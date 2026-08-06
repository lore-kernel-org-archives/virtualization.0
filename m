Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0E34752B
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786056338; cv=pass; b=GrhTa+rQ9EDAItJXsk3B1wB9V7PPADEUEqU+vx7g49XqCz5MOx1fvSYF2CDsBWjYrm3uy4vVoWX85+FCqCSRj4wrjL2ikVUuZURXW7FiqAvwYXhQS6YRmR93t6hHcErgUTfTz5ZExLLCzOYp+QV6+GeaTuLLf+QLuaaoEWq3OOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786056338; c=relaxed/simple;
	bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNLkgGM5WIry7+6GT4m1rnlLHHjbfZWlTWOtc5R1e69T/QOJk3yfh02VlXc26nZHS2Wwa+tjTXX7XHLHq79ELcuvvLSfFXk0pmwujwV2li6NOzE3GxI54MPWGOoZlGxKN0TXyecNQ4m6FF+/YLco1G5Bf2ZQQbGjNRuOPoatQoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+gEpXk8; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+gEpXk8"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10ed63c0so49461cf.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 15:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786056336; cv=none;
        d=google.com; s=arc-20260327;
        b=pZjzHCw8KkJRaOCMV4gch8KKOFCkCKnxwA26knAIXr0+P6RSq2tYutryOJ3yvxSt1b
         fYIvks3oj2vvJLLGQB4VufUNWFzVsoa6Cv4FE6N0VcVaYNRjGVbIbFVuJf/HLfEpZ+wg
         D1NQWxyT4kXTj62UqW3QgpC5vtMDvlkbmQJMbeXBKNAEBEJ16yRyjAQMKv/MEQTFVIIN
         nE3AjxiGhCnuGbhc9z2gZO+B7TLZrel4dGdCyWEJ16Ip1Qz6/MExnI0a7cCHYE3pkKf2
         XPGcFvzbhbuNdlE4ndwOPEbXHVehlzUa7ly/2O69mv5EmvpoaoWQEpm4oR6Sj29nQZVx
         cZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
        fh=UtYhZ2SXbrCjbl+irxy2hxn7DR/5A8d+qC3IqmG9Mu8=;
        b=UhXAPqnFv03nYxTM273FX0iaTeQB0fO+LsI2VIRGvsM8IoTb2UiTXV455KfCJW6Tva
         Dm/SNgPLO6i0RT/HVb/HpKgAZ5UEzSW3tTw6QSOBYqz6GdR3nQlxwUu/AgWd9oDjUoBb
         903htsoFAHzxJamzRqUAy206BQ7ftzvjuceSRP+nshrsep/Or17tARKbm2oAviL1IMFr
         viZjdNdrXj6DkY584onKDQwlurvYjX4lfZ3ow4kr63AeTToMrlJAWUNBepXd242U99Ws
         nDbBFNy92m88iXK65bVbJJ/t6qDh5FyYYivex3Xw/94m3sZLs1BmRswpU0J5QYroztDY
         tsRA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786056336; x=1786661136; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
        b=i+gEpXk8sdq2U/KD3WV4umgNOvVwiVvWRQFyUcUsoVZK5FmqBeMBr9wULmQBTKFjss
         BOx+lnGffCweXEt8CZu5N/QrQzXAkELhrvrxxV3ilCpBxQirKjYV0ncH9xTuJlyXtiMw
         EgdqxLKNkVJnYpV79ZKDISD2uPEfUaGd+cxlam3jp/26yV4s93h7CMkYJp8+2K2K4LUq
         qmvYtziNQc1CvIaHWVKaIM9ofoY/VgXJvTvQxGFaGVg/TIcCtTT259XUEk1G8ajbKUWM
         eIV+0XHDE1ydTOVUNh3ddPLGvk1iqnEgZhA3aRLxjcdmA/uNn3Zhk38W7FL0IH7MlhON
         YpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786056336; x=1786661136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6JgVqkbmtz5NpnUIHvX9HoVnvdw6c/HMcKh98oiDnA=;
        b=AV73ypfWNsGvxsmhSQO6u7CTU616wRHN8AMIcYZZOnFd8t2l8AdnPFwh3ig1TVQTIn
         LocxIQqzlLH9W20ezpB9c6uH9N3fKS2ZniPRAZX5X3iAEp+hP7SMOoRradSxa8wu4wiq
         q6GAvfzw2TQaWqj6JmrGlEtgU92DELxTdNKN0vtBLqPTDmFiuLw8/qiWJCMDUAjEJ6Jc
         /2gYPuVKvZIrOIwAPKqUQdhJTQmsO7di4lBJRbNbzqNDiyzjrdj44cHb30AAIeaOXnop
         JT3BYVaaV39/egFDglNB9BhBzQIyi1XeAfQ2TRrRQy8grL4ODo+bxUwz6KkDjmlLlSNC
         kaHw==
X-Forwarded-Encrypted: i=1; AHgh+RpKGhVfDUf0ZPfVNDz0BRe/dQtd++xV1w1aWNP3nkMnpOUm6P712EMUVKKkHN7dV7SaIbKNJUDDdV3hkgGgNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBAiHDkTr2MQ3brv+Ly8k86Hv1QIUjdZtY9OshENI25qH/Tnc4
	tJTu8Co+Cmy94ku250/EdaQ8pdLve+FMeILUrulCEa6q8JIcbHdMFgfweOCzCWKhOaekccH8wMo
	xA1/1Unuw0gEaExX6ABKfEG6e/1NJQgi45vVg89at
X-Gm-Gg: AR+sD11z2CXV9irTb0PkPuQvpzpDkH02oLTLYkFEFJiUUm86zhXXmtlPaE7zYNFgsGf
	LibkGIXfv4SQBCrbJuNPoGTQC9FSFibvhrmlPhT1T/FeK08ZGkyqdjjDPvtjwurqvyeYs6pgrvh
	JDBL8VOVhlHNZriwM+nnCDcrn/bZqmPCRYvRb/v0rqSoZuR77ugjcjkLdNFWVO5/8EE6td6IR7W
	kGsOMPOgOvZWpSBJsUDXsJ6/GpnfrAax1KHbHtpp4Z13L6fwfhWqiOaVlPAuq1QvHLjBoCiN+r8
	8lb4BjQfnxyma7+NDIkmqpNMTJ25/NB22F36dX6ALh6CGjY3NMKK3FWhnaSWK9hXoEkO8hxP8OI
	=
X-Received: by 2002:ac8:5893:0:b0:51c:104c:100c with SMTP id
 d75a77b69052e-52d106def12mr5018131cf.2.1786056335879; Thu, 06 Aug 2026
 15:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260724014605.3377283-1-linkl@google.com> <CALUx4KQfyRgG3ewQZMuU4+AMCyrh8+rH=-MOZLBv29PbPcnhYA@mail.gmail.com>
In-Reply-To: <CALUx4KQfyRgG3ewQZMuU4+AMCyrh8+rH=-MOZLBv29PbPcnhYA@mail.gmail.com>
From: Link Lin <linkl@google.com>
Date: Thu, 6 Aug 2026 15:45:25 -0700
X-Gm-Features: AUfX_myMFV1qJfbDkK0lr2_rAcEPde0PqT3TobQKcsNUoc9XJsFqir-koEVr8yU
Message-ID: <CALUx4KS-xRf7m3jPDN5BKfFrpbojp9+0czRp5-siFed-Jj1G1A@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio_balloon: add VIRTIO_BALLOON_F_REPORTING_PM_SAFE
 feature bit
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>, 
	Taylor Scanlon <tayy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Following up on this RFC to see if anyone has had a chance to look it over.

We'd appreciate any high-level feedback on whether using a dedicated featur=
e
bit (or a similar protocol-level handshake) is a viable path forward for
safe hypervisor deployment, or if there is an alternative approach the
maintainers would prefer.

Thanks,
Link


On Wed, Jul 29, 2026 at 7:52=E2=80=AFPM Link Lin <linkl@google.com> wrote:
>
> Hi all,
>
> Friendly ping on this RFC.
>
> We'd love your feedback on whether using a new feature bit
> (VIRTIO_BALLOON_F_REPORTING_PM_SAFE) to negotiate PM suspend safety is
> acceptable, or if you have concerns about protocol-level handshakes for
> kernel PM fix states.
>
> If you prefer an alternative approach for safe fleet deployment, please l=
et
> us know. Thank you!
>
> Sincerely,
> Link
