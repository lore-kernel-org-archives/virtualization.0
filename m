Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FC2D6E72
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588101; cv=none; b=SwUiGYel/3nhdZ4VXcSw44/RZGee1AlOkWi/YyITzc8eyyNKzMs3q0JyIEZwOM0/4Q+yKB8lgTk4394CDwTggz+zZsaYIQIBkBYp+ls6/rjGLAmbe0lnPIOz8O3TR6HNzg2dvH8oOdt2nZSWgv+A3zvrqixZIT9NOccAFoNVzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588101; c=relaxed/simple;
	bh=F+dHEiFLnh8A5KzJ58bksVScGa0jeuzf/tPIICsdU6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuT5ydU0u8Apuy6q7x9kxIBZszgn2NgtbuVQyWdsQgKUVQ5qGM7Gk4pYhmp2BgJrbBuMiVW4TC7tPFUDE53EpzO55tAQVqWSMYuj63sKD0XREnis/Uf+4qPT+fgEskQ3V/wP6PTM6CuH3Iy8KyvxxKJkeHdcFY39hc0BHyQudXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuGlm+lo; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuGlm+lo"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-73b4e3d0756so50275337b3.3
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588098; x=1762192898; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiovYXP3PtaA9Kfj7XU3nz29JiqSsYJIIOo4G6t3ivA=;
        b=MuGlm+lox/MchlJMOmjtfpbeHHj/WzJkvqYv3hpWwVaJzpWfwQAVXVSp86qYjS79Vy
         hicsSQ5JldrTihZE8hajgKV7N39EdQRNIz8I2a3uMo+p+aExZlwjd6MkwB6JuxE9cj47
         MVaauP/c+rDOUGOlDgZRxQUHmce+iIQQJM4WnGwMz9lZ6j3gCURZuZlIOiGqVQQvwzMC
         SBZ6CK0cUSirRr9+gyCXLJj6Ex7NGWvtObb5V6ZFM7DTNgjGRzF4Fv5eY5C9exGc0THO
         9XxKJr1rzrD54vrscgSkpUtGiryhUT2xHA1PXA+M2SWUr9v9Kls51/mOImP+BEIhYVJI
         bc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588098; x=1762192898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiovYXP3PtaA9Kfj7XU3nz29JiqSsYJIIOo4G6t3ivA=;
        b=EBFA0YoBZ6yq1u+L5/j1gb/yd9D3r5WQHkvbhYsdSHi/gDks67euj1X6yoKrXQ0lm9
         MM1jon45FIID8Gt5nc1qd8OeNnWqhV58Os/9yaahLWJ6spFZuqIlzcpecLff2l3In7Rc
         Y+76d3KcNNdble6NV3jRaFbeOcAKUyuZs+OyhSdf82rH85ZMEeLm33n4Npa/WTd8M4Yx
         PQIbZ71iRm5kOhRvjr+GxA5Mh7SRtRdkAYk3357UxwB8RvzmZpKpbp+xMzSfzzzOnMip
         jfHNBWr1Y++tQtBMeMde5idQZLTRU9d9euIFzdH0qMiMjSncWNat1WnMWtnlruOTp/Zu
         fYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVlvYZaYSqiyzieLAjA0xHu8X8qqdrO/Fhup/12VS7HkejJ7OOh/HhkpugvcaTXXmmZubJKblCP7ABCbNEAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwUo5tWt8s3gn0xlt8NGzNXSi/En0+g2RUwoQ5HYUrKoouHK/t
	mjaGoUXzNbkIr/c8fQGRcZwsiWt0N7BlnqOLhW1X2NBU2rXpRicywgeI
X-Gm-Gg: ASbGnct90wMN4OnlgoL2Lll6C+259778S3LE7n6FNNV/NlKMei9HqBc/vAcTwstEffC
	sXrZQnhG56gBBJfOOjF8FtLcj1Bz1zysJk5Zyyf3sZGGNjzTZWKWX7XvIa9s8DX2P7aHxoDRlE/
	/aTqiOAV5M7p8xVYD7Uc6mDxCPU+pEbxN+iICjfnUVLgc3mn7P+WxycGGSgrS8qzpycPmGHzrq8
	v6UfTXfWBDtH3+H0RNmEoAm9Wj4H7DK3swpqimLEbqtylHRYYQ4+3Js+9FUwrkGufkhZnkeiP7R
	PBcFum+DYD1GzkBxChaoOueE3xjrcwBAnwpwgcjfO22+aEqpfwbfSTmEM6eO183UZqu3NW8OT03
	A7JnbncqT3imlWO0w039aAPoyA5re601dlQdE59kDhTF8VtMx19dE986hJilHXCfmVG2hwCHbdJ
	VVL6IAWTEPdeSn81pFLbAxK1C/2b2lg58jtVV+
X-Google-Smtp-Source: AGHT+IGY7m5xCBIjhFzMJJMeIr2LMm+2g2vwUGpyuiJ3FoHQ+eVB5BYIwqC2NkP1JlPdGSmbLHfPDg==
X-Received: by 2002:a05:690c:ec9:b0:785:bfd8:c4c0 with SMTP id 00721157ae682-78617e03ba5mr7395497b3.4.1761588098317;
        Mon, 27 Oct 2025 11:01:38 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1c875bsm20767397b3.46.2025.10.27.11.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:01:37 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:01:36 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-kmqhvo4AFv1qm@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > the vsock_test binary. This encapsulates several items of repeat logic,
> > such as waiting for the server to reach listening state and
> > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > from hiding failures.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> shellcheck has some (new) things to say about this patch too.
> Could you take a look over them?
> 
> ...

No problem, will do.

Thanks for the reviews!

Best,
Bobby
