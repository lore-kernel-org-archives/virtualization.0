Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC951C433F5
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 06:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D9064184C;
	Fri, 18 Mar 2022 06:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nX3dQgRS_i44; Fri, 18 Mar 2022 06:00:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09C4841739;
	Fri, 18 Mar 2022 06:00:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDEA9C0033;
	Fri, 18 Mar 2022 06:00:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF81C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 06:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA140404F7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 06:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRGTcBnhOrmj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 06:00:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::606])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC0C940101
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 06:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cig6z8qIKgdRBVjXo8xP0OmnoDpBW/PU8S5NVNGMyqormgqQfd9dn10wE34RfOJcvywOCzcOgIi+Co262Xd5KCjIev9E7lwkMhukT7ul1qUDY4uw7bPkbXNTF2ZkyBgFhDCI3Gh4LgvQ/aagd6bQel09gW2Vdu5bXDBK5obXBu8W/qFv4Th28JaxuiheUV9cB8RwS77iikMikwpNK+vYNsgDezSXh8x2hP5KdZFx4TFiYSlwzkWtIgshdlGEzhYyzAYv5vnUDy+l0DC4uUQ/KhOZZ4EpBXUc3/BHGlnW2jgkByrRil4hP6uCJsMYjBeHgKHsulpB8nTFEIqYmQZQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJnfM67b0WZoHM19sGwdCrtCsA9UT9kUPn7jws6pRqk=;
 b=fr53Ujh73+745Uv5agehK8uarUtml/DGhM5OQNyYIZkNWAKHom4ssGj/L/nEs7JKLkBMpC9uEuRFoOKF3/hNmaSF76NWG4YZoM03OmU3r87b9iOZcrixfc+UdTZIkCcRmkgDZ7Djj7+ytvMHqXNB19QeJPEpd8AAFnuVOiyxSA4rVAGFsquxLldt04/bcGtocJkIeVP+uAMdxEi0f++qFnOV3L8QL+cdOSthjGMP6fjd4HW47DMa6fobmZYG3q0612zrI9dOvkdFlwv1CRxKECwMPdA/Gfj0aidACebUesim+fnvfR1vTaeQA0OCcgbDgduWeZXeZX7BlJpysQFJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJnfM67b0WZoHM19sGwdCrtCsA9UT9kUPn7jws6pRqk=;
 b=RRfrvuRjTY3UNmYrrDSVbXrEHk+N2qX8/rljnwJ6vH4mKz2X0RccyzxXjvb7uTgT2i63/zrrkzVbX51fvYRINzKOWm5JsS6Zo74g6dQ3F5/CPc2XlKuXpvHCYP+c1w1HJ9OLbGURqaZRsWj/T7kOwJdvfh9WxHu80JzfpU6vE80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by BL0PR05MB4884.namprd05.prod.outlook.com (2603:10b6:208:57::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Fri, 18 Mar
 2022 06:00:52 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::5d86:5648:18fe:a5ab]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::5d86:5648:18fe:a5ab%3]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 06:00:52 +0000
From: vdasa@vmware.com
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH RESEND] VMCI: Release notification_bitmap in error path
Date: Thu, 17 Mar 2022 23:00:40 -0700
Message-Id: <20220318060040.31621-1-vdasa@vmware.com>
X-Mailer: git-send-email 2.35.1
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To BYAPR05MB3960.namprd05.prod.outlook.com
 (2603:10b6:a02:88::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50317b5e-6910-4a73-e41e-08da08a4a88f
X-MS-TrafficTypeDiagnostic: BL0PR05MB4884:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR05MB48844F8F839C28A8C02217B3CE139@BL0PR05MB4884.namprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gd/F1dWl4Z3T+5wCETpnRst/kjQeeGO+GG2BA1WcxGkio8bK9TRquejlmyzh9HYyisw8chVDjI38VNEug5SjrhbkC+1IVYmd64pqDC5Kk8s618xgyvywXAKVg2M+jyv4FqqK0ZXIWvEFp5PLoQI3WOkkGjOA1fg7NO5VdzDpGapl3JL+ckRmaAzmu1PES5dOA9AH7EN6BBEFrHwqLePlVtzCudqxz8ejPtLW7/MrMoZc8nbwb/iuuuzHX0Zqn4k/pJSRdiACkcFIzFAQ1ySLHbAtwGrf/mKojVVkKSiICN0WRVNfMnaL10ad1UVFoOMzbZI1JYgBMBLH34rY2ZExaPeyJIPM3gxNfTBxdbUrsXxGBVcuUJ4qmudI9ppkDDt+Gy1HsYizctsXwI3j/oifDuiu4F3HS62yxRbhfnysJQUmErZw6wd2VAZ8p39hqt0SxvmQBZuRRl3H43elSF4+s1TDEN7Kbpfc5MsvWthgrFvoIChLwxl5Vnj/FTEvIzScK98895SpGTqYC6qvAe/NRsvnLX0+YW3703uUf4viF7lA/p4gVGFDKWuh9wEcCWv8VwWWFrU0EYoCWcVNQiW9QnI1F3DuoAljY1vb1dtTj/Bf/AO4rKpqOt3ltl+3VtafyTXe75BlvD+A0KAYUD+YjGRJV7QOPFCI8vsN9bk55l+yRRAWPlof6/iU/iSWMgycsZavCvIRPGiCnrAyYECf4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(8676002)(4326008)(66476007)(66946007)(38350700002)(38100700002)(508600001)(86362001)(36756003)(6512007)(9686003)(6486002)(52116002)(26005)(186003)(6506007)(2616005)(54906003)(6666004)(8936002)(5660300002)(15650500001)(83380400001)(1076003)(2906002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8vTCBk73jKK2WLjsZhOOIB2qhY0bydwEc1/tUMjIFLLwEJl7syZbMnmAUWI?=
 =?us-ascii?Q?3qnP+ssN9UJrUypfmBaY8s3LbZYmrarrSsrxs1KbFMGPWWpIlaOAmJWjrh82?=
 =?us-ascii?Q?F1AVQaZd8I0wzNJYfnM/ArApVmHqgLrko2iumzojoiMarzcbQs7l21qNxWpx?=
 =?us-ascii?Q?I2nzie8GvIZ7bJF/qEHeRyN2JuXIkrmZiCMQ/CdzAzY/reECjvrxKcwRniWT?=
 =?us-ascii?Q?UBiENy3j59LIX+wNq5y3RkKAt/9PgduSSWfGDiuLypOLq1w87b4vWOjyWZ0T?=
 =?us-ascii?Q?DVP5bG9+aGi58953XQR6+jYI88y/beaHUfbSlqeeZLNBUZ410fRWKWLuBbeR?=
 =?us-ascii?Q?eeSmz2BARUNxUwq3Ev/G1NI2c+GSrZIROh99E8cxYaIGLvDwpu9brW/t5+J1?=
 =?us-ascii?Q?umxjJpBV6+RIW+KfVlxUsTvD5edne+H0lEMuC3IxMuLsvsozl5eXBEvYzwAE?=
 =?us-ascii?Q?YV4qe39KnGp8uypa2kUspIxJdSEHeaiFodUw5n0xKYYeuXEyGJYOHRBRvIq4?=
 =?us-ascii?Q?DFyQk62iash+X7FlH9G1vgdIZoqzqfYt031vaLHaqD2kPuuhuLdfoe72RN/Q?=
 =?us-ascii?Q?WXweflYNSpumpK+qP7I5UDtoyv+i5d96Qea2yL+ro4IzOFTw/w8B7A5sQGjS?=
 =?us-ascii?Q?xlpiaqSbigqI/+73xtZo0JDXdm644VBe+7p4riEyGrZuT4LTmoBtMzlSoiG0?=
 =?us-ascii?Q?r1fcucZQkIjRdPKIg51L2wUJXtvj/hvV7fx48xa158G9NlqZFYUJPetMsng9?=
 =?us-ascii?Q?6y//mivk236orMWIwcpY1JXP0QY0AlDUOpdg6U7jo+t0+1gz1obgQrvR77i+?=
 =?us-ascii?Q?xbQ/1yl9nFzhwmV/ZsvEMQOl9LZb78htLo2oGfc4R9KQXHqVudunuGVFhEwa?=
 =?us-ascii?Q?E3QGTC/yIsvIXYrN7+CmVWlHi1RXUy4BAdGLUvV38rkTxWTQgvacRXi3G4+I?=
 =?us-ascii?Q?b/7mLLOqxnG25G69eb1yehomq8RYU99dRmH2PKC3426ES1F/T1yIR6WzNqHs?=
 =?us-ascii?Q?ehlV1GC7sHtwh21K51BddZwTFwR5hZCmdQbxhoF1Bj3bzSwp4o/9fk+j6S98?=
 =?us-ascii?Q?burL9+HgVJDoMjO8SEf17fNfGAk8GBocqu+aMPqJsWpuAkUJBHT2Gr9lCtj1?=
 =?us-ascii?Q?92Bb3VxAHFC+JqB9bDHkdNazyMA49UPWvlyoHAgqx+j8WkomQ9O50seAE2eP?=
 =?us-ascii?Q?VnmJjjsOAF2wBzDJLKS0VDL8IkUu3Ktjmu4bRZqkw+aJ6DvK1033kq8snlBM?=
 =?us-ascii?Q?Vn2p6xcoMFkWRxYeL/LVWSOkItpFO3nwnAvu33FQ/A0uXEu6EdduLefx1MSK?=
 =?us-ascii?Q?LHZTgtXzBe1dao8JteQ3rmByMd8V0FNcayXTj7bYRWHllfT/D0VCYQkyDPKn?=
 =?us-ascii?Q?OZ01hoFFNtdLUxPscr9z655kdGcMlJk4UTZ8UQ8RGIesq1zr+cgsnb+KKm2X?=
 =?us-ascii?Q?xI2EVf/E7Hphq7TlYrMQl/7cwq5hBQQj?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50317b5e-6910-4a73-e41e-08da08a4a88f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 06:00:52.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFc/ur6EILSjbZdmTdDAcdy4jWDd4aySPKdutovXWkQ8NpnREjRfoEwxRo56k9s8LBn4cNAEPOCWSkYZG7laNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4884
Cc: Vishnu Dasa <vdasa@vmware.com>, pv-drivers@vmware.com,
 gregkh@linuxfoundation.org, rjalisatgi@vmware.com, bryantan@vmware.com,
 Dan Carpenter <dan.carpenter@oracle.com>
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
Reply-To: vdasa@vmware.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Vishnu Dasa <vdasa@vmware.com>

notification_bitmap may not be released when VMCI_CAPS_DMA_DATAGRAM
capability is missing from the device.  Add missing
'err_free_notification_bitmap' label and use it instead of
'err_free_data_buffers' to avoid this.

Fixes: eed2298d9360 ("VMCI: dma dg: detect DMA datagram capability")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Bryan Tan <bryantan@vmware.com>
Reviewed-by: Rajesh Jalisatgi <rjalisatgi@vmware.com>
Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 981b19308e6f..6596a54daa88 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -720,7 +720,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 			dev_err(&pdev->dev,
 				"Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
 			error = -ENXIO;
-			goto err_free_data_buffers;
+			goto err_free_notification_bitmap;
 		}
 	}
 
@@ -884,6 +884,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	vmci_dev_g = NULL;
 	spin_unlock_irq(&vmci_dev_spinlock);
 
+err_free_notification_bitmap:
 	if (vmci_dev->notification_bitmap) {
 		vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
 		dma_free_coherent(&pdev->dev, PAGE_SIZE,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
