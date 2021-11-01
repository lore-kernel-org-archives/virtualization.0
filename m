Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DAC433FE
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:17:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC3C610D2
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 16:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AC3C610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD73A80C35;
	Mon,  1 Nov 2021 16:17:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H73ZfJUXO-lN; Mon,  1 Nov 2021 16:17:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8DBCC80C22;
	Mon,  1 Nov 2021 16:17:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 662A4C0019;
	Mon,  1 Nov 2021 16:17:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69842C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4530660605
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xqxBIV7HlL_2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:17:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78DBC605D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2vxwqlB6wFzeCRM5lLa77O94J13VaOz9ZvoVd+rZG8=;
 b=B7k9y58G4JcIJeeiOMtSuF/pN9PKfe884hWhZsMpBKVicHOLGOaAhA3bkvQohmEfRR30U6
 ZdVJcyY/DGGosjEivx/lAq1oA8SbdNvebn4BSrV8ZNz5rn9Tc0zupJl4VmczztD5x2R0JF
 Ak+B7EQ3PIAaXpM6rGqwJSPquMZgtiQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-MgkBamMrMeOhCtU8GY1E4A-1; Mon, 01 Nov 2021 12:17:46 -0400
X-MC-Unique: MgkBamMrMeOhCtU8GY1E4A-1
Received: by mail-qv1-f70.google.com with SMTP id
 p10-20020a0cc3ca000000b0038559d56582so16760179qvi.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 09:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F2vxwqlB6wFzeCRM5lLa77O94J13VaOz9ZvoVd+rZG8=;
 b=w6wNsnEuGC+W9hE3wmbpp3DJFxmQRNK7AdZfPcfHwLXwjqf4KAluRUX3aP/fWd9N0P
 lK0mRO0Nlkwl2y0BJC+SI0K14yTewM7mwP/7LeFsEZkIpcs3eeTzfe011nd8wrqR9CRX
 UBLuB0SAvTzAzq43qeSuuvTi8DQqJn5KopxLoqZf4eFHyHxht8ks/InCEHutcgAZ4qEw
 goQw8LuSLntXNNWdKIZbBtrWppismISAmrZVU5ewxRN+yYuxgf3KiHYZqq9hUk8geR1g
 GJ0qpqE4gvTZwuxY9GjnOA+IRdb64Osg97CCjfRZbw1KFOM4g87thCVg/u5PcH1QlN/Z
 bq8A==
X-Gm-Message-State: AOAM531vKVL9PS4tERlcC/1F0+SKXhfCv8eC+8RRg8QGmkT1DNquDDV5
 Tv1FJcjummvGFH61PaRc9H+ceEoaM1b5hRDENvFJlySG+n8cfuW+tfgylxnpkRLAW94d6W3bWG6
 Ze6XrAnoeNl8xaRfuvxT6jOIXVgGV+T4VM/6xOLSk
X-Received: by 2002:a05:622a:1006:: with SMTP id
 d6mr31006242qte.259.1635783465568; 
 Mon, 01 Nov 2021 09:17:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsvnNj6Smb4Ra96XKXfYd15LiYJibYUWXpiZB6UR51qpyc+daCyIZfeeXzYlbHsOmSJkMTRA==
X-Received: by 2002:a05:622a:1006:: with SMTP id
 d6mr31006216qte.259.1635783465346; 
 Mon, 01 Nov 2021 09:17:45 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id f66sm5772868qkj.76.2021.11.01.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 09:17:44 -0700 (PDT)
Date: Mon, 1 Nov 2021 12:17:43 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 07/11] dax: remove dax_capable
Message-ID: <YYATJ+oDT15TD9Np@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-8-hch@lst.de>
 <CAPcyv4gE8UXjQAe_6=BKFRCyLWNP_9CNxKFH---RpPnYfmBQLg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gE8UXjQAe_6=BKFRCyLWNP_9CNxKFH---RpPnYfmBQLg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Oct 27 2021 at  8:16P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> I am going to change the subject of this patch to:
> 
> dax: remove ->dax_supported()
> 
> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> 
> I'll add a bit more background to help others review this.
> 
> The ->dax_supported() operation arranges for a stack of devices to
> each answer the question "is dax operational". That request routes to
> generic_fsdax_supported() at last level device and that attempted an
> actual dax_direct_access() call and did some sanity checks. However,
> those sanity checks can be validated in other ways and with those
> removed the only question to answer is "has each block device driver
> in the stack performed dax_add_host()". That can be validated without
> a dax_operation. So, just open code the block size and dax_dev == NULL
> checks in the callers, and delete ->dax_supported().
> 
> Mike, let me know if you have any concerns.

Thanks for your additional background, it helped.


> 
> > Just open code the block size and dax_dev == NULL checks in the callers.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/dax/super.c          | 36 ------------------------------------
> >  drivers/md/dm-table.c        | 22 +++++++++++-----------
> >  drivers/md/dm.c              | 21 ---------------------
> >  drivers/md/dm.h              |  4 ----
> >  drivers/nvdimm/pmem.c        |  1 -
> >  drivers/s390/block/dcssblk.c |  1 -
> >  fs/erofs/super.c             | 11 +++++++----
> >  fs/ext2/super.c              |  6 ++++--
> >  fs/ext4/super.c              |  9 ++++++---
> >  fs/xfs/xfs_super.c           | 21 ++++++++-------------
> >  include/linux/dax.h          | 14 --------------
> >  11 files changed, 36 insertions(+), 110 deletions(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 482fe775324a4..803942586d1b6 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -108,42 +108,6 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> >         return dax_dev;
> >  }
> >  EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
> > -
> > -bool generic_fsdax_supported(struct dax_device *dax_dev,
> > -               struct block_device *bdev, int blocksize, sector_t start,
> > -               sector_t sectors)
> > -{
> > -       if (blocksize != PAGE_SIZE) {
> > -               pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
> > -               return false;
> > -       }
> > -
> > -       if (!dax_dev) {
> > -               pr_debug("%pg: error: dax unsupported by block device\n", bdev);
> > -               return false;
> > -       }
> > -
> > -       return true;
> > -}
> > -EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> > -
> > -bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> > -               int blocksize, sector_t start, sector_t len)
> > -{
> > -       bool ret = false;
> > -       int id;
> > -
> > -       if (!dax_dev)
> > -               return false;
> > -
> > -       id = dax_read_lock();
> > -       if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
> > -               ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
> > -                                                 start, len);
> > -       dax_read_unlock(id);
> > -       return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(dax_supported);
> >  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> >
> >  enum dax_device_flags {
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 1fa4d5582dca5..4ae671c2168ea 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -807,12 +807,14 @@ void dm_table_set_type(struct dm_table *t, enum dm_queue_mode type)
> >  EXPORT_SYMBOL_GPL(dm_table_set_type);
> >
> >  /* validate the dax capability of the target device span */
> > -int device_not_dax_capable(struct dm_target *ti, struct dm_dev *dev,
> > +static int device_not_dax_capable(struct dm_target *ti, struct dm_dev *dev,
> >                         sector_t start, sector_t len, void *data)
> >  {
> > -       int blocksize = *(int *) data;
> > +       if (dev->dax_dev)
> > +               return false;
> >
> > -       return !dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > +       pr_debug("%pg: error: dax unsupported by block device\n", dev->bdev);

Would prefer the use of DMDEBUG() here (which doesn't need trailing \n)

But otherwise:
Acked-by: Mike Snitzer <snitzer@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
