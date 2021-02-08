Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD17C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 12:01:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0EF64E60
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 12:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0EF64E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 01FA485DD1;
	Mon,  8 Feb 2021 12:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LhfP7ZR3aB7O; Mon,  8 Feb 2021 12:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1788485CD0;
	Mon,  8 Feb 2021 12:01:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFD08C0174;
	Mon,  8 Feb 2021 12:01:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98899C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 12:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6FEBA204D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 12:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLZBIVj1iEB8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 12:01:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 048E720010
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612785692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTlcoT+IigUWQzE/5Lb/sZFJTttDVxoCx4ggLUb2mzc=;
 b=bjlsagXJWCg5hnQbwo36AfkJlxq1lZ49TYcpTOFqrDNwbId0FDCDyu7GK0bxl7ldzLkAoV
 j73P+6d9/UzYXT1WKkQ/u7lFoZNhq7Id4mwL6U+gc3FkPpLLmEr3SRZdnhZkXKc4h8+WSB
 GDcbNAYEO/k9WyQESNyrwqJxLplgivk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-bxwb3HzNObiY2pkapdf8bw-1; Mon, 08 Feb 2021 07:01:28 -0500
X-MC-Unique: bxwb3HzNObiY2pkapdf8bw-1
Received: by mail-ed1-f70.google.com with SMTP id i13so12877199edq.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 04:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PTlcoT+IigUWQzE/5Lb/sZFJTttDVxoCx4ggLUb2mzc=;
 b=Xmx/su7eBbKU2BC0nMKAHdRyAcuZ3MYv1gmxHOCOOF0kjX8QLqluCAPKtLq4hUKFGd
 GJDh/DxJmtHsdGukGLsG3RwNfzUkPTnXDUNvnj6/GmYFaBcb8wkrsLwJp6jiJfPMfkj0
 41foq/pHqYmGYeQXRhzk+jNU5rGFb1Y9F3TIL/0QP2bbAESkITMloAnXitRrtk66q6oy
 Qt11GxDAhSDtp2AGHrl3pwZpOCKZTqJtuDhFujEHzBqF3fxNlCf91qIYwKAJBzrB7/P+
 ohTLQrIhF5AydDVIedR+I07x+TXaHmvBh9EqY+p1DpII1cnMtYrzpts57pjOzV3dO1MZ
 K9uw==
X-Gm-Message-State: AOAM5322IGU5R8gmBg6uh+62/d/jPOilDuixSpekYyeXm+LW4efUU9xi
 phQkbZY6c9i8+G8fGEWHVcwtxxUO1hHbAWuhkEI5NuQzbyPd8myZ6Laf9K5qrxoZ5fQo2gNelA3
 LZxZrSzmLgErfkE7eszlKCGgbzy+KwDlwCj3VCPClFg==
X-Received: by 2002:a05:6402:1914:: with SMTP id
 e20mr16757904edz.89.1612785687643; 
 Mon, 08 Feb 2021 04:01:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6KUrSSLZ/WJvZD7GSCwfBw66PX8V89QFLyOzcHizAKpcWVSLgUjhtBHtAVbQuSaC5ixXRIw==
X-Received: by 2002:a05:6402:1914:: with SMTP id
 e20mr16757890edz.89.1612785687468; 
 Mon, 08 Feb 2021 04:01:27 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id h25sm8481385ejy.7.2021.02.08.04.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 04:01:26 -0800 (PST)
Date: Mon, 8 Feb 2021 07:01:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 00/11] target: fix cmd plugging and completion
Message-ID: <20210208070050-mutt-send-email-mst@kernel.org>
References: <20210204113513.93204-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210204113513.93204-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Feb 04, 2021 at 05:35:02AM -0600, Mike Christie wrote:
> The following patches made over Martin's 5.12 branches fix two
> issues:
> 
> 1. target_core_iblock plugs and unplugs the queue for every
> command. To handle this issue and handle an issue that
> vhost-scsi and loop were avoiding by adding their own workqueue,
> I added a new submission workqueue to LIO. Drivers can pass cmds
> to it, and we can then submit batches of cmds.
> 
> 2. vhost-scsi and loop on the submission side were doing a work
> per cmd and on the lio completion side it was doing a work per
> cmd. The cap on running works is 512 (max_active) and so we can
> end up end up using a lot of threads when submissions start blocking
> because they hit the block tag limit or the completion side blocks
> trying to send the cmd. In this patchset I just use a cmd list
> per session to avoid abusing the workueue layer.
> 
> The combined patchset fixes a major perf issue we've been hitting
> where IOPs is stuck at 230K when running:
> 
>     fio --filename=/dev/sda  --direct=1 --rw=randrw --bs=4k
>     --ioengine=libaio --iodepth=128  --numjobs=8 --time_based
>     --group_reporting --runtime=60
> 
> The patches in this set get me to 350K when using devices that
> have native IOPs of around 400-500K.
> 
> Note that 5.12 has some interrupt changes that my patches
> collide with. Martin's 5.12 branches had the changes so I
> based my patches on that.
> 

OK so feel free to merge through that branch.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
