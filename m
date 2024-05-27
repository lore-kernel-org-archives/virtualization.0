Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0941D53C
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782884; cv=none; b=GGQnIqgcnNadIYy2IhFW4yfNMKCxYF78H7LJmwul+59lZfm/pQMOjj6MrEIKCpAW3DG5KCIN3vjlTxnVaYomzT4+cYXw+cCHw79FwS5PceefuCF2l/Bvaib7sypv1PT1GrBTCyN3w59q3VaPzzxDL0mOL+od6qHB5SKrLANNrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782884; c=relaxed/simple;
	bh=nkmQ+JilPUgDZHHOygxgTAIyNq6MMtJg+WcoXQ51KBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOFyaz0SLIlv1hQFUrjvFCVh1JzdW94PHQv6zcmIJf9lTl/r1BkhlbIBRLNSnKCj7/0fdoVkIbWFvB35YOSG7nQLnqq82S759K8GxZZRFCIryGquyGa7CRqnJMxFAbP37jNhISXYqihbP2hNs2Mln/95vbRnZ/zUqIrDs+zknF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLqdynMQ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLqdynMQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A0D06078B
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sOCj_XxD5K8L for <virtualization@lists.linux-foundation.org>;
 Mon, 27 May 2024 04:08:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E2994605C4
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2994605C4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GLqdynMQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E2994605C4
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 04:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716782880; x=1748318880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkmQ+JilPUgDZHHOygxgTAIyNq6MMtJg+WcoXQ51KBM=;
  b=GLqdynMQPOHwyXG9AlR27U5k6IS0lYCsVZogBszu+DOgJkk7CxUt4CKj
   3bNyN63QAvVdESZHT/MEkyLZwz1AbEpTzigEIUDc+ikhptfLyObyzae17
   YfyekAhpsn/Vg2AO+dErLu3t4ndEzji9zMNZaxJ0O8UesMjjbVWBPuEZ4
   DYZs/LtWmK/BVHmCbw/2JiEeMKXCeCZBvVENKwBWhrgAxLZUICuUdzV1j
   vO8QYrzkiRQPIclst57u28w9Cuz4hV+rUh8pYDOgAEr1aNmhjg8mfhfZv
   e2En/m9UHwmFVQrQbFnJ/NMiOy3NurPLxraSDQpZSgrNdPNe/OZnIK9y+
   Q==;
X-CSE-ConnectionGUID: VoZp/fF/SLOaIWK/VOLtSw==
X-CSE-MsgGUID: FyofvGDMR9yLTFlEcA2Hyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13022801"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13022801"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:07:47 -0700
X-CSE-ConnectionGUID: Bkts9isxQvqMWm0kVfwBHA==
X-CSE-MsgGUID: VnCE2BnBTxWm79MvG8vQPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39399976"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 21:07:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 06/10] iommufd: Add iommufd fault object
Date: Mon, 27 May 2024 12:05:13 +0800
Message-Id: <20240527040517.38561-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527040517.38561-1-baolu.lu@linux.intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommufd fault object provides an interface for delivering I/O page
faults to user space. These objects are created and destroyed by user
space, and they can be associated with or dissociated from hardware page
table objects during page table allocation or destruction.

User space interacts with the fault object through a file interface. This
interface offers a straightforward and efficient way for user space to
handle page faults. It allows user space to read fault messages
sequentially and respond to them by writing to the same file. The file
interface supports reading messages in poll mode, so it's recommended that
user space applications use io_uring to enhance read and write efficiency.

A fault object can be associated with any iopf-capable iommufd_hw_pgtable
during the pgtable's allocation. All I/O page faults triggered by devices
when accessing the I/O addresses of an iommufd_hw_pgtable are routed
through the fault object to user space. Similarly, user space's responses
to these page faults are routed back to the iommu device driver through
the same fault object.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                   |   4 +
 drivers/iommu/iommufd/iommufd_private.h |  30 ++++
 include/uapi/linux/iommufd.h            |  18 ++
 drivers/iommu/io-pgfault.c              |   2 +
 drivers/iommu/iommufd/fault.c           | 227 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   6 +
 drivers/iommu/iommufd/Makefile          |   1 +
 7 files changed, 288 insertions(+)
 create mode 100644 drivers/iommu/iommufd/fault.c

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4067ebdd6232..16b3a2da91ef 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -124,12 +124,16 @@ struct iopf_fault {
 struct iopf_group {
 	struct iopf_fault last_fault;
 	struct list_head faults;
+	size_t fault_count;
 	/* list node for iommu_fault_param::faults */
 	struct list_head pending_node;
 	struct work_struct work;
 	struct iommu_attach_handle *attach_handle;
 	/* The device's fault data parameter. */
 	struct iommu_fault_param *fault_param;
+	/* Used by handler provider to hook the group on its own lists. */
+	struct list_head node;
+	u32 cookie;
 };
 
 /**
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9b..c8a4519f1405 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -128,6 +128,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HWPT_NESTED,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
+	IOMMUFD_OBJ_FAULT,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -426,6 +427,35 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+/*
+ * An iommufd_fault object represents an interface to deliver I/O page faults
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with hardware page table objects during page-table allocation.
+ */
+struct iommufd_fault {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct file *filep;
+
+	/* The lists of outstanding faults protected by below mutex. */
+	struct mutex mutex;
+	struct list_head deliver;
+	struct xarray response;
+
+	struct wait_queue_head wait_queue;
+};
+
+struct iommufd_attach_handle {
+	struct iommu_attach_handle handle;
+	struct iommufd_device *idev;
+};
+
+/* Convert an iommu attach handle to iommufd handle. */
+#define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
+
+int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_fault_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2f34d66436fb..eba452d4344e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -50,6 +50,7 @@ enum {
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_FAULT_QUEUE_ALLOC,
 };
 
 /**
@@ -788,4 +789,21 @@ struct iommu_hwpt_page_response {
 	__u32 cookie;
 	__u32 reserved;
 };
+
+/**
+ * struct iommu_fault_alloc - ioctl(IOMMU_FAULT_QUEUE_ALLOC)
+ * @size: sizeof(struct iommu_fault_alloc)
+ * @flags: Must be 0
+ * @out_fault_id: The ID of the new FAULT
+ * @out_fault_fd: The fd of the new FAULT
+ *
+ * Explicitly allocate a fault handling object.
+ */
+struct iommu_fault_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 out_fault_id;
+	__u32 out_fault_fd;
+};
+#define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
 #endif
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index c62fcb67ef02..a629d8a93614 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -110,6 +110,8 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 	list_add(&group->pending_node, &iopf_param->faults);
 	mutex_unlock(&iopf_param->lock);
 
+	group->fault_count = list_count_nodes(&group->faults);
+
 	return group;
 }
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
new file mode 100644
index 000000000000..d0dafe761075
--- /dev/null
+++ b/drivers/iommu/iommufd/fault.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation
+ */
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/iommufd.h>
+#include <linux/poll.h>
+#include <linux/anon_inodes.h>
+#include <uapi/linux/iommufd.h>
+
+#include "../iommu-priv.h"
+#include "iommufd_private.h"
+
+void iommufd_fault_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iopf_group *group, *next;
+
+	/*
+	 * The iommufd object's reference count is zero at this point.
+	 * We can be confident that no other threads are currently
+	 * accessing this pointer. Therefore, acquiring the mutex here
+	 * is unnecessary.
+	 */
+	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+		list_del(&group->node);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+}
+
+static void iommufd_compose_fault_message(struct iommu_fault *fault,
+					  struct iommu_hwpt_pgfault *hwpt_fault,
+					  struct iommufd_device *idev,
+					  u32 cookie)
+{
+	hwpt_fault->size = sizeof(*hwpt_fault);
+	hwpt_fault->flags = fault->prm.flags;
+	hwpt_fault->dev_id = idev->obj.id;
+	hwpt_fault->pasid = fault->prm.pasid;
+	hwpt_fault->grpid = fault->prm.grpid;
+	hwpt_fault->perm = fault->prm.perm;
+	hwpt_fault->addr = fault->prm.addr;
+	hwpt_fault->length = 0;
+	hwpt_fault->cookie = cookie;
+}
+
+static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
+	struct iommufd_fault *fault = filep->private_data;
+	struct iommu_hwpt_pgfault data;
+	struct iommufd_device *idev;
+	struct iopf_group *group;
+	struct iopf_fault *iopf;
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos || count % fault_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(&fault->deliver) && count > done) {
+		group = list_first_entry(&fault->deliver,
+					 struct iopf_group, node);
+
+		if (group->fault_count * fault_size > count - done)
+			break;
+
+		rc = xa_alloc(&fault->response, &group->cookie, group,
+			      xa_limit_32b, GFP_KERNEL);
+		if (rc)
+			break;
+
+		idev = to_iommufd_handle(group->attach_handle)->idev;
+		list_for_each_entry(iopf, &group->faults, list) {
+			iommufd_compose_fault_message(&iopf->fault,
+						      &data, idev,
+						      group->cookie);
+			rc = copy_to_user(buf + done, &data, fault_size);
+			if (rc) {
+				xa_erase(&fault->response, group->cookie);
+				break;
+			}
+			done += fault_size;
+		}
+
+		list_del(&group->node);
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done == 0 ? rc : done;
+}
+
+static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	size_t response_size = sizeof(struct iommu_hwpt_page_response);
+	struct iommufd_fault *fault = filep->private_data;
+	struct iommu_hwpt_page_response response;
+	struct iopf_group *group;
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos || count % response_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (count > done) {
+		rc = copy_from_user(&response, buf + done, response_size);
+		if (rc)
+			break;
+
+		group = xa_erase(&fault->response, response.cookie);
+		if (!group) {
+			rc = -EINVAL;
+			break;
+		}
+
+		iopf_group_response(group, response.code);
+		iopf_free_group(group);
+		done += response_size;
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done == 0 ? rc : done;
+}
+
+static __poll_t iommufd_fault_fops_poll(struct file *filep,
+					struct poll_table_struct *wait)
+{
+	struct iommufd_fault *fault = filep->private_data;
+	__poll_t pollflags = EPOLLOUT;
+
+	poll_wait(filep, &fault->wait_queue, wait);
+	mutex_lock(&fault->mutex);
+	if (!list_empty(&fault->deliver))
+		pollflags |= EPOLLIN | EPOLLRDNORM;
+	mutex_unlock(&fault->mutex);
+
+	return pollflags;
+}
+
+static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
+{
+	struct iommufd_fault *fault = filep->private_data;
+
+	iommufd_ctx_put(fault->ictx);
+	refcount_dec(&fault->obj.users);
+	return 0;
+}
+
+static const struct file_operations iommufd_fault_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nonseekable_open,
+	.read		= iommufd_fault_fops_read,
+	.write		= iommufd_fault_fops_write,
+	.poll		= iommufd_fault_fops_poll,
+	.release	= iommufd_fault_fops_release,
+	.llseek		= no_llseek,
+};
+
+int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_fault_alloc *cmd = ucmd->cmd;
+	struct iommufd_fault *fault;
+	struct file *filep;
+	int fdno;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
+	if (IS_ERR(fault))
+		return PTR_ERR(fault);
+
+	fault->ictx = ucmd->ictx;
+	INIT_LIST_HEAD(&fault->deliver);
+	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
+	mutex_init(&fault->mutex);
+	init_waitqueue_head(&fault->wait_queue);
+
+	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
+				   fault, O_RDWR);
+	if (IS_ERR(filep)) {
+		rc = PTR_ERR(filep);
+		goto out_abort;
+	}
+
+	refcount_inc(&fault->obj.users);
+	iommufd_ctx_get(fault->ictx);
+	fault->filep = filep;
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_fput;
+	}
+
+	cmd->out_fault_id = fault->obj.id;
+	cmd->out_fault_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+	iommufd_object_finalize(ucmd->ictx, &fault->obj);
+
+	fd_install(fdno, fault->filep);
+
+	return 0;
+out_put_fdno:
+	put_unused_fd(fdno);
+out_fput:
+	fput(filep);
+	refcount_dec(&fault->obj.users);
+	iommufd_ctx_put(fault->ictx);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
+
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 39b32932c61e..961b2949c06f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -332,6 +332,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_fault_alloc fault;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -381,6 +382,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc, struct iommu_fault_alloc,
+		 out_fault_fd),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -513,6 +516,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
+	[IOMMUFD_OBJ_FAULT] = {
+		.destroy = iommufd_fault_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 34b446146961..b94a74366eed 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -6,6 +6,7 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
+	fault.o \
 	vfio_compat.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
-- 
2.34.1

