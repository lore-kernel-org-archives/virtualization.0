Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989395;
	b=XBSlcw8DfGHpRpGVGN1usjBl2lmbFJU9jKK3NNm6ZKqnFuCI+GOcDAKRVzhjRIooV/bL
	 S8HXv4lTcjPNbB+w6mH+jVKoUlJP8th8KtjH1ZI3dWkCYb6s/TxPiF7IpaqhmlM35oQkX
	 4m1c87oY8ZogxNnur03TsyrdbTl6WG9TLMvxGKYz7r+TxyBT0plzAhu/r35+p6CgBjAmx
	 CJIs2diVf5RjadeGHBnx+LDI/3GRnFt6Tu1gUE8I3cV/O4K/AZ+AZUmla0M7JTp9f2cwp
	 viS+GhzjH16PLJySAgXWxaM5sMy44v01Z0DL9vtk4n8Xw0Q5nV3nlZMtCUqmtDKOJbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989395;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SwXqaQPeZB5UZLdDHzNsBBjVDW0/x8WGHHtcwf53iI8=;
	b=X4GDctTMMN53rl5n/KX/vg88eHDpNEUXLgOd1Ixaegtsd8/mOjq4hPI8VckGvbRJ8ROt
	 lIV8mSIywE78PmTM9Pe24gP0zvkLWJ2bm8kk3PGnaX7d6ECKB4GvCEp80p4026GCv7kEG
	 JYZS77FkuxcvI78skvrB1LBl9p5NJe1/t56dek/dlIOhJfoxzyM8Vur997RXMWGvmDidA
	 dZYWuRgkAFelBgk/XuJZZho4JS39ojyVRsw/obm4z5eAM5e2twNdVZjpRSBK1+3TLHSGm
	 mIhm9gZK+SeqEZ/iiVPrX8zxz++GcFxxG5LA7cLEIbKz0ceYZz8YyEuwfcN5+vp41WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MCS+dVn6;
	arc=none smtp.remote-ip=95.215.58.252
Received: from mta1.migadu.com (out-252.mta1.migadu.com [95.215.58.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779E606A32F
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 08:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E779E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MCS+dVn6
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=tVRaJbRSr2735okO/8qcFBlkLriYOl2S/clUg7674iY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794989392; v=1; x=1795594192;
 b=MCS+dVn6LhZvJIbfUrTB43uAcr4VjuS2YE5rSWIAh2NxhbuDBe8geqbxaiAw8kiJxfAiF75N
 zaDhoiW6u2lJSOwxwEo6FK/rbx+pjuuuvX3AowIgDFTG0fW68339FoqfS9oh7bw5rLO3B7eh447
 48I1f5lsVu9M1MZhgrsvEuhc=
X-Envelope-To: virtualization@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 16c393e42b63aca1;
	Wed, 18 Nov 2026 08:09:51 +0000
X-Mizu-Trace-ID: 16c393e42b63aca1
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 16:09:35 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	sashiko-reviews@lists.linux.dev,
	Zack Rusin <zack.rusin@broadcom.com>,
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>, sashiko@lists.linux.dev
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Message-ID: <av1dP8iq13h-t5P6@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
 <sashiko-outbox-220212@kernel.org>
 <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
 <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
 <av1ZB3ia13M420_I@MiWiFi-R3L-srv>
 <AAB2E512-6577-4AA9-82E3-F8297A4CBDD8@linux.dev>
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
In-Reply-To: <AAB2E512-6577-4AA9-82E3-F8297A4CBDD8@linux.dev>

On 11/18/26 at 07:53am, Bradley Morgan wrote:
> On 18 November 2026 07:51:35 GMT, Baoquan He <baoquan.he@linux.dev> wrote:
> >On 11/17/26 at 11:02pm, Andrew Morton wrote:
> >> On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev>
> >wrote:
> >> 
> >> > On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
> >> > > > Allow administrators to disable host log transfer on ordinary
> >guests or
> >> > > > opt in on encrypted guests. Expose the boolean recording policy
> >through
> >> > > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel
> >suggested.
> >> > > > Zero disables recording, nonzero integers enable it, and reads
> >return
> >> > > > 0 or 1.
> >> > > > 
> >> > > > Register the sysctl only after the logger is ready. A registration
> >failure
> >> > > > leaves the internal default in force. Document that the log is
> >sent
> >> > > > before kdump, and that disable_panic_notifiers_platform_list also
> >skips
> >> > > > it.
> >> > > > 
> >> > > > Link:
> >https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> >> > > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> >> > > 
> >> > > Sashiko has reviewed this patch and found no issues.
> >> > 
> >> > It might be better to turn off this message if not issues found, just
> >> > like what LKP bot has been doing.
> >> 
> >> (+sashiko@lists.linux.dev)
> >> 
> >> Yes please.
> >> 
> >> These emails do have a little bit of value: they tell you that Sashiko
> >> was able to apply the patch and to review it.  I guess.  Or something.
> >
> >In that case a message saying Sashiko can't apply the entire patchset
> >is better.
> 
> yes my sashiko emails go to spam automatically (not cuz I set it, but 
> cuz I get so much "no issues!" Emails, that it clogs up my inbox. 
> 
> What even is the need to have the no issues emails? If one was THAT
> interested in sashiko, they could search for it?

Yeah, searching for it is one good way. Not sure if it's convenient for
people like Andrew and Mike who need pick patch. They may need check
patchset one by one if Sashiko can't apply patch while keep silent. And
some patch authors could be new, they could mistake sashiko being silent
as no issue. I did that before until Andrew told me in a private message.

If there's a document telling people where and how to search, that's
also good.

> 
> >
> >> 
> >> Me:
> >> 
> >> :0 D:
> >> * ^From:[ 	]*sashiko-bot@kernel\.org[ 	]*$
> >> * B ?? ^Sashiko has reviewed this patch and found no issues\.$
> >> /home/akpm/.nsmail-zip/Trash
> >> 
> >> hp2:/home/akpm> grep "From:.*sashiko-bot" .nsmail-zip/Trash | wc -l
> >> 1140
> >> hp2:/home/akpm> 
> >> 
> 
> --- Thanks!
