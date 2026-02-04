Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AC2882C5
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174528; cv=pass; b=P03wSrnGANjkViRYp88sA+EByapdpus2ws8GNMVLKU0IXNKBLa/99quSWT8XSf/s7x1grFAc2zfROt67yU9SlKn5CHYDOe4h9UUyOyvV/bnoN7LZUmR2mbvoexo9SxUvQZ1ZTdCYfMZHtvKTVKeISGLvUfDL+tNMonjs11+aqCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174528; c=relaxed/simple;
	bh=dZCFNfk3IzAyplxpfcKXPrgRKeaYdNIkIAcDZDpti60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHeewrLmlnXVKuOny5uIJaehSKXZwPtrcPuWfiABQmVp/x99xARRc3v7CE/RjLWHx4S9fK9JinGi75fxLZLaGxKtgaOzsPwR/SACW0y2M3f2Gi5q25lUburd22iiX6krVjRhWDRbjQK1OlHCWH7+nLvdxNqu3mUYKBUTQDmTft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OPpfB3vl; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OPpfB3vl"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so5300579a91.3
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 19:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770174527; cv=none;
        d=google.com; s=arc-20240605;
        b=b2FR5AVt2hmil3bPZ08ffpEdAE1W0pG3naRuk9Y/vdfmn7piPtxIEyiPH8nf+fiTwi
         mNIfAu1zbNeZJe3sjoJsDDypbS/p7wCoq7RdG9mFUHFnZulMlccdbK0P2pilgNiC8Z5G
         Ex+LbF8Mlk6M5TNMCVK7fqDsd3LmaJr4GJ5BtfTxQOjmcW/Uq5lt4lhpMa0Sjlh6Lizj
         2gp6DJYQ7V7JpZRbOBpafr/7xumxozPfrOIqX7tl569oQk1HdxzRlf7/uRolv+W2Ahe3
         954n1kQgYV3njZ4ZJrddl4vMWSCzIuo4bx3mp9Tfye+bCDHrf50uu8oUNeJofs13hmDe
         P8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wv5KazzuZ0/Tp//UpjjquzNJLcnLfGCDpur/wljFjwE=;
        fh=ecbD5uQKAUF3/BLV/57lxefS1UX2/Yb5XePtkzZYyoQ=;
        b=KC3CejYxvpGepD7sHBX0NeR0tFbhQYvF6LqLNMgXbju/UA/sMLythWk5RyCasbr0Vi
         mxfIIWutlxjM0840pUUC7PwBu610m7b59IMcG/sIvQRinEYFpRvtx1AI0NuCARZvvJG8
         NZVvpv4D8Ag0H4KEu3rfPVIVpdzLFbQIkxgQllXEflfiGnaOEcBb9YUIvnHDr11DQtNG
         tOACzj/sHcnAKpeWgAzTn0IG+9/HMRWmR0C+W9bvppAhnnCW0oU8khl500NWO9vhUqOj
         iAfxS+mdwVLdumBdXk2h8i8IU+1hcNX0AY/4KsXGnXywBEMXGG4sPyPMTYkj/qk2ZVkj
         FFUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770174527; x=1770779327; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv5KazzuZ0/Tp//UpjjquzNJLcnLfGCDpur/wljFjwE=;
        b=OPpfB3vlibzUKpbXg9g0EV6rxlnVqbJVhXhBgvZ6f4/PXpJRizM9SfwCaKPVWe8yCy
         kxYoayhPlgjxnrKprxc9sxkcN7VIet1THSs23gAkhpc62ZVVyxrDTIKpBBTfWINH8AFz
         VT4ReyKcr3S2dnj4C1YGsHGJ9uk/3iXhw8pcrxntHlpgas4G+uMpPcFcPd0u5APdBGnc
         +Wq0Z8d1SCBEwDuNFf5isoxS8xpoeuqK9FNaJ4VJNFQX32FqAksy9HF6qjRX0XLT003L
         aeEKVxUtbQQ6GdRwiUZFa39ZXQo5iRid7I49GCcWA6RZVCo2kcMtWQsZd6aUVqtXmXIe
         /lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174527; x=1770779327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wv5KazzuZ0/Tp//UpjjquzNJLcnLfGCDpur/wljFjwE=;
        b=s+XvTKGtPDlhw8pxYobwHuXPZwEQa2cpvby+q9JQbNc+mQWChl/LbZlCHIGy5S6kBg
         75LXB2wMwq90rnVBaRtIYxb1H+jZ1UYGzsBuPnUCoAqLDHH9aT8/zs2vHCbfK5saTYwA
         f2oleiSGWmQc4FTkDA7mLCllWD2/9+VnSUi6SMTrSYPJsWfbe+0xtMuRMeFXV5nTxexS
         QctFktsJIKjM/ivnk/HTcbgTji/VmG0IHzl1oPuNLht3B+PU6utk72GMOzTnC/oGs+WC
         2IqcpGR53fOpRQfPmtZDEsnr909T8tjhGGf5IWjq/OdLVMN+3X4tda5XBvwHR7kSxhw2
         hLjw==
X-Forwarded-Encrypted: i=1; AJvYcCXhX7efSgqtpJBo8NfZpRmqP+K6gudzScCCng2A1cgbj0pkaAlNzwHR/dT0Hz6hjoRDGn81bE6jWgniPmuBqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXQKsU4lQcXcmV5IwkGYOm/4u89H3w5RyxX/RBBlCOt9lTugJ5
	zV7A52sre96PpRGmii85szLF1LikkmEFyInfEOmxL9uxwVnX2Xh1w3FQfEzruBpWdr7UKghVTvh
	Lp+rxwMk8kQdsjuemBmL6F1gZilQ3X6HGcPMfQWEghg==
X-Gm-Gg: AZuq6aLVBV4h/fHQmpTfbKmfDYmG1qETyfkxILaggepu2vEqwFZgJi+tKk/pP4sgxsx
	SRsLOeQaR0qE1Rkce4kLbRqBNIbFfixrlW94N/nXkEBu12w+zBnIW+h+hZ2saKtVSgmfdhr6360
	r9bBMFPDwmIJ6hPoy03n+Z6DRvY7bZkRX7RqSSN0/1AZPp4PWRje8DsNaEDwLH31S/zwi4mYw3y
	Q7nUdIQkcPEyxZqIwje7vfbBcRuMw/rD+vFfUX4P5CuU3dgjXkGdffO+uuvOYTqHduluUo5zf0u
	0kZDVbXwPYH2
X-Received: by 2002:a17:90b:5808:b0:34f:62e7:4cf3 with SMTP id
 98e67ed59e1d1-354870d71d3mr1486296a91.10.1770174526682; Tue, 03 Feb 2026
 19:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com> <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
In-Reply-To: <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 4 Feb 2026 11:08:34 +0800
X-Gm-Features: AZwV_Qi0FxYMJ_vV6dV-hna-OHMVyZCTHi0eEfriw2hdpyZ_gHoLVx_8pj8RZU8
Message-ID: <CAP4dvsd1mZyMwARtN+P+chLsT1-F4FVZpiMb4QMKeo+2CWX05g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync
 and vduse_dev_read_iter
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Tue, Feb 3, 2026 at 11:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Feb 2, 2026 at 11:13=E2=80=AFAM Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
> >
> > vduse_dev_read_iter():
> >     lock(msg_lock);
> >     dequeue_msg(send_list);
> >     unlock(msg_lock);
> > vduse_dev_msg_sync():
> >     wait_timeout() finish
> >     lock(msg_lock);
> >     check msg->complete is false
> >         list_del(msg);   <- double list_del() crash!
> >
> > To fix this case, we shall ensure vduse_msg is on send_list or recv_lis=
t
> > outside the msg_lock critical section.
> >
> > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> > v2:
> >  - Rewrite commit message.                        [Michael]
> >  - Add Fixes tag and cc stable email list.        [Eugenio]
> >  - Rewrite one comment.                           [Michael]
> >
> > v1: https://lkml.org/lkml/2026/1/30/323
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index ae357d014564c..a70d0580d54e8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
> >         struct file *file =3D iocb->ki_filp;
> >         struct vduse_dev *dev =3D file->private_data;
> >         struct vduse_dev_msg *msg;
> > +       struct vduse_dev_request req;
> >         int size =3D sizeof(struct vduse_dev_request);
> >         ssize_t ret;
> >
> > @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
> >
> >                 ret =3D -EAGAIN;
> >                 if (file->f_flags & O_NONBLOCK)
> > -                       goto unlock;
> > +                       break;
> >
> >                 spin_unlock(&dev->msg_lock);
> >                 ret =3D wait_event_interruptible_exclusive(dev->waitq,
> > @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> >
> >                 spin_lock(&dev->msg_lock);
> >         }
> > +       if (!msg) {
> > +               spin_unlock(&dev->msg_lock);
> > +               return ret;
> > +       }
>
> Nit: this check seems to be redundant, I'd suggest to
>
> 1) move the spin_unlock() before the check of file->f_flags & O_NONBLOCK
> 2) then we can simply do "return ret" when it's a nonblocking read.

Makes sense. I'll make the change.

>
> > +
> > +       memcpy(&req, &msg->req, sizeof(req));
> > +       /*
> > +        * We must ensure vduse_msg is on send_list or recv_list before=
 unlock
> > +        * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout w=
hen we
> > +        * copy data to userspace, and will call list_del() for this ms=
g.
> > +        */
> > +       vduse_enqueue_msg(&dev->recv_list, msg);
> >         spin_unlock(&dev->msg_lock);
> > -       ret =3D copy_to_iter(&msg->req, size, to);
> > -       spin_lock(&dev->msg_lock);
> > +
> > +       ret =3D copy_to_iter(&req, size, to);
> >         if (ret !=3D size) {
> > +               spin_lock(&dev->msg_lock);
> > +               /* Roll back: move msg back to send_list if still pendi=
ng. */
> > +               msg =3D vduse_find_msg(&dev->recv_list, req.request_id)=
;
> > +               if (msg)
> > +                       vduse_enqueue_msg(&dev->send_list, msg);
> > +               spin_unlock(&dev->msg_lock);
> >                 ret =3D -EFAULT;
> > -               vduse_enqueue_msg(&dev->send_list, msg);
> > -               goto unlock;
> >         }
> > -       vduse_enqueue_msg(&dev->recv_list, msg);
> > -unlock:
> > -       spin_unlock(&dev->msg_lock);
> >
> >         return ret;
> >  }
> > --
> > 2.39.5
> >
>
> Thanks
>

Thanks,
Tianci
