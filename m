Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973013EA953
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299802; cv=none; b=SWp2d3RwKaNrJdnkSZs8wUIpEGltbrNMy5Ajg6VnUvrVYaQGjZK3ClrTJ4hRfcmf6jZkgc6dXYCceufjtaUJ8gmqpFqZDpKPPefWHqCd1bKt53E0CLdgtxRI/Ezh+FiPukYmC3VGthaf6GOGhpkzA2e+dPz3C5H7ZIWBGQe3WNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299802; c=relaxed/simple;
	bh=Dublram4OvvOps1rJjL7126QT2HdDhXkpgA6+9a2oHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ki5xWeuB8TlsrO9iFmr4/QtjctBNOxqabZOnqBBqiFsYROuduTbUc6PVhczUwNY3dCG4u3T4ANSNJBen62qgOCEZAOt+e/bAHYvfCR32K/YPouz1hhBMAXrqn8een5Iee2QF/4HL87uvKc/LksAPfOwBBqJemG3LSdt3yqg8liw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZPhEj3G; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZPhEj3G"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so2931402a12.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779299799; x=1779904599; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6+hlvnmwj5Awnxfo2Fw5NZ8DPJZlHGIf0en9UEe6nA=;
        b=UZPhEj3GVHSTo5F067/5S01sX3yfbN/HkaJQJjIrzOUQQiNANv6kjdOUbXEhiBAX9j
         mKBlaoOh+UhUwlu+CpCRtFnVjo9Y/M3FE0ZMQ1XJ3ti/jU/S3Ts2/S++xExMl/KHQsDP
         mf/t79BS3t3PaepXLa7mifOdk0DXdG5OxHqxmJjbb2bvP7KI18uYE3N7HpgAt4JVDfYE
         wVaRkbZemyQs+gwUKSXs8bwZ9x4wW52j2DWai3P2Mjhc7zvetsDyY7aFjS6Co6SZncEA
         NfMnFJhLLe+J2g56S90wqLeY/1h42i4I2rwcVu5SvfF258D9Kkde62T6C4PyM4AZqS27
         RbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299799; x=1779904599;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s6+hlvnmwj5Awnxfo2Fw5NZ8DPJZlHGIf0en9UEe6nA=;
        b=gIF1j/XgaEd9Hz87M6V/aDONDzo+EJqYJXqQ3XG0J1A8pHhBHU5GeFwbnGY+eAmw6H
         lehvd8ZGMdxLyr98EIEou6xtbvVtKCQ64T4O27bbNEw50TvktkRmgtPILcO5gfQ7YDgv
         GuCeqv6Ly22VNmG5lVurH9QvlsUdwvlYvRjscH5Dx9FonovRJaKwD55YmbY37Il3WiYA
         oDZVAKxhYY36rgk72+9MYc19kIb2j5Nf6/j87ZEiVgtE9srMjDjspOIFVdlhgMqt2NYC
         uYK5NRUYbcUWH4I9HzVyePo/SSlTY4wTBM16rc4uGQt+0DfqUWvJJPVFisxTIRcncjoo
         BbzA==
X-Forwarded-Encrypted: i=1; AFNElJ+xuDkkareD0pQM3nbCIrMK4T2H9TPPXUH7MwPdZroy9a9X/cbKQf1b3W7PxVkMv49SkjEH+/Vt7AmMVncl6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyx7izF+IGNvY2b705vkpBvEABNb7N82nlDkUWqAblp9r4U0uAd
	53QEU8ra3HdjVJlZraJi5RDgbEsb+qCuN93SmVMY1aCfoTiTw5Pzzq9KNOEXGkwWHYqqqZbWaHh
	Sy4bbZg==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3028:b0:837:8c8f:8f51
 with SMTP id d2e1a72fcca58-83f33db3f0dmr25728027b3a.47.1779299798653; Wed, 20
 May 2026 10:56:38 -0700 (PDT)
Date: Wed, 20 May 2026 10:56:38 -0700
In-Reply-To: <949e39aec749f019b18fa41c2a42bcc9231288b9.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <949e39aec749f019b18fa41c2a42bcc9231288b9.camel@amazon.co.uk>
Message-ID: <ag311hHnqrCGR9Jc@google.com>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: "tglx@kernel.org" <tglx@kernel.org>, "longli@microsoft.com" <longli@microsoft.com>, 
	"luto@kernel.org" <luto@kernel.org>, 
	"alexey.makhalov@broadcom.com" <alexey.makhalov@broadcom.com>, "jstultz@google.com" <jstultz@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"ajay.kaher@broadcom.com" <ajay.kaher@broadcom.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, 
	"daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "jgross@suse.com" <jgross@suse.com>, 
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "nikunj@amd.com" <nikunj@amd.com>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> >=20
> > --- a/arch/x86/xen/time.c
> > +++ b/arch/x86/xen/time.c
> > @@ -569,7 +569,7 @@ static void __init xen_init_time_common(void)
> > =C2=A0	static_call_update(pv_steal_clock, xen_steal_clock);
> > =C2=A0	paravirt_set_sched_clock(xen_sched_clock);
> > =C2=A0
> > -	x86_platform.calibrate_tsc =3D xen_tsc_khz;
> > +	tsc_register_calibration_routines(xen_tsc_khz, NULL);
> > =C2=A0	x86_platform.get_wallclock =3D xen_get_wallclock;
> > =C2=A0}
> > =C2=A0
>=20
> xen_tsc_khz() doesn't use CPUID but really *should*.
>=20
> Care to pull in
> https://lore.kernel.org/all/20260509224824.3264567-31-dwmw2@infradead.org=
/
> to your next round please?
>=20
> (Without the misplaced changes in kvm/x86.c that should have been in
> two different prior commits, and are now folded into those correctly in
> my kvmclock5 branch ready for the next posting of that).

Ya, will do.  What's one more patch...
