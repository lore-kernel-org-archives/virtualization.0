Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53194A498F
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266190; cv=none; b=aUi/pRr3oVzorXV0aNnwHy6vtQlD1256qAmpT2xOYU+eSHR+ClJmLLlG2WgrDoTboKyf6uZ+pvr0LmagVuMmQ4eEx0fldQDbr0NfS+8ooVUcKMZAbfnZqwKdlD4vN6GjZVbwPX1f3eymjRrRVwWgJrb0b8YB5toGc3jJjcKuPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266190; c=relaxed/simple;
	bh=t6wH9ipA8UlKX8Oa3hD0ZfN40ZhzwFDAlx1Rl/sNt7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgCgJeas2cLRU5P8kouUMD8wLgyOuYgS57kAUgKV/XeAbO/ftsZFoBhUxX/v8bYkDkcLOmrSyNN2C/tO/Seu5zzh6Sx7BmIPZM+X8br7/cJTaAir3s27QJwasbKpnd7eaIo1sLW3FyiACPwOYk0uRTPCngcI/E/mBm/G2WfssYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j6tiopaT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YXBql7cQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6tiopaT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YXBql7cQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFeX5t2600983
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=btmvHz6hPnl
	wSf6hWUUyXHCYOgGEKsfRdwgaW87zQRg=; b=j6tiopaTW/nLjkKYDJh9re0zSL/
	aLDUnojr7uQEJ9nhrX9fj6VVAD1mCj3ET/lCwoVTBLMTREt2eIeEbBTLqGaY0awP
	oGPZRtHhqwo+QSPFEliaVrU/d13/Hi3ydUEnWilPmZghOSDJKGy8ETBzrJsyk2Fz
	DtIxU+aAoCkuYU7FQR2bb+5oeUSyLLozxV6MgZz/WTTW+CA4vY5SpJ03gpx5zsvA
	3hrvvMNd+mST2h1HWw0a5WGv5ErZ184rL4F2/g8Oa+SrmhpnqPUJDDcJeYBrPx+E
	3+fIsQk9ePP5Kli3rN3b4An1W04nLygn1SodEEo8whP3sgDrlgbZx15c5Rw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4650vjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:45 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7a04805f8f1so1990280137.3
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790266185; x=1790870985; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btmvHz6hPnlwSf6hWUUyXHCYOgGEKsfRdwgaW87zQRg=;
        b=YXBql7cQ91vyp3EYKX92rfdta/ETTeSitq5EVI2Y81JK7NdNfyS+xEUkp46xIChyrU
         rUeUv6sFQ1/i5EA+2k6pVfr5lT2b0yVeoCgoWh9br4E3yl8mYlPqcOorR23zNvgzIJKB
         KxwJsUf3lXcqmsTiYpvmpz0ptEIdLeAU4PK6UUQwrXzgqlTJYe38SfW8f74MNHp5jO3q
         vjoJh6Vu9Owe/yW+rIpmuy0dDz+XiWiCb/JKprtBgSejK/xgi66rz4Jrf2glPU0dy7gc
         TBvm4d4r5WGB1jL7u/35RooaTgJlcwsOArlhHeOk1uwCxTzf8mPoS8U5KdKNasLwt1FY
         wP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266185; x=1790870985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=btmvHz6hPnlwSf6hWUUyXHCYOgGEKsfRdwgaW87zQRg=;
        b=FBmr42yu+u72wpKvLN2xKJUyJ7xytawU0jznT3R9I/IFnDuaf9hc7+WhiMdG7nV31r
         XgF0J5LBlwlfWCjTXn1P9pMDvVR5IRWlLWk6DzyqNHXSNm8aPFOiBaP2pdSVDNIwdYNY
         4tuVxj9kG7PN3BzJIy9aAzWl8BXgYlBdS9UI1Iahy7YdcvmitsNti0j0jwRxo+KoQ4O+
         mDuPWp9YCj38Mf9j7ssSJC2NUKjuw/0yTUJx9LP2KVH+VxDhSKNEUwuveeOKDw1SaZQZ
         Ii5YWIjE97JgCtZWFo3wZyhV6Nnpf3qbqAQk9dDehrjNVfe+CuRdubi7+MkZpTkX8xNG
         9JIQ==
X-Gm-Message-State: AFuF++k3FtHr5h2PgUq/RY71zFo2x4yy0nZGb8fE8i9vEEZLlu7k77vV
	G3X0p+fb0nIsLVeVhBoYcpXoZXI54HEBQlwUfu7b5331An/6sxrduyH3m9tkEWnwP8ejdJZOxU3
	lFhFESmwDqmvWjM8HlmQAY8e2HQMCTfi77vyfK/DUVYj6ZjNexkDn6ijmrltenAhbuHP7uQ==
X-Gm-Gg: AYBFou2lY36BZ4Ab8m7yPgngc6qFGqIu2Pb/T4SRD8g/qaZFWPPqLkmFZMaD+M/huFf
	J4BMWTPL4y9jPr8suKQPL6bMvoi3I9W0gmHwjNOLal3EMnZwQTXpTaXLI3gQ1wz4dzDScMZPRUQ
	1xgb1BQaHsIdY0uZTgwcBSINmKXzdVoFejLOOY1V6FR2A0bFVCYqXYg1CP4itRfFmWQ+mXB4xgJ
	NlWgXBbWP6vV0Zic8rN5bI4EXCSMzWFttQ5YiBDjCbVf55jamv3vwzKZLoETvl6KzLbqRp/XQZQ
	amt3OqOvDI/RYDpBgzhoGtP7XNbwiZ227baASZX8Yo3gHfymKiM5jfe7kc0QDw8HWUgCweR8/qS
	HHu+Ku00qOoNZCtaJmnEwjws8SlcCaCY=
X-Received: by 2002:a05:6102:c53:b0:7a1:f7c3:3a45 with SMTP id ada2fe7eead31-7af1d6c4296mr1585165137.18.1790266183898;
        Thu, 24 Sep 2026 09:09:43 -0700 (PDT)
X-Received: by 2002:a05:6102:c53:b0:7a1:f7c3:3a45 with SMTP id ada2fe7eead31-7af1d6c4296mr1585123137.18.1790266181878;
        Thu, 24 Sep 2026 09:09:41 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5c4csm328306766b.18.2026.09.24.09.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:09:40 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 5/8] virtio-usb: add USB On-The-Go role-switching support
Date: Thu, 24 Sep 2026 18:09:04 +0200
Message-ID: <20260924160907.145405-6-igor.skalkin@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab54b49 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=y8UAWs7lEmc5YlDWpZsA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: BWD8Skp9vFl-1dBC5C0m7K444juAehch
X-Proofpoint-GUID: BWD8Skp9vFl-1dBC5C0m7K444juAehch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfXzp/C2VHxi+On
 miEg3HdAxUKP0za+tZjhcAaXRlEt2gP+P1HwEIAGDwLG+lVllnjIUzLe4+zQ8uhCWTIVRetcsla
 CRVsYA1nZMPHICkz5QAOrBq+rv9EbWH9voafpvwBmyuvL3opf6uRWIASa7ZJpZ4UZlrJdo8lKD+
 WSC6IjYroGfqHbbF3j4bHpDwdOqEW5uOTgfSvhfmRfItU/LKMgugI7F4y6YzY4XVqM3Cxtd5TTU
 DkNJrAuPCg5p7hVYW5G3M/wAYe/1wqVdzVEWV68DFoh8P5EeZnMBUpZraWB2OP8Nt7Vh3Yb5Szb
 cPRpsgrWSC2R0yn4Ij4UQb+g1u6Qm2VFTqvGj5PvWHmkOhxfFmMPAnjuJxJuoaDnse60Ofh1/GF
 IjQWCZh7dvruyHmdC24h4fmFLX3Paqbfxg/AoAz/xLeX5tpdkNtlnFZ9k9IsVgfRMbNBq3ZhGim
 LI1VHnU1vWjcai3ZYgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX5sXbxiTHo5qq
 NaluRC87VPyxrdg3m7p8nIsVKk19DNQtcqPR1ajOFxIOTmhFUfnzhbPBCf/v2l4fXylKJGopy8p
 B//jzhlm+bWpFfBE2l0jR01vIZigoAM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

Add support for ports that can switch between the host and device
roles at runtime (USB OTG-style role switching): negotiate
VIRTIO_USB_F_SWITCH_ROLE support during probe, extend otg_get_role()
to also report each port's supported roles (is_otg), and register a
USB Role Switch class device so userspace can observe and control the
role and be notified of role changes via VIRTIO_USB_EVT_OTG_CHANGE_ROLE.

This is a proof-of-concept for internal demo purposes; the two
directions currently work quite differently and neither is fully
guest-initiated:

- Device-to-host: the guest writes the new role to its own USB Role
  Switch sysfs entry. The driver sends a switch command to the host
  device; the host device performs the switch and sends back a
  VIRTIO_USB_EVT_OTG_CHANGE_ROLE event, which is what actually updates
  the guest's role.
- Host-to-device: cannot be initiated from the guest at all. The host
  kernel driver switches role on its own, either from an OTG interrupt
  or a manual sysfs role write on the host side. The host virtio
  device notices the USB port disappearing, checks the role via
  sysfs, and if it changed, sends the guest a
  VIRTIO_USB_EVT_OTG_CHANGE_ROLE event; the guest driver just reacts
  to it.

Real USB OTG separates this into two signals: bus_req, asserted by a
B-device (peripheral) to request becoming host, and bus_drop,
asserted by the current host to grant permission for the role swap -
without bus_drop, the peripheral's request cannot succeed.
VIRTIO_USB_CMD_OTG_SWITCH_ROLE only implements the bus_req side;
there is no bus_drop equivalent, so the current host's permission is
implicitly always granted. Fine for a first version; can be
revisited if a real use case needs the host to refuse a switch.

Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
---
 drivers/usb/virtio_usb/controller.c |   94 ++++++--
 drivers/usb/virtio_usb/controller.h |   21 +
 drivers/usb/virtio_usb/device.c     |    8 
 drivers/usb/virtio_usb/host.c       |   45 +++-
 drivers/usb/virtio_usb/otg.c        |  401 ++++++++++++++++++++++++++++--------
 drivers/usb/virtio_usb/otg.h        |   16 +
 include/uapi/linux/virtio_usb.h     |    1 
 7 files changed, 474 insertions(+), 112 deletions(-)

diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb/controller.c
index 59af5cc..c018725 100644
--- a/drivers/usb/virtio_usb/controller.c
+++ b/drivers/usb/virtio_usb/controller.c
@@ -10,8 +10,8 @@
 #include <uapi/linux/virtio_ids.h>
 
 #include "controller.h"
-#include "host.h"
 #include "device.h"
+#include "host.h"
 #include "otg.h"
 #include "vq_common.h"
 
@@ -86,6 +86,14 @@ static int virtio_usb_validate(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
+	if ((!(virtio_has_feature(vdev, VIRTIO_USB_F_HOST)) ||
+	     !(virtio_has_feature(vdev, VIRTIO_USB_F_DEVICE))) &&
+	    virtio_has_feature(vdev, VIRTIO_USB_F_SWITCH_ROLE)) {
+		dev_err(&vdev->dev,
+			"OTG requires both (host and device) roles support\n");
+		return -EINVAL;
+	}
+
 	if (!virtio_usb_cmd_timeout_ms) {
 		dev_err(&vdev->dev, "msg_timeout_ms value cannot be zero\n");
 		return -EINVAL;
@@ -129,6 +137,12 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_USB_F_DEVICE))
 		vusb->device_role = 1;
 
+	if (virtio_has_feature(vdev, VIRTIO_USB_F_SWITCH_ROLE))
+		vusb->switch_role = 1;
+
+	dev_info(&vdev->dev, "%s nports %d (h_role %d dev_role %d)\n", __func__,
+		 vusb->nports, vusb->host_role, vusb->device_role);
+
 	/* Only allocate/negotiate the virtqueue triplets this instance
 	 * actually needs: HOST_* only exists when host_role is negotiated,
 	 * DEV_* only when device_role is negotiated, OTG_* only when both
@@ -219,20 +233,44 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 		}
 	}
 
+	if (vusb->device_role) {
+		INIT_WORK(&vusb->vq_dev_event_work, virtio_usb_dc_event_work);
+		INIT_WORK(&vusb->vq_dev_data_rx_work, virtio_usb_dc_data_work);
+
+		/* Populate the shared device event queue before telling the
+		 * backend we are ready, so a DEV_CONNECTED event can never
+		 * race ahead of the driver having posted receive buffers.
+		 */
+		rc = virtio_usb_dc_event_populate(vusb);
+		if (rc) {
+			dev_err(&vdev->dev,
+				"%s virtio_usb_dc_event_populate() error(%d)\n",
+				__func__, rc);
+			goto on_error;
+		}
+	}
+
+	virtio_device_ready(vdev);
+
 	/* Resolve every port's role. With only one role negotiated, every
 	 * port unambiguously has that role. With both negotiated, query
-	 * each port's actual role individually via otg_get_role(), since
-	 * it is otherwise ambiguous (host|device).
+	 * each port's actual role - and, if switch_role is negotiated,
+	 * whether the port supports switching - individually via
+	 * otg_get_role(), since a port's own role is otherwise ambiguous
+	 * (host|device).
 	 */
 	for (i = 0; i < vusb->nports; i++) {
+		vusb->vports[i].vusb = vusb;
+		spin_lock_init(&vusb->vports[i].vhc_lock);
+
 		if (vusb->host_role && !vusb->device_role) {
 			vusb->vports[i].role = VIRTIO_USB_ROLE_HOST;
 		} else if (vusb->device_role && !vusb->host_role) {
 			vusb->vports[i].role = VIRTIO_USB_ROLE_DEVICE;
 		} else {
-			u32 status, role;
+			u32 status, role, supported_role;
 
-			status = otg_get_role(vusb, i, &role);
+			status = otg_get_role(vusb, i, &role, &supported_role);
 			if (status != VIRTIO_USB_S_OK) {
 				dev_err(&vdev->dev, "%s status(%d)\n", __func__,
 					status);
@@ -247,9 +285,25 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 				goto on_error;
 			}
 			vusb->vports[i].role = role;
+			vusb->vports[i].is_otg =
+				supported_role &
+				(1UL << VIRTIO_USB_F_SWITCH_ROLE);
+
+			if (vusb->vports[i].is_otg && !vusb->switch_role) {
+				dev_err(&vdev->dev,
+					"%s port%d switch_role not supported\n",
+					__func__, i);
+				rc = -EIO;
+				goto on_error;
+			}
 		}
 	}
 
+	for (i = 0; i < vusb->nports; i++)
+		dev_info(&vdev->dev, "%s port[%d] VIRTIO_USB_F_%s is_otg %s\n",
+			 __func__, i, vusb->vports[i].role ? "DEVICE" : "HOST",
+			 vusb->vports[i].is_otg ? "TRUE" : "FALSE");
+
 	if (vusb->host_role) {
 		INIT_WORK(&vusb->vq_host_data_rx_work, virtio_usb_hc_rx_work);
 		INIT_WORK(&vusb->vq_host_evt_work, virtio_usb_hc_evt_work);
@@ -278,13 +332,9 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 		}
 	}
 
-	if (vusb->device_role) {
-		INIT_WORK(&vusb->vq_dev_data_rx_work, virtio_usb_dc_data_work);
-		INIT_WORK(&vusb->vq_dev_event_work, virtio_usb_dc_event_work);
-
-		for (i = 0; i < vusb->nports; i++) {
-			if (vusb->vports[i].role != VIRTIO_USB_ROLE_DEVICE)
-				continue;
+	for (i = 0; i < vusb->nports; i++) {
+		if (vusb->vports[i].is_otg ||
+		    vusb->vports[i].role == VIRTIO_USB_ROLE_DEVICE) {
 			rc = virtio_usb_dc_init(vusb, i);
 			if (rc) {
 				dev_err(&vdev->dev,
@@ -293,17 +343,17 @@ static int virtio_usb_probe(struct virtio_device *vdev)
 				goto on_error;
 			}
 		}
-		rc = virtio_usb_dc_event_populate(vusb);
-		if (rc) {
-			dev_err(&vdev->dev,
-				"%s virtio_usb_dc_event_populate() error(%d)\n",
-				__func__, rc);
-			goto on_error;
-		}
 	}
 
-	virtio_device_ready(vdev);
+	if (vusb->host_role && vusb->device_role)
+		if (otg_sysfs_init(vusb))
+			goto on_error;
+
+	WRITE_ONCE(vusb->started, true);
+	if (vusb->device_role)
+		schedule_work(&vusb->vq_dev_event_work);
 
+	dev_info(&vdev->dev, "%s returns %d\n", __func__, rc);
 	return rc;
 
 on_error:
@@ -323,6 +373,9 @@ static void virtio_usb_remove(struct virtio_device *vdev)
 	struct virtio_usb *vusb = vdev->priv;
 	int i;
 
+	/* Stop queue-driven workers from scheduling new activity. */
+	WRITE_ONCE(vusb->started, false);
+
 	for (i = 0; i < vusb->nvqs; i++)
 		vusb->vqueues[i].stop(vusb, &vusb->vqueues[i]);
 
@@ -344,6 +397,7 @@ static void virtio_usb_remove(struct virtio_device *vdev)
 static const unsigned int virtio_usb_features[] = {
 	VIRTIO_USB_F_HOST,
 	VIRTIO_USB_F_DEVICE,
+	VIRTIO_USB_F_SWITCH_ROLE,
 };
 
 static const struct virtio_device_id id_table[] = {
diff --git a/drivers/usb/virtio_usb/controller.h b/drivers/usb/virtio_usb/controller.h
index 4d9e0e2..deee053 100644
--- a/drivers/usb/virtio_usb/controller.h
+++ b/drivers/usb/virtio_usb/controller.h
@@ -20,6 +20,7 @@ struct virtio_usb_hc_vp;
 struct virtio_usb_dc;
 /* Forward declaration - full definition in otg.h */
 struct virtio_usb_otg;
+struct virtio_usb_port_otg;
 
 #define VIRTIO_USB_VQ_COMMAND_IDX 0
 #define VIRTIO_USB_VQ_EVENT_IDX 1
@@ -31,14 +32,27 @@ struct virtio_usb_otg;
 
 /**
  * struct virtio_usb_port - Per-virtual-port state.
+ * @vusb: VirtIO usb device this port belongs to.
+ * @is_otg: True if this port supports dynamic role switching.
  * @role: Role of this port (VIRTIO_USB_ROLE_HOST or _DEVICE).
  * @vhc: Host controller - non-NULL when role is HOST.
  * @vudc: Device controller - non-NULL when role is DEVICE.
+ * @otg: Per-port OTG role-switching state - non-NULL when is_otg.
  */
 struct virtio_usb_port {
+	struct virtio_usb *vusb;
+	bool is_otg;
 	unsigned int role;
+	/*! Protects vhc against concurrent OTG-triggered init/deinit while
+	 * the host event-processing worker is reading it. Only needs to
+	 * guard the pointer itself: virtio_usb_hc_vp_init()/_deinit()'s
+	 * sleeping work (devm_kzalloc(), usb_add_hcd(), usb_remove_hcd())
+	 * happens outside this lock.
+	 */
+	spinlock_t vhc_lock;
 	struct virtio_usb_hc_vp *vhc;
 	struct virtio_usb_dc *vudc;
+	struct virtio_usb_port_otg *otg;
 };
 
 /**
@@ -63,6 +77,9 @@ struct virtio_usb_port {
  *               otg_get_role() below, since with both host_role and
  *               device_role negotiated a port's own role is otherwise
  *               ambiguous.
+ * @switch_role: flag indicating support for dynamically switching roles
+ * @started: True once probe() has finished bringing up every VP - guards
+ *           notify callbacks against running before setup is complete.
  * @vq_host_data_rx_work: Kernel work draining the host data queue, shared
  *                        across every host-role VP.
  * @vq_host_evt_work: Kernel work draining the host event queue, shared
@@ -76,13 +93,15 @@ struct virtio_usb {
 	struct virtio_device *vdev;
 	struct virtio_usb_queue *vqueues;
 	struct virtio_usb_port *vports;
-	unsigned int nports;
+	u32 nports;
 	u32 nvqs;
 	bool host_role;
 	bool device_role;
 	int host_vq_base;
 	int dev_vq_base;
 	int otg_vq_base;
+	bool switch_role;
+	bool started;
 	struct work_struct vq_host_data_rx_work;
 	struct work_struct vq_host_evt_work;
 	struct work_struct vq_dev_data_rx_work;
diff --git a/drivers/usb/virtio_usb/device.c b/drivers/usb/virtio_usb/device.c
index 798c265..5ae0fc8 100644
--- a/drivers/usb/virtio_usb/device.c
+++ b/drivers/usb/virtio_usb/device.c
@@ -1056,6 +1056,8 @@ static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
 		break;
 	}
 	case VIRTIO_USB_EVT_DEV_DISCONNECTED: {
+		pr_info("%s port_id %d VIRTIO_USB_EVT_DEV_DISCONNECTED\n",
+			__func__, port_id);
 		if (vudc->driver && vudc->driver->disconnect)
 			vudc->driver->disconnect(&vudc->gadget);
 		if (vudc->registered)
@@ -1080,16 +1082,19 @@ static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
 		break;
 	}
 	case VIRTIO_USB_EVT_DEV_RESET: {
+		pr_info("%s VIRTIO_USB_EVT_DEV_RESET\n", __func__);
 		if (driver)
 			usb_gadget_udc_reset(&vudc->gadget, driver);
 		break;
 	}
 	case VIRTIO_USB_EVT_DEV_SUSPEND: {
+		pr_info("%s VIRTIO_USB_EVT_DEV_SUSPEND\n", __func__);
 		if (driver && driver->suspend)
 			driver->suspend(&vudc->gadget);
 		break;
 	}
 	case VIRTIO_USB_EVT_DEV_RESUME: {
+		pr_info("%s VIRTIO_USB_EVT_DEV_RESUME\n", __func__);
 		if (driver && driver->resume)
 			driver->resume(&vudc->gadget);
 		break;
@@ -1308,6 +1313,9 @@ static void virtio_usb_dc_evt_notify_cb(struct virtqueue *vqueue)
 {
 	struct virtio_usb *vusb = vqueue->vdev->priv;
 
+	if (!READ_ONCE(vusb->started))
+		return;
+
 	schedule_work(&vusb->vq_dev_event_work);
 }
 
diff --git a/drivers/usb/virtio_usb/host.c b/drivers/usb/virtio_usb/host.c
index 9926e66..5dc47f3 100644
--- a/drivers/usb/virtio_usb/host.c
+++ b/drivers/usb/virtio_usb/host.c
@@ -1013,12 +1013,16 @@ int virtio_usb_hc_vp_init(struct virtio_usb *vusb, unsigned int vp_idx)
 		vhcd_vp->hcqs[i] = &vusb->vqueues[vusb->host_vq_base + i];
 
 	/* Install into the port before add_hcd so vhcd_vp->vusb is set */
+	spin_lock(&vusb->vports[vp_idx].vhc_lock);
 	vusb->vports[vp_idx].vhc = vhcd_vp;
+	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
 
 	/* Add HCDs first so hs/ss are valid before any PORT_CONNECTED event */
 	rc = virtio_usb_add_hcd(vusb, vhcd_vp);
 	if (rc) {
+		spin_lock(&vusb->vports[vp_idx].vhc_lock);
 		vusb->vports[vp_idx].vhc = NULL;
+		spin_unlock(&vusb->vports[vp_idx].vhc_lock);
 		return rc;
 	}
 
@@ -1032,7 +1036,11 @@ int virtio_usb_hc_vp_init(struct virtio_usb *vusb, unsigned int vp_idx)
  */
 int virtio_usb_hc_vp_deinit(struct virtio_usb *vusb, unsigned int vp_idx)
 {
-	struct virtio_usb_hc_vp *vhcd_vp = vusb->vports[vp_idx].vhc;
+	struct virtio_usb_hc_vp *vhcd_vp;
+
+	spin_lock(&vusb->vports[vp_idx].vhc_lock);
+	vhcd_vp = vusb->vports[vp_idx].vhc;
+	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
 
 	if (!vhcd_vp)
 		return 0;
@@ -1045,7 +1053,9 @@ int virtio_usb_hc_vp_deinit(struct virtio_usb *vusb, unsigned int vp_idx)
 	vhcd_vp->ss = NULL;
 	vhcd_vp->hs = NULL;
 
+	spin_lock(&vusb->vports[vp_idx].vhc_lock);
 	vusb->vports[vp_idx].vhc = NULL;
+	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
 	return 0;
 }
 
@@ -1085,7 +1095,18 @@ static void virtio_usb_hc_evt_process_one(struct virtio_usb_event *uevent)
 		return;
 	}
 
+	/* vhc can be concurrently init/deinit'd by an OTG role switch
+	 * (virtio_usb_otg_event_process() runs on its own workqueue) -
+	 * vhc_lock protects only the pointer read itself; the vhcd_vp it
+	 * points to remains valid for as long as we hold a reference to
+	 * it here, since virtio_usb_hc_vp_deinit() only clears the
+	 * vports[vp_idx].vhc pointer under the same lock, it does not
+	 * free vhcd_vp itself (devm-managed, freed at device teardown).
+	 */
+	spin_lock(&vusb->vports[vp_idx].vhc_lock);
 	vhcd_vp = vusb->vports[vp_idx].vhc;
+	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
+
 	if (!vhcd_vp) {
 		dev_err_ratelimited(
 			&vusb->vdev->dev,
@@ -1174,10 +1195,12 @@ static void virtio_usb_hc_evt_process_one(struct virtio_usb_event *uevent)
  * @work: kernel work item embedded in struct virtio_usb.
  *
  * The host event queue is shared across all host-role VPs and its VP
- * may not even exist yet at probe time (e.g. a dual-role instance
- * where every port currently reports device role), so events are
- * drained and processed here, in process context, rather than
- * directly inside the interrupt-context notify callback.
+ * may not even exist yet (or may be concurrently torn down by an OTG
+ * role switch), so events are drained and processed here, in process
+ * context, instead of directly inside the interrupt-context notify
+ * callback - this lets virtio_usb_hc_evt_process_one() safely take
+ * vhc_lock without needing an atomic-context-safe primitive on the
+ * writer side (virtio_usb_hc_vp_init()/_deinit() sleep).
  *
  * Context: Process context.
  */
@@ -1215,7 +1238,11 @@ static void virtio_usb_hc_dataq_stop_cb(struct virtio_usb *vusb,
 	cancel_work_sync(&vusb->vq_host_data_rx_work);
 
 	for (vp_idx = 0; vp_idx < vusb->nports; vp_idx++) {
-		struct virtio_usb_hc_vp *vhcd_vp = vusb->vports[vp_idx].vhc;
+		struct virtio_usb_hc_vp *vhcd_vp;
+
+		spin_lock(&vusb->vports[vp_idx].vhc_lock);
+		vhcd_vp = vusb->vports[vp_idx].vhc;
+		spin_unlock(&vusb->vports[vp_idx].vhc_lock);
 
 		if (!vhcd_vp)
 			continue;
@@ -1284,6 +1311,9 @@ static void virtio_usb_hc_evt_notify_cb(struct virtqueue *vqueue)
 {
 	struct virtio_usb *vusb = vqueue->vdev->priv;
 
+	if (!READ_ONCE(vusb->started))
+		return;
+
 	schedule_work(&vusb->vq_host_evt_work);
 }
 
@@ -1310,6 +1340,9 @@ static void virtio_usb_host_data_notify_cb(struct virtqueue *vqueue)
 {
 	struct virtio_usb *vusb = vqueue->vdev->priv;
 
+	if (!READ_ONCE(vusb->started))
+		return;
+
 	schedule_work(&vusb->vq_host_data_rx_work);
 }
 
diff --git a/include/uapi/linux/virtio_usb.h b/include/uapi/linux/virtio_usb.h
index 4cbfb3f..29cec5d 100644
--- a/include/uapi/linux/virtio_usb.h
+++ b/include/uapi/linux/virtio_usb.h
@@ -318,6 +318,7 @@ enum {
 struct virtio_usb_otg_cmd_role {
 	struct virtio_usb_cmd_status status;
 	__le32 role; /* VIRTIO_USB_ROLE_XXX */
+	__le32 supported_role; /* VIRTIO_USB_F_[HOST|DEVICE|SWITCH_ROLE] */
 };
 
 /*****************************************************************************
diff --git a/drivers/usb/virtio_usb/otg.c b/drivers/usb/virtio_usb/otg.c
index 557dfae..f0f390f 100644
--- a/drivers/usb/virtio_usb/otg.c
+++ b/drivers/usb/virtio_usb/otg.c
@@ -7,11 +7,238 @@
 
 #include <linux/mutex.h>
 #include "controller.h"
+#include "host.h"
 #include "otg.h"
 #include "vq_common.h"
 
+// for usb_role enum from include/linux/usb/role.h
+const char *role_switch_role_names[] = { "USB_ROLE_NONE", "USB_ROLE_HOST",
+					 "USB_ROLE_DEVICE" };
+
+static int vusb_set_role_cb(struct usb_role_switch *sw, enum usb_role role)
+{
+	struct virtio_usb_port *vport = usb_role_switch_get_drvdata(sw);
+
+	pr_info("%s set_role to %s\n", __func__, role_switch_role_names[role]);
+	mutex_lock(&vport->otg->lock);
+
+	if (role == USB_ROLE_HOST && vport->role == VIRTIO_USB_ROLE_DEVICE) {
+		pr_warn("%s we are in device role, switch to host\n", __func__);
+		schedule_work(&vport->otg->set_role_work);
+	}
+	mutex_unlock(&vport->otg->lock);
+	return 0;
+}
+
+static enum usb_role vusb_get_role_cb(struct usb_role_switch *sw)
+{
+	struct virtio_usb_port *vport = usb_role_switch_get_drvdata(sw);
+
+	switch (vport->role) {
+	case VIRTIO_USB_ROLE_HOST:
+		return USB_ROLE_HOST;
+	case VIRTIO_USB_ROLE_DEVICE:
+		return USB_ROLE_DEVICE;
+	default:
+		return USB_ROLE_NONE;
+	}
+}
+
+static void virtio_usb_otg_event_process(struct virtio_usb_event *event)
+{
+	struct virtio_usb *vusb = event->vusb;
+	struct virtio_usb_otg_event *evt = virtio_usb_event_buf(event);
+	int port_id = le32_to_cpu(evt->port);
+	struct virtio_usb_port *vport = &vusb->vports[port_id];
+	u32 status, role, supported_role, old_role;
+	int rc;
+
+	if (le32_to_cpu(evt->code) != VIRTIO_USB_EVT_OTG_CHANGE_ROLE) {
+		pr_err("%s wrong event code %d\n", __func__,
+		       le32_to_cpu(evt->code));
+		return;
+	}
+
+	old_role = vport->role;
+	pr_info("%s VIRTIO_USB_EVT_OTG_CHANGE_ROLE curr_role %s\n", __func__,
+		old_role == VIRTIO_USB_ROLE_DEVICE ? "VIRTIO_USB_ROLE_DEVICE" :
+						     "VIRTIO_USB_ROLE_HOST");
+
+	status = otg_get_role(vusb, port_id, &role, &supported_role);
+	if (status != VIRTIO_USB_S_OK) {
+		pr_err("%s otg_get_role status %d\n", __func__, status);
+		return;
+	}
+
+	/* A port's usb_hcd/root hub is only supposed to exist while that
+	 * port is actually in host role - it's immediately visible to the
+	 * rest of the kernel (lsusb, udev, ...) the moment usb_add_hcd()
+	 * runs, unlike the device-role side's vudc, which stays dormant
+	 * and kernel-invisible until a later BIND event. So, unlike vudc
+	 * (already unconditionally pre-allocated for every OTG-capable
+	 * port at probe time, regardless of its current role - see
+	 * virtio_usb_probe()), vhc must be created/destroyed dynamically,
+	 * exactly at the moment a port's role actually changes.
+	 */
+	if (role != old_role && role == VIRTIO_USB_ROLE_HOST) {
+		rc = virtio_usb_hc_vp_init(vusb, port_id);
+		if (rc) {
+			pr_err("%s virtio_usb_hc_vp_init() port=%d error(%d)\n",
+			       __func__, port_id, rc);
+			/* Leave vport->role at its old value: reporting a
+			 * host role with no working HCD behind it would be
+			 * worse than not switching at all.
+			 */
+			return;
+		}
+	} else if (role != old_role && old_role == VIRTIO_USB_ROLE_HOST) {
+		virtio_usb_hc_vp_deinit(vusb, port_id);
+	}
+
+	vport->role = role;
+	vport->is_otg = supported_role & (1UL << VIRTIO_USB_F_SWITCH_ROLE);
+	pr_info("%s The new role (%s) is set\n", __func__,
+		role == VIRTIO_USB_ROLE_DEVICE ? "VIRTIO_USB_ROLE_DEVICE" :
+						 "VIRTIO_USB_ROLE_HOST");
+}
+
+/**
+ * virtio_usb_otg_event_work() - OTG event queue receive worker.
+ * @work: Kernel work to handle event completion.
+ *
+ * Context: Process context.
+ */
+static void virtio_usb_otg_event_work(struct work_struct *work)
+{
+	struct virtio_usb_otg *otg =
+		container_of(work, struct virtio_usb_otg, event_process_work);
+	struct virtio_usb_queue *evtq = otg->oqs[VIRTIO_USB_VQ_EVENT_IDX];
+
+	virtio_usb_evt_work(evtq, virtio_usb_otg_event_process);
+}
+
+/**
+ * virtio_usb_otg_set_role_work() - OTG send command to device worker.
+ *
+ * Context: Process context.
+ */
+static void virtio_usb_otg_set_role_work(struct work_struct *work)
+{
+	struct virtio_usb_port_otg *vport_otg =
+		container_of(work, struct virtio_usb_port_otg, set_role_work);
+	struct virtio_usb_otg *otg = vport_otg->vusb->otg;
+	struct virtio_usb_otg_cmd_hdr *hdr;
+	struct virtio_usb_cmd *cmd;
+	int rc;
+
+	cmd = virtio_usb_cmd_alloc(
+		sizeof(*hdr), sizeof(struct virtio_usb_cmd_status), GFP_KERNEL);
+	if (!cmd)
+		return;
+
+	hdr = virtio_usb_cmd_request(cmd);
+	hdr->code = cpu_to_le32(VIRTIO_USB_CMD_OTG_SWITCH_ROLE);
+	hdr->port = cpu_to_le32(vport_otg->port_id);
+	cmd->msg.queue = otg->oqs[VIRTIO_USB_VQ_COMMAND_IDX];
+
+	mutex_lock(&otg->lock);
+	rc = virtio_usb_cmd_send_sync(vport_otg->vusb, NULL, NULL, cmd);
+	mutex_unlock(&otg->lock);
+
+	if (rc)
+		pr_err("%s virtio_usb_cmd_send_sync() error %d\n", __func__,
+		       rc);
+	else
+		pr_info("%s success\n", __func__);
+}
+
+/**
+ * virtio_usb_otg_event_populate() - Add events to the otg event queue.
+ * @vusb: VirtIO USB device.
+ *
+ * Context: Any context.
+ * Return: 0 on success -errno on failure.
+ */
+static int virtio_usb_otg_event_populate(struct virtio_usb *vusb)
+{
+	struct virtio_usb_queue *otg_evt_queue =
+		vusb->otg->oqs[VIRTIO_USB_VQ_EVENT_IDX];
+	struct virtio_usb_event *events;
+
+	events = virtio_usb_events_alloc(vusb, otg_evt_queue,
+					 sizeof(struct virtio_usb_otg_event));
+	if (!events)
+		return -ENOMEM;
+
+	return virtio_usb_events_populate(events);
+}
+
+static void otg_vports_deinit(struct virtio_usb *vusb)
+{
+	if (!vusb->vports)
+		return;
+
+	for (int i = 0; i < vusb->nports; ++i) {
+		struct virtio_usb_port *vport = &vusb->vports[i];
+		/* is_otg is set before otg_sysfs_init() runs (which is
+		 * where vport->otg actually gets allocated) - a probe
+		 * failure in between the two would otherwise leave
+		 * is_otg true but otg still NULL here.
+		 */
+		if (!vport->is_otg || !vport->otg)
+			continue;
+
+		cancel_work_sync(&vport->otg->set_role_work);
+		usb_role_switch_unregister(vport->otg->sw);
+		vport->otg->sw = NULL;
+		kfree(vport->otg->sysfs_name);
+		vport->otg->sysfs_name = NULL;
+	}
+}
+
+static int otg_vport_init(struct virtio_usb *vusb, int port_id)
+{
+	struct device *dev = &vusb->vdev->dev;
+	struct virtio_usb_port *vport = &vusb->vports[port_id];
+	struct virtio_usb_port_otg *vport_otg;
+	struct usb_role_switch_desc desc = { 0 };
+
+	vport_otg = devm_kzalloc(dev, sizeof(*vport_otg), GFP_KERNEL);
+	if (!vport_otg)
+		return -ENOMEM;
+
+	vport_otg->vusb = vusb;
+	vport_otg->port_id = port_id;
+	vport_otg->sysfs_name = kasprintf(GFP_KERNEL, "port%u", port_id);
+
+	mutex_init(&vport_otg->lock);
+	INIT_WORK(&vport_otg->set_role_work, virtio_usb_otg_set_role_work);
+
+	desc.name = vport_otg->sysfs_name;
+	desc.set = vusb_set_role_cb;
+	desc.get = vusb_get_role_cb;
+	desc.driver_data = vport;
+	desc.fwnode = NULL;
+	desc.allow_userspace_control = true;
+
+	vport_otg->sw = usb_role_switch_register(dev, &desc);
+	if (IS_ERR(vport_otg->sw)) {
+		int rc = PTR_ERR(vport_otg->sw);
+		dev_err(dev, "port%u: usb_role_switch_register() failed: %d\n",
+			port_id, rc);
+		vport_otg->sw = NULL;
+		kfree(vport_otg->sysfs_name);
+		vport_otg->sysfs_name = NULL;
+		return rc;
+	}
+
+	vport->otg = vport_otg;
+	return 0;
+}
+
 int otg_init(struct virtio_usb *vusb)
 {
+	int rc;
 	struct virtio_usb_otg *otg =
 		devm_kzalloc(&vusb->vdev->dev, sizeof(*otg), GFP_KERNEL);
 	unsigned int i;
@@ -24,12 +251,39 @@ int otg_init(struct virtio_usb *vusb)
 	for (i = 0; i < VIRTIO_USB_VQ_OTG_MAX; i++)
 		otg->oqs[i] = &vusb->vqueues[vusb->otg_vq_base + i];
 
+	INIT_WORK((struct work_struct *)&otg->event_process_work,
+		  virtio_usb_otg_event_work);
+
 	mutex_init(&otg->lock);
-	init_completion(&otg->completion);
+
+	rc = virtio_usb_otg_event_populate(vusb);
+	if (rc)
+		return rc;
 
 	return 0;
 }
 
+int otg_sysfs_init(struct virtio_usb *vusb)
+{
+	int i, rc;
+
+	for (i = 0; i < vusb->nports; i++)
+		if (vusb->vports[i].is_otg) {
+			/* Skip if already registered - probe may be retried
+			 * after a Virtio reset and the role switch device
+			 * persists across retries (devm allocation).
+			 * Calling usb_role_switch_register() again would
+			 * return -EEXIST from device_register().
+			 */
+			if (vusb->vports[i].otg)
+				continue;
+			rc = otg_vport_init(vusb, i);
+			if (rc)
+				return rc;
+		}
+	return 0;
+}
+
 void otg_deinit(struct virtio_usb *vusb)
 {
 	struct virtio_usb_otg *otg = vusb->otg;
@@ -37,55 +291,75 @@ void otg_deinit(struct virtio_usb *vusb)
 	if (!otg)
 		return;
 
-	/* Wake potential OTG command waiters before releasing OTG objects. */
-	complete_all(&otg->completion);
-
+	/*
+	 * event_process_work is already cancelled by
+	 * virtio_usb_otg_evtq_stop_cb(), called earlier in
+	 * virtio_usb_remove()'s vqueues[i].stop() loop.
+	 */
+	otg_vports_deinit(vusb);
 	vusb->otg = NULL;
 }
 
+/**
+ * virtio_usb_otg_evt_notify_cb() - OTG Event virtqueue notification callback
+ * @vqueue: Underlying event virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from the
+ * device.
+ *
+ * Context: Interrupt context.
+ */
+static void virtio_usb_otg_evt_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_usb *vusb = vqueue->vdev->priv;
+
+	if (!READ_ONCE(vusb->started) || !vusb->otg)
+		return;
+
+	schedule_work(&vusb->otg->event_process_work);
+}
+
 /* Send an OTG command and get a response.
  *
  * The function is implemented as synchronous. Design pattern is
  * virtio_can.c/virtio_can_send_ctrl_msg()
  */
-u32 otg_get_role(struct virtio_usb *vusb, int port_id, u32 *role)
+u32 otg_get_role(struct virtio_usb *vusb, int port_id, u32 *role,
+		 u32 *supported_role)
 {
-	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
-	struct virtqueue *vq =
-		vusb->otg->oqs[VIRTIO_USB_VQ_COMMAND_IDX]->vqueue;
-	unsigned int len;
+	struct virtio_usb_otg_cmd_hdr *hdr;
+	struct virtio_usb_otg_cmd_role *resp;
+	struct virtio_usb_cmd *cmd;
 	u32 status = VIRTIO_USB_S_ERR_INTERNAL;
+	int rc;
 
-	struct otg_get_role {
-		struct virtio_usb_otg_cmd_hdr cmd_hdr;
-		struct virtio_usb_otg_cmd_role cmd_role;
-	} *msg = kzalloc(sizeof(struct otg_get_role), GFP_KERNEL);
-
-	if (!msg)
+	cmd = virtio_usb_cmd_alloc(sizeof(*hdr), sizeof(*resp), GFP_KERNEL);
+	if (!cmd)
 		return status;
 
-	msg->cmd_hdr.code = cpu_to_le32(VIRTIO_USB_CMD_OTG_GET_ROLE);
-	msg->cmd_hdr.port = cpu_to_le32(port_id);
-	sg_init_one(&sg_out, &msg->cmd_hdr, sizeof(msg->cmd_hdr));
-	sg_init_one(&sg_in, &msg->cmd_role, sizeof(msg->cmd_role));
+	hdr = virtio_usb_cmd_request(cmd);
+	hdr->code = cpu_to_le32(VIRTIO_USB_CMD_OTG_GET_ROLE);
+	hdr->port = cpu_to_le32(port_id);
+	cmd->msg.queue = vusb->otg->oqs[VIRTIO_USB_VQ_COMMAND_IDX];
 
-	mutex_lock(&vusb->otg->lock);
+	virtio_usb_cmd_ref(cmd);
 
-	if (virtqueue_add_sgs(vq, sgs, 1u, 1u, msg, GFP_ATOMIC)) {
-		pr_err("%s virtqueue_add_sgs error\n", __func__);
-		goto exit;
-	}
+	mutex_lock(&vusb->otg->lock);
+	rc = virtio_usb_cmd_send_sync(vusb, NULL, NULL, cmd);
+	mutex_unlock(&vusb->otg->lock);
 
-	if (!virtqueue_kick(vq)) {
-		pr_err("%s virtqueue_kick error\n", __func__);
-		goto exit;
+	if (rc) {
+		pr_err("%s virtio_usb_cmd_send_sync() error %d\n", __func__,
+		       rc);
+		virtio_usb_cmd_unref(cmd);
+		return status;
 	}
 
-	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
-		wait_for_completion(&vusb->otg->completion);
-
-	status = le32_to_cpu(msg->cmd_role.status.code);
-	*role = le32_to_cpu(msg->cmd_role.role);
+	resp = virtio_usb_cmd_response(cmd);
+	status = le32_to_cpu(resp->status.code);
+	*role = le32_to_cpu(resp->role);
+	*supported_role = le32_to_cpu(resp->supported_role);
+	virtio_usb_cmd_unref(cmd);
 
 	if (*role != VIRTIO_USB_ROLE_HOST && *role != VIRTIO_USB_ROLE_DEVICE)
 		pr_err("%s - wrong role (%d)\n", __func__, *role);
@@ -96,71 +370,32 @@ u32 otg_get_role(struct virtio_usb *vusb, int port_id, u32 *role)
 				"VIRTIO_USB_ROLE_DEVICE");
 	}
 
-exit:
-	kfree(msg);
-	mutex_unlock(&vusb->otg->lock);
 	return status;
 }
 
-static void virtio_usb_otg_cmd_notify_cb(struct virtqueue *vqueue)
-{
-	struct virtio_usb *vusb = vqueue->vdev->priv;
-
-	if (!vusb->otg)
-		return;
-
-	complete(&vusb->otg->completion);
-}
-
-static void virtio_usb_otg_cmdq_stop_cb(struct virtio_usb *vusb,
-					struct virtio_usb_queue *vq)
-{
-	unsigned long flags;
-
-	if (!vusb->otg || !vq->vqueue)
-		return;
-
-	/*
-	 * Wake sleepers in OTG synchronous command paths so they can
-	 * observe started=false and exit.
-	 */
-	complete_all(&vusb->otg->completion);
-
-	spin_lock_irqsave(&vq->lock, flags);
-	virtqueue_disable_cb(vq->vqueue);
-	spin_unlock_irqrestore(&vq->lock, flags);
-}
-
 static void virtio_usb_otg_evtq_stop_cb(struct virtio_usb *vusb,
 					struct virtio_usb_queue *vq)
 {
-	unsigned long flags;
-	u32 length;
-	void *buf;
-
-	if (!vq->vqueue)
-		return;
-
-	/* The OTG event queue is not populated yet at this stage (no
-	 * VIRTIO_USB_F_SWITCH_ROLE negotiation, no CHANGE_ROLE events),
-	 * so this only has to make sure del_vqs() finds the ring empty.
+	/*
+	 * Now that otg_get_role()/virtio_usb_otg_set_role_work() go
+	 * through the common, timeout-protected virtio_usb_cmd_send_sync()
+	 * instead of blocking indefinitely on virtqueue_is_broken(), it's
+	 * safe to cancel event_process_work directly here, same as every
+	 * other role's own evtq stop callback.
 	 */
-	spin_lock_irqsave(&vq->lock, flags);
-	virtqueue_disable_cb(vq->vqueue);
-	while ((buf = virtqueue_get_buf(vq->vqueue, &length)))
-		;
-	spin_unlock_irqrestore(&vq->lock, flags);
+	virtio_usb_evt_drain_stop_cb(
+		vq, vusb->otg ? &vusb->otg->event_process_work : NULL);
 }
 
 const struct virtio_usb_vq_desc otg_vqueues[VIRTIO_USB_VQ_OTG_MAX] = {
 	[VIRTIO_USB_VQ_COMMAND_IDX] = {
-		.callback = virtio_usb_otg_cmd_notify_cb,
+		.callback = virtio_usb_cmd_notify_cb,
 		.name = "virtusb-otg-cmd",
-		.process = NULL,
-		.stop = virtio_usb_otg_cmdq_stop_cb,
+		.process = virtio_usb_cmd_process_cb,
+		.stop = virtio_usb_cmdq_stop_cb,
 	},
 	[VIRTIO_USB_VQ_EVENT_IDX] = {
-		.callback = NULL,
+		.callback = virtio_usb_otg_evt_notify_cb,
 		.name = "virtusb-otg-evt",
 		.process = NULL,
 		.stop = virtio_usb_otg_evtq_stop_cb,
diff --git a/drivers/usb/virtio_usb/otg.h b/drivers/usb/virtio_usb/otg.h
index a34317c..85e9b9e 100644
--- a/drivers/usb/virtio_usb/otg.h
+++ b/drivers/usb/virtio_usb/otg.h
@@ -8,17 +8,29 @@
 #ifndef VIRTIO_USB_OTG_H
 #define VIRTIO_USB_OTG_H
 
+#include <linux/usb/role.h>
 #include "controller.h"
 
 extern int otg_init(struct virtio_usb *vusb);
+extern int otg_sysfs_init(struct virtio_usb *vusb);
 extern void otg_deinit(struct virtio_usb *vusb);
-extern u32 otg_get_role(struct virtio_usb *vusb, int port_id, u32 *role);
+extern u32 otg_get_role(struct virtio_usb *vusb, int port_id, u32 *role,
+			u32 *supported_role);
+
+struct virtio_usb_port_otg {
+	struct virtio_usb *vusb;
+	struct mutex lock;
+	struct usb_role_switch *sw;
+	char *sysfs_name;
+	struct work_struct set_role_work;
+	int port_id;
+};
 
 struct virtio_usb_otg {
 	struct virtio_usb *vusb;
 	struct mutex lock;
-	struct completion completion;
 	struct virtio_usb_queue *oqs[VIRTIO_USB_VQ_OTG_MAX];
+	struct work_struct event_process_work;
 };
 
 extern const struct virtio_usb_vq_desc otg_vqueues[VIRTIO_USB_VQ_OTG_MAX];
