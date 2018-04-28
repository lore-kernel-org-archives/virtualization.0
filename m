From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 1/4] virtio_net: Introduce
	VIRTIO_NET_F_STANDBY feature bit
Date: Sat, 28 Apr 2018 09:50:27 +0200
Message-ID: <20180428075027.GI5632__11714.2080715441$1524901734$gmane$org@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-2-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524848820-42258-2-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Fri, Apr 27, 2018 at 07:06:57PM CEST, sridhar.samudrala@intel.com wrote:
>This feature bit can be used by hypervisor to indicate virtio_net device to
>act as a standby for another device with the same MAC address.
>
>VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.
>
>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>---
> drivers/net/virtio_net.c        | 2 +-
> include/uapi/linux/virtio_net.h | 3 +++
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 3b5991734118..51a085b1a242 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
> 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
> 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
> 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>-	VIRTIO_NET_F_SPEED_DUPLEX
>+	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY


This is not part of current qemu master (head 6f0c4706b35dead265509115ddbd2a8d1af516c1)
Were I can find the qemu code?

Also, I think it makes sense to push HW (qemu HW in this case) first
and only then the driver.



> 
> static unsigned int features[] = {
> 	VIRTNET_FEATURES,
>diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>index 5de6ed37695b..a3715a3224c1 100644
>--- a/include/uapi/linux/virtio_net.h
>+++ b/include/uapi/linux/virtio_net.h
>@@ -57,6 +57,9 @@
> 					 * Steering */
> #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> 
>+#define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>+					 * with the same MAC.
>+					 */
> #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
> 
> #ifndef VIRTIO_NET_NO_LEGACY
>-- 
>2.14.3
>
