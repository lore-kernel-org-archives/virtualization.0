Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3B320CA0
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Sep 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832828; cv=none; b=rljwQKXhKmBq0GVCrJnAvFw+CArzLbfunW6T/6iKC9wVZZ4a5xATcXtmvqYY5ZAeHqkP9omF9+LQw8wQdc5SyYvd9goNFuKUpOKfKlo48OnNSEKlkorgxn3eTc4osyvchmg+e7BTgKdyPPFqojtIldIYqvX4koCiALW/PmQVUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832828; c=relaxed/simple;
	bh=SIeqemmlWZjtTDFt63QTgsr6TSr3ywAaj+98hdV61Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVWMf+dUa1bBIfiI0ZdQKUyFvn/RtbQBhSSrcXa4dma4E7if+OuIcKq/8kRcjB4RYJ17JjvEszUs+VGgc2FDo8rBC3GEhN74cb+Z1AH1ZeDMN6tetgTGgzEt26kLCcBo7ZY/nYdVXOWci53y7Xz0jU91fxbNvp7YYsadmNzCbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LoQqkchV; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LoQqkchV"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B525181467
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Sep 2025 17:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.391
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ukmOklFetyP for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Sep 2025 17:07:06 +0000 (UTC)
X-Greylist: delayed 4341 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 02 Sep 2025 17:07:05 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D251881489
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D251881489
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LoQqkchV
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=harald.mommer@oss.qualcomm.com; receiver=<UNKNOWN> 
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D251881489
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Sep 2025 17:07:05 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqAos023409
	for <virtualization@lists.linux-foundation.org>; Tue, 2 Sep 2025 15:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H0/NKsmoyFLkbDVaC3DDw/RfCF+8mLvmzVh8l0oPx0M=; b=LoQqkchVSHE33PUd
	SkEU4hr3knPdoC293lQKOh6/2FHCILPARZK9yLo+VLMnsRuHb0QPvKmFJs9OHycF
	sTsBJciI/6+hfPLy5o7uIGM7wIPHbzWDiP2Ddr0/KJfPDYRNRTFvPlo/KCNguyQj
	p3N4VxH6D9knhtEDiZt2QRI/EDtRjsKfMCmiQYF4cDcLkUPFjAXwzWKvg+MXsLVU
	2BC51rRZpu+I6TneQ6EOfCCeL9+Gsp/mtUJ0D7C1t5Svafe6nS4oV7yW57xNg05T
	8G7ziW473qIKOkjdBVNY20FsMDiDgCDA8fOdgZIeFMScTa3Zv4jYFNrbJpGpvHQt
	KuFfrA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp8hgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux-foundation.org>; Tue, 02 Sep 2025 15:54:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70deedd1deaso94094976d6.0
        for <virtualization@lists.linux-foundation.org>; Tue, 02 Sep 2025 08:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828482; x=1757433282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0/NKsmoyFLkbDVaC3DDw/RfCF+8mLvmzVh8l0oPx0M=;
        b=B2KJBkwFZ7H6kEnMwTlrQTKu9yKAKz9VGnZ1flKQX4Z4sFKWiqoJIw6Rqyp6urqJoB
         LoTR2KOIUAmyP/siSIQnG9I4lG/81wcAhj2Pbdig+psRitXeo+2PZqWiu11VAJ3RRCl1
         X3iQ5NQRqtRnj89OpNcTCWCkIN1H2MOjAeDvSUjAJ4hYBKmpE6rwmnOzPX+DZ16qB/oI
         Am7T6WrsIW/WCqKrVK5Kvj21Lt6QTUugI2is2voYcg02FPRugHSGkclyewhmjQ2Vl8y+
         HTNAErq8kl6S5q77EXMFtTzSIxLd7GpiuW4Q/fhAKrx+clSplFdkxXr20sAkWeJNvbvb
         +2fA==
X-Forwarded-Encrypted: i=1; AJvYcCXyYWqcNAiDmGwE08fpIs+E/8ptk8I/DM4H8TRZ/m7yfBz6Tmn+133lGYfM3TKZjZEXIsmG6DyVv5+NP7PHlg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YybQ5oHDdNxiqOmDdfOK0vHt29B6GzcA3QYkS0IFPibBhfrLAn/
	iV0nxWYfFgyNRGKPTGErmtMOkHbPMdICi0dDTttboZrOo20iRZNNXm2f9gu0vCDaq8Q45ubwosa
	IvzjS+75dpZz+wcy/Cf3GNZ3UE9BFjBBcV5qFlgnj5PdaInUSXP8tUvC/GssASOpJTzGNbrObfd
	R+r1jJRZkn
X-Gm-Gg: ASbGncswCYkrglH7WQsisW5qCcNbwTSoxU1ohFcrlezjQmvLOjepMhKbp6GSlJQdVBn
	BYFtGUucRkLgJ/XxnZJdCGfodhi2pS3i7OjGiPULNrGNIKfwMc2VuMuWeepL52OeHCcj1u9YBA3
	owDUepdqyeCP88xXplT3z/RpXUWJcl+UtmCZhU3FFboYp2UsWyiMZ0Nl0QJYHwws8IGHHhVsAjz
	tOMegyblDF6kO8lSUUi5lRbrT0mLxmHqe4RSU78NTN5GqgQiBmbjCTNYlz0PaBj7d+n+SnZNVgy
	na/7qYo4XA8TV5BCV2KT613rfHq/sBzyKDs8HUQ5kkZASaUKfiIBww==
X-Received: by 2002:a05:6214:20cf:b0:70d:f719:df3a with SMTP id 6a1803df08f44-7209d44bc7emr31784546d6.61.1756828481831;
        Tue, 02 Sep 2025 08:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESgAsgiQPlE4blyzeowkiKWqxqSOmSkJn6p3dseobdu0TaIys417DbFV6epXYxdrrnD1xuNQ==
X-Received: by 2002:a05:6214:20cf:b0:70d:f719:df3a with SMTP id 6a1803df08f44-7209d44bc7emr31784226d6.61.1756828481321;
        Tue, 02 Sep 2025 08:54:41 -0700 (PDT)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61d330f9f39sm6782677a12.14.2025.09.02.08.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:54:40 -0700 (PDT)
Message-ID: <be8961be-2964-4571-9818-b5a23867b27e@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 17:54:39 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Haixu Cui <quic_haixcui@quicinc.com>
Cc: quic_msavaliy@quicinc.com, broonie@kernel.org, virtio-dev@lists.linux.dev,
        viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdanton@sina.com,
        qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
        quic_ztu@quicinc.com, virtualization@lists.linux-foundation.org
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TJgz8yd5QEOCogu1mn_Ti8up7rOYz_dJ
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b71342 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=zryznllHkYnWp0Pe4IwA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: TJgz8yd5QEOCogu1mn_Ti8up7rOYz_dJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX01WRqqQGdf9p
 lcMMiaSyvLUDDYSxhOFjwYkPT/QpDgXPv3yL7e2dp4k4O4D8CKEJXEbX9ivRz4ZJzCVpcH8gQv0
 uUDWN2ZLPQwDywO//TTGF7agzbvgMLnMN1Z5cEyF5GcWcwMXkDQuCzEDG3eWXS/DFoC4kaD+SBv
 DYK9Bc+osc9Tm+V6rGZlzcI73ZZ/aVIwjc+LJ8yR5vIeKJ1ekx9uoKiWQY9P4/S+xDWU+mf5qMg
 xGy4OlQ2Mlv0o/qmMjpJfhX5e6U1p+XWZO5vsqdXyFur2SiLzguN/m0km4jgD+T8FSoly3qfaHR
 uQBYTW4+zOQlYNrNptsnFCFyD/7qPHYewyQSW4L8j1aUz6bP78Hg0qN5hqOgUYJGEX78V3KAFlb
 +UVZZ51c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Hello,

On 9/1/25 14:07, Andy Shevchenko wrote:
> On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
>> This is the virtio SPI Linux kernel driver.
> 
> ...
> 
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/stddef.h>
> 
> A lot of headers are still missing. See below.

The driver should compile with the set of included headers.

> 
> ...
> 
> 
>> +struct virtio_spi_priv {
>> +	/* The virtio device we're associated with */
>> +	struct virtio_device *vdev;
>> +	/* Pointer to the virtqueue */
>> +	struct virtqueue *vq;
>> +	/* Copy of config space mode_func_supported */
>> +	u32 mode_func_supported;
> 
> uXX (in particular u32) is defined in types.h.
> 
>> +	/* Copy of config space max_freq_hz */
>> +	u32 max_freq_hz;
>> +};

u32 is for sure defined in types.h. But looking into another device (gpio-virtio.c) I see that there is also u8 and u32 used and I don't see that there types.h is included directly in the C file. It must be included indirectly as the driver compiles. Same happens here.

I'm not aware of a requirement in the style guide for the Linux kernel that all used headers have to be included directly in the C file but this does not mean that such a requirement does not exist. Can anyone point my nose on it?

Regards
Harald Mommer

