Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691260;
	b=mpuQ/zup41ef6dF492+BHtMlmCBzs12UKm82HLDTvFnb8mZq4x3FQYpn+tWnU0+Jns6x
	 cv24YpIWP5t9SGNv4VN4WHXtTxKwGgjjM57/GW3KR2Fx6EAL11k8Mo7JhWQMo5h+WLert
	 Gm4IiAbZLbVtOP9Ey3c4mm69RUykWR8booOYH+Rs4+1yjQdR+Y+jVeQB8VZasfuxEd4UA
	 yXpdVgjFoNee+13x/XLEnDENz5gOcQS8eeeRz7cCTNxOscbhE1+f0BYgynAd2ymS/ouRr
	 hR6AXWII6rrFTmLpLFlYAdDWb4qnAH10RTXZcJIBhs5/4l+/3oxK3bjqIACa8lU+t3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691260;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XfKNC2NE9YSYVP2MPnS+smvI8z2Ige3tMx497tBdQho=;
	b=afroWfwhv69JD63mBtiv4UCrQYsc4xMNDELFqKtHVUuXe53WSTsfn9G8zIWikWDZE+JB
	 skgiS+erkC7Fr2eYX0nrpWr4BPjt9OgIYkIrE3Snjlv4HlllUPzdiVzOxgJZWTvNmYkLP
	 UbwBmAm4DjRUtCYHu8oMqKUfmgZRDa7nxMzDzG9x3UU7Odgl3g0lBUjFMJcxNAh4Va0v7
	 PSdS0tpHXyDXXNAvSKfJDAXeMXlKez3udX+mOWaYXVWk3UKHlQJ6SbxA2rX2AIYIgIR4B
	 vwNOciGyg7+HdTs2Acm0w/OEwZhiX0eDCMjuidwHG98JERvtikezeLN96zqFEgabE2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3dfCqjQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30406606A324;
	Tue,  3 Nov 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3dfCqjQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701041F00919;
	Tue,  3 Nov 2026 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793691259;
	bh=XfKNC2NE9YSYVP2MPnS+smvI8z2Ige3tMx497tBdQho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3dfCqjQj+DS0DEcJftio2F2cN6tjiUPYQ+Qap3FvZ5+5uPKlDOS0Ug87r+5GuC7y
	 e9+K0KJZoyu4NP7LK5uVodgS2dzgEQz3hV6fmmNiAEcdJ3535CZY1GTcqmiD/kKSHE
	 4Rb/ADET5SOCZmEvmMdMJ09KKRDCB9B4++tmKzNeShhRrru7uU6Oewtih2VGEd4qGM
	 i4KiEifWR2oXo5ZNdE+NYRGBG9Jntbr42sREOT3NtidrDBhLN5oCyjQ/k2mMGH0RJB
	 IRzuIffVomlseS+D+pWJYUIQiZ0gqBNiFABt/QWUg4pWDGvbeGScrmQ7wfmCGBwjUW
	 6Ex7BILm4/gVQ==
Message-ID: <sashiko-outbox-194717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] x86/vmware: Route low-bandwidth hypercalls
 through a static call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <70ce0c2c18008fb25399125fc81eb368d8e824ad.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
 <70ce0c2c18008fb25399125fc81eb368d8e824ad.1793685318.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:34:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] x86/vmware: broken TDX hypercall guard when vmware_init_hypercal=
l() is skipped
--

commit fc9641d4edae98b08577710c597ef17cc2f5765e
Author: Alexey Makhalov <alexey.makhalov@broadcom.com>

x86/vmware: Route low-bandwidth hypercalls through a static call

This commit consolidates the low-bandwidth VMware hypercall inline assembly
into four backend functions dispatched via a static call, passing arguments
and results through structures rather than nullable pointers.

Link: https://lore.kernel.org/r/20260309235250.2611115-2-alexey.makhalov@br=
oadcom.com
Link: https://lore.kernel.org/all/CAHk-=3Dwivx7pi+h+hGmvNFAJm6StQLiQ-b8DdsE=
5J=3DLMOWae8Ng@mail.gmail.com/

[Severity: Medium]
In arch/x86/kernel/cpu/vmware.c, vmware_init_hypercall() (around line 510)
updates the vmware_hypercall static call to vmware_tdx_hypercall() when
X86_FEATURE_TDX_GUEST is enabled, while the link-time default for
vmware_hypercall is vmware_backdoor_hypercall().

Previously, vmware_hypercall1() through vmware_hypercall7() in
arch/x86/include/asm/vmware.h checked cpu_feature_enabled(X86_FEATURE_TDX_G=
UEST)
directly and called vmware_tdx_hypercall(), which rejected non-VMware TDX
guests via !hypervisor_is_type(X86_HYPER_VMWARE) (around line 633 of
arch/x86/kernel/cpu/vmware.c) and returned ULONG_MAX.

With this change, vmware_init_hypercall() is only invoked from
vmware_platform_setup(), which only runs when VMware is the detected
hypervisor. On a TDX guest running under KVM (where x86_hyper_type is
X86_HYPER_KVM), vmware_platform_setup() does not run, leaving the
vmware_hypercall static call pointing at vmware_backdoor_hypercall().

When vmmouse_detect() in drivers/input/mouse/vmmouse.c (line 323) runs on a
KVM TDX guest (since vmmouse_supported_hypervisors[] includes X86_HYPER_KVM)
and calls vmware_hypercall3(VMWARE_CMD_GETVERSION, ...), won't it execute
the port I/O instruction inl (0x5658) in vmware_backdoor_hypercall() instead
of being blocked by vmware_tdx_hypercall()? In a TDX guest, executing inl
triggers a #VE exception and issues a TDG.VP.VMCALL<Instruction.IO> to the
VMM, which will raise a kernel #GP(0) fault via ve_raise_fault() if the VMM
rejects port 0x5658 I/O.

Additionally, since vmware_tdx_hypercall() is now only installed after
x86_hyper_type has already been set to X86_HYPER_VMWARE, doesn't the
!hypervisor_is_type(X86_HYPER_VMWARE) check inside vmware_tdx_hypercall()
become unreachable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793685318.gi=
t.zack.rusin@broadcom.com?part=3D2
