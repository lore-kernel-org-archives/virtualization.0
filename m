Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27ECEE8019
	for <virtualization@archiver.kernel.org>; Fri,  8 Sep 2023 15:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73B08415CB;
	Fri,  8 Sep 2023 15:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73B08415CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMLL-z67XI3s; Fri,  8 Sep 2023 15:41:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D671A405B7;
	Fri,  8 Sep 2023 15:41:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D671A405B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4F64C0039;
	Fri,  8 Sep 2023 15:41:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D076BC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D83640616
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:41:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D83640616
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnIf3YeXBRF5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:41:15 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A895940151
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Sep 2023 15:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A895940151
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4C175614FB;
 Fri,  8 Sep 2023 15:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ADDC433CB;
 Fri,  8 Sep 2023 15:41:12 +0000 (UTC)
Date: Fri, 8 Sep 2023 16:41:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH v2] virtio-mmio: fix memory leak of vm_dev
Message-ID: <ZPtAljIVLvOiliDN@arm.com>
References: <20230907141716.88863-1-mheyne@amazon.de>
 <ZPn6KZpdPdG2LQqL@arm.com>
 <20230908113840.GA19696@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230908113840.GA19696@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
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

On Fri, Sep 08, 2023 at 11:38:40AM +0000, Maximilian Heyne wrote:
> On Thu, Sep 07, 2023 at 05:28:25PM +0100, Catalin Marinas wrote:
> > On Thu, Sep 07, 2023 at 02:17:16PM +0000, Maximilian Heyne wrote:
> > > With the recent removal of vm_dev from devres its memory is only freed
> > > via the callback virtio_mmio_release_dev. However, this only takes
> > > effect after device_add is called by register_virtio_device. Until then
> > > it's an unmanaged resource and must be explicitly freed on error exit.
> > >
> > > This bug was discovered and resolved using Coverity Static Analysis
> > > Security Testing (SAST) by Synopsys, Inc.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> > > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Who would apply this patch?

The virtio maintainers (Michael, Jason).

> Something seems to have choked my patch so it didn't
> reach lore.kernel.org (message couldn't be delivered due to timeout). Should I
> try to send it again?

You can send a v3 with the added acks. It's strange that it didn't make
it to lore. I got it as I was cc'ed but checking the archives, it's not
there.

-- 
Catalin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
