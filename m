Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6F13A88B
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195469; cv=none; b=ng3dUWcBScxRbmL5/5tnreqJMd8+CBRQmzKyPDBras5Eab07nz1kKLxTVJMfTPKg08JlrAzltznCnZXDj5sFl+dC3yD/yn9QsXzD0S6PCWRZNCo3+zL6X/xUtgvtCF9wvapiHdetCLlihntBZXxJMT4238atKh5S+LLRKwjisWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195469; c=relaxed/simple;
	bh=FNTBsX+63uIgnWKLXkG5pwYCpWKOxAZZwqQ8X2x73vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcM0RIFzRx7L9zpR3yimlJ2EfKOuxg09EYyjuxMLP36dpQ4KItL2B/smGhmpuoLSDneFm53DtbmhnSiyAnzfHZ2IDbw6to8SJmgpIFOBmrwc0gRFzRc5QB3G8o53Qg3qh3VUF2ZHQR/+eDheKjP/Xy5EUG3UyX+aSL3ZIDmlXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J6VAgbO9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J6VAgbO9"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c8e7553c9eso1238475a91.3
        for <virtualization@lists.linux.dev>; Fri, 05 Jul 2024 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720195467; x=1720800267; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0j8hAyQWJjGjX5p48jR0ZeFa7oUdUxgMcRMAfmdz3I=;
        b=J6VAgbO9HzuhZ/FZr4H/PEin/LA11g/TNsXj3wjI9TYkXvdFPxO7sshv8iS1E2Adn2
         0FR2q1xaORujGaM7ANXeqq4G3KR7a/7V0+FYXvIaJe/pp1cMRCp0tG4FuWu2YojQ6pI3
         sTC+POvUYzgKum1B2Vwy34sDLcQMMXaNiqB/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720195467; x=1720800267;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0j8hAyQWJjGjX5p48jR0ZeFa7oUdUxgMcRMAfmdz3I=;
        b=PNd6wIO08yzCD7LeqwtHmESwt2fBhNR7Npv+4JShnIhj4rd4C91TlFomRU7VYSNTn8
         MxDVeIsoRj10odm5EV2+6B1KGTG8cAxV2GKNYw58A2DhzGpiAiBCBXz9J1LZjz6G0sMJ
         ZNAklVRrvaX1jHTRJByHD9hUbWZ5HKUU8/VE6YEsNnSLkgQ1tTMvrnZjkhjH+8pIx/Ld
         Jy146OYNe5PyOZIZ4oRzMqukRekbHK67B7w+JhPR+gx7vDzT2hntphJd6wIesLMD7O1i
         8oAaQJ2YjBD/Ap0HkSu4gwrdyBAZfE6OQSWKt/lhEZxha9sxUL1RIA4MmQIQP89zHa6k
         Qi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvh9CPtjgCminAdNUXhLmQ2YF4S3S97zqijsC+iqyKh+aQSP+2GSXp+aqtov7nksGAfWLGDZLJoFBhBoGyvd8pmBES5qOTPteHBSDvIlQ=
X-Gm-Message-State: AOJu0YyE4S1pFyyOHaa4XhlsfqIERwemhH8EQFoF87rrS884v9tzlWO4
	/hPGIF1FlTc5FAoV+J+pejBqgo/1QDhgNFYXZG5S04cRFuoPSTFOFdvpfJ1dfw==
X-Google-Smtp-Source: AGHT+IHgkOSaePxDDnJHq1U7KDyApbljJxbvMpXvGQArIGdlvWKuaNaFIdtcRXK3XVmYMcGfw2r45Q==
X-Received: by 2002:a17:90b:11d4:b0:2c9:74cc:1c1b with SMTP id 98e67ed59e1d1-2c99c504127mr4043383a91.7.1720195467069;
        Fri, 05 Jul 2024 09:04:27 -0700 (PDT)
Received: from prme-hs2-i1009 ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a992c43sm3576853a91.30.2024.07.05.09.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2024 09:04:26 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:04:17 -0700
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: Dave Hansen <dave.hansen@intel.com>
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
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, alex.james@broadcom.com,
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 0/2] Support userspace hypercalls for TDX
Message-ID: <20240705160404.GA15452@prme-hs2-i1009>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <33874bf0-c115-4185-85ef-684794de3c8e@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33874bf0-c115-4185-85ef-684794de3c8e@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)


Thanks for the response, Dave.

On Wed, Jul 03, 2024 at 05:18:22PM -0700, Dave Hansen wrote:
> 
> Could we please be frank and transparent about what you actually want
> here and how you expect this mechanism to be used?
>

Sorry for being unclear. open-vm-tools is currently broken on TDX and
the intent here is to fix that. The idea is that versions of open-vm-tools
that have been audited and restricted to certain hypercalls, would execute
prctl to mark the process as capable of executing hypercalls.
    
> This inheritance model seems more suited to wrapping a tiny helper app
> around an existing binary, a la:
> 
> 	prctl(ARCH_SET_COCO_USER_HCALL);
> 	execve("/existing/binary/that/i/surely/did/not/audit", ...);
> 
> ... as opposed to something that you set in new versions of
> open-vm-tools after an extensive audit and a bug fixing campaign to
> clean up everything that the audit found.

I understand the concern about inheritance. I chose prctl primarily
because of some existing options that seemed similar, mainly speculation
control. Is there an alternative approach that doesn't suffer from the
inheritance issue?
