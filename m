Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE342C433FE
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:32:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822306109D
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 822306109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4821A826DF;
	Tue,  7 Sep 2021 07:32:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B11vPT6dVKOx; Tue,  7 Sep 2021 07:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E92AF829B6;
	Tue,  7 Sep 2021 07:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C01B2C000F;
	Tue,  7 Sep 2021 07:32:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36CD4C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 236C34053F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="sKtbVdR7";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="xt3wQYKa";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="kW7djNC3"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsRcVH4onX1R
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:32:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DE8440536
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:32:37 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1874o4tu014901; 
 Tue, 7 Sep 2021 07:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tjMSRucp3xNXzF/CWhUxH7yncNmcV+FA5hk9p9/OWBQ=;
 b=sKtbVdR73EPTedHXdk6o9UHFSRJzfK1aN5rOtvs7sFD1yMivlovXSIGdajDygcuOawJN
 kCNiueuDrHbS4rsayYOn/m2C7luyo8NDnPcJ7xZ1xqvcZ5BJMIFDksyngqqJgfIn2Qvr
 z6BXJ8kghcyrq9+zvlsRAA+AxHHwYQy4CdmlRctkzgUFbG2MZZq2jsCqHgdOam6Rzi81
 pig50wx6MOuDpcMIPGRR/OHyGic6bnzsExBu1bE4J1hxS66zW+atQAqqxV5yddZzM7IK
 GX4Qh9bG/c6BOJhYVtZAwcgD4nrJRaAG0g9WT9TfWp5mhCY4Twu1mq08z1Xf0K9VA6to wA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=tjMSRucp3xNXzF/CWhUxH7yncNmcV+FA5hk9p9/OWBQ=;
 b=xt3wQYKa6+ic6FH8/xetnkpqwGfmDq7cBsFbMrkfuCcjeWMfxpGl+X2EHNx4NO1zjY1O
 hrHhKMP9qTduoFCkdII4gPq2CkD/1ZDgRVQTy6oWvDfWJskHnayyAMqdM22n4+4LGX0G
 TZvjcj1tz5olEEGYy+a9f4l08052quhiDFqBtYmN6FqS8lUXTPlwABy28LGcoayirAUH
 2VjPnmuX7WtjyeNZA+iWQgjA0kQU16zKnpuzPMQHTmXY33ONeNYHABTdMC3wx08lt+hK
 7O5nLdGV3fDysLpXPXNHJ5ZGHXPCMRl4v2Xd4jyF+7uJ56P3JVH2o3Hb5Lx/9syvm2FS jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ax1de8a0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Sep 2021 07:32:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1877Uj61120161;
 Tue, 7 Sep 2021 07:32:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by userp3030.oracle.com with ESMTP id 3auwwwdh6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Sep 2021 07:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frFNr0NekENpOJdFiDnmuTaXIrub/2BJlRL4hNH9PgvlbS2gi4NUmKOWEsm6s/lPHgLm77J3g8tn1FC69lQEH3SPDHZE0hhe5l8GSNsLMtugs/d0U/9MjUuI8LRNNnrh0B+uerUDMcCBjX+xphHnc68f4yxoTBRtEwTp1/bqGi8F/BzLQ/oDvfwCQiZX+7ElOSEFD8wsDsdSaTrdN+IuzZypKUbBJ/WcigyYm2/XY8Z7PeHzB1SG/FnU1WRFXvD6JIMeUj7fsKZ6H7RqA+NpWPVYXcsbvObdVKtUML/n1LP7X5SiQ9iE0wCkReG10PyE9aeXjOZEw/cpKaf9vktnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tjMSRucp3xNXzF/CWhUxH7yncNmcV+FA5hk9p9/OWBQ=;
 b=KZL1l3lIxnOH9A2eJ6cDW2k6C5AYEHYanX4MWRAYrnxB36EDir8p5q1pDLmHBFMXtTT/FzEMPECGQBBu5KAdbQDKl65dAl+bVIWdUZP3UsZJi6qb7f/VQYBdpySlEvM8upjpex3Gob8QtD5FuUnpYiSx6GxnzEvKs8bpxIyqQdeizhW3sMqNtaV7IH/euCqiJa3SlN56aDse+n1/I553YarFXEt3oSCH4NdcEjFYwW/IOljOjDeOf/SAsfy6UbxpNWYnZ0HbSHJNQDEeI/Cph9HDPxOHs8NUFe02px/gAkmq/wLPib5zf+zOmhbrsdKlmzZDoec7OavxyVL0PuKZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjMSRucp3xNXzF/CWhUxH7yncNmcV+FA5hk9p9/OWBQ=;
 b=kW7djNC3bMzPkIegl/YuiUKIae9y8EwhyJIwtUTgyBOXT4xvfjPUF3A2wf/+47Tp74xApnnh9eDxwZWQ6v1/fAb7qBWo3cBjHFurcTeXUdom3N0bBnLKSB8feNEjcj1+LQFLz+RQo/H+qBqcP0naBl44ZGFEPCSotpCbhj9IZtA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1775.namprd10.prod.outlook.com
 (2603:10b6:301:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 07:32:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 07:32:32 +0000
Date: Tue, 7 Sep 2021 10:32:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] vduse: missing error code in vduse_init()
Message-ID: <20210907073223.GA18254@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Tue, 7 Sep 2021 07:32:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e8fc4c-6163-41b1-c974-08d971d1a73f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB17759D5C254D6FB44512FBAC8ED39@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKF4AEYyxN6+uwrr8YTrMoGzggaNk0y+6e86L7ckkK64fFv6gLV/INPwjXgk9ZJN8ztM0SDwZxWps5bf7CtwlMsrJ0nMhAhLLF3Gq0YFAVVn4y0r5HyfrHzGlVtKCJIC3Y75BOgcX8X/5vysuQRm6b0jKBy8+o/xW3NijZeWU5HaCkhzqk2DxkfNfBcHgB8DiQMXFhZPhZcJ4dfWpww45gXAMv/zxs0DU0QymQI4SkBkyPcGoetM8NQXi3MMFTuC5/STRGbZ8v/i1705GzzZm6LcwtcBoxrD+Y456eGOsQkTX9tFingMJ5Z2d1ODyQ7jUY7iTyxUIz3v2TqGVstsh5VPUSEcHotRnfny4qxxaZAAI1q5Wwcnt+XncR0GSpwzRIMCmUMtz4+8oIby3eAiM5YJtwAyfx+5CWQQMV1L8tCkbC/5lNiRePGMYghfsQEwB/hiijbla1DUE/tfDU/onEPuYOfKTm2H1IrXc798Q36si5PT+WEq725+bQkpNOn1FntyviwqKgqLApylzlXk8QNYvbVn2NsKZVP/dSt4GJ0mVlWWGcSn9Tav0MAWyeAOD76w+jZdo3tZpwrN5o0YaFj7SAY5WnpNxyhPjGW2siTvm1mihJjSbL5jE/WGq5OjG/XsHz9CWea47zJlnF+qkfvLJopjwI5Bdl0eDVZmyzgat4F8kcc4h6z4oDtoHJ16CisGiqXtLTdaA9qtT+brjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(38350700002)(38100700002)(4744005)(66556008)(66476007)(66946007)(5660300002)(508600001)(55016002)(9686003)(6666004)(4326008)(52116002)(110136005)(2906002)(6496006)(33656002)(44832011)(9576002)(186003)(8936002)(8676002)(26005)(83380400001)(33716001)(956004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wxsgw2yc7rl2XRPigIVG7rBheNOlckTyrmKkB+KtW8e/0jYeN89CNou8bapw?=
 =?us-ascii?Q?Dks4W7KKigED7ycmMZa32PBouX84yMlf90jMtbm6M4O1vOvNNKiwyxtIoTUR?=
 =?us-ascii?Q?wFFPeobkwGhRUulxeOqFlzQk9ajtsWMLDuh4v/DpHAiBoD9QM0NhpVAed+Un?=
 =?us-ascii?Q?YShV6MAr3BkOPdCzYl/j/AOgT6GmgBjEaq/53uUl4f6RD8Dmcd65HZhQoTcN?=
 =?us-ascii?Q?2oqvT31HIHe3ZLKBiZpeBUt6yRcVhFBFEYRAImsFMjflQqH/xY2NtQGTAIlU?=
 =?us-ascii?Q?KgjO86eLolotZjVuqt7btnynfMUL7N9U8v4v2d9C7WU6gihQLOg8XkRc68kO?=
 =?us-ascii?Q?wacLqDRD32u3hO4QDppTEX8bad6qfcAO8Or7eTZsjC9ei+Zqd+oekV0jWors?=
 =?us-ascii?Q?v8wyHi8BlM/ZFKAYZFMBhbizAVJzBXdomckypdAol6pDjFDfJTrbMXqfLUok?=
 =?us-ascii?Q?Y6U6IGB4dLwhzUz2peSR6EHTCeallep8Wz+dOT912DSDNhC1tdH4/JjD9yB5?=
 =?us-ascii?Q?9l7pE/HFqYAj0F3EY+biHi3esKG3w9d9nDGh4hV02WoVF7kR2xvz7FHPVQVm?=
 =?us-ascii?Q?Z4961SFdNme0U6t6TSf8qU0a4SsQHnaOvTB9ZDkCgD4kTHzP55qWi4oET0MH?=
 =?us-ascii?Q?Z1H1N7jhXIiso7mpAP56DM6Ya4zUIP9hW9oUASzYCyszgIR0KVdt9AAI+gQP?=
 =?us-ascii?Q?AKb9MCkGR054/lPoAhdfioisrIQSnmFxosR8i4RELeK0WG19f7G1+G4iuwP4?=
 =?us-ascii?Q?95G5rcZ2J1TSLtcKn8TJaYNMltePQtfuIzI2fF7TObiY6G+W2mv5XfLz/BOH?=
 =?us-ascii?Q?110FZR5cTK4+v93MIKrdNSyZ6pzChPveXQRi4ceEQEF1NIJNIrmHjLf+hAuM?=
 =?us-ascii?Q?k7wLzHBSK3NKdFIvlHUfbe5vwx5THhG2vmmyKtAOsXlL2fJW8TRPHsJfr/Jr?=
 =?us-ascii?Q?wi0Ur8R6fBMqLICPd87EKDI+sMTsS4yxkTx9OTWnvfj2K3g8DsfJCGnMcFQE?=
 =?us-ascii?Q?gBKsXiEVuDDbSjhikiCfc6Kve3G9f7sOm3DiF0WiZlg8lMQseP8Y36XkwOXq?=
 =?us-ascii?Q?uywDphLEXS2NlCms3kiRMhjz4Oi0I2+tNZdwwX8H1U9H3u/f/v1/jR3QamVa?=
 =?us-ascii?Q?7GFQ1eESogjKdV0chSdlP133t+G0Dd6vUHVgfjvcPrrGJfo6pdeEf/zrjK1U?=
 =?us-ascii?Q?n8BUqOeGmrm9ufuQpriQlYCuGOxZpY2JPLdl+01W5Ga4EB2oztg2ayqs6beW?=
 =?us-ascii?Q?G647ILwiP2HnM/ujMwgV/yLoncu5jFPCUczSwOWGugdSI+jrCYvFYsee5D7L?=
 =?us-ascii?Q?UNnNIM+XPEhBETqmme6dL1W3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e8fc4c-6163-41b1-c974-08d971d1a73f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 07:32:32.0703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7cmEElSfmG/crG2xPAhUNKC5kbVn22yg5Zy74MdCYlN9HB7Dcpw1kN8GqiK73TaWjpQvrsvyFCfg0vCnDnRktag+7Uxf6o6+YSWgRhdsvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070049
X-Proofpoint-GUID: wneSwl-Vg52DENdt8VX4ORxGZ4JVJ1Xg
X-Proofpoint-ORIG-GUID: wneSwl-Vg52DENdt8VX4ORxGZ4JVJ1Xg
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
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

This should return -ENOMEM if alloc_workqueue() fails.  Currently it
returns success.

Fixes: b66219796563 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 5c25ff6483ad..fcd7de8dd1f2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1593,8 +1593,10 @@ static int vduse_init(void)
 
 	vduse_irq_wq = alloc_workqueue("vduse-irq",
 				WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
-	if (!vduse_irq_wq)
+	if (!vduse_irq_wq) {
+		ret = -ENOMEM;
 		goto err_wq;
+	}
 
 	ret = vduse_domain_init();
 	if (ret)
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
