Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7C2DC77D
	for <virtualization@lists.linux.dev>; Fri, 23 Jan 2026 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129029; cv=none; b=K2a7V3jZGk4wtNB9zLFJHu5zwUd1mRXfMqNi+yEFOvKFmOa/e8Ln2fOO74PR5zhd3J39KqvBH2+emlVn1AwNw7mjWXuLJSPRbswx+eTNaBVAk9D0jsBvw/TikAQBqtgCk6lD7iCCeMVABKH2imB01QVWjguRNh8dYr3QZoJatDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129029; c=relaxed/simple;
	bh=XGJ8do6DqiSNmZPIr9zz3bcxbAKjbH/slyEIBawIwRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYfhcYtTZw8OdobAz7O1qMeYrExYCLLLnkFgMqG1sTSybPYIZsthF/ibnxKd/7wny9/P5u7glPNPf8TfRDbPTmQV4T2KFQP0GksVS1hmxJgauUsT0Ci8QglQD+nOzl9OtK4sp25bFGSQiPZXqc1EO0hly8ft6KUF+mt5cAArC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ds+3xSJX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ds+3xSJX"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89473dca8aaso24514246d6.0
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 16:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769129021; x=1769733821; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfDbc/em5bjOki5V5/p4q24wfcBoeK7m+V9bweSJP5A=;
        b=ds+3xSJXqjA5uKFz6PpzyEAghhuhWrbwnZGIaNikW9dL36wcC/ahkVGyazDpPSr+mo
         GZ4DP7buPsixk6uPF29b2DNApUP4wPbjoZWJbeOKyt5tmN8utbHMnQWXb5GmY1nvgVff
         PKLAu3xGfLATGEF7JtB4TtxZ8Nr0NRaNa5JQeyNmvFgEr1y0T8WLWlEFIossYsqaH+lv
         BLOx4x/9uUQ0eylf4C2dFNgj6lD+nKzi7w8AO/P9vVMbO7m9VakmTYP8T8c8+iYl3zF8
         oO6+SnOjVQMW4PN+dn3zS2VR1cfVWKBiq2SwBo5ihamo6z3D0TzAy9WJHTpR+2+ZDEAJ
         8Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769129021; x=1769733821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfDbc/em5bjOki5V5/p4q24wfcBoeK7m+V9bweSJP5A=;
        b=KWfOpPsbJtpWQSqfmMYEGevsFdRJ/6/28Lowmw/GN1xlXAWTZseCrhEmHt9vplreUk
         VqoWlWMdgSzWMbFoKCczcmUT7D0+gal5yGI6MiiAuZDxWVsicQqpdhz63KaZYgObsOtn
         hfJ/Rc0+nJy4jVPanirskS7CLh+iikJPn0Nn8p+FWbLH6xjsiO9wFgK+UTRr2s+2tyud
         I0AxIj4e+70ewCPAce0VU1OxmyGqQ7QE9wDEqEli9i/oP68pRwPy6wk89rylf3kAzI79
         vPtCpy9qKhCXn9ZPCAwGzg+1023gRqNjTPHJ+XLWNycFljskuEqvz3T/Ldclh1XAjPpc
         ncOw==
X-Forwarded-Encrypted: i=1; AJvYcCU73PxASkJXUCDv3NNx+B6ObeGBXWJZNwwKB/0ZLD937e+mvQUiS4OyLWI8zwhyxOLBbercHQKICQOWUhgl2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+Kj06cvKN+IJu5FMu2xPisppB/aabUdZlCdBF00boqcybnX/H
	7B2yqQYHIYIl71fjNW9vb7aWRHc/3aRHyjD5i1n55T/NOY+77LjlkEyWCpRzMrZ9Jgo=
X-Gm-Gg: AZuq6aKGg+qCna15WocIZedDQ33IXn/Ci5wZxXgVEOOyZ8ae50vNO685OS6KPs+nOsn
	gzyWGpYQpqUF29ocmS0GAYLjx7ShQbst+cT8BdMwkzmceIPHUq8B+3SkoeMQ4NcH+2OlpxZ2vfW
	89XKThJxO+t7U2SoNxsgYYr2tt7JGz6vcvLqjWIjcTPCvyfDn5K5mEvM3XuROwm0Xu14L89ERXy
	J1lFT1c912+uLSPsEaHNHAEto1Qc040B7uJ4DP8Y4Dw6pEU4rDNqSm0R3Pdm7HPBARQn6LeOrqK
	v2q7R5TlH0/VuVOJpgwvZNtIarpPpPSLZVAQBig2500Fq9g2HzPXW5xKxAoVVTJa9hHrAWc+EcK
	P7RjOX6FpM7J8zh427Bq3Lu0eypke3CFhDMDALy+aEuwnQitq+RQzAmAwLUQANOQjBTIZ+Q3nxf
	kXp+AuA1cHT5Kf4GASwU0L8NGtY1IrCnNKJEmkD8jyXLs2MLYky8gneKnVdUFggo2HbsuZAw==
X-Received: by 2002:a05:6214:f2a:b0:88f:d4b1:4c2d with SMTP id 6a1803df08f44-894902209a0mr21597136d6.60.1769129020746;
        Thu, 22 Jan 2026 16:43:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491853478sm5521546d6.25.2026.01.22.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:43:40 -0800 (PST)
Date: Thu, 22 Jan 2026 19:43:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 7/8] dax/kmem: add sysfs interface for runtime hotplug
 state control
Message-ID: <aXLEOjgVyGYAU_zk@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-8-gourry@gourry.net>
 <3555385d-23de-492c-8192-a991f91d4343@kernel.org>
 <aWfcYjZVrROHfGyh@gourry-fedora-PF4VCD3F>
 <57c5f44f-3921-478b-843b-877fae536591@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c5f44f-3921-478b-843b-877fae536591@kernel.org>

On Thu, Jan 22, 2026 at 11:49:48PM +0100, David Hildenbrand (Red Hat) wrote:
> 
> I'm merely wondering why, in the new world, you would even want the offline
> state.
> 
> So what are the use cases for that?
> 

I don't have one, and in the 5-patch series I killed it.  You are right,
it makes no sense.

However:

> Why would user space possibly want that? [plugged-in offline blocks]
> 

I don't think anyone does.

This is baggage.

The CXL driver auto-creates dax_kmem w/ offline memory blocks

Changing this behavior breaks existing systems :[

> Can't ndctl just use the old (existing) interface if such an operation is
> requested, and the new one (you want to add) when we want to do something
> reasonable (actually use system ram? :) ).

I think we're in agreement, I think I'm doing a poor job of explaining
the interconnected issues.

summarizing the long email:

   cxl/region + dax/cxl.c + dax/bus.c auto-probe baggage for
   BIOS-configured regions prevents any userland policy from
   from being plumbed from cxl to dax.  There's no interposition step.

So yes - new interfaces would resolve this and the old interfaces
could be left for compat.

~Gregory
