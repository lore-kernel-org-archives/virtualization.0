Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DFFC433E6
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 06:39:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC46864FE3
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 06:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC46864FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 605476F6A5;
	Wed, 10 Mar 2021 06:39:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TEeHqYHASrj; Wed, 10 Mar 2021 06:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB74C6F6AE;
	Wed, 10 Mar 2021 06:39:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B594EC000A;
	Wed, 10 Mar 2021 06:39:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10ABCC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBFDC4318E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uWeK4DVDqdUo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:39:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4563840182
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 06:39:09 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id 16so4307111pgo.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Mar 2021 22:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gSNOMI9oKfCyeZf1IReYIhbAleL143kM1K6H+TStvKA=;
 b=bS0EnS12cjBxn+d37qEsq/bv5AV7F2FblUGPmoJXC9rxgmVZamu58/BllswX0K490u
 XekCwAjuyVDdm5YmyUYJl7qJDts4xdxwZVdlMzrE5NGdZPgUEWvO+qrIwjWUeBIP13xk
 tasZyxn3lvj5SjA16njfmRUegfN2WuyxSLS4bi2nsdKgqPR05652zvlAjU5WmKQiPNek
 fn1g7qizAaHaynpPUZZr0x20D0Q2Tdr28yiL7wkLWdobLslcqSiZicpmsPHe6X8Oo8sr
 bzHahroS/12bEOh0WbcMWLYSHUrx2hZVJYh5jEAQEQ3V3oeXJ39cvIwTDAv3Ho8ZZeuR
 eHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=gSNOMI9oKfCyeZf1IReYIhbAleL143kM1K6H+TStvKA=;
 b=HiduI+PpFU6dGDDXIFra0rXsxYnL14MfIiWXVYL8bAd4ExVPpf1J1cUjOcPRBVXaG/
 LOHngo1sVXH3WNa7DcQ6FXNNxynq3nAqsnqYRZB8+/cHsxcuT5f0vo68IURK8dq4unz+
 hkWp2zwpR8ZNanCt6MulUmX2gUpbn9WzFsMxUQZe07bYtHtUrT/SaOyqpdDW2wvPzEw0
 O6GLKaZQHrx7H+vN8wuCXFwto8CABu2wSt5hAk24CApZe4W4aXOWHK0+yo3Kr6Aaxexe
 stv0HE66npvyn9hOaQN8aOx9T9P0YojWKsE6f1pkrYA9bs12LqvCKvWIm2WgTtD0cl4E
 KBZw==
X-Gm-Message-State: AOAM530g/T4OVEVH2dl0Im/1N1NxkpWfUSsNo+IMgoyNijVCjF5vOkhT
 UV69Sbt0wfvIhYqztuTqXxE=
X-Google-Smtp-Source: ABdhPJzDatmAVmdLX8shF2XynOLpFurMwrwCNSBEhWWtyzFrNbIB7bjf9CIa97oVlNSPdJfjvpsY5w==
X-Received: by 2002:a63:ff57:: with SMTP id s23mr1586621pgk.90.1615358348725; 
 Tue, 09 Mar 2021 22:39:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
 by smtp.gmail.com with ESMTPSA id c12sm4755639pjq.48.2021.03.09.22.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 22:39:07 -0800 (PST)
Date: Tue, 9 Mar 2021 22:39:05 -0800
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] fs: rename alloc_anon_inode to alloc_anon_inode_sb
Message-ID: <YEhpiRCOUll6Ri6J@google.com>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-2-hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Daniel Vetter <daniel@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Nitin Gupta <ngupta@vflare.org>
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

On Tue, Mar 09, 2021 at 04:53:40PM +0100, Christoph Hellwig wrote:
> Rename alloc_inode to free the name for a new variant that does not
> need boilerplate to create a super_block first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/platforms/pseries/cmm.c | 2 +-
>  drivers/dma-buf/dma-buf.c            | 2 +-
>  drivers/gpu/drm/drm_drv.c            | 2 +-
>  drivers/misc/cxl/api.c               | 2 +-
>  drivers/misc/vmw_balloon.c           | 2 +-
>  drivers/scsi/cxlflash/ocxl_hw.c      | 2 +-
>  drivers/virtio/virtio_balloon.c      | 2 +-
>  fs/aio.c                             | 2 +-
>  fs/anon_inodes.c                     | 4 ++--
>  fs/libfs.c                           | 2 +-
>  include/linux/fs.h                   | 2 +-
>  kernel/resource.c                    | 2 +-
>  mm/z3fold.c                          | 2 +-
>  mm/zsmalloc.c                        | 2 +-
>  14 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 45a3a3022a85c9..6d36b858b14df1 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -580,7 +580,7 @@ static int cmm_balloon_compaction_init(void)
>  		return rc;
>  	}
>  
> -	b_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
> +	b_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
>  	if (IS_ERR(b_dev_info.inode)) {
>  		rc = PTR_ERR(b_dev_info.inode);
>  		b_dev_info.inode = NULL;
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f264b70c383eb4..dedcc9483352dc 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -445,7 +445,7 @@ static inline int is_dma_buf_file(struct file *file)
>  static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
>  {
>  	struct file *file;
> -	struct inode *inode = alloc_anon_inode(dma_buf_mnt->mnt_sb);
> +	struct inode *inode = alloc_anon_inode_sb(dma_buf_mnt->mnt_sb);
>  
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 20d22e41d7ce74..87e7214a8e3565 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -519,7 +519,7 @@ static struct inode *drm_fs_inode_new(void)
>  		return ERR_PTR(r);
>  	}
>  
> -	inode = alloc_anon_inode(drm_fs_mnt->mnt_sb);
> +	inode = alloc_anon_inode_sb(drm_fs_mnt->mnt_sb);
>  	if (IS_ERR(inode))
>  		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
>  
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index b493de962153ba..2efbf6c98028ef 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -73,7 +73,7 @@ static struct file *cxl_getfile(const char *name,
>  		goto err_module;
>  	}
>  
> -	inode = alloc_anon_inode(cxl_vfs_mount->mnt_sb);
> +	inode = alloc_anon_inode_sb(cxl_vfs_mount->mnt_sb);
>  	if (IS_ERR(inode)) {
>  		file = ERR_CAST(inode);
>  		goto err_fs;
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index b837e7eba5f7dc..5d057a05ddbee8 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1900,7 +1900,7 @@ static __init int vmballoon_compaction_init(struct vmballoon *b)
>  		return PTR_ERR(vmballoon_mnt);
>  
>  	b->b_dev_info.migratepage = vmballoon_migratepage;
> -	b->b_dev_info.inode = alloc_anon_inode(vmballoon_mnt->mnt_sb);
> +	b->b_dev_info.inode = alloc_anon_inode_sb(vmballoon_mnt->mnt_sb);
>  
>  	if (IS_ERR(b->b_dev_info.inode))
>  		return PTR_ERR(b->b_dev_info.inode);
> diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
> index 244fc27215dc79..40184ed926b557 100644
> --- a/drivers/scsi/cxlflash/ocxl_hw.c
> +++ b/drivers/scsi/cxlflash/ocxl_hw.c
> @@ -88,7 +88,7 @@ static struct file *ocxlflash_getfile(struct device *dev, const char *name,
>  		goto err2;
>  	}
>  
> -	inode = alloc_anon_inode(ocxlflash_vfs_mount->mnt_sb);
> +	inode = alloc_anon_inode_sb(ocxlflash_vfs_mount->mnt_sb);
>  	if (IS_ERR(inode)) {
>  		rc = PTR_ERR(inode);
>  		dev_err(dev, "%s: alloc_anon_inode failed rc=%d\n",
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8985fc2cea8615..cae76ee5bdd688 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -916,7 +916,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	}
>  
>  	vb->vb_dev_info.migratepage = virtballoon_migratepage;
> -	vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
> +	vb->vb_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
>  	if (IS_ERR(vb->vb_dev_info.inode)) {
>  		err = PTR_ERR(vb->vb_dev_info.inode);
>  		goto out_kern_unmount;
> diff --git a/fs/aio.c b/fs/aio.c
> index 1f32da13d39ee6..d1c2aa7fd6de7c 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -234,7 +234,7 @@ static const struct address_space_operations aio_ctx_aops;
>  static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
>  {
>  	struct file *file;
> -	struct inode *inode = alloc_anon_inode(aio_mnt->mnt_sb);
> +	struct inode *inode = alloc_anon_inode_sb(aio_mnt->mnt_sb);
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index a280156138ed89..4745fc37014332 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -63,7 +63,7 @@ static struct inode *anon_inode_make_secure_inode(
>  	const struct qstr qname = QSTR_INIT(name, strlen(name));
>  	int error;
>  
> -	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
>  	if (IS_ERR(inode))
>  		return inode;
>  	inode->i_flags &= ~S_PRIVATE;
> @@ -231,7 +231,7 @@ static int __init anon_inode_init(void)
>  	if (IS_ERR(anon_inode_mnt))
>  		panic("anon_inode_init() kernel mount failed (%ld)\n", PTR_ERR(anon_inode_mnt));
>  
> -	anon_inode_inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	anon_inode_inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
>  	if (IS_ERR(anon_inode_inode))
>  		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e2de5401abca5a..600bebc1cd847f 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1216,7 +1216,7 @@ static int anon_set_page_dirty(struct page *page)
>  	return 0;
>  };
>  
> -struct inode *alloc_anon_inode(struct super_block *s)
> +struct inode *alloc_anon_inode_sb(struct super_block *s)
>  {
>  	static const struct address_space_operations anon_aops = {
>  		.set_page_dirty = anon_set_page_dirty,

EXPORT_SYMBOL(alloc_anon_inode_sb) ?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
