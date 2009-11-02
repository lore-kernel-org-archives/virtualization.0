From: Or Gerlitz <ogerlitz@voltaire.com>
Subject: [PATCHv4 3/6] qemu/net: add raw backend
Date: Tue, 3 Nov 2009 00:23:50 +0200
Message-ID: <20091102222350.GD15153__9796.67670694671$1257200932$gmane$org@redhat.com>
References: <cover.1257200517.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1257200517.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add raw network backend option which uses a packet socket to provide
raw networking access. Once the socket is opened it's bound to a
provided host interface, such that packets received on the interface
are delivered to the VM and packets sent by the VM are sent to the
interface.

This is functionally similar to the existing pcap network
backend, with the same advantages and problems.
Differences from pcap:
- can get an open socket from the monitor,
  which allows running without NET_ADMIN priviledges
- support iovec sends with writev, saving one data copy
- one less dependency on an external library
- we have access to the underlying file descriptor
  which makes it possible to connect to vhost net
- don't support polling all interfaces, always bind to a specific one

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio-net.c |    3 +-
 net.c           |  192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx |    4 +
 3 files changed, 198 insertions(+), 1 deletions(-)

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 469c6e3..2e51a6a 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -531,7 +531,8 @@ static ssize_t virtio_net_receive2(VLANClientState *vc, const uint8_t *buf, size
             virtqueue_pop(n->rx_vq, &elem) == 0) {
             if (i == 0)
                 return -1;
-            fprintf(stderr, "virtio-net truncating packet\n");
+            fprintf(stderr, "virtio-net truncating packet. offset %zd size %zd\n",
+		    offset, size);
             exit(1);
         }
 
diff --git a/net.c b/net.c
index 8ac639b..1fb2f2f 100644
--- a/net.c
+++ b/net.c
@@ -93,6 +93,9 @@
 #endif
 #endif
 
+#include <netpacket/packet.h>
+#include <net/ethernet.h>
+
 #if defined(__OpenBSD__)
 #include <util.h>
 #endif
@@ -1870,6 +1873,158 @@ static TAPState *net_tap_init(VLANState *vlan, const char *model,
 
 #endif /* !_WIN32 */
 
+typedef struct RAWState {
+    VLANClientState *vc;
+    int fd;
+    uint8_t buf[4096];
+    int promisc;
+} RAWState;
+
+static int net_raw_fd_init(Monitor *mon, const char *ifname, int promisc)
+{
+	int fd, ret;
+	struct ifreq req;
+	struct sockaddr_ll lladdr;
+
+	fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (fd < 0)
+		fprintf(stderr, "packet socket failed\n");
+
+	memset(&req, 0, sizeof(req));
+	strncpy(req.ifr_name, ifname, IFNAMSIZ-1);
+	ret = ioctl(fd, SIOCGIFINDEX, &req);
+	if (ret < 0)
+		fprintf(stderr, "SIOCGIFINDEX failed\n");
+
+	memset(&lladdr, 0, sizeof(lladdr));
+	lladdr.sll_family   = AF_PACKET;
+	lladdr.sll_protocol = htons(ETH_P_ALL);
+	lladdr.sll_ifindex  = req.ifr_ifindex;
+	ret = bind(fd, (const struct sockaddr *)&lladdr, sizeof(lladdr));
+	if (ret < 0)
+		fprintf(stderr, "bind failed\n");
+
+	/* set iface to promiscuous mode (packets sent to the VM MAC) */
+	if (promisc) {
+		ret = ioctl(fd, SIOCGIFFLAGS, &req);
+		if (ret < 0)
+			perror("SIOCGIFFLAGS failed\n");
+		req.ifr_flags |= IFF_PROMISC;
+		ret = ioctl(fd, SIOCSIFFLAGS, &req);
+		if (ret < 0)
+			fprintf(stderr, "SIOCSIFFLAGS to promiscous failed\n");
+	}
+
+	ret = fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK);
+	if (ret < 0)
+		fprintf(stderr, "O_NONBLOCK set failed\n");
+
+	return fd;
+}
+
+static void raw_cleanup(VLANClientState *vc)
+{
+	struct ifreq req;
+	RAWState *s = vc->opaque;
+
+	qemu_set_fd_handler2(s->fd, NULL, NULL, NULL, NULL);
+	if (s->promisc) {
+		ioctl(s->fd, SIOCGIFFLAGS, &req);
+		req.ifr_flags &= ~IFF_PROMISC;
+		ioctl(s->fd, SIOCSIFFLAGS, &req);
+	}
+	close(s->fd);
+	qemu_free(s);
+}
+
+static void raw_send(void *opaque);
+
+static int raw_can_send(void *opaque)
+{
+	RAWState *s = opaque;
+
+	return qemu_can_send_packet(s->vc);
+}
+
+static void raw_send_completed(VLANClientState *vc, ssize_t len)
+{
+	RAWState *s = vc->opaque;
+
+	qemu_set_fd_handler2(s->fd, raw_can_send, raw_send, NULL, s);
+}
+
+static void raw_send(void *opaque)
+{
+	RAWState *s = opaque;
+	int size;
+
+	do {
+		size = recv(s->fd, s->buf, sizeof(s->buf), MSG_TRUNC);
+		if (size <= 0)
+			break;
+
+		size = qemu_send_packet_async(s->vc, s->buf, size,
+						raw_send_completed);
+		if (size == 0)
+			qemu_set_fd_handler2(s->fd, NULL, NULL, NULL, NULL);
+
+	} while (size > 0);
+}
+
+static ssize_t raw_receive_iov(VLANClientState *vc, const struct iovec *iov,
+				int iovcnt)
+{
+	ssize_t len;
+	RAWState *s = vc->opaque;
+
+	do {
+		len = writev(s->fd, iov, iovcnt);
+	} while (len == -1 && (errno == EINTR || errno == EAGAIN));
+
+	return len;
+}
+
+static ssize_t raw_receive(VLANClientState *vc, const uint8_t *buf, size_t size)
+{
+	struct iovec iov[1];
+
+	iov[0].iov_base = (char *)buf;
+	iov[0].iov_len  = size;
+
+	return raw_receive_iov(vc, iov, 1);
+}
+
+static int net_raw_init(Monitor *mon, VLANState *vlan, const char *model,
+			const char *name, const char *ifname,
+			int promisc, int fd)
+{
+	RAWState *s;
+
+	s = qemu_mallocz(sizeof(RAWState));
+
+	if (fd == -1) {
+		s->fd = net_raw_fd_init(mon, ifname, promisc);
+		s->promisc = promisc;
+	} else
+		s->fd = fd;
+
+	fcntl(s->fd, F_SETFL, O_NONBLOCK);
+
+	s->vc = qemu_new_vlan_client(vlan, model, name, NULL, raw_receive,
+					raw_receive_iov, raw_cleanup, s);
+	qemu_set_fd_handler2(s->fd, raw_can_send, raw_send, NULL, s);
+
+	if (fd == -1)
+		snprintf(s->vc->info_str, sizeof(s->vc->info_str),
+			"raw: ifname=%s, promisc=%d", ifname, promisc);
+	else
+		snprintf(s->vc->info_str, sizeof(s->vc->info_str),
+			"raw: fd=%d", fd);
+
+	vlan->nb_host_devs++;
+	return 0;
+}
+
 #if defined(CONFIG_VDE)
 typedef struct VDEState {
     VLANClientState *vc;
@@ -2632,6 +2787,23 @@ static int net_init_nic(QemuOpts *opts, Monitor *mon)
     return idx;
 }
 
+static int net_init_raw(QemuOpts *opts, Monitor *mon)
+{
+    VLANState *vlan;
+    int fd = -1;
+    vlan = qemu_find_vlan(qemu_opt_get_number(opts, "vlan", 0), 1);
+    if (qemu_opt_get(opts, "fd")) {
+        fd = net_handle_fd_param(mon, qemu_opt_get(opts, "fd"));
+        if (fd < 0)
+            return -EINVAL;
+    }
+    return net_raw_init(mon, vlan, "raw",
+                        qemu_opt_get(opts, "name"),
+			qemu_opt_get(opts, "ifname"),
+			qemu_opt_get_bool(opts, "promisc", 0),
+			fd);
+}
+
 static int net_init_slirp_configs(const char *name, const char *value, void *opaque)
 {
     struct slirp_config_str *config;
@@ -3136,6 +3308,26 @@ static struct {
             },
             { /* end of list */ }
         },
+    }, {
+        .type = "raw",
+        .init = net_init_raw,
+        .desc = {
+            NET_COMMON_PARAMS_DESC,
+            {
+                .name = "fd",
+                .type = QEMU_OPT_STRING,
+                .help = "file descriptor of an already opened raw socket",
+            }, {
+                .name = "ifname",
+                .type = QEMU_OPT_STRING,
+                .help = "interface name",
+            }, {
+                .name = "promisc",
+                .type = QEMU_OPT_BOOL,
+                .help = "enable promiscious mode at startup",
+            },
+            { /* end of list */ }
+        },
 #ifdef CONFIG_VDE
     }, {
         .type = "vde",
diff --git a/qemu-options.hx b/qemu-options.hx
index bde3e3f..0d5440f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -825,6 +825,10 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "                default of 'sndbuf=1048576' can be disabled using 'sndbuf=0'\n"
 #endif
 #endif
+    "-net raw[,vlan=n][,name=str],ifname=name[,promisc=m]\n"
+    "                bound the host network interface to VLAN 'n' in a raw manner:\n"
+    "                packets received on the interface are delivered to the vlan and\n"
+    "                packets delivered on the vlan are sent to the interface\n"
     "-net socket[,vlan=n][,name=str][,fd=h][,listen=[host]:port][,connect=host:port]\n"
     "                connect the vlan 'n' to another VLAN using a socket connection\n"
     "-net socket[,vlan=n][,name=str][,fd=h][,mcast=maddr:port]\n"
-- 
1.6.5.2.143.g8cc62
