Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533E2DEA87
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367849; cv=none; b=ScWb8rhSq3CitG7t5Q/a2fhM/o7MxFuGtYWHzRzW3nfCJu+oO7HEg7Xwm5b46tRQuOWwMbTwEmZyx5Z4YiHPUOp1DZfe/Sprfw+nsceWwftz+ZXqBSQY5VZiPzUhBTYdxqXhRLXYiXJ8yZwwrkeh2n8NJiSlHfkch+UDZnQuoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367849; c=relaxed/simple;
	bh=iKpdDrV3kOuTOMc9bKV37vH2GuPaHLNQYpIK298DPUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HE31/bZW43yORF3G6rmolTAUgvLeHQ9oNi9V2Zl9PN366/r8LMc/Q4b5u1FiCWnwgDY7zYV5jbV3f/TX/FawwNeXUvZKZF5oENBRygXubgwWyxK+eAeBBfvNNJ9mNepDZbZAVtAvXWtwADALclzfdzuvj9qJtB/UIgqufnEr/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xhbmu1O9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xhbmu1O9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9fjiv010362
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 14:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XR+fnHt/cqBwBuufCMHCP6JVhgYBVarZl6G
	D88IpMe0=; b=Xhbmu1O9XrQSBkuApyIbBeOUQ5dV+hozQWqvPq1eHl0bWT//51a
	Uq0SGquOrhR8V/lelPmCfREeZQ8AQHts3oGiEHgCuajusctPIaGG875wtO02+esi
	HOtULLor6lThCHfGhZTfNayT8UbUIuH1MHIcDzuDV+HhYWhwQDZ9dkrkTCocUSUl
	ViEEOo+qqmODjqXdYBwRjrhUmoH0XrifcIRxqzrm/gmkJaD1KYPPdDedaCoUMV3k
	Rf0VUwiloug3NktoSTHYnuJxyggp5+tD0mcVjGtfXDh/ktkDVgwSWkuklgr2urRU
	8fjzBAkjplcfyodESlyLo/xCjC5+yHXRjNg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6wa7y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 14:37:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6face45b58dso16765826d6.3
        for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 07:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367846; x=1753972646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR+fnHt/cqBwBuufCMHCP6JVhgYBVarZl6GD88IpMe0=;
        b=P80wi+mPT8iZI0txBcU62FJEohkWkKYbJoX8YsbNpGvpAeKovHmgEdjksuMT0Md5tz
         N36T2wkXn/Is18M4gGrC7Saw8T4gGPSZkQ3MHCwHNResaA5yCk/J9It2CJDW6WS0UPxX
         VhQnNawfLJtnVff61JtpU4g8KUZrOeKrhKgpEDlL0lmBOezaWLPnMGP61jJtkcoNTiId
         NNJq3SoJhF6uuo4Skk+lkGbPRG5u7ci7PGM0MqOS60urY7p8rrSOLLxjQsTqDYKsl1xe
         dwq1U4U2JeWVpDIrBr9R7hJIvd6kPt7X18eYDkFaywtj+oFOnWJWkypf2pFchxLAuqfK
         TjFg==
X-Forwarded-Encrypted: i=1; AJvYcCW919nCEx4B4vOVsT/DXjsxHhuBSmLZAr+pH3poLkoV7weSUmcRfUDGhsOfZIl5e3xq7mOdEwdZHWu2re/1QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5+/TEv2ZoBBWqbBp1O2zsi/7Fg5F68GmD2oWzunb1zV1oY1qk
	q1y/9GhLHgMiRoYWjBKgKLNUgj+wiCe3kZM2AMBaj+QU1IS/OHRI4t+8MDpMXzwV+itsxAXSRpJ
	XWHIdw0ITJmURGl2HAsBFODRo5RTX9kqxc46zdC1tA07i332tUzsblzNNBgOmlUo7RTrGPw==
X-Gm-Gg: ASbGncsSg2lfgRZOax0NzSKcffD+UkJae8nhJggfrNLqtMoultpQmijJjt2yDLSFwm0
	GVNCFTLKPujPGvupAgQaneRu73xqw8T1xtlgdQh2bdCXhWOsMNqu0edxhxKHpHqvIIUr4PP5sa/
	A4IMd3mcdx1VzWkeETsPTvfACp9YVcqezjeRNO809HzIVhju+HRAqnP49Lk7EtOD0yytr3yW/Uo
	mkw1/KnCwxlppui6RXJTZ7wfqaV9Qst4ssEf45AMUDJm19JbbpZLmUxwxT8noK+RFheLLTETUyv
	uZ1wBCVsn1VndILuKUHfi2JdBSGKuWH1lGbfpmAfTU+pY0rBj47CCE8/F1cioczxzQ==
X-Received: by 2002:a05:6214:1e3:b0:707:826:1ab5 with SMTP id 6a1803df08f44-70708261c32mr74163166d6.40.1753367845533;
        Thu, 24 Jul 2025 07:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc5FI+9v6XLNucNriGBwsIEQ9dZNlTaDhhPu74MX9L6L2A3ovmGB0HEuxN22mlYUvA2rHdHA==
X-Received: by 2002:a05:6214:1e3:b0:707:826:1ab5 with SMTP id 6a1803df08f44-70708261c32mr74162576d6.40.1753367844954;
        Thu, 24 Jul 2025 07:37:24 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c495f02sm122856266b.2.2025.07.24.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:37:24 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] gpio: virtio: Fix config space reading.
Date: Thu, 24 Jul 2025 16:36:52 +0200
Message-ID: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=68824527 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=OcK3cvsEmbn26l3-tBAA:9 a=ZXulRonScM0A:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfXzHv2k2kq+rUS
 8X8FaAvqDKiN7zL74NnYzuTHwdZ1yP9IT4rfJ4AKJTMuFfSxpMe1HoBdVgQL7pfeL0HYqLJAL4r
 5tgZQ+j+pm+wWLBN+sHzFABbVTdqXyd4Tdghehsvbv2XJGLtMV8S2nut1QgRvTjSSIhAdGu9Qja
 n58dz3whB9ft3+wR1WjS0ry8RQZG/t5JaSQw4TIclG/IUO9NUOBaY2H3xybcuAbnyQm61XiHUKM
 Y6c+Lk7IvBTWV5//A1p4U0cvj2UZxYvkQiBMY0RMu3hjaZIPq1n6QpHPZKOxGvN83CNc2Ak9Rh2
 njJHxhCn2R+hBTcUkPepyrAZ5pjVpaLQoqAryjzzRHTzn3pYADi9HCq6KpQzH7bkdJrIOgG+zUJ
 a8963f+fxzzl5qCclmUjM/C/OUtjhzHlNB7nwAUKiK+s5Gvsiy5OWMb8LXoJ2kKqE20Wqfx0
X-Proofpoint-ORIG-GUID: eDGyxlIlvzt4IVGeV7Fs3OwXSq6ZyiO7
X-Proofpoint-GUID: eDGyxlIlvzt4IVGeV7Fs3OwXSq6ZyiO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=938 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240111

Fix for Virtio GPIO Linux driver

The Virtio GPIO Linux driver reads the configuration space in a way not
conformant with the virtio specification. The hypervisor we are using is
strict in what it accepts so the current behavior causes a problem.

Builds on top of gpio/for-next, tested on Linux v6.5.7.

- Add CC: to stable as requested
- Add Fixes: in commit message as requested.
  (Problem is present from the beginning and was not introcuced later)
- Add Acked-by: from Viresh Kumar to the commit message
- No further changes to the patch itself
