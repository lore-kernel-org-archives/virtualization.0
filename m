Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A8DC433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:29:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23595651AE
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23595651AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6F9D400B8;
	Tue,  9 Mar 2021 16:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JajNw6JWEbd8; Tue,  9 Mar 2021 16:29:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C81446F3D;
	Tue,  9 Mar 2021 16:29:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33400C000A;
	Tue,  9 Mar 2021 16:29:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBF28C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B8D7F46F3D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZxEJebJP2pU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:29:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B986E400B8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615307360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSaGyOLWX+NEWKQMtAmx6cE0h7h+IwRRgb4ZBbKVgjA=;
 b=bGih4+FptEHrBRJhqu5uh7/bz5QMoW0pBok816Tw2rLWxB3TH84t11IONBpNbaJMlTAWCj
 BtW3T2+7pFEOoTQybcYCKD1Kk0F6uIsTkBcR9ViIsv6uovxc4X7EuFbEUIdJiRgYYdLz19
 CJme1SgHhG0EnafahbH205aecjH3o8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-9MI7-g3zN_CJjzd-XPQQXA-1; Tue, 09 Mar 2021 11:29:17 -0500
X-MC-Unique: 9MI7-g3zN_CJjzd-XPQQXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 135A2101F00D;
 Tue,  9 Mar 2021 16:29:15 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42D871A867;
 Tue,  9 Mar 2021 16:29:02 +0000 (UTC)
Subject: Re: [PATCH 6/9] virtio_balloon: remove the balloon-kvm file system
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-7-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c5c1b993-d391-b689-2293-97bba22368f1@redhat.com>
Date: Tue, 9 Mar 2021 17:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-7-hch@lst.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
 Nadav Amit <namit@vmware.com>, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 09.03.21 16:53, Christoph Hellwig wrote:
> Just use the generic anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/virtio/virtio_balloon.c | 30 +++---------------------------
>   1 file changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index cae76ee5bdd688..1efb890cd3ff09 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -6,6 +6,7 @@
>    *  Copyright 2008 Rusty Russell IBM Corporation
>    */
>   
> +#include <linux/anon_inodes.h>
>   #include <linux/virtio.h>
>   #include <linux/virtio_balloon.h>
>   #include <linux/swap.h>
> @@ -42,10 +43,6 @@
>   	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
>   #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
>   
> -#ifdef CONFIG_BALLOON_COMPACTION
> -static struct vfsmount *balloon_mnt;
> -#endif
> -
>   enum virtio_balloon_vq {
>   	VIRTIO_BALLOON_VQ_INFLATE,
>   	VIRTIO_BALLOON_VQ_DEFLATE,
> @@ -805,18 +802,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>   
>   	return MIGRATEPAGE_SUCCESS;
>   }
> -
> -static int balloon_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, BALLOON_KVM_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type balloon_fs = {
> -	.name           = "balloon-kvm",
> -	.init_fs_context = balloon_init_fs_context,
> -	.kill_sb        = kill_anon_super,
> -};
> -
>   #endif /* CONFIG_BALLOON_COMPACTION */
>   
>   static unsigned long shrink_free_pages(struct virtio_balloon *vb,
> @@ -909,17 +894,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
>   		goto out_free_vb;
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
> -	balloon_mnt = kern_mount(&balloon_fs);
> -	if (IS_ERR(balloon_mnt)) {
> -		err = PTR_ERR(balloon_mnt);
> -		goto out_del_vqs;
> -	}
> -
>   	vb->vb_dev_info.migratepage = virtballoon_migratepage;
> -	vb->vb_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
> +	vb->vb_dev_info.inode = alloc_anon_inode();
>   	if (IS_ERR(vb->vb_dev_info.inode)) {
>   		err = PTR_ERR(vb->vb_dev_info.inode);
> -		goto out_kern_unmount;
> +		goto out_del_vqs;
>   	}
>   	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>   #endif
> @@ -1016,8 +995,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>   out_iput:
>   #ifdef CONFIG_BALLOON_COMPACTION
>   	iput(vb->vb_dev_info.inode);
> -out_kern_unmount:
> -	kern_unmount(balloon_mnt);
>   out_del_vqs:
>   #endif
>   	vdev->config->del_vqs(vdev);
> @@ -1070,7 +1047,6 @@ static void virtballoon_remove(struct virtio_device *vdev)
>   	if (vb->vb_dev_info.inode)
>   		iput(vb->vb_dev_info.inode);
>   
> -	kern_unmount(balloon_mnt);
>   #endif
>   	kfree(vb);
>   }
> 

... you might know what I am going to say :)

Apart from that LGTM.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
