Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEA30E0C2
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374871; cv=none; b=Bkrgtz9LgWBJD4ZbpF3HsFSHU2iIm3nmy/aUgcpj33ivP+OE+mdmM2O94U8u8UHyCGTmos3hr+vbYLNSK4IBeacAz1zBdQDGr/DV2qtHzYs2YokDwrZ0+FZMnFQgO2bZssBhZO1FNhFWpwdaPk5ilWq0VWKYKuHosHVSDdUYGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374871; c=relaxed/simple;
	bh=f+BaFGtPHeQlsb4c8l2pIyZJN2yb/O0m617A3IlFA/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5JOgdQS5Q6tf9C+i8219td/kWdUk24h4eeI3ih7Je9yTnKXUczDVLO4l9k5BeA70q+4NeZHZ2vzTWk/TivENM28nbUkpY9NUqL5GOQbNbpX0+tJfjBaVb0hYrOTk3bk01CGuP5J3maARtizVfP8V/L4glr4dK7r3wyRoqDP090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I73h9xgq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I73h9xgq"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59428d2d975so4427083e87.3
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 02:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763374864; x=1763979664; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+BaFGtPHeQlsb4c8l2pIyZJN2yb/O0m617A3IlFA/s=;
        b=I73h9xgqvjR38LLB3KFXdhS3Y5bc8rrjrLLjpwXZeNYwqAm+13xO9m9/XDeFCEoUvs
         9iWx/7r6gnWKTZji5BkbqfU9vBulyDn74H4Cre1Q1uAaLh02vMDyZCSWxvvSXsvdzIyC
         d8IJ7B7ilMsWoD7Mfq/pP3WICm3shYfTSMrrbGI0rrWMbtmr9Wz84adVdteEtNcMg8HB
         eOEOkceODP72pp7ojNBHtsfqizTA17FCmd1SIBiJTlXmJoLGM1xuPH9q81BuL0oBxzUC
         EEGEJIlq3uH5n3r+hlpHMCrq3eUJ+QCK1EA0/A70ggxWI+jF+QnLDGv69kQUQ5YewfAO
         /yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374864; x=1763979664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+BaFGtPHeQlsb4c8l2pIyZJN2yb/O0m617A3IlFA/s=;
        b=rbnUAA2RMtfIh+hw7nVR4kNLLAL3sqHO9NtI5SWACd2Tksfh7a0LkDKm8RGEJbwLtC
         u6lkn2380NqgpGyS6+pOn85EDg+KIdEMqQ2iewJ3patqoq8SSt/Y0Dj1l1gj1yJ4Mvkl
         tXzUqo3wVvSrkaPi+TM/NkBp9jjodSp0Q85fUPM8kZz7DYIq3YK83deFOUXfkuuf/ai1
         4Sss593nOUjAJ7qu0styILWOc5dxk1JUMe41KbUl4Z1cBHBUwpA5dA6nBFypzpCZ++sj
         9JXiMx2fZcK5qzBEbPz9AhtP7AR7GrRZI/nyQnnCipCmfXDg9wKq6epJh9nxEreM+WAl
         7eVA==
X-Forwarded-Encrypted: i=1; AJvYcCWLCrBfKGZDNsBS15bHxAJI+JHYAaRQbj9HPPQytRgx+p380OG+Q+6hd6+6brPceaCAkqDtknVTxfeBg66MyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNOaU8dyf5XsoiSdQ731HpnRhlBoRb6ZddjalsOMS1a92Aq7cg
	KBSn4mDgEPgcW/a3dXEC9oVR1qltmFXhm/dZIvOLbaHYU89wE9UOrVBnX0pun/pevKf+S401iOX
	hwIOzwUc563TRsiI2jz8oNUWaZQFy1QvrBH53YS3Eqg==
X-Gm-Gg: ASbGncvjFWzCd/hPVOxTW7zoPqgDP7OSZhy59C2U/zBxFdFE8pPgisJab6cQHH5HHg5
	GJwFxpAfKnfIlwgu1Vm8bMpR8J4rGyb06/aTlw/LYFjWaTt7kRemV0u9y39yvz9SJJ3rB3TU+Hl
	ZsE+x07HtBPxpO6OtOxH0A+G8Z7nuvPcyd/nzX63XiK/LwmK9ghYywBNYb/ttWhYW2+sfMIsxcl
	nPFOB5sncSBv3cppFQan0T5xZ1jtY6mrKSDWF9OSjsGBGbWUwmR82PZjif/9rpcUdbGrG70K3Y/
	kRv0snaALgdUpRy1ndjf8ZLI3PO1HEb4SqOWLFg=
X-Google-Smtp-Source: AGHT+IFXIgTe4SJHZ48jLi+uHGZcmCEw/cpMKQEOY0HFOX51oOK/H+EI1O3O2fo/jMV7ldtOs7dFTqPKQ6YIPUwV1kE=
X-Received: by 2002:a05:6512:ac4:b0:595:7e96:a71b with SMTP id
 2adb3069b0e04-595841aa9f6mr4025801e87.13.1763374864573; Mon, 17 Nov 2025
 02:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251107154917.313090-1-marco.crivellari@suse.com> <20251117051617-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251117051617-mutt-send-email-mst@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 17 Nov 2025 11:20:52 +0100
X-Gm-Features: AWmQ_bk9a2LThbleALibqcRpos3B9GYdoXUUJGmfQGS2iLf8rgMaHfarqBDvft4
Message-ID: <CAAofZF7=qg8N-tCtB50C8oOtqYHNcntrCjGbAxzrLAusW-E07Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue() in virtio_balloon
 and vduse
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio Perez <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:17=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> [...]
> To make sure, this does not seem to introduce any
> functional change - you want me to queue this now?

Hi,

Yes please, there are no functional changes as you said.
We are just marking explicitly this workqueue as per-cpu.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
