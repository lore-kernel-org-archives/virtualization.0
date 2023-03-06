Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A8EC678D4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 12:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB30640910;
	Mon,  6 Mar 2023 12:09:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB30640910
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhufjDOb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nd5B9q63JZ66; Mon,  6 Mar 2023 12:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 15C1040869;
	Mon,  6 Mar 2023 12:09:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15C1040869
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E02BAC0035;
	Mon,  6 Mar 2023 12:09:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1C0C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 12:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9027813C7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 12:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9027813C7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NhufjDOb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Ee8jbGTI5LN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 12:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9011813CD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9011813CD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678104547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TIQWpkWpesX3O84a09lrsGwpESW6OyZggcHe4WwruKk=;
 b=NhufjDObczqBSkPDMsQ2aT7wz/TQD6qewHlG4Tvq9ubk/y2OBeP6xsjoQKKKJ92K1U2V6e
 UwHdJVzZQhCWpY2VDEPMdrkHlnshGqKNEdrjTPcu0Fh60XGsdYSMZD59T/pJk9STlTRYm/
 PQA+7HMtnNnsrw3ValB4DiKpa2PV74I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-TGO9pBe7Nc2fvcIdC2yUdw-1; Mon, 06 Mar 2023 07:09:01 -0500
X-MC-Unique: TGO9pBe7Nc2fvcIdC2yUdw-1
Received: by mail-wm1-f72.google.com with SMTP id
 r7-20020a05600c35c700b003eb3f2c4fb4so3656134wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 04:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678104540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIQWpkWpesX3O84a09lrsGwpESW6OyZggcHe4WwruKk=;
 b=jFScPRRG76h+3/1jitbZFxEg4vSpVvREGg7GMjzUgcTGCKB056q2xhCOFJ51Za1vuG
 OF2hBf56LEJwYZa5a1pAI4VDUlPBfOWT8dsOjE/S31y1/LS7j478VfCG4cV2YA7Jn0CB
 /kAL4j94ZEa0w2t9tPeLwwWQSlKPwW6PncgFzR8TE1eKbrWEVzPzXX1/QNCkTrQyoiV+
 pPssoU/dOX3UkLdZQiOnP0Xh2Ix1YlOYq+9vE5pol3qAihpPiokCC4UZNGOAEGd1Nv4u
 OgrE0WGWGxCWwKSAkRRulVGLwWv8JMEKxVbnBMl39ELJYzvALdf0xZnPqstBhI5DRwDW
 EZaw==
X-Gm-Message-State: AO0yUKUmK+PeH8uelVmV5snfWKD8EhpbTZDV95QumUO183F752WFYnhB
 VQcabTzznxrLdf6/gbYzxqBSqFGfHZZMtjeYiv6J+/cNh0Rd6V41Ya9Lcv/qM91ZIa8rSuurslh
 hofyopbGG7mOuT4rlrmVw1dh7ILtmH/N9w3cPTi48dA==
X-Received: by 2002:a05:6000:10cc:b0:2c7:420:5d52 with SMTP id
 b12-20020a05600010cc00b002c704205d52mr6551205wrx.62.1678104540677; 
 Mon, 06 Mar 2023 04:09:00 -0800 (PST)
X-Google-Smtp-Source: AK7set9mVWEN2OAq/N1LHfsMLygbhdAAUyaT4XAYy96wMKTIdzRA5IDlfgb0poIN+cI9N1MTK/FGlw==
X-Received: by 2002:a05:6000:10cc:b0:2c7:420:5d52 with SMTP id
 b12-20020a05600010cc00b002c704205d52mr6551188wrx.62.1678104540406; 
 Mon, 06 Mar 2023 04:09:00 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4cd2000000b002c551f7d452sm9957713wrt.98.2023.03.06.04.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 04:08:59 -0800 (PST)
Date: Mon, 6 Mar 2023 13:08:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/4] virtio/vsock: remove all data from sk_buff
Message-ID: <20230306120857.6flftb3fftmsceyl@sgarzare-redhat>
References: <a7ab414b-5e41-c7b6-250b-e8401f335859@sberdevices.ru>
 <dfadea17-a91e-105f-c213-a73f9731c8bd@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <dfadea17-a91e-105f-c213-a73f9731c8bd@sberdevices.ru>
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

On Sun, Mar 05, 2023 at 11:07:37PM +0300, Arseniy Krasnov wrote:
>In case of SOCK_SEQPACKET all sk_buffs are used once - after read some
>data from it, it will be removed, so user will never read rest of the
>data. Thus we need to update credit parameters of the socket like whole
>sk_buff is read - so call 'skb_pull()' for the whole buffer.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Maybe we could avoid this patch if we directly use pkt_len as I
suggested in the previous patch.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 2e2a773df5c1..30b0539990ba 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -466,7 +466,6 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 					dequeued_len = err;
> 				} else {
> 					user_buf_len -= bytes_to_copy;
>-					skb_pull(skb, bytes_to_copy);
> 				}
>
> 				spin_lock_bh(&vvs->rx_lock);
>@@ -484,6 +483,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 				msg->msg_flags |= MSG_EOR;
> 		}
>
>+		skb_pull(skb, skb->len);
> 		virtio_transport_dec_rx_pkt(vvs, skb);
> 		kfree_skb(skb);
> 	}
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
