Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091083A1C7
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcuYLtrO"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 865E0410DC
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 15:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 865E0410DC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NcuYLtrO
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1cfxDQbM8rt
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 15:30:26 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D6FE408E5
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 15:30:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D6FE408E5
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50e30b28c1aso2097839e87.0
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702913424; x=1703518224; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG0K7UPoSMBYTVf/4BeN4sLj8j0yHDIwZIH4KmzwU1Y=;
        b=NcuYLtrODO6VMmUjZKaN34gSX1E9i2bCl/TvY8IHHD6rmM3kNGiuZAqeVa2pwKH9Z7
         mUvtk+6CJiizoAW67GX/Hei6/JNa9dTmzX/XE6Wruw2bj4whOcnuy3+W8xN1En74e3r2
         iazPfq/Qmv9a7SvE/yPvjSfnldf6U+7PtQ4F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913424; x=1703518224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG0K7UPoSMBYTVf/4BeN4sLj8j0yHDIwZIH4KmzwU1Y=;
        b=IFt7a+fN3TcIObIsdFASYH7WLKL6P/+WRsnwLe5zRqxG6HzYh6gMDcQexYlkTMnaVG
         IRkbC57Qf+/evZ7wT1Ibe0K1fgj9QAyxuywi+4lFuTByJKh4+mqC7/MCN/low+MtGydd
         i6Wk4kqm/fSsRrTtfn1x7NtKGWzjdn2BANhlT9e4hJxiS/MWaKXPn4PFF6C6ds56/QTt
         UaRP7hvW9y/pprnjGdQg3K9aWnt47mdR8XHwdArWI+Iw3X3jhz9s7+ueEu0CUgVB4rVJ
         zRZceBKmWGCNYlAC3PapF1/GIq+oZvU51Tr/2/qeQrq3D29gl+N1OZeQPTrOM+q1dwb+
         kbTg==
X-Gm-Message-State: AOJu0YywluiNaVzJC4xupVzhlCx228pHDpMqzjLNei0zi2CR63BhUHHv
	ClcJid4UCOnbmOEbkYqVsvlpFK5QMu6I5oIiblJbKA==
X-Google-Smtp-Source: AGHT+IG7ioPSvk7odK8dBT0pCW2tc41P9y6yj1h99EeW3lSZFG0Zdz4kd95MRNuNhrGzwwRGUp9I6GLj+Q74re80cLw=
X-Received: by 2002:a05:6512:3b87:b0:50e:2cbd:cc50 with SMTP id
 g7-20020a0565123b8700b0050e2cbdcc50mr2142056lfv.23.1702913424387; Mon, 18 Dec
 2023 07:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231211114346.1132386-1-stevensd@google.com> <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
 <CAD=HUj7e9NaaYhos82JZoxhyX6J0bu+m0i7-_TqNbXiCDZ-Uxg@mail.gmail.com>
 <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com> <CAD=HUj7h-cF929AbSL0bmZE7J=G1aQjZuYSgChPBkSGJ+wfoyQ@mail.gmail.com>
 <2b8f4855-98f4-4515-bd5f-f93983d45714@redhat.com>
In-Reply-To: <2b8f4855-98f4-4515-bd5f-f93983d45714@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 18 Dec 2023 10:30:13 -0500
Message-ID: <CAD=HUj5gZYBN=6Kk+jrva-VidHdU4YNXnVu+9R2p-HT3qEuKtg@mail.gmail.com>
Subject: Re: [PATCH] virtio_balloon: stay awake while adjusting balloon
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:18=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.12.23 16:16, David Stevens wrote:
> > On Mon, Dec 18, 2023 at 6:37=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 14.12.23 05:13, David Stevens wrote:
> >>> On Wed, Dec 13, 2023 at 5:44=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 11.12.23 12:43, David Stevens wrote:
> >>>>> From: David Stevens <stevensd@chromium.org>
> >>>>>
> >>>>
> >>>> Hi David,
> >>>>
> >>>>> Add a wakeup event for when the balloon is inflating or deflating.
> >>>>> Userspace can enable this wakeup event to prevent the system from
> >>>>> suspending while the balloon is being adjusted. This allows
> >>>>> /sys/power/wakeup_count to be used without breaking virtio_balloon'=
s
> >>>>> cooperative memory management.
> >>>>
> >>>> Can you add/share some more details
> >>>
> >>> I'm working on enabling support for Linux s2Idle in our Android
> >>> virtual machine, to restrict apps from running in the background
> >>> without holding an Android partial wakelock. With the patch I recentl=
y
> >>> sent out [1], since crosvm advertises native PCI power management for
> >>> virtio devices, the Android guest can properly enter s2idle, and it
> >>> can be woken up by incoming IO. However, one of the remaining problem=
s
> >>> is that when the host needs to reclaim memory from the guest via the
> >>> virtio-balloon, there is nothing preventing the guest from entering
> >>> s2idle before the balloon driver finishes returning memory to the
> >>> host.
> >>
> >> Thanks for the information. So you also want to wakeup the VM when
> >> wanting to get more memory from the VM?
> >>
> >> Using which mechanism would that wakeup happen? Likely not the device
> >> itself?
> >
> > The wakeup would happen via the parent device's interrupt. I've sent a
> > new version of this patch that uses the parent device's wakeup event
> > instead of adding a new one.
> >
> >>>
> >>> One alternative to this approach would be to add a virtballoon_suspen=
d
> >>> callback to abort suspend if the balloon is inflating/adjusting.
> >>> However, it seems cleaner to just prevent suspend in the first place.
> >>
> >> Also, the PM notifier could also be used with very high priority, so t=
he
> >> device would respond early to PM_SUSPEND_PREPARE.
> >
> > One drawback of blocking suspend via a PM notifier is that the
> > behavior isn't configurable by userspace, whereas wakeup events can be
> > enabled/disabled by userspace.
>
> The question is if that behavior for the balloon is really worth it
> being configured by user space?

It seems to me that the current behavior of completely resetting the
virtio balloon in virtballoon_freeze is basically antithetical to the
power management integration I'm adding, where power management
doesn't interrupt the virtio balloon's operation at all. So if there
are any systems that are actually happy with the current power
management behavior, they probably don't want suspend to be blocked by
inflation/deflation.

-David
