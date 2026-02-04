Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB7237A4F
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173337; cv=none; b=gPyWEIYglVOOLIQScPHWuv+uZ430Wp5GpK9oG5yRHlv2aApUpVnIgq+oK4GxvUmmBCZbFBHx4OXBZbo21ugnwHtZiYuvLnKg8tJrh/d8IvRAEeCEaweBFDhhsfliMykjxZxXBrVvdIoq/nlNUl+hkb8ZKzeZJOXgB0sNmVHX+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173337; c=relaxed/simple;
	bh=/XnQKiJQz29UovvAUSiZzMhV/traKdiEW6/cDWRM9/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2QdtFQ/2RmiRWixFqMWXsdZPS+YCHqk5jL25hrjeVl6wXA0IXPvV7VplwAiGr0UxrFDBQC+NUT2CaR0uz2O1DSmdp/LktZqQRiMwy1hzn20pdATxEtkJM7aQM94tUFkhjzPMWZ3gxxmBmZKKGjURyHVXuugCxUsDq3KMfbZ134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrLDZe8x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrLDZe8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770173335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0s+ljzADYqZ6gkuVAKvW1TicaqOE9SFoQPBPuPZPUg=;
	b=JrLDZe8xGzGOGfcdKinyuQk8J0m0l0aSYF1HOkCjV/yOau/u4h8bTZ8AHxHW9nWXCkRDSZ
	ids4yO0XQigd7oC5J+xaJIU557bOohQkBHLXkKp11xA4sYIoZxJLBZ4YYdlxUKfOZROzWa
	Z51XVNsfXQKVbMMPEZvW1u7HrH7M8ec=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Bmmr4MSpN0K03NvQR0JVSg-1; Tue, 03 Feb 2026 21:48:51 -0500
X-MC-Unique: Bmmr4MSpN0K03NvQR0JVSg-1
X-Mimecast-MFC-AGG-ID: Bmmr4MSpN0K03NvQR0JVSg_1770173331
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so5719203a91.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 18:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770173331; x=1770778131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0s+ljzADYqZ6gkuVAKvW1TicaqOE9SFoQPBPuPZPUg=;
        b=TSNDB1iXxrWBetbBEy0M155CFcbFHKV5ZBMny0BND/KGOjayvviBWTlHx0vltZD9BT
         doVQPmwyX6f9tAbTtp2Nd3/Kvo5FcdS0d1tItUs8QKC+RaY2JdXIyBCPNgLUcJh1uzle
         Z0PL4zyxbUdbWzAd7vqA8jyzubhcLb+gkqgF3j3f8UKBdRv1tHRVlzgQXrlQH8c0doEN
         KGh0+LJo8UBUPOIZnBL+yt/bis4dHKAudqzW6X4zkc3PCv4JrR98GFQIvILspber88xS
         WHHQQKogO9PIrC/oECFhf5Do19ey04XIToPMQPmJh8DtYdD3D/kyIH85LZLtztR63QD5
         HwOw==
X-Forwarded-Encrypted: i=1; AJvYcCXUSKsYG7RlYIgG8rDA0JJn5iX9K3gBNHuMm/73hm9G8jCHDez/kANwuY7+dj5mO0givew8T157Qw1JgP2QAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJfr2BWozpx9xRL9DqP/o7q1FAn+TWXfqspMaXgqkJDKtAR/Qf
	h8HZZL/wD2em3ilNflmqqFOWjQ8M2eyzqIbr8mtKjQfcRpmfJuvrNX72vbci4l0nG6uMOBqz8X8
	4rAEhMv6SFzwM+F0cztb08b+J6VvoqO0OI2myC//gfBu3i0cvuKIYLWeP5KOXGJZaax6gBG+EWl
	d3XodU7jrhpWo7G5g9f2nGAS5p5HtRHHu/fr5e7NxWJXE=
X-Gm-Gg: AZuq6aKxO1SmRMvDgLGSUnohJOXcRDPE8boTK984pHyatL5p5aDiiK66sZYCpCrp2NE
	nsX9JUkIqWRsyvfQLLgZwUaLFK1x2Jprxp7Oy8Z78jTSAwYl5PCYiGNKpP0E7T590mKNAcHfrTL
	Or5ceXp6dDf1lQm3ToEbhZ3HPbewNSxlBbeb8NZFHBvrLvv0d6LbMVMU9kH8YRqLcWa5A=
X-Received: by 2002:a17:90b:1b41:b0:34a:a1dd:1f2a with SMTP id 98e67ed59e1d1-354871a9551mr1213279a91.20.1770173330696;
        Tue, 03 Feb 2026 18:48:50 -0800 (PST)
X-Received: by 2002:a17:90b:1b41:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-354871a9551mr1213247a91.20.1770173330233; Tue, 03 Feb 2026
 18:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-2-eperezma@redhat.com>
 <CACGkMEuDPgkEVzpu0c+oKvOqgaSR5=CnHMe9iZDi_PFQan0m6g@mail.gmail.com>
 <CAJaqyWf5sC38oT2ZkmfR_MkiYWjLsuyF4Z4opSmgS1nG8BZhgw@mail.gmail.com>
 <CACGkMEsr_cx-xR85wZ5c=QfegLfG5j0wHTjokEADpgn37gQRJQ@mail.gmail.com>
 <CAJaqyWcVdMc+xQ=oq4ipu_sGh4uMJGidC8CFYSaa+5ZcwiKZ7g@mail.gmail.com>
 <CACGkMEuNZzDVccF_yiinJowrfGgWRAR_-ZvOqNmFz=cLVKN-+w@mail.gmail.com> <CAJaqyWfpJxPYKtUcncpbEvn_wi-Rc3VRyLE5f=0Md9HAksr6Dg@mail.gmail.com>
In-Reply-To: <CAJaqyWfpJxPYKtUcncpbEvn_wi-Rc3VRyLE5f=0Md9HAksr6Dg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Feb 2026 10:48:39 +0800
X-Gm-Features: AZwV_Qju9nFavSk-YXrgxD_675qBq7ybi62LArLuTqY3dTKbX_ZdgOOY3qufQAg
Message-ID: <CACGkMEtBerHiU7EpjOqkJQxgCv2f3MsUURD6AF9663DELETsYQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 21djt04yup485Rz5w9BTr1jGO3LwS02f4-Yg957EQWc_1770173331
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 6:35=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Tue, Feb 3, 2026 at 5:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Fri, Jan 30, 2026 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Jan 30, 2026 at 3:18=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > The vduse_vdpa_set_vq_ready can be called in the lifetime of =
the device
> > > > > > > well after initial setup, and the device can read it afterwar=
ds.
> > > > > > >
> > > > > > > Ensure that reads and writes to vq->ready are SMP safe so tha=
t the
> > > > > > > caller can trust that virtqueue kicks and calls behave as exp=
ected
> > > > > > > immediately after the operation returns.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 ++++++++++++++++++++=
+++-------
> > > > > > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index 73d1d517dc6c..a4963aaf9332 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct fi=
le *file, poll_table *wait)
> > > > > > >         return mask;
> > > > > > >  }
> > > > > > >
> > > > > > > +static bool vduse_vq_get_ready(const struct vduse_virtqueue =
*vq)
> > > > > > > +{
> > > > > > > +       /*
> > > > > > > +        * Paired with vduse_vq_set_ready smp_store, as the d=
river may modify
> > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > +        */
> > > > > > > +       return smp_load_acquire(&vq->ready);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void vduse_vq_set_ready(struct vduse_virtqueue *vq, b=
ool ready)
> > > > > > > +{
> > > > > > > +       /*
> > > > > > > +        * Paired with vduse_vq_get_ready smp_load, as the dr=
iver may modify
> > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > +        */
> > > > > > > +       smp_store_release(&vq->ready, ready);
> > > > > >
> > > > > > Assuming this is not used in the datapath, I wonder if we can s=
imply
> > > > > > use vq_lock mutex.
> > > > > >
> > > > >
> > > > > The function vduse_vq_set/get_ready are not in the datapath, but
> > > > > vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you want =
to
> > > > > switch to vq_mutex if you want though, maybe it's even comparable=
 with
> > > > > the cost of the ioctls or eventfd signaling.
> > > >
> > > > I'd like to use mutex for simplicity.
> > > >
> > >
> > > I cannot move it to a mutex, as we need to take it in the critical
> > > sections of the kick_lock and irq_lock spinlocks.
> > >
> > > I can move it to a spinlock, but it seems more complicated to me. We
> > > need to make sure we always take these kick_lock and irq_lock in the
> > > same order as the ready_lock, to not create deadlocks, and they alway=
s
> > > protect just the ready boolean. But sure, I'll send the spinlock
> > > version for V2.
> >
> > Thinking about this, I'm not sure I understand the issue.
> >
> > Maybe you can give me an example of the race.
> >
>
> It's the same issue as you describe with set_group_asid on cpu1 and
> dma_map and dma_unmap in cpu1 in this mail [0], but now the functions
> are set_vq_ready in the vdpa driver side and VDUSE_VQ_GET_INFO in the
> VDUSE instance.
>
> To me, the barriers should be in the driver and the VDUSE instance,
> and the VDUSE instance should use the VDUSE_SET_VQ_READY message to
> know when a VQ is ready. But I don't expect all the VDUSE instances to
> opt-in for that, so the flow without smp barriers is:
>
> [cpu0] .set_vq_ready(vq, true)
> [cpu1] VDUSE_VQ_GET_INFO(vq)
> [cpu1] check vq->ready, and it races with the set_vq_ready from cpu0.
>

Are there any side effects of this race? I meant the driver can do
set_vq_ready() at any time. And there would be message for notifying
the usersapce in this series.

> [0] https://patchew.org/linux/20251113115558.1277981-1-eperezma@redhat.co=
m/20251113115558.1277981-6-eperezma@redhat.com/#CACGkMEtMyte91bbdb0hfUo+YgS=
pZdjoWe0meKwbDc18CfWdATA@mail.gmail.com
>

Thanks

