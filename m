From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [TRIVIAL PATCH next 12/15] video: Convert vmalloc/memset to
	vzalloc
Date: Sat, 28 May 2011 19:48:12 +0200
Message-ID: <201105281948.12941.heiko__16357.8512882397$1306868724$gmane$org@sntech.de>
References: <cover.1306603968.git.joe@perches.com>
	<77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

Am Samstag 28 Mai 2011, 19:36:32 schrieb Joe Perches:
> diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
> index 3ec4923..86573e2 100644
> --- a/drivers/video/arcfb.c
> +++ b/drivers/video/arcfb.c
> @@ -515,11 +515,10 @@ static int __devinit arcfb_probe(struct
> platform_device *dev)
> 
>  	/* We need a flat backing store for the Arc's
>  	   less-flat actual paged framebuffer */
> -	if (!(videomemory = vmalloc(videomemorysize)))
> +	videomemory = vmalloc(videomemorysize);
> +	if (!videomemory)
>  		return retval;
shouldn't this be vzalloc too?

> -	memset(videomemory, 0, videomemorysize);
> -
>  	info = framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
>  	if (!info)
>  		goto err;


Heiko
