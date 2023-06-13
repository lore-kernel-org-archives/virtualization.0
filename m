Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74248C88CBA
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ADC360F94;
	Tue, 13 Jun 2023 01:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2ADC360F94
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Su29HJ/q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=U8MKOLjx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmdf4RSbe2e7; Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1F90D6002E;
	Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F90D6002E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA779C0094;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18CBFC0093
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A06E4402E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A06E4402E1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Su29HJ/q; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=U8MKOLjx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ut1sRI7F2EEI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89511402D6
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89511402D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjTP020945; Tue, 13 Jun 2023 01:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=31jU4UO5PU4Wwi5zN2xPC3c2z/3AZgubgtkEFp8h/S4=;
 b=Su29HJ/q/SzViosFeXYyK7RnXlWX8PxfR2grfBfXq5/gwlWABvU1uTfpaamxxg3Piplu
 mCGDQ78yANJ6jDt17cxZNs2le/12zqodaDsXcDUBFlVc24DvtGi1aKN1d1lICT8d5FOg
 bcXGHQBxcH57V42U0f/jV/lFdYAJ9+ofnXOOh64uhepQTvhxumtCGQ6TKF4ODPLMXcXy
 2ImoyLhJuNRo0j6K17DOc9XEOm3xjcCZZkhcdOugCRo2gLumHSVgZs0jJ+vBAyRo3JY0
 vWtix9E4DPMbizoWqZiNYMgX6HI92Sou72s02e5UeUnqUoHuQahOdEDvBLGvHgYJj2Tb xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d451k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:20 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRK021613; Tue, 13 Jun 2023 01:33:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBG8w/Uk8pJ9UhSPzJfeXwP2KDSHvUT9UvV2tkCwWzjy2SkLfIwP2iGUh8l38AnLEOsaX3ZItSP962kheMzt8py87CcQ8Ah60EZyTtFSSmHGG1hpwR625BOZvn9DxHFct/igsSY2SbeHhDfmtKk9vX2vjnpB6aw9DnlpKaAHSea9NS3nVyMJlJGhSJR0r0Pa4u4VASZGQ/UEZtzBIVTfwO3nlb+b3PqgG+TehIhoCN9OZ5oCzn5b7xgqvBakTI7uzc11jtIUccMp7mWwWSyrD6a8ajqgm5+9EBiTB7RuZdWfsgTseLEFrPdXWL3BnYvj/sjR6m8uPI24f9cWcm1jIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31jU4UO5PU4Wwi5zN2xPC3c2z/3AZgubgtkEFp8h/S4=;
 b=TYeZFWrtwgA9IlSUBdd12TkvpOUsTiaxaVyuMyW7TsW1XoON0Lk5taw3e+NinDF5tQWBF0xkB8brdxsFyMhE/sY0FSMj3QV59dMlFUxxYwTDKNgE623JV3xtmoQ5lnUU27nAv94g+GHG1qZsEXtiPnG7Lwyy3fPjcvb1prRxAO/fHrX60d8gjwSMPRhWw0KEMCW4lhWMdPEyC3IwklQ1Wep+9nR7VpWEZlQz0/dcAO1J0mTu5l44Y1d222vMqLcrEnJ7hgQGTpDCcbL7UCeGRFi8oOB13gUxjafmT0CDyVcUb86ttAGFhFsHtAtE0V5TzOy1nBrtgfoc74SoYyurWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31jU4UO5PU4Wwi5zN2xPC3c2z/3AZgubgtkEFp8h/S4=;
 b=U8MKOLjx/V/BgLPu9317cxFEqt9OoGyCUOfLoEGHfHvBY7EpmV9G+s0/e4IAQRHBLduEZlDwZJKHUxHEzhR4rHc2LaRpkNpzVBEE0frA4TAw3gkT4Vo/7nOLKqIHL3ft+GHfiEuzXI+GL5T8A4jbIT1pL5fa6LQmRtJDbLc5Hkk=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:11 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:11 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 12/17] vhost: remove vhost_work_queue
Date: Mon, 12 Jun 2023 20:32:43 -0500
Message-Id: <20230613013248.12196-13-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e70d131-0393-401d-dcf8-08db6bae263d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fZRg/uMIbHTY/9G/yzLGXwuPcPWqpjeOA+NQsC0gu3JvT38VvAX2iflA4iwk/zhX/acKqNBCSAdGlP1QfJnSCCiKt+YUXg6NSQ3fy6EK7z3sma4vAIQ4A8dHt0pnzklzqw39VRomt4eU7gucGa7y6V+q72ZQayY9y2lqFWcw8i6zTM8kE/9UQTwEzUF68symfR1vMbRRBRyK90HDk8GYAK1OeGdRwEdwP+kpDx9Jr82F0EAv7jY69Qwf4vTBm7D3bp66KpItEM2Pe8dDM6Ujgqnbb+3VdkfEBsexl+4ekm+j00fKPsFG73AozWh8RYNYgUZazibF8NKkIOaN3YfttHeseDXkk92utYuhXp1UKJnbIl4ul31/hEU4QCURqvLualjGwf2I7f9qVIHT9N4ZbSJyS65OOfaljB+VM9vJ18La9n5Ro8dROqiOcWQCWQe+4ZthHrEH34ksNH3KUXAFyVCx+INT+fzZNS/Fp16+SnDBl4INhqkNrfrk7H4y4t18Ryuhp9b4EwrRs1FCFFGqCTBlIecFnaCYqhs7LLVD4BvRCfWol0rwv98fJumfFVX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c67Lu5Jo/IyJwUdhmtlxVeZfbmUGn3vfQ+S/rk7J/kfZeF3r4NF4UyXK4UmQ?=
 =?us-ascii?Q?0nTQRgCis5+quhY4CppPdWW9mkh0wJict2B1QuLqtWX+L7fECVaVRNskWsDQ?=
 =?us-ascii?Q?x5atbi3Nfo6Dj+V/vtf7dKIzE3sAHkTzr+W8m6cZNDHfHxFKUQYCT5mHvMcn?=
 =?us-ascii?Q?DKCYc1IInKatBOTV7AIJid0UeFobaGfscK02Y+vOzltocYdqM/oQPMcMFzgc?=
 =?us-ascii?Q?QpAuR1/hirBjBweOkEwo2Ck8AkiqwxWqHg6v+7jeUgtLt7YGtGwR23p9yGVR?=
 =?us-ascii?Q?uzBdAkCCEy48CxIWZdVAUtmG8UYEYNjXZAXvLjZrglMTqcBQ2rTk2Dx9TO01?=
 =?us-ascii?Q?Hshz+1n+hXsx2wRHMk1cGuV757SJvqoaNwzc79yMqu0Hqr9RDnXlP3rTW3Pi?=
 =?us-ascii?Q?EnerQ8ks3LWz72or8QV7+uMQZdNJcRALSblp6ODw72x7Oqq+K4AzqErHxQye?=
 =?us-ascii?Q?92Btl7znVCtn9wrewYlWzEk08xJTP5BXmNhzcuLcHg0aZYQs26nZcKgh2ANg?=
 =?us-ascii?Q?F2vx7LBon2LVIBRLbMajlYt8FVpof0M/LBJmbTiCVAFmUnUBM/+sv1FNNjUp?=
 =?us-ascii?Q?NxLCCVIP2X9VfITLzaaoMuXiGkH4++Y7px8MkVfpjFvMYx3CinZ824vKfwlE?=
 =?us-ascii?Q?MD8kLI+31PAbsXHXE5vOJa2+NL2Pe/zL3SWQjBq9oH5y/SN5EvUgZvZLgJxC?=
 =?us-ascii?Q?TmmsodydlS5WzLymm5eZajbwXbkTmHPizK6oAZEyNz9LUXbZ1shVa3HxQRVV?=
 =?us-ascii?Q?SjnbpVeefGlgBVO9wEj0EavZRFCT+I0B/IH6UxR+uzyl86BwbvGJ4xBf8qFH?=
 =?us-ascii?Q?w68qwU3fr3h7UBJEfi7CuK/Jd1rhW1I3Tu2AYY0TNtaSGA+xnPsvxwqNzTZ6?=
 =?us-ascii?Q?Zcrg3akJaSvvh0XUr1hR73uBi0Zki0Qocb+1iguy3KO/H+lqK/vyasz0h5GK?=
 =?us-ascii?Q?cp838M2p21lWcLYMCbJAHR8F1D14SfVJ9avIy/wwGoPaAyGcBm5RbsFec1eo?=
 =?us-ascii?Q?UgHxuNe4tF+DYESPeLxiLCIFcbyXduhjjhRUIhwC4/knkl96iWVzePTsdeoP?=
 =?us-ascii?Q?l/9WNuN2gWnZqR0fVx4oA5bqCPubDfAOT/kSjTdjaAaeLb/lQuSdUHxSkhAW?=
 =?us-ascii?Q?JCwIMpvBZFINrOcl8OUWTVQVqHuZERF7Qpsr9U5NADL27HsiQrr+wlg/ApNo?=
 =?us-ascii?Q?CQi7slyebwoK0FP6pty/8ifgC8poo2R+OeosGU8dk9Q+wfHVQCa3senFEat4?=
 =?us-ascii?Q?7odDzwoSsKOnyOaJe2QChhLiL//rhsFU9dpxu5AP6IVn1CimJ3d9FatiKizU?=
 =?us-ascii?Q?KWr09XPmf9gEv4HnwJ47a30KjkqzAE5pOOzPXypzod3Is0+iXh339Wopx0tO?=
 =?us-ascii?Q?7Ui/zVzkp6LvdEAfCD84iNU0m8IjVSxeLeEP+HMqw5SpsBY4UvR7NOEXl5K3?=
 =?us-ascii?Q?t4+yCaBIxG4Z0Hbo2qoSFI6sqhPEmweVooaaLAD8cC6FODlA2YRFOPlAElJJ?=
 =?us-ascii?Q?9g2ILF7EKn0CuEDcfEJtyDAhkpG6KE87egdDXPI4ZllhRaw1AzujL8pOlrMQ?=
 =?us-ascii?Q?YPf1zD8j21JFB1wUbt0i9SqowW9TbTzJldWq79/0sHN21yxGyvEz6i+HtTyA?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J3hJk0LpzUwT2mQu8A1JtU9gvZedi2HiBRgE/rTuXSYfWnZSi/OIjBurXXt6Y+PkpTtHSI/b3uto12boXUTYqMzQ//RDa7VNk1nozlEJlxI0abwM6KvvnAJp8/ejLwyulqHDcgL6JcvRtPByyxoCyuPLcyXddvFjiYR0gFNpG7vbbj3gXGGE0q4kk3yZYki9jqL1DYXJIY2t4OVFh8yIf8KDU1nVKULAEzjCc9ApPPIFs7nggK5c6F9c8P3Py4EgSbZqLCm0L9jbyLZwW9Z6uHzIUjz9G+6qqzrb3SP5pp96GspNVH+6jbLN+tmLbYYPe7SoPPvY1/H+X3FCvoLToPqbEcGCLjdkl6dKVa7UDGjMUCSh6G85bI2XSpUDfjyrwtA+34CKcMc7BloNBrBXYwN+asKjuXj/nWNHar64u8Zk2bmw4vx7wa1wz7kjSISluenOHAQGK3Bkdynude1iOCD1+7g7nDzKtoqBursoWc0/2z3DokbqQi5ObxoUrQ79vV7DLq34LhvFJOl+2IDnKPWDrQ4iiUg4q/dPv17vA6qJ5N8+ANoRXi044/4tPad5BruMoo7tWqYun0nQVFkjR3KHK026DZrnHj+0aIcNXGXlBxnLtJ9ycXare/6q4Ki/82Z4bz48BzyxP5hpIWbksI29IrY5knUzgcDT2Vi/BHYC7PA0wFP6M8/ht46u8K2lQfk3XOtz9Yg48aeJVOpDW1qG68ASoG4E2Y4Z/OuRFCyW1L6ntyJgZ00wVqhGs7QXMB3AZ1PM2lJcjXjKDvrRIHlmJwG5ig09kmZd1d1AZR1cqM4qLmrhs2gn67TYz6oP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e70d131-0393-401d-dcf8-08db6bae263d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:11.4082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq2z42GGB0MjtgNalmK8yCsOAG/X0FZqcq3wrJHb5b8dIHNuEnrUfQN2x7ya9RGKrsmSys7fxfHFXjr+960Yd9hrebN2WiTZr/vLK2+SGJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: DUj_fyqf0cxpRZ72sPJUrWssnplTGOY4
X-Proofpoint-GUID: DUj_fyqf0cxpRZ72sPJUrWssnplTGOY4
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

vhost_work_queue is no longer used. Each driver is using the poll or vq
based queueing, so remove vhost_work_queue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 6 ------
 drivers/vhost/vhost.h | 5 ++---
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9623264bb3a7..176d5fcd4b58 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -255,12 +255,6 @@ static bool vhost_worker_queue(struct vhost_worker *worker,
 	return true;
 }
 
-bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
-{
-	return vhost_worker_queue(dev->worker, work);
-}
-EXPORT_SYMBOL_GPL(vhost_work_queue);
-
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 {
 	return vhost_worker_queue(vq->worker, work);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f44eecd4fcf9..b850f534bc9a 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -44,15 +44,14 @@ struct vhost_poll {
 	struct vhost_virtqueue	*vq;
 };
 
-void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
-bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
-
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 		     __poll_t mask, struct vhost_dev *dev,
 		     struct vhost_virtqueue *vq);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
+
+void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 void vhost_dev_flush(struct vhost_dev *dev);
 
 struct vhost_log {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
