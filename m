Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D42153C6
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430471; cv=none; b=XnX8zN9njWQ13n/B414rOgh2RPiTh2IWz0h2tmzjd/Abj9T/YYJIpUkHTIKBmCwZtQhLICqsQNFgLS+8VdtFgR20W6SB5qXmVzqRUDoVkJYdXJFh7KKaI6GzTvwyEDXFCUDRmAeSRipXajmoGI+2ad9vQ/sJwwOaoBJ7l6R1bKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430471; c=relaxed/simple;
	bh=jF/5ubFo89BoEZAJxrybV/UPR1THG6liaCfHYoxNyQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCD3b7z02W1LLpe+huiluNBb2LlcvrSmn+7l1nJeAwW0ptNrRdYFd2I4wOgDIPZuZ5m/mkMOqCYgVUjk2IkcPirUIcPj2Inl7WYnFeonxEobA53jRtCBWEo7cOhLlhSxMZymiZqluusC9+APmLyQQhiZG4O+biMpUEU05qiDPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/EcULKd; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/EcULKd"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32923999549so40581561fa.2
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748430468; x=1749035268; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF/5ubFo89BoEZAJxrybV/UPR1THG6liaCfHYoxNyQY=;
        b=R/EcULKdy834mlo0aAKi63rxEjdEVdCYbkppNNs8lbCop3z+q0c7MQ9LNJS3owPH6N
         X5/SR7Lf6pkN2HLQeB5SR9D8cZ44XyTwEti2prSc7+/nr/7qvfti7u17Am3qgHtOancE
         2cyOzF3yksMMBfGQNGjKkKQniRR8QMdF1zFWwMhYlbK99dbexLlFTE7XAYLY6Xafnt2Y
         lh3Nm1RevLOiJRM6hCUuAlN91UPNIRXrZNaCoQ+B8SEB0ePDqzk1JCP5BA4GzstKyMa+
         mtCQssI+5sFzaruVv084zbaBII45ZIKAtMD2ky0PLvQMP9LEdwTh2ZkI5Kg/d8dFsSGU
         qZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748430468; x=1749035268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jF/5ubFo89BoEZAJxrybV/UPR1THG6liaCfHYoxNyQY=;
        b=og+V/g0EchamaTAZrPVmLg64K3PdHpSO0wjNVjd/aF5NBZF93RFcXEPiKBBFvR7I9D
         i3FaN4gwFmYB9kbJA4TjivU1jB4mGaFR8qFWR2wHYjW8GLz45cUzAZSmDbnjoAjN4XkV
         /HIr2yQiGdNOJnoEUEfbKlm7SLSy0fMKsOYFmmyX2Sd0QKXU43ZW1JBMNAupOWVNKL/6
         cF56dOkArt0tDjsNP/GQeuXFiLlceTTesrxalkolT3xwtqbB8/5tSr1RoqCO7yZntu+I
         cz/MGHs4a652j7lsWaTOtYXYldlRzKSkFgzgiiH637708sjVHdwGYXGZq1Azgw5ryDLP
         DEng==
X-Forwarded-Encrypted: i=1; AJvYcCW0bkvTSVw7lLxh4yPB0/+lzV9KqGhgvfabWDOT7UUTwAP1O8SBi7Tdnvrv4hpGKtI/nZM9T8Mv8EfsN6hL9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCDPfCjh7/RFrFbHwGLOH2HuXdxh1FHJGx5Mqg9vEjM75y0H4T
	gvy3UyF+oePBYsyhZZH5oHDn7jB8JfZl7LiULr7DtV5YqIuZ0vBbKNkP9IM+h2Zc1FA8y1+SYFo
	4w26aT+OtiqCzaXbcZFAis57KzDr3Dq0=
X-Gm-Gg: ASbGncvSu4KP3udn4RpuUoBb990VvG7utOUo+Slvg+OPRsme5VXqk9mOe6zcOZ2u5+U
	bhzGN60UMnGg8SRwKVjtMIw2faWUvIhUFRkD1XZBZpy2iygHoP70Y97juZ/H/3sFAitxsHkB9co
	b7rBpHPSTLhUv4PsZdCVwplSk7V602YT19JKTk3iYYXSmp/bXigNDkyBBAvyR5tAU=
X-Google-Smtp-Source: AGHT+IE1hcIMK7m1GKoGJB24P7DGefofaI/Vg8OKATdfKWNBjeH6OMyp4e7LeetXAmTIp+kezDsWsaZdJxJ8WU97Ous=
X-Received: by 2002:a2e:a9ab:0:b0:327:fec0:b85d with SMTP id
 38308e7fff4ca-3295b9e5920mr57437991fa.21.1748430467655; Wed, 28 May 2025
 04:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <20250526141316.7e907032@foz.lan> <20250527102111-mutt-send-email-mst@kernel.org>
 <20250527163927.02924adc@sal.lan> <20250527110444-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250527110444-mutt-send-email-mst@kernel.org>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 28 May 2025 20:07:34 +0900
X-Gm-Features: AX0GCFt5INry7hbLxnLIuUw8ffHrRUe_PZb75vuWFFXrALkR7hnpqJJcOCl5zNg
Message-ID: <CAAVeFuJ-zbbUT3ss5rw-=Sx52aoLxf7BCLz9tPxcA2AY+PX+yQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: add virtio-media driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Albert Esteve <aesteve@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	gurchetansingh@google.com, daniel.almeida@collabora.com, adelva@google.com, 
	changyeon@google.com, nicolas.dufresne@collabora.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, May 28, 2025 at 12:06=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, May 27, 2025 at 04:39:27PM +0200, Mauro Carvalho Chehab wrote:
> > > It's up to you though.
> > > I can keep it in next for now, so it gets some coverage by
> > > tools scanning that tree.
> >
> > Sure, feel free to keep it on next if you prefer so. Just
> > please don't submit it upstream while we don't review and
> > properly test it.
>
> No prob. I just want to see it get reviewed and merged.
> My understanding is, it wasn't because maintainers were
> not Cc'd so that should be all ironed out now.
> Alexandre, do you want this in next for now or just drop it?

I think it doesn't hurt to give some exposure to this driver, if Mauro
is ok with it (and it eventually gets merged through the media tree).
