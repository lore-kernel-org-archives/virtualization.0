Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984130;
	b=SQEINDuZqdY/dkOeMv0Ts8L2Og19bTWkpvj7ExA1TTRV3QIEWhJETVIZzy9XKLyfTlZl
	 CuLikoi+2DGNPSbhV0ojCQoxtfhMSh/15VgdZuiiVVQh8tCoSBVy9tM6wshF5kSMvAr9j
	 WdvT2D9nAq1/NAfxqRJYcIYFp2jmpeYuYYWKK9UvFP6CE5vlP1pNgvYN0zMVDW5iCbJsQ
	 Jaqiobz5ryIzAFRs/eiS78SGdnm09R8Sa3EpXTcsQq/dCv7bu8l9Nwv9aHmwErm83Ued1
	 j2V/Wb7s2hxqbhfhgpvmbWQ33THnW+2dm5SiDGIb2ADtE5WOWyRqmN83fkwCtPnU07A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984130;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4vrUGvYBYjikigCpSRsWM3IL2SKRFIwk8YXcudEu+Vw=;
	b=Fy+deDXOHhPZR+yhndVrhh//RYsB8LraQn6WX7F1+o4qC6H5L4bBF0sUKPmHNYzEejRt
	 1EEliIGH+eR948H7BftzH5JiIYNg8m2yqnWteQcYXrFXBlKhBhb3LzN3jg6gUeTL8w3Qe
	 yRGNy5zxsxPFfg1l+2vCEyxZcms9mfSavv14BPJPOCMqHk9XkDkgdzuUSPhBiiHPVFv7W
	 5lpRjqcQyhGla9hxKOh334yK2yFplv2SJAuXyt1J1vnV4RmNCnTJhC5cJWsjTF0ffp9rz
	 wJsmLCpZLBWfQjkNxK6eA0NMmal1pe33TpbTHvE1zzPc5r9JALABwqw+HKxz17R1ZOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WB2nCTXX;
	arc=none smtp.remote-ip=91.218.175.128
Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB5606A325
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60CB5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WB2nCTXX
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=FYJgjS5+nVGzEAb8n72wxlzwghj2XRvZF7p3yXiyO2M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794984127; v=1; x=1795588927;
 b=WB2nCTXXbH7W/R1/6oAKysqyeEqZ+HxxGD40vtPxuZKj2uBIwcqZDeCqS+frOAxEeKEyojEL
 LUSHj1VxElrt1ZXqU4po1aayB/2kYcbweRPa13m2WuzBM0eoPZLqtuQynAvr/Wc24ZJ+pb1vScG
 GHnQu9XU6Y4I49YuXLVbJ2zU=
X-Envelope-To: virtualization@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id fc53258ff22c9965;
	Wed, 18 Nov 2026 06:42:07 +0000
X-Mizu-Trace-ID: fc53258ff22c9965
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 14:42:00 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Message-ID: <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
 <sashiko-outbox-220212@kernel.org>
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
In-Reply-To: <sashiko-outbox-220212@kernel.org>

On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
> > Allow administrators to disable host log transfer on ordinary guests or
> > opt in on encrypted guests. Expose the boolean recording policy through
> > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> > Zero disables recording, nonzero integers enable it, and reads return
> > 0 or 1.
> > 
> > Register the sysctl only after the logger is ready. A registration failure
> > leaves the internal default in force. Document that the log is sent
> > before kdump, and that disable_panic_notifiers_platform_list also skips
> > it.
> > 
> > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> 
> Sashiko has reviewed this patch and found no issues.

It might be better to turn off this message if not issues found, just
like what LKP bot has been doing.

