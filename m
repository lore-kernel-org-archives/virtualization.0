Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300A3BE172
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457822; cv=none; b=dw2XAf5zH8nWAl3p4Ed2aOAtgDgV74fFg4SZB5VHlk15k66N9MwJnfeJet9Zeb56MIeHdMqSPwJXnZctv2gpenVWvHrRzGi8sTmN8H5dz403iSPLDEyDSiH7NJyoqp8JAXvUeIDeLsVpPA7LvIo+vRejwEe2Xwf2cgfK2vP0rFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457822; c=relaxed/simple;
	bh=UK1VL03zzqA7VphzAWuFacC+alNZcrO575+K+2rECic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqAkChqYxlbbuudPddV0SS1IvdCw01fZcSgXAlMvInWbZI7FSLHcj7F3+E+ZBtKOgMf/0kmBIrGG3bTcCOWTBjDfNQtu+Tuxx0lHqL69Vy65fzYbed5hRBmx4CjzHnzRV2FHWxoafLJgQ608KVkek7JTGv5wUxtJ1nemmhvk0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyHmQpy4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJR7cNO8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyHmQpy4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJR7cNO8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698AbmlV3004399
	for <virtualization@lists.linux.dev>; Thu, 8 Oct 2026 11:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	beKosWFQLd78eGGzyRi9IfwyASQM8FcMb7UpN5zjhpU=; b=gyHmQpy4nbpXWJRU
	TV4wCUBpCWYUxCTWmELRHFDtUzncJlYoOgmM0iNzmQCIFnRqogD/V3ym28ZtKZ3/
	BLqTGIJUGH1/2SqAsDBx93ETpt5ulhQszJSKOq8wtEMnrLD7AV6qEp3pk6gCP/bw
	dpSKEqiMculgNoGsPHVe/ZrE8CiTn0nn2lBcCJW0hD+EMoX09TJoYlf2oHmEzqss
	muCjEVDz97kAnD4XYvH3+0BUj/fpmkPV3JCfQOlXfoQg5NY5+x/o22lxIb+RVd4o
	csXDPxCjjg8w3qVSq+s0MRvYuKGJhFmoskX8eoEsIpJXoGLBDZp+V2WsExK3VsIl
	wG4ruw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe82j07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 11:10:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34ef5fd7934so13854612eec.0
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791457819; x=1792062619; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beKosWFQLd78eGGzyRi9IfwyASQM8FcMb7UpN5zjhpU=;
        b=XJR7cNO81XMVBGXfEfKC4K0HB/1jaixfBcG+Bx7ZihscGIRFPqGTH8k2Bp1pPLMf0E
         /x/fCag65Qol/nutHj+WSZ/KHbu36jKkCdCjqConztJJWIi49zH8Zxz585uP7rgYxE7e
         BRkf5W2IlMqz78qpmvsq72B7L8onPOgKSh7P+c+dK4VXWPrWbSlxi+Uwq8m9N6B2F0Nk
         uHrbfCQ5+tv8ZPZkKFaM3ZoLrvc5868fuPGnnQ0/gtuhaJZtSP3WQI04rPgKhPuqIB7D
         zeWCUoMH7FJPbi6Tr5yfnNpolH5aGRO8YB06Mgkb/JRS6XrYtXet06/ymyj3Mmn7fXR3
         xMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457819; x=1792062619;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beKosWFQLd78eGGzyRi9IfwyASQM8FcMb7UpN5zjhpU=;
        b=OnUmjMLYGDziKnkZjQJYxiVRMcb3XKM/3kdM6b67UrvpCDwaZmtUGa1m86eENSG9WM
         NgJlpA5SLhnkm/dyNx52i6sPE+4en+jfAWDt9B5q99/RS4sXgkMvXs26zqiUqfR2tAFh
         o3OqKhkd2wyvJ82ysLiKxSUXrpo02gO+qAr9ykg4UGTmfxtgYjb5w/78Ag4Km1kZ1nSg
         8pO4TJLbC8DQJrU61nGXByrVrH/4q2PT2z30v/iTu+5mjplI5vGlDo9dx26byD/gJ7uE
         upCvQ79iT5TGR3TM0gGAitrcDfj1wJJWwE1yEEn41KADgjP9FH+LInj69r5jZw+xYm+5
         Xmvg==
X-Forwarded-Encrypted: i=1; AKwUvByj3DU8k2nD8SIcaa+QP86zuqL8Orf+s7s1ZHy1IVCdS+GSl1F5cx6+lAih4V6OFg7bDpf9ommi6BC53QD6xg==@lists.linux.dev
X-Gm-Message-State: AFuF++lOHQzOClsmvU/Tbdl+/mMKcsbcmLotR6yxm6l1dS9u4eJKoTy2
	lSxLb56ey/cZ3AZf4ZG6CvZLmAkk/StS+6fNUIN0O1beBpNwcosDSlnT/dOn1yDNrpAMGmvUhda
	t68+NkYSCiMgfI7XUGIyOzkKJDjrmML7QlscYaJ7OwcQ9zg6/w9hjV4m5SpU5DMAMeH/SRdCV+J
	vG2h4c
X-Gm-Gg: AYBFou3q/rRGp+CjGJC05f3C+2VmaoX/NLboQahkUnt/JK0sN3HTGNk18VM3wbANyRp
	3+VXWOI8NJv9EcWiljZst10JnneJt8qESHmT7LsrQzAjRUNnbfZjAyFwkM7KAe7GAGL5uhRCZOq
	m1LEh/12aEg7FJH3RkJBlABM0Hd+cnVEu82kNzuWEShVrtBE+yNf4hw51yXPTZO5Zbgl7L2/P8f
	tJVhm5sUI2S6y4xWzGVSRiN3W6GHxmieBFYYoHGkYGzWWJ5Rk9C4qsCP6dtYWn8d77af4ZM2pT3
	Fu4/rW4Ev+buSkwzvIKVZ9ZH50S8ioR9F/7zkomSU1QYcwfBvtVJ6vhGNRb8wehvB01FzI2II7S
	8OiK+RWYEZb9SIbAHbvEHgtFhNZ3dLtDUuCbiFwjvNfjSDjUuLspiUzyE
X-Received: by 2002:a05:7301:dc3:b0:34b:101f:cda2 with SMTP id 5a478bee46e88-3515df631camr6652733eec.27.1791457818473;
        Thu, 08 Oct 2026 04:10:18 -0700 (PDT)
X-Received: by 2002:a05:7301:dc3:b0:34b:101f:cda2 with SMTP id 5a478bee46e88-3515df631camr6652680eec.27.1791457817586;
        Thu, 08 Oct 2026 04:10:17 -0700 (PDT)
Received: from [10.110.12.176] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515abb67e5sm15881843eec.4.2026.10.08.04.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 04:10:17 -0700 (PDT)
Message-ID: <168dcb2a-054f-455d-bdeb-d577487003b2@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 19:10:14 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] virtio_blk: add inline encryption support
To: sashiko-reviews@lists.linux.dev
Cc: Eugenio Perez <eperezma@redhat.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>, virtualization@lists.linux.dev
References: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
 <20260920122444.2549493-3-linlin.zhang@oss.qualcomm.com>
 <20260920123840.EF61D1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260920123840.EF61D1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0NCBTYWx0ZWRfX53Vo4gv7Fd1t
 1obXQ/+I4X8dQCj+4/G+cRv5pmxJ6ARWYkssXaGwebc1iXeFgrswxK3SF+UJIRsuTyJoiV/t4Fs
 jl1Fkxo1NLHu54ypb9WXQtY05LjmpBZyz43HZLBWFcDeOfKVmh+IC/Yx3jbyPN+kPo0bQvOgJlJ
 PWLbv3yKJZP7Y5uVWIFvoHaZDdcugjcFnldTjpHQEshsLuOdBIHzkkSUGAaT6ttGT9BxiyN8T2D
 QvJB6BR0RbrWrbVcJhA6v1pNjTovQroQT3TA5Fa36JO0C4XOTLVE7QFBx/j2ajGLK9w6uxK6FDL
 nh9e+ftGe8o0l43HV33EHBqxhSJ3Vvzh3sMhO5VtQ7W6Ot1o3owcsCjs94987QKKT3rT2krOfqn
 dlJvpjQFhEew5j8SyhlgORjfAYIaB+6IRQluv+yJzvB56HrnsHIqMmfyT61Mc+RBCMQBteD5lVx
 oVpLfJSZpcMF9sVHUdg==
X-Proofpoint-GUID: 9jAI0sLROmLEI5suFzhf6zFSVqyeOte_
X-Proofpoint-ORIG-GUID: 9jAI0sLROmLEI5suFzhf6zFSVqyeOte_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0NCBTYWx0ZWRfXwQZuJUFUX++a
 hUw9v+JwyCrT4n3jDzO/bIx9qqgyM+Ag0KOdMl+bcbKXIUAwPxCURavGoxOStXQY6xq7isYgt1A
 rWJrk9fMGS7nD8SXmC8z+mokjVRBN1E=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac77a1b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ken0QPC6kQFW6q7ckVsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080044



On 9/20/2026 8:38 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] block: memory leak of sensitive cryptographic key material in virtio_blk
> - [High] block: DMA cacheline sharing in virtblk_ctrl_request causes data corruption
> - [High] block: deadlock in virtblk_crypto_generate_key() due to vdev_mutex
> - [Medium] block: incorrect bitwise arithmetic in get_supported_blk_key_types() breaks negotiation
> - [Medium] block: Kconfig VIRTIO_BLK_INLINE_ENCRYPTION tristate causes linker errors
> --
> 
> commit 3dd149ac489e952ca2319a45325b2d578747f639
> Author: linlzhan <linlin.zhang@oss.qualcomm.com>
> 
> virtio_blk: add inline encryption support
> 
> This commit adds support for the virtio-blk inline encryption feature,
> allowing the guest to offload per-I/O encryption to the host. It wires up
> device characteristics to a blk_crypto_profile and manages keys via the
> control virtqueue.
> 
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index 858320b6ebb7e..58bb050d4617c 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>> @@ -372,4 +372,16 @@ config BLK_DEV_ZONED_LOOP
>>  
>>  	  If unsure, say N.
>>  
>> +config VIRTIO_BLK_INLINE_ENCRYPTION
>> +	tristate "Virtio block inline encryption support"
>> +	depends on VIRTIO_BLK && BLK_INLINE_ENCRYPTION
> 
> [Severity: Medium]
> Should this option be a bool instead of a tristate?
> 
> If a user configures CONFIG_VIRTIO_BLK=y and CONFIG_BLK_INLINE_ENCRYPTION=m,
> this dependency evaluates to 'm'. Because the inline encryption code is
> integrated directly into virtio_blk.c using IS_ENABLED(), it gets compiled
> as built-in alongside virtio_blk. It will then attempt to link against
> blk_crypto_profile_init() and other block crypto symbols which are loadable
> modules, causing unresolved symbol errors during linking.

No. it should be 'tristate', so because it's code is totally in virtio block driver.
keeping 'tristate' make it possible for virtio block driver in module form can
support inline encryption as well - both CONFIG_VIRTIO_BLK_INLINE_ENCRYPTION and
CONFIG_VIRTIO_BLK set as 'm'.

> 
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 2fad86e8f7a9a..30c303364ca97 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
> [ ... ]
>> @@ -124,7 +136,21 @@ struct virtblk_req {
>>  };
>>  
>>  struct virtblk_ctrl_request {
>> +	/* Type byte, always its own out-sg for every command. */
>>  	__virtio32 type;
>> +	/* Out request, sent as a second, separate out-sg if any. */
>> +	union {
>> +		struct virtio_blk_crypto_key_desc key_desc;
>> +		struct virtio_blk_crypto_key_blob blob;
>> +	} out_req;
>> +
>> +	/* In response */
>> +	union {
>> +		struct virtio_blk_crypto_key_blob blob;
>> +		struct virtio_blk_crypto_sw_secret secret;
>> +		struct virtio_blk_crypto_modes modes;
>> +	} in_resp;
>> +	/* Status byte, always its own in-sg for every command. */
>>  	u8 status;
>>  
>>  	struct completion *compl;
> 
> [Severity: High]
> Could this struct layout cause cacheline corruption on architectures with
> non-coherent DMA?
> 
> The virtblk_ctrl_request struct dynamically allocates fields mapped for 
> DMA_TO_DEVICE (type, out_req) and DMA_FROM_DEVICE (status, in_resp),
> alongside CPU-modified fields (abandoned, compl). Because the struct is
> not cacheline aligned internally, these fields share CPU cachelines. If the
> CPU writes to the abandoned field while a DMA operation is occurring, or
> before dma_unmap_sg() invalidates the cache for DMA_FROM_DEVICE, the cache
> coherency conflict might overwrite or discard data.

ACK

Fix it by moving both struct completion and bool abandoned to a pointer.

> 
> [ ... ]
>> +static int virtblk_crypto_keyslot_program(struct blk_crypto_profile *profile,
>> +					   const struct blk_crypto_key *key,
>> +					   unsigned int slot)
>> +{
> [ ... ]
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
> 
> [Severity: Medium]
> This is a pre-existing issue, but does virtblk_ctrl_vq_request() contain a
> race condition when handling timeouts for these allocated control requests?
> 
> If wait_for_completion_timeout() times out, virtblk_ctrl_vq_request() sets
> creq->abandoned = true to inform the callback to free the memory. However, if
> the interrupt fires exactly after the timeout expires but before the lock is
> acquired, virtblk_ctrlq_callback() reads abandoned == false and assumes the
> waiting thread will free it. The waiting thread then returns -ETIMEDOUT and
> skips freeing it, leading to a permanent leak of both creq and compl.

ACK

Move struct completion and bool abandoned in struct virtblk_ctrl_request
to virtblk_ctrl_completion *. one time kmalloc_obj() of
virtblk_ctrl_completion * allow them not in the scatterlist.

> 
>> +	if (err == -ETIMEDOUT)
>> +		goto out_unlock;
>> +	if (err)
>> +		goto out_free;
>> +
>> +	err = blk_status_to_errno(virtblk_result(creq->status));
>> +out_free:
>> +	kfree(creq);
> 
> [Severity: High]
> Does this leak sensitive cryptographic key material in memory?
> 
> The creq buffer contains the plaintext or wrapped key descriptor, but it is
> freed via kfree() instead of kfree_sensitive(). The fscrypt subsystem rules
> mandate that keys must be zeroized after use to prevent memory disclosure.
> 
> [ ... ]
>> +static int virtblk_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
>> +					    const u8 *eph_key, size_t eph_key_size,
>> +					    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
>> +{
> [ ... ]
>> +	err = blk_status_to_errno(virtblk_result(creq->status));
>> +	if (err)
>> +		goto out_free;
>> +
>> +	memcpy(sw_secret, creq->in_resp.secret.secret, BLK_CRYPTO_SW_SECRET_SIZE);
>> +out_free:
>> +	kfree(creq);
> 
> [Severity: High]
> Similar to virtblk_crypto_keyslot_program(), does this leave the highly
> sensitive derived software secret in memory instead of zeroizing it with
> kfree_sensitive()?
> 
> [ ... ]
>> +static int virtblk_crypto_generate_key(struct blk_crypto_profile *profile,
>> +					u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
>> +{
>> +	struct virtio_blk *vblk = virtblk_from_profile(profile);
>> +	struct scatterlist type_sg, resp_sg, status_sg, *sgs[3];
>> +	struct virtblk_ctrl_request *creq;
>> +	unsigned int key_size;
>> +	int err;
>> +
>> +	mutex_lock(&vblk->vdev_mutex);
>> +	if (!vblk->vdev) {
>> +		err = -ENXIO;
>> +		goto out_unlock;
>> +	}
>> +
>> +	creq = kzalloc_obj(*creq, GFP_KERNEL);
> 
> [Severity: High]
> Can holding vdev_mutex during a GFP_KERNEL allocation cause a deadlock here?
> 
> Under memory pressure, GFP_KERNEL triggers direct reclaim, which flushes
> dirty pages to the block device. If the bio requires inline encryption, the
> block layer synchronously calls virtblk_crypto_keyslot_program() from the I/O
> submission path. That callback immediately attempts to acquire vdev_mutex,
> which is already held by the sleeping thread, causing a strict AB-BA/AA
> deadlock.
> 
> [ ... ]
>> +static unsigned int get_supported_blk_key_types(u8 virtio_key_types)
>> +{
>> +	unsigned int supported = 0;
>> +
>> +	if (virtio_key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW)
>> +		supported |= virtio_key_type_to_blk(VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW);
>> +	if (virtio_key_types & VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)
>> +		supported |= virtio_key_type_to_blk(VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED);
>> +
>> +	return supported;
>> +}
> 
> [Severity: Medium]
> Does this construct an invalid capability bitmask by directly bitwise ORing
> raw enum values instead of shifting them?
> 
> The block layer's profile->key_types_supported strictly requires a bitmask
> where support is represented as (1 << BLK_CRYPTO_KEY_TYPE_...). For
> BLK_CRYPTO_KEY_TYPE_HW_WRAPPED (value 2), the accumulated enum value sets
> bit 1, making supported equal to 3. The core block layer later checks
> 3 & (1 << 2), which evaluates to 0, incorrectly causing
> blk_crypto_config_supported() to reject hardware-wrapped keys as unsupported.

No need shifting them here.

The return value of get_supported_blk_key_types is already a bitmask. Only
when virtio_key_types contains both VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and
VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, the 'supported' is 3, which means
both BLK_CRYPTO_KEY_TYPE_HW_WRAPPED key and BLK_CRYPTO_KEY_TYPE_RAW are
supported, which is expected.


> 

