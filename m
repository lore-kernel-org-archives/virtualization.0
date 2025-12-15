Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60587314B84
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792316; cv=none; b=UAFA301/W45VPQ4LD9r6V0hdwG0KGEoimKTncYqD4h5piHh2LkBbdciwhGm0CIHaLmRI8UXRNihwA1d/rGw1kU1pFlRNz90tNemEjH1UyXMifwPBzfOjs7uJmeczOV6HTil0BAWS4A1vFf6PdgobVLfRP+f8OMUJIaivH1iX3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792316; c=relaxed/simple;
	bh=py20VzeO7j/QB6qMm6xLzlggww5gOxrte3+t5KZJQwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYLWvQ6DZiI7GGADBF0SUU97F3Lr/rv7v6PTDbIlxkkCvCmoik5vL0pHTn414RhCTIsCXAayJ9UprcAeFkX+eDSoWjTAVyb/61sTc3NGkMtNsmHciXIBt8zTx2blYEf9TkoFM2I5fxHZ70TAsjnVIlZzsSg/czEjoX1eo3uO55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=haeI5S2U; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="haeI5S2U"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47755de027eso22573625e9.0
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1765792312; x=1766397112; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvvSf6i1HGJ/13NNbbzE4pyxJvNbzDgbQuP94gOgc5A=;
        b=haeI5S2UsZfy5bC1OzDE+eoo/iafDK6LsyJb6Ok/81pMigUlm2oZ6wnKACLic0rBrK
         l/q7WjPc2t6yHkJHPMQLUmUZMzPMbGr/YGkdj7yvihEbYZQCngL6bISCTeQYNduTQt+l
         hcdWVf3JlwXxmhe/cUnBHU1kjd64y89HfOI72x9t/yjLF+ccCBY2UIagiDL+6P3U0Ji/
         WODx78UZ6CQXFUiMRQH9kr0F3EViQ6ZYwLyXw+R9IC7f7iH1VgofzdlmI5HkEB6jaDGI
         YnKjWIijP/RRHYuXhfIeixZtT3eBohM5qK/c/DsHm7d82KEN2BoCcbiTXqeJjH86O3hf
         ruxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765792312; x=1766397112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvvSf6i1HGJ/13NNbbzE4pyxJvNbzDgbQuP94gOgc5A=;
        b=kTVHno1qYrMBDvZ3DQa+x7ciFydPhRq7q5j0ZDSnpByu8EXhPfSorePvbKISisAhun
         uOBu8IoTQ73gZc5EslXAUstkb0ELETxvO/qiEBlgzikiubBfy3AJ/jkWMpazhiFr1SqK
         inMgrkgucnD/AKNu+cKq95TAFOyBY9TIr1IdSOJLELeWbagF/wBi22zA162k3uNklXBp
         M75fKIcxeklVsQOUUXB0Rp19uD5f4W8T9pzQkLu0dQgOOehnQKg+1IrYKEwTltRtw4pB
         TNameBSEvdyjpSvLsSNYZlkl7nzyL9N3ZKDll62Z8VVQ4J0nCHZhNLCN21JyHb0MxCSx
         zxNg==
X-Forwarded-Encrypted: i=1; AJvYcCX20tfuPFWKXdOIoxqZO4dY/sLBElftvMIeFzdrFDaY1stA6UwWdYWcuPnEoEjEVjVRkeStN24WC6HBd6oKLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN9fpWbmoZk0GVxb5Yo0e2owO36yVpS+qSFBh97PP9rGCpPEJT
	uIpDy8P8e0x4zWkrB8r/FMS58y2szAFAWQsApjzghG6iDMezqvkecPk4SaGGuMk3N9+h1whqjD1
	pKw1qeLYxdbQMHsyAofXNtFPY5nGC/eeXzo/DfDzuZw==
X-Gm-Gg: AY/fxX4RL1mC53vZ5gtNwEHHkczIZAcQI+G61ZvURigJMZE8GWa8WLAVyx8SVbPK8AF
	CBybuMK2k6eVUAla2ev+qzvIdb7ZtVDFgiJVQewaOvGv2Q1+xYyr0GhJrtVr9ZxPbcimfAuygm3
	n5Ilk0xGP5byvb1RjFKbpT0eoTg4VpXhZku4zwPZ1Y9zIufXuMOJil0+TbFpmTvk/JQYnI3E8ES
	ZjFMQfS8sgrjcFvFwgb7deGGSYQH3Mx8jdJB0hScKroMiE3fdtiRdDedHwDAmHiED7IfWdnTWUk
	YMNLFeLy
X-Google-Smtp-Source: AGHT+IHUP5H2uq4/hCpM7j297jinVwa9e967yNxde3dSZw03Lc1hclWy1nN4s7WU7YlNfR4LgQFhxHRtm02SD02Gs7k=
X-Received: by 2002:a05:600c:4f89:b0:477:7a95:b971 with SMTP id
 5b1f17b1804b1-47a8f90c5b0mr110608905e9.31.1765792311423; Mon, 15 Dec 2025
 01:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAN+4W8hLrR1B1pNdDXiVuzoJ1q8Ta1kjV0v8vKVEZeHdRFKGcg@mail.gmail.com>
 <564165392dfefdbb6e1739102ed80c3aee92881b.camel@kernel.org>
In-Reply-To: <564165392dfefdbb6e1739102ed80c3aee92881b.camel@kernel.org>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 15 Dec 2025 09:51:40 +0000
X-Gm-Features: AQt7F2qr9d5mrCrdcyv-R4ieMqHjue11b8pJw7D1k3yKXXJYbbnNaF0vWmdpgS4
Message-ID: <CAN+4W8j004VeXm8gVGz=TJKNzt=LS-UKhRVRew1iLLiKxYPSSQ@mail.gmail.com>
Subject: Re: virtio_console: lost wakeup due to race between port_fops_poll()
 and vring_interrupt()
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 3:58=E2=80=AFPM Amit Shah <amit@kernel.org> wrote:
>
> Both port_fops_write() and port_fops_poll() call will_write_block() for
> checking the block condition -- which is whether port->outvq_full is
> set.  Even if buffers were consumed via poll, outvq_full should just
> return false, right?

Yes, it would. However, the problem is that port_fops_write never gets
to that part. It is stuck in wait_event_freezable(port->waitqueue).

> Hm, does adding wake_up(port->waitqueue) in case 'ret' is false in
> will_write_block() help?

It would, but I think it only addresses half of the problem. The read path
also calls reclaim_consumed_buffers. I've thrown together a patch which
issues a wakeup from reclaim_consumed_buffers instead, which seems
to work.

Best
Lorenz
