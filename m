From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 1/4] xen kconfig: keep XEN_XENBUS_FRONTEND builtin
Date: Wed, 11 Jan 2012 12:28:32 -0500
Message-ID: <20120111172832.GB4449__31030.8466818698$1326303638$gmane$org@phenom.dumpdata.com>
References: <20120111161911.GB18203@andromeda.dapyr.net>
	<1326299801-7966-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326299801-7966-1-git-send-email-drjones@redhat.com>
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

On Wed, Jan 11, 2012 at 05:36:38PM +0100, Andrew Jones wrote:
> When XEN_XENBUS_FRONTEND gets selected as a module it can lead to
> unbootable configs. If we need it, then we should just build it in.

Hm, don't the frontends by themsevles load this module? So if you
do 'modprobe xen-pcifront' it would load this automatically?

> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  drivers/xen/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 8795480..1d24061 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -118,7 +118,7 @@ config XEN_SYS_HYPERVISOR
>  	 but will have no xen contents.
>  
>  config XEN_XENBUS_FRONTEND
> -	tristate
> +	bool
>  
>  config XEN_GNTDEV
>  	tristate "userspace grant access device driver"
> -- 
> 1.7.7.5
