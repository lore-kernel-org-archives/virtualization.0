Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E5125D0
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088998; cv=none; b=Uql80DjsbJnchh7ZWZtNzgNMlPPkM2F7WTaEU1R6ZeeP4muGTE/82nlWUAYV58JlUq0PXwUOHtyhycVb6+BkbMUPgTTb/maWNSRg6WQXWMPMg0X9QNsOKLWKipe5mMdhSUhjqYhCM3LfGzVyhRUuP1YMcnXftChSg7SrWOtuXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088998; c=relaxed/simple;
	bh=KrtGgk294GRjBEs6iQyOp5BKbLlkhgJGu4IdQFjdyrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLoRdZ3Cr5rhYIi+ABldLbIU/zIlkZuKbt5FMpHCUbq5JeHbYV4meDKpyfL5CGUWohdXzT7sYNe15DXgdYOEJAcWj5FkiZPvZm4Rv5To83I5qLJK3iCLgvbczp2CYTo2gMj0p3cS/whAA1TOAqGjYRVEjD4gMXwgcrHM2BqdDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwZJwF/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwZJwF/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770088995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL3VVCy6HeFE+SU5i9MQx2mEMpgSKX2XiM1AgerOcGg=;
	b=IwZJwF/8qWtw7yKB0UdLXpeeX57KCcsb6JeTR0Qh/HE8lxwA4rg8L4rce+3jMiZz8gnN8A
	AHIAWL5Si+ECSS1hlc18Sw7g5y8PUi8DsSkKY15I6xTTqYUvu8DaNQDStqvN2q84xp6MFf
	HJQ2D165enoRJFokPCiD0b9gEI9fKqQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-IdqQ0a-mPUuAUhO1C2TQ-w-1; Mon, 02 Feb 2026 22:23:14 -0500
X-MC-Unique: IdqQ0a-mPUuAUhO1C2TQ-w-1
X-Mimecast-MFC-AGG-ID: IdqQ0a-mPUuAUhO1C2TQ-w_1770088993
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0a4b748a0so109816885ad.1
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 19:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770088993; x=1770693793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IL3VVCy6HeFE+SU5i9MQx2mEMpgSKX2XiM1AgerOcGg=;
        b=TXEW/J9JijP8cMcuAGzfQIqP2tvJWJii0/BKEL/I1/SwzzXOWEqKbhsriRn50hCm/4
         a3AQeMuP9A7AUkOGlCR7G/jbsJPM2cNFHpNLQi5hH8Rcsc/08/aEhYR1YtTgBkLCE4HE
         V1eddEtzX3fgDDJKMKnW4iJd4OLsaiyN1kzgWaDqwXenjxMYnei6UGU6kCtkI9/hVDTY
         ZDJaxJrS63KT7WGdg5bHAXYcXIgrL3fBPgMo0yuS3y61CYC2+XJTU8pBUw41Qc2qmjmj
         fQG56MAPhvY+g3gW+FufNnHZV/LfrUgC1GlnDWpOQmqEM3aJyvYehKfORm2a6cFYQ4ql
         KKuA==
X-Forwarded-Encrypted: i=1; AJvYcCUfrz+h3eFwQSLlzsVBPlKQnOMXfFfZB53Q6VnywWBPsPyLFwKkKjifxNXYbD/pfnWzCVs4RZ2i0wwfpSjVPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlQkomk+kEZsHxBkx1L/fcc0R1L+J2erR6pFNommMpMtY3jZkc
	jIKdu9E/sEUYNRPc5SleO0lb0/jjVmh9OR+rcGwLN3tQW4LyoiR4Jqe3goYymY359oHqx+bsgvI
	4Z9KV1LIVHdcXiLz8oSBkMLz4bggdx15Ol79fdVZEozYX0zXrwO1I0s/jzCi1q2FnD3UFRvbTWj
	2+Kkc2smFw6ry4Sv7aIw7y6gm06MSSu5+NAtNiCF8GjXk=
X-Gm-Gg: AZuq6aLnVYcQlFyEIvsq0b6mN4DWQbOTzdpMTNBq1XOfqyjbSWdazcTs+k1n/HryRPq
	fah/2FYq+WitAyaOkeCu/ZE2JWqWKMbEaccRecYbKlHlNCKTBsgZTM61tl1Fe/EqhdfTSEm3K0D
	Dseh5N130KHRoBQJccI6vyfSgsiC0zz6sGAHln06kBcxtyPoU1mbWrNVslbuOUvn6QPKY=
X-Received: by 2002:a17:903:2b0c:b0:295:8c51:64ff with SMTP id d9443c01a7336-2a8d9919237mr141235215ad.29.1770088993352;
        Mon, 02 Feb 2026 19:23:13 -0800 (PST)
X-Received: by 2002:a17:903:2b0c:b0:295:8c51:64ff with SMTP id
 d9443c01a7336-2a8d9919237mr141234955ad.29.1770088992952; Mon, 02 Feb 2026
 19:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 11:23:01 +0800
X-Gm-Features: AZwV_QiXK5cVba8qXcynunVqAEqDCvgPd9117zHmBgehD1PDOxYKFN17tYOeGKo
Message-ID: <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jb0yn_Z04MHPKrNIdFkSWENPmruz5NwbYxsIgXalpkc_1770088993
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:13=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
>
> vduse_dev_read_iter():
>     lock(msg_lock);
>     dequeue_msg(send_list);
>     unlock(msg_lock);
> vduse_dev_msg_sync():
>     wait_timeout() finish
>     lock(msg_lock);
>     check msg->complete is false
>         list_del(msg);   <- double list_del() crash!
>
> To fix this case, we shall ensure vduse_msg is on send_list or recv_list
> outside the msg_lock critical section.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> ---
> v2:
>  - Rewrite commit message.                        [Michael]
>  - Add Fixes tag and cc stable email list.        [Eugenio]
>  - Rewrite one comment.                           [Michael]
>
> v1: https://lkml.org/lkml/2026/1/30/323
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index ae357d014564c..a70d0580d54e8 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb=
, struct iov_iter *to)
>         struct file *file =3D iocb->ki_filp;
>         struct vduse_dev *dev =3D file->private_data;
>         struct vduse_dev_msg *msg;
> +       struct vduse_dev_request req;
>         int size =3D sizeof(struct vduse_dev_request);
>         ssize_t ret;
>
> @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb=
, struct iov_iter *to)
>
>                 ret =3D -EAGAIN;
>                 if (file->f_flags & O_NONBLOCK)
> -                       goto unlock;
> +                       break;
>
>                 spin_unlock(&dev->msg_lock);
>                 ret =3D wait_event_interruptible_exclusive(dev->waitq,
> @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
>
>                 spin_lock(&dev->msg_lock);
>         }
> +       if (!msg) {
> +               spin_unlock(&dev->msg_lock);
> +               return ret;
> +       }

Nit: this check seems to be redundant, I'd suggest to

1) move the spin_unlock() before the check of file->f_flags & O_NONBLOCK
2) then we can simply do "return ret" when it's a nonblocking read.

> +
> +       memcpy(&req, &msg->req, sizeof(req));
> +       /*
> +        * We must ensure vduse_msg is on send_list or recv_list before u=
nlock
> +        * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout whe=
n we
> +        * copy data to userspace, and will call list_del() for this msg.
> +        */
> +       vduse_enqueue_msg(&dev->recv_list, msg);
>         spin_unlock(&dev->msg_lock);
> -       ret =3D copy_to_iter(&msg->req, size, to);
> -       spin_lock(&dev->msg_lock);
> +
> +       ret =3D copy_to_iter(&req, size, to);
>         if (ret !=3D size) {
> +               spin_lock(&dev->msg_lock);
> +               /* Roll back: move msg back to send_list if still pending=
. */
> +               msg =3D vduse_find_msg(&dev->recv_list, req.request_id);
> +               if (msg)
> +                       vduse_enqueue_msg(&dev->send_list, msg);
> +               spin_unlock(&dev->msg_lock);
>                 ret =3D -EFAULT;
> -               vduse_enqueue_msg(&dev->send_list, msg);
> -               goto unlock;
>         }
> -       vduse_enqueue_msg(&dev->recv_list, msg);
> -unlock:
> -       spin_unlock(&dev->msg_lock);
>
>         return ret;
>  }
> --
> 2.39.5
>

Thanks

