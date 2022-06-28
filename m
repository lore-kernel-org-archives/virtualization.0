Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948E4C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 13:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2ED1D40C3C;
	Tue, 28 Jun 2022 13:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ED1D40C3C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X+RlbnLj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hg5C6a17P_u; Tue, 28 Jun 2022 13:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB3F640C0E;
	Tue, 28 Jun 2022 13:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB3F640C0E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4F9C0032;
	Tue, 28 Jun 2022 13:43:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC4BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B94D681CE7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:43:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B94D681CE7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X+RlbnLj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bGNb247JWpr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:43:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE15881AF3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE15881AF3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656423834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abXoIOqyAhxt2c9XGMOMQUpyKJ4rqMJ6hybu9hpX0PI=;
 b=X+RlbnLjXs5vg/3ccXMs4zXyOtjBM+1k0yxcRr7RUhhgeFHtr6Ui+ZzeA/SlsKaua4BvQ1
 7BwvjoHtSBgqdUutKV+lMVHhwbPjjoh2gpwpc/K0oAh0o84Rz8WV5rLcFM6fFaXtRW+tGV
 lr7NjOj9Rcsu4s/XNLcXLANCvSfuazU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-vAyPmr9LMP256EMDbXzVTw-1; Tue, 28 Jun 2022 09:43:46 -0400
X-MC-Unique: vAyPmr9LMP256EMDbXzVTw-1
Received: by mail-wr1-f71.google.com with SMTP id
 e5-20020adff345000000b0021b9f00e882so1802192wrp.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=abXoIOqyAhxt2c9XGMOMQUpyKJ4rqMJ6hybu9hpX0PI=;
 b=LKhYNSfVigd5/UFcps2x97366cwYTyDacfEvrTKqF3s0lfNQgwSIA2Xkfrn2kLZtND
 lDKayu/Nmm2EWGF4+zZnkTAqvumElz22pRK7U3iANXB7NtfW5YC4q5BGZkVBo6+49OJk
 UC3ykocBGj03jLBazBzeDm+r8sXS8qLocHiMtowd5p+/AhSq22tAwYNi/xAksrbhkAIT
 QjpAkJiCJOFv6jzsPnp+X/G8bwVS3SNrsMYtgjUGWYYP7lUGq9W1TiUyRUWy4iONFQA3
 t9YS8w7TgOxw+2YIzlo9lI71H5v1AAQVdnSpdSDBqh5qoigyuTzqyQXa7iP44LOYSsf7
 uYdw==
X-Gm-Message-State: AJIora9nXQJcH4ySrYNr4k6e/vKefL3K6Bj8dgQWyy5qfUWCmVuIX1AM
 ++V46mMl2omne2QDq90wj9ikQgX6Xkop8f9hL5ArSYeis4jNuVh4Snqgxdcm5TO42aiXf9k3MOV
 GtNB8blG5LBml4oW7FFsP4NUsXrShC2cfFQKGopbEWQ==
X-Received: by 2002:a05:6000:1a8b:b0:219:af0c:ddf8 with SMTP id
 f11-20020a0560001a8b00b00219af0cddf8mr16993633wry.142.1656423824961; 
 Tue, 28 Jun 2022 06:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulCbVDwMIzdNmmQrb5kCw0weokx6fGGdIcmA6shirIYjb3LYAkbgo0mXLYbXoBYhaHKES0mQ==
X-Received: by 2002:a05:6000:1a8b:b0:219:af0c:ddf8 with SMTP id
 f11-20020a0560001a8b00b00219af0cddf8mr16993581wry.142.1656423824625; 
 Tue, 28 Jun 2022 06:43:44 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 j18-20020a05600c42d200b003a02b9c47e4sm24072440wme.27.2022.06.28.06.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 06:43:44 -0700 (PDT)
Date: Tue, 28 Jun 2022 15:43:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v6 2/4] vhost-vdpa: introduce SUSPEND backend feature bit
Message-ID: <20220628134340.5fla7surd34bwnq3@sgarzare-redhat>
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220623160738.632852-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Piotr.Uminski@intel.com, martinh@xilinx.com,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
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

On Thu, Jun 23, 2022 at 06:07:36PM +0200, Eugenio P=E9rez wrote:
>Userland knows if it can suspend the device or not by checking this feature
>bit.
>
>It's only offered if the vdpa driver backend implements the suspend()
>operation callback, and to offer it or userland to ack it if the backend
>does not offer that callback is an error.

Should we document in the previous patch that the callback must be =

implemented only if the drive/device support it?

The rest LGTM although I have a doubt whether it is better to move this =

patch after patch 3, or merge it with patch 3, for bisectability since =

we enable the feature here but if the userspace calls ioctl() with =

VHOST_VDPA_SUSPEND we reply back that it is not supported.

Thanks,
Stefano

>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vhost/vdpa.c             | 16 +++++++++++++++-
> include/uapi/linux/vhost_types.h |  2 ++
> 2 files changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 23dcbfdfa13b..3d636e192061 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -347,6 +347,14 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *=
v,
> 	return 0;
> }
>
>+static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
>+{
>+	struct vdpa_device *vdpa =3D v->vdpa;
>+	const struct vdpa_config_ops *ops =3D vdpa->config;
>+
>+	return ops->suspend;
>+}
>+
> static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *fea=
turep)
> {
> 	struct vdpa_device *vdpa =3D v->vdpa;
>@@ -577,7 +585,11 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
> 	if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
> 		if (copy_from_user(&features, featurep, sizeof(features)))
> 			return -EFAULT;
>-		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
>+		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
>+				 BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
>+			return -EOPNOTSUPP;
>+		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>+		     !vhost_vdpa_can_suspend(v))
> 			return -EOPNOTSUPP;
> 		vhost_set_backend_features(&v->vdev, features);
> 		return 0;
>@@ -628,6 +640,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fil=
ep,
> 		break;
> 	case VHOST_GET_BACKEND_FEATURES:
> 		features =3D VHOST_VDPA_BACKEND_FEATURES;
>+		if (vhost_vdpa_can_suspend(v))
>+			features |=3D BIT_ULL(VHOST_BACKEND_F_SUSPEND);
> 		if (copy_to_user(featurep, &features, sizeof(features)))
> 			r =3D -EFAULT;
> 		break;
>diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_t=
ypes.h
>index 634cee485abb..1bdd6e363f4c 100644
>--- a/include/uapi/linux/vhost_types.h
>+++ b/include/uapi/linux/vhost_types.h
>@@ -161,5 +161,7 @@ struct vhost_vdpa_iova_range {
>  * message
>  */
> #define VHOST_BACKEND_F_IOTLB_ASID  0x3
>+/* Device can be suspended */
>+#define VHOST_BACKEND_F_SUSPEND  0x4
>
> #endif
>-- =

>2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
