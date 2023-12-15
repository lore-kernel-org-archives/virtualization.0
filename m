Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8818AE1
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="TsOy16GE"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E65B80C1E
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E65B80C1E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=TsOy16GE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dtxr1T2wT5bt
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:20:28 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B294780BF0
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:20:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B294780BF0
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso380376a12.3
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702632028; x=1703236828; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF0RjUxxOTCi/5O4/tSniADoZQ1plpiPzcoditI8TnU=;
        b=TsOy16GEM8RwQFRgPU1/pdpDRjZZ5sVorCPALzlzSKMb32oJsJUJQEfhm/fn9razZu
         skUoFXNRDQJ+zgAhNct4W6Gz6uQk9adWZkjjZdmx+T7+397HsPGcOh1AJa18gAfekgqK
         sjBljsJBPDFXmJuyniA2JEWljtMD4e3RBXBEGY/gMao7Xd//Q16LgxjoLoJm6DJEpB4c
         ZzcjK1H3uQsCxbVUIMhm+LKzJhnvIAjZz1EtUIYJ9mbRzoJ3jkDCYChjP361WGDLLcri
         IcroXU/d7mk5U6YpNTaF53N2/W0wAh7BSJKXNmwoXgJe4disMt6WATX6K3TksxHP2Nwk
         JcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632028; x=1703236828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF0RjUxxOTCi/5O4/tSniADoZQ1plpiPzcoditI8TnU=;
        b=rZu/onq2ZdBcJdLxoP3I5UkoxIURNaUaJdbmP4mw9gU3RrLg8UNNrrdrvbXP+e274h
         lG0Zrr82v+lKMHV6AbnER3ilGWz4XxMN/vF+Qosx3zEr4zJjXilyHSkLP2LBfN/Ct4IK
         GJjHUsfezGmnZhWP3yVdr9ehU2D6tZh3onGaTKvOA546PRU7f1t0WEUOlig+EyxiJcS6
         FgOnsQI4gcwxy86O/P6X95xnH+dDCchcSY7dP8B8tHqqzoPnJtaylmw5vtWPfaz6hSqn
         Ua33asfMz426lHCeKDuRmPZe1Ij5sK06seW463GEQU34T7U8dwMDpNDgPApAqEBokkiW
         cdIA==
X-Gm-Message-State: AOJu0Yy2OZx9w0lhwHYSOANpnlSxho2AxY2Jh1PLsvcWjNOJh0CiwlDn
	MCrfXbdNGIiM7y3Hdt2NCyXO82xBdDpxzDNM6zCpog==
X-Google-Smtp-Source: AGHT+IGGe7wky7OlkN2qh8RmXDPOO5hC4CA5PgO96asXf3UXjlQvMc2HzBQriu2xmybz2VFFlOT2JhtYC9rkne0rj5s=
X-Received: by 2002:a17:90a:578c:b0:285:cc9c:7406 with SMTP id
 g12-20020a17090a578c00b00285cc9c7406mr8945022pji.15.1702632028011; Fri, 15
 Dec 2023 01:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-25-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-25-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:50:15 +0530
Message-ID: <CAAhSdy1_ufRyGc3gBkV8FKBD8zZ_SwNnz6a6xct31NmuDZYssw@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] RISC-V: KVM: selftests: Move sbi_ecall to processor.c
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, atishp@atishpatra.org, 
	pbonzini@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgross@suse.com, srivatsa@csail.mit.edu, 
	guoren@kernel.org, conor.dooley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:46=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> sbi_ecall() isn't ucall specific and its prototype is already in
> processor.h. Move its implementation to processor.c.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org

Regards,
Anup

> ---
>  .../selftests/kvm/lib/riscv/processor.c       | 26 +++++++++++++++++++
>  tools/testing/selftests/kvm/lib/riscv/ucall.c | 26 -------------------
>  2 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index 6c25f7843ef4..6905a4348380 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -367,3 +367,29 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned i=
nt num, ...)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> +                       unsigned long arg1, unsigned long arg2,
> +                       unsigned long arg3, unsigned long arg4,
> +                       unsigned long arg5)
> +{
> +       register uintptr_t a0 asm ("a0") =3D (uintptr_t)(arg0);
> +       register uintptr_t a1 asm ("a1") =3D (uintptr_t)(arg1);
> +       register uintptr_t a2 asm ("a2") =3D (uintptr_t)(arg2);
> +       register uintptr_t a3 asm ("a3") =3D (uintptr_t)(arg3);
> +       register uintptr_t a4 asm ("a4") =3D (uintptr_t)(arg4);
> +       register uintptr_t a5 asm ("a5") =3D (uintptr_t)(arg5);
> +       register uintptr_t a6 asm ("a6") =3D (uintptr_t)(fid);
> +       register uintptr_t a7 asm ("a7") =3D (uintptr_t)(ext);
> +       struct sbiret ret;
> +
> +       asm volatile (
> +               "ecall"
> +               : "+r" (a0), "+r" (a1)
> +               : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (=
a7)
> +               : "memory");
> +       ret.error =3D a0;
> +       ret.value =3D a1;
> +
> +       return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testin=
g/selftests/kvm/lib/riscv/ucall.c
> index fe6d1004f018..14ee17151a59 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> @@ -10,32 +10,6 @@
>  #include "kvm_util.h"
>  #include "processor.h"
>
> -struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> -                       unsigned long arg1, unsigned long arg2,
> -                       unsigned long arg3, unsigned long arg4,
> -                       unsigned long arg5)
> -{
> -       register uintptr_t a0 asm ("a0") =3D (uintptr_t)(arg0);
> -       register uintptr_t a1 asm ("a1") =3D (uintptr_t)(arg1);
> -       register uintptr_t a2 asm ("a2") =3D (uintptr_t)(arg2);
> -       register uintptr_t a3 asm ("a3") =3D (uintptr_t)(arg3);
> -       register uintptr_t a4 asm ("a4") =3D (uintptr_t)(arg4);
> -       register uintptr_t a5 asm ("a5") =3D (uintptr_t)(arg5);
> -       register uintptr_t a6 asm ("a6") =3D (uintptr_t)(fid);
> -       register uintptr_t a7 asm ("a7") =3D (uintptr_t)(ext);
> -       struct sbiret ret;
> -
> -       asm volatile (
> -               "ecall"
> -               : "+r" (a0), "+r" (a1)
> -               : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (=
a7)
> -               : "memory");
> -       ret.error =3D a0;
> -       ret.value =3D a1;
> -
> -       return ret;
> -}
> -
>  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_run *run =3D vcpu->run;
> --
> 2.43.0
>
