Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D02F7F19
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204790; cv=none; b=JqHGSS0+Q5ClAf/BL9bqshF1Z/S5yoc3WEj1ya0wY6lHqL9tER2H6OC5z7Is37gpEJh1PoRova7iT4uss3F8WVDLrjO7mHcwIxRYMsVZ1Piilk8jPPs/rLlzECc0Zm+Xwpus3zlkb/dVJC9cXjH/HHbE90RmSZitiS+uSSDwdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204790; c=relaxed/simple;
	bh=iofOTXYS/bZXZ/2qBa9da7ho8/2GhtalFO00MODtkb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aa0fEUlWUk2tcijK6CpinzMf07FN3fMtm0bATG7iyj1bn6cwPm17X2EZfY2Y0CIFE3VLZWbkUlrz+SazdRwpRyRAgU/QhnVbyx7+wWrYpQ/RXeUZeD1KXEOmvRJRITWKkoLX1OfzuE+F5Jib09wup0zUvJ1RUoSBmzhfDMTGa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGFupaJx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MF/UJgCX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGFupaJx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MF/UJgCX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C85F4a2833159
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 09:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=; b=BGFupaJxsCp5Ahs+
	68qLTg/6wTbeLOGtIp0K/hgIDt2VlrkNoNpZVWP8g3v1YaU2GFYI+Whcz/Qxq3pm
	lIE73ZUFRwkK4ItPiGl93YsomUcKszTDx4uzwBFnLAzEl9tm4scTPzpZZLtxQZlM
	Js8aqyGz4LsMn5J50cWVx57moU8R4JIlv2Hi9eQ9jfYXSW6rxgIyBIbIDGHaM2yn
	VvIruPB4o+KYtcpIjE+2OCxEulyQwOeXN3XgfIHItCtLyzyLvdPm+iYVOM8dOkMU
	A+E0WG1v0Ttg+N9+BnEnPaUnPXmNk64rTBy5IijJlB7yNHMyzfsCtGhZASjLeirK
	kxiWoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgknn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 09:19:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so24437825ad.3
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789204785; x=1789809585; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=;
        b=MF/UJgCXuS0ccUUARS2Ndl3iFKdOoefHYLiJ2zq6b4aBdm6OCWltlIStr+SijAAg/5
         WcwbteBAmMpkuvRVZcxtLUKJ/1CnFwLZkcJ387J2eTsfsLQfdh07p6eEFgMlFIRc/qnV
         2yNMLUv0jlTG6p1gaPto030Lxlgx+uVe1R8TwkylyvJUiNs1B+o1aDM7U1Ejd9Gdu8Z4
         tJNrDcBrhOrxTVT8lNHKDs9exYw124q7RE3uAhCNsD86CKTagepXkl7Vy4m1frerHOyq
         hXUJyQ+MTQ+5teogwEUKQEsVIzjhHqlpnZnBaNrXl9mH3E5kVAsn+kCvM3hQAbY/Svvb
         OP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789204785; x=1789809585;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/33vb3qfO68qBBPyyf3BMf9vXtG4LUI2mzvFC7b6Ls4=;
        b=PyGav0pZY2W8MohKU8JVQMI9VJ+JNoDU1EY1+VpqI5hWnidEmCtK/rHEIHCliB66wE
         5PStlWr9kji7nyk9DVx+gAw9grPmmr+CxAUQlMUVm/HuxDD7qk40+jUDuz6MDu1cMfZ7
         dHyhLCNynedd3Q8FBy69psnsYn6vo5IHIR6BIzvyIqY0XmmAYzEv+bluCzIBtFHH5GaC
         kdZimvtEnMRquFlWQ07j4N0HTtXo3++BKS8uwz4k6y/IClKYj4Qp0RZAZS+sSzTdAQpM
         n893qc28dyK0DYTmAkzakOOI86lHWrk3me2BO+vvV/enHxG7+4SzldUuTuVMgaOZbBL+
         YyDw==
X-Forwarded-Encrypted: i=1; AKwUvBxO5x/L4ppyhHT27zDz9q3v8dliX7+ZFWSqoXMFhojr8iImCKkse+W6x/0qBe7aDPBVHCb9KxMObE3kS8Po5g==@lists.linux.dev
X-Gm-Message-State: AFuF++lZv1j5rqXmNVmzaO2Rpfpwq+yit7SNJ2hHpQUZ2S7sI4jEZWNM
	ke15xa7sSnI0O92katko+tnToeNmku55WSjVRSGH1SYGapHm8/oJKTkLJ/eFzU/OH4FM2aka2Pg
	PY2MYcF/zXXk5U8h9wt28i3xs9LrGWBR8Q5oUtmgPICZUBjjSpNXiDUeRSatmBQOUAeDUrg==
X-Gm-Gg: AYBFou22Juq8y97yxoM+fojLAIbgCKx4M3UMmeUN5r+D6vTaN71oS4kaa9QC07L0Uxl
	7r6VdnQRJoL9SMk+WJZmHSL54DV2oakY3xZmj35OSL+7duEdQyxWPrQS60HbN6I8W95/TNW43kJ
	R/2KQjQIPJugQg/bMMXKRC6WlhihJKcnPv2q0/T+fNr3LlIGq57KL+qex3nIA+ygpIZw2X+0TL+
	ji/3TjuQuvMjPrsTzv5hc5cCkuQCvr7+XB10qQbmwnkB0gs9nPpGMHmG0WGyox6WJLZigYYeWLf
	3+LVbDVoO8Y2/X6Nl4ELzSSeY5dTbIudcJhdHSrBLshek7/o37S7aECgoaMBH/B/Fjs85JvxK3L
	YQHDv3n7KrATuloY0acuZ9c+B/mBRI2e1Jkx/bEIKYOV2R+zIEt7QcU55QAiEPdXvVh3L
X-Received: by 2002:a17:902:f685:b0:2dd:3ddf:b895 with SMTP id d9443c01a7336-2dd3ddfbaa5mr83347455ad.3.1789204785425;
        Sat, 12 Sep 2026 02:19:45 -0700 (PDT)
X-Received: by 2002:a17:902:f685:b0:2dd:3ddf:b895 with SMTP id d9443c01a7336-2dd3ddfbaa5mr83347155ad.3.1789204784987;
        Sat, 12 Sep 2026 02:19:44 -0700 (PDT)
Received: from [10.249.16.182] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca268csm22228795ad.1.2026.09.12.02.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 02:19:44 -0700 (PDT)
Message-ID: <06aa40f1-9a47-46e0-88f5-43ece4e3160c@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 17:19:40 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDEzMyBTYWx0ZWRfX0sg6cQo/TOQr
 aecxUDtgBElTP9y3CpC5uNCRgnUvMRBZGjo3sqRNZplyNwtARYmAHOwoh2sD8xpyJD38nr1G+jq
 6K2XxX5HZiADUyvImNxR7jsyvgL4ugEmQ2WUOdYtfTqy03GW/JtIwd4P6cHAUlXBF4XKfWKiV7G
 xDSdQvyi3QmPOr7zc5FvBx78mf0hoCuqMNKe0TLjGrLz4ktUnWLhPNUdi6X4FzV1gK1KEvo711Y
 RRtllQ0AOEq1Qg6YvGmTeoeBRryEU+qqkOyDX+/IVGVS1QQXeO7tjRh5RXTe920ZjWKzY/cQ+QU
 PT8g5S5ytm9mX75Hq7g1LlFwsYqDl2YC4/Ryr28PwxgZFKSNU0kQO9kI6oJEhJCYGTSWc2y+XTL
 CBjFwy/8EiryQ0BC0e9MId4tO5N4qy/brm0x7sf8SkmIZCGZBx/HSs5/DyiFUWkTopuc65IiIh4
 rb6cg7OQCAgWaFUWTBw==
X-Proofpoint-ORIG-GUID: 4zuSSO6ZrOulOf7j67RzA4mAxCqXu5iy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDEzMyBTYWx0ZWRfXzMnIyc7X4bxz
 M10S/+IdUSgSDmmCa51o9jK5HEqzOmQ9Y0D/8eVVuNhWfnu6N1uUMfkktM7LVzIMBPucAsWVw8T
 R9ziiYqNEgXqGAjptbhYtFCuYtiCQ8s=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa51932 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tUvm9EZT49aG8J7fJHcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 4zuSSO6ZrOulOf7j67RzA4mAxCqXu5iy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120133

On 9/12/2026 4:52 PM, Cong Zhang wrote:
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
> 
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
> 
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
>
Just noticed that I forget to add the ack tag, sorry about that.
>
> ---
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
> ---
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

