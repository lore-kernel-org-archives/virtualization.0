Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D6AC433FE
	for <virtualization@archiver.kernel.org>; Wed, 15 Dec 2021 16:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 898BE415B2;
	Wed, 15 Dec 2021 16:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l6QX1xz440Qq; Wed, 15 Dec 2021 16:46:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA48841583;
	Wed, 15 Dec 2021 16:46:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBDA9C002F;
	Wed, 15 Dec 2021 16:46:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47A2BC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 16:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2702960E9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 16:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sFSLOGduzeyM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 16:46:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 778E760EB5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 16:46:28 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id o14so16914256plg.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zYAnJX+TpDGLkEzNmA27WFkqeU//5jbR+UQpskrIy5I=;
 b=kkabp0tXSY3ReH2D3KZMrsifXVc9rJJ6PrTgRFZ8gD9AdXtYiUQ//ZGjx3VH9KjuWD
 hNsIKstKwW82iaDXmRFXCdyLAA0lrEdIViQtyCNgzvG/KVIFwlMAf0vfe9DnvkwsYbUh
 KsFUMxlz6n14jE8yPGWuNF1TUPnr2r89bpquMm+I6+nUmnNnAniDCvG+Ej20pZm5llBQ
 atsGUASafXKTnlAQVSwSuww5AniywCj37Eh5LF6rweEojSWhlI3q0OdLudJu7galsQsk
 n0rPDXkDS4NjHtuGVXQ0QXEBLhIybIsv3OtRD0baE/WoQq8d/FrqqliCkLnnqZET/JHg
 Xpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zYAnJX+TpDGLkEzNmA27WFkqeU//5jbR+UQpskrIy5I=;
 b=t+l+w+oCC4pw8d1qudj8DEpyMB6eXCYSti1bRDhxbfrXGhsKovIPKL7ix8Zblb7auu
 aJY9WvMkpKBLFvIfbDciTXhLqqiEu+So4IbUpYiGmtlijoMmzdZUikYgQ0UpvwsXqOP9
 qzYjUrfXSIHDH7t+4DhIdzDZLeAHMPJXxvZ21eTrqtKFLRvmjCRLC5G0yVzMudDR5cGf
 7xd4zOroP56ZS89+3Sc+H9GHuZFqN9JfWi8azV9Ck8nrpCEgHA1iA/CVfrQNBBlGuyxL
 y9MwR91AjEoZj5IBc+vuKfiRkXK2QX20hWNVLg757NcFRjLCjm2pdYafbUqeDt3z30gn
 qptQ==
X-Gm-Message-State: AOAM530139P4jbwYF3w7FbzagnXI+jUeYDTPFj4r0RiS3d215U+4QiJa
 IWzV/bo10yvyKRZ+L6k6SjZa2g+4LIae3mbvb0dC+A==
X-Google-Smtp-Source: ABdhPJzwOIbkvP/+iBD3SIgTnAQn/UcxBAdqLsfj8FwGgFjPWSHfw+JOD+iFOYO8kxJi1FuIXtuIk9Ci48Jn1RQ/m50=
X-Received: by 2002:a17:90b:1e49:: with SMTP id
 pi9mr686283pjb.220.1639586787855; 
 Wed, 15 Dec 2021 08:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de> <YbNhPXBg7G/ridkV@redhat.com>
 <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
 <20211213082318.GB21462@lst.de> <YbiosqZoG8e6rDkj@redhat.com>
 <CAPcyv4hFjKsPrPTB4NtLHiY8gyaELz9+45N1OFj3hz+uJ=9JnA@mail.gmail.com>
 <Ybj/azxrUyU4PZEr@redhat.com>
 <CAPcyv4h_iFe8U8UrXCbhAYaruFm-xg0n_U3H8wnK-uGoEubTvw@mail.gmail.com>
 <YboPTSExR05zeDil@redhat.com>
In-Reply-To: <YboPTSExR05zeDil@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 Dec 2021 08:46:18 -0800
Message-ID: <CAPcyv4jDhK_tzb=p4CCm1_OKqJU1a3UMPhbo=8BgwXSrsQXxVQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 device-mapper development <dm-devel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>
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

On Wed, Dec 15, 2021 at 7:53 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Dec 14, 2021 at 03:43:38PM -0800, Dan Williams wrote:
> > On Tue, Dec 14, 2021 at 12:33 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Dec 14, 2021 at 08:41:30AM -0800, Dan Williams wrote:
> > > > On Tue, Dec 14, 2021 at 6:23 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Mon, Dec 13, 2021 at 09:23:18AM +0100, Christoph Hellwig wrote:
> > > > > > On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> > > > > > > On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > > > > Going forward, I am wondering should virtiofs use flushcache version as
> > > > > > > > well. What if host filesystem is using DAX and mapping persistent memory
> > > > > > > > pfn directly into qemu address space. I have never tested that.
> > > > > > > >
> > > > > > > > Right now we are relying on applications to do fsync/msync on virtiofs
> > > > > > > > for data persistence.
> > > > > > >
> > > > > > > This sounds like it would need coordination with a paravirtualized
> > > > > > > driver that can indicate whether the host side is pmem or not, like
> > > > > > > the virtio_pmem driver. However, if the guest sends any fsync/msync
> > > > > > > you would still need to go explicitly cache flush any dirty page
> > > > > > > because you can't necessarily trust that the guest did that already.
> > > > > >
> > > > > > Do we?  The application can't really know what backend it is on, so
> > > > > > it sounds like the current virtiofs implementation doesn't really, does it?
> > > > >
> > > > > Agreed that application does not know what backend it is on. So virtiofs
> > > > > just offers regular posix API where applications have to do fsync/msync
> > > > > for data persistence. No support for mmap(MAP_SYNC). We don't offer persistent
> > > > > memory programming model on virtiofs. That's not the expectation. DAX
> > > > > is used only to bypass guest page cache.
> > > > >
> > > > > With this assumption, I think we might not have to use flushcache version
> > > > > at all even if shared filesystem is on persistent memory on host.
> > > > >
> > > > > - We mmap() host files into qemu address space. So any dax store in virtiofs
> > > > >   should make corresponding pages dirty in page cache on host and when
> > > > >   and fsync()/msync() comes later, it should flush all the data to PMEM.
> > > > >
> > > > > - In case of file extending writes, virtiofs falls back to regular
> > > > >   FUSE_WRITE path (and not use DAX), and in that case host pmem driver
> > > > >   should make sure writes are flushed to pmem immediately.
> > > > >
> > > > > Are there any other path I am missing. If not, looks like we might not
> > > > > have to use flushcache version in virtiofs at all as long as we are not
> > > > > offering guest applications user space flushes and MAP_SYNC support.
> > > > >
> > > > > We still might have to use machine check safe variant though as loads
> > > > > might generate synchronous machine check. What's not clear to me is
> > > > > that if this MC safe variant should be used only in case of PMEM or
> > > > > should it be used in case of non-PMEM as well.
> > > >
> > > > It should be used on any memory address that can throw exception on
> > > > load, which is any physical address, in paths that can tolerate
> > > > memcpy() returning an error code, most I/O paths, and can tolerate
> > > > slower copy performance on older platforms that do not support MC
> > > > recovery with fast string operations, to date that's only PMEM users.
> > >
> > > Ok, So basically latest cpus can do fast string operations with MC
> > > recovery so that using MC safe variant is not a problem.
> > >
> > > Then there is range of cpus which can do MC recovery but do slower
> > > versions of memcpy and that's where the issue is.
> > >
> > > So if we knew that virtiofs dax window is backed by a pmem device
> > > then we should always use MC safe variant. Even if it means paying
> > > the price of slow version for the sake of correctness.
> > >
> > > But if we are not using pmem on host, then there is no point in
> > > using MC safe variant.
> > >
> > > IOW.
> > >
> > >         if (virtiofs_backed_by_pmem) {
> >
> > No, PMEM should not be considered at all relative to whether to use MC
> > or not, it is 100% a decision of whether you expect virtiofs users
> > will balk more at unhandled machine checks or performance regressions
> > on the platforms that set "enable_copy_mc_fragile()".
>
> If we don't handle machine check, kernel will panic(), right? So that's
> the trade off. Whether get higher performance (on select platforms) and
> crash if MC happens OR get slower memcpy() performance (on select
> platoforms) and recover from MC. Hmm...
>
>
> > See
> > quirk_intel_brickland_xeon_ras_cap() and
> > quirk_intel_purley_xeon_ras_cap() in arch/x86/kernel/quirks.c.
> >
> > >                 use_mc_safe_version
> > >         else
> > >                 use_non_mc_safe_version
> > >         }
> > >
> > > Now question is, how do we know if virtiofs dax window is backed by
> > > a pmem or not. I checked virtio_pmem driver and that does not seem
> > > to communicate anything like that. It just communicates start of the
> > > range and size of range, nothing else.
> > >
> > > I don't have full handle on stack of modules of virtio_pmem, but my guess
> > > is it probably is using MC safe version always (because it does not
> > > know anthing about the backing storage).
> > >
> > > /me will definitely like to pay penalty of slower memcpy if virtiofs
> > > device is not backed by a pmem.
> >
> > I assume you meant "not like",
>
> Yes. It was a typo.
>
> > but again PMEM has no bearing on
> > whether using that device will throw machine checks. I'm sure there
> > are people that would make the opposite tradeoff.
>
> Why pmem driver does not have to make such trade off and it always
> uses machine check variant.

It certainly did. I can't find the thread now, but the end result was
to accept the performance regression in favor of maximal MC handling
protection.

> As you mentioned machine checks can happen with DRAM too. So why loading
> from page cache not use machine check variant (or given an option to user
> allow making a choice).

...because regressing page cache operations is fraught, and x86
machine check architecture elicits strong feelings.

> BTW, stefan mentioned that we could think of adding a device feature
> bit to signal whether to do MC safe memcpy() or not if it becomes
> really necessary. For now probably let us stick to performance
> variant and if users demand machine check handling, then either
> introduce it unconditionally or make it an opt-in based on device
> feature bit.

Sure, it's a reasonable choice.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
