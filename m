Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3437AA97
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204195; cv=none; b=QS4dnmwW/m1C7pWosXr3NUW7IIZGIhOQcOI271Yca93lWUPOQs7wDtBIfUxUdPd1DZem+vA1SHQh0xN7/l6lFMXd5MslVq4cmVF1JZOjXplc2dPRl/Es9KIonByGj8Fnx1NTXDV56JRphOLXQC/+b05M0u07JVNzZbqJ2MCC+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204195; c=relaxed/simple;
	bh=Udoo0U8Eun6RScJdgOh2tTlkvguARmiSlB0JzgpGvvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GZ74x6DZPDFSbXq/HJZpWjCVFI3/3dhrzN2J0tVQ35TssEzq+0MZVd1S52qy+K7MnS4gN9Am5luqm6ie7rjg5vucDG3YTja+FRa8UBgfGkYDazWR24PmqcVNf8wMKmLctTJKc04xOQ48Tz5Sb/L9IcnqQR5bNcRPDgDlRt3A3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qy1PBF1B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy1PBF1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789204193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fTpUU0/C+r9b31rC+Uhm2IpvHL/cIjBJckoMkgqczM=;
	b=Qy1PBF1BMifO/6P0w87MuaUWX7/DvhroDc6SBx/F+7hXWFCyNPECfLV2lNdaCURXpLnP/W
	dADSGkFL13KHEm3l9c1fq/8A2M2veSM7R8pYVmX4BvPwZAvBAXzhE820a17xwq2pkLvhAa
	tn4ZvNJrtfwRf057hwGDwiYZHHKeJmc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-rlBq3amyPmyG7tr3fcHm1A-1; Sat, 12 Sep 2026 05:09:50 -0400
X-MC-Unique: rlBq3amyPmyG7tr3fcHm1A-1
X-Mimecast-MFC-AGG-ID: rlBq3amyPmyG7tr3fcHm1A_1789204190
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so13667065e9.2
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 02:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789204189; x=1789808989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fTpUU0/C+r9b31rC+Uhm2IpvHL/cIjBJckoMkgqczM=;
        b=mi2rVwiOcGt50V6PirT5pt/YP0f9f58l3idnjTszkjYznAHXqpsOzXt4WAXQ1gS62D
         sIax0Qt3Q2AougAl2UoQ/D0oHkc5xIWLkGeGhQET4t711n1sjI44ZINun/a/gc4SldBX
         bpXFtp9I5v9w6h6G/tBHtSQYop4MspEHntVIL/doaean+RZ01CvvXyOSnMZVuWb6wbfd
         eN9OBAJiQwG8hY8vdfl3n48VlF0xKRS6OTzz+k+bqZWUT7KuNwop4yVMdWCHEioVq16N
         bc9HWiBAOh8OILizdn0UL56DZMrDicD0VOD1mdOOmH4tOHsZn3okchWef7K2caRMFl60
         29Bg==
X-Forwarded-Encrypted: i=1; AKwUvBw+BdOK13gihgN2+qFQZynBJoZkRVNCCEPUSuTZWTqIGMJeQCK349gmpIoNwF9hI6ZkDNJNURjuVwXqotq9+Q==@lists.linux.dev
X-Gm-Message-State: AFuF++m13NVNMs7kOMMSzKu8dO7ENlNtuXSnCMJ7PeWMbf7Zn/Ajr10U
	McN7GjN1aXcYybcoKkbBk2j9YXmqADsB2sYM3w1tD/mIKRUtgASbh0QjU6x2tXH8LRmnLFWNHKL
	UyWrPNKLGp5BeeILZxOhCTRlxdi8eoHkgFKtHcf0axLFyVB57iVZyYvnEqpbgCJN7PfTW
X-Gm-Gg: AYBFou2DboXfT80rtBSEku4X84ZZBrstB6gUzmC4fELJLZqnh+WUmZtc+J49/kD6fx0
	yR6R53J4YEYIin/kXC9jsuKANrxfRZ2dynBsFKqzDh0QsgsiXd3YlDA4177slkYCXCkO0CWDNYC
	bpareJKAMj96HN9m0xMwtdQvcxMnq6iMVRzUcfnabuYtGDUv6hC+Yl3xd+GsS9yoW7pmZ3G9twC
	GAHf+B9CZbGlOxnaglmLX+PHQBRV9RBMb21U97bg6Aslme9i489G6DxonUzXmBGm5zVdhA982fP
	Botwaoly24cUIGpcBYkcCukv1bLctrcNx2RMWGatCOQCIlUlWsKr5FfvoUQjLe/UEdg=
X-Received: by 2002:a05:6000:4008:b0:485:8c16:a32d with SMTP id ffacd0b85a97d-486eb329a0amr8768527f8f.34.1789204189444;
        Sat, 12 Sep 2026 02:09:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4008:b0:485:8c16:a32d with SMTP id ffacd0b85a97d-486eb329a0amr8768508f8f.34.1789204188889;
        Sat, 12 Sep 2026 02:09:48 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm11666697f8f.24.2026.09.12.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:09:48 -0700 (PDT)
Date: Sat, 12 Sep 2026 05:09:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, linux-arm-msm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Message-ID: <20260912050459-mutt-send-email-mst@kernel.org>
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: knzBOqwN2XfJw8Y5AfqvHFgiadvPEYw2gJQytSJP1zE_1789204190
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 12, 2026 at 04:52:44PM +0800, Cong Zhang wrote:
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
> 
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().



This repeatition of the code in english is not what we need
in the commit log.

Suggested format:

The following issue was observed by ...: currently .... because ... this is a
problem because ... and we can not ... because ... to fix ... so that
... tested by ...: before ... after ...




> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>

no empty lines between tags please

> ---
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.



this kind of thing belongs in the commit log.

> ---
> Changes in v2:
> - Cc stable@vger.kernel.org.


which is no longer there?

> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..7a570591e040 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	/* Ensure no requests in virtqueues before deleting vqs. */
>  	memflags = blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue_nowait(q);
> +	blk_mq_quiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);
>  
>  	/* Ensure we don't receive any more interrupts */
> 
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
> 
> Best regards,
> --  
> Cong Zhang <cong.zhang@oss.qualcomm.com>

