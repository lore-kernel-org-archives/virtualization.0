Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE44C54EBE
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 10:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 226A940C2E;
	Fri, 13 Jan 2023 10:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 226A940C2E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AY83yzOW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GNhTiUOEatI6; Fri, 13 Jan 2023 10:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76AAC40122;
	Fri, 13 Jan 2023 10:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76AAC40122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50E7CC0033;
	Fri, 13 Jan 2023 10:22:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B313C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44210418AF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44210418AF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AY83yzOW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CiLvX2CA1gkW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:22:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 347F6409C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 347F6409C3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673605371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hap3aPSzXwOS05ixnlg4S7KjMs2H1FXCtTmNj33aaoo=;
 b=AY83yzOWUxeXxcXpM+kVe1OJOyZr4KdB7QkSng0ter4n6cjh3WNjjOyjBiHkLjN4/9shCB
 ELhjm8IYN7nda5PYQG3Q07Zp7JrQ1y4GFZDYDghpNPUKq/FIBOTWQ0wtF4XlKTXfGl/sIR
 TUsyUdKOEZWotf0dT5B1qdBbZUPys7c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-gQIMqwKDPhGR6iVolfr5iA-1; Fri, 13 Jan 2023 05:22:49 -0500
X-MC-Unique: gQIMqwKDPhGR6iVolfr5iA-1
Received: by mail-qv1-f70.google.com with SMTP id
 y6-20020a0cec06000000b005346d388b7aso1798700qvo.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 02:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hap3aPSzXwOS05ixnlg4S7KjMs2H1FXCtTmNj33aaoo=;
 b=013f4IIGRGjsz2fQsxAulUjGL8UppNZL4QrvRZeouqM2m+BfEKnINCbfsYNJQtg4vn
 kOtYpHqDH6fMCKIzNU+9AewIArBMxw2a49HP+P4i0mzlJ5Ioa1KZVw5KJIxGbFl0y/K/
 phN2ysLoUbwOOO/UfIDtmvsWqS/OtbLP9N/u+Phc82LpCLpQwpYwVFXKWwcdaNdfGhEe
 nhiGaGj3DUApv7STb8eNil+8NbFGEHl8KMDC7bBD4/lWVGbLDE9JqtgPDRdnueSuF2zw
 6ZN7/04L0SM04u+5XjYesrv/ywf+QV+v3o7db9vgDF5/0OPNRaXunZY3Wt6GawR9bPas
 D5yw==
X-Gm-Message-State: AFqh2koYxAoQi1KZHo0zikxCLk+lsm8OfTRuqybghGV821iOEfp58FGM
 8g6uNmy7GpzPDT0xbwdrrITKM55oWtjOg7zXxKKb4JIHmefKwaYsA0ZXBxdq+BgHCQx3g5wkH1o
 Y9V9NS7T3M3qm5j9KsFXSKiq0qkaUrtstdcl0kfmwig==
X-Received: by 2002:a05:6214:440d:b0:534:2daa:fba4 with SMTP id
 oj13-20020a056214440d00b005342daafba4mr9630281qvb.19.1673605369292; 
 Fri, 13 Jan 2023 02:22:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuwoBF5Z2CpSss2nE/Pg/feZyMgHWTbTY2Sis1r77mrss92oe1sx+Ed1/nJ0A3bZpMtoVdG3w==
X-Received: by 2002:a05:6214:440d:b0:534:2daa:fba4 with SMTP id
 oj13-20020a056214440d00b005342daafba4mr9630256qvb.19.1673605368983; 
 Fri, 13 Jan 2023 02:22:48 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it.
 [79.46.200.244]) by smtp.gmail.com with ESMTPSA id
 s18-20020a05620a255200b006eeb3165565sm12472057qko.80.2023.01.13.02.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jan 2023 02:22:48 -0800 (PST)
Date: Fri, 13 Jan 2023 11:22:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: sebastien.boeuf@intel.com
Subject: Re: [PATCH v6 4/4] vdpa_sim: Implement resume vdpa op
Message-ID: <20230113102244.ugaugqxpwam7tugv@sgarzare-redhat>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
 <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
In-Reply-To: <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jan 03, 2023 at 11:51:08AM +0100, sebastien.boeuf@intel.com wrote:
>From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
>Implement resume operation for vdpa_sim devices, so vhost-vdpa will
>offer that backend feature and userspace can effectively resume the
>device.
>
>Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 +++++++++++++++++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
> 2 files changed, 30 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b071f0d842fb..756a5db0109c 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -357,6 +357,12 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
>+	if (!vdpasim->running &&
>+	    (vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>+		vdpasim->pending_kick = true;
>+		return;
>+	}
>+
> 	if (vq->ready)
> 		schedule_work(&vdpasim->work);
> }
>@@ -527,6 +533,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
> 	return 0;
> }
>
>+static int vdpasim_resume(struct vdpa_device *vdpa)
>+{
>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>+	int i;
>+
>+	spin_lock(&vdpasim->lock);
>+	vdpasim->running = true;
>+
>+	if (vdpasim->pending_kick) {

IIUC if one of the vq receive a kick while the device is suspended, we 
will kick all the vq.

At this point perhaps we should either send the kick only to the vqs we 
should notify, or send it to all of them indiscriminately (I don't know 
if it is correct to send a spurious kick).

Thanks,
Stefano

>+		/* Process pending descriptors */
>+		for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
>+			vdpasim_kick_vq(vdpa, i);
>+
>+		vdpasim->pending_kick = false;
>+	}
>+
>+	spin_unlock(&vdpasim->lock);
>+
>+	return 0;
>+}
>+
> static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
> {
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>@@ -717,6 +744,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> 	.set_status             = vdpasim_set_status,
> 	.reset			= vdpasim_reset,
> 	.suspend		= vdpasim_suspend,
>+	.resume			= vdpasim_resume,
> 	.get_config_size        = vdpasim_get_config_size,
> 	.get_config             = vdpasim_get_config,
> 	.set_config             = vdpasim_set_config,
>@@ -750,6 +778,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> 	.set_status             = vdpasim_set_status,
> 	.reset			= vdpasim_reset,
> 	.suspend		= vdpasim_suspend,
>+	.resume			= vdpasim_resume,
> 	.get_config_size        = vdpasim_get_config_size,
> 	.get_config             = vdpasim_get_config,
> 	.set_config             = vdpasim_set_config,
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 0e78737dcc16..a745605589e2 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -67,6 +67,7 @@ struct vdpasim {
> 	u64 features;
> 	u32 groups;
> 	bool running;
>+	bool pending_kick;
> 	/* spinlock to synchronize iommu table */
> 	spinlock_t iommu_lock;
> };
>-- 
>2.37.2
>
>---------------------------------------------------------------------
>Intel Corporation SAS (French simplified joint stock company)
>Registered headquarters: "Les Montalets"- 2, rue de Paris,
>92196 Meudon Cedex, France
>Registration Number:  302 456 199 R.C.S. NANTERRE
>Capital: 5 208 026.16 Euros
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
