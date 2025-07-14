Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BE25A2AA
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502616; cv=none; b=B2DTUFGNXrTqNhBB2amqzs8YOiy7MnGmkLOxy1N2zEJYpaXilO6DKwbthJ7mgYSWwfJKRgYeqzobn5aSyXFO//SIgOa9b7YkBAGl+0gRiwOKgTpUH3tV2N4zA/ey5n64TCh9u6TGl3qjiw36RJeTx6buB4lKXBsE/JD07eozdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502616; c=relaxed/simple;
	bh=xG0P9z18dFpjktzlNNfgINo2HuI+jecvC5R7u1+N9aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUWGRdqW90qqJsoCJ9JgOQqVw34j4IaEuOcxKlsp8uMoOi/c+ogDA7WlLRo+51OMWlR2NNaCa0IaEh9+1LUSPTDEHFCfgqhxXLryNAUJz9vTV4rImxRk7XkxyXUM3jARCCjm8xTG99JpZt3XHVWkqvda663jjAnpWm+Xxr5Ne5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NvNGKG6u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NvNGKG6u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E8KRlB014677;
	Mon, 14 Jul 2025 14:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/fnawL
	bQb+PXjZBgC2TuPEOK6bDpsfugctixtUEIsVE=; b=NvNGKG6udbIccXswUHJ/c5
	us8YH2t0e3iF//eY+xOsoVOhGExntMBaSFPD1hUZDiARZwNWOBaZ4lzq8H3iRnzm
	9u8NE4bgBki6z+SnIf09UMi4zx4Bs7hLHwcuJgJjA+vZmrDxM4yQKZHW1rcaGBfO
	kZY0dA7VAkfobtkAVPxKqSaSXBfdwDQ4exRYQRgixV4D05zVtgYuclSvv1nWuzSM
	JZcDyBr7wuTZehpB9vc2uNNIcyoG2H1DF29t1m7rlK47xTDaBNJXeELwmvN/f9Uy
	G+wmDvZj8z1ouqOCVzBP77bADpQOeqgdX1zmV77+3hSuE+jEwW68XwNB/Np5oGNQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tsypq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 14:16:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56EEGp21013484;
	Mon, 14 Jul 2025 14:16:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tsynt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 14:16:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EAO9mc000890;
	Mon, 14 Jul 2025 14:16:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48kwxyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 14:16:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EEGces10420910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:16:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E2135805B;
	Mon, 14 Jul 2025 14:16:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 038D558059;
	Mon, 14 Jul 2025 14:16:38 +0000 (GMT)
Received: from [9.61.243.238] (unknown [9.61.243.238])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 14:16:37 +0000 (GMT)
Message-ID: <e0d7a518-7736-4de1-814c-578f14e591f2@linux.ibm.com>
Date: Mon, 14 Jul 2025 09:16:37 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] virtio-net: Fix VLAN filter table reset timing
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux.dev,
        qemu-stable@nongnu.org
References: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68751153 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=zTvvzZXkgg2YcvmaeiIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IcQvpBd0K6heh5JHYXw0CLJmsRLAFejt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NCBTYWx0ZWRfX6us/9Ep8psvq XmNb8LlKntk+i/WPSmaEnf0uHFPwofz4QUV19KsY5ppgTHiBfGYTkQbnQzHjJ9EEIOANhXOtwQh A4mJcxLQ8p0KPI2qgbWy4XTYI0USCTQSfO02im+hHNF3TRNXsNpsyWc1dOJXzAAlCNWu2QLeIzo
 BC9fhrHlvpiuCKHMTA+YMN3wssmDpYtFUXXD/uSD6bbh9tIS9upL8/1NSEa0fdXIUa4mxdoZXSq 5vecXKRdJPrr4ZYw5R/0ZwEKASWYYgeVo4+UPIjrh4B0yymdcmslSBIs/sUcgDs/XaStiZGwEl/ GMAbE6J/h8bqaWL9EuWUvhYLL0LrcUSP+ra+qV3aLGYGmfFUOE0lrHQZVfQUTTr6rP+SYu+6Pin
 qoR19TjgyH2F8dP5h4V74j6DSQu/gsO16mmnPx/AFDe7zpSIkatmWZEB1///M/BXyz3JvEt6
X-Proofpoint-ORIG-GUID: 2JsllPUEY_zbtj7GU-rpwZg30iJKfoYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=857
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140084

On 14-Jul-25 04:31, Akihiko Odaki wrote:
> Konstantin, I would also want you to test this new version. Please also
> give it Tested-by, and, if possible, Reviewed-by.

It works as expected during the boot. All bits in vlans[] remain set 
until virtio_pci_common_write(VIRTIO_PCI_GUEST_FEATURES) comes with 
VIRTIO_NET_F_CTRL_VLAN set, and clears vlans[]. Then I see 
virtio_net_set_status(0xb) and virtio_net_set_status(0xf).

I can't test migration because currently it's not supported on s390 for 
PCI devices.

Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

