Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985324;
	b=KtV0tGaiq15hFtHVPdsE01z+CVnaMGUN5zIqio+Qo8jQjxtqxAKtxrCQZeRwNkFHAyDN
	 G57+M6dREEUamIq74W3YWj8OI9VBUeiwKMGHM08XfVpMKi46CE29A7q4ZYIJ+srdOB900
	 s2UQk5aT155XszW0jLDLvyt/jqZwgzU800FD+BCqTCpBIMQJexgjJxj+A2fPhEYkwgG5v
	 KJmImRmbrPju1eVSZxcwOEtBxoOP1jXIuGfZ4XDaAxtfZJFZ5HVrrPyyhkvljbYUUlvGl
	 jzXRmO4SQShe7j9Sb3rSZWwQ6Zpa/lbr8f/EeTvt+lpNL61dcNuqASxb0DUtDe4tSew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985324;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pC6bu7iSXyV8W9whBUiuoNGv5YhTizVhbT+HSAZuHzc=;
	b=RnO18iW4QMTaTXwkQS7v6mCaa2lFUkF1gCayMWAGv06Np9/0comWFCMSETeYsTd0gKM+
	 QTWu2viO2FTKDwRgljF8L88EgrwXhLy+H5HQgpViOZ9C5B8qU8Tr2tPSh5obL1FxIk5Oz
	 OzDzj5VmKaQ6qToL9UJdcSOfn7fgXT5v54Vbjq4ttlAm2ZLa2GL3UTiDS2fm0FScpqNMS
	 +IIVqnOUq/cLXxIxby+tVsL/9jyJ2kuFDSQd+GEgT++kDUVz/vjVzQOvWDphicmEKrvb9
	 QsJftdNGbAa7L6Z2jl/R1OnQUl/9Q0rlvncbeHgqpHnJvF7rqjc1mBiEMGYH8CcE/0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=onWjqs9i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E64606A32A;
	Wed, 18 Nov 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=onWjqs9i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249391F000C4;
	Wed, 18 Nov 2026 07:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794985323;
	bh=pC6bu7iSXyV8W9whBUiuoNGv5YhTizVhbT+HSAZuHzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=onWjqs9iJE3AO0poYc6hGpoTohnUGtCzhLcUFlojn8PVCZr2vg99c3Fj1fhmP1+FJ
	 vzPtPTP+a8et5gVCC13vLaRdyEkNvtMZn+VzWjtGGssl9YrrjxakWM3ZkCqRfGoDOj
	 He5c8nVj9LUwgAn9BJRQMe7t+28pI3PpaTgwiJYs=
Date: Tue, 17 Nov 2026 23:02:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Zack Rusin <zack.rusin@broadcom.com>,
 Petr Mladek <pmladek@suse.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>, Ajay
 Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, x86@kernel.org, Joel Granados
 <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, John Ogness
 <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>, Brennan
 Lamoreaux <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Maaz Mombasawala
 <maaz.mombasawala@broadcom.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Stephen Brennan
 <stephen.s.brennan@oracle.com>, Michael Kelley <mhklinux@outlook.com>, Ian
 Forbes <ian.forbes@broadcom.com>, Bradley Morgan <brads@mainlining.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
 sashiko@lists.linux.dev
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg
 sysctl
Message-Id: <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
In-Reply-To: <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org>
	<av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev> wrote:

> On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
> > > Allow administrators to disable host log transfer on ordinary guests or
> > > opt in on encrypted guests. Expose the boolean recording policy through
> > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> > > Zero disables recording, nonzero integers enable it, and reads return
> > > 0 or 1.
> > > 
> > > Register the sysctl only after the logger is ready. A registration failure
> > > leaves the internal default in force. Document that the log is sent
> > > before kdump, and that disable_panic_notifiers_platform_list also skips
> > > it.
> > > 
> > > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > 
> > Sashiko has reviewed this patch and found no issues.
> 
> It might be better to turn off this message if not issues found, just
> like what LKP bot has been doing.

(+sashiko@lists.linux.dev)

Yes please.

These emails do have a little bit of value: they tell you that Sashiko
was able to apply the patch and to review it.  I guess.  Or something.


Me:

:0 D:
* ^From:[ 	]*sashiko-bot@kernel\.org[ 	]*$
* B ?? ^Sashiko has reviewed this patch and found no issues\.$
/home/akpm/.nsmail-zip/Trash

hp2:/home/akpm> grep "From:.*sashiko-bot" .nsmail-zip/Trash | wc -l
1140
hp2:/home/akpm> 

