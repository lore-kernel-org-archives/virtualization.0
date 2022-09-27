Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A141C54EE9
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 22:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 125E8402DC;
	Tue, 27 Sep 2022 22:29:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 125E8402DC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XDXkmD/F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4o7RvKd3F5Tk; Tue, 27 Sep 2022 22:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 97EB340227;
	Tue, 27 Sep 2022 22:29:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97EB340227
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58153C0033;
	Tue, 27 Sep 2022 22:29:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6464DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3190C81489
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:29:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3190C81489
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XDXkmD/F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mGiSzgCgWTbP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:29:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17147812F0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17147812F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664317765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRQQc7BKWa8LDrkT5Hw2G0pLPlGFJTPkEo3Kh+HZDeo=;
 b=XDXkmD/FBH0hOiI0z4o16hff8LW6r+NKnCsKInL3MQwfonU9tfdqS46HcdweU5E28Wfaiw
 A3gbuoOuXx/3hr9JHyWaauOsCvmwjIyeSaE4zfpEhmNoUDHfdLBvMmpwvQCOJ2IvJ4F/Mi
 Jdeqhs8oxFP4CDXS1RZz5noblPdUg1U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-xHbvCXiMP5aSAPprdywMHg-1; Tue, 27 Sep 2022 18:29:24 -0400
X-MC-Unique: xHbvCXiMP5aSAPprdywMHg-1
Received: by mail-wm1-f69.google.com with SMTP id
 p36-20020a05600c1da400b003b4faefa2b9so6161940wms.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 15:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=DRQQc7BKWa8LDrkT5Hw2G0pLPlGFJTPkEo3Kh+HZDeo=;
 b=GIyEl7FBAcBT9a8k9jsiipkvPJYOcK1BYCXn0WczZ47UEghDQot5bpBjtfroh+yTaH
 EK9h088+SC/6n1fa09zbXoMs9FgrPv8WdPEybVi6JZCP5bHYuRMnd8IbBiba9nYtktkD
 XVVkFXgvduk2u8fWcnX8X3vsXvg0tBr6bSjwgkGHGA11qcTp95d9OPPTV7iVOwtuRga8
 0GwL6cFUpTvp7VbXG140ZvrFBUOWuxQia/+FZHy1IQOHdLyB8q15xxVtZ0v+33sO/IYj
 K5qEqPTCa8piBNfssEAaqAK7Ao3pgfAv9ofcQoS5Dawjlk4XAS36DvEspQv9AU5u0I0j
 hv6A==
X-Gm-Message-State: ACrzQf2///q/THVDm0fP+7JtIrtJ5bXnAddzKiMn9PgfwxRLwnbO2qBo
 UvuY2CepXPSv4ELBCUipfkcXJ7IZHtG7M/i7B+kniHucPyK+7+jIWhrdMJQenQs+AVJcfyvyNI6
 cp9bgNmsruG4j1AzzgSEhTvIZVQyNa9dO/2BQN1SBbQ==
X-Received: by 2002:a05:600c:3b1c:b0:3b4:fef3:6a62 with SMTP id
 m28-20020a05600c3b1c00b003b4fef36a62mr4427493wms.129.1664317762513; 
 Tue, 27 Sep 2022 15:29:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6i/qTzNbRH5TrNdBRgSX0rc5y6zxldDHjyPAwP5H5gXq9WE2MFlW3Al5YW7ASlerOifzbrkg==
X-Received: by 2002:a05:600c:3b1c:b0:3b4:fef3:6a62 with SMTP id
 m28-20020a05600c3b1c00b003b4fef36a62mr4427485wms.129.1664317762333; 
 Tue, 27 Sep 2022 15:29:22 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 bx31-20020a5d5b1f000000b0022a2bacabbasm2837817wrb.31.2022.09.27.15.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 15:29:21 -0700 (PDT)
Date: Tue, 27 Sep 2022 18:29:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtio_ring: Drop unnecessary initialization of
 detach_buf_packed
Message-ID: <20220927182855-mutt-send-email-mst@kernel.org>
References: <20220926102946.3097-1-wangdeming@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220926102946.3097-1-wangdeming@inspur.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Sep 26, 2022 at 06:29:46AM -0400, Deming Wang wrote:
> The variable is initialized but it is only used after its assignment.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

The thing to do here is to move the first assigment to the
initialization.

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..abac0a3de440 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1544,7 +1544,7 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  static void detach_buf_packed(struct vring_virtqueue *vq,
>  			      unsigned int id, void **ctx)
>  {
> -	struct vring_desc_state_packed *state = NULL;
> +	struct vring_desc_state_packed *state;
>  	struct vring_packed_desc *desc;
>  	unsigned int i, curr;
>  
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
