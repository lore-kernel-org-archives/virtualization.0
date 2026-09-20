Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71935CB61;
	Sun, 20 Sep 2026 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938995; cv=none; b=HTOR4SiF1c6zbFF83+kSoknL4PhbhhQ/KoNgWwwBSG7Wo5fZiag4/UdhD/EiR/pOFtPjiZjlILg/i9UmqM491z26SfDW8bJ9u1l+i2A283XHxDAI47EKx2wMfyBzOh9DfObDZkFmvb3OFylKh+/iy+HVwUMmprvi/g2rd75T3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938995; c=relaxed/simple;
	bh=qRhFRwuodJpyHKZWB8ZDa1YSF8eQPbSuWrGYdDKtWw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siJlw4uXRit9LOuaQJOb0bO93ekoW6mCFRZ5bsruWIdONkOpBcn67y+6gswMDwe6kkpMq07bDQgeVT1A4C/kVtd6eZ0UQ9Z9TomcXDX3VkMxQjPTsunSoWROVko+HDqcrMcLPagEdBjO9NhI/XTLAcbC8D0VBZkRtMer8GGpVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JCsKlXIb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JCsKlXIb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=WuxoEppFDE+hLBKCGA1L/0v2+lTpHSjJWhfVv76jKts=; b=JCsKlXIbtQo5QkxsOYKHxV/5bX
	ydTQ8vbPPlRgJzMO1bpUUqQ3VTREbZBBc1Fmv8Dq3nkaiZkCiaW23EOg/dndqgivocFD96EiuIjKL
	xwen7ZamyZ7H5vtn6k0GJdvXwtkmaQLw/RwLh3xiPjmdNegIz0jzxzVsdD/ypM/gUY6fqLbKvUHXh
	H8d7jS6FDW8t1qentVfwJk7LdkoAr/7Jj3o1qJZP4QXYIQZnKm7eJEWoWrBSnq6R7q+gG0XWal4ke
	XgDOPGbJ5XGePkQBzBI04UbA8G1U/Mt/cG2JQXDpm4StwRTbE5dOTJDdq4t+fYDPvc893cJMWoOAn
	p89LTJ0g==;
Received: from [191.32.244.140] (helo=[192.168.1.56])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x8Osi-004orP-0B; Sun, 20 Sep 2026 23:15:27 +0200
Message-ID: <ebcf63b1-7410-4cb3-425c-da48b557556d@igalia.com>
Date: Sun, 20 Sep 2026 18:15:17 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Petr Mladek <pmladek@suse.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Stephen Brennan <stephen.s.brennan@oracle.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
 <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
 <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2026 20:00, Zack Rusin wrote:
> [...]
> Hi, Guilherme.
> 
> Thanks for looking at this and for adding Stephen. I'll keep you both copied.
> 

Hi Zach, thanks!


> [...] 
> I'm happy to add that as a separate patch if Petr agrees. With it set,
> the new list would follow ordinary panic-notifier ordering relative to
> kdump: it would run before a successful transition only when
> crash_kexec_post_notifiers is also set. If panic reaches the late
> site, the list would remain eligible to run there. I'd keep that site
> after sys_info() and before the kmsg dumpers so the log includes the
> additional notifier and panic_print output available at that point.
> 
> I've called it panic_pre_kdump_postpone after the list, but I'm fine
> with whatever name you and Petr prefer.
> 

Cool, makes sense to me and feel free to change names, I'm OK with any
name heheh


> [...] 
> Would keeping the two call sites, with postponement in a separate
> patch, work for you and Petr?
> 

Fine for me - thanks for working on that!
Cheers,


Guilherme

