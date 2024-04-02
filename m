Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB11803A;
	Tue,  2 Apr 2024 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036067; cv=none; b=PG7Bs7pIcDZFQHrXrY5+r7Gi4LdlM7bmBQPWDqIfdVyqQBJ+aDeGJV6RPv5DeoyrWWgQGvWi4IfVxJzHbFbpoqCxcXpa7lmN9BO8j4PCwnCB31AP8PjMCIBFcJeVUN5BrTujfI4oYMwnPsV66VPMlEcfsRm0nVk886yl69lY1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036067; c=relaxed/simple;
	bh=gVS7XG9AAxqbh2ZdTm88rieui4opdSW40IfBuDEG+FQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mNLPix04le+Q4f4kzNXBe8NL0FCFWNtQdz3M79v2rSyfbxVZA1CXeW/bQ071Vbo9NxnR3/u9Bd9UgREZU4Wbvg/eiSRe7jhU7kgK7peEgBag9mXE4YoGl/VHUPDTkHnSRFV7A/E4TdoIbM9ay995BcmToEPqBdcylFbPKSoKuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=nVYEvcSV; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="nVYEvcSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1712036064;
	bh=gVS7XG9AAxqbh2ZdTm88rieui4opdSW40IfBuDEG+FQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nVYEvcSVJOg2nZToOUc4chytdO/YIf+XZe79gobgGORICktkVt2KbRi+/gewz+mq3
	 VTVW/TY/9y/zYZg/DJI+tKTouppcqflTOxiUbaauQ+TKzLjYRMck4235L3rG5zAhTF
	 t/20FjbWKvgp1Apqv2+ccz8N9rBNMaz94ZJXuUjM=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 19C4966F79;
	Tue,  2 Apr 2024 01:34:22 -0400 (EDT)
Message-ID: <71ab04b76d23497ff63e36dcc05f6580223d22a2.camel@xry111.site>
Subject: Re: [PATCH v7 3/7] LoongArch: KVM: Add cpucfg area for kvm
 hypervisor
From: Xi Ruoyao <xry111@xry111.site>
To: maobibo <maobibo@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, Huacai
 Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Date: Tue, 02 Apr 2024 13:34:21 +0800
In-Reply-To: <d42c7783-3d0a-57fd-fcbe-a1a657255ae4@loongson.cn>
References: <20240315080710.2812974-1-maobibo@loongson.cn>
	 <20240315080710.2812974-4-maobibo@loongson.cn>
	 <4668e606-a7b5-49b7-a68d-1c2af86f7d76@xen0n.name>
	 <57e66ff5-1cb6-06bd-ee6f-a3c3dadd6aef@loongson.cn>
	 <b7d91c1a42470821983a811a16f9fc1c55cfe699.camel@xry111.site>
	 <d42c7783-3d0a-57fd-fcbe-a1a657255ae4@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2024-04-02 at 11:34 +0800, maobibo wrote:


> Are you sure that it's impossible to read some data used by the kernel
> internally?

Yes.

> There is another issue, since kernel restore T0-T7 registers and user
> space save T0-T7. Why T0-T7 is scratch registers rather than preserve
> registers like other architecture? What is the advantage if it is
> scratch registers?

I'd say "MIPS legacy."  Note that MIPS also does not preserve temp
registers, and MIPS does not have the "info leak" issue as well (or it
should have been assigned a CVE, in all these years).

I do agree maybe it's the time to move away from MIPS legacy and be more
similar to RISC-V etc now...

In Glibc we can condition __SYSCALL_CLOBBERS with #if
__LINUX_KERNEL_VERSION > xxxxxxx to take the advantage.

Huacai, Xuerui, how do you think?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
