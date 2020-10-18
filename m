Return-Path: <SRS0=CB8P=DZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5ECC433E7
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:29:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2267821D7F
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXnQy3eE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2267821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8AB64227AD;
	Sun, 18 Oct 2020 15:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9QR+jzvUmXg; Sun, 18 Oct 2020 15:29:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0A10C20770;
	Sun, 18 Oct 2020 15:29:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E968AC0052;
	Sun, 18 Oct 2020 15:29:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55774C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3B34B8775C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ld6Acch2Eg+5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:29:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0588487694
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603034965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1CTKIbN/xVjEnO6qY3wyEbNeQNs54uP2PLOt/PBfoP4=;
 b=VXnQy3eErQJcQYa/w3E/uS8VDdgcn0Rl1c9nAtEfndjUTwvoXHtRiRoHhz4uZXMP9RIb4j
 ika4qYpqaJt5PDHrV1BjvldVFu9Cl+XvEEynUvIn3Ny3r3TJAf+l7WinCJuNa6nksYfjhf
 cjdRQ6925qZbM4p2SzT8kTJroI95zlU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-pp8fZdv_OI6li9-G2XL5WQ-1; Sun, 18 Oct 2020 11:29:21 -0400
X-MC-Unique: pp8fZdv_OI6li9-G2XL5WQ-1
Received: by mail-wr1-f71.google.com with SMTP id t11so6252953wrv.10
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 08:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1CTKIbN/xVjEnO6qY3wyEbNeQNs54uP2PLOt/PBfoP4=;
 b=fiQh8z/9J+YcgzZ9z4GvV1IK5XdZkwPraJOcLxTL/ZT43K9OHzGCNGdzvezsyzqAjZ
 v/By3/CXonGZssydYxvMK8gWZYAcbvtB3QORCsd0GAwQ8iTanSnoAlC5/BwNV0DWSask
 BvbsEbVvzeAEVlu9a7mYmHf1fHM4rHoDXBv/1KxUTF8mP0ShgbzUKjaarYOIyPUp0h1n
 7vknzHAeA5RaJsjl5ADDE1++F2Q/un/DaW0aexsNPKIiXz0c8GbNrIXhp4HY+W5CWI3V
 R5tfZbe160s3kptM7BQmxeTznvZw07uQ36mXci4l52cHmJYXV3LcDLoeOjwFxyhDkb/G
 zzjw==
X-Gm-Message-State: AOAM533ayrVutPo2DJpCo/QnbxyDIKRheQT67BeedZKAA3+RJb8ABhsy
 ipUJLwcGzhq4D/ULJd9cy5hILG66Lb+Z4mBooBm79okqdVIakR/qpa9eMVTOQXtZ8wKnYZmN0gH
 bK5NgCN1RS0mzys/UbOQ5KAIxwHZ9K15zAQFQ/WCLwA==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr13134899wmk.43.1603034960406; 
 Sun, 18 Oct 2020 08:29:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdSke2D/bQ/4Rv046vND4iUOBVEXFQoAjUmmIvF3U1fKjAq8Hc0bRgog5vC4nNUSJIsqNYWw==
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr13134876wmk.43.1603034960186; 
 Sun, 18 Oct 2020 08:29:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id u81sm12089933wmg.43.2020.10.18.08.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 08:29:19 -0700 (PDT)
Date: Sun, 18 Oct 2020 11:29:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 00/29] virtio-mem: Big Block Mode (BBM)
Message-ID: <20201018112849-mutt-send-email-mst@kernel.org>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 virtualization@lists.linux-foundation.org, Oscar Salvador <osalvador@suse.de>
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

On Mon, Oct 12, 2020 at 02:52:54PM +0200, David Hildenbrand wrote:
> virtio-mem currently only supports device block sizes that span at most
> a single Linux memory block. For example, gigantic pages in the hypervisor
> result on x86-64 in a device block size of 1 GiB - when the Linux memory
> block size is 128 MiB, we cannot support such devices (we fail loading the
> driver). Of course, we want to support any device block size in any Linux
> VM.
> 
> Bigger device block sizes will become especially important once supporting
> VFIO in QEMU - each device block has to be mapped separately, and the
> maximum number of mappings for VFIO is 64k. So we usually want blocks in
> the gigabyte range when wanting to grow the VM big.

I guess it missed this Linux right? There's an mm change which did not
get an ack from mm mainatiners, so I can't merge it ...

> This series:
> - Performs some cleanups
> - Factors out existing Sub Block Mode (SBM)
> - Implements memory hot(un)plug in Big Block Mode (BBM)
> 
> I need one core-mm change, to make offline_and_remove_memory() eat bigger
> chunks.
> 
> This series is based on "next-20201009" and can be found at:
> 	git@gitlab.com:virtio-mem/linux.git virtio-mem-dbm-v1
> 
> Once some virtio-mem patches that are pending in the -mm tree are upstream
> (I guess they'll go in in 5.10), I'll resend based on Linus' tree.
> I suggest to take this (including the MM patch, acks/review please) via the
> vhost tree once time has come. In the meantime, I'll do more testing.
> 
> David Hildenbrand (29):
>   virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
>   virtio-mem: simplify calculation in
>     virtio_mem_mb_state_prepare_next_mb()
>   virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
>   virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
>   virtio-mem: generalize check for added memory
>   virtio-mem: generalize virtio_mem_owned_mb()
>   virtio-mem: generalize virtio_mem_overlaps_range()
>   virtio-mem: drop last_mb_id
>   virtio-mem: don't always trigger the workqueue when offlining memory
>   virtio-mem: generalize handling when memory is getting onlined
>     deferred
>   virtio-mem: use "unsigned long" for nr_pages when fake
>     onlining/offlining
>   virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
>   virtio-mem: factor out handling of fake-offline pages in memory
>     notifier
>   virtio-mem: retry fake-offlining via alloc_contig_range() on
>     ZONE_MOVABLE
>   virito-mem: document Sub Block Mode (SBM)
>   virtio-mem: memory block states are specific to Sub Block Mode (SBM)
>   virito-mem: subblock states are specific to Sub Block Mode (SBM)
>   virtio-mem: factor out calculation of the bit number within the
>     sb_states bitmap
>   virito-mem: existing (un)plug functions are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block
>     Mode (SBM)
>   virtio-mem: memory notifier callbacks are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
>   virtio-mem: factor out adding/removing memory from Linux
>   virtio-mem: print debug messages from virtio_mem_send_*_request()
>   virtio-mem: Big Block Mode (BBM) memory hotplug
>   virtio-mem: allow to force Big Block Mode (BBM) and set the big block
>     size
>   mm/memory_hotplug: extend offline_and_remove_memory() to handle more
>     than one memory block
>   virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
>   virtio-mem: Big Block Mode (BBM) - safe memory hotunplug
> 
>  drivers/virtio/virtio_mem.c | 1783 +++++++++++++++++++++++++----------
>  mm/memory_hotplug.c         |  105 ++-
>  2 files changed, 1373 insertions(+), 515 deletions(-)
> 
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
