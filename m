Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476E14D28F
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639300; cv=none; b=jnWYoQzG9glh9ieIS+fWHs8BSsuPrernU4wmIFKNqg9OCcvH88uaQvEdtwN/tGSP+uvscQaGOgX6ikPfzR3QUy5EEerQQIBiKVgpWe4DdggM+SIYdDjYmJq0yiBy761GWq2E5Eefka1ps5aifO0cAcuKzZNp80zFcPtE5V9DNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639300; c=relaxed/simple;
	bh=NtoBkFGBc3E/iPdGLo93DnYQxr46AH4EvAM+llTMuwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTnIm/eF43s4zOrK5U8Nb68bzyOUofbjEDDtut1OX3PNV1NhChGpGsAg5GxEE0udkOiSW18PLlWyEM4EjgZ7C/afF90gmZzzHgzs4OFabF4InpQOKWpmGsbXZcjVS0AooGQggmSVpRbGBYu8YV40VzCOP6a/wPNXx4/h62xDhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6/lXhkE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6/lXhkE"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f0e153eddso581203066b.0
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718639297; x=1719244097; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL3/WvJ5bI8knynduP5GyBliOLt03xCeOpkE0FZwiag=;
        b=g6/lXhkEvL6sLjPpMpLHUmOFBc9rkS8SDxQW5yF16dzDf/6CZLaBHFKqE8w3Iv5BDF
         XksRHx0WIptYgjDjCcYyt8O75Rz+ruPBh4EXg5VMUhFWPdEg5G25E9gBN9swhUEnmRaL
         ifCEHpbakMYTBn9QXUWSRTGtJ1gLnreL61n+p4PBje8r47zgqEoTTF4fECAKw5qZS3r9
         LBbwdDQ2lyMdnYj9paCGTIEvHmFxYWtsA7dfIfBDZB/ZgKQeapQrr/0zenU9rlkiXK3a
         6FAeCxlaZLd7TSUxB8RJjIUF0Jz/5JBRzNDMeMVdkVhHOhswoGUhveRux0H1QeQGJW3D
         gKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718639297; x=1719244097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL3/WvJ5bI8knynduP5GyBliOLt03xCeOpkE0FZwiag=;
        b=TsiFAoGajs7RBusRJvsRbJH8A9sZcbJv3m7C8+4EdDrqynPVcIjr3l1CUOg4ZlFCIA
         8bwxdgLPmcHkSn/Rze1h0SdaI3bLUHifTs7BSxrzeiMKAGJ6xujDzIw+nJp63ImGuGgk
         z+fpEZFaQSEtNfWeev9GbFX2kSYZXk44ue3oZR9Uw/TYinoWe6Z8FToyBw6cJPxGmEFw
         ksB9XqACcNliBRjYDh6RNl/uJ5rWqEXt6XRzLCPb9zqkOi2PyxRoIiJNlszgZB5/sVVy
         Bz/aofeMxOQ1G5iofSxr/vEShZurl0dOGLKKez/rghDA4Rkkg5pUAMk+tnROLfzEW1bg
         ubdA==
X-Forwarded-Encrypted: i=1; AJvYcCWdFamtoKjRUHulDWt9x/JyXpbFD2jP1IFhGXonZ7x3geSAVqF/76uzPn77qt+bOpYaDPhNfVjJdc3hPh92AsRMTO93RVOemQkoPuVsY6E=
X-Gm-Message-State: AOJu0Yz3oSAE2n04v5ruKlPbwlO1UMKcO+ozDqG+Lup1bc+U+5rw8PO/
	dZxtuxqhwYdmf1X8uuvgboYyZn+FFiVzzUQ2DrtKBjK0zIoxLBj8FQSHO3fXFP3BMtLgV1Q+0z3
	PUOZnhXCWbrf8EAwTf3KYqkEvSb0=
X-Google-Smtp-Source: AGHT+IGNPmTPx1E0cFnL6ihuIFXcCMyOQWVLcxbc0sjhh0aXjy0vK8tDOVXkldRu3GQ+fuvnZjW6iMTCemGxKKNUdaw=
X-Received: by 2002:a17:907:6b8e:b0:a6f:80ff:4050 with SMTP id
 a640c23a62f3a-a6f80ff41c7mr313552966b.25.1718639296601; Mon, 17 Jun 2024
 08:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240612170851.1004604-1-jiri@resnulli.us> <CAL+tcoARbB=xBqsxQJ6PWbCcHUgpFhoXBq0BAJHrKc0+1NNcvA@mail.gmail.com>
 <Zm_-vk5heG6rkZEf@nanopsycho.orion>
In-Reply-To: <Zm_-vk5heG6rkZEf@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Jun 2024 23:47:38 +0800
Message-ID: <CAL+tcoDf=2xMS4G1sbm8y=LDcUqP0Ft6AZ1Ts4Ar8jtYA_=QUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	dave.taht@gmail.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:15=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Jun 14, 2024 at 11:54:04AM CEST, kerneljasonxing@gmail.com wrote:
> >Hello Jiri,
> >
> >On Thu, Jun 13, 2024 at 1:08=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> From: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Add support for Byte Queue Limits (BQL).
> >>
> >> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> >> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> >> running in background. Netperf TCP_RR results:
> >>
> >> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
> >> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
> >> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
> >> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
> >> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
> >> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
> >>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
> >>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
> >>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
> >>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
> >>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
> >>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
> >
> >I cannot get such a huge improvement when I was doing multiple tests
> >between two VMs. I'm pretty sure the BQL feature is working, but the
> >numbers look the same with/without BQL.
> >
> >VM 1 (client):
> >16 cpus, x86_64, 4 queues, the latest net-next kernel with/without
> >this patch, pfifo_fast, napi_tx=3Dtrue, napi_weight=3D128
> >
> >VM 2 (server):
> >16 cpus, aarch64, 4 queues, the latest net-next kernel without this
> >patch, pfifo_fast
> >
> >What the 'ping' command shows to me between two VMs is : rtt
> >min/avg/max/mdev =3D 0.233/0.257/0.300/0.024 ms
> >
> >I started 50 netperfs to communicate the other side with the following c=
ommand:
> >#!/bin/bash
> >
> >for i in $(seq 5000 5050);
> >do
> >netperf -p $i -H [ip addr] -l 60 -t TCP_RR -- -r 64,64 > /dev/null 2>&1 =
&
> >done
> >
> >The results are around 30423.62 txkB/s. If I remove '-r 64 64', they
> >are still the same/similar.
>
> You have to stress the line by parallel TCP_STREAM instances (50 in my
> case). For consistent results, use -p portnum,locport to specify the
> local port.

Thanks. Even though the results of TCP_RR mode vary sometimes, I can
see a big improvement in the total value of those results under such
circumstances.
With BQL, the throughput is 2159.17
Without BQL, it's 1099.33

Please feel free to add the tag:
Tested-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason
