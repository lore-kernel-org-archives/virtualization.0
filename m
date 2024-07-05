Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AB15D5C1
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720205761; cv=none; b=oXi0htCQrgPm3U8lUXkKk9zgF6yF2DMy6oZToYImP1h/ZxNOkrKdkh1B3LonD99kgIVnA/G+5VTW5ncjSsWg1zYVTJ3SCyqOhkrbcSPyDWAUSzA7OHeDz4h+NGKteuXjYu+cbZt1c2Bv3TOgxJ8Zhca2OWjxJSqtHt78U7q6ePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720205761; c=relaxed/simple;
	bh=crLFsjy3aYw8IUr9kg3Bgeau9zFg4Rj+PWHrP/Wxqog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5iTkZI1C+ByJqpsAnSqsyRNISObBuAm9lwBft3M/RDcnIG5Ua2lcKD5pvjoaMeBeHj9sPCkOe9zlrV2TKnjlEUupBSWBPi7LqD1xJNHvod+aO4Cc7JUHRyAl1F5MXzjNSTVXfinESFqRBnfPlHmoz4D/V/Oia8maUzkvFVh70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GC96LAE7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GC96LAE7"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b09c2ade6so958263b3a.3
        for <virtualization@lists.linux.dev>; Fri, 05 Jul 2024 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720205759; x=1720810559; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaVLjoHzTdUX4sBfGSImQvpT2vm1WoW6FtbAHmtzZVw=;
        b=GC96LAE7+OlJUJkrmqQXqblLzEOjSyI/hqwnLHUC1BbDnpQUMcScXYZeSiDofcoQgR
         xWCwgcdgsLhc9uqLo1+LVhu+L1n+NkQ7b1NLtaIeDmuaXpuo0L/emK0oy+qIqBf3jUmw
         9nUwfrv1EyYiX4KoLhHkDSwiGs3FLv3+O2V9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720205759; x=1720810559;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaVLjoHzTdUX4sBfGSImQvpT2vm1WoW6FtbAHmtzZVw=;
        b=OMLS190b1dCbgxMdN78vVXui5uPtn4cFvNsTKOu814018TVCP2Lw36cECOUjXVXhCr
         HQTlYolxKHZiyvonK6wxSG8QBvtJD9DlaR2i/wdNgMDK6Uo2v/m08MC9a4vta2bV69Jg
         ZAaWvz7bVBqPziUgy2/rvj7tCPfOdsgHr3pSrxPFUdAzQBZVNcjbqKRGYNfhYRuilm6V
         cwOOkvxIHPmfi18P9O5SfqysgRS8S6G50V+gqCy6l/YnT+1W/ocgYWrOZG1EqmCktlAe
         9OSXhyG46eczKsBcNNxvLFCOZGClsB1qK9lY4mYsGyOaO5mdfIZ4gkSHuw3/AsSpjdg6
         sJEw==
X-Forwarded-Encrypted: i=1; AJvYcCVA97unBfbXTq1L6SujdX9NH93oPJPl/3kVVJz/2f+SRVnS3gXsoDL7zi6Kd5El6FauXXFuOMdCtDmW2nGeaZmKGFIDHVbVXj/A+f9eqpI=
X-Gm-Message-State: AOJu0Yw34aYpHIOXTt8vouSeYYaz7pfO4n1JEOZQl4XWjX0mqsv+bvJZ
	LGAKziIXc6Fw4PRUF0HXfAXtZ4U6OblWLbAHQeogL70xp2Hm9Xd8Y2YyELjHmQ==
X-Google-Smtp-Source: AGHT+IEZDDQ1xVg8ajrF910XkrCyc3T3zygzrPPfal/9dd33RTK+teUfJ40f9RPfqO1AZQzPqLGOmg==
X-Received: by 2002:a05:6a21:6f01:b0:1c0:defa:b68e with SMTP id adf61e73a8af0-1c0defab8e3mr2032690637.39.1720205758826;
        Fri, 05 Jul 2024 11:55:58 -0700 (PDT)
Received: from prme-hs2-i1009 ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb4f6884b6sm15663335ad.48.2024.07.05.11.55.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2024 11:55:58 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:55:39 -0700
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, alex.james@broadcom.com,
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 0/2] Support userspace hypercalls for TDX
Message-ID: <20240705185529.GA16769@prme-hs2-i1009>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <20240704130505.GT11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704130505.GT11386@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Jul 04, 2024 at 03:05:05PM +0200, Peter Zijlstra wrote:
> And how are we to ascertain the software using these hooks is deemed
> secure? What security risks are there for the kernel if a malicious
> userspace process asks for these rights?
> 
> The kernel must assume malice on the part of userspace.

Thanks, Peter.
   
I don't believe there are any additional security risks for the kernel
itself being introduced here. The kernel is only responsible for
copying to and from userspace registers for the hypercall, and
executing the TDCALL. A similar approach already exists for AMD SEV
(see vc_handle_vmmcall), which does not restrict VMMCALL in the way
that TDX restricts VMCALL.

In the case of a malicious binary running in a TDX VM, if it wants to
communicate with the untrusted hypervisor or other software outside
of the TD, there are several existing mechanisms it could use, not
just a VMCALL. I guess the point here is that if the userspace
program is malicious, is anything gained by restricting VMCALL?

This patchset really only handles the case where a trusted guest
wants to limit access to VMCALL to binaries that self identify as
hardened against potential host attacks.
