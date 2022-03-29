Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D124C433EF
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 07:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C89E984186;
	Tue, 29 Mar 2022 07:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGBApc9ktqER; Tue, 29 Mar 2022 07:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C9BC84185;
	Tue, 29 Mar 2022 07:50:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BEA2C001D;
	Tue, 29 Mar 2022 07:50:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63B66C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50ABE40579
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k4Wt1t9L5rbT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:50:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 982FD402FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648540232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HHYas20bFA+kNgMHaxoIQKsMvNcafn9rtG/cGQWeJ9M=;
 b=Zo6ty+hOTEmURP+TdqUWLsb1KPMTt145QDnODGBMpnjZoeL+84/AqGBEEYXTDlvn4vnvXF
 rnoe63XGY5LZKAy4jCBHO7y/oosPZ8bqksCTRWgIfWUXijEzU+y4V6LJYc67D1biJcIT96
 i60pe1FvIcP4KSDeAICIC4UcUvPBn10=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-9MB4TQdBMriwon0SdpXACA-1; Tue, 29 Mar 2022 03:50:31 -0400
X-MC-Unique: 9MB4TQdBMriwon0SdpXACA-1
Received: by mail-qt1-f197.google.com with SMTP id
 z18-20020ac84552000000b002e201c79cd4so14182664qtn.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 00:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HHYas20bFA+kNgMHaxoIQKsMvNcafn9rtG/cGQWeJ9M=;
 b=FmOdUTIj+qeWLJPUI3Sf03RhPA+DEHGNS0OlBTKiMvpP4I94twM4tJecAU9/rdtjh/
 cBpVmVVoOPniIRPdN79Se4W6+778TiYQjL1V1q9XJMNRuvJICN24T2h+Xa80f5TWI5Jx
 fuaT7enZQ+BSolcbFKZJwM3gOlZ2e3MGzrJC5XwDE+e1BhIZTfnfXh59Dr4puJ6n2Lag
 QbA6gWHmTf8Ze36s6QaNR1RlMZTjURTjlUdU/iFr7wfcRsvxIVbSY7Rhlgr2Y0Lm1TE6
 d0dTiMpww6lk6KY/yR2I0PHB1rXuO+PzBgmdc10N2c+yo+OeDxA2/9ixDFOe3M1Xf+la
 5SaA==
X-Gm-Message-State: AOAM532/0Ht6zbAWBwe/ewnHgRcpweibmV5K0N4uPmUYiSDDafqizQii
 PwL84LXszJQDBt3XLlDvHwFxF11XNfPzkKX2BIg7BQA/lSAtKRt0dttZGZ/DewpYks9G5r/g45n
 3MeC1aoQqSRk6msN6+/mOnGelGLa4CAh+MggcryyWEQ==
X-Received: by 2002:a05:6214:4016:b0:441:28a4:52ff with SMTP id
 kd22-20020a056214401600b0044128a452ffmr24894024qvb.74.1648540230486; 
 Tue, 29 Mar 2022 00:50:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBn1dkAlRDwy4hsXt41FSpdVAAm3YfVvYIpXoTpkqSVyseUq6Uo9uoTaE6ItLGVv55uUz6aA==
X-Received: by 2002:a05:6214:4016:b0:441:28a4:52ff with SMTP id
 kd22-20020a056214401600b0044128a452ffmr24894016qvb.74.1648540230285; 
 Tue, 29 Mar 2022 00:50:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-67.retail.telecomitalia.it.
 [79.46.200.67]) by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a14b300b0067e09a47e39sm8843107qkj.34.2022.03.29.00.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 00:50:29 -0700 (PDT)
Date: Tue, 29 Mar 2022 09:50:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs
 check
Message-ID: <20220329075024.eoajm5ufrcfytug4@sgarzare-redhat>
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
 <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
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

On Mon, Mar 28, 2022 at 06:58:17PM +0800, Xianting Tian wrote:
>The 'if (vq->vq.num_free < descs_used)' check will almost always be false.
>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/virtio/virtio_ring.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index d597fc0874ec..ab6d5f0cb579 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -525,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> 		descs_used = total_sg;
> 	}
>
>-	if (vq->vq.num_free < descs_used) {
>+	if (unlikely(vq->vq.num_free < descs_used)) {
> 		pr_debug("Can't add buf len %i - avail = %i\n",
> 			 descs_used, vq->vq.num_free);
> 		/* FIXME: for historical reasons, we force a notify here if
>-- 
>2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
