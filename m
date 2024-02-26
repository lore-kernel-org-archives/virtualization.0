Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CD1BC27;
	Mon, 26 Feb 2024 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928041; cv=none; b=f+R1wvslXaRiwCGsuDQgk4lLWsSgUMxAZw+MDWpjHPRNlG9NFlg1YTQfKfHrw30g271oRptCDJkn1drM48wVmcXEWzhz//whJi7cc2H05cDzPj9r9hIYimbiK9iMOhCdlWGyXmiZucKXztWZmsRe5BK7nIDs67iX06PhLGmjJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928041; c=relaxed/simple;
	bh=veta97L3ID3YoBQ1toWeRCzS2ZbdS3Bqd91mRo/FXzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXCqqxtIl+Ol8xTady5OmV4ouRiQoDqMZt+SGCon0uL/JEI6RLtv0HWUExKm1EWrl3fILUxSdK4UnN2bfl+dj9YhV7B9NSZB8DmXogwEkSIu+nW5zbYXw1nZQuM130BkaM3KLQfscwW8mnKH7+tT9EXYYXgUauMdykhBy4e2imM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZOBKp7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZOBKp7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD8DC433F1;
	Mon, 26 Feb 2024 06:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708928040;
	bh=veta97L3ID3YoBQ1toWeRCzS2ZbdS3Bqd91mRo/FXzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jZOBKp7+VM4tsKjCcMCIb4gblvjyo67H84BdaWJRVg/Qbu8/Pbw5H9CqX9dPPdRN7
	 aA2KBoB6tGbZHlqh3hF4IteE36tYpI/d0pyqCYeBSCRahSBpWtKQBqObKIJALrxqbm
	 fmjmAc/Pzd3FW4Hgws4MBG4kJKaquROmNiv4DAkvhlBlenJ0SW/tr8fp0/NW8S1wLf
	 CKHrEXrraOuEgqrMidlCmBBeSzgpJdkrYVnl08q9bgZ2zYVRsoPb5B+vGpLpizIKiE
	 DijZwUstwHvbXUsTUNYBu09UpzL6XZTQSxRMOAA+J7QjepPn8GOUm+qfTEFUsH06q1
	 EwDReaLOPGQoQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso415246566b.1;
        Sun, 25 Feb 2024 22:14:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHA2F2YWtDa4EDu1YmcWYyOIeB8w8Xuf/dvhmMbW7/9+5tsjQWtCZuCV+vOGi52nKTskiRwtfD9SJtNYF5pgTGP1Whau266gHlGR9lKENmYlbz6anw7tHIS4CN/wFvaDwvqyTzUc/JWrI=
X-Gm-Message-State: AOJu0YzaAugMEFziSTotMlugVXmKmZ9Cx16l5B0Au/ra0nIz28+5zqfK
	K1dzlUpk7K5aGhjrchcxU9Nq2fNTQVLO2/7NoE7ZKi3Z/8z7sIk7tiR3R9sLz7hdAZ4nMxenlfB
	Ej6Du1cSxdCRhCpRS5QK57eYX4XQ=
X-Google-Smtp-Source: AGHT+IHD5xYoZZP56DdPlwvxfM+tSalcdEJDk27CoMnchaqYVBCCJdjScbiPHJ2xCvQqzhCCMI++wLrccA+EFzHQvrg=
X-Received: by 2002:a17:906:d923:b0:a3f:1139:5a6b with SMTP id
 rn3-20020a170906d92300b00a3f11395a6bmr4636609ejb.32.1708927978885; Sun, 25
 Feb 2024 22:12:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240222032803.2177856-1-maobibo@loongson.cn> <20240222032803.2177856-4-maobibo@loongson.cn>
 <CAAhV-H5eqXMqTYVb6cAVqOsDNcEDeP9HzaMKw69KFQeVaAYEdA@mail.gmail.com> <d1a6c424-b710-74d6-29f6-e0d8e597e1fb@loongson.cn>
In-Reply-To: <d1a6c424-b710-74d6-29f6-e0d8e597e1fb@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 26 Feb 2024 14:12:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7p114hWUVrYRfKiBX3teG8sG7xmEW-Q-QT3i+xdLqDEA@mail.gmail.com>
Message-ID: <CAAhV-H7p114hWUVrYRfKiBX3teG8sG7xmEW-Q-QT3i+xdLqDEA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] LoongArch: KVM: Add cpucfg area for kvm hypervisor
To: maobibo <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Juergen Gross <jgross@suse.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:04=E2=80=AFAM maobibo <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2024/2/24 =E4=B8=8B=E5=8D=885:13, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > On Thu, Feb 22, 2024 at 11:28=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>
> >> Instruction cpucfg can be used to get processor features. And there
> >> is trap exception when it is executed in VM mode, and also it is
> >> to provide cpu features to VM. On real hardware cpucfg area 0 - 20
> >> is used.  Here one specified area 0x40000000 -- 0x400000ff is used
> >> for KVM hypervisor to privide PV features, and the area can be extende=
d
> >> for other hypervisors in future. This area will never be used for
> >> real HW, it is only used by software.
> > After reading and thinking, I find that the hypercall method which is
> > used in our productive kernel is better than this cpucfg method.
> > Because hypercall is more simple and straightforward, plus we don't
> > worry about conflicting with the real hardware.
> No, I do not think so. cpucfg is simper than hypercall, hypercall can
> be in effect when system runs in guest mode. In some scenario like TCG
> mode, hypercall is illegal intruction, however cpucfg can work.
Nearly all architectures use hypercall except x86 for its historical
reasons. If we use CPUCFG, then the hypervisor information is
unnecessarily leaked to userspace, and this may be a security issue.
Meanwhile, I don't think TCG mode needs PV features.

I consulted with Jiaxun before, and maybe he can give some more comments.

>
> Extioi virtualization extension will be added later, cpucfg can be used
> to get extioi features. It is unlikely that extioi driver depends on
> PARA_VIRT macro if hypercall is used to get features.
CPUCFG is per-core information, if we really need something about
extioi, it should be in iocsr (LOONGARCH_IOCSR_FEATURES).


Huacai

>
> Regards
> Bibo Mao
>
> >
> > Huacai
> >
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/inst.h      |  1 +
> >>   arch/loongarch/include/asm/loongarch.h | 10 ++++++
> >>   arch/loongarch/kvm/exit.c              | 46 +++++++++++++++++-------=
--
> >>   3 files changed, 41 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/includ=
e/asm/inst.h
> >> index d8f637f9e400..ad120f924905 100644
> >> --- a/arch/loongarch/include/asm/inst.h
> >> +++ b/arch/loongarch/include/asm/inst.h
> >> @@ -67,6 +67,7 @@ enum reg2_op {
> >>          revhd_op        =3D 0x11,
> >>          extwh_op        =3D 0x16,
> >>          extwb_op        =3D 0x17,
> >> +       cpucfg_op       =3D 0x1b,
> >>          iocsrrdb_op     =3D 0x19200,
> >>          iocsrrdh_op     =3D 0x19201,
> >>          iocsrrdw_op     =3D 0x19202,
> >> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/i=
nclude/asm/loongarch.h
> >> index 46366e783c84..a1d22e8b6f94 100644
> >> --- a/arch/loongarch/include/asm/loongarch.h
> >> +++ b/arch/loongarch/include/asm/loongarch.h
> >> @@ -158,6 +158,16 @@
> >>   #define  CPUCFG48_VFPU_CG              BIT(2)
> >>   #define  CPUCFG48_RAM_CG               BIT(3)
> >>
> >> +/*
> >> + * cpucfg index area: 0x40000000 -- 0x400000ff
> >> + * SW emulation for KVM hypervirsor
> >> + */
> >> +#define CPUCFG_KVM_BASE                        0x40000000UL
> >> +#define CPUCFG_KVM_SIZE                        0x100
> >> +#define CPUCFG_KVM_SIG                 CPUCFG_KVM_BASE
> >> +#define  KVM_SIGNATURE                 "KVM\0"
> >> +#define CPUCFG_KVM_FEATURE             (CPUCFG_KVM_BASE + 4)
> >> +
> >>   #ifndef __ASSEMBLY__
> >>
> >>   /* CSR */
> >> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> >> index 923bbca9bd22..6a38fd59d86d 100644
> >> --- a/arch/loongarch/kvm/exit.c
> >> +++ b/arch/loongarch/kvm/exit.c
> >> @@ -206,10 +206,37 @@ int kvm_emu_idle(struct kvm_vcpu *vcpu)
> >>          return EMULATE_DONE;
> >>   }
> >>
> >> -static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
> >> +static int kvm_emu_cpucfg(struct kvm_vcpu *vcpu, larch_inst inst)
> >>   {
> >>          int rd, rj;
> >>          unsigned int index;
> >> +
> >> +       rd =3D inst.reg2_format.rd;
> >> +       rj =3D inst.reg2_format.rj;
> >> +       ++vcpu->stat.cpucfg_exits;
> >> +       index =3D vcpu->arch.gprs[rj];
> >> +
> >> +       /*
> >> +        * By LoongArch Reference Manual 2.2.10.5
> >> +        * Return value is 0 for undefined cpucfg index
> >> +        */
> >> +       switch (index) {
> >> +       case 0 ... (KVM_MAX_CPUCFG_REGS - 1):
> >> +               vcpu->arch.gprs[rd] =3D vcpu->arch.cpucfg[index];
> >> +               break;
> >> +       case CPUCFG_KVM_SIG:
> >> +               vcpu->arch.gprs[rd] =3D *(unsigned int *)KVM_SIGNATURE=
;
> >> +               break;
> >> +       default:
> >> +               vcpu->arch.gprs[rd] =3D 0;
> >> +               break;
> >> +       }
> >> +
> >> +       return EMULATE_DONE;
> >> +}
> >> +
> >> +static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
> >> +{
> >>          unsigned long curr_pc;
> >>          larch_inst inst;
> >>          enum emulation_result er =3D EMULATE_DONE;
> >> @@ -224,21 +251,8 @@ static int kvm_trap_handle_gspr(struct kvm_vcpu *=
vcpu)
> >>          er =3D EMULATE_FAIL;
> >>          switch (((inst.word >> 24) & 0xff)) {
> >>          case 0x0: /* CPUCFG GSPR */
> >> -               if (inst.reg2_format.opcode =3D=3D 0x1B) {
> >> -                       rd =3D inst.reg2_format.rd;
> >> -                       rj =3D inst.reg2_format.rj;
> >> -                       ++vcpu->stat.cpucfg_exits;
> >> -                       index =3D vcpu->arch.gprs[rj];
> >> -                       er =3D EMULATE_DONE;
> >> -                       /*
> >> -                        * By LoongArch Reference Manual 2.2.10.5
> >> -                        * return value is 0 for undefined cpucfg inde=
x
> >> -                        */
> >> -                       if (index < KVM_MAX_CPUCFG_REGS)
> >> -                               vcpu->arch.gprs[rd] =3D vcpu->arch.cpu=
cfg[index];
> >> -                       else
> >> -                               vcpu->arch.gprs[rd] =3D 0;
> >> -               }
> >> +               if (inst.reg2_format.opcode =3D=3D cpucfg_op)
> >> +                       er =3D kvm_emu_cpucfg(vcpu, inst);
> >>                  break;
> >>          case 0x4: /* CSR{RD,WR,XCHG} GSPR */
> >>                  er =3D kvm_handle_csr(vcpu, inst);
> >> --
> >> 2.39.3
> >>
>
>
