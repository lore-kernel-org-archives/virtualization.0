Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403D4A498F
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266186; cv=none; b=h5NtrIaxBHuPfiMFog2QYEmE1Y4u4Ywwaaj4gZN15drOSCGk0ZhoqLedR0qxc+S/yauHZsRs8NnuZh6XtWSPW2q68RX0wBBljsByc4ZzGe5ZR80UXRBULThmkSuaSnoSkSqhhpONUctY83ayE9qkOsWFBrnmpgpU9h5iLnvHDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266186; c=relaxed/simple;
	bh=s6IKStopcdvBCxC62yjpsalV9GqDwcN3iOqBbeNc8jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE2xUC1P+8VxDIABNxu5+UgN+k+mkSgpTsbF8lXmTYZwVhdRjDAqcwr53Zf5BbIQaP7cAgUa85fxRnqi3Q8X+YAT23e0xgpQEpDGJPJvrZm7FGq9BFB9ljGkoDpFbhBhTFjkvoyVQzqBAG2gWC1jNWU+EIgd3MnXsOK/WYQMF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PnJ58tRG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WxftRpUh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PnJ58tRG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WxftRpUh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFeVqd3064815
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jTpUHq6eMW+
	ZfgynHNOYD0myxFPF3D55VX7Ear9Il/M=; b=PnJ58tRG0fREcW1/YjEELux+9Dp
	mBB9bYpv0AO/wGphv9LyncmJbmqJY+innYnGY8jD/t7zqR70BrmuhaC8xoWJkjD0
	NyGO5KvbmOB+iUMfMZUTlnEBWbcHLVYj4j0osCbZZrej6J36DEvAiZJfbxo7ccOw
	35wcz0QNBLoE5Qk27I45oM6H31HSct5jDIFxYRdFfK/M7BbjhmJXb9zLbRadcDX4
	2yrYfknd0M4tW7XXKGfUdoHI3XkJ7BGYeRUUdHUcvLTjkEvd6mfwwIxyzdU0AQ54
	gJDVjlBGTnJsWxGjceTuiOwgAdXBT0XKW7yGwbKftSWTpvIQ24iV5eb3cUw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjhfcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:41 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7a9378b844dso673220137.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790266180; x=1790870980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTpUHq6eMW+ZfgynHNOYD0myxFPF3D55VX7Ear9Il/M=;
        b=WxftRpUhmCsVKAyhVPrM2y0WpfFiBI1ztgxCON1lrm2knbRRWW1lHb9WPbyRMLijsR
         u5cRzmb7bLmgx6u4eXBVbRSiM7a0ZTXbycx5zNowBme2tIufFAxCw4DisSw2+072/1gJ
         W5QOjZSdbM/F2aubvhf+QDO5EoObXwm8bfC60mHxSsW2YQ+F/nCex7FjDaiYNiBrfelz
         DZibcSXDJNIWzN0BoeU2ZJvP35kjLSnhC4WTvUEmPq2wPOpCtdFsyt3m67xsHf3o/2NZ
         UdU7CqXASeY3+PeXRJ0kZii2X7c/rQFEaYzlAlcNJDiC/o8Ys/AV0byqlb2AEhkUIVu9
         JA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266180; x=1790870980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTpUHq6eMW+ZfgynHNOYD0myxFPF3D55VX7Ear9Il/M=;
        b=IidGuXjmSv7otacmdHk/bOP7P+MZVUzVxQe+1MQ/InhsMbh4/liqRw0iBe7XSk91Fl
         J6Q17wBc79dz77mPrfZUXWvZ5SyYNphxQpzzvKCP75Dwj4aCFRcy9x+s4ez9UtyjZIfz
         pIGlApJx71QrS+KsVxWHxe73ri5sRTPHqDGTvaWsHV2G5znX7FnELUSB6fIOkqs0ljG6
         gnn2yOiByTi17yKHbn9aeYShSvLy170bh8rD1dqBvGmKXL6aius7NyGjSEzTDgzHIcCJ
         7nZ61eFl3h5CfayaTawV+vrNZbOdHeYs4scPrHB23DyUp1sGmbYrO/Rjv9OrSIPkGiL8
         4a7A==
X-Gm-Message-State: AFuF++lpWgZ6djPmpZpT8zF/ufjL5EYxQs8+bNm8hYe/mn/D+lezB630
	DkEKfPKOXv5/pr/k/tBrf/giAl6XzkF4WMz/ZW07+B/b5Hl011bpPnhXw/thTuU8e1FbRep2rFt
	RzjuZe3JbLUqd1ntpkMe4IAjHOM+//MCybXU1evRZX+SWP8HOGNr3EXwXwzNvfvbomfAWPg==
X-Gm-Gg: AYBFou3WcKJE4z+K97MQ0a8Agu7AGkOSm5jrEU5dmdA0enHF6NnKp5eK7Tg/Qr/e3ft
	xF0TthaWf6DAKfGn1RzfwT72pHpVavIKb4DjVP0x0UYDaK4UZhTJCjZBIpm3miyYUoOoYaT5Fab
	9Zb7fJIZ2JRHlWsSx6T3l7go1GFD94PtPizYxFLphMIfAkUQ3FkqNqrmQCBDl3B0jzMFNE0giiQ
	OjC+SSeZ1dNh7mQWyxyxkiqufxK4FR7wz+u3WWsA2OPslrgX2jfPtenlnGu6NFHicgPdNvWSZRM
	UZr3cLN/5SXhybdes7mFSzu67rxocGLQVFLQzy3zHk6WnxhISP2OkB1E8ki0f2bV/E2FcXJRfDK
	g438WNznLvJ7okeJXnfoBGRW8s6JktGU=
X-Received: by 2002:a05:6102:4421:b0:7a1:f980:e936 with SMTP id ada2fe7eead31-7af1e4f703cmr1391949137.18.1790266179539;
        Thu, 24 Sep 2026 09:09:39 -0700 (PDT)
X-Received: by 2002:a05:6102:4421:b0:7a1:f980:e936 with SMTP id ada2fe7eead31-7af1e4f703cmr1391907137.18.1790266178300;
        Thu, 24 Sep 2026 09:09:38 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5c4csm328306766b.18.2026.09.24.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:09:37 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 3/8] virtio-usb: add device role (USB Device Controller) support
Date: Thu, 24 Sep 2026 18:09:02 +0200
Message-ID: <20260924160907.145405-4-igor.skalkin@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: EUj06NYSoUCKClzaDfeNEd2sOZbejGTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX/FAgIu1QQ18k
 LPYHd6gDht/VD1bcowWEtJRg45GsD32/1vwcN/DRNNyjQ+iAotKNm2BGiU78eqf5J33vT6Z6COC
 oJ02AIAOtO7xr0JfmfWM8prKY1S8YTVf3ipMX17DWpQZW+5+RtelUFYtbM6kxZiAVbroJXcOJGE
 YsHfVQgcrjjWCDGyidFqM/dRNVBDF/y133ZVavkh2tDxDlGaQDPPK61toLsGdb//YMzl1mvmXeM
 cZjjf7fi3s4DtPj2YZ7boJh5FLD4R94jF5QAtjlecBSLOSCobng2ntglgShKVjc31AXjYwAXu0y
 5QTOk/TOT208pwcFzgyRRerDpnEVq1K2PnccWHPrHP0iYcbx+2Bdt1QwjyIMjZZBNqhvpEaH+q8
 1YpWhmut2/WiYO4GbPCehy+XjBlrd5XUMQdEVnb1e1ceokwdkF2t9xo8D1GE/ymDwbNC0jktuIc
 mHWSI2xAN/Ym/UpFbkQ==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab54b45 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=17RnLt0UfJqkVi85R4MA:9 a=ghLhWPcnnaphjT8X:21 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: EUj06NYSoUCKClzaDfeNEd2sOZbejGTn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX/3Kz02rGomcW
 8qbJHvHb8MSdJNLKYv56YLSPpGsWqcRf7fgHqbRCycWoljRTjIMHuk3maxKvrelDE48IJG7HuOt
 gU2HYF1pC5SB9mnStuZZ2LWGROG5WfY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240066

From: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>

Add the device (UDC) role: implement the usb_gadget_ops and
usb_ep_ops callback sets, handle BIND/UNBIND/DISCONNECTED events
from the host backend and forward setup/suspend/resume/reset
notifications to the UDC core, and extend the protocol header with
the endpoint and command messages the device role needs.

Each device-role virtual port gets its own struct virtio_usb_dc and
UDC registration, one per vports[] entry, instead of a single global
device controller - mirroring the per-VP model host role already
uses, since a device-role port is just as independent as a host-role
one. Each gadget gets a name derived from its port index, and its
endpoint name buffer is allocated dynamically instead of using a
stack variable that would outlive the calling function.

This driver virtualizes an entire UDC per device-role port: each port
maps 1:1 to a single struct usb_gadget/UDC instance owned by exactly
one guest. A separate approach - USB function-level virtualization,
where a single physical UDC hosts a composite gadget whose
individual functions are each routed to a different guest - is
currently being explored and is out of scope for this driver.

Hardware endpoint names are used directly as the virtual endpoint
names, since the endpoint name has a relation with the endpoint
address.

Keep the device lifecycle separate from link-state notifications
from the start: BIND registers the UDC and UNBIND tears it down,
while DISCONNECTED is only a transient link-state notification (a
disconnect may be followed by SETUP without a new bind, so it must
not free UDC resources). This aligns the guest-side lifecycle with
the host-side callbacks: BIND -> (SETUP / DISCONNECT / RESET /
SUSPEND / RESUME)* -> UNBIND.

Each port also registers its UDC under its own intermediate
platform_device instead of the shared virtio_device, created on BIND
and torn down on the matching UNBIND. usb_add_gadget_udc() derives
the UDC's class name from its parent kobject's name, and every
device-role port registering under the same shared parent would
collide.

The UDC driver is marked nonatomic, since some gadget API calls
performed under a spinlock cannot be completed atomically due to the
round trip over virtio to the backend.

With both host_role and device_role negotiated, a port's actual role
is ambiguous until a later commit adds an OTG-based per-port query -
every port defaults to DEVICE for now as a placeholder.

Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
Co-developed-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
Signed-off-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
Co-developed-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
---
 drivers/usb/virtio_usb/Makefile     |    3 
 drivers/usb/virtio_usb/controller.c |   75 +
 drivers/usb/virtio_usb/controller.h |   17 
 drivers/usb/virtio_usb/device.c     | 1356 ++++++++++++++++++++++++++++++++++++
 drivers/usb/virtio_usb/device.h     |   91 ++
 include/uapi/linux/virtio_usb.h     |   37 
 6 files changed, 1566 insertions(+), 13 deletions(-)
 create mode 100644 drivers/usb/virtio_usb/device.c
 create mode 100644 drivers/usb/virtio_usb/device.h

diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb/controller.c
index 216edfc..0646807 100644
--- a/drivers/usb/virtio_usb/controller.c
+++ b/drivers/usb/virtio_usb/controller.c
@@ -11,6 +11,7 @@
 
 #include "controller.h"
 #include "host.h"
+#include "device.h"
 #include "vq_common.h"
 
 u32 virtio_usb_cmd_timeout_ms = MSEC_PER_SEC;
@@ -77,7 +78,8 @@ static int virtio_usb_validate(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	if (!virtio_has_feature(vdev, VIRTIO_USB_F_HOST)) {
+	if (!virtio_has_feature(vdev, VIRTIO_USB_F_HOST) &&
+	    !virtio_has_feature(vdev, VIRTIO_USB_F_DEVICE)) {
 		dev_err(&vdev->dev,
 			"device should support at least one usb role\n");
 		return -EINVAL;
@@ -123,17 +125,40 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_USB_F_HOST))
 		vusb->host_role = 1;
 
-	/* Only host_role exists so far, so every port is unambiguously a
-	 * host-role port. Later commits (device role, OTG) will replace
-	 * this with real per-port role resolution.
+	if (virtio_has_feature(vdev, VIRTIO_USB_F_DEVICE))
+		vusb->device_role = 1;
+
+	/* Only allocate/negotiate the virtqueue triplets this instance
+	 * actually needs: HOST_* only exists when host_role is negotiated,
+	 * DEV_* only when device_role is negotiated. A pure single-role
+	 * instance therefore has exactly VIRTIO_USB_VQ_HOST_MAX (3) or
+	 * VIRTIO_USB_VQ_DEV_MAX (3) virtqueues, not a fixed layout - queues
+	 * that don't exist on the wire must not be created, since a peer
+	 * with no host-role VP has no host command/event/data queues to
+	 * negotiate at all.
 	 */
 	vusb->host_vq_base = -1;
+	vusb->dev_vq_base = -1;
+
 	if (vusb->host_role) {
 		vusb->host_vq_base = nvqs;
 		nvqs += VIRTIO_USB_VQ_HOST_MAX;
+	}
+	if (vusb->device_role) {
+		vusb->dev_vq_base = nvqs;
+		nvqs += VIRTIO_USB_VQ_DEV_MAX;
+	}
 
-		for (i = 0; i < vusb->nports; i++)
+	/* Resolve every port's role. With only one role negotiated, every
+	 * port unambiguously has that role. With both negotiated, a port's
+	 * own role is ambiguous until a later commit adds an OTG-based
+	 * per-port query - default to DEVICE for now as a placeholder.
+	 */
+	for (i = 0; i < vusb->nports; i++) {
+		if (vusb->host_role && !vusb->device_role)
 			vusb->vports[i].role = VIRTIO_USB_ROLE_HOST;
+		else if (vusb->device_role)
+			vusb->vports[i].role = VIRTIO_USB_ROLE_DEVICE;
 	}
 
 	vusb->vqueues = devm_kcalloc(&vdev->dev, nvqs, sizeof(*vusb->vqueues),
@@ -155,6 +180,18 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 				host_vqueues[i].stop;
 		}
 
+	if (vusb->dev_vq_base >= 0)
+		for (i = 0; i < VIRTIO_USB_VQ_DEV_MAX; i++) {
+			vusb->vqueues[vusb->dev_vq_base + i].name =
+				dev_vqueues[i].name;
+			vusb->vqueues[vusb->dev_vq_base + i].callback =
+				dev_vqueues[i].callback;
+			vusb->vqueues[vusb->dev_vq_base + i].process =
+				dev_vqueues[i].process;
+			vusb->vqueues[vusb->dev_vq_base + i].stop =
+				dev_vqueues[i].stop;
+		}
+
 	rc = virtio_usb_find_vqs(vusb);
 	if (rc) {
 		dev_err(&vdev->dev, "%s virtio_usb_find_vqs() error(%d)\n",
@@ -190,6 +227,30 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 		}
 	}
 
+	if (vusb->device_role) {
+		INIT_WORK(&vusb->vq_dev_data_rx_work, virtio_usb_dc_data_work);
+		INIT_WORK(&vusb->vq_dev_event_work, virtio_usb_dc_event_work);
+
+		for (i = 0; i < vusb->nports; i++) {
+			if (vusb->vports[i].role != VIRTIO_USB_ROLE_DEVICE)
+				continue;
+			rc = virtio_usb_dc_init(vusb, i);
+			if (rc) {
+				dev_err(&vdev->dev,
+					"%s virtio_usb_dc_init() port=%d error(%d)\n",
+					__func__, i, rc);
+				goto on_error;
+			}
+		}
+		rc = virtio_usb_dc_event_populate(vusb);
+		if (rc) {
+			dev_err(&vdev->dev,
+				"%s virtio_usb_dc_event_populate() error(%d)\n",
+				__func__, rc);
+			goto on_error;
+		}
+	}
+
 	virtio_device_ready(vdev);
 
 	return rc;
@@ -219,6 +280,9 @@ static void virtio_usb_remove(struct virtio_device *vdev)
 			virtio_usb_hc_vp_deinit(vusb, i);
 	}
 
+	if (vusb->device_role && vusb->vports)
+		virtio_usb_dc_deinit(vusb);
+
 	virtio_reset_device(vdev);
 
 	vdev->config->del_vqs(vdev);
@@ -226,6 +290,7 @@ static void virtio_usb_remove(struct virtio_device *vdev)
 
 static const unsigned int virtio_usb_features[] = {
 	VIRTIO_USB_F_HOST,
+	VIRTIO_USB_F_DEVICE,
 };
 
 static const struct virtio_device_id id_table[] = {
diff --git a/drivers/usb/virtio_usb/controller.h b/drivers/usb/virtio_usb/controller.h
index af68a77..ec59922 100644
--- a/drivers/usb/virtio_usb/controller.h
+++ b/drivers/usb/virtio_usb/controller.h
@@ -16,21 +16,26 @@
 
 /* Forward declaration - full definition in host.h */
 struct virtio_usb_hc_vp;
+/* Forward declaration - full definition in device.h */
+struct virtio_usb_dc;
 
 #define VIRTIO_USB_VQ_COMMAND_IDX 0
 #define VIRTIO_USB_VQ_EVENT_IDX 1
 #define VIRTIO_USB_VQ_DATA_IDX 2
 
 #define VIRTIO_USB_VQ_HOST_MAX 3
+#define VIRTIO_USB_VQ_DEV_MAX 3
 
 /**
  * struct virtio_usb_port - Per-virtual-port state.
  * @role: Role of this port (VIRTIO_USB_ROLE_HOST or _DEVICE).
  * @vhc: Host controller - non-NULL when role is HOST.
+ * @vudc: Device controller - non-NULL when role is DEVICE.
  */
 struct virtio_usb_port {
 	unsigned int role;
 	struct virtio_usb_hc_vp *vhc;
+	struct virtio_usb_dc *vudc;
 };
 
 /**
@@ -41,14 +46,22 @@ struct virtio_usb_port {
  * @nports: number of supported ports
  * @nvqs: number of virtqueues for the device
  * @host_role: flag indicating support for host role
+ * @device_role: flag indicating support for device role
  * @host_vq_base: index into vqueues[] where the HOST_COMMAND/EVENT/DATA
  *                triplet starts, or -1 if this instance has no host-role
  *                VP (in which case those queues do not exist on the wire
  *                and must not be negotiated).
+ * @dev_vq_base: index into vqueues[] where the DEV_COMMAND/EVENT/DATA
+ *               triplet starts, or -1 if this instance has no
+ *               device-role VP.
  * @vq_host_data_rx_work: Kernel work draining the host data queue, shared
  *                        across every host-role VP.
  * @vq_host_evt_work: Kernel work draining the host event queue, shared
  *                     across every host-role VP.
+ * @vq_dev_data_rx_work: Kernel work draining the device data queue, shared
+ *                       across every device-role port.
+ * @vq_dev_event_work: Kernel work draining the device event queue, shared
+ *                      across every device-role port.
  */
 struct virtio_usb {
 	struct virtio_device *vdev;
@@ -57,9 +70,13 @@ struct virtio_usb {
 	unsigned int nports;
 	u32 nvqs;
 	bool host_role;
+	bool device_role;
 	int host_vq_base;
+	int dev_vq_base;
 	struct work_struct vq_host_data_rx_work;
 	struct work_struct vq_host_evt_work;
+	struct work_struct vq_dev_data_rx_work;
+	struct work_struct vq_dev_event_work;
 };
 
 /**
diff --git a/drivers/usb/virtio_usb/Makefile b/drivers/usb/virtio_usb/Makefile
index 1111111..2222222 100644
--- a/drivers/usb/virtio_usb/Makefile
+++ b/drivers/usb/virtio_usb/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 virtio-usb-y := controller.o \
 	vq_common.o \
-	host.o
+	host.o \
+	device.o
 
 obj-$(CONFIG_USB_VIRTIO) += virtio-usb.o
diff --git a/drivers/usb/virtio_usb/device.c b/drivers/usb/virtio_usb/device.c
new file mode 100644
index 0000000..798c265
--- /dev/null
+++ b/drivers/usb/virtio_usb/device.c
@@ -0,0 +1,1356 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio_usb: VirtIO USB device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <uapi/linux/virtio_usb.h>
+
+#include "controller.h"
+#include "device.h"
+
+#define GADGET_NAME "virtio_usb_dc"
+
+/**
+ * struct virtio_usb_dc_priv - Device controller data priv
+ * Structure for UDC related data in data messages
+ * @req: usb_request structure
+ * @vep: virtio usb endpoint
+ * @vreq: virtio-usb request
+ */
+struct virtio_usb_dc_priv {
+	struct usb_request req;
+	struct virtio_usb_ep *vep;
+	struct virtio_usb_data *vreq;
+};
+
+/**
+ * usb_ep_to_virtio_ep() - Get the virtio usb endpoint from usb endpoint
+ * @ep: usb endpoint
+ *
+ * Context: Any context.
+ * Return: Pointer to virtio_usb_ep
+ */
+static struct virtio_usb_ep *usb_ep_to_virtio_ep(struct usb_ep *ep)
+{
+	return container_of(ep, struct virtio_usb_ep, ep);
+}
+
+/**
+ * usb_ep_dir_in() - check if the endpoint has IN direction
+ * @ep: usb endpoint
+ *
+ * Context: Any context.
+ * Return: 1 if direction is USB_DIR_IN else 0
+ */
+static unsigned int usb_ep_dir_in(struct usb_ep *ep)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	unsigned int direction = 0;
+
+	if (ep->address == 0)
+		direction = vep->setup.bRequestType & USB_DIR_IN ? 1 : 0;
+	else if (ep->desc && ep->desc->bEndpointAddress)
+		direction = usb_endpoint_dir_in(ep->desc) ? 1 : 0;
+
+	return direction;
+}
+
+/**
+ * usb_req_to_virtio_data() - Get the virtio usb data message from usb_request
+ * @req: usb_request structure
+ *
+ * Context: Any context.
+ * Return: virtio usb data message
+ */
+static struct virtio_usb_data *usb_req_to_virtio_data(struct usb_request *req)
+{
+	struct virtio_usb_dc_priv *priv =
+		container_of(req, struct virtio_usb_dc_priv, req);
+
+	return priv->vreq;
+}
+
+/**
+ * virtio_usb_dc_complete_req() - Completes a usb request
+ * @vreq: virtio usb data message.
+ *
+ * Context: Process context.
+ */
+static void virtio_usb_dc_complete_req(struct virtio_usb_data *vreq)
+{
+	struct virtio_usb_response *response = virtio_usb_data_response(vreq);
+	struct virtio_usb_dc_priv *priv = virtio_usb_data_priv(vreq);
+	unsigned int status = le32_to_cpu(response->status);
+	struct usb_request *req = &priv->req;
+	struct virtio_usb_ep *vep = priv->vep;
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_data *vreq_iter;
+	unsigned int found = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+
+	list_for_each_entry(vreq_iter, &vep->req_queue, list) {
+		if (vreq_iter == vreq) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return;
+	}
+	if (req->status != -ECONNRESET && req->status != -ESHUTDOWN) {
+		req->status = virtio_error_to_usb(status);
+		if (!req->status)
+			req->actual = le32_to_cpu(response->actual_length);
+	}
+
+	list_del_init(&vreq->list);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+	virtio_usb_data_unref(vreq);
+	usb_gadget_giveback_request(&vep->ep, req);
+}
+
+/**
+ * virtio_usb_dc_data_work() - Worker to get all completed data message
+ * from the virtqueue and call the completion handler.
+ * @work: kernel work to handle data message completion.
+ *
+ * Context: Process context.
+ */
+void virtio_usb_dc_data_work(struct work_struct *work)
+{
+	struct virtio_usb *vusb =
+		container_of(work, struct virtio_usb, vq_dev_data_rx_work);
+	struct virtio_usb_queue *dataq =
+		&vusb->vqueues[vusb->dev_vq_base + VIRTIO_USB_VQ_DATA_IDX];
+	struct virtio_usb_data *vreq;
+	unsigned int length;
+
+	spin_lock_irq(&dataq->lock);
+	do {
+		virtqueue_disable_cb(dataq->vqueue);
+		while ((vreq = virtqueue_get_buf(dataq->vqueue, &length))) {
+			spin_unlock_irq(&dataq->lock);
+			virtio_usb_dc_complete_req(vreq);
+			spin_lock_irq(&dataq->lock);
+		}
+		if (unlikely(virtqueue_is_broken(dataq->vqueue)))
+			break;
+	} while (!virtqueue_enable_cb(dataq->vqueue));
+	spin_unlock_irq(&dataq->lock);
+}
+
+/**
+ * virtio_usb_dc_data_alloc() - Allocate and initialize a device controller
+ * data message.
+ * @ep: VirtIO usb device
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated data message on success, NULL on failure.
+ */
+static struct virtio_usb_data *virtio_usb_dc_data_alloc(struct usb_ep *ep,
+							gfp_t gfp)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	struct virtio_usb_request *request;
+	struct virtio_usb_response *response;
+	size_t request_size = sizeof(*request);
+	size_t response_size = sizeof(*response);
+	struct virtio_usb_dc_priv *priv;
+	struct virtio_usb_data *vreq;
+
+	vreq = virtio_usb_data_alloc(request_size, response_size,
+				     sizeof(struct virtio_usb_dc_priv), gfp);
+	if (!vreq)
+		return NULL;
+
+	priv = virtio_usb_data_priv(vreq);
+	priv->vep = vep;
+	priv->vreq = vreq;
+	vreq->msg.queue =
+		&vep->vudc->vusb->vqueues[vep->vudc->vusb->dev_vq_base +
+					  VIRTIO_USB_VQ_DATA_IDX];
+
+	request = virtio_usb_data_request(vreq);
+
+	request->tag = cpu_to_le64((uintptr_t)vreq);
+
+	return vreq;
+}
+
+/**
+ * virtio_usb_dc_cmd_alloc() - Allocate and initialize the device controller
+ * command message.
+ * @vusb: VirtIO usb device
+ * @command: command message
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated command message on success, NULL on failure.
+ */
+static struct virtio_usb_cmd *
+virtio_usb_dc_cmd_alloc(struct virtio_usb_dc *vudc, unsigned int command,
+			gfp_t gfp)
+{
+	size_t request_size = sizeof(struct virtio_usb_dev_cmd_hdr);
+	size_t response_size = sizeof(struct virtio_usb_cmd_status);
+	struct virtio_usb_cmd_status *status;
+	struct virtio_usb_dev_cmd_hdr *hdr;
+	struct virtio_usb_cmd *cmd;
+
+	switch (command) {
+	case VIRTIO_USB_CMD_DEV_GET_ENDPOINT_COUNT:
+		response_size = sizeof(struct virtio_usb_dev_ep_count);
+		break;
+	case VIRTIO_USB_CMD_DEV_GET_FRAME_NUMBER:
+		response_size = sizeof(struct virtio_usb_dev_frame_number);
+		break;
+	case VIRTIO_USB_CMD_DEV_CANCEL:
+		request_size = sizeof(struct virtio_usb_dev_cmd_cancel);
+		break;
+	case VIRTIO_USB_CMD_DEV_VBUS_DRAW:
+	case VIRTIO_USB_CMD_DEV_PULLUP:
+	case VIRTIO_USB_CMD_DEV_EP_SET_HALT:
+	case VIRTIO_USB_CMD_DEV_SET_SELF_POWERED:
+		request_size = sizeof(struct virtio_usb_dev_cmd_set_value);
+		break;
+	}
+
+	cmd = virtio_usb_cmd_alloc(request_size, response_size, gfp);
+	if (!cmd)
+		return NULL;
+
+	hdr = virtio_usb_cmd_request(cmd);
+	status = virtio_usb_cmd_response(cmd);
+
+	hdr->code = cpu_to_le32(command);
+	hdr->port = cpu_to_le16(vudc->port);
+	cmd->msg.queue = &vudc->vusb->vqueues[vudc->vusb->dev_vq_base +
+					      VIRTIO_USB_VQ_COMMAND_IDX];
+	status->code = cpu_to_le32(VIRTIO_USB_S_ERR_CANCELLED);
+	return cmd;
+}
+
+/* Endpoint callbacks */
+
+/**
+ * virtio_ep_enable() - Enable endpoint
+ * This callback is called to configure endpoint and make it usable.
+ * It is called to enable all endpoints except ep0
+ * @ep: endpoint object
+ * @desc: endpoint descriptor
+ *
+ * Context: Any context.
+ */
+static int virtio_ep_enable(struct usb_ep *ep,
+			    const struct usb_endpoint_descriptor *desc)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct scatterlist sg;
+	struct scatterlist *psg_data = &sg;
+	struct virtio_usb_dev_cmd_hdr *hdr;
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+	u16 endpoint;
+	int rc;
+
+	if (!vudc->driver)
+		return -ESHUTDOWN;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+
+	if (!ep || !desc || ep->caps.type_control ||
+	    desc->bDescriptorType != USB_DT_ENDPOINT) {
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return -EINVAL;
+	}
+
+	ep->desc = desc;
+	ep->maxpacket = usb_endpoint_maxp(desc);
+	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
+						     VIRTIO_USB_EP_DIR_OUT);
+
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_ENABLE,
+				      GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	sg_init_one(psg_data, desc, sizeof(*desc));
+	hdr = virtio_usb_cmd_request(cmd);
+	hdr->endpoint = cpu_to_le16(endpoint);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, psg_data, NULL, cmd);
+
+	return rc;
+}
+
+/**
+ * virtio_ep_disable() - Disable endpoint
+ * This callback is called to disable endpoint which was
+ * enabled using ep_enable callback
+ * @ep: endpoint object
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_ep_disable(struct usb_ep *ep)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	struct virtio_usb_data *vreq = NULL, *vreq_tmp;
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_dc_priv *priv = NULL;
+	struct virtio_usb_dev_cmd_hdr *hdr;
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+	u16 endpoint;
+	int rc;
+
+	if (!ep || ep->caps.type_control)
+		return -EINVAL;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+
+	list_for_each_entry_safe(vreq, vreq_tmp, &vep->req_queue, list) {
+		priv = virtio_usb_data_priv(vreq);
+		/**
+		 * When endpoint is disabled, completion handler for all pending
+		 * requests will be called. Make the request status to -ESHUTDOWN
+		 * to prevent requests completes even before the endpoint disable
+		 * is send to the controller.
+		 */
+		priv->req.status = -ESHUTDOWN;
+	}
+	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
+						     VIRTIO_USB_EP_DIR_OUT);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_DISABLE,
+				      GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	hdr = virtio_usb_cmd_request(cmd);
+	hdr->endpoint = cpu_to_le16(endpoint);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+
+	return rc;
+}
+
+/**
+ * virtio_ep_alloc_request() - Allocates request
+ * @ep: Endpoint object associated with request
+ * @mem_flags: mem flags
+ *
+ * Return: allocated request address, NULL on allocation error
+ */
+static struct usb_request *virtio_ep_alloc_request(struct usb_ep *ep,
+						   gfp_t mem_flags)
+{
+	struct virtio_usb_dc_priv *priv;
+	struct virtio_usb_data *vreq;
+
+	vreq = virtio_usb_dc_data_alloc(ep, mem_flags);
+	if (!vreq)
+		return NULL;
+
+	priv = virtio_usb_data_priv(vreq);
+
+	return &priv->req;
+}
+
+/**
+ * virtio_ep_free_request() - Free memory occupied by request
+ * @ep: Endpoint object associated with request
+ * @req: Request to be freed
+ */
+static void virtio_ep_free_request(struct usb_ep *ep, struct usb_request *req)
+{
+	struct virtio_usb_data *vreq = usb_req_to_virtio_data(req);
+
+	virtio_usb_data_unref(vreq);
+}
+
+/**
+ * virtio_ep_queue() - Transfer data on and endpoint
+ * @ep: Pointer to endpoint object
+ * @req: Pointer to request object
+ * @mem_flags: gfp flags
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_ep_queue(struct usb_ep *ep, struct usb_request *req,
+			   gfp_t mem_flags)
+{
+	struct scatterlist *out_sgs = NULL, *in_sgs = NULL, *psg_data;
+	struct virtio_usb_data *vreq = usb_req_to_virtio_data(req);
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_response *response;
+	struct virtio_usb_request *request;
+	u16 transfer_flags = 0;
+	struct scatterlist sg;
+	unsigned long flags;
+	u16 endpoint;
+	int rc;
+
+	virtio_usb_data_ref(vreq);
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	req->actual = 0;
+	req->status = -EINPROGRESS;
+
+	list_add_tail(&vreq->list, &vep->req_queue);
+	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
+						     VIRTIO_USB_EP_DIR_OUT);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	request = virtio_usb_data_request(vreq);
+	response = virtio_usb_data_response(vreq);
+
+	response->actual_length = cpu_to_le32(0);
+	response->status = cpu_to_le32(VIRTIO_USB_S_ERR_INTERNAL);
+
+	if (req->short_not_ok)
+		transfer_flags |= VIRTIO_USB_FLAG_SHORT_NOT_OK;
+	else if (req->zero)
+		transfer_flags |= VIRTIO_USB_FLAG_ZERO_PACKET;
+
+	request->transfer_flags = cpu_to_le16(transfer_flags);
+	request->endpoint = cpu_to_le16(endpoint);
+	request->port = cpu_to_le16(vudc->port);
+
+	if (req->length && req->buf) {
+		psg_data = &sg;
+		sg_init_one(psg_data, req->buf, req->length);
+	} else if (req->length && req->num_sgs > 0) {
+		psg_data = req->sg;
+	} else if (req->sg) {
+		psg_data = &sg;
+		sg_init_one(psg_data, sg_virt(req->sg), req->length);
+	} else {
+		psg_data = NULL;
+	}
+
+	if (usb_ep_dir_in(ep))
+		out_sgs = psg_data;
+	else
+		in_sgs = psg_data;
+
+	rc = virtio_usb_data_send(vudc->vusb, vreq, out_sgs, in_sgs);
+	if (rc)
+		goto on_error_vq;
+
+	return rc;
+
+on_error_vq:
+	spin_lock_irqsave(&vudc->lock, flags);
+	list_del_init(&vreq->list);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	virtio_usb_data_unref(vreq);
+
+	return rc;
+}
+
+/**
+ * virtio_ep_dequeue() - Remove request from transfer queue
+ * @ep: Endpoint object associated with request
+ * @req: Request object
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	struct virtio_usb_dev_cmd_cancel *cancel;
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_dc_priv *priv;
+	struct virtio_usb_data *vreq;
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+	int rc = -EINVAL;
+	u16 endpoint;
+
+	if (!vudc->driver)
+		return -ESHUTDOWN;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+
+	list_for_each_entry(vreq, &vep->req_queue, list) {
+		priv = virtio_usb_data_priv(vreq);
+		if (req == &priv->req) {
+			pr_debug("dequeue for vreq = %p, tag %llx\n", vreq,
+				 (u64)(uintptr_t)vreq);
+			// request will be completed from the completion handler
+			priv->req.status = -ECONNRESET;
+			rc = 0;
+			break;
+		}
+	}
+	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
+						     VIRTIO_USB_EP_DIR_OUT);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	if (rc)
+		return rc;
+
+	vreq = priv->vreq;
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_CANCEL,
+				      GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cancel = virtio_usb_cmd_request(cmd);
+	cancel->hdr.endpoint = cpu_to_le16(endpoint);
+	cancel->hdr.port = cpu_to_le16(vudc->port);
+	cancel->tag = cpu_to_le64((uintptr_t)vreq);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+
+	return rc;
+}
+
+/**
+ * virtio_ep_set_halt() - Sets/clears stall on selected endpoint
+ * @ep: Endpoint object to set/clear stall on
+ * @value: 1 for set stall, 0 for clear stall
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_ep_set_halt(struct usb_ep *ep, int value)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	struct virtio_usb_dev_cmd_set_value *req;
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+	u16 endpoint;
+	int rc;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+
+	/*
+	 * EP0 MUST NOT STALL if a control request is still pending.
+	 * Composite expects -EAGAIN instead of a forced STALL, otherwise
+	 * status stage collapses and the host sees EPROTO/EPIPE.
+	 */
+	if (&vep->ep == vudc->gadget.ep0) {
+		if (value && !list_empty(&vep->req_queue)) {
+			spin_unlock_irqrestore(&vudc->lock, flags);
+			return -EAGAIN;
+		}
+	}
+
+	if (value && ep->desc && usb_ep_dir_in(ep) &&
+	    !list_empty(&vep->req_queue)) {
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return -EAGAIN;
+	}
+	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
+						     VIRTIO_USB_EP_DIR_OUT);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_SET_HALT,
+				      GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	req = virtio_usb_cmd_request(cmd);
+	req->value = cpu_to_le32(value);
+	req->hdr.endpoint = cpu_to_le16(endpoint);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+
+	return rc;
+}
+
+/**
+ * virtio_ep_set_wedge() - Set wedge on selected endpoint
+ * @ep: Endpoint object
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_ep_set_wedge(struct usb_ep *ep)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_dev_cmd_hdr *hdr;
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+	u16 endpoint;
+	int rc;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
+						     VIRTIO_USB_EP_DIR_OUT);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_SET_WEDGE,
+				      GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	hdr = virtio_usb_cmd_request(cmd);
+	hdr->endpoint = cpu_to_le16(endpoint);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+
+	return rc;
+}
+
+static const struct usb_ep_ops virtio_usb_ep_ops = {
+	.enable = virtio_ep_enable,
+	.disable = virtio_ep_disable,
+
+	.alloc_request = virtio_ep_alloc_request,
+	.free_request = virtio_ep_free_request,
+
+	.queue = virtio_ep_queue,
+	.dequeue = virtio_ep_dequeue,
+
+	.set_halt = virtio_ep_set_halt,
+	.set_wedge = virtio_ep_set_wedge,
+};
+
+/*-------------------------------------------------------------------------*/
+/* UDC callbacks */
+
+/**
+ * virtio_usb_dc_set_selfpowered() - Sets the device selfpowered feature.
+ * @gadget: The device being declared as self-powered
+ * @is_selfpowered: Flag indicates if gadget is selfpowered
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_dc_set_selfpowered(struct usb_gadget *gadget,
+					 int is_selfpowered)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(gadget, struct virtio_usb_dc, gadget);
+	unsigned int code = VIRTIO_USB_CMD_DEV_SET_SELF_POWERED;
+	struct virtio_usb_dev_cmd_set_value *req;
+	struct virtio_usb_cmd *cmd;
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	req = virtio_usb_cmd_request(cmd);
+	req->value = cpu_to_le32(!!is_selfpowered);
+
+	return virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+}
+
+/**
+ * virtio_usb_dc_pullup() - Software-controlled connect/disconnect to USB host
+ * @gadget: Pointer to the usb gadget structure.
+ * @is_on: flag to start or stop
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_dc_pullup(struct usb_gadget *gadget, int is_on)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(gadget, struct virtio_usb_dc, gadget);
+	unsigned int code = VIRTIO_USB_CMD_DEV_PULLUP;
+	struct virtio_usb_dev_cmd_set_value *req;
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	is_on = !!is_on;
+	if (is_on == vudc->pullup) {
+		rc = -EALREADY;
+		goto on_unlock;
+	}
+
+	vudc->pullup = is_on;
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	req = virtio_usb_cmd_request(cmd);
+	req->value = cpu_to_le32(is_on);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+
+	return rc;
+
+on_unlock:
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	return rc;
+}
+
+/**
+ * virtio_usb_dc_set_speed() - Sets maximum speed supported by gadget
+ * @gadget: Pointer to the usb gadget structure.
+ * @speed: The maximum speed to allowed to run
+ */
+static void virtio_usb_dc_set_speed(struct usb_gadget *gadget,
+				    enum usb_device_speed speed)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(gadget, struct virtio_usb_dc, gadget);
+
+	vudc->gadget.speed = min_t(u8, USB_SPEED_HIGH, speed);
+
+	switch (speed) {
+	case USB_SPEED_HIGH:
+	case USB_SPEED_FULL:
+		vudc->veps[0].ep.maxpacket = 64;
+		break;
+	case USB_SPEED_LOW:
+		vudc->veps[0].ep.maxpacket = 8;
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * virtio_usb_dc_start() - Starts the device controller.
+ * @gadget: Pointer to the usb gadget structure
+ * @driver: Pointer to gadget driver structure
+ *
+ * Return: zero always
+ */
+static int virtio_usb_dc_start(struct usb_gadget *gadget,
+			       struct usb_gadget_driver *driver)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(gadget, struct virtio_usb_dc, gadget);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	vudc->driver = driver;
+	vudc->pullup = 0;
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	return 0;
+}
+
+/**
+ * virtio_usb_dc_stop() - Stops the device controller.
+ * @gadget: Pointer to the usb gadget structure
+ *
+ * Return: zero always
+ */
+static int virtio_usb_dc_stop(struct usb_gadget *gadget)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(gadget, struct virtio_usb_dc, gadget);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	vudc->driver = NULL;
+	vudc->pullup = 0;
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	return 0;
+}
+
+/**
+ * virtio_usb_dc_vbus_draw() - Constrain controller's VBUS power usage
+ * @gadget: The device whose VBUS usage is being described
+ * @mA: How much current to draw, in milliAmperes.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_dc_vbus_draw(struct usb_gadget *gadget, unsigned int mA)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(gadget, struct virtio_usb_dc, gadget);
+	unsigned int code = VIRTIO_USB_CMD_DEV_VBUS_DRAW;
+	struct virtio_usb_dev_cmd_set_value *req;
+	struct virtio_usb_cmd *cmd;
+	int rc;
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	req = virtio_usb_cmd_request(cmd);
+	req->value = cpu_to_le32(mA);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+
+	return rc;
+}
+
+/**
+ * virtio_usb_dc_get_frame() - returns the current frame number
+ * @gadget: controller that reports the frame number
+ *
+ * Return: Returns the usb frame number, normally eleven bits from
+ * a SOF packet, or -errno on failure.
+ */
+static int virtio_usb_dc_get_frame(struct usb_gadget *gadget)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(gadget, struct virtio_usb_dc, gadget);
+	unsigned int code = VIRTIO_USB_CMD_DEV_GET_FRAME_NUMBER;
+	struct virtio_usb_dev_frame_number *resp;
+	struct virtio_usb_cmd *cmd;
+	int rc;
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+	if (rc)
+		return rc;
+
+	resp = virtio_usb_cmd_response(cmd);
+	rc = le32_to_cpu(resp->frame_number);
+
+	return rc;
+}
+
+static const struct usb_gadget_ops virtio_gadget_ops = {
+	.set_selfpowered = virtio_usb_dc_set_selfpowered,
+	.pullup = virtio_usb_dc_pullup,
+	.udc_start = virtio_usb_dc_start,
+	.udc_stop = virtio_usb_dc_stop,
+	.vbus_draw = virtio_usb_dc_vbus_draw,
+	.udc_set_speed = virtio_usb_dc_set_speed,
+	.get_frame = virtio_usb_dc_get_frame,
+};
+
+/*-------------------------------------------------------------------------*/
+
+/**
+ * virtio_usb_dc_get_endpoint_count() - Function to get the number of
+ * endpoints from the virtio-usb device
+ * @vusb: Virtio usb device
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_dc_get_endpoint_count(struct virtio_usb_dc *vudc)
+{
+	unsigned int code = VIRTIO_USB_CMD_DEV_GET_ENDPOINT_COUNT;
+	struct virtio_usb_dev_ep_count *ep_count;
+	struct virtio_usb_cmd *cmd;
+	int rc;
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	virtio_usb_cmd_ref(cmd);
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+	if (rc)
+		goto on_exit;
+
+	ep_count = virtio_usb_cmd_response(cmd);
+	vudc->neps = le32_to_cpu(ep_count->count);
+	if (!vudc->neps)
+		rc = -EINVAL;
+
+on_exit:
+	virtio_usb_cmd_unref(cmd);
+	return rc;
+}
+
+/**
+ * virtio_usb_dc_get_endpoint_info() - Function to get the endpoint
+ * info from virtio-usb device.
+ * @vusb: Virtio usb device
+ *
+ * Context: Process context.
+ *  Return: 0 on success, -errno on failure.
+ */
+static int virtio_usb_dc_get_endpoint_info(struct virtio_usb_dc *vudc)
+{
+	unsigned int code = VIRTIO_USB_CMD_DEV_GET_ENDPOINT_INFO;
+	struct virtio_usb_dev_ep_info *epinfo;
+	struct virtio_usb_cmd *cmd;
+	struct scatterlist sg;
+	struct scatterlist *psg_data = &sg;
+	int rc, i;
+
+	vudc->veps = kcalloc(vudc->neps, sizeof(*vudc->veps) + sizeof(*epinfo),
+			     GFP_KERNEL);
+	if (!vudc->veps)
+		return -ENOMEM;
+
+	epinfo = (void *)vudc->veps + (sizeof(*vudc->veps) * vudc->neps);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_KERNEL);
+	if (!cmd) {
+		rc = -ENOMEM;
+		goto on_error;
+	}
+	virtio_usb_cmd_ref(cmd);
+
+	sg_init_one(psg_data, epinfo, sizeof(*epinfo) * vudc->neps);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, psg_data, cmd);
+	if (rc) {
+		virtio_usb_cmd_unref(cmd);
+		goto on_error;
+	}
+
+	INIT_LIST_HEAD(&vudc->gadget.ep_list);
+
+	for (i = 0; i < vudc->neps; i++) {
+		struct virtio_usb_ep *vep = &vudc->veps[i];
+		u16 types = le16_to_cpu(epinfo[i].types);
+		u16 directions = le16_to_cpu(epinfo[i].directions);
+		struct usb_ep_caps caps = VIRTIO_USB_EP_CAPS(types, directions);
+		unsigned int maxpacket_limit =
+			le16_to_cpu(epinfo[i].maxpacket_limit);
+
+		strscpy(vep->name, epinfo[i].name, sizeof(vep->name));
+		vep->ep_id = i;
+		vep->ep.caps = caps;
+		vep->ep.name = vep->name;
+		vep->ep.ops = &virtio_usb_ep_ops;
+		INIT_LIST_HEAD(&vep->req_queue);
+		list_add_tail(&vep->ep.ep_list, &vudc->gadget.ep_list);
+		usb_ep_set_maxpacket_limit(&vep->ep, maxpacket_limit);
+		vep->ep.max_streams = le16_to_cpu(epinfo[i].max_streams);
+		vep->vudc = vudc;
+	}
+	virtio_usb_cmd_unref(cmd);
+	vudc->gadget.ep0 = &vudc->veps[0].ep;
+	list_del_init(&vudc->veps[0].ep.ep_list);
+
+	return rc;
+
+on_error:
+	kfree(vudc->veps);
+	vudc->veps = NULL;
+	return rc;
+}
+
+static int virtio_usb_dc_parent_create(struct virtio_usb_dc *vudc)
+{
+	int rc;
+
+	vudc->pdev = platform_device_alloc(GADGET_NAME, vudc->port);
+	if (!vudc->pdev)
+		return -ENOMEM;
+
+	vudc->pdev->dev.parent = &vudc->vusb->vdev->dev;
+	rc = platform_device_add(vudc->pdev);
+	if (rc) {
+		platform_device_put(vudc->pdev);
+		vudc->pdev = NULL;
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * virtio_usb_dc_event_process() - Event process function
+ * @event: virtio_usb_event
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
+{
+	struct virtio_usb_dev_event *evt = virtio_usb_event_buf(event);
+	struct virtio_usb_dev_setup_event *setup_evt;
+	struct virtio_usb *vusb = event->vusb;
+	struct virtio_usb_dc *vudc;
+	struct usb_gadget_driver *driver;
+	struct virtio_usb_ep *vep;
+	unsigned long flags;
+	int rc = 0;
+	unsigned short port_id = le16_to_cpu(evt->port);
+
+	if (!vusb->nports || port_id >= vusb->nports) {
+		dev_err(&vusb->vdev->dev, "%s port[%d] index out of range\n",
+			__func__, port_id);
+		return;
+	}
+
+	vudc = vusb->vports[port_id].vudc;
+	driver = vudc->driver;
+
+	switch (le32_to_cpu(evt->code)) {
+	case VIRTIO_USB_EVT_DEV_BIND: {
+		if (vudc->registered) {
+			dev_err(&vusb->vdev->dev,
+				"port %d: BIND while still registered, ignoring\n",
+				port_id);
+			rc = -EBUSY;
+			break;
+		}
+
+		memzero_explicit(&vudc->gadget, sizeof(struct usb_gadget));
+		vudc->gadget.sg_supported = 1;
+		rc = virtio_usb_dc_get_endpoint_count(vudc);
+		if (rc) {
+			dev_err(&vusb->vdev->dev,
+				"Failed to get endpoint count\n");
+			break;
+		}
+		rc = virtio_usb_dc_get_endpoint_info(vudc);
+		if (rc) {
+			dev_err(&vusb->vdev->dev,
+				"Failed to get endpoint info\n");
+			break;
+		}
+		if (!vudc->pdev) {
+			rc = virtio_usb_dc_parent_create(vudc);
+			if (rc) {
+				dev_err(&vusb->vdev->dev,
+					"Failed to create UDC parent device\n");
+				kfree(vudc->veps);
+				vudc->veps = NULL;
+				break;
+			}
+		}
+		vudc->gadget.name =
+			kasprintf(GFP_KERNEL, "%s_%d", GADGET_NAME, port_id);
+		if (!vudc->gadget.name) {
+			rc = -ENOMEM;
+			kfree(vudc->veps);
+			vudc->veps = NULL;
+			break;
+		}
+		vudc->gadget.ops = &virtio_gadget_ops;
+		vudc->gadget.max_speed = USB_SPEED_HIGH;
+		vudc->gadget.nonatomic = 1;
+
+		//vudc->gadget.dev.init_name = gadget_name;
+		vudc->gadget.dev.parent = &vudc->pdev->dev;
+		rc = usb_add_gadget_udc(&vudc->pdev->dev, &vudc->gadget);
+		if (rc) {
+			dev_err(&vudc->pdev->dev, "Failed to add udc\n");
+			kfree(vudc->veps);
+			vudc->veps = NULL;
+			kfree(vudc->gadget.name);
+			break;
+		}
+		spin_lock_irqsave(&vudc->lock, flags);
+		vudc->registered = 1;
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		break;
+	}
+	case VIRTIO_USB_EVT_DEV_DISCONNECTED: {
+		if (vudc->driver && vudc->driver->disconnect)
+			vudc->driver->disconnect(&vudc->gadget);
+		if (vudc->registered)
+			usb_gadget_set_state(&vudc->gadget,
+					     USB_STATE_NOTATTACHED);
+		break;
+	}
+	case VIRTIO_USB_EVT_DEV_SETUP: {
+		if (!driver)
+			break;
+
+		vep = usb_ep_to_virtio_ep(vudc->gadget.ep0);
+		setup_evt = virtio_usb_event_buf(event);
+
+		memcpy(&vep->setup, setup_evt->setup,
+		       sizeof(struct usb_ctrlrequest));
+
+		rc = driver->setup(&vudc->gadget,
+				   (struct usb_ctrlrequest *)setup_evt->setup);
+		if (rc < 0 && rc != -ESHUTDOWN)
+			virtio_ep_set_halt(vudc->gadget.ep0, 1);
+		break;
+	}
+	case VIRTIO_USB_EVT_DEV_RESET: {
+		if (driver)
+			usb_gadget_udc_reset(&vudc->gadget, driver);
+		break;
+	}
+	case VIRTIO_USB_EVT_DEV_SUSPEND: {
+		if (driver && driver->suspend)
+			driver->suspend(&vudc->gadget);
+		break;
+	}
+	case VIRTIO_USB_EVT_DEV_RESUME: {
+		if (driver && driver->resume)
+			driver->resume(&vudc->gadget);
+		break;
+	}
+	case VIRTIO_USB_EVT_DEV_UNBIND: {
+		unsigned int registered;
+
+		spin_lock_irqsave(&vudc->lock, flags);
+		registered = vudc->registered;
+		vudc->registered = 0;
+		spin_unlock_irqrestore(&vudc->lock, flags);
+
+		if (registered) {
+			usb_del_gadget_udc(&vudc->gadget);
+			kfree(vudc->gadget.name);
+			vudc->gadget.name = NULL;
+		}
+
+		kfree(vudc->veps);
+		vudc->veps = NULL;
+
+		if (vudc->pdev) {
+			platform_device_unregister(vudc->pdev);
+			vudc->pdev = NULL;
+		}
+		break;
+	}
+	default:
+		rc = -EINVAL;
+		break;
+	}
+}
+
+/**
+ * virtio_usb_dc_event_work() - Worker to get all events
+ * from the virtqueue and process them.
+ * @work: Kernel work to handle event completion.
+ *
+ * Context: Process context.
+ */
+void virtio_usb_dc_event_work(struct work_struct *work)
+{
+	struct virtio_usb *vusb =
+		container_of(work, struct virtio_usb, vq_dev_event_work);
+	struct virtio_usb_queue *evtq =
+		&vusb->vqueues[vusb->dev_vq_base + VIRTIO_USB_VQ_EVENT_IDX];
+
+	virtio_usb_evt_work(evtq, virtio_usb_dc_event_process);
+}
+
+/**
+ * virtio_usb_dc_event_populate() - Add events to the device event queue.
+ * @vusb: VirtIO USB device
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure
+ */
+int virtio_usb_dc_event_populate(struct virtio_usb *vusb)
+{
+	struct virtio_usb_queue *evt_queue =
+		&vusb->vqueues[vusb->dev_vq_base + VIRTIO_USB_VQ_EVENT_IDX];
+	struct virtio_usb_event *events;
+	int rc;
+
+	events = virtio_usb_events_alloc(vusb, evt_queue,
+					 sizeof(struct virtio_usb_dev_event));
+
+	if (!events)
+		return -ENOMEM;
+
+	rc = virtio_usb_events_populate(events);
+
+	return rc;
+}
+
+/**
+ * virtio_usb_dc_init() - Initializes the device role.
+ * @vusb: VirtIO USB device
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure
+ */
+int virtio_usb_dc_init(struct virtio_usb *vusb, int port_id)
+{
+	struct virtio_usb_dc *vudc;
+	unsigned int i;
+
+	vudc = devm_kzalloc(&vusb->vdev->dev, sizeof(*vudc), GFP_KERNEL);
+	if (!vudc)
+		return -ENOMEM;
+
+	vusb->vports[port_id].vudc = vudc;
+	vudc->vusb = vusb;
+	vudc->port = port_id;
+	for (i = 0; i < VIRTIO_USB_VQ_DEV_MAX; i++)
+		vudc->dcqs[i] = &vusb->vqueues[vusb->dev_vq_base + i];
+
+	spin_lock_init(&vudc->lock);
+
+	vudc->registered = 0;
+
+	return 0;
+}
+
+/**
+ * virtio_usb_dc_deinit() - Deinitialize the device role.
+ * @vusb: VirtIO USB device
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure
+ */
+int virtio_usb_dc_deinit(struct virtio_usb *vusb)
+{
+	int port_id;
+
+	if (!vusb->device_role)
+		return -ENODEV;
+
+	for (port_id = 0; port_id < vusb->nports; port_id++) {
+		struct virtio_usb_dc *vudc = vusb->vports[port_id].vudc;
+		unsigned int registered;
+		unsigned long flags;
+
+		if (!vudc)
+			continue;
+
+		spin_lock_irqsave(&vudc->lock, flags);
+		registered = vudc->registered;
+		spin_unlock_irqrestore(&vudc->lock, flags);
+
+		if (registered)
+			usb_del_gadget_udc(&vudc->gadget);
+
+		kfree(vudc->veps);
+		vudc->veps = NULL;
+
+		if (vudc->pdev) {
+			platform_device_unregister(vudc->pdev);
+			vudc->pdev = NULL;
+		}
+
+		vusb->vports[port_id].vudc = NULL;
+	}
+
+	return 0;
+}
+
+/**
+ * virtio_usb_dc_dataq_stop_cb() - Stops the data virtqueue
+ * @vusb: VirtIO usb device.
+ * @dataq: data virtqueue wrapper
+ *
+ * Context: Any context.
+ */
+static void virtio_usb_dc_dataq_stop_cb(struct virtio_usb *vusb,
+					struct virtio_usb_queue *dataq)
+{
+	int port_id;
+
+	if (!vusb->device_role)
+		return;
+
+	virtio_usb_dataq_stop_cb(vusb, dataq);
+	cancel_work_sync(&vusb->vq_dev_data_rx_work);
+
+	for (port_id = 0; port_id < vusb->nports; port_id++) {
+		struct virtio_usb_dc *vudc = vusb->vports[port_id].vudc;
+		struct virtio_usb_data *vreq, *vreq_tmp;
+		struct virtio_usb_dc_priv *priv;
+		unsigned int i;
+
+		if (!vudc)
+			continue;
+
+		for (i = 0; i < vudc->neps; i++) {
+			list_for_each_entry_safe(vreq, vreq_tmp,
+						 &vudc->veps[i].req_queue,
+						 list) {
+				priv = virtio_usb_data_priv(vreq);
+				priv->req.status = -ESHUTDOWN;
+				list_del_init(&vreq->list);
+				virtio_usb_data_unref(vreq);
+				usb_gadget_giveback_request(&priv->vep->ep,
+							    &priv->req);
+			}
+		}
+	}
+}
+
+/**
+ * virtio_usb_dc_data_notify_cb() - Data virtqueue notification callback
+ * @vqueue: Underlying event virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from the
+ * device.
+ *
+ * Context: Interrupt context.
+ */
+static void virtio_usb_dc_data_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_usb *vusb = vqueue->vdev->priv;
+
+	schedule_work(&vusb->vq_dev_data_rx_work);
+}
+
+/**
+ * virtio_usb_dc_evt_notify_cb() - Event virtqueue notification callback
+ * @vqueue: Underlying event virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from the
+ * device.
+ *
+ * Context: Interrupt context.
+ */
+static void virtio_usb_dc_evt_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_usb *vusb = vqueue->vdev->priv;
+
+	schedule_work(&vusb->vq_dev_event_work);
+}
+
+/**
+ * virtio_usb_dc_evtq_stop_cb() - Stops the event virtqueue.
+ * @vusb: VirtIO usb device.
+ * @vq: virtio usb vq wrapper
+ *
+ * Context: Any context.
+ */
+static void virtio_usb_dc_evtq_stop_cb(struct virtio_usb *vusb,
+				       struct virtio_usb_queue *vq)
+{
+	/*
+	 * Unlike the host evtq stop path (which safely updates in-memory
+	 * port status bits), dc event processing drives the UDC state
+	 * machine and calls back into gadget drivers and UDC core. Doing
+	 * so here, when the UDC may be only partially initialized (probe
+	 * failure) or already torn down (remove path), risks
+	 * use-after-free and crashes - virtio_usb_evt_drain_stop_cb()
+	 * drains without processing for exactly this reason.
+	 */
+	cancel_work_sync((struct work_struct *)&vusb->vq_dev_event_work);
+	virtio_usb_evt_drain_stop_cb(vq, NULL);
+}
+
+const struct virtio_usb_vq_desc dev_vqueues[VIRTIO_USB_VQ_DEV_MAX] = {
+			[VIRTIO_USB_VQ_COMMAND_IDX] = {
+			.callback = virtio_usb_cmd_notify_cb,
+			.name = "virtusb-dev-cmd",
+			.process = virtio_usb_cmd_process_cb,
+			.stop = virtio_usb_cmdq_stop_cb,
+		},
+		[VIRTIO_USB_VQ_EVENT_IDX] = {
+			.callback = virtio_usb_dc_evt_notify_cb,
+			.name = "virtusb-dev-evt",
+			.process = NULL,
+			.stop = virtio_usb_dc_evtq_stop_cb,
+		},
+		[VIRTIO_USB_VQ_DATA_IDX] = {
+			.callback = virtio_usb_dc_data_notify_cb,
+			.name = "virtusb-dev-data",
+			.process = NULL,
+			.stop = virtio_usb_dc_dataq_stop_cb,
+		},
+};
diff --git a/drivers/usb/virtio_usb/device.h b/drivers/usb/virtio_usb/device.h
new file mode 100644
index 0000000..9dacc89
--- /dev/null
+++ b/drivers/usb/virtio_usb/device.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * virtio-usb: Virtio usb device
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef VIRTIO_USB_DC_H
+#define VIRTIO_USB_DC_H
+
+#include <linux/usb.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <uapi/linux/usb/ch11.h>
+#include <uapi/linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+
+#include "vq_common.h"
+
+#include <uapi/linux/virtio_usb.h>
+
+#define VIRTIO_USB_EP_CAPS_TYPE_CONTROL 0x01
+#define VIRTIO_USB_EP_CAPS_TYPE_INTERRUPT 0x02
+#define VIRTIO_USB_EP_CAPS_TYPE_BULK 0x04
+#define VIRTIO_USB_EP_CAPS_TYPE_ISOCHRONOUS 0x08
+
+#define VIRTIO_USB_EP_CAPS_DIR_IN 0x02
+#define VIRTIO_USB_EP_CAPS_DIR_OUT 0x01
+
+#define VIRTIO_USB_EP_CAPS(_type, _dir)                                        \
+	{                                                                      \
+		.type_control = !!((_type) & VIRTIO_USB_EP_CAPS_TYPE_CONTROL), \
+		.type_iso = !!((_type) & VIRTIO_USB_EP_CAPS_TYPE_ISOCHRONOUS), \
+		.type_bulk = !!((_type) & VIRTIO_USB_EP_CAPS_TYPE_BULK),       \
+		.type_int = !!((_type) & VIRTIO_USB_EP_CAPS_TYPE_INTERRUPT),   \
+		.dir_in = !!((_dir) & VIRTIO_USB_EP_CAPS_DIR_IN),              \
+		.dir_out = !!((_dir) & VIRTIO_USB_EP_CAPS_DIR_OUT),            \
+	}
+
+/**
+ * struct virtio_usb_ep - virtio usb device endpoint
+ * @ep: usb ep
+ * @vusb: VirtIO usb device
+ * @setup: setup packet for control endpoint
+ * @req_queue: list of usb requests submitted to ep awaiting response
+ * @ep_id: Id of the endpoint
+ * @name: Endpoint name
+ */
+struct virtio_usb_ep {
+	struct usb_ep ep;
+	struct virtio_usb_dc *vudc;
+	struct usb_ctrlrequest setup;
+	struct list_head req_queue;
+	u16 ep_id;
+	char name[16];
+};
+
+/**
+ * struct virtio_usb_dc - VirtIO USB Device controller (USBDC) device.
+ * @gadget: Pointer to the usb gadget structure
+ * @driver: Pointer to the usb gadget  driver structure
+ * @veps: Virtual endpoints
+ * @neps: Number of virtual endpoints
+ * @dcqs: Device virtqueue wrappers, indexed by VIRTIO_USB_VQ_*_IDX.
+ * @vusb: VirtIO usb device
+ * @registered: Flag indicating registration status to the UDC core.
+ * @pullup:  Software-controlled connect/disconnect status USB host.
+ * @lock: Spinlock that protects device state
+ */
+struct virtio_usb_dc {
+	struct platform_device *pdev;
+	u16 port; // Device id
+	struct usb_gadget gadget;
+	struct usb_gadget_driver *driver;
+	struct virtio_usb_ep *veps;
+	u32 neps;
+	struct virtio_usb_queue *dcqs[VIRTIO_USB_VQ_DEV_MAX];
+	struct virtio_usb *vusb;
+	unsigned registered : 1;
+	unsigned pullup : 1;
+	spinlock_t lock;
+};
+
+extern const struct virtio_usb_vq_desc dev_vqueues[VIRTIO_USB_VQ_DEV_MAX];
+
+int virtio_usb_dc_init(struct virtio_usb *vusb, int port_id);
+int virtio_usb_dc_deinit(struct virtio_usb *vusb);
+void virtio_usb_dc_event_work(struct work_struct *work);
+void virtio_usb_dc_data_work(struct work_struct *work);
+int virtio_usb_dc_event_populate(struct virtio_usb *vusb);
+#endif /* VIRTIO_USB_DC_H */
diff --git a/include/uapi/linux/virtio_usb.h b/include/uapi/linux/virtio_usb.h
index 459edc1..4cbfb3f 100644
--- a/include/uapi/linux/virtio_usb.h
+++ b/include/uapi/linux/virtio_usb.h
@@ -64,12 +64,11 @@ enum {
 	VIRTIO_USB_S_ERR_STALL,
 	VIRTIO_USB_S_ERR_SHORT_PKT,
 	VIRTIO_USB_S_ERR_CANCELLED,
-	VIRTIO_USB_S_ERR_HOST,
 };
 
 struct virtio_usb_cmd_status {
 	__le32 code; /* VIRTIO_USB_S_XXX */
-};
+} __packed;
 
 /*****************************************************************************
  * HOST COMMAND MESSAGES
@@ -145,6 +144,8 @@ enum {
 	VIRTIO_USB_CMD_DEV_EP_SET_HALT,
 	VIRTIO_USB_CMD_DEV_EP_SET_WEDGE,
 	VIRTIO_USB_CMD_DEV_CANCEL,
+	VIRTIO_USB_CMD_DEV_GET_FRAME_NUMBER,
+	VIRTIO_USB_CMD_DEV_SET_SELF_POWERED,
 };
 
 struct virtio_usb_dev_cmd_hdr {
@@ -153,12 +154,30 @@ struct virtio_usb_dev_cmd_hdr {
 	__le16 endpoint; /* Endpoint ID */
 };
 
+/* VIRTIO_USB_CMD_DEV_CANCEL */
+struct virtio_usb_dev_cmd_cancel {
+	struct virtio_usb_dev_cmd_hdr hdr;
+	__le64 tag;
+};
+
 /* VIRTIO_USB_CMD_DEV_GET_ENDPOINT_COUNT */
-struct virtio_usb_dev_cmd_ep_count {
+struct virtio_usb_dev_ep_count {
 	struct virtio_usb_cmd_status status;
 	__le32 count; /* # of supported endpoints */
 };
 
+struct virtio_usb_dev_cmd_set_value {
+	struct virtio_usb_dev_cmd_hdr hdr;
+	__le32 value;
+	__le32 padding;
+};
+
+/* VIRTIO_USB_CMD_DEV_GET_FRAME_NUMBER */
+struct virtio_usb_dev_frame_number {
+	struct virtio_usb_cmd_status status;
+	__le32 frame_number;
+};
+
 enum {
 	VIRTIO_USB_DIR_OUT = 0,
 	VIRTIO_USB_DIR_IN,
@@ -176,35 +195,39 @@ enum {
  *     struct virtio_usb_cmd_status
  *     struct virtio_usb_dev_cmd_ep_info [count]
  */
-struct virtio_usb_dev_cmd_ep_info {
+struct virtio_usb_dev_ep_info {
 	__le16 types; /* supported type bit map (1 << VIRTIO_USB_EP_XXX) */
 	__le16 directions /* supported direction bit map (1 << VIRTIO_USB_DIR_XXX) */;
 	__le16 maxpacket_limit;
 	__le16 max_streams;
+	__u8 name[16];
 };
 
 /*******************************************************************************
  * DEVICE EVENT MESSAGES
  */
 enum {
-	VIRTIO_USB_EVT_DEV_CONNECTED = 0,
+	VIRTIO_USB_EVT_DEV_BIND = 0,
 	VIRTIO_USB_EVT_DEV_DISCONNECTED,
 	VIRTIO_USB_EVT_DEV_SETUP,
 	VIRTIO_USB_EVT_DEV_RESET,
 	VIRTIO_USB_EVT_DEV_SUSPEND,
 	VIRTIO_USB_EVT_DEV_RESUME,
+	VIRTIO_USB_EVT_DEV_UNBIND,
 };
 
 struct virtio_usb_dev_event {
 	__le32 code; /* VIRTIO_USB_EVT_DEV_XXX */
-	__u8 padding[12];
+	__le16 port; /* Device ID */
+	__u8 padding[10];
 };
 
 /* VIRTIO_USB_EVT_DEV_SETUP */
 struct virtio_usb_dev_setup_event {
 	__le32 code; /* VIRTIO_USB_EVT_DEV_SETUP */
+	__le16 port; /* Device ID */
 	__u8 setup[8]; /* setup packet contents */
-	__u8 padding[4];
+	__u8 padding[2];
 };
 
 /*******************************************************************************
