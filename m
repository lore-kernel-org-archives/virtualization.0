Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2916429
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="YpVb+WSc"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC10B40131
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC10B40131
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=YpVb+WSc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tLW6yxtnllV
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 09:24:17 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84E1540127
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 09:24:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84E1540127
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c68b5cf14bso199940a12.0
        for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702632257; x=1703237057; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkgdTuSLIkBNaoAKVjs8cxc7sn+txwKysv6tc6DJg+o=;
        b=YpVb+WSc1jO0zl/C54rkWQuRutKcMDGT6gKzTp85uznOrCXBg+c9nNF5kEViJUFr8S
         1KpIpO/YbRt38RMlra/7UyKBzM2MbCfa75RpWf6kml8Gt3t8qDtdJDiAHTDUTm+G4Vjc
         6bszCge63GmutrX/TQAaeWxIGK36yevSMtBolp4WEjmWcL9cP3fMMLbd7PIyLZHobEF0
         9y7l5LDvgLmhPLgsN2Yt5nlOhrCBfqiAeKaf4TdTQNw+8dwK1EkmO4U70isiQJALJdup
         GzlmU/ephKtXIwkDryqB4KN5SM6iPMobbn7LN1ZKyltHEbv71CyX68YKIKjPPlo65Jtc
         rANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632257; x=1703237057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkgdTuSLIkBNaoAKVjs8cxc7sn+txwKysv6tc6DJg+o=;
        b=inBZq9nTmRBN0HVLs3wFqF1g0ZpEsFThVRTGp2+brztTfTI8ay746YQ3tU7usrj4Lz
         y1hnuKasq808/UdQNrjyNFrFjZbV83wTPNXOC8SfyJJ0LzliBS948+OG+An2aKbs1uUu
         u7LSvSkn2/5OvPCpcqMrSGJVgP/MKXL2E3ZxuvH2rWEvSJV6b41RtKkQF+9ZNK7+85oW
         TfVvPVpaQi4LS13c3ielBQIiKUuOKI4ERhmPAhEraftXNuRAMKlh7wrJeHIBOjkQDBbo
         FeU3JAe7/ka5qPrmxrMSirE7RosUrfpRCf9jPsFyCvmQ2V67vUROVLGrAyBmTW7faz8g
         6ekw==
X-Gm-Message-State: AOJu0Yw6qiZNq5n6/xssxxPbdlEbYc1Vb+PHrb38Fyv+ajzZ3JcJ5PdM
	UZ/U8lCS5+vW8Ko7UR/NndomlcTJolggfDNNK9UqnA==
X-Google-Smtp-Source: AGHT+IEDhHjdwldw+YUG2ayrb/iQibGTQtHNdcpFnvLV7h0Skd/NDf46TArN18pJvSRR6U+FjE/vLCIgXdM3qyXvvZU=
X-Received: by 2002:a17:90a:7143:b0:286:7ec4:e701 with SMTP id
 g3-20020a17090a714300b002867ec4e701mr5439840pjs.31.1702632256854; Fri, 15 Dec
 2023 01:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231214101552.100721-15-ajones@ventanamicro.com> <20231214101552.100721-27-ajones@ventanamicro.com>
In-Reply-To: <20231214101552.100721-27-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 Dec 2023 14:54:04 +0530
Message-ID: <CAAhSdy3xYTQP8EzB1+1Vw+sa-KAzXOhSUwBeKW+spQUjsPgmxg@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] RISC-V: KVM: selftests: Add steal_time test support
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
> With the introduction of steal-time accounting support for
> RISC-V KVM we can add RISC-V support to the steal_time test.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/Makefile          |  5 +-
>  .../selftests/kvm/include/riscv/processor.h   |  1 +
>  tools/testing/selftests/kvm/steal_time.c      | 99 +++++++++++++++++++
>  3 files changed, 103 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 963435959a92..4bf4f52341a8 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -194,12 +194,13 @@ TEST_GEN_PROGS_s390x +=3D kvm_binary_stats_test
>
>  TEST_GEN_PROGS_riscv +=3D demand_paging_test
>  TEST_GEN_PROGS_riscv +=3D dirty_log_test
> -TEST_GEN_PROGS_riscv +=3D guest_print_test
>  TEST_GEN_PROGS_riscv +=3D get-reg-list
> +TEST_GEN_PROGS_riscv +=3D guest_print_test
> +TEST_GEN_PROGS_riscv +=3D kvm_binary_stats_test
>  TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
>  TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
>  TEST_GEN_PROGS_riscv +=3D set_memory_region_test
> -TEST_GEN_PROGS_riscv +=3D kvm_binary_stats_test
> +TEST_GEN_PROGS_riscv +=3D steal_time
>
>  SPLIT_TESTS +=3D get-reg-list
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index dc50ad62e150..a0f9efe5a2a8 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -128,6 +128,7 @@ static inline uint64_t __kvm_reg_id(uint64_t type, ui=
nt64_t subtype,
>
>  enum sbi_ext_id {
>         SBI_EXT_BASE =3D 0x10,
> +       SBI_EXT_STA =3D 0x535441,
>  };
>
>  enum sbi_ext_base_fid {
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> index 171adfb2a6cb..bae0c5026f82 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -11,7 +11,9 @@
>  #include <pthread.h>
>  #include <linux/kernel.h>
>  #include <asm/kvm.h>
> +#ifndef __riscv
>  #include <asm/kvm_para.h>
> +#endif
>
>  #include "test_util.h"
>  #include "kvm_util.h"
> @@ -203,6 +205,103 @@ static void steal_time_dump(struct kvm_vm *vm, uint=
32_t vcpu_idx)
>         pr_info("    st_time: %ld\n", st->st_time);
>  }
>
> +#elif defined(__riscv)
> +
> +/* SBI STA shmem must have 64-byte alignment */
> +#define STEAL_TIME_SIZE                ((sizeof(struct sta_struct) + 63)=
 & ~63)
> +
> +static vm_paddr_t st_gpa[NR_VCPUS];
> +
> +struct sta_struct {
> +       uint32_t sequence;
> +       uint32_t flags;
> +       uint64_t steal;
> +       uint8_t preempted;
> +       uint8_t pad[47];
> +} __packed;
> +
> +static void sta_set_shmem(vm_paddr_t gpa, unsigned long flags)
> +{
> +       unsigned long lo =3D (unsigned long)gpa;
> +#if __riscv_xlen =3D=3D 32
> +       unsigned long hi =3D (unsigned long)(gpa >> 32);
> +#else
> +       unsigned long hi =3D gpa =3D=3D -1 ? -1 : 0;
> +#endif
> +       struct sbiret ret =3D sbi_ecall(SBI_EXT_STA, 0, lo, hi, flags, 0,=
 0, 0);
> +
> +       GUEST_ASSERT(ret.value =3D=3D 0 && ret.error =3D=3D 0);
> +}
> +
> +static void check_status(struct sta_struct *st)
> +{
> +       GUEST_ASSERT(!(READ_ONCE(st->sequence) & 1));
> +       GUEST_ASSERT(READ_ONCE(st->flags) =3D=3D 0);
> +       GUEST_ASSERT(READ_ONCE(st->preempted) =3D=3D 0);
> +}
> +
> +static void guest_code(int cpu)
> +{
> +       struct sta_struct *st =3D st_gva[cpu];
> +       uint32_t sequence;
> +       long out_val =3D 0;
> +       bool probe;
> +
> +       probe =3D guest_sbi_probe_extension(SBI_EXT_STA, &out_val);
> +       GUEST_ASSERT(probe && out_val =3D=3D 1);
> +
> +       sta_set_shmem(st_gpa[cpu], 0);
> +       GUEST_SYNC(0);
> +
> +       check_status(st);
> +       WRITE_ONCE(guest_stolen_time[cpu], st->steal);
> +       sequence =3D READ_ONCE(st->sequence);
> +       check_status(st);
> +       GUEST_SYNC(1);
> +
> +       check_status(st);
> +       GUEST_ASSERT(sequence < READ_ONCE(st->sequence));
> +       WRITE_ONCE(guest_stolen_time[cpu], st->steal);
> +       check_status(st);
> +       GUEST_DONE();
> +}
> +
> +static bool is_steal_time_supported(struct kvm_vcpu *vcpu)
> +{
> +       uint64_t id =3D RISCV_SBI_EXT_REG(KVM_RISCV_SBI_EXT_STA);
> +       unsigned long enabled;
> +
> +       vcpu_get_reg(vcpu, id, &enabled);
> +       TEST_ASSERT(enabled =3D=3D 0 || enabled =3D=3D 1, "Expected boole=
an result");
> +
> +       return enabled;
> +}
> +
> +static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
> +{
> +       /* ST_GPA_BASE is identity mapped */
> +       st_gva[i] =3D (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
> +       st_gpa[i] =3D addr_gva2gpa(vcpu->vm, (vm_vaddr_t)st_gva[i]);
> +       sync_global_to_guest(vcpu->vm, st_gva[i]);
> +       sync_global_to_guest(vcpu->vm, st_gpa[i]);
> +}
> +
> +static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
> +{
> +       struct sta_struct *st =3D addr_gva2hva(vm, (ulong)st_gva[vcpu_idx=
]);
> +       int i;
> +
> +       pr_info("VCPU%d:\n", vcpu_idx);
> +       pr_info("    sequence:  %d\n", st->sequence);
> +       pr_info("    flags:     %d\n", st->flags);
> +       pr_info("    steal:     %"PRIu64"\n", st->steal);
> +       pr_info("    preempted: %d\n", st->preempted);
> +       pr_info("    pad:      ");
> +       for (i =3D 0; i < 47; ++i)
> +               pr_info("%d", st->pad[i]);
> +       pr_info("\n");
> +}
> +
>  #endif
>
>  static void *do_steal_time(void *arg)
> --
> 2.43.0
>
