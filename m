Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D5C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:32:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3AE264E37
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AE264E37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8A5DA87096;
	Mon,  8 Feb 2021 18:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSaDicz+Bdqq; Mon,  8 Feb 2021 18:32:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DDDFB86C3A;
	Mon,  8 Feb 2021 18:32:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1624C0891;
	Mon,  8 Feb 2021 18:32:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCE63C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CB9EC85ABB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DrgT_rb7TE3f
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:32:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 05D4F85A5A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612809152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FONHI2TN+O9acLzuem6EKO8Yxg/GTLtQhMLyetszZzg=;
 b=EomRJV7hFFm9W17H9Qfl+8xzS9xRLJdvG/fjpDXUfcTD8izfMoBqqWhqXMs/hMylQi/Ipl
 OLWWQv/1/jeNZwSG8IS8ysQ04IYMhSHUYeCaCwORAK77DyVgxD/LzPUeEle3sCNoZSvTJU
 GDGXyhgJSPO7PoLgnWEGYlapkPO2p1A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-goIkM2Z0Nwq0NoYIMwKFgA-1; Mon, 08 Feb 2021 13:32:30 -0500
X-MC-Unique: goIkM2Z0Nwq0NoYIMwKFgA-1
Received: by mail-ed1-f69.google.com with SMTP id u24so11518929eds.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 10:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FONHI2TN+O9acLzuem6EKO8Yxg/GTLtQhMLyetszZzg=;
 b=lJoFFNMSR6Mp504ryr/K9VKgixxmmzu6m6IuEyXpvxMvcQAVR25ot6KDIknGC2nqqb
 19VwAJh7NE+Z9y0mhU0WVEGVjJpglUQ17fDCEA0n6jaysKX7lRTVNNUjuwfE1k54KLGm
 6tj64MdFkBzB0pG3Vu9PwRAPjmQR3cLUkpl/OrstL2v+oykhanIKQkyrv1jcVcZYS8OI
 r2npz7KBXg2O5U2oJy7mwwMgBnXy9hyknn4bIajnJBX5VNFUUbmrN1MC/sbjpezB8vwp
 crcB4NWRNgx9t9wQqvlCUlYoeXCF4UY1vm0/2kLGqC1dOKhiszgssCQbGlCLLVOVbUXi
 Vfmw==
X-Gm-Message-State: AOAM530wmZ+VhIhG6+q5P5CI84uiQz5KdqwvVz3xxU4pmcRHetL5uc+f
 jpS379ZB7LJDW8yRlgC+881AtlopzztITXUFYC9Qc7UUqvIgC0I95fK6S1s93e0kndKNeiXK4bp
 XRCc3P8DTeDGnV9zPGBM28GkLOK3jNH4vJcJCZiLRXA==
X-Received: by 2002:aa7:c755:: with SMTP id c21mr18592166eds.47.1612809148226; 
 Mon, 08 Feb 2021 10:32:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpsuTp5sRzeOMNIjmosofGMT5Va6UgHF+7NHtSfOHTT8nBvBhqO12WkK46eKwRMOgobAa2CA==
X-Received: by 2002:aa7:c755:: with SMTP id c21mr18592153eds.47.1612809148080; 
 Mon, 08 Feb 2021 10:32:28 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id x5sm10415492edi.35.2021.02.08.10.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 10:32:27 -0800 (PST)
Date: Mon, 8 Feb 2021 13:32:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: update credit only if socket is not
 closed
Message-ID: <20210208133211-mutt-send-email-mst@kernel.org>
References: <20210208144454.84438-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210208144454.84438-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kuba@kernel.org,
 Asias He <asias@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 08, 2021 at 03:44:54PM +0100, Stefano Garzarella wrote:
> If the socket is closed or is being released, some resources used by
> virtio_transport_space_update() such as 'vsk->trans' may be released.
> 
> To avoid a use after free bug we should only update the available credit
> when we are sure the socket is still open and we have the lock held.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Probably stable material.

> ---
>  net/vmw_vsock/virtio_transport_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 5956939eebb7..e4370b1b7494 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1130,8 +1130,6 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	vsk = vsock_sk(sk);
>  
> -	space_available = virtio_transport_space_update(sk, pkt);
> -
>  	lock_sock(sk);
>  
>  	/* Check if sk has been closed before lock_sock */
> @@ -1142,6 +1140,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		goto free_pkt;
>  	}
>  
> +	space_available = virtio_transport_space_update(sk, pkt);
> +
>  	/* Update CID in case it has changed after a transport reset event */
>  	vsk->local_addr.svm_cid = dst.svm_cid;
>  
> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
