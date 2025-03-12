Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2141E8351
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772684; cv=none; b=izY8EsKfVasRzIA15GejzOzsG3H+0FcGZpggvL9t/4jyBl0btWWuybbAP7hORkPi1Lt6Qp/yuNydIwFyoTivxuDDGY/QSTV0tqRd+nnvQucymKkYwZPyLuHKFATIcQAoySU39XXD5/ADelLs+/0x4s4a+ptXII73b4oHGBrIAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772684; c=relaxed/simple;
	bh=Hb0nBFtAqTDZUnfw3bmwRPV2fj1BVznEGk2I24zvCo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bzB8s8flYgJ/cWmjwtJEqsTvpV/mTUEiW3f1qcfvC/dobUR6srSdcTavfWvj3YvDmlNn0hR37JlMtS6iiN7NZTk0MX8H3dFXJYRB/uhjDg8pJQw1Rtr7o6ouhDn+DrzfQ6xcufdNmh4wVbSk0GZD9P38sOCekJDo9IPp904wjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WrKS9I3J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WrKS9I3J"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMH9oW008707;
	Wed, 12 Mar 2025 09:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lkQz2JxeyWrc3XhP8GgKRW466K064L+tncOacxy4RB4=; b=WrKS9I3JV6yoTLEJ
	vbnFTzVl/Dev9vYulCMhzHe8c/fSJ4cuBxSlx3LYdSjkPA6KGs4Ejs/i992jrBet
	+QOHFzbnpNZZ3bikiwL5hdsewxf5VkL0X/FAL+aYcG7DEZJjgd+XP5/pD70H5nBT
	OI4zk3dDwDH/UakHey7WtAsWZET6EfWcTKtXD24IjKIsHJXVrCwmeXTxtMNVIwA6
	h3HU8+Bob86F333ionnimKfEFxtzcyAnLsIss3Q421iB6RmhpNgTxBaDD08AmyTl
	Y8Dv6OnE4LEFnasSuZdDIaKjOn0pbb7DO15ClPNirznNiTWW9udA4F7llA3xxSBy
	V6zvkw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2mswwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 09:44:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C9iUuA020885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 09:44:30 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Mar
 2025 02:44:27 -0700
Message-ID: <c369a746-b9d1-42a9-be37-6aa2d4e11423@quicinc.com>
Date: Wed, 12 Mar 2025 17:44:00 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix data race when accessing the
 event_triggered field of vring_virtqueue
To: Jason Wang <jasowang@redhat.com>
CC: <mst@redhat.com>, <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com>,
        <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>,
        Zhongqiu Han <quic_zhonhan@quicinc.com>
References: <67c7761a.050a0220.15b4b9.0018.GAE@google.com>
 <20250311131735.3205493-1-quic_zhonhan@quicinc.com>
 <CACGkMEvK6adr6m-LpWxFxAz+pTPYpnA3gO4sLhs0Gc52nrbYLw@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <CACGkMEvK6adr6m-LpWxFxAz+pTPYpnA3gO4sLhs0Gc52nrbYLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BN+zrEQG c=1 sm=1 tr=0 ts=67d1577f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=COk6AnOGAAAA:8
 a=hSkVLCK3AAAA:8 a=gZ10_t8O0kcrIWsfhs0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: aCJcVu98_tfbL0Zpx9B9HtK1nK1JkHBQ
X-Proofpoint-ORIG-GUID: aCJcVu98_tfbL0Zpx9B9HtK1nK1JkHBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120066

On 3/12/2025 9:11 AM, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 9:18 PM Zhongqiu Han <quic_zhonhan@quicinc.com> wrote:
>>
>> Syzkaller reports a data-race when accessing the event_triggered field of
>> vring_virtqueue in virtqueue_disable_cb / virtqueue_enable_cb_delayed.
>> Here is the simplified stack when the issue occurred:
>>
>> ==================================================================
>> BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delayed
>>
>> write to 0xffff8881025bc452 of 1 bytes by task 3288 on cpu 0:
>>   virtqueue_enable_cb_delayed+0x42/0x3c0 drivers/virtio/virtio_ring.c:2653
>>   start_xmit+0x230/0x1310 drivers/net/virtio_net.c:3264
>>   __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
>>   netdev_start_xmit include/linux/netdevice.h:5160 [inline]
>>   xmit_one net/core/dev.c:3800 [inline]
>>   dev_hard_start_xmit+0x119/0x3f0 net/core/dev.c:3816
>>   sch_direct_xmit+0x1a9/0x580 net/sched/sch_generic.c:343
>>   __dev_xmit_skb net/core/dev.c:4039 [inline]
>>   __dev_queue_xmit+0xf6a/0x2090 net/core/dev.c:4615
>>
>> read to 0xffff8881025bc452 of 1 bytes by interrupt on cpu 1:
>>   virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:880 [inline]
>>   virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2566
>>   skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:777
>>   vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2715
>>   __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
>>   handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>>   handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
>>   handle_edge_irq+0x16d/0x5b0 kernel/irq/chip.c:831
>>   generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>>   handle_irq arch/x86/kernel/irq.c:249 [inline]
>>
>> value changed: 0x01 -> 0x00
>> ==================================================================
>>
>> After an interrupt is triggered, event_triggered can be set to true in the
>> func vring_interrupt(). Then virtqueue_disable_cb_split() will read it as
>> true and stop further work of disabling cbs. During this time, if another
>> virtqueue processing sets same event_triggered to false in func
>> virtqueue_enable_cb_delayed(), a race condition will occur, potentially
>> leading to further vq data inconsistency because both
>> virtqueue_disable_cb_split() and virtqueue_enable_cb_delayed() can
>> continue read/write multiple field members of vring_virtqueue.
>>
>> Fix this by using smp_load_acquire() and smp_store_release().
>>
>> Additionally, virtqueue_disable_cb_packed() may be called in the same
>> stack as virtqueue_disable_cb_split() while vq->packed_ring is true in
>> func virtqueue_disable_cb(), so event_triggered should also be protected
>> in it.
>>
>> Reported-by: syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/67c7761a.050a0220.15b4b9.0018.GAE@google.com/
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> 
> Do we have performance numbers for this change?
> 
> Btw event_triggered is just a hint, using barriers seems to be an overkill.
> 
> What's more the current implementation is buggy:
> 
> 1) event_triggered should be only called when event idx is used
> 2) the assumption of device won't raise the interrupt is not ture,
> this is especially obvious in the case of packed ring, when the
> wrap_counter warps twice, we could still get an interrupt from the
> device. This means when the virtqueue size is 256 we will get 1
> unnecessary notification every 512 packets etc.
> 
> So I wonder just a data_race() hint would be more than sufficient.
> 
> Thanks

Thanks a lot Jason for the review and discussion.

Hence event_triggered is unreliable hint and used as an optimization, 
the racy is expected.

I will use data_race for KCSAN and arise V2. Thanks


> 
>> ---
>>   drivers/virtio/virtio_ring.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index fdd2d2b07b5a..b8ff82730618 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -875,9 +875,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>>
>>                  /*
>>                   * If device triggered an event already it won't trigger one again:
>> -                * no need to disable.
>> +                * no need to disable. smp_load_acquire pairs with smp_store_release()
>> +                * in virtqueue_enable_cb_delayed()
>>                   */
>> -               if (vq->event_triggered)
>> +               if (smp_load_acquire(&vq->event_triggered))
>>                          return;
>>
>>                  if (vq->event)
>> @@ -1802,9 +1803,10 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>>
>>                  /*
>>                   * If device triggered an event already it won't trigger one again:
>> -                * no need to disable.
>> +                * no need to disable. smp_load_acquire pairs with smp_store_release()
>> +                * in virtqueue_enable_cb_delayed()
>>                   */
>> -               if (vq->event_triggered)
>> +               if (smp_load_acquire(&vq->event_triggered))
>>                          return;
>>
>>                  vq->packed.vring.driver->flags =
>> @@ -2650,7 +2652,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>>          struct vring_virtqueue *vq = to_vvq(_vq);
>>
>>          if (vq->event_triggered)
>> -               vq->event_triggered = false;
>> +               /* Pairs with smp_load_acquire in virtqueue_disable_cb_split/packed() */
>> +               smp_store_release(&vq->event_triggered, false);
>>
>>          return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
>>                                   virtqueue_enable_cb_delayed_split(_vq);
>> --
>> 2.25.1
>>
> 


-- 
Thx and BRs,
Zhongqiu Han
