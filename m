Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F765661;
	Mon,  3 Mar 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740961010; cv=none; b=fvwm4wevfz9hvDZzq7S85w0puILATJtudFWH0EcFnHbAV/dGj9FOUhTi84vMDzg/772rUzO135/eV3W1GrOd3Iub5fbbJh6f82pcIprRjCzPCYx+nNZMtvV8c/B/63w/HSAVs/9PlvJYXnkyYhXIzSgsyFJ1rD3+wnxkrZ6I60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740961010; c=relaxed/simple;
	bh=LoWtDvz144xVikaDdQeH6Dk0k1zaA6/wZJx8FixQrQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDFQOe+ddDaUW3r42X8oZLim0t6UamWJ/NRnDJx1wFDhqI6vDbt0pnZ+WCsfBp7BOyU0fCvQbNENUEKmjj2HPEacoL01/2OU7L/p6lnsAME2diZvJUs8o3hQN3LseEEWtzJAGDdvMpYR1o3aePL91sCibgZG6AdlrrdXrEBneg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VXKQ1J14; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VXKQ1J14"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=e9V8Oh6HOjBxQKE3ZmtMXNTpNJNzuuQJUfOrbyAcKZE=; b=VXKQ1J14iZeO5gGI
	LI5lu4kws5Rg0Gg3icTpnMHFKQgxZxibHz2u+2he3T8XE6Jpm+R6RXQs/aq+4a3h53zz/SYOZns9g
	VOLZvTEFWnxBIP69tC0tVdRTJQa7KdTOQD1Ktk9ISqD4nES+CjAPe2xIyJ5j0BiBR+8E5DwqjokE4
	UnOpMzLvX93lgnArliEwbCqvLUaZHZgExGU3gqBHuw7VyoJXiWd7Sl0eJ/1SS7vHHo4kV5d6lGvbZ
	dCW9b6eaPeeOsCI6debK/wSNx3CrTLrAmWxu38sQWzeksv4SdZM17SGZTsEVBELcCXNhmtmea4rfF
	MmdLT8NPNyuSsYjQ4Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1totTy-001zTe-0h;
	Mon, 03 Mar 2025 00:16:30 +0000
Date: Mon, 3 Mar 2025 00:16:30 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: jgross@suse.com, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/paravirt: Remove unused paravirt_disable_iospace
Message-ID: <Z8T03pyFFd9HyMB3@gallifrey>
References: <20250303000830.82968-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250303000830.82968-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:16:13 up 298 days, 11:30,  1 user,  load average: 0.16, 0.03,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of paravirt_disable_iospace() was removed in 2015 by
> commit d1c29465b8a5 ("lguest: don't disable iospace.")
> 
> Remove it.
> 
> Note the comment above it about 'entry.S' is unrelated to this
> but stayed when intervening code got deleted.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Oops, missed the .h - v2 coming up.

Dave

> ---
>  arch/x86/kernel/paravirt.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 1ccaa3397a67..debe92854774 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -90,26 +90,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
>  	static_call_update(pv_sched_clock, func);
>  }
>  
> -/* These are in entry.S */
> -static struct resource reserve_ioports = {
> -	.start = 0,
> -	.end = IO_SPACE_LIMIT,
> -	.name = "paravirt-ioport",
> -	.flags = IORESOURCE_IO | IORESOURCE_BUSY,
> -};
> -
> -/*
> - * Reserve the whole legacy IO space to prevent any legacy drivers
> - * from wasting time probing for their hardware.  This is a fairly
> - * brute-force approach to disabling all non-virtual drivers.
> - *
> - * Note that this must be called very early to have any effect.
> - */
> -int paravirt_disable_iospace(void)
> -{
> -	return request_resource(&ioport_resource, &reserve_ioports);
> -}
> -
>  #ifdef CONFIG_PARAVIRT_XXL
>  static noinstr void pv_native_write_cr2(unsigned long val)
>  {
> -- 
> 2.48.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
