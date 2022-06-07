Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B800C43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 19:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07B6E4154F;
	Tue,  7 Jun 2022 19:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBb0eTXh_eyr; Tue,  7 Jun 2022 19:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 21B294077D;
	Tue,  7 Jun 2022 19:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E18B0C0039;
	Tue,  7 Jun 2022 19:34:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE396C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 19:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF78C83332
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 19:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id opD2FRUB08CR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 19:34:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 745F48332A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 19:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654630474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9+sYf66B4lYQqHTknd+qv+uMRNzYbE5y/YbQ6KE2xzc=;
 b=O61dZJE1BwC+IJ1iIMo9rSlUz9rqWc8841T7Ywe3HA1jsCRsqKNPEazLk+LPOgZzTOHPTw
 GEKkpNFc4QCgOCl+7UcqsQhlNQszqoF9h3fXyjEmuooM5B7Pua86TkbXqSLmyAolleI3ME
 LRb3MVf+gC0jPE8g8tC82QgJjwpr6k0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-ozahxQXJMqS3hN5j6NST7Q-1; Tue, 07 Jun 2022 15:34:30 -0400
X-MC-Unique: ozahxQXJMqS3hN5j6NST7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B183101E165;
 Tue,  7 Jun 2022 19:33:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F53D28BFA;
 Tue,  7 Jun 2022 19:33:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 4B9B8220882; Tue,  7 Jun 2022 15:33:36 -0400 (EDT)
Date: Tue, 7 Jun 2022 15:33:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
Message-ID: <Yp+oEPGnisNx+Nzo@redhat.com>
References: <20220607110504.198-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220607110504.198-1-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: linux-fsdevel@vger.kernel.org, zhangjiachen.jaycee@bytedance.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 miklos@szeredi.hu
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

On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> The commit 15c8e72e88e0 ("fuse: allow skipping control
> interface and forced unmount") tries to remove the control
> interface for virtio-fs since it does not support aborting
> requests which are being processed. But it doesn't work now.

Aha.., so "no_control" basically has no effect? I was looking at
the code and did not find anybody using "no_control" and I was
wondering who is making use of "no_control" variable.

I mounted virtiofs and noticed a directory named "40" showed up
under /sys/fs/fuse/connections/. That must be belonging to
virtiofs instance, I am assuming.

BTW, if there are multiple fuse connections, how will one figure
out which directory belongs to which instance. Because without knowing
that, one will be shooting in dark while trying to read/write any
of the control files.

So I think a separate patch should be sent which just gets rid of
"no_control" saying nobody uses. it.

> 
> This commit fixes the bug, but only remove the abort interface
> instead since other interfaces should be useful.

Hmm.., so writing to "abort" file is bad as it ultimately does.

fc->connected = 0;

So getting rid of this file till we support aborting the pending
requests properly, makes sense.

I think this probably should be a separate patch which explains
why adding "no_abort_control" is a good idea.

Thanks
Vivek

> 
> Fixes: 15c8e72e88e0 ("fuse: allow skipping control interface and forced unmount")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/fuse/control.c   | 4 ++--
>  fs/fuse/fuse_i.h    | 6 +++---
>  fs/fuse/inode.c     | 2 +-
>  fs/fuse/virtio_fs.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 7cede9a3bc96..d93d8ea3a090 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -272,8 +272,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
>  
>  	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
>  				 NULL, &fuse_ctl_waiting_ops) ||
> -	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
> -				 NULL, &fuse_ctl_abort_ops) ||
> +	    (!fc->no_abort_control && !fuse_ctl_add_dentry(parent, fc, "abort",
> +			S_IFREG | 0200, 1, NULL, &fuse_ctl_abort_ops)) ||
>  	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
>  				 1, NULL, &fuse_conn_max_background_ops) ||
>  	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 488b460e046f..e29a4e2f2b35 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -507,7 +507,7 @@ struct fuse_fs_context {
>  	bool default_permissions:1;
>  	bool allow_other:1;
>  	bool destroy:1;
> -	bool no_control:1;
> +	bool no_abort_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
>  	enum fuse_dax_mode dax_mode;
> @@ -766,8 +766,8 @@ struct fuse_conn {
>  	/* Delete dentries that have gone stale */
>  	unsigned int delete_stale:1;
>  
> -	/** Do not create entry in fusectl fs */
> -	unsigned int no_control:1;
> +	/** Do not create abort entry in fusectl fs */
> +	unsigned int no_abort_control:1;
>  
>  	/** Do not allow MNT_FORCE umount */
>  	unsigned int no_force_umount:1;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8c0665c5dff8..02a16cd35f42 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1564,7 +1564,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->legacy_opts_show = ctx->legacy_opts_show;
>  	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
>  	fc->destroy = ctx->destroy;
> -	fc->no_control = ctx->no_control;
> +	fc->no_abort_control = ctx->no_abort_control;
>  	fc->no_force_umount = ctx->no_force_umount;
>  
>  	err = -ENOMEM;
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..af369bea6dbb 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1287,7 +1287,7 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
>  	ctx->max_read = UINT_MAX;
>  	ctx->blksize = 512;
>  	ctx->destroy = true;
> -	ctx->no_control = true;
> +	ctx->no_abort_control = true;
>  	ctx->no_force_umount = true;
>  }
>  
> -- 
> 2.20.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
