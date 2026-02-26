Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC142BE641
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089291; cv=none; b=eZxO/0vXvskffT2J2/BthyMMBwkYQ/QXpQqaGg+1CTe3uioouFMfPYhXBn1I02hFHc/sz8GXryjvbGLD1lZJ3HK2jsvfJVj14JbdHRDsx/oiXgfIaJK8/7ozTOeqkFpFl5ilCoIPFyRWS0EcNvDgmMAuhnQkQ8azcDNed/Nb9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089291; c=relaxed/simple;
	bh=CsqiwpOdkll6suZ+hlMAdpw4JeyYyHfQkHGgLakRBJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tb1M/S4e0rBOxHSBeJWNV9/R81mO3gTQXSTPTj/DRrlgtTAp2UtSqKm5oLrrvbucone/N47FjHtzW86W0AlqSNRELW9ZUBmmKFsUK9q5Z1kvONyQVAa6whYDByD96tpKoD6/YvJB34zYuqtdOvfaWOKkLv77mwGGtInzZhnpzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ya4sAlE6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bo58ujib; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ya4sAlE6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bo58ujib"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4Us2s3225937
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Bd9GytnbLfNGAuFQVvbct7LRRRfzUwf7RxY
	82DlywCg=; b=Ya4sAlE6cZED1TsJp0N/e8giADq3gJ+NF1qRP09P9719UhGwGO9
	L/FZZLty7P/3tvJsO6JPhbvUjfSPhrK49H5H3hSi5PzuTOOv20cNo3deZs1ynat1
	Bb4kvV3nAXlM3MGc61VVkSVnkHEwsKpj8M+tXGcL+nHght3c0R0XrMEwuP8qzSd0
	P1ujIQ7dmFdZS3s8ZiCVACXG4yE5bFs+NePLz8hvM3FEpa5va46xsFc60xKMVxHk
	zgW79jaDFMMA63voIpANTd1grL77YxS9Vv0qNsQUE89CPbN8skk1i2ku6ls13w/1
	FzxR5AlP66uTH9ZYAq9O0QzniBwQeh/X9sg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjdph0msj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 07:01:28 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c5fde4c7so14003608eaf.0
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 23:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089288; x=1772694088; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd9GytnbLfNGAuFQVvbct7LRRRfzUwf7RxY82DlywCg=;
        b=Bo58ujibAtFYdQ4F4drRFzVdPBRmIUEOuqgCnEngbFzKA/kyYB+RGiMEZTOC3NJm7A
         zGH+C+iOeTEXGwLyrwQ6IaQW2XDCCSjwqLlDHsckzAXRMUbjW3ApjBBBBYTcuRDb5me0
         RCa4FOgNvhHKElSprmt+s+OS2CB0VXAVy4YQp9xb4x80B41MhmcOOyQMqee3BLzzrSgH
         bb9c2S8xFBRkafZjr+Ba1OhnDAK8B+83hfCZ7gRDU/ewmc9KgjfHO1tLs2gLM6JKv3ld
         CIbBTZiqwJzU0sPLcJjRSFNB360Fzex7LkubRPRst8lbi+pwI8EElg+MEXdd9S8PZ+N8
         FBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089288; x=1772694088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd9GytnbLfNGAuFQVvbct7LRRRfzUwf7RxY82DlywCg=;
        b=Xwkz0wXire2eDJDDcJII4PrYB5kkDEpSdZDK0gDxwhE7YQ+e1iTHP2K45nYffsn3rN
         iyzW0buRDnJ2pQNJxsmPi4P0Sv5de+0f7P0vT6sMw9CaXD4YSFSxtpwV2T33Bks+cmsH
         gTfp3kJuSon5WL5eC/lJ7fgH53LuhUIOuameym4joq4xxUZgyN238w92JSdAKj7H3z5w
         F2rkYyU6YhyfLAwcbb9nFXjWNyJRv7cLbzIEtwvtLOrNyUYPQ6eUN7rwUp0cGDofBWF5
         6/QopqRdmRuo2lcsi17whBvZ8aQkqLG3rIH54IiX9KrpMBxOioxWHIfHhT8DisqQcirx
         q6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXw6Zk2W7M1rspiMrborAtUkLv0gC1gkIBf0F8NgLTAWMbhapuqBOElupjNxbgqH/B3mx2qPsDeDGjhpehnUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2RZxscxCGeUCiZEkatxdfPGazBOIUzrs2dDhcXKiMbpLhiSDI
	pdtxna+lGMKPVlvrRZNwOjLhZk5v37UDhKtBNFTJ5Eo9NezZlVrwNtb5ptIloErEY/Xzc7isCiN
	xtfqWkv2cNw1AqR7FVQtmwUqmf/wN6vhdUKUAHLTBUOFiBuzZhZQemZSL8XY6dntJK8jHAg==
X-Gm-Gg: ATEYQzy0RqsPGaBTnsgcveNYTHlhtRaSt6R07aUpvMZWEi/cukLYmYp1QjzRZzk5GXw
	ojvH8HERtEgke8xAp4u0UMoTXitZTNd3SAervMt9k5K8ysZZPYtNzHsEH/YpfBSiqTxeztHtdCF
	Vy3omGA+55UUgrbjrdIH7kuPukzWe84KGJGobh+0CdIwJNcMQ6zT1oeEQz12dUY9P8afOpQcIea
	IeEBpAOhYa2IVFfCu1pprtG0vOei3reYCeIKfqZ0V+GvAgdABknhw4IyLXPKodpnoztHkUZzkXb
	kBfNT0i/eEYVCzdCWEZ8FB+nhMSOsq6PNA6hQfulSZsF4GJnV8HrbObxF9sWCDKFuWlCKmf9g5U
	xCmTn66ET4m37aWt71p6cMT1crJ0TNNaqDCsDIo/7Q36wacjLrjLwEf1FSwJE1E3VPiILUtCZaS
	8iNfwz
X-Received: by 2002:a05:6820:1f05:b0:679:88ee:e3db with SMTP id 006d021491bc7-679ef9aa12amr1654176eaf.70.1772089288459;
        Wed, 25 Feb 2026 23:01:28 -0800 (PST)
X-Received: by 2002:a05:6820:1f05:b0:679:88ee:e3db with SMTP id 006d021491bc7-679ef9aa12amr1654157eaf.70.1772089288041;
        Wed, 25 Feb 2026 23:01:28 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:27 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Allow order zero pages in page reporting
Date: Wed, 25 Feb 2026 23:01:22 -0800
Message-Id: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xEhRKbwirpF7qeHFVfn1VA8bFbFC0T3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfXz1lNSUKm2V1a
 XIVaga7Ox92nq1RZH8D1MSUl8Kv8Tvi2YdHo0BR0NLfSA2Qxdp/cni/JJaQwlNGgQ7cyElG+AEs
 e4Bvr+aXq+4reFQnZDhP5imcmxCt09atWae+E2XyUNoxytaif0RLrlh4HfbzZHgYzefO9Ie/2NE
 CJSD10gw+Hf9PL0eMvF3iuKpNufcwnwZVIQdmTRivRLODbMUe8KekmbGO/pWEIXGE0jvKNAnIuj
 dZSH0ZS5wUptRL8041zF24albYG+NJ74h77rIQUBf4NjOnGrtu6qn2yRfBhJt1qO3L0SWnI/4Ma
 iYIV8R3J0elUoHJcRTEq5rTo0URuBHILY3Nmlr4kHWHh6PDX2DiDWGxYE5qU7+YwQ7u4h54MLea
 2PYgQ1eoGykEBbLkgxhODve6b/Ypow3mY4WD/gWhq0SNSlZ0gArKHUqnhNvAPt/Np3EBH90vr9q
 BqcnlowGeZKD68dGeXA==
X-Authority-Analysis: v=2.4 cv=NJLYOk6g c=1 sm=1 tr=0 ts=699fefc9 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=9ecvtSpfVrh-a2M179QA:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: xEhRKbwirpF7qeHFVfn1VA8bFbFC0T3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260061

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

Yuvraj Sakshith (3):
  mm/page_reporting: Allow zero page_reporting_order
  hv_balloon: Change default page reporting order
  virtio_balloon: Set pr_dev.order to new default

 drivers/hv/hv_balloon.c         |  2 +-
 drivers/virtio/virtio_balloon.c | 14 ++++++++++++++
 mm/page_reporting.c             |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1

