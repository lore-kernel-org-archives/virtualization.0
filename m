Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A37AC76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 302E681EF1;
	Tue, 28 Mar 2023 09:39:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 302E681EF1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dQWCN6ke
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ktTuXqX3PjC; Tue, 28 Mar 2023 09:39:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B7D9C8223D;
	Tue, 28 Mar 2023 09:39:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7D9C8223D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ABBCC0037;
	Tue, 28 Mar 2023 09:39:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB456C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A7FC8223D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:39:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A7FC8223D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0PBRhWpR7Kz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:39:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1E6981EF1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1E6981EF1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679996386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwPWb91WcUx6K1IICpQUovViuiJcsfmj59FF6gVXRXI=;
 b=dQWCN6kehmGtyxxPWhmSmSRrTp4spnWV50NLFwOjV3iOMB9M6RFCQX4iL+1JngntofE50c
 uTezKMIM8Uih7tQeIgot+ZSMudAL5Y4nnj0lqZwm72PoE1Kn21hCpuSU8xOdJf/krR6iYy
 5jZV9MMLORvzapXr/NvcB+MJMO+GPvk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-2vO6Ke75PyCRiwwHDT6JQw-1; Tue, 28 Mar 2023 05:39:41 -0400
X-MC-Unique: 2vO6Ke75PyCRiwwHDT6JQw-1
Received: by mail-qk1-f200.google.com with SMTP id
 r70-20020a374449000000b00746c31401f0so5291526qka.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679996381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwPWb91WcUx6K1IICpQUovViuiJcsfmj59FF6gVXRXI=;
 b=OGMa6QJPW/+YpaFjQnUtNlV4BD91Nz+fOk/B4kox1jIAq3ZGW3ZMROVMfSJ/4IxLa3
 xzyVdpWBrg4w74jcylcN6sb2+wna364vUZIAD13rZkT1Km0CQbZrTskwo+JDvWcHzmbg
 ReQ/AUQYz9tDPW/+Udak1jUGLVWSZRLIUVojH+lVMk8XOJb/Q+B2bl7b/EKsjlDuTgNJ
 zRJm9X4DABtePEZY2DKO9HAU3woyf2ph8HgJknJB8DSjBTY1ecMSGhcpDOFTfgA/wpHt
 4mPlyBbEVUnnDBYqpy6vx7jWA1RPbcZf8fuvfK7JeQnuLCwTG7S6qwxwHZ+d0uUaucrC
 WQJg==
X-Gm-Message-State: AAQBX9dCQBMltgZERQfyc8aGCjxy2lEduWmbrGh3E8b3VOkkwtAqcEi7
 YfmLDldqj0O6XjUjl3zN+jhYsrlXNIrjJJK5JUxoPh+uFugY4pe3Dg7ZITihtHt0EdSoUXCavhK
 cTUaDa7g0PDB4ZxEV650cmW05b0YQDrL+uoxqd1Udfw==
X-Received: by 2002:a05:6214:518b:b0:5bb:eefc:1623 with SMTP id
 kl11-20020a056214518b00b005bbeefc1623mr21401855qvb.42.1679996381322; 
 Tue, 28 Mar 2023 02:39:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZvqOhRxjuWkb/qDRFEYG95lVTMqkyN1lH2NCL72/Gi430kGp8+0vpnXNL4RhABqLUioJi5lA==
X-Received: by 2002:a05:6214:518b:b0:5bb:eefc:1623 with SMTP id
 kl11-20020a056214518b00b005bbeefc1623mr21401832qvb.42.1679996381014; 
 Tue, 28 Mar 2023 02:39:41 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 pe6-20020a056214494600b005dd8b9345a4sm3590288qvb.60.2023.03.28.02.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 02:39:40 -0700 (PDT)
Date: Tue, 28 Mar 2023 11:39:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/2] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <itjmw7vh3a7ggbodsu4mksu2hqbpdpxmu6cpexbra66nfhsw4x@hzpuzwldkfx5>
References: <97f19214-ba04-c47e-7486-72e8aa16c690@sberdevices.ru>
 <99da938b-3e67-150c-2f74-41d917a95950@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <99da938b-3e67-150c-2f74-41d917a95950@sberdevices.ru>
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

On Sun, Mar 26, 2023 at 01:13:11AM +0300, Arseniy Krasnov wrote:
>This removes behaviour, where error code returned from any transport
>was always switched to ENOMEM. This works in the same way as:
>commit
>c43170b7e157 ("vsock: return errors other than -ENOMEM to socket"),
>but for receive calls.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 19aea7cba26e..9262e0b77d47 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2007,7 +2007,7 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>
> 		read = transport->stream_dequeue(vsk, msg, len - copied, flags);

In vmci_transport_stream_dequeue() vmci_qpair_peekv() and
vmci_qpair_dequev() return VMCI_ERROR_* in case of errors.

Maybe we should return -ENOMEM in vmci_transport_stream_dequeue() if
those functions fail to keep the same behavior.

CCing Bryan, Vishnu, and pv-drivers@vmware.com

The other transports seem okay to me.

Thanks,
Stefano

> 		if (read < 0) {
>-			err = -ENOMEM;
>+			err = read;
> 			break;
> 		}
>
>@@ -2058,7 +2058,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	msg_len = transport->seqpacket_dequeue(vsk, msg, flags);
>
> 	if (msg_len < 0) {
>-		err = -ENOMEM;
>+		err = msg_len;
> 		goto out;
> 	}
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
