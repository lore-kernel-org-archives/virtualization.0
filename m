Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF51C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A23840931;
	Mon,  8 Aug 2022 10:46:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A23840931
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KrjVqRuv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xoPDGrlXNDDI; Mon,  8 Aug 2022 10:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE6A1402E5;
	Mon,  8 Aug 2022 10:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE6A1402E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53807C0033;
	Mon,  8 Aug 2022 10:46:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B7A0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FD3B40535
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:46:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FD3B40535
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j5ENfdjU3CFo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:46:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6644E402E5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6644E402E5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659955604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8aV2W61ptlHUyh4odksNrh50/vrECqQvfXa6ytqlWXY=;
 b=KrjVqRuvCpQttwawi+hKrlurL1o9Iw0FvKQkrIWEm0nErpUswvO0AKviA4OlMWDG7A3foW
 xZwJpBE8We45gUh6mkujbbQYetylp7Cvgp0gsD+zk9jofK3iT7sFbpTICuAt+ZUGqtBSNF
 vjHCIvTo4+p0spNHA9uO77OI6UA02+g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-CvoGLuf5OkuZrQ_Gz8mqtA-1; Mon, 08 Aug 2022 06:46:41 -0400
X-MC-Unique: CvoGLuf5OkuZrQ_Gz8mqtA-1
Received: by mail-qt1-f198.google.com with SMTP id
 a8-20020a05622a064800b00342240a9fccso6496880qtb.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 03:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=8aV2W61ptlHUyh4odksNrh50/vrECqQvfXa6ytqlWXY=;
 b=Xb4Pr4gt2O58Ao013/ZsUxT7CsIHiDopoEW/onwhvjXJTU10URpn6tqtrGIA/FZFbt
 hcUyFfrcvj3ZARWDffhfo9LA1QPZfUFv/7yFC9+g6KHzOPPaLoddN7yurhExwE/tm6tT
 b/KYacH6/gZcQVQvdRgqjJeuVo3lhVVyAqyebaRnMNMMLwCf7+sd7+DAWVuO4LfBHnTi
 0zrQg6vuWLxIkqvqklk+ufPL9AlUzRG6P5C6+5N5TKxnDNgQEVVwKEVtuMj2790NrMQa
 5rcqAWtHf9TPNC+OQahrVpuG7wbG668A7Ar0qyHWZ20FJF/FSyXYiHoK5JX0PoNplIw6
 r9oQ==
X-Gm-Message-State: ACgBeo21Nz1E3BqTpOrn8Wz41K+fU3pn4cQS8/vVP/wLt+30cv32tGS6
 rNE8fCRYLzK6bVHCfvX84KPbCS0O0Lf7bCVKr84SKZOLbm59ZEzMny14h6tkY3Q82d28i7/UcHA
 J8XC850CcTOH3bFm843+HAvMp9/wXTjUKh4fiokNDhw==
X-Received: by 2002:ac8:4e91:0:b0:31f:cfa:7669 with SMTP id
 17-20020ac84e91000000b0031f0cfa7669mr15805106qtp.264.1659955600803; 
 Mon, 08 Aug 2022 03:46:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6O+E8CH3X3PXsBGLWziRU/6izl1vexs+Npwjuu6wEzotpwy9Rb1dRKWU2PkvvJTl48EVICSg==
X-Received: by 2002:ac8:4e91:0:b0:31f:cfa:7669 with SMTP id
 17-20020ac84e91000000b0031f0cfa7669mr15805084qtp.264.1659955600582; 
 Mon, 08 Aug 2022 03:46:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 h126-20020a375384000000b006b5cb0c512asm8719392qkb.101.2022.08.08.03.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 03:46:39 -0700 (PDT)
Date: Mon, 8 Aug 2022 12:46:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 5/9] vsock: pass sock_rcvlowat to notify_poll_in
 as target
Message-ID: <20220808104630.dvprekauh5pi7zx3@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <5e343101-8172-d0fa-286f-5de422c6db0b@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <5e343101-8172-d0fa-286f-5de422c6db0b@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
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

On Wed, Aug 03, 2022 at 01:59:49PM +0000, Arseniy Krasnov wrote:
>This callback controls setting of POLLIN,POLLRDNORM output bits of poll()
>syscall,but in some cases,it is incorrectly to set it, when socket has
>at least 1 bytes of available data.

I suggest you refrase the description a bit, which should describe what 
was the problem and what the patch does, so I was thinking something 
like this:

   Passing 1 as the target to notify_poll_in(), we don't honor
   what the user has set via SO_RCVLOWAT, going to set POLLIN
   and POLLRDNORM, even if we don't have the amount of bytes
   expected by the user.

   Let's use sock_rcvlowat() to get the right target to pass to
   notify_poll_in().

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 016ad5ff78b7..3a1426eb8baa 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1066,8 +1066,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		if (transport && transport->stream_is_active(vsk) &&
> 		    !(sk->sk_shutdown & RCV_SHUTDOWN)) {
> 			bool data_ready_now = false;
>+			int target = sock_rcvlowat(sk, 0, INT_MAX);
> 			int ret = transport->notify_poll_in(
>-					vsk, 1, &data_ready_now);
>+					vsk, target, &data_ready_now);
> 			if (ret < 0) {
> 				mask |= EPOLLERR;
> 			} else {
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
