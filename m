Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EC9C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 18:17:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E0365131
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 18:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E0365131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E08783C11;
	Tue, 16 Mar 2021 18:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-d_WZor2OCi; Tue, 16 Mar 2021 18:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B164083A96;
	Tue, 16 Mar 2021 18:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 888B3C000C;
	Tue, 16 Mar 2021 18:17:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79353C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 18:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B1CC4303E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 18:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6J8xd9BJ_bTx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 18:17:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AE4D43003
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 18:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615918650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAM1TwwmGz08tYIJFcJigdtdBF6Phn1evgG1Tccbtsg=;
 b=RAms1DDWQd6wB8DWzdt8kSwoMzF1s2WpkBVqxbVWUtXLt4B4xx1Rz2FG82tMIxX7qQk8xC
 fhg3hmSh+Knh+xw7RPiM4bMINe2VZgv8tl9Rfi2xhZLfE+4xzVEaTa7ka0q++aO3Obz318
 A9vjU1jXcV4hZA7kynybjzMksiCFumU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-QoVFzhEFMwyyetXQP_FxeQ-1; Tue, 16 Mar 2021 14:17:26 -0400
X-MC-Unique: QoVFzhEFMwyyetXQP_FxeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03632107ACCA;
 Tue, 16 Mar 2021 18:17:25 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-57.rdu2.redhat.com [10.10.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 892EC5D9C0;
 Tue, 16 Mar 2021 18:17:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 1B80E220BCF; Tue, 16 Mar 2021 14:17:18 -0400 (EDT)
Date: Tue, 16 Mar 2021 14:17:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH] virtiofs: fix memory leak in virtio_fs_probe()
Message-ID: <20210316181718.GG270529@redhat.com>
References: <20210316170234.21736-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316170234.21736-1-lhenriques@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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

On Tue, Mar 16, 2021 at 05:02:34PM +0000, Luis Henriques wrote:
> When accidentally passing twice the same tag to qemu, kmemleak ended up
> reporting a memory leak in virtiofs.  Also, looking at the log I saw the
> following error (that's when I realised the duplicated tag):
> 
>   virtiofs: probe of virtio5 failed with error -17
> 
> Here's the kmemleak log for reference:
> 
> unreferenced object 0xffff888103d47800 (size 1024):
>   comm "systemd-udevd", pid 118, jiffies 4294893780 (age 18.340s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff 80 90 02 a0 ff ff ff ff  ................
>   backtrace:
>     [<000000000ebb87c1>] virtio_fs_probe+0x171/0x7ae [virtiofs]
>     [<00000000f8aca419>] virtio_dev_probe+0x15f/0x210
>     [<000000004d6baf3c>] really_probe+0xea/0x430
>     [<00000000a6ceeac8>] device_driver_attach+0xa8/0xb0
>     [<00000000196f47a7>] __driver_attach+0x98/0x140
>     [<000000000b20601d>] bus_for_each_dev+0x7b/0xc0
>     [<00000000399c7b7f>] bus_add_driver+0x11b/0x1f0
>     [<0000000032b09ba7>] driver_register+0x8f/0xe0
>     [<00000000cdd55998>] 0xffffffffa002c013
>     [<000000000ea196a2>] do_one_initcall+0x64/0x2e0
>     [<0000000008f727ce>] do_init_module+0x5c/0x260
>     [<000000003cdedab6>] __do_sys_finit_module+0xb5/0x120
>     [<00000000ad2f48c6>] do_syscall_64+0x33/0x40
>     [<00000000809526b5>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Luis Henriques <lhenriques@suse.de>

Hi Luis,

Thanks for the report and the fix. So looks like leak is happening
because we are not doing kfree(fs->vqs) in error path.

> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8868ac31a3c0..4e6ef9f24e84 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -899,7 +899,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
>  
>  out:
>  	vdev->priv = NULL;
> -	kfree(fs);
> +	virtio_fs_put(fs);

[ CC virtio-fs list ]

fs object is not fully formed. So calling virtio_fs_put() is little odd.
I will expect it to be called if somebody takes a reference using _get()
or in the final virtio_fs_remove() when creation reference should go
away.

How about open coding it and free fs->vqs explicitly. Something like
as follows.

@@ -896,7 +896,7 @@ static int virtio_fs_probe(struct virtio
 out_vqs:
        vdev->config->reset(vdev);
        virtio_fs_cleanup_vqs(vdev, fs);
-
+       kfree(fs->vqs);
 out:
        vdev->priv = NULL;
        kfree(fs);

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
