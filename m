Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13A2C43334
	for <virtualization@archiver.kernel.org>; Sun, 26 Jun 2022 10:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CDF8847FA;
	Sun, 26 Jun 2022 10:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CDF8847FA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZFW4LBvO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hnfCdr1hqzsm; Sun, 26 Jun 2022 10:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9314384788;
	Sun, 26 Jun 2022 10:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9314384788
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 032D6C0032;
	Sun, 26 Jun 2022 10:01:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF9B0C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73CC184788
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:01:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73CC184788
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dz86eSQupGMv
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:01:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 930F584778
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 930F584778
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656237707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGRXKmqSxDtj1hckKrQgcnRl/49ZwsnnCJ2CdZjop+w=;
 b=ZFW4LBvOqxV6MICKkFK5wy2kKeWRWtT10Fc1D5xEcMo3vBp+bC1XxMHRb+3pbLRzSSjeNd
 mGlswbK3xP5XqI3PWjnRRuWfzaykx2WrcfGr3kMlVJjGZBVP8BDEVEOjrVgvSSDviRV6W8
 g/72A3rklBvc8tn3Od7RogzWKc5uSgM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-eFMm6sAkM6WgmZOahunFJA-1; Sun, 26 Jun 2022 06:01:46 -0400
X-MC-Unique: eFMm6sAkM6WgmZOahunFJA-1
Received: by mail-ed1-f69.google.com with SMTP id
 m8-20020a056402430800b00435cfa7c6d1so5080326edc.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 03:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aGRXKmqSxDtj1hckKrQgcnRl/49ZwsnnCJ2CdZjop+w=;
 b=YEFqnshpkn3JQXo+k31+TZ1EIIuD5Mukr4t/+thyXVF4w0IOpWRvJVkIDYg62Qruz9
 oZ7AgqnNLJDW1UMtCG9lPVsT0yynBDHofrHK3a9v9Byx/OhZT8aP7L9/WP9Lh0Xc3hmG
 VRs8lz0D7cYBU36Z3zZPrX9U+6G90v0hfpmRGYCidhVo+QDVUcU1TFelbNGuH9l8IGow
 A4Hh/3PEmtnNbUOL4vwWdv+BtpiFG3xnQZd8DgGJQ98kPkj3nLbpKVJ4eqHQEdMhj9qm
 mvU0J0y2U8nKnQBU8TgRQKrQRDv3JrzDzndPdB/b9nnY9Za3Zs4Yma5NnTVtIwZMfozo
 XQ0Q==
X-Gm-Message-State: AJIora88i7+UmYO91G6RHOZMGoyaLu1vl1xxCSwll094BHdDtoi93qFN
 LYyfnL067PBZfPf5O7ayVLGaX7nPsDIgEMNCiiLp7qyWyDkDGjCSFLMn8RoYmIqoe1twNIB68+C
 3oNzXrXhM696Qi/yKc4CzYEtFZoeQt+DUrKk9iaEaXw==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id
 nc1-20020a1709071c0100b006f426920e23mr7265537ejc.243.1656237705083; 
 Sun, 26 Jun 2022 03:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vzneybgFRlHz5QAI5O/BC0DJ2foBJhXk1XUb/VF1+f0prhtW/kY8X0TARuHTVpptEZSfiY2g==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id
 nc1-20020a1709071c0100b006f426920e23mr7265509ejc.243.1656237704807; 
 Sun, 26 Jun 2022 03:01:44 -0700 (PDT)
Received: from redhat.com ([2.54.171.2]) by smtp.gmail.com with ESMTPSA id
 f20-20020a17090660d400b00711edab7622sm3595385ejk.40.2022.06.26.03.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jun 2022 03:01:44 -0700 (PDT)
Date: Sun, 26 Jun 2022 06:01:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
Message-ID: <20220626055420-mutt-send-email-mst@kernel.org>
References: <20220626090409.1011144-1-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220626090409.1011144-1-lulu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> We count pinned_vm as follow in vhost-vDPA
> 
> lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>          ret = -ENOMEM;
>          goto unlock;
> }
> This means if we have two vDPA devices for the same VM the pages
> would be counted twice. So we add a tree to save the page that
> counted and we will not count it again.
> 
> Add vdpa_mem_tree to saved the mem that already counted.
> use a hlist to saved the root for vdpa_mem_tree.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 40097826cff0..4ca8b1ed944b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -32,6 +32,8 @@
>  #include <linux/kcov.h>
>  
>  #include "vhost.h"
> +#include <linux/hashtable.h>
> +#include <linux/jhash.h>
>  
>  static ushort max_mem_regions = 64;
>  module_param(max_mem_regions, ushort, 0444);
> @@ -49,6 +51,14 @@ enum {
>  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
>  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
>  
> +struct vhost_vdpa_rbtree_node {
> +	struct hlist_node node;
> +	struct rb_root_cached vdpa_mem_tree;
> +	struct mm_struct *mm_using;
> +};
> +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> +int vhost_vdpa_rbtree_hlist_status;
> +
>  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
>  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
>  {

Are you trying to save some per-mm information here?
Can't we just add it to mm_struct?



> @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>  	dev->mm = NULL;
>  }
>  
> +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> +{
> +	struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> +	struct rb_root_cached *vdpa_tree;
> +	u32 key;
> +
> +	/* No hased table, init one */
> +	if (vhost_vdpa_rbtree_hlist_status == 0) {
> +		hash_init(vhost_vdpa_rbtree_hlist);
> +		vhost_vdpa_rbtree_hlist_status = 1;
> +	}
> +
> +	key = jhash_1word((u64)mm, JHASH_INITVAL);
> +	hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> +			       key) {
> +		if (rbtree_root->mm_using == mm)
> +			return &(rbtree_root->vdpa_mem_tree);
> +	}
> +	rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> +	if (!rbtree_root)
> +		return NULL;
> +	rbtree_root->mm_using = mm;
> +	rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> +	hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> +	vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> +	return vdpa_tree;
> +}
> +
> +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> +{
> +	struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> +	u32 key;
> +
> +	key = jhash_1word((u64)mm, JHASH_INITVAL);
> +
> +	/* No hased table, init one */
> +	hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> +			       key) {
> +		if (rbtree_root->mm_using == mm) {
> +			hash_del(&rbtree_root->node);
> +			kfree(rbtree_root);
> +		}
> +	}
> +}
> +
>  /* Caller should have device mutex */
>  long vhost_dev_set_owner(struct vhost_dev *dev)
>  {
> @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  	err = vhost_dev_alloc_iovecs(dev);
>  	if (err)
>  		goto err_cgroup;
> +	dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> +	if (dev->vdpa_mem_tree == NULL) {
> +		err = -ENOMEM;
> +		goto err_cgroup;
> +	}
>  
>  	return 0;
>  err_cgroup:
> @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  		dev->worker = NULL;
>  	}
>  err_worker:
> +	vhost_vdpa_relase_mem_tree(dev->mm);
>  	vhost_detach_mm(dev);
>  	dev->kcov_handle = 0;
>  err_mm:
> @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  		dev->worker = NULL;
>  		dev->kcov_handle = 0;
>  	}
> +
> +	vhost_vdpa_relase_mem_tree(dev->mm);
>  	vhost_detach_mm(dev);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index d9109107af08..84de33de3abf 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -160,6 +160,7 @@ struct vhost_dev {
>  	int byte_weight;
>  	u64 kcov_handle;
>  	bool use_worker;
> +	struct rb_root_cached *vdpa_mem_tree;
>  	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
>  			   struct vhost_iotlb_msg *msg);
>  };
> -- 
> 2.34.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
