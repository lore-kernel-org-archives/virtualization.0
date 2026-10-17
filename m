Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F43A6B67
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254957; cv=pass; b=C237rUUFp0FPqOmPdByzG7nNFNMbv10yceR7Wo2M9l0VxOcv2FOpaGD5wBUbAOepmkdNjc5VZbbCLbDS7O0PLWo3tlEPvJa8dwIHu8JGf7lHlYgRnGXtpNUPHlnk6dzH3J/H4U3+LH8E+h5d8iyi9G2P0xOrALOyXBB+jktSllU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254957; c=relaxed/simple;
	bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzDRzWTZgla2OEYNic0FuegVqcrMs1APFcqa8PNw7tEkyOF9zNb1TJ9NORsHsO1oTQyYfBU1xnWEppmS2bH2Ui5qCtlhTQxu1PwebACSVSPSiPHg5YT/3XwzvI2pYHWJBzK28crw+BnKYJkAF3nFhUfOwWsr3QywcCU3Bq5y9sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKuSn6Je; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKuSn6Je"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53381e53b80so10794271cf.1
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 09:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792254955; cv=none;
        d=google.com; s=arc-20260327;
        b=avkmjVLmTPXpl9f5J4qnNJg+LBHeKjevEItuu7Ks+xxSIQqD7Tn0qYo7+8wM55tWx9
         cgT/2XUfwi6hqD1cXiqDvo3OkDa/NfAszpvfu1mwMG1Oo/9QNIE7D4SmvZxg8b1ExeY5
         QQagKfkxkIWf5Cge022NIaS6/zurRatiCjxQNPuYHDGFVZr5mCf/LJHIRvqM2b+dq0z4
         Hs6/TdQB3ivMx31m7N82YL0kUl0PBaXeuoDtwy/gsdAl1qL+6Es75UxrAbI+IjB0RZq6
         rTZ/q85BrBoZwnKUZhOy1Qw1fbKcGrkaOFh4+KvzyZo2igDhm2WVUfxOTIPDsZ6XxKeu
         pVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
        fh=DXXx3JUtKXYIbBgzVJqpGDM77w2AKJPVhtwda2jdFtM=;
        b=nK1uJ5oJ/hK1tYJVCWMy2Wn+RH8vAMHOBciNoPmCbEKOX4u85qMZuGs7S/RMoR93eT
         My6zb38KmSHDHvvnstWmKvEPeSTGC7jEJk5k3z8SDe02HqyzEsRvo0Og2VMP7kGzLCOf
         MrYUFNNY3WvddMxmnZJNF6GWF/0elHB38ierd2eqQ8V+uPPoP1sm5jHCQrYEa8q2dHzj
         TG1hc8XFfHyUNGOcbKO/6g9dB7rGCxk04U23tKNAMvTqOH1ekTntWP16xI+14CiC1qlb
         jcZEOhnBrH1cAe6fF4KXjR4ikz0x1wgErC8vKHSn2gpPIg8cz93rcc/LiPXLK7SLHSmX
         hFNQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792254955; x=1792859755; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
        b=AKuSn6Je4USCdbilgmQpIgIz2bXi9OxHko7P2n/OeS2RIoCBUKCz82bKN4IDgD9/FQ
         WnQLIvS5V7QS5CPNLQPRLZONTOSIy5EdGsRWZoSKLnxsgE0UocJFCBAhFdmfpkGe29AK
         /2zTHqCXnue0hfHf7GtvVUFXSoHM0MZHneqMf5BLT0DnsknKAAYABDcfCYSHOPKiuPdg
         rpYiHyJSoGTD5Pif2WdZQ/kN2Y4HdVTAkMampEz8uzeMDok12c+Ax8MP09XpP22Qjcfa
         2+mAfaN6mzwpQ8WSrlFhhsmdhY1IR64mMAyof41tF1BHv7svBRAgKBpx80imP4Wnwnsc
         WNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792254955; x=1792859755;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K575d+X/T8zxf8IPb1Vxi4/BMBu6K4J9uKB9yZoQ32A=;
        b=ilE4J9Zpos36yWvyEWoPjgDCuQ2xxyuQTu1JZIp9F2/Lzdc7AoXiqqimT/VmlnWRuH
         2/A4slepfA4WNGhEcHTZKAxorYOFbYPy0SCOi6bZjRxC9l4zsLgEeBNIChECbFsokTrY
         CsTWSDuIlcl/HFlOBf6of3+tMlM9Aguxb/dIS4FwPJ1ZeWF4kLq9r5OKEmtgLEuMJiz8
         u01p9YRDXRPa03NO6C3v4sDo0m3OgkeKA5kRQIyoyPT9hLv1UWzf8eakbLTE+ji4+a/b
         BVdMQEP33GE/EJ1+pxIFnoNDiHJwwEuYfqVbLWXvvAE3zd/rULC0fexI64TlAuaU282I
         Og8g==
X-Forwarded-Encrypted: i=1; AKwUvByccfP4fOBbzsRkMiT/zlVdIu0O+8dZKiDpIXcOY8/HCJhywHhUhnlSJXZOEufxyO6lUrCBqtBp56XUDmAtCw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKnXI3zlbTLv+n3B/VJOZDgxR11KPtBKAOnxz3YGPZeX+lrkXIQ
	V2Guk21/bi6rlAsbFGl3LeXdQyShLW+xzSIw4AsUiHdc/3UK/Th2OdYA1Vod9D6zSd7fzWDD5G4
	hezsiePIm+lHbwXOHqToVrJLvgaoBROE=
X-Gm-Gg: AYBFou0Mug26pWxelw1nQtGpjDUhSp3AZqj9J6PXwgncBNyaCcbR2y0kZ1Q8QoYzXN2
	FNvga/tUXqNE+Lyw7lPcX4vrRg0NF9wLFdg572jUDWzbrJZmAxGOu6VBncnZ1wH7r2wPVYO5CyL
	6jdcMLZgerHEjm3wUNVW1bUYTVRCaZNmS32KuWasxivUiCrvjTt1XJxW3/3P9qZJcHp6T7QtzKO
	zQ8t9Z2y2XD5o0JQbp0QgTTkqdv46DabFjv4nb9Ld9wBoa+KHlCEDeJa0rWEHtY8yGceJu9vrJF
	F+8xiseEtM48g/0K6DBxw4LEA6qOOUdxLAJEZt7lTKRf6xqApqZIbTF+si5wSRxK33BhxA+cKY+
	xWUpgFlr9ktHc1JhBhGwwepWWs8g8bc1dhNaH1uhy6uK3UohHspU/OWR8M+bZlFr8+N+W607s9M
	DS16jB9RKrfJADLFTHcYYDeHKUfOhZGUpq9Mf1JehFikWuISCGhjjK2Rrbe41FToy/Fm/CsT1rv
	LsHF5J5y2QiE/eUo6hu61Zx
X-Received: by 2002:a05:622a:1244:b0:536:4482:2c5d with SMTP id
 d75a77b69052e-53645e074dfmr47949901cf.19.1792254954694; Sat, 17 Oct 2026
 09:35:54 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 11:35:54 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 17 Oct 2026 11:35:54 -0500
In-Reply-To: <willemdebruijn.kernel.eb0f6ff37e8f@gmail.com>
References: <CAJPVW+=XcHDV4aoXt5oAHYh49kX7m5wUxf7TucrcBy+q6MdXFA@mail.gmail.com>
 <CAJPVW+nstfbagm9GxQ=i-5J6Xi_aZ52-YiQZeYrzmPD3OmDNiw@mail.gmail.com> <willemdebruijn.kernel.eb0f6ff37e8f@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Megane Hebo <hebomegane@gmail.com>
Date: Sat, 17 Oct 2026 11:35:54 -0500
X-Gm-Features: AclHuK-g419mItqEZ0pdzSa8CH0A7yGLpafb0QAT-ug0oTfrYzft6MBGpXjOWuA
Message-ID: <CAJPVW+mYavbi3q8eacV4=V8Be0-_5RV8MnksXPhiEvin8XfGrg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] selftests: net: exercise virtio checksum
 ingress outcomes
To: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	mst@redhat.com, virtualization@lists.linux.dev, habte.yibelo@gmail.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Thanks, understood.

I was optimizing for preserving the semantic contract, but I
underweighted the permanent upstream maintenance cost. I'll keep these
cases local unless a future regression shows they earn their place
upstream.

I'll use git send-email next time.

On Sat, 17 Oct 2026 11:55:26 -0400, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Megane Hebo wrote:
> > Correction: Gmail Web rewrote tabs and wrapped some long lines in the
> > inline diff I just sent, so that copy is not suitable for applying.
> >
> > The attached format-patch file is the authoritative byte-exact patch.
> > Sorry for the transport noise.
> >
> > SHA256: cd11c3970f0a23ac039cdfcdc6338c20c79dbff3db8fdc93ea53b4b8996437b8
>
> This is not the way to send patches
>
> https://docs.kernel.org/process/submitting-patches.html
>
> More in-depth: with AI it is easy to generate testcases. We now have
> to consider which ones are important enough to submit. I think we all
> have reproducers for these specific fixes offline. If we had thought
> it worthwhile they would have been included in the feature series
> itself.
