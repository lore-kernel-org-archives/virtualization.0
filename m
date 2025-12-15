Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECA312819
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797961; cv=none; b=jhVkNJL3TU54z1Ovlno8hpDApoy99NND57EImrPmtucIsBcnlt35Z9YqAKJRJ0iU259C85LzvpEvoCTSjNZlNRGsmBg3P3w8rQ7rannTkz7GhYPDya4cISvZKxJBG7cvGPxIx8clIK0it8jZBZ8rWDdhxgLGgZO1Bs/+SvT6fAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797961; c=relaxed/simple;
	bh=eS5Yk3WsjQ01y+LN+SGf9F1HoK/gz/CC55YPeGSjF08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ny3sQDVIZ3hqbJM5kZZrF4HaRIQsQG5iVU3s3WGiCSQhkgq/chtgFliHwM6mSYGRk0T4kYL8B1UFiMzbGNXccWJwFqzglj+CqjlnNhRCz/0gFAB3yjesFt5136aKqZGimELPHcwC+TQUJm890IXlpbGcScmhgtDQwhT3jG3pWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ggUIlXwE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ggUIlXwE"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430fbb6012bso747815f8f.1
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1765797958; x=1766402758; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS5Yk3WsjQ01y+LN+SGf9F1HoK/gz/CC55YPeGSjF08=;
        b=ggUIlXwEZXSW5KMP9xCdWQXb19nCcbTevsqjoc3ICfCT9Y/KrJCGpYXA7pH0rSNE2Y
         gcA9uQYPkwGwBB6TEpjgVQGYoM6uEO9vLtEUk3Di6UJ0+xAvGAbjEuxZB9+nForSEwGp
         yxGGoM6lX6N3403Z2iIPL0VFSx9hX5CVmGir4zBWTe9mGQsa+/2cLZMbvtibxZMP9JeT
         CqRlshX+vlIjHMzM5Su5X+A7VnsXaB34EWE/UfRUHSHKPbj/aoXa3zt+9opD1LDm3Wan
         4/ofl7iqN+iMaRxikWXEk0zYIv/fixW6pIgMb8zNIogA493WmZga7bup67SGejzp1LqZ
         Ob4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765797958; x=1766402758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eS5Yk3WsjQ01y+LN+SGf9F1HoK/gz/CC55YPeGSjF08=;
        b=u/QdpDYuPOmNxRkVTnsaW2ziJ1yv4NQDE6iyd7ONSk4Tb3hYedWIz1kzG8nBr1fiFG
         wVSTWR0otoLrAC52UxjHGtWBgobUXUH3n/lpz5HwYLJ+S9BTbakDFz8XqbUEYlbY/hjY
         prt6qKhpAul8oYsL+amIxMTfs9bPwTRwfJ04BjQaKcgujJt4qs18P/1ApLycnUACnohW
         Y7DG9yAEqKp4ZuWuYAQ2nBtFmcFpfDlcryuPQKEmT8KNyEY6qIRPir03OjZe/YZUqz8t
         f4EPWfU/6Bdw86DQ5bWsctmyO8AWn9orRxGu3wWPdlY83cFxBzSEIdcKhEG45NouqOUb
         Db0A==
X-Forwarded-Encrypted: i=1; AJvYcCVeihyiF8iUE3Xxz2fa/YV/llIRsSMQlA8m3VjujFxQIko+L+C/szB/n8wdXpUH16b5VHR3VxEBL7XeyvWqjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7jnkSOT10ib/KweOFce2arEHPIIOKMsOjYk1APnmRclxaKoA3
	RJFLXxrvo2VVfoFrIOUk5v4WuKU1KRBKWFt9FumeEmqwE4ZyhHCenITP+SKLCEkc6B+KaOcJ4PB
	VooeUNPRIR+KekF17L7TsgZ5O22YqSU1dBPDnqmVuCw==
X-Gm-Gg: AY/fxX7q1wLKHhCMfMN9m5q7DyZY561LyU1IwdB1q8idzWJrzXwV96Q5y6kyGiG+UQ5
	Q8Oidj8GIxqW/jiir8AIsHO/xgxkxbuVQ2mKcPLrukEQBGxEUFA2Rv48l3lFBv5bNj9r/xR7h46
	vYFIFah5NMoOVzms6RxIwg2eULsRMTYBGH5sya5C8KtACHsymeqOBhyzPnnJIZnuSMxm8KFaTw4
	BvQ5lFunnA3OtlNYXM0j5ifBVLxlS7WWHwaI5BaOEgsImvbShUvZ+CpXIEBu0DW0vgLQ/jY4NVt
	tQiNyRAF
X-Google-Smtp-Source: AGHT+IGpTEbxFK2lbEctOBKa+eg6LRSXnvQzjEerfHMFeh7BccrYevClP/yesjW8S2VYrdlQoKulhkn5RWUyk6KLBnI=
X-Received: by 2002:a05:6000:2881:b0:429:d6dc:ae10 with SMTP id
 ffacd0b85a97d-42fb46e2cf5mr11339129f8f.29.1765797957904; Mon, 15 Dec 2025
 03:25:57 -0800 (PST)
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
Date: Mon, 15 Dec 2025 11:25:47 +0000
X-Gm-Features: AQt7F2ppCg1UxUWVFrNxxRZ7iZQ7757p2GrbRAwSqIYOXp8taw_DjKkJQZ4fjHk
Message-ID: <CAN+4W8hzti6dtuNAEKGqkSXj5NiNhb54w+Kbq0kCHnW3yiXmLw@mail.gmail.com>
Subject: Re: [PATCH] virtio: console: fix lost wakeup when device is written
 and polled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:49=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> Is it always enough to wake up only one waiter? From your
> description it sounds like it might need wake_up_interruptible_all()
> instead, but I may be misunderstanding the issue.

Ah, I'm just not familiar with waitqueues, so that is very possible. I
based it on
out_intr(), which also only does a wake_up_interruptible(). So either this =
is
enough, or we need a wholesale replacement of wake ups? :(

Nothing in the virtio console prevents a third thread from entering the fra=
y and
also getting stuck as far as I can tell.

- Thread A: write(): fill up vq, enter waitqueue
- Thread B: write(): vq is full, enter waitqueue
- Thread C: poll(): consume used buffers
- vring_interrupt() dropped, both A and B stuck

Is there other locking going on in the virtio layer or somewhere else that =
would
prevent concurrent write?

Best
Lorenz
