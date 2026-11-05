Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793920457;
	b=wBJKkndd9XZPqRP3qjDpW2P5cSVaII5jkyb3lYk/5pQ+gzp/5Pgbg30AQQ3zwa8451w8
	 /EIvlQPgGGT9E+FE0wuYcUjfsikzC/YMJEfcM9e4NNI4J7rHEXf8x6iTtVTU5aYtCGMr2
	 ttxK21eVVzk+KE/3FkE2Acun1+BjiNkWgQ4hRQ3ySm/65AtnHOGWhHGJARUJ+Htn5vLeG
	 FhRWBATcGXi99kEAwshRoYCJkKYAymKkt6LH/GK4xDwH/LptHjTR1IMcQcL57ge5jweza
	 4pzp9GH15DM495CfNAey4rEr7wfc8LynyOuxBY9EXuTOt6DEDfpp+OQVxLD3BqD+SWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
	b=idg0EpAjMe1xNEHAh4VFhuJb2L8skjrHlBsu3WAQ/PJNbnCseYAI8eMe2eHOtKvFfWfk
	 R/6RUhbpwCXF03BPUB2zvwi0otIm9ZHaW1lOR1EmIvYk7oApXETqez85OhfIIWp4pHVaZ
	 Pv4VdXxUtIeEd0N64gRjYqlor7QUOaBac/EOurf1XZYPcaw3yiuFAwVlwmN1F8jsdThU9
	 t+0gPEnDwaLsfVG4ULAumC3gLMn5+kykTFGVxAtXErxBDyJ55cWX0Mp0ETAk7FeFZQ70H
	 VAVfGThgNnshwD5Ksgr6PR3tYKdeNlquahCPfKwZDFRO127feIUgU3ALc2cMm4vr7aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PVVijYv8;
	arc=fail smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B41606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 23:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B41606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PVVijYv8
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso38863a91.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 15:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=HdqT6uNov0FP3+6xURVtXbMT+JuyuTm5xdHKWZ7+Y5r4LXSEigEq5TQR3abs3+uPqL
         o8yTcE7FR/+sh6yUe5Vv73dd9wZfdepIK8BXDXF+7T+0F7rtyX49JScvUH7OTBQYY/eq
         17oMd8aOPKLvcl4hcZtcWY26Ee46J0YVcH4Zp24XCXNwuV3//1P05hC0KalnBvsMju0q
         O83t+0RwWR0RAqkJJkx6xzEMJD8TqUxLHckVqcN9ZQkm3BJP4vJe8sM5Pt8Q9njKtHTe
         mT6dHiOxMc1CIzeWj/vxiIkMHr1a4//ZBsTCgOFQ4dnTw9nC35Mdt9wZlgZrCc5Xrber
         aF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=6pSniA7UzcOCao8nUOwKXyg4PIXcOy4d/op9wndqf04=;
        b=dzcd3yaHH2GQf9WzwrzWm9w60LAxAEzyOsJxXCgdUYV9Hu967DwBgiJC1jOgRu++jP
         C3Al58hlG5/VZmLoMGbqUovZpAd4sJOeVnftn8UcA3l2RnBsNtxii9Fc12xjMzbKpUQF
         y/WIjHesXwZ1OaCZoo8CbIGUz1XgxjS7s24rRnl55B854uSz/f5erhfKIjp1xZ4Gd3MU
         pIS9qkESYBL3+n69owGkLqHl3XAKZXKnjb5CswylXWoBDgcEwZZ1i2Ly6Ma7MJx/M52I
         dcCXqnGDRkSykhMx45POVI5hzQb0WMZB1+2nqEZ0uVBEqDX/P0+CZTFKo78EOPGgxgbb
         xWEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=PVVijYv8+yAEj24M3NqgVzWXUx0MYnSo79vpEA2hL4Ixufz9+ZyqyjJTP+X/05WHs4
         jLh8CThCOWhIAIpMgmEgfXOU6YV2X3uFI7v8rLG8ZhfEaBWC7QKy+oix3VvRup2kh0yy
         GpFrAco1YJw+4gCF2vAZESI2eewU5h/t7pR3/aq9PEihTmxdJ575GZ+FDxQz81PMaNQn
         FQZ8FX5GdrtKepsRsDJfhOGl9KGsh1HE9NdmINJzomrIyBBf4Zqh8kGdwJQlp2+I4Ue1
         XAlz6FW4CT4sTFxbbqAb1Ey7aTrnslvdYReYcIPvbvaiJwYFPZjQaofLIqLeu+BKQH3V
         yA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=tqrEiOolFL89DcFvGh3Cuo9P90uag2dY6JjTKheU6IKwR1IjS/1/nnfsKY9ztbwGK3
         Zwl/OsZINth9Q4hrDpZFSVtV5lrGfcs3/Syt9Xe1NAA5nceZrxDYV4ocay8wf68pWLOk
         Y1kW7hd6VPE/zmjP/vG6WxxCYOev6/qSYCOxWjsN/vkll+wAyd72MlUr8g60jPOSGuKW
         ga1cpdnZBBNQJJk3puZcRUwfU/4rlEcLrQbq18ed83N7XGHf0cUQUkP8z/aG6EBr3U7j
         lz6Yg/uxzv54kAI6N0rWHg2pQisPqbiZnJS01ozSITxSt9BwZFvl3ElZ3ONXwujACcFp
         8JWg==
X-Forwarded-Encrypted: i=1; AKwUvBwTb4Ksv+84SIkgkCSk+xp7LTiUqzOHcrLD1fL72dPOejrHsEeCOyboFwdwpGIfSzgXJuRa83DmQiYWznzcFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/j3yG/VzUBgNtaberaiB31nAg9pWjpvee0eo7kgNkJPCl5cdfN
	QJOWYgpgb0S+g+zvZCEPr1VzjVULXBpUttLL+hp9cFwLd9jBqM9FjNa0mk7rxTOxt2ZFV2n7YmT
	TyohpXE4RtR2GiWx3uLPFrY55zUmJ76is3p172jB/
X-Gm-Gg: AYBFou3Xtxywpz9lZ6flAvDX1NJ/fP5KlczmhpsMtIhFDQHQmYbHoQyQNktYFAfPJQg
	VPFZisWPylrB8G7RBl37zb001l4oJDSBa1vNGsC82prb/5aTLdFWSbVX5cXyaoy3lkp8TEqaQy0
	KoSDLjqlnDS+8/SVfJg5ypkhsshYqIuDq601l3UNlol7TYtNETX3dIocJ+GTefbfcIzgZqvY5iv
	h75IhG0WiK4gks1WcgkVnb/Wvb2jHTNy9eYQ6orQyKDCNuglWSdwVrtyhdqFb5ghFhRsKSGpypI
	JxQKwfHiXxWijbB3369+r0ivMKfN1IIelad3meZXSfC+mK2sdX9p7LgCdQRbrDuHl8ZWwlTrlto
	ek6Atz2ekAQif4BtYb+uYbLADEs51PI7cRk6pTXp44AWbOmjIxGomiZSeghXMVTVsp3cW
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
