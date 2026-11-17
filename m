Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904093;
	b=jhEpms6ul7UI8YKn4iHoF2hz4OJQVWb1m1A1iUxFTmoevDBhpl5lAdrbVlkN/447pDRW
	 AdgB/4U4fpThnDhsOCHZ0jGajWTNquPoAkhbPBukOVP4pPRXKg/wLARc4qKcSZn2Q9c8Z
	 maDHOURD1Z/KNL4W/1ssc5VwMFdKAyQc5sxbecmXL5hRsGvoF/HI5X7Aq8kd7Jig884Fp
	 yz3HcM+XVgelfTl09c8Jkw2/zBAMsOyFlv3csSW6LTPTqlsrvFzwwSTQYCSWMKcRHXmqo
	 xWGWUykhIF8onysCqnf7F80RGbfbSL2vPP2iaY9SZNoFQDaKMQC18Jksz7ZoHhhPUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904093;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=;
	b=vAG9o8E9KTbCXbEVB/EWquA860Mp0HsuQibHia7rg/3f5rO/8FXNyoOkegVz3DrP1s0O
	 NXSIoOFqXcjkZXPpisCp1TACv5ecizQc/NUWhqjkYGcBk99eC885Ojvd4YJsjE0mfdXsE
	 QzJiJP/Nw81KfcAxawmsRAENxqXQiOMEdJoLtCVMs/x1BZUGLX5dvXTkSOGnJe9LmsB3e
	 FpieuodeXQBrNL9YY00JqnUuwjg9ShCUp8gHlmP8DsIxxvcSrUqw3JAbwGhkTcy8CZRYb
	 cj+n1vSP1JOuE9GnOxHfUuWrC9SLinjAszadVlg0Rpqa/zDd6jo/tQnWK7qB8YWeZ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lY8u1rIu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HRVrvggG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014760A2609
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D014760A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lY8u1rIu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HRVrvggG
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2aC6R3624157
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=; b=lY8u1rIuFDh9Qc3o
	G+xSp1V8wA3nByNZ1k6tyv2kz2nD8XND6JamyN7gIEKw5mzpYxQLmf4eNfr7n+sA
	NUKbd1XO7mEAbbqgNu3ShKRar//+Z3Dnk3iWRp6mLffgCfmhYNKLSFdYvsWe1FG1
	qB5trr5C4W8N46O+vKqkSGjpUlSYl+tYTF4jjZfCPSNfrER3f7QJI7xFJx8/QRSv
	APW92JALwbOHcuXIAxPKU6+wz1KCvuBr49A7zlIgYTUqn0cKLVda4XN1Eh/gp23n
	i/3SZHPYKhQhokvUAMx6GC34V8AaUVsh+FauPEGjNIi2gsocx5HbkTs0P/xvE4Tx
	+5qMbw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07rejks0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 08:28:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91ebc622dc8so69629716d6.0
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794904091; x=1795508891; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=;
        b=HRVrvggGqbqU0kmo7vVsXw0+CgnM6Q2KXUTOV4aVIg5FPrw9jvSiTyCzJoYTgchbbJ
         FqCWMRqVQxX+tl3BAmVS/lhYd4oi11cANeh/1cHVHP6BZPPBqHfNtTHDNNlexFfiS+bc
         AY86AHsSxOP8a63PFCk43odyRvRRIfUdIUsgMaro3N8yhVb0a6OPZpnOWXjesHZVcpeT
         wNzPItbogA5EG3mpuDGwAx0wgXpitXdSEw/VRkeMTVqiCbgvUK052LgUGappfoQAXhzf
         +/7i7qJSVOwFr/WUA5WmmROagcyO8kXmooI6MAnxXbMqBGLupdbZZfmY9bg0PW5UaeoF
         u1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904091; x=1795508891;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZAKVQ9Wk/3PRWBaBX60YqHirCfqcsw8oH1gOKjzlRc=;
        b=ZR+WDGQFgZUspxyeLO2eKXbLGwpfqS0vEbxLZoM9LZXj6KFA3FLxw392/7x5F0ixkd
         iJanG3xJJtCBh/z/iOM5g81kOXQbhauk38/uNbsBLOlWiWOuoU7jWcK4FSPMj97hYf0l
         vze/qgCxTazUbcdNp3byUAEi9xWTfPWZuOn4ZF+JpXKdMp1shOGpn3k2ZJqGfYvCs/3e
         IBVe0EFyWnGThMqWRCDLDZ7/ELETy95XNdgYziacm/vgUyVxaMFqU/KdFZ+0j6hIBmVI
         L/8EfitoUE2UuUxGa4iNtWOh11PLh3KVT2DogCmFWMAwEYwIXCbYByl8h2mHdAYZNcOv
         EekA==
X-Forwarded-Encrypted: i=1; AL+hErEE2RbD+0Rm7lzx+K7rgaQu5S2Mr0BCuB6/D9rpAelpnIisoLkMLlJ5w4Nn50zUlCNYFn6WsoCIjV1+7b7bew==@lists.linux.dev
X-Gm-Message-State: APuU4Z+8HW6To44ORaKRAFpAb9ksKrQB4X9x9f9Rzyyh3y0EPEpW82uT
	LP//cUXy+4hRC4lH34AcYPgpvd30jDlSqFdAJGVQOtNraKLYUYaXpEePFk1z2I1jivonhlgkgVn
	IUHomHZ2Ir5KWVHvSDwNZ1xJhSdts189V89UCsGZvBr94l3T1SCFxHTjd7d7rl0/7q702xw==
X-Gm-Gg: AYBFou1VcOKGBssXNlmyDw9ZCllOgoNAz83zvu/lQaqm906IPCC48Y0lnGhHWXN4eEH
	XJQqtGY4I/IudRnj4zFsb/6XP9scriWsYImseFTWT9X/Fes+AY1ujjZdhndZyyVwxxV43Bdm7wv
	Qt25O086YSM9NC1CVbVjhY9x3rZyA97Mtust0o8aFEDAsOQZbC2fHuIMWwxKdMg8ek+Y52/WxjU
	bpT30FHjgtXn5WbVy8vFrcXGbENsPV34sV4yuMRTDwcLpAB04/EMw4cazkbnIT1dFdIj+M/3029
	AsAxL+lEeFNbDTfxxWB5N2U6/MxT9RVB4c+ERUUq7qbErl+ExkvfTCbe98vaGJdFzUwYpsOqcUS
	vrZgqfnn4dQWZuIOG6Jv288Oe+3KCMJSUtOpWS+/Rzi782ie5S8BYKGCb86XYwQYAv6TT98Vb0Q
	0=
X-Received: by 2002:a05:620a:690e:b0:949:6d95:f63a with SMTP id af79cd13be357-9496d95ffb1mr1337952585a.78.1794904091223;
        Tue, 17 Nov 2026 00:28:11 -0800 (PST)
X-Received: by 2002:a05:620a:690e:b0:949:6d95:f63a with SMTP id af79cd13be357-9496d95ffb1mr1337949785a.78.1794904090783;
        Tue, 17 Nov 2026 00:28:10 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a2ea918d24sm5393966f8f.54.2026.11.17.00.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:09 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: virtio: bound the line names block by its configured size
Date: Tue, 17 Nov 2026 09:28:08 +0100
Message-ID: <179490408585.15375.11644754395954645362.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfX/SRwCou0FlUH
 SCNRMHZy/8IgdYXQF+aKXZMuakOD5bnmbwHh772xhjJVGmyC2cI4/6cd4c/U51NBkactk6cRQGO
 Nl/qLPu2MP3PamzkuIx3cp/IVLmfEXE=
X-Proofpoint-ORIG-GUID: yE_Hb601yd3rXsQmVMcxxL0a6uJHo0yN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfX6CjIqiXF/O5g
 DHIpNm2QwtkVLDHI84V0+fD4NALRzlx6U7zqXUD2VQxLU8Ls2/pEAAj9eOT5TfeUUvXRENRUUe1
 0cgYW9VaSLjjarKGJ+SBYKIz0hLKFO52Gh7PuMz8dU+KMOq9ZSrMzaYRUa5JAIot/OZrknpLdQC
 N2BFm+Xkw/Ii7Gs+0GnOldG6dgnAi0tDX0f0uspV25rtw7SaoPDotDi2tLW2avtgP1XbEPOalhG
 hjW9vZ7yVV+kkiHp3j4iW42nIIyM19U3K5+GrWBt7Jqevx9AV6OUEcZ5+2fXCThKFr4SHeO22d0
 im3X/l5XE4yMDYmZTBGY2+iZOhvv1U1eSDunzaygXELJUcThtV+Wf3PRkvQVi8iBpHpZhzTqi+A
 SpQKaFQn2LCX+ai9Wl0wgU/4lQ4el8MCw8LDCG7Q6YNCYANGH6HLPmRc+d3lWE108NN6k3jn/+5
 WMxdPQAphUXZBcxbS7w==
X-Proofpoint-GUID: yE_Hb601yd3rXsQmVMcxxL0a6uJHo0yN
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afc101c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cV_xUt8ozR8xq277GC0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170033


On Thu, 05 Nov 2026 04:56:31 +0900, Lianjie Wang wrote:
> virtio_gpio_get_names() walks the line names that the device returns in
> a block of gpio_names_size bytes, which the driver ends with a NUL, and
> checks each name only after stepping past it. If the block holds fewer
> than ngpio names, the walk reaches the end of the block after the last
> name, and the next iteration starts strlen() at the byte after the
> allocation. With a block that holds one name for four lines, KASAN
> reports:
> 
> [...]

Applied, thanks!

[1/2] gpio: virtio: bound the line names block by its configured size
      https://git.kernel.org/brgl/c/74aee8e06277df39ec10ed043bae0ed5b7a83864
[2/2] gpio: virtio: compute the line names size in a size_t
      https://git.kernel.org/brgl/c/9e3032dc4d92e6214ae687b4c474de9270ce74a2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
