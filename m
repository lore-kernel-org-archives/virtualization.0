Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8A3DE436
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845945; cv=none; b=SXxu8Sei4iX+FjyYFgis2r40eOua3Yw+b+QXZ4BhkSC2Q2nDSiiTBg4f2Vrax8ZeYMtzny+vjEjvduxvi6ckia9hbkhw7cJglorlTf91dvp1h2yW/1I3L9G/8xItNfPptBLFaFuhmhcG3qSBkxg6Amh2MncUEjvAIEncMg5CG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845945; c=relaxed/simple;
	bh=XGgg+xXUmnlRvAbgTK542VK34Jp1hfwPb9Na535wrug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BMgWJglRA2H8XklqDXZCgzUUOV5xVUKDCI5E6GVnaQD2VTNJ3baj3+QZZn9LWxXAJMNt49e4GOWvaSqiBvUJfkP5/BbwHOtFw06KidyUHcN78ikvxMdvihQH+vVma72ZADIEluClco1ocakZF2tvQoXqJYBouVscdQqiLMs4f+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wzuhw9Nc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wzuhw9Nc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca0331d0b1so34252415ad.3
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782845943; x=1783450743; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+HRXjFGgcPzOleYtd12nce6K890KkClpjKYcrzynFs=;
        b=Wzuhw9NcSrliCD6nvF6QR/swPeEGcYXtF1EbSQMWOrqLBN9IFCJCUiwt67QrOt4GNE
         aSKGh3ingz5sBkzGBMB3xbKga0iNqXKsejXB6YTA5cj0NeOFAaqCetbooSankyhI9s/W
         wN8OMdj3t7bE3Z9+OUQgWcitAkLH5tg4AFnPygrvFnWhqbA90fq+aRzcGAP5bQk/yL/2
         yVGNIxYXs2e3YMJKH2Yqnd+LEvVVkdI5HOFMttkuBzdHfN5V9aifTcaPVk2DSRwicIhF
         Raanxv8fUQE0z0FGdC3+8MBXtLh8CYZ7bLTIq3mCpLHDWw4U3Zo+Ln9XzzjSg72dX3qi
         IKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845943; x=1783450743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+HRXjFGgcPzOleYtd12nce6K890KkClpjKYcrzynFs=;
        b=mML61i06Mvx1hYhWH6YlinlGpg0ptEsJ+HKjv5bMqJ+aidK2vUtML8OzMLxmco9Cq4
         uPGU08PTuzTlmwK5r5Xdguo9C2NkuG9n2+DD4h2GwYFhVI/p9XWr24dUdAhg+cCJbtc9
         NP6IEgd4iiJD/uZIFG5ybzM2BBgSMkXIDdpehNCQqnQn2yam62BCrzHuNdqLkIhe1C1H
         ynALrxv1t54JghE5q0DeruW8AkLaoRBpIGrc8w2bGlROH8Fn2VKWyQrP8dFtxurkPeB2
         LPPl3wDRd5KpoNdo97WxUgOmOr5fx0ibbsYoFsvbO/Bae9nsDcS7M43iQkpGnIht2SeG
         UMDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2apyWSMQ5WXS5jpMLGwOsVK04J8SYgVv1lkbrROv2p0jOvAhou81HsG4c3btQuFYLH3zfTayYUrYvDaAkEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw69DuYOqSyfbA+6F54o2LWLq6/Lbyy60hPRfN2U0DJj9fqli08
	9b5QhOSKy4zq2QT1i98HvLgYXkM6TCd+vQH/PbaGbExZTX9vXtz80ISEbVoGaqw+VvPKylUCFlC
	Nsi9YGg==
X-Received: from plbko12.prod.google.com ([2002:a17:903:7cc:b0:2c6:9f66:d581])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acd:b0:2c9:c517:d075
 with SMTP id d9443c01a7336-2ca5a581ab5mr15124165ad.15.1782845942348; Tue, 30
 Jun 2026 11:59:02 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:59:01 -0700
In-Reply-To: <akJUz0kYkEBdLSZ3@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629060526.3638272-1-jgross@suse.com> <d7c1db52-529a-43cc-ac7d-38b52627e8bc@app.fastmail.com>
 <c1608c48-13c2-4290-826b-28b5ca51eaf7@suse.com> <7332feff-2649-496c-8e49-b0a19eb54a32@app.fastmail.com>
 <akJUz0kYkEBdLSZ3@gmail.com>
Message-ID: <akQR9YMtMHReJTfB@google.com>
Subject: Re: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
From: Sean Christopherson <seanjc@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, x86@kernel.org, linux-acpi@vger.kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-ide@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-hyperv@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Pu Wen <puwen@hygon.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Reinette Chatre <reinette.chatre@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Helge Deller <deller@gmx.de>, linux-geode@lists.infradead.org, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Artem Bityutskiy <dedekind1@gmail.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Ashok Raj <ashok.raj.linux@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Ingo Molnar wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > >>> Note that most patches of this series are independent from each other.
> > >>> Only the patches removing a specific interface (patches 7, 15, 26 and
> > >>> 30) and the last two patches of the series depend on all previous
> > >>> patches.
> > >> 
> > >> It looks like you are touching most files twice or more here, to
> > >> first convert from rdmsr to rdmsrq and then to change the
> > >> two-argument rdmsrq() macro to a single-argument inline. If you
> > >> introduce the inline version of rdmsrq() first, you should be
> > >> able to skip the second step (patch 31) as they could be able
> > >> to coexist.
> > >
> > > I've discussed how to structure the series with Ingo Molnar before [1]. The
> > > current approach was his preference.
> > 
> > Ok.
> 
> Note that the individual patches are IMO significantly easier to review
> through the actual 32-bit => 64-bit variable assignment changes done
> in isolation (which sometimes include minor cleanups), while
> the Coccinelle semantic patch:
> 
>    { a(b,c) => c = a(b) }
> 
> which changes both the function signature and the order of terms as
> well, is just a single add-on treewide patch.

Is the plan for subsystem maintainers to pick up the relevant patches, and then
do the treewide change one release cycle later?
