Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FAFC433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC598221E3
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wzydsvz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC598221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 086F586A01;
	Thu,  6 Aug 2020 17:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ycT1McipMpGf; Thu,  6 Aug 2020 17:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89FD6869F4;
	Thu,  6 Aug 2020 17:28:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69816C0050;
	Thu,  6 Aug 2020 17:28:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F2D1C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 17:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3812C883D1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 17:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tovLtTKL5krW
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 17:28:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 92BA7883C4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596734892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwHd6CcJYEmEuf+YoO55dE8m5E0R87S7YH74U/aXf1A=;
 b=Wzydsvz+CgFV08PnSwCga3m51Yl0+Yh98F/ELo+/7zTJMQIwrdni7S5cuddE4bVPl3k70D
 n7zVtcl+KMA1fkDj25156nCeq6nH3cMzzsmOXalPwxzAMLxPGgsTZEPwKSpXJi7vQYUdBg
 cUUxwACifn8/+2iPNocajYDVCPiq6Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-yw4yRZZJNTKvU8TjJjHtNg-1; Thu, 06 Aug 2020 13:28:10 -0400
X-MC-Unique: yw4yRZZJNTKvU8TjJjHtNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34FF6106F8C4;
 Thu,  6 Aug 2020 17:28:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-23.rdu2.redhat.com [10.10.112.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D74767C0E5;
 Thu,  6 Aug 2020 17:28:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 47886220441; Thu,  6 Aug 2020 13:28:02 -0400 (EDT)
Date: Thu, 6 Aug 2020 13:28:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 31/38] virtio_fs: convert to LE accessors
Message-ID: <20200806172802.GD367847@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-32-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-32-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On Wed, Aug 05, 2020 at 09:44:39AM -0400, Michael S. Tsirkin wrote:
> Virtio fs is modern-only. Use LE accessors for config space.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/virtio_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4c4ef5d69298..104f35de5270 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -606,8 +606,8 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	unsigned int i;
>  	int ret = 0;
>  
> -	virtio_cread(vdev, struct virtio_fs_config, num_request_queues,
> -		     &fs->num_request_queues);
> +	virtio_cread_le(vdev, struct virtio_fs_config, num_request_queues,
> +			&fs->num_request_queues);
>  	if (fs->num_request_queues == 0)
>  		return -EINVAL;
>  
> -- 
> MST
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
