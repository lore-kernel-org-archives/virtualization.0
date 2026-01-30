Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FF36D4FA
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773943; cv=none; b=Fb2P7bRjx3W4o2PMziB6zE85NlO59XT1fptoJ/YaM5tsF6BAqpf30tsuNr/IK1LEelosfc54nbbeaaRmlyIRzcBAuBnLU+yEdIGU6dLZZQ/rfd++ZUJEe1a77eQOqTwfuYhjj860SCn0m4G+NF6qGeesb4D/pt4HAIIEU4HWzFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773943; c=relaxed/simple;
	bh=FI70cKxhmjoXPKsfCbBbw5PGVqonjFEmcu086t7+UHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8v2/Ooxhu+17Vi/MTFUCZz6opRyzJJoBeQoML+wcypDsDBOFfJ1EQWjkb+gKC72zg6DwWor+9x2CCXT2yBMql6K1YgBDoeT5DPMnBi0oxHu2AISBvPBAZVWEXJuvHqc1ovmB1G4ah+eejISGb11Dx6hXXdCjtr3gDhumW3hmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYGabAYm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYGabAYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769773941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogSP7ob4wsqHcGELkto8/MQ5SyV4apLN8YKx2SgSPpE=;
	b=JYGabAYmrgeq0KIGHQRQY82tWq4X4Ya/E4zk621fpi9Bii0b6DvkEPK9H9+yHAORN0tzQr
	p6pbrM8kROrnEqD3AGA4YiPXDP8E4J/iVpn+YL2m9qyGmBuZuQgILlqStJIkcR9TMlNgx1
	ffySs9SWyvMGuUzLySofbDeveaC08SE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-ucl2PKGiMNaw3iGewFkzUQ-1; Fri, 30 Jan 2026 06:52:20 -0500
X-MC-Unique: ucl2PKGiMNaw3iGewFkzUQ-1
X-Mimecast-MFC-AGG-ID: ucl2PKGiMNaw3iGewFkzUQ_1769773939
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6445cf02fcbso2609042d50.2
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 03:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769773939; x=1770378739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogSP7ob4wsqHcGELkto8/MQ5SyV4apLN8YKx2SgSPpE=;
        b=oghy94QkK/rk66y5Tu8T1Jjp3cxDzh1lDTydH/WhMr/HE0ZJbZbkZJLx785EO7YR6S
         MmvLcGDLBHJqcE6p0+Sphd7fLbEt/EZlX2isjk9Na8KSHcvcSsIjeo+Xkp+m7R7wM0Wm
         VX8zGvnTChLXYBZ3mCNsEL2YPqPlWrLQQ0xiywWaw2fQ2J6y2azz7F0MlISYYcGT7WbB
         W4Qb+riy+lVtFeNxxOnuTVr9xWKSRKemUHNWKVxXoVJ9l1Fdxr8cX/5e1E0mPbZpQfaD
         Hbrb3rxSy6GYXL/7gtWYaFkPJN9h2Fq+/1uRNrJRSBTASHu7EMJO+RLLkr9VxTkZxSlX
         MawQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjNeYHm3yaFkUPhionptPvI/+Rbgm5RHOaIdZmvnfZZe1nYwE7ezdlaQco6tw/142Rm5II7io3tX4sih6zYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPw6si33eFbh+H66pCDu+mamM7vgudunpJrOmkM6FQJAqBuLc0
	sJ/haxrzwbd9c/LCRCc+mP1uRVl8N4F8gM5pBaQrVh+98nYy6sYcwOHTPgz3tnAD5HN6p1PKY77
	zLHof0Bk6Ln6i/TINTkTjTZWU4wnImt7XQZxPGj0UviXOB8/gCSim7MUEXLwIAgbFRL/g/5qBe0
	zI6ePPE5MxXEoL2OSKkKTbS4PjV2iHK0B9zU0rls5FXaA=
X-Gm-Gg: AZuq6aIHVK7yhQbMCHzAgkIOqewZImnY9/N5U9qjbEVcv/U7vXvOBu+uomuLUrdmmeI
	rpSy5oK2/xC/IV8OSATQmOqoODmQ0wnCRrkYe4Hy7NYYEDL/NzLrQt4la8Jzggbd3gJ8iW1RV0O
	X3sM5H1fdb+CvQG+A4rddwlP0a04SiqXFKohD4CBdfToUyNUs0kWv1fO7dagco5wSbyA==
X-Received: by 2002:a05:690c:60c3:b0:78e:1aa5:e98a with SMTP id 00721157ae682-7949e0158femr50745977b3.37.1769773939468;
        Fri, 30 Jan 2026 03:52:19 -0800 (PST)
X-Received: by 2002:a05:690c:60c3:b0:78e:1aa5:e98a with SMTP id
 00721157ae682-7949e0158femr50745827b3.37.1769773939121; Fri, 30 Jan 2026
 03:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130081524.81271-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260130081524.81271-1-zhangtianci.1997@bytedance.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Jan 2026 12:51:42 +0100
X-Gm-Features: AZwV_QhnCP9nxdpvy79tF7bMPPdWAHqhdcqgER3mmJNGkviO3kJBktjOPfK-ORM
Message-ID: <CAJaqyWepzL6uzwDtEd7MJLxp2Ywy8RODDFUpDXA1iksCEGW3nw@mail.gmail.com>
Subject: Re: [PATCH] vduse: Fix msg list race in vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -XPKUDq29yOI3ofCl2H86v_9k77-dR9o9QsqOLNEkNY_1769773939
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:15=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Move the message to recv_list before dropping msg_lock and copying the
> request to userspace, avoiding a transient unlinked state that can race
> with the msg_sync timeout path. Roll back to send_list on copy failures.
>

Missed Fixes: tag and Cc: stable@vger.kernel.org. Or maybe we can
consider this a change in the behavior? I don't think any VDUSE
instance should trust it will never receive that message that it
received partially once but still...


> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index ae357d014564c..b6a558341c06c 100644
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
> +
> +       memcpy(&req, &msg->req, sizeof(req));
> +       /*
> +        * Move @msg to recv_list before dropping msg_lock.
> +        * This avoids a window where @msg is detached from any list and
> +        * vduse_dev_msg_sync() timeout path may operate on an unlinked n=
ode.

But in the timeout case, msg->completed is false so list_del is never
called, isn't it?

Is there even any event that may cause more than one packet in either
queue? Maybe we can simplify a lot of this if we don't have that
assumption.

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

