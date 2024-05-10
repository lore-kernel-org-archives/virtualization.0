Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B312AAC0
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341329; cv=none; b=LXqCRZ/tsc9qf/1V3G5JHdza/Wjhv50Mn0MZGfsj1hE3PoyJRE2hmSom9AGOmYZ1WnYxnkjw4dZj+nKpOXKNtm8Zw0yep4F1u2s1c43CVJBD0XyGJ5Q85wiKsCv4Etl65stFhN5wrcYYexfZeRnttUt9bCXgd1LF77OpKHRHiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341329; c=relaxed/simple;
	bh=Ha0+NpzhkqUz1q/3RALaO2DoQ9/lzrevw2pudc7Szgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFfeg73GHRss4ovzra+ivFY3CxcNleAXyQsIlUu7iLjHBS01oshBW2PSiK8LuW9se/WJi0dTQx6kflk/ROei3bIAUVbbkfiXU/ZVk8itOMo+Lp7WLTH0/J1BL1X9PbZpiAI+obwRDboCmIPwv7+PX0c4tXZcD1tBFgPdBL1YxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cej8VFUo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cej8VFUo"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a8f0d941so463623066b.2
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715341326; x=1715946126; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha0+NpzhkqUz1q/3RALaO2DoQ9/lzrevw2pudc7Szgk=;
        b=cej8VFUonMfizIKQnrmh7TZNj/L19vk4i0mEU5q+givlBOgRbvZrE3DqsdEpYeNSby
         NmMRTdLk5I8WKbRGVKYRRBXWwGiiUL/36zMrAY1Xy6MSf4UCVZ2FdhBzISWz1EvCltPd
         EkGyqmOxb/zcwYlPFUycahNJWfuF89AvMWb18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341326; x=1715946126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ha0+NpzhkqUz1q/3RALaO2DoQ9/lzrevw2pudc7Szgk=;
        b=Lh2bVdbGxlOAojjvuiGLrcmVNu/Ns8OP2a0p7VkighgHu50yBI9lElv1Z/KsXhg/We
         +s5+pZHgG+3dC0R8fvUikxDW6uL4aCHCGUvVojuYWqWUhadY95vMK6emSxDpzgMeI8mL
         512Gj8TlO20IvOdg43WS1S0OceAY3SZnKmn7hE8QrRg5yMhzbxQOo76EXWtBsAZ0f0Vf
         cFecvheTi+QjC8cTzZKKjwkBobIiqsw+4jCTDWalsRYaHUc+NRbvRZsD8X6s/+rsqq3H
         gWB/j5bx5ZdvInKpqOXkBywco8vSAcAEReYYSAdk2oiSMTffo3Uk38jjW96LBMrj5bwa
         VBlA==
X-Forwarded-Encrypted: i=1; AJvYcCWM+KQlhfrbG8Ra3BepiqAWI+6N8DlEOBtwWAh3UFmheFS8uU6IP61cf3K1E6YDnyrNNj1r44BJ0PrRiDtjSE6e5PtANvrgDVrN0At4vjk=
X-Gm-Message-State: AOJu0Yw4o+zJ48pL/EapGMXqs/MYLosKp645g9bFLuPAUFxGwo/05DlE
	32tL5JgRip6tKefMp5aEiJSUYbgY81D3vfYaMs3r3y1rBTu7ET5HQqL/qr59Aek2uJat9SiAt/r
	EUgtxeyfxt+DMjDfkTqLSp2FOq+iT4rycHypSmQ==
X-Google-Smtp-Source: AGHT+IHWwbmKStyyTxP46uRw65XGTGV9bbtL+cxTu4gfnrmA+dijWGPRf64AlJAlDtewnSqwfvUppGUd6QQeoTIxIwg=
X-Received: by 2002:a17:906:53d7:b0:a59:d6ab:7889 with SMTP id
 a640c23a62f3a-a5a2d65ecddmr154187966b.47.1715341326195; Fri, 10 May 2024
 04:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240501153817.540855-1-pgootzen@nvidia.com> <20240510070542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240510070542-mutt-send-email-mst@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:41:55 +0200
Message-ID: <CAJfpegsv9cpPnACOShW0FNddBEwSWAhyW-V565rfh7-UWt9njQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: introduce multi-queue support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter-Jan Gootzen <pgootzen@nvidia.com>, virtualization@lists.linux.dev, vgoyal@redhat.com, 
	stefanha@redhat.com, dgilbert@redhat.com, yorayz@nvidia.comm, 
	gurtovoy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 13:05, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, May 01, 2024 at 05:38:15PM +0200, Peter-Jan Gootzen wrote:
> > In this patch set we are adding multi-queue support in the virtio-fs
> > driver to enhance performance.
> > While multi-queue functionality has been in the virtio-fs specification
> > since its inception, the current implementation in the Linux kernel
> > creates multiple queues, but only enqueues requests on the first request
> > queue.
> >
> > The first commit in this patch set limits the number of request queues
> > to the number of CPUs in the system, to reduce unnecessary resource
> > consumption on the device-side.
> > The second commit adds a multi queue mapping to the virtio-fs device
> > driver that is created using MSI-X affinity mappings or, in case of no
> > existing mappings, by evenly grouping the CPUs and dividing the queues
> > over these groups.
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks.

Miklos
