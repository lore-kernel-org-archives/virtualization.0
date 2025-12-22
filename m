Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A122FD69E
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419563; cv=none; b=NtPzd63CGTAFoN0hpg/7MjQhiwma1yRW76ISBC23mcVdOBcp6wIDnsx0XaHmTUU5z7ZNZQWQFrXZBDMlzxs8z1TSoVF2F+rA/tn5l++4mo4vKqo3XXp8lTo7reUJTGgl3xIzuvItDQGPZBYd36/8AqrQ1ldgbPdUgtOXjPscWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419563; c=relaxed/simple;
	bh=9GSybY9zlgbwOL3N6pn11FM5FIhBxpAoCP7ajx3LDk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8tGDeZDwWnPEtAO41StjkH2ZDza0KO3vtsah3WjjN7KooiOHoRlgY5C7oxZWBNAz518drNNbGuX7A5IrPWhizkloCOI+VP3fN6bDg+eUU3QBI0zAtuiKCGEc4unHwZperwDS3ZOYLj3P5ZUFdjl/jfHON3AXupm4Fk5UYsAboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=cTyUmnAR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="cTyUmnAR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso26405525e9.0
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1766419559; x=1767024359; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GSybY9zlgbwOL3N6pn11FM5FIhBxpAoCP7ajx3LDk8=;
        b=cTyUmnARIRCTwD4LfDUT6SE2n4d+2EnHAGVExQanQ0L6q3l8OkGfnTKG+eAw0EK9R3
         V7meZY05xJdX7JaGUncCifGC4E2mqyI4XDvjH2R3VP28re4lgDFaWc5+0DSPcpFBX35p
         SSEYdnHBnh92Cmh82PVnhh1wPNxCmOFXmexJysqGHpRfX8GNTmtmkVuPkH3OzWWiIdfw
         wlPwcxV5VDnNywXpZXh/VOdIuFMHEfDzPNoGLZ+RCASULsBNMIO3WHh8fpQRcYt4/c0a
         vI/aDg1K0FmshLelmgStz4if6MrCb3FNIiuHCSlW4n22v/rQAEkxc9K1+YkOdybozqyd
         WaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766419559; x=1767024359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GSybY9zlgbwOL3N6pn11FM5FIhBxpAoCP7ajx3LDk8=;
        b=VwMT6/hlyQAcHYj1uT1vLkZ79RVSlfDD4Fpv7Nf/ZAwPt1JXYk0LjiUCur9os8PISP
         P56f0HI7HEM0cFQ5eznQo4BdoNpATbyjIqpd7CouYjo7ohHPgeyekLMjmSGPl/ywy8Mf
         XTAKfu3aaIe8XrQsfUhiVLBRF4ciEhrPqGUqcwYm4NQ5iKdrkczY0+a7KJJNKMoprOdE
         TWBfCK3dxzdoI7w1hYo2p9AxSXz6wr/kKWlP7XFPgAHJKvvChEjQIH4Ju9d6eVEXYjF7
         77nU4tTj4+oz/m+74pl6vjQSz9PGXs4jP/trOXxXobd5Ux+bglY2xVWRiiPdAkggOG3H
         9a/g==
X-Forwarded-Encrypted: i=1; AJvYcCUInkcP3C1eWyIrv5Vl9mIvrX8SRLChYOCNEQajP66XcvrfB3T06vXccyzj0gjNLeZWEJKTpaTX/8Tr+dTvRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi7jXAfcBMe3O9lkynTAjg+kG3YVxY4FRnuxidvMSNPNA/hqDr
	VrNOnX7TbyWIsQqcAsJGYQhSt5in2YPPC9BYt0+JaGfgsHMZXKJoCq1MTmkAx3BCfk3LGbAXRxS
	8QJF/OuH+uhsd21TqftA4EhDCl99gSEsi76x4lTMwCg==
X-Gm-Gg: AY/fxX67JX+zFD4c4l7ya84mEVMV6o/yUJEARTj96gjMpyJJR3kYbdyNDJnK+d2sNE5
	yNOwxxYf3lS9bxbRX0+UQ8Uv+LWXmAmOOdgkX1d/d3NvdUBHdP2Zowp51ZSn14eNCHpSgT8TZsY
	axwXkn6Sc3wI8dsDeytfzaKGR85ZJ1PYljcq7ntF5mkkYdT6H4HLcWT0bGNr7ymrDSFJNDiPqHm
	OJ1vO/TJg7Zsd/QP61xTNe+Ablt9SfAsZisplJlp7BEomgdLOvw3Cn65wPpquBqsR5f8N+gS3NM
	df3EoSPWvb49vcKadZQwvFvigTxdQnLVU/kO
X-Google-Smtp-Source: AGHT+IF85Jpy061efGYrFXdwEVD75nuvaquwiFbOkB8x+e/DL8d0oZJ8a+QFPrbIG+XdyRl1LA1C2FguSGaSOO7bUyA=
X-Received: by 2002:a05:6000:2385:b0:430:fae3:c833 with SMTP id
 ffacd0b85a97d-432447a27femr16821050f8f.7.1766419559533; Mon, 22 Dec 2025
 08:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com>
 <568c03e9-b30d-4655-8771-f8995f5a4ed4@app.fastmail.com>
In-Reply-To: <568c03e9-b30d-4655-8771-f8995f5a4ed4@app.fastmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 22 Dec 2025 17:05:47 +0100
X-Gm-Features: AQt7F2ouiK0yA5JohVYm-_FB_NaUn3PWwZidZ-lhlah2f1JA58OcO1oLH7qLzw8
Message-ID: <CAN+4W8hrm8k9Jo9MDPRd_4-Ak80s3Avnjw5MNNkwPVai=iCP0A@mail.gmail.com>
Subject: Re: [PATCH] virtio: console: fix lost wakeup when device is written
 and polled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 11:49=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> Is it always enough to wake up only one waiter? From your
> description it sounds like it might need wake_up_interruptible_all()
> instead, but I may be misunderstanding the issue.

I did some digging into waitqueue semantics. AFAICT
wake_up_interruptible() will wake all non-exclusive waiters, and up to
one exclusive waiter. In our case all waiters are non-exclusive
(ignoring epoll with EPOLLEXCLUSIVE).

I do believe there is a different way to fix this, which is a bit more
elegant. I've sent a v2.

Best
Lorenz
