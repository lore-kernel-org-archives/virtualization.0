Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F352FF65B
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120133; cv=none; b=KsWnA3UN2kN9vnDw7cVAGNM9mw7XQ51PAy7xBtqtgh/hNdM38qGrErpHTduSP88be0xs+7ZhbOPk9eKwTWmBNqTMOqqp4y5BYxCji+Ij0CThxO0egN/x3NyDyGwVS20w0xi++2REuuJ6iP32TZ96j6D3LqWjwUboxoUfbFox2Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120133; c=relaxed/simple;
	bh=RSN3cKeL/wrLTfUe/iXDZXDZWNlHU8sIpfbOMxyuaEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAVB8+Hi3RDMf8N03v/0KeauUBDFdJOPZ3gU/AKe9SDQQglSlPUlVMq0FUzndHjKbD8zj9u9a+UT+9oSdzH6AAkX15GKFW5IriPqV8FyN2l7/tG5ni27nY+04sVQdy9XWzi3OsRyYFa12rlzgQ0zgUeZgMBdDhui/vKNR+SaO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a933Yhqn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a933Yhqn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M33qbC026906
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 08:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PrWXaHujYM83EP0v/kYGdvqS+OMzRONuhcXEsIZpib8=; b=a933Yhqncla2BaC7
	L9lRvvEr6BQynRuJh5NPCYWspxlHRnkPfv53Zp+fyH7Uk+RmYn7Zanrkftl7tfSr
	s39XL88omoVCmp0u9RqvUtg2Ki2O/AljEUN9lclP2n6uSvC5FDfZ/7fyGv10ohy4
	zalcxXIhxDPIUxg/DsbriYDyBWbU2JMae+d8p3tkVTDQXy1AZisu0HvLAdBEt5rF
	LwvKoa+8q1SMqGRot58so87dH7d+QCDBjh9ywt4+bdBg+b1+0NMfpwchkij8xZwm
	oXvjuCaW2adBDl18ch6g4F/nZFrMc+3sX9cW5JsfFQyA1NMX1jAdqYfP0opOw0+s
	uDJCHw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pm1fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 08:02:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26983c4d708so52522915ad.3
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 01:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120128; x=1761724928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrWXaHujYM83EP0v/kYGdvqS+OMzRONuhcXEsIZpib8=;
        b=fxe/YsPNALrVOVT8vEZ3eXJhFstS0K32YyqZ9zLr1j6ODaZvITypRtgLWqfcuI8jrx
         Xtrra0CbDaDXLuvmgqGqH8IDG1WEkoh9jt9P9Oxdu5ZOONOqdMeqVAoQp7jT78lDYqeJ
         91jzJe0rfr94WmebCgoW8Xx+EpfRim9J9qQ4JWesEMM/7XHh3WySv+tIFOum5A2ZkqsQ
         ss7wHD2dGy1BVvSiPyGVYn+hBQ6wTVZNoHY+6rQ8WJEyQz/S6GsZHxKz+EbSmTfnhFK8
         5hy9Y99+pZZ2UuL8OibvL9e/OZ+3Hk/iO8S49+l4odTOVK2prBDyyA2ysPLncX1F8dnq
         5WBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq4pTor43ZlDFWRt+Nmjn6sQDZCkrJE58AerFmkIljYQwq0oOjDmNUr0V9hMCPwTfX+E+Eit40udebIMwlAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBvQGdqQM+gY9a2bF8myyIHIg2J/thheaS21Zr0zYXTpogBdan
	I0ThTO9E2p8ne01yg1AvoBT/1f7jzRFUkgKaaELnyV9J3iT+Ixf0tegbGz7DBWl6qQ6COxmot6f
	i0ED9EUra/a71f8BaQ/dWItEclf85Oxh6xmNDHQCthHZ80T9G03Oe35yS+Qz28pwqq4/cPQ==
X-Gm-Gg: ASbGncvMuBXese8j4WH16y6ObftMgRBLmjgK95UrqPPxp/oDZrSKrApIKIu5ZVVoPgj
	LDHEzf6ijPWDSp4M/NcduS7L+lIN1VK/TtZKdixGNxa/3GGfm1ZxoU04YXjKseB7BfXJnTlgGd/
	0R7zqWGqc+R8wjQe8iWbHpytA5GiCYPci65DDTCzAmr/UPCqGk99hhZn6uNG4mJJUOf0qSBEPxl
	TsOgVFnZfasR1OSDWDOZTNfPXhXRarJ4r/XX4VJdiy0kI0pYeRBXIQp/OF1RB1gidgO8j8YjrJA
	HS2CheK/QFU+Nj4SK4BNCAyiU8XAuNklM7ZiYSMQ7NERQFQ5qOJle5sV2UBMMM5mjMAt1JZtu9U
	UtBKXdOhTdu5cKR2/tuRNKfi0QaJWOo20caAgVhC1gjvXSC3EVA==
X-Received: by 2002:a17:902:e5cf:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-290cb6619aemr257341495ad.52.1761120127724;
        Wed, 22 Oct 2025 01:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcRm1cmQAZ79KpbmBiXAz/1hTG8MAAUjPR7k1568+fHx4n3Z3tvlMw2nwNPvdqpf8/BIpXNw==
X-Received: by 2002:a17:902:e5cf:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-290cb6619aemr257341145ad.52.1761120127228;
        Wed, 22 Oct 2025 01:02:07 -0700 (PDT)
Received: from [10.53.169.133] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcce8sm131876805ad.18.2025.10.22.01.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:02:06 -0700 (PDT)
Message-ID: <f7401703-e912-4d61-b206-f9f1de930092@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:02:05 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavan.kondeti@oss.qualcomm.com
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
 <20251022014453-mutt-send-email-mst@kernel.org>
 <20251022030050-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
In-Reply-To: <20251022030050-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX/xZcRJHwWnTL
 ebiEPLwo3ouC//U9pTiyV1Lzdn3+fKYRkTqjkrmZmCbC47aq4HnhZk30ZdFBCwjx/1KjsPLvDD6
 vHxA/FEajBIx5vWGrvA07f/vCOcFcL0RU3DAq0YwSo0jaVkRn5MLImISG0OpFyE6XOOdaoPmPRj
 V4yyoL6/0dCzQYWYCZLBx37Y7rYO0V4U/AH3QaUopx9b3vyxjMYpYboLsu4rwU+3E2cHvDI2Sfu
 yXSZNkdJaop+1FMiqsPdbQ0V9+ZD26Np1lda7hTX0kC7k3BjT8HKgrRETzpIWiZEJjaNXXlqsc3
 rkXvQNTnonfWjtk8ZyN9dM16/BMuGFZQyBg6+EEOepv9YMc8xd80GkW1NIjKoTufGw3pQ0Yihz4
 C4bsBExXgDs4fbQF3ZxG0x8ne/WLWQ==
X-Proofpoint-GUID: XtVC__dqGxk0uUM8CqjSFy2kgAgSU8jA
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f88f81 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EF7p3n4rWrlDlfIrDsgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XtVC__dqGxk0uUM8CqjSFy2kgAgSU8jA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000



On 10/22/2025 3:01 PM, Michael S. Tsirkin wrote:
> On Wed, Oct 22, 2025 at 01:45:38AM -0400, Michael S. Tsirkin wrote:
>> On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
>>> On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
>>>>> The vblk->vqs releases during freeze. If resume fails before vblk->vqs
>>>>> is allocated, later freeze/remove may attempt to free vqs again.
>>>>> Set vblk->vqs to NULL after freeing to avoid double free.
>>>>>
>>>>> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
>>>>> ---
>>>>> The patch fixes a double free issue that occurs in virtio_blk during
>>>>> freeze/resume.
>>>>> The issue is caused by:
>>>>> 1. During the first freeze, vblk->vqs is freed but pointer is not set to
>>>>>    NULL.
>>>>> 2. Virtio block device fails before vblk->vqs is allocated during resume.
>>>>> 3. During the next freeze, vblk->vqs gets freed again, causing the
>>>>>    double free crash.
>>>>
>>>> this part I don't get. if restore fails, how can freeze be called
>>>> again?
>>>
>>> For example, could it be triggered by the user?
>>>
>>> Thanks
>>
>> I don't know - were you able to trigger it? how?
> 
> Sorry I mean the submitter of course.
> 

Let me add more details:
Autosleep is enabled in this case. When the system wakes up from
suspend, it will call virtio_device_restore. The failure happens in the
virtio_device_restore function before vblk->vqs has been allocated. The
system still gets woken up after the failure happens. Since autosleep is
enabled and there is no wakelock being held, the system will try to
suspend again. Then virtio_device_freeze will be called and causes the
issue.

>>
>>>>
>>>>> ---
>>>>>  drivers/block/virtio_blk.c | 13 ++++++++++++-
>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>> index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
>>>>> --- a/drivers/block/virtio_blk.c
>>>>> +++ b/drivers/block/virtio_blk.c
>>>>> @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
>>>>>  out:
>>>>>       kfree(vqs);
>>>>>       kfree(vqs_info);
>>>>> -     if (err)
>>>>> +     if (err) {
>>>>>               kfree(vblk->vqs);
>>>>> +             /*
>>>>> +              * Set to NULL to prevent freeing vqs again during freezing.
>>>>> +              */
>>>>> +             vblk->vqs = NULL;
>>>>> +     }
>>>>>       return err;
>>>>>  }
>>>>>
>>>>
>>>>> @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>>>>>
>>>>>       vdev->config->del_vqs(vdev);
>>>>>       kfree(vblk->vqs);
>>>>> +     /*
>>>>> +      * Set to NULL to prevent freeing vqs again after a failed vqs
>>>>> +      * allocation during resume. Note that kfree() already handles NULL
>>>>> +      * pointers safely.
>>>>> +      */
>>>>> +     vblk->vqs = NULL;
>>>>>
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> ---
>>>>> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
>>>>> change-id: 20250926-virtio_double_free-7ab880d82a17
>>>>>
>>>>> Best regards,
>>>>> --
>>>>> Cong Zhang <cong.zhang@oss.qualcomm.com>
>>>>
> 

