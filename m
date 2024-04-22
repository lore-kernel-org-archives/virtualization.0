Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E817C74
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763973; cv=none; b=Wdzs6vWrNqjJ/BHYV8Ybf0rzB+0Ogwpzx7nySlwENqJdkX53564es3LMTD0YJ9h2EuIvzMipiEHneAIu/oRA1xu05xxGOQPJe/vqLmeiQOKEIFNNen7uCYAoRgru364HnDR0RZBcjXhQ3eOu9Dem+c3In3IB9iMSl2Id4Ak2Fco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763973; c=relaxed/simple;
	bh=BwCdWcMLmgKeTy/zl1TsPBXPPuxkE/Xsmo260vkgIDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azTYoXRhA0bHjdLAjNTfIjXNtJ4qfozNJiJSkrA7hdBejmr5lTJ2WDvF2gZJTkLMKXJBmJ6Cu9BVWKj9CxlR2F0hd57qU7SCzcf8XpTNSkTX7djTDRU2tuDM0bt/H8BzUfmGkg2UichlrUrnmxybZZ/VPsM0bPBoEx5S4h1TJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=I/MKdzuu; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="I/MKdzuu"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7da829eeeedso73085539f.0
        for <virtualization@lists.linux.dev>; Sun, 21 Apr 2024 22:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763970; x=1714368770; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mSLO7qsMu9ScrRVYm3QHz5Wa7uqrp1Jo4sRqwEm41k=;
        b=I/MKdzuuGl3cgx2AQ+3Ep0UPvsdsP77MVWyJituE00zNyK9qDMFhLryf7FYZru5L06
         oLRPij+GpaB42htwgTM9PxahfKIkOOZ3xmPeCm1meNZGt1/ZYZgay6Iegxv99vpckc8W
         jA1+CZB2BCPEBGpaeNGR3BYRg3gwLH0crrCMyGwHkUl8Ie9+XpVgh1xoNM5OotN1DLBh
         4dVsH4cyN+hPxp2MWHjVSwZV2+xEv7sufcRJnuvqcOwv4+tWWGWOwVMp+oNi+3bLh/Sq
         3rmbb6IGGDqXeW4tkSXM9dDgKJG6DcGP7EnKk1XLCv92BhV4Ezr5Q3B4cqMARJeNz+2X
         BDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763970; x=1714368770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mSLO7qsMu9ScrRVYm3QHz5Wa7uqrp1Jo4sRqwEm41k=;
        b=Gm+4xkM4FVjKaw4Qt319L9hrywoqLGwqDq5Io0qL4vGuXmRvydKaieNlHYj+5dHF/n
         tmexOo2uOqufIAkNludnSwLsGEtk7qjmSFbUDBTTTCaelnB4ctSQNdbI/VU0M7xkEIqA
         gLPwM8UcGrGLYvaU/zIM1AeonSKxjLTBYrvQmwgHC3XisMMGwt6z6Hbe2g+Vyr4+NEVy
         3jd+hFJ5VwmRxAAu/PAqfvb6AoOPoFk4QSis/jNU/h/3CyB13bZjM71i6ig6KQH+SfCF
         qsVUdPkGD/sDylpkYOo8vI8ACZP7Nn4DzwRKzPef0I6jiDXuywEe1qIfOaYurVFWhkv2
         bD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6oB483JmDf16ZLux4o8q/B87/kgddMscHSCUuDX3q9xW42V07oKrUG/IVFXzw/aaa6JKkjQAe9sP9+7/gJ8rQcjDxIImNefyUMwwZtGw=
X-Gm-Message-State: AOJu0Yyf80JyVjDArjFCkGciBijP0Oh/bW22xJdJmdSsqZQ93RLd6ISY
	iXkNHz8+qz+xEyOy1WEVq42ye3Ww9xdpaTZ1S4InSfhM3NLsjqS3qiRrQy2KeCF3XibOac0oTHQ
	2Q9zjeWQhoItP9dtV0XsIqh2sKYTEP/OGQ1k/7g==
X-Google-Smtp-Source: AGHT+IEqy96d9EYvPfCKQbMdPNUPl6DZT781YdOhP9O47wLCNvRvtopYWldFwJankgX0sYeovuf51APBEHy0ooQ/k/Q=
X-Received: by 2002:a05:6e02:144d:b0:36a:686:b3bf with SMTP id
 p13-20020a056e02144d00b0036a0686b3bfmr13479495ilo.17.1713763970407; Sun, 21
 Apr 2024 22:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-25-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-25-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 11:02:39 +0530
Message-ID: <CAAhSdy0Bo1+SomNva+A_Phd=gu_+wcqXTV_-ioqCCVEr1cXJBA@mail.gmail.com>
Subject: Re: [PATCH v8 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> SBI PMU test comprises of multiple tests and user may want to run
> only a subset depending on the platform. The most common case would
> be to run all to validate all the tests. However, some platform may
> not support all events or all ISA extensions.
>
> The commandline option allows user to disable any set of tests if
> they want to.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 73 ++++++++++++++++---
>  1 file changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/tes=
ting/selftests/kvm/riscv/sbi_pmu_test.c
> index 0fd9b76ae838..69bb94e6b227 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -33,6 +33,13 @@ static unsigned long counter_mask_available;
>
>  static bool illegal_handler_invoked;
>
> +#define SBI_PMU_TEST_BASIC     BIT(0)
> +#define SBI_PMU_TEST_EVENTS    BIT(1)
> +#define SBI_PMU_TEST_SNAPSHOT  BIT(2)
> +#define SBI_PMU_TEST_OVERFLOW  BIT(3)
> +
> +static int disabled_tests;
> +
>  unsigned long pmu_csr_read_num(int csr_num)
>  {
>  #define switchcase_csr_read(__csr_num, __val)          {\
> @@ -608,19 +615,67 @@ static void test_vm_events_overflow(void *guest_cod=
e)
>         test_vm_destroy(vm);
>  }
>
> -int main(void)
> +static void test_print_help(char *name)
> +{
> +       pr_info("Usage: %s [-h] [-d <test name>]\n", name);
> +       pr_info("\t-d: Test to disable. Available tests are 'basic', 'eve=
nts', 'snapshot', 'overflow'\n");
> +       pr_info("\t-h: print this help screen\n");
> +}
> +
> +static bool parse_args(int argc, char *argv[])
> +{
> +       int opt;
> +
> +       while ((opt =3D getopt(argc, argv, "hd:")) !=3D -1) {
> +               switch (opt) {
> +               case 'd':
> +                       if (!strncmp("basic", optarg, 5))
> +                               disabled_tests |=3D SBI_PMU_TEST_BASIC;
> +                       else if (!strncmp("events", optarg, 6))
> +                               disabled_tests |=3D SBI_PMU_TEST_EVENTS;
> +                       else if (!strncmp("snapshot", optarg, 8))
> +                               disabled_tests |=3D SBI_PMU_TEST_SNAPSHOT=
;
> +                       else if (!strncmp("overflow", optarg, 8))
> +                               disabled_tests |=3D SBI_PMU_TEST_OVERFLOW=
;
> +                       else
> +                               goto done;
> +                       break;
> +               case 'h':
> +               default:
> +                       goto done;
> +               }
> +       }
> +
> +       return true;
> +done:
> +       test_print_help(argv[0]);
> +       return false;
> +}
> +
> +int main(int argc, char *argv[])
>  {
> -       test_vm_basic_test(test_pmu_basic_sanity);
> -       pr_info("SBI PMU basic test : PASS\n");
> +       if (!parse_args(argc, argv))
> +               exit(KSFT_SKIP);
> +
> +       if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
> +               test_vm_basic_test(test_pmu_basic_sanity);
> +               pr_info("SBI PMU basic test : PASS\n");
> +       }
>
> -       test_vm_events_test(test_pmu_events);
> -       pr_info("SBI PMU event verification test : PASS\n");
> +       if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
> +               test_vm_events_test(test_pmu_events);
> +               pr_info("SBI PMU event verification test : PASS\n");
> +       }
>
> -       test_vm_events_snapshot_test(test_pmu_events_snaphost);
> -       pr_info("SBI PMU event verification with snapshot test : PASS\n")=
;
> +       if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
> +               test_vm_events_snapshot_test(test_pmu_events_snaphost);
> +               pr_info("SBI PMU event verification with snapshot test : =
PASS\n");
> +       }
>
> -       test_vm_events_overflow(test_pmu_events_overflow);
> -       pr_info("SBI PMU event verification with overflow test : PASS\n")=
;
> +       if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
> +               test_vm_events_overflow(test_pmu_events_overflow);
> +               pr_info("SBI PMU event verification with overflow test : =
PASS\n");
> +       }
>
>         return 0;
>  }
> --
> 2.34.1
>
