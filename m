Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F55C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 14:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01BE2421BB;
	Fri, 10 Dec 2021 14:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id px1LyIIcn62P; Fri, 10 Dec 2021 14:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77C044221E;
	Fri, 10 Dec 2021 14:17:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 437B8C001E;
	Fri, 10 Dec 2021 14:17:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB7CAC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FEFB61440
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbr0-6b1QmF9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C582D6143E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639145832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAS8YtaRzDwTBft61hF97SlcoBkaxxqGmF+wyCNWJ8A=;
 b=apjgopUh4DR8jZcbiRKLT+qGP8HQHrWFRpOCLNCgnfq6pLrRtKS5WIa9Ip2gYjd4Ygk39z
 fAaSNACWgQSxbifvbtFmn2+JQavzA11PLWpKtZ+olRDURyBjJnM5mQvfAGMiTZiDokXQ80
 t9P0jlvGVWLaMUyTFhpOYYnTI9a2R9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-eeZyP13LOWiAd_cdWjWvAA-1; Fri, 10 Dec 2021 09:17:09 -0500
X-MC-Unique: eeZyP13LOWiAd_cdWjWvAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 249C7835E20;
 Fri, 10 Dec 2021 14:17:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12ED719C59;
 Fri, 10 Dec 2021 14:16:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 967302209DD; Fri, 10 Dec 2021 09:16:29 -0500 (EST)
Date: Fri, 10 Dec 2021 09:16:29 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <YbNhPXBg7G/ridkV@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211209063828.18944-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Mike Snitzer <snitzer@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Vishal Verma <vishal.l.verma@intel.com>, Heiko Carstens <hca@linux.ibm.com>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, dm-devel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
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

On Thu, Dec 09, 2021 at 07:38:27AM +0100, Christoph Hellwig wrote:
> These methods indirect the actual DAX read/write path.  In the end pmem
> uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> while device mapper picks redirects to the underlying device.
> 
> Add set_dax_virtual() and set_dax_nomcsafe() APIs for fuse to skip these
> special variants, then use them everywhere as they fall back to the plain
> ones on s390 anyway and remove an indirect call from the read/write path
> as well as a lot of boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c           | 36 ++++++++++++++--
>  drivers/md/dm-linear.c        | 20 ---------
>  drivers/md/dm-log-writes.c    | 80 -----------------------------------
>  drivers/md/dm-stripe.c        | 20 ---------
>  drivers/md/dm.c               | 50 ----------------------
>  drivers/nvdimm/pmem.c         | 20 ---------
>  drivers/s390/block/dcssblk.c  | 14 ------
>  fs/dax.c                      |  5 ---
>  fs/fuse/virtio_fs.c           | 19 +--------
>  include/linux/dax.h           |  9 ++--
>  include/linux/device-mapper.h |  4 --
>  11 files changed, 37 insertions(+), 240 deletions(-)
> 

[..]
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5c03a0364a9bb..754319ce2a29b 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -753,20 +753,6 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>  	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
>  }
>  
> -static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
> -				       pgoff_t pgoff, void *addr,
> -				       size_t bytes, struct iov_iter *i)
> -{
> -	return copy_from_iter(addr, bytes, i);
> -}
> -
> -static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
> -				       pgoff_t pgoff, void *addr,
> -				       size_t bytes, struct iov_iter *i)
> -{
> -	return copy_to_iter(addr, bytes, i);
> -}
> -
>  static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
>  				     pgoff_t pgoff, size_t nr_pages)
>  {
> @@ -783,8 +769,6 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
>  
>  static const struct dax_operations virtio_fs_dax_ops = {
>  	.direct_access = virtio_fs_direct_access,
> -	.copy_from_iter = virtio_fs_copy_from_iter,
> -	.copy_to_iter = virtio_fs_copy_to_iter,
>  	.zero_page_range = virtio_fs_zero_page_range,
>  };
>  
> @@ -853,7 +837,8 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
>  	if (IS_ERR(fs->dax_dev))
>  		return PTR_ERR(fs->dax_dev);
> -
> +	set_dax_cached(fs->dax_dev);

Looks good to me from virtiofs point of view.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Going forward, I am wondering should virtiofs use flushcache version as
well. What if host filesystem is using DAX and mapping persistent memory
pfn directly into qemu address space. I have never tested that.

Right now we are relying on applications to do fsync/msync on virtiofs
for data persistence.

> +	set_dax_nomcsafe(fs->dax_dev);
>  	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
>  					fs->dax_dev);
>  }

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
