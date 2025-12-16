Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165933556A
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915158; cv=none; b=PbfzjdGWmx+8fRMxsiiL+Oa0Z+DGAqMXbCe60sHJ+Cpc4OKvsfG6yPaM5IssxYprqTpBEIVaCqFluBQCc2NmxFQnHwQDSiKJXlDDuHwtz8jE5DRZqQFGNy+UeiN+wnYwo5X7TaJoq8l7+imh/MhovZ6DM+oW02FGAtWds0v+hT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915158; c=relaxed/simple;
	bh=vz6zEIxg/+wl/MDvP+RvMv0qeimFFpWWQmNPdyV4ahQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVajPJ09Lk+4aEqHlzV5YVWhzxrYBdi/XGhnHn4PQX4yBXhtnYogV/WT5rFwAd5z4l2Vh/fh+dY2BxrbXrqvKQb4O01/gnOf2ViAxxYcrUcd/sRkBqNFl+IbCSLzpPpOqOuKX0jhdn4Sblz5OTs9TrpFbo+Lt6QcMd/qu2ZMuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jeapqzk4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jeapqzk4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so61206435e9.1
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765915155; x=1766519955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjniS35+gFl94KgDPsESP+GSizMKZS5/qxbShY9gflU=;
        b=Jeapqzk4pcd92sOyTVcX8ViLsbZx4LESUm0Vmoygx2OMounTjCtrVre0rpARGIRq1N
         aJnh+LemQecMXsy4llc22+YGFoLfJGb5tbsCPDqcVHGCw0zWjsHOEytnJiGiHrtzUj2n
         QS/11gh3g4POMFpQCxo1cVKx5fwXQu1iMVTQ2PauFNcgmPSoIgPGwrqNzFI9xxVsvAvv
         K4O238nf/wz3Nnsxu69ro3YZOEof+SWWjGQ8L0jn4fCELQexfWOEwHHiqnPlvvrAtz+q
         yIDvZ/LwTygyT+pTzSI5E7yvTXhrVeHo+/DZ2M4gHPTpIG9UkJ1Ugx/S/Lb1gK/GXP6k
         9pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915155; x=1766519955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjniS35+gFl94KgDPsESP+GSizMKZS5/qxbShY9gflU=;
        b=LOqBrBDrHO5klft9QUjt2+PdH+Zyky02bgMSo3kKHRVzCXQ/SRHIZP3e2xNYxV3jdu
         Z/RFM+kM6yc3wx6BU6BSXOwOjrqd6WJGmTXuj3wDg3QTSSYNDJEvgXH/X9yQoS1EIWAa
         Aa5kws0xFv4+TdAF70AKadnTTvVf3NTGkZXfHlr/UkGF3HciqTR5NuNCqCf8jmxrvJYU
         bnIJA/Soh+l9xS4zte0KQfIKSiB6Iu8xElPSXIHiAj3O5fABTT+TfvVa7fvFqwcejoQm
         0sS0BYOZfnB1YycSm0B3KRg4d1IFG3RDqT63LNbDDVwB6ddLFxWrnF96accQqrlc0PGR
         9QHg==
X-Forwarded-Encrypted: i=1; AJvYcCXdzwWUPRh3AqyyWlPV2Wxvbgn04MqORf/MyGNatdwWv4GVHSZsvvD/4FlhZsYLAKsFhGrKf1N7tTo2UJ4Rgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzcUunBPnzVm+r4+uRa9kDX97PIMhRm2zkrzwBZSGbdWPyJ1PF
	gj00VzTw0bI2jUTajw8VBrWywpNqWDu5LxcBf/VfjrprOxmzdWw/r81r
X-Gm-Gg: AY/fxX4gXpjlhNSlqkncaj4OPPwvSew/B/RQddzXLINPPmsA0G9Wn814He2eusQgWui
	2HuodKG3gpPNZKZv8S163+sAXjV2EL/9ILxCfhyd9i06nMp7c29QjjrvaaUU0I7iuPad/O95QXK
	Hrz6rD1Dct3A6PlTypZ3pZYch8brDrqg4RC1skEKwTsV14qeJHocoH3ZEggJkPIBlAhyBSl69Jv
	6IBOE4AGsayfewTUkTLoysh9X2DN9e9P20GwttrjU8SgOoaHJHOGbRxhWPXCMhWF6xwzKca5ZoR
	pov7ELnDCtxhxF1wLD4iAwy6DNRGV+pz5SlE77G9tqXgZqpZvqtFaxYsKctKZmmUd4L/g6yxkvu
	+9E8G8295TAn3HDf0+uBXjlTz/axho5nwxCYRvpzKceraZ/5TObf1y3WHAETJ/icwgKKojkzyY2
	oRbtMweP2Yl3gOA9DL2MknWHCJzuCPcPIgm4y7K5isE15jMkjDQ4IgHUT1ZA8uH30=
X-Google-Smtp-Source: AGHT+IGkMCP0kONGgG89SYNUeIIN6orwCVUUHEl6uObTm3wydLwUSISgvgOvaVGUZQxtmSBHQ8CSsQ==
X-Received: by 2002:a05:600c:4595:b0:479:3a87:2092 with SMTP id 5b1f17b1804b1-47a8f9145edmr152180075e9.36.1765915154784;
        Tue, 16 Dec 2025 11:59:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ade7c3fsm779077f8f.26.2025.12.16.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:59:14 -0800 (PST)
Date: Tue, 16 Dec 2025 19:59:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Ingo Molnar
 <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-block@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Denis
 Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/5] x86: Cleanups around slow_down_io()
Message-ID: <20251216195912.0727cc0d@pumpkin>
In-Reply-To: <14EF14B1-8889-4037-8E7B-C8446299B1E9@zytor.com>
References: <20251126162018.5676-1-jgross@suse.com>
	<aT5vtaefuHwLVsqy@gmail.com>
	<bff8626d-161e-4470-9cbd-7bbda6852ec3@suse.com>
	<aUFjRDqbfWMsXvvS@gmail.com>
	<b969cff5-be11-4fd3-8356-95185ea5de4c@suse.com>
	<14EF14B1-8889-4037-8E7B-C8446299B1E9@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Dec 2025 07:32:09 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On December 16, 2025 5:55:54 AM PST, "J=C3=BCrgen Gro=C3=9F" <jgross@suse=
.com> wrote:
> >On 16.12.25 14:48, Ingo Molnar wrote: =20
> >>=20
> >> * J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrote:
> >>  =20
> >>>> CPUs anymore. Should it cause any regressions, it's easy to bisect t=
o.
> >>>> There's been enough changes around all these facilities that the
> >>>> original timings are probably way off already, so we've just been
> >>>> cargo-cult porting these to newer kernels essentially. =20
> >>>=20
> >>> Fine with me.
> >>>=20
> >>> Which path to removal of io_delay would you (and others) prefer?
> >>>=20
> >>> 1. Ripping it out immediately. =20
> >>=20
> >> I'd just rip it out immediately, and see who complains. :-) =20
> >
> >I figured this might be a little bit too evil. :-)
> >
> >I've just sent V2 defaulting to have no delay, so anyone hit by that
> >can still fix it by applying the "io_delay" boot parameter.
> >
> >I'll do the ripping out for kernel 6.21 (or whatever it will be called).
> >
> >
> >Juergen =20
>=20
> Ok, I'm going to veto ripping it out from the real-mode init code,
> because I actually know why it is there :) ...

Pray tell.
One thing I can think of is the delay allows time for a level-sensitive
IRQ line to de-assert before an ISR exits.
Or, maybe more obscure, to avoid back to back accesses to some register
breaking the 'inter-cycle recovery time' for the device.
That was a good way to 'break' the Zilog SCC and the 8259 interrupt
controller (eg on any reference board with a '286 cpu).

	David

> and that code is pre-UEFI legacy these days anyway.
>=20
> Other places... I don't care :)
>=20

