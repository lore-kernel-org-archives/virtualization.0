Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F789125A2
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Y53/rvIP"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBC94817AC
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBC94817AC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=Y53/rvIP
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BG-_0FDAZKNg
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 06:28:55 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 70E6981762
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 06:28:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70E6981762
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-336437ae847so5711966f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 22:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703053733; x=1703658533; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RPPmR/uM9nAC/lsb/R3M+XWi3zjQqfwtT2yANqByHhs=;
        b=Y53/rvIPyIo5kEafWqOgxhNHTWcwRAstysdEPuUr7BRN7IxOMMBvHH4fZdtg+oXvJc
         M3Sycycqc5g30q8r+/PauQ9DkCId5BgM6XIle9Zl1RxTz3Yam0bmS5s49ROD+MZGYazL
         KzmbaOrhJdkh9d0fDeMF15WALX3D6JCE+BVDNrAulynCrcHryoK9PCOSOIdrzkrPinne
         D80GswPPUCruhO5pm7lWxWCQL65+Tez8Wp/MhEJhBgaZp5+6dZfWpBKXYp2bh7QFbdA9
         PxEGw8expOXfqg2YRwmL3l6HnxaPsdKcjSxQyRRpomlR5GgKZ/QYHH6guBsQX/ZlbaLc
         vF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703053733; x=1703658533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPPmR/uM9nAC/lsb/R3M+XWi3zjQqfwtT2yANqByHhs=;
        b=bc/wELbGbsNevBpP7JeXiUqUFbgjvVOULrfmUkwBbi/dzBi83twnJB+zqkC6MgsqkF
         AciS9+whiBRutfa3c+X9G8MJ64zZg+QY3g/AbRGWvPNFe3SZUorLavBCAhwm88jhImbm
         S2IN0zB6MhJgtYq9ltuM37Bnc73tYqQHPExMBUPj1M1gsnZZ5T1TBXl//ZblMjaK2Ruk
         zcDkO1EII6UB3yvO3TForO/lZAe3+IrHWuYmZ88TZ7TlwJWpwQ9h38UEyAW/ngOhXk2y
         pdiIm9A9p372PbTjy3fbBYn7jsH/VXseKQDwFPO4kPi6Q5w8b15QdkpzdMpnZTC7NKMK
         FtNw==
X-Gm-Message-State: AOJu0YwMXXwLjx0r0CYR/Pqlu/bN0d4EBxSwu+UL79MxXc5Q69CuMUqu
	aZBBzDBbXBxmhLAskpbASIyFyw==
X-Google-Smtp-Source: AGHT+IEuui6TSNxo/rZ9doeCkkv2CjoSQEkhy8rtjUJ/m/SdfFAEOgyS4RYG9Taw1AzEpZfqB81lvQ==
X-Received: by 2002:a05:600c:2047:b0:40c:3dd7:98dc with SMTP id p7-20020a05600c204700b0040c3dd798dcmr9979769wmg.75.1703053733337;
        Tue, 19 Dec 2023 22:28:53 -0800 (PST)
Received: from localhost (cst-prg-1-247.cust.vodafone.cz. [46.135.1.247])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040d2524270asm5860417wmo.8.2023.12.19.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 22:28:53 -0800 (PST)
Date: Wed, 20 Dec 2023 07:28:51 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, pbonzini@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH v3 11/13] RISC-V: KVM: selftests: Add
 guest_sbi_probe_extension
Message-ID: <20231220-3a173b8727d455756f691508@orel>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
 <20231217204019.36492-26-ajones@ventanamicro.com>
 <CAOnJCUKu1069YXRWopFDjRobF4jjskdFJMQH1oD2wPc+9JoBmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCUKu1069YXRWopFDjRobF4jjskdFJMQH1oD2wPc+9JoBmg@mail.gmail.com>

On Tue, Dec 19, 2023 at 01:57:21PM -0800, Atish Patra wrote:
> On Sun, Dec 17, 2023 at 12:40 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > Add guest_sbi_probe_extension(), allowing guest code to probe for
> > SBI extensions. As guest_sbi_probe_extension() needs
> > SBI_ERR_NOT_SUPPORTED, take the opportunity to bring in all SBI
> > error codes. We don't bring in all current extension IDs or base
> > extension function IDs though, even though we need one of each,
> > because we'd prefer to bring those in as necessary.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  .../selftests/kvm/include/riscv/processor.h   | 21 +++++++++++++++++++
> >  .../selftests/kvm/lib/riscv/processor.c       | 19 +++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> > index e70ccda2011b..dc50ad62e150 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -108,6 +108,17 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
> >  #define SATP_ASID_SHIFT                                44
> >  #define SATP_ASID_MASK                         _AC(0xFFFF, UL)
> >
> > +/* SBI return error codes */
> > +#define SBI_SUCCESS                            0
> > +#define SBI_ERR_FAILURE                                -1
> > +#define SBI_ERR_NOT_SUPPORTED                  -2
> > +#define SBI_ERR_INVALID_PARAM                  -3
> > +#define SBI_ERR_DENIED                         -4
> > +#define SBI_ERR_INVALID_ADDRESS                        -5
> > +#define SBI_ERR_ALREADY_AVAILABLE              -6
> > +#define SBI_ERR_ALREADY_STARTED                        -7
> > +#define SBI_ERR_ALREADY_STOPPED                        -8
> > +
> 
> Add SBI_ERR_NO_SHMEM as well ?

I can add it now to selftests, but it won't get used (steal-time doesn't
use it since it doesn't have any SBI functions that use an already set up
shared memory region). It's also not yet in Linux, so KVM selftests would
be "ahead" of Linux in this regard. And, while the naming shouldn't be
controversial, I suppose we should commit the name to Linux first to be sure
we port it correctly here. So let's wait until we have a KVM selftests
user, which means it'll also be in Linux.

> 
> >  #define SBI_EXT_EXPERIMENTAL_START             0x08000000
> >  #define SBI_EXT_EXPERIMENTAL_END               0x08FFFFFF
> >
> > @@ -115,6 +126,14 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
> >  #define KVM_RISCV_SELFTESTS_SBI_UCALL          0
> >  #define KVM_RISCV_SELFTESTS_SBI_UNEXP          1
> >
> > +enum sbi_ext_id {
> > +       SBI_EXT_BASE = 0x10,
> > +};
> > +
> > +enum sbi_ext_base_fid {
> > +       SBI_EXT_BASE_PROBE_EXT = 3,
> > +};
> > +
> >  struct sbiret {
> >         long error;
> >         long value;
> > @@ -125,4 +144,6 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> >                         unsigned long arg3, unsigned long arg4,
> >                         unsigned long arg5);
> >
> > +bool guest_sbi_probe_extension(int extid, long *out_val);
> > +
> >  #endif /* SELFTEST_KVM_PROCESSOR_H */
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > index 6905a4348380..7ca736fb4194 100644
> > --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > @@ -393,3 +393,22 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> >
> >         return ret;
> >  }
> > +
> > +bool guest_sbi_probe_extension(int extid, long *out_val)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
> > +                       0, 0, 0, 0, 0);
> > +
> > +       __GUEST_ASSERT(!ret.error || ret.error == SBI_ERR_NOT_SUPPORTED,
> > +                      "ret.error=%ld, ret.value=%ld\n", ret.error, ret.value);
> > +
> > +       if (ret.error == SBI_ERR_NOT_SUPPORTED)
> > +               return false;
> > +
> > +       if (out_val)
> > +               *out_val = ret.value;
> > +
> > +       return true;
> > +}
> > --
> > 2.43.0
> >
> 
> 
> Apart from that, LGTM.
> 
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Thanks,
drew

> 
> -- 
> Regards,
> Atish
