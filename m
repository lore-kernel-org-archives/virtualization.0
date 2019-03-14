From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] vhost: select TAP if VHOST is configured
Date: Thu, 14 Mar 2019 06:38:52 -0400
Message-ID: <20190314063549-mutt-send-email-mst@kernel.org>
References: <20190313174932.5793-1-stephen@networkplumber.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190313174932.5793-1-stephen@networkplumber.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: virtualization@lists.linux-foundation.org, sainath.grandhi@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 13, 2019 at 10:49:32AM -0700, Stephen Hemminger wrote:
> If VHOST_NET is configured but TUN and TAP are not, then the
> kernel will build but vhost will not work correctly since it can't
> setup the necessary tap device.
> 
> A solution is to select it.
> 
> Fixes: 9a393b5d5988 ("tap: tap as an independent module")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Well vhost can also work with a SOCK_RAW socket.
QEMU userspace does not seem to use that interface
pobably because we never got around to adding
offload support, but it's there and we don't know
that no one else does.


> ---
>  drivers/vhost/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index b580885243f7..a24c69598241 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -1,7 +1,8 @@
>  config VHOST_NET
>  	tristate "Host kernel accelerator for virtio net"
> -	depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> +	depends on NET && EVENTFD
>  	select VHOST
> +	select TAP
>  	---help---
>  	  This kernel module can be loaded in host kernel to accelerate
>  	  guest networking with virtio_net. Not to be confused with virtio_net
> -- 
> 2.17.1
