Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC302E7631
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961485; cv=pass; b=fVywTowQL8BegrJcs2a7hNvN0Ijq+VndaX/8Cha4mWwZxxTa7xwX34npucI3dM1+Mt2/EdLGiRjDVW6q107BhQIKy6LjHYsUowCDc9KLygTiEw5O4y97trRXjP0Ha/EkRQaT27wfpO0OhTdf1Sn54vAheLgWFjD2QPEVOUKB/9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961485; c=relaxed/simple;
	bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bquGRLZNOUBLYcH3Sddk9O1yMcUo+q3tN56Hld4bFP+Bz6jxbyC65R61QF6/xxU3i56kzI56lxYilv/TTnwzr4avVRbzL4E2rDA8/1Fr/gf2rv6SN1yIUh5+ThKBTFshCNQcTzZBqBo0lRLd2I9GFUsaW3SYtiswjxlKUAGWziA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RiLSjEYd; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiLSjEYd"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9ab2a135dso3246176a12.1
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 20:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789961482; cv=none;
        d=google.com; s=arc-20260327;
        b=nQIIy2zEZP4a9oJKCzDDMuTt7n58lIKskdVkNXEZT/3a5S5Q+6AwLXSEk/HPkdmGk/
         CmIOC5dE8AFbabzzzHKlj+F8GVS1IQ3QKY7gUY4FckdzVHrTgOHs02h9AfpByP4jSJT0
         9HUQHk5tWG6kSqDRIlv2h+ePzEdR08NctA1XQz6FjUS09/cnmsdXfGrVSJkbIAEdyChQ
         ji5IFBg7rPyOj5E3wRnFkqlhn+vZuTCFWR/j/mJu+sHMuGIiMVw2qP+4TypUWHRqaTJP
         FaKYPabYB5zeBjm/EbTbmfNQBjWRh2YudIUoppGHq33UALrROPxLBInRsPDNr1Nus3Zi
         wiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
        fh=Fr1UJgmzSJDcS/2fpL1aA+BcMHUJx95ecRvnz45Q5YQ=;
        b=N5UcUblgqHg+SLMJOVAcJ5ecz1u8iFGpdI5V0hT0x09ub+M8bWEBiL6WzSPYZCcpxQ
         pmR+6ZIVcPu8igeCQ08VhdnDwKFvAB22POhbpvo3d12j6wYQll0KoMFHhyD1tWQVbDMv
         vQmfD8WUeTRBLYJQYHKdscuZmIC44j6p2MXQo2HWTjXNBpKsyoqEct8JYNfIO9Cd/N1O
         QEHnzLyGmiASVBugb++yBosTu/sntqciaX1hNpl0x+2G43/1VPUipGraOQJninRPpyrD
         W60WV6HksC2Ugt1KC9x2C0oqG6SosECqbFzdD9Y1vhDWPTte7NJHSW1nQN5YdQKT7O7+
         TYtw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789961482; x=1790566282; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
        b=RiLSjEYdPu5omADaMBZS/9YLX5kZkj9gO5rjW/VD+96biz1hgSuAiGZuKq4CNvPGtT
         /0X4Y6MA3KpsUr+n5Odv2Ooj8CAZEkwiee6uqE8wlP7DUxYw0yEeXK7FyBI85aR6jHGy
         /ZwtcieBfUVSJ7FiTJOmJMdRgn7mcpIdsai1nu2ubiJ+gmEmff8OVe0+D07vvoUnVO3A
         bKiC46cQ0VZV2DPng8/5eG9FBeCT83yYHffvhmEiPEVUYHhaRxBTBETnHI7GsaupbCb1
         0SnWWtH/WCrlNFt3yF2uSwcqjUH2ZAFKCKaxrsIshoDQnTl6hm0lGENufq7xTW5T5X93
         YTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961482; x=1790566282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
        b=Xo3Qf2nUttNTNabY5GVpH8JoWltwGybnOxFebiPIRn6CtPirQXLTy+1yz8ajBvwABK
         +V9zSgw2XS7+qim0WYF3Pn4Avoclxw8b1xmgitX7O11IhyqoN/sLXriD6fLixxqU6wyF
         gqpyTqEMdPU4TGkbvmzhk5kX8VD7sN8mTg4le3nvZZ4UM2vH72eOaPbeprl5Gp7dved2
         51m76+dl3lY8hsEG6RvWAm9keUSsj27/k+kiDaNu+qvEhNr2XCqbgw3PlOm3Bwu4oSJ7
         dWGs8NJ3+Bpv2siIzK8zy4RCXJVPX9JnWS56jpFc0ce7zj0Wzs16t/k7FTQ2mZ5Gghu5
         gp9A==
X-Forwarded-Encrypted: i=1; AKwUvBz3MMX8EL5TPF0uupgCx53IQiCLp1fXmSeFFrkU1qBUUTOXEU/B0PdPbJRDNwTy4CNCXSuMogZ7xU+cCZBmOw==@lists.linux.dev
X-Gm-Message-State: AFuF++lcC9NBpOvQfyYJSNt49QYgV17ANoN8jJrpV1QazOeEcXDT/L4o
	mwrEd16yltIxOTmpeXggn13ZyZPgnHOIEY/CvwCD+lNLCBiRln7YtashAomtiMvZRx7xoB55H+d
	lEdG50ut1sEjTF3J3pwpCjpS0LRYQJgZndKWP/GKUVA==
X-Gm-Gg: AYBFou2njFnN0RAD6pvEFD+qtL2JQLheFXRqBa3Pk8bdjGD9wJciD5+RoRNlCejLQ3e
	fT3/H+VX/E4DUUcFSJ8vBQaowSQmlGSfkDfuPM8Q9zRlKh5Sav/6H+AboE7Yyhm8i9s2VkEeTwu
	qoO6qgJHd+p+hbeAPcw0hFNE5g2F8GDt+8e2Bv4yYhSFO+FaCb7StXpnzLW7IXMsd0pns89WKBa
	XXEX623zZgt5s8dJsw+rSuF3RQW5k6To9uzMS8VdAv+5nWXxxfkrsA00Vg3IX2knZMcJlYv47Yl
	uvxmNP8UKTEk9HBzkwaBLXTaeSRqN1892EJeItQcMTj1W0EuG/ptjqJXUkWAeGZiIh49g3HiuXT
	ffbb2k7cdL7cp6Q==
X-Received: by 2002:a05:6402:4394:b0:6a9:ab7f:c8f with SMTP id
 4fb4d7f45d1cf-6aa54611e57mr5885453a12.17.1789961481999; Sun, 20 Sep 2026
 20:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <aq1sooGCYUiWbhMH@p14s> <aq453yukMHiNb1jp@bywater>
In-Reply-To: <aq453yukMHiNb1jp@bywater>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Sun, 20 Sep 2026 21:31:11 -0600
X-Gm-Features: AcwNN1W3qE53RFtHuPGOztjJSdwljZIvy9Wk3z8AN3NJ17iDKQARaTMy5b-3hH0
Message-ID: <CANLsYkySF+eF-FURnnT6UJv7P5Sg2HdfMSBZnZy_BLyCMvuofw@mail.gmail.com>
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

On Sat, 19 Sept 2026 at 01:33, Francesco Valla <francesco@valla.it> wrote:
>
> Hi Mathieu,
>
> On Fri, Sep 18, 2026 at 10:53:54AM -0600, Mathieu Poirier wrote:
> > Hi Francesco,
> >
> > I have started reviewing this set but given the size and implications, it will
> > take me a few days to get through.
>
> I'm going through the review done by sashiko - would you prefer me
> sending a v2 with the trivial errors already ironed out before doing
> a complete review?
>

We can wait if the errors are trivial.

> >
> > Thanks,
> > Mathieu
> >
>
> Thank you!
>
> Regards,
> Francesco
>
