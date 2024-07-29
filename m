Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCA148829
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257021; cv=none; b=ETKjTMJ8dpu7kaYaLdrfc39aQij5yXPnP6AYigxrnSIoYwsiv6iHP1MhqAZDqg/drMjbMrE3lHGAu82IFfYrFDAt4m3ekhGhWLDhR8H1+1h4Sq1njQ9FNOCTsIfKlpni0Pb0IbOoUomr2Ci7IaxA3G2Wt1/VFTMDMHXG6oZzt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257021; c=relaxed/simple;
	bh=sickbkxVaX3AAOxn1K4qo91dF8jq1RkhXJpV3/YGQys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcHWLtJDWnRbVMt5nUoH0bsnNXxro/G0vizK3CxvDHzeAYMV/phUH7Cfxk6xmVaSOFSvNnNH+gnAcPo0LTRj2yLoCgBE8lB7Fad6unOmU7Dq1K2pCxny/3jwKs/kf1dsxhMrobqBdyRNW8xDNdbLr04GXxKtdFSgEh2451rIHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZEoUMQkR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07VOoV4B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZEoUMQkR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07VOoV4B"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722257017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XK5YwxNfDT4/GYye/yweeUMPcYJ7GH3lRrXTHzwEi04=;
	b=ZEoUMQkRuW6Ymcvjo+4w7A5DtqQ/MkGvVawQWa18r+wTKun/Sdl2CdiguuaGgZGvS7WRiP
	aX3F9NoBcS9nAeDTLf+FwHqXFpa9DJ3+KS/PwqgTFaVjJXAyGGyM6ehInsqAUt5CAPxUsq
	ARDUuz5+IdM6JsUKiXZtOi6TdG+8zS0rd4wbaK6Jmgh9wU3kFVH8XZTSfzMRNRiw8CuE+3
	+7cMT4coyDzLbCIEuu2mjfR+tbxD9A4rortjfJvg3DWmtxZF4YgBk7eCsY0l5vlgzvvpjZ
	YMAHkmoCiXI57w5gv2PyT6ub8G6qyXFDytyezB7fJzruxJ3MAPk6cJ45aNaBIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722257017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XK5YwxNfDT4/GYye/yweeUMPcYJ7GH3lRrXTHzwEi04=;
	b=07VOoV4BKZEjr1D1wVraWt0wF6q5G/n3wIEIJTyY4rhWOHCzH2tVstXZmEQMhwgyzZ09zW
	Nrwiset6bj+n9uAg==
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Juergen
 Gross <jgross@suse.com>, Nikolay Borisov <nik.borisov@suse.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Chen Yu <yu.c.chen@intel.com>, Prem Nath Dey
 <prem.nath.dey@intel.com>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
In-Reply-To: <20240729065236.407758-1-yu.c.chen@intel.com>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
Date: Mon, 29 Jul 2024 14:43:37 +0200
Message-ID: <87cymw8j2e.ffs@tglx>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 29 2024 at 14:52, Chen Yu wrote:
>  #ifdef CONFIG_PARAVIRT
>  /*
> - * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
> + * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
>   *
>   * Native (and PV wanting native due to vCPU pinning) should disable this key.
>   * It is done in this backwards fashion to only have a single direction change,
>   * which removes ordering between native_pv_spin_init() and HV setup.

This comment is bogus now.

