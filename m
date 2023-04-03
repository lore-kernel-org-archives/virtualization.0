Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8286C761A6
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 11:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B72681E6A;
	Mon,  3 Apr 2023 11:15:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B72681E6A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMb4y9+9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gf5jSVEAe8Uu; Mon,  3 Apr 2023 11:15:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDF3681B52;
	Mon,  3 Apr 2023 11:15:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDF3681B52
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A034FC0037;
	Mon,  3 Apr 2023 11:15:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B067C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38BEA81B52
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38BEA81B52
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bPMhuKaQdrsL
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72C4881A81
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72C4881A81
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680520499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sl4rkdnr0o5W52X2aSuuGluJKvhKvYjxKheoSDXESvI=;
 b=aMb4y9+9U7tz7jGwnQ2V+UYi8HldjPq741joxg8t1JLZdQyT5dDf11/o3B6FbtA6Qqr0n/
 xutk8SuEPNJRxriuD4AE7ZR0qFjpyzvX640Kc+3KpLM1bKTS1kRTbBNOv2bAb7xy7noNvs
 /FeFKlXVbRTsr0zXn1DVeTfToM83BtQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-xw5B3X6tOOCYlBXr3C6A8g-1; Mon, 03 Apr 2023 07:14:56 -0400
X-MC-Unique: xw5B3X6tOOCYlBXr3C6A8g-1
Received: by mail-qk1-f199.google.com with SMTP id
 a13-20020ae9e80d000000b0074a3e98f30dso971154qkg.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 04:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680520495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sl4rkdnr0o5W52X2aSuuGluJKvhKvYjxKheoSDXESvI=;
 b=hp0zHYX/p9NpYeeBsXPq3myKcyyzCLcdFP46yiuYQxvjspCi4OlgG0I08D/ksWkxFN
 SnLy6LQtWHJGkrQ1HjLH3xQNRKO416XMZSNIomvrR/9UoSgoJPur4FZOW1/uIABUXyKt
 7h+k2SW4bTq1iqhxNO2oW7t6B4fWQGH2CjBHNMNEidJta8xrW7+Xf6qYw6DuUppYTbNM
 gb7FdZTtSPPt8nEXdbJP6Y3jsTWW/IeXmyKunLb/6s8J4zDArgeA7QS1l6w8vqXCQVO9
 sCocIWWpinTB2XJpQCEKRpupypgA2s2Kr2xa+O9zXlPKtBeQe5gdDHuiecKWGxcns7Xh
 3L6g==
X-Gm-Message-State: AAQBX9cYIAYJjzTS7dq7iPSts4raPv8Nm+7kLXOnjw8dob5Nur9Isgvu
 qe/242eQf+/qbeyMJkkbNvOtrD5FpbNXATxWgTt8wTJIbBNpIdJSgNn1hjnCVkgtDoTVqPE3QcT
 iok6xVeJ/AsSK+Dj/GtujGqUSJrQP9BXLtatk/skWug==
X-Received: by 2002:a05:622a:15ce:b0:3e6:3032:827b with SMTP id
 d14-20020a05622a15ce00b003e63032827bmr25440150qty.7.1680520495546; 
 Mon, 03 Apr 2023 04:14:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350bdQmEU9WWUOrbzCJ+Bq0v8HXzqQQ+6ONbGa/DU8+jSLKW1/RzfPc/4ZJ/IS5EkzEjM/uHPCg==
X-Received: by 2002:a05:622a:15ce:b0:3e6:3032:827b with SMTP id
 d14-20020a05622a15ce00b003e63032827bmr25440112qty.7.1680520495295; 
 Mon, 03 Apr 2023 04:14:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 136-20020a37058e000000b00747d211536dsm2688864qkf.107.2023.04.03.04.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 04:14:54 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:14:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 1/3] vsock/vmci: convert VMCI error code to
 -ENOMEM on receive
Message-ID: <djxa4zzfqu463t6rw3plwegghwmem36rue3czs7ype2xn3f6b7@65ly3ebfkt6w>
References: <5440aa51-8a6c-ac9f-9578-5bf9d66217a5@sberdevices.ru>
 <fb3308c0-4a7a-a0b0-dbfd-92e50985600e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <fb3308c0-4a7a-a0b0-dbfd-92e50985600e@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
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

On Sun, Apr 02, 2023 at 09:15:49PM +0300, Arseniy Krasnov wrote:
>This adds conversion of VMCI specific error code to general -ENOMEM. It
>is preparation for the next patch, which changes af_vsock.c behaviour
>on receive to pass value returned from transport to the user.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
>---
> net/vmw_vsock/vmci_transport.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 36eb16a40745..a5375c97f5b0 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1831,10 +1831,17 @@ static ssize_t vmci_transport_stream_dequeue(
> 	size_t len,
> 	int flags)
> {
>+	ssize_t err;
>+
> 	if (flags & MSG_PEEK)
>-		return vmci_qpair_peekv(vmci_trans(vsk)->qpair, msg, len, 0);
>+		err = vmci_qpair_peekv(vmci_trans(vsk)->qpair, msg, len, 0);
> 	else
>-		return vmci_qpair_dequev(vmci_trans(vsk)->qpair, msg, len, 0);
>+		err = vmci_qpair_dequev(vmci_trans(vsk)->qpair, msg, len, 0);
>+
>+	if (err < 0)
>+		err = -ENOMEM;
>+
>+	return err;
> }
>
> static ssize_t vmci_transport_stream_enqueue(
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
