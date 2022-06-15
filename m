Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F64ECCA47D
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 19:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B447F83419;
	Wed, 15 Jun 2022 19:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7LqlGO7BLy51; Wed, 15 Jun 2022 19:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D9BE83410;
	Wed, 15 Jun 2022 19:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB0DC0039;
	Wed, 15 Jun 2022 19:56:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76A79C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 19:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64A6583419
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 19:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kCeQ75M-7S6M
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 19:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3713F83410
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655322988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqOAqAfVo6ZqE+Onf7A4WZQ8MUXyjM3cOFODgGTtWdE=;
 b=hDGJgGOOEkzxMoJob4XFhokIf8l9eogppJziNTkaGuz9u2T/Ac72odtuRCNHA6RucsUdVn
 H8356++GLf0TUCCOcespVv9sB/MJnq6oVccspefbcvQTdLtckKpk8qCRBSlhbZUXs/eFq8
 BQyjQyKslKdoY5kzdY/Uc9RNhbSxoJo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-BT-X8-u-OGydkdp13PjrIg-1; Wed, 15 Jun 2022 15:56:26 -0400
X-MC-Unique: BT-X8-u-OGydkdp13PjrIg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FB8A29AB3F3;
 Wed, 15 Jun 2022 19:56:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.19.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06ADE492CA5;
 Wed, 15 Jun 2022 19:56:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 74D942209F9; Wed, 15 Jun 2022 15:56:25 -0400 (EDT)
Date: Wed, 15 Jun 2022 15:56:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 1/2] fuse: Remove unused "no_control" related code
Message-ID: <Yqo5aaKITxivWsdV@redhat.com>
References: <20220615055755.197-1-xieyongji@bytedance.com>
 <20220615055755.197-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220615055755.197-2-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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

On Wed, Jun 15, 2022 at 01:57:54PM +0800, Xie Yongji wrote:
> This gets rid of "no_control" related code since
> nobody uses it.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Good to get rid of this knob. Nobody is using it.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/fuse_i.h    | 4 ----
>  fs/fuse/inode.c     | 1 -
>  fs/fuse/virtio_fs.c | 1 -
>  3 files changed, 6 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 488b460e046f..a47f14d0ee3f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -507,7 +507,6 @@ struct fuse_fs_context {
>  	bool default_permissions:1;
>  	bool allow_other:1;
>  	bool destroy:1;
> -	bool no_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
>  	enum fuse_dax_mode dax_mode;
> @@ -766,9 +765,6 @@ struct fuse_conn {
>  	/* Delete dentries that have gone stale */
>  	unsigned int delete_stale:1;
>  
> -	/** Do not create entry in fusectl fs */
> -	unsigned int no_control:1;
> -
>  	/** Do not allow MNT_FORCE umount */
>  	unsigned int no_force_umount:1;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8c0665c5dff8..4059c6898e08 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1564,7 +1564,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->legacy_opts_show = ctx->legacy_opts_show;
>  	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
>  	fc->destroy = ctx->destroy;
> -	fc->no_control = ctx->no_control;
>  	fc->no_force_umount = ctx->no_force_umount;
>  
>  	err = -ENOMEM;
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..24bcf4dbca2a 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1287,7 +1287,6 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
>  	ctx->max_read = UINT_MAX;
>  	ctx->blksize = 512;
>  	ctx->destroy = true;
> -	ctx->no_control = true;
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
