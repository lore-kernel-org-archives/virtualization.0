Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80B6C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 08:03:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F51060EB9
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 08:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F51060EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B0F440736;
	Thu, 12 Aug 2021 08:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZoV6lhWzYvi; Thu, 12 Aug 2021 08:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB1AD40731;
	Thu, 12 Aug 2021 08:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A60C001A;
	Thu, 12 Aug 2021 08:03:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 653E2C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5585660617
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yHxrv4Jxjli2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41E1A606B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628755417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNcc4FKKgeh1x9olC7E03PuQx1nzor6Qv2O5Zs+wmJk=;
 b=Sf6Yikze2SB5zWc7S+RxoPEJejWvB6o+cAOzpKrwXSxN5aGpJr6evPRps168OBX5iSMU/4
 O+D62emJdqBKyer12IieSCYam4iSTsAoDWTPMj8PV92ZFkF8z2pFiS7/LZ/n/yR7vvs7mB
 Kxz56V2Zfipxnawki/74wTxTgCYcCFo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-wzYeTPN_MLmg8tp-F2xxfw-1; Thu, 12 Aug 2021 04:03:36 -0400
X-MC-Unique: wzYeTPN_MLmg8tp-F2xxfw-1
Received: by mail-ej1-f70.google.com with SMTP id
 zp23-20020a17090684f7b02905a13980d522so1501016ejb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 01:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VNcc4FKKgeh1x9olC7E03PuQx1nzor6Qv2O5Zs+wmJk=;
 b=qboU+XAq9WPg/t5+5Q0bo13qDY8VbSC+iOMRZV6RLLvEIeJAfCAKXP5hivyPYM8jNh
 HgSCare8l5UK1A0EW3zF8YJuQ1MafMWMCYZMI5mXdBdybSsMn6Giz+y5ABKyT2iLgD3G
 +1Tls96+pvFL/gyipclZk+SBQuX5GGg/Dkdvwg1GIONkvkm9DqcumrOfwC8UuNCLs8Ux
 VqYB9UAMY/Lumpv2HY1sF93AeskpRDKW6AV8EhQadym9JOzheSMF05auLP+3zP0eNgfk
 vR3s6OoLrNjw6vAuk1ro/oHw0m+NIQxycy9TS9D/DjFCbDQzGdutejH7hGT6tDHjZL6E
 +urw==
X-Gm-Message-State: AOAM531uTfca84qWSuxCMAYTNY7CiOX3ZChsNBlXvMQ9sfrDMeOCJk+V
 JatSmcKy+XAVeN8aal/MsYufBhPKZgwr333cZJLXMFbCXfMY0XtfeqQZMnMlxmFy9fRBp24z/TX
 AzZti0HesF0tmLQKs7RDqM0qJov+qJnS4V2EeRy6N/w==
X-Received: by 2002:a17:906:4750:: with SMTP id
 j16mr2439923ejs.26.1628755414867; 
 Thu, 12 Aug 2021 01:03:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU2tcTx6Y7xB9zzU+HQALuAB5KSTmssapC5dM7OHV8xYFOQBEDoFPmmXvbwzdWXnsrrWl5+w==
X-Received: by 2002:a17:906:4750:: with SMTP id
 j16mr2439913ejs.26.1628755414694; 
 Thu, 12 Aug 2021 01:03:34 -0700 (PDT)
Received: from steredhat (host-79-36-51-142.retail.telecomitalia.it.
 [79.36.51.142])
 by smtp.gmail.com with ESMTPSA id k18sm752908edo.62.2021.08.12.01.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Aug 2021 01:03:34 -0700 (PDT)
Date: Thu, 12 Aug 2021 10:03:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH resend] vsock/virtio: avoid potential deadlock when vsock
 device remove
Message-ID: <20210812080332.o4vxw72gn5uuqtik@steredhat>
References: <20210812053056.1699-1-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20210812053056.1699-1-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Thu, Aug 12, 2021 at 01:30:56PM +0800, Longpeng(Mike) wrote:
>There's a potential deadlock case when remove the vsock device or
>process the RESET event:
>
>  vsock_for_each_connected_socket:
>      spin_lock_bh(&vsock_table_lock) ----------- (1)
>      ...
>          virtio_vsock_reset_sock:
>              lock_sock(sk) --------------------- (2)
>      ...
>      spin_unlock_bh(&vsock_table_lock)
>
>lock_sock() may do initiative schedule when the 'sk' is owned by
>other thread at the same time, we would receivce a warning message
>that "scheduling while atomic".
>
>Even worse, if the next task (selected by the scheduler) try to
>release a 'sk', it need to request vsock_table_lock and the deadlock
>occur, cause the system into softlockup state.
>  Call trace:
>   queued_spin_lock_slowpath
>   vsock_remove_bound
>   vsock_remove_sock
>   virtio_transport_release
>   __vsock_release
>   vsock_release
>   __sock_release
>   sock_close
>   __fput
>   ____fput
>
>So we should not require sk_lock in this case, just like the behavior
>in vhost_vsock or vmci.

The difference with vhost_vsock is that here we call it also when we 
receive an event in the event queue (for example because we are 
migrating the VM).

I think the idea of this lock was to prevent concurrency with RX loop, 
but actually if a socket is connected, it can only change state to 
TCP_CLOSING/TCP_CLOSE.

I don't think there is any problem not to take the lock, at most we 
could take the rx_lock in virtio_vsock_event_handle(), but I'm not sure 
it's necessary.

>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Jakub Kicinski <kuba@kernel.org>

We should add:
Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>---
> net/vmw_vsock/virtio_transport.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e0c2c99..4f7c99d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -357,11 +357,14 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
>
> static void virtio_vsock_reset_sock(struct sock *sk)
> {
>-	lock_sock(sk);
>+	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>+	 * under vsock_table_lock so the sock cannot disappear while 
>we're
>+	 * executing.
>+	 */
>+
> 	sk->sk_state = TCP_CLOSE;
> 	sk->sk_err = ECONNRESET;
> 	sk_error_report(sk);
>-	release_sock(sk);
> }
>
> static void virtio_vsock_update_guest_cid(struct virtio_vsock *vsock)
>-- 
>1.8.3.1
>

With the Fixes tag added:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
