Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646961;
	b=LDXeuZSPw2a8RQE6os+/sbt2oPza+KfIKao3F7si1hptSHugpt+gX5fFFh7ocUv8pUcJ
	 H9b6vumUQe9+rdscNMCaiOrya4sZtTHKwU1If7bjoMPuiFMSdZlBDoOt0VSsUOur6BCa8
	 b0Q5xW7BVUxmeiK4FD7XdyZL4ufDbEWU7XudjhsacE5+b4iTOsLab1Qju36N2oWKKct+I
	 jKy3kVrSm0C8IxW8JDWP25sI1gQlC9m+sGO2T+xHbAt0K3uWm8Cd01WJLnEU6nLNhotVV
	 /P0GDiMW9aSFuQAJOxAQqYAIxjdga3ddnXbTgJ26727v8uXZhnBeUKLERzh3G3n0GyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646961;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=LlL1FYBFvzdxPX61Wt1FdQFWAKbXd+F54L2vvyVEA2k=;
	b=ewFWmzgsrIpmV2hIIIgk1DkdkoZQV0+rmuTdWp65Ng1+K/D5u2KRhu3caTqi8rotB0LM
	 BQPf1A1h3vJiXeVCbkkSUiez78PRLatlojfa4BGXC0GhYYulpnYs/KM2ghp668u9zmXbj
	 uejhnVe1zWz/GjBfXChtFKNr0O+f2y1EmkMkCijKZ1TJclhd+scB2y6nzb8XAdDnjakTw
	 H8MPIlhZHW3j+JFwsXPUy2KCT9ZT1aq3QNSzUTMzRPVITHl+xqDqZnNeQSCmGPCiQEBdv
	 x79x5IaluaIB6oA0+if2Ot2djyMvtwOBsnG13FukXuiKO61lmZyaVhdakQu49dbQ1SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQCCtWyY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38769606D805
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 19:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38769606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQCCtWyY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793646960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LlL1FYBFvzdxPX61Wt1FdQFWAKbXd+F54L2vvyVEA2k=;
	b=aQCCtWyYCHOGMmbLDqjEoDTFFOF4rNbjn1S/m45G1i+rXfVbM6douuWAB2xyCLYtmpZWQF
	497P0w6M70su6uwCsiJ7xeMurtT4RDD5SD8r8BZsoJeKjrtHyObdtlbSAzkgm2Z88avlxS
	bGWNAwODeWIkxLO0ZVODkjJXwiFitMI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-q1TuddBQOOWXfHNbUUV5dA-1; Mon,
 02 Nov 2026 14:15:56 -0500
X-MC-Unique: q1TuddBQOOWXfHNbUUV5dA-1
X-Mimecast-MFC-AGG-ID: q1TuddBQOOWXfHNbUUV5dA_1793646954
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D58FA18052F9;
	Mon,  2 Nov 2026 19:15:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35ACB7E1;
	Mon,  2 Nov 2026 19:15:51 +0000 (UTC)
Date: Mon, 2 Nov 2026 14:15:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yunye Zhao <yunye.zhao@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: Re: [PATCH] virtio_blk: freeze the virtqueue layout at probe time
Message-ID: <20261102191551.GB1738758@shajnocz.csb>
References: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: uMLY1Cz8Q6bLe4gw-eJNcT0J7NvCehGF3pcTEaQey8g_1793646954
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2026 at 09:37:40PM +0800, Yunye Zhao wrote:
> init_vq() reads the writable num_request_queues and poll_queues module
> parameters both at probe and when recreating virtqueues after suspend
> or reset. However, virtio-blk does not update the blk-mq hardware queue
> count or queue maps on restore.
> 
> Increasing poll_queues can therefore remove the completion callback
> from a virtqueue still used for interrupt-driven I/O, leaving requests
> uncompleted. Reducing the effective request queue count through
> num_request_queues can instead leave existing hardware contexts
> indexing beyond the reallocated vblk->vqs array.
> 
> Determine the virtqueue count and the split between interrupt-driven
> and polling queues once at probe, and reuse this layout when
> recreating the virtqueues. Changes to these module parameters then
> affect only subsequently probed devices.
> 
> Fixes: 0989c41bed96 ("virtio-blk: add num_request_queues module parameter")
> Signed-off-by: Yunye Zhao <yunye.zhao@linux.alibaba.com>
> ---
> The functional fix was previously tested with QEMU 8.2.2 on
> 7be4bc52fd9e (v7.3-2415), covering:
> 
> - PCI FLR after changing poll_queues from 0 to 1 or num_request_queues
>   from 0 to 1 on a device with four request queues.
> - Normal and polled I/O across FLR with poll_queues=1 at probe,
>   including a subsequent change of poll_queues to 0.
> - Device suspend/resume with pm_test=devices and state=freeze (not a
>   full s2idle cycle), plus full S3 and S4 suspend/resume cycles.

I noticed that drivers/nvme/host/ allows the queues to change:
1. The hardware queue count can be different and the tagset is updated
   with blk_mq_update_nr_hw_queues().
2. The module parameters are refreshed in nvme_setup_io_queues() and are
   allowed to change across power management operations.

Please consider implementing more flexibile restore behavior in
virtio_blk that can toleration hardware queue count changes and module
parameter changes instead though.

However, this patch looks correct to me and can be merged IMO.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

