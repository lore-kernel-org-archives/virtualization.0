Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC975EC873E
	for <virtualization@archiver.kernel.org>; Thu,  7 Sep 2023 16:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 424D34053C;
	Thu,  7 Sep 2023 16:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 424D34053C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NAlwTyMGetes; Thu,  7 Sep 2023 16:28:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D420A40488;
	Thu,  7 Sep 2023 16:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D420A40488
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB054C0039;
	Thu,  7 Sep 2023 16:28:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E278EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 16:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAE614030F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 16:28:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAE614030F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFgxDxuw8OGk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 16:28:30 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA9244030E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 16:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA9244030E
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0D4356103B;
 Thu,  7 Sep 2023 16:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2A4C433CA;
 Thu,  7 Sep 2023 16:28:27 +0000 (UTC)
Date: Thu, 7 Sep 2023 17:28:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH v2] virtio-mmio: fix memory leak of vm_dev
Message-ID: <ZPn6KZpdPdG2LQqL@arm.com>
References: <20230907141716.88863-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230907141716.88863-1-mheyne@amazon.de>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
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

On Thu, Sep 07, 2023 at 02:17:16PM +0000, Maximilian Heyne wrote:
> With the recent removal of vm_dev from devres its memory is only freed
> via the callback virtio_mmio_release_dev. However, this only takes
> effect after device_add is called by register_virtio_device. Until then
> it's an unmanaged resource and must be explicitly freed on error exit.
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
