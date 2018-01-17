From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Wed, 17 Jan 2018 10:15:52 -0800
Message-ID: <CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg__48408.6254764863$1516212879$gmane$org@mail.gmail.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 11, 2018 at 9:58 PM, Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:
> This feature bit can be used by hypervisor to indicate virtio_net device to
> act as a backup for another device with the same MAC address.
>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/virtio_net.c        | 2 +-
>  include/uapi/linux/virtio_net.h | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 12dfc5fee58e..f149a160a8c5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2829,7 +2829,7 @@ static struct virtio_device_id id_table[] = {
>         VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>         VIRTIO_NET_F_CTRL_MAC_ADDR, \
>         VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> -       VIRTIO_NET_F_SPEED_DUPLEX
> +       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_BACKUP
>
>  static unsigned int features[] = {
>         VIRTNET_FEATURES,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 5de6ed37695b..c7c35fd1a5ed 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,9 @@
>                                          * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
>
> +#define VIRTIO_NET_F_BACKUP      62    /* Act as backup for another device
> +                                        * with the same MAC.
> +                                        */
>  #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duplex */
>
>  #ifndef VIRTIO_NET_NO_LEGACY

I'm not a huge fan of the name "backup" since that implies that the
Virtio interface is only used if the VF is not present, and there are
multiple instances such as dealing with east/west or
broadcast/multicast traffic where it may be desirable to use the
para-virtual interface rather then deal with PCI overhead/bottleneck
to send the packet.

What if instead of BACKUP we used the name SIDE_CHANNEL? Basically it
is a bit of double entendre as we are using the physical MAC address
to provide configuration information, and then in addition this
interface acts as a secondary channel for passing frames to and from
the guest rather than just using the VF.

Just a thought.

Thanks.

- Alex
