Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E443C140F
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031603; cv=none; b=Gf++ku1ze8JcjQ0zjFk/9pZW5F2XiOVEikMCVyDgrSZ5xrV9W6GMpr4qE6Hi6KO4HWHXVTnsvNuhRKrWWo57nr7m71128LWaYCqvJTI/cSqmtu5sv/mcNYy8OOkpTEXbNRw0LIEIX+LANZvqVJnc4Wd7CBd9pE4eDlFf1auAyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031603; c=relaxed/simple;
	bh=If0RLOUujKflD4TPO0bHjoQNMG3OOqX05cTdyJQ9Rpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O2iuAC4EqFWOFOwROCaZKdHcugnsAqp6tYkwJIqruH4xLevCQAozD5heAw8EhNXllWDfvc/W2O+f0RUCk4CSaWmulFvsgjiRecUQ1ya4McwNqtl72mRuZ38IJmY5TrioZ2ke9vpxNC3AUqBVHN7qDtyFThtXFSEB1e/l98A1Gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqTOmnJJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqTOmnJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783031599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi2bHpQyTkwt4bKDBeuu8K7oiC/67dbnM3I033MQlI0=;
	b=CqTOmnJJl3c3z26JZOXsq9Dfu8YGRahOBVyPZjnlMgjdMPqwWWOMJgSrMFXNdCCvD+NSe9
	SWjYlbQqRKvZGRDXVhkAFsAv2QfBwcYeL5L9puf/4YazHkigeGR2i792f8ASTbfzF1DCu3
	1myIhYgM5NBbE70q+SGc5ARuWYh02DY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ppqdXNQcM2OkBUXNd5dIPg-1; Thu, 02 Jul 2026 18:33:18 -0400
X-MC-Unique: ppqdXNQcM2OkBUXNd5dIPg-1
X-Mimecast-MFC-AGG-ID: ppqdXNQcM2OkBUXNd5dIPg_1783031597
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-475de65009dso1883862f8f.0
        for <virtualization@lists.linux.dev>; Thu, 02 Jul 2026 15:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783031597; x=1783636397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pi2bHpQyTkwt4bKDBeuu8K7oiC/67dbnM3I033MQlI0=;
        b=Hpk0vvEpOGVF/M37ck1mxmmg6TDfJUjNowlUdxaUQTJ6/cUdg0ZvzAe5pByoMrolFa
         3F9mFrd00EoZFG44vCgT1v9voebjhY8wMVwpRXELFNSCfqDSedByi79OnYTFP8LE0fp9
         IO1CFGC4u97HUYXANEHiu4vhFiY9DJamkDyELBlIZA8yUPQydJx8UUcf//lr5HSvQdVg
         UXz/rVmULOf7AfKjOMOkhx+E9DqtP+W7jyN48oudXPFAW+gHAsdk9ROPJB6GZAf+yaFC
         Q/peW/4Jm6shDRX+iTQG2/HzaMUoY1baMztnfPrUIHKQsiMzkFkw41B/RxNmExU3NPWS
         TnzA==
X-Forwarded-Encrypted: i=1; AHgh+RqX2wg/V1dhWI1hF5VDOwkp5yTEaRg3c6PgtS2fdNTE6ZYidgmgdt0GKvGaCozql8FIfxAxw+ONUsDXAX7t/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq5umEndG8uvKpyVHCYpSrOnbxOC/n0J7ip9X4opGoQy/ZfJcu
	vpFro2RWhR81qwd7adaueKO35mTEj3ZnX0sXrsP6up1cOa9bK+kZOpLwS2c7QiLUejhvOqoeZ7t
	JVUZ/nVhA2OO514ifZpJwzHoKTNe3yTFobwL4H7LVuGUDm2S+C1IuuXjXz6NKCBlHeFuT
X-Gm-Gg: AfdE7cmV4YNg4mVhE5kdHP6taGflzEtjbO2bcYW+kcMhcp/UQNhPbWt7UleGIePV5NQ
	oDbeFjhYszEeDOGrvvVBGMtPB2vreW0ufUyHi7Mk+jqVh7ZbugZESMxgy58KbDWdrxioLQW3muC
	0c4GKfypyP8sp5LuDoW0eXBWWgOplR7mHuB2DNTPyShZG3Cm4CtQcFbgjLzjBXIUEjwCuLBOD8X
	cqiCArKMAdEi2IQdqyZ4ZEvfEp27uRqJjZVpH47WwAx6USBl2bwB4Q3GyQcJxlCcwrgZdokcsm0
	vCRtKXd6iXlvfp7aaYG7lteBzdbl80KpT6gffja9FYfeLCo252y4ILuHNnxXnJKi7SuYqVHQtHx
	x8YAnQC/Z2QD5+ogtOnIr1mAWxzqpPHJ+
X-Received: by 2002:a05:6000:25ef:b0:474:fd7a:93f2 with SMTP id ffacd0b85a97d-477b39830c4mr10801339f8f.15.1783031596848;
        Thu, 02 Jul 2026 15:33:16 -0700 (PDT)
X-Received: by 2002:a05:6000:25ef:b0:474:fd7a:93f2 with SMTP id ffacd0b85a97d-477b39830c4mr10801298f8f.15.1783031596202;
        Thu, 02 Jul 2026 15:33:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm14683979f8f.32.2026.07.02.15.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:33:15 -0700 (PDT)
Date: Thu, 2 Jul 2026 18:33:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] virtio_balloon: quiesce balloon work on device
 shutdown
Message-ID: <20260702183236-mutt-send-email-mst@kernel.org>
References: <20260624140846.2616797-1-den@openvz.org>
 <c18ed056-72f3-4eab-a370-c02b735e536e@virtuozzo.com>
 <00ebb86d-f7b8-4ddc-a17c-c4700cab73a9@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <00ebb86d-f7b8-4ddc-a17c-c4700cab73a9@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 01gyEOVh9JW-3ZDrCwuqmjhAg7X7ETD_z5x5gSBuzmI_1783031597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2026 at 09:30:26PM +0200, David Hildenbrand (Arm) wrote:
> On 7/2/26 19:50, Denis V. Lunev wrote:
> > On 6/24/26 16:08, Denis V. Lunev wrote:
> >> This email originated from an IP that might not be authorized by the domain it was sent from.
> >> Do not click links or open attachments unless it is an email you expected to receive.
> >> Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
> >> device_shutdown()") the virtio bus breaks and resets every virtio device
> >> during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
> >> .shutdown of its own, so that generic path runs while the balloon's
> >> asynchronous work is still armed: the free page reporting worker, the
> >> inflate/deflate and stats workers, the OOM notifier and the free page
> >> shrinker.
> >>
> >> Once the device has been broken, virtqueue_add_inbuf() in
> >> virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
> >> On a kernel booted with panic_on_warn that turns an ordinary reboot into a
> >> fatal panic in the middle of device_shutdown(), so the machine never
> >> reaches the new kernel. The inflate/deflate and OOM paths do not warn but
> >> are no better off: they call wait_event(vb->acked, ...) and would block
> >> forever on a queue that can no longer complete.
> >>
> >> This was hit in the field as an intermittent failure of a virtualization
> >> cluster upgrade: guest storage nodes were rebooted via kexec into the new
> >> kernel, and the ones whose free page reporting happened to run during
> >> device_shutdown() panicked (the guests run with panic_on_warn) and never
> >> came back, stalling the rolling upgrade. The crash dump showed the WARN at
> >> virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
> >> virtqueues already broken.
> >>
> >> Validated by churning balloon inflate/deflate from the host while
> >> kexec-rebooting the guest in a loop under panic_on_warn: the unpatched
> >> kernel reproduces the WARN within a couple of cycles, while the patched
> >> kernel survives many consecutive kexec cycles cleanly (12/12 in the final
> >> run, 0 WARNs). checkpatch is clean across the series.
> >>
> >> Changes in v2:
> >> - Add a virtio_device_shutdown() core helper and call it from the balloon
> >>   .shutdown handler instead of open-coding break + synchronize_cbs + reset
> >>   (David Hildenbrand).
> >> - New patch: make tell_host() warn and bail instead of hanging if a buffer
> >>   add ever fails (David Hildenbrand); kept as a separate patch
> >>   (Michael S. Tsirkin).
> >>
> >> v1: https://lore.kernel.org/all/20260622133715.3707707-1-den@openvz.org
> >>
> >> Denis V. Lunev (4):
> >>   virtio: add virtio_device_shutdown() helper
> >>   virtio_balloon: factor out virtballoon_quiesce()
> >>   virtio_balloon: quiesce balloon work before device shutdown
> >>   virtio_balloon: warn on failed buffer add in tell_host()
> >>
> >>  drivers/virtio/virtio.c         | 41 ++++++++++++++++++++++-----------
> >>  drivers/virtio/virtio_balloon.c | 40 ++++++++++++++++++++++++--------
> >>  include/linux/virtio.h          |  1 +
> >>  3 files changed, 59 insertions(+), 23 deletions(-)
> >>
> > Hi, David!
> 
> Hi! :)
> 
> > 
> > Is this good to go in? I have not seen the confirmation that the
> > series is taken into your tree.
> 
> I don't have a tree (yet), and once I have one it will likely be more mm focused :)
> 
> @MST, I think this is good to go!
> 
> -- 
> Cheers,
> 
> David

Indeed, it's just a bugfix and I'm trying to get features into qemu
now before their freeze. I'll work on linux end of next week.

