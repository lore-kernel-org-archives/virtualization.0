Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769A2222D1
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972245; cv=none; b=c1rJdBsOH9r4fGgUNNVvgcIL24LIGC2lGyY3QiLXXuLAanw/VBPmltGBXxhQvcXEbluDJj/GKecdX0yQYEf4u8JvFMKClvDlBSarxPm/hATlIPdcfonpveb0V95zni0eBWX/BUbaH9NTcWjR0/qFVD5iSbp1rwzHIyKWvPe3s7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972245; c=relaxed/simple;
	bh=DJ1yQU+46cCei0IZcPQ5UVD/tR0uFMzgc1ttjjlcKME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWM6uvkwMdcZ7SGHZBspb+oA4TM8wNEIPX28cSi+tS50H83R1A5oYfRfDTVSblW2YafoTfLduL0wSvqod6JKT28zwqi7gI0dA4uYI96qokdtSHtVUKSlr4NeCUpbsg7kPo9hNpxTR5H9Y7gNNNXz0gGCoKjBoyI2Uwgezmmf93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBJVOzhj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBJVOzhj"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b079c13240eso755206666b.1
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757972243; x=1758577043; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJ1yQU+46cCei0IZcPQ5UVD/tR0uFMzgc1ttjjlcKME=;
        b=eBJVOzhjboaTw3Q6JARmoh7Xp+d3e9PLxVRLV3DWQh8oECp827pVyHT4Qer4urywEZ
         NX1OHqqy1SDc7ixTXFN6uHNLbcCIs6xAzKs8GJ3CN+cGo9d1UEtuWIeYWChbLq7JN0md
         k9dWpLy3Jl0+6RW67dotJxW1oz9uJvGkE65IEnDlTQoxHBhe0fCTaILzvTy/7GZU80Pa
         CTIAxSHQI00XKKvqhCCFOeVRolPcKPiWteY7In1q55OCmV4ZXRD5cwMZIRgKOCJASLJx
         1WLIaIe31KRFpp6d3sl/CoMIqbN9g9i6/oEcrPXbF7DrUjs35G6WimsxzrMO21p8vBeN
         WgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757972243; x=1758577043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJ1yQU+46cCei0IZcPQ5UVD/tR0uFMzgc1ttjjlcKME=;
        b=paeLRfjRHmgnwEblfpWWD0aULUxGMgWkgCCybLeDth0jttOgwo4Ec2PQKmwElmN+yB
         C5YZc1qy2S/0MHPVdrL6WL6RKKDIzsvRgvmH/jBFmr9u91Vj6IZzIcBmm4j/kl4yGT64
         hmBbEEM0ryBsEb99Ms5SRV5nmkbqgn1utQj+hYItePZC+Nil50aTZGxQRWCFFb9OOTcS
         g14Y4oz9W4kjop1k/UlytTUDmRaP9VkX4tuq3ZEVgb1+4ZicvErey3bib8QdVKEXFYsb
         Rm1H/7EMQVbPJDCzIAri7ap6y3zolKhyVjqX5naEqHEaskgm+LYwl727vWwyqB7qiFt5
         ikSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdnk75zKoN5OomBJl/Tb1z5APyv7aNZBNpQC1wwg2x/SNc6FFmBYTjNKGK/UjVhw/MhVwzjJlWTaL94fwF+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTwyDbHRAwhd4MinU37GzqBOeGR+e4CGuHxdLCppS2Kk5eN+1P
	IJnrtRgVGc05XBT/EQVrIfQslM6NMH5fVOFfoP1aJTy67oTymsrSwAMR
X-Gm-Gg: ASbGncuAM/XpYHenBqExXXjpHhvOwH6usc1ilnGIAnx3R4Z/tUEmYl9KN8iDudOV3zI
	nuKwXoPwzayvsXgLnd2fBSj0XDXLd1svGei82X0WFCIUREBf6M8cPEtDawJgS9Ov+gm4BAPcqHv
	qeLlvKYBEs7Zf8NCY6J/cpclr/FqRRk7CxF2WpxTft5WfY5+W7Q8u8s1Z3kYdG+CIyGNQkC43Fm
	A+iSLeUT3B8zMxbuBIECTFMAXBbp0Tl9GUtAYusj+hHxwevaYK+NTofvUSKexbsQq3PY30risLW
	EAtu2LEhSRNOXr2x8cBkjLRTcHmSy+eZLoc45b91YrQFFB4cEg+I9ZZ6DNNeLSAI+bjOwaHBv9E
	DZ+B6O6Z8wyMCzuydDF/9KBVMwVlhEJw3NYNb2OA8o4VmmFwDgm/sX7imSn9J
X-Google-Smtp-Source: AGHT+IFfBqyi6DinH8aK1CrKezF5SSjD+j8kk98LYlSl2lDxgnVgV78RqDPTjc8dVlgIIWjUMVwdCg==
X-Received: by 2002:a17:907:6d08:b0:b04:26a7:f77e with SMTP id a640c23a62f3a-b07c3869126mr1366969066b.51.1757972242454;
        Mon, 15 Sep 2025 14:37:22 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da27esm1038092866b.6.2025.09.15.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:37:21 -0700 (PDT)
Message-ID: <7d29cca832103f70584a9bd88c32b77f508e9045.camel@gmail.com>
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev
Date: Mon, 15 Sep 2025 23:37:20 +0200
In-Reply-To: <32bc2a49fabd619ea7dcafd7f5d50fca206b38ac.camel@linux.ibm.com>
References: 
	<7ebfa9a5ec3f07506b3d8f01cd4f2a35e2135679.1757666355.git.mst@redhat.com>
	 <32bc2a49fabd619ea7dcafd7f5d50fca206b38ac.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

On Mon, 2025-09-15 at 18:44 +0200, Maximilian Immanuel Brandtner wrote:
> [...]
> As I already mentioned in the QEMU discussion, I proposed the fix,
> because I was working on a similar implementation to bring resizing to
> QEMU.

I couldn't find any mention of your implementation on the QEMU ML.

> Unfortunately, the patch-set was stuck in limbo for a while and
> now that someone else has picked up the slack, I've descided that it's
> better to contribute to the patch-set that is upstream instead of
> sending a competing patch-set that does the same thing.

Would it be OK for me to take a look at your WIP patches? I would like
to see if you did anything differently.

Also, you mentioned before that you were also working on patches for
Libvirt. These will still be useful, because I won't be implementing
that part.

> [...]
> I don't really care if this discrepancy is fixed one way or the other,
> but it should most definitely be fixed.

I'm of the same opinion, but if it is fixed on the kernel side, then
(assuming no device implementation with the wrong order exists) I think
maybe the fix should be backported to all widely used kernels. It seems
that the patch hasn't been backported to the longterm kernels [1],
which I think Debian kernels are based on.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/d=
rivers/char/virtio_console.c?h=3Dv6.12.47

> Kind regards,
> Max Brandtner

Regards,
Filip Hejsek
