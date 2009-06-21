From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 12/12] qemu/net: flag to control the number of vectors a
	nic has
Date: Sun, 21 Jun 2009 19:51:18 +0300
Message-ID: <20090621165118.GM10164__11749.795851256$1245604475$gmane$org@redhat.com>
References: <cover.1245594586.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1245594586.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>, qemu-devel@nongnu.org, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Rusty Russell <rusty@rustcor>
List-Id: virtualization@lists.linuxfoundation.org

Add an option to specify the number of MSI-X vectors for PCI NIC cards. This
can also be used to disable MSI-X, for compatibility with old qemu. This
option currently only affects virtio cards.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio-net.c |    5 ++++-
 net.c           |   18 +++++++++++++++++-
 net.h           |    4 ++++
 qemu-options.hx |   14 ++++++++------
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index c8dabbe..4a82348 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -709,7 +709,10 @@ VirtIODevice *virtio_net_init(DeviceState *dev)
     n->mac_table.macs = qemu_mallocz(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = qemu_mallocz(MAX_VLAN >> 3);
-    n->vdev.nvectors = 3;
+    if (dev->nd->nvectors == NIC_NVECTORS_UNSPECIFIED)
+        n->vdev.nvectors = 3;
+    else
+        n->vdev.nvectors = dev->nd->nvectors;
 
     register_savevm("virtio-net", virtio_net_id++, VIRTIO_NET_VM_VERSION,
                     virtio_net_save, virtio_net_load, n);
diff --git a/net.c b/net.c
index af9de73..1a71b75 100644
--- a/net.c
+++ b/net.c
@@ -2103,7 +2103,7 @@ int net_client_init(Monitor *mon, const char *device, const char *p)
     }
     if (!strcmp(device, "nic")) {
         static const char * const nic_params[] = {
-            "vlan", "name", "macaddr", "model", NULL
+            "vlan", "name", "macaddr", "model", "vectors", NULL
         };
         NICInfo *nd;
         uint8_t *macaddr;
@@ -2138,6 +2138,22 @@ int net_client_init(Monitor *mon, const char *device, const char *p)
         if (get_param_value(buf, sizeof(buf), "model", p)) {
             nd->model = strdup(buf);
         }
+        nd->nvectors = NIC_NVECTORS_UNSPECIFIED;
+        if (get_param_value(buf, sizeof(buf), "vectors", p)) {
+            char *endptr;
+            long vectors = strtol(buf, &endptr, 0);
+            if (*endptr) {
+                config_error(mon, "invalid syntax for # of vectors\n");
+                ret = -1;
+                goto out;
+            }
+            if (vectors < 0 || vectors > 0x7ffffff) {
+                config_error(mon, "invalid # of vectors\n");
+                ret = -1;
+                goto out;
+            }
+            nd->nvectors = vectors;
+        }
         nd->vlan = vlan;
         nd->name = name;
         nd->used = 1;
diff --git a/net.h b/net.h
index 89e7706..f8b9eac 100644
--- a/net.h
+++ b/net.h
@@ -83,6 +83,9 @@ int do_set_link(Monitor *mon, const char *name, const char *up_or_down);
 /* NIC info */
 
 #define MAX_NICS 8
+enum {
+	NIC_NVECTORS_UNSPECIFIED = -1
+};
 
 struct NICInfo {
     uint8_t macaddr[6];
@@ -91,6 +94,7 @@ struct NICInfo {
     VLANState *vlan;
     void *private;
     int used;
+    int nvectors;
 };
 
 extern int nb_nics;
diff --git a/qemu-options.hx b/qemu-options.hx
index 9d5e05a..a8a1db4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -733,7 +733,7 @@ STEXI
 ETEXI
 
 DEF("net", HAS_ARG, QEMU_OPTION_net,
-    "-net nic[,vlan=n][,macaddr=addr][,model=type][,name=str]\n"
+    "-net nic[,vlan=n][,macaddr=addr][,model=type][,name=str][,vectors=v]\n"
     "                create a new Network Interface Card and connect it to VLAN 'n'\n"
 #ifdef CONFIG_SLIRP
     "-net user[,vlan=n][,name=str][,hostname=host]\n"
@@ -767,15 +767,17 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
     "-net none       use it alone to have zero network devices; if no -net option\n"
     "                is provided, the default is '-net nic -net user'\n")
 STEXI
-@item -net nic[,vlan=@var{n}][,macaddr=@var{addr}][,model=@var{type}][,name=@var{name}]
+@item -net nic[,vlan=@var{n}][,macaddr=@var{addr}][,model=@var{type}][,name=@var{name}][,vectors=@var{v}]
 Create a new Network Interface Card and connect it to VLAN @var{n} (@var{n}
 = 0 is the default). The NIC is an ne2k_pci by default on the PC
 target. Optionally, the MAC address can be changed to @var{addr}
-and a @var{name} can be assigned for use in monitor commands. If no
-@option{-net} option is specified, a single NIC is created.
-Qemu can emulate several different models of network card.
+and a @var{name} can be assigned for use in monitor commands.
+Optionally, for PCI cards, you can specify the number @var{v} of MSI-X vectors
+that the card should have; this option currently only affects virtio cards; set
+@var{v} = 0 to disable MSI-X. If no @option{-net} option is specified, a single
+NIC is created. Qemu can emulate several different models of network card.
 Valid values for @var{type} are
-@code{i82551}, @code{i82557b}, @code{i82559er},
+@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
 @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
 @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
 Not all devices are supported on all targets.  Use -net nic,model=?
-- 
1.6.2.2
