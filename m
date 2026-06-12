Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245C13C9C4
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226579; cv=pass; b=OpitoMxMGJRvx1Kwa0A267BpsXlhlY4UckQ8O5WzO7QWpRf4RssLkYjau/cTQ4g5ImazcG4ie4P1I6IZ5blMUUwq9kFLe/Kk3ZPTxlTdCs75z9r927lOYJ7u1xSRk2zBTJNNljqqYThV7/IeXJkUsd4OrIC28itJRvHXWtO/u4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226579; c=relaxed/simple;
	bh=9gi2TnyLTtIq3LPG+G/+Ly7DV11ab410M+WEj0lWYhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeJL39IlETVpXz1lYhddyOAynMKwszjg+yzwPLVI2veT1XPtZnJyCU1zShtfF2w67X5RYw4XBqjKSIdnrA/c4nELBglWOsfVcC4Ar/kDYAu5NbRX2d/iz4AyhBOAEZQm9qrHvM25dGJjuhmAcmglNMLpIyp+X0SPZdviWmTcUTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS5pUCrx; arc=pass smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS5pUCrx"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7efac480dc6so4148957b3.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 18:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781226576; cv=none;
        d=google.com; s=arc-20240605;
        b=VGsKyT3CpBX5W/SJRM6sNLObVWAupB2fA/igeF57/aD3FcpDKLblmuGEjvNXo7ZPgs
         7FKK8SAZdwHnNMpBFAiR8reElkbPemsijvtlSFf0XoGJet/2GF8/AoMdGZ9qLjh0ID2Q
         4M2ya2h7YAWzPRHamx4ombQPfwvVaPb4ApJZUdxeFkVCcYaHjKQ7wI1Tc2BsXt4yVEWz
         RGJSIVmRRiPl3+CMwLOhrlTgrJysCTKI57CodBNnotRydUe7iJecpaM0TwOtSPcUbr/5
         i3DmcV4XmNRlFCYhMurNpF0Gr7aCQy5AbJKzhObX/CcaehzdtUQU6CiybaUqeQs8VRYF
         5zPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        fh=Z4MqbnJrkruplR4i2pt0b6ZLptxYsIg9JQwwB3DiEyY=;
        b=kl4ebFKP+P+YbSshK0E0Dgt0GxZmK5ErFK3p3qw/W4+fHt5BS1ODZu0po1T0MVm1XO
         NcNRupgtMs4W9JqdeKaWrc02hXE00uM6SS00kcKsJvttBsedxFGakj7UJrWg3eNYA0aQ
         CD+PdYBhJ9qxiUsN/hrIcHGVqnlNfXeQoiOwxtBUtjxrHLiSreZPWSIWnV00BOVIHo7w
         On48l0OBfj7pB5ML4cB11U2jJ7A/EzbstJrfYyS0keHoNmokVAzvIPu+MBixuWFza82f
         2irTao4EEf/SZsTfY70so2AY2mwQw01LNQlweQJ6gQjuSE6MMsML01Vt7iBUtL8LpZtU
         N0dw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226576; x=1781831376; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        b=GS5pUCrxzMI1gLTD6YGLfbZG9jpIBhLKkETScOviAbFiqJOMgm+X0s8DyA25eT1C8X
         CsH+PM781g6q3MsOaqOQsD/OBclyOA32ME07CYzbT4WQq3zx7IJ6OU/fffGZfy8bjIlY
         qypzPkXyL8ooND+Qeh9Ugr0zmiJFJ+6Mad5VaTdM1w0WF5vV1matK/0hpD5fGAK6sbZA
         K2Lt0WSjlvCk/sAG5agysG9Jd0qqqhOaVh1t0vXoET2EFe0iS08gbXuCEa/7bLbZEOB7
         U02XGfnHyu7E8PtTdrHyifc7R6JNnQWByxZmsBu9Fle6ZciCk1qliMZqZLB3CXaWjA1P
         RDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226576; x=1781831376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        b=QXsHid8cWMnl7K425v97ziIMzx1t2cypu+bLlK6rEdVk6Aw2Oni3HygRIJPMjJWK73
         W4F0N1Ti8DUhgYGeLur0kVrtWgDRqRAxzwH+YbMZLe9s5zp0Vy4VYQVKYnMSFzIuDdQW
         Q4n3HispgSWjqjJAP2hc29+0a9ZrAGO+c3RaoKiMOWSAeiewxkst1bypI8RsMqQD2cKA
         5nWBhlzkG9n8LphH1pm+21zcRkPzU9CTN4igeOik47Dv7iy4zWUvdn2omqJ/4k3BOcwO
         fMIuKvTDXKtVAzb4pjH2dUDODs24LZFY0hpLI9hetVR9v2Bm0Bnjbn2HWt7cdyuPWIwT
         VEoA==
X-Forwarded-Encrypted: i=1; AFNElJ/2HJA7G86WMnv1xjlthbgAlcsJcuCpKbQ3Zg/7x336qxgUlmTOmfHuBQ41vi+zG8nWUHTg6MdKDgRZZufc9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYCMIhuH0An7C3KGpsZSqoi9s2181Xuy2lOurbrvYIl14hHerq
	9OgnaVUn57mnA+WhJki01oCc6Yy7gBxYheHlgfjyCXuyKLtLH2EpbY/RE9uIL07CbVFv6kqpArW
	qtZyfc1oFUBLyetOk13AkT2HcSn3uiJ4=
X-Gm-Gg: Acq92OGyney9EbNZynTDh2mwMfjgh7led+f6hjgovbTwSPVKp7sh8OqBDaelr3/4EPp
	1p3WAuKfHUDETMjqwCtOFk5BBHKzzJnw/2qSbVysNGgTCTkpqg6vb5fZeFcdMz7zdqj1E6Dwwhj
	PsgpRd4FoLmS1uJdyp+KT8nUdKHwKJJo9TGKpZQ93HzF+ZnMp4BtbmgHAM4O1FqK8YA1wJUXIQP
	SDvuUZRmUqodX9rDvp/UL7i0UfckUc63B5+ucTqoCQPyYdbNPrC6h+/rHdddr35B1L9584VNVQl
	4gTucZG/Xg==
X-Received: by 2002:a05:690c:63c2:b0:7dc:7ccb:33a1 with SMTP id
 00721157ae682-7f7b862ebbbmr7194657b3.23.1781226576049; Thu, 11 Jun 2026
 18:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn> <aisBEUmSJa1vkFYo@boxer>
In-Reply-To: <aisBEUmSJa1vkFYo@boxer>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 12 Jun 2026 09:09:39 +0800
X-Gm-Features: AVVi8Cem7Z_iAE0cAcLpfhNtsEYe4ISMI5m8TQRa6PlH_Zbru4XArHRge9Hviwk
Message-ID: <CADxym3Y_2NPr0ktHxdgh6NKd4xnoq8TrMYG=QRMdhm9g2Q1zwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] xsk: support tx napi busy_poll
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bjorn@kernel.org, kerneljasonxing@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:40=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jun 11, 2026 at 03:12:39PM +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > For now, we use sk_busy_loop() in __xsk_sendmsg() to send the data in t=
x
> > ring. The sk_busy_loop() will poll on the target NAPI. However, for the
> > nic driver that support the tx napi, such as virtio-net, it can't sched=
ule
> > the tx NAPI, but only the rx NAPI. If we enable the busy_poll for xsk a=
nd
> > use virtio-net, we can't send data, as the rx NAPI in virtio-net doesn'=
t
> > handle the packet sending.
>
> Am I reading this right that you decided to break busy-poll support for
> zero-copy drivers that happen to handle transmit side from Rx NAPI contex=
t
> in favor of supporting virtio-net?

Oh, nop. This series only has an impact for virtio-net. For the other
driver, the logic doesn't change.

I added a "tx_napi" field to struct nap_struct. For now, only virtio-net
will initialize it, as only virtio-net has the "tx napi".

In __napi_busy_loop(), we will use the napi->tx_napi, if it is not NULL
and we are in the tx code path(sk_tx_busy_loop), instead of napi.

Thanks!
Menglong Dong

>
> >
> > Fix this by introduce the sk_tx_busy_loop(), which will poll on the tx
> > NAPI if available. To get the tx NAPI from the napi_id, we add the
> > "tx_napi" field to napi_struct, which is ugly :/
> >
> > Another choice is to call virtnet_xsk_xmit() in virtnet_poll() too. But
> > this a little contradict the design of tx NAPI.
> >
> > Menglong Dong (3):
> >   net: busy-poll: introduce sk_tx_busy_loop()
> >   virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
> >   xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()
> >
> >  drivers/net/virtio_net.c  |  1 +
> >  include/linux/netdevice.h |  1 +
> >  include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
> >  net/core/dev.c            | 23 +++++-----------------
> >  net/xdp/xsk.c             |  2 +-
> >  5 files changed, 46 insertions(+), 22 deletions(-)
> >
> > --
> > 2.54.0
> >
