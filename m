Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A142429831
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686906; cv=none; b=NsrC6fK6LqDsGfvGzr3f3O7SMguWjsj88zUlwwWDcWDyrHDAypoMEY16vVPEA609el6STp85UJkDXKPGiuOG7dWCOXWLU4YuWIwcgEMABYqGJOwhokk7OmlFh7u9o2RwnLOgspNdSy2RXN0qD8q1DEgZsn3SrvGkkvkvF6tpkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686906; c=relaxed/simple;
	bh=XgyUk2amhhM/9++JTHRB9BXzl8bURMsskfIxgq2wBEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xjldm9tZ6OsA4p2631j9thYzmLBOtPtOC3e0dPkh3jAmtnrRY4zu7Vuq6kUYPEEf3FgPELh0qfz+QiGkYkxtGipZhy0qkpTCr+5vgH1D1KW9tCL+qzBejRf+WnZfyUZMH1lUJtjY/7As+WwinPlnj8p1tOCSBW1ypvVpCmvuGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id CE937A0183;
	Wed, 13 May 2026 15:41:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 0FA8833;
	Wed, 13 May 2026 15:41:33 +0000 (UTC)
Date: Wed, 13 May 2026 11:41:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, "Paul E.
 McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 6/7] locking: Factor out
 __queued_read_unlock()/__queued_write_unlock()
Message-ID: <20260513114137.0a569a47@gandalf.local.home>
In-Reply-To: <8e88613c73f0603c4440ba3a62eb604a5dddc57b.1777999826.git.d@ilvokhin.com>
References: <cover.1777999826.git.d@ilvokhin.com>
	<8e88613c73f0603c4440ba3a62eb604a5dddc57b.1777999826.git.d@ilvokhin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n3nakct8t6r1yy3ofy5ra1qebnxg8gqw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0FA8833
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX194La6sVd8fLI5Dtndp8CiCROEVNoIrQNg=
X-HE-Tag: 1778686893-373441
X-HE-Meta: U2FsdGVkX19n47HJ3PRsL6Y1RvJxJXJLdtucZN5M7VjX/LIIs6A/59gCiliFB9zKBz9Ep6v66pHEUltY8UmeMOUl5LL++AIx0j9uhDBUPpAXSFMX7mK45AC7G4GiEJkqoGxYiMzfhIHlwxnmdlZUHWgLwcrWH9EwfXbx7/0TorRGtWFLrX4Quk3cbFnjhOO10cwuECQLqsaSIBJsPbaCYRSZuPHX+KlDfDXjlcVK2sBfP+7G55KdHtbdpABHw56YHDSJyQ1ObeE1yvbzMkJsT8TJlFdEm9IHGx0z20CELoNZwBTlDMB6AH87nswXkizkxx3mfdt+Azjt7huoKRykluWHevIQ+4LrAE6jZh5irGo6F+vGEm5llaCbJ5wnjrqEqdiIXyB1NdQ/TTvk/MOgsA==

On Tue,  5 May 2026 17:09:35 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> This is a preparatory refactoring for the next commit, which adds

Same thing about using "next commit" in change logs.

-- Steve

> contended_release tracepoint instrumentation and needs to call the
> unlock from both traced and non-traced paths.
> 
> No functional change.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/asm-generic/qrwlock.h | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
