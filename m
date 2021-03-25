Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B66C433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:27:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB8E61A2C
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 10:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB8E61A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0856260B23;
	Thu, 25 Mar 2021 10:27:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TzlGQhmJC6fp; Thu, 25 Mar 2021 10:27:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83F25606EE;
	Thu, 25 Mar 2021 10:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E861C000E;
	Thu, 25 Mar 2021 10:27:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DC28C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F4B040146
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HdqrTwYTvldH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:27:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26899400B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616668021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YnnJOjLqRsNOiRCl1VmxWYaDtnFLgBh+G/O9tqpx3N4=;
 b=eQBdZo0ZAFBCEb79grPnk85P9vptY2tbCFgwjUTqUW7IhML5wO6/qWqZ/cZRv/KeEcshyb
 XjaEx/+lScB3AwZyapjoQF7KfRc3zut3hc43eAVMmXg/QDHZGkGE2j82E+NmsnQL6fBVNk
 73w75ob4bN3PIrUDeIOEjvN3jpH+H/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-Iv9MziSAMSu3MRqJuJmvVA-1; Thu, 25 Mar 2021 06:26:59 -0400
X-MC-Unique: Iv9MziSAMSu3MRqJuJmvVA-1
Received: by mail-wm1-f71.google.com with SMTP id v5so1492031wml.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 03:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YnnJOjLqRsNOiRCl1VmxWYaDtnFLgBh+G/O9tqpx3N4=;
 b=Tda2apinyB/ylQhKoWipMopLJCZN0IQ/KONDARREJojIJnCOSvs0PNuiveXdZ4Tkcc
 DdJIxk8wU0Ey1+4GT0jQx0o5OKFdZ4v7tOs+s2kxb2e4D1z3y97PmAvH1Vb99La3/jhG
 4jWq1szFNwyUEvy8iuFHO94o6shCef3sEZ5TPafgijWLbzpGUfb5yGp0Ca8G5NYKR8kt
 /nN8MIc7a6ymFyU9dzozbpA4F9LY8YIAvBfNVybKDc2oxPGC/cWIkTvyKJQrIr1iIg/v
 II+VOABcGIL0L9nhZQGIUzr69DYgs2oJrREUHeuQZumEZlhhqlyCWFAWcJ4opS6Qm6sG
 7JvQ==
X-Gm-Message-State: AOAM533owdZiBVhrTGObfC46k5Ps4iUqIhdAZvHkvWPvzTn2jXXqRlz6
 rhJ3x1SaRUd9PN+qjoZ0LNBEJXgLTlOKYAWYC5VOb8KT3rBeAeXd78zZmlOd8YNNTk2Ppl6mwxG
 USKr1xUMiQB3r6T7uKeaHP9r/M8UG06T3BbtvGRvGjQ==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr8238600wrs.229.1616668018214; 
 Thu, 25 Mar 2021 03:26:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBTujIWNkDzf/wNwRNzZd57i5I9jgY+9t+YqLrMxkr/bkSu6aLA/urK8lINmqRAJa9Wu/cyw==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr8238578wrs.229.1616668018030; 
 Thu, 25 Mar 2021 03:26:58 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id p17sm5370291wmq.47.2021.03.25.03.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 03:26:57 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:26:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 15/22] virtio/vsock: SEQPACKET support feature bit
Message-ID: <20210325102655.ujyfpapvwnubcggn@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131352.2461534-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131352.2461534-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Tue, Mar 23, 2021 at 04:13:49PM +0300, Arseny Krasnov wrote:
>This adds new virtio vsock specific feature bit which means
>SOCK_SEQPACKET support. Guest negotiates this bit with vhost,
>thus checking that vhost side supports SEQPACKET.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/uapi/linux/virtio_vsock.h | 3 +++
> 1 file changed, 3 insertions(+)

Since you have this patch, I think you can generalize the title, update 
the description, and merge here the changes I mentioned in patch 11/22 
about changes of include/uapi/linux/virtio_vsock.h.

So you can have a single patch with the new virtio-spec defines and 
structs related to SEQPACKET, of course then we move it before patch 11.

What do you think?

Stefano

>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 692f8078cced..619aaebb355a 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -38,6 +38,9 @@
> #include <linux/virtio_ids.h>
> #include <linux/virtio_config.h>
>
>+/* The feature bitmap for virtio vsock */
>+#define VIRTIO_VSOCK_F_SEQPACKET	0	/* SOCK_SEQPACKET supported */
>+
> struct virtio_vsock_config {
> 	__le64 guest_cid;
> } __attribute__((packed));
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
