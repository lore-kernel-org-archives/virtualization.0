Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911F5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 14:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 353098145A;
	Tue, 14 Dec 2021 14:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Ff2hWOCozrD; Tue, 14 Dec 2021 14:23:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E4F5981404;
	Tue, 14 Dec 2021 14:23:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3713C001E;
	Tue, 14 Dec 2021 14:23:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE463C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B84D260BB8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rodRXAyPZvVJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:23:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE11A60BAD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639491786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QkYkB6Kf2sa6GjT4KwY+Pd7w7SplqbJNTIRwfEOjpBQ=;
 b=ULHeWb2kCUGxRBV55mug4W9t9YCu47Wzz+49SNMhB3dLuQki5lAHtNW3L+5pCNQh/y5itp
 Xq44D8C/cqgawEin7eqk+bj2fhNTXMQBwVtsqSKsKNacDlHQidR8vvhOCLgc/aD+iJfeED
 6tsdLrFYLJmmCuzLIxgi9ulS2nQCLa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-bjU_FyyzOjuDB6MrfzVczw-1; Tue, 14 Dec 2021 09:23:01 -0500
X-MC-Unique: bjU_FyyzOjuDB6MrfzVczw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD3AD801ADC;
 Tue, 14 Dec 2021 14:22:58 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 389FC60C9F;
 Tue, 14 Dec 2021 14:22:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 926EA2233DF; Tue, 14 Dec 2021 09:22:42 -0500 (EST)
Date: Tue, 14 Dec 2021 09:22:42 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <YbiosqZoG8e6rDkj@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de> <YbNhPXBg7G/ridkV@redhat.com>
 <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
 <20211213082318.GB21462@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213082318.GB21462@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 device-mapper development <dm-devel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Mon, Dec 13, 2021 at 09:23:18AM +0100, Christoph Hellwig wrote:
> On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> > On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > Going forward, I am wondering should virtiofs use flushcache version as
> > > well. What if host filesystem is using DAX and mapping persistent memory
> > > pfn directly into qemu address space. I have never tested that.
> > >
> > > Right now we are relying on applications to do fsync/msync on virtiofs
> > > for data persistence.
> > 
> > This sounds like it would need coordination with a paravirtualized
> > driver that can indicate whether the host side is pmem or not, like
> > the virtio_pmem driver. However, if the guest sends any fsync/msync
> > you would still need to go explicitly cache flush any dirty page
> > because you can't necessarily trust that the guest did that already.
> 
> Do we?  The application can't really know what backend it is on, so
> it sounds like the current virtiofs implementation doesn't really, does it?

Agreed that application does not know what backend it is on. So virtiofs
just offers regular posix API where applications have to do fsync/msync
for data persistence. No support for mmap(MAP_SYNC). We don't offer persistent
memory programming model on virtiofs. That's not the expectation. DAX 
is used only to bypass guest page cache.

With this assumption, I think we might not have to use flushcache version
at all even if shared filesystem is on persistent memory on host. 

- We mmap() host files into qemu address space. So any dax store in virtiofs
  should make corresponding pages dirty in page cache on host and when
  and fsync()/msync() comes later, it should flush all the data to PMEM.

- In case of file extending writes, virtiofs falls back to regular
  FUSE_WRITE path (and not use DAX), and in that case host pmem driver
  should make sure writes are flushed to pmem immediately.

Are there any other path I am missing. If not, looks like we might not
have to use flushcache version in virtiofs at all as long as we are not
offering guest applications user space flushes and MAP_SYNC support.

We still might have to use machine check safe variant though as loads
might generate synchronous machine check. What's not clear to me is
that if this MC safe variant should be used only in case of PMEM or
should it be used in case of non-PMEM as well.

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
