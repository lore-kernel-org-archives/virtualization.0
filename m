Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD44AA1FB
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266177; cv=none; b=MxV+hK8R4GTxk/g+oanishB9hbyjDccmsr0KAMP0fn3CldDuO/11utccne++Y/++2oDh/ZJR1hLEJdlnrWvqVdQkECwM/hHP74HOb4cp7ZdAAVwOVsRFiS505IadHsBTbgBUgt66RGPu1O3oNLKv8T0Bye6cNlCXc5c8+6JpSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266177; c=relaxed/simple;
	bh=JVNoDa36ZUq4h5v6V/7FJGEvJhRQd4uDwAiFlkzHP/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBRE9YMRrRvD9vwSOoCf1TRP5VFlAC/nGm//lb4cObvybuDb38Lkl213r0LVngrb8xgCjBjLaPU8Z+vnf+YdM+jlwaYjdYBvrKggHuCpmpigubXx9740NdMeSMZURfT58eE9WCyQATtnWZ138+XnjomMJtd2WpSQAJJEXucrFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gn7N7C4Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fIXXH7WP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gn7N7C4Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fIXXH7WP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFee2T3605100
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mglXxo1pYWw
	zuOt97qZ4yF19yEeGDDvj2TJ71dmGgJU=; b=gn7N7C4ZYwdNt9pvi11VVcM3qYz
	a17nG6hWPkCtST1lfwc3qkFGKWvFBP316GjgKu5QlDZzTFchBSJyFxFmlzRdw0dd
	hWJibTTSMx7HomDG2dlbX0RM1g+Kjd4pumFu+mTn+ZjiiHYoYfXZ7BdHRTsK9XN4
	9gdUNbIasJnuK43wWUhbDYfM209ILSer3DpecLK5dL6flyhu7IJgXIwxVNl5PCty
	OxK4qAreuX+uMA1yxUduSFyuu92gPUZB/Ssbve3hLapikpnyRlYtHw/zZArzaOUq
	se6cjgUDSGHsNkoUYp9yXC1IDbuXQfUDXNLpEojfxMuvZPlBEZglyHcE7bw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1rahjrk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:34 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e9e2deaa4so7584241.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790266173; x=1790870973; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mglXxo1pYWwzuOt97qZ4yF19yEeGDDvj2TJ71dmGgJU=;
        b=fIXXH7WPsiWn+nEEq7e+7omjE/clXZ8w4KlTuKuFNBkXpSHNfFTjBcUSZZBynlmFiv
         FpH2v1MYbDmbMBzb8qPktPenw+0sFf80ys75aAy5m19WWWYanPJoolrFia21BSQxH5A8
         nG3S1Pn9afrNIAaop73wH7j66U36cz5yiMdlzeiCOuoJQn7isEPcKpSxoBins1AliXJI
         IYXAOEVuln4Jj6+V26HEHqB3mjYs+Zg/XQL6OpnTxiLe/v2DkwJEyVU1ErxrOjHdyYBI
         O6xAZWF8LTSqz6DSEaJZgHPfOipGtZKkISJTx2PW940RdjzWQJGfQQH6fVUKw56gC22P
         9X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266173; x=1790870973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mglXxo1pYWwzuOt97qZ4yF19yEeGDDvj2TJ71dmGgJU=;
        b=cLOj7L2MVMA87jenxzuFAnGpIYcqOFhJk7bKrlL96zj8XRqfecDk6sXXKHnmk5g9WA
         hMUHVpmOWUMUhARfVEOAGscZumk3z3CUAWN9W3U92togWWYxM/9NTyb5t+AYL6r8MQs1
         doIvMQWkQ1k6OLbGxzdVcUr4oudn8CBOuOItZ8Pmw0XrAN1YyAgXke/VA3uLMVnl+zGS
         +XYoyCJ1u6I2+NBK2S82KyAAPECmph6L85W+49tJu2nog1J6yNPBpfjYA126S3IHI0Gm
         N5qaMJL1VEMe+CihF1s/n+8OZAxMo8rk9pDHnEzR96GrnyjEq8QMXysiDaThaqRfou54
         ci5g==
X-Gm-Message-State: AFuF++lfxANRXn0eJb1V5tzy6kp1n8lXM/dkuBn2q0qgV2ognVw3eOIB
	YHOfhDFR3PwAYCxzm5L4jZU85OslNOUmDJWHSJT6ZUwxFd8IJZmHOfr/hGfxwk6EacKEqf4eKVg
	4vl5BP36+IDyrdO7aAMdmRsoCs9d5x8qPmxo8lI9DStiDPsnnHg773s2q7JBrjalGws3nPg==
X-Gm-Gg: AYBFou2FojM4O6W2pDzf51Qo9cKJ7YW63vBlOcBBtSYpxiYBR0iznpUg+v8/UEn42cr
	B3llGwTVYIRQjuUTbo/8NJhnbCSK6deAnGGlP1MDgoJheqXKEEf/RsF/JkxTxFAFuVxWdapexvq
	yKKmDSoD3Qy18XprWccEicByG/Bx9e+26TKmuVZsOO79dRGJUjc1UJdXutsL0UeoLQc0fJrKhZ5
	3kzZ0y9tI2Ik+auYCeAllExJOlTnqcZN8B6IfOruOusoonwjDJ0cz9jBQgQ8eegIkhnxswzehCz
	hW6qchRDZhCQi8NM8JPWNguNPTyBnTRUnR/ji49kBsNw/TrTEL5RMaURv6lOxQnDQPgiW90wf65
	FPmN5CajmXa0N/dv3+5OcUfoCgzhdQqg=
X-Received: by 2002:a05:6102:3706:b0:7a3:ff5b:ef2d with SMTP id ada2fe7eead31-7af1e6f368bmr1596752137.24.1790266172959;
        Thu, 24 Sep 2026 09:09:32 -0700 (PDT)
X-Received: by 2002:a05:6102:3706:b0:7a3:ff5b:ef2d with SMTP id ada2fe7eead31-7af1e6f368bmr1596730137.24.1790266172355;
        Thu, 24 Sep 2026 09:09:32 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5c4csm328306766b.18.2026.09.24.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:09:31 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 1/8] virtio-usb: add protocol header and skeleton dual-role driver
Date: Thu, 24 Sep 2026 18:09:00 +0200
Message-ID: <20260924160907.145405-2-igor.skalkin@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfXxxwdC+Mdpltp
 FGvaTx96q8zkEsxDNg4zAgv8N2saQwR2DS39sNZPU3GtKZWqcrQnrr1vSbetdhPNGn72r+RxAme
 OXPyRibGPIYp/NLMOYOLeFs9QEsEgIQBs/ebIX9zhYdT23T9hU6YmGztoNMxo6mE+eeFv9/W+Bz
 0OzdNFblGRografwMzdDEe8h4qgUTFmXfGa8EHZTFuiFSEOVrP/AkvhsgrovKG822YVSKVjTMEI
 H4wobwcQ/1xyRt17HSuiTovv/FgBOc6KuUShjMCj8ygtz+Yk07Pz5T4dHgiDybhJOS95l7f2c3H
 oVSnQnqMfNySYaRVZB4qDERdhBUiEELIsB902qc5wuFrzlATdtuqDvA8Y4ATFYryURxk2CkWS7f
 JWmEMv1b2QJexV1mA/b20uad378im+mPKbaxPLKAMjbSHCEO++35mmdfJn/wrBNs4N3lTv+mow4
 qi4atPSA9dblbJo1t2Q==
X-Proofpoint-ORIG-GUID: Pyc9MTRJH78b_EJWnWUsuK02iS8GeI9F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX+cpv3zTYtmbk
 ShxW8nwG6v5SKkb6nki0aNOggbYLtjRqd+FecPjmm88/lZdsOqt47CAHKPbtbzY40nHDgm/JApG
 JGD+dqBLnWtKyEyY1lEetWFselV7eg8=
X-Authority-Analysis: v=2.4 cv=fvpJ914f c=1 sm=1 tr=0 ts=6ab54b3e cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=ISgsD1N0DMwXzmNTllcA:9 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: Pyc9MTRJH78b_EJWnWUsuK02iS8GeI9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240066

From: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>

Add the virtio_usb device and virtqueue-wrapper skeleton, the
protocol header shared with the vhost gadget driver and userspace
backend, and probe()/remove() plumbing with no role support yet.

Introduce a per-port virtio_usb_port array (vports[]), sized to the
device's negotiated port count, ahead of any code that actually
populates or reads it. Every later commit that adds a role to a port
(host, device, OTG) builds on this same array from the start, instead
of the host, device, and OTG subsystems each growing their own
separate port-indexed storage that later has to be reconciled.

Wire the new drivers/usb/virtio_usb/ directory into the USB
subsystem's build (drivers/usb/Kconfig, drivers/usb/Makefile) as a
new CONFIG_USB_VIRTIO option, listed alongside the other USB
dual-mode controller drivers.

Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
---
 MAINTAINERS                         |   10 +
 drivers/usb/Kconfig                 |    2 
 drivers/usb/Makefile                |    1 
 drivers/usb/virtio_usb/Kconfig      |   21 ++
 drivers/usb/virtio_usb/Makefile     |    5 
 drivers/usb/virtio_usb/controller.c |  155 ++++++++++++++++++
 drivers/usb/virtio_usb/controller.h |   84 ++++++++++
 include/uapi/linux/virtio_usb.h     |  302 ++++++++++++++++++++++++++++++++++++
 8 files changed, 580 insertions(+)
 create mode 100644 drivers/usb/virtio_usb/Kconfig
 create mode 100644 drivers/usb/virtio_usb/Makefile
 create mode 100644 drivers/usb/virtio_usb/controller.c
 create mode 100644 drivers/usb/virtio_usb/controller.h
 create mode 100644 include/uapi/linux/virtio_usb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..93869e5f4b51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28450,6 +28450,16 @@ F:	drivers/media/usb/uvc/
 F:	include/linux/usb/uvc.h
 F:	include/uapi/linux/uvcvideo.h
 
+USB VIRTIO DRIVER
+M:	Igor Skalkin <igor.skalkin@oss.qualcomm.com>
+R:	Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
+R:	Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>
+L:	linux-usb@vger.kernel.org
+L:	virtualization@lists.linux.dev
+S:	Maintained
+F:	drivers/usb/virtio_usb/
+F:	include/uapi/linux/virtio_usb.h
+
 USB WEBCAM GADGET
 L:	linux-usb@vger.kernel.org
 S:	Orphan
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index abf8c6c..68076db 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -139,6 +139,8 @@ source "drivers/usb/chipidea/Kconfig"
 
 source "drivers/usb/isp1760/Kconfig"
 
+source "drivers/usb/virtio_usb/Kconfig"
+
 comment "USB port drivers"
 
 if USB
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index eecbd63..f28a4b7 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_USB_SUPPORT)	+= phy/
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 obj-$(CONFIG_USB_DWC2)		+= dwc2/
 obj-$(CONFIG_USB_ISP1760)	+= isp1760/
+obj-$(CONFIG_USB_VIRTIO)	+= virtio_usb/
 
 obj-$(CONFIG_USB_CDNS_SUPPORT)	+= cdns3/
 
diff --git a/drivers/usb/virtio_usb/Kconfig b/drivers/usb/virtio_usb/Kconfig
new file mode 100644
index 0000000..bd377b9
--- /dev/null
+++ b/drivers/usb/virtio_usb/Kconfig
@@ -0,0 +1,21 @@
+config USB_VIRTIO
+	tristate "Virtio USB device support"
+	depends on USB_SUPPORT && VIRTIO
+	depends on USB || USB_GADGET
+	depends on USB if !USB_GADGET
+	depends on USB_GADGET if !USB
+	select USB_ROLE_SWITCH
+	help
+	  Say Y here if you want to support a virtio-usb device: a virtio
+	  transport for USB that can present itself to the guest as a USB
+	  host controller, a USB device controller (UDC), or both, with
+	  each port independently configurable and, on ports where the
+	  virtio-usb device advertises support for it, capable of
+	  switching between the host and device role at runtime (USB
+	  OTG-style role switching), backed by the standard USB Role
+	  Switch class.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called virtio-usb.
+
+	  If unsure, say N.
diff --git a/drivers/usb/virtio_usb/Makefile b/drivers/usb/virtio_usb/Makefile
new file mode 100644
index 0000000..b7ee9e8
--- /dev/null
+++ b/drivers/usb/virtio_usb/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+virtio-usb-y := controller.o
+
+obj-$(CONFIG_USB_VIRTIO) += virtio-usb.o
diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb/controller.c
new file mode 100644
index 0000000..2fc6f50
--- /dev/null
+++ b/drivers/usb/virtio_usb/controller.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio_usb: VirtIO USB device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/module.h>
+#include <uapi/linux/virtio_ids.h>
+
+#include "controller.h"
+
+/**
+ * virtio_usb_find_vqs() - Enumerate and initialize all virtqueues.
+ * @vusb: VirtIO usb device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_find_vqs(struct virtio_usb *vusb)
+{
+	unsigned int nvqs = vusb->nvqs, i;
+	struct virtqueue **vqs = NULL;
+	int rc = -ENOMEM;
+
+	vqs = kcalloc(nvqs, sizeof(void *), GFP_KERNEL);
+	if (!vqs)
+		return -ENOMEM;
+
+	struct virtqueue_info *vqs_info =
+		kcalloc(nvqs, sizeof(*vqs_info), GFP_KERNEL);
+	if (!vqs_info) {
+		rc = -ENOMEM;
+		goto on_exit;
+	}
+	for (i = 0; i < nvqs; i++) {
+		vqs_info[i].name = vusb->vqueues[i].name;
+		vqs_info[i].callback = vusb->vqueues[i].callback;
+	}
+	rc = virtio_find_vqs(vusb->vdev, nvqs, vqs, vqs_info, NULL);
+
+	kfree(vqs_info);
+
+	for (i = 0; i < nvqs; i++) {
+		vusb->vqueues[i].vqueue = vqs[i];
+		spin_lock_init(&vusb->vqueues[i].lock);
+	}
+on_exit:
+	kfree(vqs);
+	return rc;
+}
+
+/**
+ * virtio_usb_validate() - Validate if the device can be started.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL on failure.
+ */
+static int virtio_usb_validate(struct virtio_device *vdev)
+{
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "configuration access disabled\n");
+		return -EINVAL;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev,
+			"device does not comply with spec version 1.x\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * virtio_usb_probe() - Probe VirtIO usb controller.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_probe(struct virtio_device *vdev)
+{
+	struct virtio_usb *vusb;
+	unsigned int nvqs = 0;
+	int rc = 0;
+
+	vusb = devm_kzalloc(&vdev->dev, sizeof(*vusb), GFP_KERNEL);
+	if (!vusb)
+		return -ENOMEM;
+
+	vusb->vdev = vdev;
+	vdev->priv = vusb;
+
+	virtio_cread_le(vdev, struct virtio_usb_config, ports, &vusb->nports);
+
+	vusb->vports = devm_kcalloc(&vdev->dev, vusb->nports,
+				    sizeof(*vusb->vports), GFP_KERNEL);
+	if (!vusb->vports)
+		return -ENOMEM;
+
+	vusb->vqueues = devm_kcalloc(&vdev->dev, nvqs, sizeof(*vusb->vqueues),
+				     GFP_KERNEL);
+	if (!vusb->vqueues)
+		return -ENOMEM;
+
+	vusb->nvqs = nvqs;
+
+	rc = virtio_usb_find_vqs(vusb);
+	if (rc)
+		goto on_exit;
+
+	virtio_device_ready(vdev);
+
+on_exit:
+	return rc;
+}
+
+/**
+ * virtio_usb_remove() - Remove VirtIO usb device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ */
+static void virtio_usb_remove(struct virtio_device *vdev)
+{
+	struct virtio_usb *vusb = vdev->priv;
+	int i;
+
+	virtio_reset_device(vdev);
+	for (i = 0; i < vusb->nvqs; i++)
+		vusb->vqueues[i].stop(vusb, &vusb->vqueues[i]);
+
+	vdev->config->del_vqs(vdev);
+}
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_USB, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_usb_driver = {
+	.driver.name = KBUILD_MODNAME,
+	.id_table = id_table,
+	.validate = virtio_usb_validate,
+	.probe = virtio_usb_probe,
+	.remove = virtio_usb_remove,
+};
+
+module_virtio_driver(virtio_usb_driver);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Dual-role virtio-usb controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/virtio_usb/controller.h b/drivers/usb/virtio_usb/controller.h
new file mode 100644
index 0000000..eb07d0b
--- /dev/null
+++ b/drivers/usb/virtio_usb/controller.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * virtio-usb: Virtio usb device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef VIRTIO_USB_CONTROLLER_H
+#define VIRTIO_USB_CONTROLLER_H
+
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+
+#include <uapi/linux/virtio_usb.h>
+
+/**
+ * struct virtio_usb_port - Per-virtual-port state.
+ * @role: Role of this port (VIRTIO_USB_ROLE_HOST or _DEVICE), once a
+ *        role-providing commit has assigned it. Unused for now - this
+ *        struct is deliberately introduced ahead of any code that
+ *        populates or reads @role, so that every later commit that adds
+ *        a role (host, device, OTG) can build on this same per-port
+ *        array from the start instead of each reinventing its own
+ *        port-indexed storage.
+ */
+struct virtio_usb_port {
+	unsigned int role;
+};
+
+/**
+ * struct virtio_usb - VirtIO USB device.
+ * @vdev: Underlying virtio device
+ * @vqueues: Array of virtqueue wrappers.
+ * @vports: Array of per-port structures, one entry per virtual port.
+ * @nports: number of supported ports
+ * @nvqs: number of virtqueues for the device
+ */
+struct virtio_usb {
+	struct virtio_device *vdev;
+	struct virtio_usb_queue *vqueues;
+	struct virtio_usb_port *vports;
+	unsigned int nports;
+	u32 nvqs;
+};
+
+/**
+ * struct virtio_usb_queue - Virtqueue wrapper structure.
+ * @name: Name of the virtqueue.
+ * @callback: Used to synchronize access to a virtqueue.
+ * @vqueue: Underlying virtqueue.
+ * @lock: Used to synchronize access to a virtqueue.
+ * @process: queue process callback function
+ * @stop: queue stop callback function
+ */
+struct virtio_usb_queue {
+	const char *name;
+	vq_callback_t *callback;
+	struct virtqueue *vqueue;
+	spinlock_t lock;
+	void (*process)(struct virtio_usb *vusb, void *buf);
+	void (*stop)(struct virtio_usb *vusb, struct virtio_usb_queue *vq);
+};
+
+/**
+ * struct virtio_usb_vq_desc - Read-only virtqueue template.
+ * @name: Name of the virtqueue.
+ * @callback: Virtqueue notification callback function.
+ * @process: queue process callback function.
+ * @stop: queue stop callback function.
+ *
+ * Immutable per-role virtqueue description, copied into a fresh
+ * per-instance struct virtio_usb_queue during probe() instead of being
+ * shared directly - so that multiple probed virtio_usb instances never
+ * alias the same struct virtqueue.
+ */
+struct virtio_usb_vq_desc {
+	const char *name;
+	vq_callback_t *callback;
+	void (*process)(struct virtio_usb *vusb, void *buf);
+	void (*stop)(struct virtio_usb *vusb, struct virtio_usb_queue *vq);
+};
+
+#endif /* VIRTIO_USB_CONTROLLER_H */
diff --git a/include/uapi/linux/virtio_usb.h b/include/uapi/linux/virtio_usb.h
new file mode 100644
index 0000000..b9dc448
--- /dev/null
+++ b/include/uapi/linux/virtio_usb.h
@@ -0,0 +1,302 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_USB_H
+#define _UAPI_LINUX_VIRTIO_USB_H
+
+#include <linux/virtio_types.h>
+
+/*****************************************************************************
+ * FEATURE BITS
+ */
+enum {
+	/* Host controller is supported */
+	VIRTIO_USB_F_HOST = 0,
+	/* Device controller is supported */
+	VIRTIO_USB_F_DEVICE,
+	/* Role switching is supported */
+	VIRTIO_USB_F_SWITCH_ROLE,
+};
+
+/*****************************************************************************
+ * CONFIGURATION SPACE
+ */
+struct virtio_usb_config {
+	/* # of available ports */
+	__le32 ports;
+};
+
+/*****************************************************************************
+ * COMMON DEFINITIONS
+ */
+enum {
+	VIRTIO_USB_VQ_HOST_COMMAND = 0,
+	VIRTIO_USB_VQ_HOST_EVENT,
+	VIRTIO_USB_VQ_HOST_DATA,
+	VIRTIO_USB_VQ_DEV_COMMAND,
+	VIRTIO_USB_VQ_DEV_EVENT,
+	VIRTIO_USB_VQ_DEV_DATA,
+	VIRTIO_USB_VQ_OTG_COMMAND,
+	VIRTIO_USB_VQ_OTG_EVENT,
+	VIRTIO_USB_VQ_MAX,
+};
+
+enum {
+	VIRTIO_USB_EP_CONTROL = 0,
+	VIRTIO_USB_EP_INTERRUPT,
+	VIRTIO_USB_EP_BULK,
+	VIRTIO_USB_EP_ISOCHRONOUS,
+};
+
+enum {
+	VIRTIO_USB_S_OK = 0,
+	VIRTIO_USB_S_ERR_BAD_MSG,
+	VIRTIO_USB_S_ERR_INTERNAL,
+	VIRTIO_USB_S_ERR_NO_DEVICE,
+	VIRTIO_USB_S_ERR_ISO_XFER,
+	VIRTIO_USB_S_ERR_ISO_BIG,
+	VIRTIO_USB_S_ERR_DATA_IN,
+	VIRTIO_USB_S_ERR_DATA_OUT,
+	VIRTIO_USB_S_ERR_MSG_SIZE,
+	VIRTIO_USB_S_ERR_OVERFLOW,
+	VIRTIO_USB_S_ERR_STALL,
+	VIRTIO_USB_S_ERR_SHORT_PKT,
+	VIRTIO_USB_S_ERR_CANCELLED,
+	VIRTIO_USB_S_ERR_HOST,
+};
+
+struct virtio_usb_cmd_status {
+	__le32 code; /* VIRTIO_USB_S_XXX */
+};
+
+/*****************************************************************************
+ * HOST COMMAND MESSAGES
+ */
+enum {
+	VIRTIO_USB_CMD_HOST_CANCEL = 0,
+	VIRTIO_USB_CMD_HOST_STREAMS_ALLOC,
+	VIRTIO_USB_CMD_HOST_STREAMS_FREE,
+};
+
+struct virtio_usb_host_cmd_hdr {
+	__le32 code; /* VIRTIO_USB_CMD_HOST_XXX */
+	__le32 port; /* Port ID */
+};
+
+/* VIRTIO_USB_CMD_HOST_CANCEL */
+struct virtio_usb_host_cmd_cancel {
+	struct virtio_usb_host_cmd_hdr hdr;
+	__le64 tag;
+};
+
+/* VIRTIO_USB_CMD_HOST_STREAMS_ALLOC/FREE */
+struct virtio_usb_host_cmd_streams {
+	struct virtio_usb_host_cmd_hdr hdr;
+	__le32 number_of_streams;
+	__le32 number_of_eps;
+};
+
+/*****************************************************************************
+ * HOST EVENT MESSAGES
+ */
+enum {
+	VIRTIO_USB_EVT_HOST_PORT_CONNECTED = 0,
+	VIRTIO_USB_EVT_HOST_PORT_DISCONNECTED,
+};
+
+/* VIRTIO_USB_EVT_HOST_PORT_CONNECTED/DISCONNECTED */
+enum {
+	VIRTIO_USB_SPEED_UNKNOWN = 0,
+	VIRTIO_USB_SPEED_LOW,
+	VIRTIO_USB_SPEED_FULL, /* usb 1.1 */
+	VIRTIO_USB_SPEED_HIGH, /* usb 2.0 */
+	VIRTIO_USB_SPEED_WIRELESS, /* wireless (usb 2.5) */
+	VIRTIO_USB_USB_SPEED_SUPER, /* usb 3.0 */
+	VIRTIO_USB_SPEED_SUPER_PLUS, /* usb 3.1 */
+};
+
+struct virtio_usb_host_port_event {
+	__le32 code; /* VIRTIO_USB_EVT_HOST_PORT_XXX */
+	__le32 port_id;
+	__le32 speed; /* VIRTIO_USB_SPEED_XXX */
+	__le32 padding;
+};
+
+/*****************************************************************************
+ * DEVICE COMMAND MESSAGES
+ */
+enum {
+	VIRTIO_USB_CMD_DEV_GET_ENDPOINT_COUNT = 0,
+	VIRTIO_USB_CMD_DEV_GET_ENDPOINT_INFO,
+	VIRTIO_USB_CMD_DEV_PULLUP,
+	VIRTIO_USB_CMD_DEV_VBUS_DRAW,
+	VIRTIO_USB_CMD_DEV_EP_ENABLE,
+	VIRTIO_USB_CMD_DEV_EP_DISABLE,
+	VIRTIO_USB_CMD_DEV_EP_SET_HALT,
+	VIRTIO_USB_CMD_DEV_EP_SET_WEDGE,
+	VIRTIO_USB_CMD_DEV_CANCEL,
+};
+
+struct virtio_usb_dev_cmd_hdr {
+	__le32 code; /* VIRTIO_USB_CMD_DEV_XXX */
+	__le16 port; /* Port ID */
+	__le16 endpoint; /* Endpoint ID */
+};
+
+/* VIRTIO_USB_CMD_DEV_GET_ENDPOINT_COUNT */
+struct virtio_usb_dev_cmd_ep_count {
+	struct virtio_usb_cmd_status status;
+	__le32 count; /* # of supported endpoints */
+};
+
+enum {
+	VIRTIO_USB_DIR_OUT = 0,
+	VIRTIO_USB_DIR_IN,
+};
+
+enum {
+	VIRTIO_USB_EP_DIR_OUT = 0,
+	VIRTIO_USB_EP_DIR_IN = 0x80,
+};
+
+/**
+ * VIRTIO_USB_CMD_DEV_GET_ENDPOINT_INFO
+ *
+ * Response:
+ *     struct virtio_usb_cmd_status
+ *     struct virtio_usb_dev_cmd_ep_info [count]
+ */
+struct virtio_usb_dev_cmd_ep_info {
+	__le16 types; /* supported type bit map (1 << VIRTIO_USB_EP_XXX) */
+	__le16 directions /* supported direction bit map (1 << VIRTIO_USB_DIR_XXX) */;
+	__le16 maxpacket_limit;
+	__le16 max_streams;
+};
+
+/*******************************************************************************
+ * DEVICE EVENT MESSAGES
+ */
+enum {
+	VIRTIO_USB_EVT_DEV_CONNECTED = 0,
+	VIRTIO_USB_EVT_DEV_DISCONNECTED,
+	VIRTIO_USB_EVT_DEV_SETUP,
+	VIRTIO_USB_EVT_DEV_RESET,
+	VIRTIO_USB_EVT_DEV_SUSPEND,
+	VIRTIO_USB_EVT_DEV_RESUME,
+};
+
+struct virtio_usb_dev_event {
+	__le32 code; /* VIRTIO_USB_EVT_DEV_XXX */
+	__u8 padding[12];
+};
+
+/* VIRTIO_USB_EVT_DEV_SETUP */
+struct virtio_usb_dev_setup_event {
+	__le32 code; /* VIRTIO_USB_EVT_DEV_SETUP */
+	__u8 setup[8]; /* setup packet contents */
+	__u8 padding[4];
+};
+
+/*******************************************************************************
+ * HOST/DEVICE DATA MESSAGES
+ */
+enum {
+	VIRTIO_USB_FLAG_SHORT_NOT_OK = (1 << 0),
+	VIRTIO_USB_FLAG_ISO_ASAP = (1 << 1),
+	VIRTIO_USB_FLAG_ZERO_PACKET = (1 << 2),
+};
+
+struct virtio_usb_request {
+	__le64 tag;
+	__le16 port; /* Port ID */
+	__le16 endpoint; /* Endpoint ID */
+	__le16 transfer_type; /* VIRTIO_USB_EP_XXX */
+	__le16 transfer_flags; /* VIRTIO_USB_FLAG_XXX */
+	union {
+		/* transfer_type = VIRTIO_USB_EP_CONTROL */
+		struct {
+			__u8 setup[8];
+		} control;
+		/* transfer_type = VIRTIO_USB_EP_INTERRUPT */
+		struct {
+			__le32 interval;
+		} interrupt;
+		/* transfer_type = VIRTIO_USB_EP_BULK */
+		struct {
+			__le32 stream_id;
+		} bulk;
+		/* transfer_type = VIRTIO_USB_EP_ISOCHRONOUS */
+		struct {
+			__le32 interval;
+			__le32 start_frame;
+			__le32 number_of_packets;
+			__le32 padding;
+		} iso;
+	};
+};
+
+struct virtio_usb_response {
+	__le32 status; /* VIRTIO_USB_S_XXX */
+	__le32 actual_length;
+	__le32 interval; /* type = VIRTIO_USB_EP_INTERRUPT/ISOCHRONOUS */
+	__le32 start_frame; /* type = VIRTIO_USB_EP_ISOCHRONOUS */
+};
+
+/**
+ * ISO request:
+ *     struct virtio_usb_request
+ *     struct virtio_usb_iso_packet [number_of_packets]
+ * ISO response:
+ *     struct virtio_usb_response
+ *     struct virtio_usb_iso_status [number_of_packets]
+ */
+struct virtio_usb_iso_packet {
+	__le32 offset;
+	__le32 length;
+};
+
+struct virtio_usb_iso_status {
+	__le32 status; /* VIRTIO_USB_S_XXX */
+	__le32 actual_length;
+};
+
+/*****************************************************************************
+ * OTG COMMAND MESSAGES
+ */
+enum {
+	VIRTIO_USB_CMD_OTG_GET_ROLE = 0,
+	/* If VIRTIO_USB_F_SWITCH_ROLE is negotiated */
+	VIRTIO_USB_CMD_OTG_SWITCH_ROLE,
+};
+
+struct virtio_usb_otg_cmd_hdr {
+	__le32 code; /* VIRTIO_USB_CMD_OTG_XXX */
+	__le32 port; /* Port ID */
+};
+
+/* VIRTIO_USB_CMD_OTG_GET_ROLE */
+enum {
+	VIRTIO_USB_ROLE_HOST = 0,
+	VIRTIO_USB_ROLE_DEVICE,
+};
+
+struct virtio_usb_otg_cmd_role {
+	struct virtio_usb_cmd_status status;
+	__le32 role; /* VIRTIO_USB_ROLE_XXX */
+};
+
+/*****************************************************************************
+ * OTG EVENT MESSAGES
+ */
+enum {
+	VIRTIO_USB_EVT_OTG_CHANGE_ROLE = 0,
+};
+
+struct virtio_usb_otg_event {
+	__le32 code; /* VIRTIO_USB_EVT_OTG_XXX */
+	__le32 port; /* Port ID */
+};
+
+#endif /* _UAPI_LINUX_VIRTIO_USB_H */
