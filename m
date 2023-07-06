Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7694CEB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EBDF4189D;
	Thu,  6 Jul 2023 16:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EBDF4189D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fcsE7QZo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XR_QTrzRBpL4; Thu,  6 Jul 2023 16:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4991440246;
	Thu,  6 Jul 2023 16:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4991440246
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2528EC0071;
	Thu,  6 Jul 2023 16:56:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93630C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 616B360FFE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 616B360FFE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fcsE7QZo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wrw6HxFfVxyp
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A28A660FAB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A28A660FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQmeZW7JJEADmCiQp/d8Tl0o1s0eDsc5Jt7E9LRdL4I=;
 b=fcsE7QZo9x+yTaQQPHmipdKh0ojrme/f892s7VluJMPC5cdjTm4Pqf8WYgRc8s5AEx9Tr+
 cf7G/HBfj0ixcbNBpwBrL3dmMnLmlDYdz4RNhSHJuTk3kOYmg3738fJgEOheQALgYpMdHn
 YJdxoUQw0SqDwsRUNhNl/ILW0UwnDOo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-eVTBO5ycORiVPhhtK9gDGQ-1; Thu, 06 Jul 2023 12:56:05 -0400
X-MC-Unique: eVTBO5ycORiVPhhtK9gDGQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51e28d316d0so637006a12.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662564; x=1691254564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQmeZW7JJEADmCiQp/d8Tl0o1s0eDsc5Jt7E9LRdL4I=;
 b=AMGiIj+MqEX3DPoa/4VsjYWQzQAmypYUdfchQivWH/k9xH2fQfCAoYRnwDBUcrkANf
 WmnHfZ64eXbOIqHgzfqqzuHtX1MRY9wTJFG/CtTvvV5U3Bc17+VOFTxx4v1j1rb3ffEV
 ESJY5HEw9wDd9ZW9rYZf8JJrNiEZDPELL+gdv/MEbCDyh+F0aDmhdAsUlBTZDV23zKJt
 oQQxCpK5C3r+WceeOapRtnOBx7meXiyVI3PwGH9KXnb0T8HoFwY2cAfjpeZDUx4xjKwJ
 KTFJIxc7Q1uwYNSNoyyiMOjTMTZSx+Haf2C2BSD7eY7Ptah+hXmOkpmo8bJrA3ZmsFSi
 PX+w==
X-Gm-Message-State: ABy/qLandffk3o8XPxCCNkV3QsC3pAuncZCkvKaPNMBv5LEQpoaFcilv
 s9UJRqh+aNHoY2NJl0KjQLnKmrwsYPAC6Q2IeTUnBiXoP2Op9AHLb02AeVjjktCg06LnUI/e97U
 qXHfAYyFLWgldOmO1knh0FsWurXLAaUnMNV+MGCFweg==
X-Received: by 2002:a05:6402:120b:b0:51b:ec86:b49a with SMTP id
 c11-20020a056402120b00b0051bec86b49amr2154475edw.7.1688662564106; 
 Thu, 06 Jul 2023 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxoQPW4oanBsoLFqkOwrRRnKfPaR1KLUxeJaSGG1BqBJPWu7lxGmtL/ElaHswkY3m0t4dqDw==
X-Received: by 2002:a05:6402:120b:b0:51b:ec86:b49a with SMTP id
 c11-20020a056402120b00b0051bec86b49amr2154459edw.7.1688662563919; 
 Thu, 06 Jul 2023 09:56:03 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 w26-20020a056402129a00b0051a1ef536c9sm961703edv.64.2023.07.06.09.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:56:03 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:56:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 12/17] vsock/loopback: support MSG_ZEROCOPY for
 transport
Message-ID: <p2ctmue6xm6v7px7uir2rtav6lvgenakmh45t2hd5qvdxvbeyq@cqmlufisosgx>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-13-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-13-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:42AM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for loopback transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Move 'msgzerocopy_allow' right after seqpacket callbacks.
>  * Don't use prototype for 'vsock_loopback_msgzerocopy_allow()'.
>
> net/vmw_vsock/vsock_loopback.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 5c6360df1f31..048640167411 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -47,6 +47,10 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>
> static struct virtio_transport loopback_transport = {
> 	.transport = {
>@@ -79,6 +83,8 @@ static struct virtio_transport loopback_transport = {
> 		.seqpacket_allow          = vsock_loopback_seqpacket_allow,
> 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>
>+		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
