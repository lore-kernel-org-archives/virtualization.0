Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767C2C324E
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556723; cv=none; b=Spbf9AZ7MufzTb9wPU45CmmdKLEoSUPeijtKDG+jw3cPmg4TlRJnZokEQF+sx8wa4Pj3lYNMYynKszQf0+WNDmrOxg3SClZAJRVGss9dV3A3BtV7sp62er4xt5ihcm+P2AKqcOM+rpi06//tNJnK4yfoCJ7CVJB6gwzXlq4oxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556723; c=relaxed/simple;
	bh=llUOrd6g/HLx5FAhx+SUViFFF+wpjL4tX6AinX9dVkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjpbLdNbGJHESzIgR00iahI/fDjPvm5h85vBiKhc5Q1tTpgZ/1pnaMM2dcI/sdzv0/lqWAmi+8aOmuwxv54tB3BhxdNjTdnAO9iiJBp7vClx3hxFw3TXtTNJKu60X4+VDXcP6D4ZhfZabnyoEMp2BVvZlmGEJDI8T3wafpTATWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AEEh/kqz; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AEEh/kqz"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6d8751c88so659195685a.2
        for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769556721; x=1770161521; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8ffCxgqfPNNOI1L/bqqAX6TLyKV0Tim54t2cjmn71o=;
        b=AEEh/kqz8lIqi8ikWY49h4o19W/dKihl26dSquwG3ga0zkacv8JAMovpk0ha3vQ/uy
         FmphcWWFzibFHzc78VbBR2KfmbcwsZh2qnva2VfdQZTemVUUjNtgYYzVn7bQguedlD2g
         SHbI7isa3d04Ds6KswHBiUlC8HjGbPsy2PCs1s2jG6fL34cybOaubcM1InIa9P1b99Mf
         CmB/yuLm3XfZfPf4WhPi70PVGY37FttQhiZutWgJACTTpGMnVyFeX9JJWd4U/NannH3r
         jDpn7FlfluEoqu9brqQkC84dcENt9f6XIZJC1lPuLZn0A5kE6zu7J+miaYGiV6wgq8Ln
         iXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769556721; x=1770161521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8ffCxgqfPNNOI1L/bqqAX6TLyKV0Tim54t2cjmn71o=;
        b=rF2XcnG2VrfSRiM6boEi05Tc6bjZSAbF9AOYHBWS8UWLbt4k6rNxq8lvmAPO8WL0ot
         IJ3spMkN0juszfHm0yCdk5DTv7JzNXlAxpvNbtXC++rX6NnfrvaWIIsXsH8fFj4XCHNQ
         3q5QQbA3opJbrEWuG2RQfEc/Z8X0qr2nt8uoM/VOtFy70rekiZosUsK6CXNR8kQbc5i8
         yLTtB8Dz6kDPaTFj5hxlstZpjVlWtIaWUDvbKuk/ksaXjY/sb82uwkQ9U3Cx1lD05zHT
         RFHDRxWUqNLLmPjvd0/4aDAS6hAZitJz8u66z1oLQM4Bt6tZU8O61jTTKaE3kTNy8YcK
         7Mjg==
X-Forwarded-Encrypted: i=1; AJvYcCUnMo5V1alw1NogZWmpGqVSGcB4JQx8elk0+hqxpU0FDnJ8Epu/IYt86buzJnidrFnEGDuZ+nLPaBbPm7PIQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHdZFYECR7PpWuWM5UgSs0m9VoZQLdQdBaYOUcqB9oG+INGPjK
	au7Hgmpcr/p7h3ecIq3Ou05kl3+zvb+h+6GFoLeVO5XzUe/CYiz+BPKo1VJwjna8B4E=
X-Gm-Gg: AZuq6aJPY8F2PRd8NxB9am0Ty277G2adCNYWxY+vP0pfQKNA+L3whY3eGaREJfAfC2x
	H93xkV0z4u8jQ8Hqk6UNI3s+ZBc39g+8O1EqV+HK1j6M5EUu5vqNYIFpg2oN3fhEW1t6Y8L2aq7
	PA5O1ZyK0yiQgbaPJc73fXqrzMoFs+Nu5SaNyxT/ODMdqJmQ233Zap4WMqCc9ezcQKCbFIBDvQN
	0m+8AhTJOq72DSvmwVZptaxxbEMt6AYrCnUDrgds2zZwLnX4paihC4wOEcVs6lmxCS73TIQIC8C
	BtMLle3VLgwteQsyrUy87jQQzGVLQdTNIyemcQ3dSgiYLuKmVss67tB3rcY+HDHslnEBorbHFsP
	HtMUpDum//XB9bvNPKvU/HUDdia7pA2wojLjRc0il0rMTMJK4jptsgnkgZOYnzhP2+V8VM8duyI
	z70r3ptAXVjiTrnwxeAr21GmwYbhomgM/8bEAgqnr6l5Ro46OFjq6rLB61k/uG8ZA8StiDgg==
X-Received: by 2002:a05:620a:1908:b0:8c5:2f70:c62b with SMTP id af79cd13be357-8c70b92d7cdmr423216285a.85.1769556721349;
        Tue, 27 Jan 2026 15:32:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b98539sm71997685a.20.2026.01.27.15.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 15:32:00 -0800 (PST)
Date: Tue, 27 Jan 2026 18:31:59 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 3/8] mm/memory_hotplug: add APIs for explicit online type
 control
Message-ID: <aXlK74ZlUf76nBE_@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-4-gourry@gourry.net>
 <b3d435d2-643f-4dad-9928-bc7fb5080181@kernel.org>
 <aWfR86RIKEvyZsh6@gourry-fedora-PF4VCD3F>
 <4520e7b0-8218-404d-8ede-e62d95c50825@kernel.org>
 <aXLCAtwMkSMH3DNj@gourry-fedora-PF4VCD3F>
 <20260123182526.00005ee8@huawei.com>
 <aXPIGMVAvVEBgFhJ@gourry-fedora-PF4VCD3F>
 <793fb531-1fda-4de4-b73f-fb46444ca613@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793fb531-1fda-4de4-b73f-fb46444ca613@kernel.org>

On Wed, Jan 28, 2026 at 12:06:01AM +0100, David Hildenbrand (Red Hat) wrote:
> I'd go for
> 
> 	EXPORT_SYMBOL_FOR_MODULES(__add_memory_driver_managed, "dax")
> 
> (or would it be the kmem module?)
> 

it would be kmem.

I'll let the accelerator folks argue for loosening the restriction for
OOT modules, for me I think this is sufficient.

In the long term, for the private-node set, i think this might also be
ok, as the intent is to only allow "enlightened users" access to private
nodes anyway - zones are less important since the driver still has
a say in how memory gets moved there.

(e.g. compressed-memory is a demotion-only target, which implies only
 only movable allocations can occur there... so zones are mostly
 pointless and the whole policy setup can be ignored and the original
 interface can just be used)

~Gregory
