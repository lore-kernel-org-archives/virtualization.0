Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF63327C06
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768181; cv=none; b=J6uEuTuK57uGlFdVzZMR1VppUO8/+nuVfW3k5IlVgYkm6KyzTD/wmJO0GBDnWg58+WPjvlSvynCVJ/pWSuR/sMtI+WwAR8EVy9HekBkroSr5t6PXA4iSBypzF0/uzlFQIritni9dr/rcjAXYOZ1lcmGTsGjL+Sb1O2r7nDtqFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768181; c=relaxed/simple;
	bh=wDiVkyqU9C0vk9M4TKF5Wcavq9FOed38ZuYx7EmboGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lTlfT1GPOk2iwvF30PD8VwqB4+rSRRxxrStZ+DqjNu6GGmNIbum5oqV0q7cc8+f1xjx1dzVk6we66rt/3ib7M8/ldsj2Bsk9Ta+wRcBhHK93z4MZPUNzqB9/n6CUf56pdme7cyuR+m03zip15d9IEtUGlUMJDAki4ln+xIrWhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiIavUZT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiIavUZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769768178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsp10hElzOX/V0wpyRfKhh5/ZNh15PcbrtBbOpulVsA=;
	b=eiIavUZTdLhg44Bx5FSAX+cNmpTpe7soWGfk0h1c0WP3OZHGrp6bxzim/3jgn5oZ30lrlJ
	BfqakrMCR9ZnGUFxFUB3pz3rjamPT9wqenqSxgPyeQkVUF91++9YwQYm5y2Gh6FFE6dIF6
	u5oU2TjaBN1+lnWglny6U2khIHgUDXA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-TKuziyPkMsWS6oJkEJPpxw-1; Fri, 30 Jan 2026 05:16:17 -0500
X-MC-Unique: TKuziyPkMsWS6oJkEJPpxw-1
X-Mimecast-MFC-AGG-ID: TKuziyPkMsWS6oJkEJPpxw_1769768176
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4802bb29400so26115115e9.0
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 02:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768176; x=1770372976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsp10hElzOX/V0wpyRfKhh5/ZNh15PcbrtBbOpulVsA=;
        b=MhMD/so5hxyG9UqPjpLGQCLZ5tk//Meqiu2zgCs/NW7avg94mwa8XxRB8VXpz4KZ02
         aZsN/2QKUNbngDcvDOK+5tCv0CKcCFWRKieTPmjEBSgeW3p1HvkILtKp3QfSCQxS04Fl
         enr90ecAefJPieCRCXtFLCV+d0bpmLqllsEi654Pz+Dv/zRgbSO6Cv0XC5RnxicEtxcg
         PaTRkk8jJiersjsydF7IhP1MCyNjWGw2dtrtKjx0cj1mGUc2x7FohDicxleSROjvevBe
         pKpoBYDe5oz9TWTJxXveh0w9olqrr9+e6EZKYIDabWOnsOCZOELPpJkCBgV5FmVG23fU
         qutg==
X-Forwarded-Encrypted: i=1; AJvYcCVCQGODMaXbcZcBb/oERLVR4AQv85Qb26791MH7Xi4hEb2Vpx+Im6Wmw8RW8uSNkgP7K2z3BzOwzlBXE5uuYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywwcor3hCn062pfTGkqp97DyLg2WveYuSxbsmz1OJn7iGmYek95
	Cjm95lj64O8YIH1zCtvs1Jl65O/DAk/vbkq18w/HVFRBk+2sONNFDqGnWhb9vgswu7gNLvQBhgE
	Vf6PM+cqUQJEmSu0UipW2uJaC2Kd8jhe97aRmYihi7zxoIMRPpcorrfdoqLvfl+TGh3oK
X-Gm-Gg: AZuq6aJs3aJPM4HaZF5MHad/NIs/iKvSm/IB5q5tCzBMfg63gDB57zomaMqyY7apJTo
	m0sfpocjEFDHDRR9O7i8Ia6yebMX3jEGcTUu/Jeq5kIErX4BVokWLE804nuVngwhRaQzMVrWD1S
	bp3EmALCPsbC3xQsDUZu6FO/r+XSjVfMMx8ZfaKwov2qqfHtQzPvGwp2TJ4OHOPPsqUM7Xt7fjk
	YCM7gB8aHx0jBhQ7q2WyA+y7Pk+Siu/ijTEpB6IJkesvpiuIeD0Fc4dox+fWyNeow17dFtzO92/
	PMTzocRv1l0m0aouF7gJm67S3B985ZLYTKooZPnLN5MCHO/1AX5nKvHo0EYd6YCPlc/3Qsrgr4p
	ZkPxUB/EAcpOvvIM8X2lDuRxJfNPmKpssDQ==
X-Received: by 2002:a05:600c:3152:b0:47d:6140:3284 with SMTP id 5b1f17b1804b1-482db4a1011mr24847455e9.37.1769768175824;
        Fri, 30 Jan 2026 02:16:15 -0800 (PST)
X-Received: by 2002:a05:600c:3152:b0:47d:6140:3284 with SMTP id 5b1f17b1804b1-482db4a1011mr24847135e9.37.1769768175303;
        Fri, 30 Jan 2026 02:16:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da903a30sm22140855e9.1.2026.01.30.02.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 02:16:14 -0800 (PST)
Date: Fri, 30 Jan 2026 05:16:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	marco.crivellari@suse.com, anders.roxell@linaro.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: Fix msg list race in vduse_dev_read_iter
Message-ID: <20260130050818-mutt-send-email-mst@kernel.org>
References: <20260130081524.81271-1-zhangtianci.1997@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260130081524.81271-1-zhangtianci.1997@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mw0XYcUV-J4Dj_FN6Ziz6qA9z1nMoa_qbQATAZps7og_1769768176
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks for the patch! yet something to improve:

On Fri, Jan 30, 2026 at 04:15:24PM +0800, Zhang Tianci wrote:
> Move the message to recv_list before dropping msg_lock and copying the
> request to userspace, avoiding a transient unlinked state that can race
> with the msg_sync timeout path. Roll back to send_list on copy failures.

this is not how you write commit messages, though.
describe the problem then how you fix it, please.
something like:

if msg_sync timeout triggers after a message has been removed
from send_list and before it was added to
recv_list, then .... as a result ....

To fix, move the message ...

> 
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index ae357d014564c..b6a558341c06c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct file *file = iocb->ki_filp;
>  	struct vduse_dev *dev = file->private_data;
>  	struct vduse_dev_msg *msg;
> +	struct vduse_dev_request req;
>  	int size = sizeof(struct vduse_dev_request);
>  	ssize_t ret;
>  
> @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  		ret = -EAGAIN;
>  		if (file->f_flags & O_NONBLOCK)
> -			goto unlock;
> +			break;
>  
>  		spin_unlock(&dev->msg_lock);
>  		ret = wait_event_interruptible_exclusive(dev->waitq,
> @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  		spin_lock(&dev->msg_lock);
>  	}
> +	if (!msg) {
> +		spin_unlock(&dev->msg_lock);
> +		return ret;
> +	}
> +
> +	memcpy(&req, &msg->req, sizeof(req));
> +	/*
> +	 * Move @msg to recv_list before dropping msg_lock.
> +	 * This avoids a window where @msg is detached from any list and
> +	 * vduse_dev_msg_sync() timeout path may operate on an unlinked node.
> +	 */

when standing by itself, not as part of the patch, this
comment confuses more than it clarifies.

> +	vduse_enqueue_msg(&dev->recv_list, msg);
>  	spin_unlock(&dev->msg_lock);
> -	ret = copy_to_iter(&msg->req, size, to);
> -	spin_lock(&dev->msg_lock);
> +
> +	ret = copy_to_iter(&req, size, to);
>  	if (ret != size) {
> +		spin_lock(&dev->msg_lock);
> +		/* Roll back: move msg back to send_list if still pending. */
> +		msg = vduse_find_msg(&dev->recv_list, req.request_id);

Looks like this always scans the whole list.
Make a variant using list_for_each_entry_reverse maybe?

> +		if (msg)
> +			vduse_enqueue_msg(&dev->send_list, msg);

why is it not a concern that it will be at the tail of the send_list now,
reordering the messages?

> +		spin_unlock(&dev->msg_lock);
>  		ret = -EFAULT;
> -		vduse_enqueue_msg(&dev->send_list, msg);
> -		goto unlock;
>  	}
> -	vduse_enqueue_msg(&dev->recv_list, msg);
> -unlock:
> -	spin_unlock(&dev->msg_lock);
>  
>  	return ret;
>  }
> -- 
> 2.39.5

