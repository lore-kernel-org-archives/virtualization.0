Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AC47D922
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537439; cv=none; b=MjcHngyQRoPN0HfdEYZsDdNG9yAafPaCUNGu/1B4WV60yZvEmaTUAuFGG5m3vC8B7WtzQchgrR1V6fF5xoLpNcs4vrjMUd+RJvuXgPzi3NIvk76u9pUto42fjsuA7G6AgZGE1TSH2V9vuf8oomZ1MYNUAh6FCdJYOwvCNK1zfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537439; c=relaxed/simple;
	bh=4D/io3APDupQGYCj9CFWT+uOecdkhDM/9ideWpjC7z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rtGQVU32v0f8UjMjBkn1Ung9OV+Ft6FLdFwyR2GWSuAHW0I4oBGksLTmj9ktSLsANXJPIMLeDl2QOo9uimEDJBzXS25DMMLsD/VyzVvnHLZzQ+903F3H4yE+7jjX4kmGazGN60+CgI0nEt/HwoQ89l1rxdVVMhMGMe3B+/yiQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ya2HduJ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BRdOcefL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ya2HduJ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BRdOcefL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239moHq2307603
	for <virtualization@lists.linux.dev>; Tue, 3 Mar 2026 11:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2jhEbYgGPpM9YgBi8KcAq9k2DT/kIdh5p+L
	NtRMjpwI=; b=Ya2HduJ196mEDx2M2W52dArVnBH9Llb1RLVi1QopdD9NKEKc02r
	dePOX4zFt3VO4YNGCZTkUH0ZtfyH8eQa1+YaoQ26BmFgHZmRqz0Il1BKoRwNPoVe
	G9sTv/gB+Bvejl+JXB7K+rqzWPb2ObULyTGyr4wLDAAhIzlJ63e2ikhoFbFs6WxM
	z4iiNVroxrU58YliLMLbttjy+YU+6IKiLLiQ5aVI87Efy1sz1HFKNuEoHrxZAkCE
	eNK7sUAey7UP0rojdxuF/ETuISVLyz56JBs23+s4UkK5wOpgRdl9ebBQPoEDF5fZ
	PCl+nwdoeVGIuhVhrHAKjGlB9nw3wH+yDbA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvtu8dwa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 11:30:35 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c1b2651fso28947325a34.3
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537435; x=1773142235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jhEbYgGPpM9YgBi8KcAq9k2DT/kIdh5p+LNtRMjpwI=;
        b=BRdOcefL/xqa0fP2VK6uyZodSPDWqJZlYZ3A2X+QA2y5KdPwXM7SZsyGWLYGfnH1qX
         FuQ+ngHdlpDVX5R0oPYD7KKjTj2TvncBGF04yCZ0GcmeWebSJFE6nExpHGOSd4sLH1P1
         5Pwfz9Df8Um7ZXky5zQPt/Q9A+NJ9WlGdH2Er416sCJ8BpmUCp+u2XTQ+h4avT5ylLDy
         XZwfezpUgQv+giCydxORYN/7RPhr6Rb5Kz24Si2sroLle1sQ8B/5Hh09rk5fYulWENc5
         731kMseWK+lUv6y3s4EQ28N7omfNuxa40GxRCDhWl6d1mS4WwXSxclZvQVqFvLxvyvW9
         9b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537435; x=1773142235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jhEbYgGPpM9YgBi8KcAq9k2DT/kIdh5p+LNtRMjpwI=;
        b=EygW8qOoqsY+v6+aoCwRo6lMesp8XgvFVC2XcnfsRRYkqgLfASLr1cbAHZkS3nKDcM
         mrpTBNyZ1wYs4BAzAeNSPY+z9JGWhuhgAMYSxEn1SzP0alEoSQBjmGdk2FTbEepMjNJg
         7gZFUZDHO5C5i+vxlUzYIr7VHer//InIaqEzOr9NM8HprrgfjqnCNoNpFFfzOgMDJBW7
         Ddmyrd+ZKNL5gLsNZnDdcMP3UQzyyAngagmrWuSV/nBX5F92VS7Z939r9j73CdQpSkme
         qL9aveEPSppTvwm+Z993fyavr4+dEHvSoQBtoggiNuc017Tl7qhZNuqg48NVniKddy+4
         jxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDMLsbwygSOvkp31oppZFczn35W5bH3q0MFmx6khN3tV2UPQe6Y8hX6EC0xHFgVx6ejGbbSI5UQhvFFg8vaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YysjnbJKW7hJTGixL2urSnKzx+ln4HqtqBGwTdW09eCu/2pJiLW
	Mryh4S99ed4n7vHwqj8mMXHegB8HZJENgJuVyLiNDq5sVOyMmxkljnNPvWjMHglrGvAVLniNSVc
	geUDaznQwuWru1Cuxb9HsBzG+lhWCvwGKhObKXeL/Ib8ONayNhxtOKB8d1ZuOk5KdsbhQRQ==
X-Gm-Gg: ATEYQzyvbQoBY33tVhDy1ciVUA5cZLoYgdk0TqZXkCOsg4vVPNyWp8pd+XSo4pxqxHJ
	QmB8QUK0sjjdfeddJCQotxCZum+s85sa9jfbjo9KdsCI0w/dghs4+i8ezZqbW640zc3UfzUz6X7
	fFve6MUtkXpBqvflAlg0UjWDxYokWQVMR3SbqblG1fv7oKSLZUC96JNLvCf5+NnMBV0SkZ+W3KU
	E9ncuYUQeU2MnZOnihTfnplb1aNi3V+K+tSa7K+bTfakyeKaxnVrUTBNL935yQ3WCgwfaIv2QAz
	ZxkrqXtjO/VsP1cjP60/aK+m1oABH24WT+xVhJnDGDn0z6Wb4YH3ne5SUaSMszM7U9/O1ngBrpr
	wlk2+opFJaqxtQBDE3PFCQoKcGWW9YSLLHIz7zoFCa8cdHvA5+qDzxhPHxsaWsyRcVFc86i/hXP
	f8B2Ky
X-Received: by 2002:a05:6830:6186:b0:7c7:5770:d2bd with SMTP id 46e09a7af769-7d591b3881emr11120269a34.12.1772537435251;
        Tue, 03 Mar 2026 03:30:35 -0800 (PST)
X-Received: by 2002:a05:6830:6186:b0:7c7:5770:d2bd with SMTP id 46e09a7af769-7d591b3881emr11120249a34.12.1772537434819;
        Tue, 03 Mar 2026 03:30:34 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:34 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: mst@redhat.com, david@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH v4 0/5] Allow order zero pages in page reporting
Date: Tue,  3 Mar 2026 03:30:27 -0800
Message-Id: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GRxl2yC2Y807wKdvHflUzzjT8KHv8uzu
X-Proofpoint-ORIG-GUID: GRxl2yC2Y807wKdvHflUzzjT8KHv8uzu
X-Authority-Analysis: v=2.4 cv=A75h/qWG c=1 sm=1 tr=0 ts=69a6c65b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=HYTG7BDJ-qdBC1FqdxkA:9
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfXyNdcAsJ06B/A
 VFn68u4svRKLYojNyo2ESkXQ3SsCxcijYd6oUBI0k9AeSQwLOdcIVUOk7Zh1c+04YpUNesHjLtz
 IJBw3spOGTy6vtkc9J1VF7xsSw+hQgQRRIoIokYM/RQO/4H1NyWX81ir4sv2sVndRzQ2B6ImPwZ
 7IMoPxk8SVbJi29LAQvw3qW/Q6dnL1Z5pek0tI2BEE/PTOvyq9ZgKAo+ms5S1cYQIE+AByBm6UV
 FJ59p5hum7XNEb6EUOzjVZKR1a7EBaq9IuhCvcWZD1BXI7ZCOvDGaMJQOuE2CvVSP2tcZ/Jfask
 PfA6qh9xOBZ9iCdafOnzfi+lruXED7aBm7Fm2l1nYmZUwBWm1iaxQEa5RzUvIeeqYM2xyEQN6L1
 eX2fF3TR9J8Pzz8Tf5KxkEe7Z/4T9Z09S67RCA54MYgjghmf78pBjwQ4CRYSgkzBQArisCSiROA
 02vUVhyWeWjVKMLZm9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030089

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

Changes in v3:
- Setting page_reporting_order's initial value to
	PAGE_REPORTING_ORDER_UNSPECIFIED moved to
	PATCH #5.

Changes in v4:
- Move PAGE_REPORTING_ORDER_UNSPECIFIED's usage with
	page_reporting_order to patch #5.

Yuvraj Sakshith (5):
  mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
  virtio_balloon: set unspecified page reporting order
  hv_balloon: set unspecified page reporting order
  mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
  mm/page_reporting: change page_reporting_order to
    PAGE_REPORTING_ORDER_UNSPECIFIED

 drivers/hv/hv_balloon.c         | 2 +-
 drivers/virtio/virtio_balloon.c | 2 ++
 include/linux/page_reporting.h  | 1 +
 mm/page_reporting.c             | 7 ++++---
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1

