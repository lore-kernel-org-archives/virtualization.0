Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D60466B01
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117544; cv=none; b=oD79bBAruU2wb3Qlxkcp0c6Cbay/OEIn2sHY47d/WCf/YTS/Tyy4b1szWxaJ34R04g0QMLNoPJ1vzPK1OdkcglYe5JxakrY49x7749/yDOkKkIY0O582OdHHAgC5mpzchcVGMGlfShfS2JpDVM4QWOuqKJaBfq2WI7OeNz08oSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117544; c=relaxed/simple;
	bh=X3Nd95xqCpJNQclrIlWnptvcCWNauovHRLOTs2CwJRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyB/rdWtJmCB+93eVFEkKSxy+/SVu07xMP4gk5nb18WHVq3QyLLxCh+9CcW56+fTay1btKVM/I4u4dvysFscqY3IxL1Q8OPKN3N9tCi/PaYxf3ZA8lDHnBmYtlLG55o5JP8tMKUaL3WWFxpLrwtKe60nzOkRXeUAKEBjUKyvTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fyKA5qzt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MNDocrVg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fyKA5qzt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MNDocrVg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kfVw423476
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 09:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1vw7B6EIuhuPmpddwxSeUbe9DHC9nTNYShdf9NPCBm4=; b=fyKA5qztPHpSB3s4
	J3UvPAYdx3p/yzYxGlRzzQGFIBK/W4zGT0eVqEIHFo1kUxlrKZIfYLHglMqrfSjk
	kWvRRG8aXGKbiyIw44m8WCDZH9qo8F+buzz+ZsodR0WPd4pH5NaH01Pw8+wCn86H
	kwtL/o0W37mB6XUNBQouLnsd9XzbxNKAufGf7d+HCBVEhhk4MFkxCAyyWnvzSeH1
	XCL5kogLRKdRZIGMojdm5XZEja2rFReEOgaNhdSmQXASc8mYvADa0q5W2kVGoE4M
	sQ4g9Hr4hI+OTEeSsSlmq8lCopA3qfcRgy4z9RrZbdrPLzZkuIWuHYFtI28MWMm4
	tqGQnw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8gv3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 09:05:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so8358395ad.3
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789117542; x=1789722342; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1vw7B6EIuhuPmpddwxSeUbe9DHC9nTNYShdf9NPCBm4=;
        b=MNDocrVgHm+RaL7yZ4w35MHXbfvq6FDsLDnjdOXK1VnotM02AXJxX0Xhb2nV8JMQQU
         PeOC1wR3ubVQ6HYzVDACoqmlNaEGWidX02Sir6ispb8zuQnHIlSeAWE1Jagwek4tv9eH
         /TpNSu+iQKMdwVLAHwB5WzdLK2LMQTCVZa0gOYbIw/Wsfs4O/9hyhu4oTpaD8Ek58LSI
         Jah5OrE8dV4fiwMcf+NNKzcKd2Z+mXJ66JfmfD+E6pI5TxmCCpNZEIX44hRcf/RSNYp/
         guEp7WM94b0lNEew73cXr+I1YIRg/eDLqNCT7Zu2pohA7oI8t4eAhAMUXaLbqqQEytyg
         +XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117542; x=1789722342;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1vw7B6EIuhuPmpddwxSeUbe9DHC9nTNYShdf9NPCBm4=;
        b=GWHA95mrBQl6trCLHcucSj2qbWn9Zsf194iYrzAmXYfzrFyOPVtfxuqNWtq7quqNrc
         bknTt4lrdcgwixJNBLGFUgDAfGfyIqg2QYfq2mD9qkSYKdk2HLFlvyAAxgSKf4rarwpk
         kjUZkSrFRPC7YQ2kgZyCkJS4itVXrBE/ulI5fMAdWTejlWs5cgNMHUy+vEwJtemZlKBD
         YHLO6nBkvuO4cjLFl2OXyPnbWOg02dZ5lX9NSynusmBX3Pt6jV34mi9DXP6EUzWX9GJ0
         d49G0C1DIpbdMnDdU1qo1jObyK2SfmHXBdxpJCwjFLZiT02usrk7QKnRPDnzi9frKv7z
         /QbA==
X-Forwarded-Encrypted: i=1; AKwUvBzFHx7A4WcQYfPQkL22brKAlimPuFEu9YR6B7aKcOLBlzN2BpxX5wjZcLenFf5qf3V8bNn4gjF0w+xdK01t2w==@lists.linux.dev
X-Gm-Message-State: AFuF++nic7Bc7YiKmQQIV3+T0JdAtjEqEdxG04cXnwY2hngJGO8wuuJe
	TSOjQA7naR9+Wvy2fZveR9e8Lm97KHAysjrTY2HTw9c26/TLxDJ1we481igayERYf6N53iS3vXg
	OlQwg9jVquAwOcjpsDtZwIG68eCpdJ8dtvjVGpo0oHOcA/rJtbDbNHHCnUGGHBZKevoWkOQ==
X-Gm-Gg: AYBFou3xdcWIeInQfQCxwPewDH2Mu551F+DyJJFbx25VSrg7+93EOh4YadmhDPXkAjz
	/GvKe69QCN0j8y6C+e1dZy7jvMMF1mSc3F8BxfMP/agDj/CnTjzOhx1XspRnntolZ4kfBTQkyjK
	nQbYcL2GI/fCmJYAnrXcXRYUpALwQoRlOFFxhb7IW1Vh8HYFwXY+ClMOiL77Xq9pAeFtLbiOyaH
	88ely4I3qqrfui1AcvyUXvde0xe+7oRrvUkDo/cU3StiXvJY/avb4ITokJ2V3cI66U9nNk8FQcz
	4uhjpASLXFxbMyWfIgTThqjLkXfAHg62tUazLjqmAanK8kG5bLeXAwpt6qXqjik/hSA4sNusbu/
	FU4byjK6fAwNhdT+MnCGxTZN5+5Q6J2wn0Xp6vPLYJZkg/igxS2P6WXYItAGhYdnjxi7h
X-Received: by 2002:a17:903:178e:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2dd2a336572mr72374655ad.10.1789117541735;
        Fri, 11 Sep 2026 02:05:41 -0700 (PDT)
X-Received: by 2002:a17:903:178e:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2dd2a336572mr72374035ad.10.1789117541116;
        Fri, 11 Sep 2026 02:05:41 -0700 (PDT)
Received: from [10.249.16.182] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfd94easm8123485ad.63.2026.09.11.02.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 02:05:40 -0700 (PDT)
Message-ID: <6ba2f3d3-7c44-44df-b1a7-1434bce94e00@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:05:36 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: Jason Wang <jasowangio@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-arm-msm@vger.kernel.org,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
 <CAAf7B_Oi_z7M_A_LwoAs_CAvhuk1NGxvADQssE65_OcTroncXw@mail.gmail.com>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAf7B_Oi_z7M_A_LwoAs_CAvhuk1NGxvADQssE65_OcTroncXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xu-iaigJbj1DkvS3GPAul-aHA2eRvMkE
X-Proofpoint-ORIG-GUID: xu-iaigJbj1DkvS3GPAul-aHA2eRvMkE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyNiBTYWx0ZWRfX7Wo4NoyExedc
 2pEGd+jf+Q3M+7sDXiFd6/hYdzz2OkU2GQzFrQqGHMctjcLjQKMw8uAHEwX6KQREzIfZUyKghJ+
 TfH/sf2cw+3hXzY01eXbG0OjszBxPDZOq7xjLbMFK17B5kuiCizp5duuYcjBhKSFLNKy8iU8zZY
 SgHcb972a9ofVTrTN1O/wRwQLYe6R08f+AQZwFktHGeWLmLwu16dCWSlEj9Hc8XpqI9Wfqw69+L
 DP7EC8eukk4UA/90vuVP0yqlr05HzUtkJtkdTIKwKnbl0RXzycjxy6CCVMKZTZSIW41yoe25yhi
 WlSrdZF+Yz+JvagIptntKwR6uPh53CI/nK3ZRRyOIi+dnqRe1mgXbB47uRuI3DLZiQlmquKOk05
 Umvb4G+ehE7H5f8vus5nqrfI7izBsGLBk7qWMXvuDDvo80jvx/GWEQvKgfXY47eSOtY8hvcOkAt
 BHIL5zlgcz0D8Nug6Fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyNiBTYWx0ZWRfX5nnl13ehXrnv
 M3SjL1Gqs8XjPQssU/MXBuHuQN/UgGjGBSzcGqoHtNfMVxKjPQ1n2tm+jjd/MVEDT056WV7kpOv
 KEO1lMRlHGetpXhXtLJIZzSNQ0/K+Bs=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa3c466 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=FvcSSuj2OSKhwKorxh8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110126



On 9/11/2026 10:22 AM, Jason Wang wrote:
> On Fri, Sep 11, 2026 at 12:31 AM Cong Zhang <cong.zhang@oss.qualcomm.com> wrote:
>>
>> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
>> virtblk_freeze_priv().
>>
>> Keep the existing freeze and unfreeze order. The synchronous call waits
>> for dispatch code that was already running. The queue remains quiesced
>> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
>>
>> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
>>
> 
> Do we need this for -stable?
> 
Good point, I will add this in V2.
>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
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
>>         /* Ensure no requests in virtqueues before deleting vqs. */
>>         memflags = blk_mq_freeze_queue(q);
>> -       blk_mq_quiesce_queue_nowait(q);
>> +       blk_mq_quiesce_queue(q);
>>         blk_mq_unfreeze_queue(q, memflags);
>>
>>         /* Ensure we don't receive any more interrupts */
>>
>> ---
>> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
>> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
>>
>> Best regards,
>> --
>> Cong Zhang <cong.zhang@oss.qualcomm.com>
>>
> 
> Other than this,
> 
> Acked-by: Jason Wang <jasowangio@gmail.com>
> 
> Thanks

