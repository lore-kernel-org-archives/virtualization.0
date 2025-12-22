Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025E32E698
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766420655; cv=none; b=ryuUTiB1ZM8BHKQSshnoFqRur0zghFScI786jNnajN98eW1mVrCMvkEWJusmZJGPW6DHtbsmkvWVkzJwM3haZbmh2XM0VzkATMRDX3EUQEUeNsW0MaKiE8/NDM0qSlF/K4MykHVdH4scFR7zpDomo7lT4UpDzF3KCG19s+6aa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766420655; c=relaxed/simple;
	bh=XVItW6gSKcVHQwKm0pZtptoh0/iOSe212L7bTsXr/iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHsI6PIDg2gpZbZH60irLBWhoiYvYxXoSddxNeGddwEHcyi85dHEKh9cHuVg/YzX57xjbRoJZv9FkZ50EKM7+r7COVihoczTATzgPdPTB7jfiWF0Xa9cVO36R/X3qT3iJfH1q5+1aNoStoUz7Vi5W36aViCcEq/s/hx54jNsbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=TxqT7jlu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="TxqT7jlu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so40039015e9.1
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1766420652; x=1767025452; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLjJfObP/K+oUunUOwA+6cGq02GgqBNfpHQK+UmjiP0=;
        b=TxqT7jlu+Y1s4dNGQIWZ7/q++1sDj739NFL6Hzqoe5WUpH0h1Ip11W6JqHKD6XeZqj
         VJTRDTsd7Py2wasMIx5/pnPwEGahp6sA1N1ECd1TgglytjpzMr8CrlqOre7YfcrgrQqL
         bSkfxVp5DDahh689BjlCBDD1a/VDqrIe1Ui544tynOmVBeWcxZxwnoyFycuBIUnFAY99
         snZbNmZQ0pj+Vbi8BNwCG8tqxz2erX8qWgRRpZ8W2elzbwgi/I5RpD+HZbgElE7c8mUI
         mvfqeR2+lAL42u5IPdfr/Q34z/RqarMMS7cfvEzsua1y7R86B0UGZGFmz2NIjO/TNHtG
         +qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766420652; x=1767025452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DLjJfObP/K+oUunUOwA+6cGq02GgqBNfpHQK+UmjiP0=;
        b=GNzW9UWdWhkPnaHkmdkLf73QRaIiARRrYjsaCZexBaNNlc9uuuZPZjdxWRvK9fr/Xr
         pMo7Hn8BfkDpDU5SCvS2CBjybWBi8W5Yp0Ep5PcE89kFCSNYiUucCsO6RYVCKYWJt5yo
         XTTLOLNKVMbn5ZwKkrpfooaE3lFjctpxK7YbVBWZw91A5rUVWESfsAmWtVMH1ZuM4Qb4
         f5hlCo1Po89ZKli8HU6o8ChHNVhlTP3mXkBfeXU9VNrfdBOj5Ltb53o/S8xqenKCvM2B
         zU8DfefpbeGYKz52+dkDTuNj/1WtseEUjFSoGQYsaNIN6UOzrw6VqMmsRqJ1EnhJlSsC
         gJMA==
X-Forwarded-Encrypted: i=1; AJvYcCUTCv0P2dEYCakfWoRqnsFAIoPvqyS2oTJP002CLrn0mBxTsH9cfVeZWCZDbID0yakMuPj5NZQSAVcomVemOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg2rXlhv0x9G+Yphe7oCT1V1RMb4VX4s/XnhVI+pWB/5VbnDRH
	frBgTDqqY3znn6Wtv0L1OgmmJbunCaQybmkeq7A/Yjce4L6DH0J6jDqmT2nWoxUfYp2VY6EQ/w5
	wOHKH1dIfPpKIQfXW36WcpNZjc+kU1ypQhaELSDZbkA==
X-Gm-Gg: AY/fxX7ZyeD7oNyvS/b/2IBVv7sJY/i0r3sWK9OnEe4ACuZovBxGrskFr4WDCtPWwkx
	L8CwErZHr727XpfLrZ3rJHS1gw8IsOeguiLu+KmsxqluW9I57AK8bbRsUhYWUtj4tIxuJnWvlGT
	EjkGzSfd8QWRV9xt1L0pqEXPO2EVyyOGUPpUaybxhut+Trm5xZE1GESN6UMIvbwG1Sp3WaShfRS
	dzC+MXyQMWQgqKo4kZ8SWvpnyg6ncNpK/AqyH0eVGich30saIgyUJ8YT5Lql8NRbf3iY1gPzTHR
	4vHVqAtIjgsDp5XusP/artN/usKwutscknZC
X-Google-Smtp-Source: AGHT+IFW/UBY1GDGZy7+JOBpHniCxqKE76N35WUggR4qMT49RPhicXeZeNC8NVwnBV+j+R6YmNXQD2WuLXhh6A7dquM=
X-Received: by 2002:a05:600c:620d:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-47d19549f5dmr114996105e9.10.1766420651686; Mon, 22 Dec 2025
 08:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com>
 <abdeaef1-e6d4-43c3-b8c4-d5f0c645a169@app.fastmail.com>
In-Reply-To: <abdeaef1-e6d4-43c3-b8c4-d5f0c645a169@app.fastmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 22 Dec 2025 17:23:59 +0100
X-Gm-Features: AQt7F2ru5QJkYpqy-M7Zh310tyr-FS5keGw6oQRiOhDRRgbfqq5wSsUhJLfU_As
Message-ID: <CAN+4W8hAqVxbr040b_+Q-zF0Dv0utoj_UfwH+4LVk=Vx2TTFZA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: console: fix lost wakeup when device is
 written and polled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Dec 22, 2025, at 17:04, Lorenz Bauer wrote:
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -971,10 +971,17 @@ static __poll_t port_fops_poll(struct file *filp,
> > poll_table *wait)
> >               return EPOLLHUP;
> >       }
> >       ret =3D 0;
> > -     if (!will_read_block(port))
> > +
> > +     spin_lock(&port->inbuf_lock);
> > +     if (port->inbuf)
>
> As far as I can tell, you got the interrupt flag handling wrong
> in both places: port_fops_poll() is called with interrupts
> enabled, so you have to use spin_lock_irq() to block the
> interrupt from hanging.

Ack.

> > @@ -1705,6 +1713,10 @@ static void out_intr(struct virtqueue *vq)
> >               return;
> >       }
> >
> > +     spin_lock_irqsave(&port->outvq_lock, flags);
> > +     reclaim_consumed_buffers(port);
> > +     spin_unlock_irqrestore(&port->outvq_lock, flags);
> > +
> >       wake_up_interruptible(&port->waitqueue);
>
> The callback seems to always be called with interrupts
> disabled(), so here it's safe to use spin_lock() instead
> of spin_lock_irqsave().

This is pretty much just copied from in_intr which also uses _irqsave.
I think it makes sense to stick to that for consistency's sake. What
do you think?
