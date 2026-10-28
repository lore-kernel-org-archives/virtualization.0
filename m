Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180379;
	b=IDS6y0i8yj9SMgkM73c2ZAGfGD5J7SDw9SBR54LdgrByfVpIiBXOOfaVOV7dtcsbp6IC
	 y2AhzHUHbmCdX1+Jwzr1gJ0XIG2QaLhIhumMfBRivbYo3Z8CEFkZo+Lj6qqhdC4qeNehp
	 7y2NUHwY+vNixeRGOEzTd96JhPEdvLHPMpza7hKZnVBXdOGE2jum9X5thHethi5xAIWOS
	 abLXbS2ZG57XznEhGV9Fmy53zcZGleffSRb9IOCSp6uStZVDTFXwvRz/T3KT/tD1y32sG
	 G3CFAgzpEP5nNsuBU3sWLbkdkUldu+sIZadYzo+LAB5P+u2YgHcrAsOygv/cS9mOCyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180379;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nhSXB9TXVz9aiCbi9n65eSnYhyuDc+iW156oc49stO4=;
	b=tLSWR5vCs9AbetO3as6Lu7WehuGJtqq1w2Cgrj8pYXF002uppJvi8wSnr1lO6PZOOlR6
	 wZlA0FjNqy0+ldO/KuPGX32BrKRbeiO+W89XsePwPz/BscZp0Bfe4k4gJIBhnv5D1rmbO
	 AHDCLsbV/AB0gfrj5iS+3fPB6VlgJipcuC53OtGSBvV4sPtHecTdrlFRGE3dt0VtNJ70V
	 JaihKesdoJP0rBloP9ytq1wStoUt9XwFAhM8UEU+XVggwqLrrPOrHDME/YWada62/NmkZ
	 mjzTEsypEKafymxxsPGdfb375g+oxmXb8Sw3PfeY83fjjnXjXqwVXZt5KyBDFyI0xFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nmUEFxRZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MtRYKMDo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05C606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD05C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nmUEFxRZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MtRYKMDo
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8KSJq3265095
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nhSXB9TXVz9aiCbi9n65eSnYhyuDc+iW156oc49stO4=; b=nmUEFxRZfcgRWKQT
	hzPWlWy4ZfVWACjIRCj3F7h6Rmw7hihb6JB3a+ka1dPuZIhBPfHPJ7Pdkk2aqHgF
	RDu+AdyeOjNNOqZOjwkSdJoI+JWD6RWuMIUYDLJ6imCJPPNPLyJh9yNw3vHITHaB
	VuW67xoiJGEtHAbY5OfKZ7hHdAp9g2on6Biain6QUXAjIfTzD4+urFr5yiyVoY/+
	v6E9QKnNfnSoZ34y6fzTg9C5I1noppCsLUJPG9RqLKM8bhlYi3K5G5DaFHOj5mAJ
	bXLaS0VE4MN73QDlO6PXKgy9AzYPv8SKU5lCrXQQ5nCWRS7RjCCVs5gIk4FmJsp0
	fM25/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy713hs7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:39:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f37c94ceeso374648885a.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793180376; x=1793785176; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhSXB9TXVz9aiCbi9n65eSnYhyuDc+iW156oc49stO4=;
        b=MtRYKMDolkSq5WdaKJztuBNCMs/t6Hv02LZ1Ya9cZIRz49wy9SrXxMuNB/z0FDn/NB
         oKFPvZtTvaMN824jFkArMGYPC8tiem7Ud7xUyhAQ76puFnBVlBijIrPRU4WZvfz0Fk62
         1rDFtMELLJE0ILNFsqGZ3oNlc4tiN0OQHxN9fx82uI0QKyNudv5oXj/Cumf6GqrXm4vD
         4RRHatK0ImkmUU3xhgpZEwwzvTf5B2Z9ifQMjekQy7Bk2gaKnecuLu98Ke4mfUsuQPIB
         uosQTe3ZduL51thCiwev8ghvh0iRCvCNrVX/KTH6QquhqErExWLLSTkpBE9St/kDsBsr
         L5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180376; x=1793785176;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhSXB9TXVz9aiCbi9n65eSnYhyuDc+iW156oc49stO4=;
        b=hrHxPh1Xqc9Vc+KScorsgujq+K1osZXwCqIgRMINd+VNvtCzN9PulytjO3a9kjsP3w
         S5vkqsedHBSHrJcYDOTc4Mao4E/b14QT1fBY+2GjBKjkONfQP2bWxqGLJDVbhiiDe9k3
         yPRhFmSE4dZ1sshRmiK/WqdIMxnmS+kpwhF8oNhL/3qTXgKZ2mVUMCOP+qfMTJLaYAUH
         fHWfMnyyCLE/1eqYhksZUJfQ6PQBP1BQoszUvO2PfuTEDhSy9bL59CbbBVMw1RShcAfq
         7kmK6QKCSMIey5nPdNLrJEWpFDr8tvrxlEV3hBGRca2/38e/V03FHi8Uhz0QfeTm//O8
         6bdQ==
X-Forwarded-Encrypted: i=1; AKwUvBx44R/u/Sjk0tAIuQ3z5qxuROE3iHz/c4J7rJRYlOx9twxqbF5Iu0JkvCDSuZ5NFCw/YwmIBaCa/Cany69Flg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfqMc5GjsW0adxND2yU2Pk2tiJY8Tw3xSkFZ39VOr/yiAcWgZW
	pHNhCfsbFNm2TgppUVtI3Su9QddSSmdeKhE5NPDkIvN2HXNWDLZIUf/X4OiPAY+apbuUquR1+Ng
	20x13lW1yoVp6WEY+R3GnUC+WX1koymneeLoLkr2Kwx5bssB1g0+Hquvi8M0r76BaUcqAsQ==
X-Gm-Gg: AYBFou1lfkKrAmuq75mMg3fhv+/8GB+GMOOsevXlQmJn1J1fvWxO78p3st6f40MjXq5
	iJXaMw1Z1MLI2NwnOfxEBmPnP9cnMuYAFqVQCDUOCASPRQ/HHVXmLl6NasFscVP0IkTQcTBku40
	Y1wYMcZYhEMXQ3qfjItA52NXliQYqrIpHnZH9eYKP2EvOHHTX3c/F+oWHbtWid0Qswm/B0eirPa
	EhS2I2Nf2Vkl/mMvmrjyiew85kwED5nM/EopdcVD+AIxjGb40Fq2I57t+0Bh7fTkwTTcRDFOBA3
	Dh9q5aKPsffyi7tIxvaVHaUzAocihuem6CBGzNIpkBei+XFz5xiEQKdy+3x0LtBFy+5ABE3z4QD
	oi0aDLXCf1/xeFzQ06ygcssQ9V6Xtq9QUvQobs3vZN0XISF1RZTEE1zaMJ6qwhe7byEhz+BXoxx
	Ui
X-Received: by 2002:a05:620a:3904:b0:93f:31f0:6a77 with SMTP id af79cd13be357-943f4b3d96dmr841484585a.11.1793180376568;
        Wed, 28 Oct 2026 02:39:36 -0700 (PDT)
X-Received: by 2002:a05:620a:3904:b0:93f:31f0:6a77 with SMTP id af79cd13be357-943f4b3d96dmr841483385a.11.1793180376205;
        Wed, 28 Oct 2026 02:39:36 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97a093e7bsm32246735e9.2.2026.10.28.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:39:35 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Francesco Valla <francesco@valla.it>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: virtio: convert to immutable irq_chip
Date: Wed, 28 Oct 2026 10:39:33 +0100
Message-ID: <179318037067.12114.9317144412817671928.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027-virtio-gpio-irqchip-immutable-v1-1-f64ed13d4567@valla.it>
References: <20261027-virtio-gpio-irqchip-immutable-v1-1-f64ed13d4567@valla.it>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX8FRu9Uo2KJ1t
 xOGca8BW3B4ev2ZSc2eCbSvNBuJarVQZ2NYr2YXwcrOLutTi/OLIGy2OLkYdzQQ+bpKZ8M8DF8v
 FZ3DlQAkn1EtR1+UgulHUwfXNrR4V6xo7C1n5gGLHCAXOcGzV/BtCxZKUhj6rtOJGa1QWYahBbR
 /SCYJXs0B96EdTHqyuvG3wjXKjz7QNlUCA71Y5xwBZvTj9Tv3gSyLZuxRgePqtgEo0RDa958FBU
 1MX44QAnEYDBGtnPqgUQHfKhScpa1JuG2GH7jYyewIzunFKvW5K6K3hqxDxT3zBsdv/zq05cd4K
 oZSe6lwnkeW4glmXdxqxUdY2d1m9HX275XUYZsRb04kggWjTcdPpCd3aRC1ToTt/f43s90FLV9a
 c+b3ocFhGpHpjStY41fFSvxa27w7+UyNcQK4PLySAEIyOHP+x8vXCsW58zdDlhuWnCxz3iSTCjG
 US5wXtBmczHIfRGhR3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX8HiI6jPFZcCN
 XKpjykCQvBhEVCZYmvjYGYW1lMF1F8PkT9QhGVo2n2ChEIk7jf6mOg3UzZKdvnW9gq4jwTVdsUS
 /8XbHVvTTC/uNJ4jv+OVgNtqYhYnDwc=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae1c2d9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Swp7RsIVSdNva39kMz4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: aQsEvCO7809VGAoh2eFXHJbtF7xA_qyv
X-Proofpoint-ORIG-GUID: aQsEvCO7809VGAoh2eFXHJbtF7xA_qyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280038


On Tue, 27 Oct 2026 13:55:24 +0100, Francesco Valla wrote:
> The kernel has been warning about non-immutable irq_chips for quite some
> time, printing messages such as the following one during initialization:
> 
>   gpio gpiochip6: (virtio2): not an immutable chip, please consider fixing it!
> 
> Convert the gpio-virtio irq_chip to immutable and add the relevant
> helpers. The exposed name is kept the same as before through the
> .irq_print_chip callback.
> 
> [...]

Applied, thanks!

[1/1] gpio: virtio: convert to immutable irq_chip
      https://git.kernel.org/brgl/c/c3b94486f0c07562eb894ec6c666656f8cb6eaf0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
