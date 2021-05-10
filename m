Return-Path: <SRS0=CL3f=KF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E9C433B4
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 15:25:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8FD6120D
	for <virtualization@archiver.kernel.org>; Mon, 10 May 2021 15:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8FD6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 291C340534;
	Mon, 10 May 2021 15:25:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u86Amt8mOaRc; Mon, 10 May 2021 15:25:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA9C54053A;
	Mon, 10 May 2021 15:25:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D131C000E;
	Mon, 10 May 2021 15:25:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A08CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 15:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC65E840FD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 15:25:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lO-QgIeG7nOX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 15:25:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33FFD83E67
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620660312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2CGR/IDsHtbZ5Y9P6c1L3DtRTFVjRlsHsiyPl4p12Q=;
 b=ar2oJquH6PVvKIc2xzegTg9dPDthdhVxakwGTRVdaD7sgxxfG7UbHnQ4OWsEHg4npPDeAO
 Ps/nz+ZqD5POQ+GixpOpzzrO0nLlxzTzsOMT1/beV8Ui/vjDiVDVzJfaYao9UcNib9gd5P
 HPuLXZvI03eGzuC9YyhmXeazHO4DJkA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-p8dVQo3cNiW_5LAMovdgCw-1; Mon, 10 May 2021 11:25:09 -0400
X-MC-Unique: p8dVQo3cNiW_5LAMovdgCw-1
Received: by mail-qt1-f197.google.com with SMTP id
 j12-20020ac8550c0000b02901dae492d1f2so4581687qtq.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 08:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K2CGR/IDsHtbZ5Y9P6c1L3DtRTFVjRlsHsiyPl4p12Q=;
 b=N26ULhyHGUfCB/ArTKLoeuq+c0tbA4EdF0v0u8IV9ovFegcRKSsI3Rbvpz6jygWVzy
 Y0CNSuKT0DvG4MzH1I9MlljXvkFhq/dpYtnPUdjroR3ACUxoE1IFWJlLi2bKohBQcu3H
 pXnrZnofBAHD0vT1h5l+TvLEbeh/neFYKtpkXdP5GSJQw4fK4rw9CCmjNKu/8XPGHQp1
 cKIowqwWQNEg7lVIvCDTQZiinGNHa+xxQtfAUB/Uhrlyf/JVnE6UQq8t7y/Pd9eVkxAc
 b6hY/7Pydyvx5fLUg9R7fsaMH/oIz6NDs8s/HRZAWe2CbP95DhwZRZT3mT7BT4P7dJ7Y
 tNBg==
X-Gm-Message-State: AOAM533Mbwl6qJG5EqOuPYExs6T86hJZH9FykUZNxw9RM0G/iHvDx02v
 ki0WEgF0uTGaSrTBmi8Oizjp0fqiJIlPYvb04+ByCobJlQikDvN+V9cwBLSR5dFkHdaJ51CPiIG
 cdZ5Z4w1JLsaEO6nlUUfn2H4+ec2GloLyRsXQKmbpzA==
X-Received: by 2002:a37:4017:: with SMTP id n23mr21753957qka.338.1620660308753; 
 Mon, 10 May 2021 08:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf+1jFnLT/UbwYtkRupiUPmDiPqdUTk6gWY3qtL/u/wOC2u18ZkK0Q8NmQNcSkgGbQ0jbSXQ==
X-Received: by 2002:a37:4017:: with SMTP id n23mr21753938qka.338.1620660308550; 
 Mon, 10 May 2021 08:25:08 -0700 (PDT)
Received: from horse (pool-173-76-174-238.bstnma.fios.verizon.net.
 [173.76.174.238])
 by smtp.gmail.com with ESMTPSA id 28sm6715878qkr.36.2021.05.10.08.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 08:25:08 -0700 (PDT)
Date: Mon, 10 May 2021 11:25:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
Message-ID: <20210510152506.GC150402@horse>
References: <20210507221527.699516-1-ckuehl@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210507221527.699516-1-ckuehl@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org
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

On Fri, May 07, 2021 at 03:15:27PM -0700, Connor Kuehl wrote:
> Distribute requests across the multiqueue complex automatically based
> on the IRQ affinity.

Hi Connor,

Thanks for the patch. I will look into it and also test it.

How did you test it? Did you modify vitiofsd to support multiqueue. Did
you also run some performance numbers. Does it provide better/worse
performance as compared to single queue.

Thanks
Vivek

> 
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index bcb8a02e2d8b..dcdc8b7b1ad5 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -30,6 +30,10 @@
>  static DEFINE_MUTEX(virtio_fs_mutex);
>  static LIST_HEAD(virtio_fs_instances);
>  
> +struct virtio_fs_vq;
> +
> +DEFINE_PER_CPU(struct virtio_fs_vq *, this_cpu_fsvq);
> +
>  enum {
>  	VQ_HIPRIO,
>  	VQ_REQUEST
> @@ -673,6 +677,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	struct virtqueue **vqs;
>  	vq_callback_t **callbacks;
>  	const char **names;
> +	struct irq_affinity desc = { .pre_vectors = 1, .nr_sets = 1, };
>  	unsigned int i;
>  	int ret = 0;
>  
> @@ -681,6 +686,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	if (fs->num_request_queues == 0)
>  		return -EINVAL;
>  
> +	fs->num_request_queues = min_t(unsigned int, nr_cpu_ids,
> +				       fs->num_request_queues);
> +
>  	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
>  	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
>  	if (!fs->vqs)
> @@ -710,12 +718,24 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  		names[i] = fs->vqs[i].name;
>  	}
>  
> -	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
> +	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
>  	if (ret < 0)
>  		goto out;
>  
> -	for (i = 0; i < fs->nvqs; i++)
> +	for (i = 0; i < fs->nvqs; i++) {
> +		const struct cpumask *mask;
> +		unsigned int cpu;
> +
>  		fs->vqs[i].vq = vqs[i];
> +		if (i == VQ_HIPRIO)
> +			continue;
> +
> +		mask = vdev->config->get_vq_affinity(vdev, i);
> +		for_each_cpu(cpu, mask) {
> +			struct virtio_fs_vq **cpu_vq = per_cpu_ptr(&this_cpu_fsvq, cpu);
> +			*cpu_vq = &fs->vqs[i];
> +		}
> +	}
>  
>  	virtio_fs_start_all_queues(fs);
>  out:
> @@ -877,8 +897,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
>  	if (ret < 0)
>  		goto out;
>  
> -	/* TODO vq affinity */
> -
>  	ret = virtio_fs_setup_dax(vdev, fs);
>  	if (ret < 0)
>  		goto out_vqs;
> @@ -1225,7 +1243,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
>  __releases(fiq->lock)
>  {
> -	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
>  	struct virtio_fs *fs;
>  	struct fuse_req *req;
>  	struct virtio_fs_vq *fsvq;
> @@ -1245,7 +1262,8 @@ __releases(fiq->lock)
>  		 req->in.h.nodeid, req->in.h.len,
>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
>  
> -	fsvq = &fs->vqs[queue_id];
> +	fsvq = this_cpu_read(this_cpu_fsvq);
> +
>  	ret = virtio_fs_enqueue_req(fsvq, req, false);
>  	if (ret < 0) {
>  		if (ret == -ENOMEM || ret == -ENOSPC) {
> -- 
> 2.30.2
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
