Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F5489880
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132967; cv=none; b=ENBiI9xUW8AbLqehd6t14h61bgHFk12QYsoJnVbeJoVe/QIv7Ip7JLSwn3wROm4/dWpnHqu8c0qnXyLT0M706VafdMjke+2MVvdgdmZgMG2Q1f/Ge3BS+NWbtXSgAyyg56cwurof1WWyy/PXiixBNMWuSxqrUDYeDrNcEE9I1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132967; c=relaxed/simple;
	bh=T/e2vgzi/yX3haBVonSYMOMOZ1YJ8sxvxQcGMOKmPKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XyeoBXxInWyGc6VULiWZKZuHVDF+Jl3WJpUjWTlz9t0VGmCFrkL5RUACuAs+Se140dGYcjzMOmsn/VMnV42mojD6duVihilAlCIW79D3V4rcOaeQ+iXSBvE1n7VeyIZZ6qxRNLqKBXLO0s4WuNuVv4K8GD/bnQUtX0xi5iQWf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nyosg7EL; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nyosg7EL"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so1545497a91.3
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789132963; x=1789737763; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqAHaS5fsv9ERkHKe2Kmet0fUHotC014bD2kFqqX4to=;
        b=Nyosg7ELmIe0I76HtKPrCoTX2jFPKtsiQxJqme1pHCK7+KR9M9/qSBnmH/CYGRX7KH
         IqvaCHAIb1tLA8wPB0aSFKveIQ13GKwXNCsn14adTKX0qBLmDt7Iw4P5GrG9VyqD3Qkq
         cRxWAToq3Fsb5BoaKD6cQcRnEZgRtEvlO22eOxhI+N2prSg4/ze63mUzLvPmLQfMJLYq
         XVjU6p23fISWwEHFul9ihdaWSHb1Isq+Ja+UU558GxhziQpVX/PH4hTUCsr5pGVj+9Cg
         lpxL8+LQvdwiJ/gOEKrbTybicDcd5jD4OqZxtvlPCseSue6MD5nypyGgiGNbSxRGWH/K
         DA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789132963; x=1789737763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqAHaS5fsv9ERkHKe2Kmet0fUHotC014bD2kFqqX4to=;
        b=ETo/hiKvrIb2rmBnmqe1PmLoX+ccuu05waK0M9z4rcIZowCYQn8WznywOEBwhePXzW
         kh67u1Gc38e7VNaC9gfISx3NEJ9LSYEswl6Akr31bqnL61SkoocKw4TQgjVLYEen6IBy
         g5vuG0oYybiUdxeJb/u/hwte+gLxJYrokuy5B9tlnko4azBbYOOKobps3cR8JVy/s1Kc
         UWs4iqOHZ9Eth0crfUKYRKUUrkxA4bSIA6u6B1iUXaoUmvvYg0Nhz6usFQUoDYeYx3qt
         X+FA5PPjWWRq2iVC8j0oBoutupXnELiEc1fFIGnfVD2EwL9+ecnHHeIkEk5zEWti/Xyb
         njhA==
X-Forwarded-Encrypted: i=1; AKwUvBxRdxliChN25nlrt5OCvGJ4orzux0NIs0zeodHV31odEeZ4zkwXhyiIHf+RqAtiU6vdXYyHThsEsOnrBMlTnw==@lists.linux.dev
X-Gm-Message-State: AFuF++mLThw1MnnvzASAbA7xekxel+yeiM/aF10dcQKxpRtYfZkzPBWx
	fqTmfIXyROVkyR965/ITfSbDZXPACBozVxGnFrqc6n6wYr1BBSQlb0Vd6QzbvsMv5UHZPK3DjEl
	q5fsaHw==
X-Received: from pjbmv13.prod.google.com ([2002:a17:90b:198d:b0:39d:8dae:7e6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c89:b0:398:e46e:ade3
 with SMTP id 98e67ed59e1d1-39d9c39625dmr7169956a91.23.1789132962606; Fri, 11
 Sep 2026 06:22:42 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:22:41 -0700
In-Reply-To: <20260911074530.3140830-13-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260911074530.3140830-1-jgross@suse.com> <20260911074530.3140830-13-jgross@suse.com>
Message-ID: <aqQAodJCAEZyeQ1k@google.com>
Subject: Re: [PATCH v3 12/13] treewide: convert rdmsrq() from a macro to an
 inline function
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-crypto@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Pu Wen <puwen@hygon.cn>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Len Brown <lenb@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	David Airlie <airlied@redhat.com>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Artem Bityutskiy <dedekind1@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Ashok Raj <ashok.raj.linux@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, 
	"Ilpo =?utf-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, Xi Pardee <xi.pardee@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Helge Deller <deller@gmx.de>, xen-devel@lists.xenproject.org, 
	linux-geode@lists.infradead.org, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 11, 2026, Juergen Gross wrote:
> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
> 
> Convert rdmsrq() to an inline function returning the MSR value.
> 
> The users have been converted using the following semantic patch:
> 
>   // Options: --include-headers
> 
>   virtual patch
>   virtual report
> 
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val = rdmsrq(msr)
>   )
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>      # ATA
> Reviewed-by: Michael Kelley <mhklinux@outlook.com> # Hyper-V
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
