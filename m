Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF864C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 09:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E38F81C2F;
	Mon,  5 Dec 2022 09:47:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E38F81C2F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c46v/ec2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NrniwgC4PgMA; Mon,  5 Dec 2022 09:47:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1A6781C11;
	Mon,  5 Dec 2022 09:47:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1A6781C11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76EA4C0033;
	Mon,  5 Dec 2022 09:47:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5768C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D8B3403FB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:47:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D8B3403FB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c46v/ec2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qlEuZQ6TJ-lI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:47:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93AA040120
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93AA040120
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670233667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IcvnyLKDgnT5EwGdRxoCJ/l5uFVnluQmDLioHt8iGWE=;
 b=c46v/ec2weF+VNHW0251SZFIRwVQ/Jg7gXkMBvA+t900ohgHZTvfMfFdtEdJiiCp8tqj6J
 YxI1dqYvFpM6FI4KNQ3EMnOKk8MYQUMEu7jxQoGxSitOHDnhImaysl4BhH6YP0hmES7s5B
 4w82ZJyqolR5NXTWYZqCXHlhthUwgYM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-vvFjsYNiOgeQoDlpRnPVTw-1; Mon, 05 Dec 2022 04:47:44 -0500
X-MC-Unique: vvFjsYNiOgeQoDlpRnPVTw-1
Received: by mail-qv1-f71.google.com with SMTP id
 ln3-20020a0562145a8300b004b8c29a7d50so29288169qvb.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 01:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcvnyLKDgnT5EwGdRxoCJ/l5uFVnluQmDLioHt8iGWE=;
 b=QIUioJTXeHgNUie1MetBIxpPfoy7+XBi2JhOxs00rWA1W/jtJ1EMU0cb9SocDF4lgh
 TdPakIH3tbNHgxSh924llDPYnQjoqDR6XkG78DBGV/tRqUHdYYVfD0I+q5CARi3S/dFR
 jII17UMyS+gB6Lhwyy6TxJREAzjdn6femewiX9CiYvkEa7qHtifep5CYcXe8hR8c2CG7
 /b87y7wjR8MbuigPZma/XvIvOSRQpU9vBo8LHKjwP6FNsg+/UpTO+pcidUAngEFjY7MH
 AvfyKSN1N5BU6PtaYGLmthTz2pmp8Oj7chygK2QB5E7L2W1hbkFkR6Po5Lmvm6RuWCd1
 X+Hw==
X-Gm-Message-State: ANoB5plYM803Tha6wq6Yxsi1H4Y4/UpNoQQ4lyjIEBTDUfZWdWytH1fV
 8BQaP+Rkw6g0PSlMYlN2C5Y2Ecb3QqQEVjl2Fn1Q7es1DQwwiUYJGsR1/+7hcz/JtV7fB2Uh2Pj
 dFewvr8DNThKC9DTpqHO8G8WnBqtaGkh78V7ZBEHzyg==
X-Received: by 2002:a05:620a:13ab:b0:6fe:b81b:b34d with SMTP id
 m11-20020a05620a13ab00b006feb81bb34dmr3591729qki.670.1670233663914; 
 Mon, 05 Dec 2022 01:47:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf45OxZ8+RfdMfmhJecYJujPPz1Wg0eh2+1ixtUFNzLbxhTUqg3CfNjhGJz5ohM76/NfGk6Qbw==
X-Received: by 2002:a05:620a:13ab:b0:6fe:b81b:b34d with SMTP id
 m11-20020a05620a13ab00b006feb81bb34dmr3591720qki.670.1670233663688; 
 Mon, 05 Dec 2022 01:47:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 ay40-20020a05622a22a800b003a57a317c17sm9285578qtb.74.2022.12.05.01.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 01:47:43 -0800 (PST)
Date: Mon, 5 Dec 2022 10:47:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH v2] net: vmw_vsock: vmci: Check memcpy_from_msg()
Message-ID: <20221205094736.k3yuwk7emijpitvw@sgarzare-redhat>
References: <702BBCBE-6E80-4B12-A996-4A2CB7C66D70@vmware.com>
 <20221203083312.923029-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
In-Reply-To: <20221203083312.923029-1-artem.chernyshev@red-soft.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, lvc-project@linuxtesting.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bryan Tan <bryantan@vmware.com>, Jakub Kicinski <kuba@kernel.org>
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

On Sat, Dec 03, 2022 at 11:33:12AM +0300, Artem Chernyshev wrote:
>vmci_transport_dgram_enqueue() does not check the return value
>of memcpy_from_msg(). Return with an error if the memcpy fails.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>Fixes: 0f7db23a07af ("vmci_transport: switch ->enqeue_dgram, ->enqueue_stream and ->dequeue_stream to msghdr")
>Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
>---
>V1->V2 Fix memory leaking and updates for description
>
> net/vmw_vsock/vmci_transport.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 842c94286d31..c94c3deaa09d 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1711,7 +1711,10 @@ static int vmci_transport_dgram_enqueue(
> 	if (!dg)
> 		return -ENOMEM;
>
>-	memcpy_from_msg(VMCI_DG_PAYLOAD(dg), msg, len);
>+	if (memcpy_from_msg(VMCI_DG_PAYLOAD(dg), msg, len)) {
>+		kfree(dg);
>+		return -EFAULT;

Since memcpy_from_msg() is a wrapper of copy_from_iter_full() that 
simply returns -EFAULT in case of an error, perhaps it would be better 
here to return the value of memcpy_from_msg() instead of wiring the 
error.

However in the end the behavior is the same, so even if you don't want 
to change it I'll leave my R-b:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
