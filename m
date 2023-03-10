Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAB6C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2634F418C4;
	Fri, 10 Mar 2023 09:05:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2634F418C4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KoIn6R1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bfs35kW2s56O; Fri, 10 Mar 2023 09:05:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6840A415B9;
	Fri, 10 Mar 2023 09:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6840A415B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4197CC0071;
	Fri, 10 Mar 2023 09:05:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 466EBC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20F9260F58
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:05:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20F9260F58
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KoIn6R1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B12ep5E_JsL3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:05:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 619F160B98
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 619F160B98
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678439110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSp+VIKj40Odq1TE8zG+B/+GmimzIKfK2Y2IeLufmS4=;
 b=KoIn6R1BBJkKZCja8Cwx6C8p+//Gy3+VCW3nv5+E5uLToQ6261iKXOdBnqw3Ao1VAEFdJ9
 /iq+kI+kjMWtMG7tb6KFeFpoEdLgm10YG1+LBRedL4odhoJLuLB4lyN3+DwuDRF5oQ0aoV
 L8i7DA/mjOaT9tFRV0fiLWsJQsk+qhE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-nyy_JJo2MuaUMW-vmQR3ZA-1; Fri, 10 Mar 2023 04:05:08 -0500
X-MC-Unique: nyy_JJo2MuaUMW-vmQR3ZA-1
Received: by mail-wr1-f72.google.com with SMTP id
 o3-20020a5d6483000000b002cc4fe0f7fcso906540wri.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678439107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSp+VIKj40Odq1TE8zG+B/+GmimzIKfK2Y2IeLufmS4=;
 b=nHD42Rbw7B5jmXBQy3M1JF+kE8b/P55yCRndBQ5RQyIvAbeEReYtKoI6aRtpgbCGGG
 ZIgkoAKKuRQEUp7OZMWL8G4m1B6RYMDe9X5sNL0sSLFagg64zisgnsdFE5q5NN4mYvaK
 ckW/uqXn2fs3qHElqsHoYr9YWeTQ0TNwvPJBcIKvqzoe7qqCS7lMSuGHP2whR5K5SXZJ
 4BpD1fXfR2Ky2eQAIkjFm5ceOAP9rcTMOeZ+NMt7R6maACae8NBqu7rmKoEj138t5e0M
 MCw0HCJYKakGdZHfuZXDw3i3cJlIJUI/GFDIRYApZL9GdXt5x95P/BIpICeGSOa7ktk9
 DBRQ==
X-Gm-Message-State: AO0yUKXea0Yq9PfkjvrsVoPDzaYR1niEe0iEQD2yjP+g48SzLKj3Hi92
 //qMhM0CYhGs9SDsz+gT3W8s585uqyN1322TKWjFWCWssv/rqAhJK+BdIYQPwfAe81Vpb2QnLjO
 1QqiO4a2/iOlapgEsVrA0Wd13o+Pu+v8SoVKuJnBpgw==
X-Received: by 2002:adf:dd49:0:b0:2c7:1aaa:750 with SMTP id
 u9-20020adfdd49000000b002c71aaa0750mr15972648wrm.66.1678439107741; 
 Fri, 10 Mar 2023 01:05:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9DduuuLAv+i3q26KYq40a81V24NkG6hIbjnT7zANoOAvamzKFyI9Hk66z6o3kwzE7qfxgfdg==
X-Received: by 2002:adf:dd49:0:b0:2c7:1aaa:750 with SMTP id
 u9-20020adfdd49000000b002c71aaa0750mr15972636wrm.66.1678439107465; 
 Fri, 10 Mar 2023 01:05:07 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 g7-20020a5d5407000000b002c569acab1esm1590111wrv.73.2023.03.10.01.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 01:05:06 -0800 (PST)
Date: Fri, 10 Mar 2023 10:05:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 2/4] virtio/vsock: remove redundant 'skb_pull()'
 call
Message-ID: <20230310090504.joeyn4l65pcd3anh@sgarzare-redhat>
References: <1804d100-1652-d463-8627-da93cb61144e@sberdevices.ru>
 <6260a6cc-bd69-72a6-8aa5-34ff68764287@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <6260a6cc-bd69-72a6-8aa5-34ff68764287@sberdevices.ru>
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

On Thu, Mar 09, 2023 at 11:27:02PM +0300, Arseniy Krasnov wrote:
>Since we now no longer use 'skb->len' to update credit, there is no sense
>to update skbuff state, because it is used only once after dequeue to
>copy data and then will be released.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 1 -
> 1 file changed, 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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
