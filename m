Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183335DA7B
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931490; cv=none; b=du66d2a9szpHIuQIYH9svZG+JIe8n03gYUX2fEw7ERhbCEU1UismcLaADutBvml4H0/InvnfvMcv/BGPjZWuAwlBaRYXx9JnAS00vWXpPeicsiJLTVT0N8KRwGZlb/eiBqTkvm1GfhGl51N+h4C8zg4XCYl3dtGRb9WazrK/+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931490; c=relaxed/simple;
	bh=cz3F+ErOy0RXfPiWVt2Rk09qsZ11xAKIDCmzOQpDc10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3giUARPz9DEcwJZeggu4dS27XVmgry/1pQbV6SEDvyH6s2vR+L0FY2srEKhc45D6q8C46MTIyHdnHqLRdc8Tjlu1O6yBV2SMJsN6OtR+XdM3Rr4dzJQbee1ME0HDLMTUujpHCmrwJAwL1/alCPUN3SBCnzdjIR/6+lbnYe3UKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K92Tm9LY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KaqFTw/k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K92Tm9LY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KaqFTw/k"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDke2p3545318
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 15:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BJdt0aDQo3QWYjdT6UEMt92s1/oBkWrWP3BZCycXw4Y=; b=K92Tm9LY6warnFMn
	r+KgWglRN5lTmnNv4TYdixWUW6+LNsArcFIQRkefUgXn/+GVgm1HHB88snwc8YWk
	EW4K64uIBy6dTmpLtqj+AjTGh9Vdh0EjPhFic6UXf8P3SCkwVsGsbq8ZF5Z6kSKO
	SGmJo81d+l6vdqdOmM2lMkUEqoj4z85gHnp1IfCicCqL/suABpsn+Jd3mpcAvQ8+
	OHf+bhdX6IrbS7YloXPyPevYHkCpedIznh9wsz+fLli61XmyFFADDoyacKHNH1+K
	ewHwLWtaer9PqpugYeNWIFwKeX9mCLHkdmvdeZyCLVkBCBbuFUGCbRhrzZEbwsaZ
	1JX+4A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb47n2cay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 15:38:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2405559a91.0
        for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787931486; x=1788536286; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJdt0aDQo3QWYjdT6UEMt92s1/oBkWrWP3BZCycXw4Y=;
        b=KaqFTw/ks1anvAAaOgRzU8swn55hCzBNOEZ3JWDzC9MhUDh9vYt78l0kX2TiW3tjOg
         I6QqNPGAtdojGrcI/jcNiPzFLQF1vo1lRViaoOO1zO4ihCYAd7GSjU7XKbkZy0+Sh3bu
         ZNTtU3AtIZB6dA5wXm22xqpc3XU/rJKlz+9zfpc66CcJ3IpTGe163AV2ipZNPidWi5Hs
         HuR6F7VAWmGGyHbIz2bI78Opf/iut6dRmWNfyRWo45l4LvcdSqOODk88aBfIewreOGI/
         cvpzDH2lPzwZvk2c7gbEMiwyWZzsOf0vXMOuG1qlDG3AE9/AdJ9+rGDfPUrnrH9oietQ
         rD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931486; x=1788536286;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJdt0aDQo3QWYjdT6UEMt92s1/oBkWrWP3BZCycXw4Y=;
        b=NhiWV729C6NNTI5/+c3BB5dDOL5jn2jwNVQjefML59nB+r0YQrzqpY6k/+FlzWzkyW
         s3GZTvDmNjizahHfW6SFxNOTM7BBsZmwf/NjZuqQSNkGfbVhRMVw9e9hSsqSWTZ8PY57
         iKZsGpDCiNDm8gUPjG0Nn60qGkyMF59tgy8Gqu6kpPvCfNJ8Dzf7klhv9sUo51d/b2Vu
         /Lxf5SB5yqBQIe2aXa7O0M62+/UpRzx2065PRNvgiYL1CjN3a8aJSCq7N1ZZqNrO3fgh
         wntX4d+nOJpK5HrGrgZ6bgLV0EdQyQDoSkJdzS6n7Z5MlDOS9NfR1AyifyfE1xl6LuRB
         ru8A==
X-Forwarded-Encrypted: i=1; AHgh+RqNKqjCLZWpWjtcqS/BW+zJIPvauDw7h1NhlCi47BSksqhdJqcfP0RfDQOR6bYguo7ppzUyrtyYUru4LLT0SQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lgl5zwNmP23TN5DUMQFD1J23tHErGcxjvZ/VmaumeDZZoF0T+4
	ZJlNm6iVCnzJqtJ8EsQbY9SGcCw1ctdrjebZRAmR2iPJpCe0Wa5p0g7WOyWeFS3padmhYZ4b2qb
	VY8UQyrzg75hMKN04nhqe7gK3qCk1LN+8dbESPp94/uBr72Ulyw0rVIff3CJwafDI8wIBGQ==
X-Gm-Gg: AR+sD128pbJjHawCdKc4/JjLgdEYOIoY4gTyjtyEv0GaHqwdnCZTpqYeShmnYBrx769
	BBziRJLGhGJH6ZJ4Cks5d/PQWidxs8mfDdZGv82wIhQoCFWbRoqLAxhfPL30yO3aukUsmGF88Rp
	oDgpsnzz9AiVRsiQODmOY9TwNYLGlDM0WXpJIyAeuQyDEUmHQMwo5C7EVMk63WfzW7b/UHYvWUa
	Or/W3Wf43RwBfE6VSF0Vn2ALv45Crdq1ZV7NA+Pi3lkRmerGxOUioBY1O2lIJVPMb+mjHKfE+RH
	f7iru6kYpKgL2V+4P4x5RJMDVckowyGyOCGOCedY9AAWe1XSD+ltrougFQvGq8EoaF0vt2fv1IE
	pxTwbaI0jA6Asy4GDNF7y0UdgyHur9651riZKP3TLyTQM5xxQesBAgWrmM/U=
X-Received: by 2002:a17:90a:d44d:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-396d0c15f3cmr16719872a91.0.1787931485821;
        Fri, 28 Aug 2026 08:38:05 -0700 (PDT)
X-Received: by 2002:a17:90a:d44d:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-396d0c15f3cmr16719807a91.0.1787931485324;
        Fri, 28 Aug 2026 08:38:05 -0700 (PDT)
Received: from [10.110.102.109] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4d92sm6485178c88.13.2026.08.28.08.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 08:38:04 -0700 (PDT)
Message-ID: <d81e347e-8ca7-40a1-a428-5bce6f0d4b02@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 23:37:57 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] FBE virtualization: inline encryption for
 virtio-blk guests
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
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260827184219.GB2137493@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8YAM0SF c=1 sm=1 tr=0 ts=6a91ab5e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Z1znHgkL5aNkaA1FTC0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: wz03tXIBpuWVKpHFVzVrXyEANwmlhOLj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNiBTYWx0ZWRfXwsy8IyIz3jyK
 q6phRsuIqE90b7kJj4+/YAetzSsGZKHqcjGRiBcolwhyJP1A3lmeYFbNTzttuRmXqr5/P5d6dx6
 sPT2DCcGQia4dTa2i0IxvoQsoxRybJQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNiBTYWx0ZWRfX/9z0xT+5Mz0l
 DGeGDPio7VYPxOtb+XQHtcVtniUuFPPWu1laXhZUV/A1L88MqFDybA6MvAgNSxLCJ3bmka322Nb
 ByReFtrGSz3A944qD1KVWZ4HbEBpD/uOlV3WrPfDazIqGA9YNLfypFFnlbjQTjJMsmCAUoKctjq
 EgZZPE92F1iJ0ukzTQm20+hhSpSryeqv6Evx5//pm0Y4H/NJ/nBLX5lYGca8P5YZQqLfNWOemat
 hiSFK2EmZ16F8A5UBopFbl/juUVtIO0s70rjSlYQSM3qOHpcZuW+5OcrY+ToYo/DUjuU3vJorvf
 uag7XVVI02orkKTru8gSoSD2ApHcVMhoQqoF1qRO3TsdQ40j7sUCdT5YbQoim8m0qUyT5EsIeVG
 QAflo8N62hEj13vjDUNa2LrvKrYmGA4nTfElKr3yKCyT2CKHf0YA7K0GgKBtO1s3mJn1QHCS0xd
 7EMxD+ZliGO0UOizO7g==
X-Proofpoint-GUID: wz03tXIBpuWVKpHFVzVrXyEANwmlhOLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280136



On 8/28/2026 2:42 AM, Eric Biggers wrote:
> On Thu, Aug 27, 2026 at 09:07:09AM -0700, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> Current virtio-blk does not provide a mechanism for a guest to
>> program hardware keys or submit encrypted I/O using pre-programmed
>> keyslots.  It drops the crypto context when issuing a bio request
>> to the virtio-blk queue, preventing inline-encryption-based FBE
>> on virtio block devices.
>>
>> This series enables File-Based Encryption in guest VMs on Qualcomm
>> GVM platforms where the ICE inline encryption hardware is shared
>> between the host and guests.  In this environment the guest kernel
>> has no access to the ICE hardware directly; it supplies a virtual
>> keyslot index and data unit number with each encrypted I/O request
>> via VIRTIO_BLK_F_INLINE_ENCRYPTION, and the host must translate the
>> virtual slot to a physical ICE keyslot and submit the bio — without
>> transferring raw key material across the VM boundary.
> 
> This seems to be designed incorrectly by not making virtio-blk itself
> support key programming and eviction.  That complicates things
> significantly by then having to handle the key programming and eviction
> out-of-band using Qualcomm-specific SCM calls.  It also means that
> adding other implementations of this would be very difficult.
> 
> There are some claims that not transmitting keys across the VM boundary
> is desirable.  But that doesn't seem meaningful, given that all the I/O
> is transmitted across that boundary in plaintext anyway, and also it
> seems that hardware-wrapped keys will be supported too.
> 
> Please make virtio-blk support the key programming, eviction, and
> HW-wrapped key management operations that are needed for this to work.
> 
> - Eric

Thanks for your comments!

Not making virtio-blk itself support key programming and eviction is
something done deliberately. Based on that HW-wrapped key management
operations are also handled in the out-of-band path.

There are bellow 2 approaches I investigated to let virtio-blk programming
the key.

  1. virtio_blk implements blk_crypto_ll_ops interfaces, including program
     key and evict key interfaces.(Same to 'the virtio-blk interface standardized
     blk_crypto_ll_ops requests' mentioned by Stefan in the virtio SPEC thread)

     The guest's block crypto profile manages the keyslot in virtual slot
     format in this scenario.

      - block crypto key and virt_slot index it passed to the hypervisor's
       (EL2) device emulation (QEMU, using QEMU in the following) which
       runs in userspace of the host. Besides of transferring the virtual
       slot to the physical slot, a programming block crypto key UAPI need
       be added. Follow current blk-crypto design, it may be like
       BLKCRYPTOGENERATEKEY. I thought this results in a security risk that
       allows userspace process a key into a key slot.

     - For key eviction, it's similar to above key programming handling, also
       need a key eviction in blk IOCTLs, but leads to the security risk
       that allow userspace client to evict a key in a key slot.

    virt_slot, DUN and DUSize is appended to virtblk request during crypto
    I/O.

  2. virtio_blk implements blk_crypto_ll_ops interfaces, excluding program
     key and evict key interfaces.

     The guest's block crypto profile doesn't manage keyslot for the guest,
     the host's block crypto profile manages keyslot for both the guest and
     the host. The trigger of key programming operation is moved from the
     guest to the host.

       - The whole block crypto key (key size, key bytes, blk_crypto_config)
         and DUN are appended to the virtblk request during IO, a little
         high payload.

         The backend parses the crypto message in the virtio queue and
         construct a block crypto key and DUN for the bio_crypto_ctx
         set to the BIO. So that the IO flow in the host can program
         the key. 

         The question is that the blk-crypto-profile distinguishs the
         block crypto key via the key's address. But the host has
         different key addresses for the programming and eviction key
         operations of the same block crypto key from GVM, because the
         key is re-constructed in the host for the key program and
         eviction operations. 

         To fix it, the approach I thought is maintaining a new key
         hash table in the backend, and comparing the block crypto key
         content and DUN parsed from virtio queue with that in the key
         hash table. 
         My major concern is that this need keep the keys synchronization
         b/w this new hash table and the blk-crypto-profile's hash table
         carefully, avoiding that key is still present in the
         blk-crypto-profile's hash table, but removed in backend hash
         table. Another point is that the whole block crypto key and
         DUN are appended into virtio block request per crypto I/O.

       - For key eviction, adding a key eviction in blk IOCTLs allows
         userspace client to evict a key in a key slot. I thought this
         is a security concern.


     This option doesn't need map virt_slot to physical one.


Taking all the above into account, I made a compromise to implement
blk_crypto_ll_ops interfaces in a out-of-band path, which lets the virtio
blk only need focus on the data path. I agree that it is complex than
the second option mentioned in the above, but small payload (only
virt_slot, DUN, DUSize) in the virtio block request and no security
risk of key eviction from userspace.


I would like to hear your thoughts about the above and am appreciated
if you could share your insights about the design of inline
encryption in virtio block.

Regards,
Linlin



