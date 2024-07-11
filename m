Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46838398
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723453; cv=none; b=nC0FsQRWwAlyjqGp8PLoeTiAg5oJ5iTGtZ/HJELcm3vzv058+PcHjeu29gbH60xXizfRhZ/sv1mlJ0Ep1StN41P2K6HqZxSj7SuU7O0/kaZIFdx88sAahnFR5QggQDs3xUSQEggvLU+u0HS39ASl3hSxw+jI56eljWsu+Gr63ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723453; c=relaxed/simple;
	bh=pd/Yn2JxsxkrZmSa8/G43dYjU26mRHFRHL2mCUI7paM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=XNWkOZCOUraw7lNTwFbcc6a2pzMO4XS6OLj8Lh9MZCLboskfGfd4zO1/yPlD633O3w6fl14uvUE+zaf6A25pYVDWjvnXjY4ovpYqwW9RofkYgm7YwyzBp1rimoNsDMIFVKrLeDtB4m9iErUFR2/Z0pOZXHjUKBDa7kvNviBiKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kkxt+r4k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kkxt+r4k"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BDd6Je012659;
	Thu, 11 Jul 2024 18:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s1g4puKmzdu8RvrxbPD8Z2aPunTmspkN2ogP0QM2Mgo=; b=kkxt+r4kmrvm3tOg
	Cvtt++B6tDH1iMjXXt5MgVSHGM5Gu96pqK63EVrhMYf0lxG6qnrTHqsxD4wHi2tw
	Or+d3Agonk838LTpP+S1bX+y7y8sjGJAIHCmUcr8jkqRXmjdKj64ASqP+hlEDzkR
	aPAld/u7yNd4pnA7A9iL2g8fQwur8kyiLijZ4+B0Y+AUeaHfq5kfK72X7HsO/zzp
	79DM3xMyPZqF89lTu8FivGml0lkA8mEVOqvE/74dLMW9qRI1Zmte1aJCJSIPz4UJ
	oDiG4Z9jiJT543GSejBAJ9qq+lN97XsOKDDj+nD+9WC+/SLW9JIZ8Bhz1avAzNhm
	3PRLJg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409vydugwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:43:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BIhJCa014533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:43:19 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 11:43:19 -0700
Message-ID: <b8b23dc1-7df6-489d-9638-db64a89c8a83@quicinc.com>
Date: Thu, 11 Jul 2024 11:43:18 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: add missing MODULE_DESCRIPTION() macro
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-virtio_dma_buf-v1-1-ce602d47e257@quicinc.com>
 <ef8f00f2-210c-454e-a7f8-ab724a18bf96@quicinc.com>
Content-Language: en-US
In-Reply-To: <ef8f00f2-210c-454e-a7f8-ab724a18bf96@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T_ZKg2aanK-uQjTJG4ZN8WXUocqwZfjS
X-Proofpoint-ORIG-GUID: T_ZKg2aanK-uQjTJG4ZN8WXUocqwZfjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_14,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110129

On 6/23/24 10:36, Jeff Johnson wrote:
> On 6/2/2024 1:25 PM, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_dma_buf.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/virtio/virtio_dma_buf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
>> index 2521a75009c3..3034a2f605c8 100644
>> --- a/drivers/virtio/virtio_dma_buf.c
>> +++ b/drivers/virtio/virtio_dma_buf.c
>> @@ -85,5 +85,6 @@ int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
>>   }
>>   EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
>>   
>> +MODULE_DESCRIPTION("dma-bufs for virtio exported objects");
>>   MODULE_LICENSE("GPL");
>>   MODULE_IMPORT_NS(DMA_BUF);
>>
>> ---
>> base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
>> change-id: 20240602-md-virtio_dma_buf-b3552ca6c5d5
>>
> 
> Following up to see if anything else is needed from me.
> Hoping to see this in linux-next :)

I still don't see this in linux-next so following up to see if anything 
else is needed to get this merged. Adding Greg KH since he's signed off 
on this file before and he's taken quite a few of my cleanups through 
his trees.

I'm hoping to have all of these warnings fixed tree-wide in 6.11.

/jeff

