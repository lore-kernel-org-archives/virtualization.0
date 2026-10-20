Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460433;
	b=eWWB1ZMZVrgWDZyUidPo1rLCT16QyWf63UC5pDU4Gg/peiv/QiJcs+iOfFGch3r8GJVN
	 8urd2iGCjLcj6tfkD6R3YyHxDISgJcebf9+l/pTLiK16Xk2wV0EUTQsNZUlfdxk6zPnRA
	 CkpyFPv5ETwvvbKJtZrsIKVuYSlS7n/rhcuSzCuJFEukISHeyTkqYrkjXarDhKfUXsHk5
	 P/5G7xPS1UzSbS215v+najYP7wcN3CRlfjjpHFBMzik9xp+FPxgaSduBeAAfwID+oZnsw
	 gr4g6d/jMN66RZ+Q3GkH2hMDw1A9PG/6eiDcQZiLJYSlgDCYAg1dSxMhDmm7C7o5AZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460433;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y/v52Nt7wua3/Hqh2/eSRWr2zKr9agsfw3+QaI3Wh7o=;
	b=d3MjsxEpDDcey3Xex7lc8FbBc7snLY8byNod9Lrx3++P4a5bs2jO8ZCuE5xEo0+j03s5
	 eRbV85gpQbvmE14jus4s/J+bxuM0mESmxJGfpLsNi3bTE0vulpG6GkYqS9Xbdls+1bD/S
	 2vw5lWC+JOK3P4fx1SsCH4atqEWcK76z/6xA1nlw3G7LlRrm+ExqEDm3scm5kBBfeBV67
	 0A0W4RRP6WB7UpcvBLVZyNOOBPdxqjtvxI5gYslS4atWZqDmMsUYGtRqU+ff34GYh1Ug6
	 4w7fHZT8+DzRC4xnrj7zCm10oBQCfqJAmRHjE6bCdYYJHXSIrckwedoNnNVW6T3yahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=gz3Y0cld;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9D606A31A;
	Tue, 20 Oct 2026 01:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=gz3Y0cld
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=Y/v52Nt7wua3/Hqh2/eSRWr2zKr9agsfw3+QaI3Wh7o=; b=gz3Y0cldVWyCo401TUdb94v8wa
	YoSB0h8baJhpIXaCi9PlSKT+G0Ap571CVXBDOFWQnrW1IXDQY2olHhBiDqAs8u0baPqzVYPzsAcDc
	FzGtkjvYOjmHF6SUB8pFSNuwMObtBQOQd7Flb8gBocyw1DyA5fjgKE0qBfhyclWFTfwxTxjHTKv5p
	zXjPNqwA+XUlZCu50sJcr3fyf0qN9IjtiBlZ8hU69wnf2hTYoaVQn9aQe4fd8X2miull6Un5xUhQq
	QO9/s4noupNuak9u8vOqWLS3ze7ZAmWHZZCzpL9QYM5ooDl36WVwy2Ovx/qhD/4YMPnyiu6x62FFF
	2EcCKf8g==;
Received: from [177.189.74.83] (helo=[192.168.15.93])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xIypa-0044FE-6B; Tue, 20 Oct 2026 03:39:58 +0200
Message-ID: <83dffabb-c702-eec9-a992-ba5b9530a8cc@igalia.com>
Date: Mon, 19 Oct 2026 22:39:49 -0300
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Content-Language: en-US
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 Petr Mladek <pmladek@suse.com>, Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
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
 kexec@lists.infradead.org, linux-doc@vger.kernel.org
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
 <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com> <87v77p9t4h.fsf@oracle.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87v77p9t4h.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2026 14:35, Stephen Brennan wrote:
> [...]
> Hi Guilherme, thanks for CCing me! You're right, I'm interested too :D
> Your email arrived on the first day of my vacation, so I'm sorry for the
> delayed response.

Hi Stephen! Nice talking to you =)
No worries at all, this is also conference season heh

> [...] 
> I do think we're going to have trouble articulating exactly what are the
> criteria for a "pre_kdump" notifier vs a "panic" notifier? Anyone
> submitting a patch believes their notifier is important, so of course
> they believe it belongs on the pre_kdump list! How will we draw the line
> in the future?
> 
> - Is it safety? As in "the notifier doesn't take any locks"? I feel
>   this should be part of the criteria. (Though I have never been
>   successful in predicting what code would cause a kdump/panic failure)
> - Is it urgency? As in "without this, the expected behavior of the
>   system during a panic will not occur".
> - Is it the fact that the notifier is communicating with the hypervisor?
> 
> From my perspective: informing the hypervisor of a panic is both safe
> and urgent. If the hypervisor is configured to immediately halt and do
> its own panic handling, great.
> 

This is a very good point. What is the criteria? I honestly don't
know...I think hypervisor-related things, that are safe (as you put)
makes sense. Anything that might also make kdump work more reliably, and
is safe as well...but everyone will judge their notifier important, in
the end heh


> Providing the last 4KB of logs seems less safe and less urgent (though
> obviously still immensely helpful). The kernel provides a huge variety
> of consoles through which the hypervisor could have already received
> these logs. If the system is configured not to use them... it seems the
> tradeoff to not be debuggable has already been made :P
> To me, that logic belongs in a standard panic notifier.
> 
> Plenty of people will likely disagree with me on that, but that's why it
> would be helpful to have clarity on what separates pre_kdump from
> standard panic notifiers.
> 

But at the same time ... there's something else, the "self-contained"
nature of hypervisor-related notifiers. This one is restricted for
vmware only, so personally, I think it's not a super biggie to run it
early. It is, in the end, a decision of vmware stakeholders. If that
would be an arch notifier, something that all arm64 users would
necessarily run, for example, I'd be way more skeptic on putting it early.

Anyway, not sure if I helped or if I contributed nothing to the criteria
discussion heheh

But I hope to see this discussion happening, maybe should also gets
documented as part of future Zach's patch iteration as well.
Cheers,


Guilherme


