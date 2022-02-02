Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363C5C4332F
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 14:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E04EA60FE7;
	Wed,  2 Feb 2022 14:55:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id spZcLglsb_uH; Wed,  2 Feb 2022 14:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81BC460FDE;
	Wed,  2 Feb 2022 14:55:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8FBAC0078;
	Wed,  2 Feb 2022 14:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 137F2C001A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C174404CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vT1SU3bBOfff
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 734D94058C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exkbcWJJe2h1STt2t+pRnajSOEUtL6pDd8//jfb+4ymK4FgGxRPZNz2WhmgeKfh2T2z9wHZsXWdZZwvBYxmcyYW0/vXKaQVQmkTWijAkmdKNvZWJ0gtKZG3nDOgMohH5CGb0H4BAOAbzaan4jB9BaSxlGdxpBJglSPGfM3lv4/jfCDuglVORFqeFAhr+Y/swy513EP3CkcM5fb+gZXo8KBu5V9V7YEU7o0i3VJiex+0kAcU2gSQfK2iCc3kX8K5jxfwBmSIrtor/KYzGR8KW5wvWR6BPB5vzzbg6JXAxgP9v7bdM1Jz/NA7au02rEIAWmKOqfKqKSzPQ3OpkKlcNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26D7f31clRKoGd7hQIFPAj/GHByry7JUAE64TCDbyoo=;
 b=iZduUMr84heHDs3ZXUwlHs8NO40p/uCPlREGPlmsQg19Ovp/eKcotDhPdFdK+IM+ValFhu4Ln+xE6qvoDL66kPiTMkUP3a/XlBuMITBeyvE1klcqV7IJoTDJV266o2kGStM1KNK8+jZRh9Xc3u3Qvba3eNemVv7SOuvqs4t8k3vLzT2CDV9oxq7G4BJZBvSVb42Icu/QZJ87u5I5dqMiu4f4ownEwmPf90QXTsFeRY8SI4Wty6qA5ghb4QvNBREsu2QXifArgh9Am07ycXfqpt3PWbZ22rd+tgw+oF+oK5BXpGDXZuXJYxtqgAEbcjqkEOL197GUwz+iKRJswbbPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26D7f31clRKoGd7hQIFPAj/GHByry7JUAE64TCDbyoo=;
 b=bHRgzbWuTMB5yhdQXJvADNuTVq0LLW943oVk2psc6lCBRw7TU0U437IXbxzK41y74ycIhL0b9hceTssC+nZ+4l4C7b8kSOI5fB4lK8f7bv3Q+DGU8+f/KoF4OQDZAiwFTIYDydYCqw/NPgx2lilzNIMFRmZbdMXcNC4VdI03UaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by BN6PR05MB2803.namprd05.prod.outlook.com (2603:10b6:404:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 2 Feb
 2022 14:55:14 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:55:14 +0000
From: Jorgen Hansen <jhansen@vmware.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH 3/8] VMCI: dma dg: detect DMA datagram capability
Date: Wed,  2 Feb 2022 06:49:05 -0800
Message-Id: <20220202144910.10349-4-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202144910.10349-1-jhansen@vmware.com>
References: <20220202144910.10349-1-jhansen@vmware.com>
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a384e9-84ba-401b-0b99-08d9e65c0468
X-MS-TrafficTypeDiagnostic: BN6PR05MB2803:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR05MB2803BE8C9DB3D1C1571F9210DA279@BN6PR05MB2803.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lb/e7+Uh2BJzPcH4O/2w/jm2xM2JeZdMI+0mqw2ftvsDrJ+9qzef9tXqRt/0K71VJChrZGhJyyUYae2jKJ8JHhC0vNg27moWgKbGXvRcDMZLCChXWYfKKJ6fSsQ+07RP2qb2w8hFMuP1IZR+PGfi7WrOHbkZ+TH6b324OgueuyiXafI8gnBL25DuxoyMtxu7OwkNGC1PlJPWU9s8WEduARbq7O1GmOdYWA2AhO8SablWmvBv2JTHdCt/F4bTF3JxY50FtMGmVIDzT6q5Dz9wCp9AqffacIxZ5N1B11s344wDv9axLmHgMoGhOK8djvRMZ58yHjMFsfBFM5Z/KI1BxpzP8TCk2P4wcgkoykx5LLnMty5OSSs8Df8szqpQnqKTw26lBb93dEMwZbkJAx0WoCfgu1r+qi9GVCOyiEJdxlUKljylK0WPJHqvIwCYilwgO/M7/IO2WhZ5C5xbzo1BtvtQ6EnvWTRtBOV6z8ouBU8EZ82DNDvpV5siEBzaho5B3ZcssEHz5PC30euLMfuxpF3DlCAwfamtM404kXxgOzKp9cET8SEfGlIAy8WAzU+12o/xb+uWwHoOj3rVbrIYBMBexbjAxYqwRRDH8ejbvNncC/9YMzlTxog44zaAc7tMMWyQL/YQdLcf6Dnc/eoZTGUZhH0GU3YTSh+nMEq6r3fFx70MdeLTsaZX2wkc7EtnCSqXXLmGQqRPks4UvUlXTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8081.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52116002)(316002)(6512007)(38100700002)(38350700002)(5660300002)(2616005)(8676002)(8936002)(54906003)(4326008)(66476007)(66556008)(66946007)(83380400001)(107886003)(508600001)(6486002)(86362001)(1076003)(36756003)(186003)(6506007)(26005)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6T+SbrF/bnKMBYf/w/mSkhFapyrrHlP+C6kFMT5vISOQ34kwfLasZDcJdMbT?=
 =?us-ascii?Q?tVvxSFd6vZURcm1GXvpJE6qrzT1ppFqOw/Y6dh9mDBpQL+XBQxOXNEoLJ7Nd?=
 =?us-ascii?Q?TJgd5OSZ4DaJn43sxQQfep3ZhS6a27PftuAn7KjUg6JBXKtLrd0iFlM8QaIJ?=
 =?us-ascii?Q?7AP2+7OH94H8yPK2Rr6eKo2n61JyxYLVrRKQBUsnAuis8iatEQfqUR1u/28g?=
 =?us-ascii?Q?o9cDdf4IYqIuu67B5N7U3W6KasqYAdQDjepPYjmFFRY/n2XbUTyPheOtBFoN?=
 =?us-ascii?Q?+1OFN5eNCIFzTXk2ewujr3nY0mfZ8roTRxB3As0xW21G3mbbHTPuJB6Ll/8F?=
 =?us-ascii?Q?yxfFo8WltuX7kPWeJYeoRXcXdfFk1FlvDq89a8VYbhDlBh8am5ZG28Yt7cZU?=
 =?us-ascii?Q?s4Qnbl0obNZZffPrgc1Qh7a1BwhZAXSAMIVms5Ci+4rmNryZBGqxlbLL8DmA?=
 =?us-ascii?Q?B2tn7jfWo7ArpOqDDetAph7pJwXItD3T0yCs3E3GPVlussMTEgYqWKHgcp7M?=
 =?us-ascii?Q?mj0paOhDmmIZPp+YZoX0dxTRzTrKbrVPnrUfxPolZoV85rIL8WiQtjd2yxtx?=
 =?us-ascii?Q?E+3fEjDzrdupazPNMxBq7aCMwWo5xR75n1PSEFq5LySa737JIWhdc9qO8BJG?=
 =?us-ascii?Q?S0OfyzfPHc3IH4BHEkl9Vs887kFXDUxvGudqOcXF96gckeDRvHYJaUoNmQkz?=
 =?us-ascii?Q?xS/yjDIifVb0Ix0f4PKmtaxHrMzvaOO4lVboUk2jqEtufp9CLTR9/4y63o9C?=
 =?us-ascii?Q?hEAMLAlQv1rV63MRwpSwdUJMHn7aTZn+Pgf9384MzWjCutyWVq0x3TvWIUMl?=
 =?us-ascii?Q?OIfUL6uj3sP4NVoXA/6hOgyLBTQQ7BSwRH0HwO3lzXW4Qaf+2/bu/uoxVOcd?=
 =?us-ascii?Q?5UOwXAfaXTT9ixwx7exsxtj1jCmAzsfrD9FE5cWxo9zX6eUdMKAp/V/1wNTR?=
 =?us-ascii?Q?cALXIEurCPwxZTnOacIqrHZtOnlZhz4wmslPpEONFeOm/HyqCGM3EOSQ81VX?=
 =?us-ascii?Q?ZUxx9K7iHCAkzukCqTrrDcA7KV0VDHeRR3pv102f5BbyAjEj6LtriIpT6myS?=
 =?us-ascii?Q?LDxrzPqKtfZ+YCdUCJ1Rodeg1uiRotW3BsrnzwS9TrS7Z6eYnheIPyDTnXks?=
 =?us-ascii?Q?tfx1wOZWnzhEzkMrcqN/Mm20yPfUsR+y4RJ6atiWiO27U8j5nwJrk9LKutEf?=
 =?us-ascii?Q?ef5ZzWsv8KVtLgCVk7ZwqoyujPJ/DmbaFi1/v6oQC7HJE3qfvXWZu41+yn4v?=
 =?us-ascii?Q?fy7UzZKEDkNjXk6Pstnv6Ok3GX62a9FwA9aAQ4R7SPEnBhQKaoPMAHwCUmid?=
 =?us-ascii?Q?EWLcYUa78RvpB9nN6Mova94vT8QuU1/1jXxmV+lY0vRBlaUKBB2iataQhduv?=
 =?us-ascii?Q?3Z9yDi/ik/EvLL3T21ZOuIQVGzpKF1IUwmBYJFbCXAmtUvVm77dNpmpfwsSN?=
 =?us-ascii?Q?cU1i/tSe94ZQ5MdoPi6tpYS4A6+PF0hci7WTShfaIr4qROVKN51Qh0XWbe7I?=
 =?us-ascii?Q?3axoZpHlKzo1gJhpm4ymVXO2fOl7ZRqIeQ0pvSXpy+TV5zIL57RKi5yzYsAf?=
 =?us-ascii?Q?RRC9Q7C5xBJZ0iT8AnjZrfVg8iOgA6beK633Techp1H6S3OGSYxXJtJSMxJB?=
 =?us-ascii?Q?gSZTdx2fJwnAvatawhc8AQE=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a384e9-84ba-401b-0b99-08d9e65c0468
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:55:13.7454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZx6YUyyff4ZTtRy8lacz7n+w4OsMdQNTKVQnEgmGim3qdJZ5PteV3AfLnyhAfRTWEHFrw3hpuKb+xPbeZXU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2803
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org,
 Vishnu Dasa <vdasa@vmware.com>, Jorgen Hansen <jhansen@vmware.com>
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

Detect the VMCI DMA datagram capability, and if present, ack it
to the device.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 11 +++++++++++
 include/linux/vmw_vmci_defs.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index d00430e5aba3..4bd5891ff910 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -565,6 +565,17 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		}
 	}
 
+	if (mmio_base != NULL) {
+		if (capabilities & VMCI_CAPS_DMA_DATAGRAM) {
+			caps_in_use |= VMCI_CAPS_DMA_DATAGRAM;
+		} else {
+			dev_err(&pdev->dev,
+				"Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
+			error = -ENXIO;
+			goto err_free_data_buffer;
+		}
+	}
+
 	dev_info(&pdev->dev, "Using capabilities 0x%x\n", caps_in_use);
 
 	/* Let the host know which capabilities we intend to use. */
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 8fc00e2685cf..1ce2cffdc3ae 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -39,6 +39,7 @@
 #define VMCI_CAPS_DATAGRAM      BIT(2)
 #define VMCI_CAPS_NOTIFICATIONS BIT(3)
 #define VMCI_CAPS_PPN64         BIT(4)
+#define VMCI_CAPS_DMA_DATAGRAM  BIT(5)
 
 /* Interrupt Cause register bits. */
 #define VMCI_ICR_DATAGRAM      BIT(0)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
