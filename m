Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50031D137
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rj92dfP3"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66EE981DFA
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 15:16:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66EE981DFA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Rj92dfP3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djNTdcWNo3vl
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 15:16:38 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 83A2A81A4E
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 15:16:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83A2A81A4E
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f8faf57bso39027171fa.3
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 07:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702912596; x=1703517396; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY60PN5C+lwGGC6WWMv45aexAZDh9La78/eVT3cI7Yo=;
        b=Rj92dfP3vLc1S6LkIwGuZ55FyG5A5nlDOL03sGsVbiWYsfiXTIwQIZIjgnkNP47Yfe
         QfZMRhP/H6Yhy/u/3XXvHWoJvBDDfdeJ0mz2XFu15yTNFaciKgNIrN36fjAUMtO5HVpt
         mEjGlY7+/wHIqy5VarlXq8YFvWjoPpzM+ldrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912596; x=1703517396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY60PN5C+lwGGC6WWMv45aexAZDh9La78/eVT3cI7Yo=;
        b=OE6P25tXvA0I4xhAqnZBYSvSsVBoH+OYdb4aIjWGaSLOl2jNFHhJBugRwMfCRTEzOS
         tLgmC4w9ECEps4i7r3HHK5SjZxlrK1cCXXAnP1af0yrkeSIavKYkjw5bjjZBTZPcqn1M
         RdDs3GOg2vqsbPcS8Bi9vL9GXIk667fqSKFD2CfbQolZHliggHQlmYglj1+tvZtxtIlW
         GoqZGRHUxASp+061skDvVYIyCiBGLC0kHilUoAZyVYA8EuG+KwNfBqym99nmXUqkIAop
         eEfedh4fAtNIukeNGVqa/OPpO6GMH1e6vO6Gwnt0uZMQfplapMRbw9DL3EN/cQkXgLQ3
         6voA==
X-Gm-Message-State: AOJu0Yzy6kTyjlaB6uwpbP0Qq+414NpvLvwFTlNQdGlOOhztKchl2EJ/
	ULwFjXPfhgqCd/uzmehir/dsiDFgvQo4XS1A4ObT3A==
X-Google-Smtp-Source: AGHT+IGjJop7oEsSX/3Ak4U+fYL3wpoY4UCc7Na0tU4gVge+P2pqeifmcNy+8SAGPVeT1XXEXmz03GvHhC95mdyNcWo=
X-Received: by 2002:a2e:95d8:0:b0:2cc:67ad:4153 with SMTP id
 y24-20020a2e95d8000000b002cc67ad4153mr1326894ljh.25.1702912596293; Mon, 18
 Dec 2023 07:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231211114346.1132386-1-stevensd@google.com> <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
 <CAD=HUj7e9NaaYhos82JZoxhyX6J0bu+m0i7-_TqNbXiCDZ-Uxg@mail.gmail.com> <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com>
In-Reply-To: <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 18 Dec 2023 10:16:24 -0500
Message-ID: <CAD=HUj7h-cF929AbSL0bmZE7J=G1aQjZuYSgChPBkSGJ+wfoyQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_balloon: stay awake while adjusting balloon
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 6:37=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.12.23 05:13, David Stevens wrote:
> > On Wed, Dec 13, 2023 at 5:44=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 11.12.23 12:43, David Stevens wrote:
> >>> From: David Stevens <stevensd@chromium.org>
> >>>
> >>
> >> Hi David,
> >>
> >>> Add a wakeup event for when the balloon is inflating or deflating.
> >>> Userspace can enable this wakeup event to prevent the system from
> >>> suspending while the balloon is being adjusted. This allows
> >>> /sys/power/wakeup_count to be used without breaking virtio_balloon's
> >>> cooperative memory management.
> >>
> >> Can you add/share some more details
> >
> > I'm working on enabling support for Linux s2Idle in our Android
> > virtual machine, to restrict apps from running in the background
> > without holding an Android partial wakelock. With the patch I recently
> > sent out [1], since crosvm advertises native PCI power management for
> > virtio devices, the Android guest can properly enter s2idle, and it
> > can be woken up by incoming IO. However, one of the remaining problems
> > is that when the host needs to reclaim memory from the guest via the
> > virtio-balloon, there is nothing preventing the guest from entering
> > s2idle before the balloon driver finishes returning memory to the
> > host.
>
> Thanks for the information. So you also want to wakeup the VM when
> wanting to get more memory from the VM?
>
> Using which mechanism would that wakeup happen? Likely not the device
> itself?

The wakeup would happen via the parent device's interrupt. I've sent a
new version of this patch that uses the parent device's wakeup event
instead of adding a new one.

> >
> > One alternative to this approach would be to add a virtballoon_suspend
> > callback to abort suspend if the balloon is inflating/adjusting.
> > However, it seems cleaner to just prevent suspend in the first place.
>
> Also, the PM notifier could also be used with very high priority, so the
> device would respond early to PM_SUSPEND_PREPARE.

One drawback of blocking suspend via a PM notifier is that the
behavior isn't configurable by userspace, whereas wakeup events can be
enabled/disabled by userspace.

-David
