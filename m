Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79538F63D
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445012; cv=none; b=skNn070DWwHVc02fUwIVli59Oa2wc211q+rwUYO2Qb79LX8qj5iWBc+USWxOdUXbNhAEs0rRX030O0Kza2lk8vG1J4nZX8FDIxcSM0Y8dZDbo1VA4+kLmw25S9ko3pqiCkxNQVSr1rF373r/XdPIbT80uk+5jyu6rIJ7+eq+F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445012; c=relaxed/simple;
	bh=40qwCnqz+wEjM/IhhB5z6vQ43MV8x6Zl2HZJnHwNqcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcx+iyjnVhXugHrJdxc0Z2ACHXdpue6OO1Xgo37D0C7h2TcSO42GRz9ZUVxa/MA7JuotmjTv1ThJRpKhKxegAKZJV5AQbxvWhxRmprAPlluRlWBUEVlV7QOAqqs7LjvmSG4GqC1E9W4iN919cRBFacJYQyDCnqEWWJUC5a8yCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIzRQTqF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X5DliH6L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIzRQTqF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X5DliH6L"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62288QTd3223966
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 09:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QRKxM/P9l/2Z1hR6WxyeRaZQ
	55JcQ9u9VYXCLMJIR1U=; b=OIzRQTqFJipxKuT+C6DHeqrfvDJYYRPlB/CM+r1w
	6T6L55qjSbNMz9tX0sQdtFbked9kH0Q1OSGmoeskImmKnZvdLAhehs50qRTihjwP
	jsUcf9dniYuepWQIeWEc/pdLT94X2mrrOP6TRIg1T6CIzzm3w7EwgW1NELDImI2U
	wlNUc1krHXfqFLMkIZ1hSGwNc+FIHN/2kvvwi/fQ3b7HHN0j8TIr8VIgwWPjr/uN
	BXuT5dnhDVwtD9/5mGcm8E9TbpgfdkQLiTD7nIZlMF5JKxj3qRZw7Xicpz2y1t6l
	vowH+8dS/EKVvpvJ75MdqGY1zJDQCKLfUOZqaiZn38Bi8Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn0b1hmnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 09:50:09 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-463967f3573so19923860b6e.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 01:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772445009; x=1773049809; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRKxM/P9l/2Z1hR6WxyeRaZQ55JcQ9u9VYXCLMJIR1U=;
        b=X5DliH6LuPD769ZIXqRVD6oBxcqqHcD7MYVVcPrIc7hVZj2GUAP4CRfZ9kltQtjq2H
         gFeT4RxghxLR5eVNVr4LFm5lgqinOCOArCyo+sYfleY3f5Ho9BsIvxnt4BGZqwALH3/z
         9nddNcQdruoU7cSK7Hal3FCMEjlRgbCZDk9pQUzw3V5AsBB60KwNH7jkSWMFMPRg5Sig
         VBilnvsg9/dROBeswjdeBfwXbf0W2VQ5SljDi7ATV0H209VsVlp+dOf2RdVDk29TWg6P
         VjEzy2dQPqiq5j49Abkl77bJ4ICeWags92kJFVhwAjDI5bhrP5IZz4N1j57sZqPwoGBl
         bmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445009; x=1773049809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRKxM/P9l/2Z1hR6WxyeRaZQ55JcQ9u9VYXCLMJIR1U=;
        b=AezWHfxL2orByjBxN+iG4UAJdRPsPJTOyFDWRDE+VnXP4fA1b804AtHAbyjMS2FJiS
         f1JEk7gtJS76BVjXDRidrWQpk4WX9MDdTzEx9QWyQSNxSv4E88jV+LYnm90HRiLLHEqF
         AsOO88P2NvVOQvySpHzc1DfjoldsNALnEaJ+1Ex6ykfRcMSHfVBQ108dk1yQZXlc7kp9
         ij6xMcAnMOYt0SiCzhLH9GXZe4tuXvyegXM6diHy0G1j4Bk8EWgbjnvpAy7Ke0jIbYTx
         tmZL5SEChPnIEwOLW6F3Y3FI78vm8wpeCxDJw0Je839GjNl8M9O1qeaZA27p4mMekvRl
         7fJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLi0UvYzQjunwY4Cexwv2CrMiiPt7V93ahhaq0qUg/d57zUSIF77NqMNhNX9VVr2tOfs17gyvPYzO0JzC62g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlmcbelXD9C+SihV0XEnERdyqOrSAAGohXlWXgyDvEJA+suQw+
	CaRAn68RKTTUsSQV8PHz/g98LLxc+haiBg6XhSPV7kb3wPXcRLJRqcX7UHdr0PAVYzG9cxet8SD
	WyTPsArZHNio5zzUp5tVnEAYO5SpQptzLIC7eo0dlzBp1/ieg8CD6fcuQoFb8UajT7UMcaA==
X-Gm-Gg: ATEYQzy+i52dUti92W3YtML7xI9YQRasvbwXt2bDgegiw2huOfy5hRaU6hoGCZSsJ12
	IwL+lEWQysjc5mh27d+bw8H6DBeDRl5n5xT4Pui0Yh2JnrF2cYBnfIGM/5nxUYlCG1/gs9WruAi
	P8YV3H87prIiYCHbKzz0UwNMdoWb72czadCof19ZHi+q/JsNUAcfYr8fX11L+7f3yUBqeRKLK86
	pq/ZdmANHKbqO5rM3n+Io5L2KxHLjRvJCwEwIiCNZQosrTFc0MJxeWOXPF/zgB8SWJi3txChk6j
	2n1p4Jcw4yumoHwLU/Poh1iC2KWS1K6hDgKljhw4XOzVJg3MPF/KitrALVvkz1So9SV6Z1Euhnu
	t/sjDlIaXGeMIQANEgH7SaDhvk5NS5bWJs/Yq0bM7rTv9Wy4l9vz+Uw+VAl+FPQSxSn+y4/Q4Ww
	7OiI/W
X-Received: by 2002:a05:6808:1705:b0:450:b7a0:41ca with SMTP id 5614622812f47-464beceb57cmr5117092b6e.22.1772445008439;
        Mon, 02 Mar 2026 01:50:08 -0800 (PST)
X-Received: by 2002:a05:6808:1705:b0:450:b7a0:41ca with SMTP id 5614622812f47-464beceb57cmr5117069b6e.22.1772445007942;
        Mon, 02 Mar 2026 01:50:07 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59be78sm7391540b6e.13.2026.03.02.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:50:07 -0800 (PST)
Date: Mon, 2 Mar 2026 01:50:04 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "longli@microsoft.com" <longli@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "jackmanb@google.com" <jackmanb@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] page_reporting: change
 PAGE_REPORTING_DEFAULT_ORDER to -1
Message-ID: <aaVdTM3ubiDa2ELR@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
 <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
 <SN6PR02MB4157D37B3D254251F0135B04D47EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
 <aaVDiwEPl5t2UPX4@hu-ysakshit-lv.qualcomm.com>
 <a0133403-8ce3-45a4-987f-96fb7421f920@kernel.org>
 <aaVQXbllLVBLZCwQ@hu-ysakshit-lv.qualcomm.com>
 <571547b0-007a-4cf9-be1d-95a0ef871cf8@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571547b0-007a-4cf9-be1d-95a0ef871cf8@kernel.org>
X-Proofpoint-GUID: LZBQPtVSgKA3aUGxvEcq0ajbHZXglUDo
X-Authority-Analysis: v=2.4 cv=Hol72kTS c=1 sm=1 tr=0 ts=69a55d51 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=0mXQa5sO9039VI3KVg8A:9 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: LZBQPtVSgKA3aUGxvEcq0ajbHZXglUDo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4MSBTYWx0ZWRfX69wm4oojpe6y
 PZgUbGEW2KLmagqs7y3dvmXqrOfp0BsZcLGy+HyJ6b0ilWKfur9x5UDlPVACfFhAXqvO88/ID/s
 tounzV3ONUGdkqRxNKwFtzRx3UhVGy6xTOCp9x2D+62NzfgqEU2et2dPsw4S75PlJuXfJ2FjIMy
 z+Rjzpxhtu1cNk+MJ1PZVmmbo7QOEYtjMKARNEGYqGwlPSPoAjNKRj7ozrYKXGK0ftl3TIc3Xux
 MYlsNlBPgdcRGalGKqXSrSF1Om0GrCk67wz3nJwIP99uWbYKDVvfUyjcPkpO/dXMMwvhz1tYknT
 vko4O+DHxWU5XX/l25bbwgu6Z+tv6aRdNQ3h/hSY+diVKu9SOZsNHibNsRkNpt2xZrQiuPtVJ63
 EQm6HNWgMH9MiIsmNTDkol6T5J3dMeSiCoSSVtz4Ht+p7xEbRvDcVeicmKppyVvdhw9ZqG3sOFv
 iQ1oZgmhcE/ZQW+59pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020081

On Mon, Mar 02, 2026 at 10:18:23AM +0100, David Hildenbrand (Arm) wrote:
> > Great. Much more clearer on page_reporting.c 's end. 
> > 
> > Don't you think on the driver's end:
> > 
> > prdev->order = PAGE_REPORTING_USE_DEFAULT; looks clearer? As compared to:
> > prdev->order = PAGE_REPORTING_ORDER_UNSET; ?
> > 
> > I'm thinking, why would a driver worry about page_reporting_order being set/unset?
> 
> Maybe PAGE_REPORTING_ORDER_UNSPECIFIED ?
> 
> In any case, we should use a single flag for this. Everything else will
> be confusing once drivers could use only one of them.
> 
> -- 
> Cheers,
> 
> David

Sounds good. Thanks for the suggestion.

Thanks,
Yuvraj
