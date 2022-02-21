Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF66C433FE
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 15:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7818B4055E;
	Mon, 21 Feb 2022 15:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dZx2FLnz2F4S; Mon, 21 Feb 2022 15:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 11D8A40355;
	Mon, 21 Feb 2022 15:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFF4EC0021;
	Mon, 21 Feb 2022 15:03:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45CF1C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3455740151
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Azf2ReoQTgRU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:03:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA07D40110
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645455830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mr/1CQBSFnmPM+qg+tsLOOwlovqhtz4/EPWnJbnRwCM=;
 b=TARFnywqR82kJ2l8XkJFxuiQ3NK4+3U4LbkxxA4uX7PK4P6fUarIkuR6xLq5BBM8SGrRar
 rZLHG89rOmMfIaHQhwUNnMuYPDovwui9vY0wQQL+Tc+MiAaiQ1G1xt9K9z5/6lRIW+GoRO
 cwSt+PSDdxn7Z3kRE+IL2iSoKMikpXY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-8-zKEAkvPvCqPyhoYkb0XQ-1; Mon, 21 Feb 2022 10:03:47 -0500
X-MC-Unique: 8-zKEAkvPvCqPyhoYkb0XQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 c7-20020a1c3507000000b0034a0dfc86aaso8124895wma.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mr/1CQBSFnmPM+qg+tsLOOwlovqhtz4/EPWnJbnRwCM=;
 b=pZf0B5/urMH8qiufwY5upBPA/nqZNPAM3ku+jmsgs1Ylhk+pzv9svBlFID3MkDspwD
 8doXvlcamrAOF0N2vH/GVdUWvhNSJOWb5zvnB9JaKpHc5b7aY1Ux+G0wdDjAGlMbmFYW
 BP6D8S41dPcUI5Cn/WfbXTdEoBDuB51UJNiisUhwMOTnakdtvUMkrLdQCSc3E979n876
 sFPXWu5z7NctV+fC5lbaCOQbuauHcjDNXZ2KL9pPjRsZplenwSztY6ZhaPIbn4Rg0JQZ
 RSbef5iU8jJSLmzGK/LjnKCyBLoRnTf4r6wy7QTubBMWmQAvUYX1EWuXSUq+GBzDXKWZ
 sJ7Q==
X-Gm-Message-State: AOAM53314lW2xAB9xFqAO2I6QBLx4wK2+HNcLPXIOSp/sCsBiRwotb79
 z27eIB/mnfc2KcUJLqT+mt02m97Nw5gqRZX/YW4NwncE4Xp1Gj9AN4/qco8Tui4rKSzL5nrHQ4e
 PP5pCsOibisPMI08lpJqyNHfTr9xhrTHWZ2zKPryvIA==
X-Received: by 2002:adf:fbd0:0:b0:1e6:8ec3:570 with SMTP id
 d16-20020adffbd0000000b001e68ec30570mr17166370wrs.396.1645455825783; 
 Mon, 21 Feb 2022 07:03:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzV1pmRzjoWzZVTM1CFvom60MmV/YsWRRt4E8ofGC8c5/iOYk+2qzFWrG5At7u3dNopXHgX7g==
X-Received: by 2002:adf:fbd0:0:b0:1e6:8ec3:570 with SMTP id
 d16-20020adffbd0000000b001e68ec30570mr17166351wrs.396.1645455825521; 
 Mon, 21 Feb 2022 07:03:45 -0800 (PST)
Received: from redhat.com ([2.55.129.240])
 by smtp.gmail.com with ESMTPSA id b7sm39967572wrp.23.2022.02.21.07.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 07:03:43 -0800 (PST)
Date: Mon, 21 Feb 2022 10:03:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <20220221094829-mutt-send-email-mst@kernel.org>
References: <20220221114916.107045-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220221114916.107045-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Asias He <asias@redhat.com>
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

On Mon, Feb 21, 2022 at 12:49:16PM +0100, Stefano Garzarella wrote:
> vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
> ownership. It expects current->mm to be valid.
> 
> vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
> the user has not done close(), so when we are in do_exit(). In this
> case current->mm is invalid and we're releasing the device, so we
> should clean it anyway.
> 
> Let's check the owner only when vhost_vsock_stop() is called
> by an ioctl.




> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vhost/vsock.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index d6ca1c7ad513..f00d2dfd72b7 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -629,16 +629,18 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>  	return ret;
>  }
>  
> -static int vhost_vsock_stop(struct vhost_vsock *vsock)
> +static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)

>  {
>  	size_t i;
>  	int ret;
>  
>  	mutex_lock(&vsock->dev.mutex);
>  
> -	ret = vhost_dev_check_owner(&vsock->dev);
> -	if (ret)
> -		goto err;
> +	if (check_owner) {
> +		ret = vhost_dev_check_owner(&vsock->dev);
> +		if (ret)
> +			goto err;
> +	}
>  
>  	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>  		struct vhost_virtqueue *vq = &vsock->vqs[i];
> @@ -753,7 +755,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>  	 * inefficient.  Room for improvement here. */
>  	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
>  
> -	vhost_vsock_stop(vsock);

Let's add an explanation:

When invoked from release we can not fail so we don't
check return code of vhost_vsock_stop.
We need to stop vsock even if it's not the owner.

> +	vhost_vsock_stop(vsock, false);
>  	vhost_vsock_flush(vsock);
>  	vhost_dev_stop(&vsock->dev);
>  
> @@ -868,7 +870,7 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>  		if (start)
>  			return vhost_vsock_start(vsock);
>  		else
> -			return vhost_vsock_stop(vsock);
> +			return vhost_vsock_stop(vsock, true);
>  	case VHOST_GET_FEATURES:
>  		features = VHOST_VSOCK_FEATURES;
>  		if (copy_to_user(argp, &features, sizeof(features)))
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
