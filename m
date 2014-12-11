From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 15/20] virtio-net: no writeable mac for virtio-1
Date: Thu, 11 Dec 2014 14:25:17 +0100
Message-ID: <1418304322-7546-16-git-send-email-cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Devices operating as virtio 1.0 may not allow writes to the mac
address in config space.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/net/virtio-net.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d6d1b98..ebbea60 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -87,6 +87,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
     memcpy(&netcfg, config, n->config_size);
 
     if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
+        !virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
         memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
         memcpy(n->mac, netcfg.mac, ETH_ALEN);
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
-- 
1.7.9.5
