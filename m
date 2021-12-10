Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452C4C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 14:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FFA6411E9;
	Fri, 10 Dec 2021 14:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPoLVTMzIpR2; Fri, 10 Dec 2021 14:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E220F411DA;
	Fri, 10 Dec 2021 14:05:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B67DFC001E;
	Fri, 10 Dec 2021 14:05:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02569C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEBA284EB3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pvo3dAzu49ot
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C62BD84EAF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639145137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1IPYd/U/Ts1tZJpb5JWXIO6VaK+NnfSEAcLoJXiiX6k=;
 b=cmlDa8Qni1skJjwHveQxClTwy6Q0BCc18oDZVEqY6d+UL72ocVp9zyDhLbHoMGaHRfFW8t
 kmM/UnCHSGdqpdb3NsKyQvqrYN8unffNfo8A9h6boc/piq5s4d+mGBQHtpuVEVUTBj8vV1
 CWX89DabyOzuF37bJqYpxtCnCgs23S0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-AXVHfjlYNN-rOCr5ug7-OA-1; Fri, 10 Dec 2021 09:05:32 -0500
X-MC-Unique: AXVHfjlYNN-rOCr5ug7-OA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA031017965;
 Fri, 10 Dec 2021 14:05:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C13919C59;
 Fri, 10 Dec 2021 14:05:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id AC32F2209DD; Fri, 10 Dec 2021 09:05:01 -0500 (EST)
Date: Fri, 10 Dec 2021 09:05:01 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
Message-ID: <YbNejVRF5NQB0r83@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211209063828.18944-6-hch@lst.de>
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

On Thu, Dec 09, 2021 at 07:38:28AM +0100, Christoph Hellwig wrote:
> While using the MC-safe copy routines is rather pointless on a virtual device
> like virtiofs,

I was wondering about that. Is it completely pointless.

Typically we are just mapping host page cache into qemu address space.
That shows as virtiofs device pfn in guest and that pfn is mapped into
guest application address space in mmap() call.

Given on host its DRAM, so I would not expect machine check on load side
so there was no need to use machine check safe variant. But what if host
filesystem is on persistent memory and using DAX. In that case load in
guest can trigger a machine check. Not sure if that machine check will
actually travel into the guest and unblock read() operation or not.

But this sounds like a good change from virtiofs point of view, anyway.

Thanks
Vivek


> it also isn't harmful at all.  So just use _copy_mc_to_iter
> unconditionally to simplify the code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 10 ----------
>  fs/fuse/virtio_fs.c |  1 -
>  include/linux/dax.h |  1 -
>  3 files changed, 12 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index ff676a07480c8..fe783234ca669 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -107,8 +107,6 @@ enum dax_device_flags {
>  	DAXDEV_SYNC,
>  	/* do not use uncached operations to write data */
>  	DAXDEV_CACHED,
> -	/* do not use mcsafe operations to read data */
> -	DAXDEV_NOMCSAFE,
>  };
>  
>  /**
> @@ -171,8 +169,6 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  	 * via access_ok() in vfs_red, so use the 'no check' version to bypass
>  	 * the HARDENED_USERCOPY overhead.
>  	 */
> -	if (test_bit(DAXDEV_NOMCSAFE, &dax_dev->flags))
> -		return _copy_to_iter(addr, bytes, i);
>  	return _copy_mc_to_iter(addr, bytes, i);
>  }
>  
> @@ -242,12 +238,6 @@ void set_dax_cached(struct dax_device *dax_dev)
>  }
>  EXPORT_SYMBOL_GPL(set_dax_cached);
>  
> -void set_dax_nomcsafe(struct dax_device *dax_dev)
> -{
> -	set_bit(DAXDEV_NOMCSAFE, &dax_dev->flags);
> -}
> -EXPORT_SYMBOL_GPL(set_dax_nomcsafe);
> -
>  bool dax_alive(struct dax_device *dax_dev)
>  {
>  	lockdep_assert_held(&dax_srcu);
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 754319ce2a29b..d9c20b148ac19 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -838,7 +838,6 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>  	if (IS_ERR(fs->dax_dev))
>  		return PTR_ERR(fs->dax_dev);
>  	set_dax_cached(fs->dax_dev);
> -	set_dax_nomcsafe(fs->dax_dev);
>  	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
>  					fs->dax_dev);
>  }
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index d22cbf03d37d2..d267331bc37e7 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -90,7 +90,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  #endif
>  
>  void set_dax_cached(struct dax_device *dax_dev);
> -void set_dax_nomcsafe(struct dax_device *dax_dev);
>  
>  struct writeback_control;
>  #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
> -- 
> 2.30.2
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
