Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8D8814
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039242; cv=none; b=H7O9v7ZLvys9rteBP9iqtuDel9WRGagpq+14dy6hYl2dST8Eqy80ZwD+9a7Ol2BO3W8XGFWuU/EXsDsxTLh8jdaxbgH1XTYdUyvluRTFnW+jWFlL+AcAY6B2J6mUsVxhh+2QLF7NhxFxSuBkpKM2dz/uDCv+WdKUtmaS4J59fAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039242; c=relaxed/simple;
	bh=MQTQ7Cp02xw7hHkn7dKec4W7o8RkEWaaDwz+tXow0RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDj1o+OmjLaIo4oN/F2mpAQR5KRiRoFGZIh/thzxkUHlfuCi/lGpJRbTJOI6TrrOSqoaL/kpItZ/96JaDC9cyVoC8y55jhM6AVXu+L7NTw90RgSsq/O5erocLdF54qguiwiC+D7kaAmfgBKbU5sDpWkBXi6+Ra8DehTNz1iCwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JTQv+OsP; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JTQv+OsP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717039236; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+Fxqt3tnwHm9/kuy3jiTE8slP9edWqwdcp8oxwmEvek=;
	b=JTQv+OsPFbp9usda/bLnvpWJ3LHqYVwjrEv+V4+ACxFFUnEk1VnsunETi9BM7vSZQ+1KoDph7RjMgi+mqNbOAH0TNK3k63sp5GmdcZ/QbYxljc3r8GgX0qno+dQsC02KJRroAUVfmhKaAk8H/OSSlhtzTFdjH1vEvk187kg/5PQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7VW8-W_1717039235;
Received: from 30.221.148.14(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7VW8-W_1717039235)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 11:20:36 +0800
Message-ID: <af09b5d3-940f-491d-97ba-bd3bf19b750a@linux.alibaba.com>
Date: Thu, 30 May 2024 11:20:34 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Peter-Jan Gootzen <pgootzen@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yoray Zack <yorayz@nvidia.com>,
 Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev
References: <20240529155210.2543295-1-mszeredi@redhat.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240529155210.2543295-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/24 11:52 PM, Miklos Szeredi wrote:
> Virtiofs has its own queing mechanism, but still requests are first queued
> on fiq->pending to be immediately dequeued and queued onto the virtio
> queue.
> 
> The queuing on fiq->pending is unnecessary and might even have some
> performance impact due to being a contention point.
> 
> Forget requests are handled similarly.
> 
> Move the queuing of requests and forgets into the fiq->ops->*.
> fuse_iqueue_ops are renamed to reflect the new semantics.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

[...]

> +static void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
> +{
> +	spin_lock(&fiq->lock);
> +	if (list_empty(&req->intr_entry)) {
> +		list_add_tail(&req->intr_entry, &fiq->interrupts);
> +		/*
> +		 * Pairs with smp_mb() implied by test_and_set_bit()
> +		 * from fuse_request_end().
> +		 */
> +		smp_mb();
> +		if (test_bit(FR_FINISHED, &req->flags)) {
> +			list_del_init(&req->intr_entry);
> +			spin_unlock(&fiq->lock			^
		missing "return" here?

> +		}
> +		fuse_dev_wake_and_unlock(fiq);
> +	} else {
> +		spin_unlock(&fiq->lock);
> +	}
> +}

[...]

>  static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
> @@ -581,7 +605,6 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>  {
>  	struct fuse_req *req;
>  	struct fuse_iqueue *fiq = &fm->fc->iq;
> -	int err = 0;
>  
>  	req = fuse_get_req(fm, false);
>  	if (IS_ERR(req))> @@ -592,16 +615,9 @@ static int fuse_simple_notify_reply(struct
fuse_mount *fm,
>  
>  	fuse_args_to_req(req, args);
>  
> -	spin_lock(&fiq->lock);
> -	if (fiq->connected) {
> -		queue_request_and_unlock(fiq, req);
> -	} else {
> -		err = -ENODEV;
> -		spin_unlock(&fiq->lock);
> -		fuse_put_request(req);
> -	}
> +	fuse_send_one(fiq, req);
>  
> -	return err;
> +	return 0;
>  }

There's a minor changed behavior visible to users.  Prior to the patch,
the FUSE_NOTIFY_RETRIEVE will returns -ENODEV when the connection is
aborted, but now it returns 0.

It seems only example/notify_store_retrieve.c has used
FUSE_NOTIFY_RETRIEVE in libfuse.  I'm not sure if this change really
matters.

Maybe we could check req->out.h.error after fuse_send_one() returns?


-- 
Thanks,
Jingbo
