From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/4 v2] xen kconfig: relax INPUT_XEN_KBDDEV_FRONTEND deps
Date: Wed, 11 Jan 2012 12:30:09 -0500
Message-ID: <20120111173009.GC4449@phenom.dumpdata.com>
References: <20120111161911.GB18203@andromeda.dapyr.net>
	<1326299801-7966-1-git-send-email-drjones@redhat.com>
	<1326299801-7966-2-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326299801-7966-2-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: konrad@darnok.org, jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2012 at 05:36:39PM +0100, Andrew Jones wrote:
> PV-on-HVM guests may want to use the xen keyboard/mouse frontend, but
> they don't use the xen frame buffer frontend. For this case it doesn't
> make much sense for INPUT_XEN_KBDDEV_FRONTEND to depend on
> XEN_FBDEV_FRONTEND. The opposite direction always makes more sense, i.e.

What is the disadvantege of keeping it as is?

> if you're using xenfb, then you'll want xenkbd. Switch the dependencies.
> 
You are missing the CC to the proper maintainer.

Also, did you test this with PV and PVonHVM guests?

> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  drivers/input/misc/Kconfig |    2 +-
>  drivers/video/Kconfig      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 22d875f..36c15bf 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -533,7 +533,7 @@ config INPUT_CMA3000_I2C
>  
>  config INPUT_XEN_KBDDEV_FRONTEND
>  	tristate "Xen virtual keyboard and mouse support"
> -	depends on XEN_FBDEV_FRONTEND
> +	depends on XEN
>  	default y
>  	select XEN_XENBUS_FRONTEND
>  	help
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d83e967..3e38c2f 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2263,7 +2263,7 @@ config FB_VIRTUAL
>  
>  config XEN_FBDEV_FRONTEND
>  	tristate "Xen virtual frame buffer support"
> -	depends on FB && XEN
> +	depends on FB && XEN && INPUT_XEN_KBDDEV_FRONTEND
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
>  	select FB_SYS_IMAGEBLIT
> -- 
> 1.7.7.5
