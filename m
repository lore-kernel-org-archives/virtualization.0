Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C36183CA8
	for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387131; cv=none; b=QoFH1GOYM9HbH6LCXqSYUZS9GkGE7VYIwQQfyhi86aTnQUoJtH2lRFMJ0xw36XaA5i91+vy5piihiIoUyCfRrwMQwOOav3ZPzY0B9BanHbPw1aWjL1hw3FXg9noRjocLs2zsq+om4HOvOetiaA4KVzLqv0jQhQOKYwTaovShZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387131; c=relaxed/simple;
	bh=l/HaFVaR7BoDVbAm5WIhT9BDgn54NZwR1ZupQgBLZi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESvRWLUacMKpce47aiv6NkMB0jBBrOCTQze9DCyHFgqGKax7gn9rac8cwxZR+RebNvsuoFR59NM132jUtRPcD1XXK1qnD2BHlQWjbh2imSLAq5xMBy5syYzIvzI/ZTWC/eLUQx/fclOXuKMGtpFLfAFre2JQAfddrB4z2WeO0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NFEoj0Ap; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NFEoj0Ap"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D76784636
	for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 21:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brxHlDvVyNoN for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Sep 2024 21:45:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=dverkamp@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 024D6845E7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 024D6845E7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NFEoj0Ap
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 024D6845E7
	for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 21:45:27 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a8a913874b8so21779566b.2
        for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727387125; x=1727991925; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wFqYL8EpKHPQ4Z9/fkdSdMxzIWfj+vpRDsv1wr/BYg=;
        b=NFEoj0ApbzQ1ZCTXsVuriTvEiDFF/oSE01zrfOtkiT860A5NYPvApyN82qYLky7hqb
         tzyjCpG+waaN6WSJW2gO3w1UhqAE9epMELBwWIeYsVB/nj4OnBzyJIPIo+ytJmJkaili
         TAU+u2aJkVgdYZ9U7k5p8lOzlMnk1nAyVCeIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727387125; x=1727991925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wFqYL8EpKHPQ4Z9/fkdSdMxzIWfj+vpRDsv1wr/BYg=;
        b=mt5Kqr9FAIG8eIm5qiMDq75cgLhQpIq6W3QCWDVjoWPJ+08cHnOsG0BjyMFpV/EwgM
         4peDF61tcN3ibdTLtaZa3NB+B6z3/fHCHnosGpnaE1+41cqwNiB++nu8wQsnfGMs68+f
         jLPARq0bQfGBQehIak0yBVyqnpkQ+Dg0hTvorejO7SCnc4yFuAymBwYs3W8e25tas0ge
         rAzLlwcETpxlqynMXCnUPZFeoh1Ts7X7wTYdC7gChRG/GEDQoaGsyYHf1flxSbjAPuoJ
         lqvOAlCG9kXuxv1aY5R5Z9dJXQVW8zEocPwaZYYk1EHEsUDWA3N/aNP7UZuKiKkeMggh
         hJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW74uQM5YT1DKFIuwcYtZT4xIxoHhRkt79UqxTX5TFMGFzvoDxBzWTU3d7YEJoFoi2P7bcIHEZJn0UpolVRPQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyX42t6v8E/uWwOTv0QcHnCmcuNxVjNQmCxWALXQYmcrA74hHQR
	8kXfNhIlRfE7ga/aNNyrhpO9TTvM5hUdnr4XIuj5l44l40XvmG6+arMsV9Ksm60l8MY0xoCZ7x4
	=
X-Google-Smtp-Source: AGHT+IE+MyjvKW3i9jADJilUGGWsaG9zV2L+kjuuc+MzUM4PlYa1CSF7VAvK49iMkhRmfP7xRI28MA==
X-Received: by 2002:a17:907:6d0d:b0:a80:ed7e:8468 with SMTP id a640c23a62f3a-a93c47d88f3mr29784966b.0.1727387125147;
        Thu, 26 Sep 2024 14:45:25 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27770b4sm42027866b.42.2024.09.26.14.45.23
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 14:45:24 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso691822f8f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 14:45:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWv/oKbLHmOLbFA5FCtb6J4BwVITUf77CspfHQUWcFoO59R3g0uEFItv/FUJP5/GBS4magYULNVmNqRH4qrDA==@lists.linux-foundation.org
X-Received: by 2002:adf:cd8b:0:b0:37c:d179:2f6f with SMTP id
 ffacd0b85a97d-37cd5b2d543mr517922f8f.58.1727387123192; Thu, 26 Sep 2024
 14:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925145228.27953-1-mgurtovoy@nvidia.com> <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com>
In-Reply-To: <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 26 Sep 2024 14:44:55 -0700
X-Gmail-Original-Message-ID: <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
Message-ID: <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:42=E2=80=AFPM Max Gurtovoy <mgurtovoy@nvidia.com>=
 wrote:
>
> Hi Daniel,
>
> On 25/09/2024 23:57, Daniel Verkamp wrote:
>>
>> On Wed, Sep 25, 2024 at 8:05=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.c=
om> wrote:
>>
>> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
>> set.
>>
>> The blk_size field represents the smallest addressable unit of data that
>> can be read from or written to the device. It is always a power of two
>> and typically ranges from 512 bytes to larger values such as 4 KB.
>>
>> I agree that this is what the blk_size field probably *should* have
>> meant (matching other storage protocols like ATA, SCSI, NVMe, ...),
>> but I believe rewriting the spec like this changes the meaning of the
>> blk_size field in an incompatible way.
>
> I believe that this is more of a clarification than a re-write.
>
>> Previously, blk_size was described as the "optimal" sector size, so it
>> seems clear that the driver is still allowed to send requests that are
>> not aligned to blk_size ("awareness of the correct value can affect
>> performance" but no mention of correctness). A device may need to do
>> extra work to support this, of course, such as turning an unaligned
>> write into a read-modify-write sequence if the underlying storage
>> device doesn't support such an access directly, but such requests are
>> still valid. It's also perfectly fine for a driver to ignore
>> device-offered features like VIRTIO_BLK_F_BLK_SIZE and still operate
>> correctly.
>
> A device should report its block size (logical) using the VIRTIO_BLK_F_BL=
K_SIZE feature. For legacy devices that don't report this feature, Linux as=
sumes a 512-byte block size.

Sure, I agree with both points here.

> Drivers should not ignore this feature when it's offered by the device. I=
t's crucial for correct operation IMO.

This is a "should", not a "must", though - adding a new MUST is a
breaking change.

> The statement "driver is still allowed to send requests that are not alig=
ned to blk_size" needs explicit clarification in the spec.

It definitely would be better to have it written out explicitly, one
way or the other, no disagreement there.

> From my understanding of the spec, the driver is not allowed to do so (ot=
herwise error will be returned or the behavior is undefined).

This doesn't seem to follow from my reading of the spec. Otherwise,
phrases like "optimal sector size" and "can affect performance" would
not make sense (such a request would instead be described as
illegal/returning an error).

> In Linux, the reported blk_size is used to set logical_block_size, while =
physical_block_exp is used to calculate the physical_block_size.

Sure, but this is describing the behavior of one driver
implementation, not really relevant to the meaning of the spec.

> Regarding the specification statement: "This does not affect the units us=
ed in the protocol (always 512 bytes)":
>
> This likely refers to how certain fields in the virtio-blk protocol are e=
xpressed, not the actual logical block size used for I/O operations. For ex=
ample: capacity reporting, max_discard_sectors and Other fields that are ex=
pressed in 512 byte units.

The way the fields are expressed in the virtio-blk protocol is what is
relevant in the virtio spec. Even if a virtio-blk device is sending
requests to a physical SCSI/ATA/... device behind the scenes, it's the
job of that virtio-blk device implementation to handle the translation
and whatever mismatches there may be between the protocols.

Particularly, the "sector" value in a virtio_blk_req used for
VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT is always in 512-byte units,
regardless of what blk_size the device reports, and regardless of what
underlying physical media may be used.

From the virtio spec: "The sector number indicates the offset
(multiplied by 512) where the read or write is to occur."

(This could probably use clarification that the "offset" is in bytes,
but it still seems pretty clear that it does not depend on blk_size.)

So a request with sector =3D 1 always means an offset of 512 bytes from
the beginning of the block device, even if the advertised blk_size is
4096.

This is different from (e.g.) a SCSI READ where the logical block
address is in units of the block length returned by READ CAPACITY, so
it is impossible to send a request that is not block size aligned.

[...]
>>> diff --git a/device-types/blk/description.tex b/device-types/blk/descri=
ption.tex
>>> index 2712ada..88a7591 100644
>>> --- a/device-types/blk/description.tex
>>> +++ b/device-types/blk/description.tex
>>> @@ -3,7 +3,10 @@ \section{Block Device}\label{sec:Device Types / Block =
Device}
>>>  The virtio block device is a simple virtual block device (ie.
>>>  disk). Read and write requests (and other exotic requests) are
>>>  placed in one of its queues, and serviced (probably out of order) by t=
he
>>> -device except where noted.
>>> +device except where noted. Each block device consists of a sequence of=
 logical
>>> +blocks. A logical block represents the smallest addressable unit of da=
ta that
>>> +can be read from or written to the device. The logical block size is a=
lways a
>>> +power of two. Logical block sizes may be 512 bytes, 1KB, 2KB, 4KB, 8KB=
, etc.
>>
>> Does this imply that a device may return an error for a request where
>> the sector or num_sectors fields are not aligned to the blk_size? If
>> so, it should be called out as a more explicit normative requirement,
>> but that would definitely be an incompatible change.
>
> As mentioned, the logical block size, such as 512 bytes, defines the smal=
lest addressable unit for I/O operations on the storage device.
> This has important implications for I/O requests:
> 1. Minimum I/O size: You cannot send I/O requests smaller than the logica=
l block size. For example, with a 512-byte logical block size, requests of =
128 bytes are not valid.

128-byte requests are not valid, certainly, but that is already
covered by the wording in the spec ("in multiples of 512 bytes" in the
VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT description, and "The length of data
MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN and
VIRTIO_BLK_T_OUT requests" in the driver requirements).

> 2. I/O alignment: All I/O requests must be aligned to the logical block s=
ize. This means the target start address (on the media device) of the I/O m=
ust be a multiple of the logical block size (the expressed units in the spe=
c are not relevant).

Unless there is a change to the spec (like this proposed patch), I
don't think this is required. I suppose a device that can't manage to
perform a misaligned I/O could choose to deny such requests and return
VIRTIO_BLK_S_IOERR, but this is not explicitly allowed or denied by
the current spec.

> 3. I/O size granularity: The size of I/O requests must be a multiple of t=
he logical block size. For a 512-byte logical block size, valid I/O sizes w=
ould be 512 bytes, 1024 bytes, 1536 bytes, and so on.

Same as point 1 above, the only requirement (that I can see, anyway)
is that the I/O request has to be a multiple of 512 bytes.

>> The "smallest addressable unit" wording is also more confusing than
>> clarifying here, since in virtio-blk, the "smallest addressable unit"
>> is always 512 bytes, regardless of blk_size (even if a change like
>> this would enforce limits on the sector values that would actually be
>> allowed, it would still be possible to create a request that refers to
>> a smaller unit than blk_size, unlike other storage protocols where
>> logical block size changes the multiplier of the address, making it
>> impossible to address smaller units).
>
> Can you please point me to the place in spec that explicitly say that "in=
 virtio-blk, the smallest addressable unit is always 512 bytes, regardless =
of blk_size" ?

The description of struct virtio_blk_req's sector field:
"The sector number indicates the offset (multiplied by 512) where the
read or write is to occur."

Unless we have different definitions of "smallest addressable unit",
that seems pretty clear. It is always possible to address a part of
the disk in 512-byte multiples (e.g. sectors 1 through 3) even when
the blk_size is larger than 512. Maybe those requests won't succeed,
but it is always possible to describe a region of the block device
with an address that is not a multiple of blk_size.

> I didn't find it in the spec and I don't agree with this call if it is im=
plicit.

I agree it should be clarified. The current wording requires too much
reading between the lines.

> The implementation of the Linux kernel driver isn't implemented in this m=
anner as well.

When filling the sector field, the Linux virtio-blk driver uses the
value of blk_rq_pos(), which is also always in units of 512 bytes, as
far as I can tell (it returns sector_t, which is in units of 512 bytes
per the definition in include/linux/blk_types.h).

[...]
>>> @@ -228,7 +234,7 @@ \subsection{Device Initialization}\label{sec:Device=
 Types / Block Device / Devic
>>>  \item The device size can be read from \field{capacity}.
>>>
>>>  \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
>>> -  \field{blk_size} can be read to determine the optimal sector size
>>> +  \field{blk_size} can be read to determine the logical block size
>>>    for the driver to use. This does not affect the units used in
>>>    the protocol (always 512 bytes), but awareness of the correct
>>>    value can affect performance.
>>> @@ -282,6 +288,12 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
>>>
>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Types /=
 Block Device / Device Initialization}
>>>
>>> +Drivers MUST negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered=
 by the
>>> +device.
>>
>> Why is this a MUST? This is also an incompatible change since there
>> was no such requirement before, and drivers are free to ignore
>> features they don't care about.
>
> I can say SHOULD, but then the driver that is ignoring this feature may g=
uess/assume the logical block size and it can be wrong.
>
> This may lead to an undefined behavior.

Unless the spec is changed, if a device can't correctly handle
non-blk_size-aligned requests, this seems like it would be a device
bug ("undefined behavior") or at least non-spec-derived limitation
(returning an error would not be undefined, but also probably wouldn't
result in a working system).

Certainly it would be preferable for the driver to send aligned
requests, but the existing wording seems to cover that pretty well
already.

Thanks,
-- Daniel
