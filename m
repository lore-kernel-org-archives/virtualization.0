Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8245C6E0
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147515; cv=none; b=s2RXBjsCCOZuA+LXb3MpiqqbwL0WyIcsR/vYoy9RWuG2zN+XptjvN8glGLr0F4Md2NZdO7uQNoCc62gmOTcQicWfycUCuLXQzrZM/rD+bleiswMDfCHv/dZhpIAxbJXpe7YIyDtIBf1ablhQs905SQopmPeJttS+KtG/2cdSwX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147515; c=relaxed/simple;
	bh=za3xPCzkeb/HbtLkfxowaJK9cwklSa6k6bFi2PQWCX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CegRMIV3kuD1XSPwIrx0otlfyThPW1nRopeM3e6oPN7n4d5fyp9PQ4utdup1MCKoh6QIZ78hKqS6J8KrF1kJZiGgeUe+PNMXdrR+SeB4GRS9WQU4ECIAUWkQsHCQLOq9uFkqOqchHRExUW5URTfXx8L2utaL4vLH99FWFt+zA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqjC5hWj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FzX8Dwwg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqjC5hWj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FzX8Dwwg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAK7U1946480
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 10:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=; b=cqjC5hWjjuUoAN2r
	fUvmguEvQmzjUOru8VPNLlR0Zj/In6bXgvtGRAZaZE8XZUkxH62CRIAs0qVj5Nqy
	dYYzuzBg+munPZgSSPpYXfLVtoOxGrYsAUcUWCDd2AQHE1K3PL7ij4pv/if9XXDx
	pmRslDDUIVc38faPIZEiXeDJK/l5Fwae+R2t5PsDB+bHLPyIyOwBN3BZlCYMUF38
	mhyFamLnXVq7RGzqaxQkYRnz93kxqjtgXcMcjE2DFuoRkES+ndsTN+s8ZJBI1gO4
	dm0R6/cAcRdlsi+2gliSOOK9iX5+InZNJXU725jeoQIsN1PHnBAlk69+Bq0fP4yO
	qvFn7g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yrjtv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 10:45:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so1590896b3a.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792147511; x=1792752311; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=;
        b=FzX8DwwgM4wTNeVp3qVbFh6ZSElOFMD9pfkoe82lj5VOBRQQMa1Z95YyqeHFKRdxAy
         3PHLsjd8F+UkrUaIxkw8hc2dDJBvNxFzBdY9Lyxxd7Z5KUbBmfcCgsdrJBkBPl+g9Rqb
         lbF7LHDMQo/SnFn6ZA/yLYARiYmtn/nx8dqTJ7GOK/u8JRKnzHcWXNmtTvt3v4iadZRd
         dwQG7xJFtZIRGSsCPTtY08x/COcg257ijsQrPc2Jpzp6DkQih7+sop66/R4JckAnzt7E
         KP52hEstXO8VeX/hlIfpA01ItGalfPOqfiinrZR3rVin9XU1t4C1tD/qtdgyryfeP5F4
         eDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792147511; x=1792752311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXyFb2bWpRvXjn7PnLKNSg4kUzQ9j0D6sJu6sZHfQlA=;
        b=q4SR1ury4cdDugYkgTgYojYR+WflOO4C80D0Mt/PmnBhtyAkkOA1pFez0KE7KVdFyM
         IIZyGT0P84ujqb2UjJNTBhoiJatTQ1VS/lITJmmQ2LjS6tvhWL8uroQVKkIiqBiIpbEp
         5Z20MmT0153fbpuWcjDVAZ9XQqeh06R83ZniEr+Zj0o3ELGwK3zU3fWKYJm/PHcYcQl4
         sMBXFAUlHrJcukjurM30Zm3kW/mjC5C+PDJnvFnQBpzZn7TtoVV9LOBwFE8RqQObXLxj
         m3EjEnP0iLYyG3a91nm+CVkMpbDcihzmhTLbWA4RQfGA/+08v5Ej9Ll5ErcnflqP8a15
         1IDg==
X-Forwarded-Encrypted: i=1; AKwUvBxYmWJjyvJabRZuNVwLSic5iVUGFXdctEaMuZl7Ia7WpcZAu5GHKVOR5nDtonrH6mMoj+XeNajQbZ6oyHpbIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJgntRgJVzuyGQbQr0/KCWdHEdeqglJg0khAJv4HuaGvvdKJJ9K
	9RatzWhtPfbZt5//S96R6aLnrlxo1EZfb/KN0iOExyaZZ0CA4eCu9iywiT8K3mI2HlxEa2nsVOI
	rcYrQ+uZWfHV4Jll4DSsgSM+fRA3mAGDwVxhnKDqW+jex0H4JZeZDg5q3wfOLshF5nk/UVQ==
X-Gm-Gg: AYBFou1m6lOBoldZYWHDF/XoJcipzism4Cg1HkB6enSLx9mbparUgtQe5HfsmOgkF4p
	nc7oveuExsX1dcdN1FWOfKStF9BlvZkCdotGcq0WVE1ybfvdhCnVQTQLU6JCb/0tpJFwCXbAfP0
	lI72yH0QD4Wj0fHztiuUHZV56JeZFZ8OiV+ATXGk7UtIJmwR5/sgbvvpzIhOUq9Y3a38MbMvvER
	2npQtLcwOrFtcJrUVgJ04389uBULLOO6hWcuW5CIaZ53tfJVyJLY2uF9yG/UXlxpq+X2twhEhPs
	+HyRPTqGY34dO9hGJgvtWnhjXR03QZK1bxu2W+TrvVlvB3/zRcgA0F/XH6LUySWpjDn69ic0D+w
	7xujKPRhPucE7Udus2YBFF4pea5w=
X-Received: by 2002:a05:6a00:ac89:b0:89f:3f60:cd81 with SMTP id d2e1a72fcca58-89f3f60dd06mr2297224b3a.51.1792147511472;
        Fri, 16 Oct 2026 03:45:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac89:b0:89f:3f60:cd81 with SMTP id d2e1a72fcca58-89f3f60dd06mr2297188b3a.51.1792147510877;
        Fri, 16 Oct 2026 03:45:10 -0700 (PDT)
Received: from [10.239.132.237] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947fb2sm911384b3a.37.2026.10.16.03.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:45:10 -0700 (PDT)
Message-ID: <c02ffaa1-88ad-4fc7-9171-f8eef64f9ea9@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:45:05 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
Content-Language: en-US
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
In-Reply-To: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AQgN7XnilQDi8XweKkd6_rqDCLOvv8jG
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad20038 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=BM0rjV1Hin7eb0uZrgEA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX+M8rq5XfhMxY
 ap52eR21nk+Tspub2Bsm2+NJBFhuElH8LtoP6aTL6RjacbvmRPSxryHeWB+RFMkjjCZONC3XTvs
 sTLfCFG9C1z7hShxkm+8MambzK+A1+Y=
X-Proofpoint-GUID: AQgN7XnilQDi8XweKkd6_rqDCLOvv8jG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MiBTYWx0ZWRfX6kVWuThPQ9In
 ktAuPS78a/dGXNm30uZ4kcU2G8oZGFFqUJo9Xt3GJbCo2BbutoMONRV8X+DWAQ9AV6nkQaaggeC
 8ZJebdQuTpuMMSdyVvQYhd6TbJytz3ltd0wHxptRRn3SsVjR4u+QZGWIN1+bHMa8jJWVm9HP3Lz
 phbL/VfjdGmZb8aDzL58AHKS2uQFSlPdysm6YFwgheo8J/TIPeZnL0SmOCPHfoaCD8Zgjs/owhb
 2nx7GkhwIVMU2XJjC5NE1MXHFy3kbuUGAB7jSl2B2tpWnZtuGf72Xf3Fwd/yIggJ8rCBROrWiou
 n2w5OyUfMjIm42xfBuZ0p8UI1pypuXcDc3plC49uWtW5FbzoS6c7OlD8ERO/hZkC8oBxKNr0h8Q
 sBsgEzGV8KHTx7TLw/yYIJrOW7dxKoCt5aQyhfCQnxsfRBhr1Xl2qpFGPeS3iylFM8tm9V+fXpF
 OZai6Kovb4dVdIyWKaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160042


Gentle reminder on this patch. Any feedback would be appreciated.

On 9/28/2026 7:58 PM, Cong Zhang wrote:
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> 
> Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
> that was already running. Keep the existing freeze and unfreeze order.
> The queue remains quiesced until virtblk_restore_priv() calls
> blk_mq_unquiesce_queue().
> 
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> Cc: stable@vger.kernel.org
> Acked-by: Jason Wang <jasowangio@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> Changes in v3:
> - Move the race description into the commit log.
> - Remove the blank line between tags.
> - Add Cc: stable@vger.kernel.org to the commit trailers.
> - Link to v2: https://lore.kernel.org/20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com
> 
> Changes in v2:
> - Cc stable@vger.kernel.org.
> - Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..7a570591e040 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	/* Ensure no requests in virtqueues before deleting vqs. */
>  	memflags = blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue_nowait(q);
> +	blk_mq_quiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);
>  
>  	/* Ensure we don't receive any more interrupts */
> 
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
> 
> Best regards,
> --  
> Cong Zhang <cong.zhang@oss.qualcomm.com>
> 

