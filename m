Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B2C04FF3
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 09:38:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582166117A
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 09:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582166117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1748560682;
	Mon, 24 May 2021 09:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJbZL4QI-X5B; Mon, 24 May 2021 09:38:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B70A1607A1;
	Mon, 24 May 2021 09:38:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DAF3C000E;
	Mon, 24 May 2021 09:38:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A26C7C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88B1440311
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:38:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MXsivmwh6uF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:38:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F00D402AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621849092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhcG+ZYBd4bRB5Q9zZ5/t8jdmTbmo6W9bwBV1bTr2uI=;
 b=Q8bg5J1n3YHew9O1qTU1h1v+vXElIyfM2sw3Lh9RNNThsV0zExotBRqXPVObBi37ystBdq
 ixaoPOpKPtie4zClLCHa1fB+sbMmrouBJDExMX/UXXJlFZmsbukoCpv9s9a+ErqS9wqdF+
 BSqHiDMiaUK6Iu0wL9w7VnoZpXm+5q0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-FTTtNiOgPgaSbB49FihTKw-1; Mon, 24 May 2021 05:38:11 -0400
X-MC-Unique: FTTtNiOgPgaSbB49FihTKw-1
Received: by mail-wr1-f71.google.com with SMTP id
 h104-20020adf90710000b029010de8455a3aso12813101wrh.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 02:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UhcG+ZYBd4bRB5Q9zZ5/t8jdmTbmo6W9bwBV1bTr2uI=;
 b=fOPPtHCSSIzVYGGrBadZb++27jp2Zuf0yjQzElfLi6bUZCtehWvlAuDFufx6Z1RHkT
 877CixhesJ2X081JQxDC7Yu9VTd7fi1EDGz2s3ivOTjNgzLYul9x+I+AhHlHRME2Q+ua
 TTjVDJNQ9CS5IMPB8NhUTthZApfxJrGSN20ge0YOYtNEenoVJo76utZiL0nr1xlD2vxi
 APT6+RlHp1aqVrt/vRGMDe0aZcOYEZcmUQ/7zp6zGSVyfOwQE/pUGqN+kFs++OKgGv6o
 vJpN7avAI+iv3nOrkBGlkuGGjTlUAVfz9wxjDkbUY4lh5GqjQIfbz2DpqBPip5jvrVdX
 SCsw==
X-Gm-Message-State: AOAM5313Mmr78G1TXWIJEfGZEHh9a7he+2+cWRrUrGbiHVfjNM0KrhME
 luMQxRCH1OM++T+e1+FmtuaOfPMH5gBJABo6Gxz6kBT5+cQ7NAIbczOEEC3+23wCtj9i5kYoUCF
 KrRLuNBa2uQW9dhMTxVNeD5QkiWPxRXzpaxpvSyxWcQ==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr20882574wrt.95.1621849089943; 
 Mon, 24 May 2021 02:38:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkE8l/aehoZWuKmQObYHxaOPyTbgiq/nPsGARq/5vNSJKSJ1RNdTK4INsbnLsVugDByKpq7Q==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr20882558wrt.95.1621849089807; 
 Mon, 24 May 2021 02:38:09 -0700 (PDT)
Received: from redhat.com (bzq-79-176-159-122.red.bezeqint.net.
 [79.176.159.122])
 by smtp.gmail.com with ESMTPSA id u11sm11262234wrw.14.2021.05.24.02.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 02:38:09 -0700 (PDT)
Date: Mon, 24 May 2021 05:38:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v3 00/29] vDPA software assisted live migration
Message-ID: <20210524053144-mutt-send-email-mst@kernel.org>
References: <20210519162903.1172366-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210519162903.1172366-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Harpreet Singh Anand <hanand@xilinx.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, May 19, 2021 at 06:28:34PM +0200, Eugenio P=E9rez wrote:
> Commit 17 introduces the buffer forwarding. Previous one are for
> preparations again, and laters are for enabling some obvious
> optimizations. However, it needs the vdpa device to be able to map
> every IOVA space, and some vDPA devices are not able to do so. Checking
> of this is added in previous commits.

That might become a significant limitation. And it worries me that
this is such a big patchset which might yet take a while to get
finalized.

I have an idea: how about as a first step we implement a transparent
switch from vdpa to a software virtio in QEMU or a software vhost in
kernel?

This will give us live migration quickly with performance comparable
to failover but without dependance on guest cooperation.

Next step could be driving vdpa from userspace while still copying
packets to a pre-registered buffer.

Finally your approach will be a performance optimization for devices
that support arbitrary IOVA.

Thoughts?

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
