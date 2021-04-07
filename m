Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD402C433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 15:50:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A99961382
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 15:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A99961382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3446C60C28;
	Wed,  7 Apr 2021 15:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDb2-y_V0n0g; Wed,  7 Apr 2021 15:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B852A60C27;
	Wed,  7 Apr 2021 15:50:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C90CC000C;
	Wed,  7 Apr 2021 15:50:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02C57C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 15:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D91ED40210
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 15:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4jB3EgBZAaUW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 15:50:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A58D0400AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617810643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e55XxdhFEquyLB2Ir8ZHzShBhWe4g5kf5ai240p48C8=;
 b=Ax3QeoVdzRqNQX3AN0RBuLcmNfsUJLCGASa9+HYCL3rFN2zAn8OYYIITVCtviBWGyBLtgR
 BCVDNtgTF2UR38r6nkswibgeD+hC2hpoRILslMVvrkKVT2UtJVBf4i7HeneSJiwbKgDlpV
 9tn0fjhCaZzmk+7KFXklT3OrkwKwKmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-5_T2zrWdOB2lBb81PkAixw-1; Wed, 07 Apr 2021 11:50:39 -0400
X-MC-Unique: 5_T2zrWdOB2lBb81PkAixw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C0E81425A;
 Wed,  7 Apr 2021 15:50:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-29.rdu2.redhat.com [10.10.117.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0993F1042A66;
 Wed,  7 Apr 2021 15:50:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6DF1122054F; Wed,  7 Apr 2021 11:50:31 -0400 (EDT)
Date: Wed, 7 Apr 2021 11:50:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] fuse: Avoid potential use after free
Message-ID: <20210407155031.GA1014852@redhat.com>
References: <20210406235332.2206460-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406235332.2206460-1-pakki001@umn.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>
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

On Tue, Apr 06, 2021 at 06:53:32PM -0500, Aditya Pakki wrote:
> In virtio_fs_get_tree, after fm is freed, it is again freed in case
> s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
> a double free, set fm to NULL.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  fs/fuse/virtio_fs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4ee6f734ba83..a7484c1539bf 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
>  	if (fsc->s_fs_info) {
>  		fuse_conn_put(fc);
>  		kfree(fm);
> +		fm = NULL;

I think both the code paths are mutually exclusive and that's why we
don't double free it.

sget_fc(), can either return existing super block which is already
initialized, or it can create a new super block which need to
initialize further.

If if get an existing super block, in that case fs->s_fs_info will
still be set and we need to free fm (as we did not use it). But in 
that case this super block is already initialized so sb->s_root
should be non-null and we will not call virtio_fs_fill_super()
on this. And hence we will not get into kfree(fm) again.

Same applies to fuse_conn_put(fc) call as well.

So I think this patch is not needed. I think sget_fc() semantics are
not obvious and that confuses the reader of the code.

Thanks
Vivek

>  	}
>  	if (IS_ERR(sb))
>  		return PTR_ERR(sb);
> -- 
> 2.25.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
