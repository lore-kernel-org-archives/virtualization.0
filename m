From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY feature bit to
	virtio_net
Date: Mon, 11 Jun 2018 20:26:04 +0300
Message-ID: <20180611202207-mutt-send-email-mst__36016.2170175046$1528737845$gmane$org@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 07, 2018 at 04:09:54PM -0700, Sridhar Samudrala wrote:
> This feature bit can be used by hypervisor to indicate virtio_net device to
> act as a standby for another device with the same MAC address.
> 
> I tested this with a small change to the patch to mark the STANDBY feature 'true'
> by default as i am using libvirt to start the VMs.
> Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
> XML file?
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

So I do not think we can commit to this interface: we
really need to control visibility of the primary device.

However just for testing purposes, we could add a non-stable
interface "x-standby" with the understanding that as any
x- prefix it's unstable and will be changed down the road,
likely in the next release.


> ---
>  hw/net/virtio-net.c                         | 2 ++
>  include/standard-headers/linux/virtio_net.h | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 90502fca7c..38b3140670 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>                       true),
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
> +                      false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index e9f255ea3f..01ec09684c 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -57,6 +57,9 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
> +                                         * with the same MAC.
> +                                         */
>  #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
>  
>  #ifndef VIRTIO_NET_NO_LEGACY
> -- 
> 2.14.3
