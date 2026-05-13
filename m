Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B648122E
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686681; cv=none; b=l4BN3H3xeOxGEgwjYzIY4rKry6I18rGcW3tvJZVwiM/6we47HikmLwNGFWOvGR7ZqWvN+8ZOYRF1lXVdqJAG+HMgziJC0mtl5oW+YAzHlxMR/ZyRNLTxbNnLvxWfqlcXI3Ug43KVOS7M+qYROUAcrQi5AfgtNOTwv7lw0hfzAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686681; c=relaxed/simple;
	bh=y8NfF3OMajZVMwfCULKb6I7Sxnei84iMNXs5shGDIEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JonR2vbM0+YiOKFwmC3RtpF/d4HHMb35MKpkxhJ7/y0ViFWBN2XF0at5SM3khNi4npweH6L44PDBE3ZDUNLAu+agsKVt589ghNOIP2XJmLGlH+jZYG+Q5TmPQqsmnQtjI0ZhJhx3awUR41a4eeHsel9WCQcv6mvBf4u3AWQjICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B530B1C0437;
	Wed, 13 May 2026 15:37:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id E2CAB30;
	Wed, 13 May 2026 15:37:50 +0000 (UTC)
Date: Wed, 13 May 2026 11:37:54 -0400
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
Subject: Re: [PATCH v6 4/7] locking: Factor out queued_spin_release()
Message-ID: <20260513113754.051c50e9@gandalf.local.home>
In-Reply-To: <64c202b8a76a7d98515cf10cc1f99ecb0a9a7ccf.1777999826.git.d@ilvokhin.com>
References: <cover.1777999826.git.d@ilvokhin.com>
	<64c202b8a76a7d98515cf10cc1f99ecb0a9a7ccf.1777999826.git.d@ilvokhin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E2CAB30
X-Stat-Signature: uew54cpg7odf4hwzm1e8ogr5uztk4ec5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191fRG9JHtupJy9pd45jNQyIWUqbihg3Yg=
X-HE-Tag: 1778686670-783690
X-HE-Meta: U2FsdGVkX1/Xz0KsUrlgbQ6P0jqSsi0BuOOQ57BSdsiBmiHSiqcnhQ8GGF/57kY5vcJ/Kp/3f3hVXhFX4GKJd6dUHccPq7zIEHyQxn5yDoVxMijnzCiN8wJ8SDaVYwf66HqkJmTiFdJ7pJh3X3xBeD26+lUuy34LqT1aZOLssrwR5BQSZZo9PBde81EORMGBaUxWkhXB2CrVDuixHOOyqducHcecosvvnTb/fZrh00Esfpaocrvm/lYF5zhG0N+LkOPDBCjYZcjvOuGc0vZBxMjXiv4M4p/fDszLwC/Cm9LBow3UCP5Zi/qp3HetYEBByXLUrv4ZuTRn2iP6b3iT/wWWHo+jNXq7lo9cNMgRiATjmxEOnW30JzPGPSXoL4wAt8retxoe8y0BmTSkSH3xzQ==

On Tue,  5 May 2026 17:09:33 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Introduce queued_spin_release() as an arch-overridable unlock primitive,
> and make queued_spin_unlock() a generic wrapper around it.
> 
> This is a preparatory refactoring for the next commit, which adds
> contended_release tracepoint instrumentation to queued_spin_unlock().

In change logs, do not use "next commit". Instead say something like:

  In preparation for adding contended_release tracepoint instrumentation to
  queued_spin_unlock(), refactor the code to allow out of line calls when
  the tracepoint is enabled.

Or something like that.

-- Steve



> 
> Rename the existing arch-specific queued_spin_unlock() overrides on
> x86 (paravirt) and MIPS to queued_spin_release().
> 
> No functional change.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
