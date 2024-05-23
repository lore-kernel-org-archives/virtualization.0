Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1141869
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446088; cv=none; b=s2UHxeBu26rBqRzppRx8ENRGADOfoIv5jxlZwdiRhX4SKgufbcxPTNlATLTgHSfEqiQvs6rh+xtEcZl9pa+UxpkYa7pCN/0pkXJDS8XDVO1qiHLRMJbrwG6dgyl6pdEYlHRxeBdOZVWsDGbTVt9qIqcxVU4L7t0roQpvOnw+whs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446088; c=relaxed/simple;
	bh=XxVSYbHZ+H/p/wEVBPhFkeHIAS4bvPHUHG/AfTbTDl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWqHqk16B5g24iR/XhrnCOJJH4WXy4MXm+s0rMSfJZY4ATxxU7dWX2N2H0CdxtttqMaM3bqDDVXcvj0STpCrpRG/hFXacZ6JFsxIiQZINH+vU78HVtXcgEswhV4ybXYyfNnVsY9l4ooFPvD/Qy6HCBCaaiavYK7G9P9filH1JQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qj4PLV3H; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qj4PLV3H"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C25160754
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 06:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HD3-6rZl_7Tu for <virtualization@lists.linux-foundation.org>;
 Thu, 23 May 2024 06:34:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 977236073E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 977236073E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qj4PLV3H
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 977236073E
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 06:34:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 10D4862C85;
	Thu, 23 May 2024 06:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33804C2BD10;
	Thu, 23 May 2024 06:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716446083;
	bh=XxVSYbHZ+H/p/wEVBPhFkeHIAS4bvPHUHG/AfTbTDl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qj4PLV3HfkRjRQvaCMLX5FImOPh0tTMCsbpqbwyjmQ9PuQCJMuRKK4DRfMAdT+H64
	 /pyVc6TFgQ1Ff0VO5zYnQCh7NihLZ5ubHevsFD67z9IPgAHJ09ei56lxzlYf5BLgaN
	 tDPpQVlYjfjJ5j3Xrko/muiRpAeisWvFzfXLZ7Ss=
Date: Thu, 23 May 2024 08:34:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
	dave.hansen@linux.intel.com,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	xen-devel@lists.xenproject.org, security@debian.org,
	Salvatore Bonaccorso <carnil@debian.org>, benh@debian.org,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
	Deep Shah <sdeep@vmware.com>,
	"VMware, Inc." <pv-drivers@vmware.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 5.10] x86/xen: Drop USERGS_SYSRET64 paravirt call
Message-ID: <2024052333-squishy-phony-d2e2@gregkh>
References: <20240522-verw-xen-pv-fix-v1-1-45add699c0e4@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-verw-xen-pv-fix-v1-1-45add699c0e4@linux.intel.com>

On Wed, May 22, 2024 at 06:20:15PM -0700, Pawan Gupta wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> commit afd30525a659ac0ae0904f0cb4a2ca75522c3123 upstream.

Now queued up, thanks.

greg k-h
