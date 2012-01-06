From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [Xen-devel] [PATCH 2/4] xen kconfig: relax
	INPUT_XEN_KBDDEV_FRONTEND deps
Date: Fri, 6 Jan 2012 11:46:40 -0400
Message-ID: <20120106154640.GC21220@andromeda.dapyr.net>
References: <1325842991-4404-1-git-send-email-drjones@redhat.com>
	<1325842991-4404-3-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325842991-4404-3-git-send-email-drjones@redhat.com>
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
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 06, 2012 at 10:43:09AM +0100, Andrew Jones wrote:
> PV-on-HVM guests may want to use the xen keyboard/mouse frontend, but
> they don't use the xen frame buffer frontend. For this case it doesn't
> make much sense for INPUT_XEN_KBDDEV_FRONTEND to depend on
> XEN_FBDEV_FRONTEND. The opposite direction always makes more sense, i.e.
> if you're using xenfb, then you'll want xenkbd. Switch the dependencies.

You need to CC as well these people that have 'maintainer' field on them:

konrad@phenom:~/work/linux$ scripts/get_maintainer.pl -f
drivers/video/Kconfig
Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
(maintainer:FRAMEBUFFER LAYER)
linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
linux-kernel@vger.kernel.org (open list)
konrad@phenom:~/work/linux$ scripts/get_maintainer.pl -f
drivers/input/misc/Kconfig
Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT
(KEYBOARD,...,commit_signer:9/16=56%)
Samuel Ortiz <sameo@linux.intel.com> (commit_signer:3/16=19%)
Anirudh Ghayal <aghayal@codeaurora.org> (commit_signer:2/16=12%)
Peter Ujfalusi <peter.ujfalusi@ti.com> (commit_signer:2/16=12%)
Alan Cox <alan@linux.intel.com> (commit_signer:2/16=12%)
linux-input@vger.kernel.org (open list:INPUT (KEYBOARD,...)
linux-kernel@vger.kernel.org (open list)

> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  drivers/input/misc/Kconfig |    2 +-
>  drivers/video/Kconfig      |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
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
> index d83e967..269b299 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2269,6 +2269,7 @@ config XEN_FBDEV_FRONTEND
>  	select FB_SYS_IMAGEBLIT
>  	select FB_SYS_FOPS
>  	select FB_DEFERRED_IO
> +	select INPUT_XEN_KBDDEV_FRONTEND
>  	select XEN_XENBUS_FRONTEND
>  	default y
>  	help
> -- 
> 1.7.7.5
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
