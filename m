Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821072;
	b=N7nv+Jtl3zisP8DW9bY4/NHKghANV8/TmpbxCO+eEIhVRwWntXpraV6PLE1Po1qBjSkI
	 C7MY0UvtKV3Js3KFcHbl7y3sQ3YsWFrmWCpuNqd9KWd8S+nI06Pr5n6ZEs9W5eh2vjo9Q
	 +xk3SMplBI90ycnQW3/nIaXdFVYWwlZGAc9YFnk4M4B8xCEH+qxnaDDdGtxeDVf1xIGYc
	 rO6HWg3/ipUkjOcqty2mlVxl0kDDSwFCjBfoVJwsWit880RAvzhytLL0zutAlRRNYccGb
	 ciEgkRy2Ny+o3PuEMFDIhcNnMOTeCmVm97JSwhD0lhwAJtIkXMXSgna1Hiz4ckLlQaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=/5MszlfJHB7Xr7Xp5GjEvhWx25u5UBjAyc2/c9bnue0=;
	b=JnBhvpO7ivdgVpyoP1LOoAQ+c2zZlTy7T+1sOoTZokL/pNYd8lSO+kTldoAMnXr4+Jyk
	 S7wKpUOQQ9u5w+Pq7yWa9kgDqB/yaQY0Z5QVy3i/2whqwYomXnIzhZmFqChwUma6jmYY5
	 4lkaVO4jnMf79RBiKCVyVijCAxRbr85d2YVgIyzYgjctska5EuR4YIypBt5Khkp3xkNRt
	 /yJeDbYktb77nDz6pwU9io3jn3qk3SVqz6p9uriIVPVvWce6h2G4OYQqqvnh4i0O9AIVU
	 /l886kOmJNxbjOx1lH8e0YaFhvdzoxZUu77nIFwiDM7sdi/unkPecvL/wC+ReLn+YdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ee6AMn5b;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43860B4C03
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 19:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B43860B4C03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ee6AMn5b
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eb2437d752so15698155ad.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793821071; x=1794425871; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/5MszlfJHB7Xr7Xp5GjEvhWx25u5UBjAyc2/c9bnue0=;
        b=Ee6AMn5bfUK+y0OpzwmKyBxhk6j6xNUGvBlwR8hOxQ06TQLfj91odSF1TsKr9z+MOb
         DQvdM1N0+zMs3G3zjkndSdLKm9umd8m74B7SkOxLgdswtvToeNIDWh+np6Ew6J9AUA5W
         O8dIM9JASmcOyGcxBJ6hNg7ZOYvhpslPP0zn1+xWcwpN3u9dFMERcYcrsbB803DjHwqH
         n7cf1kxkqEL3SDW3vhfeQIlqTBeG6nRy5Jx0psJ8YhscA/M2SqKg2h+pBwkxxEXu37/4
         Wpclj57TNo8JndwREzDpimCjKw/IgPPQ53FKvUBxGMKvBB0Hs8TilXlaFV4MiT5FPneb
         +Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821071; x=1794425871;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5MszlfJHB7Xr7Xp5GjEvhWx25u5UBjAyc2/c9bnue0=;
        b=hXwZw+LgoCa9EQq5ntK1VN/kfJodu2BBYuY3Anx0dvhc443RR29NpimwQOm+ing6ER
         uIsER3fzX2XLyE8PgNmIAxTe1f27FX56bPV3sUxmMGIEhVD5aZvye03o0d/qyID/UYyB
         aUue5hT1gc/22HksCAr6O+Lfq8wZ5Ro2ydguuX1SvHixPdTlhTx6aTlDxwEltC5de+UV
         4UrIZ0gTwBSavYyAZ+2oBe2fjT5t2bY0C/DwepYqIST2DpLHPcOClIu3EqPk2Icg9iSD
         Ejvz4L2U0IL9W4LG9hNGjA6aWYSy152zRpYgrymsWaZEYX+rRwqC0Q6MS5qROPjfdD9Y
         Lhiw==
X-Forwarded-Encrypted: i=1; AKwUvBw1M1H6z5DNmEr1PE+h0YtsMEcUb6XaCZ7+Cp1+Pcn/n0BPpHWU7Fhja/ZROjatZFnjR8kI0TOn9gi3WDZQdg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+anFRkOrB5CY7I2aBQCA3Nut4R0h5UaenfvfSrTmHnU7VD38y0
	AXrtLqoVCGx8cMuDnOdl4pxcZ522oLofAdOxhi7KLcaaUABRMmslLloRxw5S+KQh7/boj754pfc
	bzDiemw==
X-Received: from plww1.prod.google.com ([2002:a17:902:d101:b0:2e9:4a78:9294])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1986:b0:2e9:4d9f:a65b
 with SMTP id d9443c01a7336-2eb3651d564mr160599195ad.53.1793821071087; Wed, 04
 Nov 2026 11:37:51 -0800 (PST)
Date: Wed, 4 Nov 2026 11:37:50 -0800
In-Reply-To: <c9a6455eb88c24d4271b7a7c86f7a4e90799e40a.camel@infradead.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com> <aqLv9GwBNymyHs8q@google.com>
 <c9a6455eb88c24d4271b7a7c86f7a4e90799e40a.camel@infradead.org>
Message-ID: <auuJjiowddGlysWI@google.com>
Subject: Re: [PATCH v6 00/51] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026, David Woodhouse wrote:
> On Thu, 2026-09-10 at 10:59 -0700, Sean Christopherson wrote:
> > On Thu, Aug 06, 2026, Sean Christopherson wrote:
> > > The primary goal of this series to fix flaws with SNP and TDX guests =
where a
> > > PV clock provided by the untrusted hypervisor is used instead of the =
secure
> > > TSC that is controlled by trusted firmware.
> > >=20
> > > The secondary goal is modernize running under KVM.=C2=A0 Currently, K=
VM guests will
> > > use TSC for clocksource, but not sched_clock.=C2=A0 And Linux-as-a-KV=
M-guest doesn't
> > > support paravirt enumeration of the TSC/APIC frequencies, even though=
 QEMU
> > > provides that information by default.
> > >=20
> > > The tertiary goal is to clean up the PV clock code to deduplicate log=
ic across
> > > hypervisors, and to hopefully make it all easier to maintain going fo=
rward.
> > >=20
> > > The quaternary goal is to clean up the TSC calibration code, which wa=
s made
> > > stupidly hard to follow by hypervisor code mixing in with the native
> > > calibration routines, instead of being implemented as a pure alternat=
ive.
> > >=20
> > > Note, the VMware and Xen changes still probably should get acks from =
those
> > > maintainers, as my understanding of what they're trying to do may be =
flawed.
> >=20
> > This (thankfully) still applies cleanly.=C2=A0 What can I do to help mo=
ve this forward?
>=20
> Nudge Thomas to spot that this is guest-side and we want him to pick it u=
p, I guess?

Amazingly, still applies cleanly on 7.4-rc1 and tip/master.  I know we're s=
hortly
after the merge window, but this has been sitting idle for months and addre=
sses
issues that are impacting a variety of end users.

Note, this also provides meaningful hardening for SNP and TDX.  /me stares =
intently
in the direction of Dave and Boris.
