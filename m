Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826801;
	b=l9IovyvxlKB4ZmbzHoN+QNwbcUs5rFGrShAqrOoZ51KdUbvESz9ntRCANHDsETUIe2Jn
	 2Kw4zeWh4LM4Scofmc5txpzKf517jGW9vWzZ2xefIvn/PoqELvuZU9aGaXeU6bA16xkUY
	 jQlNzSZSQJ62QLkjmnsAIDPvRNiItCsDuYYiGhcFyI8cOLd2A7koBOB6l7T0c9PQGhN4S
	 Fe4sY8F52YgR3igQHzFi6vCLKA4cRlzZ+Vyhk6y7EcTSuaEgDKuH+2zMlTe9loN8fWehQ
	 LreGca6S7vssNcd6fPoXP0PORdXTf1YZHyH7dxz2CsU+9f2DtZGb9htzavPvHyyDdMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826801;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0j7BAmeDQwwtoMBbI3yPl2jkhlbza1J7ZyqEZwxFy/Q=;
	b=qFTbFupTO1ZYocoRjsTQrPx3QVCu40V7LLxyMS71S370fHqSZpzGwRiN16QANZ12W80m
	 W3cKCB6V+UuNCgp4KDjZ69yt+d6r/CFuVzK7RaFFvE+PE7L/a9vnKHeD0y4odPRUPvEJG
	 uaMFVRDK/ZCAa4CMXbaBHK9yDuSObf29AJGx5BT2EMbvrDHxdLG8pAjDlaVErjC0tRcH4
	 Ah4JTFVE+34YVLZ92I16PqEUlpl8KXkU+kHhjCoCgjdfw3WjdyqO/p21NzEO6yJFrwJ4x
	 K/M3HK3QZFG5Aj9UKFfI2EN1Kp/Q7efTLWNG1dxsXBhhW7prEKGJf4nl6TM4uCbT+SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=U2D3wB8g;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB76071A00;
	Wed,  4 Nov 2026 21:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEFB76071A00
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=U2D3wB8g
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CD5940E015B;
	Wed,  4 Nov 2026 21:13:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3U2b1QxYClr0; Wed,  4 Nov 2026 21:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793826783; bh=0j7BAmeDQwwtoMBbI3yPl2jkhlbza1J7ZyqEZwxFy/Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U2D3wB8gdl4a43Fm64mNA6ZM2USpJCLIwCtamRC4PcjkbT+N3A+hed3l9E18bhVyX
	 oyhZdr4pmbZ9eFP5+UCjaiCqxDqDEyCl5ThDEaSCrWe2xKlb2DMAun1RtooMcmRDqa
	 eDsyzK2506LRm7jgiN+z6u0Z1GSJ6mRPPgSKdtbyccDShhNEccOFW/K62qudpbnOHO
	 SuXkb4mORY7livXLiDQ5+Ip3dhFyNLyBkSYk8+E/lcB8GyQjyDz6I/LGeYT5wFvdBj
	 FKYmI/T9PuFn7AWswVv0APe7rfg2hIcSKMRF4R3nCwdF87X5HfcAZi2pnEz6WA2+8k
	 bEgan0ne6CSX6MMOvrHt4UoxaCLJIB74x5NpPo5jrHn7UD+kmGPkTKobaONv8p8eym
	 lsXxoQ+Iw1u25zQiuWo2B+I6nBcwQfZxDqWFuXkh0s8suZoS+fsGW5BIXPFwGHmCjW
	 h9d+gKicHVqg9hI1B/pB8JJ71qDvalixTPqVIl6tG+dSHRTJSU8ENCPsEW7V+RMGV9
	 f+p4oTHAT38MTk38E04WDhaktVkQ3/v2M/KgowJqc897S71W4JCMPk05g3RqtWVczr
	 14fNyyPqp67ozGOUyRQEtaJDemz2FCPZ+WTgKsrUg+W0CM0uspv1CtxXXyYzxM65w5
	 7jyZ1iDKDaNuk1lF+8s1+8zs=
Received: from ehlo.thunderbird.net (mobile-166-137-178-199.mycingular.net [166.137.178.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A83DE40E0184;
	Wed,  4 Nov 2026 21:12:25 +0000 (UTC)
Date: Wed, 04 Nov 2026 21:12:19 +0000
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>,
 David Woodhouse <dwmw2@infradead.org>
CC: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, John Stultz <jstultz@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 Michael Kelley <mhklinux@outlook.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 00/51] x86: Try to wrangle PV clocks vs. TSC
User-Agent: K-9 Mail for Android
In-Reply-To: <auuJjiowddGlysWI@google.com>
References: <20260806233609.212337-1-seanjc@google.com> <aqLv9GwBNymyHs8q@google.com> <c9a6455eb88c24d4271b7a7c86f7a4e90799e40a.camel@infradead.org> <auuJjiowddGlysWI@google.com>
Message-ID: <375997C1-577B-440C-B347-B8D256FA84B3@alien8.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 4, 2026 7:37:50 PM UTC, Sean Christopherson <seanjc@google=2Eco=
m> wrote:
>On Thu, Sep 10, 2026, David Woodhouse wrote:
>> On Thu, 2026-09-10 at 10:59 -0700, Sean Christopherson wrote:
>> > On Thu, Aug 06, 2026, Sean Christopherson wrote:
>> > > The primary goal of this series to fix flaws with SNP and TDX guest=
s where a
>> > > PV clock provided by the untrusted hypervisor is used instead of th=
e secure
>> > > TSC that is controlled by trusted firmware=2E
>> > >=20
>> > > The secondary goal is modernize running under KVM=2E=C2=A0 Currentl=
y, KVM guests will
>> > > use TSC for clocksource, but not sched_clock=2E=C2=A0 And Linux-as-=
a-KVM-guest doesn't
>> > > support paravirt enumeration of the TSC/APIC frequencies, even thou=
gh QEMU
>> > > provides that information by default=2E
>> > >=20
>> > > The tertiary goal is to clean up the PV clock code to deduplicate l=
ogic across
>> > > hypervisors, and to hopefully make it all easier to maintain going =
forward=2E
>> > >=20
>> > > The quaternary goal is to clean up the TSC calibration code, which =
was made
>> > > stupidly hard to follow by hypervisor code mixing in with the nativ=
e
>> > > calibration routines, instead of being implemented as a pure altern=
ative=2E
>> > >=20
>> > > Note, the VMware and Xen changes still probably should get acks fro=
m those
>> > > maintainers, as my understanding of what they're trying to do may b=
e flawed=2E
>> >=20
>> > This (thankfully) still applies cleanly=2E=C2=A0 What can I do to hel=
p move this forward?
>>=20
>> Nudge Thomas to spot that this is guest-side and we want him to pick it=
 up, I guess?
>
>Amazingly, still applies cleanly on 7=2E4-rc1 and tip/master=2E  I know w=
e're shortly
>after the merge window, but this has been sitting idle for months and add=
resses
>issues that are impacting a variety of end users=2E
>
>Note, this also provides meaningful hardening for SNP and TDX=2E  /me sta=
res intently
>in the direction of Dave and Boris=2E

Would you believe me if I told you you're in the "review" mbox?

The damn thing just keeps growing constantly :-/

I would love it if we had a review scoring thing like the net folks - whoe=
ver reviews others' patches, gets looked at first=2E=2E=2E and no, I don't =
mean you with that=2E

:)
--=20
Small device=2E Typos and formatting crap
