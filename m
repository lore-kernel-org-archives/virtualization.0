Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD919B3EE
	for <virtualization@lists.linux.dev>; Mon,  9 Dec 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787757; cv=none; b=Y/IJOAtam0kYHH4FgLwYJFMB4Qd1kec2wNCwsJSI8TvOCOXd5YFybJZWo3Nq6U+OToNqOuAdv+DxPUnq6uRzX7NO5gzSu3YAv9B8aaq6FSjeLhZXtK63ZzyZ0VD9wCHcjYjm4CZpM2ctsHguhm8Y+CYuq4qHglRgmvunxbr3o+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787757; c=relaxed/simple;
	bh=nimOTSL9Znrxib3tUb9L8vYX6gPSgfgZq9pRGBWeHhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YavVyNZ0CbLw/Sl0K1Q1LSYsEV2SOcoKo5iomAWUSq79boLWS1myqIUROSnv6sHWoxL2zhMOYEb5LbhLfbm/D7TmMOX+/T+/tvg8ybwdZWiLMSbv+khlNgsSqFnf7pWvY939b67SYIuoRmTRkjPENgD9a5FlHF3Z1HKd6ArifjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BUh5b7a6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BUh5b7a6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9E6nEJ006957
	for <virtualization@lists.linux.dev>; Mon, 9 Dec 2024 23:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjDjYNmyOQCEyuW9Wcn0o22htAiKyRiMSInFe9Mx5HM=; b=BUh5b7a6MnDoDe6k
	OEmrpdpGV+SKCMuKsV9eJ4InwLNHIsWagBL97IjYZ5fCq7OocOw4dAV7eKCLdYfq
	+6T5VrI2e8HJ8PWBvYVS4+rTh8XxB93++3WqkCmgM3s8FEoHcAIhA9g/wcrZGzin
	tUVgQ/GpwIPGmdjqjLgFoLgRijWDBlfBM006jfoXk/gcyAVxxAHtKaAN3xl6Sjy2
	VTNK3liSIGZ1FhvjDd/ruRWnD4atRn5vsA8LcxyaqrS5H2tk3VK1AGbFRaA3xSZz
	4SbN12TKaNa0j5DaXSXoezNZXefhUjH9yt+YWSW0V5qv921c90mTva3ZfV90Q+Lv
	//F48Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e21bhf4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 09 Dec 2024 23:42:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7fd48914d9bso1274546a12.2
        for <virtualization@lists.linux.dev>; Mon, 09 Dec 2024 15:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787754; x=1734392554;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjDjYNmyOQCEyuW9Wcn0o22htAiKyRiMSInFe9Mx5HM=;
        b=ToIz19UY6SpoWvPsz4cBDGvnWiyMb1CE/KT7j2x1k7lOBb/ob/RSi8lyidntp9hD0j
         KLlVZ0L6yoVzgS4kwVanzCXTJ6UCT0u07vT8yw8aPet62omnmidiOakmuV4OCiow/Hxt
         Bjf5nvuIYu9l5z2eFsO/4W5hyK4upIr2WaIbW1LCrDen0/bVqLmGQ9cR3wPAxJCUf50t
         Om9SjFOIKdLNEjFkiMJGYRjMTrVFjq2y8hvSj9HdCSJrEEETkdY/oBb87RGl2q7Rbb2M
         x9WrXnBKb7/+C2eiDzKfEa3Yk48ekUMZfIgjWYwjAvaK9VTENrBai51L6GzbFZrsDEUZ
         R1hA==
X-Forwarded-Encrypted: i=1; AJvYcCUJv3Eke+GqsvYi9PUfg8/QNjKjmiIo3827XkIe9aZjWHeFtUGdJ3bRDPqxKQcfLBMrnMNeXBCbtY3ZnxVqkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YykCafi4y25ViaygrOuZxhXZEC0/HpUxi5+mhlfLM1GvSoxLhnZ
	tFFXGV0WwRgF8UW5CkPNT1QdVTQzrt9PiP3y5HUAH5S6DgffOAEppvUbnjtAa4ly43kt91Eu878
	EvoznVWKf8/gEfUrdTSDt0aZziJiRM03FtlPzNHHSE6sQX5wDy0m0y9d93lz88xPlvw==
X-Gm-Gg: ASbGnct05KCr5werjFH5OQYaPvWNIEY+7lvOiKxy/kTW2Do7jVv87l1HPNhi5Jf3Fpx
	TK9OF/QbZiSmGrePEKztEE9qh+0JvRlbGgGU+CrknjlrwvR+iZMAzfjd7UDPP2ZzUDgY+9rLuUR
	XtGuFOFjb02Gmgo/bheyWTtYC13Vc475v5eUjBj9WbNsRIPecUjdydPtYg/luD677wi5mdgkjCg
	4YZLZVa9kdS8xT0JdQFKf3w9KgjaeOK2z51+WvMAvHaxTWus3hAXQ5V1obx1Umtcy3oCJVCYDVt
	sE5BDV7KpOYg718=
X-Received: by 2002:a17:903:1206:b0:20c:5533:36da with SMTP id d9443c01a7336-21614db26d0mr213662075ad.42.1733787754155;
        Mon, 09 Dec 2024 15:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL+hsnLEHYE+knt2cKrrAlXNVWaFMj8osQa0ggexhJ4SCwXZKtZ+f6KtDQjEKHmm2LNIcxoA==
X-Received: by 2002:a17:903:1206:b0:20c:5533:36da with SMTP id d9443c01a7336-21614db26d0mr213661755ad.42.1733787753794;
        Mon, 09 Dec 2024 15:42:33 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631117c6dsm42869045ad.158.2024.12.09.15.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:42:33 -0800 (PST)
Message-ID: <365f763b-5985-4dcd-a526-185aa49bf47d@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 15:42:32 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [virtio-dev] [RFC PATCH 1/1] VirtIO: Add platform bus driver for
 loopback virtio device
To: t.ampelikiotis@virtualopensystems.com, virtio-dev@lists.oasis-open.org
Cc: anna@virtualopensystems.com, a.rigo@virtualopensystems.com,
        m.paolino@virtualopensystems.com, s.raho@virtualopensystems.com,
        chou.kensou@jp.panasonic.com, wminer@linuxfoundation.org,
        jsmoeller@linuxfoundation.org, virtualization@lists.linux.dev,
        stefanha@redhat.com, xuanzhuo@linux.alibaba.com, sgarzare@redhat.com,
        jasowang@redhat.com
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
 <20241204153811.126028-2-t.ampelikiotis@virtualopensystems.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241204153811.126028-2-t.ampelikiotis@virtualopensystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6OGNuVR8dpXVJ2aY7NEiV9QD8l5I9PX8
X-Proofpoint-ORIG-GUID: 6OGNuVR8dpXVJ2aY7NEiV9QD8l5I9PX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090184

On 12/4/24 07:38, t.ampelikiotis@virtualopensystems.com wrote:
> From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> 
> This commit, is based on virtio MMIO driver, adds support
> for dynamic allocated (platform) virtio devices. This
> allows applications running in native environments to use
> virtio drivers as a HAL and eventually communicate with
> user-space drivers (implementing the vhost-user protocol).
> 
> Signed-off-by: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> ---
>  MAINTAINERS                                |  10 +
>  drivers/virtio/Kconfig                     |  20 +
>  drivers/virtio/Makefile                    |   2 +
>  drivers/virtio/virtio_loopback.c           | 780 +++++++++++++++++
>  drivers/virtio/virtio_loopback_transport.c | 924 +++++++++++++++++++++
>  include/uapi/linux/virtio_loopback.h       | 259 ++++++
>  6 files changed, 1995 insertions(+)
>  create mode 100644 drivers/virtio/virtio_loopback.c
>  create mode 100644 drivers/virtio/virtio_loopback_transport.c
>  create mode 100644 include/uapi/linux/virtio_loopback.h

...

> diff --git a/drivers/virtio/virtio_loopback.c b/drivers/virtio/virtio_loopback.c
> new file mode 100644
> index 000000000000..a3013f0e1109
> --- /dev/null
> +++ b/drivers/virtio/virtio_loopback.c
> @@ -0,0 +1,780 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Virtio loopback device driver
> + *
> + * Copyright 2022-2024 Virtual Open Systems SAS
> + *
> + * Authors:
> + *  Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> + *  Anna Panagopoulou <anna@virtualopensystems.com>
> + *  Alvise Rigo <a.rigo@virtualopensystems.com>
> + *
> + * This module allows virtio devices to be used in a non-virtualized
> + * environment, coupled with vhost-user device (user-space drivers).
> + *
> + * This module is responsible to assign the virtio-loopback transport driver
> + * to a group of virtio drivers in order to be able to share notifications and
> + * the vrings (without copies) with the corresponding vhost-user devices in
> + * the user-space.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) "virtio-loopback: " fmt
> +
> +/* Loopback header file */
> +#include <uapi/linux/virtio_loopback.h>
> +
> +/* Features */
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Not sure if this issue is applicable
to virtio, but if so, please add a MODULE_DESCRIPTION().

/jeff
