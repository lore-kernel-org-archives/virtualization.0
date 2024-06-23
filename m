Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164132F4A
	for <virtualization@lists.linux.dev>; Sun, 23 Jun 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719164170; cv=none; b=E6KxsOUzeNYjls52COInlN/ECGg9eNzuEdppg5g1DcMFfjTHlOXzTYaz+A7PBi/6fF5F1A8m/GOKm5UN9RLBSzs94+4L5AJiX/TrvZJyazcDutNZehz3gmXe5+0G7IN0y0DHibWkmAdmgcLwoodAmaZeOsGAWr5CQxiTM5D+chw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719164170; c=relaxed/simple;
	bh=bwN3gclkygcXWJOiFAASQSAeTPkRYD4XszbBGziR+7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VtUQQT24517BgFE7KyHLmv6qawxfcQgICwVmQn/f9ypFrmJBEtRr0+65CO92HX7lvCUiX7LpOppCx0vvl3f68lWCz4MKTspy/rnJuF2I5q/u2XMNSv9/knCcsV7C5IKjnK0DDYt14D0sVD+ZapJ82IVx7wtlT9q/G8Y+uk9Xlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hu9Bwrh5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hu9Bwrh5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NGsnbn019000;
	Sun, 23 Jun 2024 17:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYqXIpDlJIChmPpDMjt0km/fejYAk7VGogsrNLclnYo=; b=Hu9Bwrh5VP1GP6Cj
	PxbnfBcZFQ16I6guqifIHYsdeJ1vHY8+DwO82//nB9T7rKVJu/hxC9xnKt0UDdoS
	/N9Mex3K8QLg0jSYNHeBLWJLkmTzBN7hg1ouDAGm6QwR2xmTxSA6fKZWgGcyWj7L
	iwxHa1b07EPOVXcxpXNWdkHSEnCYq3Tul6BxaZtDmtI5FLeKM1SaxdAuPpz1B+SG
	9pfHpPXHZ1i3c9JEKag152lQtCZEOax7Oa75bMN/yddyqJvBzHm/uFS7CihOVSgV
	04WkxE2y58bAsaRdLzAJ0kk2IsPQS5smnsaZaTpe1KSu6X/usA0i2BA6wxxTOHmq
	hEpBtw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywkyn24ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:36:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45NHa2qc024073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:36:02 GMT
Received: from [10.48.244.142] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 23 Jun
 2024 10:36:01 -0700
Message-ID: <ef8f00f2-210c-454e-a7f8-ab724a18bf96@quicinc.com>
Date: Sun, 23 Jun 2024 10:36:01 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-virtio_dma_buf-v1-1-ce602d47e257@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240602-md-virtio_dma_buf-v1-1-ce602d47e257@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _khJIn_nfHXpICehNptjTd3v_qb0WSw4
X-Proofpoint-GUID: _khJIn_nfHXpICehNptjTd3v_qb0WSw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406230142

On 6/2/2024 1:25 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_dma_buf.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/virtio/virtio_dma_buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 2521a75009c3..3034a2f605c8 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -85,5 +85,6 @@ int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
>  }
>  EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
>  
> +MODULE_DESCRIPTION("dma-bufs for virtio exported objects");
>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS(DMA_BUF);
> 
> ---
> base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
> change-id: 20240602-md-virtio_dma_buf-b3552ca6c5d5
> 

Following up to see if anything else is needed from me.
Hoping to see this in linux-next :)
