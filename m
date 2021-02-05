Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69835C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:25:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58A1650EB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58A1650EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3833D872C1;
	Fri,  5 Feb 2021 15:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qRLPlySFxfxt; Fri,  5 Feb 2021 15:25:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5EC7787277;
	Fri,  5 Feb 2021 15:25:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41928C08A1;
	Fri,  5 Feb 2021 15:25:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7364DC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 59AFC872BD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M8G+Ht4IUfPU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:25:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4E9C87277
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612538707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YxfECkOsSZ1stOC425/5nMxggTO4yyHeVSunIkBmhLY=;
 b=TypJtOjri3qX3l269J4f/my3c4RAJMBE5Rnwao9A+RjGJupobe89Dk8ujRD0xt0NZD6FXd
 fGBgcBvqO0Vo5xT8SUTkcQ5kUeS4E5MHhpV1ii7U4DfVqVX09FfJRWyaUo/zs95SI5OjFu
 Q/WrsE7RyOx53KLc8oUVMkJrW/7sPwA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Ei0X9bSZNo6qJ-SrWQj4_Q-1; Fri, 05 Feb 2021 10:25:05 -0500
X-MC-Unique: Ei0X9bSZNo6qJ-SrWQj4_Q-1
Received: by mail-wm1-f70.google.com with SMTP id b62so3950798wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 07:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YxfECkOsSZ1stOC425/5nMxggTO4yyHeVSunIkBmhLY=;
 b=gfqhY7qPfyXV+M/RCid0/AjWwnuB6Wt4QNUun23zyjPt/bHosJvZRb1ikP4A/uCV0I
 hlxWYcMTkKJS7q3mpekpaRLhD2yO6YDQor98PdZY4bhWL9VoddwIpMbkUjh2EbSsamQy
 hU4a8K/OkrAF+ME2Wf0jDRVwvAF04zRO/bxX5NeQ/Jvy05dDHKQ4DVJURVnAa/hFbTXc
 WmsDivhZO3Hb8Fy3Wd9Cwn+whhrfXCfg/0J1Xtfy0YzzFzHKB64OxjaIs18GJmsR1v4I
 WcifzdTKlJ8L0yEp3y+fH7/zVo4MusfC4m3P+XwVeF4F0Jvy/NcdGF372i03PVYMQ7Nx
 cgSg==
X-Gm-Message-State: AOAM530S+VTDuZG6VWh3+X0Kxfp4mPkFDEVCcQ382Jqq/MK9LLERl0QM
 ZW5zCy2VDOW3mmZAJc4eG3t3EM2t3j0jzYJHVwlAiPvU7HVKxXGjpPgu1E1cXOD0qAqP2H4GFpH
 JImrmtaGQGInw6P0MhhqTvu3GUMvwRYHs2xIuwIjrQQ==
X-Received: by 2002:a05:6000:41:: with SMTP id
 k1mr5536466wrx.386.1612538704681; 
 Fri, 05 Feb 2021 07:25:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxh9sPVEw44Ux+BaaaaDLWX/oOyRAPVDo/jFYvRscnoIbqqTxP54NPPzP3n77CaXR4yrWtdw==
X-Received: by 2002:a05:6000:41:: with SMTP id
 k1mr5536451wrx.386.1612538704557; 
 Fri, 05 Feb 2021 07:25:04 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id d9sm13031562wrq.74.2021.02.05.07.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 07:25:03 -0800 (PST)
Date: Fri, 5 Feb 2021 10:24:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 18/19] virtio_vdpa: don't warn when fail to disable vq
Message-ID: <20210205102442-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-19-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210104065503.199631-19-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jan 04, 2021 at 02:55:02PM +0800, Jason Wang wrote:
> There's no guarantee that the device can disable a specific virtqueue
> through set_vq_ready(). One example is the modern virtio-pci
> device. So this patch removes the warning.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Do we need the read as a kind of flush though?

> ---
>  drivers/virtio/virtio_vdpa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 4a9ddb44b2a7..e28acf482e0c 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -225,9 +225,8 @@ static void virtio_vdpa_del_vq(struct virtqueue *vq)
>  	list_del(&info->node);
>  	spin_unlock_irqrestore(&vd_dev->lock, flags);
>  
> -	/* Select and deactivate the queue */
> +	/* Select and deactivate the queue (best effort) */
>  	ops->set_vq_ready(vdpa, index, 0);
> -	WARN_ON(ops->get_vq_ready(vdpa, index));
>  
>  	vring_del_virtqueue(vq);
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
