Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF05AC0015E
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 16:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BF084148C;
	Tue, 11 Jul 2023 16:32:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BF084148C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ymbOEdbz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NaIUdZCWp55; Tue, 11 Jul 2023 16:32:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93B5940144;
	Tue, 11 Jul 2023 16:32:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93B5940144
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F125C0071;
	Tue, 11 Jul 2023 16:32:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2195BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 16:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06FEB41DCD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 16:32:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 06FEB41DCD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ymbOEdbz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hj6oJOAeck0H
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 16:32:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC00241DC7
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC00241DC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 16:32:49 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36BG3O1f022902; Tue, 11 Jul 2023 16:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=+4V1nFRqwTelDtAcI310e7e7t3xc9C8kzlyU277DNxs=;
 b=ymbOEdbzGq63lkQ0RO+iBGkUQEcS4UO/lxjF5K2PqFLto+ysV4TEsKigi8pkSD+0XbV3
 XL1VOnexhj0u4/lo6XBn/xKbWSCP26vhMmRAizm8IRK0RiyBmzMxWVgii4+mt2saQDoe
 WQkfBM6MOBixvv4+SnNsom8ajpTprr/jzywgI6bM0UJ9nti/578BpsbF+a3T3kS3400U
 qjrAwqeuyDNTIGrKLmM9yjvATi3gM7M2TcV35rsN6hK23qmhlVJ+Q2GA+3HbmZr/Ok6j
 74UXMpMsv5v2yolmJdhg0gscYbkGqAGt8XqOJSHUbr49tqGPzkT/fCW47BE+ftkelpr9 sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud5e6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jul 2023 16:32:04 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36BGUtBm007087; Tue, 11 Jul 2023 16:32:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rpx854cdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jul 2023 16:32:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BGQBXP019529;
 Tue, 11 Jul 2023 16:32:02 GMT
Received: from ca-mkp2.ca.oracle.com.com
 (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.251.135])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3rpx854c4h-4; Tue, 11 Jul 2023 16:32:02 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-hyperv@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH v2 00/24] use vmalloc_array and vcalloc
Date: Tue, 11 Jul 2023 12:31:45 -0400
Message-Id: <168909306205.1197987.4062725942946508296.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=801
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110148
X-Proofpoint-ORIG-GUID: VdiqWRAD5JOoA45uglvHtoSxe29wDWJY
X-Proofpoint-GUID: VdiqWRAD5JOoA45uglvHtoSxe29wDWJY
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 John Stultz <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-sgx@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 kasan-dev@googlegroups.com, iommu@lists.linux.dev, kuba@kernel.org,
 Laura Abbott <labbott@redhat.com>, linux-media@vger.kernel.org,
 keescook@chromium.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Krishna Reddy <vdumpa@nvidia.com>, Shailend Chand <shailend@google.com>,
 christophe.jaillet@wanadoo.fr, linux-tegra@vger.kernel.org,
 intel-gvt-dev@lists.freedesktop.org, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
 mhi@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
 Brian Starkey <Brian.Starkey@arm.com>, linux-btrfs@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 27 Jun 2023 16:43:15 +0200, Julia Lawall wrote:

> The functions vmalloc_array and vcalloc were introduced in
> 
> commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")
> 
> but are not used much yet.  This series introduces uses of
> these functions, to protect against multiplication overflows.
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[07/24] scsi: fnic: use vmalloc_array and vcalloc
        https://git.kernel.org/mkp/scsi/c/b34c7dcaf311
[24/24] scsi: qla2xxx: use vmalloc_array and vcalloc
        https://git.kernel.org/mkp/scsi/c/04d91b783acf

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
