Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437FAC6FD1D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 14:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C983981A27;
	Mon, 20 Mar 2023 14:57:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C983981A27
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ai6Y5y00
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5RYjmMPmsCf; Mon, 20 Mar 2023 14:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 71DCD8188A;
	Mon, 20 Mar 2023 14:57:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71DCD8188A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA7FC0071;
	Mon, 20 Mar 2023 14:57:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E36DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BDE5819BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BDE5819BE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MW1iOyk11jOH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:57:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1F738188A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1F738188A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679324252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OQtFmm4KZTwh3zjk0Ct7Wnh43xep01cq4SPytfY48TY=;
 b=ai6Y5y00wR6f76FPHFokaQjnJ9NTg1y6w5o3u4LkK1CmZ83WSTud9OdCpdk3gXbBfxGNOY
 EZjuqLd26ngLGsflS2iCCe715i9o0sNQBMpJGgUFGGj7yjGjkqH0c2eWbTzmLDE9MuGllR
 s259Z9nHRvG288FORzXWZ8ZIw2+WmH4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-qH7xE-p5NOmefg0h93nPsg-1; Mon, 20 Mar 2023 10:57:25 -0400
X-MC-Unique: qH7xE-p5NOmefg0h93nPsg-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay12-20020a05600c1e0c00b003ed201dcf71so5656511wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 07:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679324244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQtFmm4KZTwh3zjk0Ct7Wnh43xep01cq4SPytfY48TY=;
 b=8DqWvvKf+qR0Hc2ja0/qvL2hAjrJADNfPTZvwSjkpi1+XEVnxdBUqzpohACJawfJHW
 hy38kOZYbwmjde3pEVzVuLSaHBBqd0wZ/w/r+cbEAcHuL0iKTDpG6v5SBdcbsE8qvUIo
 yVvkpGBiwFZu/NlLq7d2Oq7XjpMWAaHJWc1GXpnMoz3JjM5SD0WAblZYZo9hMT5PY58o
 GeNSz4oOsCMfQ3hf3QzgaAAPQOgWh/NNF1JZaNKrQ+kFGWDM8+0LaT22yWhf0b/E56uI
 fo86ycSBWB68PzwrNE4bWjKxfSSsGPC05PO7SJrwMv0A78sxA0H16L0GI6cB6kPn/091
 zLlw==
X-Gm-Message-State: AO0yUKXgAlv/myXiNoTnggprfwMWwr2y0+yhMCKhyBA6KXUEK/t0sV1p
 stDL4vCBWjiaVFTEpNyNgJUTf3n5GZEXKeuaQqGoyQBtolgTKffV0elaOAxS5DFMqfUqokccbVf
 iY/22epdWfxX1wfMmbkEpFrVInobLRgOtlyW637Nk0g==
X-Received: by 2002:a05:600c:350f:b0:3eb:3843:9f31 with SMTP id
 h15-20020a05600c350f00b003eb38439f31mr32779743wmq.10.1679324244388; 
 Mon, 20 Mar 2023 07:57:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set+H3q9948VZ11zwy3FuyhsaXEplz4rpzcboLvqOLEhb7JocoduN7nI4hrj2vQBstLG8pNpEyw==
X-Received: by 2002:a05:600c:350f:b0:3eb:3843:9f31 with SMTP id
 h15-20020a05600c350f00b003eb38439f31mr32779734wmq.10.1679324244157; 
 Mon, 20 Mar 2023 07:57:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 bg5-20020a05600c3c8500b003e7f1086660sm16977466wmb.15.2023.03.20.07.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 07:57:23 -0700 (PDT)
Date: Mon, 20 Mar 2023 15:57:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/3] virtio/vsock: fix header length on skb merging
Message-ID: <20230320145718.5gytg6t5pcz5rpnm@sgarzare-redhat>
References: <e141e6f1-00ae-232c-b840-b146bdb10e99@sberdevices.ru>
 <63445f2f-a0bb-153c-0e15-74a09ea26dc1@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <63445f2f-a0bb-153c-0e15-74a09ea26dc1@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Sun, Mar 19, 2023 at 09:51:06PM +0300, Arseniy Krasnov wrote:
>This fixes header length calculation of skbuff during data appending to
>it. When such skbuff is processed in dequeue callbacks, e.g. 'skb_pull()'
>is called on it, 'skb->len' is dynamic value, so it is impossible to use
>it in header, because value from header must be permanent for valid
>credit calculation ('rx_bytes'/'fwd_cnt').
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")

I don't understand how this commit introduced this problem, can you
explain it better?

Is it related more to the credit than to the size in the header itself?

Anyway, the patch LGTM, but we should explain better the issue.

Thanks,
Stefano

>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 6d15cd4d090a..3c75986e16c2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1091,7 +1091,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
> 			free_pkt = true;
> 			last_hdr->flags |= hdr->flags;
>-			last_hdr->len = cpu_to_le32(last_skb->len);
>+			le32_add_cpu(&last_hdr->len, len);
> 			goto out;
> 		}
> 	}
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
