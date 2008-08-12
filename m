From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: SR-IOV: patches are available for Linux kernel [3/4]
Date: Tue, 12 Aug 2008 16:44:54 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110164BC91__48306.0082806789$1218531186$gmane$org@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

[PATCH 3/4] PCI: support SR-IOV capability

Support SR-IOV capability. By default, this feature is not enabled and the Physical Function behaves as normal PCIe device. After it's enabled, each Virtual Function's PCI configuration space can be accessed using its own Bus, Device and Function Number (Routing ID). Each Virtual Function also has PCI Memory Space, which is used to map its own register set.

Signed-off-by: Yu Zhao <yu.zhao@intel.com>
Signed-off-by:  Eddie Dong <eddie.dong@intel.com>

---
 drivers/pci/Kconfig      |    9 +
 drivers/pci/Makefile     |    2 
 drivers/pci/iov.c        |  608 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h        |   13 +
 include/linux/pci.h      |   35 +++
 include/linux/pci_regs.h |   20 ++
 6 files changed, 687 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index f43cc46..5000c3c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -57,3 +57,12 @@ config PCI_ARI
 	default n
 	help
 	  This enables PCI Alternative Routing-ID Interpretation.
+
+config PCI_IOV
+	bool "PCI SR-IOV support"
+	depends on PCI
+	select PCI_MSI
+	select PCI_ARI
+	default n
+	help
+	  This allows device drivers to enable Single Root I/O Virtualization.
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 96f2767..2dcefce 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -55,3 +55,5 @@ EXTRA_CFLAGS += -DDEBUG
 endif
 
 obj-$(CONFIG_PCI_ARI) += ari.o
+
+obj-$(CONFIG_PCI_IOV) += iov.o
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
new file mode 100644
index 0000000..0bd006f
--- /dev/null
+++ b/drivers/pci/iov.c
@@ -0,0 +1,608 @@
+/*
+ * drivers/pci/iov.c
+ *
+ * Copyright (C) 2008 Intel Corporation, Yu Zhao <yu.zhao@intel.com>
+ *
+ * PCI Express Single Root I/O Virtualization capability support.
+ */
+
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <asm/page.h>
+
+#include "pci.h"
+
+#define VF_PARAM_LEN		128
+
+#define notify_phyfn(pf, event, arg) ({ \
+	pf->iov->notify ? pf->iov->notify(pf, event, arg) : 0; \
+})
+
+static int iov_set_nr_virtfn(struct pci_dev *, int);
+
+
+static inline void vfid_to_bdf(struct pci_dev *pf, int vfid, u8 *bus, u8 *devfn)
+{
+	u16 bdf;
+
+	bdf = (pf->bus->number << 8) + pf->devfn +
+	      pf->iov->offset + pf->iov->stride * vfid;
+	*bus = bdf >> 8;
+	*devfn = bdf & 0xff;
+}
+
+static inline int bdf_to_vfid(struct pci_dev *pf, u8 bus, u8 devfn)
+{
+	u16 bdf;
+	int vfid;
+
+	bdf = ((bus - pf->bus->number) << 8) + devfn -
+	      pf->devfn - pf->iov->offset;
+	vfid = bdf / pf->iov->stride;
+
+	if (bdf % pf->iov->stride || vfid >= pf->iov->nr_virtfn)
+		return -EINVAL;
+
+	return vfid;
+}
+
+static struct pci_dev *iov_alloc_virtfn(struct pci_dev *pf, int vfid)
+{
+	int i;
+	u8 bus, devfn;
+	unsigned long size;
+	struct pci_dev *vf;
+	struct pci_bus *pb;
+	struct resource *res;
+
+	vf = alloc_pci_dev();
+	if (!vf)
+		return NULL;
+
+	vfid_to_bdf(pf, vfid, &bus, &devfn);
+
+	/*
+	 * PF uses internal switch to route Type 1 configuration
+	 * transaction to VF when VF resides on a different bus.
+	 * So there is no explicit bridge device in this case.
+	 */
+	pb = pci_find_bus(0, bus);
+	if (!pb) {
+		pb = pci_create_bus(pf->dev.parent, bus,
+				    pf->bus->ops, pf->bus->sysdata);
+		if (!pb)
+			goto failed;
+	}
+
+	vf->bus = pb;
+	vf->sysdata = pb->sysdata;
+	vf->dev.parent = pf->dev.parent;
+	vf->dev.bus = pf->dev.bus;
+	vf->devfn = devfn;
+	vf->hdr_type = PCI_HEADER_TYPE_NORMAL;
+	vf->multifunction = 0;
+	vf->vendor = pf->vendor;
+	vf->device = pf->iov->device;
+	vf->cfg_size = 4096;
+	vf->error_state = pci_channel_io_normal;
+	vf->pcie_type = PCI_EXP_TYPE_ENDPOINT;
+	vf->dma_mask = 0xffffffff;
+
+	dev_set_name(&vf->dev, "%04x:%02x:%02x.%d", pci_domain_nr(pb), bus,
+		     PCI_SLOT(devfn), PCI_FUNC(devfn));
+
+	pci_read_config_byte(vf, PCI_REVISION_ID, &vf->revision);
+	vf->class = pf->class;
+	vf->current_state = PCI_UNKNOWN;
+	vf->irq = 0;
+
+	for (i = 0; i < PCI_IOV_NUM_BAR; i++) {
+		res = pf->iov->resource + i;
+		if (!res->parent)
+			continue;
+		size = resource_size(res) / pf->iov->nr_virtfn;
+		vf->resource[i].name = pci_name(vf);
+		vf->resource[i].parent = res->parent;
+		vf->resource[i].flags = res->flags;
+		vf->resource[i].start = res->start + size * vfid;
+		vf->resource[i].end = vf->resource[i].start + size - 1;
+	}
+
+	vf->subsystem_vendor = pf->subsystem_vendor;
+	pci_read_config_word(vf, PCI_SUBSYSTEM_ID, &vf->subsystem_device);
+
+	pci_device_add(vf, pb);
+	pci_bus_add_devices(pb);
+
+	return vf;
+
+failed:
+	kfree(vf);
+	return NULL;
+}
+
+static int iov_add_virtfn(struct pci_dev *pf, int vfid, char *param)
+{
+	int err;
+	struct pci_dev *vf;
+	u8 bus, devfn;
+
+	vfid_to_bdf(pf, vfid, &bus, &devfn);
+
+	vf = pci_get_bus_and_slot(bus, devfn);
+	if (vf) {
+		strcpy(pf->iov->args[vfid], param);
+		return notify_phyfn(pf, PCI_IOV_VF_PAR, vfid);
+	}
+
+	pf->iov->args[vfid] = kmalloc(VF_PARAM_LEN, GFP_KERNEL);
+	if (!pf->iov->args[vfid])
+		return -ENOMEM;
+
+	strcpy(pf->iov->args[vfid], param);
+	err = notify_phyfn(pf, PCI_IOV_VF_ENA, vfid);
+	if (err)
+		goto failed1;
+
+	vf = iov_alloc_virtfn(pf, vfid);
+	if (!vf) {
+		err = -ENOMEM;
+		goto failed2;
+	}
+
+	return 0;
+
+failed2:
+	notify_phyfn(pf, PCI_IOV_VF_DIS, vfid);
+failed1:
+	kfree(pf->iov->args[vfid]);
+	pf->iov->args[vfid] = NULL;
+
+	return err;
+}
+
+static int iov_remove_virtfn(struct pci_dev *pf, int vfid)
+{
+	u8 bus, devfn;
+	struct pci_dev *vf;
+
+	vfid_to_bdf(pf, vfid, &bus, &devfn);
+
+	vf = pci_get_bus_and_slot(bus, devfn);
+	if (vf) {
+		memset(vf->resource, 0, sizeof(vf->resource));
+		pci_remove_bus_device(vf);
+
+		if (!vf->bus->self && list_empty(&vf->bus->devices)) {
+			device_unregister(vf->bus->bridge);
+			pci_remove_bus(vf->bus);
+		}
+
+		notify_phyfn(pf, PCI_IOV_VF_DIS, vfid);
+		kfree(pf->iov->args[vfid]);
+		pf->iov->args[vfid] = NULL;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int get_line(const char *str, int len, char *buf)
+{
+	int i, j;
+
+	for (i = 0, j = 0; i < len; i++) {
+		if (j == 0 && isspace(str[i]))
+			continue;
+
+		if (str[i] == '\n')
+			break;
+
+		if (j >= VF_PARAM_LEN - 1)
+			return -E2BIG;
+
+		buf[j++] = str[i];
+	}
+
+	buf[j] = '\0';
+
+	return j ? i : 0;
+}
+
+static int parse_line(char *str, u16 *bdf, u16 *nvfs, char **ptr)
+{
+	u8 b, d, f, val;
+	int err;
+	char *p;
+
+
+	err = sscanf(str, "NumVFs=%hu", nvfs);
+	if (err == 1)
+		return 1;
+
+	err = sscanf(str, "%2hhx:%2hhx.%1hhu=%1hhu", &b, &d, &f, &val);
+	if (err != 4)
+		return -EINVAL;
+
+	*bdf = (b << 8) + PCI_DEVFN(d, f);
+	if (!val)
+		return 2;
+
+	for (p = str + 9; *p != '\0'; p++)
+		if (!isspace(*p))
+			break;
+
+	*ptr = p;
+
+	return 3;
+}
+
+/*
+ * Operations on "iov" file:
+ *   1) Read - will get number of VFs and list of available VFs.
+ *   2) Write "bb:dd.f={1|0}" - enable or disable a VF.
+ *   3) Write "NumVFs=N" - change number of available VFs.
+ */
+static ssize_t iov_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u16 bdf, nvfs;
+	int vfid;
+	int n, pos, err = 0;
+	char *str, *param;
+	struct pci_dev *pf = to_pci_dev(dev);
+
+	str = kmalloc(VF_PARAM_LEN, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+
+	for (n = 0; (pos = get_line(buf + n, count - n, str)) > 0; n += pos) {
+		err = parse_line(str, &bdf, &nvfs, &param);
+		switch (err) {
+		case 1:
+			err = iov_set_nr_virtfn(pf, nvfs);
+			break;
+		case 2:
+			vfid = bdf_to_vfid(pf, bdf >> 8, bdf & 0xff);
+			err = vfid < 0 ? -EINVAL :
+			      iov_remove_virtfn(pf, vfid);
+			break;
+		case 3:
+			vfid = bdf_to_vfid(pf, bdf >> 8, bdf & 0xff);
+			err = vfid < 0 ? -EINVAL :
+			      iov_add_virtfn(pf, vfid, param);
+			break;
+		}
+
+		if (err)
+			break;
+	}
+
+	kfree(str);
+
+	return err ? err : count;
+}
+
+static ssize_t iov_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	int i, pos;
+	u8 bus, devfn;
+	struct pci_dev *pf = to_pci_dev(dev);
+
+	pos = sprintf(buf, "NumVFs=%d\n", pf->iov->nr_virtfn);
+
+	for (i = 0; i < pf->iov->nr_virtfn; i++) {
+		vfid_to_bdf(pf, i, &bus, &devfn);
+
+		pos += sprintf(buf + pos, "%02x:%02x.%d=%d\n",
+			       bus, PCI_SLOT(devfn), PCI_FUNC(devfn),
+			       pci_get_bus_and_slot(bus, devfn) ? 1 : 0);
+	}
+
+	return pos;
+}
+
+static DEVICE_ATTR(iov, S_IRUGO | S_IWUSR, iov_show, iov_store);
+
+static int iov_alloc_res(struct pci_dev *pf)
+{
+	int i;
+	int reg;
+	int err;
+	u64 size;
+	struct resource *res;
+
+	for (i = 0; i < PCI_IOV_NUM_BAR; i++) {
+		res = pf->iov->resource + i;
+		reg = pf->iov->cap + PCI_IOV_BAR_0 + i * 4;
+		i += pci_read_base(pf, pci_bar_unknown, res, reg);
+		if (!res->flags)
+			continue;
+
+		size = resource_size(res) * pf->iov->nr_virtfn;
+		res->end = res->start + size - 1;
+		err = pci_bus_alloc_resource(pf->bus, res, size, pf->iov->align,
+					     PCIBIOS_MIN_MEM,
+					     IORESOURCE_PREFETCH, NULL, NULL);
+		if (err < 0 && (res->flags & IORESOURCE_PREFETCH))
+			err = pci_bus_alloc_resource(pf->bus, res, size,
+						     pf->iov->align,
+						     PCIBIOS_MIN_MEM,
+						     0, NULL, NULL);
+		if (err) {
+			dev_err(&pf->dev, "can't allocate IOV resource.\n");
+			return err;
+		}
+
+		pci_update_base(pf, pci_bar_unknown, res, reg);
+	}
+
+	return 0;
+}
+
+static void iov_free_res(struct pci_dev *pf)
+{
+	int i;
+	struct resource *res;
+
+	for (i = 0; i < PCI_IOV_NUM_BAR; i++) {
+		res = pf->iov->resource + i;
+		if (res->parent)
+			release_resource(res);
+	}
+}
+
+static void iov_set_vfe(struct pci_dev *pf, int enable)
+{
+	u16 reg;
+
+	pci_read_config_word(pf, pf->iov->cap + PCI_IOV_CTRL, &reg);
+
+	if (enable) {
+		reg |= (PCI_IOV_CTRL_VFE | PCI_IOV_CTRL_MSE);
+
+		if (pci_ari_fwd_enabled(pf))
+			reg |= PCI_IOV_CTRL_ARI;
+		else
+			reg &= ~PCI_IOV_CTRL_ARI;
+	} else
+		reg &= ~(PCI_IOV_CTRL_VFE | PCI_IOV_CTRL_MSE);
+
+	pci_write_config_word(pf, pf->iov->cap + PCI_IOV_CTRL, reg);
+
+	ssleep(1);
+}
+
+static int iov_init(struct pci_dev *pf)
+{
+	int i;
+	u16 maxbus;
+	u32 reg;
+	int err;
+	int pos = pf->iov->cap;
+
+	iov_set_vfe(pf, 0);
+
+	if (pf->iov->nr_virtfn == 0)
+		return 0;
+
+	pci_write_config_word(pf, pos + PCI_IOV_NUM_VF, pf->iov->nr_virtfn);
+
+	pci_read_config_dword(pf, pos + PCI_IOV_SUP_PGSIZE, &reg);
+	i = PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0;
+	while (!(reg & (1 << i++)))
+		if (i == 32) {
+			err = -EINVAL;
+			goto failed1;
+		}
+
+	pci_write_config_dword(pf, pos + PCI_IOV_SYS_PGSIZE, 1 << i);
+	pf->iov->align = 1 << (i + 12);
+
+	err = iov_alloc_res(pf);
+	if (err)
+		goto failed2;
+
+	iov_set_vfe(pf, 1);
+
+	pci_read_config_word(pf, pos + PCI_IOV_VF_DID, &pf->iov->device);
+	pci_read_config_word(pf, pos + PCI_IOV_VF_OFFSET, &pf->iov->offset);
+	pci_read_config_word(pf, pos + PCI_IOV_VF_STRIDE, &pf->iov->stride);
+
+	if (!pf->iov->offset || (pf->iov->nr_virtfn > 1 && !pf->iov->stride)) {
+		err = -EIO;
+		goto failed3;
+	}
+
+	maxbus = ((pf->devfn + pf->iov->offset + pf->iov->stride *
+		  (pf->iov->nr_virtfn - 1)) >> 8) + pf->bus->number;
+	if (maxbus > pf->bus->subordinate) {
+		dev_err(&pf->dev, "can't allocate IOV bus range.\n");
+		err = -EINVAL;
+		goto failed3;
+	}
+
+	pf->iov->args = kzalloc(sizeof(char *) * pf->iov->nr_virtfn,
+				GFP_KERNEL);
+	if (!pf->iov->args) {
+		err = -ENOMEM;
+		goto failed3;
+	}
+
+	return 0;
+
+failed3:
+	iov_set_vfe(pf, 0);
+failed2:
+	iov_free_res(pf);
+failed1:
+	pf->iov->nr_virtfn = 0;
+
+	return err;
+}
+
+static int iov_set_nr_virtfn(struct pci_dev *pf, int nvfs)
+{
+	int i;
+	int err;
+	u8 bus, devfn;
+
+	for (i = 0; i < pf->iov->nr_virtfn; i++) {
+		vfid_to_bdf(pf, i, &bus, &devfn);
+		if (pci_get_bus_and_slot(bus, devfn))
+			return -EBUSY;
+	}
+
+	if (nvfs == pf->iov->nr_virtfn)
+		return 0;
+
+	if (nvfs < 0 || nvfs > pf->iov->max_virtfn)
+		return -EINVAL;
+
+	err = notify_phyfn(pf, PCI_IOV_VF_NUM, nvfs);
+	if (err)
+		return err;
+
+	iov_free_res(pf);
+	kfree(pf->iov->args);
+	pf->iov->args = NULL;
+	pf->iov->nr_virtfn = nvfs;
+
+	err = iov_init(pf);
+	if (err)
+		notify_phyfn(pf, PCI_IOV_VF_ERR, err);
+
+	return err;
+}
+
+/**
+ * pci_iov_virtfn_param - retrieve parameter of a Virtual Function
+ * @dev: PCI device
+ * @vfid: Virtual Function ID (0 ~ nvfs-1)
+ *
+ * Returns pointer to string (which could be empty string) on success,
+ * and null pointer on failure.
+ */
+const char *pci_iov_virtfn_param(struct pci_dev *dev, int vfid)
+{
+	BUG_ON(!dev->iov);
+
+	if (vfid < 0 || vfid >= dev->iov->nr_virtfn)
+		return NULL;
+
+	return dev->iov->args[vfid];
+}
+EXPORT_SYMBOL_GPL(pci_iov_virtfn_param);
+
+/**
+ * pci_iov_max_virtfn - query maximum number of Virtual Functions
+ * @dev: PCI device
+ *
+ * Returns number of Virtual Functions that are initially associated
+ * with the Physical Function, and negative on failure.
+ */
+int pci_iov_max_virtfn(struct pci_dev *dev)
+{
+	u16 reg;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_IOV);
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_IOV_INITIAL_VF, &reg);
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pci_iov_max_virtfn);
+
+/**
+ * pci_iov_enable - enable device's SR-IOV capability
+ * @dev: PCI device
+ * @nvfs: number of Virtual Functions that are available
+ * @cb: callback used to notify Physical Function driver
+ *
+ * Returns 0 on success, and negative on failure.
+ *
+ * This function initializes SR-IOV capability. Number of available
+ * Virtual Functions should be set to less than or equal to the value
+ * returned by pci_iov_max_virtfn().
+ */
+int pci_iov_enable(struct pci_dev *dev, int nvfs,
+		   int (*cb)(struct pci_dev *, int, int))
+{
+	u16 reg;
+	int err;
+	int pos;
+	struct pci_iov *iov;
+
+	BUG_ON(dev->iov);
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_IOV);
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCI_IOV_INITIAL_VF, &reg);
+	if (nvfs < 0 || nvfs > reg)
+		return -EINVAL;
+
+	iov = kzalloc(sizeof(*iov), GFP_KERNEL);
+	if (!iov)
+		return -ENOMEM;
+
+	iov->cap = pos;
+	iov->max_virtfn = reg;
+	iov->nr_virtfn = nvfs;
+	iov->notify = cb;
+	dev->iov = iov;
+
+	err = iov_init(dev);
+	if (err)
+		goto failed1;
+
+	err = sysfs_create_file(&dev->dev.kobj, &dev_attr_iov.attr);
+	if (err)
+		goto failed2;
+
+	dev_info(&dev->dev, "IOV is enabled\n");
+	return 0;
+
+failed2:
+	iov_set_vfe(dev, 0);
+failed1:
+	kfree(iov);
+	dev->iov = NULL;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(pci_iov_enable);
+
+/**
+ * pci_iov_disable - disable device's SR-IOV capability
+ * @dev: PCI device
+ *
+ * Should be called upon Physical Function removal, or power state
+ * change. All previous allocated Virtual Functions are reclaimed.
+ */
+void pci_iov_disable(struct pci_dev *dev)
+{
+	int i;
+	struct pci_iov *iov = dev->iov;
+
+	BUG_ON(!iov);
+
+	sysfs_remove_file(&dev->dev.kobj, &dev_attr_iov.attr);
+
+	for (i = 0; i < iov->nr_virtfn; i++)
+		iov_remove_virtfn(dev, i);
+
+	iov_set_vfe(dev, 0);
+	iov_free_res(dev);
+	kfree(iov->args);
+	kfree(iov);
+	dev->iov = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_iov_disable);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d807cd7..8a13f8b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -144,3 +144,16 @@ struct pci_slot_attribute {
 };
 #define to_pci_slot_attr(s) container_of(s, struct pci_slot_attribute, attr)
 
+/* Single Root I/O Virtualization */
+struct pci_iov {
+	int	cap;		/* Capability position */
+	int	align;		/* Page size used to map memory space */
+	int	nr_virtfn;	/* Number of available VFs */
+	u16	max_virtfn;	/* Number of VFs associated with the PF */
+	u16	device;		/* VF device ID */
+	u16	offset;		/* First VF Routing ID offset */
+	u16	stride;		/* Following VF stride */
+	char	**args;		/* Device specific parameter */
+	struct resource	resource[PCI_IOV_NUM_BAR]; /* VF BAR resource */
+	int 	(*notify)(struct pci_dev *, int, int); /* VF callback */
+};
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 110779a..9cf91ba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -142,6 +142,7 @@ struct pci_cap_saved_state {
 
 struct pcie_link_state;
 struct pci_vpd;
+struct pci_iov;
 
 /*
  * The pci_dev structure is used to describe PCI devices.
@@ -230,6 +231,9 @@ #ifdef CONFIG_PCI_MSI
 	struct list_head msi_list;
 #endif
 	struct pci_vpd *vpd;
+#ifdef CONFIG_PCI_IOV
+	struct pci_iov *iov;		/* IOV capability related */
+#endif
 };
 
 extern struct pci_dev *alloc_pci_dev(void);
@@ -1154,5 +1158,36 @@ static inline int pci_ari_next_fn(struct
 }
 #endif
 
+#define PCI_IOV_VF_ENA	0x00000001U	/* VF enable */
+#define PCI_IOV_VF_DIS	0x00000002U	/* VF disable */
+#define PCI_IOV_VF_PAR	0x00000004U	/* VF parameter change */
+#define PCI_IOV_VF_NUM	0x00000008U	/* Number of VFs change */
+#define PCI_IOV_VF_ERR	0x00000010U	/* VF error */
+
+#ifdef CONFIG_PCI_IOV
+extern int pci_iov_enable(struct pci_dev *dev, int nvfs,
+			  int (*notify)(struct pci_dev *, int, int));
+extern void pci_iov_disable(struct pci_dev *dev);
+extern int pci_iov_max_virtfn(struct pci_dev *dev);
+extern const char *pci_iov_virtfn_param(struct pci_dev *dev, int vfid);
+#else
+static inline int pci_iov_enable(struct pci_dev *dev, int nvfs,
+			  int (*notify)(struct pci_dev *, int, int))
+{
+	return -EIO;
+}
+static inline void pci_iov_disable(struct pci_dev *dev)
+{
+}
+static inline int pci_iov_max_virtfn(struct pci_dev *dev)
+{
+	return -EIO;
+}
+static inline const char *pci_iov_virtfn_param(struct pci_dev *dev, int vfid)
+{
+	return NULL;
+}
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index eb6686b..c97c5f2 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -434,6 +434,7 @@ #define PCI_EXT_CAP_ID_VC	2
 #define PCI_EXT_CAP_ID_DSN	3
 #define PCI_EXT_CAP_ID_PWR	4
 #define PCI_EXT_CAP_ID_ARI	14
+#define PCI_EXT_CAP_ID_IOV	16
 
 /* Advanced Error Reporting */
 #define PCI_ERR_UNCOR_STATUS	4	/* Uncorrectable Error Status */
@@ -551,4 +552,23 @@ #define  PCI_ARI_CTRL_MFVC	0x0001	/* MFV
 #define  PCI_ARI_CTRL_ACS	0x0002	/* ACS Function Groups Enable */
 #define  PCI_ARI_CTRL_FG(x)	(((x) >> 4) & 7) /* Function Group */
 
+/* Single Root I/O Virtualization */
+#define PCI_IOV_CAP		0x04	/* SR-IOV Capabilities */
+#define PCI_IOV_CTRL		0x08	/* SR-IOV Control */
+#define  PCI_IOV_CTRL_VFE	0x01	/* VF Enable */
+#define  PCI_IOV_CTRL_MSE	0x08	/* VF Memory Space Enable */
+#define  PCI_IOV_CTRL_ARI	0x10	/* ARI Capable Hierarchy */
+#define PCI_IOV_STATUS		0x0a	/* SR-IOV Status */
+#define PCI_IOV_INITIAL_VF	0x0c	/* Initial VFs */
+#define PCI_IOV_TOTAL_VF	0x0e	/* Total VFs */
+#define PCI_IOV_NUM_VF		0x10	/* Number of VFs */
+#define PCI_IOV_FUNC_LINK	0x12	/* Function Dependency Link */
+#define PCI_IOV_VF_OFFSET	0x14	/* First VF Offset */
+#define PCI_IOV_VF_STRIDE	0x16	/* Following VF Stride */
+#define PCI_IOV_VF_DID		0x1a	/* VF Device ID */
+#define PCI_IOV_SUP_PGSIZE	0x1c	/* Supported Page Sizes */
+#define PCI_IOV_SYS_PGSIZE	0x20	/* System Page Size */
+#define PCI_IOV_BAR_0		0x24	/* VF BAR0 */
+#define PCI_IOV_NUM_BAR		6	/* Number of VF BARs */
+
 #endif /* LINUX_PCI_REGS_H */
-- 
1.4.2.1
