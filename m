Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C92367BA
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370647; cv=none; b=Ru8gKqs9rp+tK8glhAFEkgVvWPyi3z0HfK2++NfrA7DjazB6S+gfUt87b2TMHgGCKZjlnuuoVIV8kaTZraZo/d0pZ+g7gUzsgEqTIQit5p+WDkJZGvUYumAKPPFKsYd7QbLK4pc1ABmSaes4YT4xuLRimJxeb8b+3IarkFZgYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370647; c=relaxed/simple;
	bh=z2ZuAl6m8mQF8bCGTrIOO7EDrjCj2YFxDmYFrGwTZ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggnNqWMSHIwYgMkdg4HFmaHK/FKncjVmwm33nZ26hHzVXgvaOqPmZjDEmC74+9PZmHaIb1Vjno9jsFXseRuOhVHbmb8RdMA8uWdxjw7xUCbOsthLhsP/XhKw7YBPalPQpfaft5sbEdYlZvCNg4AmTsvjjeWHA13pR4xo9deyolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DonHrQQZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DonHrQQZ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-781421f5bf5so1422517b3.3
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 11:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370643; x=1762975443; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=DonHrQQZZgrPf6QGobRk8nzmwYr9voG4ab62rwFQWQj8XIR6/VLWA1l6KbBlaHcK05
         XlURIvnuQOrgH4dIpoWlxzss/KrhpuUs8N3axxSHjN8ewPdgOxxgj1ByQ177FETBphf/
         StN4xWD9XplWatuZeXVm6ryq9wvLmaMu6lUqLTxs/8w+R2MgHQLqpiYChVtB0sGIzuXT
         81LBEy1RocmOr5wig7PQjy3CLHdiHQPCHGXqYAPGqyIdfS0duLa5zWPSImlowDJ8I1k3
         h/7PjP0KtZxrVgqGx6J1+J7UtqclHdbk+k3WliaDx/TI13JsYk+qwMoFT75ee0dHgxWE
         1rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370643; x=1762975443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCfZbCx1ZjFQUpQxhvpq9tTfc/hY+795vC8k5TIfi5U=;
        b=ATuKof2bnNElHRveNcRga1QnL5T173mLEgX4cDetfE1vAJ/ShNqmauvex8Ze9MLvcj
         nL4YeIXskOfaxLRyAOYIgk+7QpotsJieM3RJlgRM4s2kTbsw0G3s34q2UV0L+oYI7aAB
         BPUL0ah+kasWx3EybkLrFQrMqWFaZOGFTv7IXEMTy084yo7T6TmvWYsl3CIENJoCdyvG
         z3A8sH4g0e2KjFCMiO7H2yzTdOEtI9mbiEAwJr8U1agK+uhQpmbC7/hLcmVRLhX9Lpda
         YXt9zpu2gD6zJg3g0EsGLwfp0Rc8jLlyMKnIgVLcPWhH5h9C3aIeL0tgyjSuBT9efUXB
         UbOw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Bw1wRmEnTFYEgswl7OmZlgC3vor+dohYREuOvp0r1D4ViljRujUJSgfXjFCGx0SAma55CkQl6HJljm+BLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBReYjbO0Dh2Vdw16IWd9zLKIFJenV9URF3v9w7wJsQqavAbvh
	T3e6jD0A9wV9i7LaI3y4HsXYU+xUsoQWVbKwUaPQ12r8Q8ynh6nuSUOR
X-Gm-Gg: ASbGnct+E7Yjx+myRoyjjuspP383HQQSNtQ5NthaAmF+bdfzTzRI0fUZuNWUYdE67AY
	OlpRnjVGk/FdgAbCkzySpgEmzwdoi+4YpYNTZvpuOs9rYh/1CAE9DGUuGFNVpmOTT22aBJhoFeU
	GqDCUusqWQrWMKkdjmeYTGeOpjN5Epb0IEp76mJZxLFUeZGmnCR3HkgXSwZIW3uYuim4SdVjaD4
	r/sn3Neld8wAn23ZqOISCP5d2tpnxfMr9knjfi9GhKeKE8QzfNfrC9J18M0CxcZ3d2advcWMxaA
	qJQfFdqoC7/942XBhm6I7tBS1ZwQYhqmojenyXaaH64wij86z9fKJXIyrSsDYtQvuaUs1zvaxyG
	O56naEm2+G5bYidx6lFVR3m81eSDF86YsVTb1qyeYcMeBjI+/9k/g+3U3qART6j8tqLe7LaYrII
	EtxWvMhFzMU4HfoA32IBvuHmFfQdkjkhuaaKTu
X-Google-Smtp-Source: AGHT+IGzkMph0aR1AuSLsLz+NyiUmW9UyqgkXIKscDfhGHTikd7KQOHT6TykmLaTJLeIJUZrZX00oA==
X-Received: by 2002:a05:690c:61c5:b0:786:a774:e415 with SMTP id 00721157ae682-786a774e5d7mr54395367b3.56.1762370643208;
        Wed, 05 Nov 2025 11:24:03 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5ca403asm61413d50.8.2025.11.05.11.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:24:02 -0800 (PST)
Date: Wed, 5 Nov 2025 11:24:00 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <aQukUFyuN+iJ1zv9@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
 <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>

On Wed, Nov 05, 2025 at 03:48:09PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:39:00PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Testing with 1.37 shows all tests passing but emits the warning:
> > 
> > warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
> > 	The following versions have been tested: 1.33 1.36
> > 
> > This patch adds 1.37 to the virtme-ng versions to get rid of the above
> > warning.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> I'm just worried that the list will explode. Perhaps in the future we should
> just define the minimum version that we are sure we can support and the
> maximum that we have tested.
> 
> Stefano
> 

Sounds like a good approach.

Best,
Bobby
