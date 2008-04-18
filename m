From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [4/6] [KVM] virtio-net: Add SG/GSO support
Date: Fri, 18 Apr 2008 11:19:39 +0800
Message-ID: <20080418031939.GC18071@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031444.GA18041@gondor.apana.org.au>
	<20080418031554.GA18071@gondor.apana.org.au>
	<20080418031722.GB18071@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080418031722.GB18071@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Here's the patch to get the KVM backend to do GSO.  Please note
that this was a quick hack and I haven't even tested the case
where the tun device doesn't support GSO so it'll probably break
there.

It does the stupidest thing possible for guest => host by copying
the data so that it can use write(2).

diff --git a/qemu/hw/virtio-net.c b/qemu/hw/virtio-net.c
index 86f9e5a..b92e7c5 100644
--- a/qemu/hw/virtio-net.c
+++ b/qemu/hw/virtio-net.c
@@ -22,9 +22,9 @@
 #define VIRTIO_ID_NET	1
 
 /* The feature bitmap for virtio net */
-#define VIRTIO_NET_F_NO_CSUM	0
+#define VIRTIO_NET_F_CSUM	0
 #define VIRTIO_NET_F_MAC	5
-#define VIRTIO_NET_F_GS0	6
+#define VIRTIO_NET_F_GSO	6
 
 #define TX_TIMER_INTERVAL (1000 / 500)
 
@@ -87,7 +87,10 @@ static void virtio_net_update_config(VirtIODevice *vdev, uint8_t *config)
 
 static uint32_t virtio_net_get_features(VirtIODevice *vdev)
 {
-    return (1 << VIRTIO_NET_F_MAC);
+    int gso = tap_has_gso(to_virtio_net(vdev)->vc->vlan->first_client);
+
+    return (1 << VIRTIO_NET_F_MAC) |
+	   (gso ? (1 << VIRTIO_NET_F_CSUM) | (1 << VIRTIO_NET_F_GSO) : 0);
 }
 
 /* RX */
@@ -112,6 +115,7 @@ static void virtio_net_receive(void *opaque, const uint8_t *buf, int size)
     VirtQueueElement elem;
     struct virtio_net_hdr *hdr;
     int offset, i;
+    int total;
 
     /* FIXME: the drivers really need to set their status better */
     if (n->rx_vq->vring.avail == NULL) {
@@ -129,18 +133,26 @@ static void virtio_net_receive(void *opaque, const uint8_t *buf, int size)
     hdr->flags = 0;
     hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
 
-    /* copy in packet.  ugh */
     offset = 0;
+    total = sizeof(*hdr);
+
+    if (tap_has_gso(n->vc->vlan->first_client)) {
+	memcpy(hdr, buf, sizeof(*hdr));
+	offset += total;
+    }
+
+    /* copy in packet.  ugh */
     i = 1;
     while (offset < size && i < elem.in_num) {
 	int len = MIN(elem.in_sg[i].iov_len, size - offset);
 	memcpy(elem.in_sg[i].iov_base, buf + offset, len);
 	offset += len;
+	total += len;
 	i++;
     }
 
     /* signal other side */
-    virtqueue_push(n->rx_vq, &elem, sizeof(*hdr) + offset);
+    virtqueue_push(n->rx_vq, &elem, total);
     virtio_notify(&n->vdev, n->rx_vq);
 }
 
@@ -201,7 +213,10 @@ void virtio_net_poll(void)
             hdr->flags = 0;
             hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
 again:
-            len = readv(vnet->tap_fd, &elem.in_sg[1], elem.in_num - 1);
+	    if (tap_has_gso(vnet->vc->vlan->first_client))
+		len = readv(vnet->tap_fd, &elem.in_sg[0], elem.in_num);
+	    else
+		len = readv(vnet->tap_fd, &elem.in_sg[1], elem.in_num - 1);
             if (len == -1) {
                 if (errno == EINTR || errno == EAGAIN)
                     goto again;
@@ -229,25 +244,32 @@ again:
 static void virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
 {
     VirtQueueElement elem;
+    uint8_t buf[sizeof(struct virtio_net_hdr) + 65536];
+    int size = sizeof(buf);
     int count = 0;
+    int nogso = !tap_has_gso(n->vc->vlan->first_client);
 
     if (!(n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
         return;
 
     while (virtqueue_pop(vq, &elem)) {
 	int i;
-	size_t len = 0;
+	int offset = 0;
 
-	/* ignore the header for now */
-	for (i = 1; i < elem.out_num; i++) {
-	    qemu_send_packet(n->vc, elem.out_sg[i].iov_base,
-			     elem.out_sg[i].iov_len);
-	    len += elem.out_sg[i].iov_len;
+	/* Ignore the header if GSO is not supported. */
+	for (i = nogso; i < elem.out_num; i++) {
+	    int len = MIN(elem.out_sg[i].iov_len, size - offset);
+	    memcpy(buf + offset, elem.out_sg[i].iov_base, len);
+	    offset += len;
 	}
 
+	qemu_send_packet(n->vc, buf, offset);
+
 	count++;
 
-	virtqueue_push(vq, &elem, sizeof(struct virtio_net_hdr) + len);
+	if (nogso)
+	    offset += elem.out_sg[0].iov_len;
+	virtqueue_push(vq, &elem, offset);
 	virtio_notify(&n->vdev, vq);
     }
 }
@@ -291,7 +313,7 @@ void *virtio_net_init(PCIBus *bus, NICInfo *nd, int devfn)
     n->vdev.update_config = virtio_net_update_config;
     n->vdev.get_features = virtio_net_get_features;
     n->rx_vq = virtio_add_queue(&n->vdev, 512, virtio_net_handle_rx);
-    n->tx_vq = virtio_add_queue(&n->vdev, 128, virtio_net_handle_tx);
+    n->tx_vq = virtio_add_queue(&n->vdev, 512, virtio_net_handle_tx);
     n->can_receive = 0;
     memcpy(n->mac, nd->macaddr, 6);
     n->vc = qemu_new_vlan_client(nd->vlan, virtio_net_receive,
diff --git a/qemu/net.h b/qemu/net.h
index c8ff6d6..c3a75d6 100644
--- a/qemu/net.h
+++ b/qemu/net.h
@@ -36,6 +36,7 @@ void do_info_network(void);
 
 /* virtio hack for zero copy receive */
 int hack_around_tap(void *opaque);
+int tap_has_gso(void *opaque);
 
 /* NIC info */
 
diff --git a/qemu/vl.c b/qemu/vl.c
index 21c9b53..3f10d0a 100644
--- a/qemu/vl.c
+++ b/qemu/vl.c
@@ -3962,6 +3962,7 @@ typedef struct TAPState {
     int fd;
     char down_script[1024];
     int no_poll;
+    int gso;
 } TAPState;
 
 static int tap_read_poll(void *opaque)
@@ -4019,6 +4020,14 @@ int hack_around_tap(void *opaque)
     return -1;
 }
 
+int tap_has_gso(void *opaque)
+{
+    VLANClientState *vc = opaque;
+    TAPState *ts = vc->opaque;
+
+    return ts ? ts->gso : 0;
+}
+
 /* fd support */
 
 static TAPState *net_tap_fd_init(VLANState *vlan, int fd)
@@ -4038,7 +4047,7 @@ static TAPState *net_tap_fd_init(VLANState *vlan, int fd)
 }
 
 #if defined (_BSD) || defined (__FreeBSD_kernel__)
-static int tap_open(char *ifname, int ifname_size)
+static int tap_open(char *ifname, int ifname_size, int *gso)
 {
     int fd;
     char *dev;
@@ -4180,7 +4189,7 @@ int tap_alloc(char *dev)
     return tap_fd;
 }
 
-static int tap_open(char *ifname, int ifname_size)
+static int tap_open(char *ifname, int ifname_size, int *gso)
 {
     char  dev[10]="";
     int fd;
@@ -4193,18 +4202,30 @@ static int tap_open(char *ifname, int ifname_size)
     return fd;
 }
 #else
-static int tap_open(char *ifname, int ifname_size)
+static int tap_open(char *ifname, int ifname_size, int *gso)
 {
     struct ifreq ifr;
     int fd, ret;
+    unsigned int features;
 
     TFR(fd = open("/dev/net/tun", O_RDWR));
     if (fd < 0) {
         fprintf(stderr, "warning: could not open /dev/net/tun: no virtual network emulation\n");
         return -1;
     }
+
+    if (ioctl(fd, TUNGETFEATURES, &features))
+	features = IFF_TUN | IFF_TAP | IFF_NO_PI | IFF_ONE_QUEUE;
+
     memset(&ifr, 0, sizeof(ifr));
     ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
+
+    if (features & IFF_VIRTIO_HDR && features & IFF_RECV_CSUM &&
+	features & IFF_RECV_GSO) {
+	*gso = 1;
+	ifr.ifr_flags |= IFF_VIRTIO_HDR | IFF_RECV_CSUM | IFF_RECV_GSO;
+    }
+
     if (ifname[0] != '\0')
         pstrcpy(ifr.ifr_name, IFNAMSIZ, ifname);
     else
@@ -4262,13 +4283,15 @@ static int net_tap_init(VLANState *vlan, const char *ifname1,
 {
     TAPState *s;
     int fd;
+    int gso;
     char ifname[128];
 
     if (ifname1 != NULL)
         pstrcpy(ifname, sizeof(ifname), ifname1);
     else
         ifname[0] = '\0';
-    TFR(fd = tap_open(ifname, sizeof(ifname)));
+    gso = 0;
+    TFR(fd = tap_open(ifname, sizeof(ifname), &gso));
     if (fd < 0)
         return -1;
 
@@ -4281,6 +4304,8 @@ static int net_tap_init(VLANState *vlan, const char *ifname1,
     s = net_tap_fd_init(vlan, fd);
     if (!s)
         return -1;
+
+    s->gso = gso;
     snprintf(s->vc->info_str, sizeof(s->vc->info_str),
              "tap: ifname=%s setup_script=%s", ifname, setup_script);
     if (down_script && strcmp(down_script, "no"))
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
