Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AD25771
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535006; cv=pass; b=gSGSavbyeaDfayMn8Wrrl6usTbkYofWiDXD4S2X5Hlbvc3+2HcZH4KyfX8eYjLZC+FZvHCHVbInhyiE1NjnB/+VjYPZnOJhKQhGSauJyTNMyhF+qq693/AlOc5/BX4WRn2uBO/MnYQ2glUJL8CHe87YI2Rtai3LFmqPaSu8N/PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535006; c=relaxed/simple;
	bh=2gYCKfN/e4XX88DqEAREwJyHD3XEyYy67FJpt4Q1jeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxWUs7MhGZ6o+uLWWDeGPy2FpwJ9DYSWgfnzAnBQBoHgtJinlXJkqP3Z3osvccVCW9MkTegIav9dLSJ7UFJ7UQFVwAK53thwQoT0zfNlKEMlyLpON/2cU3pj+SJdHpmtpokKu9YCv8HS6L0+YYbh7+naHv8ISz3oWO+/0zEPcTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s50dNacB; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s50dNacB"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a7109f568so19011927b3.1
        for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 10:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776535004; cv=none;
        d=google.com; s=arc-20240605;
        b=MqzWk892vjVt6SMrI4YbH2shPO9UcRHgAt/6QAFYZJzaQHWjbEeRiTcbW+mL7VxoHe
         1R200EPLlXQPIXm4MYOwJiG2GD4AnmXOKfQdSiWeSM5Grz3LyApFmxwpqGf9IPo/Dymh
         hw0hHNJVYEo3tJeQMJFc0PqIoNgAXLF6HFVZeN8voEPPntehz/OFWe9+USWoWZ/MryST
         2T0BpQHXXiKmWEdVxZLLN1DjQeJFvawNL3WjSHsY+5Mz9qkCCkNg2Gc50qShY+2WizeQ
         EekQwv05JC8Nck+W5h241meRm4KOvf7adKxYR/1+uEN+uPuZION8JWN8ybaanQTG8ff2
         gOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWe1FcSJQcmVIDnQpqvND6nwI9rOq1fLeSKpef3W+nc=;
        fh=kGUD2EQURlqqofFei3Jg9qZdUylzrGqK52kNlxcyE80=;
        b=GIW1S6p4SgyMPYntq16biciWGr06uroJ1Gg0yM4+UJ12r3IFkKch9GHFAUby0TseOz
         ItK9hCuY2x+rruDf9m0/o30JZwFI1QW0nQmtX9xNNA4x85u7Cq7qWN7TldB7rO+0t7xt
         Lq2GtLq0dei6K749Hbg3FAfTx5/Udse9Oj/grRoyc0ZtDQ1iMNLXQUDcSRAzLzOZgybO
         QgDIuTzb9MhDxwTfVrGkyrC22wVVG6yjkVexm4DPRNqMABJENwp5KYPyNstYx9jHnV2U
         tCuVyl0pec0kyeHBtkhiSerHSnyWodZI6dXY09TIqSefEBTQq+irH/6MFP5cDokAt52a
         mepw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776535004; x=1777139804; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWe1FcSJQcmVIDnQpqvND6nwI9rOq1fLeSKpef3W+nc=;
        b=s50dNacBdBGw/vRjo/XGPRCKgce/1ILt9bwZqqrgMq9ZQzjZ6H1S78SL+W3JB0nmKq
         NafF91P2BGzc6Xami05xXZWr3bP96UQ0r5DP0VIziUM9iJYYaFRVuJgDIRhOUg3q8qRN
         dQygDspyu4rFNipPvq7/8UVCOeYWWgZhk/KfuQ45+6OCB6hRm7oQJpkjOz5rPRimCumq
         suieMn+VThftKyqQpQb9DfMdmfarSKi+E6E1f3wfNIHNCqSEt2E7GD7NWGY3Visnia9e
         cahDbSsFyjxx105MkiLuDAmEjpfLy/YJczaIJtlsijPdJcLxUBmeeGDt/7adkpnnx9D4
         Lxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776535004; x=1777139804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWe1FcSJQcmVIDnQpqvND6nwI9rOq1fLeSKpef3W+nc=;
        b=poX9tGJ1aRi7ZimQ/vuoqIYyeiLFTov+rtcgB9MJNcuXHQn/o779QOvQXJow4cqJEW
         fStRwFUL5UHMY4CvT2j20R44LYeM4RI15xKGvfGgFOeWiKiCvZMBmONUGOLS6R7K8s87
         rqyIsE6r48cBaH1WnMAkqXh2n3t6cI6i0qlcxd54YbA9x9lXnLlihxUOdaRETc3GDGz7
         YruvmAZIlQ242gtjYcOtlyhkqEvROHJmZ+xPEQAPCL2GzEcOXDTpJmcoPC87PqajcKYG
         9EkV6L2WMMOpxSamtRZOAk8VZVFsJ4q7Xr/AN87NSQDOFQI20F3jE/Fb4sfH3YefSmnt
         sX6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+7HwqqfxpNdX37qfX4YeQ8l9RPTgUVPe9h008ULx3xK9O06XzbmMHIXhzvDJtQ35bLzUQOWoCpie5F1cjjcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcgadVZci/bORna5kcyLjU/IwWGRRsgh2bAA6PeIxEKi+cyf+8
	Lqodsk/usqrTxCKJOAwYAVqKhPOEGzSLACOyiWziORAkc7msLZ/+bo0cg7nogImLyJljLpS5Q5Q
	0HTQneQ0/yPpaZMv5nVJF49Ax0VBtl9E=
X-Gm-Gg: AeBDievnX5TcAXfWsG3sVPWw6RH3kBIUaHKptCtO5OfZ3qTzeejBaHS9KL7TS2FIVu8
	qBCB2PSTO2hBJgRZd0wNBaShwqJy5U+WPOPM9LG9uVveIKD/9ys6a6QZQKIxw+/yTEYH8MjnpJV
	F2IvbkWnF2Dasz6SoLqAsUxl7hNalaYUhCVA49zqqHSpVpA+5ilHgVsl3lCfwmhJzoZ5yy9LPWX
	ZSzrTHn4G36TzoiRwJ4ASJe0XIwOmGbE7Ahz+wJ6VhGRRy8Zh1E86T8PDl5OsoR1p23tWRUXvlE
	jPrIZthsKKaGf7GyqTIhtrJVegcRnohB+eLSPZFdSsoBYSg=
X-Received: by 2002:a05:690e:430b:b0:651:bc3c:a91a with SMTP id
 956f58d0204a3-653107ef604mr5520585d50.6.1776535004544; Sat, 18 Apr 2026
 10:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
 <20260418150613.3522589-1-michael.bommarito@gmail.com> <20260418131110-mutt-send-email-mst@kernel.org>
 <CAJJ9bXzgpAR3Gm+mZu=mZJyUrc6bpd+_crOGa7HLxteKxw1DzA@mail.gmail.com> <20260418133030-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260418133030-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Apr 2026 13:56:33 -0400
X-Gm-Features: AQROBzAV5ttOMOY0D-fVTLEFE4Sdx8UKW8dKkYhppNEnNaJe651V_S4o9gva_Nc
Message-ID: <CAJJ9bXzgXZ43DLOfo2EANuFPx+DTyT2riCN_MQyM3jM9kXAg1w@mail.gmail.com>
Subject: Re: [PATCH v2] hwrng: virtio: clamp device-reported used.len at copy_data()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 1:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> Maybe we do I'm just not sure I understand how do
> all these checks help, and for what threat.
> It could be just me being dense.

I also don't feel confident about how much the differences matter.
For background, I think I lifted the pattern from similar issues in
kvm and io_uring.  Your point about request_entropy is right either
way.

Maybe we'll see if anyone else weighs in over the next few days and if
not, I'll go with your shorter fix for v3.
