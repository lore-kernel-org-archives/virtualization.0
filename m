Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183ADC7EE24
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 23:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93EEC821A2;
	Tue, 30 May 2023 23:16:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93EEC821A2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=A6P9MRUq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ib9HrtVkThMw; Tue, 30 May 2023 23:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F20CB821A5;
	Tue, 30 May 2023 23:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F20CB821A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3C75C0035;
	Tue, 30 May 2023 23:16:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9A2BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 23:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB45E4171B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 23:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB45E4171B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=A6P9MRUq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l4qT_xIDlI6N
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 23:16:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C14241612
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C14241612
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 23:16:11 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso3842688b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1685488571; x=1688080571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q6wOdCsvPcfL1AGuKhq7si1i+l1tB9VGHRhgBuI4hFQ=;
 b=A6P9MRUqWxltKJ9Zgwok7DSDRoOxoww2FWlF6WQO1tYgoM5+Hi0Ez2oEaQQjsD1m8R
 d4fRiNfemEoHsLbKtPfU643qi1eTaIaRbZTrXG8PIKxDT7zOE/fxQqSHWBsVd7zxgsD9
 9LmT/yPeVeEdIlXyQ0jganlgblNgnS7PESvrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685488571; x=1688080571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q6wOdCsvPcfL1AGuKhq7si1i+l1tB9VGHRhgBuI4hFQ=;
 b=ZzHgItj/JXIUU0FTYEVidZ5NgkMqySfMEwCxkHBKovT049ASfBRUt8ZBEQUu3rJphi
 jMBMpIj1wFi80g8KZqgtv8H4DXGc+6Q+E0DQX07ycyO9QukJoaM3tBtoIN9BQ5YcuD1E
 as7kP39258amUZN903kG+FVt4nzswd4veKPrvJlm0LJbTNPYPPpTiLFYkY3SOXgfuY1d
 oifsjB6iXsgvy8+AxhzpGjzzdGSwYhGhE6gu/UX1gJiZ7iwnzje/MGpUxPbvfURPMbrr
 w7ArR6eWK53qUsynF7q74JIi+pja55bR9IN8JOnAqUXa4pqMeDcMTGYZ2Ex4wFwexwoV
 2m0Q==
X-Gm-Message-State: AC+VfDx4WfnMhKLCG1O/ZGf+ojLv9WEdGcKUhf9Wk5rQhps1UlqKRNhw
 iP9Q4wj+Nyjk/O2vkSD3PYdIvQ==
X-Google-Smtp-Source: ACHHUZ5vUXK2I/pfuTav0TBfWy3DDrvFJsd+7uESTSUanu+Vl50RByVZpLds9PiU8F5GGbjiErQYOQ==
X-Received: by 2002:a05:6a00:10c4:b0:646:663a:9d60 with SMTP id
 d4-20020a056a0010c400b00646663a9d60mr4308038pfu.10.1685488570875; 
 Tue, 30 May 2023 16:16:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 v22-20020aa78516000000b0063d3d776910sm2123773pfn.138.2023.05.30.16.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 16:16:10 -0700 (PDT)
Date: Tue, 30 May 2023 16:16:09 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [PATCH v1 5/9] KVM: x86: Add new hypercall to lock control
 registers
Message-ID: <202305301614.BF8D80D3D5@keescook>
References: <20230505152046.6575-1-mic@digikod.net>
 <20230505152046.6575-6-mic@digikod.net>
 <ZFlllHjntehpthma@liuwe-devbox-debian-v2>
 <901ff104-215c-8e81-fbae-5ecd8fa94449@digikod.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <901ff104-215c-8e81-fbae-5ecd8fa94449@digikod.net>
Cc: linux-hyperv@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 John Andersen <john.s.andersen@intel.com>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-hardening@vger.kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>, x86@kernel.org,
 James Morris <jamorris@linux.microsoft.com>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Forrest Yuan Yu <yuanyu@google.com>,
 dev@lists.cloudhypervisor.org, Thara Gopinath <tgopinath@microsoft.com>,
 =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>,
 Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zahra Tarkhani <ztarkhani@microsoft.com>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 29, 2023 at 06:48:03PM +0200, Micka=EBl Sala=FCn wrote:
> =

> On 08/05/2023 23:11, Wei Liu wrote:
> > On Fri, May 05, 2023 at 05:20:42PM +0200, Micka=EBl Sala=FCn wrote:
> > > This enables guests to lock their CR0 and CR4 registers with a subset=
 of
> > > X86_CR0_WP, X86_CR4_SMEP, X86_CR4_SMAP, X86_CR4_UMIP, X86_CR4_FSGSBASE
> > > and X86_CR4_CET flags.
> > > =

> > > The new KVM_HC_LOCK_CR_UPDATE hypercall takes two arguments.  The fir=
st
> > > is to identify the control register, and the second is a bit mask to
> > > pin (i.e. mark as read-only).
> > > =

> > > These register flags should already be pinned by Linux guests, but on=
ce
> > > compromised, this self-protection mechanism could be disabled, which =
is
> > > not the case with this dedicated hypercall.
> > > =

> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Sean Christopherson <seanjc@google.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Wanpeng Li <wanpengli@tencent.com>
> > > Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20230505152046.6575-6-mic@digikod.net
> > [...]
> > >   	hw_cr4 =3D (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE=
);
> > >   	if (is_unrestricted_guest(vcpu))
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index ffab64d08de3..a529455359ac 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -7927,11 +7927,77 @@ static unsigned long emulator_get_cr(struct x=
86_emulate_ctxt *ctxt, int cr)
> > >   	return value;
> > >   }
> > > +#ifdef CONFIG_HEKI
> > > +
> > > +extern unsigned long cr4_pinned_mask;
> > > +
> > =

> > Can this be moved to a header file?
> =

> Yep, but I'm not sure which one. Any preference Kees?

Uh, er, I was never expecting that mask to be non-static. ;) To that
end, how about putting it in arch/x86/kvm/x86.h ?

-- =

Kees Cook
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
