Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1558C433FE
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 14:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4586940227;
	Sun, 12 Dec 2021 14:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BAPpUcPxiFy7; Sun, 12 Dec 2021 14:44:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7EA0D40131;
	Sun, 12 Dec 2021 14:44:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4750EC002F;
	Sun, 12 Dec 2021 14:44:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 813D5C0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61F1682640
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s3b2Pt2czUvR
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:44:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B402282628
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 14:44:37 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id u17so9441545plg.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 06:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=agYW6DcaeuP+q4nan8V1VqgSNwzlJAeR6akaOZ2DEVE=;
 b=NhXgmEqiOO3TDAnM/oJYTe308BJdK34sJJBFru0szdBrVWgK9AoytL660B82dxWuHq
 Uk1WbiFnBpVzFZVCeNGfGlbraNzlE4y4q2b1Akd3exuclDWE56luAHTvH2uhmcv65HA/
 ZJO7p6YmjOOvQtXVf/jhtCiSdGV6YElJuPbrFu+mPyonxBMAO3PjGgZBXtY/J3piabR2
 34gwJnZUYWxDqlZKkERQCyAsIpvU6mlsyr8rrU8NEZpCpRRe7fPvv/9QSvYT9hweUYit
 rvMtfYbrkepesOsTejX8oKII9/8TKssEO0lrGkjJE1lymRG4b95lITyRik0ePoOzEmRj
 eI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=agYW6DcaeuP+q4nan8V1VqgSNwzlJAeR6akaOZ2DEVE=;
 b=59+ermuaS0jfv/9pw3ajSYjSaCpqp5CLiClpFYnTbX3ieUBXCmW5HbQE2kbyLnphHW
 wofXSNxWTUUdacXcQwgO76jqfXOA19QFNhPg/mLn7u1+0o6oCirQ1bC7FQ4nPe7BSj3z
 suSaSagBsx/I7utmSW1t9ZIh6Fnwc9Lck5Q1wOrkBGWvjMH4rhVe4kryTeh5RnFQL621
 iKXwNsvQZHaSbmWdsUaS+KhRGc8b9XXphjd7bZBTMdCc99d8fytzFFKgK2i7SoWMRWrS
 /tgZdRa6huPL/UTS3ctcku440KK7zBmXC/AVPjwHSSgGDOdRm0rEBqMbWq7wLbs0VOcA
 i1Jg==
X-Gm-Message-State: AOAM530tLeWJgytPhI0bV9Z1BLhpV9b2XqnJ2U+BGx+bexk/R3VwWPAK
 HUbqKFWeScCPx0bYAot2o6d4TGmPnyu5RvsV+9V+gg==
X-Google-Smtp-Source: ABdhPJwLj56PBRqvGExnBUnnCkX5apEf9je516CrVNM0D8M9K2XSCF8Su7nlWxjv1JO1vwplQ6ww7tAn0NH7STTpMKQ=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr88249325plb.4.1639320277138; Sun, 12
 Dec 2021 06:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de> <YbNhPXBg7G/ridkV@redhat.com>
In-Reply-To: <YbNhPXBg7G/ridkV@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 12 Dec 2021 06:44:26 -0800
Message-ID: <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
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

On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Dec 09, 2021 at 07:38:27AM +0100, Christoph Hellwig wrote:
> > These methods indirect the actual DAX read/write path.  In the end pmem
> > uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> > while device mapper picks redirects to the underlying device.
> >
> > Add set_dax_virtual() and set_dax_nomcsafe() APIs for fuse to skip these
> > special variants, then use them everywhere as they fall back to the plain
> > ones on s390 anyway and remove an indirect call from the read/write path
> > as well as a lot of boilerplate code.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/dax/super.c           | 36 ++++++++++++++--
> >  drivers/md/dm-linear.c        | 20 ---------
> >  drivers/md/dm-log-writes.c    | 80 -----------------------------------
> >  drivers/md/dm-stripe.c        | 20 ---------
> >  drivers/md/dm.c               | 50 ----------------------
> >  drivers/nvdimm/pmem.c         | 20 ---------
> >  drivers/s390/block/dcssblk.c  | 14 ------
> >  fs/dax.c                      |  5 ---
> >  fs/fuse/virtio_fs.c           | 19 +--------
> >  include/linux/dax.h           |  9 ++--
> >  include/linux/device-mapper.h |  4 --
> >  11 files changed, 37 insertions(+), 240 deletions(-)
> >
>
> [..]
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 5c03a0364a9bb..754319ce2a29b 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -753,20 +753,6 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> >       return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
> >  }
> >
> > -static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
> > -                                    pgoff_t pgoff, void *addr,
> > -                                    size_t bytes, struct iov_iter *i)
> > -{
> > -     return copy_from_iter(addr, bytes, i);
> > -}
> > -
> > -static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
> > -                                    pgoff_t pgoff, void *addr,
> > -                                    size_t bytes, struct iov_iter *i)
> > -{
> > -     return copy_to_iter(addr, bytes, i);
> > -}
> > -
> >  static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
> >                                    pgoff_t pgoff, size_t nr_pages)
> >  {
> > @@ -783,8 +769,6 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
> >
> >  static const struct dax_operations virtio_fs_dax_ops = {
> >       .direct_access = virtio_fs_direct_access,
> > -     .copy_from_iter = virtio_fs_copy_from_iter,
> > -     .copy_to_iter = virtio_fs_copy_to_iter,
> >       .zero_page_range = virtio_fs_zero_page_range,
> >  };
> >
> > @@ -853,7 +837,8 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> >       fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> >       if (IS_ERR(fs->dax_dev))
> >               return PTR_ERR(fs->dax_dev);
> > -
> > +     set_dax_cached(fs->dax_dev);
>
> Looks good to me from virtiofs point of view.
>
> Reviewed-by: Vivek Goyal <vgoyal@redhat.com>
>
> Going forward, I am wondering should virtiofs use flushcache version as
> well. What if host filesystem is using DAX and mapping persistent memory
> pfn directly into qemu address space. I have never tested that.
>
> Right now we are relying on applications to do fsync/msync on virtiofs
> for data persistence.

This sounds like it would need coordination with a paravirtualized
driver that can indicate whether the host side is pmem or not, like
the virtio_pmem driver. However, if the guest sends any fsync/msync
you would still need to go explicitly cache flush any dirty page
because you can't necessarily trust that the guest did that already.

>
> > +     set_dax_nomcsafe(fs->dax_dev);
> >       return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
> >                                       fs->dax_dev);
> >  }
>
> Thanks
> Vivek
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
