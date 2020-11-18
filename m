Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3B2C63697
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:01:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3332468D
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gX8uJ6i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3332468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 67BDA871A8;
	Wed, 18 Nov 2020 09:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwJnfiI98oJD; Wed, 18 Nov 2020 09:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0A1B87183;
	Wed, 18 Nov 2020 09:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B66AAC0800;
	Wed, 18 Nov 2020 09:01:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFD0DC07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A09D0867A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMGenL+VJxtH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:01:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 78D6786672
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605690060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7wqEQsvX22nx16Jojzb8KFZiOjvsM4OAXsB57jTMi5g=;
 b=gX8uJ6i5nfjv6AjTK92knEoCDkERJargMYXs2csnKHXLyPvjY0WgRKPqA51JNPmO9ssR2H
 DCvsgveWCVT6Abt2PF1/cQkmWbjEs6kEcPAYIic/plH2ouIa0MGPu+n77TTur5VImA/AFh
 m02o8IGN7ZgwS/fj4kitlr0wxPdl9pw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-2N1wxjY5PRCnTvtQQPEbLA-1; Wed, 18 Nov 2020 04:00:59 -0500
X-MC-Unique: 2N1wxjY5PRCnTvtQQPEbLA-1
Received: by mail-wr1-f71.google.com with SMTP id w6so657148wrk.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 01:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7wqEQsvX22nx16Jojzb8KFZiOjvsM4OAXsB57jTMi5g=;
 b=FsqJvapuBam1GZYzpxJzPqiw3WjPFAEs7IacvgVT4/1jExIqVYeo5VvPQqu79o/mnK
 SmBHikEZIyFsT3EeinHcE+rKVlEdx6PhS9WuyijtwMqsf+8Q2bpjqegsFgSecelI528/
 Lq7cCWaBqtSsmF1c8bhcsZK8QteZ4NnzbDblqUHTitDlgAmi2GvPj23DjlXIejOwtCTJ
 WbuHEVlQdkjSnE7RZS5BYOAeoVjag59RkmXlR3cVmcAfIgpO4WNxpjIzOh9s5bDufWTI
 CVHiBzWly4cH7ZGr8tWZ8WugJMiK34NNoPLgigP44+wFAZ99iSt5TSDb29DKvPYUhece
 A99Q==
X-Gm-Message-State: AOAM530O2BDVzKwih8ue/5GnJyEVb/uu/WtUjY6Xum+pwHVtlPnGn+e/
 MhUw+ZVL3+JsmGE70a3YCce8LZ6j6AwAdwl6/B1tV5o27dU0e8gZH0KeXpzdJbeeW2zmAfPO+2c
 35ZMIC7kOxCvf1qZQmeZgjgFPnom+dRbaBzq9/siK6Q==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr3616030wrr.353.1605690057431; 
 Wed, 18 Nov 2020 01:00:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIcY5c9fabl6ughyv2LZhAK3/bgxlHsBiPuOq6RbM1KZQEh4wZshXsh3Bu1z6logi57UI1Rw==
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr3616013wrr.353.1605690057263; 
 Wed, 18 Nov 2020 01:00:57 -0800 (PST)
Received: from redhat.com (bzq-79-181-34-244.red.bezeqint.net. [79.181.34.244])
 by smtp.gmail.com with ESMTPSA id n10sm31309533wrv.77.2020.11.18.01.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 01:00:56 -0800 (PST)
Date: Wed, 18 Nov 2020 04:00:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 00/29] virtio-mem: Big Block Mode (BBM)
Message-ID: <20201118040030-mutt-send-email-mst@kernel.org>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
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

On Thu, Nov 12, 2020 at 02:37:46PM +0100, David Hildenbrand wrote:
> @Andrew, can we have an ack for patch #27, so that one can go via
> the vhost tree for 5.11?

OK, we got an ack, I'll put it in next now.
Thanks!

> ---
> 
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
> 
> Patch #1 - #10 are cleanups and optimizations
> Patch #11 - #24 are refactorings to prepare for BBM
> Patch #25 - #29 implement BBM, including one mm/memory_hotplug extension
> 
> This series is based on latest linus/master and can be found at:
>  git@github.com:davidhildenbrand/linux.git virtio-mem-bbm-v2
> 
> v1 -> v2:
> - Code wise, the only bigger change is using an union for sbm/bbm state
> - Reworked some subjects/patch descriptions
> - Reshuffled patches to make reviweing easier, and to have
>   cleanups+optimizations before all refactorings
> - "virtio-mem: more precise calculation in
>    virtio_mem_mb_state_prepare_next_mb()"
> -- Changed subject
> -- Avoid two local variables
> 
> David Hildenbrand (29):
>   virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
>   virtio-mem: more precise calculation in
>     virtio_mem_mb_state_prepare_next_mb()
>   virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
>   virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
>   virtio-mem: use "unsigned long" for nr_pages when fake
>     onlining/offlining
>   virtio-mem: factor out calculation of the bit number within the
>     subblock bitmap
>   virtio-mem: print debug messages from virtio_mem_send_*_request()
>   virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
>   virtio-mem: factor out handling of fake-offline pages in memory
>     notifier
>   virtio-mem: retry fake-offlining via alloc_contig_range() on
>     ZONE_MOVABLE
>   virtio-mem: generalize check for added memory
>   virtio-mem: generalize virtio_mem_owned_mb()
>   virtio-mem: generalize virtio_mem_overlaps_range()
>   virtio-mem: drop last_mb_id
>   virtio-mem: don't always trigger the workqueue when offlining memory
>   virtio-mem: generalize handling when memory is getting onlined
>     deferred
>   virito-mem: document Sub Block Mode (SBM)
>   virtio-mem: memory block states are specific to Sub Block Mode (SBM)
>   virito-mem: subblock states are specific to Sub Block Mode (SBM)
>   virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block
>     Mode (SBM)
>   virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
>   virito-mem: existing (un)plug functions are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: memory notifier callbacks are specific to Sub Block Mode
>     (SBM)
>   virtio-mem: factor out adding/removing memory from Linux
>   virtio-mem: Big Block Mode (BBM) memory hotplug
>   virtio-mem: allow to force Big Block Mode (BBM) and set the big block
>     size
>   mm/memory_hotplug: extend offline_and_remove_memory() to handle more
>     than one memory block
>   virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
>   virtio-mem: Big Block Mode (BBM) - safe memory hotunplug
> 
>  drivers/virtio/virtio_mem.c | 1789 +++++++++++++++++++++++++----------
>  mm/memory_hotplug.c         |  105 +-
>  2 files changed, 1376 insertions(+), 518 deletions(-)
> 
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
