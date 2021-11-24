Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D957C433F5
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 08:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB78240205;
	Wed, 24 Nov 2021 08:38:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-Q2iMTg4T_5; Wed, 24 Nov 2021 08:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 641B54011F;
	Wed, 24 Nov 2021 08:38:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37F84C002E;
	Wed, 24 Nov 2021 08:38:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0834FC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 08:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D84CC80D4F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 08:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xGvBKuuTh1H
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 08:38:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E542E80D67
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637743083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ew0/8OcB0nHB+hKeOXSMunpXDkwrDFkJCK+wFmTlwpw=;
 b=iqIazOAsRgA2GIx93JjL+OISQzyMkbHkS8vypIujk0uqN1dthG18YOiL4BOerJ14y2lu9Z
 9HHumJGsXZvGm1LljJG9092TpT9lvRyEDJkvL4ul8ornOhlYSWcbB6JbMbkQgQ/5CiT69X
 w3g12CEJdzWZ60k+brZfPuJQG/2Xfs4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-B4n4PIYBODGeOgkVCvOEaw-1; Wed, 24 Nov 2021 03:38:02 -0500
X-MC-Unique: B4n4PIYBODGeOgkVCvOEaw-1
Received: by mail-ed1-f69.google.com with SMTP id
 bx28-20020a0564020b5c00b003e7c42443dbso1568705edb.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 00:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ew0/8OcB0nHB+hKeOXSMunpXDkwrDFkJCK+wFmTlwpw=;
 b=ly86OK8etATSrOmL5bashlnTVmbtperuplVmXSJcgGXVi7piBzO16t0Dy5FwGJxu05
 /zaFG6vER2xbyHimFIuJUvug0KtF4kBhIdiALSIU3eJQF/YF649/FzmBPLphc+MFWib6
 fe1ps7OZkbSPTYi3Sf3etwyvM/OmHun7spA9wJy/2RZZWHDTrRzfjqgrSvAnpve1Z7g6
 NVAtT/doWpZZSAjlWp+cHhzNURhfXZEYl98XlyoRpAwFEXbb7496NHC2dc4BzV1cyudS
 S1UISV6I7/QiqywIUDvnrjTw8IkdXJrVigj2C7gvXRbj451y9J9cnPD4QNkaN/MKm1zG
 uv6g==
X-Gm-Message-State: AOAM530MA44Z6iOPsCWia86CfIvjGKtfy9hKEZT8lF9dC0Q8NZfWTPpV
 07s2uA3FF4utP1F6aS6umQak6QyOe1W9uOKtsDoBfAIPDXB6Bn6bCFgGMZt+XIdf43BfXk+9tOB
 kdxSG7MLnkXeF3ciFzUOU1oDApYxRUm9X3xd7K3wuXw==
X-Received: by 2002:aa7:cada:: with SMTP id l26mr21846880edt.376.1637743080831; 
 Wed, 24 Nov 2021 00:38:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRKYDPJsWfWbpwgMl3Ck7YSdSgHyeVN3u7vgEpNX/bGXsRpFpwHnV/4SZHyqaHxUpcGOtohQ==
X-Received: by 2002:aa7:cada:: with SMTP id l26mr21846826edt.376.1637743080570; 
 Wed, 24 Nov 2021 00:38:00 -0800 (PST)
Received: from redhat.com ([2.55.144.93])
 by smtp.gmail.com with ESMTPSA id r3sm6439039ejr.79.2021.11.24.00.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 00:37:59 -0800 (PST)
Date: Wed, 24 Nov 2021 03:37:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v2] virtio_balloon: add param to skip adjusting pages
Message-ID: <20211124032622-mutt-send-email-mst@kernel.org>
References: <20211118091130.3817665-1-stevensd@google.com>
 <290e140c-abc1-76b8-e036-5b550b8b99c4@redhat.com>
 <CAD=HUj7i7foyPE8a6dhj+=UR2jn5_vaQx-3jjKtjYrY8iSJWzw@mail.gmail.com>
 <3ecd8132-ad5c-0a37-7334-d58ccc58a495@redhat.com>
 <eec5cc46-ec6d-e997-c8f1-9a7d3c57468c@redhat.com>
 <CAD=HUj5wPYLKJxsjgcnMu_NYQ6eMwmd-VDU0gbWbqgzOPkV6fg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj5wPYLKJxsjgcnMu_NYQ6eMwmd-VDU0gbWbqgzOPkV6fg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Wed, Nov 24, 2021 at 01:55:16PM +0900, David Stevens wrote:
> > >> And if you look at things from the context of
> > >> a specific userspace process, there will be other processes running
> > >> and using memory. So while that statement is true with respect to this
> > >> change, that is also true without this change. The specific details
> > >> might be changed by the proposed parameter, but it wouldn't be
> > >> introducing any fundamentally new behavior to Linux.
> > >>
> > >
> > > Please note that the hyper-v balloon just recently switched to using
> > > adjust_managed_page_count() proper accounting reasons:
> > >
> > > commit d1df458cbfdb0c3384c03c7fbcb1689bc02a746c
> > > Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Date:   Wed Dec 2 17:12:45 2020 +0100
> > >
> > >     hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning
> > >
> > >     Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
> > >     does not adjust managed pages count when ballooning/un-ballooning and this leads
> > >     to incorrect stats being reported, e.g. unexpected 'free' output.
> > >
> > >     Note, the calculation in post_status() seems to remain correct: ballooned out
> > >     pages are never 'available' and we manually add dm->num_pages_ballooned to
> > >     'commited'.
> > >
> 
> I saw this commit, but it wasn't entirely clear to me the problem it
> was addressing was. Is it the issue Michael pointed out on v1 of my
> patch set, where memory in the balloon shouldn't be included in the
> free stat reported to the device? This version of my patch should
> address that specific issue. Managed page count is linux kernel
> specific metadata, so there's no fundamental reason that it needs to
> line up exactly with anything reported via the virtio-balloon API.
> 
> > >> That approach would require a lot of changes to userspace - probably
> > >> nearly everywhere that uses _SC_PHYS_PAGES or get_phys_pages, or
> > >> anywhere that parses /proc/meminfo. Actually properly using "logically
> > >> offline pages" would require an additional API for monitoring changes
> > >> to the value, and updating to that sort of listener API would not be a
> > >> localized change, especially since most programs do not account for
> > >> memory hotplug and just use the amount of physical memory during
> > >> initialization. Realistically, nearly all of the callers would simply
> > >> add together "logically offline pages" and MemTotal.
> > >
> > > I'd appreciate a more generic approach for user space to figure out the
> > > "initial memory size" in a virtualized environment than adding
> > > some module parameter to virtio-balloon -- if that makes sense.
> > >
> > > MemTotal as is expresses how much memory the buddy currently manages,
> > > for example, excluding early allocations during boot, excluding actually
> > > unplugged memory and excluding logically unplugged memory. Adjusting that
> > > value makes perfect sense for virtio-balloon without deflate-on-oom.
> > >
> 
> That's a definition of how MemTotal is implemented, but it's not
> really a specification of the MemTotal API. The closest thing to a
> real specification I can find is "Total usable RAM (i.e., physical RAM
> minus a few reserved bits and the kernel binary code)", from the proc
> man pages. I think there is quite a bit of leeway in changing how
> exactly MemTotal is implemented without violating the (quite vague)
> specification or changing any observable semantics of the API. In
> particular, leaving the pages in the balloon as part of MemTotal is
> essentially indistinguishable from simply having a non-OOM killable
> process locking an equivalent amount of memory. So this proposal isn't
> really introducing any fundamentally new behavior to the Linux kernel.
> 
> > >> It's also not clear to me what utility the extra information would
> > >> provide to userspace. If userspace wants to know how much memory is
> > >> available, they should use MemAvailable. If userspace wants to have a
> > >> rough estimate for the maximum amount of memory in the system, they
> > >> would add together MemTotal and "logically offline pages". The value
> > >> of MemTotal with a no-deflate-on-oom virtio-balloon is a value with a
> > >> vague meaning that lies somewhere between the "maximum amount of
> > >> memory" and the "current amount of memory". I don't really see any
> > >> situations where it should clearly be used over one of MemAvailable or
> > >> MemTotal + "logically offline pages".
> > >
> > > The issue is that any application that relies on MemTotal in a virtualized
> > > environment is most probably already suboptimal in some cases. You can
> > > rely on it and actually later someone will unplug (inflate balloon)
> > > memory or plug (deflate balloon) memory. Even MemAvailable is suboptimal
> > > because what about two applications that rely on that information at
> > > the same time?
> > >
> >
> > BTW, the general issue here is that "we don't know what the hypervisor
> > will do".
> 
> I do agree that this is a significant problem. I would expand on it a
> bit more, to be "since we don't know what the hypervisor will do, we
> don't know how to treat memory in the balloon". The proposed module
> parameter is more or less a mechanism to allow the system
> administrator to tell the virtio_balloon driver how the hypervisor
> behaves.


Now that you put it that way, it looks more like this should
be a feature bit not a module parameter.



> And if the hypervisor will give memory back to the guest when
> the guest needs it, then I don't think it's not necessary to logically
> unplug the memory.

Ideally we would also pair this with sending a signal to device
that memory is needed.

> It might be a bit cleaner to explicitly address this in the
> virtio_balloon protocol. We could add a min_num_pages field to the
> balloon config, with semantics along the lines of "The host will
> respond to memory pressure in the guest by deflating the balloon down
> to min_num_pages, unless it would cause system instability in the
> host". Given that feature, I think it would be reasonable to only
> consider min_num_pages as logically unplugged.

Okay. I think I would do it a bit differently though, make num_pages be
the min_num_pages, and add an extra_num_pages field for memory that is
nice to have but ok to drop.


As long as we are here, can we add a page_shift field please
so more than 2^44 bytes can be requested?


> > Maybe "MemMax" actually could make sense, where we expose the maximum
> > "MemTotal" we had so far since we were up an running. So the semantics
> > wouldn't be "maximum possible", because we don't know that, but instead
> > "maximum we had".
> 
> Rather than add a new API, I think it is much better to make existing
> APIs behave closer to how they behave in a non-virtualized
> environment. It is true that we could go through and fix a limited
> number of special user space applications, but sysconf(_SC_PHYS_PAGES)
> and /proc/meminfo are not special APIs. Fixing every application that
> uses them is not feasible, especially when taking into account systems
> with closed-source applications (e.g. Android). Also, while MemMax is
> well defined, it has the same issues you brought up earlier -
> specifically, applications don't know whether the hypervisor will
> actually ever provide MemMax again, and they don't know whether MemMax
> is actually the realy maximum amount of memory that could be available
> in the future. It's not clear to me that it's significantly better or
> more useful to userspace than simply changing how MemTotal is
> implemented.
> 
> -David

Agree on trying to avoid changing applications, limiting changes
to device and guest kernel, this has a lot of value.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
