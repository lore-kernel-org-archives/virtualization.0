Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D9346E74
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975044; cv=none; b=qfnJLGClqfViC2DpIIhNcHDeaw0yMzDWBqR/UmL6ll85VoicxBWRJbFOMQM7O8cfHWlDCbe6PEbnBOMATRvJNbRB/AK2Kug2odZRixGwMq1QuCgQlJiCf2BYTJ7rOE2DdPO9IYICN85BvFoeK+oUz0vz4J2hI6PEKkvyYUqPC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975044; c=relaxed/simple;
	bh=oUwoqKe1I/6hnoW/yPmZKqCl+Dd44tauTgfIsfpIof0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fj28ZCD/s9JoaH5L2UCshWF+gyrgezcALIcANQ26T6AYxE/r7FWq/680sd4q5EMk8y35ClhjnfAc70m4Pw26ep/RGXU3C1K68wzvPWp7e7mj/NRs2FaTh8LrnjKcZJFVRxRrb1ORmiO/4XtxypFnulfdbmQBbbaWP2eKLXbhGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNL1Ft+M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNL1Ft+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783975041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93agWWxYqJptOVx1oz7T8JnMRAoNjNWehGTGOvfl/80=;
	b=TNL1Ft+Mv6FwthyKauG6hi46cr1Wi6bjgD2/RcFVj4dYvx0pAaN7Ngm6Yv6i5PrsT12Xoa
	TSlnv8KaESl4AqYTdenxON+nSeEvz3PVVtOhquTynbVx1Ntl5LiseOISwbqvCqDc0KsoFD
	ccmfaaR1TJnMCYfDshqyPqlTmGeIFfU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-U40Gi_xdMBKLmTUU2i6OGA-1; Mon, 13 Jul 2026 16:37:20 -0400
X-MC-Unique: U40Gi_xdMBKLmTUU2i6OGA-1
X-Mimecast-MFC-AGG-ID: U40Gi_xdMBKLmTUU2i6OGA_1783975039
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so2132964f8f.0
        for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 13:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783975039; x=1784579839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=93agWWxYqJptOVx1oz7T8JnMRAoNjNWehGTGOvfl/80=;
        b=dAhowZ/p4kOeRna/Ctlpq5DCIpqrbs0KybzwTD0kHqSWT6IyTs5MiVkbqL9Yy/riWv
         Svw2kgeaTb7o0w+7lqs9XNOzt5tfImTgUFiKhpThtmiIyYC5LCC3yyCvnCAiMqfw5dAR
         A5rCvhJPkv+blqVxiObZoEyxYCvJweWA/7AMI6vI5l8ux4mlsh350RDG6v8HXCqMTCqp
         YAA08aZhso0t1MAvAYHeSbPQ+BpWwu0q0JK8gliCETxKyl6DTTdZaJhNwIkQhCVz3tq0
         8+/fwy6MIWLkGlwZ65yM8IHeoONU7fqywwMLvK42QMvdyd3S0/ZAT8PnFeoSbPM0guTF
         Bzsw==
X-Forwarded-Encrypted: i=1; AHgh+RowPXPQ1X6EoHUzTZhM3PVdyLdzEG9y70dOAbMR+EgB+RzYPS52zIdJPnN0PsKqYSKb3oKUlINfBOqIvwAbTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyid12idn1vMshbISRAEqxpiUTdUVuo82K9vpUjZagJN9HxkRnN
	ULQDKacKkj5biTxGEzZM8JjyfemlJCJI9zc8S9o7STUYRWXYJ36Y3zIiCHO49f33DQv4dHhaxG6
	FtPB3OsiGj3z7nZbPK7uztYFfxD1XV25fOytC1K+tX2aPRGzLXCuT9sUBFncju0LpFyEN7C283m
	A1pVuLZg==
X-Gm-Gg: AfdE7clV53InzvZBNKNvia/9+SGs4W87qpK8hgRsFmY/bayTrXzc+ynhlkdsh8CWA+y
	dl6OVrb/a7ZPpcSDZCtFU/AAqW0Nvelp4SNP/scrMFimJQmXHTBJOQf2ox0N+4YivyLQoMwq0+G
	yB0bLTD6lE/+pCQTaMoDVJO3z/TuSxgxKxiE3WkTUrwN+BNnIHSV5DZR592q4HzBvcSJzkvRjI9
	xM7bD8rHgjxy8FpQ0De3hH7v7NoAQAxaHmdyjsRDlAraWCkWV1NQh+vWnak/vt+qE+OhBw3K+sM
	tgJgF5ZFNZmVsOSNerNwvhwUyJ6OWFd6rvdGS0brdsZjmDGGe5EzpFmP65teTlQlDCPKWP8QUim
	/G0vH3rn1af6KAOvqEis6xQPP24w0pBsgFG4=
X-Received: by 2002:a05:6000:430a:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47f2dca8a2amr12617047f8f.2.1783975039024;
        Mon, 13 Jul 2026 13:37:19 -0700 (PDT)
X-Received: by 2002:a05:6000:430a:b0:475:94e1:29d2 with SMTP id ffacd0b85a97d-47f2dca8a2amr12617028f8f.2.1783975038543;
        Mon, 13 Jul 2026 13:37:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9884sm2463389f8f.23.2026.07.13.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:37:18 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:37:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Denis V. Lunev" <den@openvz.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] virtio_balloon: quiesce balloon work on device
 shutdown
Message-ID: <20260713163611-mutt-send-email-mst@kernel.org>
References: <20260624140846.2616797-1-den@openvz.org>
 <c18ed056-72f3-4eab-a370-c02b735e536e@virtuozzo.com>
 <00ebb86d-f7b8-4ddc-a17c-c4700cab73a9@kernel.org>
 <20260702183236-mutt-send-email-mst@kernel.org>
 <6697d41e-a2fd-4207-982d-999cafd3cd56@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6697d41e-a2fd-4207-982d-999cafd3cd56@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iLRIzd5bOblCHAyrqPrhzPUkOhgpoR95Uz7kgme_6_Y_1783975039
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 13, 2026 at 10:32:29PM +0200, Denis V. Lunev wrote:
> On 7/3/26 00:33, Michael S. Tsirkin wrote:
> > On Thu, Jul 02, 2026 at 09:30:26PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/2/26 19:50, Denis V. Lunev wrote:
> >>> On 6/24/26 16:08, Denis V. Lunev wrote:
> >>>> This email originated from an IP that might not be authorized by the domain it was sent from.
> >>>> Do not click links or open attachments unless it is an email you expected to receive.
> >>>> Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
> >>>> device_shutdown()") the virtio bus breaks and resets every virtio device
> >>>> during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
> >>>> .shutdown of its own, so that generic path runs while the balloon's
> >>>> asynchronous work is still armed: the free page reporting worker, the
> >>>> inflate/deflate and stats workers, the OOM notifier and the free page
> >>>> shrinker.
> >>>>
> >>>> Once the device has been broken, virtqueue_add_inbuf() in
> >>>> virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
> >>>> On a kernel booted with panic_on_warn that turns an ordinary reboot into a
> >>>> fatal panic in the middle of device_shutdown(), so the machine never
> >>>> reaches the new kernel. The inflate/deflate and OOM paths do not warn but
> >>>> are no better off: they call wait_event(vb->acked, ...) and would block
> >>>> forever on a queue that can no longer complete.
> >>>>
> >>>> This was hit in the field as an intermittent failure of a virtualization
> >>>> cluster upgrade: guest storage nodes were rebooted via kexec into the new
> >>>> kernel, and the ones whose free page reporting happened to run during
> >>>> device_shutdown() panicked (the guests run with panic_on_warn) and never
> >>>> came back, stalling the rolling upgrade. The crash dump showed the WARN at
> >>>> virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
> >>>> virtqueues already broken.
> >>>>
> >>>> Validated by churning balloon inflate/deflate from the host while
> >>>> kexec-rebooting the guest in a loop under panic_on_warn: the unpatched
> >>>> kernel reproduces the WARN within a couple of cycles, while the patched
> >>>> kernel survives many consecutive kexec cycles cleanly (12/12 in the final
> >>>> run, 0 WARNs). checkpatch is clean across the series.
> >>>>
> >>>> Changes in v2:
> >>>> - Add a virtio_device_shutdown() core helper and call it from the balloon
> >>>>   .shutdown handler instead of open-coding break + synchronize_cbs + reset
> >>>>   (David Hildenbrand).
> >>>> - New patch: make tell_host() warn and bail instead of hanging if a buffer
> >>>>   add ever fails (David Hildenbrand); kept as a separate patch
> >>>>   (Michael S. Tsirkin).
> >>>>
> >>>> v1: https://lore.kernel.org/all/20260622133715.3707707-1-den@openvz.org
> >>>>
> >>>> Denis V. Lunev (4):
> >>>>   virtio: add virtio_device_shutdown() helper
> >>>>   virtio_balloon: factor out virtballoon_quiesce()
> >>>>   virtio_balloon: quiesce balloon work before device shutdown
> >>>>   virtio_balloon: warn on failed buffer add in tell_host()
> >>>>
> >>>>  drivers/virtio/virtio.c         | 41 ++++++++++++++++++++++-----------
> >>>>  drivers/virtio/virtio_balloon.c | 40 ++++++++++++++++++++++++--------
> >>>>  include/linux/virtio.h          |  1 +
> >>>>  3 files changed, 59 insertions(+), 23 deletions(-)
> >>>>
> >>> Hi, David!
> >> Hi! :)
> >>
> >>> Is this good to go in? I have not seen the confirmation that the
> >>> series is taken into your tree.
> >> I don't have a tree (yet), and once I have one it will likely be more mm focused :)
> >>
> >> @MST, I think this is good to go!
> >>
> >> -- 
> >> Cheers,
> >>
> >> David
> > Indeed, it's just a bugfix and I'm trying to get features into qemu
> > now before their freeze. I'll work on linux end of next week.
> >
> Hi, Michael!
> 
> Have you had a chance to take series into your tree, i.e.
> should I continue to track this submission?
> 
> Thank you in advance,
>     Den

Hi!
It's on my queue and will be in the next Linux release, don't worry.

-- 
MST

