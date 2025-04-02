Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D41428E7;
	Wed,  2 Apr 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609455; cv=none; b=aEjgDVd6VZY+9Pc+94rISR4RDSKPMYcjP5bhfYou+QFK9PAEtr0XeyBuRTt4tLDms/9dn/ZNmndq9gFdv4H99EkDjqM5ShkPNzO+AokMFV/+bgRPnhPpk6E0JZzXvHIaBm9CgDs/67zin4MJ6XqOK/74UgiIqj37buRWDfVGFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609455; c=relaxed/simple;
	bh=Xa25b++XKImzKTw5z/38OkUO4BtW0ZFRs8vcKJg4Ci0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FxHU37B4pVF+D0Sj0aYeATH560ffKRfYrQXwdnHXdeJIq49ILqWLTxFshALRCG3Kd4q9FSv827PFbZVPbv3wAM4jmBcOYq6I0FadlF7/L5jGzHUTnlotvfyaHIKVItWE4JEs23KF7Yoyo7G2QHSACcxxE4pL961b3PcX4GoLVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PKY9pYPR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PKY9pYPR"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 532FutGe095148
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 2 Apr 2025 08:56:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 532FutGe095148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1743609418;
	bh=Xa25b++XKImzKTw5z/38OkUO4BtW0ZFRs8vcKJg4Ci0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PKY9pYPRwrzTz3T2wfMHzO5CxQTclyrXpopuE633CLIfZy/ukPrGJisoGqNXqtKGR
	 Kwz413hdEtK5pBXselQWUxDFcZNypXyGZdI8G30/DwRJXDsP4zWDSJB/AE9/Rxd+2y
	 UpqxkHxOPXPWmGYI+FJgvcCaL46+fNbgfHJ0c/b1wjVyQCE2qT0M/ZA7JLtTSrk+kH
	 ZmVpsuIPE4MYWvvrXrlGIXqvQJY0mfJeR5VLbutwJ29pIU+n402Afr0HUdg174buI6
	 LnlSkpy+WJQiHzFkU9vzRc2V7DoFNa6OrQ/gdWEEYK97M+97vAsoAKJUgXaK8+OFNg
	 pTT1Aq8YFeE0Q==
Date: Wed, 02 Apr 2025 08:56:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Xin Li <xin@zytor.com>,
        Ingo Molnar <mingo@kernel.org>
CC: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
        linux-edac@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-ide@vger.kernel.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jgross@suse.com,
        andrew.cooper3@citrix.com, peterz@infradead.org, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        wei.liu@kernel.org, ajay.kaher@broadcom.com,
        alexey.amakhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        tony.luck@intel.com, pbonzini@redhat.com, vkuznets@redhat.com,
        seanjc@google.com, luto@kernel.org, boris.ostrovsky@oracle.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v1_01/15=5D_x86/msr=3A_Re?=
 =?US-ASCII?Q?place_=5F=5Fwrmsr=28=29_with_native=5Fwrmsrl=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <e5770add-9d18-40e1-929d-df7c40f3c7d1@intel.com>
References: <20250331082251.3171276-1-xin@zytor.com> <20250331082251.3171276-2-xin@zytor.com> <Z-pruogreCuU66wm@gmail.com> <9D15DE81-2E68-4FCD-A133-4963602E18C9@zytor.com> <a0254e73-bf7c-4876-b64e-b08e96044666@zytor.com> <e5770add-9d18-40e1-929d-df7c40f3c7d1@intel.com>
Message-ID: <ADCFB190-A89A-460D-81A6-80E20AEFBFBC@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 2, 2025 8:41:07 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wr=
ote:
>On 3/31/25 22:53, Xin Li wrote:
>> Per "struct msr" defined in arch/x86/include/asm/shared/msr=2Eh:
>>=20
>> struct msr {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 l=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 h=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u64 q;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> };
>>=20
>> Probably *msrq() is what we want?
>
>What would folks think about "wrmsr64()"? It's writing a 64-bit value to
>an MSR and there are a lot of functions in the kernel that are named
>with the argument width in bits=2E

Personally, I hate the extra verbosity, mostly visual, since numerals are =
nearly as prominent as capital letters they tend to attract the eye=2E Ther=
e is a reason why they aren't used this way in assembly languages=2E
