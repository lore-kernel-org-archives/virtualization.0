Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012620;
	b=EM6AJKS9MOjvaPoe/No2000vbP5J9hfKRjYDAa1WdDBoLIb8AjQQeus1TNVj3u29l+jz
	 PfdMPGplVq1md5GNiHyI+sBOsmoEihmI+9lvzOUVW6D3LPUMXQpu406xzulkA9yVmmLFU
	 3dCNvf45P+9fcU6yXJ/C2TTim1oXqpwt0gZ9lw+l0uAy3O429JAG+zoCOs9IEpvBNl1/Q
	 lSfzNqICgZHOgEWDUqmLGXzA3/yZprKNCwilsExUwcE5aSs8viDl5QRAgpUqWVw2zC0/P
	 VkQq20zzMOI6zFMLjZwcavTZ9KQu4iksyQg+OBKlFlPJKAVOsKPf/JgTK6oV1zgqN7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012620;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Rspamd-Server:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=5Uv1kv8Fyhvm9H5I85dSa/PbCA5mggh9KfNOAnb9QWM=;
	b=WHaIfGkC84sn/QP+cIWHWQHfSbt+qwgwCsEqK0NWzidHPUZ07q+4Sce0m0t5VvTn7Miw
	 w7kR/BB0W3FFf0HGKW6+O4vk4c7XdWaucu8c0jAlRHqsgGcj8dfGipqREnOFo60ILGDIO
	 u/b24jiEsfXRZdDknq+rK8r1I/OZaTKx1wEAehXqPBmiaYzw7WAgBITZFLuyWJRvuf6cc
	 kP7VK2XjycXI2gTYTMhUuTbaTCbtSM0xOli0NVVxp2hM/ZDktTzRYHOg3J4VM7zIVNitP
	 RTpQvOVSH42IIocKxmKWQG551KcwV9aI9BwC10BBribs6ZDRSXM/5n/ZP3lQALYKYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=iGfSqlI4;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB6606A320;
	Wed, 18 Nov 2026 14:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13DB6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=iGfSqlI4
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 88883120785;
	Wed, 18 Nov 2026 14:36:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 472A92000E;
	Wed, 18 Nov 2026 14:36:46 +0000 (UTC)
Date: Wed, 18 Nov 2026 09:36:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Zack Rusin <zack.rusin@broadcom.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, Dave
 Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>,
 x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, John
 Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>, Brennan Lamoreaux
 <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, Maaz Mombasawala
 <maaz.mombasawala@broadcom.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Stephen Brennan
 <stephen.s.brennan@oracle.com>, Michael Kelley <mhklinux@outlook.com>, Ian
 Forbes <ian.forbes@broadcom.com>, Bradley Morgan <brads@mainlining.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg
 sysctl
Message-ID: <20261118093644.10644df9@gandalf.local.home>
In-Reply-To: <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org>
	<av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 472A92000E
X-Rspamd-Server: rspamout08
X-Stat-Signature: nsnhqchs79u4e17w4yf3cscerw5q6qjw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZBBweeRonAcIW3Sj8e1zyecfJ8umsG9A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5Uv1kv8Fyhvm9H5I85dSa/PbCA5mggh9KfNOAnb9QWM=; b=iGfSqlI4S5Jo9GiY8tlcxhyjxCE0unaS0t24fuxlAGdpNjHwyDHZj+ARmOszbO/EKCO1t2Ugca5wEWxdj+vnHq9p0zClr1EqkpIXcw0AKRzDFnMXQXE7hjS1KzJqqCKlsrgb3ii+t4Nx6MEhcyOUhiDAegNBAC6zR6uHfwR5QaI=
X-HE-Tag: 1795012606-378161
X-HE-Meta: U2FsdGVkX19ahj7+sR8308Zi2QXrJe1XafgKhfctr/grJYjwlB9Y8ZEh/wCDLdA3ilqVbgcd9/psAC2D02fnr5NUfybeZ8dc2HRYcO/cre8NmsHiAH7z4QB2+ChzEVX6QXqA8HfV1e1a0kC83FEElkujKiAX8EP0rmw1Qg87CIqmP4+nRaJOlE0C+GcOa6xa0zLDxZ+bzRw3rN2idlYOeuy5fAv88aSpKGahWNzLysA5buZCVrgVlj9rFtLgQarpJXo29VVm+Jp7Aruj752oLohZgu25tt6ki2pKen4lvDNRGDC+kc25u30CI0RfQ0Cbkale1qu0klm6mwdUMDphGbgdaUT81kCrCO0IFbQ5G+k0R5R+Lmk0oA==

On Wed, 18 Nov 2026 14:42:00 +0800
Baoquan He <baoquan.he@linux.dev> wrote:

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

I believe that's an option per mailing list. I personally like it because
to me it does add value. It tells me it was able to apply it and it didn't
find anything wrong with it. This way I know sashiko didn't ignore it.

But I understand others may not find that useful.

-- Steve
