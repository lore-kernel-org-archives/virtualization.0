Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E73750CF
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529314; cv=pass; b=Lku1RwbHODKKCxntvX4PFB/dsY6Xtk24iHS3NpK+K9I4en1U6XiXsiHgmrHf/nXcHFuU8j+/fxeTBKx029AFZ5fvi5oRWEkk13DNRy0byb0l0YmzSRMcQba5LXz4m00R6eyyYaxietjjThckiE+aVutcO0qeET32Yk7tFwaUNjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529314; c=relaxed/simple;
	bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIKT9hIakRWVuqlXrk1sAQcWBYkrN+dZNjTggeb67eIgjHk7LGVqmzsNjlwEV50FfWmA+tTjZ4TuB3Y2iz+HRIXA0CrPZFgG/jI6QkVFw9gI5kOdb6ZLjrdAAYtGUIwmgjYqciUV1yE1VfQPpXCl4rP5XU+52NH0pXsoyNHQ4wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6k6AwVl; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6k6AwVl"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c01c79467so57241cf.0
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 13:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785529312; cv=none;
        d=google.com; s=arc-20260327;
        b=jY8MHblTJKrZUHNjpu7B+4zSIRARjrEwgUfn7xVNjFH77dRy2Xo9eiOoBVvDG5jJax
         e1NMp6lsjX03Bl2QrxGIHoEK0YC4/5OKIWNmfMpD2IFcecPUxsdR2hxpnOLaW/n13JA5
         qh0wbqEmQfxpTGwXF2mg3Tm76VGu5PgsmPIpDaM8vNFarjvAgHvzGFNKPtVi3fzLClQQ
         6Lt03ihwCl3Xox4jn17sk7YTA3On4VPJbwtclrIC2TgqVpQdQscgEAtVyX0Vog2hIO/p
         jqMulALVcfJIrxPOSGq0sL1mLBf7PhRmjnuAwgHwfS9GOCSW47sfxGWBFCzcUwPLmDc3
         rN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
        fh=91OkdNwBOf37DV0AsJOLWU0OrGQU1lQ2XzDRetqTAaE=;
        b=F6ceMjlsDXSCfzaWWm+vojG6YiUgU52mXtdQ7NWVhjg3TR3yB09YbJ35uRcanM3LnP
         DY25q0DsSWace2N+yEUq5j1nhQHoeERVp7N9bXFvqGrbmCYMo5YO6gUerQaYy+C1KydG
         j0lGtQRBJaHI9A2HfrAMhv8/be9oTKf+vq0DLQioXM0WqQACTEoBeFIusMDmQv20qfWv
         xz/Lb68HaRWdViEywi8Y3O3Z9xwEoMbWiE9pjqqnwyIQvSCqk/8kChKhlhm0Km80rHuA
         fNiabVsJ1LjE1XWMbBeRxYVIYAAmS+jK6XC95+KC5DMlPILuFlzzgHcFLp/6cBczkEjN
         7RjA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785529312; x=1786134112; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
        b=A6k6AwVlmfz0NHTyH/t58/Mr2cJT9tKUHdy0aMxtXuKS786lyg84opP+6cCSKvHPYw
         Vf30iCMHx+GITYOyICzDfU09eMoLlb684Gmjmy83fvpCVq2blLY/ArIT0JPg0JQR3Yhk
         SHuBzM6CCrh9jE4POYyq47SEj5G2FnSHbPmghsyhX/N8Bnm24xiLLlVd1X8druxyfJNj
         pGs0mOjJjDO9SOv+kiEukksHKAY6YTke81XKSNuRbspJAXU0g7hzEY1/6LAcFqOab6JC
         88YXq4qdymWqZqCni59U38A3e7NdcO6KF0mbEvmN5Y689wGW+6gSbiqrKue0gTAiZLZM
         Lc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785529312; x=1786134112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5CueYXbQOcoeKtu8qRFGDocoF+pTzEJV0YKoT1V3Gg=;
        b=TFnRtIsgOp1fO2Mt4tJ1lhWzR7S9Qakn5Oiz1W9X08hppfyGqKDL/Xh3viOo2e6m0v
         iJ96TdveRGnOQzOuzSD5txPx45U9CJj76o5RKlyIAI/tYkKB71DKRjpLD02YX7tmP/MM
         jxSc8FrliyHAniSI9WzT384kJiad8AOf1H7g6Rb/E7f13eK1ekWxDjQe1r5ZJeB14W5b
         rbvVG9JGdR3wXLpr0akkw2nmA1693NitmE9yBThudf8jfhLXRB0q6dpAs6Z3oNhRMf3x
         zxkf5DiNT9vfzD4FxSHXbZ9jVljkgYeSr+CNrHBBc/pyjIdNWFc9Iozp70F+x2qVpEsr
         Rm5A==
X-Forwarded-Encrypted: i=1; AHgh+RqUsTe7v6HIum/DAFYMnLlnVhi0WqyJd4HTFEQmdX0xmnIm1rDJjCWSHeLdfqlJcuDsUKZk9hsugsg++AKvPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPKGrxZImgTqx4ppEM6AUTGlwTR1eSdwYNI+wseHFYmTEkqN5D
	eGrwll531JOXiROWNoo/SdB+MiTqGoGculxKZX9vxsE3wNO2HZdJxVyZ/5TDyC54tvD24MVqukO
	Ouv7kALnPxsMc7I/jFjooGaVqwB1IeKKKA9OUFyGw
X-Gm-Gg: AR+sD10gR0gRVcVZrKvS+AdaezrIJup5dpQiFVXm21vqbmMKVc/SqbkkXuirKxIqdtV
	1aB1D1+AhsdccPzt/HQKO6+HZ0ThfevInZjCiiqYU4K3Rl8/sH7Z6k7y0AlPjlRtVJ7z83YzRYd
	HnhKtgtGlrC2AertKu+pq2ZQy8qApiMe3j8dRoarDP9rmseQHHUuVwQmXdkEXBH1mV44rwgcdvc
	QftHYmSrk80Oveg/LqUGZgxcbbUWkHN7mQvrXX7G2Q4iVrLnhASJb4PanlOPMHG6DTOj+IlNb1G
	UYzOVkRd+xUVtMyfxPAQU5bPPoRxwYAQcFbejA5J+Q8C11F2ezbUldEm88sqT/owJG19MJUL8wk
	=
X-Received: by 2002:a05:622a:1823:b0:51c:935d:8d74 with SMTP id
 d75a77b69052e-52b5b0e51demr641901cf.9.1785529311540; Fri, 31 Jul 2026
 13:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260721005603.1710551-1-linkl@google.com> <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
 <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com> <20260723051327-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260723051327-mutt-send-email-mst@kernel.org>
From: Link Lin <linkl@google.com>
Date: Fri, 31 Jul 2026 13:21:40 -0700
X-Gm-Features: AUfX_mxNBDgDMslJcUjNED66vC66b1XZjumXM0ISgNPSYjId3DELRHMAgLjGE7s
Message-ID: <CALUx4KRoCco0HA=Y_qFzSD=CegbJPUkQkvjRb1Y3UcgRdwQToA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> I suspect rest of work items we have, e.g. update_balloon_stats_work/upda=
te_balloon_size_work
> all have issues around freeze/restore and error handling.
>
> --
> MST
>

Hi Michael,

We have indeed discovered a kernel crash in update_balloon_stats_work
after the balloon driver failed to resume and initialize in our
production fleet.

Alex Wilkins <ahwilkins@google.com> diagnosed, root caused, and
reported this vulnerability. I am currently drafting and testing a
2-patch series to gracefully unregister callbacks and cancel work
items on resume failure so that the VM continues running without the
balloon driver instead of crashing with a kernel panic.

I wanted to follow up and let you know that we are actively working on
this. I will send out the patches to the list as soon as they are
sufficiently tested.

Best,
Link
