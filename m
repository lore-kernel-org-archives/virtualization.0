Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11789C433EF
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 07:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A212A40DC2;
	Wed, 25 May 2022 07:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvS_N7BGgmn6; Wed, 25 May 2022 07:42:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1665F409C1;
	Wed, 25 May 2022 07:42:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCCAAC0032;
	Wed, 25 May 2022 07:42:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7F4C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 07:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 664724109F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 07:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wmdrExPbKi3Q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 07:42:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E724F40A04
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 07:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653464567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ys9N/aStuUczJG1d59vIuu5WRFG0fOE8qpuySSttVig=;
 b=Y1Mq76RnixPrGz4G/DcEquxLEzxIHFQLAlvQLNSpDoQqsZO+DfxTtIc7db024C+bBBHzev
 zhX6tFzOKNzSq1HVKFxP0qWWgZL/THbP3jHxXgYx36wLR1uyiteMFagvqyB8hKub3X+HSZ
 kd4JOpLO53+1qi16aV6hQ4+OGGuppFE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-5FqGZTxINpKDLmlAUBPSsQ-1; Wed, 25 May 2022 03:42:45 -0400
X-MC-Unique: 5FqGZTxINpKDLmlAUBPSsQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 cn8-20020a05622a248800b002f3c7be2744so15628992qtb.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 00:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Ys9N/aStuUczJG1d59vIuu5WRFG0fOE8qpuySSttVig=;
 b=6M7z53SsGTuUXL6DoNdpy85XOnzFtJihx1oOzy5qstRX8KYtcdOLd+RJ9LIKtfCWn+
 EAqevl4FW341YKdgCT6oEIO1ZJdnxja/BBQfw5cB5D4TzWFuaqrlXRn4iKnzylhCZml5
 CG0PYFwGLhTunGxg8QlWnF0O9fyuTavmKaKaHm7WPgNgu/on1kR4ILWEvY2vxR6eSjT0
 +EB8Q6hudRWota7Cw361HzRjg/LuZjPKzM/jDh1XuM5N7JO3CRq8H7HSukxjgSXyvWgX
 QNQG3k4O+Xtap1mFbA6HxRLkuilgLbqXc1HilM9iluLa9Wwp1U6SCKdq4x6RfTphj7yG
 qd1w==
X-Gm-Message-State: AOAM531Q1ZKkII5X+QsLZHLBEdnodjH8UohkMWP1JVVRxeb/cm/XbFlW
 ir7ZJh0rrfGXoZAmAW/PhPu3l7cSF9km1eI28LvJQgDrJc0Sel5LbsyodlZXQSwzEbAgM0nkrgW
 veAGw55ho2BhjsWzhfO3zFv5vK9gmsSsVn2ZwMtGHMg==
X-Received: by 2002:ac8:5813:0:b0:2fa:a441:ba8a with SMTP id
 g19-20020ac85813000000b002faa441ba8amr2204489qtg.162.1653464565029; 
 Wed, 25 May 2022 00:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8/milkg51+yfBQTz/8OhX1w5WPXtXVRPuIhObK5HHUAywQzfC8MVhw6rZ751qf/C+5s+Uqg==
X-Received: by 2002:ac8:5813:0:b0:2fa:a441:ba8a with SMTP id
 g19-20020ac85813000000b002faa441ba8amr2204464qtg.162.1653464564785; 
 Wed, 25 May 2022 00:42:44 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 b14-20020ac84f0e000000b002f96db4519csm922248qte.37.2022.05.25.00.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 May 2022 00:42:44 -0700 (PDT)
Date: Wed, 25 May 2022 09:41:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 4/4] vdpa_sim: Implement stop vdpa op
Message-ID: <20220525074156.rwyesinlzrza72cn@sgarzare-redhat>
References: <20220524170610.2255608-1-eperezma@redhat.com>
 <20220524170610.2255608-5-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220524170610.2255608-5-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 pabloc@xilinx.com, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, lulu@redhat.com, Piotr.Uminski@intel.com,
 martinh@xilinx.com, Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 hanand@xilinx.com, martinpo@xilinx.com, gautam.dawar@amd.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Tue, May 24, 2022 at 07:06:10PM +0200, Eugenio P=E9rez wrote:
>Implement stop operation for vdpa_sim devices, so vhost-vdpa will offer
>that backend feature and userspace can effectively stop the device.
>
>This is a must before get virtqueue indexes (base) for live migration,
>since the device could modify them after userland gets them. There are
>individual ways to perform that action for some devices
>(VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
>way to perform it for any vhost device (and, in particular, vhost-vdpa).
>
>After the return of ioctl with stop !=3D 0, the device MUST finish any
>pending operations like in flight requests. It must also preserve all
>the necessary state (the virtqueue vring base plus the possible device
>specific states) that is required for restoring in the future. The
>device must not change its configuration after that point.
>
>After the return of ioctl with stop =3D=3D 0, the device can continue
>processing buffers as long as typical conditions are met (vq is enabled,
>DRIVER_OK status bit is enabled, etc).
>
>In the future, we will provide features similar to
>VHOST_USER_GET_INFLIGHT_FD so the device can save pending operations.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c     | 21 +++++++++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
> 4 files changed, 28 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa=
_sim.c
>index 50d721072beb..0515cf314bed 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -107,6 +107,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
> 	for (i =3D 0; i < vdpasim->dev_attr.nas; i++)
> 		vhost_iotlb_reset(&vdpasim->iommu[i]);
>
>+	vdpasim->running =3D true;
> 	spin_unlock(&vdpasim->iommu_lock);
>
> 	vdpasim->features =3D 0;
>@@ -505,6 +506,24 @@ static int vdpasim_reset(struct vdpa_device *vdpa)
> 	return 0;
> }
>
>+static int vdpasim_stop(struct vdpa_device *vdpa, bool stop)
>+{
>+	struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>+	int i;
>+
>+	spin_lock(&vdpasim->lock);
>+	vdpasim->running =3D !stop;
>+	if (vdpasim->running) {
>+		/* Check for missed buffers */
>+		for (i =3D 0; i < vdpasim->dev_attr.nvqs; ++i)
>+			vdpasim_kick_vq(vdpa, i);
>+
>+	}
>+	spin_unlock(&vdpasim->lock);
>+
>+	return 0;
>+}
>+
> static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
> {
> 	struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>@@ -694,6 +713,7 @@ static const struct vdpa_config_ops vdpasim_config_ops=
 =3D {
> 	.get_status             =3D vdpasim_get_status,
> 	.set_status             =3D vdpasim_set_status,
> 	.reset			=3D vdpasim_reset,
>+	.stop			=3D vdpasim_stop,
> 	.get_config_size        =3D vdpasim_get_config_size,
> 	.get_config             =3D vdpasim_get_config,
> 	.set_config             =3D vdpasim_set_config,
>@@ -726,6 +746,7 @@ static const struct vdpa_config_ops vdpasim_batch_conf=
ig_ops =3D {
> 	.get_status             =3D vdpasim_get_status,
> 	.set_status             =3D vdpasim_set_status,
> 	.reset			=3D vdpasim_reset,
>+	.stop			=3D vdpasim_stop,
> 	.get_config_size        =3D vdpasim_get_config_size,
> 	.get_config             =3D vdpasim_get_config,
> 	.set_config             =3D vdpasim_set_config,
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa=
_sim.h
>index 622782e92239..061986f30911 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -66,6 +66,7 @@ struct vdpasim {
> 	u32 generation;
> 	u64 features;
> 	u32 groups;
>+	bool running;
> 	/* spinlock to synchronize iommu table */
> 	spinlock_t iommu_lock;
> };
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim_blk.c
>index 42d401d43911..bcdb1982c378 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -204,6 +204,9 @@ static void vdpasim_blk_work(struct work_struct *work)
> 	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> 		goto out;
>
>+	if (!vdpasim->running)
>+		goto out;
>+

Not related to this series, but I think in vdpa_sim_blk.c we should =

implement something similar to what we already do in vdpa_sim_net.c and =

re-schedule the work after X requests handled, otherwise we risk never =

stopping if there are always requests to handle.

Also for supporting multiple queues, that could be a problem, but for =

now we only support one, so there should be no problem.

I have other patches to send for vdpa_sim_blk.c, so if you want I can do =

that in my series.

Thanks,
Stefano

> 	for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> 		struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim_net.c
>index 5125976a4df8..886449e88502 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -154,6 +154,9 @@ static void vdpasim_net_work(struct work_struct *work)
>
> 	spin_lock(&vdpasim->lock);
>
>+	if (!vdpasim->running)
>+		goto out;
>+
> 	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> 		goto out;
>
>-- =

>2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
