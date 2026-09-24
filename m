Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374C4B04B3
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266190; cv=none; b=GXagw+sqB6NZ0ffxDd2QhujjWco907WZZhIDFK0oz31CNu1zfq+TveiF/hMT2zQanXWiFs65DXjtme52kXzKGf9OntVApAmK1AgzZg8MqNqmmPfR6TjXQMaB9xSfP5UOY5rQl85D65uGMce2uK7IeDH7G1997eTI7jd6yriMmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266190; c=relaxed/simple;
	bh=nFkNP2XqgD6acFW2c2S80rUt0aCFsl/KtpgSbhtHmdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffIIGrN69w5/SRb7dUkeC9DgkhQyvTeHH/Oqv9tbAy4y0jlIA3njAl3n3t/I6Nc/oZ6jI/aSB/i0hQo6k8Zy7y4zpRb8TbhzQS1ijwsi40qrHXo9Y5GCmLGLliQf1B9/7TlM0ps3zpJEBP+tp0GAtLyc8Lu8PaX5oNxYm0SNx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGkOpwTc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KwUKw1Bd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGkOpwTc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwUKw1Bd"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFeQnM3754779
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ayko0KHZ47N
	52S+7Rlk65dMQqxbuEpTsbWLoLdxw6Qs=; b=dGkOpwTcxkHvedaBco2PZnR6B+A
	sqWtH3NFTV4fORuIZNozDS00gfWB2dtKRI3jW8aV7Ns16pSh56n1KH6ekT79p6Wz
	Qy+rn33me61QApwNLmEuYsiobHXePEHtXDdeH29QmkD5n0XyHecc3B/f5YqgTH6q
	0/2Jv2n0n5+MPsfiNmRcpM1WBvLuPUKdtgeMev+DAB0R51hsrVV7MoiCXTK9+ay0
	JwEfR2IFGjH/QSPIYOtEc5SiAa7bNgymAFr65exEKdiFiBY9R262QJB/7SHfXwdi
	SP90PzhZq2Im8SyuOtodKYPKtNUH2buyjIv32L4U9kNv+zOJ+lJHNFrIMsg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstukm7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:09:45 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78fb9f59781so1987894137.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790266185; x=1790870985; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ayko0KHZ47N52S+7Rlk65dMQqxbuEpTsbWLoLdxw6Qs=;
        b=KwUKw1BdulTBSGoUVuijDV2fw5nChNm57v6thcGTDI/H8u/WXVZjXPMJuUq1+KaJPo
         G6TzU72UmqQAhaWkIQ2civzFGUXn6tyfmHAWTG0xRNb4uOfoyCFPh0ihTTkSe2poxE0U
         wRyFVxeipBjVUlNJRvvjWLOnR+ifjHc3eRlNbK/AH87R+3LJbYhhl4pvnC2QI8e9t5fr
         sOPJ/hlepNlyahyeDkdLGHox5m9j7jpTd5/fI0arZ/RNcYfAtSpI805fUo3I7WBcEtct
         iGx6OKXbSCcCgOOGHbviIQmkH2rKUf1Ahn2/cxbj38DMCRk7tvVf886+uYGma3ScFHzN
         33jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266185; x=1790870985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ayko0KHZ47N52S+7Rlk65dMQqxbuEpTsbWLoLdxw6Qs=;
        b=QELuwFlRWtIHG8c1XFhrIF+XJ7IP/FCO2ZTTCWZnJ9YPFY5m4XBAJD1u2OltDqIReL
         guofV2eUKU3rIIvSkl1jr1t1yOedxtM33pQFkjrlE5qPbtcOtlr9JQKGytTCPSwrz3nA
         Cykkk8xcRG3yarWXJQuYgxcpCRo/cLQS9NrhO4vqIjkI5Aczu5oAlR3fD5SnWXexkwNP
         5YuP0iicJOqYRaygotJsdHX5OdfGtmmdq20Ugln5o2lWXAjxmZOORBHspA+iSBkkAoYX
         P8pVN01mkifKvlYvuu60Cce8IHdSVT8Y9bamCreAh6/+rvGuWotxuVIoo8MaXe5PMEQv
         oOWA==
X-Gm-Message-State: AFuF++md03Ll0nDf3WRAZ74U3z+7MoMsdfdiXNxj6ZE0fgAGP9BVt+77
	8P5NH74P5/5BI6N69hXNy1S0E/Qt08fF2ZuFZRp4FmNCIccqJr3RRJ63MgG9zhvMNG5obMxiJ3S
	H/hGelTFFKHxDcwX14h5kIN2eCbAxrXeg+jCVigU7s6JqU/PYBHawXzDIPEtnXOvaqYvsPNF8na
	L/5w==
X-Gm-Gg: AYBFou2nopAo6V/UXNqcCkeiNltGHiohNiHzPo2oSdUasWO33ZTKwfJNnY3vGmNCd85
	nrA/c/elCPSk1PjZGLPTUKc9k63lQ8sGWJUJcKBcCoaTMjC882llBw1N9QuTce2J7QfYTHMFije
	nXrIeinSMpODl0owPwM9jxcfkpwg4GvprqjnksZTulphdvjgDhhSYjVE8BxIYH/nBbnJjvA22mP
	uyxJcrTZyv3ogjcAXRsjb4HRcooC8n9G3lk+5B7yrNkMyArNZerRDB8om7KcGXjL9RuahcJdO47
	PKpA8ANYsmaPkFm168v4Iyz+Tm8kXEiO7/W7xc8dRIb2DSTcRFYj1n/mi2W/0uKSZ9KeTtWlW+v
	pzljJsXTVG5esPvpOYcW7UF6tud9qQKc=
X-Received: by 2002:a05:6102:3fac:b0:7a5:72f6:3a0b with SMTP id ada2fe7eead31-7af1ce9e845mr1652683137.14.1790266184311;
        Thu, 24 Sep 2026 09:09:44 -0700 (PDT)
X-Received: by 2002:a05:6102:3fac:b0:7a5:72f6:3a0b with SMTP id ada2fe7eead31-7af1ce9e845mr1652663137.14.1790266183638;
        Thu, 24 Sep 2026 09:09:43 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c5c4csm328306766b.18.2026.09.24.09.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:09:42 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org,
        Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
        Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
        Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 6/8] virtio-usb: rework endpoint lifecycle to an async split-phase state machine
Date: Thu, 24 Sep 2026 18:09:05 +0200
Message-ID: <20260924160907.145405-7-igor.skalkin@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX5DqOcTMvMDIx
 6wEhPASQ0ckMdAmhikDXqCCnNw6v2yLPkjH8ynO4hMvrjFMjS6HUFbYzj0CrFPJFqdcgp44Xvxl
 gQEb413ecUEZ6VggpEdKZCcaBFtHrO8=
X-Proofpoint-ORIG-GUID: uMR3m-Rw_p-2zOEsESvg4WZeoT_dzyF9
X-Proofpoint-GUID: uMR3m-Rw_p-2zOEsESvg4WZeoT_dzyF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NiBTYWx0ZWRfX9kQ38K4nA51p
 ibVdEHxkev1FYYO9u9g41QaSeyS7q1GB1JIz+JD1vU1kHuaF7gUOiYY17/7hrnVHqqrKhb0lt6D
 GO5xLpkWYUrtM2IgAT0b3ymxQtmeGJW7O+BQlU3hvzkAhP0iNS0idJ0nBNy4z3A6tnxd6VLuEkr
 KVI2HsZnMwO2rugKx06LYcJYZVY2G/s9bYjFpGbjbKdAuePAZt65xfh56vvle+L6BQghlHlT4L8
 J7k73SXi7BzW5rQSIy9ZP3ofYYtvXIMd4+sNi6C765Qk8EzBcAe2fEAqGryZN4X8IyKwCvavs4D
 9yz8fo9eI71bjin0inqqDty6diYPAZ474xTH11pSwR5Ku2du0+lO1prFJCt1EH1FPZlRaQj5CdB
 9NK1zjTcU2xOJOGaeWMBaH7NcEMr70CzhAROaVxGnSIzopOnTlftlRKvdyLYl/mPxMHmehXj8lg
 WGNn7pic6RuUW1GHm4g==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab54b4a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=lsKRr0NpPQ41l5Grd8sA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240066

The USB gadget API's usb_ep_ops/usb_gadget_ops callbacks are documented
as atomic - they must not sleep. This driver's endpoint and command
handling needs to send a virtio command and wait for the backend's
response, which is exactly what those callbacks cannot do.

We previously worked around this with a small out-of-tree patch to
the gadget core itself: a gadget.nonatomic flag that, when set, swapped
the UDC core's spinlocks for mutexes so a driver could sleep in these
callbacks. That patch was never going to pass upstream review, so it
had to go - which meant this driver needed to actually honor the
atomic contract instead of relying on a modified core.

This commit is that fix: an explicit endpoint state machine
(EP_DISABLED, EP_ENABLING, EP_ENABLED, EP_HALTED) plus per-UDC/
per-request work items and a pending-request queue, so every
usb_ep_ops/usb_gadget_ops callback returns immediately and the actual
virtio round trip happens asynchronously on a workqueue.
ep_enable()/ep_disable()/set_selfpowered()/vbus_draw() all move to
this split-phase pattern; ep_queue()/ep_dequeue() are reworked on top
of the same state machine. gadget.nonatomic itself is removed, since
nothing needs it anymore.

Also fixes a handful of bugs found while doing this: preserve
-ECONNRESET/-ESHUTDOWN completion statuses instead of always
overwriting them, support early-completed requests without a double
giveback(), serialize SETUP handling against in-flight EP0 completions
and still-EP_ENABLING endpoints to avoid overlapping control transfers
exposed by dummy_hcd's tighter timing, and fix EP0's descriptor
initialization and a spinlock-unbalance bug in ep_enable().

Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
---
 drivers/usb/virtio_usb/device.c |  774 +++++++++++++++++++++++++++++++---------
 drivers/usb/virtio_usb/device.h |   24 +
 2 files changed, 639 insertions(+), 159 deletions(-)

diff --git a/drivers/usb/virtio_usb/device.c b/drivers/usb/virtio_usb/device.c
index 5ae0fc8..9ee1f05 100644
--- a/drivers/usb/virtio_usb/device.c
+++ b/drivers/usb/virtio_usb/device.c
@@ -11,6 +11,7 @@
 #include "device.h"
 
 #define GADGET_NAME "virtio_usb_dc"
+#define VIRTIO_USB_EP0_IDLE_TIMEOUT_MS 5000
 
 /**
  * struct virtio_usb_dc_priv - Device controller data priv
@@ -23,6 +24,8 @@ struct virtio_usb_dc_priv {
 	struct usb_request req;
 	struct virtio_usb_ep *vep;
 	struct virtio_usb_data *vreq;
+	struct work_struct cancel_work;
+	bool completed_early;
 };
 
 /**
@@ -72,6 +75,34 @@ static struct virtio_usb_data *usb_req_to_virtio_data(struct usb_request *req)
 	return priv->vreq;
 }
 
+static bool virtio_usb_dc_req_queue_empty(struct virtio_usb_ep *vep)
+{
+	struct virtio_usb_dc *vudc = vep->vudc;
+	unsigned long flags;
+	bool empty;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	empty = list_empty(&vep->req_queue);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	return empty;
+}
+
+static int virtio_usb_dc_wait_ep0_idle(struct virtio_usb_dc *vudc)
+{
+	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(vudc->gadget.ep0);
+	long ret;
+
+	if (virtio_usb_dc_req_queue_empty(vep))
+		return 0;
+
+	ret = wait_event_timeout(
+		vudc->ep0_idle, virtio_usb_dc_req_queue_empty(vep),
+		msecs_to_jiffies(VIRTIO_USB_EP0_IDLE_TIMEOUT_MS));
+
+	return ret ? 0 : -ETIMEDOUT;
+}
+
 /**
  * virtio_usb_dc_complete_req() - Completes a usb request
  * @vreq: virtio usb data message.
@@ -89,6 +120,8 @@ static void virtio_usb_dc_complete_req(struct virtio_usb_data *vreq)
 	struct virtio_usb_data *vreq_iter;
 	unsigned int found = 0;
 	unsigned long flags;
+	bool wake_ep0 = false;
+	bool early;
 
 	spin_lock_irqsave(&vudc->lock, flags);
 
@@ -98,10 +131,15 @@ static void virtio_usb_dc_complete_req(struct virtio_usb_data *vreq)
 			break;
 		}
 	}
+	early = priv->completed_early;
 	if (!found) {
 		spin_unlock_irqrestore(&vudc->lock, flags);
+		/* Arrived after ep_disable() already gave back */
+		if (early)
+			virtio_usb_data_unref(vreq);
 		return;
 	}
+	/* Common case - request still belongs to in-flight queue */
 	if (req->status != -ECONNRESET && req->status != -ESHUTDOWN) {
 		req->status = virtio_error_to_usb(status);
 		if (!req->status)
@@ -109,9 +147,17 @@ static void virtio_usb_dc_complete_req(struct virtio_usb_data *vreq)
 	}
 
 	list_del_init(&vreq->list);
+	wake_ep0 = !vep->ep_id && list_empty(&vep->req_queue);
 	spin_unlock_irqrestore(&vudc->lock, flags);
+	if (wake_ep0)
+		wake_up(&vudc->ep0_idle);
+
+	/* Normal completion: giveback now */
+	if (!early)
+		usb_gadget_giveback_request(&vep->ep, req);
+
+	/* Drop final reference */
 	virtio_usb_data_unref(vreq);
-	usb_gadget_giveback_request(&vep->ep, req);
 }
 
 /**
@@ -128,22 +174,24 @@ void virtio_usb_dc_data_work(struct work_struct *work)
 	struct virtio_usb_queue *dataq =
 		&vusb->vqueues[vusb->dev_vq_base + VIRTIO_USB_VQ_DATA_IDX];
 	struct virtio_usb_data *vreq;
+	unsigned long flags;
 	unsigned int length;
 
-	spin_lock_irq(&dataq->lock);
+	spin_lock_irqsave(&dataq->lock, flags);
 	do {
 		virtqueue_disable_cb(dataq->vqueue);
 		while ((vreq = virtqueue_get_buf(dataq->vqueue, &length))) {
-			spin_unlock_irq(&dataq->lock);
+			spin_unlock_irqrestore(&dataq->lock, flags);
 			virtio_usb_dc_complete_req(vreq);
-			spin_lock_irq(&dataq->lock);
+			spin_lock_irqsave(&dataq->lock, flags);
 		}
 		if (unlikely(virtqueue_is_broken(dataq->vqueue)))
 			break;
 	} while (!virtqueue_enable_cb(dataq->vqueue));
-	spin_unlock_irq(&dataq->lock);
+	spin_unlock_irqrestore(&dataq->lock, flags);
 }
 
+static void virtio_usb_dc_cancel_work(struct work_struct *work);
 /**
  * virtio_usb_dc_data_alloc() - Allocate and initialize a device controller
  * data message.
@@ -174,6 +222,8 @@ static struct virtio_usb_data *virtio_usb_dc_data_alloc(struct usb_ep *ep,
 	priv = virtio_usb_data_priv(vreq);
 	priv->vep = vep;
 	priv->vreq = vreq;
+	priv->completed_early = false;
+	INIT_WORK(&priv->cancel_work, virtio_usb_dc_cancel_work);
 	vreq->msg.queue =
 		&vep->vudc->vusb->vqueues[vep->vudc->vusb->dev_vq_base +
 					  VIRTIO_USB_VQ_DATA_IDX];
@@ -242,6 +292,264 @@ virtio_usb_dc_cmd_alloc(struct virtio_usb_dc *vudc, unsigned int command,
 
 /* Endpoint callbacks */
 
+static int do_real_queue(struct virtio_usb_ep *vep, struct usb_request *req)
+{
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_data *vreq = usb_req_to_virtio_data(req);
+	struct virtio_usb_dc_priv *priv = virtio_usb_data_priv(vreq);
+	struct virtio_usb_request *request;
+	struct virtio_usb_response *response;
+	struct scatterlist *out_sgs = NULL, *in_sgs = NULL, *psg_data = NULL;
+	struct scatterlist sg;
+	unsigned long flags;
+	u16 endpoint;
+	u16 transfer_flags = 0;
+	u16 transfer_type = VIRTIO_USB_EP_CONTROL;
+	int rc;
+
+	virtio_usb_data_ref(vreq);
+
+	request = virtio_usb_data_request(vreq);
+	response = virtio_usb_data_response(vreq);
+	response->actual_length = cpu_to_le32(0);
+	response->status = cpu_to_le32(VIRTIO_USB_S_ERR_INTERNAL);
+
+	if (req->short_not_ok)
+		transfer_flags |= VIRTIO_USB_FLAG_SHORT_NOT_OK;
+	else if (req->zero)
+		transfer_flags |= VIRTIO_USB_FLAG_ZERO_PACKET;
+	request->transfer_flags = cpu_to_le16(transfer_flags);
+
+	endpoint = vep->ep_id |
+		   (usb_ep_dir_in(&vep->ep) ? VIRTIO_USB_EP_DIR_IN :
+					      VIRTIO_USB_EP_DIR_OUT);
+	request->endpoint = cpu_to_le16(endpoint);
+	request->port = cpu_to_le16(vudc->port);
+	if (vep->ep_id && vep->ep.desc) {
+		switch (usb_endpoint_type(vep->ep.desc)) {
+		case USB_ENDPOINT_XFER_ISOC:
+			transfer_type = VIRTIO_USB_EP_ISOCHRONOUS;
+			break;
+		case USB_ENDPOINT_XFER_BULK:
+			transfer_type = VIRTIO_USB_EP_BULK;
+			break;
+		case USB_ENDPOINT_XFER_INT:
+			transfer_type = VIRTIO_USB_EP_INTERRUPT;
+			break;
+		default:
+			transfer_type = VIRTIO_USB_EP_CONTROL;
+			break;
+		}
+	}
+	request->transfer_type = cpu_to_le16(transfer_type);
+
+	if (req->length && req->buf) {
+		psg_data = &sg;
+		sg_init_one(psg_data, req->buf, req->length);
+	} else if (req->length && req->num_sgs > 0) {
+		psg_data = req->sg;
+	} else if (req->length && req->sg) {
+		psg_data = &sg;
+		sg_init_one(psg_data, sg_virt(req->sg), req->length);
+	} else {
+		psg_data = NULL;
+	}
+
+	if (usb_ep_dir_in(&vep->ep))
+		out_sgs = psg_data;
+	else
+		in_sgs = psg_data;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	priv->completed_early = false;
+	req->actual = 0;
+	req->status = -EINPROGRESS;
+	list_add_tail(&vreq->list, &vep->req_queue);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	rc = virtio_usb_data_send(vudc->vusb, vreq, out_sgs, in_sgs);
+	if (rc) {
+		spin_lock_irqsave(&vudc->lock, flags);
+		list_del_init(&vreq->list);
+		spin_unlock_irqrestore(&vudc->lock, flags);
+
+		virtio_usb_data_unref(vreq);
+		return rc;
+	}
+
+	return 0;
+}
+
+static bool virtio_usb_dc_ep_enabling_locked(struct virtio_usb_dc *vudc)
+{
+	u32 i;
+
+	for (i = 1; i < vudc->neps; i++) {
+		if (vudc->veps[i].state == EP_ENABLING)
+			return true;
+	}
+
+	return false;
+}
+
+static void virtio_usb_dc_flush_ep0_pend(struct virtio_usb_dc *vudc)
+{
+	struct virtio_usb_ep *vep = &vudc->veps[0];
+	struct virtio_usb_data *vreq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+	if (virtio_usb_dc_ep_enabling_locked(vudc)) {
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return;
+	}
+
+	while (!list_empty(&vep->pend_queue)) {
+		struct virtio_usb_dc_priv *priv;
+		int qrc;
+
+		vreq = list_first_entry(&vep->pend_queue,
+					struct virtio_usb_data, list);
+		priv = virtio_usb_data_priv(vreq);
+		list_del_init(&vreq->list);
+		spin_unlock_irqrestore(&vudc->lock, flags);
+
+		qrc = do_real_queue(vep, &priv->req);
+		virtio_usb_data_unref(vreq);
+		if (qrc) {
+			priv->req.status = qrc;
+			usb_gadget_giveback_request(&vep->ep, &priv->req);
+		}
+
+		spin_lock_irqsave(&vudc->lock, flags);
+	}
+	spin_unlock_irqrestore(&vudc->lock, flags);
+}
+
+static bool
+virtio_usb_ep_comp_valid(const struct usb_ss_ep_comp_descriptor *comp)
+{
+	return comp && comp->bLength == USB_DT_SS_EP_COMP_SIZE &&
+	       comp->bDescriptorType == USB_DT_SS_ENDPOINT_COMP;
+}
+
+static void vep_enable_work(struct work_struct *work)
+{
+	struct virtio_usb_ep *vep =
+		container_of(work, struct virtio_usb_ep, enable_work);
+	struct virtio_usb_dc *vudc = vep->vudc;
+	const struct usb_endpoint_descriptor *desc = vep->ep.desc;
+	struct scatterlist sg;
+	struct scatterlist *psg_data = &sg;
+	struct virtio_usb_dev_cmd_hdr *hdr;
+	struct virtio_usb_cmd *cmd;
+	unsigned long flags;
+	u16 endpoint;
+	int rc;
+
+	if (!desc)
+		return;
+
+	endpoint = vep->ep_id |
+		   (usb_ep_dir_in(&vep->ep) ? VIRTIO_USB_EP_DIR_IN :
+					      VIRTIO_USB_EP_DIR_OUT);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_ENABLE,
+				      GFP_KERNEL);
+	if (!cmd) {
+		rc = -ENOMEM;
+		goto done;
+	}
+
+	sg_init_one(psg_data, desc, sizeof(*desc));
+	hdr = virtio_usb_cmd_request(cmd);
+	hdr->endpoint = cpu_to_le16(endpoint);
+
+	rc = virtio_usb_cmd_send_sync(vudc->vusb, psg_data, NULL, cmd);
+
+done:
+	spin_lock_irqsave(&vudc->lock, flags);
+	if (!rc) {
+		vep->state = EP_ENABLED;
+		vep->last_err = 0;
+		/* Flush pend_queue */
+		while (!list_empty(&vep->pend_queue)) {
+			struct virtio_usb_data *vreq = list_first_entry(
+				&vep->pend_queue, struct virtio_usb_data, list);
+			struct virtio_usb_dc_priv *priv =
+				virtio_usb_data_priv(vreq);
+			int qrc;
+
+			list_del_init(&vreq->list);
+			spin_unlock_irqrestore(&vudc->lock, flags);
+			qrc = do_real_queue(vep, &priv->req);
+			/*
+			 * do_real_queue() takes its own ref for the
+			 * in-flight/vring lifetime; drop the ref that kept
+			 * vreq alive while it was parked in pend_queue.
+			 */
+			virtio_usb_data_unref(vreq);
+			if (qrc) {
+				/*
+				 * Request was accepted while EP was ENABLING.
+				 * If forwarding now fails, complete it with
+				 * error instead of silently dropping it.
+				 */
+				priv->req.status = qrc;
+				usb_gadget_giveback_request(&vep->ep,
+							    &priv->req);
+			}
+			spin_lock_irqsave(&vudc->lock, flags);
+		}
+	} else {
+		vep->state = EP_HALTED;
+		vep->last_err = rc;
+
+		while (!list_empty(&vep->pend_queue)) {
+			struct virtio_usb_data *vreq = list_first_entry(
+				&vep->pend_queue, struct virtio_usb_data, list);
+			struct virtio_usb_dc_priv *priv =
+				virtio_usb_data_priv(vreq);
+
+			list_del_init(&vreq->list);
+			priv->req.status = rc;
+			spin_unlock_irqrestore(&vudc->lock, flags);
+			virtio_usb_data_unref(vreq);
+			usb_gadget_giveback_request(&vep->ep, &priv->req);
+			spin_lock_irqsave(&vudc->lock, flags);
+		}
+	}
+	spin_unlock_irqrestore(&vudc->lock, flags);
+	virtio_usb_dc_flush_ep0_pend(vudc);
+}
+
+static void vep_disable_work(struct work_struct *work)
+{
+	struct virtio_usb_ep *vep =
+		container_of(work, struct virtio_usb_ep, disable_work);
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_cmd *cmd;
+	struct virtio_usb_dev_cmd_hdr *hdr;
+	u16 endpoint;
+
+	if (!READ_ONCE(vudc->driver) || !vudc->registered)
+		return;
+
+	endpoint = vep->ep_id |
+		   (usb_ep_dir_in(&vep->ep) ? VIRTIO_USB_EP_DIR_IN :
+					      VIRTIO_USB_EP_DIR_OUT);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_DISABLE,
+				      GFP_KERNEL);
+	if (!cmd)
+		return;
+
+	hdr = virtio_usb_cmd_request(cmd);
+	hdr->endpoint = cpu_to_le16(endpoint);
+
+	(void)virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+}
+
 /**
  * virtio_ep_enable() - Enable endpoint
  * This callback is called to configure endpoint and make it usable.
@@ -256,44 +564,30 @@ static int virtio_ep_enable(struct usb_ep *ep,
 {
 	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
 	struct virtio_usb_dc *vudc = vep->vudc;
-	struct scatterlist sg;
-	struct scatterlist *psg_data = &sg;
-	struct virtio_usb_dev_cmd_hdr *hdr;
-	struct virtio_usb_cmd *cmd;
 	unsigned long flags;
-	u16 endpoint;
-	int rc;
-
-	if (!vudc->driver)
-		return -ESHUTDOWN;
 
 	spin_lock_irqsave(&vudc->lock, flags);
 
-	if (!ep || !desc || ep->caps.type_control ||
+	if (!vudc->driver || !ep || !desc || ep->caps.type_control ||
 	    desc->bDescriptorType != USB_DT_ENDPOINT) {
 		spin_unlock_irqrestore(&vudc->lock, flags);
 		return -EINVAL;
 	}
 
+	if (vep->state != EP_DISABLED) {
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return -EBUSY;
+	}
+
 	ep->desc = desc;
 	ep->maxpacket = usb_endpoint_maxp(desc);
-	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
-						     VIRTIO_USB_EP_DIR_OUT);
-
-	spin_unlock_irqrestore(&vudc->lock, flags);
-
-	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_ENABLE,
-				      GFP_ATOMIC);
-	if (!cmd)
-		return -ENOMEM;
+	vep->state = EP_ENABLING;
 
-	sg_init_one(psg_data, desc, sizeof(*desc));
-	hdr = virtio_usb_cmd_request(cmd);
-	hdr->endpoint = cpu_to_le16(endpoint);
+	queue_work(vudc->ep_cmd_wq, &vep->enable_work);
 
-	rc = virtio_usb_cmd_send_sync(vudc->vusb, psg_data, NULL, cmd);
+	spin_unlock_irqrestore(&vudc->lock, flags);
 
-	return rc;
+	return 0;
 }
 
 /**
@@ -311,42 +605,82 @@ static int virtio_ep_disable(struct usb_ep *ep)
 	struct virtio_usb_data *vreq = NULL, *vreq_tmp;
 	struct virtio_usb_dc *vudc = vep->vudc;
 	struct virtio_usb_dc_priv *priv = NULL;
-	struct virtio_usb_dev_cmd_hdr *hdr;
-	struct virtio_usb_cmd *cmd;
+	LIST_HEAD(giveback_inflight);
+	LIST_HEAD(giveback_pended);
 	unsigned long flags;
-	u16 endpoint;
-	int rc;
 
-	if (!ep || ep->caps.type_control)
+	if (!ep || ep->caps.type_control) // EP0 not called disable
 		return -EINVAL;
 
 	spin_lock_irqsave(&vudc->lock, flags);
 
+	if (vep->state == EP_ENABLING) {
+		/*
+		 * cancel_work_sync() can sleep and must not be called while
+		 * holding vudc->lock: vep_enable_work() only re-acquires
+		 * this same lock after its (possibly blocking) virtio
+		 * command completes, so holding the lock here across
+		 * cancel_work_sync() would deadlock against it.
+		 */
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		cancel_work_sync(&vep->enable_work);
+		spin_lock_irqsave(&vudc->lock, flags);
+	}
+
+	if (vep->state == EP_DISABLED) {
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return 0;
+	}
+
+	vep->state = EP_DISABLED;
+
+	/*
+	 * All pending (waiting for the ENABLING) - put to local list for
+	 * giveback(-ESHUTDOWN). These requests are not in the virtqueue,
+	 * can be unref now.
+	 */
+	list_for_each_entry_safe(vreq, vreq_tmp, &vep->pend_queue, list) {
+		list_del_init(&vreq->list);
+		list_add_tail(&vreq->list, &giveback_pended);
+	}
+
+	/*
+	 * in-flight requests - make early giveback, remove from req_queue,
+	 * mark completed_early, but do not unref: unref will be in complete
+	 * handler.
+	 */
 	list_for_each_entry_safe(vreq, vreq_tmp, &vep->req_queue, list) {
 		priv = virtio_usb_data_priv(vreq);
-		/**
-		 * When endpoint is disabled, completion handler for all pending
-		 * requests will be called. Make the request status to -ESHUTDOWN
-		 * to prevent requests completes even before the endpoint disable
-		 * is send to the controller.
-		 */
 		priv->req.status = -ESHUTDOWN;
+		priv->completed_early = true;
+		list_del_init(&vreq->list);
+		list_add_tail(&vreq->list, &giveback_inflight);
 	}
-	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
-						     VIRTIO_USB_EP_DIR_OUT);
+
 	spin_unlock_irqrestore(&vudc->lock, flags);
 
-	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_DISABLE,
-				      GFP_ATOMIC);
-	if (!cmd)
-		return -ENOMEM;
+	/* pending: just giveback and unref */
+	list_for_each_entry_safe(vreq, vreq_tmp, &giveback_pended, list) {
+		struct virtio_usb_dc_priv *p = virtio_usb_data_priv(vreq);
 
-	hdr = virtio_usb_cmd_request(cmd);
-	hdr->endpoint = cpu_to_le16(endpoint);
+		list_del_init(&vreq->list);
+		p->req.status = -ESHUTDOWN;
+		usb_gadget_giveback_request(&vep->ep, &p->req);
+		virtio_usb_data_unref(
+			vreq); /* drop the pend_queue ref taken in virtio_ep_queue() */
+	}
 
-	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+	/* in-flight: giveback now, unref will be in complete_req */
+	list_for_each_entry_safe(vreq, vreq_tmp, &giveback_inflight, list) {
+		struct virtio_usb_dc_priv *p = virtio_usb_data_priv(vreq);
 
-	return rc;
+		list_del_init(&vreq->list);
+		usb_gadget_giveback_request(&vep->ep, &p->req);
+	}
+
+	queue_work(vudc->ep_cmd_wq, &vep->disable_work);
+
+	return 0;
 }
 
 /**
@@ -395,75 +729,52 @@ static void virtio_ep_free_request(struct usb_ep *ep, struct usb_request *req)
 static int virtio_ep_queue(struct usb_ep *ep, struct usb_request *req,
 			   gfp_t mem_flags)
 {
-	struct scatterlist *out_sgs = NULL, *in_sgs = NULL, *psg_data;
 	struct virtio_usb_data *vreq = usb_req_to_virtio_data(req);
 	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
 	struct virtio_usb_dc *vudc = vep->vudc;
-	struct virtio_usb_response *response;
-	struct virtio_usb_request *request;
-	u16 transfer_flags = 0;
-	struct scatterlist sg;
 	unsigned long flags;
-	u16 endpoint;
-	int rc;
-
-	virtio_usb_data_ref(vreq);
+	int rc = 0;
 
 	spin_lock_irqsave(&vudc->lock, flags);
-	req->actual = 0;
-	req->status = -EINPROGRESS;
-
-	list_add_tail(&vreq->list, &vep->req_queue);
-	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
-						     VIRTIO_USB_EP_DIR_OUT);
-	spin_unlock_irqrestore(&vudc->lock, flags);
-
-	request = virtio_usb_data_request(vreq);
-	response = virtio_usb_data_response(vreq);
 
-	response->actual_length = cpu_to_le32(0);
-	response->status = cpu_to_le32(VIRTIO_USB_S_ERR_INTERNAL);
+	switch (vep->state) {
+	case EP_ENABLED:
+		if (!vep->ep_id && virtio_usb_dc_ep_enabling_locked(vudc)) {
+			virtio_usb_data_ref(vreq);
+			req->actual = 0;
+			req->status = -EINPROGRESS;
+			list_add_tail(&vreq->list, &vep->pend_queue);
+			spin_unlock_irqrestore(&vudc->lock, flags);
+			return 0;
+		}
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		rc = do_real_queue(vep, req);
+		/* if rc==0 - unref will be in completion, on failure
+		 * do_real_queue() has already dropped its own ref
+		 */
+		return rc;
 
-	if (req->short_not_ok)
-		transfer_flags |= VIRTIO_USB_FLAG_SHORT_NOT_OK;
-	else if (req->zero)
-		transfer_flags |= VIRTIO_USB_FLAG_ZERO_PACKET;
+	case EP_ENABLING:
+		/* Waiting for ENABLED state */
+		virtio_usb_data_ref(vreq);
+		req->actual = 0;
+		req->status = -EINPROGRESS;
+		list_add_tail(&vreq->list, &vep->pend_queue);
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		// Additional ref waited for the enable_work()
+		return 0;
 
-	request->transfer_flags = cpu_to_le16(transfer_flags);
-	request->endpoint = cpu_to_le16(endpoint);
-	request->port = cpu_to_le16(vudc->port);
+	case EP_HALTED:
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		req->status = vep->last_err ? vep->last_err : -EPIPE;
+		usb_gadget_giveback_request(&vep->ep, req);
+		return req->status;
 
-	if (req->length && req->buf) {
-		psg_data = &sg;
-		sg_init_one(psg_data, req->buf, req->length);
-	} else if (req->length && req->num_sgs > 0) {
-		psg_data = req->sg;
-	} else if (req->sg) {
-		psg_data = &sg;
-		sg_init_one(psg_data, sg_virt(req->sg), req->length);
-	} else {
-		psg_data = NULL;
+	case EP_DISABLED:
+	default:
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return -ESHUTDOWN;
 	}
-
-	if (usb_ep_dir_in(ep))
-		out_sgs = psg_data;
-	else
-		in_sgs = psg_data;
-
-	rc = virtio_usb_data_send(vudc->vusb, vreq, out_sgs, in_sgs);
-	if (rc)
-		goto on_error_vq;
-
-	return rc;
-
-on_error_vq:
-	spin_lock_irqsave(&vudc->lock, flags);
-	list_del_init(&vreq->list);
-	spin_unlock_irqrestore(&vudc->lock, flags);
-
-	virtio_usb_data_unref(vreq);
-
-	return rc;
 }
 
 /**
@@ -477,20 +788,32 @@ on_error_vq:
 static int virtio_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 {
 	struct virtio_usb_ep *vep = usb_ep_to_virtio_ep(ep);
-	struct virtio_usb_dev_cmd_cancel *cancel;
 	struct virtio_usb_dc *vudc = vep->vudc;
 	struct virtio_usb_dc_priv *priv;
 	struct virtio_usb_data *vreq;
-	struct virtio_usb_cmd *cmd;
 	unsigned long flags;
 	int rc = -EINVAL;
-	u16 endpoint;
 
 	if (!vudc->driver)
 		return -ESHUTDOWN;
 
 	spin_lock_irqsave(&vudc->lock, flags);
 
+	/* If request is still pending (ENABLING) */
+	list_for_each_entry(vreq, &vep->pend_queue, list) {
+		priv = virtio_usb_data_priv(vreq);
+		if (&priv->req == req) {
+			list_del_init(&vreq->list);
+			req->status = -ECONNRESET;
+			spin_unlock_irqrestore(&vudc->lock, flags);
+
+			virtio_usb_data_unref(vreq);
+			usb_gadget_giveback_request(ep, req);
+			return 0;
+		}
+	}
+
+	/* in-flight - schedule async cancel */
 	list_for_each_entry(vreq, &vep->req_queue, list) {
 		priv = virtio_usb_data_priv(vreq);
 		if (req == &priv->req) {
@@ -502,28 +825,14 @@ static int virtio_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 			break;
 		}
 	}
-	endpoint = vep->ep_id | (usb_ep_dir_in(ep) ? VIRTIO_USB_EP_DIR_IN :
-						     VIRTIO_USB_EP_DIR_OUT);
 	spin_unlock_irqrestore(&vudc->lock, flags);
 
-	if (rc)
+	if (rc) // request not found in req_queue
 		return rc;
 
-	vreq = priv->vreq;
+	schedule_work(&priv->cancel_work);
 
-	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_CANCEL,
-				      GFP_KERNEL);
-	if (!cmd)
-		return -ENOMEM;
-
-	cancel = virtio_usb_cmd_request(cmd);
-	cancel->hdr.endpoint = cpu_to_le16(endpoint);
-	cancel->hdr.port = cpu_to_le16(vudc->port);
-	cancel->tag = cpu_to_le64((uintptr_t)vreq);
-
-	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
-
-	return rc;
+	return 0;
 }
 
 /**
@@ -633,6 +942,109 @@ static const struct usb_ep_ops virtio_usb_ep_ops = {
 /*-------------------------------------------------------------------------*/
 /* UDC callbacks */
 
+static void virtio_usb_dc_cancel_work(struct work_struct *work)
+{
+	struct virtio_usb_dc_priv *priv =
+		container_of(work, struct virtio_usb_dc_priv, cancel_work);
+	struct virtio_usb_ep *vep = priv->vep;
+	struct virtio_usb_dc *vudc = vep->vudc;
+	struct virtio_usb_cmd *cmd;
+	struct virtio_usb_dev_cmd_cancel *cancel;
+	struct virtio_usb_data *vreq = priv->vreq;
+	unsigned long flags;
+	u16 endpoint;
+	struct virtio_usb_data *iter;
+	bool found = false;
+
+	spin_lock_irqsave(&vudc->lock, flags);
+
+	list_for_each_entry(iter, &vep->req_queue, list) {
+		if (iter == vreq) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		spin_unlock_irqrestore(&vudc->lock, flags);
+		return;
+	}
+	endpoint = vep->ep_id |
+		   (usb_ep_dir_in(&vep->ep) ? VIRTIO_USB_EP_DIR_IN :
+					      VIRTIO_USB_EP_DIR_OUT);
+	spin_unlock_irqrestore(&vudc->lock, flags);
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_CANCEL,
+				      GFP_KERNEL);
+	if (!cmd)
+		return;
+
+	cancel = virtio_usb_cmd_request(cmd);
+	cancel->hdr.endpoint = cpu_to_le16(endpoint);
+	cancel->hdr.port = cpu_to_le16(vudc->port);
+	cancel->tag = cpu_to_le64((uintptr_t)vreq);
+
+	(void)virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+}
+
+static int virtio_usb_dc_send_cmd(struct virtio_usb_dc *vudc,
+				  unsigned int cmd_code, unsigned int val)
+{
+	struct virtio_usb_dev_cmd_set_value *req;
+	struct virtio_usb_cmd *cmd;
+
+	cmd = virtio_usb_dc_cmd_alloc(vudc, cmd_code, GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	req = virtio_usb_cmd_request(cmd);
+	req->value = cpu_to_le32(val);
+
+	return virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+}
+
+static void virtio_usb_dc_work(struct work_struct *work)
+{
+	struct virtio_usb_dc *vudc =
+		container_of(work, struct virtio_usb_dc, dc_cmd_work);
+	int sp, ma;
+
+	mutex_lock(&vudc->dc_cmd_work_lock);
+
+	sp = atomic_xchg(&vudc->pending_self_pwr, -1);
+	ma = atomic_xchg(&vudc->pending_vbus_ma, -1);
+
+	if (sp >= 0) {
+		bool new_sp = (sp != 0);
+
+		if (new_sp != vudc->cur_self_pwr) {
+			(void)virtio_usb_dc_send_cmd(
+				vudc, VIRTIO_USB_CMD_DEV_SET_SELF_POWERED,
+				new_sp);
+			vudc->cur_self_pwr = new_sp;
+		}
+	}
+
+	if (ma >= 0) {
+		unsigned int new_ma = (unsigned int)ma;
+
+		if (vudc->cur_self_pwr)
+			new_ma = 0;
+
+		if (new_ma != vudc->cur_vbus_ma) {
+			(void)virtio_usb_dc_send_cmd(
+				vudc, VIRTIO_USB_CMD_DEV_VBUS_DRAW, new_ma);
+			vudc->cur_vbus_ma = new_ma;
+		}
+	}
+
+	mutex_unlock(&vudc->dc_cmd_work_lock);
+
+	if (atomic_read(&vudc->pending_self_pwr) >= 0 ||
+	    atomic_read(&vudc->pending_vbus_ma) >= 0) {
+		queue_work(vudc->dc_cmd_wq, &vudc->dc_cmd_work);
+	}
+}
+
 /**
  * virtio_usb_dc_set_selfpowered() - Sets the device selfpowered feature.
  * @gadget: The device being declared as self-powered
@@ -645,18 +1057,11 @@ static int virtio_usb_dc_set_selfpowered(struct usb_gadget *gadget,
 {
 	struct virtio_usb_dc *vudc =
 		container_of(gadget, struct virtio_usb_dc, gadget);
-	unsigned int code = VIRTIO_USB_CMD_DEV_SET_SELF_POWERED;
-	struct virtio_usb_dev_cmd_set_value *req;
-	struct virtio_usb_cmd *cmd;
 
-	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_ATOMIC);
-	if (!cmd)
-		return -ENOMEM;
-
-	req = virtio_usb_cmd_request(cmd);
-	req->value = cpu_to_le32(!!is_selfpowered);
+	atomic_set(&vudc->pending_self_pwr, is_selfpowered ? 1 : 0);
+	queue_work(vudc->dc_cmd_wq, &vudc->dc_cmd_work);
 
-	return virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
+	return 0;
 }
 
 /**
@@ -774,29 +1179,18 @@ static int virtio_usb_dc_stop(struct usb_gadget *gadget)
 /**
  * virtio_usb_dc_vbus_draw() - Constrain controller's VBUS power usage
  * @gadget: The device whose VBUS usage is being described
- * @mA: How much current to draw, in milliAmperes.
+ * @ma: How much current to draw, in milliAmperes.
  *
  * Return: 0 on success, -errno on failure.
  */
-static int virtio_usb_dc_vbus_draw(struct usb_gadget *gadget, unsigned int mA)
+static int virtio_usb_dc_vbus_draw(struct usb_gadget *gadget, unsigned int ma)
 {
 	struct virtio_usb_dc *vudc =
 		container_of(gadget, struct virtio_usb_dc, gadget);
-	unsigned int code = VIRTIO_USB_CMD_DEV_VBUS_DRAW;
-	struct virtio_usb_dev_cmd_set_value *req;
-	struct virtio_usb_cmd *cmd;
-	int rc;
-
-	cmd = virtio_usb_dc_cmd_alloc(vudc, code, GFP_ATOMIC);
-	if (!cmd)
-		return -ENOMEM;
-
-	req = virtio_usb_cmd_request(cmd);
-	req->value = cpu_to_le32(mA);
-
-	rc = virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
 
-	return rc;
+	atomic_set(&vudc->pending_vbus_ma, ma);
+	queue_work(vudc->dc_cmd_wq, &vudc->dc_cmd_work);
+	return 0;
 }
 
 /**
@@ -930,6 +1324,11 @@ static int virtio_usb_dc_get_endpoint_info(struct virtio_usb_dc *vudc)
 		vep->ep.name = vep->name;
 		vep->ep.ops = &virtio_usb_ep_ops;
 		INIT_LIST_HEAD(&vep->req_queue);
+		INIT_LIST_HEAD(&vep->pend_queue);
+		vep->state = i ? EP_DISABLED : EP_ENABLED; // EP0 always enabled
+		INIT_WORK(&vep->enable_work, vep_enable_work);
+		INIT_WORK(&vep->disable_work, vep_disable_work);
+		vep->last_err = 0;
 		list_add_tail(&vep->ep.ep_list, &vudc->gadget.ep_list);
 		usb_ep_set_maxpacket_limit(&vep->ep, maxpacket_limit);
 		vep->ep.max_streams = le16_to_cpu(epinfo[i].max_streams);
@@ -1038,7 +1437,6 @@ static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
 		}
 		vudc->gadget.ops = &virtio_gadget_ops;
 		vudc->gadget.max_speed = USB_SPEED_HIGH;
-		vudc->gadget.nonatomic = 1;
 
 		//vudc->gadget.dev.init_name = gadget_name;
 		vudc->gadget.dev.parent = &vudc->pdev->dev;
@@ -1071,6 +1469,14 @@ static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
 
 		vep = usb_ep_to_virtio_ep(vudc->gadget.ep0);
 		setup_evt = virtio_usb_event_buf(event);
+		rc = virtio_usb_dc_wait_ep0_idle(vudc);
+		if (rc) {
+			dev_warn(
+				&vusb->vdev->dev,
+				"SETUP while ep0 request is still pending, timing out\n");
+			virtio_ep_set_halt(vudc->gadget.ep0, 1);
+			break;
+		}
 
 		memcpy(&vep->setup, setup_evt->setup,
 		       sizeof(struct usb_ctrlrequest));
@@ -1102,6 +1508,9 @@ static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
 	case VIRTIO_USB_EVT_DEV_UNBIND: {
 		unsigned int registered;
 
+		pr_info("%s port_id %d VIRTIO_USB_EVT_DEV_UNBIND\n", __func__,
+			port_id);
+
 		spin_lock_irqsave(&vudc->lock, flags);
 		registered = vudc->registered;
 		vudc->registered = 0;
@@ -1113,8 +1522,14 @@ static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
 			vudc->gadget.name = NULL;
 		}
 
-		kfree(vudc->veps);
-		vudc->veps = NULL;
+		if (vudc->veps) {
+			unsigned int i;
+
+			for (i = 0; i < vudc->neps; i++)
+				cancel_work_sync(&vudc->veps[i].enable_work);
+			kfree(vudc->veps);
+			vudc->veps = NULL;
+		}
 
 		if (vudc->pdev) {
 			platform_device_unregister(vudc->pdev);
@@ -1141,7 +1556,6 @@ void virtio_usb_dc_event_work(struct work_struct *work)
 		container_of(work, struct virtio_usb, vq_dev_event_work);
 	struct virtio_usb_queue *evtq =
 		&vusb->vqueues[vusb->dev_vq_base + VIRTIO_USB_VQ_EVENT_IDX];
-
 	virtio_usb_evt_work(evtq, virtio_usb_dc_event_process);
 }
 
@@ -1186,13 +1600,39 @@ int virtio_usb_dc_init(struct virtio_usb *vusb, int port_id)
 	if (!vudc)
 		return -ENOMEM;
 
-	vusb->vports[port_id].vudc = vudc;
 	vudc->vusb = vusb;
 	vudc->port = port_id;
 	for (i = 0; i < VIRTIO_USB_VQ_DEV_MAX; i++)
 		vudc->dcqs[i] = &vusb->vqueues[vusb->dev_vq_base + i];
 
+	vudc->ep_cmd_wq = alloc_ordered_workqueue(
+		"vudc_ep_work_%d", WQ_MEM_RECLAIM | WQ_UNBOUND, port_id);
+	vudc->dc_cmd_wq = alloc_ordered_workqueue(
+		"vudc_dc_work_%d", WQ_MEM_RECLAIM | WQ_UNBOUND, port_id);
+	if (!vudc->ep_cmd_wq || !vudc->dc_cmd_wq) {
+		if (vudc->ep_cmd_wq)
+			destroy_workqueue(vudc->ep_cmd_wq);
+		if (vudc->dc_cmd_wq)
+			destroy_workqueue(vudc->dc_cmd_wq);
+		devm_kfree(&vusb->vdev->dev, vudc);
+		return -ENOMEM;
+	}
+
+	/* Publish only once fully initialized - vports[port_id].vudc must
+	 * never point at a partially-constructed (or already-freed, on the
+	 * failure path above) struct virtio_usb_dc.
+	 */
+	vusb->vports[port_id].vudc = vudc;
+
+	INIT_WORK(&vudc->dc_cmd_work, virtio_usb_dc_work);
+	mutex_init(&vudc->dc_cmd_work_lock);
+	atomic_set(&vudc->pending_self_pwr, -1);
+	atomic_set(&vudc->pending_vbus_ma, -1);
+	vudc->cur_vbus_ma = 0;
+	vudc->cur_self_pwr = false;
+
 	spin_lock_init(&vudc->lock);
+	init_waitqueue_head(&vudc->ep0_idle);
 
 	vudc->registered = 0;
 
@@ -1228,6 +1668,22 @@ int virtio_usb_dc_deinit(struct virtio_usb *vusb)
 		if (registered)
 			usb_del_gadget_udc(&vudc->gadget);
 
+		if (vudc->dc_cmd_wq) {
+			cancel_work_sync(&vudc->dc_cmd_work);
+			destroy_workqueue(vudc->dc_cmd_wq);
+		}
+
+		if (vudc->ep_cmd_wq) {
+			flush_workqueue(vudc->ep_cmd_wq);
+			if (vudc->veps) {
+				unsigned int i;
+
+				for (i = 0; i < vudc->neps; i++)
+					cancel_work_sync(
+						&vudc->veps[i].enable_work);
+			}
+			destroy_workqueue(vudc->ep_cmd_wq);
+		}
 		kfree(vudc->veps);
 		vudc->veps = NULL;
 
diff --git a/drivers/usb/virtio_usb/device.h b/drivers/usb/virtio_usb/device.h
index 9dacc89..2f93f45 100644
--- a/drivers/usb/virtio_usb/device.h
+++ b/drivers/usb/virtio_usb/device.h
@@ -11,6 +11,7 @@
 #include <linux/usb.h>
 #include <linux/list.h>
 #include <linux/platform_device.h>
+#include <linux/wait.h>
 #include <uapi/linux/usb/ch11.h>
 #include <uapi/linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -37,12 +38,19 @@
 		.dir_out = !!((_dir) & VIRTIO_USB_EP_CAPS_DIR_OUT),            \
 	}
 
+enum vep_state { EP_DISABLED, EP_ENABLING, EP_ENABLED, EP_HALTED };
+
 /**
  * struct virtio_usb_ep - virtio usb device endpoint
  * @ep: usb ep
  * @vusb: VirtIO usb device
  * @setup: setup packet for control endpoint
  * @req_queue: list of usb requests submitted to ep awaiting response
+ * @pend_queue: list of usb requests waiting for submit while EP is ENABLING
+ * @state: endpoint state (necessary to support split-phase async processing)
+ * @enable_work:  workstruct for the async ep_enable()
+ * @disable_work:  workstruct for the async ep_disable()
+ * @last_err: error code if async processeing brings us to HALTED state
  * @ep_id: Id of the endpoint
  * @name: Endpoint name
  */
@@ -51,6 +59,11 @@ struct virtio_usb_ep {
 	struct virtio_usb_dc *vudc;
 	struct usb_ctrlrequest setup;
 	struct list_head req_queue;
+	struct list_head pend_queue;
+	enum vep_state state;
+	struct work_struct enable_work;
+	struct work_struct disable_work;
+	int last_err;
 	u16 ep_id;
 	char name[16];
 };
@@ -66,6 +79,7 @@ struct virtio_usb_ep {
  * @registered: Flag indicating registration status to the UDC core.
  * @pullup:  Software-controlled connect/disconnect status USB host.
  * @lock: Spinlock that protects device state
+ * @ep0_idle: Wait queue for SETUP serialization while ep0 has an in-flight req
  */
 struct virtio_usb_dc {
 	struct platform_device *pdev;
@@ -79,6 +93,16 @@ struct virtio_usb_dc {
 	unsigned registered : 1;
 	unsigned pullup : 1;
 	spinlock_t lock;
+	wait_queue_head_t ep0_idle;
+	/* Workqueue for EP enable/disable/cancel commands */
+	struct workqueue_struct *ep_cmd_wq;
+	struct workqueue_struct *dc_cmd_wq;
+	struct work_struct dc_cmd_work;
+	struct mutex dc_cmd_work_lock;
+	atomic_t pending_self_pwr;
+	atomic_t pending_vbus_ma;
+	unsigned int cur_vbus_ma;
+	bool cur_self_pwr;
 };
 
 extern const struct virtio_usb_vq_desc dev_vqueues[VIRTIO_USB_VQ_DEV_MAX];
