Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34B15E9D
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EkNobIrV"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5962D81463
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 14:52:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5962D81463
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EkNobIrV
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HbpIyaAXxAzg
	for <virtualization@lists.linux-foundation.org>;
	Mon, 20 Nov 2023 14:52:26 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 40FE9813EC
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 14:52:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40FE9813EC
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKEgxib020299;
	Mon, 20 Nov 2023 14:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : references : in-reply-to : to : cc :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MKqs0kH46522/dBFUNoDwo0NLDCnu0C5KWXCe66OgJM=;
 b=EkNobIrVVFt8l0NSnypVifJYz4lzV7FwXRka+a6U33wViI6pgn3VV6909aoQ8OUk6Kps
 FeE8O4R9uCdIP6XXeitCmo8jQXVMGVT12Y5TdXlG3IClzW0jDYTKJoxri92XNBQvXoMI
 JetblLJTEhajpwV+jN/eJQqZWhjhkdXTR9mU6bRSSZVml7VrNMG+jY/vZx2jKjHbnuvc
 GuikvJshewMsQpn0gUVsvOizVh4NJcx2ROSYoYBtX7RLRxIBO+BUCPAcrvqdzFe8E9nj
 bGXyxGvER5VgKsgcr45j616uRE6Y5PLh4G2gHXq5+d0Exx84eDtIiabQIz9zUf6sYtS0 XQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug92b0xce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 14:52:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDRelH008982;
	Mon, 20 Nov 2023 14:52:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy9ygr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 14:52:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKEqFnF41484696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Nov 2023 14:52:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B2F820040;
	Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69F7B20043;
	Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 20 Nov 2023 15:51:56 +0100
Subject: [PATCH v3 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Type: text/plain; charset="utf-8"
Message-Id: <20231120-viommu-sync-map-v3-1-50a57ecf78b5@linux.ibm.com>
References: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
In-Reply-To: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=61dRzahqb+NckHJJYg5DlB8RlYEAYvbeelbu3VOGu+E=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFKjiybrNew5vV+NpcZt26w6kStO11xKjbKb12Wm3Yv15
 eupiljbUcrCIMbBICumyLKoy9lvXcEU0z1B/R0wc1iZQIYwcHEKwERi3Rj+Cupc5xYLfZthKPOG
 5Vd4aMnx1DPB5399WvjqidiDmhsn9jL8D5RviXUX5120La6E83qOa8hxlr3tAV0uqicWzbasy97
 LCAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vG_dkTNHMYheTaa0pdY1jAJaupmtev7C
X-Proofpoint-GUID: vG_dkTNHMYheTaa0pdY1jAJaupmtev7C
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=369 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200103

Pull out the sync operation from viommu_map_pages() by implementing
ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
elements of an sg with a single sync (see iommu_map_sg()).

Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 379ebe03efb6..3f18f69d70d8 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -843,7 +843,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			.flags		= cpu_to_le32(flags),
 		};
 
-		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
+		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
 		if (ret) {
 			viommu_del_mappings(vdomain, iova, end);
 			return ret;
@@ -912,6 +912,20 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
 	viommu_sync_req(vdomain->viommu);
 }
 
+static int viommu_iotlb_sync_map(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	/*
+	 * May be called before the viommu is initialized including
+	 * while creating direct mapping
+	 */
+	if (!vdomain->nr_endpoints)
+		return 0;
+	return viommu_sync_req(vdomain->viommu);
+}
+
 static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
 	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
@@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops = {
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
 		.iotlb_sync		= viommu_iotlb_sync,
+		.iotlb_sync_map		= viommu_iotlb_sync_map,
 		.free			= viommu_domain_free,
 	}
 };

-- 
2.39.2

