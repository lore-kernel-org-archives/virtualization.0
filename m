Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE81339B0
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939613; cv=none; b=DP3XYOuI9UbbcU+ArA3N3jUjNIEa4lMdNkcSTgOPtO/wjqZf6wa6skG7ZcWDlRjCiDn7hxQffLKt/R85Jbx6vue1FmhOx/pHhriO/8hBGqn9NA9moKTrmIAxTZJ1L1wrX+DrthcOOmnLUJEhDXFa4s+dQbnwWvtASdTOyrnqzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939613; c=relaxed/simple;
	bh=Nh/RPEGQMLbipsQ873OI9l7WmsakJphI8B81DlzeqAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ph09zYsh87CqTs3qumFuml+u8TEZd5gXgVTXBAh2esa2K784/svFVkwbMP55sMT59f317jVT6if4XCt0weVL951S0xeY7kt1OSgVy0M/Z8mCzgyLQqnAeuZcCJUCoOkQmq9uZlZYxZnNb61/7LI98W5bCzwlWtE+EzYUr+DhE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT3tkeG+; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT3tkeG+"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8B6C60819
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 19:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uwjgs1UkqI6c
	for <virtualization@lists.linux-foundation.org>;
	Wed, 14 Feb 2024 19:40:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 20B8F60816
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20B8F60816
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AT3tkeG+
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 20B8F60816
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707939609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40AE8jzoctMs/4UQVB3kZWi/SrcTMf7FmeAg9I90IS4=;
	b=AT3tkeG+jjFPvc8dernrQwOXbnwzl4BQTMhFQpwqM3tsi4fq/03/KGE+KjHvIn3pzs7fhh
	HOHNw4NaAoWoDSC1sT+ekcBY+ZAp9ekwrS2p/pcWb6qWodcXBTiaXWlfXcLZpsf6wQN8Nz
	rW8k1vYcdduQBh04sW/e7fM9mNJ0KpA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-d-EfapeWPtWYAG2fq70EYQ-1; Wed, 14 Feb 2024 14:40:08 -0500
X-MC-Unique: d-EfapeWPtWYAG2fq70EYQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc3645a6790so96831276.0
        for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 11:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939607; x=1708544407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40AE8jzoctMs/4UQVB3kZWi/SrcTMf7FmeAg9I90IS4=;
        b=NxQZ8CaedpVHiBiTTx2C6V+Z+6o78B3k8MOWfRQM3byeAnhWG8RE/GZNmKAeLeb6g+
         X9UWABgKSHxIAl5VFpnRem7QJmFK9kJMk8lElziDwGmmxYsglD11itc6WKaIikz7mFGh
         t3Ld2ddzF5JN5GLzZe8OeFjwddsUJIa+PXiQqeV8sNAdZ2cWjOeM71CRGWS6lzazu/W9
         TlXj2FPG2Pym3j5Cs4Ji8QjEYgAg9vmHOxQ810tEEiED/bNK+RBBnu+q8sJxlvheS/eK
         4cHz+/G+Cz4JRGFRFlPjmyoLNjN8zmtKLN6SHR9qAZ9R96x4Cf6pof5wQK9cVx/qEE0v
         HTsQ==
X-Gm-Message-State: AOJu0Yzsdb91Hg1aA+pBRUGVR2cDBerIjm7Z0QWRbr1cSORKJCoQLp6c
	/lCrFMilgbfEoHRM+0q8paI6t3pmfB3SI7B3o+WUEOkLvj6ZHZKEBGzKQbjHRAucDVDY2kKD0lA
	cjAHu5vzrit+G5kgqIMAxuG4GBw0EEWkR0saDx6+5h9t8JexEBpTJ2D/9qQ11Jm76JvS/kFTXLv
	mFdspRXOGAbf70LwklBGbzRbknQeNngP2bP1SMjOA7uYTxIZNHZQKjRg==
X-Received: by 2002:a25:8391:0:b0:dcd:59e4:620c with SMTP id t17-20020a258391000000b00dcd59e4620cmr3543768ybk.49.1707939607710;
        Wed, 14 Feb 2024 11:40:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfRe7gS1Br3szsmeSRIaV1Vjr5iFP1u6aZ0i0V5KCMfqQ0Ntu2jtH9k8bI7ZqOnZmqvInJwB/MFN0YZ80FzeY=
X-Received: by 2002:a25:8391:0:b0:dcd:59e4:620c with SMTP id
 t17-20020a258391000000b00dcd59e4620cmr3543755ybk.49.1707939607473; Wed, 14
 Feb 2024 11:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
 <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com> <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com>
In-Reply-To: <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 14 Feb 2024 20:39:31 +0100
Message-ID: <CAJaqyWe1=eQ4eQyv+wOqbr3pfZst6gmss2SrDZSNkY_ZVXcf=Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 6:50=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 2/13/2024 11:10 AM, Eugenio Perez Martin wrote:
> > On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> Flush to guarantee no workers are running when suspend returns.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim.c
> >> index be2925d0d283..a662b90357c3 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vd=
pasim *vdpasim,
> >>         kthread_flush_work(work);
> >>  }
> >>
> >> +static void flush_work_fn(struct kthread_work *work) {}
> >> +
> >> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
> >> +{
> >> +       struct kthread_work work;
> >> +
> >> +       kthread_init_work(&work, flush_work_fn);
> >
> > If the work is already queued, doesn't it break the linked list
> > because of the memset in kthread_init_work?
>
> work is a local variable.  It completes before vdpasim_flush_work returns=
,
> thus is never already queued on entry to vdpasim_flush_work.
> Am I missing your point?
>

No, sorry, I was the one missing that. Thanks for explaining it :)!

I'm not so used to the kthread queue, but why not calling
kthread_flush_work on vdpasim->work directly?

> >> +       kthread_queue_work(vdpasim->worker, &work);
> >> +       kthread_flush_work(&work);
> >> +}
> >> +
> >>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >>  {
> >>         return container_of(vdpa, struct vdpasim, vdpa);
> >> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdp=
a)
> >>         vdpasim->running =3D false;
> >>         mutex_unlock(&vdpasim->mutex);
> >>
> >> +       vdpasim_flush_work(vdpasim);
> >
> > Do we need to protect the case where vdpasim_kick_vq and
> > vdpasim_suspend are called "at the same time"? Correct userland should
> > not be doing it but buggy or mailious could be. Just calling
> > vdpasim_flush_work with the mutex acquired would solve the issue,
> > doesn't it?
>
> Good catch.  I need to serialize access to vdpasim->running plus the work=
er queue
> in these two functions.  vdpasim_kick_vq currently takes no locks. In cas=
e it is called
> from non-task contexts, I should define a new spinlock to be acquired in =
both functions.
>
> - Steve
>

