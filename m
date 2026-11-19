Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102520;
	b=2kd5FXTow9oSas9TNpzofSOMTTmSOPqk973iKb5y89FWgp0mHUwxiO2/5IjY/BpE53lB
	 bPA6p8/9jI0/cEkxcZh/qO7LOmK+MJ7h1N6uN8OLfynqfI6m4m7IIEhZ6O2c/+528mrpQ
	 vOie2926rG4lY5SHQmonOIzxA/9N2GTTadqwnlKDySXNVw5VFA3NwYw5TLnN/pELIsctS
	 Y5OIA043QAwXvUeY3AsFqtoThpfq8T0m1FtfC4ooNLpA7Ccd9UEMMoyPWZZAYOrB85pru
	 TQ2lm/MyUgKtxC7JPRMRghXEdDiKHs6tR0S9yEADsRQsRJLwl0P1CNis+EnNdRn8Byg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102520;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=5PHc8ZY0sl/OvQI4AydERp0/2Wo62tIxIPbE1l5fSsw=;
	b=DWSf4vghVaPa/G2FjFUZ1rAM/4OzQHgS4AEERTIA7hYH6JszpxjGcpaFhMFcUeA76YUL
	 NZhMt/ODv8AoGpBl4/Pl710V8Cd8OEEXl4PtvxS8VuWlaZ7sC7tgA7awP8LOxlVG8o2Xl
	 aBEb4RylVrZerAQ3587Lx6FFJ3Y277MjxPhrHDlyZVL3DemMRJlj1fUr0iFxwVTEmXrro
	 ZY5/iIuRnnA4dNwxDmyOWXMUoJG9yJ0vuRzh87eU7OO1xaWkHw7AnUJloY2PZrkGWe+3m
	 FFXx7h3YPOGwurcpaviHp7vi7/b5Ee9b9HCjLU79HhAd4nGKnFt4oPjWQ/jtZ41Fa9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hex2NF+0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7660A2605;
	Thu, 19 Nov 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hex2NF+0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A101F000C6;
	Thu, 19 Nov 2026 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102519;
	bh=5PHc8ZY0sl/OvQI4AydERp0/2Wo62tIxIPbE1l5fSsw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Hex2NF+07pgiDiizKTSaTy2QiJt962Jz9neDLC7SWt0Z1pHIjDY3RVhYbNO3rUv+0
	 7Wly4VWIb5fUVUi/d3RiLYokJt6bUnQJVtXyzkw2awLQS7P6Iffo77DyKm2BBJLmiV
	 x8CF4xkG1AP80Oc0D/eBWKh+hGgYAqBO135x0D4cGnj29nC76rF/a4pVTUlViL2v5G
	 1Q0dfxaDiav1aptpzp+P2KiZRNm5rxwXTEV1DiViRLzgtQ8IEVBQlmLRKFTr4qdPJw
	 lCaH42SZVqa4mSGQWi2hScFQiRW0POGlv5gcT/QFraKN46WKK+P1Ez2GxIeHxhtI2g
	 nljYf3/nuXM+g==
From: Roman Gushchin <roman@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>,  sashiko-reviews@lists.linux.dev,
  Zack Rusin <zack.rusin@broadcom.com>,  Petr Mladek <pmladek@suse.com>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,  Dave
 Young <ruirui.yang@linux.dev>,  Borislav Petkov <bp@alien8.de>,  Ajay
 Kaher <ajay.kaher@broadcom.com>,  Alexey Makhalov
 <alexey.makhalov@broadcom.com>,  x86@kernel.org,  Joel Granados
 <joel.granados@kernel.org>,  Thomas Gleixner <tglx@kernel.org>,  Ingo
 Molnar <mingo@redhat.com>,  Dave Hansen <dave.hansen@linux.intel.com>,
  "H. Peter Anvin" <hpa@zytor.com>,  virtualization@lists.linux.dev,
  bcm-kernel-feedback-list@broadcom.com,  John Ogness
 <john.ogness@linutronix.de>,  Steven Rostedt <rostedt@goodmis.org>,
  Sergey Senozhatsky <senozhatsky@chromium.org>,  Kees Cook
 <kees@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Bo Gan
 <bo.gan@broadcom.com>,  Brennan Lamoreaux
 <brennan.lamoreaux@broadcom.com>,  kexec@lists.infradead.org,  "Guilherme
 G. Piccoli" <gpiccoli@igalia.com>,  Maaz Mombasawala
 <maaz.mombasawala@broadcom.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  Randy Dunlap <rdunlap@infradead.org>,  Stephen Brennan
 <stephen.s.brennan@oracle.com>,  Michael Kelley <mhklinux@outlook.com>,
  Ian Forbes <ian.forbes@broadcom.com>,  Bradley Morgan
 <brads@mainlining.org>,  "Michael S. Tsirkin" <mst@redhat.com>,  Eugenio
 Perez <eperezma@redhat.com>,  sashiko@lists.linux.dev
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
In-Reply-To: <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
	(Andrew Morton's message of "Tue, 17 Nov 2026 23:02:01 -0800")
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org> <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
	<20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Thu, 19 Nov 2026 15:35:18 +0000
Message-ID: <7ia41p8gx2a1.fsf@castle.c.googlers.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev> wrote:
>
>> On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
>> > > Allow administrators to disable host log transfer on ordinary guests or
>> > > opt in on encrypted guests. Expose the boolean recording policy through
>> > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
>> > > Zero disables recording, nonzero integers enable it, and reads return
>> > > 0 or 1.
>> > > 
>> > > Register the sysctl only after the logger is ready. A registration failure
>> > > leaves the internal default in force. Document that the log is sent
>> > > before kdump, and that disable_panic_notifiers_platform_list also skips
>> > > it.
>> > > 
>> > > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
>> > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
>> > 
>> > Sashiko has reviewed this patch and found no issues.
>> 
>> It might be better to turn off this message if not issues found, just
>> like what LKP bot has been doing.
>
> (+sashiko@lists.linux.dev)
>
> Yes please.
>
> These emails do have a little bit of value: they tell you that Sashiko
> was able to apply the patch and to review it.  I guess.  Or something.

They are opt-in and some maintainers asked for them, so Idk if globally
disabling them is a good idea. Johannes suggested to send one email per
patchset, which I like as an idea, will implement a bit later.

I like the idea (from the thread) to send an email if a patch(set)
hasn't been reviewed, e.g. not applied correctly. Will implement as
opt-in feature too.

Thanks
