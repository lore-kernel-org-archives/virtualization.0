Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EE78F26
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752464369; cv=none; b=h/q6f6dHuKTXKGK790LGChrF+yDkcNMgRuAi635P/Bsa3zhuOUvubZgSbg+SdfLwMydFkI1wZGOh/+zp1+SXxdiYrt6yKwuA4O2CWHYTKS6eU84g6c2sx4ML+FH45ZN7LVZ5wJy+yxSICEwJiDOSD0NMx2MZUhGvudikM6zqdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752464369; c=relaxed/simple;
	bh=9yw1cM1JJ8Ap1pjgj+U/AwSkrqjRXzvfTo4MgmXrsx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzIg+wVJpkrn/xwq46VjiTX5HczxsxGm8KnH1dN1CGx1bGh/zccFGZfZUjL/Sn/TtKpm+D/3Clddx+gYUMrA2Tt5EFqLFwWA8xiG/xPy62hJNe7dAOKKgPbRYbbiEBX5a8eKYlHMvlV82G1bkEXdMDDE+kcp6zGUvOleRWFYUow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QiQnqxJD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiQnqxJD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234d3261631so29863875ad.1
        for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752464367; x=1753069167; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+6/k62UI4QDNnsPMaNZviv8mxGlHDTuu2KNG71R0NE=;
        b=QiQnqxJDEdo5c/2nWJ1p2AyxDcboG4e6P4iuq/rURxK6vi0WnwqhS8IyeALybaWOAs
         K7m/ShV4pTXhuj7+gdV1341lKP92YUIqvXebe0xKUwyiBzoKN1P26fyLasHqtimPJtQN
         4EFO+kYu3f90FPnaACY8HiYlQHeLad5ey54aR56U97K02Ud9QRsCecrs4xF+Uid2ocBy
         0Y79eMfK2Qh+dG4OAVSAh5ELgG0g4aAkTjYVPc5YHaZ++Mv1Q8ecehK4zUq0IblymQ/x
         XkA2N/zUADqTc/nv4f/AYlkYKN1100Fr24iHhCg2tLD/b6MvA0cRnLZ01T/zwIw0BrhA
         oDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752464367; x=1753069167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+6/k62UI4QDNnsPMaNZviv8mxGlHDTuu2KNG71R0NE=;
        b=DqFDLQ1mtTI9fSe2n8e6sFWQn5eYpjQY3dP7eHfceclQA8Pj+2rmHcfdRcqjFIVnBh
         CGpLDqtHpvuLGrapjWAvK9VjXPqyWQKlXQqQcsDXOAKxxCFHjVdREohmyQBI97mF/0HS
         NAYYxnoqHeZokmUwaMMfW2HSV6O6cwfpvLdfWzKoypz9SbqCMEk2H6nSlS10VOFNqOSP
         VUWgTPr7pzKunRF4xzsOTOj+clmaWaw0CGPFLEvZ+2lswn0MzvY2Kky1l30oNIAPysIG
         ANpZWh9bJXTcGVbBSRbwWCnO5kkerjL5j8ljSxl+QASmVi93QihfdPj6bRWO9rFGQUGX
         /Ccw==
X-Forwarded-Encrypted: i=1; AJvYcCU0jgl6OvqyNxZ3udAHELhiRzqhfUp10yD9iAmLsS3AIoBEu7t2eUccAbfmFstAdxl5HLdQeHyDyURf7ObwNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9SC6N3REJNTVbPct+QgyN6qSSMjObhE+GPKAyqFEr6xufovxQ
	2sbNObmUPdV+Y1p26jD1rJo8btvh+ZPyfL6Y4E1wiE1eTFVfeWqbbsowETIS5ykVf6k=
X-Gm-Gg: ASbGncu8RFlHszVWdV1cSpQ4rwhbvY46yTVDWDar54SRaKb6ukn4z92gTQifLhYg4ac
	gosz+qmnLVmRgYP4eHkdIDTKfgl/aH1C3nKvF+3HoSByUE+j8yqq0WAPRXZeMHDpf6qGSBK7LVE
	rP3jHVaXUOyg5yKUphOgoLuX7BrT4omEY/3KgbmZlsCj/kJRDwRy8mG91nT0PdQAXe3POf4z2gK
	AThDN/9H/+u+goQolaRDaLFsxYR1Qt5y8DLKnee19B9kWE2LQJivRi+UOOUKud88oHqLptF69Hm
	XKBS7Pe6Q+nTQnWpP6RJJ5UvnHBJOns7I0Aph6uCjIjMq3LdKSJDJ/4xNKvUjxwMBgxT2LpQ9Om
	JX/XzhPE5ns2CRIpN4jlDnXw=
X-Google-Smtp-Source: AGHT+IH2g5qmc9RE+Cl3rwDnpBl4jF0vwTsbg5rxmEj55bIQb34Hr8YQz/Yx4gWK6dStNBp+qFIREw==
X-Received: by 2002:a17:903:a86:b0:235:91a:4d with SMTP id d9443c01a7336-23dede58855mr153362665ad.23.1752464366767;
        Sun, 13 Jul 2025 20:39:26 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b0e04sm81449905ad.84.2025.07.13.20.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 20:39:26 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:09:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: virtio: Avoid hang by using interruptible
 completion wait
Message-ID: <20250714033923.uoyehav3sbcb3rqn@vireshk-i7>
References: <b8944e9cab8eb959d888ae80add6f2a686159ba2.1751541962.git.viresh.kumar@linaro.org>
 <pvjv6gn6ylnpncdp5xdzt5wdnzc2tuuww3ihed46q76vm6qwly@7smel4x243a3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pvjv6gn6ylnpncdp5xdzt5wdnzc2tuuww3ihed46q76vm6qwly@7smel4x243a3>

On 11-07-25, 16:51, Andi Shyti wrote:
> Hi Viresh,
> 
> On Thu, Jul 03, 2025 at 05:01:02PM +0530, Viresh Kumar wrote:
> > The current implementation uses wait_for_completion(), which can cause
> > the caller to hang indefinitely if the transfer never completes.
> > 
> > Switch to wait_for_completion_interruptible() so that the operation can
> > be interrupted by signals.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Do we need the Fixes tag here?

Maybe we can add:

Fixes: 84e1d0bf1d71 ("i2c: virtio: disable timeout handling")

-- 
viresh
