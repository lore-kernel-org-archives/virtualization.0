Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703592EAD10
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382580; cv=none; b=E33CA19DVKjOoV+s3eRYpMgujGHUIGcbe3FVL+HoZxEyTicn6wloRR3nvCfgi/GxVRKfpMI6D7bnHFqWwwAxsh9bL/xr63jBJaZsf1q3ImpFSp+1r3vWtEuRSRDkYIh28aUKEZikxpjvHaUotve64+tsGsyZUKk6tFmLCRmY8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382580; c=relaxed/simple;
	bh=DDJcM3o308lRznvcKXTlIS/CWI9gWk3xwBcIeYBXdjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeLd/hLGI31zBwiLO0XBxCxs6WUbOX2PROQavvDKONpqb0qv8EVJWixUh9PCJ4hhHkPvTAh0kTDyd9Z9ZI1TmQN8bdQH2ynCBId1DROx6ulLCw78GeGg3/dQv7ho/0SU/CfGw6RQeQJqdokigWKsw39Vs4v4WMg3NWYYYlrSfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/R07v7b; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/R07v7b"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7868b7b90b8so2931467b3.1
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382578; x=1762987378; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=J/R07v7blhN/L9fUYxhXl1hNgQSbt2MoNo3CpetT7J1/6TpO2ongDY/CxM7pkG2/B3
         WHxlkwmfx1ID19vAtR4n9VD4xfizafSTjCMxypBrihX8PPutXvTcuBzbiXnKVHRb8MFG
         m9VMNzE+NVC2QisPj8vRGkpDthMK4zQRr6lpuQh8vI4h7XLX5u2MUfAshoaMDRdku2gF
         1au8AgGOf970l1kSx3PUBG9/RkD8WLzP5vw2LLd6R5wx/RAWaCUL4y0m0wFgSCGKM0Bq
         NyCcdSsVLtYbQsNv0NkLTxVkegMbkSWLYVymkELz0JUnSqF2dfNXkxXYViDm9cqBipRQ
         dQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382578; x=1762987378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=ay2jHdRdd0aVO1faxPqZ5wGF9TDQPSHuPVC8X72rJ6a3coNrk5NVZ/deyrg5nGClKr
         HvNsvIsumtFa3nw1mIrtlasOb3k6x0pPr8kO91UOGMh8WlvQK4o+XeMrieYPI3M6LB/U
         2icGmrFNgrsJxdPEbu4eSztvk5of+T1V+k2ZA3i1B756A8fNwMEh0in9w+W0WOAGBhbA
         1ajNv35OEUubzjZSOsN8NPfG3k4G0H+al4c33vTymCz0KvbE+avomfRtOks9juH916Kt
         CJDkQZQmJYGZcGImojPzDU7ya/uBnKFervC+ZEVpWBY64/VGQgv5CjzLaNB/edzVn8OQ
         tEPA==
X-Forwarded-Encrypted: i=1; AJvYcCUEj4cCcyRYRpG9HfsNlCr+XkDVhAvXs6LOYMH4Lj5bzSQN+x3VhcHNQWci1//TMdLCQDxvs3WiaDEwiBnLQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1Jhub+Zaqj/ZN/wreifiR7XlZk9oX3N0BUI9dAk8KPTotmXnj
	wAgKKkY3TkPXaOxwxIUDTuJUjvbtOV51uJ6Gy2soHzsYooxDhdYX4q4r
X-Gm-Gg: ASbGncua4uTEBZCcR7Y65t9i/Tkc9f3SRJzeLNSpROaaJBe+8BNpvsnmk5OU2IVYQob
	JecY+TFg+GNtWiqOKPbh423jHCcVJnMqSSeuHvZOVfKDKZSPLuy/XFfqIpzCRJ43ILg2GdXchf5
	o1Ad05+1IeAL64HTeh/MSzrQr9BzoJ3aYoUrjkqXlCDxlc4XZyw8GyEVmcBLY0rQimBR6zb2evD
	MYLiJ0UVOgkR4lriMvM2NjqxEA/qzkCGQK3ayQV/lIdC+yUpVD3M2w1Ime95ta5CLKk+dGqIrS8
	O7KZj9w0s48S4bPwQzNda+iHQ7b170Av7ecqFL+jQcojphVDvx2hztoXBdzwHGPrmR0/jvIJOD+
	XymhsjNlvfpbOU3AXjNhsftzM/gQrvYoOHZv4IPcTEboG4bYeJF83oOXwyYL9GtQ35M7q8qV4yH
	52BmradVSFSMeZ+WskdPYqT/7a5rNudCto7EFD
X-Google-Smtp-Source: AGHT+IF4bH2tlcrxAWH8nMgSsZ+oa2FDYqK2kFDiy/QWN+ROxEWd8z1LH772DutB9P2i6rkfAV9wfA==
X-Received: by 2002:a05:690e:4289:20b0:63f:9a63:46e5 with SMTP id 956f58d0204a3-63fd34d6705mr3657566d50.28.1762382578383;
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b160e761sm2705947b3.57.2025.11.05.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Date: Wed, 5 Nov 2025 14:42:56 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQvS8GdzrfhVOhgx@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
 <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>

On Wed, Nov 05, 2025 at 03:32:18PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:38:54PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 

[...]

> > 
> > -trap cleanup EXIT
> > -
> 
> Why avoiding the cleanup on exit?
> Should we mention this change in commit description?
> 

Makes sense to call it out. It's removed because it just isn't needed
anymore (vm_start() callers now all terminate and cleanup the pidfiles).
I'll add more context in the message.

Best,
Bobby
