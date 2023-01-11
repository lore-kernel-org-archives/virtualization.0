Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDE8C46467
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 08:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84C23418DB;
	Wed, 11 Jan 2023 08:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84C23418DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VKIBlYmp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78g_tLQn7iDn; Wed, 11 Jan 2023 08:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D281F418E8;
	Wed, 11 Jan 2023 08:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D281F418E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6B5BC0032;
	Wed, 11 Jan 2023 08:25:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1238C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9B2560ABB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9B2560ABB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VKIBlYmp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGRxUgf2DM95
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:25:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43AB960AB0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43AB960AB0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673425522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9BqbleyIskxpRXIgDkvfJFpA17h9Qu7BSswmKTjpxs=;
 b=VKIBlYmp15GrSZ+QcapcoMhDxdR4VeJdoirqZ3/qjum+L+eg1Y6eYVxp53u2z+KShlwa4/
 Vy53A6VXabDbE1YmDIEge00qT1F4mEJk0+YZ6NpHVWBbnQZ/OyjFrgBXZ5FQyRgaa2n/MX
 +GnDrtbtBcd2YcAE9dwzvsZl+qAp5FI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-60_EA8ZCPmuEngk6im-dWw-1; Wed, 11 Jan 2023 03:25:19 -0500
X-MC-Unique: 60_EA8ZCPmuEngk6im-dWw-1
Received: by mail-qk1-f197.google.com with SMTP id
 de38-20020a05620a372600b0070224de1c6eso10562304qkb.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 00:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9BqbleyIskxpRXIgDkvfJFpA17h9Qu7BSswmKTjpxs=;
 b=6d83lmK/TkGoDG2kYEn//GgA4ju3bVEzsNqIwXNJsVdbbvukdb/wIQZQSZpbENpVBd
 Onb4vVRSWfBHJzJXuGzhnORR3/aG55VYQFYfLuxGSZv0anxfnvQzrjp5GnpFUA4Tt/qp
 BbubGtgD0HxpaJjFVmYcCzpRO3qhn8E3ccJZbrvPztS+neC3WSWPBDzD3rxis7wZyez7
 j/1AUg78AUO/IrRQZkrQWAbRBVRB/1ucVHYa4bdTHwPw5EifEj93j5a2VvEbhah7pRQd
 8e6oobgSmRWTP/GAV8zxqllDdE24gkwtCslPqbVJObmiqwXheXtkWDkhvhedL/cbIzRS
 BoFg==
X-Gm-Message-State: AFqh2krp39li5CJtxwTJSoPEOsVNdo8Qga8OS4EKHWB1DOrDqrzr7JSa
 h1Pq+x6QeSc4mTUio+HSbWWBu9BM0y+Xo9JBNlLnCD9foismbLKFMM8qSXx9guFO+JPgXQr3pfx
 6AwjQgmUA/SeShskrNGsvrxdy9tj4vXpyiL0+j6eYJQ==
X-Received: by 2002:ac8:6f19:0:b0:3a9:84bd:7cc5 with SMTP id
 bs25-20020ac86f19000000b003a984bd7cc5mr109481131qtb.39.1673425518776; 
 Wed, 11 Jan 2023 00:25:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvypWklvz3km9uYoBB0qv32xq21YlcTjpjh3KzgK6avNFjv4jYlLRNPx/BLDFKbo966A5oWEQ==
X-Received: by 2002:ac8:6f19:0:b0:3a9:84bd:7cc5 with SMTP id
 bs25-20020ac86f19000000b003a984bd7cc5mr109481108qtb.39.1673425518406; 
 Wed, 11 Jan 2023 00:25:18 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it.
 [79.46.200.244]) by smtp.gmail.com with ESMTPSA id
 c8-20020ac86608000000b003a4f435e381sm7226084qtp.18.2023.01.11.00.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jan 2023 00:25:17 -0800 (PST)
Date: Wed, 11 Jan 2023 09:25:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: liming.wu@jaguarmicro.com
Subject: Re: [PATCH] vhost: remove unused paramete
Message-ID: <20230111082513.weu6go5k2nyfvkjh@sgarzare-redhat>
References: <20230110024445.303-1-liming.wu@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20230110024445.303-1-liming.wu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: 398776277@qq.com, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Jan 10, 2023 at 10:44:45AM +0800, liming.wu@jaguarmicro.com wrote:
>From: Liming Wu <liming.wu@jaguarmicro.com>
>
>"enabled" is defined in vhost_init_device_iotlb,
>but it is never used. Let's remove it.
>
>Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
>---
> drivers/vhost/net.c   | 2 +-
> drivers/vhost/vhost.c | 2 +-
> drivers/vhost/vhost.h | 2 +-
> drivers/vhost/vsock.c | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)

Little typo in the title s/paramete/parameter.

A part of that, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
