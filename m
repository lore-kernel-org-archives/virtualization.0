Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A460BC48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 13:50:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F317613EC
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 13:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F317613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1890860688;
	Fri, 18 Jun 2021 13:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 640jobZUrG29; Fri, 18 Jun 2021 13:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B15B060AD0;
	Fri, 18 Jun 2021 13:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 816B7C000D;
	Fri, 18 Jun 2021 13:49:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADD34C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8535183673
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JCRFU4ExRxfM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:49:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A93CA83508
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624024194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6HoUIMXGDRyxX15B0OSH99zC37qr5ecUlX8BEKoHItE=;
 b=iHjXmatj1Y2LMIxRCwnCI3KuYPrejDjAJ3vz9gNI2NVNlDMeb7P/XGb98sAnD028FO8GKp
 IM8KnKIkaB4DBpE1liFcwH//c8KG30AyZ8+BRZNMAW+kQCEie2UGGdCiZoG0hSQsfohGFp
 /A8UNy4FebMLOuDOo+JhgOFEmTv0O58=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-UG7k4plCMnG_6FXboY7lzg-1; Fri, 18 Jun 2021 09:49:53 -0400
X-MC-Unique: UG7k4plCMnG_6FXboY7lzg-1
Received: by mail-wm1-f71.google.com with SMTP id
 i82-20020a1c22550000b02901d64e84b3c9so2204259wmi.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 06:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6HoUIMXGDRyxX15B0OSH99zC37qr5ecUlX8BEKoHItE=;
 b=Mjxau71itumiMy6M+sBAn6CW6g3IVxakYUVU05ICSYgX8rlNP8ciszTD8yOYaN90an
 Kn0ZxkluAEEKNOzegYKZ8WNvox42z3Iiw/c6gqPPSXhdSc8kDywj3utvk8Z1cGAhSkcj
 5SrM2dwXNUF9NTD12w0VtDeInlr/6SatPCrwAy85Gx1a061130FUUFhluG4dl8gZmxle
 POa+Yoi8I3fpS7MIzVFf4WgYHVPo8Bxb38yQNFxcBsymdZaA3ODCwj1AAJeO8eYebEB8
 i+xF97lmnIMQywcvvKxWZNzfKCi4kS8NU2jtKZcmgASHtbQvL+hLWNSssJBph8rBURc6
 oYQg==
X-Gm-Message-State: AOAM5338zBGekbhCJ5tVokzBOaZGDtRkZHgGhFtVbszNQIBmGTwHEiPc
 Kic5sjLKomjYXDDMzKUK87ESltqNOkXkTSbKymI7eT/bRwXd1xQ9yp3P6Hlltfb73FDAJVWJLTe
 9SRfkDycMoNbFTdOGP/9FV9NpEwTQb6Zbti1ylChQag==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr11631726wmj.59.1624024191916; 
 Fri, 18 Jun 2021 06:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0yMkDjr+tukARGep0TvBKEJk88iUPh4P+McQ1eT/TSNVb46YaflNZmxNuwGdGDQ4lDKQjQg==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr11631713wmj.59.1624024191719; 
 Fri, 18 Jun 2021 06:49:51 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
 by smtp.gmail.com with ESMTPSA id r6sm8645754wrt.21.2021.06.18.06.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 06:49:48 -0700 (PDT)
Date: Fri, 18 Jun 2021 09:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH v11 00/18] virtio/vsock: introduce SOCK_SEQPACKET support
Message-ID: <20210618094746-mutt-send-email-mst@kernel.org>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <162344521373.30951.11000282953901961373.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
In-Reply-To: <162344521373.30951.11000282953901961373.git-patchwork-notify@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andraprs@amazon.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, nslusarek@gmx.net, stefanha@redhat.com,
 colin.king@canonical.com, kuba@kernel.org,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, davem@davemloft.net
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

On Fri, Jun 11, 2021 at 09:00:13PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (refs/heads/master):
> 
> On Fri, 11 Jun 2021 14:07:40 +0300 you wrote:
> > This patchset implements support of SOCK_SEQPACKET for virtio
> > transport.
> > 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
> > do it, new bit for field 'flags' was added: SEQ_EOR. This bit is
> > set to 1 in last RW packet of message.
> > 	Now as  packets of one socket are not reordered neither on vsock
> > nor on vhost transport layers, such bit allows to restore original
> > message on receiver's side. If user's buffer is smaller than message
> > length, when all out of size data is dropped.
> > 	Maximum length of datagram is limited by 'peer_buf_alloc' value.
> > 	Implementation also supports 'MSG_TRUNC' flags.
> > 	Tests also implemented.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v11,01/18] af_vsock: update functions for connectible socket
>     https://git.kernel.org/netdev/net-next/c/a9e29e5511b9
>   - [v11,02/18] af_vsock: separate wait data loop
>     https://git.kernel.org/netdev/net-next/c/b3f7fd54881b
>   - [v11,03/18] af_vsock: separate receive data loop
>     https://git.kernel.org/netdev/net-next/c/19c1b90e1979
>   - [v11,04/18] af_vsock: implement SEQPACKET receive loop
>     https://git.kernel.org/netdev/net-next/c/9942c192b256
>   - [v11,05/18] af_vsock: implement send logic for SEQPACKET
>     https://git.kernel.org/netdev/net-next/c/fbe70c480796
>   - [v11,06/18] af_vsock: rest of SEQPACKET support
>     https://git.kernel.org/netdev/net-next/c/0798e78b102b
>   - [v11,07/18] af_vsock: update comments for stream sockets
>     https://git.kernel.org/netdev/net-next/c/8cb48554ad82
>   - [v11,08/18] virtio/vsock: set packet's type in virtio_transport_send_pkt_info()
>     https://git.kernel.org/netdev/net-next/c/b93f8877c1f2
>   - [v11,09/18] virtio/vsock: simplify credit update function API
>     https://git.kernel.org/netdev/net-next/c/c10844c59799
>   - [v11,10/18] virtio/vsock: defines and constants for SEQPACKET
>     https://git.kernel.org/netdev/net-next/c/f07b2a5b04d4
>   - [v11,11/18] virtio/vsock: dequeue callback for SOCK_SEQPACKET
>     https://git.kernel.org/netdev/net-next/c/44931195a541
>   - [v11,12/18] virtio/vsock: add SEQPACKET receive logic
>     https://git.kernel.org/netdev/net-next/c/e4b1ef152f53
>   - [v11,13/18] virtio/vsock: rest of SOCK_SEQPACKET support
>     https://git.kernel.org/netdev/net-next/c/9ac841f5e9f2
>   - [v11,14/18] virtio/vsock: enable SEQPACKET for transport
>     https://git.kernel.org/netdev/net-next/c/53efbba12cc7
>   - [v11,15/18] vhost/vsock: support SEQPACKET for transport
>     https://git.kernel.org/netdev/net-next/c/ced7b713711f
>   - [v11,16/18] vsock/loopback: enable SEQPACKET for transport
>     https://git.kernel.org/netdev/net-next/c/6e90a57795aa
>   - [v11,17/18] vsock_test: add SOCK_SEQPACKET tests
>     https://git.kernel.org/netdev/net-next/c/41b792d7a86d
>   - [v11,18/18] virtio/vsock: update trace event for SEQPACKET
>     https://git.kernel.org/netdev/net-next/c/184039eefeae

Hmm so the virtio part was merged before the spec is ready.
What's the plan now?


> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
