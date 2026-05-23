Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37414B950
	for <virtualization@lists.linux.dev>; Sat, 23 May 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779570035; cv=none; b=hUYCt9LQL48OXgoBCXuio0T3LNHV+ypw/zNCZ/xZ0uRqjzPnOpMXh8v8h75V4QdHco3pHbhwEXUhoX8R+lzV5OazQzDoUiGYM2hZgYSUHK5+DcZhVPieQY0weZl+/15fLOpPQvtGCwzk7MAg3ALDuRL/XBdel3BxlHDRZtbwz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779570035; c=relaxed/simple;
	bh=jfxbcf+FqpM5A4AkTcArXazVQ76DEoJbdDQ6mB30fuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjjCzSksjF08LkY9Plgq0oLzdRSCLvIY7+yKxjQPkRC+WYIEbno6P4w/XUXpWG135qWHcbzJGDdZYhoajDqO7lTvg6YdPBT4mPr1QtWlk+sT4DEXQAMMjaaUK/7BvjUKHd645jbeWyrexnXaXiTBKn0JD2NLLQ6uQa4glsCp8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NltG4Rmv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NltG4Rmv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd5e373d07so91339547b3.2
        for <virtualization@lists.linux.dev>; Sat, 23 May 2026 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779570032; x=1780174832; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y1y4GAd9p9GhPE4PTa/6ET/JYihYfQNwe+bNAtlVWsM=;
        b=NltG4RmvIapEgZW4iuwpjLojnpjxJ1vnpVM0agoKNj8mNx+K7OY6coBTSUvV8+CVKY
         o57cf/BZSa3nebA0wav84sBpJjZl2nrchgOnIszDL89wHF4cjJ1mk4/QCDbdkdMhF5/c
         jDYEcD0NFOmkIDxgD2A8+mxmWvuJePsSJxygZLffyqFcG4z9yIopH0umZYcHHQPTTc+1
         +AR2WpKYgyZlpmhP3jAKchL0NybfbsqQpiNP1hPNgWjtc/w80Resmh5PkHlBlk9jcVab
         qPo0cwkGSwKDM13AdYgyHs9fb9g9klf++/Qv/Ly7BsBj/Y9NtDlnCl+uXXC/kBf8MqS/
         iyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779570032; x=1780174832;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1y4GAd9p9GhPE4PTa/6ET/JYihYfQNwe+bNAtlVWsM=;
        b=anOWOBDy0hYvscDGBL/jKGxPPgsW1zkSfJZkinnCD5h4101pxLsuF17EuhE1MkERt4
         xc3j4Q4++1kmbk1yJhVqr/VxLA4sZbrOtslwwYlEeuQyzRtc/U8oCBwgBfQH7MTWB8Px
         vi2pjR90SjRi9ITJJOGM6xjXYO7qn15tfpt/iz6Ok4dK0WPRkfxIIQmB/oTtzJKypmvh
         EJZvR/hS6yzb4zg4hpv3i53xS1YHM6HRG9EjKJexoms1twD1C6va6BtUqC3ZGuC0T42D
         djPnakD/9cskpZHwVjhm85Tp03RXqoe57RdDeXGGGDMtaTxyvMjuHRv+IHpNgOoBbWnA
         nFsA==
X-Forwarded-Encrypted: i=1; AFNElJ/DofCOcKLcsf8b3d/CjaW7PZQhj28pf344Fck5BWhSEeVv9MqhtCxkPGGwPEmc1aX71ttJItMaMs6Lj0ieRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0cHwVSQMQ2MLI/1SbKSjIyQMnzVAsK74QEtxPz3T4Iy/y+4Xj
	AnImL91agq5cHXz6KbwFE9FkgGxKXpBHH8rUEZxST5jYRr1QpL3UzElO
X-Gm-Gg: Acq92OFhnosvW43/vUaQfdvTbA9dcHttjOGg7OB6m2ORQd1rM02WDA+K7XXLBrUIq0A
	l90FttUWg54W8qlWJ7v9tGtik6As7vDnCs9ygVM88ab56cejqOCLDJUj9WtDtzVzff3e2Cu/iiz
	NKiUeTPmidBq2VjoN5rQYeLarHsQLAeKOg3Ol0JSIkgVm11GQMI8in3HL8I/S/2R20csF1+tUY6
	jH8Uc6c4Bo3fRXNdgmuXOjzT8m1Yn7QCgjJdQGydq++IcxU4uVcLfvjMB+9iEjKf4ZZQhQnc3jo
	u49qidw64lU3TadY8zj57oRsS0Nx4ZE9MLbP+rqOM6KlaMIsWGiEvB1CnFIwJKQls4Jx7zeYw+X
	WAgmBzV03o76oTXp+LvWhYaCN+f4ks4FzJDfk1pssuPPy/hzIeWz4/ual4VTpLxmN7MyciooK9L
	W+YvzNIrpFV9AX3vSnoFfnUdIYtr8GdRSOsXXaEcpIg7GxoO/iCbv84qJwry994X1tvRWM9MsqA
	6D5D/WMYpIuVenHFeH7VRDY5r1P/dqhcXXETyQ=
X-Received: by 2002:a05:690c:62c1:b0:7bf:55b:8f97 with SMTP id 00721157ae682-7d3352d7236mr101807737b3.14.1779570032382;
        Sat, 23 May 2026 14:00:32 -0700 (PDT)
Received: from [10.138.34.110] (h69-131-147-66.cncrtn.broadband.dynamic.tds.net. [69.131.147.66])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389815c94sm25221707b3.10.2026.05.23.14.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 14:00:31 -0700 (PDT)
Message-ID: <baf184f6-fefd-45ca-a437-1505533e3c81@gmail.com>
Date: Sat, 23 May 2026 17:00:25 -0400
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev,
 "virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>,
 Manuel Stoeckl <code@mstoeckl.com>, Alyssa Ross <hi@alyssa.is>,
 Spectrum Development <devel@spectrum-os.org>,
 systemd development <systemd-devel@lists.freedesktop.org>,
 Val Packett <val@invisiblethingslab.com>
References: <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat>
 <20260508055343-mutt-send-email-mst@kernel.org>
 <af21ZGlANY6UUCKx@sgarzare-redhat>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <af21ZGlANY6UUCKx@sgarzare-redhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Gujcl66gv37bCYoyeDkdkz2X"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Gujcl66gv37bCYoyeDkdkz2X
Content-Type: multipart/mixed; boundary="------------MG0m72mpqD1vVNkrkvWY9xza";
 protected-headers="v1"
Message-ID: <baf184f6-fefd-45ca-a437-1505533e3c81@gmail.com>
Date: Sat, 23 May 2026 17:00:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev,
 "virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>,
 Manuel Stoeckl <code@mstoeckl.com>, Alyssa Ross <hi@alyssa.is>,
 Spectrum Development <devel@spectrum-os.org>,
 systemd development <systemd-devel@lists.freedesktop.org>,
 Val Packett <val@invisiblethingslab.com>
References: <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat>
 <20260508055343-mutt-send-email-mst@kernel.org>
 <af21ZGlANY6UUCKx@sgarzare-redhat>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <af21ZGlANY6UUCKx@sgarzare-redhat>
Autocrypt-Gossip: addr=hi@alyssa.is; keydata=
 xsFNBFpSgoYBEAC4xkCYidG2JlRWulUkTWcx0pHFDf3oSbb6Q872Kb3iDChWgluNVz43hva1
 3xfDo9foV0GoyfGl/ycSCkXX5hlQr7ir/5FN38E7H/yY6tH8+l68iDgIOcb1qY0OYaxyg+Lz
 WesfFQedrmwNTbF4L1BtWzrTR5PflDdhDo5VWSguHGJFSclchcr/6UmMb/gOUN+2ElBC2TE2
 EKY099phZ6DJZ2aZCsclwKIdCpZzXlEmXPAeaH5om6xo90JYv5+sFji40R0Plqec3WC+jTxy
 lGca6IbPdOminuUF+GvsR86eVsgh/0XNK7/zus7gyc4PuMUA1rCoeHcWOBDPgmelgCQyJGXd
 /bXeKuUsGoge58uc7/YNvOh1vfpD3AaEMqAyXfmmUwBnIicml74+2eOpH3Oljfs01g+DhkOB
 MtpVSZSgaIDvP0WG6cbAxImoUasnmNxEDNskfVmI8bsajPW9bt4z5hiP5Q9G3vE0D5HcIFdM
 adOz81PpOwNiUXcjtYV1PWZQ56jbSTOf8EBvsB71WwB+XgVWcPzIlY8hAykiHIO87oV3o71U
 JTAn1Foj7mjSADnY0deleOmar/K5jrK3wvKKM1XlB7PXcGBdkorJC+cbxVsw0ADzMw0c7bVc
 wEE7OFvHjQiIK1lO+lb1cvGBBY3IZxjsjZdA/VsFHFdAeYlzNQARAQABzRpBbHlzc2EgUm9z
 cyA8aGlAYWx5c3NhLmlzPsLBlwQTAQgAQQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAIZ
 ARYhBHVzVtd5u7iIdz5BXnNszfnvUb2XBQJp+DXpBQkQHFpjAAoJEHNszfnvUb2XyMsP/0b3
 VfbvrD6u4ohdpoFhBTaacnMaZVBKr8yHMpD/YFKO3dM5nqne92uoauy5RBknH2gQg667gWtZ
 KpnqgKnV8JCswyepmLqRdJwLnPpQUri5c089QZHVSvjrSXOtcU9MqVA/fU5pHh2j06I1mrEy
 A8uZ5GWqjBwshAI+JmP2uEeEURCQi5XcNso92r//Q3tPm6QhF3B3hbfqZ31Qx17/4Unh6f4/
 8XY9RxXoVLuMQpYXd1lqXwH8+QF0aTXoRuR/p48dV6DpxU7arVvZMpJ5WAzPTcQ7VdJjTkVR
 nWPJ4f1Keun+Y3FkBg4vc3ADqKtNZ4eyTaG7DBD5jBMMLS9KYZM9bzT5Y8eNj6JbqB8JVdS6
 PwHMlBnYhp5v2z9BboyUiNiQPN9oh0ONV9yVMV5wLr5JUofvoMz4pYdaysyCoPaSoR2BYqWN
 HDnqdBvVQqdae8a5cbTPDpiqrT0yy3KQGR+iGqIHa5fzibc755RNzikuDYXC4Rovy7Tsrog5
 rV869o1RMTIxp/vgLm3v8/ZLkNabIpb3UdsnUp+NyvQNXuSZ6mkO4wALVkv+Yud0sqUhtRQJ
 gOpEiEg4DVP92JVBeIM7qpfvmdgP6Z9rTPq7nXEZ6MkCfMolkc1TBoFkNHxIDCCoEKgtESK4
 jVRVTXT/zUGZaTJQ0OK08jSPNjWGZGnvzjgEZyd/yxIKKwYBBAGXVQEFAQEHQCVxoiHOlsEo
 NDKGCbxg4nL3E1CV0MRQCU1hPowd77h3AwEIB8LBfAQYAQoAJgIbDBYhBHVzVtd5u7iIdz5B
 XnNszfnvUb2XBQJp+DXlBQkDR10PAAoJEHNszfnvUb2XRjYQAKOyORIaAhTyKPAX3SezjFWH
 NK1jjtSyL23dnHENbmtYoi0tL/P3cF1PEskT/mJZ6A/ON4lb1Lh84Ux1yG+lGq7wIXIY4RFC
 1dYCQdCa7YKRTxrw6hyuGkJlwTbdCx1rzA4F7JEpI3VV2s2xIcuonMszxslKvaYCvtNLdy6A
 a87oGEdTadCfdm7w1O2YfnMR/XiEHH37jXOPz9zMuBoVpU5pj0DzFrN17vPNwdumgQ6QAfdL
 Xe7suys1hHarqBClX+d2qpj0OI/Bc5nhto2Melhw8V1t57fNIGlSt812+dcp5TK3DWsc1InA
 FOfEo7LLpcptLdM86/3gwul4DqRm9MYIDWnRxdobi9/2Uk7O9412lfakYN0/ap70a6eHn0Ht
 SfGShJfpGDSG13Gy8XfgBNb3tpI39kNNzGfl1i3xscsIyzs6oLrngnH3lnrqyN/ss0a11Knj
 QK+j47whKVBuxT5ZN6slPApn9yv9htZVZlSMXbMUrnkMuP0WSERjC63S9+x2SDgJOM76DpAt
 tEX6QaY4Yd7gQgLnQVR/q9duQz+jnawc9NApS9T5t5XNqfVOPzns7mLa9FU1L/+lhpmpSIO5
 G36q4gc2EX58JAXXqU+RXStAd9L86KyynIsnMD0jf9k4VN466Ew5WXbDjeucltEG0ZMg0WxO
 PMu8tBGvtGVA

--------------MG0m72mpqD1vVNkrkvWY9xza
Content-Type: multipart/mixed; boundary="------------mP30nH0JPZgumXRy2xZFB3Nq"

--------------mP30nH0JPZgumXRy2xZFB3Nq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/8/26 06:11, Stefano Garzarella wrote:
> On Fri, May 08, 2026 at 05:58:06AM -0400, Michael S. Tsirkin wrote:
>> On Fri, May 08, 2026 at 11:41:21AM +0200, Stefano Garzarella wrote:
>>> On Thu, May 07, 2026 at 06:48:47PM -0400, Michael S. Tsirkin wrote:
>>>> On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
>>>>> On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:=

>>>>>> On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote=
:
>>>
>>> [...]
>>>
>>>>>>> For now, we're already doing something:
>>>>>>> merging the skuffs if they don't have EOM set.
>>>>>>
>>>>>>
>>>>>> Right that's good. You could go further and merge with EOM too
>>>>>> if you stick the info about message boundaries somewhere else.
>>>>>
>>>>> This adds a lot of complexity IMO, but we can try.
>>>>>
>>>>> Do you have something in mind?
>>>>
>>>> BER is clearly overkill but here's a POC that claude made for me,
>>>> just to give u an idea. It's clearly has a ton of issues,
>>>> for example I dislike how GFP_ATOMIC is handled.
>>>
>>> Okay, I somewhat understand, but clearly this isn't net material
>>
>> I doubt we have many other options given reverting the regression was
>> ruled out.
>=20
> As Eric pointed out, we can't revert it.

Could there be an option to disable the mitigation in guests, for the
situation where the host is trusted?  There are VMMs that implement
AF_VSOCK in userspace with a backing AF_UNIX socket.

>>> so for now
>>> I think the best thing to do is to merge the fixup I sent (or somethi=
ng
>>> similar):
>>> https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat=
=2Ecom/
>>
>> I reviewed that one, problem is it's a spec violation/change that we'l=
l
>> have to support forever.
>=20
> I have a few points to make on this, but let's discuss them there.
>=20
>>
>>> This is a major change that should be merged with more caution.
>>> Could this have too much of an impact on performance?
>>>
>>> Thanks,
>>> Stefano
>>
>> It's really a POC, real patch is left as an excersise for the reader=20
>> :).
>=20
> eheh, I see, but honestly, this overcomplication scares me. I'll try to=
=20
> think it over.
>=20
>> The correct approach IMHO is to only start using this
>> when we wasted a lot of memory on small packets.
>>
>> For example, if sum(truesize) >=3D buf size.
>>
>> then we'll not see a perf impact unless it's already pathological.
>=20
> Agree on this, which is similar to what I'm doing in that patch. =20
> Reducing the advertised buf_alloc only in pathological cases (e.g. =20
> overhead > buf_alloc).

This isn't enough to prevent data loss due to race conditions.

I'm CCing the virtio-comment list and a few others.

Right now, any application that needs to send massive amount of
data over a vsock is simply broken.  This isn't just theoretical.
It's causing real-world problems for users of Waypipe.
Waypipe forwards Wayland protocol messages over AF_VSOCK,
so it can send a large amount of traffic over the socket.
See https://gitlab.freedesktop.org/mstoceckl/waypipe/work_items/165.

If one is willing to mutate the ring buffer in-place, or to maintain
an auxiliary counter, it's possible to store all messages with bounded
(in practice) overhead.  Specifically:

- If the first byte of a block of data is nonzero, it's a
  variable-length length.  1 byte for messages less than 128 bytes.

- If the first byte of a block of data is zero, the subsequent bytes
  are a variable-length counter that stores the number of consecutive
  zero-byte messages.

That adds a lot of complexity, which is very unfortunate for something
that needs to be backported to stable kernels.  I also suspect it
requires all access to the ring buffer to take a lock rather than
being lock-free.  But it's the only approach that I can think of that
can work with the current spec.

Could there at least be a normative note stating that drivers and
devices should treat each message as consuming 1024 bytes + the size
of the message itself, and warning that anything that doesn't is
going to be broken in practice?

I'm CCing Val Packet (of Invisible Things Lab) and Alyssa Ross
(of Spectrum) because both of them are working on systems that rely
critically on vsock.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------mP30nH0JPZgumXRy2xZFB3Nq
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------mP30nH0JPZgumXRy2xZFB3Nq--

--------------MG0m72mpqD1vVNkrkvWY9xza--

--------------Gujcl66gv37bCYoyeDkdkz2X
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmoSFWkACgkQszaHOrMp
8lOpcQ/+PolGgcpEH8oCYyPHZ3wqE9QFzQ0Tnw1H64yTeR3n9JHh8aT3AypxW6ca
QQANXggvXleIuNT4OBvJwKUEYd2lWEKucLqqU03rd4/maggtWcnGymYsbRRCCy2i
PIKK/fNWLftOU3aVluPG3bVAV7vEeDoaNQ3rQkp0ltbHTTzp9JYdPIF1ekMhtaEy
XHXj1rDv+mb+4JRZJ7eaOsB+npV+BfvAQXzkYDhcO295ijoO7YfNiMSM2+EsaQGJ
oh4Pb7LrHGXNQTmM16N+m0mN4ASSNKEGSEdyrw4cv3b2P3I9+N3Q/7zwEPHA+oNZ
nCso5U15wpZtbNyShkgNzP1ZY7GDf9ScSgeIZVeRM/gv09Dfwy/0ALGhw+8zVRKX
ANZiUNuJmK4DAYti+4yuePAApSvJLrVhztwf73OiC+obQ4ABls518ArMSxgREIGU
C3jj6/On2Y69x5a/bdV1p71Jy4KjVqyE/CBk9oo/UcHlKm1XTSfZ8McFJ4OLncz4
PiEh6xvRLBsm+vnbeuu5EiiMPGF0iJqPzZEoglHGUDzDiBamqLPOpUNEUNd1eCn4
7sfkx+FdZMHqIW4zEo3/uKBipcnIYbmZYkDFsZWzArFt/nI759tefJJELbu4h011
7V3chgFIaU08Mfv2rkTgSjWuQJRW3Lja3+ECFD1HcmbzEcBvoR0=
=7wdu
-----END PGP SIGNATURE-----

--------------Gujcl66gv37bCYoyeDkdkz2X--
