Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988306;
	b=Et1fjeTcY9VBa93jj+lkEI2cBnmB10ul7ihOeWjmKxBzytrai/XcXeZKlqUuwtGXnlJw
	 vp6SRD1VLgi7o02hNYYKlqU8nK4oGQM+pOoOBYJiZxQHOkj6P5xKf5W57TYsTtEdCWZic
	 nO9cTQJGxLhM2h8pDz/r3BRTmHhOKMnTo/N8qXFnnD2Etqe74uWulnpXSK2KsXPHRYBZ8
	 djWaRkQQjqr48vyZTXPZ0qCngsyCiQNrPU1IEUMJGEkKa/5pBVKognuPE0zGQchLyUQhl
	 fnWwg+E94BHSZbDJi2Sl9ljRkHLLrB4OjderFqXMJqIl6GD0rN9Qoc8esM6JDXAOlyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988306;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O5PkKeqYb/LwHETHiLrh+1bM410DfdgOAKrYXsI05vg=;
	b=j0dZ1KxMAdFSP0GapPie11QkA4d/a/zgNpkQhPTNISiegPqtlNUsYTzRNd5/9jyxdQGI
	 EaX0aCAoqU8/LMOKZdZEj4Hb8USPAWwDJhVKPs3DvAZCzi8VvnVgXb8DuLzLVJdg1Z14a
	 Uh/8saHTkawPluw4rRWiuIefHvA7gNAmoH77ki5Uhm1M2aVZ65mZ2AhlnNh2J3g5PKR2V
	 O4JacG3WvQ2oX1zPI8P0pPoAudm3n+PwqkU7XCS2G9dfN6/n6SQDj1uYYd2OozGv8syiE
	 OrDBt6MyYgTHTRhsJaQw5s2HVYSn/coIDIShapEwRIEbGaKUhZVj+WiC78vvBs0rWpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P1ud4Uqd;
	arc=none smtp.remote-ip=91.218.175.45
Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB6606A32A
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 07:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BBB6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P1ud4Uqd
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=XvAgxEjJ3OAUwu1XgsNSodkGZOpTs7Rjf0Vt5qxjVW0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794988303; v=1; x=1795593103;
 b=P1ud4UqdkEjF5/8kmiGXo6Je+q0eJbj2XWY1uGgq+rPJZ+hgPzvXocLCtuJ+2E3A+8R2a+lH
 AgdhbIapLGW1EqtTYbzxBovEueeytSWVdwk7dD80rbD7wP0BiqMRUVAAE1FgS3p0qzYbA0QLcoc
 ketO+IeHdxaS2beDnxuCrbQI=
X-Envelope-To: virtualization@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 2217796b0058d3f6;
	Wed, 18 Nov 2026 07:51:43 +0000
X-Mizu-Trace-ID: 2217796b0058d3f6
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 15:51:35 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sashiko-reviews@lists.linux.dev, Zack Rusin <zack.rusin@broadcom.com>,
	Petr Mladek <pmladek@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>, sashiko@lists.linux.dev
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Message-ID: <av1ZB3ia13M420_I@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
 <sashiko-outbox-220212@kernel.org>
 <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
 <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
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
In-Reply-To: <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>

On 11/17/26 at 11:02pm, Andrew Morton wrote:
> On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev> wrote:
> 
> > On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
> > > > Allow administrators to disable host log transfer on ordinary guests or
> > > > opt in on encrypted guests. Expose the boolean recording policy through
> > > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> > > > Zero disables recording, nonzero integers enable it, and reads return
> > > > 0 or 1.
> > > > 
> > > > Register the sysctl only after the logger is ready. A registration failure
> > > > leaves the internal default in force. Document that the log is sent
> > > > before kdump, and that disable_panic_notifiers_platform_list also skips
> > > > it.
> > > > 
> > > > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> > > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > > 
> > > Sashiko has reviewed this patch and found no issues.
> > 
> > It might be better to turn off this message if not issues found, just
> > like what LKP bot has been doing.
> 
> (+sashiko@lists.linux.dev)
> 
> Yes please.
> 
> These emails do have a little bit of value: they tell you that Sashiko
> was able to apply the patch and to review it.  I guess.  Or something.

In that case a message saying Sashiko can't apply the entire patchset
is better.

> 
> Me:
> 
> :0 D:
> * ^From:[ 	]*sashiko-bot@kernel\.org[ 	]*$
> * B ?? ^Sashiko has reviewed this patch and found no issues\.$
> /home/akpm/.nsmail-zip/Trash
> 
> hp2:/home/akpm> grep "From:.*sashiko-bot" .nsmail-zip/Trash | wc -l
> 1140
> hp2:/home/akpm> 
> 
