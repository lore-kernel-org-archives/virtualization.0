Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7DBC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 16:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CEFA6F480;
	Mon, 13 Dec 2021 16:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7syyig8VJZl6; Mon, 13 Dec 2021 16:18:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8103E60F48;
	Mon, 13 Dec 2021 16:18:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56D47C001E;
	Mon, 13 Dec 2021 16:18:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3595DC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23D2D85AC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d-GqWwxQlc1L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:17:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF78680D64
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639412276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zgm1TTb9mRYOZNW01H/VVMVpM00k6pLnOlu/2f/Ro58=;
 b=WnmaUglzoLzdxuZ96EwWe7IZtxLCvK2wo4qW3SyU1tIFUhQ7+FTLvLXYT4AVfwkluHm8so
 03t7+oOMiBDm5QL1RITfDeJhJWUe1PgVY93/VIQyWFGzu18V1LkMsVx8+ViTaxiAMdKxyE
 JiEkqb04btwbSIy0IcZCoxUFuF3zlQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-Xi8VqCsjNuuM18ClmLa9mw-1; Mon, 13 Dec 2021 11:17:53 -0500
X-MC-Unique: Xi8VqCsjNuuM18ClmLa9mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8D261015DA0;
 Mon, 13 Dec 2021 16:17:51 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A17260C9F;
 Mon, 13 Dec 2021 16:17:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id D90BB2209DD; Mon, 13 Dec 2021 11:17:49 -0500 (EST)
Date: Mon, 13 Dec 2021 11:17:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <YbdyLc+V1xyp8sc5@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de> <YbNhPXBg7G/ridkV@redhat.com>
 <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
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

On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, Dec 09, 2021 at 07:38:27AM +0100, Christoph Hellwig wrote:
> > > These methods indirect the actual DAX read/write path.  In the end pmem
> > > uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> > > while device mapper picks redirects to the underlying device.
> > >
> > > Add set_dax_virtual() and set_dax_nomcsafe() APIs for fuse to skip these
> > > special variants, then use them everywhere as they fall back to the plain
> > > ones on s390 anyway and remove an indirect call from the read/write path
> > > as well as a lot of boilerplate code.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  drivers/dax/super.c           | 36 ++++++++++++++--
> > >  drivers/md/dm-linear.c        | 20 ---------
> > >  drivers/md/dm-log-writes.c    | 80 -----------------------------------
> > >  drivers/md/dm-stripe.c        | 20 ---------
> > >  drivers/md/dm.c               | 50 ----------------------
> > >  drivers/nvdimm/pmem.c         | 20 ---------
> > >  drivers/s390/block/dcssblk.c  | 14 ------
> > >  fs/dax.c                      |  5 ---
> > >  fs/fuse/virtio_fs.c           | 19 +--------
> > >  include/linux/dax.h           |  9 ++--
> > >  include/linux/device-mapper.h |  4 --
> > >  11 files changed, 37 insertions(+), 240 deletions(-)
> > >
> >
> > [..]
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index 5c03a0364a9bb..754319ce2a29b 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -753,20 +753,6 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> > >       return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
> > >  }
> > >
> > > -static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
> > > -                                    pgoff_t pgoff, void *addr,
> > > -                                    size_t bytes, struct iov_iter *i)
> > > -{
> > > -     return copy_from_iter(addr, bytes, i);
> > > -}
> > > -
> > > -static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
> > > -                                    pgoff_t pgoff, void *addr,
> > > -                                    size_t bytes, struct iov_iter *i)
> > > -{
> > > -     return copy_to_iter(addr, bytes, i);
> > > -}
> > > -
> > >  static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
> > >                                    pgoff_t pgoff, size_t nr_pages)
> > >  {
> > > @@ -783,8 +769,6 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
> > >
> > >  static const struct dax_operations virtio_fs_dax_ops = {
> > >       .direct_access = virtio_fs_direct_access,
> > > -     .copy_from_iter = virtio_fs_copy_from_iter,
> > > -     .copy_to_iter = virtio_fs_copy_to_iter,
> > >       .zero_page_range = virtio_fs_zero_page_range,
> > >  };
> > >
> > > @@ -853,7 +837,8 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> > >       fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> > >       if (IS_ERR(fs->dax_dev))
> > >               return PTR_ERR(fs->dax_dev);
> > > -
> > > +     set_dax_cached(fs->dax_dev);
> >
> > Looks good to me from virtiofs point of view.
> >
> > Reviewed-by: Vivek Goyal <vgoyal@redhat.com>
> >
> > Going forward, I am wondering should virtiofs use flushcache version as
> > well. What if host filesystem is using DAX and mapping persistent memory
> > pfn directly into qemu address space. I have never tested that.
> >
> > Right now we are relying on applications to do fsync/msync on virtiofs
> > for data persistence.
> 
> This sounds like it would need coordination with a paravirtualized
> driver that can indicate whether the host side is pmem or not, like
> the virtio_pmem driver.

Agreed. Let me check the details of virtio_pmem driver.

> However, if the guest sends any fsync/msync
> you would still need to go explicitly cache flush any dirty page
> because you can't necessarily trust that the guest did that already.

So host dax functionality will already take care of that, IIUC, right?
I see a dax_flush() call in dax_writeback_one(). I am assuming that's
the will take care of flushing dirty pages when guest issues
fsync()/msync(). So probably don't have to do anything extra here.

I think qemu should map files using MAP_SYNC though in this case though.
Any read/writes to virtiofs files will turn into host file load/store
operations. So flushcache in guest makes more sense with MAP_SYNC which
should make sure any filesystem metadata will already persist after
fault completion. And later guest can do writes followed by flush and
ensure data persists too.

IOW, I probably only need to do following.

- In virtiofs virtual device, add a notion of kind of dax window or memory
  it supports. So may be some kind of "writethrough" property of virtiofs
  dax cache.

- Use this property in virtiofs driver to decide whether to use 
  plain copy_from_iter() or _copy_from_iter_flushcache().

- qemu should use mmap(MAP_SYNC) if host filesystem is on persistent
  memory.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
