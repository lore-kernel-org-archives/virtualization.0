Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41312C19F21
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 12:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A45EC40942;
	Wed, 27 Jul 2022 12:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A45EC40942
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i7a1tQy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Czblhf_vqFFC; Wed, 27 Jul 2022 12:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A2904408D3;
	Wed, 27 Jul 2022 12:24:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2904408D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 718F3C0033;
	Wed, 27 Jul 2022 12:24:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38D2EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F007408ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F007408ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rdOlhhsHo04N
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:24:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01866408D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01866408D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658924665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dapYisiCBXlgZkwMi+Hyveg1G9f8dLox6yKCT12ZMlw=;
 b=i7a1tQy/3alEra/5NDgbi/JF1nt6QgHJKmeMbxH1qm0cCVxSX9/nPffTP3Y1FZvAXIlN4c
 Y09InLtxv0rYyYCQ8sHYIB99OkzizV8biR6x8nZR696nlGciOCzxVA8HR05f5y+f7YbQZH
 Wg8rOheOipWKFz1WnsN7uNwpNoOcVzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-NknvHWvuPSO3BYxBquCBrg-1; Wed, 27 Jul 2022 08:24:24 -0400
X-MC-Unique: NknvHWvuPSO3BYxBquCBrg-1
Received: by mail-wm1-f71.google.com with SMTP id
 z20-20020a1c4c14000000b003a3020da654so484185wmf.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 05:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dapYisiCBXlgZkwMi+Hyveg1G9f8dLox6yKCT12ZMlw=;
 b=YH9tfn7hXwvoL9BMjITUz+kaGeIsckC2jUcnm0aICWs93d/Rf479BROfKEg/N0abSC
 lgd1IT21eHcCvTT6T7bQX7hYgQuTNf1q3+9lyXvndGrpf3b5SDLERfdAl8a6VGTKZE85
 fdnDJg5h78HgkjsIBPyZ4KCN/Zhc+1OkiNfk2rwyHdsRu0CSJchmW8+PSfrDq5sQK7Mj
 dFnnpiSmKOEC5utd2uUA/6koHS5uUK0jswJHi+ex3etbo6uGOO6FwJEn1reF8sQs6dMs
 GYYQ3IpnT9NHkfGquogPy2Z+x/SIBYY9pRu+1llaTQv4I5NLlp2xj6HYEt06nn3qK3A0
 Cb/A==
X-Gm-Message-State: AJIora8NjktxyO3nazKP62+tLfP36GKDXx25zKD43uCTWRuNTlFD//RM
 Z138dHt8bG7/0sW1h8Tw2ItHP8nQhhbSke5hDc3IMfKV781W/HPbbTIMprSFWhaV/NrvAwLpTUW
 NiH6Uh8WX5BOKgK8c9SOrWMD4m+FX5pQCC+HsHvklGg==
X-Received: by 2002:a05:6000:1541:b0:21d:b298:96be with SMTP id
 1-20020a056000154100b0021db29896bemr13644426wry.206.1658924663475; 
 Wed, 27 Jul 2022 05:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vC2MGRjFi3qSHZ2fm0BkjEDxRi6ABSiXhvcdsFTw4lBpGNZw6+Ua7w1AgH+IiVMbwoDfqM2g==
X-Received: by 2002:a05:6000:1541:b0:21d:b298:96be with SMTP id
 1-20020a056000154100b0021db29896bemr13644403wry.206.1658924663274; 
 Wed, 27 Jul 2022 05:24:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 bg26-20020a05600c3c9a00b003a3279b9037sm2308365wmb.16.2022.07.27.05.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 05:24:22 -0700 (PDT)
Date: Wed, 27 Jul 2022 14:24:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 5/9] vsock: SO_RCVLOWAT transport set callback
Message-ID: <20220727122417.jvdfjnuybk3mwxkq@sgarzare-redhat>
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
 <8baa2e3a-af6b-c0fe-9bfb-7cf89506474a@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <8baa2e3a-af6b-c0fe-9bfb-7cf89506474a@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Jul 25, 2022 at 08:05:28AM +0000, Arseniy Krasnov wrote:
>This adds transport specific callback for SO_RCVLOWAT, because in some
>transports it may be difficult to know current available number of bytes
>ready to read. Thus, when SO_RCVLOWAT is set, transport may reject it.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 19 +++++++++++++++++++
> 2 files changed, 20 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index f742e50207fb..eae5874bae35 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -134,6 +134,7 @@ struct vsock_transport {
> 	u64 (*stream_rcvhiwat)(struct vsock_sock *);
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>+	int (*set_rcvlowat)(struct vsock_sock *, int);
>
> 	/* SEQ_PACKET. */
> 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 63a13fa2686a..b7a286db4af1 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2130,6 +2130,24 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int vsock_set_rcvlowat(struct sock *sk, int val)
>+{
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	int err = 0;
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;

`transport` can be NULL if the user call SO_RCVLOWAT before we assign 
it, so we should check it.

I think if the transport implements `set_rcvlowat`, maybe we should set 
there sk->sk_rcvlowat, so I would do something like that:

     if (transport && transport->set_rcvlowat)
         err = transport->set_rcvlowat(vsk, val);
     else
         WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);

     return err;

In addition I think we should check that val does not exceed 
vsk->buffer_size, something similar of what tcp_set_rcvlowat() does.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
