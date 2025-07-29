Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529F4C98
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797109; cv=none; b=NaKo7mxI3KDqQ9iNouV6h/Q7R1yTr/SP5WUGnIifPnwtd0oqnN50FIG8DRAVAuCLhAPlq8BUs51HLW8gkhMbOsKo0XlBOYsFnglt+fS+/wCU0bm7vfwgLPc1nUI/nurgiuc0lugjdU/vCuRSG4sQ76+qgbCYW2Pr/4/egl1Z0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797109; c=relaxed/simple;
	bh=hoo0VZ8djB8RitqLM6jiFX6GVzpj9dIvdPNFEKlhtDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiMI2+emcJCT9sogAcFjhHqFAgFEmiiuJLZScUTM4DgUbnxDgekBWqfzSf/ra5FSyqRMAn80zj+QiiLyVEdz6tV1nFxcj8qOJV5DEnPZzp54qpDjj/DOt4dhtdn7fGpUEvxlEI8tfJBI2mX9ls/zi4UOJTmqfn9BFE2DzplUwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVukV2Yu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVukV2Yu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4YuKp022242;
	Tue, 29 Jul 2025 13:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mHhfNB
	3oDoP8UAbSAi6vxVgPlsnKrJzYQS128/QQKiE=; b=CVukV2Yu4MWjjN/Vc/qcNU
	JzMQeTvoP9MQTHTq2SbeE9+OdZdqJv5wJ9KOWJy5jsSrt1PBrIYC5Ozt7VIP68j7
	EijeCaxKDsCILDFUgkSEuf0Kaa7bM9G7tc5GP6BbVO1EB77ytsAJNos5s/0w5eu1
	PYrg7EvBa1t2TqOk0OEFY/Pv4ygGGrWpbEqPolu22U29fqeen+rR+I+nWgyY6CCD
	txwFJc+tdpjCSjhy+V8niZNB0GdeJrGN8bOf/tBwKkGg2adzt7ux5Mn3OPpBsQlV
	Vr8lyYgLUBEx7SIi6j8BlPa91lENn/luI5H1ta8vIPPnkGmj7qk1iqlY/YvKlPPA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd5f0y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 13:51:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56TD3s77017464;
	Tue, 29 Jul 2025 13:51:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r02q2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 13:51:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56TDpW7525428588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:51:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF3CB5805D;
	Tue, 29 Jul 2025 13:51:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5995958057;
	Tue, 29 Jul 2025 13:51:32 +0000 (GMT)
Received: from [9.61.242.224] (unknown [9.61.242.224])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 13:51:32 +0000 (GMT)
Message-ID: <f2d3027f-44d1-44d2-b89c-e01085c6d036@linux.ibm.com>
Date: Tue, 29 Jul 2025 08:51:31 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, eperezma@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgarzare@redhat.com, will@kernel.org, Breno Leitao <leitao@debian.org>
References: <20250729073916.80647-1-jasowang@redhat.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20250729073916.80647-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNyBTYWx0ZWRfX3Yflp5UMOpWy
 O/YRFoiaTO1Le9cN3kuuAX9CILQQXc8SCTD/TgqoTiat/DU/Bj02LF9XA333U4W9w3U3lt+V+af
 Acsd5EScOtOT8Yfbpn135cIUC/yeERwEFdUtkxsT8NqiBfpwjU1+oXT5VV7bJiSuytzmkrG89d4
 K7avTQoW7Hj3rL74ldtIeDeHd00I+s7zViDJUCo8EHeoIHctzXuOqXsinhrzDzWy4QlHLBj8xyK
 +umj/h+wek1NOq2gWGjw5wYCQQq2eFy7gTkdB5vmGIktnOLW0lt1KS3AS3+RujSEupl8F/NkSOM
 V5x9fveXiuu9qktiJI5v18IPTzCJ82iuzxe8pc9lcFyuSo//ubT8msx1vtDb5VYLVc6icoAqGrR
 jC0MNoeozy01L+T08Eyk5qFys4FomsNQLBjlG6QKAMuiEnjWtpvr9ro2PrJisjud5J/GuNom
X-Proofpoint-ORIG-GUID: mpOpWW-OLWu6n9CXOeVuW_P66Tb9mhIX
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=6888d1e6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=xNf9USuDAAAA:8
 a=20KFwNOVAAAA:8 a=wyMUYbSDCzE7wVUlRWoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mpOpWW-OLWu6n9CXOeVuW_P66Tb9mhIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=956
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290107

On 7/29/2025 2:39 AM, Jason Wang wrote:
> Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
> vq->nheads to store the number of batched used buffers per used elem
> but it forgets to initialize the vq->nheads to NULL in
> vhost_dev_init() this will cause kfree() that would try to free it
> without be allocated if SET_OWNER is not called.
>
> Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 7918bb2d19c9 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vhost/vhost.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a4873d116df1..b4dfe38c7008 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -615,6 +615,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>   		vq->log = NULL;
>   		vq->indirect = NULL;
>   		vq->heads = NULL;
> +		vq->nheads = NULL;
>   		vq->dev = dev;
>   		mutex_init(&vq->mutex);
>   		vhost_vq_reset(dev, vq);
>
checked and confirmed no crash occurs.
Thanks for the fast update.

Tested-by: Jaehoon Kim <jhkim@linux.ibm.com>

