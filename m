Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67F8C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:26:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690A661574
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690A661574
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 267FD83D44;
	Tue,  9 Mar 2021 16:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u75LcRXJkxHI; Tue,  9 Mar 2021 16:26:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C069D83CD5;
	Tue,  9 Mar 2021 16:26:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91066C000A;
	Tue,  9 Mar 2021 16:26:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1C1AC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2F2883D40
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LiYVbUCJK0C3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:26:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC10E83CD5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615307191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDc/X1+87E7IT2HUEvNRCZ2BjXCFrZE0D42derxTKz0=;
 b=Rj7megbT3ZnaJVu6v6GHR7ErBpdzGK9gcEME3OT9GH38vrvkdTj/gik6bGImow//XcHgXx
 mz/avtYQXbVNNdI841QJp/AJtSVBL4Jfw8s4xNEAPAPPA5Mn2sAWkl/OM1Da2zRrs3ScHE
 sTAgY19wj3yWf6WTGLTbOAr2tMEmuTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-Q3Hdf_Q4ODeKumoAfx1BcQ-1; Tue, 09 Mar 2021 11:26:24 -0500
X-MC-Unique: Q3Hdf_Q4ODeKumoAfx1BcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374F7108BD08;
 Tue,  9 Mar 2021 16:26:22 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1707A19C59;
 Tue,  9 Mar 2021 16:26:18 +0000 (UTC)
Subject: Re: [PATCH 3/9] powerpc/pseries: remove the ppc-cmm file system
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-4-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <001be2e1-995c-d5d9-734f-06f75c702b42@redhat.com>
Date: Tue, 9 Mar 2021 17:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-4-hch@lst.de>
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
>   arch/powerpc/platforms/pseries/cmm.c | 27 ++-------------------------
>   1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 6d36b858b14df1..9d07e6bea7126c 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -6,6 +6,7 @@
>    * Author(s): Brian King (brking@linux.vnet.ibm.com),
>    */
>   
> +#include <linux/anon_inodes.h>
>   #include <linux/ctype.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
> @@ -502,19 +503,6 @@ static struct notifier_block cmm_mem_nb = {
>   };
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
> -static struct vfsmount *balloon_mnt;
> -
> -static int cmm_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, PPC_CMM_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type balloon_fs = {
> -	.name = "ppc-cmm",
> -	.init_fs_context = cmm_init_fs_context,
> -	.kill_sb = kill_anon_super,
> -};
> -
>   static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>   			   struct page *newpage, struct page *page,
>   			   enum migrate_mode mode)
> @@ -573,19 +561,10 @@ static int cmm_balloon_compaction_init(void)
>   	balloon_devinfo_init(&b_dev_info);
>   	b_dev_info.migratepage = cmm_migratepage;
>   
> -	balloon_mnt = kern_mount(&balloon_fs);
> -	if (IS_ERR(balloon_mnt)) {
> -		rc = PTR_ERR(balloon_mnt);
> -		balloon_mnt = NULL;
> -		return rc;
> -	}
> -
> -	b_dev_info.inode = alloc_anon_inode_sb(balloon_mnt->mnt_sb);
> +	b_dev_info.inode = alloc_anon_inode();
>   	if (IS_ERR(b_dev_info.inode)) {
>   		rc = PTR_ERR(b_dev_info.inode);
>   		b_dev_info.inode = NULL;
> -		kern_unmount(balloon_mnt);
> -		balloon_mnt = NULL;
>   		return rc;
>   	}
>   
> @@ -597,8 +576,6 @@ static void cmm_balloon_compaction_deinit(void)
>   	if (b_dev_info.inode)
>   		iput(b_dev_info.inode);
>   	b_dev_info.inode = NULL;
> -	kern_unmount(balloon_mnt);
> -	balloon_mnt = NULL;
>   }
>   #else /* CONFIG_BALLOON_COMPACTION */
>   static int cmm_balloon_compaction_init(void)
> 

I always wondered why that was necessary after all (with my limited fs 
knowledge :) ).

a) I assume you want to remove PPC_CMM_MAGIC from 
include/uapi/linux/magic.h as well?

b) Do we still need #include <linux/magic.h>, #include <linux/mount.h> 
and #include <linux/pseudo_fs.h>?

Apart from that looks much cleaner.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
