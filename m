Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4452CCE6
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067784; cv=fail; b=rFutTCe3xhGs3WRS4PeeOl9ILJzN3JiTI6wDbQdxD5vVMyIL1663C8btsIztmzemoFkn7mk8TsVdO8e4x82wBL6YMdILq6QXwx+mHYe8gnRv9Gj5TJV9l5voI1KPO+nOM3BYsdtAo3gGsCIE+/2u8/a6OPC5OxGG48lGs9+wnLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067784; c=relaxed/simple;
	bh=bp/m3uzWv3hkXprwVfR8r9f7e9PwEeQCto/G6HcjAOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdmcc+iWkMyICBZKzJj6wVW7t7Fz7Ssxe/+mOMvQvUGTLSD2MYsg8IXmUfySOjzdREzsK4rHbyPU3hMvdsr8wS1FFnQxgDM101VMp9Evx91v30BPG8t7jHIXSJQNmOemUyJUNs3ijGQSnaWditK8UfqcOVN8HO+5HQ7DNsJPlrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wrMWqa0J; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wrMWqa0J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2EItJvNOFobSmzc5uTXKbXbh4FctjDhyVubMR6S3vrq8vng5OTOOXfXnwBnin0ovJ3xvwelBAqLDxdIQV3B3d7mLPtpNRhGEIkCo8HI70xzr11nkEY8fuV+hbJe5/de2UqrM0Wyfj+2mW9ugBHezvkk6NOCueE321Z+LUsMg///PEjnl2iRS+UAKl/7gBDIbeGkiZo+HNDQGUI7HpXAjHK1hPlJ7wfw01ytJEuZcL5OMouXmhqJrkL4wcTZn6xaj5kiM5qYZpX5SOt1rOkDXr9AbDbNSYrlOVSAX3LeVzDH5Khqhpl7Qg0NO3pzpFbFpvO9WnrFSAIwIf/jAihYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H1IyCVACdWpmSUbv4h7IxAYdEMcLnxZCYkB6oXmdkU=;
 b=D7t/tJfbk07pqvLQIJ+nl6AsUGp/a2hVKT8m39gkOkoabTqvR9NqThrLit7xJeR7Q+ZVEJ7bGmWngl2XFp40VF5XZkf6OfxGYb6CVAYBS5tlELQFtqoL5Klse0B+MIz/b3SxazCnRF52T68t7PzeVI+bWIkQCgUR2WS0WpGQCAQOwWpiV+wsnF5/U9MeM19vI4UF8bJ4C09td9DxVpcYZ50jaMf3Puoy4KtyJMYz7PATEv3E97O1Cqq4MfDKSkQqAOz3ok7eSWV9uos1xrLeohJtASyvg6tc9ENU1dQz3UFxfdnNmviipaOwOBI8sgBU7NN1AuygYuhug9qA6vaJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H1IyCVACdWpmSUbv4h7IxAYdEMcLnxZCYkB6oXmdkU=;
 b=wrMWqa0JIZWlxhGpueoGOaBRAFcgd6TfOBf6c4k+TEY0pMKQqRqoUFBmy8W3uKN0dsJF/ZosmVnxNo2RQzj3Bwnaq3jsUgHSfm3aoCtGf3P9+tY9/viV1OIFZsKkoxsUapzcPJ38Ee0cUX6VbU2Fes4GB3UfFgPAJHS+CKb8zwQ=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:54 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a4) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 09:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:02:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:02:54 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 04:02:51 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saravanak@kernel.org>,
	<mst@redhat.com>, <jasowangio@gmail.com>, <eperezma@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>, Baorui.Liu
	<baorliu@amd.com>, kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v2 1/1] cpufreq: virtio: add driver to report host frequency to guests
Date: Tue, 22 Sep 2026 17:02:24 +0800
Message-ID: <20260922090224.430-2-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916073735.541-1-baorliu@amd.com>
References: <20260916073735.541-1-baorliu@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb5c7e6-46db-459b-6ff3-08df18884a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|82310400026|23010399003|376014|10067099003|56012099006|3023799007|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B7SrBL6HUHrdMiWELPv/yTy8IDxCQiMhl5uXyrjvssZGanWPLtlCLInHpKO8shjrM0BMtsLLb2ZD7sMnRXROuwXjPdTh4nmksZBSl7ALN+Vnr54Kx/lhnK6Btc8JiNscZzWnPldSwtWi+DG51Gg/68s24MfqHuQ2z3PwfuILZLJ3E9GIkHU79t6FDTlUWN4Nvle2UqhqkiX3eLyOAzmWsKYGWjhp1NpTYLwooYsm1fFWn3UQXRYgpLUXVrgcMP//ku21HN5R+Pp6IYIHe3UVfpRBSSrlaCEwjj2iFkXENk6bnHtqltVuRfvtdCxKE4r3PCZEjSEY8yT0A0ItyL71sgPL9sC+bNTXicIcXbvFez0e7c74ln9MXcLWukqgsaBlbxwJ8EydXomXtbT6IhM0F23BDxa4l5dCvgCISyhD7PHwwFJcwcfFWYesPf3LmEU2twKPXhx9Jtoy3rPUnnUl6AtkS3r9AocoeDRxOyiIOmmU8uBSmxmyg4zcBJSjC1TYltfzyzl50YbsOuxoPfb8VtZyhBO1ghaz9Znvc9e7G+9sVMot/LBLLoBa7zhFFvCd1f4t33HfLOFuEnd0TD9fo3M9hGg+QuXHJs2G0uMnUcrznRAhPuzGF6SzUyypT0vvvFHxyfdDRUqIijzoZwIGTEXmjo0VGFQEjCLJtkHe/vU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qjoywe1vooE3+Pb+BJkUY01JoLKBxZWoRiYBtsj1kmBxkPlSW/9A+B6sMzxsu935c4vjc5x8cqMdRJGzpeS6iuwey1dl7KzKiDoGXjhmW7BzgGKceVD6f7hB2Q8wNPtSastHEKqYxnD3+DiSMqsKzbJOcFfrgRJVL/oG7y3p1JlR98Z0RpJS0aq3+cWYOwQPpL2sXIxUJWF95QhiMJfHc5eTak/C0Bne69Ge32dnHIqpVSo9V3PrxJ5pb7yQLhe0eje0SEIa/ieh0hhOwFkm0wB8OHy/89j+EmfSwVHz2T4NfrWHrSXHh4QOtwvFUPDggTcZx97kUfBnkQ08gscUS83eYDqP6YhcAYO4Z3jHk/iORTYbX7Ubx6vRwH7XVj784Nn5kKHVAgutbx9vmJwgsG0fdoy9i8Ulm1qjbKwj6pdVVopuRF4Ee2GPfADgXuLE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:02:54.7754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb5c7e6-46db-459b-6ff3-08df18884a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

Some virtualization stacks pin each vCPU to a pCPU. Guest software
still needs the current host frequency for energy accounting, but
the guest cannot access host sysfs.

Add a virtio frontend that queries the host for the frequency of
the mapped pCPU and exposes it through the cpufreq .get() callback.

Fix build on current linux-pm: cpufreq_generic_attr no longer
exists; use cpufreq_freq_attr_scaling_available_freqs instead.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609191437.OaXd0Blz-lkp@intel.com/
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 drivers/cpufreq/Kconfig          |  14 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/virtio-cpufreq.c | 240 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h  |   1 +
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/cpufreq/virtio-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index db83f3365698..ba0e38f5dce5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -242,6 +242,20 @@ config CPUFREQ_VIRT
 
 	  If in doubt, say N.
 
+config CPUFREQ_VIRTIO
+	tristate "Virtio CPU frequency driver"
+	depends on VIRTIO
+	help
+	  This option adds a virtio cpufreq frontend. The guest sends a
+	  vCPU id to the host backend and receives the mapped physical
+	  CPU frequency in kHz through the cpufreq .get() callback.
+
+	  This is intended for virtualization stacks (for example Xen)
+	  that pin each vCPU to a pCPU and expose host frequency to the
+	  guest. It does not change the host frequency.
+
+	  If in doubt, say N.
+
 config CPUFREQ_DT_PLATDEV
 	bool "Generic DT based cpufreq platdev driver"
 	depends on OF
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 6c7a39b7f8d2..9d9bb7ea1300 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 obj-$(CONFIG_CPUFREQ_DT_RUST)		+= rcpufreq_dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 obj-$(CONFIG_CPUFREQ_VIRT)		+= virtual-cpufreq.o
+obj-$(CONFIG_CPUFREQ_VIRTIO)		+= virtio-cpufreq.o
 
 # Traces
 CFLAGS_amd-pstate-trace.o               := -I$(src)
diff --git a/drivers/cpufreq/virtio-cpufreq.c b/drivers/cpufreq/virtio-cpufreq.c
new file mode 100644
index 000000000000..aa04fd7fd343
--- /dev/null
+++ b/drivers/cpufreq/virtio-cpufreq.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Virtio cpufreq frontend
+ *
+ * Query the host for the frequency of the pCPU that currently runs a
+ * given vCPU. Used when the guest cannot read host cpufreq sysfs, for
+ * example a Xen domain that needs the value for energy accounting.
+ *
+ * The on-wire protocol is a packed { cpu_id, freq_khz } request that
+ * must match the QEMU virtio-cpufreq backend.
+ */
+
+#include <linux/completion.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+
+#define DRV_NAME "virtio-cpufreq"
+
+struct virtio_cpufreq_req {
+	__le32 cpu_id;
+	__le32 freq_khz;
+} __packed;
+
+struct virtio_cpufreq {
+	struct virtio_device *vdev;
+	struct virtqueue *vq;
+	struct mutex lock; /* serializes virtqueue requests */
+};
+
+static struct virtio_cpufreq *virtio_cpufreq_dev;
+
+/*
+ * Placeholder OPPs so cpufreq has a table. Real platforms should
+ * populate this from the host or from firmware. Values match the
+ * existing QEMU/Android backend used for bring-up.
+ */
+static struct cpufreq_frequency_table virtio_freq_table[] = {
+	{ .frequency = 1400000 },
+	{ .frequency = 1700000 },
+	{ .frequency = 3000000 },
+	{ .frequency = CPUFREQ_TABLE_END },
+};
+
+static int virtio_cpufreq_init_policy(struct cpufreq_policy *policy)
+{
+	cpumask_clear(policy->cpus);
+	cpumask_set_cpu(policy->cpu, policy->cpus);
+
+	policy->freq_table = virtio_freq_table;
+	policy->cpuinfo.min_freq = 1400000;
+	policy->cpuinfo.max_freq = 3000000;
+	policy->cpuinfo.transition_latency = 0;
+
+	return 0;
+}
+
+static int virtio_cpufreq_target_index(struct cpufreq_policy *policy,
+				       unsigned int index)
+{
+	struct cpufreq_freqs freqs;
+
+	freqs.old = policy->cur;
+	freqs.new = policy->freq_table[index].frequency;
+
+	/*
+	 * This frontend does not change host frequency. It only keeps
+	 * the cpufreq core in sync so userspace can observe values.
+	 */
+	cpufreq_freq_transition_begin(policy, &freqs);
+	cpufreq_freq_transition_end(policy, &freqs, 0);
+
+	return 0;
+}
+
+static unsigned int virtio_cpufreq_fallback(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	unsigned int freq = 0;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (policy) {
+		freq = policy->cur;
+		cpufreq_cpu_put(policy);
+	}
+
+	return freq;
+}
+
+static void virtio_cpufreq_vq_cb(struct virtqueue *vq)
+{
+	struct completion *done;
+	unsigned int len;
+
+	while ((done = virtqueue_get_buf(vq, &len)) != NULL)
+		complete(done);
+}
+
+static unsigned int virtio_cpufreq_get(unsigned int cpu)
+{
+	struct virtio_cpufreq *vc = virtio_cpufreq_dev;
+	struct virtio_cpufreq_req *req;
+	struct scatterlist out_sg, in_sg, *sgs[2];
+	struct completion done;
+	unsigned int freq_khz;
+	int ret;
+
+	if (!vc || !vc->vq)
+		return virtio_cpufreq_fallback(cpu);
+
+	req = kzalloc_obj(*req, GFP_KERNEL);
+	if (!req)
+		return virtio_cpufreq_fallback(cpu);
+
+	req->cpu_id = cpu_to_le32(cpu);
+
+	init_completion(&done);
+	sg_init_one(&out_sg, req, sizeof(*req));
+	sg_init_one(&in_sg, req, sizeof(*req));
+	sgs[0] = &out_sg;
+	sgs[1] = &in_sg;
+
+	mutex_lock(&vc->lock);
+	ret = virtqueue_add_sgs(vc->vq, sgs, 1, 1, &done, GFP_KERNEL);
+	if (ret) {
+		mutex_unlock(&vc->lock);
+		kfree(req);
+		return virtio_cpufreq_fallback(cpu);
+	}
+
+	virtqueue_kick(vc->vq);
+	ret = wait_for_completion_timeout(&done, msecs_to_jiffies(1000));
+	mutex_unlock(&vc->lock);
+
+	if (!ret) {
+		/*
+		 * The buffer may still be on the virtqueue. Leak it
+		 * rather than freeing while the host may still write.
+		 */
+		return virtio_cpufreq_fallback(cpu);
+	}
+
+	freq_khz = le32_to_cpu(req->freq_khz);
+	kfree(req);
+
+	if (!freq_khz)
+		return virtio_cpufreq_fallback(cpu);
+
+	return freq_khz;
+}
+
+static struct freq_attr *virtio_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver virtio_cpufreq_driver = {
+	.name		= DRV_NAME,
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.init		= virtio_cpufreq_init_policy,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= virtio_cpufreq_target_index,
+	.get		= virtio_cpufreq_get,
+	.attr		= virtio_cpufreq_attr,
+};
+
+static int virtio_cpufreq_probe(struct virtio_device *vdev)
+{
+	struct virtio_cpufreq *vc;
+	struct virtqueue *vq;
+	int ret;
+
+	vc = devm_kzalloc(&vdev->dev, sizeof(*vc), GFP_KERNEL);
+	if (!vc)
+		return -ENOMEM;
+
+	mutex_init(&vc->lock);
+	vc->vdev = vdev;
+
+	vq = virtio_find_single_vq(vdev, virtio_cpufreq_vq_cb, "requests");
+	if (IS_ERR(vq))
+		return PTR_ERR(vq);
+
+	vc->vq = vq;
+	vdev->priv = vc;
+	virtio_cpufreq_dev = vc;
+	virtio_device_ready(vdev);
+
+	ret = cpufreq_register_driver(&virtio_cpufreq_driver);
+	if (ret) {
+		vdev->config->del_vqs(vdev);
+		virtio_cpufreq_dev = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void virtio_cpufreq_remove(struct virtio_device *vdev)
+{
+	cpufreq_unregister_driver(&virtio_cpufreq_driver);
+	virtio_cpufreq_dev = NULL;
+	vdev->config->del_vqs(vdev);
+}
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_CPUFREQ, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_cpufreq_virtio_driver = {
+	.driver.name	= DRV_NAME,
+	.driver.owner	= THIS_MODULE,
+	.id_table	= id_table,
+	.probe		= virtio_cpufreq_probe,
+	.remove		= virtio_cpufreq_remove,
+};
+
+static int __init virtio_cpufreq_mod_init(void)
+{
+	return register_virtio_driver(&virtio_cpufreq_virtio_driver);
+}
+
+static void __exit virtio_cpufreq_mod_exit(void)
+{
+	unregister_virtio_driver(&virtio_cpufreq_virtio_driver);
+}
+
+module_init(virtio_cpufreq_mod_init);
+module_exit(virtio_cpufreq_mod_exit);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio cpufreq frontend");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index f9056af0c622..f7e357f3bf94 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_CPUFREQ		42 /* virtio cpufreq */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
 #define VIRTIO_ID_MEDIA			48 /* virtio media */
 
-- 
2.34.1

