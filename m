Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27569C43334
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 17:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7BEE81A12;
	Wed, 15 Jun 2022 17:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ti5CrNXeJkFd; Wed, 15 Jun 2022 17:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 707B5819E6;
	Wed, 15 Jun 2022 17:57:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53FD7C0039;
	Wed, 15 Jun 2022 17:57:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DB55C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 17:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BE55415CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 17:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aF-3bQYHNsr2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 17:57:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50B49409FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655315845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IsV319NZNgDzu9DPo6i72lisoqYXO+k9cCPYQoqn8LA=;
 b=E57iX/ezFX2UtYWoTa9x+HpUeW/v+uvrrEGJUoxgn4JvhjbYeVR6oN3fSI+61qm0ZIsYlP
 UnP5NBnp9nwqUixBG+IAGcvbC7skzSFswUqUhh9ihxKxe0r1bWanKYWRqWXS74RuotbY9l
 soVk6r0GIsrWIgYtYQC+soXApsJcoVc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-c2Q-mJ0zPsyh09IqDQBOCw-1; Wed, 15 Jun 2022 13:57:20 -0400
X-MC-Unique: c2Q-mJ0zPsyh09IqDQBOCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 511AC800971;
 Wed, 15 Jun 2022 17:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38C9F18EA9;
 Wed, 15 Jun 2022 17:57:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id E9F252209F9; Wed, 15 Jun 2022 13:57:19 -0400 (EDT)
Date: Wed, 15 Jun 2022 13:57:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtiofs: delete unused parameter for
 virtio_fs_cleanup_vqs
Message-ID: <YqodfwS3KSVIaqKD@redhat.com>
References: <20220610020838.1543-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220610020838.1543-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, miklos@szeredi.hu
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

On Thu, Jun 09, 2022 at 10:08:38PM -0400, Deming Wang wrote:
> fs parameter not used. So, it needs to be deleted.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Thanks Deming Wang for the patch. Good cleanup.

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> ---
>  fs/fuse/virtio_fs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8db53fa67359..0991199d19c1 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -741,8 +741,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  }
>  
>  /* Free virtqueues (device must already be reset) */
> -static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
> -				  struct virtio_fs *fs)
> +static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
>  {
>  	vdev->config->del_vqs(vdev);
>  }
> @@ -895,7 +894,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
>  
>  out_vqs:
>  	virtio_reset_device(vdev);
> -	virtio_fs_cleanup_vqs(vdev, fs);
> +	virtio_fs_cleanup_vqs(vdev);
>  	kfree(fs->vqs);
>  
>  out:
> @@ -927,7 +926,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
>  	virtio_fs_stop_all_queues(fs);
>  	virtio_fs_drain_all_queues_locked(fs);
>  	virtio_reset_device(vdev);
> -	virtio_fs_cleanup_vqs(vdev, fs);
> +	virtio_fs_cleanup_vqs(vdev);
>  
>  	vdev->priv = NULL;
>  	/* Put device reference on virtio_fs object */
> -- 
> 2.27.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
