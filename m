Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347215;
	b=zbjkRS1bKq+Y9KCaEsjbQehdnpC2JVwqUMnPSlnixG4pr/FF2gAbou9YMY3gQjCwZSVH
	 yCuMomPcjzYxGIKnw7D2blLExrgK4VYPZ+X2tiXjtAHhMn6R0VasDdS4K9MImSB9eTZHU
	 bpX8WluzwAeqU59gcKZ3JD9Dj6J/RvMPVKz7Q4ArMdqyFPJn/fTimWxWKNdUyTCRyMI4Z
	 8dT4Uxtyhvq86jp5YhZ4kKHenQ2BY4lZbRxHwx7Bw7u7iUr/WCHopaYoeOdfl8tpuvU4o
	 1YLdbovNySEKevkfvycuqwbfFK6dTBBZhsn+lXCu28iRc8SSN2nUMrDGn1SltRMpzPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347215;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zWEZa03SCyKXbufBes9Agr+bKSMPLOJ12v+JF8SJl7E=;
	b=XAlY+zVkBX4Zq/7JdLhW1yvl7j9dyMGCWKieldN/8EebUMb3Qjk9S+xDDNBvEkRcmOcd
	 h+azI+SdDhsT4ixI1/yxOjvAlf3FGXjRn2m/krVoRgFPtkqf2j694hFaMcqYPZVcpnydX
	 CyKKP9clrpxWReq6rXna/NtxEfxZayUHLid6vRDFGKKlQ/bYUYJUirM4ejYDzrHzQImcu
	 4GcyhxjFMTXvGofpoXSlcNBzwz1YNZ+PPDYoIPu+EY27GKN0D8pdSyBs634jBZCTzWnqS
	 wHthXkE92JxASpp8HnQptgWM2b43wRF7jguzt3brWPGWDUuesrcifJqqrd15Mz0sm+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e53IvUgz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0C606A320;
	Sun, 22 Nov 2026 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e53IvUgz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5511F000C4;
	Sun, 22 Nov 2026 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795347214;
	bh=zWEZa03SCyKXbufBes9Agr+bKSMPLOJ12v+JF8SJl7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e53IvUgzHCrkUAHG+yWvJd3c+dc99WoP+aVNVlRb0rhrjQFJ+6gqyLqWS0nRcpi6x
	 MLEg/wL4oG68gmptGo7b8RmJ8IaKT2H4z0ElVEHeyKsnTlfX8H/YmkoSeRlcI2ct9P
	 H+eug0ook4dd5TkUUn+mn+v61gtU6zZAZyXFfEYXJ6nT+0pbJQsDJeNodhevEpiF+H
	 zK3JJaUl4U0ZOGBFWFdHX/hzs9Yylfkg6awe4pv4HU+WKKNuJjPKJOVthUxj1yhRTj
	 B3AzWBaRFa+TecF1D+Yi8tHgqPUa8/RnGX6ZW9pKITUeV5VjpXA+c0ocxVSTXnVbsG
	 QPJy1dwEHokpA==
Date: Sun, 22 Nov 2026 12:33:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v6 09/12] x86/msr: Remove wrmsr()
Message-ID: <awLTCUz12tpDOFvp@gmail.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-10-jgross@suse.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116150208.1572254-10-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> wrmsr() has no users left. Delete it.

So there's a few uses left within comments:

  # wrmsr:
  Documentation/arch/x86/microcode.rst:performing the wrmsr(0x79) to rendezvous in the MCE handler and shutdown
  arch/x86/events/amd/ibs.c:		 *                  \        wrmsr(IBS_{FETCH|OP}_CTL, new value);
  arch/x86/events/intel/core.c:	 * Quirk only affects validation in wrmsr(), so wrmsrq()'s value
  arch/x86/events/intel/lbr.c: *   - For wrmsr(), bits 61:62 are considered part of the sign extension.
  arch/x86/events/intel/lbr.c: * ... then any value passed to wrmsr() must be sign extended to 63 bits and any
  arch/x86/include/asm/shared/msr.h: * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
  drivers/platform/x86/intel/ifs/load.c: * Run wrmsr(MSR_COPY_SCAN_HASHES) for scan hash copy and run wrmsr(MSR_AUTHENTICATE_AND_COPY_CHUNK)

But we can (and should) do that in a separate patch.

Thanks,

	Ingo
