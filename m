From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [TRIVIAL PATCH next 12/15] video: Convert vmalloc/memset to
	vzalloc
Date: Mon, 30 May 2011 12:40:25 +0100
Message-ID: <20110530114025.GP5044__28803.2387187288$1306755783$gmane$org@csn.ul.ie>
References: <cover.1306603968.git.joe@perches.com>
	<77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Jiri Kosina <trivial@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mundt <lethal@linux-sh.org>, xen-devel@lists.xensource.com, Jaya Kumar <jayalk@intworks.biz>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 28, 2011 at 10:36:32AM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/video/arcfb.c        |    5 ++---
>  drivers/video/broadsheetfb.c |    4 +---
>  drivers/video/hecubafb.c     |    5 ++---
>  drivers/video/metronomefb.c  |    4 +---
>  drivers/video/xen-fbfront.c  |    3 +--
>  5 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
> index 3ec4923..86573e2 100644
> --- a/drivers/video/arcfb.c
> +++ b/drivers/video/arcfb.c
> @@ -515,11 +515,10 @@ static int __devinit arcfb_probe(struct platform_device *dev)
>  
>  	/* We need a flat backing store for the Arc's
>  	   less-flat actual paged framebuffer */
> -	if (!(videomemory = vmalloc(videomemorysize)))
> +	videomemory = vmalloc(videomemorysize);
> +	if (!videomemory)
>  		return retval;
>  
> -	memset(videomemory, 0, videomemorysize);
> -
>  	info = framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
>  	if (!info)
>  		goto err;

This is the first commit I saw and stopped reading at this point
because this hunk is not using vzalloc. I imagine grep for ^+ and
vmalloc throughout the series would be helpful?

-- 
Mel Gorman
SUSE Labs
