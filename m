From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] virtio module alias support
Date: Tue, 25 Sep 2007 10:50:04 +1000
Message-ID: <1190681405.27805.243.camel__16974.6000705802$1190681560$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<1190625394.27805.206.camel@localhost.localdomain>
	<20070924160221.GB5846@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070924160221.GB5846@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-09-24 at 09:02 -0700, Greg KH wrote:
> On Mon, Sep 24, 2007 at 07:16:34PM +1000, Rusty Russell wrote:
> > This adds the logic to convert the virtio ids into module aliases, and
> > includes a modalias entry in sysfs.
> > 
> > Unfortunately this does not seem sufficient to have the module
> > autoprobed at startup on my Ubuntu system.  Greg?  Am I missing some
> > udev magic?
> 
> You also need to pass the MODINFO environment variable to the hotplug
> call so that udev can pick it up.
> 
> hope this helps,

Well, I finally decoded this as follows:

        You need to implement the bus_type.uevent hook, and use
        add_uevent_var() to add a "MODALIAS=virtio:..." var.  See
        drivers/pci/hotplug.c.

Not sure why I need the modalias here when it's in sysfs.  But, it
works.

Thanks!
Rusty.

---
Module autoprobing support for virtio drivers.

This adds the logic to convert the virtio ids into module aliases, and
includes a modalias entry in sysfs and the env var to make probing work.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio.c  |    9 +++++++++
 scripts/mod/file2alias.c |   18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff -r 4b377c58d110 drivers/virtio/virtio.c
--- a/drivers/virtio/virtio.c	Mon Sep 24 18:46:28 2007 +1000
+++ b/drivers/virtio/virtio.c	Tue Sep 25 10:42:18 2007 +1000
@@ -19,11 +19,20 @@ static ssize_t status_show(struct device
 {
 	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
 	return sprintf(buf, "0x%08x", dev->config->get_status(dev));
+}
+static ssize_t modalias_show(struct device *_d,
+			     struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+
+	return sprintf(buf, "virtio:d%08Xv%08X\n",
+		       dev->id.device, dev->id.vendor);
 }
 static struct device_attribute virtio_dev_attrs[] = {
 	__ATTR_RO(device),
 	__ATTR_RO(vendor),
 	__ATTR_RO(status),
+	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
 
@@ -48,6 +57,22 @@ static int virtio_dev_match(struct devic
 	for (i = 0; ids[i].device; i++)
 		if (virtio_id_match(dev, &ids[i]))
 			return 1;
+	return 0;
+}
+
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
 	return 0;
 }
 
@@ -61,6 +86,7 @@ static struct virtio_bus virtio_bus = {
 		.name  = "virtio",
 		.match = virtio_dev_match,
 		.dev_attrs = virtio_dev_attrs,
+		.uevent = virtio_uevent,
 	},
 	.dev = {
 		/* Can override this if you have a real bus behind it. */
diff -r 4b377c58d110 scripts/mod/file2alias.c
--- a/scripts/mod/file2alias.c	Mon Sep 24 18:46:28 2007 +1000
+++ b/scripts/mod/file2alias.c	Mon Sep 24 18:46:28 2007 +1000
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
