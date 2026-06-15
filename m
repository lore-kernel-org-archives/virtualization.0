Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B03F4DDA
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533456; cv=none; b=UR299aufLDQ+UQDPsU4JqFZtKmoxnO0ZVKZV2QqI/VQK6mbh+aOLFCoau4ZGXmEKxyHljrIjIpR2f2GH4OdgQO+1yvDAfqHZFOeOQw0Xv1ylVo9q4kmX5Tzi+x1XSfAqo//fLGmtBhrslVpTBTC4nq3cZvPBLJYQm+6qzSF0JvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533456; c=relaxed/simple;
	bh=kiIsMDo+qCR+gsHM8Iu+H9cpLnLwOVAQRINXxJNClUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLAoZhBYlJfXi8GeyxCOR1Y/RjJGmvBP9C0+bIF0EgzsyZisq+x9TBuNqQR5gLSZfPJMX80CX/FsA16ByLyNijRArE7RLlBihQl20RztQS02aCqSnazpCKG6iv0dwEb5+nHGrSlpapq5zNYJAVC7KiEM1Ypr7RrwVotUgNEjwYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GN4eQdbK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GN4eQdbK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCmR1c2516332;
	Mon, 15 Jun 2026 14:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kiIsMDo+qCR+gsHM8
	Iu+H9cpLnLwOVAQRINXxJNClUY=; b=GN4eQdbKdswwSls6TmhN7tpRUObzW/956
	FamR+im5/GrFejoOBThGVMmsMUCTKKCpk12PteeH6Sj+r5kdpRIr2UeYoI5LZz07
	4lwZj0Uk1GkmtZu1VrOvbOCs8R9KfKuvRxEX6tC2HAsMjqLaTMnA3j1FP8OblpGi
	L1JWXiPgTS51lP+jx/4oujUNzbrvC7nSiB2W22a9V9CXFf1w98Hgfvq5/oj90lWv
	dUYlx5AXCCl8/aKSBPVnPXfJd6LMwgVbvXiz67SCX04uAd90NYQfG8UHSagshnI/
	o1UFrrFeresp91jJVazVGMhX0SBUMrVIBikkZwHjPOYF7O2Rogfsg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg0kae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 14:24:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FEJgaq014403;
	Mon, 15 Jun 2026 14:24:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1gxwnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 14:24:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FEOCmO26280516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 14:24:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACBFB58067;
	Mon, 15 Jun 2026 14:24:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A88A55804B;
	Mon, 15 Jun 2026 14:24:10 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 14:24:10 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: mst@redhat.com
Cc: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sgarzare@redhat.com, shuangyu@yunyoo.cc, stefanha@redhat.com,
        virtualization@lists.linux.dev,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: vhost: fix vhost_get_avail_idx for a non empty ring
Date: Mon, 15 Jun 2026 16:24:08 +0200
Message-ID: <20260615142408.64169-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX4kOKOUsdn62Q
 /00GYZASuleTVtIXkuDbgwDV+7nlTSxdLhmfjXnEDOwZphkeDsc5yNcqeYOjo0AQY4CUKdPRaNk
 v59IksHTAY5najYc84fr6Zys+ciMo94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfXxGYz/ntpzeEW
 VQ0IpQMPtCIG0fa+inikduA5QDgfsJQ5qhKQ4Kmik6MQWgbSBWWV5hoY+zPWdOwYeWfO7xg6yYh
 rkASTGzuEePJ1NF48p+ZRcx9GBXw0tVPFwHnirO8CfmTlo4JRwzbB8Wu7PNQdp42r8YdPtIud0j
 MVt29Aty2bQDOFZ7PgmyzrJVd6zankDgEtEImfRryU1Y96gCs2HODtDhdqkX8DK+AyPS+jJ/8ko
 VUMgUTD7d9ng/rUY0HXLoV0/ofAtMuKpoasRTW5Tm+j8OrL7cKz+Q16k7HFKQEe4aYu2uIfwJhT
 TnS5RNi6WL9G68VKw/jgs68qV4ETCurGbaUXMg9bBUZ/wGSAemiQ/A9oZz2kJ230FKyj5SULK14
 3Zl7YYWOezdl13PO0b1+aZXaOQCg1WFTXCVbPX+X49a3quUsqi+1yJS1jcfxN/g+0B4LTns9XdR
 2+4FI9fsa5Z9Wov215A==
X-Proofpoint-GUID: JCecQl8GbpHgCG0Czo7MCieaqFs7ZQJ_
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a300b0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=q_tXsGYBvXEQEe6gApwA:9
X-Proofpoint-ORIG-GUID: JCecQl8GbpHgCG0Czo7MCieaqFs7ZQJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150150

Late feedback, but this patch massively improves our uperf latency/bandwidth
and cpu consumption significantly for s390. Improvements are all over
the place, streaming, transactional (100 byte/2000 byte). Nice fix.


Christian
