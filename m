Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655EFC43334
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 13:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1AAA4175B;
	Tue, 28 Jun 2022 13:40:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1AAA4175B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N34XgfuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9o-gi7wB-1Gn; Tue, 28 Jun 2022 13:40:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2693417AE;
	Tue, 28 Jun 2022 13:40:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2693417AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA8B5C0032;
	Tue, 28 Jun 2022 13:40:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61B23C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CC3C416C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CC3C416C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P698gq2S3FEh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:40:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3949415C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3949415C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656423607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JI0SMOllATTHDDnFWqGpyGyrKVYRMdL/R18gEZANfRM=;
 b=N34XgfuTdposPCi0F6k6e4iuPT82msTP2J4ss2z7m/um3AtaLhefhSKPt1tBD0K8XGMBKl
 dGl3VwoiOZCTdPvwm2CAxh5o6WnVizKMRpVZGlAahX2bYrEnBu9ojLXMunA/HbuwxoHnAK
 9Er1GQfW+qlcQfiIJMV/WOuTPJwQskI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-QW1o-qV5Ne22hHi9PuZLew-1; Tue, 28 Jun 2022 09:40:06 -0400
X-MC-Unique: QW1o-qV5Ne22hHi9PuZLew-1
Received: by mail-qv1-f72.google.com with SMTP id
 jv13-20020a05621429ed00b0047048fce5bdso12268949qvb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JI0SMOllATTHDDnFWqGpyGyrKVYRMdL/R18gEZANfRM=;
 b=QYkqzqHsZOvpCcoexLnhn6nADBw6FQRCZv1hlqujMQLD4ETsDUB/9txaT5LTAiZTeq
 8/QKJGRhwm0RR9EpmY5zOytt1uGnE///tGX8HtNDn89yZenT/l01Xq6W7UtQCdWe6H+p
 vr+Sg1urhrrsGq2J20LOPd/TYp2lwTObRVVxqPeQZKESD0q2Fp8/pTh7Bm/MulEpO/za
 p90e7rS9pD+KUywwId+O/XutgCCHLq45hrE5BCyGUyrQ0+zFITGj0qyM83kkoNdl3OIx
 YL3qHptQ8ZnZe+FYYmkRazWSFq1Te2NRaJeJoGxaCgPBzWG3nMGRLPjstnWSs+rG8kB0
 LqVw==
X-Gm-Message-State: AJIora+cGdBz+VGeo3oMEH5xVqNMNHoU8lJSzNWZaLhL+KCK4ifKRv6C
 xa7O/nnAsM/jhIMKGDIwuGt9S6jW5lxvLxQt5f20louKO7kGswk0IDJ4gpnHsWhiWSz5AmnOstk
 ARSFT7PwfCimm54gestuyrbndbZ6b/npCTgxNsJ8TyA==
X-Received: by 2002:a05:6214:509c:b0:470:529a:1d76 with SMTP id
 kk28-20020a056214509c00b00470529a1d76mr3556360qvb.7.1656423605661; 
 Tue, 28 Jun 2022 06:40:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uR1KivmrgHGt9XzHfmrBurNzgAa+UdSQyz20DSSdlK3mKA/+nt175Sp7jgxeEBsCjfL+bPrw==
X-Received: by 2002:a05:6214:509c:b0:470:529a:1d76 with SMTP id
 kk28-20020a056214509c00b00470529a1d76mr3556306qvb.7.1656423605246; 
 Tue, 28 Jun 2022 06:40:05 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 bl10-20020a05620a1a8a00b006a67eb4610fsm11214694qkb.116.2022.06.28.06.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 06:40:04 -0700 (PDT)
Date: Tue, 28 Jun 2022 15:39:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v6 1/4] vdpa: Add suspend operation
Message-ID: <20220628133955.sj32sfounu4byggl@sgarzare-redhat>
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-2-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220623160738.632852-2-eperezma@redhat.com>
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

On Thu, Jun 23, 2022 at 06:07:35PM +0200, Eugenio P=E9rez wrote:
>This operation is optional: It it's not implemented, backend feature bit
>will not be exposed.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> include/linux/vdpa.h | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 7b4a13d3bd91..d282f464d2f1 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -218,6 +218,9 @@ struct vdpa_map_file {
>  * @reset:			Reset device
>  *				@vdev: vdpa device
>  *				Returns integer: success (0) or error (< 0)
>+ * @suspend:			Suspend or resume the device (optional)
                                            ^
IIUC we removed the resume operation (that should be done with reset),
so should we update this documentation?

Thanks,
Stefano

>+ *				@vdev: vdpa device
>+ *				Returns integer: success (0) or error (< 0)
>  * @get_config_size:		Get the size of the configuration space includes
>  *				fields that are conditional on feature bits.
>  *				@vdev: vdpa device
>@@ -319,6 +322,7 @@ struct vdpa_config_ops {
> 	u8 (*get_status)(struct vdpa_device *vdev);
> 	void (*set_status)(struct vdpa_device *vdev, u8 status);
> 	int (*reset)(struct vdpa_device *vdev);
>+	int (*suspend)(struct vdpa_device *vdev);
> 	size_t (*get_config_size)(struct vdpa_device *vdev);
> 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> 			   void *buf, unsigned int len);
>-- =

>2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
