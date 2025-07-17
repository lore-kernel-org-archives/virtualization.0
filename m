Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCC15A85A
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761413; cv=none; b=pKcIoP0DuzsihkJJYY0xMqJRVlOxoQMrmTLJoaSFsNe3AGch/UipdcGMTogEVRWZz46k8mSBnntoe3XTfgwk06g8VVtp4p8A2svHBCoJSYUpVSVRn8nRwmmivf56r7gbFyCQeo/YbVEwsrQGt7lvuYFWOr/CSO6B1Uk8AoTOUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761413; c=relaxed/simple;
	bh=Hn6xp41CG8R9jLKdMzrXoDdSoG3dKzhDMIecMB8nXho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHVZ7YYNcdlMzp+HouE3gVY74vTYC4W8p58MsVl4Wh1zIh+doevqzyKVtE0aUJTYMcQ9tl184wwwlY7vx/lCe/EdhQKZnS4vyhjyqizPcCfBrFxT8dxb6JA4TdsOiAsa9ShuZhZrJzMxq9Dv2DsH4kc1XJke592CBu+xn1c704E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U556DEdu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U556DEdu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC5nUY021258
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 14:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Hn6xp41CG8R9jLKdMzrXoDdSoG3dKzhDMIe
	cMB8nXho=; b=U556DEdul47+c8LrFA0hHZ1/MRM688BpmpxOPkNNmF96rNa+tC8
	sHzehphmv8NB/cJftt9nF7yd/e98tRCL+1Vc5l0MvJIrviMYsiWQ5TpJ+7A8Inzs
	G5Z2oNGReaG81ypWgoTLWMsK/bUtRfJVVpqScJEwmQhk2/ft3QLWLWsGcDzgWNJg
	qaV9hPM40dx327RM1VKpzhG+RoPB3SzhDqNqNwUw7O5fWMSGAAowCgfaxIVAIhK7
	hArOGXPJmQj2oaK8hzABiyTwVaWryiknPWRHdHGqPiMCCVoIPoi9Qs9NM7zbPqKd
	I7KMCOSMgwcHbNi4Cj0H8oSEP60laMdhXqg==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpjysc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 14:10:11 +0000 (GMT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so123383539f.1
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 07:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761410; x=1753366210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hn6xp41CG8R9jLKdMzrXoDdSoG3dKzhDMIecMB8nXho=;
        b=L7rRHO7MCDADeMoZg9RtMD9L9A227IwfDSmdwdFXCipFfm1fuJEPzb2qRF5tVfrrlK
         9fOkgkUvu5Z+PQ73izCC0HSan5jADiNFMlPQFdnX1DCy/Tn+gTnG7BND23zaGG/SOEiU
         BKYPD0CTEUrYKyGROkSKzkz0kouz5ojxh0ZhkGf4dRENBLe3iOd07YX5kWr3EeASYr5H
         tZLIdLsUwYNV3d11okGpjKM1lULrLKaKWILkA8Fj0xz9GSI6e1Ny9RlEpkH4uw1KJL+r
         5zkLk5bC1rRiXnvQHgCVCbovBLgpTmrIHWU+DlphOJ0WyZXLt0fgsC3rW3s6O/3K0+iW
         uT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcavipBh2eBlLo13HGLb6fyd0VjEvMc/JxfGAQvdz4shtKgyw5iJcct/vN4qX4U80LMhdauac7rexXlfaRRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxS1wS2G+DVJj01hV3JnWkiQXjRgGqEAeP4BjanHU43ighJxRj9
	8MbcLI51oy4hBRtuNx0u0A5JuB+lLFI30/FXSDlqsmMmZF3kGXx92EgLDMIxK/M/y/QOU2DyVc0
	IJy2krwqZdYH9WVljx+EKaLmnuvHKF3Ut+LWIwM+KuZlDmKTbfxRHPXrVlw+vT4ERQexkUQ==
X-Gm-Gg: ASbGncuAiQu0LDwl1CWufsBlWcSVjhRGC6BdARtVXysxRGu4RoUkwUCqSxBqsu4gAi2
	XrQ/3hMI4hq311KrFJNaWTwRZxbnHs/epg0T4gRAfFYANJ/PBn4fzzl24or03SEkbdWWcQ3NC5c
	LhJUQ1penkYHHNNq0NaM8Wk3bTaW/yzK0TubOC8y1g0WP9u10tZpygHsaSehqeaL+FnWHsebpBp
	/fsZl5dUPieBsHAAubhN2Anotg64P898ZsvF2T5ApRQ2555mgGLPVnW3RHOgSKPGScGeQCU9IxF
	iw7rmzRmwrOeMci9fmZiphrDJx/1fBPZo2wID+QPmMFzsHtMp4WKPzkWHhNDat/axg==
X-Received: by 2002:a05:6e02:18c8:b0:3df:3ab2:cc7c with SMTP id e9e14a558f8ab-3e282e2ad3fmr59716195ab.13.1752761405242;
        Thu, 17 Jul 2025 07:10:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwHhw4sdYXg/rxc0xk2whzgzOEpVwWmRJcX6HXtNCTGUO9L3yjAp/57Q94d0ey9RuG/gR99Q==
X-Received: by 2002:a05:6e02:18c8:b0:3df:3ab2:cc7c with SMTP id e9e14a558f8ab-3e282e2ad3fmr59715725ab.13.1752761404826;
        Thu, 17 Jul 2025 07:10:04 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c4dsm1391452366b.19.2025.07.17.07.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:10:03 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] gpio: virtio: Fix config space reading.
Date: Thu, 17 Jul 2025 16:09:09 +0200
Message-ID: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNCBTYWx0ZWRfXwnv7R2SYcHjB
 hLw9ztQXDm7LX+JjQwM320sL0W9NKAFwSpHKWQFy6yREKVOTqWnlgs8NGGyC5WfP1icbkxNXLXF
 bBG/3rWRnAufqo3oFHvx7timZXF0eYdlaY98Iuhsu/qPBeo+G7/iSUsSWd6wPZ6FPo/pZstgjwM
 JWNyx6P7Nq247UMiTtmkkwnUx41BwRBa948dMUGlI4FDkuuNhFtbcZiERbUNxLe8c3y4EnaEIrm
 SuFGpmyNzDBVXKjmgVRaGlbDBn2++d1//3b7u45mfgi8IlxUUi+kZ1eGt2Z5eGRcUSHROE6uuVO
 xDlNYOv2UN24EcxfpZNpZ7iHO7ZELRL+I4lh8DoeQYrLL4Ns9PWtI6SZqXEHyD/rfc7LNZEOxUQ
 MPkDaGVQtG3m+n29UfJsPpR6iPonpd0ZhpK5SOONCkDQaCKq0hbP8ZGbtJPILKu0hEvMxcBn
X-Proofpoint-GUID: CJJqmEodLBTFJsJnhl3cQxwDanUTmjep
X-Proofpoint-ORIG-GUID: CJJqmEodLBTFJsJnhl3cQxwDanUTmjep
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68790443 cx=c_pps
 a=WjJghted8nQMc6PJgwfwjA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=OcK3cvsEmbn26l3-tBAA:9 a=CtjknkDrmJZAHT7xvMyn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=834 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170124

The Virtio GPIO Linux driver reads the configuration space in a way not
conformant with the virtio specification. The hypervisor we are using is
strict in what it accepts so the current behavior causes a problem.

Builds on top of gpio/for-next, tested on Linux v6.5.7.
