Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0147C433F5
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 08:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 302ED416B1;
	Mon, 23 May 2022 08:27:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XYMLax31eVrM; Mon, 23 May 2022 08:27:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6DC9D416BA;
	Mon, 23 May 2022 08:27:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 338CEC0039;
	Mon, 23 May 2022 08:27:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E63BBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD966416BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LofySqgsm5KM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:27:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C71DD416B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653294471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/1kwIlur/LWGYGUmdTrROiOtB3QTQUmvrtaI59KDYw=;
 b=YzcRkmrwdnU9Hy0fRvlOt7TUh8tYpL+UbiNO4cBgqWLSa8I36oNzO/ChM/AiAk5IcAU0FM
 OYbxckaiQIxpSeRf6zaLrDCOf4yWdB+0n/F6p+itIUMyBMd20Ej7QuCuUB4LkJ4mNWPMWZ
 Tcjn78gxt774BtkbSaLnaPcSL8i8sX8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-p0xGxP-QMo-AmiRHeg2naQ-1; Mon, 23 May 2022 04:27:50 -0400
X-MC-Unique: p0xGxP-QMo-AmiRHeg2naQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 kl23-20020a056214519700b0046200065604so7291622qvb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 01:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=T/1kwIlur/LWGYGUmdTrROiOtB3QTQUmvrtaI59KDYw=;
 b=MV1zeoFs+w5sLb1XEI/R5bcPLR5hq2YxYyk6OhgkJW/dPQ0iqGgSIi5lPAzAlFLJ7r
 N6A+jkt+1PmEbq8I8cDt3eQpyeF69bD8h0sLUK8JoGj6ya5LGsGInx7jLx+VCDzWcX3s
 2PhsXZXnR40v3oQb3YjPeOlm3FxIZQo7Gj/FlcJEncMZpG3gRRCDdP9QFd2wxlAZrH9v
 mA2/3u3iKK57QrhxMjXQQuzmsp76F2b2BQowdy9ZNAoTOx/BfGFvVfTZYkN1pJQeziO8
 vShFBWC8+4uwUKvqvtYJUZyOizYmmwULYd+GhooZsMOj1+kso2ljLVpsVTOuFAU5yk95
 SFGQ==
X-Gm-Message-State: AOAM532TyHxhGhLMmJcemmILP2GZNvutDq7DlV3gaNb9az3dkE2jbDLe
 RHuHqQ2G0HiJEFn1Ilhg8Iblh3vVwYnz77B1tChiriKJUM5NnmE/p90B0818b5BoJQpwKBGx28w
 bJGB8I/IK2dtECkMQvGeg+cdaDZfJJU/pHkTzImA4lA==
X-Received: by 2002:ad4:5bef:0:b0:462:3068:9225 with SMTP id
 k15-20020ad45bef000000b0046230689225mr4664783qvc.26.1653294470031; 
 Mon, 23 May 2022 01:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxext/h6oF1JgzqF6JvJzAca18yRqrepSqFHtMgfDdKHE+p8QYTPMkUbIPydmmw9aPdDAkBCw==
X-Received: by 2002:ad4:5bef:0:b0:462:3068:9225 with SMTP id
 k15-20020ad45bef000000b0046230689225mr4664769qvc.26.1653294469789; 
 Mon, 23 May 2022 01:27:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 m24-20020ac866d8000000b002f932d920ccsm2544399qtp.64.2022.05.23.01.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 May 2022 01:27:49 -0700 (PDT)
Date: Mon, 23 May 2022 10:27:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH 4/4] vdpa_sim: Implement stop vdpa op
Message-ID: <20220523082738.h7lvwkysnqhynf37@sgarzare-redhat>
References: <20220520172325.980884-1-eperezma@redhat.com>
 <20220520172325.980884-5-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220520172325.980884-5-eperezma@redhat.com>
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
 Zhang Min <zhang.min9@zte.com.cn>, lulu@redhat.com, martinh@xilinx.com,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
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

On Fri, May 20, 2022 at 07:23:25PM +0200, Eugenio P=E9rez wrote:
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
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
> 3 files changed, 25 insertions(+)
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

It would be nice to do the same for vdpa_sim_blk as well.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
