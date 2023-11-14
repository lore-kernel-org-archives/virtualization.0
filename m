Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B141227
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hMnbDHKW"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEB2742168
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 15:09:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEB2742168
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hMnbDHKW
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5spCzbCIQhkU
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 15:09:32 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5681F42166
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 15:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5681F42166
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A530440E0171;
	Tue, 14 Nov 2023 15:09:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G3AX9jz7husn; Tue, 14 Nov 2023 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1699974563; bh=xht2qTGG5m+Qk/3MJxB19SlmIWOtdwjcdQHyOC+cgh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMnbDHKW9vz0py+I8oKiODpkC6egFa32y2qtmkUHRrDJPpIRAzSyceM5Ospv0l8yY
	 upH0OzyyU1NSMRPuYMvHyMOVldBG5wOWGKSvdbAIOfjpihOv9sIOhzc+yz4auSE7N8
	 WKyRvaBC1Tbvqohg2+t9ut1GyjoIr0zCYC/U3L8QYlaVOEtKdc4zh/oALIqOtyW/H7
	 pjjOLh86KeoITHkg2dkAILgkDRAKnrPBu+TTvzsJw0f1WhjaXhp7Pa6+t3Zvk6DTt0
	 QLAn9x3BTH/+Rbo2olMoIxOrgdlvY/aZjIbarc44BVSdva2wmIaNVKzuZBB7dAQnDo
	 HsNMwclI7ychnOSzNoPk3bbYc70CrCvxobwKPmxYVyc8fKHhLhhprvLJ3MUFIDIqU2
	 Jvc8QN/6KR/8cjpeL2c4EmQlRpAttKYBdGlRPKSgeP2ZNP0bOeTAWg0vtXNn89USa5
	 8VR1QkztArRQXjVh4ErLqENGF5tBrI6YtI5l2C8PQHir5562q+qy0u4FTAMy3GgIJa
	 9JgBXardLrJWFzghTiPyq09U7O5GhbrexkNbSRcPI8pEP+HVRWokqvR4lPLuTpcljU
	 VbMs8KjRiCzo6EBe5s4fTfFYBZc4JQ5RJm2vdLKV88NjnlEv51Qk4K19y6WU056Uui
	 qpZY9edoTt8tvJB76UnCXlFw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7729540E0030;
	Tue, 14 Nov 2023 15:09:11 +0000 (UTC)
Date: Tue, 14 Nov 2023 16:09:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux-foundation.org,
	Ajay Kaher <akaher@vmware.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 3/5] x86/paravirt: introduce ALT_NOT_XEN
Message-ID: <20231114150910.GEZVONlhGbKpkrx7El@fat_crate.local>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030142508.1407-4-jgross@suse.com>

On Mon, Oct 30, 2023 at 03:25:06PM +0100, Juergen Gross wrote:
> Introduce the macro ALT_NOT_XEN as a short form of
> ALT_NOT(X86_FEATURE_XENPV).

Not crazy about adding yet another macro indirection - at least with the
X86_FEATURE_ it is clear what this is. But ok, whatever.

Anyway, this patch can be the first one in the series.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
