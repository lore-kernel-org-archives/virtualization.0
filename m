Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BC4C25B0C
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C8F8813A1;
	Mon,  8 Aug 2022 10:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C8F8813A1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZycgCR8h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NDyEi2PZ3-cB; Mon,  8 Aug 2022 10:23:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 762818137C;
	Mon,  8 Aug 2022 10:23:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 762818137C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B990C0033;
	Mon,  8 Aug 2022 10:23:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF936C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C92E960E0D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:23:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C92E960E0D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZycgCR8h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ECkV8pONPtKM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:23:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8E8C60C22
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8E8C60C22
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659954227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZ+7qMtAooG6dh841vB4xXZOc4YcIi/wWT2HlYib+T4=;
 b=ZycgCR8hdsG9QNG4pRzDFFbZxv5bk4c6N2WUcWNTueflOhRu38XAEz20HHIZbuguLIKidB
 gziOahRPbop4bXKkM8ords/mp9zTRMG5K0dVUif/ZKKWJ9fIFqANumlWzseL/eW0BDefeE
 0W7ALKQe2UQ7bi4q0Q2QNpBysl7u6l0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-Tg3bMyd4PmqBR1gx1RxHUg-1; Mon, 08 Aug 2022 06:23:46 -0400
X-MC-Unique: Tg3bMyd4PmqBR1gx1RxHUg-1
Received: by mail-qt1-f198.google.com with SMTP id
 h13-20020ac87d4d000000b00342f6c363afso2430156qtb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 03:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=CZ+7qMtAooG6dh841vB4xXZOc4YcIi/wWT2HlYib+T4=;
 b=WUekfdVrpwVaJ8lcA2NY1dfSMIypk4/y6DMz7GDYJ0lfGhmozoJZXqOwri9pOdTml6
 6Rpr6ofxrDzytqBlAOGIhWL9P64GWvfjax7SGu5laEsjgxGURL9Tw6dSILkTWZGGxMgV
 bgXrJ+eyb5t+0wcP4160WP9l2M8umlq+He7mNfpgt4ng6PJfusKyPQu6yDt9DSbbpxAx
 qq+7YhVd/vSi4O8Upf5yJCDsHTGNn9LPg0MmhQW03X9VoqQVbW5zFU/HmcNvjvORPLzV
 UqZX4XGtl3qlRtn+wO8ZjuKIflYzrDtWiL68ydKII9uC3kBXO+Mvabv4dJh3UTi4wDsp
 Mdhw==
X-Gm-Message-State: ACgBeo2wmfCw2/FWEbf8151wZUun0p1j/IzUzJsVifkjaaFI/p/TQd5N
 znYh6+gdoJvD57DmlyoxTnTBpPd1NqBJOACMOzKFhTpkYkPKbnpzO9ntc4kvGiiOE5f3GVvGirh
 P/vhDJPLxxgzCqlGruzqineb6DwNSLcthMdZ6T1B/QA==
X-Received: by 2002:ac8:7d4e:0:b0:31f:33db:69bc with SMTP id
 h14-20020ac87d4e000000b0031f33db69bcmr15622436qtb.482.1659954226107; 
 Mon, 08 Aug 2022 03:23:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6JBzf5xAfbbDtzMbPLn2U0H6BGM6n6lSlv4ISjtq6rY6A09Oo3blf5b3eQhOOQ/S3L7JLDWA==
X-Received: by 2002:ac8:7d4e:0:b0:31f:33db:69bc with SMTP id
 h14-20020ac87d4e000000b0031f33db69bcmr15622424qtb.482.1659954225867; 
 Mon, 08 Aug 2022 03:23:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 k5-20020a05620a414500b006b93ef659c3sm4308518qko.39.2022.08.08.03.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 03:23:44 -0700 (PDT)
Date: Mon, 8 Aug 2022 12:23:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 1/9] vsock: SO_RCVLOWAT transport set callback
Message-ID: <20220808102335.nkviqobpgcmcaqhn@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <45822644-8e37-1625-5944-63fd5fc20dd3@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <45822644-8e37-1625-5944-63fd5fc20dd3@sberdevices.ru>
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

On Wed, Aug 03, 2022 at 01:51:05PM +0000, Arseniy Krasnov wrote:
>This adds transport specific callback for SO_RCVLOWAT, because in some
>transports it may be difficult to know current available number of bytes
>ready to read. Thus, when SO_RCVLOWAT is set, transport may reject it.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 25 +++++++++++++++++++++++++
> 2 files changed, 26 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index f742e50207fb..eae5874bae35 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -134,6 +134,7 @@ struct vsock_transport {
> 	u64 (*stream_rcvhiwat)(struct vsock_sock *);
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>+	int (*set_rcvlowat)(struct vsock_sock *, int);

checkpatch suggests to add identifier names. For some we put them in, 
for others we didn't, but I suggest putting them in for the new ones 
because I think it's clearer too.

WARNING: function definition argument 'struct vsock_sock *' should also 
have an identifier name
#25: FILE: include/net/af_vsock.h:137:
+	int (*set_rcvlowat)(struct vsock_sock *, int);

WARNING: function definition argument 'int' should also have an identifier name
#25: FILE: include/net/af_vsock.h:137:
+	int (*set_rcvlowat)(struct vsock_sock *, int);

total: 0 errors, 2 warnings, 0 checks, 44 lines checked

>
> 	/* SEQ_PACKET. */
> 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..016ad5ff78b7 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2129,6 +2129,30 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int vsock_set_rcvlowat(struct sock *sk, int val)
>+{
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	int err = 0;
>+
>+	vsk = vsock_sk(sk);
>+
>+	if (val > vsk->buffer_size)
>+		return -EINVAL;
>+
>+	transport = vsk->transport;
>+
>+	if (!transport)
>+		return -EOPNOTSUPP;

I don't know whether it is better in this case to write it in 
sk->sk_rcvlowat, maybe we can return EOPNOTSUPP only when the trasport 
is assigned and set_rcvlowat is not defined. This is because usually the 
options are set just after creation, when the transport is practically 
unassigned.

I mean something like this:

         if (transport) {
                 if (transport->set_rcvlowat)
                         return transport->set_rcvlowat(vsk, val);
                 else
                         return -EOPNOTSUPP;
         }

         WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);

         return 0;

>+
>+	if (transport->set_rcvlowat)
>+		err = transport->set_rcvlowat(vsk, val);
>+	else
>+		WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
>+
>+	return err;
>+}
>+
> static const struct proto_ops vsock_stream_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -2148,6 +2172,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.recvmsg = vsock_connectible_recvmsg,
> 	.mmap = sock_no_mmap,
> 	.sendpage = sock_no_sendpage,
>+	.set_rcvlowat = vsock_set_rcvlowat,
> };
>
> static const struct proto_ops vsock_seqpacket_ops = {
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
