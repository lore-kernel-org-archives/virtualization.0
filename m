Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA371C69D
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XdRUyBDf"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78738410B7
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 14:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78738410B7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=XdRUyBDf
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A_yW5iHo3RYh
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 14:30:02 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 44EEE4159C
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 14:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44EEE4159C
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a236d2cc372so192813766b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702996200; x=1703601000; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LmB6XvSqGvAwRBDdkbtoIzjwp96a7xR5GmSDPtFeoNg=;
        b=XdRUyBDf17Iu/veag+XGR9o1MBopQ+RwLtKXqIh22so9uLoUb2F1+7vrh/hrqWKdIV
         XwdC+eAIM28jza/HSm3kXx7LFgEcJLqt5LI/Y6dP55KJ8e/he3/jbCKZ4R+0AlMQ3oOi
         4eyfv7fVZE/EvYvRWq+B/qb1vWwG3xb8EcZX+GIImVqBxFZnd0W1HozUkeGub0lXix85
         Mi5rlTo8XIQUs73mmI/N/wJ44TctAgDY9gA7DxgQl9+yvMjdxHb/ATppbU8vWr7my5p6
         Sf2zlHvmp8UODv92ZV3ugA0jiF1opKsFFtqp2HDCrBgCppOKT67qBwrwitI+GHG8+t4y
         j8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996200; x=1703601000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmB6XvSqGvAwRBDdkbtoIzjwp96a7xR5GmSDPtFeoNg=;
        b=pd2DaA3sZNnAOO+cMBZIttktQaV53y3WMzdxe1I+baiAV/St1eZRdsP9fzZhdOiegr
         vmuUAYX9UQywruBTMTxxhQ7kb4Sy3HY/cg1HK7Yvz6NHy/fCZYPEJ2mcImPvBiK7UTC1
         3vu3kZKRSegCqbHeiW24qQ6Rg+Pz+qpcaQ0Ylr7tZqgsGoifp0wezWM6UcySxDo4oNYF
         KXwEpjJSukrlML695gh8mlephOlnzO2Pur10QdzRyycYd6WZrSWjQB8xFkpgd7lfM7xG
         HxT8TQLrDy+8PSrvYx7r/5GnRzNa+q72TjmVA8GaNqlbdNzlBikxprR1Os/nroeTOkZj
         tEZA==
X-Gm-Message-State: AOJu0Yxsr6w/a0LmHfeaZD50DIV1yb6lO1H+K3wsZWWwenA2JPnvC6LE
	vP1PfZrdvd8/FJgGv9tSAaxGoA==
X-Google-Smtp-Source: AGHT+IHwNjxs5OhEsK3+Gz90Sq6b7RCFum4m3Y7neFzvc/yieqcSn85ljedasiaSoZ8JlNEfAqxM/g==
X-Received: by 2002:a17:906:c0cc:b0:a1f:612a:d3b5 with SMTP id bn12-20020a170906c0cc00b00a1f612ad3b5mr9645315ejb.141.1702996199984;
        Tue, 19 Dec 2023 06:29:59 -0800 (PST)
Received: from localhost (cst-prg-1-247.cust.vodafone.cz. [46.135.1.247])
        by smtp.gmail.com with ESMTPSA id th18-20020a1709078e1200b00a1f8df4e2d5sm13346430ejc.178.2023.12.19.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:29:59 -0800 (PST)
Date: Tue, 19 Dec 2023 15:29:57 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, pbonzini@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH v3 01/13] RISC-V: paravirt: Add skeleton for pv-time
 support
Message-ID: <20231219-3ed5ceb6bcb61fcfebc4a342@orel>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
 <20231217204019.36492-16-ajones@ventanamicro.com>
 <CAOnJCULYeMz63LA-MR-Y9HqCU+dhBQdXf7Shwhu1FXFuck5gWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCULYeMz63LA-MR-Y9HqCU+dhBQdXf7Shwhu1FXFuck5gWA@mail.gmail.com>

On Mon, Dec 18, 2023 at 04:48:04PM -0800, Atish Patra wrote:
> On Sun, Dec 17, 2023 at 12:40 PM Andrew Jones <ajones@ventanamicro.com> wrote:
...
> > +int __init pv_time_init(void)
> > +{
> > +       int ret;
> > +
> > +       if (!has_pv_steal_clock())
> > +               return 0;
> > +
> > +       ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                               "riscv/pv_time:online",
> > +                               pv_time_cpu_online,
> > +                               pv_time_cpu_down_prepare);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       static_call_update(pv_steal_clock, pv_time_steal_clock);
> > +
> > +       static_key_slow_inc(&paravirt_steal_enabled);
> > +       if (steal_acc)
> > +               static_key_slow_inc(&paravirt_steal_rq_enabled);
> > +
> > +       pr_info("using paravirt steal-time\n");
> > +
> 
> Nit comment:
> If the scheduler doesn't take stolen time into consideration (when If
> no-steal-acc is specified in the command line),
> the above log is a bit misleading ? ARM64 also seems to be doing the
> same thing.
> 
> Maybe the intention of the log is to steal time extension presence
> rather than actual usage in place ?

You're right that the word "using" isn't great. "Computing" would be
better as, even with no-steal-acc, steal time gets computed and shows
up in /proc/stat.

> 
> > +       return 0;
> > +}
> > diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> > index 23641e82a9df..ba3477197789 100644
> > --- a/arch/riscv/kernel/time.c
> > +++ b/arch/riscv/kernel/time.c
> > @@ -12,6 +12,7 @@
> >  #include <asm/sbi.h>
> >  #include <asm/processor.h>
> >  #include <asm/timex.h>
> > +#include <asm/paravirt.h>
> >
> >  unsigned long riscv_timebase __ro_after_init;
> >  EXPORT_SYMBOL_GPL(riscv_timebase);
> > @@ -45,4 +46,6 @@ void __init time_init(void)
> >         timer_probe();
> >
> >         tick_setup_hrtimer_broadcast();
> > +
> > +       pv_time_init();
> >  }
> > --
> > 2.43.0
> >
> 
> Other than that, lgtm.
> 
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Thanks,
drew
