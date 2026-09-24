Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FE4AA1F7
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266187; cv=none; b=XMliCxIuegBZC266H7ehtfYimPlQfD3wTN/BnrmTaJs+duk5Q9bmC7XCxf3EBTS0JZcrUa3hapaXAZ3YAi1ErJ5qNxvbZ86i7jdXmNTsgvzdLVlEMIVITGcePr13AploERfc0+dQhe98cw2maWkURz9wV87CqtugpxiAhJsxufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266187; c=relaxed/simple;
	bh=bKuF7puAisnFQ4uJrGGNIY5aqzE+gBIcZ/zbL2MGg0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rC4A15S09WTkEdjrmyP/e6U1aHJR2tF0+LJeK79hfIf//33J8phsxG2uznx75G4BIbqI7JMa/I7jJEAjSYR3Td8dN1htjg67US2L1HI0AruV1ikdQQ+wcw2BAJNExrmV7snqqSOaLRbXxPuuYD9deSiBgXvI7oM2xzmfc34OTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h0h/zBjo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Am5Bl/68; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h0h/zBjo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Am5Bl/68"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFeQdQ3754787
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OIHNAgrI2h5
	d1yfjoZRHe2lflh7/GuFvs0Lz7TKgC5E=; b=h0h/zBjoKtiVwlWk4TAOxMaD6X9
	C9C0yxi3LhEGLdchgZdGVUp/jimAxWtBGyVBNQa7YdNzqZ73lw632CbTN2d2zROM
	fdb3d4KL5xSht8qN18y1z5q/srfV/r74mBzDc4bPB3I9lX+ow3iKnCikgSHbV/pp
	FuVFuq+1kskf8FskoXb511hf7ES0z6lQ3Pg2cWVHhdLnYw10b7kiS3Cg1XDrwUiM
	6cltrg87HDxmTh2sOD3Ju/L5f7kCtW8lIVvvR/c4CBZ9LAOkl4QPPYxKZwBVKryc
	6XZPJ6pPsaTzGlXm9Mhdk8wBPlBfu9fXUBNNblp55Y/OUNOIv36Ub+4ddQQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstukm7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9806756ea40so7241241.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790266180; x=1790870980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OIHNAgrI2h5d1yfjoZRHe2lflh7/GuFvs0Lz7TKgC5E=;
        b=Am5Bl/681jdQhWxYsmnWNZRA/BzD9Gixswd6+1BAljKAlGL/MiOrinOapd3UJnrHwy
         HL0snSLNMboTOAM/dfi7eg3yMRYI2vbfAxi+8RPVXpvxeZger8Jdhfx/QNWdDYzk3vZL
         LdRvpjR8IOoCZkV+PxXeGjTVkXO+ZrbOYn9TLZRbSZtXgKC7y1hNZN8bFE3aYk5NLd2b
         vLkVOxPLN8yOiYsnt/TEXRuoMf3O+RVvl/On2zP7qNii4QtLE5wsvn/aVw92lRGPipb4
         ZXY7HbBsWVjyi7rLG4lIgB0Cf7aLtE810ib1zYent71ATjlcYyTJjMOmb51PP62tO+Dm
         gysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266180; x=1790870980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OIHNAgrI2h5d1yfjoZRHe2lflh7/GuFvs0Lz7TKgC5E=;
        b=ve4XO3N06/MqVHEbBlvHjQCTVSFLwvVRNlT+NsChsiSWjaNbRku9/9ptGNfby0DUCl
         80vI1tnq7gkcUWGND4e9Bdz8Yp50Pq/0kv/o/QQ/tNbMd75wp2YQXZxyxedGZMBFX+/Q
         H+TDuVuFu0XqZqCtFGBzIyC2eoxn++04FJzs+et5AX7uxUnw3y+zaaqZuq6FB0lb6uJ4
         80LfxbQZv92Sxi2ZmPkx87nKj6TsjsKBc3unLflEr8ZuoTkqcQkdo6W80kZQmGzk5FRR
         NPAZJTqjTERW3TfKvQJ46FwZCi0aodrCCVTlPkS9fG2/hWSkbo6S1TgiHVDwIltAN+LQ
         WsIw==
X-Gm-Message-State: AFuF++lAwo79wTAFh9Rs6cyMrpoorkYButJf/LrPrqtOLKvGdxVowwMO
	9sevt0CtPLNzart6v+dJkrtQzOpS6E44FT17r7b9crnmtjfb0MF1TC3oh8i3EEDG4WGOmZAAp6Y
	Ggkkr7tnfgUNaJbcozETu0I/VyLs+SZ2uHxrq/awJpUvw9SSf50C7NlPnZvEV3f1wbGO6vA==
X-Gm-Gg: AYBFou3KGjYAvwYVoTtMS4V/ZZ1Qb6cPRBthTvFYVaS6Vo80dCxnFXkoQTM4XpL2CSA
	j+FN/0GB5RVrtu03Ux23skd8wfJbOvyxZ3ikgyolLqWC8HHRwUYRCvepp7efJofyoksAz1CU4Zf
	cITim7++QWen6QZnWFYioyYlscfLHjmY03t/bAPSkxkxIAraysygw5j98Zl/FCLEBE1BYpqykIA
	1k02wo/S57OqJ22YlKB6z8Ho+QVhl20O+JLgCo8Fost0MC5xKXOXSCyzkEBXmZjQh1yijZOtbO9
	qu4iDWRoQxDdtImmuATYqvXdkY3EYujO++ryq4Gy0euP2z9tgymd8CvcBNAmW1bQtc/I+f0HrTd
	95q0HDtfzLLn8UgnEmmlcSzaozaqwQs4=
X-Received: by 2002:a05:6102:a50:b0:7a4:ebdb:cc0c with SMTP id ada2fe7eead31-7af1c58faa0mr1597877137.6.1790266178792;
        Thu, 24 Sep 2026 09:09:38 -0700 (PDT)
X-Received: by 2002:a05:6102:a50:b0:7a4:ebdb:cc0c with SMTP id ada2fe7eead31-7af1c58faa0mr1597813137.6.1790266176573;
        Thu, 24 Sep 2026 09:09:36 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5c4csm328306766b.18.2026.09.24.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:09:35 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 2/8] virtio-usb: add host role (USB Host Controller) support
Date: Thu, 24 Sep 2026 18:09:01 +0200
Message-ID: <20260924160907.145405-3-igor.skalkin@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX6ymVnOn/K+Q4
 ShJna52I63M62iY34/onV3v85RY1jUGJy05g2OjUU7ADyFX+bo461HlEn0Fa9ymJ9+ST/T1xc+v
 KcCrf7x+bEw43HHs0D9WgD5egRj+XZ8=
X-Proofpoint-ORIG-GUID: qlQge5mEspAA0l2JXOY6Mt4ECeIVWxRb
X-Proofpoint-GUID: qlQge5mEspAA0l2JXOY6Mt4ECeIVWxRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfXyUJmb1mNe46L
 8/4TmIQ1OEF66NDhjDAYhE+Wiw0mC/R2vhLeV+KJVTGKwLl1yd7kAoauQQym9bQKp7xMY5FnWoV
 g9PlxH9aVPPUQzX3fD1UWhDdT86dKbGxgqs8gci//2C897p+JGb36ytulLDIy18MjEKq7nVAZIs
 EOW5C/uF29Ol8o46xJO+EKiDlY4mLuC+CfqXu+anm3mX1kr256ZXgwowwoCpGKk/K+HOV8r6O6P
 +3xLdwLyjJ55pAEXdfak3fGCTGbl2g2fzlpf3IiDyO6R0zB/ynp4jdA+BzOhyKqzdJh9yB0ontc
 y4T9mTkW1QMSFFDK9W4Xbqe+ZEsq6ssJ5XJimSUSUJd2nnrH4Xfc475Wm7HiM7wJETYIUyQnQte
 h4dTRCzn2L86vE4lPH4y92u7LB2018MLk4TiVdsy/m3e879l5mbcPs/5SVxDy1nvrwSD+UDOsFb
 +C9/kzZG3q691dfpYGg==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab54b45 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=2yJIHOzV08vIsU6lbPcA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

From: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>

Add the common virtqueue handling code (command, event and data
queues) shared by every role, and the virtio-usb host controller
(HCD) implementation, wiring it up as the host role of the dual-role
driver on top of that common code.

Each host-role virtual port gets its own HS+SS usb_hcd pair and its
own root hub (struct virtio_usb_hc_vp), with a fixed
VIRTIO_USB_VP_MAX_PORTS (8) leaf slots pre-allocated at VP init time
and reused across connect/disconnect - never dynamically alloc'd or
freed. This lets the backend forward more than one physical socket -
and, for host ports behind a physical hub, more than one leaf device
per socket - as independent virtual ports from the start, instead of
collapsing everything onto a single shared root hub and having to
revisit that decision once more than one host-role port needs to
exist at the same time.

virtio_usb_add_hcd() derives each VP's HCD bus_name from the parent
virtio_device with devm_kasprintf() rather than a stack buffer, since
usb_create_hcd()/usb_create_shared_hcd() store that pointer as-is in
hcd->self.bus_name without copying it - it must outlive the HCD
itself.

Every port is host-role for now, since no other role exists yet;
vports[].role is populated unconditionally until later commits add
device role and OTG-based role resolution.

Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
Co-developed-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
Signed-off-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
Signed-off-by: Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>
Co-developed-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
---
 drivers/usb/virtio_usb/Makefile     |    4 
 drivers/usb/virtio_usb/controller.c |  105 ++
 drivers/usb/virtio_usb/controller.h |   35 
 drivers/usb/virtio_usb/host.c       | 1335 ++++++++++++++++++++++++++++++++++++
 drivers/usb/virtio_usb/host.h       |  203 +++++
 drivers/usb/virtio_usb/vq_common.c  |  740 +++++++++++++++++++
 drivers/usb/virtio_usb/vq_common.h  |  163 ++++
 include/uapi/linux/virtio_usb.h     |   16 
 8 files changed, 2585 insertions(+), 16 deletions(-)
 create mode 100644 drivers/usb/virtio_usb/host.c
 create mode 100644 drivers/usb/virtio_usb/host.h
 create mode 100644 drivers/usb/virtio_usb/vq_common.c
 create mode 100644 drivers/usb/virtio_usb/vq_common.h

diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb/controller.c
index 2fc6f50..216edfc 100644
--- a/drivers/usb/virtio_usb/controller.c
+++ b/drivers/usb/virtio_usb/controller.c
@@ -6,9 +6,16 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <uapi/linux/virtio_ids.h>
 
 #include "controller.h"
+#include "host.h"
+#include "vq_common.h"
+
+u32 virtio_usb_cmd_timeout_ms = MSEC_PER_SEC;
+module_param_named(cmd_timeout_ms, virtio_usb_cmd_timeout_ms, uint, 0644);
+MODULE_PARM_DESC(cmd_timeout_ms, "Command completion timeout in milliseconds");
 
 /**
  * virtio_usb_find_vqs() - Enumerate and initialize all virtqueues.
@@ -70,9 +77,22 @@ static int virtio_usb_validate(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
+	if (!virtio_has_feature(vdev, VIRTIO_USB_F_HOST)) {
+		dev_err(&vdev->dev,
+			"device should support at least one usb role\n");
+		return -EINVAL;
+	}
+
+	if (!virtio_usb_cmd_timeout_ms) {
+		dev_err(&vdev->dev, "msg_timeout_ms value cannot be zero\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
+static void virtio_usb_remove(struct virtio_device *vdev);
+
 /**
  * virtio_usb_probe() - Probe VirtIO usb controller.
  * @vdev: VirtIO parent device.
@@ -84,7 +104,7 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 {
 	struct virtio_usb *vusb;
 	unsigned int nvqs = 0;
-	int rc = 0;
+	int rc = 0, i = 0;
 
 	vusb = devm_kzalloc(&vdev->dev, sizeof(*vusb), GFP_KERNEL);
 	if (!vusb)
@@ -100,6 +120,22 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 	if (!vusb->vports)
 		return -ENOMEM;
 
+	if (virtio_has_feature(vdev, VIRTIO_USB_F_HOST))
+		vusb->host_role = 1;
+
+	/* Only host_role exists so far, so every port is unambiguously a
+	 * host-role port. Later commits (device role, OTG) will replace
+	 * this with real per-port role resolution.
+	 */
+	vusb->host_vq_base = -1;
+	if (vusb->host_role) {
+		vusb->host_vq_base = nvqs;
+		nvqs += VIRTIO_USB_VQ_HOST_MAX;
+
+		for (i = 0; i < vusb->nports; i++)
+			vusb->vports[i].role = VIRTIO_USB_ROLE_HOST;
+	}
+
 	vusb->vqueues = devm_kcalloc(&vdev->dev, nvqs, sizeof(*vusb->vqueues),
 				     GFP_KERNEL);
 	if (!vusb->vqueues)
@@ -107,13 +143,60 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 
 	vusb->nvqs = nvqs;
 
+	if (vusb->host_vq_base >= 0)
+		for (i = 0; i < VIRTIO_USB_VQ_HOST_MAX; i++) {
+			vusb->vqueues[vusb->host_vq_base + i].name =
+				host_vqueues[i].name;
+			vusb->vqueues[vusb->host_vq_base + i].callback =
+				host_vqueues[i].callback;
+			vusb->vqueues[vusb->host_vq_base + i].process =
+				host_vqueues[i].process;
+			vusb->vqueues[vusb->host_vq_base + i].stop =
+				host_vqueues[i].stop;
+		}
+
 	rc = virtio_usb_find_vqs(vusb);
-	if (rc)
-		goto on_exit;
+	if (rc) {
+		dev_err(&vdev->dev, "%s virtio_usb_find_vqs() error(%d)\n",
+			__func__, rc);
+		goto on_error;
+	}
+
+	if (vusb->host_role) {
+		INIT_WORK(&vusb->vq_host_data_rx_work, virtio_usb_hc_rx_work);
+		INIT_WORK(&vusb->vq_host_evt_work, virtio_usb_hc_evt_work);
+
+		/* Initialize one HCD pair per host-role VP. */
+		for (i = 0; i < vusb->nports; i++) {
+			if (vusb->vports[i].role != VIRTIO_USB_ROLE_HOST)
+				continue;
+			rc = virtio_usb_hc_vp_init(vusb, i);
+			if (rc) {
+				dev_err(&vdev->dev,
+					"%s virtio_usb_hc_vp_init() port=%d error(%d)\n",
+					__func__, i, rc);
+				goto on_error;
+			}
+		}
+		/* Populate the shared host event queue once, after every
+		 * VP is initialized.
+		 */
+		rc = virtio_usb_hc_event_populate(vusb);
+		if (rc) {
+			dev_err(&vdev->dev,
+				"%s virtio_usb_hc_event_populate() error(%d)\n",
+				__func__, rc);
+			goto on_error;
+		}
+	}
 
 	virtio_device_ready(vdev);
 
-on_exit:
+	return rc;
+
+on_error:
+	dev_err(&vdev->dev, "%s failed(%d)\n", __func__, rc);
+	virtio_usb_remove(vdev);
 	return rc;
 }
 
@@ -128,13 +211,23 @@ static void virtio_usb_remove(struct virtio_device *vdev)
 	struct virtio_usb *vusb = vdev->priv;
 	int i;
 
-	virtio_reset_device(vdev);
 	for (i = 0; i < vusb->nvqs; i++)
 		vusb->vqueues[i].stop(vusb, &vusb->vqueues[i]);
 
+	if (vusb->host_role && vusb->vports) {
+		for (i = 0; i < (int)vusb->nports; i++)
+			virtio_usb_hc_vp_deinit(vusb, i);
+	}
+
+	virtio_reset_device(vdev);
+
 	vdev->config->del_vqs(vdev);
 }
 
+static const unsigned int virtio_usb_features[] = {
+	VIRTIO_USB_F_HOST,
+};
+
 static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_USB, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -142,6 +235,8 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_usb_driver = {
 	.driver.name = KBUILD_MODNAME,
+	.feature_table = virtio_usb_features,
+	.feature_table_size = ARRAY_SIZE(virtio_usb_features),
 	.id_table = id_table,
 	.validate = virtio_usb_validate,
 	.probe = virtio_usb_probe,
diff --git a/drivers/usb/virtio_usb/controller.h b/drivers/usb/virtio_usb/controller.h
index eb07d0b..af68a77 100644
--- a/drivers/usb/virtio_usb/controller.h
+++ b/drivers/usb/virtio_usb/controller.h
@@ -14,18 +14,23 @@
 
 #include <uapi/linux/virtio_usb.h>
 
+/* Forward declaration - full definition in host.h */
+struct virtio_usb_hc_vp;
+
+#define VIRTIO_USB_VQ_COMMAND_IDX 0
+#define VIRTIO_USB_VQ_EVENT_IDX 1
+#define VIRTIO_USB_VQ_DATA_IDX 2
+
+#define VIRTIO_USB_VQ_HOST_MAX 3
+
 /**
  * struct virtio_usb_port - Per-virtual-port state.
- * @role: Role of this port (VIRTIO_USB_ROLE_HOST or _DEVICE), once a
- *        role-providing commit has assigned it. Unused for now - this
- *        struct is deliberately introduced ahead of any code that
- *        populates or reads @role, so that every later commit that adds
- *        a role (host, device, OTG) can build on this same per-port
- *        array from the start instead of each reinventing its own
- *        port-indexed storage.
+ * @role: Role of this port (VIRTIO_USB_ROLE_HOST or _DEVICE).
+ * @vhc: Host controller - non-NULL when role is HOST.
  */
 struct virtio_usb_port {
 	unsigned int role;
+	struct virtio_usb_hc_vp *vhc;
 };
 
 /**
@@ -35,6 +40,15 @@ struct virtio_usb_port {
  * @vports: Array of per-port structures, one entry per virtual port.
  * @nports: number of supported ports
  * @nvqs: number of virtqueues for the device
+ * @host_role: flag indicating support for host role
+ * @host_vq_base: index into vqueues[] where the HOST_COMMAND/EVENT/DATA
+ *                triplet starts, or -1 if this instance has no host-role
+ *                VP (in which case those queues do not exist on the wire
+ *                and must not be negotiated).
+ * @vq_host_data_rx_work: Kernel work draining the host data queue, shared
+ *                        across every host-role VP.
+ * @vq_host_evt_work: Kernel work draining the host event queue, shared
+ *                     across every host-role VP.
  */
 struct virtio_usb {
 	struct virtio_device *vdev;
@@ -42,6 +56,10 @@ struct virtio_usb {
 	struct virtio_usb_port *vports;
 	unsigned int nports;
 	u32 nvqs;
+	bool host_role;
+	int host_vq_base;
+	struct work_struct vq_host_data_rx_work;
+	struct work_struct vq_host_evt_work;
 };
 
 /**
@@ -81,4 +99,7 @@ struct virtio_usb_vq_desc {
 	void (*stop)(struct virtio_usb *vusb, struct virtio_usb_queue *vq);
 };
 
+/* Command completion timeout in milliseconds (module parameter). */
+extern u32 virtio_usb_cmd_timeout_ms;
+
 #endif /* VIRTIO_USB_CONTROLLER_H */
diff --git a/drivers/usb/virtio_usb/Makefile b/drivers/usb/virtio_usb/Makefile
index b7ee9e8..1111111 100644
--- a/drivers/usb/virtio_usb/Makefile
+++ b/drivers/usb/virtio_usb/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-virtio-usb-y := controller.o
+virtio-usb-y := controller.o \
+	vq_common.o \
+	host.o
 
 obj-$(CONFIG_USB_VIRTIO) += virtio-usb.o
diff --git a/drivers/usb/virtio_usb/host.c b/drivers/usb/virtio_usb/host.c
new file mode 100644
index 0000000..9926e66
--- /dev/null
+++ b/drivers/usb/virtio_usb/host.c
@@ -0,0 +1,1335 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio_usb: VirtIO USB device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "controller.h"
+
+#include "host.h"
+#include "vq_common.h"
+
+/**
+ * virtio_usb_hc_reset() - Reset the host controller.
+ * @hcd: USB host controller device.
+ *
+ * Context: Any context
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_hc_reset(struct usb_hcd *hcd)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+
+	if (hcd == vhcd_vp->hs) {
+		hcd->speed = HCD_USB2;
+		hcd->self.root_hub->speed = USB_SPEED_HIGH;
+		hcd->has_tt = 1;
+	} else {
+		hcd->speed = HCD_USB3;
+		hcd->self.root_hub->speed = USB_SPEED_SUPER;
+	}
+
+	hcd->self.sg_tablesize = ~0;
+	return 0;
+}
+
+/**
+ * virtio_usb_hc_start() - Start the host controller.
+ * @hcd: USB host controller device
+ *
+ * Context: Any context
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_hc_start(struct usb_hcd *hcd)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+	unsigned long iflags;
+
+	hcd->uses_new_polling = 1;
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+
+	spin_lock_irqsave(&vhcd_vp->lock, iflags);
+	hcd->state = HC_STATE_RUNNING;
+	spin_unlock_irqrestore(&vhcd_vp->lock, iflags);
+	hcd->self.no_sg_constraint = 1;
+
+	return 0;
+}
+
+/**
+ * virtio_usb_hc_stop() - Stop the host controller.
+ * @hcd: USB host controller device
+ *
+ * Context: Any context
+ */
+static void virtio_usb_hc_stop(struct usb_hcd *hcd)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+	unsigned long iflags;
+
+	spin_lock_irqsave(&vhcd_vp->lock, iflags);
+	hcd->state = HC_STATE_HALT;
+	spin_unlock_irqrestore(&vhcd_vp->lock, iflags);
+}
+
+/**
+ * virtio_usb_hub_status_data() - Get the hub status data for the root hub.
+ * @vhcd_vp: per-VP VirtIO USB host controller
+ * @buffer: status buffer in which the hub status need to be updated
+ * @ss_mode: indicates if the root hub is a super speed hub.
+ *
+ * Context: Any context
+ * Return: 0 if the status hasn't changed, or the number of bytes in buffer.
+ */
+static int virtio_usb_hub_status_data(struct virtio_usb_hc_vp *vhcd_vp,
+				      char *buffer, bool ss_mode)
+{
+	unsigned int i;
+	unsigned int nbytes = DIV_ROUND_UP(VIRTIO_USB_VP_MAX_PORTS + 1, 8);
+	int changed = 0;
+	unsigned long iflags;
+	struct usb_hcd *hcd = ss_mode ? vhcd_vp->ss : vhcd_vp->hs;
+
+	memset(buffer, 0, nbytes);
+
+	for (i = 0; i < VIRTIO_USB_VP_MAX_PORTS; i++) {
+		struct virtio_usb_hc_port *port = &vhcd_vp->ports[i];
+		u16 value;
+
+		spin_lock_irqsave(&port->lock, iflags);
+		value = ss_mode ? port->ss.change.value : port->hs.change.value;
+		spin_unlock_irqrestore(&port->lock, iflags);
+
+		if (value) {
+			buffer[(i + 1) / 8] |= 1 << ((i + 1) % 8);
+			changed = 1;
+		}
+	}
+	if (changed) {
+		spin_lock_irqsave(&vhcd_vp->lock, iflags);
+		if (hcd->state == HC_STATE_SUSPENDED)
+			usb_hcd_resume_root_hub(hcd);
+		spin_unlock_irqrestore(&vhcd_vp->lock, iflags);
+	}
+
+	return changed ? nbytes : 0;
+}
+
+static int virtio_usb_hs_hub_status_data(struct usb_hcd *hcd, char *buffer)
+{
+	return virtio_usb_hub_status_data(vhcd_get(hcd), buffer, false);
+}
+
+static int virtio_usb_ss_hub_status_data(struct usb_hcd *hcd, char *buffer)
+{
+	return virtio_usb_hub_status_data(vhcd_get(hcd), buffer, true);
+}
+
+/**
+ * virtio_usb_windex_to_port - Map wIndex to a host controller port.
+ * @vhcd_vp: per-VP host controller
+ * @wIndex:  low byte contains the 1-based port number
+ *
+ * Return: pointer to port on success, NULL if out of range.
+ */
+static struct virtio_usb_hc_port *
+virtio_usb_windex_to_port(struct virtio_usb_hc_vp *vhcd_vp, u16 wIndex)
+{
+	u16 pIndex = wIndex & 0xFF;
+
+	if (pIndex == 0 || pIndex > VIRTIO_USB_VP_MAX_PORTS)
+		return NULL;
+	return &vhcd_vp->ports[pIndex - 1];
+}
+
+/**
+ * virtio_usb_hub_control() - Hub control request callback (shared HS/SS).
+ */
+static int virtio_usb_hub_control(struct usb_hcd *hcd, u16 type, u16 wValue,
+				  u16 wIndex, char *buffer, u16 wLength,
+				  bool ss_mode)
+{
+	struct virtio_usb_hc_port *port;
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+
+	switch (type) {
+	case GetHubDescriptor: {
+		struct usb_hub_descriptor *dsc =
+			(struct usb_hub_descriptor *)buffer;
+
+		memset(dsc, 0, sizeof(struct usb_hub_descriptor));
+
+		if (ss_mode) {
+			dsc->bDescLength = USB_DT_SS_HUB_SIZE;
+			dsc->bDescriptorType = USB_DT_SS_HUB;
+		} else {
+			dsc->bDescLength = 9;
+			dsc->bDescriptorType = USB_DT_HUB;
+		}
+
+		/* Fixed port count per VP - always within USB_MAXCHILDREN (31)
+		 * and USB_SS_MAXPORTS (15).
+		 */
+		dsc->bNbrPorts = VIRTIO_USB_VP_MAX_PORTS;
+
+		return 0;
+	}
+	case GetHubStatus: {
+		*((u32 *)buffer) = 0;
+		return 0;
+	}
+	case GetPortStatus: {
+		u16 *status = (u16 *)buffer;
+		unsigned long iflags;
+
+		memset(status, 0, wLength);
+
+		port = virtio_usb_windex_to_port(vhcd_vp, wIndex);
+		if (port) {
+			spin_lock_irqsave(&port->lock, iflags);
+			if (ss_mode) {
+				status[0] = port->ss.status.value;
+				status[1] = port->ss.change.value;
+			} else {
+				status[0] = port->hs.status.value;
+				status[1] = port->hs.change.value;
+			}
+			spin_unlock_irqrestore(&port->lock, iflags);
+		}
+
+		return 0;
+	}
+	}
+
+	return -EPIPE;
+}
+
+/**
+ * virtio_usb_hs_hub_control() - VirtIO USB High speed hub control request.
+ */
+static int virtio_usb_hs_hub_control(struct usb_hcd *hcd, u16 type, u16 wValue,
+				     u16 wIndex, char *buffer, u16 wLength)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+	struct virtio_usb_hc_port *port;
+	unsigned long iflags;
+	int rc = 0;
+
+	switch (type) {
+	case ClearPortFeature:
+		port = virtio_usb_windex_to_port(vhcd_vp, wIndex);
+		if (port == NULL)
+			return -EPIPE;
+
+		spin_lock_irqsave(&port->lock, iflags);
+		switch (wValue) {
+		case USB_PORT_FEAT_ENABLE:
+			if (port->hs.status.bits.enable) {
+				port->hs.status.bits.enable = 0;
+				port->hs.change.bits.enable = 1;
+			}
+			break;
+		case USB_PORT_FEAT_C_CONNECTION:
+			port->hs.change.bits.connect = 0;
+			break;
+		case USB_PORT_FEAT_C_ENABLE:
+			port->hs.change.bits.enable = 0;
+			break;
+		case USB_PORT_FEAT_C_RESET:
+			port->hs.change.bits.reset = 0;
+			break;
+		default:
+			rc = -EPIPE;
+			break;
+		}
+		spin_unlock_irqrestore(&port->lock, iflags);
+		break;
+	case SetPortFeature:
+		port = virtio_usb_windex_to_port(vhcd_vp, wIndex);
+		if (port == NULL)
+			return -EPIPE;
+
+		spin_lock_irqsave(&port->lock, iflags);
+		switch (wValue) {
+		case USB_PORT_FEAT_RESET:
+			if (!port->hs.status.bits.enable) {
+				port->hs.status.bits.enable = 1;
+				port->hs.change.bits.enable = 1;
+			}
+			port->hs.change.bits.reset = 1;
+			break;
+		case USB_PORT_FEAT_POWER:
+			port->hs.status.bits.power = 1;
+			break;
+		default:
+			rc = -EPIPE;
+			break;
+		}
+		spin_unlock_irqrestore(&port->lock, iflags);
+		break;
+	default:
+		rc = virtio_usb_hub_control(hcd, type, wValue, wIndex, buffer,
+					    wLength, false);
+		break;
+	}
+
+	return rc;
+}
+
+/* Super speed root hub device descriptor */
+static struct {
+	struct usb_bos_descriptor bos;
+	struct usb_ss_cap_descriptor ss_cap;
+} __packed ss_bos_desc = {
+	.bos = {
+		.bLength = USB_DT_BOS_SIZE,
+		.bDescriptorType = USB_DT_BOS,
+		.wTotalLength = cpu_to_le16(sizeof(ss_bos_desc)),
+		.bNumDeviceCaps = 1,
+		},
+	.ss_cap = {
+		.bLength = USB_DT_USB_SS_CAP_SIZE,
+		.bDescriptorType = USB_DT_DEVICE_CAPABILITY,
+		.bDevCapabilityType = USB_SS_CAP_TYPE,
+		.bmAttributes = 0x00,
+		.wSpeedSupported = cpu_to_le16(USB_5GBPS_OPERATION),
+		.bFunctionalitySupport = ilog2(USB_5GBPS_OPERATION),
+		.bU1devExitLat = 0x00,
+		.bU2DevExitLat = 0x00,
+		},
+};
+
+/**
+ * virtio_usb_ss_hub_control() - VirtIO USB Super speed hub control request.
+ */
+static int virtio_usb_ss_hub_control(struct usb_hcd *hcd, u16 type, u16 wValue,
+				     u16 wIndex, char *buffer, u16 wLength)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+	struct virtio_usb_hc_port *port;
+	unsigned long iflags;
+	int rc = 0;
+
+	switch (type) {
+	case ClearPortFeature:
+		port = virtio_usb_windex_to_port(vhcd_vp, wIndex);
+		if (port == NULL)
+			return -EPIPE;
+
+		spin_lock_irqsave(&port->lock, iflags);
+		switch (wValue) {
+		case USB_PORT_FEAT_C_CONNECTION:
+			port->ss.change.bits.connect = 0;
+			break;
+		case USB_PORT_FEAT_C_RESET:
+			port->ss.change.bits.reset = 0;
+			break;
+		case USB_PORT_FEAT_C_PORT_LINK_STATE:
+			port->ss.change.bits.link_state = 0;
+			break;
+		case USB_PORT_FEAT_C_BH_PORT_RESET:
+			port->ss.change.bits.bh_reset = 0;
+			break;
+		default:
+			rc = -EPIPE;
+			break;
+		}
+		spin_unlock_irqrestore(&port->lock, iflags);
+		break;
+	case DeviceRequest | USB_REQ_GET_DESCRIPTOR: {
+		u8 dtype = (wValue >> 8) & 0xff;
+
+		if (dtype == USB_DT_BOS) {
+			u16 bos_length = sizeof(ss_bos_desc);
+
+			if (bos_length > wLength)
+				bos_length = wLength;
+
+			memcpy(buffer, &ss_bos_desc, bos_length);
+
+			rc = bos_length;
+		} else {
+			rc = -EPIPE;
+		}
+
+		break;
+	}
+	case SetPortFeature: {
+		port = virtio_usb_windex_to_port(vhcd_vp, wIndex);
+		if (port == NULL)
+			return -EPIPE;
+
+		spin_lock_irqsave(&port->lock, iflags);
+		switch (wValue) {
+		case USB_PORT_FEAT_RESET:
+		case USB_PORT_FEAT_BH_PORT_RESET:
+			port->ss.status.bits.enable = 1;
+
+			if (port->ss.status.bits.link_state != 0x00) {
+				port->ss.status.bits.link_state = 0x00;
+				port->ss.change.bits.link_state = 1;
+			}
+
+			port->ss.status.bits.reset = 0;
+			port->ss.change.bits.reset = 1;
+
+			if (wValue == USB_PORT_FEAT_BH_PORT_RESET)
+				port->ss.change.bits.bh_reset = 1;
+
+			break;
+		case USB_PORT_FEAT_POWER:
+			port->ss.status.bits.power = 1;
+			break;
+		default:
+			rc = -EPIPE;
+			break;
+		}
+		spin_unlock_irqrestore(&port->lock, iflags);
+		break;
+	}
+	default:
+		rc = virtio_usb_hub_control(hcd, type, wValue, wIndex, buffer,
+					    wLength, true);
+		break;
+	}
+
+	return rc;
+}
+
+/* virtio usb host controller priv structure */
+struct virtio_usb_hc_priv {
+	struct virtio_usb_hc_port *port;
+	struct urb *urb;
+	struct scatterlist *sgs;
+};
+
+/**
+ * virtio_usb_hc_complete_urb() - Completes a URB
+ * @vurb: virtio_usb_data message.
+ *
+ * Context: Process context.
+ */
+static void virtio_usb_hc_complete_urb(struct virtio_usb_data *vurb)
+{
+	struct virtio_usb_hc_priv *priv =
+		(struct virtio_usb_hc_priv *)vurb->priv;
+	struct virtio_usb_response *response;
+	struct virtio_usb_iso_status *iso_urb_status;
+	struct virtio_usb_hc_port *port = priv->port;
+	struct urb *urb = priv->urb;
+	struct usb_hcd *hcd;
+	unsigned long flags;
+	int i;
+	unsigned int status;
+
+	if (unlikely(!urb || !urb->dev || !urb->dev->bus)) {
+		kfree(priv->sgs);
+		virtio_usb_data_unref(vurb);
+		return;
+	}
+
+	hcd = bus_to_hcd(urb->dev->bus);
+
+	response = virtio_usb_data_response(vurb);
+
+	status = le32_to_cpu(response->status);
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	usb_hcd_unlink_urb_from_ep(hcd, urb);
+	urb->hcpriv = NULL;
+	list_del(&vurb->list);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	urb->status = virtio_error_to_usb(status);
+	urb->actual_length = le32_to_cpu(response->actual_length);
+	if (urb->status == -EINVAL)
+		dev_err(&urb->dev->dev,
+			"URB ep%02x status -EINVAL from virtio status %u actual=%d\n",
+			urb->ep->desc.bEndpointAddress, status,
+			urb->actual_length);
+
+	if (usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe))
+		urb->interval = le32_to_cpu(response->interval);
+
+	if (usb_pipeisoc(urb->pipe)) {
+		iso_urb_status = (void *)response + sizeof(*response);
+
+		for (i = 0; i < urb->number_of_packets; i++) {
+			struct virtio_usb_iso_status *iso_status =
+				&iso_urb_status[i];
+			status = le32_to_cpu(iso_status->status);
+
+			urb->iso_frame_desc[i].actual_length =
+				le32_to_cpu(iso_status->actual_length);
+			urb->iso_frame_desc[i].status =
+				virtio_error_to_usb(status);
+
+			if (iso_status->status)
+				urb->error_count++;
+		}
+
+		urb->start_frame = le32_to_cpu(response->start_frame);
+	}
+	local_bh_disable();
+	usb_hcd_giveback_urb(hcd, urb, urb->status);
+	local_bh_enable();
+	kfree(priv->sgs);
+	virtio_usb_data_unref(vurb);
+}
+
+/**
+ * virtio_usb_hc_set_urb_sgs() - Set urb sgs when total sg elements > 1.
+ */
+static struct scatterlist *
+virtio_usb_hc_set_urb_sgs(struct virtio_usb_hc_priv *priv, gfp_t gfp)
+{
+	struct scatterlist *sg = NULL, *sgs = NULL;
+	struct urb *urb = priv->urb;
+	unsigned int nsgs, i = 0;
+	unsigned int buffer_length = urb->transfer_buffer_length;
+	unsigned int sg_length = 0;
+
+	nsgs = urb->num_sgs;
+
+	for_each_sg(urb->sg, sg, nsgs, i) {
+		sg_length += sg->length;
+	}
+	if (sg_length > buffer_length) {
+		sgs = kcalloc(nsgs, sizeof(*sgs), gfp);
+		if (!sgs)
+			return NULL;
+
+		sg_init_table(sgs, nsgs);
+
+		for_each_sg(urb->sg, sg, nsgs, i) {
+			sg_length = sg->length;
+
+			if (sg_length > buffer_length)
+				sg_length = buffer_length;
+
+			sg_set_page(&sgs[i], sg_page(sg), sg_length,
+				    sg->offset);
+
+			buffer_length -= sg_length;
+			if (!buffer_length)
+				break;
+		}
+		priv->sgs = sgs;
+		return sgs;
+	}
+	return urb->sg;
+}
+
+/**
+ * virtio_usb_hc_data_alloc() - Allocates a virtio usb data for the host
+ * @port: VirtIO USB HC port
+ * @urb: The urb request
+ * @gfp: Kernel flags for memory allocation.
+ */
+static struct virtio_usb_data *
+virtio_usb_hc_data_alloc(struct virtio_usb_hc_port *port, struct urb *urb,
+			 gfp_t gfp)
+{
+	struct virtio_usb_data *vurb;
+	struct virtio_usb_hc_priv *priv;
+	struct virtio_usb_request *request;
+	struct virtio_usb_response *response;
+	struct virtio_usb_iso_packet *iso_packet;
+	struct virtio_usb_iso_status *iso_status;
+	size_t request_size = sizeof(*request);
+	size_t response_size = sizeof(*response);
+	u16 ep, transfer_flags = 0;
+
+	if (usb_pipeisoc(urb->pipe)) {
+		request_size += sizeof(*iso_packet) * urb->number_of_packets;
+		response_size += sizeof(*iso_status) * urb->number_of_packets;
+	}
+
+	vurb = virtio_usb_data_alloc(request_size, response_size,
+				     sizeof(struct virtio_usb_hc_priv), gfp);
+
+	if (!vurb)
+		return NULL;
+
+	priv = vurb->priv;
+	priv->port = port;
+	priv->urb = urb;
+	vurb->msg.queue = port->vhcd_vp->hcqs[VIRTIO_USB_VQ_DATA_IDX];
+
+	INIT_LIST_HEAD(&vurb->list);
+
+	request = virtio_usb_data_request(vurb);
+	response = virtio_usb_data_response(vurb);
+
+	response->status = cpu_to_le32(VIRTIO_USB_S_ERR_CANCELLED);
+
+	if (usb_pipeisoc(urb->pipe)) {
+		iso_packet = (void *)request + sizeof(*request);
+		iso_status = (void *)response + sizeof(*response);
+	}
+	request->tag = cpu_to_le64((uintptr_t)vurb);
+	ep = usb_pipeendpoint(urb->pipe);
+	if (usb_pipein(urb->pipe))
+		ep |= VIRTIO_USB_EP_DIR_IN;
+
+	request->endpoint = cpu_to_le16(ep);
+	request->vp_idx = cpu_to_le16((u16)port->vhcd_vp->vp_idx);
+	request->port = cpu_to_le16((u16)port->port_id);
+
+	if (urb->transfer_flags & URB_SHORT_NOT_OK)
+		transfer_flags |= VIRTIO_USB_FLAG_SHORT_NOT_OK;
+	if (urb->transfer_flags & URB_ISO_ASAP)
+		transfer_flags |= VIRTIO_USB_FLAG_ISO_ASAP;
+	if (urb->transfer_flags & URB_ZERO_PACKET)
+		transfer_flags |= VIRTIO_USB_FLAG_ZERO_PACKET;
+	request->transfer_flags = cpu_to_le16(transfer_flags);
+
+	switch (usb_pipetype(urb->pipe)) {
+	case PIPE_ISOCHRONOUS: {
+		int i;
+
+		request->transfer_type = cpu_to_le16(VIRTIO_USB_EP_ISOCHRONOUS);
+		request->iso.start_frame = cpu_to_le32(urb->start_frame);
+		request->iso.interval = cpu_to_le32(urb->interval);
+		request->iso.number_of_packets =
+			cpu_to_le32(urb->number_of_packets);
+
+		for (i = 0; i < urb->number_of_packets; i++) {
+			struct virtio_usb_iso_packet *packet = &iso_packet[i];
+
+			packet->offset =
+				cpu_to_le32(urb->iso_frame_desc[i].offset);
+			packet->length =
+				cpu_to_le32(urb->iso_frame_desc[i].length);
+		}
+
+		break;
+	}
+	case PIPE_INTERRUPT:
+		request->transfer_type = cpu_to_le16(VIRTIO_USB_EP_INTERRUPT);
+		request->interrupt.interval = cpu_to_le32(urb->interval);
+		break;
+	case PIPE_CONTROL:
+		request->transfer_type = cpu_to_le16(VIRTIO_USB_EP_CONTROL);
+		memcpy(request->control.setup, urb->setup_packet, 8);
+		break;
+	case PIPE_BULK:
+		request->transfer_type = cpu_to_le16(VIRTIO_USB_EP_BULK);
+		break;
+	}
+	return vurb;
+}
+
+/**
+ * virtio_usb_hc_cmd_alloc() - Allocate and initialize a host command message.
+ */
+static struct virtio_usb_cmd *virtio_usb_hc_cmd_alloc(struct virtio_usb *vusb,
+						      unsigned int vp_idx,
+						      unsigned int command,
+						      gfp_t gfp)
+{
+	size_t request_size = sizeof(struct virtio_usb_host_cmd_hdr);
+	size_t response_size = sizeof(struct virtio_usb_cmd_status);
+	struct virtio_usb_cmd *cmd;
+
+	switch (command) {
+	case VIRTIO_USB_CMD_HOST_CANCEL:
+		request_size = sizeof(struct virtio_usb_host_cmd_cancel);
+		break;
+	case VIRTIO_USB_CMD_HOST_STREAMS_ALLOC:
+	case VIRTIO_USB_CMD_HOST_STREAMS_FREE:
+		request_size = sizeof(struct virtio_usb_host_cmd_streams);
+		break;
+	default:
+		break;
+	}
+
+	cmd = virtio_usb_cmd_alloc(request_size, response_size, gfp);
+	if (cmd) {
+		struct virtio_usb_host_cmd_hdr *hdr =
+			virtio_usb_cmd_request(cmd);
+		struct virtio_usb_cmd_status *status =
+			virtio_usb_cmd_response(cmd);
+
+		hdr->code = cpu_to_le32(command);
+		cmd->msg.queue = vusb->vports[vp_idx]
+					 .vhc->hcqs[VIRTIO_USB_VQ_COMMAND_IDX];
+		status->code = cpu_to_le32(VIRTIO_USB_S_ERR_CANCELLED);
+	}
+	return cmd;
+}
+
+/**
+ * virtio_usb_port_from_urb() - Look up the port for a URB.
+ *
+ * urb->dev->portnum is the 1-based port number on the root hub, which
+ * equals port_id + 1. The HCD identifies which VP.
+ *
+ * Returns NULL if the slot is out of range.
+ */
+static struct virtio_usb_hc_port *virtio_usb_port_from_urb(struct usb_hcd *hcd,
+							   struct urb *urb)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+	int slot = urb->dev->portnum - 1;
+
+	if (slot < 0 || slot >= VIRTIO_USB_VP_MAX_PORTS)
+		return NULL;
+	return &vhcd_vp->ports[slot];
+}
+
+/**
+ * virtio_usb_hc_enqueue() - Enqueue a URB.
+ * @hcd: USB host controller device
+ * @urb: URB
+ * @mem_flags: Kernel flags for memory allocation.
+ *
+ * Context: Any context
+ * Return: 0 on success -errno on failure
+ */
+static int virtio_usb_hc_enqueue(struct usb_hcd *hcd, struct urb *urb,
+				 gfp_t mem_flags)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+	struct virtio_usb *vusb = vhcd_vp->vusb;
+	struct virtio_usb_hc_port *port;
+	struct virtio_usb_data *vurb;
+	struct virtio_usb_hc_priv *priv;
+	struct scatterlist sg;
+	struct scatterlist *psg_data = &sg, *out_sgs = NULL, *in_sgs = NULL;
+	unsigned long flags;
+	int rc = 0;
+
+	port = virtio_usb_port_from_urb(hcd, urb);
+	if (!port)
+		return -ENODEV;
+
+	vurb = virtio_usb_hc_data_alloc(port, urb, mem_flags);
+	if (!vurb)
+		return -ENOMEM;
+	priv = vurb->priv;
+
+	if (urb->transfer_buffer) {
+		sg_init_one(psg_data, urb->transfer_buffer,
+			    urb->transfer_buffer_length);
+	} else if (urb->num_sgs > 1) {
+		psg_data = virtio_usb_hc_set_urb_sgs(priv, mem_flags);
+		if (!psg_data) {
+			rc = -ENOMEM;
+			goto on_exit;
+		}
+	} else if (urb->transfer_buffer_length && urb->sg) {
+		sg_init_one(psg_data, sg_virt(urb->sg),
+			    urb->transfer_buffer_length);
+	} else {
+		psg_data = NULL;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+	rc = usb_hcd_link_urb_to_ep(port_vhcd_get(port), urb);
+	if (rc) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		goto on_exit;
+	}
+	urb->hcpriv = vurb;
+	list_add_tail(&vurb->list, &port->pending_urb_list);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (usb_pipeout(urb->pipe))
+		out_sgs = psg_data;
+	else
+		in_sgs = psg_data;
+
+	rc = virtio_usb_data_send(vusb, vurb, out_sgs, in_sgs);
+	if (rc)
+		goto on_error_vq;
+
+	return rc;
+
+on_error_vq:
+	spin_lock_irqsave(&port->lock, flags);
+	usb_hcd_unlink_urb_from_ep(port_vhcd_get(port), urb);
+	urb->hcpriv = NULL;
+	list_del(&vurb->list);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+on_exit:
+	kfree(priv->sgs);
+	virtio_usb_data_unref(vurb);
+	return rc;
+}
+
+/**
+ * virtio_usb_hc_dequeue() - Dequeue a URB.
+ * @hcd: USB host controller device
+ * @urb: URB
+ * @status: status of the URB.
+ *
+ * Context: Any context
+ * Return: 0 on success -errno on failure
+ */
+static int virtio_usb_hc_dequeue(struct usb_hcd *hcd, struct urb *urb,
+				 int status)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vhcd_get(hcd);
+	struct virtio_usb *vusb = vhcd_vp->vusb;
+	struct virtio_usb_hc_port *port;
+	struct virtio_usb_host_cmd_cancel *cancel;
+	struct virtio_usb_data *vurb;
+	struct virtio_usb_cmd *cmd;
+	int rc;
+	unsigned long flags;
+
+	port = virtio_usb_port_from_urb(hcd, urb);
+	if (!port)
+		return -ENODEV;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	vurb = urb->hcpriv;
+	if (!vurb) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		return -EIDRM;
+	}
+
+	rc = usb_hcd_check_unlink_urb(port_vhcd_get(port), urb, status);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (rc)
+		return rc;
+
+	cmd = virtio_usb_hc_cmd_alloc(vusb, vhcd_vp->vp_idx,
+				      VIRTIO_USB_CMD_HOST_CANCEL, GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	cancel = virtio_usb_cmd_request(cmd);
+	cancel->hdr.port = cpu_to_le32(port->port_id);
+	cancel->tag = cpu_to_le64((uintptr_t)vurb);
+
+	return virtio_usb_cmd_send_async(vusb, NULL, NULL, cmd);
+}
+
+/**
+ * virtio_usb_hc_get_frame() - Get the current hw frame number
+ */
+static int virtio_usb_hc_get_frame(struct usb_hcd *hcd)
+{
+	return 0;
+}
+
+/* Virtio USB high speed host controller driver */
+static struct hc_driver virtio_usb_hs_hc_driver = {
+	.description = "virtio-usb-hc",
+	.product_desc = "VirtIO USB2 Host Controller",
+	.hcd_priv_size = sizeof(void *),
+	.flags = HCD_USB2 | HCD_SHARED,
+
+	.reset = virtio_usb_hc_reset,
+	.start = virtio_usb_hc_start,
+	.stop = virtio_usb_hc_stop,
+
+	.hub_status_data = virtio_usb_hs_hub_status_data,
+	.hub_control = virtio_usb_hs_hub_control,
+
+	.urb_enqueue = virtio_usb_hc_enqueue,
+	.urb_dequeue = virtio_usb_hc_dequeue,
+
+	.get_frame_number = virtio_usb_hc_get_frame,
+};
+
+/* Virtio USB super speed host controller driver */
+static struct hc_driver virtio_usb_ss_hc_driver = {
+	.description = "virtio-usb-hc",
+	.product_desc = "VirtIO USB3 Host Controller",
+	.hcd_priv_size = sizeof(void *),
+	.flags = HCD_USB3 | HCD_SHARED,
+
+	.reset = virtio_usb_hc_reset,
+	.start = virtio_usb_hc_start,
+	.stop = virtio_usb_hc_stop,
+
+	.hub_status_data = virtio_usb_ss_hub_status_data,
+	.hub_control = virtio_usb_ss_hub_control,
+
+	.urb_enqueue = virtio_usb_hc_enqueue,
+	.urb_dequeue = virtio_usb_hc_dequeue,
+
+	.get_frame_number = virtio_usb_hc_get_frame,
+};
+
+/**
+ * virtio_usb_add_hcd() - Add HS and SS HCDs for one VP.
+ * @vusb:    VirtIO usb device.
+ * @vhcd_vp: per-VP host controller to populate.
+ */
+static int virtio_usb_add_hcd(struct virtio_usb *vusb,
+			      struct virtio_usb_hc_vp *vhcd_vp)
+{
+	struct virtio_device *vdev = vusb->vdev;
+	struct device *dev = &vdev->dev;
+	const char *name;
+	int rc;
+
+	/* usb_create_hcd()/usb_create_shared_hcd() store this pointer as-is
+	 * in hcd->self.bus_name (no copy is made) - it must stay valid for
+	 * the lifetime of the HCD, so it cannot be a stack buffer. Allocate
+	 * it from the parent virtio device, which outlives the HCDs.
+	 */
+	name = devm_kasprintf(&vusb->vdev->dev, GFP_KERNEL, "%s-vp%u",
+			      dev_name(dev), vhcd_vp->vp_idx);
+	if (!name)
+		return -ENOMEM;
+
+	vhcd_vp->hs = usb_create_hcd(&virtio_usb_hs_hc_driver, dev, name);
+	if (!vhcd_vp->hs)
+		return -ENOMEM;
+
+	vhcd_set(vhcd_vp->hs, vhcd_vp);
+
+	vhcd_vp->hs->skip_phy_initialization = 1;
+	rc = usb_add_hcd(vhcd_vp->hs, 0, 0);
+	if (rc)
+		goto on_put_hs;
+
+	vhcd_vp->ss = usb_create_shared_hcd(&virtio_usb_ss_hc_driver, dev, name,
+					    vhcd_vp->hs);
+	if (!vhcd_vp->ss) {
+		rc = -ENOMEM;
+		goto on_remove_hs;
+	}
+
+	vhcd_set(vhcd_vp->ss, vhcd_vp);
+
+	rc = usb_add_hcd(vhcd_vp->ss, 0, 0);
+	if (rc)
+		goto on_put_ss;
+
+	return 0;
+
+on_put_ss:
+	usb_put_hcd(vhcd_vp->ss);
+on_remove_hs:
+	usb_remove_hcd(vhcd_vp->hs);
+on_put_hs:
+	usb_put_hcd(vhcd_vp->hs);
+
+	return rc;
+}
+
+/**
+ * virtio_usb_hc_event_populate() - Add events to the host event queue.
+ * @vusb: VirtIO USB device
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure
+ */
+int virtio_usb_hc_event_populate(struct virtio_usb *vusb)
+{
+	/* The host event queue is shared across every host-role VP and
+	 * lives at the struct virtio_usb level - not owned by any single
+	 * VP - since a host-role VP may not exist yet (e.g. a dual-role
+	 * OTG instance where every port currently reports device role).
+	 */
+	struct virtio_usb_queue *evt_queue =
+		&vusb->vqueues[vusb->host_vq_base + VIRTIO_USB_VQ_EVENT_IDX];
+	struct virtio_usb_event *events;
+
+	events = virtio_usb_events_alloc(
+		vusb, evt_queue, sizeof(struct virtio_usb_host_port_event));
+
+	return virtio_usb_events_populate(events);
+}
+
+/**
+ * virtio_usb_hc_rx_work() - Worker to drain completed data messages.
+ * @work: kernel work item embedded in struct virtio_usb.
+ *
+ * The data virtqueue is shared across all host-role VPs, so the work
+ * item that drains it lives on struct virtio_usb itself instead of on
+ * any single VP (mirrors vq_dev_data_rx_work on the device-role side).
+ *
+ * Context: Process context.
+ */
+void virtio_usb_hc_rx_work(struct work_struct *work)
+{
+	struct virtio_usb *vusb =
+		container_of(work, struct virtio_usb, vq_host_data_rx_work);
+	struct virtio_usb_queue *dataq =
+		&vusb->vqueues[vusb->host_vq_base + VIRTIO_USB_VQ_DATA_IDX];
+	u32 length;
+	struct virtio_usb_data *vurb;
+
+	spin_lock_irq(&dataq->lock);
+	do {
+		virtqueue_disable_cb(dataq->vqueue);
+		while ((vurb = virtqueue_get_buf(dataq->vqueue, &length))) {
+			spin_unlock_irq(&dataq->lock);
+			virtio_usb_hc_complete_urb(vurb);
+			spin_lock_irq(&dataq->lock);
+		}
+		if (unlikely(virtqueue_is_broken(dataq->vqueue)))
+			break;
+	} while (!virtqueue_enable_cb(dataq->vqueue));
+	spin_unlock_irq(&dataq->lock);
+}
+
+/**
+ * virtio_usb_hc_vp_init() - Initialize the host controller for one VP.
+ * @vusb:    VirtIO USB device
+ * @vp_idx:  VP index (0..nports-1)
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure
+ */
+int virtio_usb_hc_vp_init(struct virtio_usb *vusb, unsigned int vp_idx)
+{
+	struct virtio_usb_hc_vp *vhcd_vp;
+	unsigned int i;
+	int rc;
+
+	vhcd_vp = devm_kzalloc(&vusb->vdev->dev, sizeof(*vhcd_vp), GFP_KERNEL);
+	if (!vhcd_vp)
+		return -ENOMEM;
+
+	vhcd_vp->vusb = vusb;
+	vhcd_vp->vp_idx = vp_idx;
+	spin_lock_init(&vhcd_vp->lock);
+
+	/* Pre-allocate all port structs. Reused across connect/disconnect. */
+	for (i = 0; i < VIRTIO_USB_VP_MAX_PORTS; i++) {
+		struct virtio_usb_hc_port *port = &vhcd_vp->ports[i];
+
+		port->vhcd_vp = vhcd_vp;
+		INIT_LIST_HEAD(&port->pending_urb_list);
+		spin_lock_init(&port->lock);
+		port->port_id = i;
+		port->ss.status.bits.link_state = 0x05; /* RX_DETECT */
+	}
+	for (i = 0; i < VIRTIO_USB_VQ_HOST_MAX; i++)
+		vhcd_vp->hcqs[i] = &vusb->vqueues[vusb->host_vq_base + i];
+
+	/* Install into the port before add_hcd so vhcd_vp->vusb is set */
+	vusb->vports[vp_idx].vhc = vhcd_vp;
+
+	/* Add HCDs first so hs/ss are valid before any PORT_CONNECTED event */
+	rc = virtio_usb_add_hcd(vusb, vhcd_vp);
+	if (rc) {
+		vusb->vports[vp_idx].vhc = NULL;
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * virtio_usb_hc_vp_deinit() - Deinitialize the host controller for one VP.
+ * @vusb:   VirtIO USB device
+ * @vp_idx: VP index
+ */
+int virtio_usb_hc_vp_deinit(struct virtio_usb *vusb, unsigned int vp_idx)
+{
+	struct virtio_usb_hc_vp *vhcd_vp = vusb->vports[vp_idx].vhc;
+
+	if (!vhcd_vp)
+		return 0;
+
+	usb_remove_hcd(vhcd_vp->ss);
+	usb_put_hcd(vhcd_vp->ss);
+	usb_remove_hcd(vhcd_vp->hs);
+	usb_put_hcd(vhcd_vp->hs);
+
+	vhcd_vp->ss = NULL;
+	vhcd_vp->hs = NULL;
+
+	vusb->vports[vp_idx].vhc = NULL;
+	return 0;
+}
+
+/**
+ * virtio_usb_hc_evt_process_one() - Process a single host port event.
+ * @uevent: VirtIO usb host controller event.
+ *
+ * Context: Process context (called from virtio_usb_hc_evt_work()).
+ */
+static void virtio_usb_hc_evt_process_one(struct virtio_usb_event *uevent)
+{
+	struct virtio_usb *vusb = uevent->vusb;
+	struct virtio_usb_host_port_event *evt;
+	unsigned int vp_idx, port_id;
+	struct virtio_usb_hc_vp *vhcd_vp;
+	struct virtio_usb_hc_port *port;
+	struct usb_hcd *hcd = NULL;
+	unsigned long iflags;
+
+	evt = (struct virtio_usb_host_port_event *)virtio_usb_event_buf(uevent);
+	vp_idx = le32_to_cpu(evt->vp_idx);
+	port_id = le32_to_cpu(evt->port_id);
+
+	if (vp_idx >= vusb->nports || !vusb->vports) {
+		dev_err_ratelimited(
+			&vusb->vdev->dev,
+			"virtio_usb: PORT event vp_idx %u invalid (nports=%u), ignoring\n",
+			vp_idx, vusb->nports);
+		return;
+	}
+
+	if (port_id >= VIRTIO_USB_VP_MAX_PORTS) {
+		dev_err_ratelimited(
+			&vusb->vdev->dev,
+			"virtio_usb: PORT event port_id %u >= VP_MAX_PORTS %u, ignoring\n",
+			port_id, VIRTIO_USB_VP_MAX_PORTS);
+		return;
+	}
+
+	vhcd_vp = vusb->vports[vp_idx].vhc;
+	if (!vhcd_vp) {
+		dev_err_ratelimited(
+			&vusb->vdev->dev,
+			"virtio_usb: PORT event vp_idx %u not host-role, ignoring\n",
+			vp_idx);
+		return;
+	}
+
+	port = &vhcd_vp->ports[port_id];
+
+	spin_lock_irqsave(&port->lock, iflags);
+	switch (le32_to_cpu(evt->code)) {
+	case VIRTIO_USB_EVT_HOST_PORT_CONNECTED:
+		/* Reinitialize the pre-allocated port struct in place */
+		memset(&port->hs, 0, sizeof(port->hs));
+		memset(&port->ss, 0, sizeof(port->ss));
+		port->ss.status.bits.link_state = 0x05; /* RX_DETECT */
+
+		switch (le32_to_cpu(evt->speed)) {
+		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER:
+			port->ss.status.bits.connect = 1;
+			port->ss.status.bits.enable = 1;
+			port->ss.status.bits.link_state = 0x00; /* U0 */
+			port->ss.change.bits.connect = 1;
+			port->ss.change.bits.link_state = 1;
+			hcd = vhcd_vp->ss;
+			break;
+		case USB_SPEED_HIGH:
+		case USB_SPEED_FULL:
+		case USB_SPEED_LOW:
+			port->hs.status.bits.connect = 1;
+			port->hs.change.bits.connect = 1;
+			if (le32_to_cpu(evt->speed) == USB_SPEED_HIGH)
+				port->hs.status.bits.high_speed = 1;
+			if (le32_to_cpu(evt->speed) == USB_SPEED_LOW)
+				port->hs.status.bits.low_speed = 1;
+			hcd = vhcd_vp->hs;
+			break;
+		default:
+			break;
+		}
+		port->speed = le32_to_cpu(evt->speed);
+		break;
+
+	case VIRTIO_USB_EVT_HOST_PORT_DISCONNECTED:
+		switch (port->speed) {
+		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER:
+			port->ss.status.bits.connect = 0;
+			port->ss.status.bits.enable = 0;
+			port->ss.status.bits.link_state = 0x05; /* RX_DETECT */
+			port->ss.change.bits.connect = 1;
+			port->ss.change.bits.link_state = 1;
+			hcd = vhcd_vp->ss;
+			break;
+		case USB_SPEED_HIGH:
+		case USB_SPEED_FULL:
+		case USB_SPEED_LOW:
+			port->hs.status.bits.connect = 0;
+			port->hs.status.bits.enable = 0;
+			port->hs.status.bits.low_speed = 0;
+			port->hs.status.bits.high_speed = 0;
+			port->hs.change.bits.connect = 1;
+			port->hs.change.bits.enable = 1;
+			if (port->hs.status.bits.suspend) {
+				port->hs.status.bits.suspend = 0;
+				port->hs.change.bits.suspend = 1;
+			}
+			hcd = vhcd_vp->hs;
+			break;
+		default:
+			break;
+		}
+		port->speed = USB_SPEED_UNKNOWN;
+		break;
+	}
+	spin_unlock_irqrestore(&port->lock, iflags);
+
+	if (hcd)
+		usb_hcd_poll_rh_status(hcd);
+}
+
+/**
+ * virtio_usb_hc_evt_work() - Host event queue receive worker.
+ * @work: kernel work item embedded in struct virtio_usb.
+ *
+ * The host event queue is shared across all host-role VPs and its VP
+ * may not even exist yet at probe time (e.g. a dual-role instance
+ * where every port currently reports device role), so events are
+ * drained and processed here, in process context, rather than
+ * directly inside the interrupt-context notify callback.
+ *
+ * Context: Process context.
+ */
+void virtio_usb_hc_evt_work(struct work_struct *work)
+{
+	struct virtio_usb *vusb =
+		container_of(work, struct virtio_usb, vq_host_evt_work);
+	struct virtio_usb_queue *evtq =
+		&vusb->vqueues[vusb->host_vq_base + VIRTIO_USB_VQ_EVENT_IDX];
+
+	virtio_usb_evt_work(evtq, virtio_usb_hc_evt_process_one);
+}
+
+/**
+ * virtio_usb_hc_dataq_stop_cb() - Stop data virtqueue, force-complete all
+ * pending URBs with -ESHUTDOWN.
+ */
+static void virtio_usb_hc_dataq_stop_cb(struct virtio_usb *vusb,
+					struct virtio_usb_queue *dataq)
+{
+	struct virtio_usb_data *vurb, *vurb_tmp;
+	struct virtio_usb_hc_priv *priv;
+	struct usb_hcd *hcd;
+	unsigned int vp_idx, slot;
+	unsigned long flags;
+
+	virtio_usb_dataq_stop_cb(vusb, dataq);
+
+	if (!vusb->vports)
+		return;
+
+	/* The data virtqueue is shared across all host-role VPs, so the
+	 * work item that drains it lives on struct virtio_usb itself.
+	 */
+	cancel_work_sync(&vusb->vq_host_data_rx_work);
+
+	for (vp_idx = 0; vp_idx < vusb->nports; vp_idx++) {
+		struct virtio_usb_hc_vp *vhcd_vp = vusb->vports[vp_idx].vhc;
+
+		if (!vhcd_vp)
+			continue;
+
+		for (slot = 0; slot < VIRTIO_USB_VP_MAX_PORTS; slot++) {
+			struct virtio_usb_hc_port *port = &vhcd_vp->ports[slot];
+			LIST_HEAD(giveback_list);
+
+			spin_lock_irqsave(&port->lock, flags);
+			list_for_each_entry_safe(
+				vurb, vurb_tmp, &port->pending_urb_list, list) {
+				priv = (struct virtio_usb_hc_priv *)vurb->priv;
+				if (!priv->urb) {
+					list_move_tail(&vurb->list,
+						       &giveback_list);
+					continue;
+				}
+				if (!priv->urb->dev) {
+					usb_hcd_unlink_urb_from_ep(
+						port_vhcd_get(port), priv->urb);
+					priv->urb->hcpriv = NULL;
+					list_move_tail(&vurb->list,
+						       &giveback_list);
+					continue;
+				}
+				hcd = bus_to_hcd(priv->urb->dev->bus);
+				usb_hcd_unlink_urb_from_ep(hcd, priv->urb);
+				priv->urb->hcpriv = NULL;
+				list_move_tail(&vurb->list, &giveback_list);
+			}
+			spin_unlock_irqrestore(&port->lock, flags);
+
+			list_for_each_entry_safe(vurb, vurb_tmp, &giveback_list,
+						 list) {
+				priv = (struct virtio_usb_hc_priv *)vurb->priv;
+				if (!priv->urb || !priv->urb->dev) {
+					list_del(&vurb->list);
+					kfree(priv->sgs);
+					virtio_usb_data_unref(vurb);
+					continue;
+				}
+				hcd = bus_to_hcd(priv->urb->dev->bus);
+				priv->urb->status = -ESHUTDOWN;
+				list_del(&vurb->list);
+				local_bh_disable();
+				usb_hcd_giveback_urb(hcd, priv->urb,
+						     priv->urb->status);
+				local_bh_enable();
+				kfree(priv->sgs);
+				virtio_usb_data_unref(vurb);
+			}
+		}
+	}
+}
+
+/**
+ * virtio_usb_hc_evt_notify_cb() - Event virtqueue notification callback.
+ *
+ * Just schedules virtio_usb_hc_evt_work() - the actual event processing
+ * needs process context, since it may end up reading vhc concurrently
+ * with an OTG-triggered virtio_usb_hc_vp_init()/_deinit(), which sleep.
+ *
+ * Context: Interrupt context.
+ */
+static void virtio_usb_hc_evt_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_usb *vusb = vqueue->vdev->priv;
+
+	schedule_work(&vusb->vq_host_evt_work);
+}
+
+/**
+ * virtio_usb_hc_evtq_stop_cb() - Stop the host event virtqueue.
+ *
+ * Do not process host port events during teardown - the vhc they'd
+ * reference may already be gone. Just cancel the (idempotent)
+ * work item and drain the used ring so del_vqs() finds it empty.
+ */
+static void virtio_usb_hc_evtq_stop_cb(struct virtio_usb *vusb,
+				       struct virtio_usb_queue *vq)
+{
+	virtio_usb_evt_drain_stop_cb(vq, &vusb->vq_host_evt_work);
+}
+
+/**
+ * virtio_usb_host_data_notify_cb() - Data virtqueue notification callback.
+ *
+ * The data virtqueue is shared across all host-role VPs; the work item
+ * that drains it lives on struct virtio_usb, not on any specific VP.
+ */
+static void virtio_usb_host_data_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_usb *vusb = vqueue->vdev->priv;
+
+	schedule_work(&vusb->vq_host_data_rx_work);
+}
+
+const struct virtio_usb_vq_desc host_vqueues[VIRTIO_USB_VQ_HOST_MAX] = {
+	[VIRTIO_USB_VQ_COMMAND_IDX] = {
+			.callback = virtio_usb_cmd_notify_cb,
+			.name = "virtusb-host-cmd",
+			.process = virtio_usb_cmd_process_cb,
+			.stop = virtio_usb_cmdq_stop_cb,
+			},
+	[VIRTIO_USB_VQ_EVENT_IDX] = {
+			.callback = virtio_usb_hc_evt_notify_cb,
+			.name = "virtusb-host-evt",
+			.process = NULL,
+			.stop = virtio_usb_hc_evtq_stop_cb,
+			},
+	[VIRTIO_USB_VQ_DATA_IDX] = {
+			.callback = virtio_usb_host_data_notify_cb,
+			.name = "virtusb-host-data",
+			.process = NULL,
+			.stop = virtio_usb_hc_dataq_stop_cb,
+			},
+};
diff --git a/drivers/usb/virtio_usb/host.h b/drivers/usb/virtio_usb/host.h
new file mode 100644
index 0000000..8c5a233
--- /dev/null
+++ b/drivers/usb/virtio_usb/host.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * virtio_usb: VirtIO USB device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef VIRTIO_USB_HOST_H
+#define VIRTIO_USB_HOST_H
+
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/virtio.h>
+
+#include <uapi/linux/usb/ch11.h>
+#include <uapi/linux/usb/ch9.h>
+
+#include "controller.h"
+
+/**
+ * struct virtio_usb_port_hs_status - High speed port wPortStatus
+ * See USB 2.0 spec Table 11-21
+ */
+struct virtio_usb_port_hs_status {
+	u16 connect : 1;
+	u16 enable : 1;
+	u16 suspend : 1;
+	u16 over_current : 1;
+	u16 reset : 1;
+	u16 reserved0 : 3;
+	u16 power : 1;
+	u16 low_speed : 1;
+	u16 high_speed : 1;
+	u16 test_mode : 1;
+	u16 indicator_control : 1;
+	u16 reserved1 : 3;
+};
+
+/**
+ * virtio_usb_port_hs_change - High speed port wPortChange
+ * See USB 2.0 spec Table 11-22
+ */
+struct virtio_usb_port_hs_change {
+	u16 connect : 1;
+	u16 enable : 1;
+	u16 suspend : 1;
+	u16 over_current : 1;
+	u16 reset : 1;
+	u16 reserved : 11;
+};
+
+/**
+ * struct virtio_usb_port_ss_status - Super speed port wPortStatus
+ * See USB 3.1 spec Table 10-13.
+ */
+struct virtio_usb_port_ss_status {
+	u16 connect : 1;
+	u16 enable : 1;
+	u16 reserved0 : 1;
+	u16 over_current : 1;
+	u16 reset : 1;
+	u16 link_state : 4;
+	u16 power : 1;
+	u16 speed : 3;
+	u16 reserved1 : 3;
+};
+
+/**
+ * struct virtio_usb_port_ss_change - Super speed port wPortChange.
+ * See USB 3.1 spec Table 10-14.
+ */
+struct virtio_usb_port_ss_change {
+	u16 connect : 1;
+	u16 reserved0 : 2;
+	u16 over_current : 1;
+	u16 reset : 1;
+	u16 bh_reset : 1;
+	u16 link_state : 1;
+	u16 config_error : 1;
+	u16 reserved1 : 8;
+};
+
+/**
+ * struct virtio_usb_hc_port - VirtIO USB host controller port.
+ *
+ * One slot in a VP's root hub. Pre-allocated at VP init time and reused
+ * across connect/disconnect cycles - never dynamically freed.
+ *
+ * @vhcd_vp: Per-VP host controller this port belongs to
+ * @pending_urb_list: Pending URB list to the port
+ * @speed: Speed of current device connected to the port
+ * @port_id: Slot index within the VP (0..VIRTIO_USB_VP_MAX_PORTS-1)
+ * @lock: Spinlock that protects fields shared by interrupt handlers and
+ *        hcd operation callback
+ * @hs: High speed Port Status and Port Change structure
+ * @ss: Super speed Port Status and Port Change structure
+ */
+struct virtio_usb_hc_port {
+	struct virtio_usb_hc_vp *vhcd_vp;
+	struct list_head pending_urb_list;
+	enum usb_device_speed speed;
+	u32 port_id;
+	spinlock_t lock;
+	struct {
+		/* USB 2.0 port status bits */
+		union {
+			struct virtio_usb_port_hs_status bits;
+			u16 value;
+		} status;
+		/* USB 2.0 port status change bits */
+		union {
+			struct virtio_usb_port_hs_change bits;
+			u16 value;
+		} change;
+	} hs;
+	struct {
+		/* USB 3.0 port status bits */
+		union {
+			struct virtio_usb_port_ss_status bits;
+			u16 value;
+		} status;
+		/* USB 3.0 port status change bits */
+		union {
+			struct virtio_usb_port_ss_change bits;
+			u16 value;
+		} change;
+	} ss;
+};
+
+/**
+ * struct virtio_usb_hc_vp - Per-VP VirtIO USB Host controller.
+ *
+ * One instance per host-role virtual port (physical USB socket).
+ * Pointed to by virtio_usb_port.vhc - NULL for device-role VPs,
+ * mirroring how virtio_usb_port.vudc works for device-role VPs.
+ *
+ * All VIRTIO_USB_VP_MAX_PORTS port structs are pre-allocated at init
+ * time and reused across connect/disconnect cycles.
+ *
+ * @vusb:         VirtIO usb device
+ * @vp_idx:       Index of this VP in vusb->vports[]
+ * @hs:           High speed usb_hcd for this VP
+ * @ss:           Super speed usb_hcd for this VP
+ * @ports:        Pre-allocated port state array, one entry per slot
+ * @hcqs:         Host virtqueue wrappers, indexed by VIRTIO_USB_VQ_*_IDX
+ *                (shared across VPs)
+ * @lock:         Spinlock protecting HC state for this VP
+ */
+struct virtio_usb_hc_vp {
+	struct virtio_usb *vusb;
+	unsigned int vp_idx;
+	struct usb_hcd *hs;
+	struct usb_hcd *ss;
+	struct virtio_usb_hc_port ports[VIRTIO_USB_VP_MAX_PORTS];
+	struct virtio_usb_queue *hcqs[VIRTIO_USB_VQ_HOST_MAX];
+	spinlock_t lock;
+};
+
+extern const struct virtio_usb_vq_desc host_vqueues[VIRTIO_USB_VQ_HOST_MAX];
+
+/**
+ * vhcd_get() - Get pointer to per-VP host controller stored in hcd_priv.
+ * @hcd: usb_hcd
+ */
+static inline struct virtio_usb_hc_vp *vhcd_get(struct usb_hcd *hcd)
+{
+	return ((void **)hcd->hcd_priv)[0];
+}
+
+/**
+ * vhcd_set() - Store per-VP host controller pointer in hcd_priv.
+ * @hcd: usb_hcd
+ * @vhcd_vp: per-VP host controller
+ */
+static inline void vhcd_set(struct usb_hcd *hcd,
+			    struct virtio_usb_hc_vp *vhcd_vp)
+{
+	((void **)hcd->hcd_priv)[0] = vhcd_vp;
+}
+
+/**
+ * port_vhcd_get() - Get the usb_hcd that owns this port's speed.
+ * @port: VirtIO usb host controller port
+ *
+ * Returns the SS hcd for SuperSpeed and SuperSpeed+ devices,
+ * HS hcd for everything else.
+ */
+static inline struct usb_hcd *port_vhcd_get(struct virtio_usb_hc_port *port)
+{
+	return (port->speed == USB_SPEED_SUPER ||
+		port->speed == USB_SPEED_SUPER_PLUS) ?
+		       port->vhcd_vp->ss :
+		       port->vhcd_vp->hs;
+}
+
+int virtio_usb_hc_vp_init(struct virtio_usb *vusb, unsigned int vp_idx);
+int virtio_usb_hc_vp_deinit(struct virtio_usb *vusb, unsigned int vp_idx);
+int virtio_usb_hc_event_populate(struct virtio_usb *vusb);
+void virtio_usb_hc_rx_work(struct work_struct *work);
+void virtio_usb_hc_evt_work(struct work_struct *work);
+
+#endif
diff --git a/include/uapi/linux/virtio_usb.h b/include/uapi/linux/virtio_usb.h
index b9dc448..459edc1 100644
--- a/include/uapi/linux/virtio_usb.h
+++ b/include/uapi/linux/virtio_usb.h
@@ -106,6 +106,14 @@ enum {
 	VIRTIO_USB_EVT_HOST_PORT_DISCONNECTED,
 };
 
+/* Maximum number of leaf-device slots per virtual port (physical socket).
+ * Each VP's root hub advertises exactly this many ports to the guest hub
+ * driver. Leaf devices (direct or behind a physical hub) are flattened
+ * into slots 0..VIRTIO_USB_VP_MAX_PORTS-1 of their VP's root hub.
+ * Must be <= USB_MAXCHILDREN (31) and <= USB_SS_MAXPORTS (15).
+ */
+#define VIRTIO_USB_VP_MAX_PORTS 8
+
 /* VIRTIO_USB_EVT_HOST_PORT_CONNECTED/DISCONNECTED */
 enum {
 	VIRTIO_USB_SPEED_UNKNOWN = 0,
@@ -119,9 +127,9 @@ enum {
 
 struct virtio_usb_host_port_event {
 	__le32 code; /* VIRTIO_USB_EVT_HOST_PORT_XXX */
-	__le32 port_id;
+	__le32 vp_idx; /* virtual port (physical socket) index, 0..nports-1 */
+	__le32 port_id; /* leaf slot within VP, 0..VIRTIO_USB_VP_MAX_PORTS-1 */
 	__le32 speed; /* VIRTIO_USB_SPEED_XXX */
-	__le32 padding;
 };
 
 /*****************************************************************************
@@ -210,10 +218,12 @@ enum {
 
 struct virtio_usb_request {
 	__le64 tag;
-	__le16 port; /* Port ID */
+	__le16 vp_idx; /* virtual port (physical socket) index, host role only */
+	__le16 port; /* Port ID (leaf slot within vp_idx for host role) */
 	__le16 endpoint; /* Endpoint ID */
 	__le16 transfer_type; /* VIRTIO_USB_EP_XXX */
 	__le16 transfer_flags; /* VIRTIO_USB_FLAG_XXX */
+	__le16 padding;
 	union {
 		/* transfer_type = VIRTIO_USB_EP_CONTROL */
 		struct {
diff --git a/drivers/usb/virtio_usb/vq_common.c b/drivers/usb/virtio_usb/vq_common.c
new file mode 100644
index 0000000..baaf29d
--- /dev/null
+++ b/drivers/usb/virtio_usb/vq_common.c
@@ -0,0 +1,740 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio-usb: Virtio usb device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "controller.h"
+#include "vq_common.h"
+
+/**
+ * struct virtio_usb_cmd_generic_hdr - Generic command header
+ * for the command
+ * @code: command code
+ * @value: value for the command
+ */
+struct virtio_usb_cmd_generic_hdr {
+	__le32 code;
+	__le32 value;
+};
+
+/**
+ * virtio_error_to_usb - Convert virtio error to usb error
+ * @error: virtio error code
+ *
+ * Context: Any context.
+ * Return: virtio error converted to usb error code
+ */
+int virtio_error_to_usb(unsigned int error)
+{
+	int status;
+
+	switch (error) {
+	case VIRTIO_USB_S_OK:
+		status = 0;
+		break;
+	case VIRTIO_USB_S_ERR_CANCELLED:
+		/* cancelled */
+		status = -ECONNRESET;
+		break;
+		/* device shutdown or removal*/
+	case VIRTIO_USB_S_ERR_NO_DEVICE:
+		status = -ESHUTDOWN;
+		break;
+	case VIRTIO_USB_S_ERR_STALL:
+		status = -EPIPE;
+		break;
+	case VIRTIO_USB_S_ERR_OVERFLOW:
+		status = -EOVERFLOW;
+		break;
+	case VIRTIO_USB_S_ERR_SHORT_PKT:
+		/* short packet */
+		status = -EREMOTEIO;
+		break;
+	case VIRTIO_USB_S_ERR_BAD_MSG:
+		status = -EINVAL;
+		break;
+	case VIRTIO_USB_S_ERR_DATA_IN:
+		status = -ECOMM;
+		break;
+	case VIRTIO_USB_S_ERR_DATA_OUT:
+		status = -ENOSR;
+		break;
+	case VIRTIO_USB_S_ERR_ISO_XFER:
+		status = -EXDEV;
+		break;
+	case VIRTIO_USB_S_ERR_ISO_BIG:
+		status = -EFBIG;
+		break;
+	case VIRTIO_USB_S_ERR_MSG_SIZE:
+		status = -EMSGSIZE;
+		break;
+	case VIRTIO_USB_S_ERR_INTERNAL:
+	default:
+		status = -EPROTO;
+		break;
+	}
+	return status;
+}
+
+/**
+ * virtio_usb_msg_ref() - Increment reference counter for the message.
+ * @msg: common message.
+ *
+ * Context: Any context.
+ */
+static void virtio_usb_msg_ref(struct virtio_usb_msg_common *msg)
+{
+	refcount_inc(&msg->ref_count);
+}
+
+/**
+ * virtio_usb_msg_unref() - Decrement reference counter for the message.
+ * @msg: common message.
+ *
+ * The message will be freed when the ref_count value is 0.
+ *
+ * Context: Any context.
+ */
+static void virtio_usb_msg_unref(struct virtio_usb_msg_common *msg)
+{
+	if (refcount_dec_and_test(&msg->ref_count))
+		kfree(msg);
+}
+
+/**
+ * virtio_usb_msg_request() - Get a pointer to the request header.
+ * @msg: common message.
+ *
+ * Context: Any context.
+ */
+static void *virtio_usb_msg_request(struct virtio_usb_msg_common *msg)
+{
+	return sg_virt(&msg->sg_request);
+}
+
+/**
+ * virtio_usb_msg_response() - Get a pointer to the response header.
+ * @msg: common message.
+ *
+ * Context: Any context.
+ */
+static void *virtio_usb_msg_response(struct virtio_usb_msg_common *msg)
+{
+	return sg_virt(&msg->sg_response);
+}
+
+/**
+ * virtio_usb_msg_alloc() - Allocate and initialize a message.
+ * @msg_size: Size of the requested message.
+ * @request_size: Size of request header.
+ * @response_size: Size of response header.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, NULL on failure.
+ */
+static void *virtio_usb_msg_alloc(size_t msg_size, size_t request_size,
+				  size_t response_size, gfp_t gfp)
+{
+	struct virtio_usb_msg_common *msg;
+
+	if (!msg_size || !request_size || !response_size)
+		return NULL;
+
+	msg = kzalloc(msg_size + request_size + response_size, gfp);
+	if (!msg)
+		return NULL;
+
+	sg_init_one(&msg->sg_request, (u8 *)msg + msg_size, request_size);
+	sg_init_one(&msg->sg_response, (u8 *)msg + msg_size + request_size,
+		    response_size);
+
+	refcount_set(&msg->ref_count, 1);
+
+	return msg;
+}
+
+/**
+ * virtio_usb_cmd_ref() - Increment reference counter for the command.
+ * @cmd: Command message.
+ *
+ * Context: Any context.
+ */
+void virtio_usb_cmd_ref(struct virtio_usb_cmd *cmd)
+{
+	virtio_usb_msg_ref((struct virtio_usb_msg_common *)cmd);
+}
+
+/**
+ * virtio_usb_cmd_unref() - Decrement reference counter for the command.
+ * @cmd: Command message.
+ *
+ * The message will be freed when the ref_count value is 0.
+ *
+ * Context: Any context.
+ */
+void virtio_usb_cmd_unref(struct virtio_usb_cmd *cmd)
+{
+	virtio_usb_msg_unref((struct virtio_usb_msg_common *)cmd);
+}
+
+/**
+ * virtio_usb_cmd_request() - Get a pointer to the request header.
+ * @cmd: Command msg.
+ *
+ * Context: Any context.
+ */
+void *virtio_usb_cmd_request(struct virtio_usb_cmd *cmd)
+{
+	return virtio_usb_msg_request((struct virtio_usb_msg_common *)cmd);
+}
+
+/**
+ * virtio_usb_cmd_response() - Get a pointer to the response header.
+ * @cmd: command message.
+ *
+ * Context: Any context.
+ */
+void *virtio_usb_cmd_response(struct virtio_usb_cmd *cmd)
+{
+	return virtio_usb_msg_response((struct virtio_usb_msg_common *)cmd);
+}
+
+/**
+ * virtio_usb_cmd_alloc() - Allocate and initialize a control message.
+ * @request_size: Size of request header.
+ * @response_size: Size of response header.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, NULL on failure.
+ */
+struct virtio_usb_cmd *virtio_usb_cmd_alloc(size_t request_size,
+					    size_t response_size, gfp_t gfp)
+{
+	struct virtio_usb_cmd *cmd;
+
+	if (!request_size || !response_size)
+		return NULL;
+
+	cmd = virtio_usb_msg_alloc(sizeof(*cmd), request_size, response_size,
+				   gfp);
+	if (!cmd)
+		return NULL;
+
+	init_completion(&cmd->notify);
+
+	return cmd;
+}
+
+/**
+ * virtio_usb_cmd_msg_send() - Function to send command message to the
+ * command virtqueue
+ * @vusb: VirtIO usb device.
+ * @msg: common message.
+ * @out_sgs: Additional sg-list to attach to the request header (may be NULL).
+ * @in_sgs: Additional sg-list to attach to the response header (may be NULL).
+ *
+ * Context: Any context. Takes and releases the command queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_cmd_msg_send(struct virtio_usb *vusb,
+				   struct virtio_usb_msg_common *msg,
+				   struct scatterlist *out_sgs,
+				   struct scatterlist *in_sgs)
+{
+	struct virtio_usb_queue *queue = msg->queue;
+	unsigned int nouts = 0, nins = 0;
+	struct scatterlist *psgs[4];
+	bool notify = false;
+	unsigned long flags;
+	int rc = 0;
+
+	psgs[nouts++] = &msg->sg_request;
+	if (out_sgs)
+		psgs[nouts++] = out_sgs;
+
+	psgs[nouts + nins++] = &msg->sg_response;
+	if (in_sgs)
+		psgs[nouts + nins++] = in_sgs;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
+			       GFP_ATOMIC);
+	if (!rc)
+		notify = virtqueue_kick_prepare(queue->vqueue);
+	spin_unlock_irqrestore(&queue->lock, flags);
+
+	if (rc)
+		goto on_exit;
+
+	if (notify)
+		virtqueue_notify(queue->vqueue);
+
+on_exit:
+	return rc;
+}
+
+/**
+ * virtio_usb_cmd_send() - Send a command to the command virtqueue
+ * @vusb: VirtIO usb device.
+ * @cmd: command message.
+ * @out_sgs: Additional sg-list to attach to the request header (may be NULL).
+ * @in_sgs: Additional sg-list to attach to the response header (may be NULL).
+ * @nowait: Flag indicating whether to wait for completion.
+ *
+ * Context: Any context. Takes and releases the command queue spinlock.
+ *          May sleep if @nowait is false.
+ * Return: The return value is a message status code (VIRTIO_USB_S_XXX) converted to an
+ * appropriate -errno value.
+ */
+int virtio_usb_cmd_send(struct virtio_usb *vusb, struct virtio_usb_cmd *cmd,
+			struct scatterlist *out_sgs, struct scatterlist *in_sgs,
+			bool nowait)
+{
+	unsigned int js = msecs_to_jiffies(virtio_usb_cmd_timeout_ms);
+	struct virtio_usb_cmd_generic_hdr *request =
+		virtio_usb_cmd_request(cmd);
+	struct virtio_usb_cmd_status *response = virtio_usb_cmd_response(cmd);
+	struct virtio_device *vdev = vusb->vdev;
+	int rc;
+	u32 code;
+
+	/* Set the default status in case the command was canceled. */
+	response->code = cpu_to_le32(VIRTIO_USB_S_ERR_CANCELLED);
+
+	virtio_usb_cmd_ref(cmd);
+
+	rc = virtio_usb_cmd_msg_send(vusb, (struct virtio_usb_msg_common *)cmd,
+				     out_sgs, in_sgs);
+	if (rc) {
+		dev_err(&vdev->dev, "failed to send control message (0x%08x)\n",
+			le32_to_cpu(request->code));
+
+		/*
+		 * Since in this case virtio_usb_cmd_process_cb() will not be
+		 * called, it is necessary to decrement the reference count.
+		 */
+		virtio_usb_cmd_unref(cmd);
+		goto on_exit;
+	}
+
+	if (nowait)
+		goto on_exit;
+
+	rc = wait_for_completion_interruptible_timeout(&cmd->notify, js);
+	if (rc <= 0) {
+		if (!rc) {
+			dev_err(&vdev->dev,
+				"control message (0x%08x) timeout\n",
+				le32_to_cpu(request->code));
+			rc = -ETIMEDOUT;
+		}
+
+		goto on_exit;
+	}
+
+	code = le32_to_cpu(response->code);
+
+	rc = virtio_error_to_usb(code);
+
+on_exit:
+	virtio_usb_cmd_unref(cmd);
+	return rc;
+}
+
+/**
+ * virtio_usb_events_alloc() - Allocates the events.
+ * @vusb: VirtIO USB device
+ * @vq: event virtqueue to which events need to be populated.
+ * @evt_size: Size of the event structure.
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure
+ */
+struct virtio_usb_event *virtio_usb_events_alloc(struct virtio_usb *vusb,
+						 struct virtio_usb_queue *vq,
+						 size_t evt_size)
+{
+	unsigned int n = virtqueue_get_vring_size(vq->vqueue);
+	struct virtio_device *vdev = vusb->vdev;
+	struct virtio_usb_event *events, *event;
+	unsigned int i;
+
+	events = devm_kcalloc(&vdev->dev, n, (sizeof(*events) + evt_size),
+			      GFP_KERNEL);
+	if (!events)
+		return NULL;
+
+	for (i = 0; i < n; i++) {
+		event = (void *)events + i * (sizeof(*event) + evt_size);
+		event->evt_size = evt_size;
+		event->queue = vq;
+		sg_init_one(&event->sg_event, (void *)event + sizeof(*event),
+			    evt_size);
+		event->vusb = vusb;
+	}
+	return events;
+}
+
+/**
+ * virtio_usb_events_populate() - Add preallocated events to the event queue.
+ * @events: Pointer to preallocated virtio usb events
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure
+ */
+int virtio_usb_events_populate(struct virtio_usb_event *events)
+{
+	unsigned int n = virtqueue_get_vring_size(events[0].queue->vqueue);
+	size_t evt_size = events[0].evt_size;
+	struct virtio_usb_event *event;
+	unsigned int i, rc = 0;
+
+	for (i = 0; i < n; i++) {
+		event = (void *)events + i * (sizeof(*event) + evt_size);
+		rc = virtqueue_add_inbuf(event->queue->vqueue, &event->sg_event,
+					 1, event, GFP_KERNEL);
+		if (rc)
+			return rc;
+	}
+	/* Notify the backend that event buffers are available so it can
+	 * deliver any pending PORT_CONNECTED events immediately.
+	 */
+	virtqueue_notify(events[0].queue->vqueue);
+	return rc;
+}
+
+/**
+ * virtio_usb_event_buf() - Get the event buffer.
+ * @event: The virtio_usb_event
+ *
+ * Context: Any context.
+ * Return: Pointer to the event buffer
+ */
+void *virtio_usb_event_buf(struct virtio_usb_event *event)
+{
+	return sg_virt(&event->sg_event);
+}
+
+/**
+ * virtio_usb_event_send() - Send an event to the specified event queue.
+ * @event: The event that needs to be send
+ *
+ *
+ * Context: Any context which expects the event queue spinlock to be held by
+ *          caller.
+ * Return: 0 on success -errno on failure
+ */
+int virtio_usb_event_send(struct virtio_usb_event *event)
+{
+	int rc = 0;
+	void *event_buf = virtio_usb_event_buf(event);
+
+	/* reset event content */
+	memset(event_buf, 0, event->evt_size);
+
+	rc = virtqueue_add_inbuf(event->queue->vqueue, &event->sg_event, 1,
+				 event, GFP_ATOMIC);
+	if (rc)
+		return rc;
+
+	if (virtqueue_kick_prepare(event->queue->vqueue))
+		virtqueue_notify(event->queue->vqueue);
+	return rc;
+}
+
+/**
+ * virtio_usb_data_ref() - Increment reference counter for the data.
+ * @data: Data message.
+ *
+ * Context: Any context.
+ */
+void virtio_usb_data_ref(struct virtio_usb_data *data)
+{
+	virtio_usb_msg_ref((struct virtio_usb_msg_common *)data);
+}
+
+/**
+ * virtio_usb_data_unref() - Decrement reference counter for the data.
+ * @data: Data message.
+ *
+ * The data will be freed when the ref_count value is 0.
+ *
+ * Context: Any context.
+ */
+void virtio_usb_data_unref(struct virtio_usb_data *data)
+{
+	virtio_usb_msg_unref((struct virtio_usb_msg_common *)data);
+}
+
+/**
+ * virtio_usb_data_request() - Get a pointer to the request header.
+ * @data: Data message.
+ *
+ * Context: Any context.
+ */
+void *virtio_usb_data_request(struct virtio_usb_data *data)
+{
+	return virtio_usb_msg_request((struct virtio_usb_msg_common *)data);
+}
+
+/**
+ * virtio_usb_data_priv() - Get a pointer to the data priv.
+ * @data: Data message.
+ *
+ * Context: Any context.
+ */
+void *virtio_usb_data_priv(struct virtio_usb_data *data)
+{
+	if (!data)
+		return NULL;
+
+	return data->priv;
+}
+
+/**
+ * virtio_usb_data_response() - Get a pointer to the response header.
+ * @data: Data message.
+ *
+ * Context: Any context.
+ */
+void *virtio_usb_data_response(struct virtio_usb_data *data)
+{
+	return virtio_usb_msg_response((struct virtio_usb_msg_common *)data);
+}
+
+/**
+ * virtio_usb_data_alloc() - Allocate and initialize a data message.
+ * @request_size: Size of request header.
+ * @response_size: Size of response header.
+ * @priv_size: Size of priv context of the data.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, NULL on failure.
+ */
+struct virtio_usb_data *virtio_usb_data_alloc(size_t request_size,
+					      size_t response_size,
+					      size_t priv_size, gfp_t gfp)
+{
+	struct virtio_usb_data *data;
+
+	if (!request_size || !response_size || !priv_size)
+		return NULL;
+
+	data = virtio_usb_msg_alloc(sizeof(*data) + priv_size, request_size,
+				    response_size, gfp);
+	if (!data)
+		return NULL;
+	data->priv = (u8 *)data + sizeof(*data);
+
+	return data;
+}
+
+/**
+ * virtio_usb_data_send() - Send a data message
+ * @vusb: VirtIO usb device.
+ * @data: Data message.
+ * @out_sgs: Additional sg-list to attach to the request header
+ * @in_sgs: Additional sg-list to attach to the response header
+ *
+ * Context: Any context. Takes and releases the data queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtio_usb_data_send(struct virtio_usb *vusb, struct virtio_usb_data *data,
+			 struct scatterlist *out_sgs,
+			 struct scatterlist *in_sgs)
+{
+	struct virtio_usb_queue *queue = data->msg.queue;
+	struct scatterlist *psgs[4] = { NULL };
+	unsigned int nouts = 0, nins = 0;
+	bool notify = false;
+	int rc = 0;
+
+	psgs[nouts++] = &data->msg.sg_request;
+	if (out_sgs)
+		psgs[nouts++] = out_sgs;
+
+	psgs[nouts + nins++] = &data->msg.sg_response;
+	if (in_sgs)
+		psgs[nouts + nins++] = in_sgs;
+
+	spin_lock_irq(&queue->lock);
+	rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, data,
+			       GFP_ATOMIC);
+	if (!rc)
+		notify = virtqueue_kick_prepare(queue->vqueue);
+	spin_unlock_irq(&queue->lock);
+
+	if (rc)
+		goto on_exit;
+
+	if (notify)
+		virtqueue_notify(queue->vqueue);
+
+on_exit:
+	return rc;
+}
+
+/**
+ * virtio_usb_cmd_notify_cb() - command virtqueue
+ * notification callback
+ * @vqueue: Underlying virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from the
+ * device.
+ *
+ * Context: Interrupt context.
+ */
+void virtio_usb_cmd_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_usb *vusb = vqueue->vdev->priv;
+	struct virtio_usb_queue *vq = &vusb->vqueues[vqueue->index];
+	unsigned long flags;
+	u32 length;
+	void *buf;
+
+	spin_lock_irqsave(&vq->lock, flags);
+	do {
+		virtqueue_disable_cb(vqueue);
+		while ((buf = virtqueue_get_buf(vqueue, &length)))
+			vq->process(vusb, buf);
+		if (unlikely(virtqueue_is_broken(vqueue)))
+			break;
+	} while (!virtqueue_enable_cb(vqueue));
+	spin_unlock_irqrestore(&vq->lock, flags);
+}
+
+/**
+ * virtio_usb_cmd_process_cb() - process callback for commands.
+ * @vusb: VirtIO usb device.
+ * @buf: Pointer to the command message
+ *
+ * Context: Interrupt context.  Expects the command queue spinlock to be held by
+ *          caller.
+ */
+void virtio_usb_cmd_process_cb(struct virtio_usb *vusb, void *buf)
+{
+	struct virtio_usb_cmd *cmd = (struct virtio_usb_cmd *)buf;
+
+	complete(&cmd->notify);
+	virtio_usb_cmd_unref(cmd);
+}
+
+/**
+ * virtio_usb_cmdq_stop_cb() - Stops the command virtqueue
+ * @vusb: VirtIO usb device.
+ * @cmdq: The command virtqueue to be stopped
+ *
+ * Context: Any context.
+ */
+void virtio_usb_cmdq_stop_cb(struct virtio_usb *vusb,
+			     struct virtio_usb_queue *cmdq)
+{
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+
+	if (cmdq->vqueue) {
+		spin_lock_irqsave(&cmdq->lock, flags);
+		virtqueue_disable_cb(cmdq->vqueue);
+
+		while ((cmd = virtqueue_detach_unused_buf(cmdq->vqueue)))
+			cmdq->process(vusb, cmd);
+
+		spin_unlock_irqrestore(&cmdq->lock, flags);
+	}
+}
+
+/**
+ * virtio_usb_dataq_stop_cb() - Stops the data virtqueue
+ * @vusb: VirtIO usb device.
+ * @dataq: The data virtqueue to be stopped.
+ *
+ * Context: Any context.
+ */
+void virtio_usb_dataq_stop_cb(struct virtio_usb *vusb,
+			      struct virtio_usb_queue *dataq)
+{
+	if (dataq->vqueue) {
+		spin_lock_irq(&dataq->lock);
+		virtqueue_disable_cb(dataq->vqueue);
+		spin_unlock_irq(&dataq->lock);
+	}
+}
+
+/**
+ * virtio_usb_evt_work() - Generic event queue receive worker.
+ * @evtq: The event virtqueue to drain.
+ * @process_one: Callback invoked for each dequeued event, with the
+ *               queue's own lock released (the callback is free to
+ *               sleep / send further virtio commands).
+ *
+ * Common drain loop shared by every role's own event queue: dequeue
+ * completed event buffers, hand each one to @process_one, then
+ * immediately re-arm and resend it via virtio_usb_event_send() so the
+ * backend always has a full set of event buffers available.
+ *
+ * Context: Process context.
+ */
+void virtio_usb_evt_work(struct virtio_usb_queue *evtq,
+			 void (*process_one)(struct virtio_usb_event *event))
+{
+	u32 length;
+	struct virtio_usb_event *event;
+
+	spin_lock(&evtq->lock);
+	do {
+		while ((event = virtqueue_get_buf(evtq->vqueue, &length))) {
+			spin_unlock(&evtq->lock);
+			process_one(event);
+			spin_lock(&evtq->lock);
+			virtio_usb_event_send(event);
+		}
+		if (unlikely(virtqueue_is_broken(evtq->vqueue)))
+			break;
+	} while (!virtqueue_enable_cb(evtq->vqueue));
+	spin_unlock(&evtq->lock);
+}
+
+/**
+ * virtio_usb_evt_drain_stop_cb() - Generic event queue stop callback.
+ * @vq: The event virtqueue to stop.
+ * @work: The work item that drains @vq via virtio_usb_evt_work(), to
+ *        be cancelled before draining (may be NULL if the caller has
+ *        already cancelled it, or must defer cancellation itself).
+ *
+ * Do not process events during teardown - whatever state process_one()
+ * would touch may already be partially torn down (probe failure) or
+ * gone (remove path). Just drain the used ring without processing, so
+ * virtio core's del_vqs() finds it empty.
+ *
+ * Context: Any context that permits to sleep (if @work is non-NULL).
+ */
+void virtio_usb_evt_drain_stop_cb(struct virtio_usb_queue *vq,
+				  struct work_struct *work)
+{
+	unsigned long flags;
+	u32 length;
+	void *buf;
+
+	if (!vq->vqueue)
+		return;
+
+	if (work)
+		cancel_work_sync(work);
+
+	spin_lock_irqsave(&vq->lock, flags);
+	virtqueue_disable_cb(vq->vqueue);
+	while ((buf = virtqueue_get_buf(vq->vqueue, &length)))
+		;
+	spin_unlock_irqrestore(&vq->lock, flags);
+}
diff --git a/drivers/usb/virtio_usb/vq_common.h b/drivers/usb/virtio_usb/vq_common.h
new file mode 100644
index 0000000..28755f3
--- /dev/null
+++ b/drivers/usb/virtio_usb/vq_common.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * virtio-usb: Virtio usb device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef VIRTIO_USB_COMMON_H
+#define VIRTIO_USB_COMMON_H
+
+#include <linux/atomic.h>
+#include <linux/virtio.h>
+
+#include "controller.h"
+
+/**
+ * struct virtio_usb_msg_common - Common message structure
+ * for command and data message
+ * @sg_request: Scattergather list containing a device request (header).
+ * @sg_response: Scattergather list containing a device response (status).
+ * @queue: Virtqueue wrapper
+ * @ref_count: Reference count used to manage a message lifetime.
+ */
+struct virtio_usb_msg_common {
+	struct scatterlist sg_request;
+	struct scatterlist sg_response;
+	struct virtio_usb_queue *queue;
+	refcount_t ref_count;
+};
+
+/**
+ * struct virtio_usb_cmd - Command message
+ * @msg: Common message
+ * @notify: Request completed notification.
+ */
+struct virtio_usb_cmd {
+	struct virtio_usb_msg_common msg;
+	struct completion notify;
+};
+
+void virtio_usb_cmd_ref(struct virtio_usb_cmd *cmd);
+void virtio_usb_cmd_unref(struct virtio_usb_cmd *cmd);
+void *virtio_usb_cmd_request(struct virtio_usb_cmd *cmd);
+void *virtio_usb_cmd_response(struct virtio_usb_cmd *cmd);
+
+struct virtio_usb_cmd *virtio_usb_cmd_alloc(size_t request_size,
+					    size_t response_size, gfp_t gfp);
+int virtio_usb_cmd_send(struct virtio_usb *vusb, struct virtio_usb_cmd *cmd,
+			struct scatterlist *out_sgs, struct scatterlist *in_sgs,
+			bool nowait);
+
+/**
+ * virtio_usb_cmd_send_sync - Simplified sending of synchronous message.
+ * @vusb: VirtIO usb device.
+ * @out_sgs: Additional sg-list to attach to the request header (may be NULL).
+ * @in_sgs: Additional sg-list to attach to the response header (may be NULL).
+ * @cmd: Command message.
+ *
+ * After returning from this function, the message will be deleted. If message
+ * content is still needed, the caller must additionally to
+ * virtio_usb_cmd_ref/unref() it.
+ *
+ * The msg_timeout_ms module parameter defines the message completion timeout.
+ * If the message is not completed within this time, the function will return an
+ * error.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ *
+ * The return value is a message status code (VIRTIO_USB_S_XXX) converted to an
+ * appropriate -errno value.
+ */
+static inline int virtio_usb_cmd_send_sync(struct virtio_usb *vusb,
+					   struct scatterlist *out_sgs,
+					   struct scatterlist *in_sgs,
+					   struct virtio_usb_cmd *cmd)
+{
+	return virtio_usb_cmd_send(vusb, cmd, out_sgs, in_sgs, false);
+}
+
+/**
+ * virtio_usb_cmd_send_async() - Simplified sending of asynchronous message.
+ * @vusb: VirtIO usb device.
+ * @out_sgs: Additional sg-list to attach to the request header (may be NULL).
+ * @in_sgs: Additional sg-list to attach to the response header (may be NULL).
+ * @cmd: Command message..
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static inline int virtio_usb_cmd_send_async(struct virtio_usb *vusb,
+					    struct scatterlist *out_sgs,
+					    struct scatterlist *in_sgs,
+					    struct virtio_usb_cmd *cmd)
+{
+	return virtio_usb_cmd_send(vusb, cmd, out_sgs, in_sgs, true);
+}
+
+/**
+ * struct virtio_usb_data - Data message.
+ * @msg: Common message
+ * @list: VirtIO usb data list entry.
+ * @priv: Pointer to priv structure.
+ */
+struct virtio_usb_data {
+	struct virtio_usb_msg_common msg;
+	struct list_head list;
+	void *priv;
+};
+
+void *virtio_usb_data_request(struct virtio_usb_data *data);
+void *virtio_usb_data_response(struct virtio_usb_data *data);
+void *virtio_usb_data_priv(struct virtio_usb_data *data);
+void virtio_usb_data_ref(struct virtio_usb_data *data);
+void virtio_usb_data_unref(struct virtio_usb_data *data);
+
+struct virtio_usb_data *virtio_usb_data_alloc(size_t request_size,
+					      size_t response_size,
+					      size_t priv_size, gfp_t gfp);
+
+int virtio_usb_data_send(struct virtio_usb *vusb, struct virtio_usb_data *data,
+			 struct scatterlist *out_sgs,
+			 struct scatterlist *in_sgs);
+
+void virtio_usb_cmd_notify_cb(struct virtqueue *vqueue);
+
+void virtio_usb_cmd_process_cb(struct virtio_usb *vusb, void *value);
+
+void virtio_usb_cmdq_stop_cb(struct virtio_usb *vusb,
+			     struct virtio_usb_queue *vq);
+void virtio_usb_dataq_stop_cb(struct virtio_usb *vusb,
+			      struct virtio_usb_queue *vq);
+
+/**
+ * struct virtio_usb_event - Event message.
+ * @work: Optional Kernel work to handle the event.
+ * @sg_event: Scattergather list containing a event.
+ * @queue: Virtqueue wrqapper
+ * @vusb: Virtio usb device
+ * @evt_size: size of event buffer
+ */
+struct virtio_usb_event {
+	struct work_struct work;
+	struct scatterlist sg_event;
+	struct virtio_usb_queue *queue;
+	struct virtio_usb *vusb;
+	size_t evt_size;
+};
+
+struct virtio_usb_event *virtio_usb_events_alloc(struct virtio_usb *vusb,
+						 struct virtio_usb_queue *vq,
+						 size_t evt_size);
+int virtio_usb_events_populate(struct virtio_usb_event *events);
+int virtio_usb_event_send(struct virtio_usb_event *event);
+void *virtio_usb_event_buf(struct virtio_usb_event *event);
+int virtio_error_to_usb(unsigned int error);
+
+void virtio_usb_evt_work(struct virtio_usb_queue *evtq,
+			 void (*process_one)(struct virtio_usb_event *event));
+void virtio_usb_evt_drain_stop_cb(struct virtio_usb_queue *vq,
+				  struct work_struct *work);
+
+#endif /* VIRTIO_USB_COMMON_H */
