Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97133BBA7
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114914; cv=none; b=hOYfRmeK0jDSekDE0eX+GrmhB0RTi/DZaVqnUs5bKRuQND5hWZe5Ac0enLQ/IvpCqDXqUIpPObDo+o2Y/FLOmqdGZoAWq9HfvQhvW7yzpLxrbBVkhEtjkqi4VmL8Q47+hO/MAZPT0tYSGyGWxp2l/8BlpqgJDWm6J6Pjyj3MIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114914; c=relaxed/simple;
	bh=t1UcEzBGxK0BCz19XygbNTaJZxlF6PDWi/BIFmL6hk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbJuc1+JvIR13lVmhM/kEZJldaS0bp0K02XV10hHzdiR4VgX9WlpNZRomS7ZRNcRVPRO4IafvyMF0OMLoCq0vKZEB2Zk6wvMMjjiawDqacZasl9DLl5Y1ppFYYqMAdWM1rJ/WKrlgUzwKF8VGZbBY9qSi2/Th5CHETk2YInaPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isHACYph; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A+kgStbK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isHACYph";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A+kgStbK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAL2Ul369028
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 14:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FiSYMHWATOi0zx+LUFUVIp9vkmisGEX5Df+vL79Citc=; b=isHACYphQ1QkU94z
	m7dlsNGpOoT0RI+TZ4kN/6bUzRnekrB1CNo95oq9AIrX8fdGv8uKt3FvTHjV7zJr
	ruYptkiwpegL1TIU30cmMZGipToXjuXVCKpIyyKpr+BPen00YXbC7Pt+6/iECIBa
	W8m6QlVKWejcBEeibkiQ8B6AUnWDVCvuY9XSTe70lamH+GakECOB/e2o2xJDks+w
	EpVE4cJsTlwiDG0VLazzN/AerP9fzIdr8UaeI9j1tSgVv+lCDypBFUy8fT3Z6nc8
	QyhZvTW8wNA0H84u0+P1r5iaeuegPMllJ7HNiHinIFWQTrV8D3v+XrRYyreM8lQw
	PEla8A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj8bdaqjg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 14:08:32 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5fdf5c67d5fso7546650137.1
        for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772114912; x=1772719712; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiSYMHWATOi0zx+LUFUVIp9vkmisGEX5Df+vL79Citc=;
        b=A+kgStbKQxx3KLyDIMv32Vdg0dPYVmMCnB8dPeFQFSW3fhf4cpboXBuLr6ICI4/dS5
         23yYWsDszZ+x05VnEJHTMnV3DYYgnPNpXk4pg42PWa5L9PRJBZ9OUx78uH8+I54+gZKp
         rAlw0/diaH9qHUmyYoSFVvFDNodS+XAcziBi2wqbw3Vu2ACAvo7ew3JLTb/GNtCCCWrQ
         udChq28GTcVZcUx50bvpb2JZJoSRXBFsgmrVL6+tIhaSeMNKiUK9K2BF48ZChCgcJzqf
         f87iELd7UCf4va6WkRvQgHOPQzebs8m9AKNKGHvb0E6B2E7xY0bCe3hVkGECcxOjxYh7
         NKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114912; x=1772719712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiSYMHWATOi0zx+LUFUVIp9vkmisGEX5Df+vL79Citc=;
        b=upfFsyMtwX+JJK8FLUVOW9VsmF6eru5+02FRsnGlGk2nVPfSqmQxYiZVsopg1m7XuD
         7UnX6D8d5KRlxQTk+hZf0G0zfVNJ7Max2I+9AlePQxM8VuMlrBvDuSZEXrsbbfowCr3V
         nScED31hc5MjxH0jsKUXKM/HT5XGDuJNUfvxVlj2K3BgzodOJghAThcitmBnOqcG6/6d
         DPB0sBgl2CmNHYxYx7MINuF0H1X/StVdLPIEruS06gxxMD7CizZ8z9iwf3qelxrw8bgr
         wdfVaLS/N8XNZBZ8YS6tIScsmSEy118Nymardd7TeJaU0J9Bvr2WPOZCvJIv+0zpznlk
         hzfg==
X-Forwarded-Encrypted: i=1; AJvYcCVRvfW3c7oaoSftLhbpaIJvCmCkysc4PcgqPpulzkgAkpZi2S+fUINd/UVpi1u/BNPzHeodEuUaBLWyUlK0JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBk9w1C6jV6EC/tlzcj40U72cJFuhdF9QlYsuGB6c0GYVnRnFx
	3Bi9Zkro1LLZTZwKlqX8OaqE9dwFLDR1T0GlT4h5JESxQCr+3dtYvD1qg0kPbzhReoFciziXBAG
	Uk5c/8x7vzaOZR/+ggvnNNJRyt3EDVcANul545QoJVVUN4zDQejGT8w8LMiGzH2pSc1SqSg==
X-Gm-Gg: ATEYQzyeRKnQjA8QQtCSh55RuoAW/M7mQvwfa2JbgzGs+3/5QAc68B7cmExdFI/6tB7
	4axAwi4xz4loWrDH2o/MqeVf7ipWI8VzxPMw4T98k0FB4mOyM77N27scoxcG2xYJsAqUAl0O2bQ
	dqehnESLhsxHTZy3bzZ9AWayJXoLp4vvXzOy1Xc10o3blz7j50C9jNxJKi96g5n/ZA5MMJ2DRhD
	NIoB7q/G2EjJapXVQyM35f31waKlCJejcf9mKb83K1p/nJ65JmO1GimpUza+SCjfQTfGmXUkeLx
	j3OWW89UnSuiCwqtzwQZaoJoKxP87OAmOCqlqACvEaS8ROvgI7/dxaBjndi3xHlooOYYvPEBD3I
	3KrASFJGedJ4ZzRljL8Csl+DfufFGT5dIuCw=
X-Received: by 2002:a05:6102:3586:b0:5f5:3dbd:700b with SMTP id ada2fe7eead31-5ff209d60admr1231286137.7.1772114911866;
        Thu, 26 Feb 2026 06:08:31 -0800 (PST)
X-Received: by 2002:a05:6102:3586:b0:5f5:3dbd:700b with SMTP id ada2fe7eead31-5ff209d60admr1231254137.7.1772114911360;
        Thu, 26 Feb 2026 06:08:31 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d113sm471955a12.19.2026.02.26.06.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:08:30 -0800 (PST)
Message-ID: <76036b0d-fe61-4d19-a209-65e1a790c107@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 15:08:28 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
 <mailhol@kernel.org>,
        Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
        virtualization@lists.linux.dev,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
References: <aZRB7Reu/D6HvRcb@fedora>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aZRB7Reu/D6HvRcb@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FKQWBuos c=1 sm=1 tr=0 ts=69a053e0 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=u91kjjuq1gvM5pTUOaIA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: MUBmPNa0qqExmqK5vneLUP63Whm1GaSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyNyBTYWx0ZWRfX4eAGh0+8ziYq
 gGPqCudsnlY63HDWAmTMsDcawlm/TfACaGw6oraq6qLNS9a9M96USY/WG7bbHC9DJ7IfYl/eg05
 Pty75ixhAYFT7UO7IBscNalusZRRMdPfISkr4GTb2YxVdtl3xOZ/DNYpSaG7gbUY0A6/rPzTn2W
 KkEBN0A/hStYShFxUiAoKT/Bt3RIQdfS0rEpJHh8jiYU1yU/9XTTVZ68zhXBbGREfguUOSg12QY
 jzC+UCyznqSlfwoQ+a0RoC6nTm28vHz1xffoR82KZYHxixYNHnVhrmgHOhxxVI4JMJHwl7LVjIh
 sVrHw5TqTZuiedUvrx7qz+4DigTg6JxXihM6XEBD/q51cn3+aYU6oYfagegqU9KzNYL451Olry4
 z2f+i3hmWZrcQCqkITbBP7TnJMPilR1tqgHiCKdN7nLe7x/sEFN5t930hqqr4WuTmO/LAsNhiya
 36hMP9WF4tGETapCXkQ==
X-Proofpoint-ORIG-GUID: MUBmPNa0qqExmqK5vneLUP63Whm1GaSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260127

Hello Matias,

On 2/17/26 11:24, Matias Ezequiel Vara Larsen wrote:

> +static int virtio_can_probe(struct virtio_device *vdev)
> +{
...
> +	priv->rpkt = devm_kzalloc(&vdev->dev, priv->rpkt_len *
> +						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
> +						GFP_KERNEL);
...
We're here clearly beyond column 80 with something which is not a string or a comment. Elsewhere we are also sometimes beyond column 80 but then only 1 or 2 characters which may or may not be acceptable by the kernel community. No idea. You may re-check the formatting.

Besides formatting:

I compared your actual v10 of the virtio CAN driver against my last v5 and and I saw nothing in your code which may cause a problem. Only learned doing the review this way that at some corners my old v5 code was not this bug free as I thought when I saw some changes. Nothing serious because in some "not expected to happen" corner case code paths but anyway I'll occasionally have to take over some of your changes into an internal project repository here.

We will see whether this virtio CAN device will be accepted in some near future for integration in the mainline kernel...

Regards
Harald

