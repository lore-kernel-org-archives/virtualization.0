Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AABEB64DC
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD406418AE;
	Thu,  6 Jul 2023 16:55:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD406418AE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KE+98sW5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrVsob_Ubeaa; Thu,  6 Jul 2023 16:55:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4268841896;
	Thu,  6 Jul 2023 16:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4268841896
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE72C0071;
	Thu,  6 Jul 2023 16:55:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87B4BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 554324158C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 554324158C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KE+98sW5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVC3D0yzbvGd
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9797140A98
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9797140A98
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78X1P2RbA2naQ6uRnxp6k32HKAIUnBp53PzVIigmGLg=;
 b=KE+98sW5HUo9y6qy3S42o6Q/92kmS0eiW1Ugg3eIuicm1eEMq//f8ZiXeYuM3EGnJOAor2
 mt5HXn6wDxJJgHv7Q6Gncuxe7dHxEQo2qX6+sTgTcP6AKXDJhMFn+CnFZ4kPY2VvpvJg1S
 y218uq3yME4sX3u68ZSw/1tEwr8BliI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-EIhq-akEP_Ku9P7HZmSsQA-1; Thu, 06 Jul 2023 12:55:07 -0400
X-MC-Unique: EIhq-akEP_Ku9P7HZmSsQA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-978a991c3f5so69740966b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662506; x=1691254506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78X1P2RbA2naQ6uRnxp6k32HKAIUnBp53PzVIigmGLg=;
 b=UJxKnA68x9pXLWiav/Uk03c1cyQ+chrX43emA8xpcTABQrwUbYjSCxXW7hQ+yE2zC/
 HE3OluXWcHU34hIsDJP92uzsR+4byP/qSM2g5REE7bkhLBBmO84Rw6Oty1eJgZRqpdAo
 c0JekfKT4QkMtBa88EAKouE7+e9lMCh2ykILdm3+bKYauAiufyBtOZGsFBnT98uRFm6S
 9fSQcJXd09Z1XnG0FV/exeh116U+kAxs/GzqXMJboo8shCiW38i6muSQGMZRGhWQqYCC
 Yiv2Z0N+ifQ+jMjJlOVbO+EGfM9J7z1iq+i29B9ZLgv+hW8qYHdFlzISr5ZHp1N2HrzE
 6ioQ==
X-Gm-Message-State: ABy/qLaOnhDm+Syok//Az85TpWbXrgVMHzUnUCuCo4S4EOWaPuNMaHYo
 PDbAYhwHzeVBfmNZ1uKuBU3xcE0lEC6MZPYNYrAegWG4xPZuZYZzo09iKv1H/EvDti+sQqv3Kcf
 VmF7crD9i6tFhoIcnTmyIP88ZljSrwmmWe6TiENonSQ==
X-Received: by 2002:a17:906:5185:b0:992:a9c3:244f with SMTP id
 y5-20020a170906518500b00992a9c3244fmr1583451ejk.4.1688662506004; 
 Thu, 06 Jul 2023 09:55:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnbcCuNIs/OppuWQYxPKp5Z8HDqdwHBAM1xNlziO52ksP44T7cMIPX6GA9m+5cSy54n0kP6Q==
X-Received: by 2002:a17:906:5185:b0:992:a9c3:244f with SMTP id
 y5-20020a170906518500b00992a9c3244fmr1583447ejk.4.1688662505832; 
 Thu, 06 Jul 2023 09:55:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 hk15-20020a170906c9cf00b00991bba473e1sm1041884ejb.3.2023.07.06.09.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:55:05 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:55:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 08/17] vsock: check for MSG_ZEROCOPY support on send
Message-ID: <xpc5urpiwj5adhqqtiumlnxwnljuv3jtepkzn6owju5quzuojh@m2bbycr6bnnj>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-9-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-9-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Jul 01, 2023 at 09:39:38AM +0300, Arseniy Krasnov wrote:
>This feature totally depends on transport, so if transport doesn't
>support it, return error.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h   | 7 +++++++
> net/vmw_vsock/af_vsock.c | 6 ++++++
> 2 files changed, 13 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 0e7504a42925..ec09edc5f3a0 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -177,6 +177,9 @@ struct vsock_transport {
>
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>+
>+	/* Zero-copy. */
>+	bool (*msgzerocopy_allow)(void);
> };
>
> /**** CORE ****/
>@@ -243,4 +246,8 @@ static inline void __init vsock_bpf_build_proto(void)
> {}
> #endif
>
>+static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
>+{
>+	return t->msgzerocopy_allow && t->msgzerocopy_allow();
>+}
> #endif /* __AF_VSOCK_H__ */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 07803d9fbf6d..033006e1b5ad 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1824,6 +1824,12 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		goto out;
> 	}
>
>+	if (msg->msg_flags & MSG_ZEROCOPY &&
>+	    !vsock_msgzerocopy_allow(transport)) {
>+		err = -EOPNOTSUPP;
>+		goto out;
>+	}
>+
> 	/* Wait for room in the produce queue to enqueue our user's data. */
> 	timeout = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
