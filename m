Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60F3E9C3C
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490244; cv=none; b=hOORqmkR+msaCIms96ViQzPW8mH+YXQX4OemI3sWuZC/7/fdaKZ4KYzodhlTSn2ptdc4ELyxtRIurHCaEA1aoYlPh7SnxZUCUcbVAVmIDCyXjeIcyigzt8CrtX2nFYqSd0UCjb/FI2jMJCyrQ94YEVB7rodiK+o6V+/8N5PXaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490244; c=relaxed/simple;
	bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ayoOA6OEfMaFmsqwOrs5xlGqCeMPDdVsLnKR9JPoFdeZCdb/ULNNuEvRdSm17fkW6X/xuKuxWcLqaqjf0/EkLo8/9wBw9ppm+wH+nojRsYRMBoJTcC7w4WgHVgBHTAYT6FE2O4Pt/vd3YDoGBWKWrci3bapPpFsew93uJqDTDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqmP2TCj; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqmP2TCj"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-823b938464fso4344889a34.2
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791490238; x=1792095038; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
        b=bqmP2TCjTeInPuoeqHorwuy4Q+xd9GSdgjIuPpUNLr9Q520Fn1E2wFa99CdziI95T4
         R2nVuGajM/WCx1sqVb1C28+yyaqPW0fnu64+3KdsOHOPULIlKlA6OB+PCYDZ7JCpEm1m
         8rWnS7qfI5HMjrG+texq1R6b36xPVK1dNYlmYfLMLs+Qffo8Al6WGyUCKlmmB6dHR2Nm
         IDImCHCzOR5FuM4/6phWe0eZRP65FY/gT+9hs6mEZScXYiKKxBaC+RSRaFXMPiH9TsbH
         AXZnCxA4nPxCe9qEdfwOAbN/L4c/k+25QX8669RjSaQK/y/PJKsbi+5OkTg1GY/yJNM+
         hQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791490238; x=1792095038;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
        b=YL8YeN9QRcLFX0qo+XFaAp/nazvJafljB2NUtJiH19C1wM7lR2yBE+aoeEGr33/0j4
         BrJmshjkVI2z9MhCVyhg7qwm4qn9lJ9gcIT+dQ6/CFRbuTDv+NrIoh2t4wDgYGRhIuoM
         KpeHpZSuMyZOkWEJrJ3pFESpKMz0wp62pcRYyPKHV/qi61q+CbqN17pXl4whOB/Wp1xM
         Be+eUnTMTbDOHfE2UVKxynz6XlA7ZMogLZYy0xif1SnHs28Cx3WdHVVvErQMtk6Hh/7H
         csJwRrOf4yWjNvNV0MBS7bMLFcALHNNMMA0lqCM4AEEqM6T5YmoKW9dgE39HP/MfXVFE
         by5g==
X-Forwarded-Encrypted: i=1; AKwUvBxGBf7iNuxN0hD8AA2Tf4mLDCwfxbHXPSjNVZTZ21fVFCoHZkoHOyW+dgDtVGT9eXE65pa1PWeLRkFqO4yx9w==@lists.linux.dev
X-Gm-Message-State: AFuF++kWla/oFHpg1sCLhJwenKDWTvuWwB/Vh9EyPnipXZ6IW4k7AzPD
	YI3uijiyXJs1XtpV0euI41l6NDSkCeGkYELiO3nYOWbP52FASAcps3wE
X-Gm-Gg: AYBFou3piFm3XqWxXeDajpmpl/dEi343SgU+YKIprY9ZJQL9ru1V2gu7Ii/RcXu7fxt
	ILILGptS6J7aL7r9PZhvE05PWysBzgcysexYmGYwW7zM3LSFTEzgY9wIAzpgFo3d5TVkCQHx1zu
	P1o6a60i3/gNvM6Ma7XSieosnmlDCFLCIW6Vsixf9Jjv6/+KUBm7EErkCdKYZY+otZlmvEMVbBT
	vZ9sFHIc9RGrIJwoL64VoNW7ATxgq9wxKVEgiEyFCLvEc4vvZHCzBlqBJI3ZqF6qASQz8U4paxA
	z2CSeeyICkKHGVDxoh5jMzn54JWM2R/xUq9QiQ+Yo6ryaICt+7NzP3cRIBa+EbzygP1DE4D9pP+
	tKxxZKxmc0jRY4KfQ/07OW9V2NSQIN+XdODADzkX6UmPDLE0VbofHC0KrII0pnL4EbkRVAbDx0z
	cRp23IxMfPuS44Uln8U3U3K+SWMTZHOLSNRbQRDO11xmYAKUdENUpvG0C1YLm1Pc4YusVZwH0JM
	jnqdnCGdq00MSC9oTCvZFhGr2o=
X-Received: by 2002:a05:6830:2105:b0:806:9a8d:4b9b with SMTP id 46e09a7af769-82acf49f6a5mr7338564a34.15.1791490237678;
        Thu, 08 Oct 2026 13:10:37 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:220:4650:f501:3b3:565b:2d79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82fc7cc90aasm601054a34.4.2026.10.08.13.10.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2026 13:10:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [RFC] virtio-net: AF_XDP zero-copy TX checksum offload
From: Azadeh Aftahi <aftahi334@gmail.com>
In-Reply-To: <1791423335.8486545-2-xuanzhuo@linux.alibaba.com>
Date: Thu, 8 Oct 2026 15:10:26 -0500
Cc: magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com,
 sdf@fomichev.me,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 mst@redhat.com,
 jasowangio@gmail.com,
 eperezma@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FA6FB0F-51BB-407C-BD2B-A13FC2FC94BF@gmail.com>
References: <9DB6FE89-98AB-47CF-9B57-5F47FBB6DAE8@gmail.com>
 <1791423335.8486545-2-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi Xuan,

Thank you for the response and encouragement.
I'll proceed with the single-buffer AF_XDP zero-copy TX checksum offload =
work and share an RFC patch for review once the initial implementation =
and tests are ready.

Thanks,
Azadeh

> On Oct 7, 2026, at 8:35=E2=80=AFPM, Xuan Zhuo =
<xuanzhuo@linux.alibaba.com> wrote:
>=20
> On Mon, 5 Oct 2026 17:28:35 -0500, Azadeh Aftahi <aftahi334@gmail.com> =
wrote:
>> Hi all,
>>=20
>> I'm planning to work on single-buffer AF_XDP zero-copy TX checksum =
offload for virtio-net.
>>=20
>> Current net-next's virtnet_xsk_xmit_one() does not consume XSK TX =
checksum metadata and uses the shared zeroed virtio header.
>>=20
>> I found Xuan's 2021 proposal anticipating separate headers for =
checksum support, and the merged 2024 zero-copy TX series, but I =
couldn't find a checksum-specific follow-up implementation.
>>=20
>> The proposed scope is to map the existing XSK checksum metadata API =
to VIRTIO_NET_F_CSUM, using a DMA-safe per-packet virtio header whose =
lifetime extends until TX completion, with corresponding completion, =
reset, and unbind cleanup.
>>=20
>> I would keep the initial scope limited to single-buffer TX: no =
multi-buffer RX, timestamps, launch time, or GSO.
>>=20
>> I'd also add checksum and header-lifetime coverage using the existing =
XSK selftest framework with QEMU/TAP.
>>=20
>> Is anyone already working on this? If not, does this scope and =
per-packet-header approach sound reasonable for a follow-up patch?
>=20
> It seems no one has taken this work forward yet; I would welcome it if =
you were
> to do so.
>=20
> Thanks.
>=20
>=20
>>=20
>> Thanks,
>> Azadeh


