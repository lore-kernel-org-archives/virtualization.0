Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E795C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9AD54151E;
	Mon,  8 Aug 2022 10:54:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9AD54151E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q0bNohSk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qDavopUo4L_c; Mon,  8 Aug 2022 10:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C8C441511;
	Mon,  8 Aug 2022 10:54:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C8C441511
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9F46C0033;
	Mon,  8 Aug 2022 10:54:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED7CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6974540609
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:54:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6974540609
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q0bNohSk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vT1rwxtMpVVH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:54:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4C7D40535
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4C7D40535
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659956039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqTZfTOpSZv/oxvZyQIT3dmO6v6DeAZnUAfnA5NVFOM=;
 b=Q0bNohSkuL9wd6uheLV5DUo95n72hX6MJ292omc5DPyO0ZqG8ABpneMVhneU9ohDsvsLyJ
 PzaCSmYxH/I4ZoiQ8KV2ZVdYI8c33W9i29JnDZGze1+bWwEhScrOc1Z2jW1e9FrfPwSkXY
 ELIoXTZjNReivqbexV5yacw0uwWOJHQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-TV8ypit6NGC5ejes1MYyFQ-1; Mon, 08 Aug 2022 06:53:57 -0400
X-MC-Unique: TV8ypit6NGC5ejes1MYyFQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 m17-20020a05620a291100b006b6590830feso7631168qkp.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 03:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=cqTZfTOpSZv/oxvZyQIT3dmO6v6DeAZnUAfnA5NVFOM=;
 b=T9/4e14ifMPkqKm+VulEraH7CfPUt/b9g4WFpxOry4Bjp2MCr45Jxd3uBFdvTDa/54
 UyvvaXsNoSgKRk2TdvXm9bf0lAi7PvtTPhhd+WL//j269GnL/l5d/apxfvBnd/d5gl3N
 mvSfrTSJCqYq6dSO7paiNmdclEYtKIs7ch5ULX+mG9/MDgcTGvAxJc8Zf6lXVcNU50q0
 Qrp5MQUS9wTiEcsEQJUo829bShQk+pbJ/OqMCI3fmsa3dch9uKq4y3bFqy0lvfNYYmMf
 Kd/VXmUt8CHw+0DV18ujTyqLSFezzhMfsFDDm87gAfuVL5xnPudb3ZN/Dk0Rtga1Bt6D
 gr2Q==
X-Gm-Message-State: ACgBeo2bQveBrhJ7tkernuUMZ5ntVGVoMW0KcUqxdnQRD9LnqdkHIpRl
 t9OSaEpZExt8pLK0qBGxDlcYD7iXytofuLALaY6V6R4qYbv0I12oio48GZxyM1JLfMLyxbJlk2x
 hc2E3bvZfx5IIeMzHI/RyZow5er6i+5i2rZrttwrgOw==
X-Received: by 2002:a05:620a:f8f:b0:6b5:be6c:255e with SMTP id
 b15-20020a05620a0f8f00b006b5be6c255emr13571447qkn.638.1659956036588; 
 Mon, 08 Aug 2022 03:53:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5eZOYkfnMEABqPmnzlbZTfqIBNY9uF7dpmoPWJ7+Uc8TBxra/Vn+m6r3fobIYoBwsf4CHA7A==
X-Received: by 2002:a05:620a:f8f:b0:6b5:be6c:255e with SMTP id
 b15-20020a05620a0f8f00b006b5be6c255emr13571431qkn.638.1659956036378; 
 Mon, 08 Aug 2022 03:53:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 az38-20020a05620a172600b006b8619a67f4sm8787400qkb.34.2022.08.08.03.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 03:53:55 -0700 (PDT)
Date: Mon, 8 Aug 2022 12:53:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 6/9] vsock: add API call for data ready
Message-ID: <20220808105345.vm7x6nzbi4ss7v6j@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <edb1163d-fb78-3af0-2fdd-606c875a535b@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <edb1163d-fb78-3af0-2fdd-606c875a535b@sberdevices.ru>
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

On Wed, Aug 03, 2022 at 02:01:57PM +0000, Arseniy Krasnov wrote:
>This adds 'vsock_data_ready()' which must be called by transport to kick
>sleeping data readers. It checks for SO_RCVLOWAT value before waking
>user,thus preventing spurious wake ups.Based on 'tcp_data_ready()' logic.
>

Since it's an RFC, I suggest you add a space after the punctuation. :-)

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 10 ++++++++++
> 2 files changed, 11 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index eae5874bae35..7b79fc5164cc 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -77,6 +77,7 @@ struct vsock_sock {
> s64 vsock_stream_has_data(struct vsock_sock *vsk);
> s64 vsock_stream_has_space(struct vsock_sock *vsk);
> struct sock *vsock_create_connected(struct sock *parent);
>+void vsock_data_ready(struct sock *sk);
>
> /**** TRANSPORT ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 3a1426eb8baa..47e80a7cbbdf 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -882,6 +882,16 @@ s64 vsock_stream_has_space(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(vsock_stream_has_space);
>
>+void vsock_data_ready(struct sock *sk)
>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
>+	if (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
>+	    sock_flag(sk, SOCK_DONE))
>+		sk->sk_data_ready(sk);
>+}
>+EXPORT_SYMBOL_GPL(vsock_data_ready);
>+
> static int vsock_release(struct socket *sock)
> {
> 	__vsock_release(sock->sk, 0);
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
