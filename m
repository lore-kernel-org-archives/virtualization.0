Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A98192B78
	for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358886; cv=none; b=WAPP51NyrcDEmp7K4jhM1L8xSkjoVcMpKoVEca4SH62hT/j+kV0Zd4RnwhJEZZ5ujl6ZgW8jvn0PPIPEUA0bX3SO0krrMgRp+0MY4VW03AYsyLRPKItqHel+4l4kiwKDMibXV2jOijpwrdwOcGTJQaLK4YfkCwVM0MGDIndrGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358886; c=relaxed/simple;
	bh=W/9gzfdr9cZH+57QRUYYgUTHJXQgKUhaZKD1T4opQIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owXM6RA2mveoj0JQnERTMLM5EZoWpT1BEB2E/n46k4IXW2/wOLBgM0I7cxs1xcuMquX02lHqoWD9UL4p87Iz5rujvhUcttFspVwEsnP2hC6ScfFPRSFmvybuTjUYys1MVUm2IPexuc+o1q9yONctejnAZP3NGcOA0qv967PYKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSBAOfV4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSBAOfV4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so2310213a12.0
        for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358883; x=1718963683; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adHx/v9H1K0ctclC+H80fMLfFox5GlDl2/q1KJG4axs=;
        b=nSBAOfV4HBcMFCG/AegJPNZNRy4kJSSlixykYyJya/kkSGNUGRpc0SWAmRYvsrybwg
         Jlou6Zip6dl/eM7Uc37rZnesIII5bcakOBxwsgdBiRBy/fLwxoloGYCgCEyGStgL68rS
         ybPl7WzBJ96G2UiTy7jqgUQ/MyV3GI3GiaoOQALr20KIeD5TbSlKTLqShDhCGbpPqYeO
         w1XTVgOvJQTMPrhCn9kUAPGMHquqhgME1JLq8ErMwgC0h8QIL2g2ZA6zz4G1HFpMnLxU
         p0WNqYJD6N+jpmILH/tOQ0zr3OQUiE2Ql+mk4LuI8RMWPrAo31MR4nVNf8tuIpt0mYQG
         wvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358883; x=1718963683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adHx/v9H1K0ctclC+H80fMLfFox5GlDl2/q1KJG4axs=;
        b=G8mVApWvUyQ8K5thbTvIwcxw4xMmpUl2HWZgNcvo8LQXrim0Wkzi7W+XTu9GsJVwM7
         MKTQG9qu6NHnonU6xw8WoGJnWYCqhSAldhR67cSerYj/AksE8c0HAZ5AqviR4NXGpnSZ
         V1fClQr4/Kxr3NPotJjobgcYjUUUeK5jC5frvuB1WekCJLDagRG3idbQ/t6I3qm86epe
         b3205oDPeKnhqC9QGRrVRX6eiQ3AmO19R48rXkfiPR11VRFPYAe6FETHBjYXQ822QW1I
         qKJt8iyXCAGmYT/P26QhD2lUYWkGVyOEVES49hZfFcLT/PdNdwWiX1yzxT5tNZk0wwD4
         cYhg==
X-Forwarded-Encrypted: i=1; AJvYcCU0gwp4HMgM2PYsmqiyJeU6Y6IHSz60E5LMYp31dasiSSNruJNtqJJOcEryIJMrjI9eMw3thdS3uqHthMTCBnWwRq/ge/YWW349gG6jPQQ=
X-Gm-Message-State: AOJu0YxQHIxe3HKgHvU3iCEKSz1qN/nUzFyRT/v+AUVfXV6VZnnP+hwO
	8MwdsoZ/4BSycRs6tTrU3wc6+TYupkO81eQ14VolCSZ1XN21oDnkkctgO46P3j308foJmqnMFv8
	VFpA+OIUfpFkBMVKqGfbz/w/AAuc=
X-Google-Smtp-Source: AGHT+IGakXnmjTnRi+Meh7Ot1SOK1Jk8EHV5gq1zUDmJEMqV+7KBV3woTvBGkzd+rG01YdnSmfdc0VvhdZrQHSrqttE=
X-Received: by 2002:a50:f604:0:b0:57c:6bd6:d8e5 with SMTP id
 4fb4d7f45d1cf-57cbd674328mr1420261a12.8.1718358882884; Fri, 14 Jun 2024
 02:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240612170851.1004604-1-jiri@resnulli.us>
In-Reply-To: <20240612170851.1004604-1-jiri@resnulli.us>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Jun 2024 17:54:04 +0800
Message-ID: <CAL+tcoARbB=xBqsxQJ6PWbCcHUgpFhoXBq0BAJHrKc0+1NNcvA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	dave.taht@gmail.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jiri,

On Thu, Jun 13, 2024 at 1:08=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add support for Byte Queue Limits (BQL).
>
> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> running in background. Netperf TCP_RR results:
>
> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875

I cannot get such a huge improvement when I was doing multiple tests
between two VMs. I'm pretty sure the BQL feature is working, but the
numbers look the same with/without BQL.

VM 1 (client):
16 cpus, x86_64, 4 queues, the latest net-next kernel with/without
this patch, pfifo_fast, napi_tx=3Dtrue, napi_weight=3D128

VM 2 (server):
16 cpus, aarch64, 4 queues, the latest net-next kernel without this
patch, pfifo_fast

What the 'ping' command shows to me between two VMs is : rtt
min/avg/max/mdev =3D 0.233/0.257/0.300/0.024 ms

I started 50 netperfs to communicate the other side with the following comm=
and:
#!/bin/bash

for i in $(seq 5000 5050);
do
netperf -p $i -H [ip addr] -l 60 -t TCP_RR -- -r 64,64 > /dev/null 2>&1 &
done

The results are around 30423.62 txkB/s. If I remove '-r 64 64', they
are still the same/similar.

Am I missing something?

Thanks,
Jason
