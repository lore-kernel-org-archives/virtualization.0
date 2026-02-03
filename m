Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225433A9D2
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119713; cv=none; b=oYdz0VcJZRQv5928G1zo7ZoYG8X/VNrI/GJ6G03jCUQGocmfIcVzGuJSWMg9RhZTmmhKebUQzkRPFNhT+rZDeOh8ONRjuyO6fizwrcCXmLJ+vr+4xUoO8yByjgPwX1JRqKJ0SMgYLrMREVQQVTmPltf36JBXItl6VYLo6sYBh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119713; c=relaxed/simple;
	bh=lOecQHF5OFB8heiN8hsmTHJySpCloKpE7IzIr70fBoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg+QXNOSeSll/5+Gzjt1DYQpgKtrbyq4ct7srA5mV1rF2BtIFWczl+BNXmNgdL/kQf6YwaBS7jzwxDWtEsoRpD8Lwr4EZmQfWaoLnGpPqZB6PXtUqnEmaSZBGsuwWMv+iPFb1DH7Pift4XHUMl/QDX8PZCiJBNT7qYX5WrfG2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpAk0F/E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WcwfnCuR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpAk0F/E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WcwfnCuR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6136URxd277414
	for <virtualization@lists.linux.dev>; Tue, 3 Feb 2026 11:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MDuT0B7OylkoIAE5tcgNAXoUzztKFfX7/W2HioUlO8k=; b=LpAk0F/EBp5Lajim
	lhaFUI7b7iw8ZMu2CBA7SW/INIYXw2SqjreERufOq2JIQQx+PpuFL6xCiq2zZYeX
	LnzzbCZRYEG4An4ZnYmWeFb9M+55YP7HC/6GmdUF20BrV0PehwpNmkO1SpIsR2Dv
	WsEA4d1RMGlovvFPCQkyebtFYoAsST/BaRXF7MvvmdscNXLFuF/hTl+aegI9NYJx
	SrOOa9fEpYXLtafUQQOps8VEx04rbSdHZum/yGvmgNYHNOZXAHfv4ttVkknij/kk
	4FbZ6/15lah2RS6lbQbfsLxYX4NfZsecW3UlK2oWZWPBK1MiZWMB5adevXuu3J69
	DmN1Zw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c32s3ag4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 11:55:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6cfd52556so234538085a.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 03:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770119710; x=1770724510; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDuT0B7OylkoIAE5tcgNAXoUzztKFfX7/W2HioUlO8k=;
        b=WcwfnCuRaXdPKa5iGF+qJUA85YwFS/jpGVXrIazdgsqeVb/VrRIFExt0P4a5PaAa0J
         corlqGGB7yFX7PUvRJt3BNvqGyeUox/dbKx6Fgy/K0E2iIt+rbI/O3T+we825srAh73K
         tS7UdbkTD6pTrrIfJ9OPyk4OlzjrepkRV0EIdizAaupP4+HB0kETeyYhdRmw4k3CAKFe
         20/RyAx43hfMyhSOVtueOrS7B5vDskHvlNt6/6NUUqSBrfFssTfCbJuRcJg5TNPOcGxa
         JgUY2bPrgahZ5Sa1TCZNCG3nxRN0i5t4l9xbS/+haae5CXpo8SzPzHmaIC7o+KfDw4x2
         40DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119710; x=1770724510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDuT0B7OylkoIAE5tcgNAXoUzztKFfX7/W2HioUlO8k=;
        b=mqexFu8PLpeCqxVv6hRc8rowS8DqRn6nXkgz6XpyfxTNjPVF0HAvDNgHUyeDXUuFjV
         iesCMYN4g8ra2OBtF8b1Uvm7N8XlIGj5y7tyZKh3ZGiMRD2jiVsemswDBTjQU91TDsG/
         PEk9sAjb4tm5yImXsJb5vBV566S9DBko+0esfV79EfTxtG7Mr0IxJzeR1AHWF/QrDgcZ
         xho/9w0w9oUwtTAUNoqU6lZ3FmY489SafQzBEN3RDT687nrhQV+PyuRE0SCZJh7OfsHW
         dvO6TDSe75x5Pm12i1J1tYdIvki3ehN8doas0915Zds6D23nkWAh+yjkFpcbsijaFt7+
         QmSA==
X-Forwarded-Encrypted: i=1; AJvYcCUGAVcmnwzN3M6UFi1mgKsRj33cYiWhanMOuTOpn/kNQ8gHuvJcVwNFGnyrlqlj/9xZUY/ta/9MLAQQEG843w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2ZFheI7kMm+RUbc7/VYQXwXKTfzo5U26buWsw8Hige2eyxEki
	w3ZIVw4MGdCU5DAnTmDqOShxKJ5jfsDyIGnrxlVj8DOdMaiLmvWgK1/Afy68QmE9SAENMsVE4wP
	SiGjanCsV+2g5iDY3l3BlbsHnnniCo+OhrzXEVGhOHxIljGygWIYfYN40vWXmSur1IZoLvg==
X-Gm-Gg: AZuq6aLNisuNEKUVTub2HFFF7texq9Qr1XhCkxMUqRJxiDZ3mc9BoT4vsg6ggCbTx33
	KIy15WWpPPdGBGJQwF1hHQ15aO/vAA/xSkpR41J5IzvIqIv6BJiVNB4kQ8WSkDxcjzwKuIqyZoI
	ailTxE3NaOT2J/fnqP5jh5n7gXT3zDDJ/Q2kbpI4ajBkKd4XoD29Xa84icJzadJjhkzqh/1fkPs
	JVfSLY+By2x5n9YeK2D4jAA/wlC2YcvjTCThUVMBBpXSRMZRL2z5GhWd/Q8qQkzG9oF5Os/RmX/
	/s1iOi1RXnGDV8bhUKvTOon4TbyjxPxOOEU8BfRZTZdpWuWNkY989xOZd7ZGfPaXEyHmJKWiOjF
	n/e2KS3IBirXZjcMDRiMFiIs=
X-Received: by 2002:a05:620a:f12:b0:828:faae:b444 with SMTP id af79cd13be357-8ca20483debmr282371585a.20.1770119710080;
        Tue, 03 Feb 2026 03:55:10 -0800 (PST)
X-Received: by 2002:a05:620a:f12:b0:828:faae:b444 with SMTP id af79cd13be357-8ca20483debmr282369385a.20.1770119709628;
        Tue, 03 Feb 2026 03:55:09 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd4a5b8sm143604075e9.5.2026.02.03.03.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:55:09 -0800 (PST)
Message-ID: <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 12:55:07 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>,
        Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
        virtualization@lists.linux.dev,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <aVwGfOlvRqdv5xj7@fedora> <aWE5duyvXCuwsMAn@bywater>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aWE5duyvXCuwsMAn@bywater>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zc4Q98VA c=1 sm=1 tr=0 ts=6981e21f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Am9B1zxb3eBZUTWmzOgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VmGxZdMN9FJMds5w49D_Q2TxFwMmS8As
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NCBTYWx0ZWRfXwPo88/6AJwmj
 qV1kNuKxdTfR066Cj+61Zi4+XgSXHBpVqQKynDyO4gXPV0huoiR0hYB5iK8Ntay4+AmE3h2rFFb
 msII5vbFrwyxTdYtGApPJpiPZ/0cVqk6tHC7QZPq3JuO2GIQCUefuNs95Lv3qfz5sj5N6XihT1P
 qM2YBiAThCSnPf3ZIU5tUWAM3i6It4NkSqboEzDc1FgNr0AvFsWM19M2j4B7UA8bRQqGvE/2EZz
 KoBulTxK8uBEsuEuTtTbhATVzgxgKTuv7sB3CwXZtLo6SYb7vOoUabhNriVJVD37qQhlZo5KKfy
 d+YFntYPqW9oyLl0eUFaavRAea5yHYsBH5ZesX7gmHrkl+KfL0NqUMrYR9sNFS/+0TcWA//odCE
 yIjdlu2RiMHxAieU8lgmjfc4L2eZ2Z0WIWhv3F8eAR3L5pwcy8vC5lK2/SRF351aHrE/qA8fPBi
 5HtvAd6ccF3xMwpSrCg==
X-Proofpoint-GUID: VmGxZdMN9FJMds5w49D_Q2TxFwMmS8As
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030094



On 1/9/26 18:23, Francesco Valla wrote:
>> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
>> +{
>> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
>> +	struct virtio_can_priv *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->vdev->dev;
>> +	struct virtqueue *vq;
>> +	unsigned int len;
>> +	int err;
>> +
>> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> Nit: consider initializing this above, while declaring it.

All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.

The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.

To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.

Solution was: What you see above.

Regards
Harald

