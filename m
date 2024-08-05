Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE11547C5
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875060; cv=none; b=J2ACagbKWrb3meBdoHnjdbuRCru3hlTszYMial/vyBDiOMf927xNBx95sU4MVyjukpxSpkCm2CFxfTUa/Qy3pP7A0YbYRosMBwzkq7eEcY2/LnWGUW7/bSkvYvgLuwy7KYPDHDGkAPhdrm8gEVA+8UznZhGJmFHb66303v+GZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875060; c=relaxed/simple;
	bh=a8C99+OTElpTmOTtUSQ4jS9OW9GVLl/7moJ7+wx1Mb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOVic030l42rugEXKn0jwtS6uLexl5zgLGwDRIBmgxLrxlc6ztJksyodVA+C/PmloGEB+l+VAVK9ymemk/KEXEKoUelHC9j99AL44GShD3WI/35uXBBizWuhjLAW1X/bR7j11Zzy/Fv3R6x0B4JrQ6NynmOQ0OnXmBDdiuTOJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFejOcOw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFejOcOw"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6117aso1669316a12.0
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722875057; x=1723479857; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8C99+OTElpTmOTtUSQ4jS9OW9GVLl/7moJ7+wx1Mb4=;
        b=YFejOcOwcD5BDOvcLz9CPKfSSPH7JHGZTkl260Vupgdq9TsFLnhfTJ7Tfvu23khXkm
         +EjJD50bkuAkOAJZaUXQ0qzUUB0eCHJo/vyCaWlMXArTiFAvSZLPKxi4g7Lg2wVWyFdh
         floYKh7cSHcL4r2wq1O1tuzr+CKawIdgGGPej0mQ+oJaHHjN+r0EkJBR+HF1dDksS2Mt
         R322Vuy3HEVjiIav3MOT3SMJ934SpyadnMbWWm7oHGpH4huLipi+GKey7nbLlUWxv+rr
         QIJUXgO37PRPQp+FlFapr/snOQX+4TQzeY9RUQALeKzL2DSZm67xigpTXeDIhNqQ2WOy
         MPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722875057; x=1723479857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8C99+OTElpTmOTtUSQ4jS9OW9GVLl/7moJ7+wx1Mb4=;
        b=shX05EyO9ATPBLV5VatAwgNj0La2URuB/JqlkBVvvdVpbkhou4XK0+hO0SIBEM+Wan
         oO/sQruS8pyQkaEoFb+BPP1x13txRghd+r06p0R4BdW+hzoYl5MqCnZkjuch1wMfq9lT
         FQ7uffNyZ0sz1Ucxdxd6cwjlVBn+c0HfdW21s1B4J78M3W4CKKPL1yxO6Q0NvkbDK6cI
         QFAb+TvSog6KYGruYP3ng/Cm4/jFFHrDPoetiON96F46qAJPcR7qP/usZcJtaJflZU+v
         9qctPxj4BHf35WDJM8zPCNzbh78ayRgKu9rtxKok1JqgumSYkuvOmMn5NHtWRYI80JXW
         J74Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOQAm/9zSX79I1H4Yaa8kGkEigq5/XAiJ5eRC8uudOpyB4D3/h0zAxGD/QkJJnMZqg9tQeUcKYfWkW1aT7uguCNopaG4KXhAAPUyhrGOw=
X-Gm-Message-State: AOJu0YxDV15CJZtrOflBAyCpDvZ/SaIqjYFA/Z2fflHWK5zmh/pSQauZ
	d3ijOLBXk2N/D07POFjWMabFE92FYZeKvxaqjzmdNzTP159Zm2aimTGLQ5xhlmmObxFsTmQND6x
	qh958sj5ur+UoJ3UlaS5PE2ycoT0=
X-Google-Smtp-Source: AGHT+IHvyHbFZJE4p8C4OL9f2eMAtF/7nSyBc86q0iTr2swDTqSonp+1rkVReAaAYjc0C810FGILIP+l2ZHt9zaqOEo=
X-Received: by 2002:a50:e613:0:b0:5a1:a08a:e08 with SMTP id
 4fb4d7f45d1cf-5b7f39e07b7mr10209743a12.11.1722875057029; Mon, 05 Aug 2024
 09:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
In-Reply-To: <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 5 Aug 2024 09:24:04 -0700
Message-ID: <CAF6AEGvwrYiN6nMSsRAdc3qq+qQGWEvdW_3+xJh6y2iAyW6rkw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Sergio Lopez <slp@redhat.com>, gurchetansingh@chromium.org, tzimmermann@suse.de, 
	mripard@kernel.org, olvaffe@gmail.com, kraxel@redhat.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, airlied@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:00=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 7/23/24 14:49, Sergio Lopez wrote:
> > There's an incresing number of machines supporting multiple page sizes
> > and on these machines the host and a guest can be running, each one,
> > with a different page size.
> >
> > For what pertains to virtio-gpu, this is not a problem if the page size
> > of the guest happens to be bigger or equal than the host, but will
> > potentially lead to failures in memory allocations and/or mappings
> > otherwise.
>
> Please describe concrete problem you're trying to solve. Guest memory
> allocation consists of guest pages, I don't see how knowledge of host
> page size helps anything in userspace.
>
> I suspect you want this for host blobs, but then it should be
> virtio_gpu_vram_create() that should use max(host_page_sz,
> guest_page_size), AFAICT. It's kernel who is responsible for memory
> management, userspace can't be trusted for doing that.

fwiw virtgpu native context would require this as well, mesa would
need to know the host page size to correctly align GPU VA allocations
(which must be a multiple of the host page size).

So a-b for adding this and exposing it to userspace.

BR,
-R

> --
> Best regards,
> Dmitry
>
