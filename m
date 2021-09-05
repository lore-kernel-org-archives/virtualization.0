Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF24C433EF
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:09:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5758B60E52
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5758B60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B233400C6;
	Sun,  5 Sep 2021 15:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E7CcLTJNvelk; Sun,  5 Sep 2021 15:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 851D6400F5;
	Sun,  5 Sep 2021 15:09:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57D5AC0010;
	Sun,  5 Sep 2021 15:09:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F401C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECC2240299
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Adoge38bxb8
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C178A40258
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630854563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bkfQCXJDEUYk3g8BBS8rlUuMyFV0Zq2nUPXbhNlOHg0=;
 b=Q85YS7u1I/oftYsxt+nm6nVOms4LmElCmBxTCLyJbIFU+F83YwTzJCSYx20Fbf5ZAvvABr
 VP3DFd5q1v0oB4bNNm4Kn8wE4SgnjOKbRbH/FWJDv/i6jsX/mHpD7fs8t9bVuGBP/ihzN/
 JUGD3HzsPKeXgYjdBu0jDDEhydcZK0U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-X_f_TCXMNrS1pIAc8aEvWQ-1; Sun, 05 Sep 2021 11:09:22 -0400
X-MC-Unique: X_f_TCXMNrS1pIAc8aEvWQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 y188-20020a1c7dc5000000b002e80e0b2f87so2687933wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 08:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bkfQCXJDEUYk3g8BBS8rlUuMyFV0Zq2nUPXbhNlOHg0=;
 b=jGob7yI3FX3t/7C85s9QSgNGDC/rOjAiwGAhhUpioeyz5+Sv4rCrOpxAXBnSlJfDVV
 nHH8yLmDiy9dQC1tpVKT17WTpvGMv86R56QL1HsYcJXf2DJ6IVThDgj3qSu39U6cdbp7
 ffy1sw6Xb1oP2HqQFzYaSW8jQl3E1SReqOtn45biyx0Pjwfqx8cH1th+W51crQBZ1727
 B9r/zRKCWcKf3YxNW7tyh2BW7lWk/mYmTkm7DdU1+Gz5ZotR8go6mU77OlQ77DChlGmL
 lfDT38ndw5w9bWftby0T4vlE3znwCVCGShuJdGVvulVApybfgqSpLYtRMT052iBUtIYO
 ns9w==
X-Gm-Message-State: AOAM531tX4dg02yLp6u77DW/cx+ZEtHw24Pz89awFKboJBsjdC9S1ELA
 4vj6JiVxWJ2nNRQzbFQwHS9TIWmWAMuF7Ms0dvSMaqm6LLBYLzOWTpkH8rDoL+dNbNDZ1e8SAx4
 s2YWRMWOey3UqLc6Hhh+up02QFB33AZlEISk+bHFJcQ==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr7294613wmd.160.1630854560957; 
 Sun, 05 Sep 2021 08:09:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWg8Rhwq8pH6/4X7ngXckGFB5ySGYXCykfVnvivAfOnMQtde2OZp9BretAuFmPJFBmLiNypg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr7294604wmd.160.1630854560782; 
 Sun, 05 Sep 2021 08:09:20 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id h11sm6126459wrx.9.2021.09.05.08.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 08:09:20 -0700 (PDT)
Date: Sun, 5 Sep 2021 11:09:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio: add VIRTIO_F_IN_ORDER to header file
Message-ID: <20210905110804-mutt-send-email-mst@kernel.org>
References: <20210905120911.8239-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210905120911.8239-1-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: nitzanc@nvidia.com, oren@nvidia.com, stefanha@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, Sep 05, 2021 at 03:09:11PM +0300, Max Gurtovoy wrote:
> For now only add this definition from the spec. In the future, The
> drivers should negotiate this feature to optimize the performance.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

So I think IN_ORDER was a mistake since it breaks ability
to do pagefaults efficiently without stopping the ring.
I think that VIRTIO_F_PARTIAL_ORDER is a better option -
am working on finalizing that proposal, will post RSN now.


> ---
>  include/uapi/linux/virtio_config.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b5eda06f0d57..3fcdc4ab6f19 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -82,6 +82,12 @@
>  /* This feature indicates support for the packed virtqueue layout. */
>  #define VIRTIO_F_RING_PACKED		34
>  
> +/*
> + * This feature indicates that all buffers are used by the device in the same
> + * order in which they have been made available.
> + */
> +#define VIRTIO_F_IN_ORDER              35
> +
>  /*
>   * This feature indicates that memory accesses by the driver and the
>   * device are ordered in a way described by the platform.
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
