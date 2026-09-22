Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6E54B1BF
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085203; cv=pass; b=Jr/llY8ZWX4bpjQ/6i5Cq34/L+jWQN0FPvxvprC/fa40SPVZAq7gNAu2VPNYoc3b0yetUTL6ZpOULlHRcnoRmE3Ftz8r1jwEf+mo0Yn4Rm3orEoU+hn+QoJqFzA2kzYYGEnZxB166xsmsZNQZaViaG956rwPQKYvYkJ2s95mLTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085203; c=relaxed/simple;
	bh=0hurBNTkrVz1B/9TW5ipWegr4/ZEEZE2GB3faJsOdT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rveZ5qudHfNHc8PBETWiX+y3rAadG0G95jfJrv4JAmujlWEkQStxLeAu0M4wYv+6GPJY8Xjy4UrKnAFtmSj4H4uU8RSMPW9bnS3HQegkUl3VMWA/YZWkWF6CYywSCOvPZeTRpH/ImlvCgFohRUbX0V52SqvfmOo02tNWPRyIxng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJfQrXKj; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJfQrXKj"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso7427991a12.2
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 06:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790085200; cv=none;
        d=google.com; s=arc-20260327;
        b=JcaqqeZx3z3jP7nCMdUIpiieKsSV2J4I4RQC9/Y9EbpjtLWBz/EAiARTFtdtMdgmO3
         J+L1zoevIx3dolVFsP9G6/6yA/YViUbJCxSotEUliro6+EP1CtIL1JVgDdvoMjHeGFUA
         2hLiHtuDH1ZwTAvdnG28eFFsc2WMzRJwJeriRqbSIXtDcqaswUZOafoh9UJKXnzCztby
         RFQlLHkvnow6VhV4ROLmrghW4mAD/XBI2Pzwgp22WomveeCIE0ft2Xhkcdg8xc+pTlpC
         1SPIBOY1iwVSTacdBDfTrRZv/CQudLKWLb5X1bRYB2D3wA+i6cb6tJcXBV0QfC+JQcAy
         w2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=awCRBzfBSO0cm9zEvmZIeCCRXLT0QzBOpw1tpjmmlbQ=;
        fh=mnPj3ez1GiNSC/tgH9nSP19oaIzkbFTw0a64CZCil2M=;
        b=Y7tOHFnWq6dcWraOEMIehjlRADFmRxtyPg7TzVeQ6JGe6qQKhRZsd84ZX1OI0boDLu
         UtvD4iF6IZtfggnKCZK0wW9lEuSGmuB6OQNB75Ho29OiX54FwwjISFf+qEOqsaIeKu7U
         PJgxptb8w3a2VtV+gAAYBLmy4ExiSUnjq/tfYiRIBzbMFNoOPOah8Cj9th4YZVVUflhm
         g3H0WFn5T+/oaytUa3NYzbPs38Ou6Bchqmj4AgRqVSIBicjtfzCe3rBJmTbkTJZT5fOE
         wSs/h6AkGyvxFbapyNQ5eQM78SlYRNyK/xF3DFTM5jvXuocTUgZQXn382pn19mdQtIL1
         09ag==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790085200; x=1790690000; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awCRBzfBSO0cm9zEvmZIeCCRXLT0QzBOpw1tpjmmlbQ=;
        b=xJfQrXKjUWONG38womQya5smAp9gsRcpsxsyRwgvpI5Dp7ZDiAkkzhfhHut7wFte5B
         vQdLlY797vE0NiHcp7Y35lRyoX1wo+MTiIN/rdxz6CfM3J8VNvty72SPio8AFDVBzwtt
         BscQFUVPPVojZdoPhHUwDSyS6OYnVOUkLIZCS67aPx1uYCD1YPVUGkaoqPaYqjPZ3igp
         AqQTgK3EhsTKkNywF3NQRTaobCOmXVWantfAtBgIo9TiOY/5HUx3kLdx3v1v1zanCfet
         kCeqGTws8GhEDy/4evDN5CNx8PM9QuvWGdT+culDnAwwW1Cqvu6e2RPdBe03ClsLJsRc
         VDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085200; x=1790690000;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=awCRBzfBSO0cm9zEvmZIeCCRXLT0QzBOpw1tpjmmlbQ=;
        b=XrGxKOO8f0fLIeJn7bVLm9CQMK0HZ4mCs0ky+DGeABpYkHznqsoEBv2NsIQqaZ0STm
         oGLUjBCZRAn2EdQCSRyoKEhZ4TlEJRCO23o3GF5GHXa0kA0LmyUGpFaUAq8lbBDX1Rww
         WW3MzWXNvrUU67th2vCMDT69MQkkroJ0aCUVu8SlZZTECU2A5a7g1y01rJOdAWHCgbrN
         EOvkBk/r98ZZc92L8jSq4B+/qsuV2iRleZeTkdXCWpx1D4haLIezNGlLfVHMHQxaTtng
         igF+4T60yNo+lOYjPF1QpESebkxJy+PdQIjUvMWcMbyn07IlHH3/7QqXPBab5BtFuw1n
         nuhw==
X-Forwarded-Encrypted: i=1; AKwUvBzDZ1ONdLG6segMn0fsMOv/bSbKQpBCjzb3fuLD94VfYVmoRyqaB9rjEr1ZI9uV5OIZImH7HMZhRBuj/q25xg==@lists.linux.dev
X-Gm-Message-State: AFuF++kjjzVoTOd2MkVIDn0fBwVcucCTCuds/Y19nb7s5I74RSLie1nF
	+AalEQ6aUzcxQw6fYhtFdVIUKeJ/JrWfRIOc0GIdApbyaIb2dWVtr8tJGYevwmmuPkox6vpbzlv
	xLxcs868QQFysot9FqiuVYQNlG+dhk/goikll15ualw==
X-Gm-Gg: AYBFou0INdbBoPBUD3HNPmk+8Wkbj9drzSVS9HYEnako6rqI79pUAaLGIikWOeBoYNm
	8zd9UvmEnU+pF9ovwlpFpjLJFgCkvT6IVMFsYhQXORQAeyGyNQNw5yngujsCYeaHNUd0z3eRFQf
	6QkCGI9aLVV5w7fV41JGevJ//A9Ri4zoFynmMGMlaJdpsVCrlx1TURt4QqfNIFYIyust9kLm49h
	9NNjVs7UhVoZtPC7GWq+/HRnAlNy01Fr5WY1sHR1OUtv6wBJu4lJhiQWx632XnHpRMLJyH225pt
	M7IvKtmyBkaCFxDEaL3PwbpIMQl/RieRXtfZibjyke7Db8d/eDWPcj13sOKlNk2x7uMxTPq9ZaF
	HPuNy0x2kd+jF
X-Received: by 2002:a05:6402:20c3:20b0:6aa:9210:262 with SMTP id
 4fb4d7f45d1cf-6aa92100342mr3351155a12.22.1790085199929; Tue, 22 Sep 2026
 06:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <aq1sooGCYUiWbhMH@p14s> <aq453yukMHiNb1jp@bywater> <CANLsYkySF+eF-FURnnT6UJv7P5Sg2HdfMSBZnZy_BLyCMvuofw@mail.gmail.com>
 <arIfj-1Ji6HEBHLJ@bywater>
In-Reply-To: <arIfj-1Ji6HEBHLJ@bywater>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 22 Sep 2026 07:53:08 -0600
X-Gm-Features: AcwNN1V0zenE0U1QivuzVoqHQLJIIYIxl9SSuy2ocYOHZBqajP-1AfG4uh0OqKk
Message-ID: <CANLsYkzaxwx8NJAOki_wkzauL68ourd12qF8PzzVKW++PJXZfw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] remoteproc: add support for any virtio device
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
	imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 00:29, Francesco Valla <francesco@valla.it> wrote:
>
> On Sun, Sep 20, 2026 at 09:31:11PM -0600, Mathieu Poirier wrote:
> > On Sat, 19 Sept 2026 at 01:33, Francesco Valla <francesco@valla.it> wrote:
> > >
> > > Hi Mathieu,
> > >
> > > On Fri, Sep 18, 2026 at 10:53:54AM -0600, Mathieu Poirier wrote:
> > > > Hi Francesco,
> > > >
> > > > I have started reviewing this set but given the size and implications, it will
> > > > take me a few days to get through.
> > >
> > > I'm going through the review done by sashiko - would you prefer me
> > > sending a v2 with the trivial errors already ironed out before doing
> > > a complete review?
> > >
> >
> > We can wait if the errors are trivial.
> >
>
> Not all of them are. I have been a bit to naive about the bounce buffer
> management w.r.t. what can happen if a memory area is not specified and
> I will need to rethink/rework that part.
>

Ok, I'll keep an eye out for that.  I'm already halfway through your
work, so there's no need for a new version now.

> Regrads,
> Francesco
>
