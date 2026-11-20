Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163802;
	b=pO8JlzSqPkMZKWCYnqBeeDaXArmU9JhySNefsMLQi+Pb9ScmDxL/De5fV3h7ZScuGI22
	 yrpNU3n3nGAScyYG0Qn31Il3bfnDGVrgFUI88ooG/3x0urAR+wDfn96gMhZFBh6mbfcZ+
	 k4y5nMQ0JgMte+c5kG6xJ/p/tGggByw3RPYgOGAdKg5TQfhmGnEW3sXbMNKahL6TNK98H
	 8MWBMkEhQG7poN3lIL156lnJQQtTlXFAPCJ50JDgsHR6IQ/TZg0wZ/II1IJjdqpHlVr03
	 Fc/qsjXXAEVGEUIQMS/NBLEofR8z1Y9akNX9lsCClIktVwdEeOm2pw/dBncqK7YYdwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FroopTMuPleqi9xrjHNZRUYAbvATL8axnG/vJHY5tGg=;
	b=ILhrq88Mi6a92n8xWaMk0k6d+TIq+Yk6s9lXjlT4DWpwLuFm35EeK0+8oWXaU/ywkTYQ
	 gq6HMiifkQuvoiscem5a6ZvepZiChH164GSOhmVYxnraRgHYJwrRyn11ecNMWS/kfYrO+
	 hbpJysdRAWJG8OUNqEvOqmGjg0bpnbcseleReV1y+wf39oFDi4FWpYxgKwVUyZ84Kek14
	 RKvw3MplzXWxnkSfy+KzvbU5Ig9cx/S9+BksfF14qIdBSgmLHzrqQ1QmoW4QAGDTNlAGr
	 a3XyJwxUjxatUKtUNhCo/n3rQH4x4bDwT67o9Yd8/UTiDMQ33CfT7qh/wWWEvSqAemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IczSjrY5;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D30606A326
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 08:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66D30606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IczSjrY5
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so5119305e9.2
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795163801; x=1795768601; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FroopTMuPleqi9xrjHNZRUYAbvATL8axnG/vJHY5tGg=;
        b=IczSjrY54mCBes+jgx7lFPQNzRTI5iZIh3AGHmK+QrkfKmKBOpxvXDm4H87UIrs5Ra
         mUn17pDJjB+FBEXdOfj0wIKWRZdiiL7dt0bs4K/5ksVgQMWteYID8b5oCXF5h0weZnhg
         mYMIDkeRwB5OPs77IiuXrttFiQ2TQFvon1qHflutibtFfOO5X07KrDwMBwcN0fsA0HtV
         OeBsQnDqNI7Ogi+JCLBouF4Vw1QY52c/n6hVvatVYHpjkiSBN1nawqZUcAuJB53zbBlY
         Rk/0+60/cj1Mu7m2FsZjMZ4svHhOLegsYmBlLc2jFYSLKAzajzCan5/rfBINn1RrlYuq
         u/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163801; x=1795768601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FroopTMuPleqi9xrjHNZRUYAbvATL8axnG/vJHY5tGg=;
        b=W5JZVM9CIpvMnqNJ8CcM5rjH/oLsB+BUGWO75Xug7Sfbx/1SLgC7ClAGZ65wclbxuf
         Vo8v2Bz8FA7M5PTb9AmGwdjO7td9CxDQsDqfOAjhWm1llNLiMOiBy+uEg32TZm2ZXsRM
         iAT9gT6G8vq3FGAgXv8djhUNyglkwPmONSmdqWPVbeeZIPXe6lQzofWryGsDOyBJk25d
         pkYAovnIaa8VcDXpNA6J8pwcXSBaMGJQmm6XbWl7ZoB9byTdMxt+3SoMBPfWzB6fUB2U
         cn41+NiPsnQvfilDfbyCkdrEfqNLrlVKBqbNiaEBLu5PPcQKVB6h/0cFo/A8/PPwrcYR
         mMnw==
X-Forwarded-Encrypted: i=1; AL+hErFE8n8IqYNB9I37Nj5eNtiMRNhv6+WPqvOsQpWx1yDZqG+UJXyOzqKaJeCuKq25bIYlbjVi0zTfqzUKCaETWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8pksRMoiEDNy76OqQP9a7jH6/YH5uanZ6Lx+IMM/9ViLqt0Ttt
	JF38tXKwALfaayeDTT2bRgrdcJmk6KMMYKtxqxMFtvpV2VQGvC1/hLJbsBMJ+Hr9O70=
X-Gm-Gg: AYBFou1uOsX/gcOh70YB6fhh3BFyW+H3CXD3CXyev1kZwjthb3w8sb4FjAVZ4WjKXrp
	tydBj8mK7tZ/ZD01veUJeDRttbVCvoLok5DagW/x0OivAYfLzkIc7sCwEsXGNTfxSmIg6pbsMaw
	+nZWCqRKHx/iJIbDmLFJfKCsi31POaKFf8pjQXtwFPzz4HrkK8d+E5ZZ4HsHVQX9bnVgOXFIuxh
	B1bKVut+AeefNrrd14uAIySKZ89y5Q6gli3VTrqRb8uiXQuWynamFocKIXgZihEgL/gewN9tCV6
	P8+aDX+nfb0pv+mShbHrlLYuL9Yy4kYRcLibsc8TqqscFgt3XSqmbmn7z78OC6j+V51cJYoiozF
	/Zb6+T+cyMkmKEj1deR5+nAdRFLYeVuUhxbNy4A1S9LmOecq4iSd9TkDoiGTVm63v313Hdh3alZ
	qfITVBkwwCWgWp9JM/jngIdE6b7hSENTw9PtUouhlbQ2yLDWMogFa7gqDKg4W1os77qYFjPQs9M
	Esemx2EaEQHXJIwhgUyjF5aIl7uH2sV88VST0eveCC7m4xiinwIHI0wTU5CSYgngDXk7H4PFlGx
	BGMyfzPaFXbqYmp9IHQz7len6fFPgdqXRWg5gAhTsw==
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id 5b1f17b1804b1-4bb88810991mr53940545e9.21.1795163800697;
        Fri, 20 Nov 2026 00:36:40 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm126587935e9.0.2026.11.20.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:36:40 -0800 (PST)
Date: Fri, 20 Nov 2026 09:36:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v4 1/4] panic: Add a platform panic notifier list
Message-ID: <awAGlQhpaLtrHCAR@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
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
In-Reply-To: <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>

On Wed 2026-11-18 01:01:48, Zack Rusin wrote:
> Some platforms set crash_kexec_post_notifiers so their crash handlers
> run before kdump. That also runs every other panic notifier and kmsg
> dumper before the crash kernel.
> 
> Add panic_notifiers_platform_list for platform callbacks that need to
> run early and are safe while other CPUs are still running. Call it
> from vpanic() before kdump and before stopping the other CPUs,
> independently of crash_kexec_post_notifiers.
> 
> Also call it from __crash_kexec() if a crash kernel is loaded, since a
> fatal oops can enter kdump without panic(). Call it before taking the
> kexec lock, so a callback that panics can still enter kdump. Run the
> list at most once, including when a callback panics.
> 
> Add disable_panic_notifiers_platform_list to skip these callbacks
> when debugging panic or kdump failures.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

JFYI, it looks reasonable from my POV:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
