Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA50C77B60
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FEDB81409;
	Tue, 28 Mar 2023 09:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FEDB81409
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IV3lmgxt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4bnFHXz9DKJ7; Tue, 28 Mar 2023 09:23:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2B1480DCB;
	Tue, 28 Mar 2023 09:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2B1480DCB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86970C0037;
	Tue, 28 Mar 2023 09:23:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 442F9C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BCCE605A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BCCE605A5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IV3lmgxt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sad0JBiDWpwK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EDB960597
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EDB960597
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679995405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FlyvMdw2nhPSREcgm2mQMSn2Bg5EDd8FhpiFHg5I85g=;
 b=IV3lmgxt/dGleSM3rPgG04mWaP241f/ZwanLE1ZVZzPtoIeWQCRn1ognrpmvals1QnVXJB
 RHbOHDKAkznvXy+r9X+miyJrohi6PzmFS105SoURGcASx5UzrbY8hUwN1YQZosQdsidpbw
 Fx+h+x4MglNjMIDezlomaSRebGkNlWg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-fbqfyinVOc2by0axkkDh6Q-1; Tue, 28 Mar 2023 05:23:22 -0400
X-MC-Unique: fbqfyinVOc2by0axkkDh6Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 oo15-20020a056214450f00b005a228adfcefso4804587qvb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679995402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlyvMdw2nhPSREcgm2mQMSn2Bg5EDd8FhpiFHg5I85g=;
 b=PKfMQvV15OM3mliNNmtu9PvWUZCu7y2VHMCoyALSmb/BKNPfIITaOU8p3/pju7vLqq
 X9EZ0E7IAXNJSEg4SjWZxcjOIIS80IFrw+K6Sm4+5IObDybXUmX18Bty1U7RT51IAKPE
 3oyEzciWB0kYrnF0TEAsOfxD7QjDL1LkifWgSPPD6HC9UBJDPynuubbmpsAIIu7QgrWh
 mxcmGDAtni3JHoubtcnbL6scsDW9Wcn/G7N3QxmaDL9DzcWbPbCMLXeb4Q1FK3PvsF4b
 sZ1wHctwbxWJgOcuZBbq14/3zwdDimGVdDM0+I1WF/AaHdIri1A/goAC7NxzhFOPfZLT
 Xznw==
X-Gm-Message-State: AAQBX9cR9fyjQBh46NAq0zEnJ8XpuYTOuKcIx21rE0TJ7U4m2VK3Vvt7
 cdpLL9dSMDnWEkoPNQJBJ2dZJ83OJCOx4TOnE/ZEh/Q/t+7VPF14I6hyz4CLVte86toPO6oVhAv
 mRK6bQMJ3tYfsOXss/KlQ8EeN6AhzTw0P6b1+Z6VQ1A==
X-Received: by 2002:a05:6214:27c6:b0:56e:a9d4:429b with SMTP id
 ge6-20020a05621427c600b0056ea9d4429bmr23339839qvb.1.1679995402136; 
 Tue, 28 Mar 2023 02:23:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yjyndn+8JhX5yEkfDB1ZbfV1IVX73FEzKiCbPGXb88TQ6qGch6AlQQ3iq9fmV5EH8VUrZ2rQ==
X-Received: by 2002:a05:6214:27c6:b0:56e:a9d4:429b with SMTP id
 ge6-20020a05621427c600b0056ea9d4429bmr23339828qvb.1.1679995401919; 
 Tue, 28 Mar 2023 02:23:21 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 l7-20020a0cc207000000b005dd8b9345d0sm3588061qvh.104.2023.03.28.02.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 02:23:21 -0700 (PDT)
Date: Tue, 28 Mar 2023 11:23:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/3] virtio/vsock: fix header length on skb merging
Message-ID: <yi6goqhyxkh4slmje6a37vlrxby2qmzg66wgdzrzgt55wgpvdy@d3b7jucayzxv>
References: <728181e9-6b35-0092-3d01-3d7aff4521b6@sberdevices.ru>
 <b5d31a81-a089-146b-d04f-569710e6b14b@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <b5d31a81-a089-146b-d04f-569710e6b14b@sberdevices.ru>
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

On Sun, Mar 26, 2023 at 01:08:22AM +0300, Arseniy Krasnov wrote:
>This fixes appending newly arrived skbuff to the last skbuff of the
>socket's queue. Problem fires when we are trying to append data to skbuff
>which was already processed in dequeue callback at least once. Dequeue
>callback calls function 'skb_pull()' which changes 'skb->len'. In current
>implementation 'skb->len' is used to update length in header of the last
>skbuff after new data was copied to it. This is bug, because value in
>header is used to calculate 'rx_bytes'/'fwd_cnt' and thus must be not
>be changed during skbuff's lifetime.
>
>Bug starts to fire since:
>
>commit 077706165717
>("virtio/vsock: don't use skbuff state to account credit")
>
>It presents before, but didn't triggered due to a little bit buggy
>implementation of credit calculation logic. So use Fixes tag for it.
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7fc178c3ee07..b9144af71553 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1101,7 +1101,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
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

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
