Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38C4F96AF
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414159; cv=none; b=arEm2Sbg0ZCDIpeVSolvt0PxEbQ9i1E2RtFrnaWwQqk9FQvbuNaKd6p03pyfnclBjsGimGgy5TZX83MKwR2Jqx+JhnM+cGURaBewEFj7EHSArcY8QBKtynOkEm8wsYqgb5GT2WLVLSTPg0IJIfhvR1lJb/+gKjeWzohx/WlDDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414159; c=relaxed/simple;
	bh=JPo4Fy9VMdAZ9SflP9EN+YrEOyXVYYBNZNRUKkVIWVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Px8psFEz1BBYohCFS+E4eD3gUbzWwa4J6fjD1XAC48XDCMb029L8fVkZfjx7FoKLOS2ICHTkyXXXG4yvnh4GWd8qGG9bcjRfkGJJ5K0CV+nuXuCUesvNHTatm49nQ5jjxByd04bO9JSh2gFrktERoQpCN0M9gaF9Cam8n6bJhaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdAR3+da; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VrCWY1tB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdAR3+da";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VrCWY1tB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Opxm2234252
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	auMhq3XA2qTYpIkbiJ47uvtQxF16I8+0ecaAYJP+Cyg=; b=cdAR3+daSoO5lG2P
	o1THQ3+MNSrBk3f2li10XzIlvqrMqg0mZ2b2GqFZjfyla7xspohEJuJCpw4yLes7
	FILpalb/TJZa4aDtHljq4phDIrHX3WzKHsTWAvShYFDbwt/p3Q6a9YgF9ZSRoqqI
	A0C9l6fwWshnMViQu1+7Kn5EBw27NS+VVZFpzr7VY8FGMWVLFouz2KPZje04d7qC
	iHZxIHgBm54opaDQvkn0i2Nrlr57FUyIcxpm5Q2bWfPAB2HcuDsrKqDHxmi1ozDM
	b/x22htL7w9g+nZxJOuqyYaluK0okK3tPdx2iI6F7FUnEe/FUN8v4aUV+u7s/iWS
	DgvBaQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x94ub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:49:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e9501034c4so33850565ad.0
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792414154; x=1793018954; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auMhq3XA2qTYpIkbiJ47uvtQxF16I8+0ecaAYJP+Cyg=;
        b=VrCWY1tBq/j19RDZft7xSz4iAk1jsDhSQZzWxsV9yL69hlAQS7M0npz5PlSijSVx8D
         n0vSjhxBni5XX3iaPNPa64XWzYTGg6DbHoJgNPOtZHO7+B9VahXIew6aJH2BRf9nYBRJ
         w3uFlNaYgbLfJswSSp4M8aDEL4qZhd+fOtjlFN/S+qXu7iMW6Kmb9JDfHsTzTYZaFPLZ
         FJ+JXzoclNt7y2YPquCQoR7wJpxAnHmRmcOnzWi46OfAmQrnYuKoBMEherVlmmv/GGQM
         PGFgEsLf3lbem+YzMTnW0cdxtiCJZLKXoiOGwGKuK0ywqG64FF+IFlcwejaDHr/xMEjR
         aLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414154; x=1793018954;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auMhq3XA2qTYpIkbiJ47uvtQxF16I8+0ecaAYJP+Cyg=;
        b=FbaUsO8xKiRP48ff/4yuvGB0f/n220r5sArs8ghU71numBoma4y9UcngoFr/cpIbas
         IIzrPs2Qu/1aMaG03NsjOe1OYk4x/26C1HPOzyOeSYMwCu2oZ503MLX7H6p/59QynKKw
         DtaDkNV8UHi1WeoyUtgeSvRB2/WflZgi2vds10l5rbY2JJADpJr2FjhieSojxOTgFtxt
         56zceVb++UlnQ0Gq2bsgNa5zN9hDHxr7D1GjAS6vdniv+X78VFq2s/NNH+DRIbljUpDt
         m1PE0SghlykmcRK1xiUvmJKArhDVJmIkJ2eZyPb8/NuFgjgWrLlW5/dXC9SnVLpmpqWB
         5xZg==
X-Forwarded-Encrypted: i=1; AKwUvBysOQKf42/2aNZGdHFKyR8FMPYeNjFMEkQDJgWtKm8yul914nHRkq9i3e+qlA8POkoOdbrFbz9b/IspUejGKw==@lists.linux.dev
X-Gm-Message-State: AFq9FYISyQb8M9iNBwNNN77Nl+WcAmGnpLVQ67MM7YD1A1yrCiuL882z
	g7dd1b1H4pUZPkh8FTUiZFrxr+RWY+6vl31qCQ3xF6ryM5q7PRx6BwwxMNlfPIIUUX/03Nf+mN+
	WvHeBYQpejFVQSRklmEaib35V1ornO48e5BCx/tRUOlpRXj6eoJv02dZ85hLBQvXsTtxVaQ==
X-Gm-Gg: AYBFou2bykUUslUi8GDgEeDwfz/Ya/FAmnlsfNW4oNNQW6KMPnY6lFUrmGaKKZYfeo4
	J27BhY9maq9Bhvv67XtqOuu/RwxHJkL7g+EdOrOIsfNm1fh75nwa8ZUus3tnPNVtpUjO9/Cejpw
	R1X+S7UmYs9rG2YQtcqTnwCULdfOn806RCMRBGm168XtkKNaTOU6l/L4BWqv7NTNmSxoIDoeWBb
	/kSzX/pJAfpTOegixWmNXLJsi7FqoAsX0BGZ+SFxMPRo4dybZeZKa6JXLd/Wk9WrfidQYuZ1Fq0
	Du5kTkuKNY+15dbz1jbNploNAXv0xCS/El3H3/+9yxOmIU9M3JnyrhzGcDNddjr4QuZmJzyr0la
	oLvqEaYNjL2b7sk3v9SSSCrSB+ySiFXGtodnZhAesyM5noysNc1fIv/9t
X-Received: by 2002:a17:902:ec85:b0:2e9:9263:a5f with SMTP id d9443c01a7336-2e9a69e461cmr67522585ad.17.1792414153616;
        Mon, 19 Oct 2026 05:49:13 -0700 (PDT)
X-Received: by 2002:a17:902:ec85:b0:2e9:9263:a5f with SMTP id d9443c01a7336-2e9a69e461cmr67522305ad.17.1792414153099;
        Mon, 19 Oct 2026 05:49:13 -0700 (PDT)
Received: from [10.110.10.179] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea150299a3sm49185ad.44.2026.10.19.05.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 05:49:12 -0700 (PDT)
Message-ID: <621faf8e-9262-415d-b319-de2f46577f83@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 20:49:06 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] virtio_blk: add inline encryption support
To: Eric Biggers <ebiggers@kernel.org>
Cc: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, stefanha@redhat.com,
        pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
 <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>
 <20261015202644.GA2317081@google.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20261015202644.GA2317081@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x9FT6B0WHZ6Zt-MqYMeHyjo9DPLpO5rp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MCBTYWx0ZWRfXx1ZaLd9d687k
 xPLFmoRoUpIdsnBpPN3p1H49gf5UdC+LHLz3Cf7sIJg6Ug0/3oG2kFCNdYOA76yn0YRZsYK+kkd
 e2EUXBdl8D2u//6q1qdlO2bmSmK6Cmk=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad611ca cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=miAsq2xNFU6VxYnW6ecA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: x9FT6B0WHZ6Zt-MqYMeHyjo9DPLpO5rp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MCBTYWx0ZWRfX9N49OBC6Imgu
 OnZQ5/ChZv+B5ZUftQLp0Xhh7gwnU/OcG+oAc9G5SKHMehA7JkOOVjss8D+v/GwR4bbw2Z00KFb
 uq3n/VK00qw0WLLlfQIPF4xAZ9bTwy/heP+Rsj8JewGHWoR/NrhOc7eOfelTCBO1XVpLhOmjoUr
 PhUZ1L8X1zy5hDKxfQYnMenk7ZeP7vjgqgbRMtJfc4GT8h60NtVgr4jgGypWP2kygpbLG3ohHeM
 YHWauAXWERelDrLHpvgeYTPQGMwkV68lt4NdlXL+J8x5BHc3vP9HLJrFvvXthkkXYXVvVGIxKYh
 a3YOfWwiPcGdf84Zcn9doO8fCeYqmZTcRqknvyc7EUasj55xxOT05fkvrpF7DJWi35N8yCfO2sO
 xDecFAh3no4AdzPzld46KEUcrrTETw64FPJaUTfiHY6T+2Fq7iXNJFtNEiXat5ZzE5oonEMHx/+
 qJz/LEG9Dvug0tM6BKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190050



On 10/16/2026 4:26 AM, Eric Biggers wrote:
> On Thu, Oct 08, 2026 at 09:17:14PM -0700, Linlin Zhang wrote:
>> +config VIRTIO_BLK_INLINE_ENCRYPTION
>> +	tristate "Virtio block inline encryption support"
>> +	depends on VIRTIO_BLK && BLK_INLINE_ENCRYPTION
>> +	help
>> +	  Say 'Y or M' here will allow the virtio block driver to route crypto
>> +	  requests to a different operating system in a virtualized
>> +	  environment. This is useful to encrypt the data stored in the storage
>> +	  by using storage inline crypto engine. The control queue feature bit
>> +	  must be negotiated to enable this functionality.
>> +
>> +	  If unsure, say N.
> 
> This should be a bool, not a tristate.  (Since it controls the inclusion
> of a feature in a module, rather than the inclusion of a module.)

Thanks for your comment!

Double confirmed that the virtio block driver is still built to virtio_blk.ko
in the combination CONFIG_VIRTIO_BLK=m and
CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION=y.

I'll modify it to bool and update '#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)'
to #ifdef CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION

> 
>> +#if IS_ENABLED(CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION)
>> +static int virtblk_get_crypto_modes(struct virtio_blk *vblk,
>> +				    unsigned int *crypto_modes_supported)
>> +{
>> +	unsigned int nr_modes = VIRTIO_BLK_CRYPTO_MODE_MAX + 1;
>> +	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
>> +	struct virtblk_ctrl_request *creq;
>> +	unsigned int i;
>> +	int err;
>> +
>> +	creq = kzalloc_obj(*creq, GFP_KERNEL);
>> +	if (!creq)
>> +		return -ENOMEM;
>> +
>> +	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_CRYPTO_MODES);
>> +
>> +	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
>> +	sg_init_one(&resp_sg, &creq->in_resp.modes, sizeof(creq->in_resp.modes));
>> +	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
>> +	sgs[0] = &type_sg;
>> +	sgs[1] = &resp_sg;
>> +	sgs[2] = &status_sg;
>> +
>> +	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 1, 2);
> 
> What happens if the host follows a future version of the spec and wants
> to return more than VIRTIO_BLK_CRYPTO_MODE_MAX modes?

Thanks for pointing this out!

The response is bounded by the device-writable buffer provided by the frontend.
VIRTIO_BLK_CRYPTO_MODE_MAX defines the maximum number of valid modes supported
by this version of the frontend, with entry 0 reserved and always zero.

A backend implementing an older version of the spec may return fewer modes.
Conversely, if a newer backend supports additional modes, it must not write more
entries than can fit in the response buffer provided by the frontend. Therefore,
additional modes that cannot fit in an older frontend's response buffer cannot
be returned to that frontend.

> 
>> +static int virtblk_crypto_keyslot_program(struct blk_crypto_profile *profile,
>> +					   const struct blk_crypto_key *key,
>> +					   unsigned int slot)
>> +{
>> +	struct virtio_blk *vblk = virtblk_from_profile(profile);
>> +	struct scatterlist type_sg, out_req_sg, status_sg, *sgs[3];
>> +	struct virtblk_ctrl_request *creq;
>> +	int err;
>> +
>> +	mutex_lock(&vblk->vdev_mutex);
>> +	if (!vblk->vdev) {
>> +		err = -ENXIO;
>> +		goto out_unlock;
>> +	}
>> +
>> +	/*
>> +	 * GFP_NOIO: this callback runs on the bio-submission path, which
>> +	 * memory reclaim can reach while writing back dirty pages to this
>> +	 * same device; GFP_KERNEL here could recurse into that same reclaim
>> +	 * and self-deadlock.
>> +	 */
>> +	creq = kzalloc_obj(*creq, GFP_NOIO);
>> +	if (!creq) {
>> +		err = -ENOMEM;
>> +		goto out_unlock;
>> +	}
>> +
>> +	creq->type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM);
>> +
>> +	err = set_virtblk_crypto_key_desc(vblk->vdev, creq, key, slot);
>> +	if (err)
>> +		goto out_free;
>> +
>> +	sg_init_one(&type_sg, &creq->type, sizeof(creq->type));
>> +	sg_init_one(&out_req_sg, &creq->out_req.key_desc, sizeof(creq->out_req.key_desc));
>> +	sg_init_one(&status_sg, &creq->status, sizeof(creq->status));
>> +	sgs[0] = &type_sg;
>> +	sgs[1] = &out_req_sg;
>> +	sgs[2] = &status_sg;
>> +
>> +	err = virtblk_ctrl_vq_request(vblk, creq, sgs, 2, 1);
>> +	if (err == -ETIMEDOUT)
>> +		goto out_unlock;
> 
> Is the -ETIMEDOUT handling really correct?  This basically turns this
> into an asynchronous operation; the host might still complete it later.

Thanks for pointing it out!

I agree that the -ETIMEDOUT handling turns the keyslot management request into an
asynchronous operation, but I believe it won't leads to functional error for inline
encryption as 
  1. the key eviction in block-crypto layer doesn't depends on the return value of
     keyslot_evict of blk-crypto-ops
  2. the virtual keyslots per device in the host can be overwritten.

The timeout was added to avoid a lock-ordering hang in virtblk_remove().

  - A keyslot callback such as virtblk_crypto_keyslot_program() takes vdev_mutex to
    ensure the virtio device won't be set to NULL during the this operation.
    It holds that vdev_mutex while virtblk_ctrl_vq_request() sleeps waiting for the
    host.

  - virtblk_remove() calls virtblk_ctrl_vq_quiesce() and then acquires vdev_mutex.
    It only calls virtio_reset_device() and virtblk_ctrl_vq_drain() after acquiring
    that lock. Those are the calls that would wake the waiter with VIRTIO_BLK_S_IOERR.

  - If the host never answers, the waiter holds vdev_mutex and waits for a wakeup
    that only comes after virtblk_remove() gets vdev_mutex. virtblk_remove() waits
    for the waiter, so this is a dead lock. 

The 10-second timeout avoids the deadlock at the cost of falling back to asynchronous handling.

I don't think we can eliminate the asynchronous path entirely due to the lock
ordering between the key programming/eviction paths and virtblk_remove().
However, we can reduce the cases where it is needed. Ideally, it would only
be used during virtblk_remove(), whereas the current implementation may also
fall back to asynchronous handling when a keyslot operation does not complete
within 10 seconds.

> 
>> +/* Must be >= BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in include/linux/blk-crypto.h */
>> +#define VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE		128
> 
> Does this value really need to be exposed in a UAPI header?  As
> documented in the comment above BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE, it's
> supposed to be possible to increase it if ever needed.  This change
> takes away that flexibility by making the current (somewhat arbitrarily
> chosen) value part of the UAPI.

ACK. Thanks for your comments!

Currently, only struct virtio_blk_crypto_key_desc and struct
virtio_blk_crypto_key_blob use VIRTIO_BLK_CRYPTO_MAX_KEY_SIZE for fixed-size
array fields. I will change these to variable-length arrays which are always
the last filed of the struct, with the actual length specified by the
corresponding key_size field. The device-readable/writable buffer size for
commands using these structures will therefore be the size of the fixed
fields plus key_size.

For struct virtio_blk_crypto_sw_secret, however, the software secret size is
always fixed at 32 bytes:

  /* Must match BLK_CRYPTO_SW_SECRET_SIZE in include/linux/blk-crypto.h */
  #define VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE	32

  /* Reply to a VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET request. */
  struct virtio_blk_crypto_sw_secret {
	  __u8 secret[VIRTIO_BLK_CRYPTO_SW_SECRET_SIZE];
  };

So I think it makes sense to keep secret as a fixed-size array here.

Please let me know if you see any issues with this approach.

> 
> - Eric

