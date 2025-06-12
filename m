Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2423C4E2;
	Thu, 12 Jun 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726655; cv=none; b=f3aeSofN68ML5dRZmY5v9g4uVnPoJzK+HRJgH9VwG63knBBk0Mi2/tbeuJSXtVa3SXNo3bo5MRNAqBZ5O84EYT/F/82gm7B1N2gqYgawFvz2fMzfQNpVi7Ac/jj4iNy+yktngvvcH2+VZy5Mh72dao5+Md2Rg7pLmkN18Pymybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726655; c=relaxed/simple;
	bh=9nBrpMK9zZeZHFNOhk7Yg3FOCL/mJbGGTtA0TEp4ISs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWipY7Gj1P0iBai63NVgsByk91TsHi3hYpXJZerApVI/slihpJZFoz8eyzwkllL4GDiw2YUau9gDhutn1otE/YQF+kpKFtK3NnGMsm4bxOAFE9FpAPkmxqhvkHt3vstTmu4XYoB1uDdPj1C1AyVnTghYMD1e+Gv5vNAa6gUZE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwTXttJO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwTXttJO"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo1636506a12.3;
        Thu, 12 Jun 2025 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749726652; x=1750331452; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nBrpMK9zZeZHFNOhk7Yg3FOCL/mJbGGTtA0TEp4ISs=;
        b=lwTXttJOehrbbo+i1AJKghgyCZwR6pnVG4hV0D788m0xhGEDdRRtvLyd6jmUuhL/qE
         cBrP8r/VqGg0s7dWiVsXiecA0g2+QcSuEQyKWSRjC7ihdDEnb3kDiqicbudMl3SDCvle
         Q/HRUkYWuCabGZys2dCGl2BdVyPEdQAcvIKCAryFTVK0kz+jyK+dx7J32mBe57T/oQT5
         rKdBO4xmkPwk4zI8ZtjmU2cmDfDJZ7MfYjKm/qShWk9zj8rKSuHszcoDN4TJ8YcdCqvQ
         CmGW01dOYu4oQ3nCC8lK+YjHWVF4ISkJLADxXq1S12XG05zSB7bl7ObnowcmWllrQ1nf
         eySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749726652; x=1750331452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nBrpMK9zZeZHFNOhk7Yg3FOCL/mJbGGTtA0TEp4ISs=;
        b=R1e9W28xOD+KoK3B5dWzfAtUZvD0SX4a5FA8lvR5Srm/jmT+G/RrW+YQq4pPim+ZfJ
         to1F6YH8DlSizcQVyh8I3SPYZ4/7GcJcKQFpubNQt5O9/MTuWrqgT5xyqx3OWK/6ToXP
         pMGmG+fc3jQMpenyTEOWTaEYlajoBtrbJmHseAATZ4Leh0uHO80mfcg4JLK3bi0Vl652
         3YmNJYvLUkJ9ICqieR0bZdiFcgRO2jr12EbsPGHSYIFLYpiHQsB0VpbGveFkcNPabITi
         NBCE6ppFwu8Ik6f0Cgfk2mXamd22sF5zZeR54Wd2GEBGyDoRHZDWP67KCT7JLyl2wcz3
         Df3w==
X-Forwarded-Encrypted: i=1; AJvYcCWQUhvJfLon+sFeX9T7yRbWFlr+Qzxj8l+L1oQUzkxkIeBt7tCLxB+msc/eTiJHKBDICQ7cO1BgWBRmiI58SFg=@lists.linux.dev, AJvYcCXbC5Vju7Z0KBjyICiVZ04SkhlA+esvg+qhzyfhRMaLKF3hvV6Yo/VXz5W9EvZgRoyQ595b6DvaFXp1@lists.linux.dev
X-Gm-Message-State: AOJu0YxHuLeTnOpdCdgSdZWIwjgwr+hb8zde2rKPEO/f7rvJNiQT6oEp
	42Swo5GJuHsQrzI63ZVKbtMjJtIUGWZ7abFIvqqjKxRSgphEtMiix+RFvfv+i+QFdBd9f5pC3pf
	OXjkcKQvY1CUFnIYc9HDctvfovxOExvI=
X-Gm-Gg: ASbGnctnNMj6gcsAhtWYQeCc3i3e9emUhpS5zOnx5I/vArB/ClJSPo3yrTXP2Xd0bl/
	Je/Ps2LXw3Jgakmz7H4VFmU2on43lMyRtqa7nHntbqbeizsa7Bd92dsH3naeW8tSmuEZo3ryCVQ
	ZO0Mmc8msXCQyDH6Ftvt1pEwE0eHx9SSaUmi67mAKF8nI=
X-Google-Smtp-Source: AGHT+IFrX17XfYVkjVnepz8BihCrbdN9elHb1a1FwyoMbX0yLjH2EltV5lWsECJ7oLshTrIE21PMDORFUypei4zXNLs=
X-Received: by 2002:a17:907:980f:b0:ad8:a515:767f with SMTP id
 a640c23a62f3a-adea9464061mr258576566b.51.1749726651742; Thu, 12 Jun 2025
 04:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612093228.7655-1-chengzhenghan@uniontech.com> <84b14425-03e4-42be-8bd5-9bc010ebecda@suse.com>
In-Reply-To: <84b14425-03e4-42be-8bd5-9bc010ebecda@suse.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Jun 2025 14:10:15 +0300
X-Gm-Features: AX0GCFubP_i495cQIkoSGfjK4G9pwjz7TYfQyvgZfj4JA8pwuaopIL7tecp4u7I
Message-ID: <CAHp75Vc7AO_sRgB1Nj6CevbseMFyv5ku8ZS3PwzAuAgysKVxNg@mail.gmail.com>
Subject: Re: [PATCH] x86: Fix build warnings about export.h
To: Juergen Gross <jgross@suse.com>
Cc: Zhenghan Cheng <chengzhenghan@uniontech.com>, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	mario.limonciello@amd.com, yazen.ghannam@amd.com, jpoimboe@kernel.org, 
	tony.luck@intel.com, jarkko@kernel.org, bhelgaas@google.com, 
	pbonzini@redhat.com, oleg@redhat.com, jbaron@akamai.com, ning.sun@intel.com, 
	seanjc@google.com, luto@kernel.org, andy@kernel.org, jim.cromie@gmail.com, 
	kirill.shutemov@linux.intel.com, hpa@zytor.com, 
	pawan.kumar.gupta@linux.intel.com, vkuznets@redhat.com, rostedt@goodmis.org, 
	ardb@kernel.org, thomas.lendacky@amd.com, nikunj@amd.com, 
	ashish.kalra@amd.com, kees@kernel.org, alexandre.chartre@oracle.com, 
	rppt@kernel.org, steve.wahl@hpe.com, jirislaby@kernel.org, 
	apatel@ventanamicro.com, bvanassche@acm.org, ptsm@linux.microsoft.com, 
	Jonathan.Cameron@huawei.com, beata.michalska@arm.com, xin@zytor.com, 
	davydov-max@yandex-team.ru, ravi.bangoria@amd.com, joel.granados@kernel.org, 
	ffmancera@riseup.net, kprateek.nayak@amd.com, akpm@linux-foundation.org, 
	bhe@redhat.com, brgerst@gmail.com, coxu@redhat.com, dmaluka@chromium.org, 
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-sgx@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, tboot-devel@lists.sourceforge.net, 
	nouveau@lists.freedesktop.org, linux-coco@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Huacai Chen <chenhuacai@loongson.cn>, 
	Zhenghan Cheng <your_email@example.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 1:19=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 12.06.25 11:32, Zhenghan Cheng wrote:
> > After commit a934a57a42f64a4 ("scripts/misc-check:
> > check missing #include <linux/export.h> when W=3D1")
> > and commit 7d95680d64ac8e836c ("scripts/misc-check:
> > check unnecessary #include <linux/export.h> when W=3D1"),
> > we get some build warnings with W=3D1,such as:
> >
> > arch/x86/coco/sev/core.c: warning: EXPORT_SYMBOL() is used, but #includ=
e <linux/export.h> is missing
> > arch/x86/crypto/aria_aesni_avx2_glue.c: warning: EXPORT_SYMBOL() is use=
d, but #include <linux/export.h> is missing
> > arch/x86/kernel/unwind_orc.c: warning: EXPORT_SYMBOL() is used, but #in=
clude <linux/export.h> is missing
> > arch/x86/kvm/hyperv.c: warning: EXPORT_SYMBOL() is used, but #include <=
linux/export.h> is missing
> > arch/x86/events/intel/core.c: warning: EXPORT_SYMBOL() is not used, but=
 #include <linux/export.h> is present
> > arch/x86/events/zhaoxin/core.c: warning: EXPORT_SYMBOL() is not used, b=
ut #include <linux/export.h> is present
> > arch/x86/kernel/crash.c: warning: EXPORT_SYMBOL() is not used, but #inc=
lude <linux/export.h> is present
> > arch/x86/kernel/devicetree.c: warning: EXPORT_SYMBOL() is not used, but=
 #include <linux/export.h> is present
> >
> > so fix these build warnings for x86.
> >
> > Signed-off-by: "Zhenghan Cheng" <chengzhenghan@uniontech.com>
> > Suggested-by: "Huacai Chen" <chenhuacai@loongson.cn>
>
> For Xen and paravirt:
>
> Acked-by: Juergen Gross <jgross@suse.com>
>
> Your patch is looking a little bit strange, as the list of modified files
> is located between the patch hunks, followed by another "Signed-off-by:".

Indeed.
And at bare minimum please split at least to two:
1) adding export.h;
2) removing export.h.


--=20
With Best Regards,
Andy Shevchenko
