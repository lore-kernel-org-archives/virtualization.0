Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618872;
	b=dfDokNnevvldZUCXm0Ho3CyipK4SNClHgivETlc59Ic1vHMoA76owTbyvS7ZypL9dY2J
	 CbRqjlnri0WVYlXwC8nRxh6V33dxrgZRe7yLJ/SvHKCXd7GOu8POByI8gPV6U4a5zRt5k
	 Fxf3Vb4jHDQF528fCeLP6wQPeQXz54AZOZdZwCT5cj2gWAse4epEgw90DMl2oc15Ioti8
	 ZBopTrs0QyD4+BPo3M3kdiMtcQpM3eAJ2Obgw7qf4ossezHvrNitQqSBVz5SqjWPptC6a
	 iWlt6ecUKuyyrwQMCnO0CnsjA76Hj8XgPZI9v5Cok9Z1EzkxWrIR0XGFZKWCMrrXnlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618872;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ft6X+VlL79CZvQx4aq0+yd2DeSbPndo6NUks85m/Zu4=;
	b=ru4RL3r94c6EYXhy866IyxEigA9HSjp+4FQgBmdCe90effsTh9NG+UxA5IF+G4P12OAk
	 WK+aNDdB4hTjMrl2Tcl/rXBqy7N+7h22wlz8yqfmk0Kj6Bo5Xf9pJo+maPMWMDE2t5X3H
	 VNjtOcjj9cGBsCVioyeGviWAX4/ObizzJj1vviYU/nu5p35Xyd7bca7pZmqL33GnhSQvj
	 OmFUPA6YdAwr5FFhOLxAfQLADAUsbYPuDTbFXg6DA1jMGhGK2PFipzIydieoqVBDsbWBp
	 /T3U0VVT6VsJgUxuQ7aD9IIJ+Z9f0j1GxvDqzoQyJZvKVGsbfginIhRYcvGc9VxOaiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wai9+uU5;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC06E606A327;
	Wed, 25 Nov 2026 15:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC06E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wai9+uU5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEYoch1554207;
	Wed, 25 Nov 2026 15:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ft6X+V
	lL79CZvQx4aq0+yd2DeSbPndo6NUks85m/Zu4=; b=Wai9+uU5ugpAbfR/0U+JYG
	UQwia2gUfuHdofBxe82hbaaMGRT8tAfLhAnotGLVFK2C49il7x1XWbv7/Q3o6Hpg
	4Zm5zB6m6fJuKMwnzfwGxqJkDe8o5khxpHK+oVmj0JWbwgxwSesx1bSWMxfjLGhi
	AvWlcrQqT2OnYGQpgAnEDQDEH7D9kBag23YLKZYPM9FI1qqDy4SEm8YV4T+wprwB
	s42uUqf7xio21Wo+lSdZCKbIyFPvrEedh4LLrSNcP+2lYH6E4vQzCy/IRIJxnNG5
	PaKSGpy4dwzCon/fWk6GF9tuY7HZbNCaorGpWFtYGE6kvO0D4kCepzqKmyazS1BQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvck22-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 15:00:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEKV7d3937879;
	Wed, 25 Nov 2026 15:00:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa2gcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 15:00:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APF0sbF21889592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 15:00:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46CAD58062;
	Wed, 25 Nov 2026 15:00:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54DB258056;
	Wed, 25 Nov 2026 15:00:52 +0000 (GMT)
Received: from [9.68.2.134] (unknown [9.68.2.134])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 15:00:52 +0000 (GMT)
Message-ID: <a79cdc1ece955a62375d5b0f832267158d68aeff.camel@linux.ibm.com>
Subject: Re: [RFC linux v1 1/3] iommu/virtio: Fix out-of-order teardown in
 viommu_remove()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Cam Miller <cam@linux.ibm.com>, jpb@kernel.org, joro@8bytes.org,
        will@kernel.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        mjrosato@linux.ibm.com
In-Reply-To: <20261124155410.768743-2-cam@linux.ibm.com>
References: <20261124155410.768743-1-cam@linux.ibm.com>
	 <20261124155410.768743-2-cam@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:59:50 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b06f827 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=XDt_XW3gfnYMqUlrHHwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfXxxp4c7CsIqJY
 aFSW9fW+DW2y0q1AxLg5T0qKpL/0IYCM14FKGBMcLfR0YUOt6ZOUdljqnBWJhYsWI4BIxA48iOV
 5Z8AfYZk88QC+vhM99hBdwG+O3TV/Tk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX8CrlvO4V75+U
 YFEnDy2G0+UdSH68trN7pH4u57NoQqxicaut/LA/dZBOgF7ijHdBlEpacN+TXwvf3LaxDavizgm
 mIFWXwN+da2s0fHTRhNU0sMbmcFFm4PJlOOftoMQ5L7AuwJ7GaxpKcx1JLhBDQSL+ouXblEkxGk
 juk6ulC7UDWrMogZhT5Hn6ZG4jzgxm4a3Kg/d4zKbZhDi9acv7M4C7f55E8gIJuu9o/JdjvapQV
 h/tmF2CMqRiFAXQNtzF0Tv/leaDEC0ltOCXfzh5vKuoSQScN8xqqtVdlSVA8V0KFu/pETWzLG8y
 mNo2ruX3a/qoqnTJyISGomhVoN+cL8tIIW8GqseoQvheGz1hYBE5OoUXfNNuRBB40r1+9Jxao50
 4hyO788nHG4vaYeDwoXVoGb14TlgfVCFxe3ueX5VxeWxEOqlL6g2YzXyTNY4N8pI6Lnzh48tZZ2
 NzJuvqHkrUchybRDUbw==
X-Proofpoint-ORIG-GUID: gpvu99_mjX2KD5wIEHy6tVoeGVzJjEwo
X-Proofpoint-GUID: gpvu99_mjX2KD5wIEHy6tVoeGVzJjEwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250058

On Tue, 2026-11-24 at 10:54 -0500, Cam Miller wrote:
> Fix bug in viommu_remove() by swapping out-of-order IOMMU unregistration
> and sysfs removal steps.
>=20
> Other IOMMU drivers all call iommu_device_unregister() before
> iommu_device_sysfs_remove(). Before this change, viommu_remove() had
> incorrectly reversed this ordering, leading to the following kernel
> oops.
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   ...snip...
>   RIP: 0010:sysfs_remove_link_from_group+0x10/0x40
>   ...snip..
>   Call Trace:
>    <TASK>
>   ...snip...
>    ? sysfs_remove_link_from_group+0x10/0x40
>    iommu_deinit_device+0x2a/0xe0
>    __iommu_group_remove_device+0xb0/0xe0
>    ? __pfx_remove_iommu_group+0x10/0x10
>    remove_iommu_group+0x35/0x60
>    bus_for_each_dev+0x83/0xd0
>    iommu_device_unregister+0x3d/0xb0
>    viommu_remove+0x25/0x60
>    virtio_dev_remove+0x3c/0x90
>   ...snip...
>=20
> iommu_device_sysfs_remove() will set iommu->dev =3D NULL after tearing
> down the corresponding sysfs entry. Then iommu_device_unregister() will
> iterate over every endpoint device attached to the IOMMU and reference
> the null iommu->dev pointer, specifically via call
> sysfs_remove_link_from_group(&iommu->dev->kobj, ...).
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Cam Miller <cam@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 587fc13197f1..a08474eeed58 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1254,8 +1254,8 @@ static void viommu_remove(struct virtio_device *vde=
v)
>  {
>  	struct viommu_dev *viommu =3D vdev->priv;
> =20
> -	iommu_device_sysfs_remove(&viommu->iommu);
>  	iommu_device_unregister(&viommu->iommu);
> +	iommu_device_sysfs_remove(&viommu->iommu);
> =20
>  	/* Stop all virtqueues */
>  	virtio_reset_device(vdev);

Looks good to me. Thanks!

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
