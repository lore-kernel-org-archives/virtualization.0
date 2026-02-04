Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C226286D7E
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174773; cv=pass; b=DnlZ9vqNkfT2s8OLhy7u7jqhcMde7MVK1PAdFjLsKHdAScaUOokBuE2EeG5sQsX2mMyO7qJ7shOIofMtg6nJhkDxI3P5j/ek43Xn1MCcuyLfTVvKLvhtyPSGrJn+dUC6uwoZJQfECr4TkXruxTFUNxC1W7HqIlbnVzZKqrSqq/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174773; c=relaxed/simple;
	bh=tShlbJCcBqCuciT7fA7ChfjLfuZeg5HSJRumys940Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ba2TecHWKfxgZLw3AxsYdLv0Lq1uLIleNZK9cMOT+lRxoumJSMhJ2L3Tv8cbaKzapopTuYRd4Nda9CqOPCxEtYSqM4L58wPrqy22IXEO3iHF/DRXfZtRbjDnaq6Eo1oqbtia8itc59wouHTKZK9uCfCOnD4g8veTAshapueH7ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VB0PsnGo; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VB0PsnGo"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3530715386cso4702370a91.2
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 19:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770174771; cv=none;
        d=google.com; s=arc-20240605;
        b=e8clYEBQTxNOddm6Q6lvcais73jP4WJoXXU4UpPbJ+DRh3752z3BOvdllA4ReQ6Wa0
         YfNqjQGFLTIa2/D7+9yvOukomPYCt0iX8GFcwz/grFuaNt+LUHUUUtGz2I003oY+5KXb
         uJK/HlXwOpOOvx5+EYByEVPz7b034oGpa+YbttCu3IyMCEI62rzUpw+0dadQtB4URSHs
         5pB5FM6Yn44JrM0V31WCEssQmcn+tHjk+6A1neSXJs8099n4DWrCl8DbQ2kbmakDV6r4
         R55K4q+vvXDLI2KaSbDpM4nSyx0uhIhbwPNcbhI59ylBo+/oJmF/aTWSv+axv5izVsIj
         k9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VyB8GeZeoQ6TdlAqqhLDkjURCE1GppXWjsFRPk64SY4=;
        fh=L6d+0s2VXbzLxxuQtErsQ+TGt5DVqxRGXcFeRefOtZ8=;
        b=iVxwNhx73QbP/Y5PrX/Qpj7eio6luUAyIsT47PdAb920GMHbFu4FPZmph25+eREYHt
         mEw3eOHn/OtxPzXcIJHG7R8P8JVE6UvlzM9bXKmmx0EpkopQPdmGmjcON+Q8I97nCKPr
         Zr1u2Vqf7+wZP3iAEKlUYjQs4Pfk0JQPRo2cgxpGhMaThRfg6hhMGzMV/bH/VtTb96p3
         q8QNXbzQzZM7NGC061FP1waGeWFtDlcaVWz57mjN6Yxji5ieGPWIrqL4nUb76hSsbMiG
         Z6ycFXYxY/no+BCutgC4JfEb6ZFFlsr6pQUyl0McaK+z0Qt9+bv+bDItd/IqIi2YV5hW
         sAsA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770174771; x=1770779571; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyB8GeZeoQ6TdlAqqhLDkjURCE1GppXWjsFRPk64SY4=;
        b=VB0PsnGo1ldwY7CzwYg/fjMSU8EDd0hSd9ZDlpss3Fa8vFKOAdKmEhXG/cJgCfFRXH
         dTvCUzOvC/xCP/4VEk0Ius49gYWk3eilcWPzNLOxwA8QIJZGiXa6BdEvv/cqd5l5BZAZ
         OyRNx2bybYygjUt3lnu/ycCQ3OeT48/Khiwoy9fZr6bZ/5IlrPUXUAMhHbPJwR2o+Z4d
         0BZHeca8xt6z4frR0Zm304OvCxTixf+oqt51ogHvYxw2Y9Aa/vaMw0EWPGQqs9NwmPln
         akFyEGZ8uJqWNL0hobAO3Hl1gqYNpAHHEYLrJH8yWF4m1ODhxMmyvCnZp07TFvVvqLzb
         pqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174771; x=1770779571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyB8GeZeoQ6TdlAqqhLDkjURCE1GppXWjsFRPk64SY4=;
        b=dAwZu7B+2nkk3p2uFmEXxPG5Z+cp4fJecG8apeNIHHv0h2tIYTBcbgMl4CN6zoaQax
         Nf+EbhccX90mBzoh2v8VnZuHbSxQId22tv4DMG6GTvBivEnQJytq7n+iR0Df5cZFm4P7
         /BYAUoqN3Hs9nALt2hUPOzc3vNrAy2kxanTc3bKVdfIMrmBtkMm8bXYB3WLqbwnnFy9i
         AbAY5fyq4q9jzsaZ+eMiPxRbUZNanjuW4QOPlBcVi4ev/bvuy9CjJMZwNJfQ1n2+4gTL
         UolCqv9m0+zAEv9NxGYwKA775SZNYd8ctg2XIK5EUhqP9VRGz/pyn7xYOk1l5fD60jtg
         7iSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkROuGqHVYYgJipLHMcf7pDYWMLusCy96HY9snucNc1o/+Y9D4CsP8WPHIhoICuSjDbtSNSngyrxPiQGVrZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzjxH4XkAicvnu4fUoa0Eg7s1xmc/gDWLgMbzWbcr0IQDxFFd/
	4oSciG1hrrs7MYokkL72TKccflo58Aonay6ofGiBUJOBKpGSa4WlwGqyA2nSvF5lu9xgoFvUzuk
	vIPt5YfqYPrWghH0bQwFjdxsY+rkg8X/KD6/QIr5AxftzcWvKuIMzhoirt0rZlKI=
X-Gm-Gg: AZuq6aKv+Owe8lvFEOD1nu/1Qw6SC9NCg2mQw0FEoIVn9FVVntgSGMVG8O/ieLnmOc3
	17a3+TrcSQAeZcOPg5zVFxzNGR/qIab2oOvhx7uFHYeogmrZGbaJjXr2aSJoRooC4w5DBUFnoLD
	ZP0SoWAwoCRTIH8uDtbcVtzoA8oK/xa7Xu/mnzyqUg3bjAA6CBxbteM/gYl5DvG+UrfaCautHAx
	BKmq4qqFItV6Xy2ed1TwJ3rWWji7URpvIr2kmtdeyQWwu4yVb9EdhUMTXgNmzO1iVolP4lUbGkm
	tXqA7K7mooQu
X-Received: by 2002:a17:90b:264a:b0:352:cd8e:3ead with SMTP id
 98e67ed59e1d1-354870e626bmr1435325a91.10.1770174771203; Tue, 03 Feb 2026
 19:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
 <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com> <CACGkMEtKZE2NQMoY8quO=Y+g=b0fMrkzg64AZ3O5w901yU9bFQ@mail.gmail.com>
In-Reply-To: <CACGkMEtKZE2NQMoY8quO=Y+g=b0fMrkzg64AZ3O5w901yU9bFQ@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 4 Feb 2026 11:12:39 +0800
X-Gm-Features: AZwV_QjZ8_6OHPU9CpcTCSE3bVbgC-pg74TGqZJzN-isa3OOL6yW2dgzSXw-6S8
Message-ID: <CAP4dvsfz2PO+8J+DsXcOPGAoEiDciww=9Fp5=XeYtuauowMHbA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync
 and vduse_dev_read_iter
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason,

On Tue, Feb 3, 2026 at 11:27=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Feb 3, 2026 at 11:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Feb 2, 2026 at 11:13=E2=80=AFAM Zhang Tianci
> > <zhangtianci.1997@bytedance.com> wrote:
> > >
> > > There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
> > >
> > > vduse_dev_read_iter():
> > >     lock(msg_lock);
> > >     dequeue_msg(send_list);
> > >     unlock(msg_lock);
> > > vduse_dev_msg_sync():
> > >     wait_timeout() finish
> > >     lock(msg_lock);
> > >     check msg->complete is false
> > >         list_del(msg);   <- double list_del() crash!
> > >
> > > To fix this case, we shall ensure vduse_msg is on send_list or recv_l=
ist
> > > outside the msg_lock critical section.
> > >
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspa=
ce")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > > v2:
> > >  - Rewrite commit message.                        [Michael]
> > >  - Add Fixes tag and cc stable email list.        [Eugenio]
> > >  - Rewrite one comment.                           [Michael]
> > >
> > > v1: https://lkml.org/lkml/2026/1/30/323
> > >
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++------=
--
> > >  1 file changed, 22 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index ae357d014564c..a70d0580d54e8 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> > >         struct file *file =3D iocb->ki_filp;
> > >         struct vduse_dev *dev =3D file->private_data;
> > >         struct vduse_dev_msg *msg;
> > > +       struct vduse_dev_request req;
> > >         int size =3D sizeof(struct vduse_dev_request);
> > >         ssize_t ret;
> > >
> > > @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> > >
> > >                 ret =3D -EAGAIN;
> > >                 if (file->f_flags & O_NONBLOCK)
> > > -                       goto unlock;
> > > +                       break;
> > >
> > >                 spin_unlock(&dev->msg_lock);
> > >                 ret =3D wait_event_interruptible_exclusive(dev->waitq=
,
> > > @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb=
 *iocb, struct iov_iter *to)
> > >
> > >                 spin_lock(&dev->msg_lock);
> > >         }
> > > +       if (!msg) {
> > > +               spin_unlock(&dev->msg_lock);
> > > +               return ret;
> > > +       }
> >
> > Nit: this check seems to be redundant, I'd suggest to
> >
> > 1) move the spin_unlock() before the check of file->f_flags & O_NONBLOC=
K
> > 2) then we can simply do "return ret" when it's a nonblocking read.
> >
> > > +
> > > +       memcpy(&req, &msg->req, sizeof(req));
> > > +       /*
> > > +        * We must ensure vduse_msg is on send_list or recv_list befo=
re unlock
> > > +        * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout=
 when we
> > > +        * copy data to userspace, and will call list_del() for this =
msg.
> > > +        */
> > > +       vduse_enqueue_msg(&dev->recv_list, msg);
> > >         spin_unlock(&dev->msg_lock);
> > > -       ret =3D copy_to_iter(&msg->req, size, to);
> > > -       spin_lock(&dev->msg_lock);
> > > +
> > > +       ret =3D copy_to_iter(&req, size, to);
> > >         if (ret !=3D size) {
>
> Btw, I would like to explain why it's still safe if a (malicious)
> userspace writes in this window in either commit log or here.

Do you mean we should document in a comment here why the potential read/wri=
te
race is safe?

Thanks,
Tianci
