Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BCA32D45C
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592136; cv=none; b=sgYNW/Dk1s1ff1gwMJQdhbD8hcFnLglnyTzTqeKrU6CFBV6VlWQx8gRzewOpnkCFtz8bLpgsKES5c8deVuPCyYo5SP7IDb1KDKZ0RyrcyvFU864eHKCX4KjkQc2zvpe1wJNa0EvVFBew5coYubQoqwdpRCbPb1H/P75O/KQ1Ab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592136; c=relaxed/simple;
	bh=LwAmk/7MTnIWI2oZ7HDPyu3lp0S1pBrNDG9x+kH9r9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1IR0KqGPMLIbLJSLVE1dJIMqqc/LE2aI64575PrLYFV/56GvD/Uk1A3o1cJ0uLmagzyhfjw96SdXPfOb7gxtlid1r5t265ezdxl38hcTe8DKDFhfyFguyTvX6gXWMdDygy+q7AdD6Cd/Te49geXSJJ2AnJFLkmyot0ccgX+DNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ7xYs4w; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ7xYs4w"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63cf0df1abbso5698753d50.2
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761592132; x=1762196932; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBa16o2HS8qCHNhSfYkAhXZ4L9FP6XeHVGIquo4j2vI=;
        b=WZ7xYs4wbKR3zYWsaR3m7NiLbLR1wXG3ngEBX9eWOxDeh7O3VX3cqYWUzEvedfQkNc
         L5Blj7/nR69hZ1QlvRROzznCFR1vTpbQwElUZPD5bWQcp9l4kj9HMQuRciTS09JTHtKB
         uf9bG/91pD3T2CZjbuPk8/lw+yGT0o3+O1JlLnQyHIILd9ulmrQYjytkpOTdW4hyB4C6
         sriKf+N0+2AX8DntfrXRl3uk/jkEwf7JRbe+VA/St6PpjWN/E88O7mqm6DV+CG+Pwtxc
         v5qU1dRdlP+Twp5qtuM12Lk9EEjur5oCFb7Lcs1KwBOZtdFMMJP2MhTKjNiGhXTlUyDE
         N4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761592132; x=1762196932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBa16o2HS8qCHNhSfYkAhXZ4L9FP6XeHVGIquo4j2vI=;
        b=PwgxckreG+vExZmbO9rbRMJ21u2tfcvWlfrdJ3cSlvHTeDt/mIYTxBNzOhHrejh8GW
         XgSyodIGJEluNlkXcHIjuT9ZmnzDEnjL8RweYO8tEWwfJpLPX3J/KJpMemeQh6CB/OHw
         8cm81ARCmhxu+3Edy9ZzAP4VpM04ighZn6lfnMnNy9cYtRZzHYJPXFSv53Kozx8Z7mXL
         xQkr6jGcqMEiOcx5XJV0QO1yEhKbjbmR1Kc4DtPYvRP4A3rJZi2vmHpHpyS+4IDxJEuK
         SFLP9MmaMedirj38n1/OZWz5CheYbOD1cZPFL0roeydlscsTWaPa0qCMbbeBlh1NaeJE
         PVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUClRjAM5cSHDA11Aqvo0HC0XrFEw3/rOBVtxqHShRwIxf+Cl0aGWYzD6Ykxfch8Or2v8I4HrGIdbDTv71NDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmKDNu1yUx02pHDZkgPonvLkbSwR5xaFwwITf5I0fohwhc31uE
	5WpvF1Xw3Z5rz/MFmzZIDsv2qP62JWRZs+D3BH+YUB2tAV4LPK/ALEjv
X-Gm-Gg: ASbGnctWOjH7eN4y60PUyI9xTx/RDolk1/eMdBZU2VU/RaYIwfe/yB3hl7QZleDnxKw
	m5+k2GzGDhGHU5I4J3jVc/+PvyYHYjsQImEKnT1ceg6s6JQ1w6IAsB2Av0XaVisafmgarlrU5dF
	xeaBrPtmPlA6acKhkGhRJhplt2wZICCn5Ekh7n1Wj2/x5KRvn+k1BYdb4ApPI8Fi8hBOte9lbkC
	GLY8205KcPtgW17bynerFu2PwLYu98Gxftm/IbWZrUsj1rl2+kQ2kRRwQpcPDbinmaCtfjlUJs/
	w5gL5L6gwQBg59hBhpBsYgagPy9xGAY9jx3QaYENh9+SrAB070Zd8K4N1XnlbTmIYzjV0OkbiZI
	0oEhVhEBSlzrhnX9LQKS+Bp5qeVy3TDrwoaxUwNGNHRfcjr5D/CEZVr0expLv6crZTy0lkLiDnv
	uT8LuBca22RFwodszOS7RgOOtWwoW5NRuKnnCeeEFaEXMjH0E=
X-Google-Smtp-Source: AGHT+IGyyVhNMyFPJ1iH6VB3LobfrBQTkhvZ12vnfHgjuauZlHjFnodUEDbnz8J1VMMlZEjH/eQK1A==
X-Received: by 2002:a53:cd41:0:b0:63c:f5a6:f2ef with SMTP id 956f58d0204a3-63f6bab5662mr707347d50.65.1761592130958;
        Mon, 27 Oct 2025 12:08:50 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c441fe2sm2525648d50.15.2025.10.27.12.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:08:50 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:08:48 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>

On Mon, Oct 27, 2025 at 11:01:36AM -0700, Bobby Eshleman wrote:
> On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> > On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > > the vsock_test binary. This encapsulates several items of repeat logic,
> > > such as waiting for the server to reach listening state and
> > > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > > from hiding failures.
> > > 
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > shellcheck has some (new) things to say about this patch too.
> > Could you take a look over them?
> > 
> > ...
> 

It looks like the errors are SC2317 and SC2119, but are false-positives.
Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
being passed zero arguments (logging its stdin instead).

I also see that SC2317 has many other false positives elsewhere in the
file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
unreachable. I wonder if we should add a patch to this series to disable
this check at the file-level?

Best,
Bobby
