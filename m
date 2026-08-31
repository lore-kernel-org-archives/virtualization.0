Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE1370AD4
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157323; cv=none; b=t+73I2u5G7LIlpvUzgfw3o9FiOrD+3X8xU/qK/9khJd7j+tKtv/MUvP6kl1mSIeMQ0HGJbkTnaWdNqvePMEj/6XI/katF4oSiiskP7sBAZDtYOR3hRRse9gstq+Pr9SloKEjy/8CQUXdh598hq05NsAEugCU2VUIy/h+FW+H+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157323; c=relaxed/simple;
	bh=WqBC9k9dQo1Fkp8FeGnmJpcacq5DVytNnWXm1742Lso=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mmDhy3Nf2EqBMgs7jQN0PaFCJSXkSBquzmVk6zHTpEPiDzwpRL0jel/PKp1NhWgqF3npUV7g4KFspxQ3PQzn7YMGC+AlKeuTQCTCPV7g0pr2aC2hhjoyiFBkltupPLSytROlZ9csvzsMcrlz6eUsSz5QsFfaqQL3bRtbSEi4/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kn1YWkQ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jHJhKj4B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kn1YWkQ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jHJhKj4B"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52ZRQ2017641
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 06:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wcg0Ez9nJOyV/8LnbrobWqWP9ec96FQgJeXfFdTZe98=; b=Kn1YWkQ+vhRQHjuO
	SVI5IsM2hTE6k/B7tdf0xyH4PlNsXgYl0N7x5vnWCEca9O8XKKg3jahYZUWkPR0n
	+qeSVd8FRmIHiewURxfvjSJx+uB64pJtZrLrdWPHjCg9DpizkuocQjaFcrVAYkdA
	WDc0L3w92gEM5Q6XgPxrcAVACH75rTknrsWOyWoifZj6aMGpw+/JdPW8KpmmqdTR
	2DNyt5eb9xVa2A/rliKmaFuK9WT9pS/5fEYovg4utjnON5Xd8G3nJx79Paor08QO
	Y4IZqDQaCcKxlz8U8G4vQ1MSFmarnUr5FdbXlPv8RgNsz599hGjCmB4+7NR8x6nI
	mTa+6g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6mt9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 06:22:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so138924a91.2
        for <virtualization@lists.linux.dev>; Sun, 30 Aug 2026 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788157320; x=1788762120; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wcg0Ez9nJOyV/8LnbrobWqWP9ec96FQgJeXfFdTZe98=;
        b=jHJhKj4BpkJCRDWdPselNokiGP+7KlgE0jp/RjOdJM36fr7AtXkWoru4YCTCZpk3gR
         kzwSIdQK36WV0Jtn7jixZdrieiLs6LEugn7urMMkOssDkRp4OIc32ENmn6FYopUUFM1z
         uZhF4MP02vbX87Lwmanepbw4ow/LBOxRy2AYKENof4AuZ+tACWW98xGOuF86tSfH6C/L
         kUa9ntSCX7gHcFiHbOWJP1u91z3lpCk31JsXcyPZW2YpiCmXWV1TaLOQ3IhrAGdBBsP2
         N43q6fj5G2D3EhMZIN0/Vb9vvRdTUktebkqVLCep46ROTjKSLfrL/WLBI9s9EuMDZanx
         DUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788157320; x=1788762120;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcg0Ez9nJOyV/8LnbrobWqWP9ec96FQgJeXfFdTZe98=;
        b=N9bvXOUmAK43SQgk0xa3PCJiA/ckNaTnb+g35QcPAnoS3TPV680JhAEyP2M0lreHkQ
         56tTMCtj30jpXZpPy7oQaSlYk46ssGPOqZtaHoQ+d9BpDAoVW1vIvxwDDc/zPFuWFBDQ
         usUx58MLCD5xrOXCtf4MllA71m3QiLUi/Eg7F6fAwMQz8vk2U5Sm0RMiBZ2iGP9siaV/
         Cr/L2rvFaET524v5kY7lardu9NvFaydkKmN54CCOHzZgHou9d4HVLyshrEYCILBRmYpS
         PyRyfpD9I0LtVpZPOw4Kw1R0DoB+w1DSOrJ5sioRZddGcuzU9xOKU0WOXntj3vNAbQLG
         2Avw==
X-Forwarded-Encrypted: i=1; AKwUvBzn5aEtNMwS5SkMfe00+SB5LrRLUX80aKUWdrPVf8NMPA/xthx9H4iAP4shRYFrLm0FvYuCIGEaUNy7fHm0hA==@lists.linux.dev
X-Gm-Message-State: AFuF++nwkAEgTy1/iAyu4sliJ1qaS6xYkENQmjxWv8mfz+jR3jMrn2XF
	qBAmHkyxwc4m/zZLa/D8d5Cux/+V/d2A3GX7CNdynyoeI+yLVNPMdZqb82SMH3hJCDcHV7hAzRL
	jcEuejKHZCjmZs+jvwpwOmrEGTe8OHL/apIOas6A05ICH+cXNI3F59XCLFjk15CWr7tJPFg==
X-Gm-Gg: AYBFou0RCIEw+xZdBpwYO3A/zAS8DnoKlfjLG4stqZ137MPig719OpCD8HSNI+KFBHU
	egWAUJZIuAVRdRxNAp1AZci7D0D3/zpsfIFS7ITDJqpuYidVYOIY2E/z7VSj85Rn6vNwGMa5KzU
	gm7Cro4IpyVuY03lfqp5LNNIyZ79Yn8tAKMqIm4W7g6EODGtIULjhgVu9/gZkjgXlQ4z1gg6Piw
	yHlgCIUtu+cRcZ12xRC64bAZF14WHDJRN233vAhzR8exve/fHhqHopO4L7ErwYErIDOhYJVfDfY
	fnkwO5ADN9BH5kF+yq4QomGISO7eexVWRVJ7pLb0dyYKDJ82YvSw1pLFVP+bEAiURQp0rMsbojk
	tC7HNe2NjqXL+YA319aK2r3CJEMEht0T6yjx5mWvCCWpws0nAsDwf92f1gg==
X-Received: by 2002:a17:90b:4d0c:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-396d0dd5069mr33909575a91.7.1788157319609;
        Sun, 30 Aug 2026 23:21:59 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0c:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-396d0dd5069mr33909493a91.7.1788157319060;
        Sun, 30 Aug 2026 23:21:59 -0700 (PDT)
Received: from [10.110.79.126] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d38207sm25010026c88.5.2026.08.30.23.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 23:21:58 -0700 (PDT)
Message-ID: <e09d1622-29aa-43f3-8e3f-776dc78c3641@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 14:21:50 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] FBE virtualization: inline encryption for
 virtio-blk guests
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
 <20260827184219.GB2137493@google.com>
 <d81e347e-8ca7-40a1-a428-5bce6f0d4b02@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d81e347e-8ca7-40a1-a428-5bce6f0d4b02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gYA5XisfNqNCpwhGXLtyf5fghmGHkuvS
X-Proofpoint-GUID: gYA5XisfNqNCpwhGXLtyf5fghmGHkuvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1MyBTYWx0ZWRfX7Uy7KZlAOT7s
 JMWhgBRy6tX0ENO2XGxj2B2Qz9eAlnyBjt5QndN7SaAgn1dWduaKlxIZ7Zb+/sCFra6zpsG+Twi
 mMkRIFRHfF2C8J3yb8xuqqR72V0CaVlau5xSoXQ0sL0VUOHr6WQ7mXbhuGY1hlSjDKmg/7XYCUu
 Mm/bkSC+zx41ZkVWf/0ccH+OsYiHCDfS49jUpHQqhqTNtN8v9zUUkKMmTE1ditxZHHLtsHRcsFq
 +L0anLnUNKdpaIJ3rYOsHr6G/4/QQLP7TBT+KkSvgT9xwLEMbGAU5vpnYeUdXvX2Gon3py0KVvu
 FdAl5RWmoUrXqBhk/GCS7lnnzktw6vmfGODEo6Yy0ksryhhHKiBu2muV4qSmogHI66Se7Aq3GKz
 //9Qq7Fp3EPK1JLkIQ5gfjqAEHPL7yONLbgTTbgnudxxt6uuJUxDLNxsc+yTIHxvmua0D/vZVb2
 L4tFt5eWZ7izWcABGKQ==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a951d88 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_h6NAR8LnRz2utxSRfIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1MyBTYWx0ZWRfX6CZ8/KUQwlt1
 QYtmaLBboImjLV1KsqbgLGYE6kEqfYonXnd3IXLfQGhBgiqxdd20w1KRIeaYp7R/HjUVXZL6B4l
 z73HesbrEJLhG7cCHgqQAdbx1smpdM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310053



On 8/28/2026 11:37 PM, Linlin Zhang wrote:
> 
> 
> On 8/28/2026 2:42 AM, Eric Biggers wrote:
>> On Thu, Aug 27, 2026 at 09:07:09AM -0700, Linlin Zhang wrote:
>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>
>>> Current virtio-blk does not provide a mechanism for a guest to
>>> program hardware keys or submit encrypted I/O using pre-programmed
>>> keyslots.  It drops the crypto context when issuing a bio request
>>> to the virtio-blk queue, preventing inline-encryption-based FBE
>>> on virtio block devices.
>>>
>>> This series enables File-Based Encryption in guest VMs on Qualcomm
>>> GVM platforms where the ICE inline encryption hardware is shared
>>> between the host and guests.  In this environment the guest kernel
>>> has no access to the ICE hardware directly; it supplies a virtual
>>> keyslot index and data unit number with each encrypted I/O request
>>> via VIRTIO_BLK_F_INLINE_ENCRYPTION, and the host must translate the
>>> virtual slot to a physical ICE keyslot and submit the bio — without
>>> transferring raw key material across the VM boundary.
>>
>> This seems to be designed incorrectly by not making virtio-blk itself
>> support key programming and eviction.  That complicates things
>> significantly by then having to handle the key programming and eviction
>> out-of-band using Qualcomm-specific SCM calls.  It also means that
>> adding other implementations of this would be very difficult.
>>
>> There are some claims that not transmitting keys across the VM boundary
>> is desirable.  But that doesn't seem meaningful, given that all the I/O
>> is transmitted across that boundary in plaintext anyway, and also it
>> seems that hardware-wrapped keys will be supported too.
>>
>> Please make virtio-blk support the key programming, eviction, and
>> HW-wrapped key management operations that are needed for this to work.
>>
>> - Eric
> 
> Thanks for your comments!
> 
> Not making virtio-blk itself support key programming and eviction is
> something done deliberately. Based on that HW-wrapped key management
> operations are also handled in the out-of-band path.
> 
> There are bellow 2 approaches I investigated to let virtio-blk programming
> the key.
> 
>   1. virtio_blk implements blk_crypto_ll_ops interfaces, including program
>      key and evict key interfaces.(Same to 'the virtio-blk interface standardized
>      blk_crypto_ll_ops requests' mentioned by Stefan in the virtio SPEC thread)
> 
>      The guest's block crypto profile manages the keyslot in virtual slot
>      format in this scenario.
> 
>       - block crypto key and virt_slot index it passed to the hypervisor's
>        (EL2) device emulation (QEMU, using QEMU in the following) which
>        runs in userspace of the host. Besides of transferring the virtual
>        slot to the physical slot, a programming block crypto key UAPI need
>        be added. Follow current blk-crypto design, it may be like
>        BLKCRYPTOGENERATEKEY. I thought this results in a security risk that
>        allows userspace process a key into a key slot.
> 
>      - For key eviction, it's similar to above key programming handling, also
>        need a key eviction in blk IOCTLs, but leads to the security risk
>        that allow userspace client to evict a key in a key slot.
> 
>     virt_slot, DUN and DUSize is appended to virtblk request during crypto
>     I/O.
> 
>   2. virtio_blk implements blk_crypto_ll_ops interfaces, excluding program
>      key and evict key interfaces.
> 
>      The guest's block crypto profile doesn't manage keyslot for the guest,
>      the host's block crypto profile manages keyslot for both the guest and
>      the host. The trigger of key programming operation is moved from the
>      guest to the host.
> 
>        - The whole block crypto key (key size, key bytes, blk_crypto_config)
>          and DUN are appended to the virtblk request during IO, a little
>          high payload.
> 
>          The backend parses the crypto message in the virtio queue and
>          construct a block crypto key and DUN for the bio_crypto_ctx
>          set to the BIO. So that the IO flow in the host can program
>          the key. 
> 
>          The question is that the blk-crypto-profile distinguishs the
>          block crypto key via the key's address. But the host has
>          different key addresses for the programming and eviction key
>          operations of the same block crypto key from GVM, because the
>          key is re-constructed in the host for the key program and
>          eviction operations. 
> 
>          To fix it, the approach I thought is maintaining a new key
>          hash table in the backend, and comparing the block crypto key
>          content and DUN parsed from virtio queue with that in the key
>          hash table. 
>          My major concern is that this need keep the keys synchronization
>          b/w this new hash table and the blk-crypto-profile's hash table
>          carefully, avoiding that key is still present in the
>          blk-crypto-profile's hash table, but removed in backend hash
>          table. Another point is that the whole block crypto key and
>          DUN are appended into virtio block request per crypto I/O.
> 
>        - For key eviction, adding a key eviction in blk IOCTLs allows
>          userspace client to evict a key in a key slot. I thought this
>          is a security concern.

Correction.

The key eviction operation is also moved from the Guest's blk_crypto_profile
to the Host's blk_crypto_profile. As a result, the entire block crypto key
(including the key size, key material, and blk_crypto_config) is appended to
the virtblk request. The backend parses the supplied blk_crypto_key, looks
it up in its key hash table, and can then invoke blk_crypto_evict_key() to
evict the corresponding key from the ICE keyslot. Unlike Approach 1, Approach
2 does not allow the guest to specify the keyslot to be evicted through the
block ioctl interface.

I'm appreciated if you can share your insights and thoughts about these 3
approaches.

> 
> 
>      This option doesn't need map virt_slot to physical one.
> 
> 
> Taking all the above into account, I made a compromise to implement
> blk_crypto_ll_ops interfaces in a out-of-band path, which lets the virtio
> blk only need focus on the data path. I agree that it is complex than
> the second option mentioned in the above, but small payload (only
> virt_slot, DUN, DUSize) in the virtio block request and no security
> risk of key eviction from userspace.
> 
> 
> I would like to hear your thoughts about the above and am appreciated
> if you could share your insights about the design of inline
> encryption in virtio block.
> 
> Regards,
> Linlin
> 
> 
> 

