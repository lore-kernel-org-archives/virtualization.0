Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A03112A1
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221727; cv=none; b=OpAPSlUfYKpzXkUaGRpKlp6AMV6uUgaiNz0o1bDVaZ+vOMNOQUNl9pJteyV53KOyormpyfVsrMLtiBFrOX8MyXe2b0s45VXHjQZoG4KsmoThUDRbMY+GtJwUUTJCo1yo1/MM7KkLby9LWMw8Rs220Xj9JxSd6VG3tROFSC/otCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221727; c=relaxed/simple;
	bh=/Aa9/p5ixgjp5gWgZv1LUcGcEIoUWo0x8Z1c+T8nOPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq90KR6CyQG377HcW5vqLrvZKrvTWLQXewuAPcH5P/ROQZ98XKfnEkkrDPx9V3i8CNfJHurQCcdGwgZuSxFb4BM5MXo6W8G9V0B3F27J3+kz5WZLEsndy3t7Kx3tcESrtQUCGSOYVM7jqryMRcH5dYsf8EBBwaxPhnXvEhTRjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eGkwRJvx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eGkwRJvx"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE4BA40E00DE;
	Thu, 23 Oct 2025 12:15:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PEGJEf8Oi9kU; Thu, 23 Oct 2025 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761221713; bh=jNnUSZNer5DkpYV3DRAZLxkJtVPD6JU88mvtvzlUzrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGkwRJvxA6ZWwjgoz+h6Ny6iNgdo8S9sWJs5wzlLkqFRbZkmwKaQDv9LJrkPF2vmC
	 p7aIUkdFVsrNKwpq1KnO1nMdelg6z1Hr2mn3eAbEmVFOVVTP8o1AOHVSxlZ1XKSl7U
	 H4Ifbjyu9DBkP0K8MlklOffniFDhhEISfC7qZcKpQ8oSX6SuNV2DY8Jc0msWAIU0ed
	 k1Cv0weEk9/Go/SjHPEWp3KN9PTTTm/AI3Q6/JkxDJgcTifwSxzeVdvl0jqs6sTZ9v
	 OJJfhpyO0nkAIBfV+sLMZuyGTKI3jhzSgTx2JPQj2702qb87gM8dPcjGe7mT+i5W+P
	 CnSOK4HBuj6cHMQc5uJVH8uHirtcFPEyTw++sYGhpAglZSYkt8tzuQyb4vfbIDqgCM
	 fNpgqQsosfznobp8apjq3Q/e3wr0isccF8pLFZzZAEABRX36xljT5ujUplSZlE75XJ
	 vfnSxRkKiIvyXu9ouD0uTbyIoVVt6fy0Mvx6rue/voSFuoNvZzuLdVCLSlYZVHwlxO
	 JML4IhfvK3/ZHOeCvZg4zUp007UrUTefyOD7weNrJmTZatgKGiIt+U/yuDFne4gJRp
	 bEmNtO2XKtju40bf01PcG+hxWCRdsiB/zqjShYq5TdqA3RKdqA1Rko0HxE1XLYCIpd
	 E7cCFHHEbzgDRLp3fUrLWXQU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CBB0F40E021B;
	Thu, 23 Oct 2025 12:15:00 +0000 (UTC)
Date: Thu, 23 Oct 2025 14:14:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v3 02/21] x86/paravirt: Remove some unneeded struct
 declarations
Message-ID: <20251023121454.GQaPocPvNMDYuOBod2@fat_crate.local>
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006074606.1266-3-jgross@suse.com>

On Mon, Oct 06, 2025 at 09:45:47AM +0200, Juergen Gross wrote:
> In paravirt_types.h iand paravirt.h there are some struct declarations
		      ^^^^^

Spellchecker pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
