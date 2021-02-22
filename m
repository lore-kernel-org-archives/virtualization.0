Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D79FC433E6
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 10:17:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1454E64E27
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 10:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1454E64E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3C936F554;
	Mon, 22 Feb 2021 10:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhIwIwznaAdI; Mon, 22 Feb 2021 10:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98FEB6F54D;
	Mon, 22 Feb 2021 10:17:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7288EC000B;
	Mon, 22 Feb 2021 10:17:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F578C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E15E6F554
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R4sNO4AO5L1K
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBBE36F54D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613989022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cOQGHTJkgVItLkSYtHFKmnYNiFiArxAhybbu5iVGEZE=;
 b=T0L8PXZFoZqH4FKOya13GKl+d3bKpd8iJya9v/nXT1KvLBchPoOK1Z0/pZ00fBMhLDoWeI
 paMR1SohGJkZYVunzFbiu0fkurAlz9DwtySgGqO9nvoVK3WWm5zNqXa9y8cVuBcFlLvS0o
 S9NDZTvfqdn4GQ5AYNW0Lb4Q+Lvv9sM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-kKhaxj8XMNSeGvsHz3ufMg-1; Mon, 22 Feb 2021 05:16:59 -0500
X-MC-Unique: kKhaxj8XMNSeGvsHz3ufMg-1
Received: by mail-wr1-f71.google.com with SMTP id u15so5854074wrn.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 02:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cOQGHTJkgVItLkSYtHFKmnYNiFiArxAhybbu5iVGEZE=;
 b=CrdvUNRB9uwrX5qnnjmJIZ8zODSgwo/qa59mrXQbSdnp73GZpyel8TBmalkXPEaUwA
 xgLQf+M7TAPFsaeUcq+fJcpCSaDccMpI1VYpDxfqS38JRc84hW1/79t8JTB0IQ5LVX+Y
 aKiI17Cvv/q4Fqr/mt5MWhFhCCAy7xLjVlgoSDj3NjY1nupflu1lclP988ULMCr4s3FX
 tdQKxgksbFfUWkJXZ/aKYdVTIk4GKU0SHurvy/6qZRFGmkxZKke4drY/R6+NpusbHKmq
 s3ufu/LwrwbyY/U+ZfRRCiGlR9MGP5i0HltGGFMiBi4t5OgddS4pyHS+0MX6ocX3LQtM
 zfIg==
X-Gm-Message-State: AOAM531Lj+voJaR0hgqMRwtcIfJhED+oInb3QbbxQbH36VlZduIXJb5B
 aZlQCX+LM+Ycg+vqx4LgwLpicuWdBDyCAe1jopp605epJpcOwvZa68KNkI0kwtJqppWekJe732B
 sRL60cACvu1UAuBkFztmKikpXAJPuPZEW53W7DxqREg==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr4465412wru.249.1613989018280; 
 Mon, 22 Feb 2021 02:16:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweyTCl5fh1PIL5sdwYScCRaU0QOymRN8qy7bBT0Mhof57dP1ybfm4V2HipG+O4qvWxF66KgA==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr4465388wru.249.1613989018042; 
 Mon, 22 Feb 2021 02:16:58 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id 4sm29338957wrr.27.2021.02.22.02.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 02:16:57 -0800 (PST)
Date: Mon, 22 Feb 2021 11:16:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 0/1] virtio-vsock: introduce SEQPACKET description
Message-ID: <20210222101654.63tz75jzspiwt4tc@steredhat>
References: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Thu, Feb 18, 2021 at 09:07:12AM +0300, Arseny Krasnov wrote:
>This patchset adds description of SOCK_SEQPACKET socket's type
>of virtio vsock.
>
>Here is implementation:
>https://lkml.org/lkml/2021/2/18/24
>
> Arseny Krasnov(1):
>  virtio-vsock: add SOCK_SEQPACKET description
>
> virtio-vsock.tex | 40 +++++++++++++++++++++++++++++++++++++---
> 1 files changed, 37 insertions(+), 3 deletions(-)
>
>TODO:
>- for messages identification I use header's field called 'msg_cnt'.
>  May be it is better to call it 'msg_id' or 'msg_num', because it
>  is used as ID, but implemented as counter.

If we use it only as an identifier, I think 'msg_id' is preferable and 
we shouldn't mention in the specs that it's a counter, since it's just a 
possible implementation.
Instead if we use the counter for some control, for example if we lost a 
packet, then maybe msg_cnt is better.
But since the channel shouldn't lose packets, I don't think this is the 
case.

>
>- in current version of specification, some values of headers' fields
>  still unnamed, for example type of socket (stream or seqpacket), then
>  shutdown flags. Spec says that for stream socket value of 'type'
>  must be 1. For receive shutdown bit 0 is set in 'flags', for send
>  shutdown bit 1 is set in 'flags'. But in Linux these unnamed ones and
>  zeroes are implemented as enums, so may be it will be ok to add such
>  enums in specification (as 'enum virtio_vsock_event_id').

Since we have an enumerate for VIRTIO_VSOCK_OP_* values, I think we can 
add enums for socket type and maybe 'flags'.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
