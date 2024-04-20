Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B318C7FD
	for <virtualization@lists.linux.dev>; Sat, 20 Apr 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713575308; cv=none; b=FXC29e0MA99EUYVy/Wps2EeVlnlY0grBpN9N7N08jcWKemHfSJ6FOjDbSQW6wZvbUVCiUebx2kxhb4kr3nb8gBNdmu42wAgzvXuHXSWFXAWwmAIuo1tIC/LsezEi7QBylPGx3ukfewBcbCVq3FvJqcXxFS3//QtGlwtzRZMos9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713575308; c=relaxed/simple;
	bh=/v5DF/yr70RSo2cPlpFendzuWaxo1OWbch7DeiC/1po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1oPF95KH1hSfn0ObhOsHvKmX6uwf5xeqatV/gTm+S7cPV8Xv43ByusSNpSwOEdo2sVcjOT5nOwLV42lAvVvNwQ+8mrLW7kdDots2HDjQqNRj5V5KSlqjNejEHI+pEj3QH0I1BynO0BE+Z5P3CchS9VlFJBIKo1c42VT044vja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tUkoTmVP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tUkoTmVP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51967f75729so3084072e87.0
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 18:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713575304; x=1714180104; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FopOoJVqlKLyitM+vV+llThPHlvMlGI12SmtWJmmk/0=;
        b=tUkoTmVP91AEqMiIdLP59OnVyMkLy4Cubuuu5GTMWLUe1USyaw96GcJDHHMlv+ziuY
         ND5BDeTlH8kR8QmdH3LCRO/yEx3KLiDjHBZYswOIvd6ItBVZor1SgEuZMxYPr+SrVWuF
         ylr0SaQj7mSBs5qBzwT8yBMKNd7jZ2xiIM/yAB9XF85SKV6P9gqDfPE0+rRhCWcdjHaO
         V9wuKdtKBtrdzoDNNc9JhGlFBhTD69S6MNCkZ99/i3uB7OWie5GPwHil6XG0LTL12+j5
         l2lkhQQD8dYEehX0h/72nzoYoibojBtgC9lXOdcfTUeFQM7S7QcqRjY1EDj+U0NVqRUU
         Ae2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713575304; x=1714180104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FopOoJVqlKLyitM+vV+llThPHlvMlGI12SmtWJmmk/0=;
        b=hQXcDsGjneJYmTiCe20p98F5BANugb1v/sjKuMcNppzflqyy79xZPpCzba+tkf/Y+S
         UKKixiVS521kdB1dPBWU3AhEoEFVeBAT72FGfYVj0+UQPH822AK+8BsPdNXLeYEBV9vB
         dscQudeGZMY1LSKGFP7bpZ3BForxZ9p5x45kNV6rOXCMyTCshk5iQgYySRagf4hruUzd
         ODIVgJRsfyhXUaSuEG04RhGxuIrbm8D7TbNZQ94PtT19YbJBRuufKRC4wUE1A+EANAEX
         CDmhU628aYMZOEheGUU4bg1II97EPAUSWMuIGXILrPOsXuPAjN3+7ExEbdIiZd9qJb/1
         LBQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1lsh+MU+z0xfbCfHk/7GsSSeY6s8FWk+OT4UkP5Pr7GsOFL9Uy/QOU7G24GHtf24GbWAGN3GBCtH5Wlnpam3n28cVSYUu6v7CW9OjQ8I=
X-Gm-Message-State: AOJu0Yzu5WlWl9UinzX+gWUdmIAsWJhplh2R/kovhuzv3KxFkzmwVHrn
	ULFmd2r40gvvx6IQcKqotkq8M1o+mSxGKZWi87vzak92ssTgz/WB4iq+TOQXJhM8+Z8QnTJz8g6
	xy+mJWfzlg9dYmAIPoKUbqpBp5NszI7wrdVqzTg==
X-Google-Smtp-Source: AGHT+IEogPfnlgAs9tR0qh0PAukDsFCglg4IjcLIKZzaVYr+8YdRMjPXcvRvV/A0KI3X5O1GyN/90pSnjyS/BTYsdl8=
X-Received: by 2002:ac2:5a1e:0:b0:519:296e:2c80 with SMTP id
 q30-20020ac25a1e000000b00519296e2c80mr1893557lfn.15.1713575303793; Fri, 19
 Apr 2024 18:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-9-atishp@rivosinc.com>
 <6fa06233-d572-48a7-a8ef-73a7c5879c06@sifive.com>
In-Reply-To: <6fa06233-d572-48a7-a8ef-73a7c5879c06@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 19 Apr 2024 18:08:12 -0700
Message-ID: <CAHBxVyHZ81G7yaMkV25RBwS=ric=MA92MePaPtQaOXuR+C70YA@mail.gmail.com>
Subject: Re: [PATCH v8 08/24] drivers/perf: riscv: Fix counter mask iteration
 for RV32
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:37=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Atish,
>
> On 2024-04-20 10:17 AM, Atish Patra wrote:
> > For RV32, used_hw_ctrs can have more than 1 word if the firmware choose=
s
> > to interleave firmware/hardware counters indicies. Even though it's a
> > unlikely scenario, handle that case by iterating over all the words
> > instead of just using the first word.
> >
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index f23501898657..4eacd89141a9 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -652,10 +652,12 @@ static inline void pmu_sbi_stop_all(struct riscv_=
pmu *pmu)
> >  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> >  {
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> > +     int i;
> >
> > -     /* No need to check the error here as we can't do anything about =
the error */
> > -     sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> > -               cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
> > +     for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> > +             /* No need to check the error here as we can't do anythin=
g about the error */
> > +             sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS=
_PER_LONG,
> > +                       cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
> >  }
> >
> >  /*
> > @@ -667,7 +669,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct risc=
v_pmu *pmu)
> >  static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> >                                              unsigned long ctr_ovf_mask=
)
> >  {
> > -     int idx =3D 0;
> > +     int idx =3D 0, i;
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> >       struct perf_event *event;
> >       unsigned long flag =3D SBI_PMU_START_FLAG_SET_INIT_VALUE;
> > @@ -676,11 +678,12 @@ static inline void pmu_sbi_start_overflow_mask(st=
ruct riscv_pmu *pmu,
> >       struct hw_perf_event *hwc;
> >       u64 init_val =3D 0;
> >
> > -     ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
> > -
> > -     /* Start all the counters that did not overflow in a single shot =
*/
> > -     sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_ma=
sk,
> > -               0, 0, 0, 0);
> > +     for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> > +             ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf=
_mask;
>
> This is applying the mask for the first 32 logical counters to the both s=
ets of
> 32 logical counters. ctr_ovf_mask needs to be 64 bits wide here, so each =
loop
> iteration can apply the correct half of the mask.
>

The 64bit wide support for ctr_ovf_mask is added in the next patch.

> Regards,
> Samuel
>
> > +             /* Start all the counters that did not overflow in a sing=
le shot */
> > +             sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BIT=
S_PER_LONG, ctr_start_mask,
> > +                     0, 0, 0, 0);
> > +     }
> >
> >       /* Reinitialize and start all the counter that overflowed */
> >       while (ctr_ovf_mask) {
>
