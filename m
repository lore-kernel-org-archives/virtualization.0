Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CAC4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 10:26:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5632560F41
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 10:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5632560F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BD606082A;
	Tue, 17 Aug 2021 10:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VKlKXbOaihWo; Tue, 17 Aug 2021 10:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B7EC96081A;
	Tue, 17 Aug 2021 10:26:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 990A5C001A;
	Tue, 17 Aug 2021 10:26:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DA82C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4835840370
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MoCAc5Y9H2zq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:26:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 525EB4036C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629196010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dPOZjn3V5im3EaSW+oKZSoZf4HaKDzmboAenj2oASbI=;
 b=WqxsD3Ir8BFLql3g5mImy4OlGMsmAMD3SkvjfdZLc8ii9QU6MKLeeZ8lIGZNj7q4MNkmpc
 xB2MBc5StvwLWNs791BdqaK7Lttm1SpetD+2t89vsT1xb0eocCEJRQ2wiwvYhYnXSlgHot
 pou1p+bhdRYJvZuwkc7bOuPpncNPL6U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-TGMdmpXMMIGaLnBq9z895g-1; Tue, 17 Aug 2021 06:26:48 -0400
X-MC-Unique: TGMdmpXMMIGaLnBq9z895g-1
Received: by mail-wr1-f69.google.com with SMTP id
 q4-20020a05600000c400b00156d811312aso849572wrx.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dPOZjn3V5im3EaSW+oKZSoZf4HaKDzmboAenj2oASbI=;
 b=hXJ5GgNmt4iTM5V/jp0Dsc7bu81YdWRFcir8e3Yhj74ZEcSFXaFMpJJS26qwS4U8Ya
 YccLAYzlK8WtJHo1coeDVxvI1uKlLw1qzY6CFW5v/cQqZW4NH/uZCXVSDXHIFAZ3AmpT
 2/jSKzeC2HxVddTLoc5ZFjs07tDmcpqy6d35Paz3Srnb6+h54kfOfyw5bmUl3SWJmlEx
 oOoyHyST1E68jfFKILZOXTUnlzZZUAu7VxpcJVGNhagebnLjAuk3AVVsrvk0ydIGlROg
 3rjzz4zr1+wkuVg5bSl/ACeEsI5aN7VlAHrBWSkdPC7C4PKR2cXgbvnJlwbEPx5GR6+/
 pgjA==
X-Gm-Message-State: AOAM530n91DBi4T4qp+7UeGs4L1TVOrQVpiWO1dpK0ifshNUlEN4gEHu
 c4V200aGIpG6noPt4ZG//TrTCZwFQpNFuqpyaY6wKtyOlHn0/W3uQjrkVTKXQ3mvMX+gbZXqjXZ
 2ZQvxmzqjegNRIPuXWcF5Wo6pXCoZ+d+iZnvKHmHOag==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr2487672wmj.119.1629196007629; 
 Tue, 17 Aug 2021 03:26:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZpPkW0eowh5zeHCjZYpXMEsSrO7sfME5hs/QsYMSAWHwk4z4E0xnU4zl3GG5yBTtHDNtGvg==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr2487663wmj.119.1629196007464; 
 Tue, 17 Aug 2021 03:26:47 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net.
 [82.29.237.198])
 by smtp.gmail.com with ESMTPSA id j17sm1885274wrt.69.2021.08.17.03.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 03:26:47 -0700 (PDT)
Date: Tue, 17 Aug 2021 11:26:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [Virtio-fs] [PATCH v4 6/8] fuse: mark inode DONT_CACHE when
 per-file DAX indication changes
Message-ID: <YRuO5ZzqDmuSC3pN@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022220.17574-7-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20210817022220.17574-7-jefflexu@linux.alibaba.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 virtio-fs@redhat.com, joseph.qi@linux.alibaba.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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

* Jeffle Xu (jefflexu@linux.alibaba.com) wrote:
> When the per-file DAX indication changes while the file is still
> *opened*, it is quite complicated and maybe fragile to dynamically
> change the DAX state.
> 
> Hence mark the inode and corresponding dentries as DONE_CACHE once the

                                                     ^^^^^^^^^^
typo as DONT ?

Dave

> per-file DAX indication changes, so that the inode instance will be
> evicted and freed as soon as possible once the file is closed and the
> last reference to the inode is put. And then when the file gets reopened
> next time, the inode will reflect the new DAX state.
> 
> In summary, when the per-file DAX indication changes for an *opened*
> file, the state of the file won't be updated until this file is closed
> and reopened later.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c    | 9 +++++++++
>  fs/fuse/fuse_i.h | 1 +
>  fs/fuse/inode.c  | 3 +++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 30833f8d37dd..f7ede0be4e00 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1364,6 +1364,15 @@ void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>  }
>  
> +void fuse_dax_dontcache(struct inode *inode, bool newdax)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +
> +	if (fc->dax_mode == FUSE_DAX_INODE &&
> +	    fc->perfile_dax && (!!IS_DAX(inode) != newdax))
> +		d_mark_dontcache(inode);
> +}
> +
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
>  {
>  	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7b7b4c208af2..56fe1c4d2136 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1260,6 +1260,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>  void fuse_dax_inode_cleanup(struct inode *inode);
> +void fuse_dax_dontcache(struct inode *inode, bool newdax);
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>  void fuse_dax_cancel_work(struct fuse_conn *fc);
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8080f78befed..8c9774c6a210 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -269,6 +269,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
>  		if (inval)
>  			invalidate_inode_pages2(inode->i_mapping);
>  	}
> +
> +	if (IS_ENABLED(CONFIG_FUSE_DAX))
> +		fuse_dax_dontcache(inode, attr->flags & FUSE_ATTR_DAX);
>  }
>  
>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> -- 
> 2.27.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
