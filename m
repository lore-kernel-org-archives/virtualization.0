Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AE6C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 15:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF776853B6;
	Fri, 10 Dec 2021 15:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZEDD4iy0gatK; Fri, 10 Dec 2021 15:57:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7BEA185237;
	Fri, 10 Dec 2021 15:57:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37CBDC002F;
	Fri, 10 Dec 2021 15:57:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4E71C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 15:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B43374040A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 15:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZ8qKIOlzMtA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 15:57:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B915E402D0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639151845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UjRrEEFV0RnFo1gRn0fkwiU82fcIwIzn2KvghaQzERo=;
 b=Iv7WNOMnD6vHFSu/cFs/pwUTGohq+O8qQwi3ZF6QPJ0OAzM8gmTLnNaTp814s+IJwB2MJP
 Jr6F+XS6yBMwzaUCSaKBhhI9B+MKZs/4iC0RFXUfRPzpGVcTPW6D9OQW20bH+roIVM1ASv
 4dGumWjGztjFC22duJCtfBJMOpV+U/g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-12XkR4s-PZSUQcrsfBlgYA-1; Fri, 10 Dec 2021 10:57:24 -0500
X-MC-Unique: 12XkR4s-PZSUQcrsfBlgYA-1
Received: by mail-qk1-f198.google.com with SMTP id
 u8-20020a05620a454800b00468482aac5dso10614047qkp.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 07:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UjRrEEFV0RnFo1gRn0fkwiU82fcIwIzn2KvghaQzERo=;
 b=p1VjZegnbJ5p7kNWtbAbpByoD9KJDR++qyNN8XVV3Ecf6sHFfC7ygezhL49aMNPkc+
 k8j4ANbQXmCM8Uj8i/97GLSpZpBowi7IdMuA7QrV8jnMOEdnkBDDuMnnnyXketNnQLEA
 gt5ej6i8BSkg4Ypnl1t6xhj91dnxtMaBUUACKm/9jzPvu8BMRZRxU4UhWmZ5equyJWKR
 9ZHhuf1/IrW5geDmPULgjcbPUCOQksJSuIKD/a455qTyZz41Oig7kyRYftNjbmDiuksg
 nI1tHKruU4JayYj2WvFMbKGX8yruFnRRJ/sRa+iSFhRRvcAKNaCaMcf4jgd2mMuSfj7r
 mSlw==
X-Gm-Message-State: AOAM531gxdHlzTkUreByH8EB0pek54BMnuFs0LLNkU/G/FfEJUcwBSGF
 v1lc6U7ErmFvtrzEGveBj/amn4pA3Dqg5NOEJ0i0PPWn8nN6wcv/qtF8i6ztPuBw+1bIloRPacV
 mbdjzorRH/xOh2W/wBeQ8pAhNjUTULR75HaDpUUAjKA==
X-Received: by 2002:a05:6214:2623:: with SMTP id
 gv3mr26529280qvb.63.1639151844015; 
 Fri, 10 Dec 2021 07:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzs+LzmUpOama6unBO927f2nSILl4Bmq0c61+mViRdU6k0JP+iu8wBoSgzkRmRq8fOU8h1alQ==
X-Received: by 2002:a05:6214:2623:: with SMTP id
 gv3mr26529251qvb.63.1639151843813; 
 Fri, 10 Dec 2021 07:57:23 -0800 (PST)
Received: from steredhat (host-87-21-203-138.retail.telecomitalia.it.
 [87.21.203.138])
 by smtp.gmail.com with ESMTPSA id f1sm2185250qtf.74.2021.12.10.07.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 07:57:23 -0800 (PST)
Date: Fri, 10 Dec 2021 16:57:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH] virtio: fix a typo in function "vp_modern_remove"
 comments.
Message-ID: <20211210155719.i3men2finfug47ux@steredhat>
References: <20211210073546.700783-1-dapeng1.mi@intel.com>
MIME-Version: 1.0
In-Reply-To: <20211210073546.700783-1-dapeng1.mi@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Fri, Dec 10, 2021 at 03:35:46PM +0800, Dapeng Mi wrote:
>Function name "vp_modern_remove" in comments is written to
>"vp_modern_probe" incorrectly. Change it.
>
>Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
>---
> drivers/virtio/virtio_pci_modern_dev.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>index e11ed748e661..e8b3ff2b9fbc 100644
>--- a/drivers/virtio/virtio_pci_modern_dev.c
>+++ b/drivers/virtio/virtio_pci_modern_dev.c
>@@ -345,7 +345,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> EXPORT_SYMBOL_GPL(vp_modern_probe);
>
> /*
>- * vp_modern_probe: remove and cleanup the modern virtio pci device
>+ * vp_modern_remove: remove and cleanup the modern virtio pci device
>  * @mdev: the modern virtio-pci device
>  */
> void vp_modern_remove(struct virtio_pci_modern_device *mdev)
>-- 
>2.30.2
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
