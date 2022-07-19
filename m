Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0B3C43334
	for <virtualization@archiver.kernel.org>; Tue, 19 Jul 2022 12:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EA7D40C41;
	Tue, 19 Jul 2022 12:49:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EA7D40C41
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rq/ifcv1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wlvJtmKGrUIA; Tue, 19 Jul 2022 12:49:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C22C640101;
	Tue, 19 Jul 2022 12:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C22C640101
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99863C0033;
	Tue, 19 Jul 2022 12:49:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75C7FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E01D60AFA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E01D60AFA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rq/ifcv1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wqwR_O-ig5Ps
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:49:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99AAA60ACF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99AAA60ACF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658234948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQ7i8DMmDNLQBzOxesas/9REVBIK8tkfXNsEsnI0ryg=;
 b=Rq/ifcv1AdJVs/VpkGcVe41ohxb3Kbj8iReyWfnJSZyXk68CNlk6LQY42wQ3cYdYWewDaK
 r2V7PzCSg3nUevyy5XJ5e/at/wSys11hGMcwMJiIVrIb9Ia79KTLZrZJG6B2yk9+0XNX90
 vejHKAFqaeVATduPEcXFPQi0Jj/f9iU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-Uwi0H_pMOfun1g70OszN7A-1; Tue, 19 Jul 2022 08:49:07 -0400
X-MC-Unique: Uwi0H_pMOfun1g70OszN7A-1
Received: by mail-qk1-f198.google.com with SMTP id
 j16-20020a05620a411000b006b5fb8e5d95so1984600qko.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 05:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SQ7i8DMmDNLQBzOxesas/9REVBIK8tkfXNsEsnI0ryg=;
 b=5HUGKNqIfWAAK4Mqu8nPNRxFrGK6F1awJu1BbNWpT4IAlTOijLr+71FjyKP7m+RDyu
 ibnqNzg5iCjXCajyqSMHosh8svTtXHpV1A73gYmDCJfPxbshLUvbiBS/DLy5VAyvjF/l
 FsXIs8KnYL+RkTPNxKVqtyDtPBOchUQzFt6HCTumHx+W2U5kovUTtQSWv0Zt9AVxEUM5
 Ts4Y4HAUrWDUo2sH0NiN6H3CqkXBGNsIt3ZwASEjMycfEqmZ1T3Wu4XDuyxzjunAztEY
 alphC9Id4phsvKzoHnCA1L6+Xsznt1HBhY5NFkydHYGYpdWqPX58I35JMvVDC6iG3JG3
 UPDw==
X-Gm-Message-State: AJIora+hPmQt/2HG85BmQE6yJ4cWuuDNNNrf6qm8x0P0fpVopFB30pEl
 LDltEgPf5Jj6I13cvEL6V1svnloc5109zyumVB0U48JAvH7JUnIwb0tkFmBAWcAIbrVUN4WDfZ0
 6tSD4IMzUFlFSajDxKdTgKgkorlEklq+dpUsx5A8imA==
X-Received: by 2002:a05:6214:5285:b0:472:ed70:23a0 with SMTP id
 kj5-20020a056214528500b00472ed7023a0mr24653532qvb.121.1658234946740; 
 Tue, 19 Jul 2022 05:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZuaMPjQgfS6W9/DnlaK0uE0XgUkrEb2ofE1GV4HHuSsM3Xbj6XHQUCZkbhYbWbuoG/U//nQ==
X-Received: by 2002:a05:6214:5285:b0:472:ed70:23a0 with SMTP id
 kj5-20020a056214528500b00472ed7023a0mr24653509qvb.121.1658234946505; 
 Tue, 19 Jul 2022 05:49:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 dm53-20020a05620a1d7500b006b4880b08a9sm14522441qkb.88.2022.07.19.05.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 05:49:05 -0700 (PDT)
Date: Tue, 19 Jul 2022 14:48:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/3] virtio/vsock: use 'target' in notify_poll_in, 
 callback.
Message-ID: <20220719124857.akv25sgp6np3pdaw@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <358f8d52-fd88-ad2e-87e2-c64bfa516a58@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <358f8d52-fd88-ad2e-87e2-c64bfa516a58@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
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

On Mon, Jul 18, 2022 at 08:17:31AM +0000, Arseniy Krasnov wrote:
>This callback controls setting of POLLIN,POLLRDNORM output bits
>of poll() syscall,but in some cases,it is incorrectly to set it,
>when socket has at least 1 bytes of available data. Use 'target'
>which is already exists and equal to sk_rcvlowat in this case.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ec2c2afbf0d0..591908740992 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -634,7 +634,7 @@ virtio_transport_notify_poll_in(struct vsock_sock *vsk,
> 				size_t target,
> 				bool *data_ready_now)
> {
>-	if (vsock_stream_has_data(vsk))
>+	if (vsock_stream_has_data(vsk) >= target)
> 		*data_ready_now = true;
> 	else
> 		*data_ready_now = false;

Perhaps we can take the opportunity to clean up the code in this way:

	*data_ready_now = vsock_stream_has_data(vsk) >= target;

Anyway, I think we also need to fix the other transports (vmci and 
hyperv), what do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
