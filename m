Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D48C433FE
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 05:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4517360B63;
	Fri, 18 Mar 2022 05:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9O5O7lzAyhDB; Fri, 18 Mar 2022 05:59:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B41360B29;
	Fri, 18 Mar 2022 05:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AF0DC0033;
	Fri, 18 Mar 2022 05:59:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABE26C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 05:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8F7581AD7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 05:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wg00ywgkaFL3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 05:59:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6160081A6F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 05:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcwaBsNPy023DmaAXHjBCGAiQdOOVqztT+rViBrOYCoYSeWWGPzbUvTLxVGSd8zBvICd2C/Zt9AoWhU5/cj5iLStyreCoDfhBy0aAYnDEE50nWwl5MGScABGx5GrYxk+Nd2Bjs4bD3NvGxE+PEebVmxMV/7whA9YTCYU2rTS9GDt/dXGNd60IIbmSzdoDdDnkBZO/+Rr3DONcHsqpdBCjvbtpzA5nE686V7E+8PYuAXUlTe1L8p7G3sz5NcuaskGApZrK5KQpT2PKyjCqh8/BxG9FNYL3/hW4fTP+Q+KZ2y61wULuPn8664weA03WwBEP9aFkfdKoIQ8ZhjUbXWFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCh6GmUXzrnJCdAMiDfY26axiq0ujeeb1vq13L2g7Yw=;
 b=emXV4+UAjswDxYXFhEjwo9McYgs0HlHzZTR8FXEovuokV5cszNnbuS+Roxy6zRtAQxfoBZIlHzWjyUxGbZA/emj7PTamJ+2FhoaJphCkaIGv7u8qRdXFDurbgptwCuY2htPF46Km8EJvWgnpFuGJ+vZaq+IUNYmgV96coS5LA/9HuNizWSPeYGKjTP1z1fSv3wC44cvRXzcs/BJKrCBizoCEX+aeBr9ioyg+r7p2tBqjW3cT5K0xjBEpo3FbFNsiqIDadNyRErbHKpMlDzwe6nHgnNtYeMDYW0J4WwJN/3cfBAnifUAf9KmwrjQj7ydEsV43IR1ehfpOuoyKtSQLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCh6GmUXzrnJCdAMiDfY26axiq0ujeeb1vq13L2g7Yw=;
 b=1cGfbJG/JgxR/TGvoiHy9GFn96cyOUQw5fT8q6IwynrmoOyPLVAVij3kG0YSHHc9PWrIgJLXK5VCPBlJ7lQeWv6MsXvM7ggvObplk9Ud/F44lL8N5ITfEwqRQ4rjR9LAslyNvtwzlp//w2avDwwbngk9FlMot/ZWlhS2IWsRBug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by BL0PR05MB4884.namprd05.prod.outlook.com (2603:10b6:208:57::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7; Fri, 18 Mar
 2022 05:59:07 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::5d86:5648:18fe:a5ab]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::5d86:5648:18fe:a5ab%3]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 05:59:07 +0000
From: vdasa@vmware.com
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH RESEND] VMCI: Check exclusive_vectors when freeing interrupt 1
Date: Thu, 17 Mar 2022 22:58:43 -0700
Message-Id: <20220318055843.30606-1-vdasa@vmware.com>
X-Mailer: git-send-email 2.35.1
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To BYAPR05MB3960.namprd05.prod.outlook.com
 (2603:10b6:a02:88::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c9e37f-e8c8-45db-b3d7-08da08a469a0
X-MS-TrafficTypeDiagnostic: BL0PR05MB4884:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR05MB488420B052811DF07CAECE6ACE139@BL0PR05MB4884.namprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xC4SLJgYnj6YWkL5GOy9ClBlobL5ZAWnHFW0I/Hrr5TifyE5wbzxOf/ocMGg33JJ77dD86AXUz0lYoknBSAT1e3EUxCp5ar9Artmh93ZVGY29SOcUiXUC0HvlYEGfxUAJnIFRFBvKAlxeODVf8nWlnKXjpVYr0xwBIa1xi0+5QHhfB0C++HSN+G9vic2NDZuqn5q6Gx7Kba9DRpxkB11JE6fex4trjQZ5NTcVR8SBuYM3Uyp7KbAAyLPZ9WFMqiQiQj2uYPyeD1qFVjfA4ieXp8r5xzIjh7dthfQlcGgq4ekZi67+iwnYe8JHbGBReAq9IhL43tyVZ5RFRXE4bBKE4q5Gc/r17voqdH5Bv3Ig4VwmlbhcdEcPt4Rntn8EUm3eFcETH1GVcpVMk/ojcZrgLHHcvIRn+aTKQKLFqDsV9MZe9IvcozxfnomyAl4nvNLr5OnYeBGr3y3r/fcwj4yPCDvTlKRmYdcUG/m6b2cH6sdWPHU6payOoIpArM2LUM0DqicsGM6m8BJHo/DD3nToqkk7Py+wYauwI5ebW9nvmqbSPP1V5/pkhEK/Xv0cloxBsh3cg6SO6XnG1OkuVITaFlx/TcLJTkyusbvnGejnCojnYYnUDRam2fesUc1b0hKi8UoUrDG5Mfd1JcyRac3zQZXucx7GW+jkyPIIHVCbtpwAjhW5V4d8X4GZnqG3qjxE4hBRsfFwvXFCD4Q9c68QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(8676002)(4326008)(66476007)(66946007)(38350700002)(38100700002)(508600001)(86362001)(36756003)(6512007)(9686003)(6486002)(52116002)(26005)(186003)(6506007)(2616005)(54906003)(6666004)(8936002)(5660300002)(83380400001)(1076003)(2906002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MV6gw46DNlf7sPR2iXuU65v0wfiMldYolOsVxV7li/HlDa0nmZ7qCxZn1Y9?=
 =?us-ascii?Q?/I0y20SRizxVEVlbFG5i7igIRkeLWPuEZAqyvnFQGVEdgQuYUA7C170U9iis?=
 =?us-ascii?Q?lIs2p+oQ7/LhQ+EfL3JTJJ3XGpzxgLubCm7bQf+rYI0HlvQ0Wz+5oY9R8UDk?=
 =?us-ascii?Q?4dQ2bAnAQSAK5cjtQivmXx0LIVSEJ/2qWJ/7L+NvY7sDr9nrNcpbeSNgO1E3?=
 =?us-ascii?Q?9kflDMjAWgPyhcxM4bUFKrsG7lMjHM/E/OTorVaOMU7tMAZuiYKccwzfaGUp?=
 =?us-ascii?Q?2v89k+56Ucz6//FyNrvimwcZ+EzBA7sCdrASAtzOlRW2VeCtLI5Bjuyuo287?=
 =?us-ascii?Q?eLbdA17BTauVnSYD36vfd+/ep32vXq2XKvNhq8Nog4ZkXpeOIdV/7KV3zEOb?=
 =?us-ascii?Q?aQx+SVkFLZYefj8FpKFaBtSdZlID82lRagIioYGK+o9oJdBuyF/5tpmWa8vX?=
 =?us-ascii?Q?VmpqtTdV3tUDFGtPIHv9QClFkzvVNUrue8uPVQxd1AtH7+HvzeYkCTSd7rUu?=
 =?us-ascii?Q?jvrnATgSv9+Or39WxnZYAU4Tx0pjCnD34Oy52Chj2LSVgMu2oGiTDdFxvKYC?=
 =?us-ascii?Q?nw0Bz/f2joBSTqTOwkelbmkMjkNSPgLz0GjPHth5daNCYQERnqYCW/o6fWFu?=
 =?us-ascii?Q?19mvXBngvaPftEoS6i6Ir9Q7ExZisdhnyYVHe7OkiLhJEsCpWwl34HiJlfYZ?=
 =?us-ascii?Q?/mHNMYDmMLcUooZb7ef14uFUiq/gKcZ5OIzoaPHt8lplzQyzw7LhZZsn/io/?=
 =?us-ascii?Q?Zj/5PairQfz89SrG2GrRnqBieQgrWUrpg48iEDxPftC8B/DZ9Fu3Kx2XyMzc?=
 =?us-ascii?Q?x+0lM6+8om02jFLkfa2mK4xJ3zBA05Do2QG7sOMFqT1OwZGrbSW9OA5rnSmF?=
 =?us-ascii?Q?yEePXr0P3FEM5g+d/KArHVoAWDLvyhwiZ8S3EiAvixFdW8tZKZJhzFqYdm4E?=
 =?us-ascii?Q?yOtMnpQG6Tz2Bszrj+4tLiotqnbqvd1iMBL0ZWVwu2p6fFPAnE2dQa7N/gMP?=
 =?us-ascii?Q?+ydj6YLytThL0feZPdlGu7bmUtOX0Yv1a5/2A/Q3XCw4W6D1B0NeWO6r3eV8?=
 =?us-ascii?Q?fOcmQ2QEDEcDxLAtpXTv3AFiVZsqdgyuF/pAF8oDsdF8gHwSEDK/nJvdopL4?=
 =?us-ascii?Q?IgqwO53AD1Cw8kNKXOOAjFheTZVf80ouGFyRAgfC+R386atY5AywOA+LJUPq?=
 =?us-ascii?Q?bnJVIdCwc5Cb+I5MTMbCdZqI3/4HvBZ///5s2t8Aav17UEBzvzuh+RCU0x4D?=
 =?us-ascii?Q?P6aM5ds6PxBiOe6dRhJnnsswHGCSCdzr4dtGWzPGG4pqj+v+w/E4iqCUUln5?=
 =?us-ascii?Q?Kzq85mzY0J9j4GB5ZAPd1XmYK+WlCN99414qYmciJfx3+naJD3uzl/p0hVx9?=
 =?us-ascii?Q?gT8bm6e+ID8ZsX9VBOBbEKl/3LvC5vz5s21M/6u52oM1H+Vas+oKn0JYHj0B?=
 =?us-ascii?Q?4YKbnNyWOiWUWo0X8yrgn4iYXaIi+qpZ?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c9e37f-e8c8-45db-b3d7-08da08a469a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 05:59:06.9425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoEqnC2ynirtPCGuZCovj7v4XXX0JVgUkxF2bOytBHvkv3izgeBAl4dahFP0PHqjHrc0O1mPEdFD6Ih2MAJqMw==
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

free_irq() may be called to free an interrupt that was not
allocated.  Add missing 'if' statement to check for
exclusive_vectors when freeing interrupt 1.

Fixes: cc68f2177fcb ("VMCI: dma dg: register dummy IRQ handlers for DMA datagrams")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Bryan Tan <bryantan@vmware.com>
Reviewed-by: Rajesh Jalisatgi <rjalisatgi@vmware.com>
Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 6596a54daa88..57a6157209a1 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -862,7 +862,9 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	return 0;
 
 err_free_bm_irq:
-	free_irq(pci_irq_vector(pdev, 1), vmci_dev);
+	if (vmci_dev->exclusive_vectors)
+		free_irq(pci_irq_vector(pdev, 1), vmci_dev);
+
 err_free_irq:
 	free_irq(pci_irq_vector(pdev, 0), vmci_dev);
 	tasklet_kill(&vmci_dev->datagram_tasklet);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
