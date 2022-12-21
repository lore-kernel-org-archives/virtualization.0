Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178F5C10F1B
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 09:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B0F381F27;
	Wed, 21 Dec 2022 09:13:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B0F381F27
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D1XLT/rY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IWPceFMLG_oo; Wed, 21 Dec 2022 09:13:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AD1781EDE;
	Wed, 21 Dec 2022 09:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AD1781EDE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88DAAC0071;
	Wed, 21 Dec 2022 09:13:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F059C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5E1B81EDE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5E1B81EDE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ChZ_qGIwlDVt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA2EF81EDB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA2EF81EDB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671613988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9B1AE9iXfUV5VO4gONRrYR5hHzr17wsWJVUV7OEY3E=;
 b=D1XLT/rYhYT7HMVsT0S7YCEtvLL93mvb7TBBu4YDcE8+SYIDdUA3klqqpbQiL72wKYhFms
 d2eKQK+1atgtUdPY3R82K3+ACViPwQP9lGvVIdthr01zvvxQ+FqsLtwsrbcpDzGfcVkUv+
 r7BLlzAh+xyCMzJvExps1nzNbCN0CU0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-77-sygW1vlWOZO1gVK_Y0IGOA-1; Wed, 21 Dec 2022 04:13:07 -0500
X-MC-Unique: sygW1vlWOZO1gVK_Y0IGOA-1
Received: by mail-ej1-f71.google.com with SMTP id
 qw20-20020a1709066a1400b007c1727f7c55so10003861ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 01:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9B1AE9iXfUV5VO4gONRrYR5hHzr17wsWJVUV7OEY3E=;
 b=y/AtXYxVm8+jE3UADop6eoirkAyDYke9BOGbLZWOe6u2XQ+e+GKhrVCZLqxo6c6PFF
 WdiVemRTMCS8XESoV1QxWPfgbYFTqh9N+kZ0+bVXCfmDVJIwIHttKOR4dLL9AZVWp8h/
 g8xJjKTWu4KmlUfT/co2jwftyoygdINIOY5t2SaYLqnGF90y8i89ecp/pGPhpPkAB6d2
 TArwjCuEsr6f2tGn+jUNdixfy+X5MGosOuDmq5hXLbabunYZPxufN+FDiqenmYQj6SeK
 5JjgT1QORAEMy6vrt5LUncAdq6FiTUuuvmnaRDF45zTnPoCCMJzqTPRGsIiRpMATdtEk
 Mkig==
X-Gm-Message-State: AFqh2koHMefb54vag+GkKxC/qxVh7h/UEJMXwjaKtSAwyhZDHZSQenVX
 IK9LpLIGnaC3+6fCPkEnncuPnNBxCaZlnrMA47cZoCd/mO6PD2q5O0kU8IgHHPcHBdl4PH3Tw0G
 RZ89pjiiUDwFPsT6HZae3K38+ptQJmVIMCBPGY2j0sQ==
X-Received: by 2002:a17:906:6441:b0:7c1:994c:f168 with SMTP id
 l1-20020a170906644100b007c1994cf168mr4585938ejn.54.1671613986264; 
 Wed, 21 Dec 2022 01:13:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu4K0F4pqOQKTW+FeVXRl7LTyqCua6J0mFvEILbLF6Z4guSWcyoysAbSikqTK6jLvlp7X2krw==
X-Received: by 2002:a17:906:6441:b0:7c1:994c:f168 with SMTP id
 l1-20020a170906644100b007c1994cf168mr4585934ejn.54.1671613986092; 
 Wed, 21 Dec 2022 01:13:06 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 d19-20020a170906305300b007c4f8bc322asm6653739ejd.196.2022.12.21.01.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 01:13:05 -0800 (PST)
Date: Wed, 21 Dec 2022 10:13:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [PATCH] tools/virtio: fix the vringh test for virtio ring changes
Message-ID: <20221221091302.mxnmrnqvn7oua7nf@sgarzare-redhat>
References: <20221221075506.3291148-1-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20221221075506.3291148-1-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Dec 21, 2022 at 04:55:06PM +0900, Shunsuke Mie wrote:
>Fix the build caused by missing kmsan_handle_dma() and is_power_of_2() that
>are used in drivers/virtio/virtio_ring.c.
>
>Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>---
> tools/virtio/linux/cpumask.h  |  7 +++++++
> tools/virtio/linux/gfp.h      |  7 +++++++
> tools/virtio/linux/kernel.h   |  1 +
> tools/virtio/linux/kmsan.h    | 12 ++++++++++++
> tools/virtio/linux/log2.h     | 11 +++++++++++
> tools/virtio/linux/topology.h |  7 +++++++
> 6 files changed, 45 insertions(+)
> create mode 100644 tools/virtio/linux/cpumask.h
> create mode 100644 tools/virtio/linux/gfp.h
> create mode 100644 tools/virtio/linux/kmsan.h
> create mode 100644 tools/virtio/linux/log2.h
> create mode 100644 tools/virtio/linux/topology.h
>
>diff --git a/tools/virtio/linux/cpumask.h b/tools/virtio/linux/cpumask.h
>new file mode 100644
>index 000000000000..307da69d6b26
>--- /dev/null
>+++ b/tools/virtio/linux/cpumask.h
>@@ -0,0 +1,7 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef _LINUX_CPUMASK_H
>+#define _LINUX_CPUMASK_H
>+
>+#include <linux/kernel.h>
>+
>+#endif /* _LINUX_CPUMASK_H */
>diff --git a/tools/virtio/linux/gfp.h b/tools/virtio/linux/gfp.h
>new file mode 100644
>index 000000000000..43d146f236f1
>--- /dev/null
>+++ b/tools/virtio/linux/gfp.h
>@@ -0,0 +1,7 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef __LINUX_GFP_H
>+#define __LINUX_GFP_H
>+
>+#include <linux/topology.h>
>+
>+#endif
>diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>index 21593bf97755..8b877167933d 100644
>--- a/tools/virtio/linux/kernel.h
>+++ b/tools/virtio/linux/kernel.h
>@@ -10,6 +10,7 @@
> #include <stdarg.h>
>
> #include <linux/compiler.h>
>+#include <linux/log2.h>
> #include <linux/types.h>
> #include <linux/overflow.h>
> #include <linux/list.h>
>diff --git a/tools/virtio/linux/kmsan.h b/tools/virtio/linux/kmsan.h
>new file mode 100644
>index 000000000000..272b5aa285d5
>--- /dev/null
>+++ b/tools/virtio/linux/kmsan.h
>@@ -0,0 +1,12 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef _LINUX_KMSAN_H
>+#define _LINUX_KMSAN_H
>+
>+#include <linux/gfp.h>
>+
>+inline void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
>+			     enum dma_data_direction dir)
>+{
>+}
>+
>+#endif /* _LINUX_KMSAN_H */
>diff --git a/tools/virtio/linux/log2.h b/tools/virtio/linux/log2.h
>new file mode 100644
>index 000000000000..aa67bb21d8e2
>--- /dev/null
>+++ b/tools/virtio/linux/log2.h
>@@ -0,0 +1,11 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+
>+#ifndef _LINUX_LOG2_H
>+#define _LINUX_LOG2_H
>+
>+inline bool is_power_of_2(unsigned long n)
>+{
>+	return true;
>+}

is_power_of_2 seems defined in tools/include/linux/log2.h so
`#include <linux/log2.h>` in tools/virtio/linux/kernel.h should be
enough.

If that's not the case, however, I think we should return true here only
if n is really power of 2.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
