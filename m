Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAF63D1
	for <virtualization@lists.linux.dev>; Thu, 25 Jan 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153986; cv=none; b=a+aLkFk+GK8A09EAiSfkZ4Mc3IOtFflGnSwpU5uGTsH3PPI5y0tGrJoz7WNZTOiwGFFFbWT2tn0+ocfrMZLa5LIxKCtu9DGydGkkvE11i082/e5oK9qftn+IBaGJrILEPMiMQRlbQzmkYIdTfwPFEE2TAa0iubzqlK3iP86V9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153986; c=relaxed/simple;
	bh=bzfgSrTXZv75Mm6hevdNUUdlfQUg3HZgZpDtc3gLtjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMysi8mOgRE7EI9JyWlYelG0Hzb+8qnl8vzXGePfID1KInNt56eI7r5BIOHwx5ZQgX69YqFJukUxlswq45aHMMDvxOkAKseIrWCFc65xrLVGicIRvmi049di3LrBUl50oN5BlUkxvQSD2gzDemq7gldpYw8TQ4j3nuGiVOiCo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKXFgzX+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKXFgzX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706153983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhIcirBtLyJR8yn+TaM7AmyOi7FPWH074qlYOHeT1Pg=;
	b=iKXFgzX+gAZyUrLAaBsMMN9o+OEL0ZyEsqsoXYlgdhD2TPK+UHAtffELpTjcHr4BIGIoNM
	JLIWoA/En7SF+Tcndt8bFtn77gYwNN2PENY9Lt/+4UyffM+Y7Lnqch873A9sPyzLdGXhfw
	2aup75ydAIr8YbPQGV0IfDohlNaqXAQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-dG-TZ4PaNbS2xlrKSOuuDA-1; Wed, 24 Jan 2024 22:39:42 -0500
X-MC-Unique: dG-TZ4PaNbS2xlrKSOuuDA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6d99506e2e7so8854738b3a.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 19:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153980; x=1706758780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhIcirBtLyJR8yn+TaM7AmyOi7FPWH074qlYOHeT1Pg=;
        b=Wq/jI1+VGtz5969gUtLKsXt0i2uZdr3kyeTEzpJbmMmNS2ROoTPKFhT8vM3t3+9mTR
         yniQGq+2AlgJl8SDyyRqChbHqX8//X3YgaK9T90BPdyYGjJ30CeGA25SYtJ5w3akI3O0
         avXlQKi14MNE9qBm66Q7yogTKezMeoGSQ5KBHBFgeZNWTjOmn7pYS4U/5Ths2kuO2hWT
         FwIwWNyN05zAuA8XY6rHq6TkvVbyV2VTqrEhlsljHfJ412EYt14ot647I8dLDh/OfNR/
         ypCiAuk9vMQW37a3Wcng7Lw0kxRq8jNw6go1JT0Ht+RbJL1dluf4bM44BMZHYP/ztOEo
         3DSw==
X-Gm-Message-State: AOJu0Yx/1Kl6Y8Ce2rFI2ipNZzdsm6bUG5L929PC/yIp1NEzkpat57ZJ
	Bh6EHi3Vn8lSiKsnadGNM6M7uuxRQ87goilBfx/DNMlTTmtQI1URs875DWZqxT0zHjAC9IpUKtA
	L5d5f+aXtUyqAJ+oukO8SiU8QMCwzB39ZTKGmQNVu7L38b7WJHdpBz8OeeUrIgsYEaMWVuJSelB
	pER+L1CykbUHlSEdUvN6/xXF7OelTRp2zOJ71RRtk=
X-Received: by 2002:a05:6a00:27a3:b0:6d9:b66f:3d16 with SMTP id bd35-20020a056a0027a300b006d9b66f3d16mr291083pfb.50.1706153980666;
        Wed, 24 Jan 2024 19:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaSzOq8OPaBB6Tm8EEh0l52HE0p4Uu3X2xESlPVUQ9JKv5URCEQPGZtpr7WpXJp0bAO33LkGRhVaAqIrGA+vI=
X-Received: by 2002:a05:6a00:27a3:b0:6d9:b66f:3d16 with SMTP id
 bd35-20020a056a0027a300b006d9b66f3d16mr291071pfb.50.1706153980378; Wed, 24
 Jan 2024 19:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:39:28 +0800
Message-ID: <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This is the second part of virtio-net support AF_XDP zero copy.
>
> The whole patch set
> http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@linux.alibaba.=
com
>
> ## About the branch
>
> This patch set is pushed to the net-next branch, but some patches are abo=
ut
> virtio core. Because the entire patch set for virtio-net to support AF_XD=
P
> should be pushed to net-next, I hope these patches will be merged into ne=
t-next
> with the virtio core maintains's Acked-by.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> ## AF_XDP
>
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The z=
ero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already suppo=
rt
> this feature, This patch set allows virtio-net to support xsk's zerocopy =
xmit
> feature.
>
> At present, we have completed some preparation:
>
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
>
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
>
> Virtio-net can not increase the queue num at will, so xsk shares the queu=
e with
> kernel.
>
> On the other hand, Virtio-Net does not support generate interrupt from dr=
iver
> manually, so when we wakeup tx xmit, we used some tips. If the CPU run by=
 TX
> NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. =
If it
> is also the local CPU, then we wake up napi directly.
>
> This patch set includes some refactor to the virtio-net to let that to su=
pport
> AF_XDP.
>
> ## performance
>
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> ### virtio PMD in guest with testpmd
>
> testpmd> show port stats all
>
>  ######################## NIC statistics for port 0 #####################=
###
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
>
>
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ########################################################################=
####
>
> ### AF_XDP PMD in guest with testpmd
>
> testpmd> show port stats all
>
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
>
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   #######################################################################=
#####
>
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
>
> ## maintain
>
> I am currently a reviewer for virtio-net. I commit to maintain AF_XDP sup=
port in
> virtio-net.
>
> Please review.
>

Rethink of the whole design, I have one question:

The reason we need to store DMA information is to harden the virtqueue
to make sure the DMA unmap is safe. This seems redundant when the
buffer were premapped by the driver, for example:

Receive queue maintains DMA information, so it doesn't need desc_extra to w=
ork.

So can we simply

1) when premapping is enabled, store DMA information by driver itself
2) don't store DMA information in desc_extra

Would this be simpler?

Thanks

