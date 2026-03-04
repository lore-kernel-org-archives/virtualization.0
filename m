Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485C390228
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613852; cv=none; b=YlIBqx4P5P8f8fzcTIsj/ZLjTEOpPTKXcVyr1RyyEv3+ejjk+6w24LRfiZKh2BCnPZhJucucZxO7aYUDZ2aXRjSmtYbuFNdQjlHWF3y1AHN4DInhFWO9nTNuUmKqQmVYne0wZ5relS4pl+NJMJP5EgirA0X++yAkMDNGP3EV1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613852; c=relaxed/simple;
	bh=A4hVQa4Ck15Gxh0A8DRKmYnt2BE+A/oq+1oyfVx6EaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt8gmjp51Iy0f9h03N4FTrynUjWTv1XnbW73yjNfEDpWXdMCz8WI9+KJJCsKN7CvDzYrA2cOxyPUKiNGJVUIoAHoaItNwvoBs/Iq2Rd1lDcWpUx3aYUhJdDOKnIyMf2Q8iOF5PM+CEjM67iJpWroxLIRjjk2y1NgP5YjXBkZm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UomrPyVX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GwwW1Jid; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UomrPyVX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GwwW1Jid"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SOCk1421894
	for <virtualization@lists.linux.dev>; Wed, 4 Mar 2026 08:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A4hVQa4Ck15Gxh0A8DRKmYnt
	2BE+A/oq+1oyfVx6EaY=; b=UomrPyVX6Vj4jQd4L8JKq8WdlHJbzwgN5kLFyUyb
	O4aj8QK9JigxGnLhJKpV5nX0udO4u9YnLWT/9MXQQg1eAcDIicjDy1vKuZLien/d
	qbjKCndKoTGoqxEQLvfulbwLf6fASgpdXcJZ3krVrgtabQg2doE/qnKFwcVWJugo
	53PeEKsxBlLzI4cOdg5zRziUUULuG1rozQfVfF1WBD5HEOIzU3TkbSCGYnrGRVyX
	xOOGgCZNE94hfQxkEyBf0a3PIxZCJF7Dhv57Qt/sIPjLshN1RjVOyAspJcSa+Tl+
	D5GlBO0U7GgzrROeN5jS51sEeGbAiWtYDd+uMPxuzLkAUA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpe8u0pce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 04 Mar 2026 08:44:08 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c393cc9aso34962383a34.0
        for <virtualization@lists.linux.dev>; Wed, 04 Mar 2026 00:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772613848; x=1773218648; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4hVQa4Ck15Gxh0A8DRKmYnt2BE+A/oq+1oyfVx6EaY=;
        b=GwwW1JidbrFeXbbpAAa+Sjkh4SCq6Bk3vcn+Wn4JckWFy3uuY0Z5lUixzYSXl/S0bY
         dsW5i0Lu2CuRds3D6TVmJHSXCbubhzQxxzOx34SPqVsDb/MUvE1Aw3cV7FLC8pRcesTz
         N5A45d15nU3kkpW/WVcSj6m4qe3CvSuOrnc/D4LdZaFLuwGlPahwjKHfMMAdiqOlxqSp
         CTbTYAd4B7cNpgnpn60t1tNG7PIm0QTD+daBvx/8Sm3aZ9jldDkfArH1nBKighnpx9WR
         ZzjCNFefuSRPSjkQrGRUl/YOva6w9psrVJgn6YdBpkGXeKVSj5oslBbyy5BnxemK8yMJ
         3TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613848; x=1773218648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4hVQa4Ck15Gxh0A8DRKmYnt2BE+A/oq+1oyfVx6EaY=;
        b=S1867938r4l3fveu6f2QyyFzc3xexiYQpOypZNI9x/XaD9w/gbuk0fUOdKPOLF3xWS
         lO0wFyCW3Dh4OnZ5qbBxLsc1cyZPlXX6WSZ0Lpjr/Yo/GqhC/TgIo1R6YjJyinsVb3GY
         6hop/AINx7jjUDBMiu/OGxLOdNZR1lpOAVkDM1r2S2oXdp56IbwI8o4r9jjXcDFeU4zF
         ds0y3s26aArP4VmLdWalyaf/P38i/XoMzCdHmfed5OuI1Oblv3FfYZ+c+pfHDwKAyYKm
         RBMMb86C5NCEyIv1Gk0vnLxbpKbIZY+19U6aKJPT8mlREygx6WFgphy0lSVNcbQt1J5B
         VT5w==
X-Forwarded-Encrypted: i=1; AJvYcCVZVU3aPQ2deKcqJTHLr0KG+Yn3rdIcnGxzeJftQwSaFPW6lKNtk7lrUGFcBbcZy5+ccqFZmqjVMx/2JZzyvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSs8m6sigKF4N6SwoegKvEPDmLK9oROWRLA23o2eGM0zrTDnE0
	f6eO/AlrSelrdt+wgOogXuSaDz/wH+LT1AEz+ynaZnR9Ns3oDAiKVPAI29ERXu7s9qVPd1QAC72
	edHisMdNgE2TB+1DktVMwFEEm//vhcAwM+yr1JOFhJsAiP8p88gwyELa3N+vwBUlsnxQA6Q==
X-Gm-Gg: ATEYQzzYjKxBuoQEKUsqKiBcRIHE10iBnxACcbX8IK12I7PKqSTsNFQf27On0c+IyUE
	sLsoteiF4ph/oHCTfs7Uq0JL0wjAyj7lnZ9SiX8ZgX/0VVfi78pDS2iDHlZ4w0uEDcnG6z/5C6M
	zJuMs5iRcv3ZLBmLzxdnSLXISzEv0W1TUDmqQnWvmZyFfjItVTif9GKu222GyiYRQYIew74B3Q1
	Q7zEfYg0AnX9h5tKh8FoV4xqrfQ8pxQlnD5a7zNTM143CGD3dFP9+eo3ibG0KkTBeqeaIeBRnoY
	fezgSREcu7Puew4SYUr9WqBSs7oNocRGhWh9Pw2vV0IJQ1EReIrcnJUBjoZUFrLPvSwH7NxDGmp
	Ksm06NdiULL1Ujz/sRyXsv0bGgMHiEu9d+8eknOx/c3hszkp9gRIqwW7rYi1MN3x1IPEj7LkUmX
	zywTpc
X-Received: by 2002:a05:6830:3901:b0:7d4:96c3:3f8b with SMTP id 46e09a7af769-7d6c7f5d9c6mr844968a34.8.1772613848091;
        Wed, 04 Mar 2026 00:44:08 -0800 (PST)
X-Received: by 2002:a05:6830:3901:b0:7d4:96c3:3f8b with SMTP id 46e09a7af769-7d6c7f5d9c6mr844945a34.8.1772613847716;
        Wed, 04 Mar 2026 00:44:07 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm14945895a34.16.2026.03.04.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:44:07 -0800 (PST)
Date: Wed, 4 Mar 2026 00:44:04 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: mst@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 5/5] mm/page_reporting: change page_reporting_order to
 PAGE_REPORTING_ORDER_UNSPECIFIED
Message-ID: <aafw1FO6pFe8p5mm@hu-ysakshit-lv.qualcomm.com>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260303113032.3008371-6-yuvraj.sakshith@oss.qualcomm.com>
 <849233d2-9d40-4d67-965d-262153d15d07@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849233d2-9d40-4d67-965d-262153d15d07@kernel.org>
X-Proofpoint-ORIG-GUID: N4uguWE16jLWdmqNl9DdXxheXceKd0X6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NiBTYWx0ZWRfX231JgMPQiySw
 WOU25s+Lqc1ri+a6yVwoMLGkDS5K77ILEjcyuUuciImWOxY8brIo+r9UlHMph3T9DppfyGgqbhI
 gX/94cC/xaw9fXDf4KPiXar8rTB4lD3XHvs6UTcmxQF7hQnz7GuIvae3TALqvgSLFBKwWWjOr9m
 sqSzWDn7au3x0jPoPlzp8poyU7ofGH6aI7m70hg4Qn2hQIj7TxVXl+OClZhWkIdWwkJPzdyf9J5
 15Z6Spur+xDUopNmKCXnNzg0Cw2oiwHkYAVrAluWZVqyTxNcQM1jhHwokK+Z6cIbbxIaTDzDoxs
 GVXwPRUbzIgwbiknc9Mf2EXEnSHDJs6e4DAxe6te9oFKtoyGa5o3fM1Wf10WtG83U81xRh3hs8O
 Y0iPYBEHWP2LBxe9VR3a/ZsLmWrlTEfsZpcFb0fvxFKFpYZp/MRrRrLjxP988mc3gNSQVcOtWVS
 LGXPJXI8JayHIfB5IDA==
X-Authority-Analysis: v=2.4 cv=FpAIPmrq c=1 sm=1 tr=0 ts=69a7f0d8 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ciUuy_i2Sbo4mXWE2mcA:9 a=CjuIK1q_8ugA:10
 a=PG_jTqMH23MA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: N4uguWE16jLWdmqNl9DdXxheXceKd0X6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040066

On Tue, Mar 03, 2026 at 03:59:10PM +0100, David Hildenbrand (Arm) wrote:
> On 3/3/26 12:30, Yuvraj Sakshith wrote:
> > Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Sweet. Thanks for the review, David.

Yuvraj
