Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EC34DB4B
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737343; cv=none; b=kUE4va5jJX37MFYOCq5fkGxwBS6alpabr/rsFsY+s318xv4TqGzwCK/0iA5vohIoQ3GHb57jbaRTDDq65d6gWqSG8gXkQy3TtpiuQrdIkFxu42Xzdu7VHbqssUsbcq/LW6Id2NUYuoS+/80VTwcaVCYAh6gtgRyn26FanRy0wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737343; c=relaxed/simple;
	bh=B1SonV887716oesm2yPOqphPLINTjebEH4V7kipGne8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7/Nh7LG+2hUyzTYlNaZ1PI3xKfl5wJkugnKMD4FJnSnND5kcOJMjBkoBTphFGXbEfogGz/+miGSxL2vnF+xDGWG1dWSiFyksJQNm0ai91mQHOz4NdVVSawYmNakE0Y0fd+ALKXGunBeP1gBUq75tSMOLSlKGwlPnmJzoGt+1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I5zMxZ/k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5zMxZ/k"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae3a2f6007so44770995ad.2
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773737342; x=1774342142; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjrnRLDXHBwFdgbFPJ5wbch9uelKKkj5QYsOf+XR6ck=;
        b=I5zMxZ/kRQk7vgWzYP9C4658GRt4h50cVbnEiUwX6I8qk85myP8yd/Rwwpm5Pc3iAY
         yfIR59RcLj8KvJS9wSEFxV2/WbBUHXB+RZlA3F4EXcPC0Dnp3vPSM8JtpFUs6SawHa61
         Zz60iDo2lZzxOlt+fIZUypfiWygVEB/jQ/AfmokiW5u+Um9VmLh1TjzvQPIQae3ee2rW
         Vr/nmuaLWcgVbGoFP+j2CyJ6TREOLNYGRiXubp9nbnqTf3IixC0/QhH+av6jO+9PX+ux
         3Ik4MzSMk5Xej/Z6cVyVKU5Wg2zGR8l1Ny2kFQQhG1TxZxM0lvTaNpU69uz8tAUTuGiH
         rIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773737342; x=1774342142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjrnRLDXHBwFdgbFPJ5wbch9uelKKkj5QYsOf+XR6ck=;
        b=W0NYhQNKJKesIoNsaw0VsyS714B6xq/gDJqsqdrTGg08Bu1NFgcWrhtwbYxUvHRSQL
         06LPvoMbhtesK6rG22ZrrUyNI/vWKB8DW1ZycT8baRqSO7SuAZGnmZyaZmBJPtQ1Fk1n
         twKt3F75RzRfhlYRCb6vwij1ypdAMxJ/UyQVOGL7fpzRbKS9yttNOdD0gPv81vyi5Rcp
         S7KPM+bWbb9hi47KPh9gSGeZz3d0aztcpRWEXSfyqe/IAY5aHqy5e+HjdfNwnOPe2ccj
         6zV7dgLCn+KgZ3WhWiThsD50Tk2Ys9fF8TVClb/kfVmybjaadvdcIfBzH88l/u8oWfD4
         dkuA==
X-Forwarded-Encrypted: i=1; AJvYcCXw1mxCui5AVAf7ufDXoyTsa47nwSwISvTxGEUqrmRrsLfQ5RTFiPauK5Ci0FVI1OpV4pUQ4wRUcYvEpfSrHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2gAOVxzx0PKROGMHy8vRU1DLhtVc+QGrsfmTFqoM7OCCSr6E3
	bpG8VTaFR9Nf2anmuwPx6FcxPfZnXMeVMg23sGroMLDPoDm2PO7UwpD9c4fBhi0/wI4=
X-Gm-Gg: ATEYQzzuqY1L6kto+YNX+0zF6DaWy+t0sD2pFkqeVXuk/fQIG26BTuMC+RT27/ClOkd
	vE2ZvPXsnw4o2rVEg2gys6l8LZyuKoLa041nZZVqUSgNF2M9rDRvVcdoPzI7plxTgY+N/C6jz16
	d6nxvVzV3VvaaKxh8FvhRTzFaUCdoxujW6jGCVxc6vguWinXfOETzN8eCknatl+D810EwSlA/Qo
	LpnT0QQX3TLEoZEFXPevf3renAhv5JL/Zky5ApBJUXCNrWPZ3EEef5WIez9a6MQ+mUaif6PSQ4s
	PgkEP8Be36REXjRsTAsqEqDRtJ2oK96rhG9rejYbB8VuBnWai+TZKkBJ9FKXDou+IGP5CDy5sKz
	08oKLU7VjMHr6DSrDwCb2MEDZGc3NqgLn0ssEJ2ao0TH5Q21+SfMLJiNlIZwbjNbBO7FPOqG9I7
	x5HA/L6zLDNeJR4E91zUKoDqo2
X-Received: by 2002:a17:902:e850:b0:2ae:ba5f:3ac3 with SMTP id d9443c01a7336-2aeca9a961cmr181695145ad.2.1773737341543;
        Tue, 17 Mar 2026 01:49:01 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece84084bsm126396425ad.82.2026.03.17.01.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 01:49:00 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:18:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
Message-ID: <bh5rgccasvor5xjunkc7wjp3resyulehnqafhzlfwqx2ealwxw@eqohebwzjq2a>
References: <20260312193717.12221-1-rosenp@gmail.com>
 <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
 <CAD++jLnTJGt2YXo6ASXEjPPsMbrr+Mz3RKcCVeUpaWEMPm6DOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnTJGt2YXo6ASXEjPPsMbrr+Mz3RKcCVeUpaWEMPm6DOQ@mail.gmail.com>

On 16-03-26, 15:00, Linus Walleij wrote:
> On Fri, Mar 13, 2026 at 7:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > I wonder if it is worth it anymore. Why combining allocations is better when we
> > are ending up using more memory ?
> 
> For the same reason we are starting to use Rust in the kernel, despite
> it sometimes will take more memory essentially. __counted_by() enforce
> the same type of runtime size checks as Rust do on arrays.

Right. I don't have any issue with __counted_by(). It does the right thing for
flexible length arrays. But we don't need a flexible length array here and so my
question.

-- 
viresh
