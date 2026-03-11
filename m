Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B839271471
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219806; cv=none; b=eyLrIw5/d9k7E66X4Urqq9bOXhkA9qqZbVgSh53Cz+v3acgJioI4wd1OAFUyJLCFoiUvz8fpCXSicMlVT/yepX/6oM2rBdlrswM+ltuq9rvLoI5dFxONfgnLmr+sRdc0Kb0E28jXJ37jHBqV70d5rvczLKQXhQqRqryUFxHJESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219806; c=relaxed/simple;
	bh=BQS3KUm8OQjIX93jfxtNkYI9z4nKh5FJP1G049uo1P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1Qc1sUxgt18IBmegq2MeqBM8SNR+yN9E8DiawmiUmuMwkUffMfSnDAwLA04s+K6HX/QZehUdwU4l++tgwePd8DszL41J8O28qe9MiPGLTL6a9VnamKcs8vEi7AhQjj7U72Lk73QFVbUu/igX2QRGHaQDq3hjxim2DITG0zaUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvMXL9fb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvMXL9fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97025C4CEF7
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773219805;
	bh=BQS3KUm8OQjIX93jfxtNkYI9z4nKh5FJP1G049uo1P4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QvMXL9fbEAsrNaulZ315J1Jwr74orxch9PLbcG+NkNIuEEZkjRjKg8d1FpYOx0v6x
	 WyQpGjOWRgLCSqtlyJ6ZjD77lKwr3rxNfEFb62EqqmviGledmdl0Zusw4aMwwodATY
	 GVYVnRkas6jeWidLF1WGS8nrhi8X9FOFLwVYiiqSr6a91T1PfKGOFT1CGep57sIiGZ
	 DHH044TdtiRrV+i60+8BF5yMut2ojXWq8e3lqCBkCTIO/5psCGYyw3fC9kKZR3q/my
	 VnBQNOZPVZ0PZRPkp/A5UcJrEioFTXEKMdPdXohf5TqE9l8eRVDM+PzNIzpNUWMazF
	 W2e+PVk1xPX3g==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64caaacb9bcso13415602d50.1
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 02:03:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLgA3nyy6ef6plyyKTM6wAKti2isZeOBlgMXO9IU1MNI8fHuofgHBwbz8NdJ3aftAZeVj1zfGljo4jTOBg+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+AMwrsSKP3mFUupVLLMBWqKQXGWQY9/LhI/R1H5KlMJdsUQoO
	gcNYHZHtz1nnDaInknONWwBtJGVQWr32vzjQaV+Aukhd0it0Sh+/rsmpiNnRJdQ2n1eiMQvUP+q
	O2CI0SYnn0rP1XYctMoKX97Dcbz7PYA8=
X-Received: by 2002:a53:ec85:0:b0:64c:a63f:87a with SMTP id
 956f58d0204a3-64d65853949mr938325d50.79.1773219804991; Wed, 11 Mar 2026
 02:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260311025541.53814-1-rosenp@gmail.com>
In-Reply-To: <20260311025541.53814-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 10:03:14 +0100
X-Gmail-Original-Message-ID: <CAD++jLmDbs7aAbVnS3Y=xzYZuazkELxoXN-XmeMeJWYFwNAwcQ@mail.gmail.com>
X-Gm-Features: AaiRm51Dig3_h2M69qJOjOwvCe-yKwAZ6MTyR3MSK2Qyck0cUFVFycu9lBlp-gc
Message-ID: <CAD++jLmDbs7aAbVnS3Y=xzYZuazkELxoXN-XmeMeJWYFwNAwcQ@mail.gmail.com>
Subject: Re: [PATCHv2] gpio: virtio: remove one kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:56=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> A flexible array member can be used to combine allocations.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

unsigned int num_lines;

> +
> +       struct virtio_gpio_line lines[];
>  };

struct virtio_gpio_line lines[] __counted_by(num_lines);

I'm starting to get a slight feeling of d=C3=A9ja vu here, we
want to use __counted_by() for all
of these.

Yours,
Linus Walleij
