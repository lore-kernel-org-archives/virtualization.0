Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA346EC69
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642824; cv=none; b=DCplGSSPwBSzjBNlJPgxVi3aOM9Nzs5su/0w7WKoAaqkoR3XWA6QzX7rSIM6MLkajCU3vmzTuaFPP3GYut5PpM+68eZLW02lmK5Cphm4IAgo9GzAy+Tt21+JGCLOFswiTuDwHU1RKisYqW8lAevEooIsLlBL8xt/36iWkxW4nfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642824; c=relaxed/simple;
	bh=IHjKB4L5nRV2UKl/PMgUcbJsiI5fL3VekqREU8PfNK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iamc9Yq7ypMEWHlRTWBIPhYLgAIVFNyCT3SdrJV5IOoocQPG4AOqnYvVGsn3Fg4rgsAdmh4n+Q1xzzTy03lGF82l9thu+nPLnwDavooVAmWA5KhLlsNJ7aPszaOPKnoAoBag1gwafD2vSzSZlocTS2C74+RzXEgnHLRaL574VkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3r3Fe5Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fhZIX3w/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3r3Fe5Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fhZIX3w/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9Zc1w746581
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 11:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+jTM8LwMfdXriiY2J868Sv0nXBm4Jhe5/I4UKZcO15Q=; b=M3r3Fe5Yp5jZwPeP
	6U1a3JjNypIugGMJkitHM/ngIuXONUYfoxQmf1OOtvXXtV9pNgrtuKf6S9+1d0iJ
	4lvxFRHh+fRe7rWMd+ddKdiPs6U+bULLVs1vBFyoH5I4Q9XWDfeJ/6FwkyYO0Cmp
	an/Bsv0eb1P7eoFsE4d9ulQP+BLvjOmyOd4EtyQZa0vYg3YR7UMCrELsxsQAP1+t
	QMQP+Wc4TC44UhbhWCLWqf/j5rffOI9FzyhT+SO9chgi2MM8ufRVV4/XQ3j9yRas
	3ROpVu6TmvnQLjmbWToT7IlKqq+tsbMjnVYNNYi02H31alHdNKQOBIUiaahznN3p
	uHqgnQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grcra8k4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 11:00:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so1394806a91.2
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789642811; x=1790247611; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jTM8LwMfdXriiY2J868Sv0nXBm4Jhe5/I4UKZcO15Q=;
        b=fhZIX3w/9BUpbUkuRSLd2o1I5VMswdfPTpGWz4wrnvJgJ73XPf90EOYKmscBiNCHzA
         UQKYgykhkXZlsCYa1ZBJE5k+AahyQ0U6SprcH7eF4Mj7bOPBM44yisfyHc2UMIcBSQ1f
         fXHyYIy1UiPE78chDtWqQyBZpOK0xWpPqwR+F1vvbNz14cKkUc0/pLKAhHwXarPZWs0J
         OsxXM1M34xhjcV4WWFrqzPXSc24E4Z3rlVqAW85lhxeprsgRgPM3Gn7a0t+UEGUmkyig
         zsXdP8DqbFVnSKIrGCSPF5WRRO1igMp4qGGs+arNeU9k5VpQAos2Ayg5IskkDNjBONkf
         fIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642811; x=1790247611;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jTM8LwMfdXriiY2J868Sv0nXBm4Jhe5/I4UKZcO15Q=;
        b=aCKS5spac6jmtdBSgRXtLMz6pcEakQfnP6D3zt9fux67oZiYr6okZ3X3sy14669Gtj
         b2WD0USqjA+p7LSBaLVuBuFSJvbF/BXNWThLIbVehMklVd/C7oaTKkukDGTtMhba9o82
         r06duUlHkR6gzOMDD5jYKScAu6y3+uyUpgk4+6tF0nqf6D7uxYD9a3Rm+Llrwu8mJdxx
         s3drSah0xmeWbDOUlY2Ee7dgfEldKqddnCIYZ8u8qLgWcyKMA9/HDUv1VDFsGDbHJS+R
         aYRQfQZwj2HFETP+QxNQSwcprE2zVXxm/jnI6i+NTX0Min06h9TrkqL3DZ3AzyKmiNxd
         Kndg==
X-Forwarded-Encrypted: i=1; AKwUvByDQUxSyVHkva9QakMzLc01EbfeZYz+E3uSgsg0mseLUyoZ7/XSo801GuSLZVBN6AwTf5WXw4C2y6pJV+2Nwg==@lists.linux.dev
X-Gm-Message-State: AFuF++m8iUm/stxUh7JguhUN8AJxRFglbZxawGEAnSxAI2he/dFx0cG7
	+8Ayt0Zt7oatorMB1C523H8wM38FkSeTVEgKNh7jryZsgf9C8EsJUo0gY3vybma0E4I6ixDWUYJ
	BwRCJ4U78+VNnlXxunwaqrc/e8/6mJNAWXCMUjwvTsD63xBiWUhlpSgs1UqVMMsKsMzuMTA==
X-Gm-Gg: AYBFou0VcYiZnO5CRl/jsXLXD13bbT1MZuLo3o0NxAzOTjq5R5Rdflyx/U+tKt8URDx
	Cc6vHKzUg5Hl6j2orm4ilr0nAg3VrJbCEzghdMKhpSGbxukrV9POUck7SUclVyvojMTFa5JhqiR
	J0QF5AqgKifmj9Q+ndreMuewIK8RsW1G0ye3lm6e/cocehTadYjiABqzsbiE+PoRqhu7iAKE7fW
	y2VGKVaXeiZWM4IKNDbSus2HkFXHhUMhzYmwSBUSYzMy05emO/j54y0Q1INDfJG66McoLYy4PLE
	pKB1fAdgyddDGE0UX2QHu3YrnKMqnTZerMs/gAE2+F3Zehj7K3IfEVeKAIhciYAy3uO7AbZXYUT
	gBavmDawc0xBFfjXK47mlRrk6dQQ=
X-Received: by 2002:a17:90a:6c96:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-39e21a7824emr9355198a91.11.1789642809576;
        Thu, 17 Sep 2026 04:00:09 -0700 (PDT)
X-Received: by 2002:a17:90a:6c96:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-39e21a7824emr9355108a91.11.1789642808808;
        Thu, 17 Sep 2026 04:00:08 -0700 (PDT)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35e732d6sm4715358a91.11.2026.09.17.04.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:00:08 -0700 (PDT)
Message-ID: <ab07749b-2aef-485c-b54c-becd26e5dfae@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 19:00:02 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-arm-msm@vger.kernel.org,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
 <20260912050459-mutt-send-email-mst@kernel.org>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260912050459-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE1MiBTYWx0ZWRfX7qxoMwP69bFZ
 Tcc6tZHG6VQJUVemwQS5qTu+/FhVSX4vCOAzKXxf/pGEbvX2kFSPMOef0WEvx6QglfAozt2IIjf
 VdFvto0OpGhKhW9g5ABxFAU1dMLTTwE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE1MiBTYWx0ZWRfXxdaQdQ/+N6T4
 +89KtT7et+EyL7VuaTedQbZLGy2EAl33D4vVZdWJHSEuahMRy4tb7CvqGZz2At8cxmexG4cwsEZ
 dmmVgonQiL21/E1w8SgoCNMQDWbrEKa3U5rAund9xZrlDc5SHDyKh5ewKKYMOI2amujxX3ljceK
 BP6E+/JJsmB3CHPXlf+hoJoNL728SLI2syyT0hddRABKGFkJ7COrkbB82APAj4KH5thmlWvLdBd
 ILGoWivi7aH9+AFHK0vwu+9KCWvHwFhygPqtByEos4E4075VxspuaMuBKrTkBy//tzl9O2SUj7s
 /0kErpfocpT8VVf50emNxvSiwPx8EzfJAQg87r6rjP0YYF+ChEB0WEhxpV4vs2ZOU//p9Prf7mb
 1gdu6CXtxV0HwM2mAf78keSbR4p1c2qGwiPuA6SdendA/9nLnTjlWzt4lNE5yAz7sZ4GSjjl3Ji
 9dGEBEMuJHLv8t86i5g==
X-Authority-Analysis: v=2.4 cv=WL/qzXsR c=1 sm=1 tr=0 ts=6aabc83b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iuKekLPq-CDQsUwbdJkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: VW9WlFlt87E5NUvB0ww_xFdOkXpB6kfN
X-Proofpoint-ORIG-GUID: VW9WlFlt87E5NUvB0ww_xFdOkXpB6kfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170152



On 9/12/2026 5:09 PM, Michael S. Tsirkin wrote:
> On Sat, Sep 12, 2026 at 04:52:44PM +0800, Cong Zhang wrote:
>> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
>> virtblk_freeze_priv().
>>
>> Keep the existing freeze and unfreeze order. The synchronous call waits
>> for dispatch code that was already running. The queue remains quiesced
>> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
> 
> 
> 
> This repeatition of the code in english is not what we need
> in the commit log.
> 
> Suggested format:
> 
> The following issue was observed by ...: currently .... because ... this is a
> problem because ... and we can not ... because ... to fix ... so that
> ... tested by ...: before ... after ...
> 
Got it. I will merge the detailed description of the issue into the
commit message.
> 
> 
> 
>> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
>>
>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> 
> no empty lines between tags please
>
Sure. Will remove this in the new patch.
> 
>> ---
>> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
>> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
>> while the flag is clear. It can then be preempted before it gets a
>> request. At that time, it has no queue usage reference, so
>> blk_mq_freeze_queue() does not wait for it.
>>
>> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
>> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
>> dispatcher can run again, use its old flag check, get the new request,
>> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
>> reset the device, delete the virtqueues, and free vblk->vqs. The old
>> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
>> kernel can crash.
> 
> 
> 
> this kind of thing belongs in the commit log.
> 
>> ---
>> Changes in v2:
>> - Cc stable@vger.kernel.org.
> 
> 
> which is no longer there?
>
I only CC in the mail, but not in the commit message, will add this in
the new patch.
> 
>> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
>> ---
>>  drivers/block/virtio_blk.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 32bf3ba07a9d..7a570591e040 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>>  
>>  	/* Ensure no requests in virtqueues before deleting vqs. */
>>  	memflags = blk_mq_freeze_queue(q);
>> -	blk_mq_quiesce_queue_nowait(q);
>> +	blk_mq_quiesce_queue(q);
>>  	blk_mq_unfreeze_queue(q, memflags);
>>  
>>  	/* Ensure we don't receive any more interrupts */
>>
>> ---
>> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
>> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
>>
>> Best regards,
>> --  
>> Cong Zhang <cong.zhang@oss.qualcomm.com>
> 

