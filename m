Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19773C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 16:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD36E40FD1;
	Thu,  9 Mar 2023 16:29:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD36E40FD1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SVqctff7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UpEF0xhPp0K5; Thu,  9 Mar 2023 16:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5DA3D4101B;
	Thu,  9 Mar 2023 16:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DA3D4101B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 335D1C0035;
	Thu,  9 Mar 2023 16:29:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4B3CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F5AC60D65
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:29:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F5AC60D65
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SVqctff7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5edDxXQsenvg
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:29:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5BC5607CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5BC5607CA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678379385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkGMBcAqnKS6JyN4vXTerExSnh7y8GSPNATG4aVOfrc=;
 b=SVqctff7CViQljXIC7K5cunkwoHvw5V+kgvCvSNTCZHEd1HU5aJeQE1Il7P4ZCdJB1bkws
 IElpPKXtAIUkQHu20KuMQYPCgV2zEfiQ1pE0zcRHb3YxJb1087HD8lu1y4R4uZ0Bu8wsXk
 zpwCI7dDZKhISg4iURLRquSyU8HTsVU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-USD6tYB0MwWeVA8S4dVBgA-1; Thu, 09 Mar 2023 11:29:41 -0500
X-MC-Unique: USD6tYB0MwWeVA8S4dVBgA-1
Received: by mail-qv1-f69.google.com with SMTP id
 pv11-20020ad4548b000000b0056e96f4fd64so1452185qvb.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 08:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678379381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkGMBcAqnKS6JyN4vXTerExSnh7y8GSPNATG4aVOfrc=;
 b=A8pdQAC7rDMBdNolQ4htiLnvZGwk8BwowUl384EEfPQdCBSYGzzvc21X9nWV0+Ctoc
 H3K5gWqzWm/zd3XymOJhKs+PM29okAeRe+5HVq4D3EuFny4yVC5ilIlRLWnBq+GBZEUw
 IaQY/2b/BQT4+KXJGfJgQk9UZf9Sh64rTL/QiWdWijsYowouJ2GS1kjHy8ltIqlfb506
 Yg20Vl4GM8KAPXSOApnPDojGeJ9E6YfkjW03pq6XocmReOKSf8Zx3vd2SX4u8xjhfP4P
 Vk8XOjR6+hOR6e5cRTPCg9CoDWhQg0u1blw+ZiE/s7SbwRpBpWfeZYtmT7ZtiPK/P4Oe
 SRsA==
X-Gm-Message-State: AO0yUKUHdbA58qt3F/wwIJOOE0qvfwGkHuZJD2l2Ye/VBNIFZRhnknC/
 IdjuK0KdRiKVWidfaxlxTGQUs2mqUAv3GnIZbKd+JOydNtSz+sGvy5qYjtSkk7U896u6VhbhfeW
 ECimuTQ4ByVNDLKfhNSMScAXHzAIoArjGVo+g45yFPg==
X-Received: by 2002:ac8:5c02:0:b0:3b8:525e:15ec with SMTP id
 i2-20020ac85c02000000b003b8525e15ecmr43003991qti.27.1678379381153; 
 Thu, 09 Mar 2023 08:29:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/wt8PRwAtM1Bf3zAU+80K15G/N3ODjmPX5KS1M+6kzBy453+fWsgrmcpFNeaN7ieLbWU2BRw==
X-Received: by 2002:ac8:5c02:0:b0:3b8:525e:15ec with SMTP id
 i2-20020ac85c02000000b003b8525e15ecmr43003941qti.27.1678379380798; 
 Thu, 09 Mar 2023 08:29:40 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 r13-20020a05622a034d00b0039cc0fbdb61sm14575595qtw.53.2023.03.09.08.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 08:29:40 -0800 (PST)
Date: Thu, 9 Mar 2023 17:29:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 2/4] virtio/vsock: remove redundant 'skb_pull()'
 call
Message-ID: <20230309162935.c76hilqo3s22fysd@sgarzare-redhat>
References: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
 <ea7a542b-8772-e204-6b2b-a60d89614f3b@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <ea7a542b-8772-e204-6b2b-a60d89614f3b@sberdevices.ru>
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

On Thu, Mar 09, 2023 at 01:12:42PM +0300, Arseniy Krasnov wrote:

I would add:

Since we now no longer use `skb->len` to update credit, ...

>There is no sense to update skbuff state, because it is used only once
>after dequeue to copy data and then will be released.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 1 -
> 1 file changed, 1 deletion(-)

The patch LGTM!

Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 618680fd9906..9a411475e201 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -465,7 +465,6 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 					dequeued_len = err;
> 				} else {
> 					user_buf_len -= bytes_to_copy;
>-					skb_pull(skb, bytes_to_copy);
> 				}
>
> 				spin_lock_bh(&vvs->rx_lock);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
