Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7231280C
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450282; cv=none; b=eSBSJVT4QRFv+X8IiHxaoO6fIWif7fTkdigii4A5KFQ9E1vHTtFAe5fD9UvmYbPZ6OAJWBNaOBbYHJyF7ZwKH2iPfZwIzabzvZKgh056VS5+aErxOsV9aU4uba4opSsNT10BQmV8Se9n72jibN6i7AQrdU5tRXNRQ3JSlb4NcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450282; c=relaxed/simple;
	bh=gekinlAEc/Z/E4mHPXrII3Zgs20MXts8dOrdEmKT+vg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cll1rVsBuN+YZKosamsNRcunE+NDi8hzfz0w/3Dvn6Lj7bt8b19C5t8UZTNQX81kL/RHOPJRfw4u9ngUI5Zw7F+wf3ZeIlrtJV6EZIvFce/fgitH+EPuM+f2kZzYvi3qm9d/dEOdAo4iEAQVCqo8DvVJpMljiGPkosQwIJW/bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MHRcXxNn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U2Met+I2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MHRcXxNn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U2Met+I2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294WYc3752703
	for <virtualization@lists.linux.dev>; Mon, 2 Mar 2026 11:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/iFgusvo1aPKir8ugITOqUipqQuZUj6mnHU
	5x4L5Mi4=; b=MHRcXxNnbz5GIKwWQYVoaNUziQJIm1paESYHmUwIp8XM8ZrTtZQ
	kcWU5RPnyN+J/lK8HEO4xggNDAX87YEtX+uyGAs+gzkW4c0y660oCog5baGTwhwL
	/+nBuWpu2Sxgv1D99xyf0mQgaJiwF3slKBh2Qu9t/GvSWSUmHrout4pmtuUKjsjt
	/CKjluajet6WGWMAaPMLcnWZrcuEpKzXCek0kna0xqpSKnm5wH16juvw7rMIehIR
	0KJ8oYt3tpIdqqB5yF3QVZNFVTrl2fS3fLFogoOoZz7dDz5baYaTEL8LIN2WvABr
	s0TfoEpl7QRHAEkWKwHTe+IMzQkw/PX/z4Q==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7kq8fss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 11:18:00 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463a018f61bso22623232b6e.3
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450280; x=1773055080; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iFgusvo1aPKir8ugITOqUipqQuZUj6mnHU5x4L5Mi4=;
        b=U2Met+I2swAsV/G3zSGfArX4Alw9VzI6rRIEiEsokldTkzWWAkVvKDX2Gd0bd23wSX
         EtOC1L4TzyYPYbl74NDoxsVbT4Y/x4LofbPaifR6Pep5zV2QwpvJ/YIZOf6Cpqu6AMcA
         HmHiLkOFixYOzxgYGS62irnFzoKVD071jsh/08JY+oC9wUsMz2+4gYACMRaxWh2LYFBZ
         HQ1fbLew0QdQv4A+maVvDrTG5goeuQTW0LTfQBiiRXWAhlIZHFYoeDpAgbXW8jUWgRUN
         0nraF7KIzpZu6yLDzez6w1Oub4f1YztRRtF8OgSrUE7/xVA02go1N55h7jDKuzIkozl6
         EoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450280; x=1773055080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iFgusvo1aPKir8ugITOqUipqQuZUj6mnHU5x4L5Mi4=;
        b=hNx5GcD/pJRqV+gizeeFrIxwL4WnSk6Brj+wlUST9lkWRcbLJxIuYUrCFOr5xpMSIn
         XigrjAVhs1k/noA+WcqAflCYrO/TM8JXR7J13FqqNtpKwX9U3NiJu01ECxYAzUP3EAOb
         iQN+uSZavtIEAIn7/CktLxZHl/+XYGwXEc94pi6+S+wfwQEvpUq2xY7oeeZv2Wl1nehF
         sB8wy6+bqYBO2AmjaxFTOVzGruT/KwvJGbITq6fOLNcXCyvUBNuQ18UKxXbYuS3rPwl9
         Pj9Fe6KR9t2tbu2ChriIExXebu6J6lcFu/a8V0XS2zLmuHv3PtgRAkTO/QRC/eZaNIVy
         DSXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTUUSrju3jEDkwELe+0NOjtfCK+qdMEGDR1vN32vzVTmepLMquPJ5g/dsxE3ktlI6u2VQtHjEj1Mm9rKkSdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYXrACEd2qRQL3G56bTgIHOr5b3CFK7370YE1Nnlenbs4HKywJ
	GZkWuWJqBQ04U+vSXNeOtieBcxhvAKvtGZyc1fRaR59YxXgBDtQGkWn/OKFx49Vp+Fzr38wuTjB
	XkLBoOGTTWhyrbmYPN7Ff/2rbA711YOLOPj8S/9VAZNqECednQv9vux87POAtqVsg3jxXyw==
X-Gm-Gg: ATEYQzy2p2/RiQvl6ie/T/vlcvgJymsYhv/auugit1A0A2AMUOBbV8Rhtc30hAB3MUx
	gyM5ygmqwXbwbxjh9Mok5oSqqC5hWz3bwt/GXayrK1STYIvNpuOMcrHbZk36cG2OWQbTLyh5JUe
	s2BOOA7L9P97dDKySBu8weQ+4vp0VGTb8tMvn/31SmoTMIKVbWe6lFSzbeUpnauV/1Lh8mpwg9m
	WkvKNAWAXDgvcSz3D0ngG8CAEILRk6XJkkefwDvwjrN9csnHBhChsR42+fVkGmEMPRQpgmreXlP
	0yGnbzyD66nMmuitg3kqj4fsMeoUqj+esQBnHsEDdPIK8bHcNjcb0Dd5JC8MTpUFiwa7Ms6cjWR
	FwQzuZfSVLSOyjJQpB/qqfttGX+fOXM2HEPoLJ3UtZvGeso7CQvRewqS9lUwnpId/u3D5BxVRy3
	78hAQZ
X-Received: by 2002:a05:6808:6c2:b0:462:d097:2467 with SMTP id 5614622812f47-464be972a89mr4750529b6e.7.1772450279938;
        Mon, 02 Mar 2026 03:17:59 -0800 (PST)
X-Received: by 2002:a05:6808:6c2:b0:462:d097:2467 with SMTP id 5614622812f47-464be972a89mr4750514b6e.7.1772450279537;
        Mon, 02 Mar 2026 03:17:59 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:17:59 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org,
        jasowang@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
Subject: [PATCH v2 0/4] Allow order zero pages in page reporting
Date: Mon,  2 Mar 2026 03:17:53 -0800
Message-Id: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YI6bIlnDI29qCFXmPa_qD8CO-ycjjZC5
X-Proofpoint-GUID: YI6bIlnDI29qCFXmPa_qD8CO-ycjjZC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfX/Y2ml+xi+v0h
 KgUvn3rlix+XK6gVaejc0IZtVmc9ySFFviEcSuNUKQogn+8476JnE76Sw0i8Q5NKWA6vMlsDGxk
 KNiwHZ6T10iPRiFsro+D3qlp9xOb05i0Ph+fuPWqoja7dJKaoupPlO51lwi+mijf++FbePC6wX9
 P4v0m0wfy0NP5x0ajv6bSd07QYqV2myugbVr2fWY5EVV7oYFbvqonFQkDSG6M3KjR1pG+81J5NH
 LGHfmS0xk6BgK2AW2YKzpoYu91dLffAQHrCxBavAyAenLGASA/ERqbZxkQkbkPodPcRDZ7Xf+pE
 OldD3hh/O/Kx/la9X+dT8n70mNsC9UOJrvVwbLvh7opc5wz4/60C2dfsjgT3jWIk+SovhR0cLCY
 tEI2/ffyQQUvkzWrReB0bqfWqvEjrkbYQSTFak5cAlDtSC8l7yzGRAVH/FGiFqK8HyEweWdslAQ
 hV8oOzb8xmgO3rqQymw==
X-Authority-Analysis: v=2.4 cv=GLkF0+NK c=1 sm=1 tr=0 ts=69a571e8 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=9ecvtSpfVrh-a2M179QA:9
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020093

Today, page reporting sets page_reporting_order in two ways:

(1) page_reporting.page_reporting_order cmdline parameter
(2) Driver can pass order while registering itself.

In both cases, order zero is ignored by free page reporting
because it is used to set page_reporting_order to a default
value, like MAX_PAGE_ORDER.

In some cases we might want page_reporting_order to be zero.

For instance, when virtio-balloon runs inside a guest with
tiny memory (say, 16MB), it might not be able to find a order 1 page
(or in the worst case order MAX_PAGE_ORDER page) after some uptime.
Page reporting should be able to return order zero pages back for
optimal memory relinquishment.

This patch changes the default fallback value from '0' to '-1' in
all possible clients of free page reporting (hv_balloon and
virtio-balloon) together with allowing '0' as a valid order in
page_reporting_register().

Changes in v1:
- Introduce PAGE_REPORTING_DEFAULT_ORDER macro (initially set to 0).
- Make use of new macro in drivers (hv_balloon and virtio-balloon)
	working with page reporting.
- Change PAGE_REPORTING_DEFAULT_ORDER to -1 as zero is a valid
	page order that can be requested.

Changes in v2:
- Better naming. Replace PAGE_REPORTING_DEFAULT_ORDER with
	PAGE_REPORTING_ORDER_UNSPECIFIED. This takes care of
	the situation where page reporting order is not specified
	in the commandline.
- Minor commit message changes.

Yuvraj Sakshith (4):
  mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
  virtio_balloon: set unspecified page reporting order
  hv_balloon: set unspecified page reporting order
  mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1

 drivers/hv/hv_balloon.c         | 2 +-
 drivers/virtio/virtio_balloon.c | 2 ++
 include/linux/page_reporting.h  | 1 +
 mm/page_reporting.c             | 7 ++++---
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1

