Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834234CFBC
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720009; cv=none; b=Hw41VyVvPWmtOJFxz5aaKw/DVeO44kgEE/5AJc+q/C7oJBmYb0hrJE8KynFiGUj7btOlvETDKKgmtEJI/7Pzgyse3yrqidu7P/1RUVQRcSuB8wUKDeG8cv2YS+F8zBAcOenoklSAu9pBOOZoyjcZiJjqQeIfXXE91OIs/Srg33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720009; c=relaxed/simple;
	bh=sTEErpPjp2Z3VcdZBQ3ncsCXdMkyOWbj/MC6CcVmLfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNtRvd3juF3rzX3FXmlJws9u+84UqO2KHtzCpJRQg1Gz2G6oJxbgIwt9dZmtIN+L8ittIN6Q4XyEAOXgfJDsiPWO264p3kvZB0ytaTNHgHn/vXoX0GLNm6I+qA4yjWwr6fF/XFjG/oD1cGAnIOjFMx/W71AIP63AcT7m1cVlZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBes3I3Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zbgr9e0c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBes3I3Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zbgr9e0c"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606GjP9R731861
	for <virtualization@lists.linux.dev>; Tue, 6 Jan 2026 17:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYQ0RFgsq4v2jX8N+92N2Ml8ilGX8oRxAim8aWpvhaU=; b=XBes3I3YjDgtdZ0W
	m5LMrh+fHz7ExRrnSc9Iw0cqW3p+05ymBAtDC9LKqCZTE4akwK3p3IuOo+Rc/mpC
	3eEhsm4TnttzZbd9wmfQ3jDoGuyJuO1SpwbJLkzmoA8j4szWwhWeSQ926AwlH0La
	OZLiVn4LRIk3Pyn5Kw8a0LgrkhaOcIoJvC7aPJ4VFyxOlzCnQ8t7ADLc4SXtce4O
	ams8WQoi8xC8soU3314Bf5ZIAP6hAlPJUnJyWL9ixVxZlpjg3VoOZUbTv2SEp1CD
	s+h1UqTHn5trdEITD8pq1V1xE2lFv8LPAAvsnCd5CX7sNaTBEr1FDZzSORC6uCyF
	4T/j7Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh66mg3kt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 17:20:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4fc0d0646f9so47452531cf.1
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767720004; x=1768324804; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYQ0RFgsq4v2jX8N+92N2Ml8ilGX8oRxAim8aWpvhaU=;
        b=Zbgr9e0cKdJp559tdqbsSoXpCn2gix0/oBoFGMKQ0GowJTWRIdadb4oPxl+TnWQImb
         1UwrHaMOEpOPMAnXhfkSr5scjqg3AUsxCSAMO5xnKFg8mVHFfSM1t5NsWTrZjOSj4JfX
         o8BYFFMwMD2rqBqZC1a+rlOUWC/WqZ51DggN/0qwtsU7ZVd0muUxXvZS+6mJcnWoWcPY
         ry4E1tK1oYrkV5So06dPZ+N01MpciUQqg/kUNJSBGP53BIZNk/us0SXBcYFQ5JnDcYQj
         ckA2bvQ+Cfw1tRPOXbqcXgVt7NfBVe9pO1LVt6wrB7Gas+vhXnY6C6/BDJbaRJrXQ0Nd
         UT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720004; x=1768324804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYQ0RFgsq4v2jX8N+92N2Ml8ilGX8oRxAim8aWpvhaU=;
        b=NdONN6PuPen4Z6iLvohJCGOBCJVV8pEAepl6zF9W6cFxrXliBs3PobROkMYWV5pgtO
         omBwF4XwB3RNZ0zObj3llGTij2u/3I536UPYjRfxkFAa0zfPjJtqYZH1m1ZjN/40+Hp7
         UphHzrlSZUXc6gtSheOUY9SF1nXIGmcLhEKeYQR7w1xJKox9RXRmGcOdEev4a3TBym6t
         YMDuMitqmOthiKUVzKzHaetJkfauy0C8AQ/1NxvZX0ZDbrmIJNwjypPNHhwYC7uhiPgS
         InK0adGF4ZY99QTOx9o6LwEjGo5bZDlZGpll8t9T50iZXKOr2wcPEYQ5U7VEV5p8XXha
         4Z2g==
X-Forwarded-Encrypted: i=1; AJvYcCWakvhnggRrVQEB3bSt9w8BWVeC32lO0K/RVW46PQx4tzsC6+b5ufvKeyIaBsTxMR4fzsr0jmqteIgYMvdrMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7R2zm1GG/t7zg90uVQfOxnPf8SP+Z75sdvDqAskAnOVcjAKND
	cB50aHfBehjWoTmBKi7FTir0krjg9yWx20DlALb+FdaFPqGy1dHPPz3CTDbp3y25znUzyBx+7W1
	9U+cFTjq/96P+6DMW+9vgZ9Z7JTJ1DglwqUy9ci09ZM/AEDUBOSEDwYOYNG3uNsDlLyk1fIzzO1
	J0yA==
X-Gm-Gg: AY/fxX4aMQ5SrYTtPQNpDcxcXQjLCkuAoS5Qq2MxyQRaWNfftFZ/XAksGmmk2EAaela
	3rLzuj0NVCTmD0l71a2T+XfQylcvm2Fj/w8WwbJDLPKm1Od6/uZe2xNHRydvriabvb1XvJfn0Ry
	DeE3TXRbQtBpEJHEVKnr13RyGi1Dx1oWMDesP7wJwoHKUmKcTe+jJtNT7Cb+FkZ/IDeFIKDmgkn
	SAbaAzIS4ArXFZta8XzV6W+a7qmW/cvS4mclXDvWlP+ftibL3KIPzQrv9y2XweK74o1UYBBJzN0
	S4wM3vl9PrMsmJxakS0qrjNW+BYW9pLLwr977lFJ9Y3VE1Mi36EkYpgExI0tug8xZ7cacpeHhQx
	PKaJ2I80CfEMGsYPs/RdkK1w=
X-Received: by 2002:a05:622a:13cd:b0:4f1:bd73:ac6f with SMTP id d75a77b69052e-4ffa7833eb3mr49446491cf.74.1767720004236;
        Tue, 06 Jan 2026 09:20:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcVKhmSOxrYJdgdUdXOibewTJ5CLkfjpvth8cSPNn9My88somjEwg0WSoJvtWbiqCzlMfSjQ==
X-Received: by 2002:a05:622a:13cd:b0:4f1:bd73:ac6f with SMTP id d75a77b69052e-4ffa7833eb3mr49446151cf.74.1767720003816;
        Tue, 06 Jan 2026 09:20:03 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27cc6bsm274657966b.23.2026.01.06.09.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 09:20:03 -0800 (PST)
Message-ID: <ad67d007-7e03-4ed1-a163-9c16aee791be@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 18:20:01 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
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
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater>
 <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>
 <aUSJJtRNOJTohjCS@bywater>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aUSJJtRNOJTohjCS@bywater>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xmHEViF-zr7yd-dnpXMpp3_E00-GwpD5
X-Authority-Analysis: v=2.4 cv=PoSergM3 c=1 sm=1 tr=0 ts=695d4445 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=SXg1PQ7gjAQXpXJ5tqcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE1MCBTYWx0ZWRfX6F1/mFXQ3jjo
 7G06jxM4dRj8IRXJySpKwMUiZYa8nbUNm75aEw5tlrIhOwiLlQ3yW7eItokKlgA7Qgn2Yc7Qnxc
 D1yGeiD+OvqU37usEoefg8evNyePHMehtwSW/Q6Lw+TcOybLZqkoPzWD6n+w9K/lTQLHePuJowf
 Biex0/4DhCuDMtLAWtWWiLtlLGRHe4izWmjV6NI0S0mSHXRSGbhDcAo8Z0GiZ79164wpFX/yyUF
 Oq9p/PoGt2zoodacozOBgmZBdjg9Ma8HLrKCyF2cVZszeLCCkUqeU2iCVXSacM8egi+TV2ru0o9
 U5GCsh9ghJGN2JNZN8bwUIE4l8PI/7BDjEW1S0AkDav9Edx+WMmU2rGujVRmFLCTC1qLsdkjMmQ
 5XPKQS1AOhXErsEXcUoV4HGqjlOD1bkO8MZ1gSVxDq5tvO3Rpr0t6QmqXPaBJMxdJbo27yaPGAM
 SyTwCsc8DchYz56aseA==
X-Proofpoint-ORIG-GUID: xmHEViF-zr7yd-dnpXMpp3_E00-GwpD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060150


>>>>> Most of the existing drivers enable the napi(s) during the open() phase,
>>>>> IIUC to avoid scheduling napi operations for devices that might never
>>>>> get used. But here maybe there is a specific reason to do it this way?
>>>>>
>>>>
>>>> I do not have idea. I moved to open() and something stopped to work. I
>>>> am investigating it.
>>>>
>>>
>>> On a second thought, it may be wiser to have the napis enabled on probe,
>>> to drop the incoming messages even when the interface is brought down.
>>
>> It's a while since then but I wanted to drop messages not having lurking a 3 hours old cooling water temperature in some virtio message buffer being misinterpreted as an actual value. May have the disadvantage to cause load when the driver is not open-ed. But I see you also thought about 3 hours old outdated values now which may cause trouble.
>>
> 
> I am stil thinking about this. We are sending a ctrl message with
> VIRTIO_CAN_SET_CTRL_MODE_STOP, so new frames shouldn't be arriving while
> the interface is stopped (i.e., once it is brought down). May it be
> sufficient to consume and re-queue all pending vring elements as part of
> virtio_can_stop()?

The NAPI operations are only scheduled by interrupt functions virtio_can_tx_intr() and virtio_can_rx_intr(). When STOPPED, and this is the initial state, there will no TX messages and a well behaving virtio CAN device does also not send RX messages. So no interrupts and no additional load by scheduling NAPI when not STARTED. Having napi_enable() in virtio_can_probe() we conveniently get rid of messages received in a race when transitioning from STARTED to STOPPED and than there should be silence. A misbehaving device may cause RX load in STOPPED but this was a device issue. Under normal circumstances no resources (especially CPU) is wasted.

But to "consume" all queue and re-queue is a bad idea. After made avail the element belongs to the device until the device gives it back to the driver by marking it as used (e.g. putting it into the used queue). It is not possible to steal queue elements from the device during live state. So this "consume" and "re-queue" is something I do not see as being feasible.

Saw in the meantime that a new driver (V7) was sent and was happy not to see some queue stunts just to move napi_enable() around for no really good reason at all.

