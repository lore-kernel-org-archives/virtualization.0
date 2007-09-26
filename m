From: rusty@rustcorp.com.au
Subject: [patch 36/43] lguest: Module autoprobing support for virtio drivers.
Date: Wed, 26 Sep 2007 16:36:54 +1000
Message-ID: <20070926063651.595560877@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=new-io-modpost.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This adds the logic to convert the virtio ids into module aliases, and
includes a modalias entry in sysfs and the env var to make probing work.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio.c  |   26 ++++++++++++++++++++++++++
 scripts/mod/file2alias.c |   18 ++++++++++++++++++
 2 files changed, 44 insertions(+)

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
 
@@ -51,10 +60,27 @@ static int virtio_dev_match(struct devic
 	return 0;
 }
 
+static int virtio_uevent(struct device *_dv, char **envp,
+			 int num_envp, char *buffer, int buffer_size)
+{
+	struct virtio_device *dev = container_of(_dv,struct virtio_device,dev);
+	int i = 0, err;
+	int length = 0;
+
+	err = add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+			     "MODALIAS=virtio:d%08Xv%08X",
+			     dev->id.device, dev->id.vendor);
+	if (err)
+		return err;
+	envp[i] = NULL;
+	return 0;
+}
+
 static struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
 	.dev_attrs = virtio_dev_attrs,
+	.uevent = virtio_uevent,
 };
 
 static void add_status(struct virtio_device *dev, unsigned status)
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

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
