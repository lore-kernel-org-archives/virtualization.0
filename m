Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7723F0746
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697621; cv=pass; b=Bs0MJKNgxobvlV5JI3eKL0+3JuAWT7NRWEihTigrTO2lsVmYCOHrkEHxxZEAKcs5y8Va5/W6a4fYoEbYWoklrsCe9G9aqQ6BpMnT9stQqiw1t6QHkvkaSB0XUD1Wp49JjO5Lc7cq6C3YlEecwlqElx9zwXkOFj1EuzrgAdQejqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697621; c=relaxed/simple;
	bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjnH2mOaOHidz7luA9n8dpcZX6uQ6oXVOCBKnLAzKFRDXz67cMmpW0y6u7DSM1Wi7+6Pt1n5K56N4Xhss+vsDinaHbO3+DAdsXKjkLrE8zrwSqvObc+zFoOAFYJIoCZrtCxt5LnOWeXptIJar5nQrYiYxt0GZBuS2VAYjVTB2ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iILNId4r; arc=pass smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iILNId4r"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-660390acd71so877450d50.1
        for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 05:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781697618; cv=none;
        d=google.com; s=arc-20240605;
        b=cJR5Vwv6nwoqSDoAGbafiLrJyiySnVsx1DFooAk2Iia7EZu4E4tt8FETZWRunkgfUd
         knniz+eg1YmCXUBDigqKBQ3eQ5E+0+gm20RCwwnyXkRNGiQAhayvRL+G4cPM2bq8qG8i
         4oeI7Gx4YugYGFaNJtqvgXPHqFGv7oh2ToZEetWB8fP4gC6J+TdBDJ1ZbdMP3UPbuSUj
         ECEC/BwtJbH74sB2yGUy9Os3QdL90PiTwW4R6jOs3aZ7xNRn/9upt6w/52gTSLlZHFFi
         xckM95nfsu8FhzV+umOdpuFyM3viGYayIuAOa4aeaoL9/RjXfGdkZRXvAo1y4mDAa2+u
         aioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        fh=cBjLy064ukYE3hdWY7+q2GKmDrlRJfY9oO2V9YP+y1Y=;
        b=hGcaciv+j0HrkJl4PhPpiMimYe8reI5EcoW3w6lP0X+sbuWn1ICTvNz+AnEKwPSRyy
         mXCMKR1gJJPEt1UCXb1O8orRUPvwaGd9jPtYBMpy4bYktrJRhP3se866CFCHBq7hb+Ui
         i9T/d/ILQUS3iqeafBRE1l1kxFLjrrrl/hOhcUw21Q0uKtZ1CSJ+3D4P6xYzzeGpd2X7
         cxYpYCA3fDKJ4K273RwfWwwIw7ez9KWZqs0GVLze37UG05s1FgulfLAgIwd6f/PnDtVg
         JtrpfYjBgP1QMeKs2TZbnnNHNOtbR94sWJhBL/EzwaFoFAuHuFGAiK0P4ENWjueb6CKp
         SeyA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781697618; x=1782302418; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        b=iILNId4rOPfQgjIlvJGJmTQ2w0It8wx8kzP5rHNzusDvcmNcpFwesPJbZC9afSgspN
         YKF5OlyccJmkSBuiuiNhDJxhwATPkAc/oWHPdjLVzta6DOV2VzfPQI29cSEk0MUEZ8yJ
         BuSGa/S1tsxQnxVqRyV1KBlVcS5B4Jmb4sajmB+R9Zy9UsT4RC1bX4bLhNH+hgoEcjlv
         XN3933iVOMVeM2CReaortR5Uxe/Q5Ncd5n3uaF9usjnIrhB42eW6SLYoj3kYY+ImDnQx
         vpfmCbbyGA6h/bOXMbP6mAafIEmBm2mE7mxz9De/fY9TC4d8uYIY8iziJiET4zGeHd18
         rk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697618; x=1782302418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        b=TDhSv4eyg5LNO1vrcFbS6hTjQRdlL4EL8+IXmbtvMd/yCkcdNniwKc02WJcf0ZH10T
         IWIrtt9F/ejPsGqRTEsYxrPl0uFJtES7x6eC9hBf7iGHM/KjfhD+LEBSgDVosWefDyHU
         oRnTPCv+YwD+ZE2GNnt9ImpWJveJyrkbmHlBxnFn+jV5M/0rpEUaBLY3YY/GFK2Kj4sB
         CO0BKranbt2bvx9jEhk6ueSdWQ9iS/7bYXBReZgbFgvaAc5e+nfwSSJdfnuSFNNzrQwC
         kfOB4xF/MJFfuqeZY5MiifNuLggrxHn9Whmt9uaZxx13OhgsOjduTGf6YdM+yDuBY9HD
         yr6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+mYqDt91S8BnAkpdTfveCAOovWlY8Jw1G8tWsNZ5MO8wMQ2rRtNvP97vjepaK1w/gEQIMfibI+kf5UtmKYmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzbvUJNPQKNKwlHzZB4inEx4E20xbTWFwxnfFeFg3VuX+QD01Y
	hbmgKB3Kj/dvFAIRpqSE61BjrqviGYbQZikp+ycy+TYzTXVq0TRKK1r/F0bTxn3DwHPw47TBkK3
	6RjFMf399gQZYzziGuz8kz8On4DwPfu0=
X-Gm-Gg: AfdE7cmepi9Lq3luLtb7rm7PtYRwvOiGbulUX3j4IV07F9dCavPydFGw6nE9BpbdiA9
	1aYrJdJxBTdFrMYh1cXitKRKrobU5nUhU2f7XzO0kX3HKK9wiURCvgI3pkkkA9kpi9YsURDri9E
	TDQP80TgVhZz7x/4M4Pn10CEqI1ZPtuGTL/eXomV4v3EV5eeh3DSiPRw30D0bHVlqdBqs/fenvB
	1EDzpBCm2eNaTpnpqFczOoI3IA8tYpN0XaW+kr+sJF+pfc3VaKDXgJvGaa+n4Bte6uOOMJsfJE=
X-Received: by 2002:a05:690e:1306:b0:654:3fca:3515 with SMTP id
 956f58d0204a3-662ced30a5dmr1739473d50.30.1781697617856; Wed, 17 Jun 2026
 05:00:17 -0700 (PDT)
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
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 17 Jun 2026 20:00:06 +0800
X-Gm-Features: AVVi8CceZgHFM8mfvFHKtEXFCMHWNlKB0MljWDwvRAc_BYBHABk8LGbFC_ALR_Q
Message-ID: <CADxym3aXnGwna-TKQmJ24UD1XNmq3hsapRQXQtwKF=YC-qqrOA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Jakub Kicinski <kuba@kernel.org>, jasowang@redhat.com, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, magnus.karlsson@intel.com, sdf@fomichev.me, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, kerneljasonxing@gmail.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 5:40=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> > On 2026/6/14 02:21, Jakub Kicinski wrote:
> > > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
[...]
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

Hi, Maciej. I have not done such performance testing yet. It's a good
and interesting
idea to do such testing on viriot-net, and I'll do it. If there is no obvio=
us
performance differences, I'll modify virtio-net by sending data via rx napi
instead.

>
> Side note/question - Do you have a tx-only use case for AF_XDP ? I am
> planning (for a long time actually) to implement asymmetric AF_XDP
> sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
> queues even when you do rx or tx only.

I think this is an interesting idea, and will be helpful in some cases.
I'm improving the performance of MySQL with AF_XDP. For this case,
tx-only is not suitable, as data reading and writing are both needed.

But for the other case, such as Redis, data reading is mostly. And in
this case, I think it's a good idea to use such "tx-only" ZC AF_XDP.

In my case, I don't want to occupy the whole NIC or the whole queue
with AF_XDP, and the other users can use the NIC too. However, the
ZC of AF_XDP has a little additional overhead to the skb in rx path,
as there is an extra data copy.

If such "tx-only" ZC is supported, the performance of AF_XDP is still
good in the read mostly case, and doesn't have additional overhead to
others too.

I haven't used AF_XDP for such a "reading mostly" case yet, so I'm not
sure if I'm right ;)

Thanks!
Menglong Dong

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
