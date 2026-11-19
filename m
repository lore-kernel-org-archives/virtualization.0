Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086463;
	b=HcqPzhApb1YO4IILmW2rvn2BUW1deUm6xrvnZCmJXmTH1ZmvCeQnoK33t30/h0a3cF1l
	 7THeSR93ZVV4v5VxL61a3QqtBnIsZ8Sa6G0XOpIKobGCSzDASkfjmKrGy6+vcuDElfpIX
	 wQGKe90BZ7bLpNFGgw9b9bxHVqEWxk45WGCl7MZjf3jJvSxQ6rlrYBaTW59kdc8dZk0nm
	 pcj18G9JSv3QcJXtYF5J524fb/p5r0feP7vN3SYPNXK6Qj01aIdudSgFNIf2C5R7RDBtn
	 +92sCW+HM0CjfsD92HNBWLloFuHykLxVxjGq2Ry6tQEqo6ZZZSlF5tIJ8YjwZ7ngLdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=Ji/rZwxiSW0gG4Mvn53YHSbXtC5FbPqPXsT1gfczIuE=;
	b=fdDwONaXz0EBm869ACMPd7gjBT01rqtSA/IUHvtz+JoUD6rSxPViefZMm5XtvaPuUI/U
	 5q+OZOdNoXA5mFWZThhYP+y7CYbWi+4a/W43QytkbKAJKO3PTr2lD2AYbA6++95J3cgL6
	 CeZt3A11NecMSWOQsgQI/fqVZ34GzYVMZA0rTj56ENkjeH8wkspH9PsU3gf/dabChCQwG
	 DH6gfrv9Ze0R4Zv7fOIUDAe7rFI9UkmEWQ/9rCkldAlQcr0t0tpCx7WLAr1UXxHIeI9jE
	 hDShqwAeoyL22H7TVu48IveMtW3o/PqZt5YLhu9n420e5kpbVVCskG97bcXNsYnscUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heaEZpr7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A8606A325;
	Thu, 19 Nov 2026 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heaEZpr7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E331F000C9;
	Thu, 19 Nov 2026 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086463;
	bh=Ji/rZwxiSW0gG4Mvn53YHSbXtC5FbPqPXsT1gfczIuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=heaEZpr7V3NBLDI0usDA+AdsJvsPsidYzAf0n5/3kPoFzBY2XFgjITLpjvkEwUx6v
	 R2y9WCZu5EX4VQXsjAZsMWfy/h2dyTMc2mZPxeV9xxNNmtXMIC5Zp/y28BETLSWHdx
	 C3BdhTrYju2+scSHodr1VBT/fVjji6V5quDrsSBiGtCNBDaTmd8d8KwjRQPYzTgEkG
	 SmAx/pPPxOeMaYhed/yV7ynQZ0+ohwDrN+X5Id55qQBAYHuS0sNbfxXQW9ON38p26o
	 mLDttVexQMYCjqjDtfcDoMVTDf3XaCWL+oYUUdXdheTBUeGHCN9JVDjR6tzzWJxTf9
	 trhKJ33C85/oA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  sashiko-reviews@lists.linux.dev,  Zack Rusin <zack.rusin@broadcom.com>,
  Petr Mladek <pmladek@suse.com>,  Mike Rapoport <rppt@kernel.org>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Dave Young <ruirui.yang@linux.dev>,  Borislav
 Petkov <bp@alien8.de>,  Ajay Kaher <ajay.kaher@broadcom.com>,  Alexey
 Makhalov <alexey.makhalov@broadcom.com>,  x86@kernel.org,  Joel Granados
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
In-Reply-To: <av1ZB3ia13M420_I@MiWiFi-R3L-srv> (Baoquan He's message of "Wed,
	18 Nov 2026 15:51:35 +0800")
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org> <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
	<20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
	<av1ZB3ia13M420_I@MiWiFi-R3L-srv>
Date: Thu, 19 Nov 2026 11:07:34 +0000
Message-ID: <2vxzzev52i6h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

On Wed, Nov 18 2026, Baoquan He wrote:

> On 11/17/26 at 11:02pm, Andrew Morton wrote:
>> On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev> wrote:
>> 
>> > On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
>> > > > Allow administrators to disable host log transfer on ordinary guests or
>> > > > opt in on encrypted guests. Expose the boolean recording policy through
>> > > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
>> > > > Zero disables recording, nonzero integers enable it, and reads return
>> > > > 0 or 1.
>> > > > 
>> > > > Register the sysctl only after the logger is ready. A registration failure
>> > > > leaves the internal default in force. Document that the log is sent
>> > > > before kdump, and that disable_panic_notifiers_platform_list also skips
>> > > > it.
>> > > > 
>> > > > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
>> > > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
>> > > 
>> > > Sashiko has reviewed this patch and found no issues.
>> > 
>> > It might be better to turn off this message if not issues found, just
>> > like what LKP bot has been doing.
>> 
>> (+sashiko@lists.linux.dev)
>> 
>> Yes please.
>> 
>> These emails do have a little bit of value: they tell you that Sashiko
>> was able to apply the patch and to review it.  I guess.  Or something.
>
> In that case a message saying Sashiko can't apply the entire patchset
> is better.

Yeah, sounds better.

Or, perhaps Sashiko can reply to the cover with a list of patches it
found no issues with. That should reduce the spam on big series at
least, while still keeping the signal of "Sashiko looked at this".

[...]

-- 
Regards,
Pratyush Yadav
