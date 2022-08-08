Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C23C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61D4140931;
	Mon,  8 Aug 2022 10:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61D4140931
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aq79ZUAN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pC4j1AooW8Tq; Mon,  8 Aug 2022 10:36:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BB121402E5;
	Mon,  8 Aug 2022 10:36:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB121402E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BB80C0033;
	Mon,  8 Aug 2022 10:36:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8750C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 800E582978
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 800E582978
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aq79ZUAN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RnAvYKZHSNvh
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:36:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC712827AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC712827AA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659954983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zJ1tVOq7gmtva8bvG4/tC19zWSGUYjLfZNUM1FdlBcA=;
 b=aq79ZUAN4Q/3jZSK73nD1tswjVjkp1gOUzTNxXoDmq1GDy6TNWv1Dj0XZocq3ZnovLw9Ai
 Pdk/2DFZd8i1IC7zeq4ylI7E/nqFBIaSvhEFZqRd7KvQviwAHwb9JcDaKq0hY8tuqULzHf
 bldLYrs1B8qK7Yba+GK7q1XqoxQll50=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Un6-r0wFMSqWyTwo0XBYgA-1; Mon, 08 Aug 2022 06:36:22 -0400
X-MC-Unique: Un6-r0wFMSqWyTwo0XBYgA-1
Received: by mail-qt1-f198.google.com with SMTP id
 cc11-20020a05622a410b00b0033a100489c4so6580607qtb.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 03:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=zJ1tVOq7gmtva8bvG4/tC19zWSGUYjLfZNUM1FdlBcA=;
 b=hV5NN8EXoF/ClBFnQN8Inzqa3IfdGae1vBRZJEgAHLJyBQzdVxJRgdHgH7yEz2x8et
 x6aNWirQJ5MNbVOYzkj2ZjyKRsUWbmmX272Q2+1CxRR/GIJ+LknhFWE+LHlC7YdHyOe4
 augU6MWUeJcss9G1f9uIUKQZsMxYy2lgxAArk0xc1O0wJVKoDZ/v/fMkNCIIgadt6eLq
 YoWx3ORREFgCcrw7hrjZipq6fuS1yK4nUwZ5GnorKRT38YKGxyrI0VoGtiLUjlzai0Uf
 ZVWeKpuC617SHuaK4Y/VrDSQMs4zSQtp56MiXR6VbJHEO1aTVvpjMSo1MZtwBaqdmjOK
 Bylw==
X-Gm-Message-State: ACgBeo2zjHBRV0ArvTBZ+FftQjkE2nDaTmS4iSyahmhhvb4B8lRhl1VW
 XnEx76aGPc+neCxqojW49VEctxECNbc6YPoY3vkgSSkdRZGqWEaY016IT003pRQHLmEWXyl/2gV
 pdiRCGQWWvdA11ATAB7OjO2qstuitEelQN6Iboy96xg==
X-Received: by 2002:a05:622a:180e:b0:31f:d9b:5d08 with SMTP id
 t14-20020a05622a180e00b0031f0d9b5d08mr14833991qtc.361.1659954982343; 
 Mon, 08 Aug 2022 03:36:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6F6gVFFx3Fov1l256Ik12Z9hgmB//giFTCFLHWESSv1E7Qcw4/dS8csL3oAtpxvwHPq8lSnw==
X-Received: by 2002:a05:622a:180e:b0:31f:d9b:5d08 with SMTP id
 t14-20020a05622a180e00b0031f0d9b5d08mr14833976qtc.361.1659954982116; 
 Mon, 08 Aug 2022 03:36:22 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 m22-20020ac866d6000000b0031f229d4427sm7582235qtp.96.2022.08.08.03.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 03:36:21 -0700 (PDT)
Date: Mon, 8 Aug 2022 12:36:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Subject: Re: [RFC PATCH v3 4/9] vmci/vsock: use 'target' in notify_poll_in
 callback
Message-ID: <20220808103611.4ma4c5fpszrmstvx@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <2e420c8e-9550-c8c5-588f-e13b79a057ff@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2e420c8e-9550-c8c5-588f-e13b79a057ff@sberdevices.ru>
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

On Wed, Aug 03, 2022 at 01:57:54PM +0000, Arseniy Krasnov wrote:
>This callback controls setting of POLLIN,POLLRDNORM output bits of poll()
>syscall,but in some cases,it is incorrectly to set it, when socket has
>at least 1 bytes of available data. Use 'target' which is already exists
>and equal to sk_rcvlowat in this case.

Ditto as the previous patch.
With that fixed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

@Bryan, @Vishnu, if you're happy with this change, can you ack/review?

Thanks,
Stefano

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport_notify.c        | 8 ++++----
> net/vmw_vsock/vmci_transport_notify_qstate.c | 8 ++++----
> 2 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport_notify.c b/net/vmw_vsock/vmci_transport_notify.c
>index d69fc4b595ad..852097e2b9e6 100644
>--- a/net/vmw_vsock/vmci_transport_notify.c
>+++ b/net/vmw_vsock/vmci_transport_notify.c
>@@ -340,12 +340,12 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>-	if (vsock_stream_has_data(vsk)) {
>+	if (vsock_stream_has_data(vsk) >= target) {
> 		*data_ready_now = true;
> 	} else {
>-		/* We can't read right now because there is nothing in the
>-		 * queue. Ask for notifications when there is something to
>-		 * read.
>+		/* We can't read right now because there is not enough data
>+		 * in the queue. Ask for notifications when there is something
>+		 * to read.
> 		 */
> 		if (sk->sk_state == TCP_ESTABLISHED) {
> 			if (!send_waiting_read(sk, 1))
>diff --git a/net/vmw_vsock/vmci_transport_notify_qstate.c b/net/vmw_vsock/vmci_transport_notify_qstate.c
>index 0f36d7c45db3..12f0cb8fe998 100644
>--- a/net/vmw_vsock/vmci_transport_notify_qstate.c
>+++ b/net/vmw_vsock/vmci_transport_notify_qstate.c
>@@ -161,12 +161,12 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>-	if (vsock_stream_has_data(vsk)) {
>+	if (vsock_stream_has_data(vsk) >= target) {
> 		*data_ready_now = true;
> 	} else {
>-		/* We can't read right now because there is nothing in the
>-		 * queue. Ask for notifications when there is something to
>-		 * read.
>+		/* We can't read right now because there is not enough data
>+		 * in the queue. Ask for notifications when there is something
>+		 * to read.
> 		 */
> 		if (sk->sk_state == TCP_ESTABLISHED)
> 			vsock_block_update_write_window(sk);
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
