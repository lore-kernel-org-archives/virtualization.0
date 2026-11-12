Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794463443;
	b=T+WmRtk0gKpnwEbjOAc3mPX1GLWNPTruDs6I/IEr0uZHythTQSQVE7/ezMJI1hJVdE9Z
	 rW9yxEV3NMCGVXQxkydhfK6NUZlo697iqaNVUJCwz4TBuOTcWzfMY6EeeJG2ha4D+ED7t
	 AyI1PDmqLOtIS0VKtBcoZNcICxUDUQ2JlfRiAhpKpznWusA4evPEizwhyupIZN5R4kARu
	 lQwbTqOniqHWzWWA9V7c7MgULGYVwUzE01zGhUGe4g574kyb3XfLz4P8rFZN9uiojL2EH
	 tARRE1wHQSM0mzq9SgcniD/SfpRvpwrTstszGVVyQtwJfqKWHf9IeKcU90g+DNsV8Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463443;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8B+7bgNSJzuv/eI62YnmIyuOnqT9cVeVeA+y8N+Tk9Y=;
	b=Ug23fRpYCqhaM4CgBoLbG0OIy63o9ym11va1mR9qs27qhpozAjd+k6CTPJOq6VzK6fGd
	 Zv5Dk7wcFsiVfqSCHxDMOaaWmP4tDwWm53VV4ZABDZy2bQNQiPucH1zPdw+8jNfdcTiOs
	 EHPaNaefVAweSDKkvOTf++7qr85MlJ96Uxpz6FdmAF22HqfbvWn+pelSxKw+i9ccf6pqy
	 uRTQyXnZ+3Y+oCnCyuyx8D+ieTMXgU/ZtEtP4JeacK7UVKR7/Gx1lPEtJxzPMqPGEXT6I
	 Ul16Lqw9Y60XzSUzHlIPpqUKKWhxqmTs8i8IFARpZA8P+XwPeFhXT1pq0lVQ5BDQsOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABwcr2u7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D9606A321;
	Thu, 12 Nov 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABwcr2u7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208B41F00A05;
	Thu, 12 Nov 2026 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463443;
	bh=8B+7bgNSJzuv/eI62YnmIyuOnqT9cVeVeA+y8N+Tk9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABwcr2u7OtEkvuPOkgOMQhUotooZKO3/MDaprvOJpMLtuOjwxh7b90t5QvBos9BGt
	 6fBcvoS/7Vwnh/lMbS5q945OqH7kWDUhK9G9OCHhp25JLzTHsAr/qYMh2jjJJ6VCk7
	 SS9CvvDKvlrtVhOyu0dtTyEXONIjUT+BIDqK8FleuG29MmKSMn1SoKRTSjldvcxWM2
	 w0jZvnBGmxgpMSiR2L4zSLBOrfdxY1nZFYwz7AkUQrMi8IJLLSbX6PTE6CsyIPr5Q1
	 KmEy0ZrJPObl9BZBdhXF+QZQqkEIhBpp41yAyAanX7y+XR/nn8NoDte8ibTZEy5c94
	 GuIfZzu8EOg4A==
Message-ID: <sashiko-outbox-210494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 17/17] ALSA: virtio: preserve playback progress
 across pause and buffer access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-18-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-18-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:04:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ALSA: virtio: ephemeral patch numbers and test notes in commit
  message
--

commit 828a40dca88211506643733b87d449d53fefdce3
Author: Joonho Lee <mynameisjune111@gmail.com>

> ALSA: virtio: preserve playback progress across pause and buffer access
>
> TX completions can arrive after PAUSE closes transfer admission.
> Preserve that progress and schedule catch-up when the stream resumes or
> a rejected pause restores RUNNING. Cache device latency in stream-owned
> state so a late completion does not need to dereference the ALSA
> runtime. Clear both the cache and runtime delay on prepare and before
> RESET observes the hardware pointer.
>
> A playback pointer callback can also invoke ACK while the core has
> closed buffer-access admission, after the pointer helper has already
> accounted for completed hardware bytes. Track that callback context and
> refill only previously committed data using pcm_indirect.appl_ptr. Keep
> rejecting other ACKs while the gate is closed, and use the
> explicit-pointer helper from patch 16 for the refill. If
> runtime->control is absent, route the condition through the common
> playback validator and XRUN error path rather than returning before
> transfer failure handling.
>
> Use the existing indirect hw_queue_size to keep outstanding TX below one
> physical ring: buffer_bytes - period_bytes. Equal modulo cursors then
> mean no unobserved completion, and a non-interrupt HWSYNC cannot consume
> a hidden full-ring wrap before deferred period work. Continue using the
> ordinary ALSA pointer update for silence, drain, stop-threshold and
> wakeup policy.
>
> Check for pending progress or a latched transfer error again in the
> period worker under the PCM stream lock. A queued notification can
> outlive a paused RESET or an earlier pointer observation. Calling the
> period helper without new progress after resume can turn equal cursors
> into a false wrap when the core has backdated its pointer timestamp.
>
> This reduces queued buffering by one period. With two periods, only one
> period can be queued. Worst-case scheduling tolerance needs
> qualification.
>
> The final candidate was tested on ARM64 QEMU with KASAN and lockdep.
> RW/MMAP boundary pause, release, HWSYNC/poll, drop and reopen passed
> with two- and eight-period rings. RW/MMAP also passed accepted RESET
> from PREPARED followed by DRAIN and reopen, and accepted RESET while
> RUNNING after the full 2,048-frame buffer became available.
>
> A separate paired RW/MMAP gate fixture reproduced the baseline failure.
> The generic ALSA indirect helper invokes ACK for each pointer callback
> but masks its internal -EBADFD. Once hw_ptr =3D=3D hw_io with no completi=
on
> outstanding, virtio period-work progress suppresses further callbacks,
> so there is no ACK to retry the refill. Baseline stopped after 3,072
> completed bytes with 1,024 bytes in sw_ready. The candidate drained
> sw_ready and completed 4,096 bytes without any further client ACK. A
> test-only hook changed appl_ptr to 2,560 while only 2,048 frames were
> committed; the candidate refilled only committed data. The hostile
> mutation used a test-only kernel hook because ARM64 control-page mmap is
> unsupported. KASAN and lockdep had no diagnostics. KCSAN and physical
> audio were not tested. The tree through patch 15 was inspected but was
> not run as a separate control. Full-series runtime is not claimed here.
>
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This isn't a bug, but the commit message refers to mailing-list series
numbers ("patch 15" and "patch 16"), which lose their meaning once the
commits are applied to git history; naming
snd_pcm_indirect_playback_transfer_appl_ptr() or the prior commit subject
directly would be clearer.  Also, the open-ended note ("Worst-case
scheduling tolerance needs qualification") and test-runner disclaimers
("The tree through patch 15 was inspected...", "Full-series runtime is not
claimed here.") belong in the cover letter or below the --- separator
rather than the permanent changelog.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D17
