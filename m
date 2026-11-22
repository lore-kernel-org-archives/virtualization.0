Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347297;
	b=EvE/kEfCr6B9foO9XLkvl+zPi2wxsCwSFGl2utCXFYFHKU7YyVIWE0GSet1bn+s8ELoj
	 pQhRnPhBGGwTwF+kkQw6vTjpr/nP3jVIz4YWzWz9DDm+MPgMd0Jds0SOVibLmNtVvqsdY
	 op5IO2w2LnMY7e8kroKnGzmeo0FGD8Izvysaco2aToC3wDQvouAX36RExMbvRDoK3Bg5p
	 urzM3vaeyGG3hZGWRXsmcp8nPnDlhP/DSvZTEEvyF7N+8cFRw3jDqwaSX0ufPUGuY99ca
	 PYwOM0mmqk0v41qn4RIgHYBpCuD5K4qBcyzhshWfQUMSJ0KVXHhugFP07DcfZ1wuCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347297;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nQzV/9Wa47apIF2ZpStnVmsOFO0VSOl+SYDHpEGXpHw=;
	b=tWwzftnnvbwnl9ySiccPF3liQgYXBYTQ1Qgot7eHqG5OdIgtxMit9Wj15AejPvnoHF5V
	 fb9EbI4BWnUhnAI77MHx6vWeXidfu4Xu4Xbo0tRMK5CDPfSohlqdApnV1N465BBwtqIhW
	 YXUZfxtdT9tik2+utJUeJdpRDUaQyNp548xonDiFwyQqT7TYNKOHgGZgngVymkII8108b
	 p35pjOLqUn6CqKmLeZKp9AY1HqatKaV5ttt+f5e3dLFI0Fd9T7xooYTHfJ+5PGUGc74TN
	 c+2wKjIFywAn/+On9jOVdOtNXP/z2R9oc5kLUshefD7kdNNJCxxTYD+2vEU5Ad5hp0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NKj/+re8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78386606A320;
	Sun, 22 Nov 2026 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKj/+re8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F151F000C0;
	Sun, 22 Nov 2026 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795347297;
	bh=nQzV/9Wa47apIF2ZpStnVmsOFO0VSOl+SYDHpEGXpHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NKj/+re8LgzSze/Za37NPrrrz9zYqxHFHzO7f8dZqTmv45wHkFwoCtaMgIuYxyR2l
	 Ogw5SzsilayaXJN49VS4ILnYt+TnhJ0Inqlu/HNt/yKetSwsFH70N12Lq5lyf62iXB
	 uiy080+z+yTbsrue/PlDLzllH61aXJxoZp6vGagCweR+ZPPSF/sjxouABjSR3ezFTL
	 XJbNIKHZeKOShPfbYfwgo43JDKEC1J0T6huXy0hNYGO9hjbgSb+DhKZdltCoVA4rPo
	 1UOhV/qUhsg2KGAgwodLhAktcd/iEbHcvlK9cJpPEK/vQkvrRaZC+POlv6oabRgsTo
	 np9JRe9wf1pnA==
Date: Sun, 22 Nov 2026 12:34:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v6 10/12] x86/msr: Remove rdmsr()
Message-ID: <awLTXAT-amcgoRT7@gmail.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-11-jgross@suse.com>
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
In-Reply-To: <20261116150208.1572254-11-jgross@suse.com>


* Juergen Gross <jgross@suse.com> wrote:

> rdmsr() has no users left. Delete it.

Here too we have a few uses left in comments:

  # rdmsr:
  arch/x86/events/intel/lbr.c: * value from rdmsr() must be converted to have a 61 bits sign extension,
  arch/x86/include/asm/shared/msr.h: * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
  arch/x86/kernel/cpu/feat_ctl.c:	 * Use raw rdmsr() for primary processor controls and pin controls MSRs

Which can be addressed in a followup patch.

Thanks,

	Ingo
