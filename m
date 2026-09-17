Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EC4E2366
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647470; cv=none; b=NHU68F+rlM7TrLXT4TZr/N67Hh4PCMNu4yuufRGTJ8nV+XcrCW7wXI+xgvgsw1WMBeTJF6hrQl2/E44lsO5ThoUOrOLnrtpQwdf5MNqWHJS+Csv0kepwyuS/QqSxIzu9aj8wz/mJKfZ8TJsOgtuTn103E4KFCa1YFphJIJAkQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647470; c=relaxed/simple;
	bh=mFXQRplK7Tru4IGa/IeoLc1eJ1PO9FZp1wQMKUl8n5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnEYaC/3tQAK1PF3sOr015hRPVKyjFzdpueINqLF7BvLlS+/Q5tPqNhl4sqm+N52ZPyKErzZgdniJtaCkuCvcb1GZlwG+Mzur2iI3v3PC7YSumpDJlZF/WDYpleYhS/4jGKzDe9I+YoqBhMDRzhTJSEGHim/6drO9RqW59CdKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QV32/7r6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JZTlSIIL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QV32/7r6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZTlSIIL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9Zr1C1863444
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 12:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	knfojBFIONKDfO3+XeI2J2qQx98XKylUoNvwAISaqCM=; b=QV32/7r61PCxOWfn
	Bhel+CmW3ILGi2CDlU93qFE2CruF8lhsar+m/pMKU6QBoV/swqBZxWuUIjgk8LgQ
	R/8HCilhpOCEt1e/IUiLlMh0aBhJRiWj+KhrTmpVMKQ5IhMJRWeXMYLeK/u1iCV2
	VSb9KqhLCFGx2QOKKmeTy8dyqjVhbs6fieWrOv9MXBaf0QvGt/cQtTTMDAK9ecpG
	SpPCrwCCm1tP3weFP62emNuniKYbyKF4/enG5psCwYBBoC1WwHbW4oea1egI+PqM
	lG5LKn1j7i2aJpZsnxizhmC3wzR7iVQsTON5jhhMJLGZla8LBcCociWnI97Mr7Y3
	DbuIvA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy6av5by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 12:17:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso11347475ad.0
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789647452; x=1790252252; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knfojBFIONKDfO3+XeI2J2qQx98XKylUoNvwAISaqCM=;
        b=JZTlSIILlEymuvPU6ZrfeV8qPp67VDk847BfU+6rIxgXJ0MxJqrK1kSi4McCffiTBW
         wqQJwVThl4pc/MjSL9QCCgBoQzmrek+SluNhsvwt8LUNnjDNG1lxm2PQjYjES7evIV88
         XfCP3YqF8cjrPKLIwCvCZVckpa5MClzIOg76SdLYNYoqIWSuyDKWdiTMV3FaBu8rLill
         Pnx6oKzL9b9PJdN5KTzIKzo+hj5lqIbNW9SuFNEvcfV870Ob3nbFXb68+jtAwzFLobiv
         G2DyY20NE8Tfs1YKgKJSq5rk+eGdYrq9qOVxhswqC8yUF//FrznIS+fAeD2uU8BCPBu7
         700Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647452; x=1790252252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knfojBFIONKDfO3+XeI2J2qQx98XKylUoNvwAISaqCM=;
        b=NVa0P3PAj+RV68Wcfmjj6CTGTP9JQlwG2ppIJjjhzZDZv4uwlMsDZZa0j1XkzHM0WX
         meJ9fym7b1opkDVR//KTnUTn0j7PmJxIO0Kb+aW1gr1UvZk71+yAa4JDt4OHIj+PI1+M
         r39vegU1vLorC7PaaxUMFP9+UDZYNPROgrHjSauoeM7Hsbvkq+CfCyJzSv+JjI53H4Ac
         Dn4UienthuKcLRg4W+OAXycBC9ETVgIZrvlczwxwzK0zDm3cQTx0P76uUiQCsRvNv7aX
         e1dMsLS3fTcDL8T4SNDxyK2oJj7cMjRulK43cyGbSl7h20vGjOxaTPcAD+ByAEIwKO6E
         YXmw==
X-Forwarded-Encrypted: i=1; AKwUvBxsype6xePD1VKpqvqwxL8ALiXAJkeEhmBOVgOlu+iFW68dKL59DT3hYEzrMDL4mBwGjrAGI4L8rLIxRalDqQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lAgCxqeBNf4oJrXG/yACoEO6klmGNQO+cEm835r4nX9Biw94sI
	3Ry6eMHEOf1dptIVjWjcmtCxEgvHHOYnJZtdcY1a+gGEBkYohKFwLi8789vPGWOnXfCfME0cd+c
	qcRFlKKOZluKx7+PFFxNg4M9L+vqZoVbuKV82xLV/ApRVejQSRs8MWPfUfXChj/LZFYDfaA==
X-Gm-Gg: AYBFou3gTr1LxS3Kspqn7k+nXYHiDHMujFSd4aiYgOu0YtGTzcNPtw50vzU8jFbM7LB
	JVZsyenckUebQCiU9JjgXMjzjK3c67zZ0XWEJlou2p6U77Pmj833onfCTYsWHtTjpTvckcMPEy8
	bQYXc2VYjnX5flSitxO+eUIUDaqO/Rjz0J2aBz7O0k9jr7vVBzxZemP8l7CZWGwVlxsV6YpbbfK
	WSF9beqgfxrbICNODADaefp30/LEE9pnuw9vsUiihAaizysa5GgBnwelhtHI5d3ApUrYg8TMwTb
	RTj9eckXSOqxSPsRnR0HJFo5uGaPzgUkVYns1vMzFIAgDor00NoTyMFCa7KirMxEW/GM054GGoF
	Rs8APbV12ZpGf+16w+rBFRhQayvYAkySRrluw/r7x6T8fiuz3E9jFeV/Ljg==
X-Received: by 2002:a17:902:ec87:b0:2dd:ad73:5b69 with SMTP id d9443c01a7336-2ddad735d3amr1179185ad.25.1789647451550;
        Thu, 17 Sep 2026 05:17:31 -0700 (PDT)
X-Received: by 2002:a17:902:ec87:b0:2dd:ad73:5b69 with SMTP id d9443c01a7336-2ddad735d3amr1178785ad.25.1789647451068;
        Thu, 17 Sep 2026 05:17:31 -0700 (PDT)
Received: from [10.110.122.88] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f12117sm25529505ad.70.2026.09.17.05.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:17:30 -0700 (PDT)
Message-ID: <b133206c-51e7-4877-be14-a4081e9e7cd7@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 20:17:27 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio_blk: Add control virtqueue support
To: sashiko-reviews@lists.linux.dev
Cc: Eugenio Perez <eperezma@redhat.com>,
        "Michael S. Tsirkin"
 <mst@redhat.com>, virtualization@lists.linux.dev
References: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
 <20260914133733.15429-2-linlin.zhang@oss.qualcomm.com>
 <20260914140213.398941F000FF@smtp.kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260914140213.398941F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TlQqA4UJWzXwRzPXVOrBZffOeaoK39WK
X-Proofpoint-ORIG-GUID: TlQqA4UJWzXwRzPXVOrBZffOeaoK39WK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3MSBTYWx0ZWRfXxo6HW5oIxkba
 Eyk11gnvAZkMNOIHsjxhqiQBrhSBGLPr+pVbytmvLPVtPCIVsAF180Wp2yXwSKpF5r7UMR4w1o+
 ST7yVoC5GO6E3Io/DwbleftXEf7KbJmjlrvlSoRGmx9qRDxd8AyK7kAsAQMTVCo3ECcNnOIMQtA
 ijECgnXyGDzNjruJsFoq/6cv+KARcqZwEJztJgvLv6eUsYV+KY1w7y7J6aP5zWgXRtbr64C2NSq
 s4q7bGEEumsoJmWrPVCap4zjOXQN8Sj4G3lJmH2KJlXKOXU5VopGS3InIHLzql/vGwlx2BAylV9
 fXSlWDMCwmp1WHoPPNVEDERxiXFYbi38wPnxjskkCbCLRGz4Z+zQkLb46mkPzPh/YRGIe7L8/6T
 qjrzGNpF1kPEmOkwY9nyhJP2N0ldc85L4GL2y6iXrj8eAQVmquy9ubMjwRr10E89/r2U8Ghu369
 XYvW59eBD1ZAADJMttw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3MSBTYWx0ZWRfX+cE9ft6cAubn
 SACM938+sDygFBKXBHX12UqsroIxWFtJpPQ6EU7z39TuqBeggqeEICInRON0wd5yRqS/IvOok2D
 QwJMDXVJIuMA9NOazAs69OlhpHLiQek=
X-Authority-Analysis: v=2.4 cv=VIRIDNPX c=1 sm=1 tr=0 ts=6aabda5c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2u0DQsLCC9M23k4N1EAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170171



On 9/14/2026 10:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] DMA cacheline sharing causes memory corruption on non-coherent architectures.
> - [High] Erroneous teardown ordering causes valid in-flight requests to fail with I/O errors during suspend.
> - [High] Unbounded wait in `virtblk_ctrl_vq_request` deadlocks device teardown if the host is unresponsive.
> 
> Pre-existing issues:
> - [High] Use-after-free and double-free of `vblk` in the `virtblk_probe` error path.
> --
> 
> commit 36271d203fcaee50a88fd7b53aa73dbbba25cf7c
> Author: linlzhan <linlin.zhang@oss.qualcomm.com>
> 
> virtio_blk: Add control virtqueue support
> 
> This commit adds support for the optional virtio-blk control virtqueue.
> It allows the driver to manage control-queue requests independently from
> the data path, preparing for subsequent inline encryption implementation.
> 
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
> [ ... ]
>> @@ -110,6 +123,12 @@ struct virtblk_req {
>>  	struct scatterlist sg[];
>>  };
>>  
>> +struct virtblk_ctrl_request {
>> +	__virtio32 type;
>> +	u8 status;
>> +	struct completion compl;
>> +};
> 
> [Severity: High]
> Is it safe to place DMA targets (type, status) and CPU synchronization
> primitives (struct completion compl) in the same struct without cacheline
> alignment?
> 
> On non-coherent architectures, could the DMA API unmap operation invalidate
> the cacheline and destroy the CPU's unwritten modifications to compl.wait,
> thereby corrupting the waitqueue? Buffers that are targets of DMA typically
> need to be cacheline-aligned or physically separated from CPU-modified
> lock/sync primitives.
> 
> [ ... ]

ACK

Update  struct completion compl to a pointer of struct completion compl.

>> +static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
>> +				    struct virtblk_ctrl_request *creq,
>> +				    struct scatterlist *sgs[],
>> +				    unsigned int out_sgs, unsigned int in_sgs)
>> +{
> [ ... ]
>> +	wait_for_completion(&creq->compl);
>> +	mutex_unlock(&vblk->ctrl_vq.mutex);
>> +	return 0;
>> +}
> 
> [Severity: High]
> Could this unbounded wait deadlock device teardown if the host is
> unresponsive?
> 
> When called from a block I/O context, this thread holds a reference to
> q_usage_counter. If the host hangs, del_gendisk() in virtblk_remove() will
> freeze the block queue and wait indefinitely for q_usage_counter to reach
> zero.
> 
> Since virtblk_ctrl_vq_drain() is called after del_gendisk(), wouldn't the
> system deadlock before the drain can recover the stuck requests?
> 
> [ ... ]

ACK

Add abandon flag in struct virtblk_ctrl_request. Set a 10 seconds timeout when
sending a request via the control queue. Set the control request as abandoned
once it doesn't return in 10 seconds to force finishing the caller in the control
queue, so that q_usage_counter in the data I/O thread can decrease to 0, unblock
del_gendisk() finally.

>> @@ -1553,6 +1713,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>  out_free_vq:
>>  	vdev->config->del_vqs(vdev);
>>  	kfree(vblk->vqs);
>> +	vblk->ctrl_vq.vq = NULL;
>>  out_free_vblk:
>>  	kfree(vblk);
>>  out_free_index:
> 
> [Severity: High]
> This is a pre-existing issue, but does the error path in virtblk_probe()
> trigger a use-after-free and double-free?
> 
> If device_add_disk() fails, the path jumps to out_cleanup_disk which calls
> put_disk(vblk->disk). Because vblk->disk->fops points to virtblk_fops,
> dropping the last reference invokes virtblk_free_disk(), which frees vblk
> and vblk->index.
> 
> By the time execution reaches out_free_vq, aren't accesses to vblk->vqs and
> this new assignment to vblk->ctrl_vq.vq writing to freed memory, followed
> by a double free of vblk in out_free_vblk?
> 
> [ ... ]

It doesn't lead to use-after-free or double-free.

Because
  1. put_disk() calls disk_release();
  2. disk_release(）calls disk->fops->free_disk() only if GD_ADDED is set.
  3. GD_ADDED is only set in add_disk_final() after the successful call of
     device_add_disk().

GD_ADDED won't be set if device_add_disk() returns the failure, then
virtblk_free_disk() won't be called. vblk->ctrl_vq.vq is set to NULL before
free vblk.

>> @@ -1593,6 +1759,8 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>>  	struct request_queue *q = vblk->disk->queue;
>>  	unsigned int memflags;
>>  
>> +	virtblk_ctrl_vq_quiesce(vblk);
>> +
>>  	/* Ensure no requests in virtqueues before deleting vqs. */
>>  	memflags = blk_mq_freeze_queue(q);
> 
> [Severity: High]
> By calling virtblk_ctrl_vq_quiesce() before blk_mq_freeze_queue(), could
> valid in-flight requests fail with I/O errors?
> 
> virtblk_ctrl_vq_quiesce() sets ctrl_vq.dead = true. Since the block queue
> is not yet frozen, in-flight block I/O requests that haven't yet submitted
> their control requests (but have already incremented q_usage_counter) will
> encounter dead == true when calling virtblk_ctrl_vq_request(), resulting in
> -ENODEV.
> 
> Should the data plane be frozen before the control queue is marked dead?
> 

ACK

Move virtblk_ctrl_vq_quiesce(vblk) after blk_mq_freeze_queue(q), before
virtio_reset_device().


