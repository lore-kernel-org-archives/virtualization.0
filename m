Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2707129A99
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426296; cv=none; b=kUMp7giy2Mdt5J58Wr1N4B/35oYFnWthwn3zFjGs0OrO8ENC0ew7H+iuqxHR0gjkQzYEPX7LD3X0JCxfTFZncUIUgmEaULGU0H8V6v5FRySq6hUEWmy+TKMaC2TDJHgyvUEZo1DXlG5rHETkoXND1o0n8El93gyxS1R24Fb4xyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426296; c=relaxed/simple;
	bh=BaNIUMYLUfYIAxF8Bo7Ytv4+BqNGV2rWnneTGhHa1PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWwQxgA4/yEr7rf+sbS2IafJIRhW2WegKg8/c/oiccuw4ompRnMEaL4QomMPr+OVin6aK2IFqd8c0jHAiWIJekfwVR++57mVg138xrGLBUPHEfsa2q3H4IdkL/gEPJbvQ8pdEqTYImokSaPnbp/9B7/Y8V+FsAOWloYPM3Vy2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E998erZR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E998erZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711426293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQsyVicGgRcIN44As4bUegtDIQaw+ubTJUdf1CG0g5E=;
	b=E998erZR3RUMQhFGLsTlyZhcnlCCnFt63Xh0xzTwtarzswi/UpZrvtoQckMvhbLnPUoFTU
	IWM+QR8R/RJIi1xsLBL6xtHXnYn0QsARju8JWBoF/i//P1I42a4aqEFBu/QMmFhJyq8Q09
	OXL/VvYyC/Jjh2E6AcA9qFB76DT7Tmo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-nTYRd4k4M0q1nXxP721RSw-1; Tue, 26 Mar 2024 00:11:28 -0400
X-MC-Unique: nTYRd4k4M0q1nXxP721RSw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so3557100a12.3
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 21:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426287; x=1712031087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQsyVicGgRcIN44As4bUegtDIQaw+ubTJUdf1CG0g5E=;
        b=I8+hriP2wCLB0rky+NgDRGZfDtqZYzYRBHoPMuvpjAwdi3aFnVXcz93gCBKI5MO9gh
         YhoQBLF8t56OTEcVjIj2qhGJcFX6P9Rzl7tom5lwg02tvBIxx8m1JIKKY0FKxD39Bbqh
         HpK/05ohKFrQ5F3Ko4O6OnIy7M181EGYCNNzPHY5sx/gpLQOYxkk4sg/9OteI1p765OG
         04BhBGsPTyR9pDHwgVpu7QA6NDr2iPg4y/89X7ExO4a33ZFjQh1uXIqUsDVMu3xFJgqp
         qNvaqHMG0e099mB/oxZg66kOcUCoqLDv5/OW+nHHDnPIFb3oiuu0UidUbAKLSBtvU84H
         JGHg==
X-Forwarded-Encrypted: i=1; AJvYcCVHe+qjvrM7/nHn4Uveya6+lIg/VtJ0J9t6fOomUKgxTqutN2+65I6GkGIG2EIF6AfZHZyyogyULieZUXljNROSHvilF0YwQQVEVecvxDs=
X-Gm-Message-State: AOJu0YxUkFhLbcI7dyV+W11fL5mbmnNOfh6gYii6Nh2SUr/M/8zmgmZ6
	xfWKB9pWP1I/k+LOl/I8wOOjKAFm/jDjO82Xfu6XDG9vcfj0GlkPLAwSLVpjL+RIjwqyxlENlTY
	j1TsgqiHlwbqv5A4wafpjHDP0Wx80fEdTJVmy2CIdu+KTts1dhS0AkkH/kzhbSgXTZo2fPy6SwV
	lkFb4dwhxdqNZBABcm4B53IBCZFhQmdkODKlAE35Y=
X-Received: by 2002:a05:6a20:258c:b0:1a3:c38d:3faa with SMTP id k12-20020a056a20258c00b001a3c38d3faamr5648379pzd.42.1711426286920;
        Mon, 25 Mar 2024 21:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiRyQj7rPG1kUKPZ23XZNSein3zhu5gMpJRn7QAtQMWCO9dHpV877gL0Y33Jgc90wBoRXEcgX2bRa4NFcju8o=
X-Received: by 2002:a05:6a20:258c:b0:1a3:c38d:3faa with SMTP id
 k12-20020a056a20258c00b001a3c38d3faamr5648365pzd.42.1711426286588; Mon, 25
 Mar 2024 21:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com> <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
 <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com> <1711346901.0977402-2-xuanzhuo@linux.alibaba.com>
 <87zfum7ii8.fsf@redhat.com>
In-Reply-To: <87zfum7ii8.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:11:15 +0800
Message-ID: <CACGkMEv0g9CJmZzO4bH2BjcL5Wc0NxE6+zQ2Wgg=3v2AqR=XQA@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, 
	Daniel Verkamp <dverkamp@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:44=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> w=
rote:
>
> On Mon, Mar 25 2024, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > On Fri, 22 Mar 2024 22:02:27 +0100, David Hildenbrand <david@redhat.com=
> wrote:
> >> On 22.03.24 20:16, Daniel Verkamp wrote:
> >> > On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> >> >>
> >> >> Currently, the init_vqs function within the virtio_balloon driver r=
elies
> >> >> on the condition that certain names array entries are null in order=
 to
> >> >> skip the initialization of some virtual queues (vqs). This behavior=
 is
> >> >> unique to this part of the codebase. In an upcoming commit, we plan=
 to
> >> >> eliminate this dependency by removing the function entirely. Theref=
ore,
> >> >> with this change, we are ensuring that the virtio_balloon no longer
> >> >> depends on the aforementioned function.
> >> >
> >> > This is a behavior change, and I believe means that the driver no
> >> > longer follows the spec [1].
> >> >
> >> > For example, the spec says that virtqueue 4 is reporting_vq, and
> >> > reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
> >> > but there is no mention of its virtqueue number changing if other
> >> > features are not set. If a device/driver combination negotiates
> >> > VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
> >> > VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
> >> > that reporting_vq should still be vq number 4, and vq 2 and 3 should
> >> > be unused. This patch would make the reporting_vq use vq 2 instead i=
n
> >> > this case.
> >> >
> >> > If the new behavior is truly intended, then the spec does not match
> >> > reality, and it would need to be changed first (IMO); however,
> >> > changing the spec would mean that any devices implemented correctly
> >> > per the previous spec would now be wrong, so some kind of mechanism
> >> > for detecting the new behavior would be warranted, e.g. a new
> >> > non-device-specific virtio feature flag.
> >> >
> >> > I have brought this up previously on the virtio-comment list [2], bu=
t
> >> > it did not receive any satisfying answers at that time.
>
> I had missed it back then, but now that I read it, I realize that we
> really have a bit of a mess here :/
>
> >>
> >> Rings a bell, but staring at this patch, I thought that there would be
> >> no behavioral change. Maybe I missed it :/
> >>
> >> I stared at virtio_ccw_find_vqs(), and it contains:
> >>
> >>      for (i =3D 0; i < nvqs; ++i) {
> >>              if (!names[i]) {
> >>                      vqs[i] =3D NULL;
> >>                      continue;
> >>              }
> >>
> >>              vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callbac=
ks[i],
> >>                                           names[i], ctx ? ctx[i] : fal=
se,
> >>                                           ccw);
> >>              if (IS_ERR(vqs[i])) {
> >>                      ret =3D PTR_ERR(vqs[i]);
> >>                      vqs[i] =3D NULL;
> >>                      goto out;
> >>              }
> >>      }
> >>
> >> We increment queue_idx only if an entry was not NULL. SO I thought no
> >> behavioral change? (at least on s390x :) )
>
> The code for pci behaves in the same way.
>
> >>
> >> It's late here in Germany, so maybe I'm missing something.
> >
> > I think we've encountered a tricky issue. Currently, all transports han=
dle queue
> > id by incrementing them in order, without skipping any queue id. So, I'=
m quite
> > surprised that my changes would affect the spec. The fact that the
> > 'names' value is null is just a small trick in the Linux kernel impleme=
ntation
> > and should not have an impact on the queue id.
> >
> > I believe that my recent modification will not affect the spec. So, let=
's
> > consider the issues with this patch set separately for now. Regarding t=
he Memory
> > Balloon Device, it has been operational for many years, and perhaps we =
should
> > add to the spec that if a certain vq does not exist, then subsequent vq=
s will
> > take over its id.
>
> The changes here do not really seem to affect the spec issue that Daniel
> had noted, unless I'm reading the code wrong.

Spec seems to be wrong here:

5.5.2 Virtqueues

0 inflateq 1 deflateq 2 statsq 3 free_page_vq4 r eporting_vq

And this is the Qemu implementation:

5.5.2 Virtqueues

    s->ivq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
    s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
    s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);

    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_HIN=
T)) {
        s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                           virtio_balloon_handle_free_page_=
vq);
        precopy_add_notifier(&s->free_page_hint_notify);

        object_ref(OBJECT(s->iothread));
        s->free_page_bh =3D
aio_bh_new_guarded(iothread_get_aio_context(s->iothread),

virtio_ballloon_get_free_page_hints, s,
                                             &dev->mem_reentrancy_guard);
    }

    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
        s->reporting_vq =3D virtio_add_queue(vdev, 32,
                                           virtio_balloon_handle_report);
    }

We need to fix it.

>
> However, we should try to address the spec mess, where we have at least
> some of the most popular/important implementations behaving differently
> than the spec describes... I would suggest to discuss that on the virtio
> lists -- but they are still dead, and at this point I'm just hoping
> they'll come back eventually :/
>

Thanks

