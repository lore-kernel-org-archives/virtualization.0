Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943B441616
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457815; cv=none; b=N5CPseRTxY6CByZ8x9IGU/7XuzvnqYU1LkHhefLV8Jx9m7yL9frtz/H6oFlh8RBVTAUCRcIbKH6nKSAqGQPMeQtaK6qJRCdHOirR6AK02DxuwxEe4d7TdlI9SFOiJ2LOVPmGzEmEQJwzWseRNCKXOsGHGJH6rQNFt2zd7fRUR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457815; c=relaxed/simple;
	bh=wJlvb7XZYh0kYJvDm0txppf9AxV/Q8OL54PZ9T2BfV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxEMTtaelIGnxpyhK1jXdnoP4WUfAZmO4AUUOj2f8mjScHaDxSL2OPiAWonCFBLp9MEBa1VevPd1qledbuEeMM9JxUswMehdxBPYx5UQFdw7M7CH4GWxllpRI/zFfoqtLroPVjMYuf4F5SBZjysqG4zlWu3Pd9LrNaHxNGSh8Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3cw3zR8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dCRq6AEf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3cw3zR8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCRq6AEf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698AbPcj2289835
	for <virtualization@lists.linux.dev>; Thu, 8 Oct 2026 11:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M2xih7xm5C8vr4li+BnM2KTiURVVghrspg38JJXxsSE=; b=B3cw3zR8jdKu3bh/
	hTQVsZ2SazQEeoRofd85u7hdbHG59A3hToVunf44JORJpFwTQ8H5hSXtHeXqOJWe
	gR3lJR5qg1m3suEc2rOhvSIFVQBb9NiGHWtfLsQ2HvjJcm8qJ0hGDap0dXDGa1Mm
	a7Z6mEMTChI+Avu9PE4C+bwwKVTr2UjoinjdMb40GHCDIyX7/M9GKUk7WUV25Fe1
	gITgKZahRZbWOz284txCw8Sfmo8rv73aYMDFksGe80+ROXXqpRJgCE8ZFGsXtP5Y
	Fp5dpU/kD8rcWAzXHQEwLfothwSadHfd4kzF2/rP5wAiezt1GmWHB5E5SQorx4UF
	MOttNQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3jpxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 11:10:11 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso6175647eec.0
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791457809; x=1792062609; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2xih7xm5C8vr4li+BnM2KTiURVVghrspg38JJXxsSE=;
        b=dCRq6AEfe55h6vMhbVLovmJceLl02rRDrNVvgwVTbHKaFXsFIF5DH88BhnGIojTsiO
         KQn6rkhHxWZwTFxj7kQO4H/+i48eAhqnBNCBEP90tC6o7vv4i++4A9RAS32JcgSGivn7
         z8YUHu5ZsF5StzUkb7vBODZcx5x0cDRjmPdhAFf174wrKUKITLaW2cviFLRVDS1Zk4fZ
         pk/kK9c7CCW3mTdrXHTiZ+gnmfwVdCQYbrbbhiOIcNkGpSOAvDBLneO7K/Fn5MnEcRzj
         xR+EKjEOJEQvcXkRYJgCvmwaXEGia53LF8cqZ8gYd1JlW6Y7Ozvkzwwg9OlI9bfB6tyc
         8/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457809; x=1792062609;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M2xih7xm5C8vr4li+BnM2KTiURVVghrspg38JJXxsSE=;
        b=XluMzaYSLnhtEE+dBgkxiVaKIhffzNJ0JAN72YOCH+TL459jymDdPeATmyGOpUtcVt
         RiZme4xknTj0yg4ty/b1baGwDlMqtoJ4Sp5M+5nUVY3+iPr262q1yLS680nBqdC9hUzn
         uXKOmSTXkV0lL0Rs1OcpDlJVfdfOtihDATWNyYuk36FxktNGtbnA4rw7rcDu/in77jE0
         8EwpYkZP0WBpLusuTY1MjW6zmapk8qb/r2P8XI96IMVuenhPqRBNvv2fbp5UIQatjfLc
         YDCdCGesFjODFwJVjQUu4UwzdyheSqHCO/piIObzw0VtigSJ4fKPXA9bUM90APeQdzB+
         lYxw==
X-Forwarded-Encrypted: i=1; AKwUvBzxF/awnpbe0ooI2Re4aivRLJRftzy/EP22LP1WCnVaTnHjjS9VUZEKLxx2ZuDLnleMSgT/WsmBz4eR6ueKyg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL1f4zp4weiqI9g16wtb1FzxxB86Wl+wbf6yGmz6dgeYw1/cg7O
	LDE3hXh7pW8lvgQCOidFiEyrmaZd4louk5cKINIkPis9y9pgYfkFV0GSnx4OKeqfxHywM8RoHWv
	HMA4036uxx3hcKVATmhlT7UH8rBQsmF8Dix8hr1TaDelpKZ/MvklMcyCUdfKYFi6n1PUlag==
X-Gm-Gg: AYBFou00PTkEzzk/sjeX3j1w70cGIYnd+vXpQwVY2nvoxH+USIiyydRPXRP41uLtmrm
	w4GumNOpH99RWLIOxRHQTDe6+9getiSarKp+7brjfUdnwNCOOfVAZiMIlrPy06LCF5lktGU6Tvf
	GGLfXD/8oMjxkvWUp4CWs3jdyHzbs3Hj0SmvwDaMlTWyRkFBPbureLtE6hX1CzNmsHaPO+NpcGI
	3H56v3GP073k2Xf86qXxS45d3bGfB8ikEO8tMWXhp+HX8/icj97+ulesxmlMNfziI5VnsVcmUr6
	Cb0iFWrjOY8ybu+pWzcVLy/akI/4MazatR++Rq1gVh0ns8mRfcsFTPZoUml2afRQJKPKNQM/SxU
	Lhq3Fwp16t5Pk5T2k9Y4r6Q4GqJTeGqlLPBlOqJlxSUFi2409LrZ1pYKj
X-Received: by 2002:a05:7300:e9c4:20b0:34b:401a:4648 with SMTP id 5a478bee46e88-3515de3b344mr6072890eec.20.1791457808880;
        Thu, 08 Oct 2026 04:10:08 -0700 (PDT)
X-Received: by 2002:a05:7300:e9c4:20b0:34b:401a:4648 with SMTP id 5a478bee46e88-3515de3b344mr6072850eec.20.1791457808052;
        Thu, 08 Oct 2026 04:10:08 -0700 (PDT)
Received: from [10.110.12.176] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af26f10sm17742632eec.13.2026.10.08.04.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 04:10:07 -0700 (PDT)
Message-ID: <227923b6-8fbc-47b0-9ac1-e52785a4cc61@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 19:10:04 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] virtio_blk: Add control virtqueue support
To: sashiko-reviews@lists.linux.dev
Cc: Eugenio Perez <eperezma@redhat.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>, virtualization@lists.linux.dev
References: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
 <20260920122444.2549493-2-linlin.zhang@oss.qualcomm.com>
 <20260920123505.012D31F000FF@smtp.kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260920123505.012D31F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0NCBTYWx0ZWRfX3A0f+Agz2xnV
 O8iN82I02na1ItRUBgwqn5ZQnvBKFggBXFtT85C8SIIZ7LfPfPRo471tyVgkovFrMyoYlGrMyjO
 xTIBV5wi4FoCZ6PtzLmRgWXmIbeCe04=
X-Proofpoint-ORIG-GUID: hjR31sAGaVM7G59UvgJQKezpeSS2M4P8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0NCBTYWx0ZWRfX1fRVs0E4xmTK
 XvhuQCwT9+e+EzmP4fXUHtrKPbVD6E1ErlMQCZEoiDqAKFfXI7gdvKG73vXrQRDNzeYnTnQ7ZMt
 gKs32Dad28odllaf/HpNnInHRfQeeJWXwtS44FDPy2RhvxIkg3g0UE/W9DO1KJn6wzNPJ6DsWlM
 2FZZ9JboLYViT5hH51ROP2o1oXsg6cQm1mcLpt7FhSc//z0w56WY17axRLGNiaK5Dv7nMxlViPp
 /RKFOJi25AJuIwfNZLBAZ4KwmXY3y4Q/9jzTHnEtRBmfLER5ayzQ2W6Srf8oTzxlRwt9osA2IB1
 3FiQ7SGkCg6rANvN0Z956GJwQYMZWDvYlY5xU/Rm0yuNrrZJaBgLMqfJvvXRdLliBTgmg3zmwY6
 0hneHKdNRba+IUjoUM87uWV3kUp0nTfiPrPJ7E/OkDdpkccjtt428F/4epiuNgEWktFJn9uvumn
 yJ2dZmAt9f4bd6Kq50w==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac77a13 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xidzSydqH__qsm9hblAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: hjR31sAGaVM7G59UvgJQKezpeSS2M4P8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080044



On 9/20/2026 8:35 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] block/virtio_blk: DMA coherency violation on creq->abandoned
> - [Medium] block/virtio_blk: TOCTOU race in control request timeout leads to memory leak
> --
> 
> commit e5e45f06d7dfecf78d290eb12655787cf1bee763
> Author: linlzhan <linlin.zhang@oss.qualcomm.com>
> 
> virtio_blk: Add control virtqueue support
> 
> This patch adds support for the optional virtio-blk control virtqueue,
> allowing the driver to manage control-queue requests independently from
> the data path. The control virtqueue is intended for a subsequent inline
> encryption implementation.
> 
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 32bf3ba07a9dc..2fad86e8f7a9a 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
> [ ... ]
>> @@ -110,6 +123,20 @@ struct virtblk_req {
>>  	struct scatterlist sg[];
>>  };
>>  
>> +struct virtblk_ctrl_request {
>> +	__virtio32 type;
>> +	u8 status;
>> +
>> +	struct completion *compl;
>> +	/*
>> +	 * Set when virtblk_ctrl_vq_request()'s waiter timed out and moved on
>> +	 * without freeing this request. Whichever of virtblk_ctrlq_callback()
>> +	 * or virtblk_ctrl_vq_drain() later retrieves the buffer must free
>> +	 * @compl and this struct instead of calling complete() on them.
>> +	 */
>> +	bool abandoned;
>> +};
> 
> [Severity: High]
> Could this cause a DMA coherency violation? The struct bundles the
> device-written DMA field (status) with a CPU-modified software flag
> (abandoned) within the same cacheline.
> 
> On non-cache-coherent architectures, if the CPU writes to the abandoned
> flag while the device is actively DMA-writing to the status field, it
> could result in cacheline tearing. This might lead to either silent data
> corruption of the DMA-mapped response or loss of the CPU write.

ACK

Fix it by moving both struct completion and bool abandoned to a pointer.

> 
> [ ... ]
>> +static void virtblk_ctrlq_callback(struct virtqueue *vq)
>> +{
>> +	struct virtio_blk *vblk = vq->vdev->priv;
>> +	struct virtblk_ctrl_request *creq;
>> +	unsigned long flags;
>> +	unsigned int len;
>> +
>> +	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
>> +	do {
>> +		virtqueue_disable_cb(vq);
>> +		while ((creq = virtqueue_get_buf(vq, &len)) != NULL) {
>> +			bool drained = false;
>> +			bool abandoned = creq->abandoned;
>> +
>> +			if (WARN_ON_ONCE(!vblk->ctrl_vq.inflight)) {
> [ ... ]
>> +			if (drained)
>> +				complete(&vblk->ctrl_vq.drained);
>> +			if (abandoned) {
>> +				kfree(creq->compl);
>> +				kfree(creq);
>> +			} else {
>> +				complete(creq->compl);
>> +			}
>> +			spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
>> +		}
>> +	} while (!virtqueue_enable_cb(vq));
>> +	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
>> +}
> 
> [Severity: Medium]
> Is there a race condition here that could lead to a memory leak of both
> the request and completion structs?
> 
> If a request times out exactly as the device completes it, the IRQ thread
> might read creq->abandoned as false, unlock the spinlock, and get
> preempted.
> 
> Meanwhile, virtblk_ctrl_vq_request() wakes up from the timeout, acquires
> the lock, sets creq->abandoned to true, unlocks, and returns -ETIMEDOUT.
> 
> When the callback resumes, it checks its local abandoned variable (which
> is still false) and calls complete(creq->compl) instead of freeing the
> memory. Because the caller already discarded the pointer upon timeout,
> both creq and compl would be permanently leaked.

ACK

Lock the whole code snippet of do-while statement.

> 
> [ ... ]
>> +/* Submit a control-queue request and wait for completion. */
>> +static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
> [ ... ]
>> +	if (wait_for_completion_timeout(comp, VIRTBLK_CTRL_VQ_TIMEOUT)) {
>> +		mutex_unlock(&vblk->ctrl_vq.mutex);
>> +		kfree(comp);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * The host hasn't responded within the timeout. @creq is still
>> +	 * owned by the device, so don't touch its DMA-target fields or
>> +	 * free it here. Mark it abandoned and hand ownership of both @creq
>> +	 * and @comp to whichever of virtblk_ctrlq_callback() or
>> +	 * virtblk_ctrl_vq_drain() retrieves the buffer later; unlock the
>> +	 * mutex so subsequent requests aren't serialized behind an
>> +	 * unresponsive host.
>> +	 */
>> +	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
>> +	creq->abandoned = true;
>> +	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
>> +	mutex_unlock(&vblk->ctrl_vq.mutex);
>> +
>> +	dev_warn(&vblk->vdev->dev,
>> +		 "control queue request timed out, abandoning\n");
>> +	return -ETIMEDOUT;
>> +}
> 
> [Severity: High]
> This timeout path is where the CPU writes to the shared cacheline while
> the DMA operation might still be in flight. Does this trigger the DMA
> coherency violation mentioned above for struct virtblk_ctrl_request?
> 

ACK

Move struct completion and bool abandoned in struct virtblk_ctrl_request
to virtblk_ctrl_completion *. one time kmalloc_obj() of
virtblk_ctrl_completion * allow them not in the scatterlist.
