Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBC3F39DB
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691591; cv=pass; b=UJaQ2Ylg3A6F/Jr44WxWMWq5i3sSiol2xQD+z3R8OkNM7w5iMLrYw+k/BxhBlRlxja8L556k2LUb6yNrk5UZ3IQY3aDrjPy1AWCQarLZam5P6fVm3hu/CrlZCXviOdFXlxPMsUj0JnuuLNkvUuhb24rYOs7kHuzQF5JJifyY/RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691591; c=relaxed/simple;
	bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwplvEB6Mf0khTNJC1UP8zmzs64nHjRfic0ZvZPThql16s/BbTMaQcQHg19eWeA2A3nz7/Zq2TPB4jl99Rf7134o0rtlrrWhO3t2Qp8PjgybtCEAhwIkEakYyA0juHgTPytlV48zJJ4wABu6RwAzD0evvN3rBkVX/iB7qHZFt2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMYJpYa9; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMYJpYa9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ad4c0c94fbso130400e87.1
        for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 03:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781691584; cv=none;
        d=google.com; s=arc-20240605;
        b=PiyTIgvZjPc9xFiAwYSzRnzXMJGEMew6aRJkudwuP0bqFCyY3lRlm37U6rl+7apuZC
         2mzEep2zgVbvnkXiBo9hGcOStTB4QuH2akj7+iD/PebKKE06pSsI4J7GyR054uqW4iS+
         psafDTwqh4oQIj306x2WD1FCfirkcSukfIS0o9zcYsahiN/9MW9GUs8XgPbfAfccLj+w
         uEKVUK0XCeasB4m5ZECLVmrIMj+tQfnxF2+t+Cfu+LNsg01BATIb/990Wbu5Kpk1MNID
         gYT9KPXjSd5q31++QqofRHO1wSldXPSVtzC0WBJZ71ZS59L04hu5K9MPtR/TCKfeZzCs
         nXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        fh=/YaiBEbyteS2B/8UoBjh9fK6QSM80s74R0C6UPKRnm0=;
        b=UWzw4YY0vbPMSPZ8x/cgoaZFSctXECoJnMt9LS6GWGWKJUg29ceIF41/+tElH1HWMO
         85OmHh17BRVdl5LgOUgGUxgJe2n1iXfgnPHCcxk1CZ37hhomRa48X23ALXmAS0837oIC
         qTsJ7Dp5ox1m9O8yZZTPxNJekkQ9CBcccNGcYuF57PN+CymH2SaB99DMUt6lbUq9It+p
         h1xNFpLpduYRVP1/GxrBDPIwamh9iDSK7nqiotvGAec1KjWtlpdqmpJSIAA50CTjH9aD
         9PKD7DoqWZwQ0pjys0azi1fGOZHF22byxe4rAb9gNHN140+P2PkiaAT4Uo0k/S/aQOFJ
         /Hdg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781691584; x=1782296384; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        b=aMYJpYa9Wq+R/m3AhOeNOpd5a73NfEHmP3SN2qrsxh9s5i9wrcic6offsHibVyxglQ
         lgyVG652THjXtEtjH6+lSwnNQHlXNXSt9sVU5QlKMvY9adzf7svMq12l4/gcY0i6+ZEE
         JPDJEvmNoP9Yt+8OhVsaHlcZNIZiC4ucx78R+asClsJLFcKLrxDRbGEgPfMgwjgpB2jV
         kbczU2ofM/SLGJJhgeo60q5NXdDiNTQ9wuhH7UDoNfPYsUTk6SRRO+OeXvpybxmzase/
         Jln65KLXvaNLRJD57pJy3nag9bKQ9oT49XZJYVBHVbbbYi6NikF5SceoURlPHviIFLY8
         RB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691584; x=1782296384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        b=RDvLfwSwU9eXpWW/sXvo1oNDXzoBkb3zpjqK+OxyOqtb+/jWv194lhr8VFzkdF2LnJ
         143Rxq7wVKxhQtErnLLaN8x5eApA0iLgMbmPv27GO9QvFeaWZocdr1Ch8k4Ag/8fuBBL
         EcynsK2JALG7cEV4asqjaakcBkMhIbW5/ottZkT+UmtgP5I9mpcAbozvDcQB4FkPHxBh
         aAVON+BwdcDr1l5n6XGYMmIMxkE97mO38f0Su0LwVTo8v4V8OnAbfrHbdUwijtyUFOw5
         YDrCINLZOpxYyDuhIQEd/p/QGZztXUdM8qy+/sw3G1OKbyf1cXs5dnjCbhzIObsm/nBF
         Ir+w==
X-Forwarded-Encrypted: i=1; AFNElJ+m16W74EqNrsx2QEAjyupKOZKG86YdVXWX/Y4XVabkctMezNo4zZBPUV+tibfXtqRZzlRZ8BH1/n5Rw6TSjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzypxz40Q+XgaD1tjd1LpeQIHUsNW06IKw3flZoPdNaG2/1qDab
	VMeANsblInGaJzENSTFxGkW+unrNYZiTZ8XyJ101gpObeS721hwydo5JfoQcDXNzqpFsQy6cAm6
	zQtqcLj2UmPJUfGn9rulJ/C1uhN6wlBo=
X-Gm-Gg: AfdE7cnNl6+j03aumlGIijij9hY2eFphoJWtB5SUXm6DnpCMSK9/qAmdvbl14FiiLdT
	UUA5jJAZ4IlZIHZyfVGPvez4cD54+8FwMKmHxLggkhf3x86Ow6DKlhEO6ANiC7bindMS7cykFA+
	cpwDwpJJ7SLKw+MQMB3m9ku79tsbBmrrRjq+b1oVjSMPgtk8SQ1H2BckBeJ5z1qt64VJAp6Sjxb
	SWz/oVCvUEc1XNuOFhXMoqb0pJXvgR8f46TwA72oZWI08n0xn/u8Oq1F0Rxtw4NOjaPX4FHLQbh
	fFnVt0Okr8VPgp1D1odAunM5PVuRplvwXF2FpBEweE85uE5PhVj722H9tCdsypKYX12QVG2HtAB
	a2dR4H9fR1Fk=
X-Received: by 2002:a05:6512:1c8:b0:5a8:86a6:c476 with SMTP id
 2adb3069b0e04-5ad470467a4mr663270e87.37.1781691584047; Wed, 17 Jun 2026
 03:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn> <20260613112113.55d9313f@kernel.org>
 <TYn10tJ2SIGF1pAhF26DRQ@linux.dev> <ajJrckiXEUztBQDz@boxer>
In-Reply-To: <ajJrckiXEUztBQDz@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Jun 2026 18:19:06 +0800
X-Gm-Features: AVVi8Ccr6U6gFua-s95uJJAy8Eyxi9pGTjbRb0f81lrrSkjCY3B3t1Mt-CCv8VE
Message-ID: <CAL+tcoCcrJdynuBqrntDGK_OMSkKkQB9XeoUAC5ig-1_mVjaeQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, menglong8.dong@gmail.com, 
	Jakub Kicinski <kuba@kernel.org>, jasowang@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bjorn@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 5:40=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> > On 2026/6/14 02:21, Jakub Kicinski wrote:
> > > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> > > > For now, we use sk_busy_loop() for both rx and tx path. The sk_busy=
_loop()
> > > > will call napi_busy_loop() for the specified napi_id. However, some
> > > > nic drivers have tx napi, such as virtio-net. In this case, sk_busy=
_loop()
> > > > doesn't work, as it can only schedule the NAPI for the rx queue.
> > > >
> > > > Therefore, introduce sk_tx_busy_loop() for the nic drivers that sup=
port tx
> > > > napi, which will schedule the tx napi if available.
> > >
> > > First, I thought the only difference with Tx NAPI is that it can't be
> > > busy polled. So if you want to poll an instance don't register it as
> > > a Tx one instead of adding all this "tx polling" stuff in the core?
> >
> > I see. Register the tx NAPI with netif_napi_add_config() allow us
> > busy poll it. But we still have two NAPI instance: rx NAPI and tx NAPI.
> > sk_busy_loop() can only busy poll on one of them.
> >
> > Before AF_XDP, we don't have the need to send packet via tx NAPI, which
> > means that we don't need to busy poll it.
> >
> > I analyst some nic drivers on the implement of AF_XDP. Some of them
> > will check xsk tx ring of current queue and send the data in it in the
> > rx NAPI, such as mlx5. Some of them will allocate a extra "rxtx" NAPI
> > for the AF_XDP zero-copy queue, which will poll both the data receiving
> > and sending.
> >
> > In the case about, they will do the data sending and receiving for the
> > AF_XDP in a single NAPI instance.
> >
> > However, some driver receiving the data in rx NAPI and send data in
> > tx NAPI for AF_XDP. In this case, we can't use sk_busy_loop() for both
> > rx path and tx path, as we need to wake different NAPI instance.
> >
> > >
> > > Second, can this problem happen for any other NIC or is it purely
> > > an artifact of virtio's delayed Tx completion handling?
> >
> > According to my analysis, only virtio-net and ICSSG driver have
> > split NAPI for AF_XDP. I don't have a ICSSG nic, but the codex tell
> > me that it does have the same problem.
> >
> > I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
> > Maybe we can modify the driver instead by using the same NAPI
> > for both data sending and receiving, just like others do. The
> > advantage of introduce sk_tx_busy_loop() is that we can split the
> > data sending and receiving, which maybe more efficient.
>
> Would be good if you back your changes by any performance numbers. I
> believe that drivers do tx processing via rx napi as before AF_XDP it was
> only about cleaning up writebacks, AF_XDP added more weight via actual tx
> descriptors submission.
>
> Maybe you can vibe-code virtio-net to work only with rx napi and see what
> are the results.
>
> Side note/question - Do you have a tx-only use case for AF_XDP ? I am
> planning (for a long time actually) to implement asymmetric AF_XDP
> sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
> queues even when you do rx or tx only.

As far as I know, since I use TCP as the userspace protocol, I don't
have any idea on how we can apply this. It seems you've got the
requirement in the real world? Interesting.

Thanks,
Jason

>
> >
> > >
> > > Third, this series does not apply.
> >
> > Ah, I'll rebase this series if a V2 is acceptable.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > >
> >
> >
> >
> >
