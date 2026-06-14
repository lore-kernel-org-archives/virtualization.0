Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A23321A7
	for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453691; cv=pass; b=YQ+6vcaHb2dnaEQdS0lpHpkVVPFHlF2Ld+h0RgJU2hfVLEAevxvCzEetSnAYrOqtVaL+QFqYBb3C6uoJQQIxaeabX370VjEYr0JCUR63fSlWllfcNSyOCM5ZMrQNiMqSMQ5K4w2IqlwMuvXFp/khcGda5krRLgSlJxCI6po8hPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453691; c=relaxed/simple;
	bh=GafyeebZAzgXIwpDZ/XxAtB3YDhyuA1vtDBy2V1SRQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll0TjJgstsibjm9+V+ZxGIFri9lPGy9sexiArtE+UvKCX5a2oa11F1ButBALJfGJie8SQENVTrIUdtwfXJGhrniMittWqelDX2T9pAb1nuORUFPgxX8f3Xeri5QMejaDK0TgyKjQRQYu4DPIT6H0KS3IzHtymaNQGXB4CPXibbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTTzf86K; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTTzf86K"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e266714bd3so27462917b3.2
        for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 09:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453689; cv=none;
        d=google.com; s=arc-20240605;
        b=PAhZn1JRlTu/EzhuHGKJQy8aD8TOe3USAojW8ygFiLcXHKYyRwTA9FsU/vF6ugwMQK
         BW0i6lMxEVBwAB7dHGwSwiLtgXhmbTxduhR1xj1UN0N7S95gV6t1sZx8qXP55hfqqTh6
         xrJmWc9rgXsYbEWKfmBpRMh1y15mp1JRFuBzTrSFAK0ItvPFcBq4NWFYqHkedgOiQjW4
         udpqr3Fb/d8fSzO2EE7uQD2kgRd4y+tkEwMFDcOinqASHHxzpwz2W0FPEy7+SaV4k1Dr
         gwNFYKYn8Zg+NSmN3DXgAB2LA/eaV0Vn4DZPm10sAwASxPqw7kGG2u0cC8W99o/+RM0D
         zPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ty5lBs7BYCuv0nBuQV2yqa7LPhpPLdyc9ZwRXmG1e1M=;
        fh=iya2dfXc2s74kDt6xY76EQGWbWKcV1qtv3+gTKoq6XU=;
        b=ky3FzdcXpxA/23l+z0F9l4PQqn7KZplk89VVO82ulCUjA5voPkkM238RyeaTB4sGFu
         EekqYmqXlc+vTb1OnSiMOq5PG57aQilI3K0o2FSSq0DebPviGKGW+UcLCm0v6KyYzG8O
         cSr0mFm+uVOZ1uTwrzQQU5j2B9kGWknksNW/LC9kR3InmeypI9tiOSSw57NPZP8UwJnU
         RB424P0KdRHpUfDdOacgNlNp2G5nrSSSdJSHTtElGRuarK/TUKQhON0V262iZZUrzlVN
         Jq7mtQqf3tA9DEptPUIfdhQSLTWfPX+nf3zlE0/z1MgW7MnP7DBnVwiGqEb/yymIo01m
         E3cw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781453689; x=1782058489; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty5lBs7BYCuv0nBuQV2yqa7LPhpPLdyc9ZwRXmG1e1M=;
        b=MTTzf86KXUWs+GjUxFcc7vsMsbqSFu6Aw8IgLpfktHdLzyY732Sj2sTSvgVhHpTzQ7
         wRo5BWzowgz7TdP/2jEp/jA7KpSC+9jxUOppR/6XTnI1o9b9AEm05Q5qonm90hVevh4c
         WO172J6I8D8BlOqmODCE+DPrsVBFUWJSnmSVDigaqzedJ4N8Kx9mmSMUJKoDPwpwsDsB
         YmzHbbAMPJY8KtR3+o60s4CbVVggbB5AmgN2vSmlQryvuGJnGmw1mc8f8n3z6XmRQMyy
         TTjPC+MPi/ACReSS/qcSDhvz7XKqD6k+i15irHFx3MHkghQtgewnpuV3aWaSUYhoEPBz
         oMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781453689; x=1782058489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ty5lBs7BYCuv0nBuQV2yqa7LPhpPLdyc9ZwRXmG1e1M=;
        b=qAEnYX6ZyIfA7ofxgnxsBEpksvFyUxBzbciOvZJwO3WD4Ofgx9VjLzz1AFh1VFoNYZ
         D7QTBFalCtDChmr9Nk0zztekZ6nbqMkk1aAP6cIC2P09tuq5ST4+x3K5HU1JXlKqRdmO
         frusWLPPwJjCLIg9RXYJ0+mgBT+ePpJy0ft9i1zGtjgaH+P6KeQzqAAhq7ySCOSDlCex
         /GX0PhzQG8XI44IxOtBrNgx2o9mTJYWRdBBDmZh/cNTNYS4i0ulhReOqPJkzwUyCLg+W
         /FgFuaOAwh6kSQ/wK0n2OW7dodKvvlpnx6Z9s39/GEzrv3v3dJv+9kdP8VKklpMkg5lM
         OpEg==
X-Forwarded-Encrypted: i=1; AFNElJ/bUEmlFCq1ABPEQgByverYn2BaWV4BlXudAaiM5p4w1Omf5Tf8JZfpAEPqcGYr1yfjNzHGWJRVZEIV6x7GCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4YwesScCz/t4umNa4y2SbeKq9GSRdgypKbbpntv8ouv0n8p2b
	12dCDSWffRIowruB2A3L+DhToye32hd3ZY1ROIhiOcwsE4wsZi1hplzTk+O7ICxnxakQoN7ZMQd
	2LCmwxvl0OFj8GMQZtxd24g4928C3WCA=
X-Gm-Gg: Acq92OEvaPRiufwCDZ8/8Hms30FukHuySowlys/EvnmhXIxzxSy6lwCPodWsuirTHZP
	vZxf7ZR7PuK45b7daGBu9k4G7vhjAbMuYsmQdtLzeAYueqc5fdvl6opN5oYRePHcdug8sw5rhqF
	/bhxiaDrf8r0Edtku/oA181TLV6aEijJUV7f6/jQKC1+WAGX41yRTUznLkfcd11l0HPeNFAfRNl
	VkLGfeHGeGQtc5569IF5lQLQ1w9mbZXOXRt/VqkFItUDyh/j06kHAUx/19AY9h7vQ8JfyVffq2Y
	jSqcLfpVq2Sgjc8YI/zRD3vHeCSk3WZwha6M
X-Received: by 2002:a05:690c:4a08:b0:7dc:61c7:5929 with SMTP id
 00721157ae682-7f8c1e186fcmr72702827b3.14.1781453689525; Sun, 14 Jun 2026
 09:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260531142251.2792061-1-michael.bommarito@gmail.com>
 <aio83ZWadVTiuNpR@gondor.apana.org.au> <20260611025916-mutt-send-email-mst@kernel.org>
 <aipn8sIAQ6Ai2sax@gondor.apana.org.au> <20260611035035-mutt-send-email-mst@kernel.org>
 <aipvZhfvdtRxOQm0@gondor.apana.org.au> <20260611050731-mutt-send-email-mst@kernel.org>
 <aip9nja-Oz2RxkWi@gondor.apana.org.au> <20260611064040-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611064040-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sun, 14 Jun 2026 12:14:38 -0400
X-Gm-Features: AVVi8CcUV6kBzoaAvDDRMWKFTCSd_vc02sh0mmpZIxeJVk8RGpH0yKfWyYpQUKU
Message-ID: <CAJJ9bXyihwkBc71jWbvmPHU-s5=i5G19g5jP-d+5-3_G6MW=cg@mail.gmail.com>
Subject: Re: [PATCH v3] hwrng: virtio: clamp device-reported used.len at copy_data()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Olivia Mackall <olivia@selenic.com>, 
	linux-crypto@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Kees Cook <kees@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	torvalds@linux-foundation.org, alan@linux.intel.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 6:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> AKA defence is depth programming)
> Alright we can drop this. No biggie.

Sorry for the delay.  I'll ship a v4 without the nospec

Thanks,
Mike
