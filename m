Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9149BC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 15:09:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED3161A06
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 15:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED3161A06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFA2483E8B;
	Wed, 24 Mar 2021 15:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M7nAVywzXhZP; Wed, 24 Mar 2021 15:09:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4760283E56;
	Wed, 24 Mar 2021 15:09:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21897C000E;
	Wed, 24 Mar 2021 15:09:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC525C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DF3E4011B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:09:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GO0t0foTCkrF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:09:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A366140113
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616598559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqXvs+0nCxAmKCtC0cP0qRElEwb5kKKFxyyMwoEAD/A=;
 b=YLI01+/1zrxaPdUCXVMp/fa3Tg0qApxCHN3k4LkEnIqjA/MbiXgS0FIMKsNtubuAgCGoDE
 Iz0+6eg2hlAS0NEWxa69+xTnFBkPuN+km6Q57HIVPLDlwpXQ3Hyk+df4wLLFMkTgZYHSxU
 /YBxQtelv7CNVRMYwqm4Y+uf1L11SJY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-2iZaNhwmMqGMsyIVpM8V0A-1; Wed, 24 Mar 2021 11:09:17 -0400
X-MC-Unique: 2iZaNhwmMqGMsyIVpM8V0A-1
Received: by mail-oo1-f69.google.com with SMTP id o23so1435621oop.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 08:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jqXvs+0nCxAmKCtC0cP0qRElEwb5kKKFxyyMwoEAD/A=;
 b=kbu59hI0gNri9ePiUiRRoK0C2x5qHYQ5dUgi8oWvJgjNOC8Ok1qI0oLpuSqesYoMo4
 omKdCPj9gzhZCzmhiyzGaZTidy6BRsiqq1UBIFnSYfryYhF0yv1PiQaltu4FSOYLI9GW
 pDdLBUmflYTZkEGRRiFljPiZlrLschPt7wMevEoD43GocsDyWUpMTCDvG6g3Rm1sVqtE
 zZqGZcRK7bLwdlnp7XhKTuPcs5KwLHB54wT/0JukYFOcio63Q/nBYYDF5B9MGDW3NbmH
 ak0aniP/8uL7XyJXixPuQUuwQ7SbdfTXkqoB+UpG1EyYFO264Kx5Yn0iMZTYFk3E/Fnj
 d4kw==
X-Gm-Message-State: AOAM532ts/zNbC1cd/u/xlppoDVvIMPca86TTMSJoaSIvEo+JHUYVxQM
 NyKHohRmBwuLrU3i8QonoWaO7KnC6fhq1SprFYFPbX7f1zIb0IfIpQWWeEvO9fXE+IdKvrsZzKM
 3bYuJLf25WdggyCTz1YO59mioLxN41fyzkSaqZWHmFg==
X-Received: by 2002:aca:6204:: with SMTP id w4mr2835035oib.86.1616598557136;
 Wed, 24 Mar 2021 08:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHPVgEdBZLrQFZ7Du7KylIQIiw5HTambi70oV6Rxz8VLEHPTtDJpdjuIgYn7pwxoFzoqH4cw==
X-Received: by 2002:aca:6204:: with SMTP id w4mr2835008oib.86.1616598556903;
 Wed, 24 Mar 2021 08:09:16 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 t22sm596856otl.49.2021.03.24.08.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Mar 2021 08:09:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To: Miklos Szeredi <miklos@szeredi.hu>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
Date: Wed, 24 Mar 2021 10:09:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> I removed the conditional compilation and renamed the limit.  Also made
> virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.

Hi Miklos,

Has this patch been queued?

Connor

> ---
> From: Connor Kuehl <ckuehl@redhat.com>
> Subject: virtiofs: split requests that exceed virtqueue size
> Date: Thu, 18 Mar 2021 08:52:22 -0500
> 
> If an incoming FUSE request can't fit on the virtqueue, the request is
> placed onto a workqueue so a worker can try to resubmit it later where
> there will (hopefully) be space for it next time.
> 
> This is fine for requests that aren't larger than a virtqueue's maximum
> capacity.  However, if a request's size exceeds the maximum capacity of the
> virtqueue (even if the virtqueue is empty), it will be doomed to a life of
> being placed on the workqueue, removed, discovered it won't fit, and placed
> on the workqueue yet again.
> 
> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> Descriptors) of the virtio spec:
> 
>    "A driver MUST NOT create a descriptor chain longer than the Queue
>    Size of the device."
> 
> To fix this, limit the number of pages FUSE will use for an overall
> request.  This way, each request can realistically fit on the virtqueue
> when it is decomposed into a scattergather list and avoid violating section
> 2.6.5.3.1 of the virtio spec.
> 
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/fuse/fuse_i.h    |    3 +++
>   fs/fuse/inode.c     |    3 ++-
>   fs/fuse/virtio_fs.c |   19 +++++++++++++++++--
>   3 files changed, 22 insertions(+), 3 deletions(-)
> 
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -555,6 +555,9 @@ struct fuse_conn {
>   	/** Maxmum number of pages that can be used in a single request */
>   	unsigned int max_pages;
>   
> +	/** Constrain ->max_pages to this value during feature negotiation */
> +	unsigned int max_pages_limit;
> +
>   	/** Input queue */
>   	struct fuse_iqueue iq;
>   
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -712,6 +712,7 @@ void fuse_conn_init(struct fuse_conn *fc
>   	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
>   	fc->user_ns = get_user_ns(user_ns);
>   	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
> +	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
>   
>   	INIT_LIST_HEAD(&fc->mounts);
>   	list_add(&fm->fc_entry, &fc->mounts);
> @@ -1040,7 +1041,7 @@ static void process_init_reply(struct fu
>   				fc->abort_err = 1;
>   			if (arg->flags & FUSE_MAX_PAGES) {
>   				fc->max_pages =
> -					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> +					min_t(unsigned int, fc->max_pages_limit,
>   					max_t(unsigned int, arg->max_pages, 1));
>   			}
>   			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -18,6 +18,12 @@
>   #include <linux/uio.h>
>   #include "fuse_i.h"
>   
> +/* Used to help calculate the FUSE connection's max_pages limit for a request's
> + * size. Parts of the struct fuse_req are sliced into scattergather lists in
> + * addition to the pages used, so this can help account for that overhead.
> + */
> +#define FUSE_HEADER_OVERHEAD    4
> +
>   /* List of virtio-fs device instances and a lock for the list. Also provides
>    * mutual exclusion in device removal and mounting path
>    */
> @@ -1413,9 +1419,10 @@ static int virtio_fs_get_tree(struct fs_
>   {
>   	struct virtio_fs *fs;
>   	struct super_block *sb;
> -	struct fuse_conn *fc;
> +	struct fuse_conn *fc = NULL;
>   	struct fuse_mount *fm;
> -	int err;
> +	unsigned int virtqueue_size;
> +	int err = -EIO;
>   
>   	/* This gets a reference on virtio_fs object. This ptr gets installed
>   	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
> @@ -1427,6 +1434,10 @@ static int virtio_fs_get_tree(struct fs_
>   		return -EINVAL;
>   	}
>   
> +	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
> +	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
> +		goto out_err;
> +
>   	err = -ENOMEM;
>   	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
>   	if (!fc)
> @@ -1442,6 +1453,10 @@ static int virtio_fs_get_tree(struct fs_
>   	fc->delete_stale = true;
>   	fc->auto_submounts = true;
>   
> +	/* Tell FUSE to split requests that exceed the virtqueue's size */
> +	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
> +				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> +
>   	fsc->s_fs_info = fm;
>   	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
>   	if (fsc->s_fs_info) {
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
