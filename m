Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D88423164
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201226; cv=none; b=ss+VqnNr156neOG7kpa79VaBrVSIIyU1a8hFs+8MroF9Gh5/ZUP+k6KbySKdduwK5gtbrvqVdqXanGi98iPGbvKkR6g1G47q/hzJpIn0QXbAMM5V/s2RQzXZhVLUOpmdXYvS9hNtKiYsFDS2KizHs5BxKoHHrxU/oVms/7+nl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201226; c=relaxed/simple;
	bh=EjuOsbxuEHdSCAhIUVJeqLCmyZU507OmNwvaUDm0HSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YxMCqRED4eBSUOgIZrrMzEyCGnW0wdTebpWm07XtbaSA4R302ATpFPl/SWpStzFWiojgzTcnvCiB2BaClJVLBp7qyJW3XgeD20i6UlrVRW/Sia57+j+WCIvAHLR4G7mOCBDWI0oe+2XFG7fcJcuglbtanXcf/iNzNqEi0hbWVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuK84Pbd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRxlHt9c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuK84Pbd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRxlHt9c"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9lrCe3748172
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QrnGUwS2K/U
	9l3e6Z5G/7MAq15xmGxokEEu8o3CQqSg=; b=KuK84PbdNBHtRHb/qaLqIxiTLHx
	/RiqNNPVF7n1ODEWqmJiYFWzIW87kBXHIzlPawr3HanrWWLQWM5MgeGhDIcZg2O3
	tkyWgjZj4s/jYSty/wAk817lcnmtV6BdqwoVvz6GmXSLszti+rhU8oubYjVNDqhx
	ZYz7Fl1qkceW4XUExOfvxUM9deOn8Ns3jem5qHC5/2SkB70QI8LitNZVIZLszVPO
	OvkhNYpNEjD19yhZcP8frXsPJicvdJatCSwwUkT5e1dPr6bj5YaWq+qYJFvX+DP3
	paAWh7CElljrmZdYp0OyL+pHc30KgAtvIUnpwK0Pil/kU+uLXlEj3K08JkQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur38ns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 14:07:04 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4beca8c53so19590970a34.2
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 06:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201224; x=1772806024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrnGUwS2K/U9l3e6Z5G/7MAq15xmGxokEEu8o3CQqSg=;
        b=ZRxlHt9cVMWwmxzHee8WRroUilgKt8+wxfH6zKd47W4YiYitTnEAdGgr3twi/hP18+
         L8zNavvOybTzWd7r6iD6gopV88RiXmsU3aPYWvIqRmrY7GdYwivXOkl86r0mw8TaCuaL
         CcUdpik1toOL9lPsk4DgAzVG5wXWyQumsahB0BfK4QlYhAMe8ViEVee/xCAC01quPFC7
         mgpUqbXCGSwkTvrzkMbWO4GbvBh9vO0vNI0/P3tq25HIku0vovs6R0EIEh8jlEsv/nvl
         jGmIDhrUKsZ1jrXJSnTAI5NUZ2WGcQx7AAZiF8s5eOLjhFF14kqY1udj1YV37/gM5i8b
         K6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201224; x=1772806024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrnGUwS2K/U9l3e6Z5G/7MAq15xmGxokEEu8o3CQqSg=;
        b=xQ3aWe/vJpuQ38HvyTfCM5v0+8M2wBrG1w1gVMQVaN/+10aH32pgpwi0BILPWIUGmD
         Dn+YjY2X0p5tqrw6wtxtd3sFq5AdAtkGdZaJ2LqdvZGTl1O6VgrhRw3azZk2YvwH/vf2
         +N+jPFtoEY5rYMDKRvM3z7Zp97BA+M0IwtdqAN2lztrCmGJ7fkw+0qK5esh1Xa9bWmus
         XK6xFUobHhVNQyvbpaPpWxp2KFDdGoQLD9R8zMEMzYfnaU1zevfdD8pTE/TdYflGAqFg
         1zuDRk30ydbKc6CEnU4QJzOHCSFy2hqqIQ52Y514B+m5bQyN2fvRxje8SEGj56iTW2YN
         yA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpMvXZ5DD3/F9qg4QrryKd6nm+A8OcFwctolo9SwROBPgCleqldcgQYKKz8hGvAZLhsoBJHGNWcTvNlQUO4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX57+T/FRwxDyPwi8SW+hzD+n9/HMEwcLPCanFo3Xj1wL2PWIq
	lDhEdiN5Ts675p2VvNPhS4/Yt3Kos/ANn25bd18sWwL0nelwyHkY/06qpfMFkHgkFkK8T+Sw+eG
	/DHc1Q1rDdJ7W8p2u1EL93ZmFgQEPhvzgxTaQ+O7euKf91U6AUT8HKit0Gm5TcYPphpGUrQ==
X-Gm-Gg: ATEYQzx7OKYd3rGj8O9pl05V423vJ3e3+WTtNvh7+aD4uTrTvBIDZ2heDXufDCzLkVr
	XR8WSw3bw9Z3/Dy9GB3ndSqAD7zMIGt81atOp2ORuVzqKewp+7/QDgqU2pUHlI9IM/OO/4pt5jS
	FV4P5LMmSIvc+sF1pf2YthGimdr5Of+DmyAoKE13eMT2ey4paURt3JiafAvVmY7n2EW9sxj27j9
	atHBQ+N/FwYwh/iJkNFg4fqe6n0L9swS1cdWXJXH6TiczmMJvCa5Yz3pIk6LpuDbG5QdIpk8Eyw
	EVoafaBuLKuleONC9pzFqQZxypT5h+vN4Sd1fCBl0x554A9wbHDeSTV9CiMjhKqYPg9LoXDfD02
	/g204JWkYqnKQ4FHYhaiIYg5S2FuJhlhBuJJUDX+FSRGzXmH3XXWpfZ3vx6eB+DTmGb0lkM7MTl
	QXss0g
X-Received: by 2002:a05:6830:25d5:b0:7c7:6043:dd93 with SMTP id 46e09a7af769-7d591b2656amr2098290a34.13.1772201223980;
        Fri, 27 Feb 2026 06:07:03 -0800 (PST)
X-Received: by 2002:a05:6830:25d5:b0:7c7:6043:dd93 with SMTP id 46e09a7af769-7d591b2656amr2098262a34.13.1772201223559;
        Fri, 27 Feb 2026 06:07:03 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:03 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org
Cc: mst@redhat.com, david@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] virtio_balloon: set default page reporting order
Date: Fri, 27 Feb 2026 06:06:53 -0800
Message-Id: <20260227140655.360696-3-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9A4nQY5dYviwNq17Vt1QInLNsoN2uHg8
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a1a508 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX6hhokaHJ/HEi
 Yo6UznHedM6guZCBvpRLA5j/HE6glMGcRZPTfq3MyzjGuIIzHoK5R7lmZ/+7Z9aiSo/cQGMgcF+
 FyFxqoZQ5Jmj7aM3daAGBA6UnWtyagwlu5K75D2euQOBc45Vs4Yikw8glI/9wB3rIJEDwiofqbv
 hKgByNVCL6v/nF1ibiJThDAoPq23XoPhQyZCBWjmXXLkReC7BWBXZZTCt7OB+ZesHAKjWYTXW42
 pDzaf2MSdbK1Y8w2eNULvQpgomeubtEx31vWSDWiz+jmlUe9ve4iUEtTC6f7zBHaKbyLUEcgfbx
 h/XdtvdOtUEiPcKyss56dF2zuUu0BhV/NF5YqXbPgTRCLK1JqIiM51Qi6+UEPU+MMRafH9vspR/
 wKNjfLLyFFwZ9w0aNNU4+EZwJNKOwtnkvfcTYoDkOvsiRYmjyz3J72la8/kacDdyWvXqopanCEj
 CGEqgQEAiI3eV3DqLQQ==
X-Proofpoint-ORIG-GUID: 9A4nQY5dYviwNq17Vt1QInLNsoN2uHg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270125

virtio_balloon page reporting order is set to MAX_PAGE_ORDER implicitly
as vb->prdev.order is never initialised and is auto-set to zero.

Explicitly mention usage of default page order by making use of
PAGE_REPORTING_DEFAULT ORDER fallback value.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a..0616c03b2 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1044,6 +1044,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.order = PAGE_REPORTING_DEFAULT_ORDER;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.34.1

