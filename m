Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38816D4D7
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327119; cv=none; b=e5pXa/YdQuErdUPqXwE+CHctMoluDcJkrAGJ2SjGRIMnM5qZLhtxYDQh6C9rXBTdoLWb7q9TWtbdgvV1cZ0i635VF/HrWpbYIiioCVJVSV0uBNlO/nYL4rVXbdLWFnSeiqfFLrWxy686qjazhnRyaWUsEyoRe6bKOPrKPbEp2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327119; c=relaxed/simple;
	bh=jEr7anQAPkYvzkC2SFRisvG5HDx4DP/ad1oW/ENiDas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZpfTxIEvY6IULbFsku5Ush5U89ZiyRTeTnrWCckA7WezeCiAaQKItecbQpykPJqEecgMKmzzur9lQOSgnO32R7H2b8C6NywYrIhpdvPoU7W34m98syuVs68Y8lRxEQd78M+xOH+T00zC7iiilGmTAwQBaH/dU0PyqDIqpfNb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hDAvsikJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hDAvsikJ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF79540E0177;
	Tue, 25 Jun 2024 14:51:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DQfD-sV-ACFT; Tue, 25 Jun 2024 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719327105; bh=j9RZt/+5pkMkrV/swftoHy/cSkvH1sDrCipVa9ihigc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDAvsikJLAMdBlQtf0W4aW6UMan/XJYXkbbRzPDRthP2Wce34hJ+8oBXcdJb2eysr
	 RMOxtwq9EjuEc2zIRSD1F19EkliGH/U/yk3wgpJfEoKw7btc6hTBT8d5i7f0SJhgGW
	 oxYn/c6fLL3z08LsQnt8GZNN26wGfWgWxzyw88lC+wN5p2xbuxpzPIP1U35QQ712Q8
	 KlZPDt7n6RiA9LuZUsDsbwub3NqKyueMXKMBdeR4rharx+6UmAzI5dYvp29PpJ+alh
	 CL8mYJEKCPGAwN/yjriXbsXLU62Ji1R10TxnNcq4xRsBZf35plF9xVmGiJnIF6xdeb
	 jVpsFPP/tkafRoqhVMUenoalx0QDrBERl28MRsFiOFvJndg3Mk6BkIuhQGP3tjHe/p
	 Pnl/EmRYvJsxvcMR7Q7xxLPUv+SLnYbckRecUgbHrmBioj6H3kZPizpu0vnplwie2V
	 8B/zXVTzwxApQatp2m9gMVZ2nTjfWiEerCgJh4IbJ32WvkVzI0M8i1c1t7VHqzNZeO
	 gkZl+05AXNUXwBhE6kX28ldEc9n5BKbuYE3DXyj3pOmARceGieLvaYNRbhA+fepyMB
	 j5W6r5N1QR3pYjnitFTX4Ad00Ib0gonm6IMsBD8wR1uorB4KSgSRiHCCFIy6eabSoz
	 M2LLlDaDZfAUfBRv4HwN8cA4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35AAE40E0219;
	Tue, 25 Jun 2024 14:51:34 +0000 (UTC)
Date: Tue, 25 Jun 2024 16:51:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, x86@kernel.org, ajay.kaher@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alex James <alex.james@broadcom.com>
Subject: Re: [PATCH] x86/vmware: fix panic in vmware_hypercall_slow()
Message-ID: <20240625145128.GGZnrZcEK4YWOJyEMq@fat_crate.local>
References: <20240625083348.2299-1-alexey.makhalov@broadcom.com>
 <20240625084721.GCZnqEGbrkNNW6ZCfZ@fat_crate.local>
 <8193d6d2-5322-4a9a-82ed-50ac24dd3525@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8193d6d2-5322-4a9a-82ed-50ac24dd3525@broadcom.com>

On Tue, Jun 25, 2024 at 07:45:50AM -0700, Alexey Makhalov wrote:
> My test environment was screwed up during the last version of the patchset.
> I was using a kernel which was built previously and didn't pay attention to
> commit hash suffix in `uname -r`.
> Human mistake, apologize for that.

Ok, no worries, happens.

> Alex found it while doing TDX testing on x86/vmware on tip.
> 
> Do you want me to resubmit the patchset to do not brake a git bisect?

Nah, I'll fold it into the broken patch and rebase.

Btw, pls do me a favor and do not top-post but put your reply underneath the
quoted text, like we all do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
