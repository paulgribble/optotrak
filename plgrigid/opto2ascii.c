/* opto2ascii			Paul L. Gribble		OSOSA Software    */
/*									  */
/* converts optotrak floating point files to ascii files		  */

#include <stdio.h>
#include <stddef.h>

typedef struct
	{
	    char 	filetype;
	    short 	items, subitems;
	    long	numframes;
	    float	frequency;
	    char	junk[243];
	} HEADER;

void main(argc,argv)
int	argc;
char	*argv[];
{
	FILE	*fin, *fout;
	HEADER	*head;
	float	data;
	int	i,j,k,ok;
	char	c,c1,c2,c3,c4, s[4];
	float	freq;
	int	items,subitems,frames;

	if (argc < 2)
		printf("cread infile outfile\n");
	else
	{
		fin = fopen(*++argv,"r");
		if (fin==NULL) { printf("Error opening file!\n"); exit(0);}

		fscanf(fin,"%c",&c);
		if (c==32)
			printf("converting a floating point file to ascii\n");
		else
		{
			printf("input file is not a floating point file - aborting\n");
			exit(0);
		}
		printf("filetype is %d\n",c);
		fscanf(fin,"%c",&c1);
		fscanf(fin,"%c",&c2);
		items = (unsigned char)c1 + ((unsigned char)c2)*256;
		fscanf(fin,"%c",&c3);
		fscanf(fin,"%c",&c4);
		subitems = (unsigned char)c3 + ((unsigned char)c4)*256;
		printf("there are %d items and %d subitems\n",items,subitems);
		c1=getc(fin);
		c2=getc(fin);
		c3=getc(fin);
		c4=getc(fin);
		frames = (unsigned char)c1 + ((unsigned char)c2 + ((unsigned char)c3 + (unsigned char)c4*256)*256)*256;
		printf("there are %d frames\n",frames);
		s[3]=getc(fin);
		s[2]=getc(fin);
		s[1]=getc(fin);
		s[0]=getc(fin);
		printf("collection frequency was %6.2f Hz\n",*(float *)s);

		fseek(fin,256,0);
		printf("converting frame ");

		fout = fopen(*++argv,"w");

		for (i=1;i<=frames;i++)
		{
			for (j=1;j<=items;j++)
			{
				for (k=1;k<=subitems;k++)
				{
					s[3]=getc(fin);
					s[2]=getc(fin);
					s[1]=getc(fin);
					s[0]=getc(fin);
					fprintf(fout,"%e ",*(float *)s);
				}
			}
			fprintf(fout,"\n");
		}
		printf("Done.\n");
		fclose(fin);
		fclose(fout);
	}
}
