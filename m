Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0356C43334
	for <virtualization@archiver.kernel.org>; Sun, 26 Jun 2022 10:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27540418D1;
	Sun, 26 Jun 2022 10:06:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27540418D1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TBT8HUXm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTffe0TOfV7E; Sun, 26 Jun 2022 10:06:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C971418B1;
	Sun, 26 Jun 2022 10:06:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C971418B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45CD8C007A;
	Sun, 26 Jun 2022 10:06:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B24F6C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76D788470E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76D788470E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TBT8HUXm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bS-G02tjEB4y
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:06:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E800D83E90
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E800D83E90
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656237998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PM53ZyiRE2Y6MtoCWE2Qvp7sGZnpAIPWEB1KZDVgiLw=;
 b=TBT8HUXmGJj2ncVgdVCtjCE6Y6EOm07Ifpy1yFipyzrZrGBG21e2P7yAJ6ochBwC5sqo2w
 rxrMdYnleNh/HnCDi/KzhROrJxBb0a9JIELoLfYKRZSJroj0YCjTvUKYfhu/6+w60fPt2y
 GNIs5Ur9J+HT9d7ELBUYcweYDGwK+cA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-TCqCWWEHMN2jqkhC-qoM5A-1; Sun, 26 Jun 2022 06:06:37 -0400
X-MC-Unique: TCqCWWEHMN2jqkhC-qoM5A-1
Received: by mail-ed1-f71.google.com with SMTP id
 m8-20020a056402430800b00435cfa7c6d1so5085532edc.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 03:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PM53ZyiRE2Y6MtoCWE2Qvp7sGZnpAIPWEB1KZDVgiLw=;
 b=WYZ+Zw+5JUdL+Fn40OD7RTrHNga6LJCHWgClKYM3XWdI+8VAazSOXP+Y4cdWKPiHjV
 EfdGGJs7fgJ5Mo9egHvBilYC5/QqdGcjbuEI2tS7R0U2gS0RVCIH6hIglGWm/vFr43zM
 ivj/50odgfrXAEiuTlTZnDwdk9vYQxTN4a/Z38DO6MbdgiazcHGi2bVp9wfOlSE1eYSA
 qvYDiqhFdN4R4xm6xrccPFt6IDzLaeqHCm/jVeXxO1Zmhn2tiLT9u8So0Tcr60hVNIvs
 yXYOnRaVLOF7KDyVN8481T2mZsCby8wAti3Z9qWenhKUKmrlQGJ/9Q3ugvJOm+ZNxX5J
 qpTg==
X-Gm-Message-State: AJIora88zNEhwdW06rAybwIYS1c3FGNhVsD9S1WO9SmCIIXeK8RVZAyS
 kAUscw38A6RHZ6vP/YpTR4mP8drMPWEm8iM4x9xZ8LiL75a7iNKOHcLlaCvQbzw9j0moim2zYbC
 X5BsFZepWbEup49JJQIL0k6rE1Ms5zUTcoS7sY6whZA==
X-Received: by 2002:a17:907:2d08:b0:726:35bd:b3c1 with SMTP id
 gs8-20020a1709072d0800b0072635bdb3c1mr7318653ejc.281.1656237995943; 
 Sun, 26 Jun 2022 03:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sR6/NOEJBvmum3KtZh4MNJRHib/2vaboCpV41MaaHJUXpUm9TdfochNuki2EeE9Zq7sqq2WQ==
X-Received: by 2002:a17:907:2d08:b0:726:35bd:b3c1 with SMTP id
 gs8-20020a1709072d0800b0072635bdb3c1mr7318631ejc.281.1656237995618; 
 Sun, 26 Jun 2022 03:06:35 -0700 (PDT)
Received: from redhat.com ([2.54.171.2]) by smtp.gmail.com with ESMTPSA id
 a7-20020a056402236700b0043570d96d25sm5604121eda.95.2022.06.26.03.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jun 2022 03:06:35 -0700 (PDT)
Date: Sun, 26 Jun 2022 06:06:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v3 2/2] vdpa: Do not count the pages that were already
 pinned in the vhost-vDPA
Message-ID: <20220626060331-mutt-send-email-mst@kernel.org>
References: <20220626090409.1011144-2-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220626090409.1011144-2-lulu@redhat.com>
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

On Sun, Jun 26, 2022 at 05:04:09PM +0800, Cindy Lu wrote:
> we add a tree vdpa_mem_tree to save the page that counted.
> we will not count it again if the address already in this tree.
> Here is the process that we count the newly add/del mem
> 1.remove all the node have overlap address from this tree.
> 2.if this range is newly added then add the new node(ref=1) to the tree,
>   if this range is already in the tree, then change the ref to ref+1
>    and add back to the tree(split the node if needed)
> 3. Counted the size newly add to the tree.
> Del the address is the same process
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Sorry I don't really understand the commit log or the comments.
What are we trying to do here?
A bunch of typos and coding style violations all of the place
don't really help either ...

Try adding a cover letter to the patchset maybe.


> ---
>  drivers/vhost/vdpa.c | 467 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 456 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 5ad2596c6e8a..e9de24c437ff 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -24,6 +24,9 @@
>  #include <linux/vhost.h>
>  
>  #include "vhost.h"
> +#include <linux/rbtree.h>
> +#include <linux/interval_tree.h>
> +#include <linux/interval_tree_generic.h>
>  
>  enum {
>  	VHOST_VDPA_BACKEND_FEATURES =
> @@ -65,6 +68,12 @@ static DEFINE_IDA(vhost_vdpa_ida);
>  
>  static dev_t vhost_vdpa_major;
>  
> +struct vdpa_tree_node {
> +	struct interval_tree_node tree_node;
> +	struct list_head list_node;
> +	u64 ref;
> +};
> +
>  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
>  {
>  	struct vhost_vdpa_as *as = container_of(iotlb, struct
> @@ -470,6 +479,430 @@ static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __user *argp)
>  	return 0;
>  }
>  
> +int vhost_vdpa_add_node(struct rb_root_cached *root, u64 start, u64 last,
> +			u64 ref)
> +{
> +	struct interval_tree_node *new_node;
> +	struct vdpa_tree_node *vdpa_node;
> +
> +	if (last < start)
> +		return -EFAULT;
> +
> +	/* If the range being mapped is [0, ULONG_MAX], split it into two entries
> +	 * otherwise its size would overflow u64.
> +	 */
> +	if (start == 0 && last == ULONG_MAX) {
> +		u64 mid = last / 2;
> +
> +		vhost_vdpa_add_node(root, start, mid, ref);
> +		start = mid + 1;
> +	}
> +	vdpa_node = kmalloc(sizeof(struct vdpa_tree_node), GFP_ATOMIC);
> +	if (!vdpa_node)
> +		return -ENOMEM;
> +
> +	new_node = &vdpa_node->tree_node;
> +
> +	new_node->start = start;
> +	new_node->last = last;
> +	vdpa_node->ref = ref;
> +
> +	interval_tree_insert(new_node, root);
> +
> +	return 0;
> +}
> +
> +/**
> + * vhost_vdpa_range_ref_add()
> + * the main process is
> + * 1. if the range not in the tree, add the new tree_node and make the ref =1
> + * 2. if a part of the rang in the tree_node, splt the tree_node, count the ref
> + * @root:	the rb_root for this tree, this tree saved the range of address that used
> + * @start:	starting  address
> + * @last:	the end  address
> + * @list_node_head: the list of the node that have overlaped with the range
> + *
> + * @size_count : this size is the newly added/del size, if the address
> + * range already in the vdpa_tree then we will not count it again
> + */
> +
> +int vhost_vdpa_range_ref_add(struct rb_root_cached *root,
> +			     struct list_head *list_node_head, int node_number,
> +			     u64 start, u64 last, u64 *size_count)
> +
> +{
> +	int i, ret = 0;
> +	u64 size = 0;
> +	u64 ref;
> +	u64 node_start, node_last, range_start, range_last;
> +	int range_size;
> +	struct list_head *list_node;
> +	struct vdpa_tree_node *vdpa_node = NULL;
> +	struct interval_tree_node *node = NULL;
> +
> +	if (node_number == 0) {
> +		ret = vhost_vdpa_add_node(root, start, last, 1);
> +
> +		size = last - start + 1;
> +		*size_count = size;
> +		return ret;
> +	}
> +
> +	list_node = list_node_head;
> +	range_start = start;
> +	range_last = last;
> +
> +	for (i = 0; i < node_number; i++) {
> +		vdpa_node = container_of(list_node, struct vdpa_tree_node,
> +					 list_node);
> +
> +		node = &vdpa_node->tree_node;
> +		ref = vdpa_node->ref;
> +		node_start = node->start;
> +		node_last = node->last;
> +
> +		list_node = list_node->next;
> +
> +		/* checking the size and count ref */
> +		/* 1: all these nodes are removed from the tree*/
> +		/* 2: all these nodes are sorted in ascending order*/
> +		/* 3: in this is loop the largest address we work in will be the node_last */
> +		/* 4: if the range_last larger the node last, will work in next node*/
> +		/* 5: the range_start in next loop will be node_last+1*/
> +
> +		if (range_start == node_start) {
> +			if (node_last <= range_last) {
> +				/* this comment the layout of the range and node in this loop*/
> +
> +				/* range_start= =node_start---node_last--range_last*/
> +				ret = vhost_vdpa_add_node(root, node_start,
> +							  node_last, ref + 1);
> +				/*node_last+1--range_last will count in next loop */
> +			} else {
> +				/* range_start== node_start---range_last---node_last*/
> +				ret = vhost_vdpa_add_node(root, node_start,
> +							  range_last, ref + 1);
> +				ret += vhost_vdpa_add_node(root, range_last + 1,
> +							   node_last, ref);
> +			}
> +		} else if (node_start < range_start) {
> +			if (range_last < node_last) {
> +				/* node_start---range_last---range_last---node_last*/
> +				ret = vhost_vdpa_add_node(root, node_start,
> +							  range_start - 1, ref);
> +				ret += vhost_vdpa_add_node(root, range_start,
> +							   range_last, ref + 1);
> +				ret += vhost_vdpa_add_node(root, range_last + 1,
> +							   node_last, ref);
> +
> +			} else {
> +				/* node_start---range_last---node_last= =range_last*/
> +				ret = vhost_vdpa_add_node(root, node_start,
> +							  range_start - 1, ref);
> +				ret += vhost_vdpa_add_node(root, range_start,
> +							   node_last, ref + 1);
> +			}
> +		} else {
> +			if (node_last <= range_last) {
> +				/* range_start---node_start---node_last ----range_last  */
> +
> +				ret = vhost_vdpa_add_node(root, range_start,
> +							  node_start - 1, 1);
> +				ret += vhost_vdpa_add_node(root, node_start,
> +							   node_last, ref + 1);
> +				size += ((node_start - 1) - range_start) + 1;
> +			} else {
> +				/* range_start---node_start---range_last --node_last*/
> +				ret = vhost_vdpa_add_node(root, range_start,
> +							  node_start - 1, 1);
> +				ret += vhost_vdpa_add_node(root, node_start,
> +							   range_last, ref + 1);
> +				ret += vhost_vdpa_add_node(root, range_last + 1,
> +							   node_last, ref);
> +				size += ((node_start - 1) - range_start) + 1;
> +			}
> +		}
> +
> +		/* move range_start to next node*/
> +		range_start = node_last + 1;
> +		if ((range_start > range_last) || (ret != 0))
> +			break;
> +	}
> +
> +	range_size = range_last - range_start;
> +	/* last round and but still some range left */
> +	/*start with node_last+1 end with range_last*/
> +
> +	if (node_number == i + 1) {
> +		if ((range_size >= 0) && (range_start >= node_last)) {
> +			ret = vhost_vdpa_add_node(root, range_start, range_last,
> +						  1);
> +			size = size + (range_last - range_start) + 1;
> +
> +			*size_count = size;
> +
> +			return ret;
> +
> +		} else if (range_size == -1) {
> +			/*this means the node_last ==range_last in final loop */
> +			*size_count = size;
> +
> +			return ret;
> +		}
> +	}
> +
> +	return -EFAULT;
> +}
> +/**
> + * vhost_vdpa_range_ref_del()
> + * the main process is
> + * 1. if the range not in the tree, return -1
> + * 2. if a part of the rang in the tree_node, splt the tree_node, count the ref
> + *
> + * @root:	the rb_root for this tree, this tree saved the range of address that used
> + * @start:	starting  address
> + * @last:	the end  address
> + * @list_node_head: the list of the node that have overlaped with the range
> + *
> + * OUT @size_count : this size is the newly added/del size
> + */
> +
> +int vhost_vdpa_range_ref_del(struct rb_root_cached *root,
> +			     struct list_head *list_node_head, int node_number,
> +			     u64 start, u64 last, u64 *size_count)
> +{
> +	int i, ret = 0;
> +	u64 size = 0;
> +	u64 ref;
> +	u64 node_start, node_last, range_start, range_last;
> +	int range_size;
> +	struct list_head *list_node;
> +	struct vdpa_tree_node *vdpa_node = NULL;
> +	struct interval_tree_node *node = NULL;
> +
> +	if (node_number == 0) {
> +		/* the address range not in the tree */
> +		*size_count = 0;
> +		return -EFAULT;
> +	}
> +
> +	list_node = list_node_head;
> +
> +	range_start = start;
> +	range_last = last;
> +
> +	for (i = 0; i < node_number; i++) {
> +		vdpa_node = container_of(list_node, struct vdpa_tree_node,
> +					 list_node);
> +
> +		node = &vdpa_node->tree_node;
> +		ref = vdpa_node->ref;
> +		node_start = node->start;
> +		node_last = node->last;
> +		list_node = list_node->next;
> +
> +		/* checking the size and count ref, here are some note here */
> +		/* 1: these nodes are removed from tree, we just need to check ref and add it back*/
> +		/* 2: all these nodes are sorted in ascending order*/
> +		/* 3: in this is loop the largest address we work in will be the node_last */
> +		/* 4: if the range_last larger the node last, will work in next node*/
> +
> +		if (range_start == node_start) {
> +			if (node_last < range_last) {
> +				/*this comment is the layout for this memory*/
> +				/*range_start==node_start---node_last----range_last*/
> +				if (ref > 1) {
> +					ret = vhost_vdpa_add_node(root,
> +								  node_start,
> +								  node_last,
> +								  ref - 1);
> +				} else {
> +					/*new ref ==0, don't need add it back, count the size*/
> +					size += (node_last - node_start) + 1;
> +				}
> +
> +			} else if (node_last > range_last) {
> +				/*range_start== node_start--range_last---node_last*/
> +
> +				if (ref > 1) {
> +					ret = vhost_vdpa_add_node(root,
> +								  node_start,
> +								  range_last,
> +								  ref - 1);
> +				} else {
> +					/*new ref ==0, don't need add it back, count the size*/
> +					size += (range_last - node_start) + 1;
> +				}
> +				ret = vhost_vdpa_add_node(root, range_last + 1,
> +							  node_last, ref);
> +			} else {
> +				/*range_start== node_start---range_last = =node_last*/
> +
> +				if (ref > 1) {
> +					ret = vhost_vdpa_add_node(root,
> +								  node_start,
> +								  range_last,
> +								  ref - 1);
> +				} else {
> +					size += (range_last - node_start) + 1;
> +				}
> +			}
> +		} else if (node_start < range_start) {
> +			if (range_last < node_last) {
> +				/* node_start--range_start--range_last--node_last*/
> +				ret = vhost_vdpa_add_node(root, node_start,
> +							  range_start - 1, ref);
> +				if (ref > 1) {
> +					ret += vhost_vdpa_add_node(root,
> +								   range_start,
> +								   range_last,
> +								   ref - 1);
> +				} else {
> +					size += (range_last - range_start) + 1;
> +				}
> +				ret += vhost_vdpa_add_node(root, range_last + 1,
> +							   node_last, ref);
> +
> +			} else if (range_last > node_last) {
> +				/*node_start--range_start--node_last--range_last*/
> +
> +				ret = vhost_vdpa_add_node(root, node_start,
> +							  range_start - 1, ref);
> +				if (ref > 1) {
> +					ret = vhost_vdpa_add_node(root,
> +								  range_start,
> +								  node_last,
> +								  ref - 1);
> +				} else {
> +					size += (node_last - range_start) + 1;
> +				}
> +			} else {
> +				/*node_start---range_start---node_last==range_last*/
> +				ret = vhost_vdpa_add_node(root, node_start,
> +							  range_start - 1, ref);
> +				if (ref > 1) {
> +					ret = vhost_vdpa_add_node(root,
> +								  range_start,
> +								  range_last,
> +								  ref - 1);
> +				} else {
> +					size += (range_last - range_start) + 1;
> +				}
> +			}
> +		} else {
> +			/* some range not in the node, should not happened*/
> +			*size_count = size;
> +			return -EFAULT;
> +		}
> +
> +		range_start = node_last + 1;
> +		if ((range_start > range_last) || (ret != 0))
> +			break;
> +	}
> +
> +	range_size = range_last - range_start;
> +
> +	/* last round and still some range, this should not happened*/
> +
> +	if ((range_size > 0) && (node_number == i + 1))
> +		return -EFAULT;
> +
> +	*size_count = size;
> +	return ret;
> +}
> +/**
> + * vhost_vdpa_range_ops()
> + * @root:	the rb_root for this tree, this tree saved the range of address that used
> + * @start:	starting  address
> + * @last:	the end  address
> + * @ops:	the opreater for this BOOL true means to add the range of address
> + *      FALSE means to del the range address
> + * OUTPUT@size_count : this size is the SIZE newly added/del,
> + * if the address range already in the vdpa_tree, will not count it again
> + */
> +int vhost_vdpa_range_ops(struct rb_root_cached *root, u64 start, u64 last,
> +			 bool ops, u64 *size_count)
> +{
> +	struct interval_tree_node *node = NULL;
> +	struct vdpa_tree_node *vdpa_node;
> +	struct list_head *list_node = NULL;
> +	struct vdpa_tree_node dummyHead = { 0 };
> +	int node_number = 0;
> +	int i = 0;
> +	int ret;
> +
> +	INIT_LIST_HEAD(&dummyHead.list_node);
> +
> +	/*search the rang overlaped, and del from the tree*/
> +	while ((node = interval_tree_iter_first(root, start, last)) != NULL) {
> +		node_number++;
> +		vdpa_node =
> +			container_of(node, struct vdpa_tree_node, tree_node);
> +
> +		list_node = &vdpa_node->list_node;
> +
> +		/* Remove the node overlaped with the range from the tree*/
> +		/* otherwish it will count again in a loop */
> +		interval_tree_remove(node, root);
> +		list_add_tail(list_node, &dummyHead.list_node);
> +	}
> +
> +	list_node = (&dummyHead.list_node)->next;
> +
> +	/* check the ref and add/del to tree*/
> +	if (ops == true) {
> +		ret = vhost_vdpa_range_ref_add(root, list_node, node_number,
> +					       start, last, size_count);
> +	} else {
> +		ret = vhost_vdpa_range_ref_del(root, list_node, node_number,
> +					       start, last, size_count);
> +	}
> +
> +	/*free all the node overlaped with the range*/
> +	for (i = 0; i < node_number; i++) {
> +		vdpa_node = container_of(list_node, struct vdpa_tree_node,
> +					 list_node);
> +
> +		list_node = list_node->next;
> +		kfree(vdpa_node);
> +	}
> +
> +	return ret;
> +}
> +int vhost_vdpa_range_add(struct vhost_vdpa *v, u64 start, u64 last,
> +			 u64 *size_count)
> +
> +{
> +	int r;
> +	struct vhost_dev *dev = &v->vdev;
> +
> +	r = vhost_vdpa_range_ops(dev->vdpa_mem_tree, start, last, true,
> +				 size_count);
> +	if (unlikely(r))
> +		dev_info(&v->dev,
> +			 "vhost vdpa range add fail start %lld last %lld %lld",
> +			 start, last, *size_count);
> +
> +	return r;
> +}
> +
> +int vhost_vdpa_range_del(struct vhost_vdpa *v, u64 start, u64 last,
> +			 u64 *size_count)
> +
> +{
> +	int r;
> +	struct vhost_dev *dev = &v->vdev;
> +
> +	r = vhost_vdpa_range_ops(dev->vdpa_mem_tree, start, last, false,
> +				 size_count);
> +	if (unlikely(r))
> +		dev_info(&v->dev,
> +			 "vhost vdpa range del fail start %lld last %lld %lld",
> +			 start, last, *size_count);
> +
> +	return r;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				   void __user *argp)
>  {
> @@ -658,6 +1091,7 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
>  	struct vhost_dev *dev = &v->vdev;
>  	struct vhost_iotlb_map *map;
>  	struct page *page;
> +	u64 size;
>  	unsigned long pfn, pinned;
>  
>  	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
> @@ -669,7 +1103,10 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
>  				set_page_dirty_lock(page);
>  			unpin_user_page(page);
>  		}
> -		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
> +
> +		vhost_vdpa_range_del(v, map->start, map->start + map->size - 1,
> +				     &size);
> +		atomic64_sub(PFN_DOWN(size), &dev->mm->pinned_vm);
>  		vhost_iotlb_map_free(iotlb, map);
>  	}
>  }
> @@ -731,6 +1168,20 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	u32 asid = iotlb_to_asid(iotlb);
>  	int r = 0;
> +	u64 size_count;
> +	unsigned long lock_limit;
> +
> +	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> +	if (!vdpa->use_va) {
> +		r = vhost_vdpa_range_add(v, iova, iova + size - 1, &size_count);
> +
> +		if (size_count + atomic64_read(&dev->mm->pinned_vm) >
> +		    lock_limit) {
> +			r = vhost_vdpa_range_del(v, iova, iova + size - 1,
> +						 &size_count);
> +			return -ENOMEM;
> +		}
> +	}
>  
>  	r = vhost_iotlb_add_range_ctx(iotlb, iova, iova + size - 1,
>  				      pa, perm, opaque);
> @@ -748,11 +1199,11 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  	}
>  	if (r) {
>  		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
> +		r = vhost_vdpa_range_del(v, iova, iova + size - 1, &size_count);
>  		return r;
>  	}
> -
>  	if (!vdpa->use_va)
> -		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
> +		atomic64_add(PFN_DOWN(size_count), &dev->mm->pinned_vm);
>  
>  	return 0;
>  }
> @@ -843,7 +1294,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> -	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long sz2pin, nchunks, i;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -864,12 +1315,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  
>  	mmap_read_lock(dev->mm);
>  
> -	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> -	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> -
>  	cur_base = uaddr & PAGE_MASK;
>  	iova &= PAGE_MASK;
>  	nchunks = 0;
> @@ -951,7 +1396,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  		}
>  		vhost_vdpa_unmap(v, iotlb, start, size);
>  	}
> -unlock:
> +
>  	mmap_read_unlock(dev->mm);
>  free:
>  	free_page((unsigned long)page_list);
> -- 
> 2.34.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
