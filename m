Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE97EC56202
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 04:58:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB9F20888
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 04:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tie7eb5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB9F20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F7B1826E0;
	Wed, 18 Nov 2020 04:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ObbisV86qp0; Wed, 18 Nov 2020 04:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 62BA781ADE;
	Wed, 18 Nov 2020 04:58:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 566B0C0891;
	Wed, 18 Nov 2020 04:58:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C05C1C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AE642204BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cc-3Gq76SCAP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:58:56 +0000 (UTC)
X-Greylist: delayed 00:05:53 by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id E10C3203C2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:58:56 +0000 (UTC)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50EF92463B;
 Wed, 18 Nov 2020 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1605675182;
 bh=YCosJ2qYaKYkNcdNS2lsX13OGUTapFeLurPSXtSY+yk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Tie7eb5a7TGFHuXfQKFc18si/9EZtnUmgSFQYX4CGvs5aVPpW1/N6cLGDnv9rC6UC
 zxkxaptgjS5j619jNjOTbYBMfZK21CQSMde6I8vSErrktiKlLf8Ra7hO19t9nbYWD8
 Z0U5Huazt/VSjcrl/OKncScPsDznNsmv5IAMZfx8=
Date: Tue, 17 Nov 2020 20:53:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 27/29] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Message-Id: <20201117205301.bcef9773f3557a764d17b8df@linux-foundation.org>
In-Reply-To: <20201112133815.13332-28-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
 <20201112133815.13332-28-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>
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

On Thu, 12 Nov 2020 14:38:13 +0100 David Hildenbrand <david@redhat.com> wrote:

> virtio-mem soon wants to use offline_and_remove_memory() memory that
> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
> remove that restriction.
> 
> Let's remember the old state and try to restore that if anything goes
> wrong. While re-onlining can, in general, fail, it's highly unlikely to
> happen (usually only when a notifier fails to allocate memory, and these
> are rather rare).
> 
> This will be used by virtio-mem to offline+remove memory ranges that are
> bigger than a single memory block - for example, with a device block
> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
> block size of 128MB.
> 
> While we could compress the state into 2 bit, using 8 bit is much
> easier.
> 
> This handling is similar, but different to acpi_scan_try_to_offline():
> 
> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
> optimization is still relevant - it should only apply to ZONE_NORMAL
> (where we have no guarantees). If relevant, we can always add it.
> 
> b) acpi_scan_try_to_offline() simply onlines all memory in case
> something goes wrong. It doesn't restore previous online type. Let's do
> that, so we won't overwrite what e.g., user space configured.
> 
> ...
>

uint8_t is a bit of a mouthful.  u8 is less typing ;)  Doesn't matter.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
