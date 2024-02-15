Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9813247C
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011914; cv=none; b=uUvKO/YI5/aAEpE1PWg8PJrFRIYCvuzR1802Fkdi7Z4gB5Xkm2kwvOqtXpMDDW5/haAzwnn94nwFDBAJpX2udRtZv5mCO2UW/JsHAAjhdsKIDNPrgAU/ruJPisH+1SYJfnr3sn7k9AFqNFUUSm+zOciPkbGayCAPXcdq/hvJ5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011914; c=relaxed/simple;
	bh=jGrsuTrQ50aMOx/Q4bJMab8iuOMogw82FMKiSbI60CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/4kDnm7c/utyO7X0mxBPZHbtfJiKdi+VvHKP3qXvkKPLnnAskHxINgL9VvWi7bSdFS8YBHVJ6vrHjdAU/mUVRdXi2YyXNticxCPq38uI0cV5h29NCS6azhIel50r2tyjSnkZcWvWT8LV0WcnHjlbezS4RG1A7AnWRZaABqlLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATXPKSXU; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATXPKSXU"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6C0883B88
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 15:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3yLR5rzyLsW4
	for <virtualization@lists.linux-foundation.org>;
	Thu, 15 Feb 2024 15:45:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7AF3683C52
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AF3683C52
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ATXPKSXU
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7AF3683C52
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708011910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgRj/r6jJKBOT9E5bjhJrMIbJaqPHZG5ug6maI133dw=;
	b=ATXPKSXUfTE16I3RJlsVWrpayfFr/38J8GeR88Vvi+xk7rhLQ5noM1+NPOQK98fz3rnGix
	4vvWCB3rn6sypRAezpwYGz7BmWHyUyECMY97nLR5+yiwmG13pcns1XCxWYe5Kc72qOxNi5
	9+7vBRzPOJ9NqpRgur6eqgu9xutOTv4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-y4wN4YpiPYOw6XXiGgC8uQ-1; Thu, 15 Feb 2024 10:45:08 -0500
X-MC-Unique: y4wN4YpiPYOw6XXiGgC8uQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5ee22efe5eeso19403057b3.3
        for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 07:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011908; x=1708616708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgRj/r6jJKBOT9E5bjhJrMIbJaqPHZG5ug6maI133dw=;
        b=h1XuRrQH8KZR7TZ14S90tLxuYBVUzDsFZ/GsCWNQYlKG+tmcamIE+p3A7giHtv/iE6
         5eRf9eUck0ahlOIuCRObBmLW/X+G/KI6k/ClVx0KbiE3Cj8hHZBHYm6JOAyDkMoImeTw
         hNgANsQpnq+y+Q7gT8FsdNsvm6y22QApavGPNGFSjqd3pT+tVaYI1pITJEznmf+s7DKA
         2rBAIO6fYWRM126MVMcZh2T7PXxGW8cG0i/+qbGAky8sRvmfZEXJb6nWZyC6pdGpAwAv
         9l7pze6BXsKTxi8LJMhucQf3Lvo1Igxx5S+Bzkm9MHJyirorf7EHQ6dV89T2Ou70ofNw
         NTiw==
X-Gm-Message-State: AOJu0Yyw2UA9zj23QY4Agil+iIenBiMzWcYPNB45yGO6KrIpwgyfcJbT
	fWQZVxQ68GPX9KZb/hDvDLm7DUT2H0S0HRAIdppMahYvjIIbIA4VYHmui+CxZEVXSC28WLeXNqD
	PBy028sqMNyX/1t4n1OcHwcqR6Nmbu4Vs3lddmrAWGuiZeedwBo+jvS0o/ATYGFsSaNdjoL5DG5
	epZdJtj+FixyyMQYSRAh2jbF3oyvE3plO1OeJpHeZh7zo7G2sAKN9w4A==
X-Received: by 2002:a0d:e2d6:0:b0:5ff:fdd5:d368 with SMTP id l205-20020a0de2d6000000b005fffdd5d368mr1990516ywe.44.1708011908406;
        Thu, 15 Feb 2024 07:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7G3wF/llkvMZxRUqMJv2ohvPHXABLz4Ismq8yT+WDgcWzbT/FJJn6vSBV+U06iKvGRxaKLxllo++71kRJ/Jg=
X-Received: by 2002:a0d:e2d6:0:b0:5ff:fdd5:d368 with SMTP id
 l205-20020a0de2d6000000b005fffdd5d368mr1990454ywe.44.1708011907148; Thu, 15
 Feb 2024 07:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
 <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com>
 <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com> <CAJaqyWe1=eQ4eQyv+wOqbr3pfZst6gmss2SrDZSNkY_ZVXcf=Q@mail.gmail.com>
 <996cfabf-c612-43c8-9e56-03fb58a1ebec@oracle.com>
In-Reply-To: <996cfabf-c612-43c8-9e56-03fb58a1ebec@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Feb 2024 16:44:30 +0100
Message-ID: <CAJaqyWdKC6rLBOykSeWc87QtJ757LNXd78R59JRizUyAQCu+ig@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:52=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 2/14/2024 2:39 PM, Eugenio Perez Martin wrote:
> > On Wed, Feb 14, 2024 at 6:50=E2=80=AFPM Steven Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> On 2/13/2024 11:10 AM, Eugenio Perez Martin wrote:
> >>> On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Steve Sistare <steven.sistare=
@oracle.com> wrote:
> >>>>
> >>>> Flush to guarantee no workers are running when suspend returns.
> >>>>
> >>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>>> ---
> >>>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
> >>>>  1 file changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_si=
m/vdpa_sim.c
> >>>> index be2925d0d283..a662b90357c3 100644
> >>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >>>> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct =
vdpasim *vdpasim,
> >>>>         kthread_flush_work(work);
> >>>>  }
> >>>>
> >>>> +static void flush_work_fn(struct kthread_work *work) {}
> >>>> +
> >>>> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
> >>>> +{
> >>>> +       struct kthread_work work;
> >>>> +
> >>>> +       kthread_init_work(&work, flush_work_fn);
> >>>
> >>> If the work is already queued, doesn't it break the linked list
> >>> because of the memset in kthread_init_work?
> >>
> >> work is a local variable.  It completes before vdpasim_flush_work retu=
rns,
> >> thus is never already queued on entry to vdpasim_flush_work.
> >> Am I missing your point?
> >
> > No, sorry, I was the one missing that. Thanks for explaining it :)!
> >
> > I'm not so used to the kthread queue, but why not calling
> > kthread_flush_work on vdpasim->work directly?
>
> vdpasim->work is not the only work posted to vdpasim->worker; see
> vdpasim_worker_change_mm_sync.  Posting a new no-op work guarantees
> they are all flushed.
>

But it is ok to have concurrent mm updates, isn't it? Moreover, they
can be enqueued immediately after the kthread_flush_work already, as
there is no lock protecting it.

> - Steve
>
> >>>> +       kthread_queue_work(vdpasim->worker, &work);
> >>>> +       kthread_flush_work(&work);
> >>>> +}
> >>>> +
> >>>>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >>>>  {
> >>>>         return container_of(vdpa, struct vdpasim, vdpa);
> >>>> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *v=
dpa)
> >>>>         vdpasim->running =3D false;
> >>>>         mutex_unlock(&vdpasim->mutex);
> >>>>
> >>>> +       vdpasim_flush_work(vdpasim);
> >>>
> >>> Do we need to protect the case where vdpasim_kick_vq and
> >>> vdpasim_suspend are called "at the same time"? Correct userland shoul=
d
> >>> not be doing it but buggy or mailious could be. Just calling
> >>> vdpasim_flush_work with the mutex acquired would solve the issue,
> >>> doesn't it?
> >>
> >> Good catch.  I need to serialize access to vdpasim->running plus the w=
orker queue
> >> in these two functions.  vdpasim_kick_vq currently takes no locks. In =
case it is called
> >> from non-task contexts, I should define a new spinlock to be acquired =
in both functions.
> >>
> >> - Steve
> >>
> >
>

