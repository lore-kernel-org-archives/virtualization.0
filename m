Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76C43AD2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756597; cv=none; b=l1Pcy17RzJ+V0oxAnibEsdGjr7yP6z8Zr09kNV7sLAwkHS58OLrqjMY5YOAUrNmf4pBkqIdHbVKH/ir07V96y4uifa2ZTmkITMGCPsw9GMQN1ZZMazO/eErlKjDYwc2aTWL1BsuoKP2w+kYT9zzyt3GXnHWLRZT+/nv9dxcX9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756597; c=relaxed/simple;
	bh=B4qEMf4EVGsDCaOxKzxxINbFJU5l8ld0fYiuh99Vrd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSk4bkGKdm0Vqhq45l81ISq4tk/vp6XLgzMhtJn7HTAsNlYmcH9IhVFe6o0P83DG5uINlhDMMF9jLK78jrUo2nfZgeOT7x9HeFKMJwG/HkizvqVSX3jjBC4M+bR8BikekNg7zFZWYnkJwaiXLXkqnbqol/q0A0PxXRXXjnv7Rno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNaYmnP6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNaYmnP6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 600456069E
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:03:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRF-ckSzjEcy for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:03:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 041CE60689
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 041CE60689
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DNaYmnP6
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 041CE60689
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:03:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 045FDCE1372;
	Wed, 15 May 2024 07:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6A2C2BD11;
	Wed, 15 May 2024 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715756586;
	bh=B4qEMf4EVGsDCaOxKzxxINbFJU5l8ld0fYiuh99Vrd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DNaYmnP6lqeZPyPEH4NDgKmSjYmC9W/HLk2KbeeSAN78X+py65STTCNKA1KvSaEYT
	 ZVPx29xw1qFyhgp30weJoH1zCvmxl3BevfyrAKof0HHTqq9b/OvZ40yXJ8LNt79RKM
	 5BVm2vdbtuCkaqSyVOvsxo+iBWsDfHBDGoqanZ/E4l0vQnmupevWqbQe0pMXibnPor
	 xjIQSIpV9CgHcOKLX0Xc+iQrBrRxyMnsEG3DJMcI82+vQcHCP1oVOoFCwgYVlSUwM8
	 bxCDPmgE4k+MG2+8MzwYcC9bXWBDZ7wPZzOkfzAaYnMbkiwU/lw4LZ7XnyeQvqLai3
	 9xKzdqSQMXGJQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou
 <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Andrew Bresticker
 <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>, Santosh Mamila
 <santosh.mamila@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 8/8] riscv: mm: Add support for ZONE_DEVICE
In-Reply-To: <20240514140446.538622-9-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-9-bjorn@kernel.org>
Date: Wed, 15 May 2024 09:03:02 +0200
Message-ID: <87pltntv4p.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> ZONE_DEVICE pages need DEVMAP PTEs support to function
> (ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
> in the PTE for DEVMAP mark, add the corresponding helpers, and enable
> ARCH_HAS_PTE_DEVMAP for riscv64.

...and this patch has rv32 build issues. Will fix as well.
