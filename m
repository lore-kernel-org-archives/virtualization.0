From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [TRIVIAL PATCH V2 next 12/15] video: Convert vmalloc/memset to
	vzalloc
Date: Tue, 31 May 2011 10:28:33 -0400
Message-ID: <20110531142833.GJ14641@dumpdata.com>
References: <cover.1306603968.git.joe@perches.com>
	<77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
	<201105281948.12941.heiko@sntech.de>
	<1306606413.20336.9.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1306606413.20336.9.camel@Joe-Laptop>
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
Cc: linux-fbdev@vger.kernel.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Jiri Kosina <trivial@kernel.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mundt <lethal@linux-sh.org>, xen-devel@lists.xensource.com, Jaya Kumar <jayalk@intworks.biz>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 28, 2011 at 11:13:33AM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> on the:

> diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
> index a20218c..beac52f 100644
> --- a/drivers/video/xen-fbfront.c
> +++ b/drivers/video/xen-fbfront.c
> @@ -395,10 +395,9 @@ static int __devinit xenfb_probe(struct xenbus_device *dev,
>  	spin_lock_init(&info->dirty_lock);
>  	spin_lock_init(&info->resize_lock);
>  
> -	info->fb = vmalloc(fb_size);
> +	info->fb = vzalloc(fb_size);
>  	if (info->fb == NULL)
>  		goto error_nomem;
> -	memset(info->fb, 0, fb_size);
>  
>  	info->nr_pages = (fb_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
