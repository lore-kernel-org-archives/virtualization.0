Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A22C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 08:30:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C175B64E24
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 08:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C175B64E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 67EB186C1D;
	Mon,  1 Feb 2021 08:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8U5dyMGK5Aer; Mon,  1 Feb 2021 08:30:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A2EF9861F8;
	Mon,  1 Feb 2021 08:30:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9F9C0174;
	Mon,  1 Feb 2021 08:30:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27D57C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 08:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2336F86830
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 08:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2I6i4HEbCru6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 08:30:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A23D7864C1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612168204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9abuyB1cdyK0EkjXW3R63neo8lvwSJKL9r9wYH7jDK8=;
 b=XD0KJrvYdfH25geq1Jpy+AQL2G4WkbqThbv4ICIoasXN3zztxVGXJC2J7G4CsMCVQ1fBc5
 bp/BZQBXdvmC69luTKpS593UMmdyS+NC8Igt43JGK0SLdiWNL2ggurer4A/cvuFzs56anF
 5KQNy+8D0RXCrSymLdoXGKOcvvaSiNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-b-C0BoIhON--iu-5p-80Dw-1; Mon, 01 Feb 2021 03:30:02 -0500
X-MC-Unique: b-C0BoIhON--iu-5p-80Dw-1
Received: by mail-wm1-f72.google.com with SMTP id f65so4249450wmf.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Feb 2021 00:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9abuyB1cdyK0EkjXW3R63neo8lvwSJKL9r9wYH7jDK8=;
 b=nzubeQh6MGcQjvTTtQtiZF57VeQPAefrFC0Telrb0b2xytYbhb9nixfysmH+iYj89l
 Qvs2i2nNk/rIrEHCQK5dy+t0GU8TzXxDUjGrjfoib3vIPQxRY4kKIl+F3UtT/8iu8ZyL
 oEeSjum8OdhRiganAJJrKR17dmKY9Ml+Qtj4hXopEb4KSBR+nbeabVnUDMD1rmd3Yi5S
 4dCami88FhNdzGpFVvTn/1XWCFXGEHgwrtoJ+VeHm+3X4Q8Xris9B1xZ2H0lqxUJMbFw
 qad0MyTIk322AtF8OgdQU1cwIodYaksyMR9ENylNX1v9bZ61ptg+n2HcivwbCSBUrTcX
 Iljw==
X-Gm-Message-State: AOAM532OLSanxJXEhltvfXPUeF2TM9i3XwV35grWg8nwZTpJDdjq+7Nx
 +FDFujSuLF+MztSvzMTzuya2nYiuIDqbdDSnycIOB3K73g5lvX99g6ptL12I6C4njdhZ9oOlGO8
 M+9YqKMsq/SnuY4VPHL5AytGNTwBVAryFC44fn4FDrg==
X-Received: by 2002:a05:6000:1045:: with SMTP id
 c5mr17350742wrx.250.1612168201728; 
 Mon, 01 Feb 2021 00:30:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6UZr189pCeRP1YezATVaXeQQHRGHCvETS8Jr7AzP2dFOuy5pRO24CAZQYIXQgraHCwm17sg==
X-Received: by 2002:a05:6000:1045:: with SMTP id
 c5mr17350715wrx.250.1612168201566; 
 Mon, 01 Feb 2021 00:30:01 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id w14sm25577889wro.86.2021.02.01.00.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 00:30:00 -0800 (PST)
Date: Mon, 1 Feb 2021 09:29:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC v2 08/10] vdpa: add vdpa simulator for block device
Message-ID: <20210201082958.646etcwgssvi22cq@steredhat>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-9-sgarzare@redhat.com>
 <e8f97ea2-d179-de37-a0ea-b2858510f3ce@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <e8f97ea2-d179-de37-a0ea-b2858510f3ce@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Sun, Jan 31, 2021 at 05:31:43PM +0200, Max Gurtovoy wrote:
>
>On 1/28/2021 4:41 PM, Stefano Garzarella wrote:
>>From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>>This will allow running vDPA for virtio block protocol.
>>
>>Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>[sgarzare: various cleanups/fixes]
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v2:
>>- rebased on top of other changes (dev_attr, get_config(), notify(), etc.)
>>- memset to 0 the config structure in vdpasim_blk_get_config()
>>- used vdpasim pointer in vdpasim_blk_get_config()
>>
>>v1:
>>- Removed unused headers
>>- Used cpu_to_vdpasim*() to store config fields
>>- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>>   option can not depend on other [Jason]
>>- Start with a single queue for now [Jason]
>>- Add comments to memory barriers
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 145 +++++++++++++++++++++++++++
>>  drivers/vdpa/Kconfig                 |   7 ++
>>  drivers/vdpa/vdpa_sim/Makefile       |   1 +
>>  3 files changed, 153 insertions(+)
>>  create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>new file mode 100644
>>index 000000000000..999f9ca0b628
>>--- /dev/null
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>>@@ -0,0 +1,145 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+/*
>>+ * VDPA simulator for block device.
>>+ *
>>+ * Copyright (c) 2020, Mellanox Technologies. All rights reserved.
>
>I guess we can change the copyright from Mellanox to:
>
>Copyright (c) 2020, NVIDIA CORPORATION. All rights reserved.

I'll update in the next version.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
