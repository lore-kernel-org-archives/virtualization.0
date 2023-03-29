Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D21C77B61
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 07:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2E7F8228A;
	Wed, 29 Mar 2023 07:16:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2E7F8228A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UmgAySgW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RDLnezRXIMw; Wed, 29 Mar 2023 07:16:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B9E78214E;
	Wed, 29 Mar 2023 07:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B9E78214E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 250D8C0037;
	Wed, 29 Mar 2023 07:16:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9F15C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 07:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 715D08228A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 07:16:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 715D08228A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O7SwCtzLUDe6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 07:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 724488214E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 724488214E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 07:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680074185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FgNqIpETnEwtXon7v3S9aQlVl6/D6olezWGAgum/M94=;
 b=UmgAySgWXbE/22GqjFjAGXcg951QWg0fDA+NE3CPihHInvQ4PEnTvLCzXaaZboJfPR/Zr8
 bsGh0CsRcEb41Jpu/du7ZBMgAoEQyO3HsBUYUWNUF+qyUZN+gvPP3LRFI0Z4EGQEkEUIab
 grIBiANYQV+cOO1zDApKMvu6A6/5Wd0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-5AngV9iqM9mQT5RRRYkRnQ-1; Wed, 29 Mar 2023 03:16:24 -0400
X-MC-Unique: 5AngV9iqM9mQT5RRRYkRnQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 h11-20020a0564020e8b00b004e59d4722a3so20834761eda.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 00:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680074183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgNqIpETnEwtXon7v3S9aQlVl6/D6olezWGAgum/M94=;
 b=c4+KhofrlZ5ItP4fw69GsjmR/7nyDeTgYwBnWxei+4GWAvWW5nXYyctseKojTN1Zsf
 WSy5AHfMzgLtWGxZvxU1zLXt0OJvbCeT/rcfyeDxbyi3b04EdWHam6dcy1uU4qHZuV2p
 WiIIBYzjkrmF3Dj1ShkeAJ8KDeZ0gTK+FJjXAkS0rqF7Q8O7SSR2HlU3L4l17Lji5Oww
 wQHwvtjZvtAxTr4lips9efgE9+AE3hnA6rMKGmWoqe2sXOrEFrc8HTURzTJYV4lbrNkG
 hVzVxdu/7TgNjQeZx6OGWsM8IagHyjIc9x1/z7+fWzxGbpQBzs+v01tYu6KV1Bb63g55
 cZ5w==
X-Gm-Message-State: AAQBX9dCF+KCEMsFFglDsim4znv8mOtp2OrFLyi9YiSu3DZchEmVnW0u
 XmY4WPMniEFwfryAYauK+whDD/tmgcmpyuCgooioSEPNLYcoQ0VD3O+5jR/KkjMtDFkPzA9RcWO
 d7p0t6ydNYNgDBCv5hxhml3fkPM9fAdLzwQG1BHYE9Q==
X-Received: by 2002:a17:906:33d3:b0:908:7fed:f0f with SMTP id
 w19-20020a17090633d300b009087fed0f0fmr18015430eja.42.1680074182859; 
 Wed, 29 Mar 2023 00:16:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXrrArCxeBniSit8qX/4ISh60zS47mWrvlzo8Jgs3svz8qYB58JPbBHkk1wTagNwUK5LAUEQ==
X-Received: by 2002:a17:906:33d3:b0:908:7fed:f0f with SMTP id
 w19-20020a17090633d300b009087fed0f0fmr18015416eja.42.1680074182527; 
 Wed, 29 Mar 2023 00:16:22 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 sc36-20020a1709078a2400b0093e39b921c8sm6666528ejc.164.2023.03.29.00.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 00:16:22 -0700 (PDT)
Date: Wed, 29 Mar 2023 09:16:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net v2] virtio/vsock: fix leaks due to missing skb owner
Message-ID: <teatarzyqlkgbgxjezbm56ilpsbcq3f6nwvwwfi7f6z7agbgoh@jxwm3mgot2w4>
References: <20230327-vsock-fix-leak-v2-1-f6619972dee0@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230327-vsock-fix-leak-v2-1-f6619972dee0@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>,
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

On Tue, Mar 28, 2023 at 04:29:09PM +0000, Bobby Eshleman wrote:
>This patch sets the skb owner in the recv and send path for virtio.
>
>For the send path, this solves the leak caused when
>virtio_transport_purge_skbs() finds skb->sk is always NULL and therefore
>never matches it with the current socket. Setting the owner upon
>allocation fixes this.
>
>For the recv path, this ensures correctness of accounting and also
>correct transfer of ownership in vsock_loopback (when skbs are sent from
>one socket and received by another).
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>Link: https://lore.kernel.org/all/ZCCbATwov4U+GBUv@pop-os.localdomain/
>---
>Changes in v2:
>- virtio/vsock: add skb_set_owner_r to recv_pkt()
>- Link to v1: https://lore.kernel.org/r/20230327-vsock-fix-leak-v1-1-3fede367105f@bytedance.com
>---
> net/vmw_vsock/virtio_transport_common.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 957cdc01c8e8..900e5dca05f5 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -94,6 +94,9 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 					 info->op,
> 					 info->flags);
>
>+	if (info->vsk)
>+		skb_set_owner_w(skb, sk_vsock(info->vsk));
>+
> 	return skb;
>
> out:
>@@ -1294,6 +1297,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		goto free_pkt;
> 	}
>
>+	skb_set_owner_r(skb, sk);
>+
> 	vsk = vsock_sk(sk);
>
> 	lock_sock(sk);

Can you explain why we are using skb_set_owner_w/skb_set_owner_r?

I'm a little concerned about 2 things:
- skb_set_owner_r() documentation says: "Stream and sequenced
   protocols can't normally use this as they need to fit buffers in
   and play with them."
- they increment sk_wmem_alloc and sk_rmem_alloc that we never used
   (IIRC)

For the long run, I think we should manage memory better, and using
socket accounting makes sense to me, but since we now have a different
system (which we have been carrying around since the introduction of
vsock), I think this change is a bit risky, especially as a fix.

So my suggestion is to use skb_set_owner_sk_safe() for now, unless I
missed something about why to use skb_set_owner_w/skb_set_owner_r.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
