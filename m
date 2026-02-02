Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A0285C98
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024577; cv=none; b=Ex4Nk1dS8sUBV1yMFdvC7vbzvISWXqq4ZEDpR1HFFDY9wNldbfEmtnPT8eF8NTEsCJG243lgjTRjm1rHMQq/E4X3Uh6So2ir2+Zg6xdTIjyPKcXEnXZm0leIOucjp63fpe1TrS8SYny1UxWvy7tlb4t/ufsdRKyxbruIBoKlnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024577; c=relaxed/simple;
	bh=3IhHg2qGjCWWrH3tJI/p3IIFJllNt3XBEPltfF4pOdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mglyBUYK6DFcSnax99uNBdCq0/CFXrAzmxIJqIbXjC+/PbBK3Gaj+BV5tKuKAENGodqG7UehveEVkzGlCj9Bnm16oemdUBDOELr+YM5qFwVP9L7A7xA3DZplueH4VbnZaQXyWPQP5YhbaBzBZNUEU+VqPPRX4/9PLSTKRANaRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDjCOYWe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDjCOYWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770024574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrbP4sgebgqs0JpTgDFG08jJm58o0TDtZ6dkP3Wvvag=;
	b=bDjCOYWemmsfUl03j8FapysEtUxuAHxFPP56S/FKlAX04kJIqHNyZnNkUJNVPZR9RstvJ2
	DxDoVgyvDsp98Rwxsfrz4zs+izN57UYLQlko6WjnD/SM65bXzf36vBp/yeQWGcLwlUr6eD
	t5DuvwUjOZaTDjgjJGFRUuF9GrYj5qA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-rAzoaGs-MUm23Lb5oKi7hQ-1; Mon, 02 Feb 2026 04:29:33 -0500
X-MC-Unique: rAzoaGs-MUm23Lb5oKi7hQ-1
X-Mimecast-MFC-AGG-ID: rAzoaGs-MUm23Lb5oKi7hQ_1770024573
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-794c28a770aso15982747b3.2
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 01:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770024573; x=1770629373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrbP4sgebgqs0JpTgDFG08jJm58o0TDtZ6dkP3Wvvag=;
        b=LGYrFdMyOxbgmdk4XT+Ye1QLMJbXBLx7cgbW16TRvDRaBJxbcdi1yNQLXGF050W2sn
         sRN6/uqsNL4rc1V8oKKFHlAam6NZt1I+UPq8AGYkDu2IEP78NTdN1yCGHtWxyjNendni
         7/3fxSqJZHMVFVe2OPIwnh0ZVhqqYXGLwNFOxuaO6E9ImVtquryavR0ia4p+PyKG3qmt
         yNyUpzW/Jh/jjG3KMF3lmxNU6f9WvcvrcvGschQaIryVyaijzU2zvJGREWwgFGNt8AqB
         b3oS7djYgRr6Ui4zqohG/JccgZaIThTUAg2AzwR0zm3CaDSmp5lS4jTtQhM1HG7+nIOd
         bhJA==
X-Forwarded-Encrypted: i=1; AJvYcCWtOMkp2/OLAradD08VV2wjoS6t2+BrY8OA7Qq1/RKD8Dxz398XxPlVaOcm6iYzAfVk50Grn9pojM+ls5CC0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzI1RaZeGoYphrSa4UkCpzE/q1mtR+YlbkR4JrQ93DI2z3SFT7
	ZuKQNwrTeeVByxMesIq9ngIVPM6W9DtI/nUb0qlaDFArkUcCigLdsDpWn30ynx7v6NuYtq8T68b
	Xyc0O6cR5wZnhyJTKww1cMw4xZ+Tu9bcD/PL87dcBxHwCFfQqNYaJDpVBscNmGJLvvUPp0sPYCg
	0vWpyfPfauhNYZZ0VpusXGIJaeNFcHGrf1y0F3lzusBUU=
X-Gm-Gg: AZuq6aJI233UUBT0spLKcq+18mazRORJUcHeth6opHzaqeum6I56Qel3j00r31Wo26F
	JC8csXqvjIrHAcpw8hqfW7DG+J3kCOh8OD54GEqpWUmcinhfUgLRqDdt8AuVlTtSUaH0fAJHWpu
	fBJJ+Dc1+jimy2sqVz1B8SiLZ++r95K95Lqgjb5gFtk6jsPN1fWzhMVWiNEZnGu/t6aw==
X-Received: by 2002:a05:690c:38b:b0:794:8cde:3ef0 with SMTP id 00721157ae682-7949e025a14mr81504587b3.61.1770024572913;
        Mon, 02 Feb 2026 01:29:32 -0800 (PST)
X-Received: by 2002:a05:690c:38b:b0:794:8cde:3ef0 with SMTP id
 00721157ae682-7949e025a14mr81504427b3.61.1770024572539; Mon, 02 Feb 2026
 01:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130081524.81271-1-zhangtianci.1997@bytedance.com>
 <CAJaqyWepzL6uzwDtEd7MJLxp2Ywy8RODDFUpDXA1iksCEGW3nw@mail.gmail.com> <CAP4dvscscRNbJBKwDLE-gebPT24fOJg08xap_0t00cPbYZ4xvQ@mail.gmail.com>
In-Reply-To: <CAP4dvscscRNbJBKwDLE-gebPT24fOJg08xap_0t00cPbYZ4xvQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 2 Feb 2026 10:28:55 +0100
X-Gm-Features: AZwV_QhIpNAjFf0Q9TCBSGyNn0ctloJU0xVi5359A_WjiwIaWZ1sR1Mx2-1gCu8
Message-ID: <CAJaqyWcbKc6RdmA+JPnhGiYO_J55s6hs637xbtFOXGH_WejPEw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] vduse: Fix msg list race in vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, marco.crivellari@suse.com, 
	anders.roxell@linaro.org, virtualization <virtualization@lists.linux.dev>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rUfjJ7tQD6ASVqysamlG4ErEqZjheZIPdzIJcAzRhvc_1770024573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 8:15=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi Eugenio,
>
> On Fri, Jan 30, 2026 at 7:52=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Jan 30, 2026 at 9:15=E2=80=AFAM Zhang Tianci
> > <zhangtianci.1997@bytedance.com> wrote:
> > >
> > > Move the message to recv_list before dropping msg_lock and copying th=
e
> > > request to userspace, avoiding a transient unlinked state that can ra=
ce
> > > with the msg_sync timeout path. Roll back to send_list on copy failur=
es.
> > >
> >
> > Missed Fixes: tag and Cc: stable@vger.kernel.org. Or maybe we can
> > consider this a change in the behavior? I don't think any VDUSE
> > instance should trust it will never receive that message that it
> > received partially once but still...
>
> I'll add the Fixes tag and CC stable list in v2 patch.
>
> >
> >
> > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++------=
--
> > >  1 file changed, 22 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index ae357d014564c..b6a558341c06c 100644
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
> > > +
> > > +       memcpy(&req, &msg->req, sizeof(req));
> > > +       /*
> > > +        * Move @msg to recv_list before dropping msg_lock.
> > > +        * This avoids a window where @msg is detached from any list =
and
> > > +        * vduse_dev_msg_sync() timeout path may operate on an unlink=
ed node.
> >
> > But in the timeout case, msg->completed is false so list_del is never
> > called, isn't it?
>
> Did you misread it?

Yes, I probably misread the code :). I should not post on Friday evenings!

> Here's the code:
>          spin_lock(&dev->msg_lock);
>          if (!msg->completed) {       <- here msg->completed is false.
>                  list_del(&msg->list);   <- boom
>                  msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
>                  /* Mark the device as malfunction when there is a timeou=
t */
>                  if (!ret)
>                          vduse_dev_broken(dev);
>          }
>          ret =3D (msg->resp.result =3D=3D VDUSE_REQ_RESULT_OK) ? 0 : -EIO=
;
>          spin_unlock(&dev->msg_lock);
>
> >
> > Is there even any event that may cause more than one packet in either
> > queue? Maybe we can simplify a lot of this if we don't have that
> > assumption.
>
> That makes sense. However, I believe that even though such a scenario doe=
sn't
> exist at present, we cannot depend on the queue containing just a single =
entry.
> This is a very fragile assumption and can easily be invalidated by modifi=
cations
> to upper-layer operations.
>

I didn't mean to change the external character device, that would be a
userland visible change. Just to simplify the part of the code
internal to the module.

For example, instead of having a list, have a permanent msg with an
enum state: free (as "no message in flight)", sent_to_userland,
completed. So we don't need to worry about lists etc.

If vduse ever implements more than one message in flight it is very
easy to come back to the list. Note that I'm also interested in
speeding up the vdpa initialization and to have many msgs in flight is
one of the most straightforward ways to do it, I'm not against that in
the long term :).

> >
> > > +        */
> > > +       vduse_enqueue_msg(&dev->recv_list, msg);

If we re-enqueue it, another read from another userland thread could
read the same message again concurrently with this vduse_dev_read_iter
call, isn't it?

> > >         spin_unlock(&dev->msg_lock);
> > > -       ret =3D copy_to_iter(&msg->req, size, to);
> > > -       spin_lock(&dev->msg_lock);
> > > +
> > > +       ret =3D copy_to_iter(&req, size, to);
> > >         if (ret !=3D size) {
> > > +               spin_lock(&dev->msg_lock);
> > > +               /* Roll back: move msg back to send_list if still pen=
ding. */
> > > +               msg =3D vduse_find_msg(&dev->recv_list, req.request_i=
d);
> > > +               if (msg)
> > > +                       vduse_enqueue_msg(&dev->send_list, msg)
> > > +               spin_unlock(&dev->msg_lock);
> > >                 ret =3D -EFAULT;
> > > -               vduse_enqueue_msg(&dev->send_list, msg);
> > > -               goto unlock;
> > >         }
> > > -       vduse_enqueue_msg(&dev->recv_list, msg);
> > > -unlock:
> > > -       spin_unlock(&dev->msg_lock);
> > >
> > >         return ret;
> > >  }
> > > --
> > > 2.39.5
> > >
> >
>
> I'll send out the v2 patch soon.
>
> Thanks,
> Tianci
>

