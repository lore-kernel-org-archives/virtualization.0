Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599D5C4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 08:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C44216110B;
	Fri, 23 Dec 2022 08:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C44216110B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=caOknhJ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GVAv8awSzNqG; Fri, 23 Dec 2022 08:37:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A60D761106;
	Fri, 23 Dec 2022 08:37:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A60D761106
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C19BC0071;
	Fri, 23 Dec 2022 08:37:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1E74C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5758402A7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:37:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5758402A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=caOknhJ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7CUjj0j88wsp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:37:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68B3440160
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68B3440160
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671784674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tibs9pd8jDUt8h9x80aD1hAsOpHzVYssW4T7EsRgLKw=;
 b=caOknhJ/rsn18c+4tmtGTy6vr7Ftr/l0linSokVdOCIN6DjosPshnUd9DIIMON1pcljpUz
 cQqf8VtoXMTKu1Ku1zMIM3UeqZJgRIE4dz7kSOGcLNMf3wZHVcjIynDa89lnJw4M67N/s8
 ieSLl7C33sZhkGsjiyHWexCe10ye2Z8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-x6iMlCTMOpePw_NQk8NoEw-1; Fri, 23 Dec 2022 03:37:52 -0500
X-MC-Unique: x6iMlCTMOpePw_NQk8NoEw-1
Received: by mail-qt1-f198.google.com with SMTP id
 ay40-20020a05622a22a800b003a978b3019cso1762448qtb.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 00:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tibs9pd8jDUt8h9x80aD1hAsOpHzVYssW4T7EsRgLKw=;
 b=rH0mxE/XNB++ZO4ZX0zm68KZaRm93ivCiYTK7J5rUjaCPMssdjAO44uqlJNBHpTKXT
 5F1aPp+4+G7vUd0ymYTU566MvG+bPzeDUaVw6UGUrybJLKIXnd0kPUXqABOIUJ5W6MPE
 GGYQHWniJd8ZMbtY/WKLzYc6K39qCz1ZSzMpGcNX7GF1s6+Z2jY3G6VIhXNtEZFbnECU
 JypP/zHmaQm+Cd6jDGD2zbm7HKanpk1H0bjPRDOZ53lxCqYNHDX3qXHD8rplXENz9OsR
 UMUk2VYaqcJsAUvORcMHtRovFbqgLSn9Te4Q0xGNzSHiyqOijJ0/vxbGQ+Mna3y0nfnF
 jQWg==
X-Gm-Message-State: AFqh2kqPUulcWUUPbre6V3ZOiOBqhZiq9vPXrJsD4aPNp7s6cAuWYYLu
 ThsGq4iI2WXWr27N+dHIBzinYYWeZlwV/UNhwjXaPSHQRzJW3Kzi+CMDq8oxae0sIvxMYMiuQ90
 1C/yuYDNcSD2tfsoUk/Omlb6rJhOyIlBz0Cxeqgqxtw==
X-Received: by 2002:a05:622a:ca:b0:3a8:1677:bc39 with SMTP id
 p10-20020a05622a00ca00b003a81677bc39mr15027594qtw.52.1671784672378; 
 Fri, 23 Dec 2022 00:37:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtXAVeXCU7Z60xZ2A/kTwDtBLtl+RNfota7X4YVBNcGaGNzEeuXfc2pR1Fu4/OKNHnHA84nbg==
X-Received: by 2002:a05:622a:ca:b0:3a8:1677:bc39 with SMTP id
 p10-20020a05622a00ca00b003a81677bc39mr15027565qtw.52.1671784672018; 
 Fri, 23 Dec 2022 00:37:52 -0800 (PST)
Received: from sgarzare-redhat (host-79-34-11-215.business.telecomitalia.it.
 [79.34.11.215]) by smtp.gmail.com with ESMTPSA id
 w16-20020a05620a425000b006a6ebde4799sm1898693qko.90.2022.12.23.00.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Dec 2022 00:37:51 -0800 (PST)
Date: Fri, 23 Dec 2022 09:37:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 4/4] vdpa_sim_net: vendor satistics
Message-ID: <20221223083744.ny3yy3rdh2bftm6c@sgarzare-redhat>
References: <20221223055548.27810-1-jasowang@redhat.com>
 <20221223055548.27810-5-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221223055548.27810-5-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 23, 2022 at 01:55:48PM +0800, Jason Wang wrote:
>This patch adds support for basic vendor stats that include counters
>for tx, rx and cvq.
>
>Acked-by: Eugenio P=E9rez <eperezma@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 219 ++++++++++++++++++++++++++-
> 1 file changed, 213 insertions(+), 6 deletions(-)

Little typo in the commit title s/satistics/statistics

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim_net.c
>index 5abd4efd9028..e827708adcca 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -15,6 +15,7 @@
> #include <linux/etherdevice.h>
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
>+#include <net/netlink.h>
> #include <uapi/linux/virtio_net.h>
> #include <uapi/linux/vdpa.h>
>
>@@ -37,6 +38,34 @@
> #define VDPASIM_NET_AS_NUM	2
> #define VDPASIM_NET_GROUP_NUM	2
>
>+struct vdpasim_dataq_stats {
>+	struct u64_stats_sync syncp;
>+	u64 pkts;
>+	u64 bytes;
>+	u64 drops;
>+	u64 errors;
>+	u64 overruns;
>+};
>+
>+struct vdpasim_cq_stats {
>+	struct u64_stats_sync syncp;
>+	u64 requests;
>+	u64 successes;
>+	u64 errors;
>+};
>+
>+struct vdpasim_net{
>+	struct vdpasim vdpasim;
>+	struct vdpasim_dataq_stats tx_stats;
>+	struct vdpasim_dataq_stats rx_stats;
>+	struct vdpasim_cq_stats cq_stats;
>+};
>+
>+static struct vdpasim_net *sim_to_net(struct vdpasim *vdpasim)
>+{
>+	return container_of(vdpasim, struct vdpasim_net, vdpasim);
>+}
>+
> static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
> {
> 	/* Make sure data is wrote before advancing index */
>@@ -97,9 +126,11 @@ static virtio_net_ctrl_ack vdpasim_handle_ctrl_mac(str=
uct vdpasim *vdpasim,
> static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
> {
> 	struct vdpasim_virtqueue *cvq =3D &vdpasim->vqs[2];
>+	struct vdpasim_net *net =3D sim_to_net(vdpasim);
> 	virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
> 	struct virtio_net_ctrl_hdr ctrl;
> 	size_t read, write;
>+	u64 requests =3D 0, errors =3D 0, successes =3D 0;
> 	int err;
>
> 	if (!(vdpasim->features & (1ULL << VIRTIO_NET_F_CTRL_VQ)))
>@@ -115,10 +146,13 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpas=
im)
> 		if (err <=3D 0)
> 			break;
>
>+		++requests;
> 		read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov, &ctrl,
> 					     sizeof(ctrl));
>-		if (read !=3D sizeof(ctrl))
>+		if (read !=3D sizeof(ctrl)) {
>+			++errors;
> 			break;
>+		}
>
> 		switch (ctrl.class) {
> 		case VIRTIO_NET_CTRL_MAC:
>@@ -128,6 +162,11 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasi=
m)
> 			break;
> 		}
>
>+		if (status =3D=3D VIRTIO_NET_OK)
>+			++successes;
>+		else
>+			++errors;
>+
> 		/* Make sure data is wrote before advancing index */
> 		smp_wmb();
>
>@@ -145,6 +184,12 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasi=
m)
> 			cvq->cb(cvq->private);
> 		local_bh_enable();
> 	}
>+
>+	u64_stats_update_begin(&net->cq_stats.syncp);
>+	net->cq_stats.requests +=3D requests;
>+	net->cq_stats.errors +=3D errors;
>+	net->cq_stats.successes +=3D successes;
>+	u64_stats_update_end(&net->cq_stats.syncp);
> }
>
> static void vdpasim_net_work(struct work_struct *work)
>@@ -152,8 +197,10 @@ static void vdpasim_net_work(struct work_struct *work)
> 	struct vdpasim *vdpasim =3D container_of(work, struct vdpasim, work);
> 	struct vdpasim_virtqueue *txq =3D &vdpasim->vqs[1];
> 	struct vdpasim_virtqueue *rxq =3D &vdpasim->vqs[0];
>+	struct vdpasim_net *net =3D sim_to_net(vdpasim);
> 	ssize_t read, write;
>-	int pkts =3D 0;
>+	u64 tx_pkts =3D 0, rx_pkts =3D 0, tx_bytes =3D 0, rx_bytes =3D 0;
>+	u64 rx_drops =3D 0, rx_overruns =3D 0, rx_errors =3D 0, tx_errors =3D 0;
> 	int err;
>
> 	spin_lock(&vdpasim->lock);
>@@ -172,14 +219,21 @@ static void vdpasim_net_work(struct work_struct *wor=
k)
> 	while (true) {
> 		err =3D vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
> 					   &txq->head, GFP_ATOMIC);
>-		if (err <=3D 0)
>+		if (err <=3D 0) {
>+			if (err)
>+				++tx_errors;
> 			break;
>+		}
>
>+		++tx_pkts;
> 		read =3D vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
> 					     vdpasim->buffer,
> 					     PAGE_SIZE);
>
>+		tx_bytes +=3D read;
>+
> 		if (!receive_filter(vdpasim, read)) {
>+			++rx_drops;
> 			vdpasim_net_complete(txq, 0);
> 			continue;
> 		}
>@@ -187,19 +241,25 @@ static void vdpasim_net_work(struct work_struct *wor=
k)
> 		err =3D vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
> 					   &rxq->head, GFP_ATOMIC);
> 		if (err <=3D 0) {
>+			++rx_overruns;
> 			vdpasim_net_complete(txq, 0);
> 			break;
> 		}
>
> 		write =3D vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
> 					      vdpasim->buffer, read);
>-		if (write <=3D 0)
>+		if (write <=3D 0) {
>+			++rx_errors;
> 			break;
>+		}
>+
>+		++rx_pkts;
>+		rx_bytes +=3D write;
>
> 		vdpasim_net_complete(txq, 0);
> 		vdpasim_net_complete(rxq, write);
>
>-		if (++pkts > 4) {
>+		if (tx_pkts > 4) {
> 			schedule_work(&vdpasim->work);
> 			goto out;
> 		}
>@@ -207,6 +267,145 @@ static void vdpasim_net_work(struct work_struct *wor=
k)
>
> out:
> 	spin_unlock(&vdpasim->lock);
>+
>+	u64_stats_update_begin(&net->tx_stats.syncp);
>+	net->tx_stats.pkts +=3D tx_pkts;
>+	net->tx_stats.bytes +=3D tx_bytes;
>+	net->tx_stats.errors +=3D tx_errors;
>+	u64_stats_update_end(&net->tx_stats.syncp);
>+
>+	u64_stats_update_begin(&net->rx_stats.syncp);
>+	net->rx_stats.pkts +=3D rx_pkts;
>+	net->rx_stats.bytes +=3D rx_bytes;
>+	net->rx_stats.drops +=3D rx_drops;
>+	net->rx_stats.errors +=3D rx_errors;
>+	net->rx_stats.overruns +=3D rx_overruns;
>+	u64_stats_update_end(&net->rx_stats.syncp);
>+}
>+
>+static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
>+				 struct sk_buff *msg,
>+				 struct netlink_ext_ack *extack)
>+{
>+	struct vdpasim_net *net =3D sim_to_net(vdpasim);
>+	u64 rx_pkts, rx_bytes, rx_errors, rx_overruns, rx_drops;
>+	u64 tx_pkts, tx_bytes, tx_errors, tx_drops;
>+	u64 cq_requests, cq_successes, cq_errors;
>+	unsigned int start;
>+	int err =3D -EMSGSIZE;
>+
>+	switch(idx) {
>+	case 0:
>+		do {
>+			start =3D u64_stats_fetch_begin(&net->rx_stats.syncp);
>+			rx_pkts =3D net->rx_stats.pkts;
>+			rx_bytes =3D net->rx_stats.bytes;
>+			rx_errors =3D net->rx_stats.errors;
>+			rx_overruns =3D net->rx_stats.overruns;
>+			rx_drops =3D net->rx_stats.drops;
>+		} while (u64_stats_fetch_retry(&net->rx_stats.syncp, start));
>+
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+					"rx packets"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_pkts, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx bytes"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_bytes, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx errors"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_errors, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx overrunss"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_overruns, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx drops"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_drops, VDPA_ATTR_PAD))
>+			break;
>+		err =3D 0;
>+		break;
>+	case 1:
>+		do {
>+			start =3D u64_stats_fetch_begin(&net->tx_stats.syncp);
>+			tx_pkts =3D net->tx_stats.pkts;
>+			tx_bytes =3D net->tx_stats.bytes;
>+			tx_errors =3D net->tx_stats.errors;
>+			tx_drops =3D net->tx_stats.drops;
>+		} while (u64_stats_fetch_retry(&net->tx_stats.syncp, start));
>+
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx packets"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_pkts, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx bytes"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_bytes, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx errors"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_errors, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx drops"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_drops, VDPA_ATTR_PAD))
>+			break;
>+		err =3D 0;
>+		break;
>+	case 2:
>+		do {
>+			start =3D u64_stats_fetch_begin(&net->cq_stats.syncp);
>+			cq_requests =3D net->cq_stats.requests;
>+			cq_successes =3D net->cq_stats.successes;
>+			cq_errors =3D net->cq_stats.errors;
>+		} while (u64_stats_fetch_retry(&net->cq_stats.syncp, start));
>+
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "cvq requests"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      cq_requests, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "cvq successes"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      cq_successes, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "cvq errors"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      cq_errors, VDPA_ATTR_PAD))
>+			break;
>+		err =3D 0;
>+		break;
>+	default:
>+		err =3D -EINVAL;
>+		break;
>+	}
>+
>+	return err;
> }
>
> static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
>@@ -243,6 +442,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> 			       const struct vdpa_dev_set_config *config)
> {
> 	struct vdpasim_dev_attr dev_attr =3D {};
>+	struct vdpasim_net *net;
> 	struct vdpasim *simdev;
> 	int ret;
>
>@@ -253,10 +453,11 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
> 	dev_attr.nvqs =3D VDPASIM_NET_VQ_NUM;
> 	dev_attr.ngroups =3D VDPASIM_NET_GROUP_NUM;
> 	dev_attr.nas =3D VDPASIM_NET_AS_NUM;
>-	dev_attr.alloc_size =3D sizeof(struct vdpasim);
>+	dev_attr.alloc_size =3D sizeof(struct vdpasim_net);
> 	dev_attr.config_size =3D sizeof(struct virtio_net_config);
> 	dev_attr.get_config =3D vdpasim_net_get_config;
> 	dev_attr.work_fn =3D vdpasim_net_work;
>+	dev_attr.get_stats =3D vdpasim_net_get_stats;
> 	dev_attr.buffer_size =3D PAGE_SIZE;
>
> 	simdev =3D vdpasim_create(&dev_attr, config);
>@@ -269,6 +470,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *=
mdev, const char *name,
> 	if (ret)
> 		goto reg_err;
>
>+	net =3D sim_to_net(simdev);
>+
>+	u64_stats_init(&net->tx_stats.syncp);
>+	u64_stats_init(&net->rx_stats.syncp);
>+	u64_stats_init(&net->cq_stats.syncp);
>+
> 	return 0;
>
> reg_err:
>-- =

>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
