Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3946CC433E6
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:23:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE40165237
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 16:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE40165237
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90661834FC;
	Tue,  9 Mar 2021 16:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ea0wv7SaESEa; Tue,  9 Mar 2021 16:23:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ECD2833C6;
	Tue,  9 Mar 2021 16:23:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF1AFC000A;
	Tue,  9 Mar 2021 16:23:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5223AC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F8CA4CB15
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:23:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6mv6r6Z-tm6v
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:23:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 439634C51B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615306983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19LP5gRKwmwH1jc81ul4akn1QbWUor1+lZY/TUhT8Cc=;
 b=cHsbpwg1kbxz0VwZ74SDLLP5mlzcKi7zGLRE47K7e39IkHAAk2EpefF3bSXYGY26bKJxzx
 LzVf1X4dbPqZVM9N+QQTP7g+IjlX39oK3X+FitmeFb+yv/AbUsM9CH8MOKwIV8a7Cz4/7T
 V4UOTHnq//vXqoSatpT6w0bcJ89qq08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-6dAmojhlMgOOkpbQO0364g-1; Tue, 09 Mar 2021 11:22:58 -0500
X-MC-Unique: 6dAmojhlMgOOkpbQO0364g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 411A310199A6;
 Tue,  9 Mar 2021 16:22:56 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADE225C233;
 Tue,  9 Mar 2021 16:22:46 +0000 (UTC)
Subject: Re: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-3-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a0ca78b1-e663-8521-e69c-edae30b8082c@redhat.com>
Date: Tue, 9 Mar 2021 17:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-3-hch@lst.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> Add a new alloc_anon_inode helper that allocates an inode on
> the anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/anon_inodes.c            | 15 +++++++++++++--
>   include/linux/anon_inodes.h |  1 +
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 4745fc37014332..b6a8ea71920bc3 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -63,7 +63,7 @@ static struct inode *anon_inode_make_secure_inode(
>   	const struct qstr qname = QSTR_INIT(name, strlen(name));
>   	int error;
>   
> -	inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
> +	inode = alloc_anon_inode();
>   	if (IS_ERR(inode))
>   		return inode;
>   	inode->i_flags &= ~S_PRIVATE;
> @@ -225,13 +225,24 @@ int anon_inode_getfd_secure(const char *name, const struct file_operations *fops
>   }
>   EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
>   
> +/**
> + * alloc_anon_inode - create a new anonymous inode
> + *
> + * Create an inode on the anon_inode file system and return it.
> + */
> +struct inode *alloc_anon_inode(void)
> +{
> +	return alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
> +}
> +EXPORT_SYMBOL_GPL(alloc_anon_inode);
> +
>   static int __init anon_inode_init(void)
>   {
>   	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
>   	if (IS_ERR(anon_inode_mnt))
>   		panic("anon_inode_init() kernel mount failed (%ld)\n", PTR_ERR(anon_inode_mnt));
>   
> -	anon_inode_inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
> +	anon_inode_inode = alloc_anon_inode();
>   	if (IS_ERR(anon_inode_inode))
>   		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
>   
> diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> index 71881a2b6f7860..b5ae9a6eda9923 100644
> --- a/include/linux/anon_inodes.h
> +++ b/include/linux/anon_inodes.h
> @@ -21,6 +21,7 @@ int anon_inode_getfd_secure(const char *name,
>   			    const struct file_operations *fops,
>   			    void *priv, int flags,
>   			    const struct inode *context_inode);
> +struct inode *alloc_anon_inode(void);
>   
>   #endif /* _LINUX_ANON_INODES_H */
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
