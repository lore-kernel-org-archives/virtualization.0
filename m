Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8549B459
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636030; cv=none; b=qe5ChYgKfFgeU4DSBqg3AetGXOH/b+BYlt7OY3PG+Oc8pb2XdHPIm4hK1djq4WwviPXd+qonIKT0ccro0chuOpfqiX5lrjIzDP4L3H/CjYrGl4cWSv4BQ4OcGkHEv+H7jADvbNtElyUXofguWn1DJ1xpWSpVRtIfcAex9yaPZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636030; c=relaxed/simple;
	bh=W6DTvRWLmpIsiFAlB1cla3wKAoWr3XT+ojA5ZsdvDrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opqf4QmcRjt6tDL8AqhjcvxLsJNx/kFw73YnKd971Mj8JURNSnn0lp10oKMn0X07OEcx9g1z3LBXAXCI2wu2NZKiHpU455yI15ZmujBsCbPgmpiChDQiLCwzfgjzQDSvZlk6T2xHzw7Ita4ciQKcUljzDTJ78SlUzsbORf00I+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZZaD5+/l; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZZaD5+/l"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49e73611928so2615145e9.1
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789636026; x=1790240826; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jxbi13ouQTHyRdtBDlCDYfBDO36J/sfcBmF9VRStXnQ=;
        b=ZZaD5+/lh3YHNryK/D+UbvNZJz6U0LlchDwRke4XoLVODaONJ/qCbxLDSxjxRMxvB4
         XikMBoKN1hNw4sDSXAxBNmtQj27SFK4l5NeU0LeOxCorjHkMEvjhua0MvLk0x9+z6ePe
         6ugbCidHxJ96Clj+0vHuIBszT0iP9BU+K+O5LcsIIGYEuzO0R2ouIq6fYPMAzjLscgcd
         I6KmXbA8Kdb3ylStIJg6iuByNRP7rQ60vJxoiM8OU9PnvLxtU9jZjqXSGq2n/h99TE0k
         UJfadJ+lr7PldqXfGVMvBDILALYLsBWtnPhvNZQMmRbw6qWREX+HCxjuQmZAUXRsB7yf
         RFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636026; x=1790240826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxbi13ouQTHyRdtBDlCDYfBDO36J/sfcBmF9VRStXnQ=;
        b=eNC22eSfK0WM1vtOVCula7NR+TdntlHktqgHyl3XvSCfAGSB04Uu8eJ50nC0+E7OMz
         Ecvik2nYHrdI/0X845nuZ6E/9QwhidCWDnLiOH+rK9gJId4G9zADo3mpE1NA47MNJryb
         DKmVbZx0g98ITzrLlFRMqEXBVgIbsC2NHXhL+90T9p9rJ7PIZ6bx39euVyKPnlMTkKGo
         zUBXXOJ3E+vUvSGChSbbKcAyALusqWIwLVD3YdqIOb7PS6o5r7PmscEjSm9iaCBFqV4J
         VCOoEgLnbwnOvk+LPsrKK289PsYuOoWn/PleYU9ZYNtpIFzZdLzkx04LqQlIihxuc6hU
         OBHQ==
X-Forwarded-Encrypted: i=1; AKwUvByx83legp6JW8XbGDzXAFnZDKrPo11SVb32PVDPj3htyLdq50x7oCewK/C3tKlaK9H3AfCPt8uBJMCPnNKt8A==@lists.linux.dev
X-Gm-Message-State: AFuF++lY71/czOfnjr+mLgSfbA5eDGZTicBD1WYQyjcOo3yCWQjkuNJx
	7YW1ffcfOSopVNFxLNURtUj+7tYWjTPE29UaeaBtdCJ7kfXOsvfROi5IzlEjksTREKA=
X-Gm-Gg: AYBFou1ZlgBR7lm7xOaTMbVXpn9YhU3voEmD5brDJ7egw35hYk//kj7qqRUz977tQ2x
	i905Mc4TQTwmnlC3VNwlvNUV897qlE7Au09j392q02qxkBUZDQzHKUY0JOB8f0WdAhG6EwLm++B
	SmU8+gukJz7k5dVOLLiI6Ym7ZuP6RPEpDcsfgvCfQ6mCWk93ssyVkZxOI9SufHz2m9DSJENUbB0
	dMZUsEMNotATFXY0xd9Hle70o59EIc0m+89ASlwPdXLE/t9fo4hUtPC0UvAwtZBtxI8zJDtiQYp
	x+xpo3XChEZ4+gz8LqHMp9lEiMEy/jSW7uSErAKeFgPvC+oqb8Eh6FEtLIxn0qsGi4H7/16XxLE
	RiY+/7F87rFviZyerTnd+6/o0gZ0TAX84/m9G2d2NSZmRQ3t2J+ND8XNTs0ya80m/WK8FIoFR0W
	uRaBWa27CwNQij6RLqRDmFr2BBX0X7N5OdqtmpCzh2wHbw62LGPVGz/TmRinLbMG4DQesAtpXf
X-Received: by 2002:a05:600c:e555:20b0:49d:27ee:79c9 with SMTP id 5b1f17b1804b1-49fbd1c4afamr25264695e9.8.1789636025806;
        Thu, 17 Sep 2026 02:07:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm12476177f8f.12.2026.09.17.02.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:07:05 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:07:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Message-ID: <aquttpMVKX8e6zGB@pathway.suse.cz>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>

Adding Guilherme G. Piccoli into Cc.

On Tue 2026-09-08 14:07:16, Zack Rusin wrote:
> The core panic path enters a loaded crash kernel before running kmsg
> dumpers, so the VMware logger cannot preserve the panic in the host log.
> Set crash_kexec_post_notifiers during VMware platform setup. setup_arch()
> runs before ordinary core parameters are parsed, so an explicit
> crash_kexec_post_notifiers=0 still overrides this default. The 0644
> parameter also remains writable at runtime.
> 
> VMware exposes no capability bit for this behavior, so the default changes
> for every VMware guest. Running the logger first adds work to the panic
> path and can reduce kdump reliability.

AFAIK, the quality of the notifiers is varying. Running all notifiers
might reduce the kdump reliability even more.

I do not like much the hack with crash_kexec_post_notifiers. It is
an all or nothing option.

Also it was introduced as a quick hack so that users could decide
what is more important for them. But it is not longer a "user"
decision when some platforms enforce the ordering because they
depend on the notifier.

panic() is problematic and it is about compromises. And we need
to balance what is important, what is safe, and what is optional.
This is why I suggested to introduce more notifiers some time ago,
see https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp@alley/

Guillermo implemented this, see
https://lore.kernel.org/all/20220427224924.592546-1-gpiccoli@igalia.com/
But it has stalled because it touched too many subsystems and it was
hard to get an agreement.

Maybe, we should start with something simple, and introduce
one more panic notifier as a start. It might be called either:

  + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
    seems to be primary set on hypervisors.

But I would rather make it more generic and call it

  + panic_pre_crash_kexec or panic_pre_kdump because there might be
    more notifiers which are either 100% safe and useful or are worth
    the risk before calling crash dump.

We could put there x86/vmware notifiers as a start. And we could later
move there other important notifiers.

How does that sound, please?

> A full log transfer uses 1027 low-bandwidth hypercalls; three checkpoint
> attempts are bounded at 3077. In vmcall tests, a maximum-size transfer
> took at most 7.47 ms; three complete transfers comprising 3081 calls took
> at most 21.58 ms.
> 
> The crash report remains suppressed while a crash kernel is loaded because
> the host may terminate the VM inside that call. A future report from the
> crash kernel or kdump userspace can restore the event after saving the
> vmcore.

Best Regards,
Petr
