From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] virtio module alias support
Date: Mon, 24 Sep 2007 19:16:34 +1000
Message-ID: <1190625394.27805.206.camel__2758.04466004974$1190626160$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190625307.27805.203.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Greg KH <greg@kroah.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This adds the logic to convert the virtio ids into module aliases, and
includes a modalias entry in sysfs.

Unfortunately this does not seem sufficient to have the module
autoprobed at startup on my Ubuntu system.  Greg?  Am I missing some
udev magic?

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio.c  |    9 +++++++++
 scripts/mod/file2alias.c |   18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

===================================================================
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -20,10 +20,19 @@ static ssize_t status_show(struct device
 	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
 	return sprintf(buf, "0x%08x", dev->config->get_status(dev));
 }
+static ssize_t modalias_show(struct device *_d,
+			     struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+
+	return sprintf(buf, "virtio:d%08Xv%08X\n",
+		       dev->id.device, dev->id.vendor);
+}
 static struct device_attribute virtio_dev_attrs[] = {
 	__ATTR_RO(device),
 	__ATTR_RO(vendor),
 	__ATTR_RO(status),
+	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
 
===================================================================
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -484,6 +484,20 @@ static int do_parisc_entry(const char *f
 	return 1;
 }
 
+/* Looks like: virtio:dNvN */
+static int do_virtio_entry(const char *filename, struct virtio_device_id *id,
+			   char *alias)
+{
+	id->device = TO_NATIVE(id->device);
+	id->vendor = TO_NATIVE(id->vendor);
+
+	strcpy(alias, "virtio:");
+	ADD(alias, "d", 1, id->device);
+	ADD(alias, "v", id->vendor != VIRTIO_DEV_ANY_ID, id->vendor);
+
+	return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -599,6 +613,10 @@ void handle_moddevtable(struct module *m
 		do_table(symval, sym->st_size,
 			 sizeof(struct parisc_device_id), "parisc",
 			 do_parisc_entry, mod);
+	else if (sym_is(symname, "__mod_virtio_device_table"))
+		do_table(symval, sym->st_size,
+			 sizeof(struct virtio_device_id), "virtio",
+			 do_virtio_entry, mod);
 }
 
 /* Now add out buffered information to the generated C source */
