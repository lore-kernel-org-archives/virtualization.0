Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B42313267
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718236; cv=none; b=MDwh267KG5xnXJ7ZVgRlMc2NRL/8elvBbjgSc/FpDAt5BW0KT439RCXtFeeY24CT9AoNOh/BTk2+2zY8GOf7EpYet3RLcY7KavRHlvoHpX8EtRM2D32xyxJoQSXqdR6yWN1q4AiX4Sn74mYjno+dvOJNXFqrhrZlI+jPuWWQw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718236; c=relaxed/simple;
	bh=6iSHSTGCHOn+oNl65sjP1ZpMqEAVFdqznf3RZmtfug0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntr4MWcSbBhUBLZiDpEYaDzyZaT6pMiFR5bIEuJ1Y7s7cuWA0oJ4BZaIKDYy4y/d4s+uElfPl2k93tJ5+Xp6kZq6ipBLeGG8WdOm0BlUC/uP8gpKMdRXWg8qst1LEjDwoD5aRcwcazlV75z6sk1Dq7v/mMSb/PfnUmttZd871+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Erbn7mW7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xz0w74jn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Erbn7mW7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xz0w74jn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6069W9Ig4090727
	for <virtualization@lists.linux.dev>; Tue, 6 Jan 2026 16:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VAUtlmRjLy97NcqtQuTcG7bRDJ8Ja6OXdIIzOPTCSs=; b=Erbn7mW7FGK8CHMe
	HevbAcgZu9/+p+jdKpzsXslBskXkFudpJPBk08oyb2pwkqq3m7TpWbxw4WdKy5OU
	sZ/OM4NUfMAnlCBH3oKa471Cw9k8rV/a/pZdICng9c0iDCJ231Rv75KkFhY4GVn7
	zcDgr2SlrBJ53QtC4yXYe8L7a7m6UU/6t5BBqDGW1D4SiltxbBIxoECWsMMj4PIs
	BUfH54yq/MoR5x5rrPPz/qQ0C84mwcPoBDwQEiwp+U0dxUQzBAc0/exOkFaxAhzD
	m+ARe0ZXnI8G+ksQk9kjrUzeVZBtFVfznuMDyzX8u9LphhYvz0i1Pajn12hXPr6i
	m47XKA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgyun97sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 16:50:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ffb28462fbso2222061cf.3
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767718233; x=1768323033; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VAUtlmRjLy97NcqtQuTcG7bRDJ8Ja6OXdIIzOPTCSs=;
        b=Xz0w74jn+N3NlJznMa7GkAtuoLwRi2ysrTUt/ApGzk2T+py48nUpS56MuqaQYGapOL
         Hc9vgXMI1MhXJAfT2V3DlCor4YxzDXNy1DgTAAUSiewHD3+M/LTFn5yU+aXhIhLdCLgB
         cypobmBL4Hf1GiJhDqbace05zdWOI88ZkLNLovaD0BbcrRO/pL/xn3bi+51pQP4u7RoX
         08Z9EZRX+T/v9Ie34NGlVeej1VVYyvHJC2urD7CPAkouEKnskFu3UbQVEBvZ9Yspf3if
         q3s5Vb8KqvirQUFXQCxAc3PNOSi9n6Mx3Z6P0E4RR0TT+PKgLBBrCbIXDay9JqL627ks
         cFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767718233; x=1768323033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VAUtlmRjLy97NcqtQuTcG7bRDJ8Ja6OXdIIzOPTCSs=;
        b=t+HUN7XmGNrO5ZfCUoqeKi/5ld1di4OzRCRjSRyFyDFegRHpJ5P6k5jksOrhXaQLr9
         uDyh8c4PGqGheRNKNOo4nro8M7jA/m+Jdkc169VAUDoTbeh5R5JUtbOjJQkW46n3Gbkv
         IEo91cAWLettYn2qar1ts7A8gJVa3/5BlaWoKxlzmh6ccfbx8wqXpJSQf4fNwt5ZaOUT
         AHrvfe4/WZJn3knHs+0If9tv+mVBs2HljBisdqi5xV2SdC5dr9CbGO7tftN/g3L6uEBm
         hMQ4G1cdH9vRNEFmDiQuDS+txArmnHN0TL+uTEdX/NoNrm3++NQtnElBOVs8Qz+qoHp2
         DPBg==
X-Forwarded-Encrypted: i=1; AJvYcCV5SocLVHnwFfIYBY7WLDSJZl2UGrk9l3hejRbiQSE4LcwaFoV9RD4lBYEqUipg9HJeFloeJDmx9wz0F3gdpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhJLfITYV/zU1Wc2zSJ8aX2T/lCI7rjqPPA4UCZlK+RDItlT9p
	fqmFS3HlUEpi5gYD8lDzebWzWB7vVBpTYN6ROC6jahJYvEo1TKB2lTNd4x09qTYpOr50ofmhsKf
	kHzWP+Uh6XC41iD/QOs6sTyHwgx321syts10apG+oP4cB5e5XZGrUAbn2qWS38ZSSeO/rwg==
X-Gm-Gg: AY/fxX656D+mD3GqtqG0h16isxZD/x54UkyIYh2QkldD6gWjIT3/oJlc5dOZS4twKF7
	Jmbw0+wcNbmOjjhIgoiBZvaJbApHPfT9GdHTRa49ZrRoAwxJDThAtRkP8TYEUP4Im3N4qaBULGw
	g1qaHHodJ1M9Tw5zfw3igaGu1kd+zKR37fj2FvO9L/4l4WAS5jlYqp7bnmd3OO7QUvjz+S0Itz6
	48fZG7RMtFPWerpnlg9FiZcx3U93wvkwACZ6qpwuCkirVIK7PLkuoSBCFkXeRhxk3KZPhuV1asI
	BBSg25FtBR1PWj628Mmzea9PZvmNhh4l2QqRYngkWhDhzJTRAcX1kXCJva7P5IlG0l/ZThlZthl
	x11GBEdrjWZGYBHdUEoTZjr0=
X-Received: by 2002:a05:622a:4d8b:b0:4ed:e337:2e68 with SMTP id d75a77b69052e-4ffa781aef8mr44277321cf.81.1767718232850;
        Tue, 06 Jan 2026 08:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/ZXbhNy7Jd7LAhxEa8VoxNP3Jg/EJKMvwej6K1JBI+OtThxBa96D1dk7k6OgAcGm/ULfcxQ==
X-Received: by 2002:a05:622a:4d8b:b0:4ed:e337:2e68 with SMTP id d75a77b69052e-4ffa781aef8mr44277011cf.81.1767718232444;
        Tue, 06 Jan 2026 08:50:32 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a563f0esm271661566b.60.2026.01.06.08.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 08:50:31 -0800 (PST)
Message-ID: <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 17:50:30 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
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
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora> <aVLq1ibPcPHk-7Qv@bywater>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aVLq1ibPcPHk-7Qv@bywater>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfX8rlxmR2tb/PS
 1n7mgDWKShN6OSI7mswZrSZB+MmCawS6yXtW5hZBEfj0JrPq+4hWf/oAXgyWQCylGhc5gLKSTaG
 TlD+qWLssPKkAPy7Z0iLneWVugDkX5RpbZmWSHIHZiU7Km+SaXeKYnp72My6pbw1QGUoBlqukSc
 yT15/UZU5Kk3KwdG/ic8lIgvokhaQYe4mFlr4ojvRgOc9OWQtMqd+mvdimLENWgqV2lmOyld7WF
 vEheHQBEUBB57YG6QYW22wALk6wmzCC929bIAFKmWBgtuTThtcg38ZHkXuzEt9fSDpaGn9XoDu1
 D/8muP9VGxzsRxVrZgsM/f9Ckt208Cffpy0hlfzIq5IlJCPwwFgLGdn1JttF7xlOdVkHOkbPVuH
 5tVcf+IW/ww2v+hVLXQT2+2ep1Qx0iRC0s0yRWhbD+0OqhKFK0/P97jlUTpfdmwlFA22Uyggr1E
 k0kRwwHi4UAnxCUYyZg==
X-Authority-Analysis: v=2.4 cv=YqIChoYX c=1 sm=1 tr=0 ts=695d3d59 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u_aeR0i784IBtNsgb4sA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: cPziPnrdaEBcwvyqpT5gv4WRtzBO7_uJ
X-Proofpoint-ORIG-GUID: cPziPnrdaEBcwvyqpT5gv4WRtzBO7_uJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060146

> With the plain 'cangen' you are not really flooding the interface, since
> you are only sending a random CAN frame every 200ms. The only way I can
> reproduce this behaviour in a consistent manner is running from the host:
> 
>     while true; do cansend vcan0 134#00; done
> 
> which seems to generate the maximum amount of traffic.
> 
> This is not of course a realistic bus load, but is leading the system
> (at least on my setup) to a corner case somewhere.

I have no idea how long the shell needs for a loop, always used cangen -g 0 to stress the setup which is most probably faster than the shell interpreter, and sometimes did this for both directions (RX and TX).

Full load is a realistic setup. And even if it was not, if something stopped working or worse crashes torturing the setup this was a problem.


