Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51AC433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:28:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA7A61574
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA7A61574
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70A2683D90;
	Tue,  9 Mar 2021 16:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouqA2DMW6bBF; Tue,  9 Mar 2021 16:28:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 171D483D72;
	Tue,  9 Mar 2021 16:28:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E22E5C000A;
	Tue,  9 Mar 2021 16:28:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2378C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 836A8430B6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DPJA6lERmLvO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:28:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C068542FC7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615307312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Iv7BBIxQ8+W8sz1TqvejVKfcifyHSm+wQDXMt7okOA=;
 b=BOYqXhuTDVLs6z/NFxBWkic1NlUbZFgL7E7llk+r8WWAykhK5TuIXNRHoiapge6mi5GoTf
 Ojw1604x0HgOz09Hd8cFk7bUa+ghkjnGol8bDUmkqoqYxgw7mrE8StJJjWkIjRvWFa1nuG
 C2kvj4IvJ8r9PooqU/WP0sE8ROEWOrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-2LKAOAxWMcKIauY_Ng6y0g-1; Tue, 09 Mar 2021 11:28:28 -0500
X-MC-Unique: 2LKAOAxWMcKIauY_Ng6y0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CCD108BD0B;
 Tue,  9 Mar 2021 16:28:26 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E403E10023AE;
 Tue,  9 Mar 2021 16:28:16 +0000 (UTC)
Subject: Re: [PATCH 5/9] vmw_balloon: remove the balloon-vmware file system
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-6-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8bdd6f30-3cd1-ad7f-df95-bbb85623ae64@redhat.com>
Date: Tue, 9 Mar 2021 17:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-6-hch@lst.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
>   drivers/misc/vmw_balloon.c | 24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 5d057a05ddbee8..be4be32f858253 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -16,6 +16,7 @@
>   //#define DEBUG
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
> +#include <linux/anon_inodes.h>
>   #include <linux/types.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -1735,20 +1736,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
>   
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
> -
> -static int vmballoon_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type vmballoon_fs = {
> -	.name           	= "balloon-vmware",
> -	.init_fs_context	= vmballoon_init_fs_context,
> -	.kill_sb        	= kill_anon_super,
> -};
> -
> -static struct vfsmount *vmballoon_mnt;
> -
>   /**
>    * vmballoon_migratepage() - migrates a balloon page.
>    * @b_dev_info: balloon device information descriptor.
> @@ -1878,8 +1865,6 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
>   		iput(b->b_dev_info.inode);
>   
>   	b->b_dev_info.inode = NULL;
> -	kern_unmount(vmballoon_mnt);
> -	vmballoon_mnt = NULL;
>   }
>   
>   /**
> @@ -1895,13 +1880,8 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
>    */
>   static __init int vmballoon_compaction_init(struct vmballoon *b)
>   {
> -	vmballoon_mnt = kern_mount(&vmballoon_fs);
> -	if (IS_ERR(vmballoon_mnt))
> -		return PTR_ERR(vmballoon_mnt);
> -
>   	b->b_dev_info.migratepage = vmballoon_migratepage;
> -	b->b_dev_info.inode = alloc_anon_inode_sb(vmballoon_mnt->mnt_sb);
> -
> +	b->b_dev_info.inode = alloc_anon_inode();
>   	if (IS_ERR(b->b_dev_info.inode))
>   		return PTR_ERR(b->b_dev_info.inode);
>   
> 

Same comment regarding BALLOON_VMW_MAGIC and includes (mount.h, 
pseudo_fs.h).

Apart from that looks good.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
