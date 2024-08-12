Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F183189B89
	for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486946; cv=none; b=LgLKYnkgjhvc0diobu8mKNY9KPWl/Lx5a8A+SX7p4yuWnEIyi70uuyk4Q1jfpVa0wUuYZ1+6tgc8l7JiiBak2dwRofiSpBvriYszNRAFplevEMBuuDLkHKRclTUkfJ+9rt17fZkawLyCp3ECv7QqGQIHYHFMt9uW9EvVk1rlrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486946; c=relaxed/simple;
	bh=MN6EVSg50cIdsGQkQdCredezsAWU82dFVedyLLRBeYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G69jsTsSM+FF9MsUxnQcbtlntM1QM4/N76etSW2oBj7qaXCLwta3hu0oXW8J/9szMNNf7oHyZV6RTO9QVQ+seWftyWKT/sJPb0gA3wZ1iZ9OqJt7r7GWEaR3yU7VY4g4ZsS3ACk8ZUPJybTochywrSzjxGmqkcbddRo5nZ2P8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjXWEMCF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjXWEMCF"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f15790b472so58536881fa.0
        for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723486943; x=1724091743; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coUi0/ohCVhoxzgHSkTjcFNIQKRPd60M4TbuFg/3kwI=;
        b=KjXWEMCFQKGdyOluvf57cfVQg+u+wB+ovww0aGVx2VNHFbQg+2Y0xi30mVjy/bi9WZ
         cGo5jk1skHC3YqSfG6dkXVE+dzhFxG8oafmH8ELYJmwG5Av0fDLuqGxD8TvyJ9GDEdhr
         bKLnW28kJ/goWXQuntR/LfNXLarhSMGpL3fgSQqqjVLw+GoVWikiZdsBGsJsckb6Amd1
         TPSXXWqR6gfEhzzUNlpnIDvr3cHDQbcUEKEZ9BwN0K4DPz5bHZcKhDDlGc3DtxQjR6Fe
         P6dC7ZOutHHq9wOGS1IAChHopuS4gEsu5AuLxgyZ7hAczRUNFjUuKRNJGI9rkQNcecyD
         POrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486943; x=1724091743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coUi0/ohCVhoxzgHSkTjcFNIQKRPd60M4TbuFg/3kwI=;
        b=Xioqn+s3QydW11dKPPkeqJcrf/PN6rs4kQaHPwd8xaObKBKkP4y6jbhziSImzRj57E
         kFHMbzH4i8sV0+q6l7Rq3Rgau5MdJdO+lVZ41rYTqHOlJGoyIS+9xPLyG/xCOcXg3V9j
         WDauWOYvmahUo/fk8m76emoBR4q04X17UQr/uWwHBdZ/jJKACTWqX7tg88fp6n3GrJ9u
         v5dHNn+JnyVV/VS5OXPA9JoC7iK8P7p8XuDm2bNi46I9HNCJPIyqe/59ZxFRue5v5DuP
         CnrKlb1dxuUipXpS6fSLtRfcC7kxY29gpJFoHrUvRLzmcrelwUBuU98mvfo5J1T2Po5j
         wGOA==
X-Forwarded-Encrypted: i=1; AJvYcCUfY3q1kglB4NHczhP+P+PbIb3pc2GnHWGEHjvqMH4yNzqf5WnCcsAqWv5BQV8kSbjfJqP+kgdv+oAtkA52l5AA6DKUCt6YvXsSxOTSKFg=
X-Gm-Message-State: AOJu0YxcMfERd+DWogi8mZnzRsXZpjIFoneGsyneMnwKKMAFxZV1YHHg
	av66rO6DhIV6bbEAMerkEfU8tilhlpvuJTzu2L1uacgNbz6xtcxqktZxpyLVDQaPPCeoEuSQt3q
	YDhNfI5QoEDaSeP8ylXj6V/eijvGK8w==
X-Google-Smtp-Source: AGHT+IGsw5wOKenJ4/S6cK3uyE7tsHyzF1jzrmqdqVsPGZnCBKOLdTZr3nAw3POmcblOWHUs99+JFc65/My6jbBmV4M=
X-Received: by 2002:a2e:98c3:0:b0:2ef:2eb9:5e55 with SMTP id
 38308e7fff4ca-2f2b7150337mr7651301fa.13.1723486942050; Mon, 12 Aug 2024
 11:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
 <CAF6AEGvwrYiN6nMSsRAdc3qq+qQGWEvdW_3+xJh6y2iAyW6rkw@mail.gmail.com> <46a5ec89-be9b-4342-820d-019b595fa379@collabora.com>
In-Reply-To: <46a5ec89-be9b-4342-820d-019b595fa379@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 12 Aug 2024 11:22:10 -0700
Message-ID: <CAF6AEGseD2=+vZG=ZfigLhDXt4WJ=XkP=NeT3ERTiiPifpbd+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Sergio Lopez <slp@redhat.com>, gurchetansingh@chromium.org, tzimmermann@suse.de, 
	mripard@kernel.org, olvaffe@gmail.com, kraxel@redhat.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 4:16=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 8/5/24 19:24, Rob Clark wrote:
> > On Wed, Jul 24, 2024 at 12:00=E2=80=AFPM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> On 7/23/24 14:49, Sergio Lopez wrote:
> >>> There's an incresing number of machines supporting multiple page size=
s
> >>> and on these machines the host and a guest can be running, each one,
> >>> with a different page size.
> >>>
> >>> For what pertains to virtio-gpu, this is not a problem if the page si=
ze
> >>> of the guest happens to be bigger or equal than the host, but will
> >>> potentially lead to failures in memory allocations and/or mappings
> >>> otherwise.
> >>
> >> Please describe concrete problem you're trying to solve. Guest memory
> >> allocation consists of guest pages, I don't see how knowledge of host
> >> page size helps anything in userspace.
> >>
> >> I suspect you want this for host blobs, but then it should be
> >> virtio_gpu_vram_create() that should use max(host_page_sz,
> >> guest_page_size), AFAICT. It's kernel who is responsible for memory
> >> management, userspace can't be trusted for doing that.
> >
> > fwiw virtgpu native context would require this as well, mesa would
> > need to know the host page size to correctly align GPU VA allocations
> > (which must be a multiple of the host page size).
> >
> > So a-b for adding this and exposing it to userspace.
>
> In general, GPU page size has no connection to the CPU page size. It
> happens that MSM driver uses same page size for both GPU and CPU. Likely
> you could configure a different GPU page size if you wanted. dGPUs would
> often use 64k pages.

The smmu actually supports various different page sizes (4k, 64k,
etc.. I think up to 2g), and will try to map larger contiguous sets of
pages using larger page sizes to reduce TLB pressure.  This
restriction about aligning to host page size is because the kernel
expects allocations and therefore (currently, pre-sparse) gpu mappings
to be a multiple of the host page size.

As far as whether this should be something outside of virtio-gpu, this
does feel a bit specific to how GEM buffer allocations work and how
host blob resources work.  Maybe other subsystems like media end up
with similar constraints for similar reasons, idk.  But it at least
feels like something applicable to all/most virtgpu context types.

BR,
-R
