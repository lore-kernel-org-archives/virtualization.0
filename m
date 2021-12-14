Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A9AC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 16:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82A6360B72;
	Tue, 14 Dec 2021 16:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ExZ-pZKGN5y; Tue, 14 Dec 2021 16:41:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2AE5A60C02;
	Tue, 14 Dec 2021 16:41:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01FF2C006E;
	Tue, 14 Dec 2021 16:41:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DED51C0038
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 16:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDAAF80C9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 16:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZ7O7ptwlGyn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 16:41:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F029480C89
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 16:41:39 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id y8so13965178plg.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t/nnzQN9F5r4zFSkk8iYiBeWCGCkT6Dn6wCuQkQZ9ZI=;
 b=dZAHZODGRVbZR2ysy2aU8tziv8EUSVJ4G7lyxIrGTVAuZTAI+h8NEwG8q7Ti0dmlRz
 FUs67aDUBnh6oEQuwW9klnzG6whuDB0WHzvC+u6KewQCpZ3qzZkQxOjXcIwIOakbw+W8
 0IPx5KqHgVMSuYrfYVo/3t/drPQ+jE/inPZaZAe65sMgMfC0QFbD7dio6ED/HtOLm8GC
 OtyfjDtD51vI1WL0SiPHAHoYFrmLR9/1Ewk0VndBGOMrtBOrC2Xs+YWkZlTmM1nQ+fwf
 xp9G/2UCykZKzSIljzl9L8OafZyAgDu+6bByD3Jg+aWM9iQLLGlyuMF0JKsj5Ok6ufkJ
 np+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t/nnzQN9F5r4zFSkk8iYiBeWCGCkT6Dn6wCuQkQZ9ZI=;
 b=RyA1vtgjo7jg5VG4oIHKMxFX7mNfTMbzF7yQaqQ6fGAg+Y6pNtTzBpEo9Za9oC0c+R
 AfKyrfSU624kUrFo9eEnQ1f0WnwaegSGwDcctBHHY/YiYospr40vR4J6WSmyKL0atH0E
 CsoO8OYoEQ8rpXso+IRWjymvivhQqq3kbhHGkeOOHhLGZjq5LPq5XsCrRp+Lz1tIqpXZ
 EGU6c7vHdd8kjyX7iDSpUs+2n+FUPtgXB2lBrXzJySl8MOUJf43+UELTRBU9cUxF9iIW
 lCbvdFXi6js3x60tcne9LDMHcOaOI1Vdv2Ig6aVRxZ1aJFOkNdtMFVS4xTQ5gKwDhjDn
 HTHQ==
X-Gm-Message-State: AOAM532Xx8mwgAXCoQBAx/9/qRbESvRhxqf2JrBbwH1Fb22xxpWXbEVk
 YZljTTqhcE0/XpY9zokAACatUS3iGhxDXAmJtfiNhg==
X-Google-Smtp-Source: ABdhPJw+O9j0H9UWQxoVKDQYePJLlAtoMN+dCn3S6Q/xMAfRBDp6O2XP6nSywAkX3lUHqDKzBphvkGiQvj7Lgmg0w8E=
X-Received: by 2002:a17:902:bb87:b0:148:a2e7:fb52 with SMTP id
 m7-20020a170902bb8700b00148a2e7fb52mr124861pls.147.1639500099392; Tue, 14 Dec
 2021 08:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de> <YbNhPXBg7G/ridkV@redhat.com>
 <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
 <20211213082318.GB21462@lst.de> <YbiosqZoG8e6rDkj@redhat.com>
In-Reply-To: <YbiosqZoG8e6rDkj@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 14 Dec 2021 08:41:30 -0800
Message-ID: <CAPcyv4hFjKsPrPTB4NtLHiY8gyaELz9+45N1OFj3hz+uJ=9JnA@mail.gmail.com>
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

On Tue, Dec 14, 2021 at 6:23 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Dec 13, 2021 at 09:23:18AM +0100, Christoph Hellwig wrote:
> > On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> > > On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > Going forward, I am wondering should virtiofs use flushcache version as
> > > > well. What if host filesystem is using DAX and mapping persistent memory
> > > > pfn directly into qemu address space. I have never tested that.
> > > >
> > > > Right now we are relying on applications to do fsync/msync on virtiofs
> > > > for data persistence.
> > >
> > > This sounds like it would need coordination with a paravirtualized
> > > driver that can indicate whether the host side is pmem or not, like
> > > the virtio_pmem driver. However, if the guest sends any fsync/msync
> > > you would still need to go explicitly cache flush any dirty page
> > > because you can't necessarily trust that the guest did that already.
> >
> > Do we?  The application can't really know what backend it is on, so
> > it sounds like the current virtiofs implementation doesn't really, does it?
>
> Agreed that application does not know what backend it is on. So virtiofs
> just offers regular posix API where applications have to do fsync/msync
> for data persistence. No support for mmap(MAP_SYNC). We don't offer persistent
> memory programming model on virtiofs. That's not the expectation. DAX
> is used only to bypass guest page cache.
>
> With this assumption, I think we might not have to use flushcache version
> at all even if shared filesystem is on persistent memory on host.
>
> - We mmap() host files into qemu address space. So any dax store in virtiofs
>   should make corresponding pages dirty in page cache on host and when
>   and fsync()/msync() comes later, it should flush all the data to PMEM.
>
> - In case of file extending writes, virtiofs falls back to regular
>   FUSE_WRITE path (and not use DAX), and in that case host pmem driver
>   should make sure writes are flushed to pmem immediately.
>
> Are there any other path I am missing. If not, looks like we might not
> have to use flushcache version in virtiofs at all as long as we are not
> offering guest applications user space flushes and MAP_SYNC support.
>
> We still might have to use machine check safe variant though as loads
> might generate synchronous machine check. What's not clear to me is
> that if this MC safe variant should be used only in case of PMEM or
> should it be used in case of non-PMEM as well.

It should be used on any memory address that can throw exception on
load, which is any physical address, in paths that can tolerate
memcpy() returning an error code, most I/O paths, and can tolerate
slower copy performance on older platforms that do not support MC
recovery with fast string operations, to date that's only PMEM users.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
