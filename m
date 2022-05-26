Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE4C433FE
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 14:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54798425EB;
	Thu, 26 May 2022 14:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ItJA-i-uRs4; Thu, 26 May 2022 14:25:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BEED425EA;
	Thu, 26 May 2022 14:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72163C0039;
	Thu, 26 May 2022 14:25:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14263C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E712B425EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8VZ6GONVy8d0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:25:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5670425EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653575117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REW5eBj0k51HdxwQT5MIo/NGzv21C0HdYvY4KP3ZBC8=;
 b=O+AU9r87Vr2L1aY61ozgGAeSt2f5VJspMoTgabqCMbaMGUnknB4LA1iu2B36GD112san0p
 8JwTDaPmdziozLWv6WPKve4k3REtV40gtyrc1AzCNsW77QX2lS8li0fPgVIAZsAlBGvUBr
 a82RdgB/W8NfnafqLbQZP15GbXo8HGo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-PyDNcFZiO_SYsA6mv_IA_w-1; Thu, 26 May 2022 10:25:16 -0400
X-MC-Unique: PyDNcFZiO_SYsA6mv_IA_w-1
Received: by mail-qt1-f200.google.com with SMTP id
 t25-20020a05622a181900b002f3b32a6e30so1694675qtc.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 07:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=REW5eBj0k51HdxwQT5MIo/NGzv21C0HdYvY4KP3ZBC8=;
 b=WRDzSVIi+WtJeMoEjLVWSEqZNDFTZCedQ8sN+f6Ic2PzBbGHB/qfQrExqZ8Zl7c++B
 q/TB60Ye44lD9xRJAyenTVVh0/ucTtz3XzWK4o0fxnsDZRBsmySFGGqyDZiVUIq/31/e
 L40DDrVcyp3Pz6EbWCx0DoiDYREyZQGJWD7UmkT0U6qjjCGSzpkDwSml7Ruj7sbF1Y0d
 Toy7ttwhEV+AwYZ2Miiq2yzw51CK2c30l2e1O1ZG0P/9wviZfeVO9PTHJO2gDSrAftRv
 IxRIiu3qfNcZUSOUoLOsZMorsmYpxfQWZfgKfv0g/t/K8zDmTJ6YzGINHIaB3PWgTD1Y
 QEyQ==
X-Gm-Message-State: AOAM533U3bd/zLK/xC7FeskMIOPyMixN4UNdG3ZOK9r7wAvwrPf4a2oX
 v+tPsGExhfjd6gcXaKJVi7ivb/VLnvNWGDZ7Up9EU8O3n/mvHNFFtVxz7o2Y4ag8SXA3gWlJtir
 v6C2kCT1Vi9T3DeNaUPoSk72EgbIfVWIGDzWBnBi9YA==
X-Received: by 2002:a05:6214:27cf:b0:462:6338:f19c with SMTP id
 ge15-20020a05621427cf00b004626338f19cmr7054550qvb.123.1653575115865; 
 Thu, 26 May 2022 07:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx5+bYj+79D3UUpEhK5Xb40CENj+PWoMKEk6jIiMR1TuSf+fgweph1KuVE9X/p4pNnNr7Now==
X-Received: by 2002:a05:6214:27cf:b0:462:6338:f19c with SMTP id
 ge15-20020a05621427cf00b004626338f19cmr7054515qvb.123.1653575115597; 
 Thu, 26 May 2022 07:25:15 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 z20-20020a05622a061400b002f39b99f6a2sm1112748qta.60.2022.05.26.07.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 07:25:14 -0700 (PDT)
Date: Thu, 26 May 2022 16:25:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v4 4/4] vdpa_sim: Implement stop vdpa op
Message-ID: <20220526142506.4c2j2mguwu3ejg7i@sgarzare-redhat>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <20220526124338.36247-5-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220526124338.36247-5-eperezma@redhat.com>
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
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com, hanand@xilinx.com,
 martinpo@xilinx.com, gautam.dawar@amd.com,
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

On Thu, May 26, 2022 at 02:43:38PM +0200, Eugenio P=E9rez wrote:
>Implement stop operation for vdpa_sim devices, so vhost-vdpa will offer
>that backend feature and userspace can effectively stop the device.
>
>This is a must before get virtqueue indexes (base) for live migration,
>since the device could modify them after userland gets them. There are
>individual ways to perform that action for some devices
>(VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
>way to perform it for any vhost device (and, in particular, vhost-vdpa).
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c     | 21 +++++++++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
> 4 files changed, 28 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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

>2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
