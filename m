Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD54449ED7
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544337; cv=fail; b=t3qV7zWvCiQ0lKaKRvApQH5vUQmQh9R8QQKf8FPK1v7dUPX32NE8QKCErWy0OBWYEOh7Y/mTdEfmrSpw0snO0m18hUNPP/VMZxekTH6i+Snz2UDnEXgbjEwR2m0YCLsFK/PqhMmlSe0yIsJt1kYHD6IMvpTyLPAExLkxg/CdSSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544337; c=relaxed/simple;
	bh=+FkC2O0gCS+Jd3CHcgjNiBVpaHC2IckKsnef2WA0niE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KavXGUjozTT1/LBl2RZX/qsVIWVB4N6Flm+168hUDwxe0/Yh7lNj7Fc6GhhH+pJKz1YOvOlUcmjJ7XZSomYHb75yaKUBuhle0KXqjvuSzDMr1/rMqae9dN7esQn0t/MLm6Nu0O8D/cDQRnwJ9pNol+R73qglIzFXeD07jhr13pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hbmGK/ju; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hbmGK/ju"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9vvM/Tx18wRQS4HeNh////1ZaK+5bvYWBnVa33CxZz1PjZ9nLUtxpi4Zo/+5uLPAzPhFDg0em8yRNQwU8dPsyYKUEQV1Ienzb09kL71uHr1PnIam47HLiF2SFR/46G1wGG22PueZrhItfEWxnXJ4r/Z4NUDmkYbK71nHFLaLtKPzb6jdHgP+YKfGrUxluRynLQUavNhyKvy65NZZIIt9zg6d1TBWmP1vYjquPOFkdJfL6jD9zKHfmr7MP72hA5jEvDu1y73V+0vHJcdg+4A6z/QuQ70p2mDBw61uUg6LVFOq498f7Qj/cPeKZwowoJpf8GnA2Q1VP8UFde1pQb7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvVxGyWCibblvS3yPRF+QDPZJijdhe+LXGKl+kBu0WQ=;
 b=qT+FfAaR3s1wSDRBmcxFn6t8Zqe2ve66n9eiAFVKe0jnqVSAq+Yu4HgUOu/Eh4VHOPVHOwLfX8Vb8EhtBwYU130tbew2OgrTBjyawX3ol3Qv02WBytiqU17ZxIKFevV8xeV3ubCscJWMa13I3u9f3E18aAedIdpF87YyXnUqrXAzhEoHYMDkjaqGujsW2DF7KSEm0HxxyaKrLKFYEfw8agOtZ84+7uTyY3YN89JD2G9EYY6r+0z1YUDyjS6Hs3EQr9nGv1csiCrXGMrFXF0Gy3Y9TU2cvDs7rco90iVxnmeJDzw3g2k8iybujkU70JLnvvQWgxJOrj+sW+nK6jdJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvVxGyWCibblvS3yPRF+QDPZJijdhe+LXGKl+kBu0WQ=;
 b=hbmGK/juVB3pL1ZYpbjJsedLltJboPqlzJ+ZYr+WJtPziL6872Hk0bKoL9aw/HaXi5Oif1hbIzmADHrigm53dsPgM1s51jDSrWVBVpXje45wObb7yeunf+rOtaHhj22PpY/pZcuKcPWQ8vh4clLb3UplgrlMS0zxUdDqjoLSmMY=
Received: from CH2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:610:59::35)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 07:38:43 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::22) by CH2PR03CA0025.outlook.office365.com
 (2603:10b6:610:59::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 07:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 07:38:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 02:38:42 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 02:38:40 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saravanak@kernel.org>,
	<mst@redhat.com>, <jasowangio@gmail.com>, <eperezma@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>, Baorui.Liu
	<baorliu@amd.com>
Subject: [RFC PATCH 1/1] cpufreq: virtio: add driver to report host frequency to guests
Date: Wed, 16 Sep 2026 15:37:35 +0800
Message-ID: <20260916073735.541-2-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 31803f02-bd4f-41d3-a6be-08df13c588c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sFAN1FyJSfL0GcxFp62Dt1zcS74A+S9Jy/pUrRXMTVZGhLaVQlpD6LrWGx+x/JB6IopFd3jpnXDLaNwLQTfbRVh5IxvOne7Co8xuciPu1dI0QfuKQMv8uQabUmlQaZ75+QUUkTFqfiMAufRD3Xdo6CW4VuLqgIc5j7WHKVqSJSVRwOcqfFb8Gk/BSTU7eikfmk9ICiScznzL1Zy2M9kYa+mniy0dILZzuXbUZ7i2D9yqCXcxULLQF9DIPNFt3jwc50vIEE/gDFaL1xLNfWJuCj7QjhGASyPYfscKBTVEUc2Up7EsCML+EZTI5+k1WdTXLUvhfmQbSJEklUkyVm72DY3SIEX6TK67FMUC5sjTdHnfjhRbAFvP+6ubn9HIf9gf6l3Y2wGzWRcgNzxqptM2/BMTvbwPDWWalYDcd6oDj2N+7/h/htWy6vtAXLW4X0Ah+9QAJaT0cFxWOB4WZnugmJQbBKaFq+T4o8x7j6Hiaft8QmrTsda7lt31tOHzosgNzCQKvWrtVwcbPY6IXyjDDDfbq2CKQ+FgQThL7qmBQJstjD3h4cj8JQqSHfOn/zx3G6h6Ye1NNQAWdIRIShtWHsiX+/osM774aZ+l0PghQq+hc1XeQhvkZLJLG9bWprH1x/oolvP8qlm/+6MjbzIz5KKmqOgrcNzodoqWJfA3OsxQhflpq5yDbpO67Tzw5pV8XqdjNnciJzLkN5lRAGvWAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Szf7pmUXnXXOJTjRWCeVGl7kD5JEpMcy1HtChHsWF4mjp+YkB4sG9apqBPAjzRGcooiTgbu0DIo4p9a9IrtuSnHCQ/gt8n4ZuTtpd0+4w2FbxQ4oobTsEQHPRCrOc5QbP/HRdCoU+re89ra3DauAX5eppMZ+zW5HFtdtCBZURwxeMrK7xwsSTvIiYEApOXcOmQ//Ovwc5QHYptZUCqqfBCCufI1L6+eDPL1ob2fa51Y3DVoZCfSolCvUFyP1F5d+OJnwQS+dVTPDlj8+tLmBdOON+p3Q9OmY1JQOx72c+xGlaWK7QseroLJOq9wCeuOtxnwRES++7enlmfqv0nC0pzOfqu9HVzWb+GaIyy8AyIzCQpmw8Lz6a4k0IdVcpIwnvkbdECP2FEhg5Awss4vVSqhzll4pL7aYoUrms4XD4x8uCPURRzCPFCz/2t+ZE8i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:38:43.3354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31803f02-bd4f-41d3-a6be-08df13c588c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205

Some virtualization stacks pin each vCPU to a pCPU. Guest software
still needs the current host frequency for energy accounting, but
the guest cannot access host sysfs.

Add a virtio frontend that queries the host for the frequency of
the mapped pCPU and exposes it through the cpufreq .get() callback.
Frequency tables are placeholder OPPs; the driver does not change
the physical frequency.

RFC: virtio device id 42 is not allocated by the virtio spec yet.
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 drivers/cpufreq/Kconfig          |  14 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/virtio-cpufreq.c | 235 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h  |   1 +
 4 files changed, 251 insertions(+)
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
index 000000000000..23fde862a313
--- /dev/null
+++ b/drivers/cpufreq/virtio-cpufreq.c
@@ -0,0 +1,235 @@
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
+static struct cpufreq_driver virtio_cpufreq_driver = {
+	.name		= DRV_NAME,
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.init		= virtio_cpufreq_init_policy,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= virtio_cpufreq_target_index,
+	.get		= virtio_cpufreq_get,
+	.attr		= cpufreq_generic_attr,
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

