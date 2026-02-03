Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4652F3621
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131894; cv=none; b=HDzcfKzf7bumAjCCEBceyd6yE6phtwoll2Q6uAuISosbAe2J9/780V9n9YJmeRoFCp/9cWeVwfwRyHITyKyEwLftm5DbgtIlGKHe8iYcoaJAb1OKpehUvcwSl4B5TlrHsd1eWOvVS3chZenJE2kd1TlID7Fna+G4btT8SqtNv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131894; c=relaxed/simple;
	bh=huBTCAC0SSikbAdwLz43/1SAs20PtE+f0ox3U9SYL4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1gkOzss3WS3s1K4DAjW0GALP1bIoFH09WN6bpJb16oXPTmHVrGtTaJsFJRdBuh4mgDDQdZdKPp3Eidb8YQvaecTFV8BS2cG7kv5smKUJ6Xo6JiwvLnSOZFN8ojja96BR4V7wwthREd4yXSOO57SRWq+qLh6MX3BB4z2Px0kXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ApWdl6w7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hjd1vhOG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ApWdl6w7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hjd1vhOG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613D3mg9277411
	for <virtualization@lists.linux.dev>; Tue, 3 Feb 2026 15:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XH5EuiNvejIxGNn5Hrr461F6cF6oIwOIg4suguNnfHg=; b=ApWdl6w7gYoO3z8v
	eMidIeotZYkoy3pUA0QLRed7yVoFp7/y54Y8Y7ZUDY8w2VGTM+tcmiyKp4M3ngtD
	MnAWKWj2nzH73b/sPy2m4h+gwE8vxR2E/X/Q9zdZ3WOnY9RZSu7oBxq72mYtFc7C
	YSxfBo+WiwIX/2bktZBXMvQUbn8y2BtgZhCfWJkQpQLELNseeB2ZkApauDZBUVKB
	eAqMnw4uf2FyB4eCUHLnZ7+xa+pzftEIjnUKYsEUJAAq8r1EoAnNKHZ6j+a+Q7Lc
	bw4ARNo62UG8j6NmVYNVry3GXYPS+yBLizZEc6DYB70uaYal3sTE9m4yGfZLI94a
	eNPBZA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c32s3b2r5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 15:18:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70b4b53e4so2512758385a.1
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770131892; x=1770736692; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XH5EuiNvejIxGNn5Hrr461F6cF6oIwOIg4suguNnfHg=;
        b=hjd1vhOGU+BJigfXnZ3TG+z0tXMytkMxm5kRHcenHG5+LF2h1n1aZJj7VJXyMQ5yoB
         aM4AQDbJjgckN7/QuzxkrjUtDYqkAyx4V/s5BqDbGZUVQBiOr4NXx9aZ4J9xaZUa2fPw
         4/f7MsgN0HMyFI1wOkC5XU47Yokv7iPld2YKrFJ8y1yxfxJFrTWfrtK57s//Oz20uMKQ
         O4kicnbQFNGm/dtxU3FW8/SiptjIrajGnUrP3zrxyzCD+gbnbC/iXs0Ui4BEpUzYs5Lz
         +7+yzmt4dACcld4b2OxJLhwSB6TfMK2dWLKqr7hEEC4hSCNxV0ebyq//L4FP5bSgF3ya
         y0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131892; x=1770736692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH5EuiNvejIxGNn5Hrr461F6cF6oIwOIg4suguNnfHg=;
        b=a5M8kmHrq7As9yT6opmU4e+uAJNFKsvWPR1sf+8x8M5iiKQqeoiA3cKOyXhNTlJ6GN
         Hfp8ocfgYdp/4nukSZbp3WevllvbKVvM5kNmtNyV9RNU7/QiMOqcMGiQ+WdSD9TPPS97
         8RmNUjD8GpMUHHX0p3fRA6ocnwIHSfmM5Cm8ggd1esuXPzPR+FhhSGQny82FyBvcNkYH
         sArWsPt32iivyd3ylEfhqLX3NAon0rG3vKUENJYxawFZypGG9haenFLVOQBXzOzHnJH/
         V6gcFhuBfjJCsqe8IMMbguPY74cnIroMWN3E1hnBV8RFye+gUf3dyt3S1EqGK/D6oasy
         AbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbSOsXc9aIGodYgZFQqcj7MZz4Rlx1pzFEq4mbEn0ejjqp6rI9dnRPRZAf3uqh4IdJ5oADudvQ2lePHLfagA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuloPVOxY3DW7SAFeyFfKDCIVPxIMbnjtNYdfEwWS16yxa6dJT
	RrjlfUHsiOQNoifOxPWcW1hI59Ag6nafMY1dFOQNM60d+tZHeRkixu+8i165y35qh06xYEPSjF/
	eEFa5kGinHPTATw9gJE0v16H9pfsw8F/+bO4dehJpleY3tvwihIok06dXnLRL7NUMdAfE5Q==
X-Gm-Gg: AZuq6aL44I9SSZ5EielV8R8lVpEAdeqSIewx8C72DCaiL6o57jAjKxkMnEvRAg0Sdww
	pPYCUHU/eHilhqx/3bR/bwx8tJBwhhDmZ4whhYlOzmIlr00dpRU30yslQbx8InLJzUsedgVyP/r
	0QIM8VgCFjhrxNOy5jizrX7eS+qXQxAggW8NA2bZYpDXKGjm4IVDpwqLN11mMJoWvWACOPelh86
	ROG2mkL3s8+m519uNsNu0R6pRwI1KVfHhPT2rVqWaiQ2PAoWjxR5AYih/+gtmt6thWAxicgBbsL
	XMG1Vpbz+MJcBF1XLZ1H6iJYUWFXMjiJ95tSS+BPRYYfNoZuRyjaeMtTnRzexqSkbMbdAG1SvOS
	mzislm9fqW5lZ58GwdIONRHw=
X-Received: by 2002:a05:620a:20d0:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8c9fb69e75bmr1174801985a.25.1770131891641;
        Tue, 03 Feb 2026 07:18:11 -0800 (PST)
X-Received: by 2002:a05:620a:20d0:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8c9fb69e75bmr1174797785a.25.1770131891179;
        Tue, 03 Feb 2026 07:18:11 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm50385318f8f.17.2026.02.03.07.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 07:18:10 -0800 (PST)
Message-ID: <5d9645ea-41b8-4904-abbf-3b201183e2fc@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 16:18:09 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
 <mailhol@kernel.org>,
        Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
        virtualization@lists.linux.dev,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <aVwGfOlvRqdv5xj7@fedora> <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
 <20260203070338-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <20260203070338-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zc4Q98VA c=1 sm=1 tr=0 ts=698211b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JgmFLj68GAqNGjo_vmsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 40_VLNTPBH6FePisDzvWMte8PS4qp0cW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMiBTYWx0ZWRfX9Duu6LqHen5M
 DY9tQyRQ5xp7qDnLoJJPj4aDkJGccLQsSPsEmKtlD217on0kbCMFCCPfQA2D9PL9HvSs834KMGW
 T33tiUCyfCi1MlqEEWFX9Vd5UPU4ZBKOpVAAnazp3/083EvCkXdW+0erHrIMOcENfzob+T8jSyH
 sEtzZBvTD88EDcBjjbETSRCSx/fz3jgwA6MDvyYyRb2IPXWiK69PgpO3yxcHS33aGuv3X3DX4gi
 L0JinlHDmdq48S6v9AopPs/dMjUymqMUYZTRiU/3Y0eQhKQzzh5ow8BRHvPjgDo2yVVqOdbk6yt
 jvXYYiqMxFQA4S+VVpT0HZPfReFDKY8iO5M2eRlakLH16ED+glqigAAB0+sscTZlSgGwfGkHfyf
 phKiQTf1vutqz+K40OXrhKm5yYj+bFecPKjnWRJDFsaplulX9cq/rEcJZvXRgHMLjhqAEkeGz88
 Sg6LaM83aEnkrMeidHw==
X-Proofpoint-GUID: 40_VLNTPBH6FePisDzvWMte8PS4qp0cW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030122



On 2/3/26 13:05, Michael S. Tsirkin wrote:
> On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
>>
>>
>> On 1/9/26 18:23, Francesco Valla wrote:
>>>> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
>>>> +{
>>>> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
>>>> +	struct virtio_can_priv *priv = netdev_priv(ndev);
>>>> +	struct device *dev = &priv->vdev->dev;
>>>> +	struct virtqueue *vq;
>>>> +	unsigned int len;
>>>> +	int err;
>>>> +
>>>> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
>>> Nit: consider initializing this above, while declaring it.
>>
>> All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
>>
>> The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
>>
>> To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
>>
>> Solution was: What you see above.
>>
>> Regards
>> Harald
> 
> So you reorder it then:
> 
> 	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> 	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL]; // priv not initialized, will be done too late in the next line
> 	struct virtio_can_priv *priv = netdev_priv(ndev); // you see it?
> 	struct device *dev = &priv->vdev->dev;
> 	unsigned int len;
> 	int err;
> 
> 
> and where is the problem?

The problem is that you use priv here to initialize vq in the line before priv is initialized.

> 
> On the flip size, this guarantees we will not forget to initialize.

Static analysis is your friend.

