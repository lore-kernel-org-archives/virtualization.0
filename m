Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3987BEB64DD
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D419D409C9;
	Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D419D409C9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=mUfJe+/a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=wVTyiQ1s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MHXv5f69sH55; Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 072F4409D6;
	Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 072F4409D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 872E0C008C;
	Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C54AC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA8B680C2A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA8B680C2A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=mUfJe+/a; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=wVTyiQ1s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDubRBVGHSED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 302B680DCB
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 302B680DCB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMrNg5029856; Mon, 26 Jun 2023 23:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=P4gyJes/CqL6iT9dOwoilwsvqdWGKPu7kjkUtEdn/+0=;
 b=mUfJe+/aedvp3kgA8zdSuaGMfeIuM0h2iwKzC5gvIXzLlmwt650wjjklYxclBwjmBNiM
 V8FNkJLADIIOdRoMxJD1PSfKrGgzfLcDnvxOjukp82x8xYjIk77A4IK6PTL6tJbCIkHh
 y1B+SYc4PydXMtQfnMfb00b0p0KPt2jvPaFldyS/jWWVyOEsIekF16K4ooDwuFsF2X7b
 C8RWFfBv63BR+djusTxfuozQNVN7fsQavN4lbyIreYti9XelQ8QQIiPIF7HSJXrVWKlo
 ElRPECYhPlnaH7u6WdsZSj/+k/IIvm/d05UHeNUdzf2u3jHtGKPANLEaNuHJZOcfJj2h FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e2139-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:31 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMFOj5026326; Mon, 26 Jun 2023 23:23:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxa88ep-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyZnUhJ7rCyULjKRD0DlA9l+S84nN7s2oLMH73Ukqbt00JIEZu7qX0FiNblKPlIhDNWXq8e3rJLecUulirDGi1OV+04yv68EiOehbM8HOkAvul8DItJMq+Mk4w4rXE8lxFnamy6H8qiB+JBIkWmCUgy9zWUty/j27hikF+OgFK1WTlT7JMO/4JKEKgzb0DWLLJOK+dLv+X4SZ5SrTkudHxgHYfV3xOSHQ/ikBBJA8Lh9pg0BlRm0ZyhJwjnjtP2NY4buKgDLI/jh5ufavzWL/kJaS/Cg+7iJSuJZMq3Fa8kCPdPniDgfa6XtZWSuWp6SKRD24Xt+tsqKb/f0OfQ7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4gyJes/CqL6iT9dOwoilwsvqdWGKPu7kjkUtEdn/+0=;
 b=Am/nebhzY2yxNBNvplAJ/UXZt59MkHnSp9KtElf3BRhEKBN9WJV5EGfd5aBW0KIf5g+zlhG6tJsarrpbBnEmVF4ec7jf3cKxemUjvf9FcsLJcFJZ678MyDfuRWjoS7g9cYgTdI08xjl3vbeiPoQ7acXMZ45BYRdZ4Ug5M0Nf4GBejH+Y4ptpPE1g9z0N3lQSE6tFrpksfCFYkmZdv9v+HiN1AMpCA1LRcudRvEAorcQuhrIcpQXBdxepdLvoJa6F/++6VmDsM9GMkFo69bIZqryMsJCXr/hDR3nNZXuKKmEnnRIBNf7oLy+z6StrSZzFdxvcNbmnrmIsCn8jHDdu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4gyJes/CqL6iT9dOwoilwsvqdWGKPu7kjkUtEdn/+0=;
 b=wVTyiQ1saewLSKHZ9WGtTrP0v/mOM1ILEp/a8vzSlYEoEgHFzYBWRYdI+D4SpcgZnpgLke/uzf1ylbtPDsMTghNg46w200V9/3oS2lSIBErGkIvhLWtrQcHTw6NolZ4/mnG0RI0kun9mkPpJD3W8hvx0uePEluxiOwJCObAXL1o=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:29 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:29 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 12/17] vhost: remove vhost_work_queue
Date: Mon, 26 Jun 2023 18:23:02 -0500
Message-Id: <20230626232307.97930-13-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:8:2b::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b9a8b8-8aa2-4298-5499-08db769c595c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWCGdJory9W0OlCfuBKqGR6zutEB3yMlh9UIbB48I5426b8nnEplh1EU8WfPgU3iGNdkowYAcxZxp39qzMmsnKEiGmgBJzQQfW53xmW0wqfF/kKtuUVc5o909Z00tEbQz8kfWFPwTdSrMurXTUQ906DLJoB8p/ZyPMC+3UjAiA10G244OBvQm6q+J1sBiQYEEATbtq84FDAQSgvloCGIDK4dbfqjHO3sLNbqzFNzl9OwJSZS07kKI8M94bEK3coD+y9QtyBFplkJAXu3/0p/t7XE0qGAteMAupuX+YnCQZ6AKe6upjPl4JKTiZ7cyjky8+Tpy2YSGxksn4foe1Xzo6KdX5F5jaL+DXVr/CbJXDYr2K1eMo+VO/jMgNhLSRgT7UXWpedKudCR/uO7wzQcFCx4U2/TmK8DeI5/3XhehkrqDpGfL5wmNxBGnd7jKpXVbyq7OrT9h8nvoH8Ham2ZVzqNU3z8TQhWp/A3gxaxp3yaA+5m8cGcmx0Cxc6sXlKkxiQBl8Ga+w/kKtP00v3gv1IGxXqkDYOl21g4xBPGukkn3KT1VWmspx2ZXyTtZ1QjnIZtKqiabFp9JZh9omHKB5tnEcvo35CCtCQNTdNK6LM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HCfuh5Lc4gEuAcdMcm5cuh6YR10Nlz4voDFGaEnr9uS6MYGInbVGXap+Vb5/?=
 =?us-ascii?Q?BOhsjau/neIHTnapD5h+W1jCXJc+sB49qpGKdC98NuzhwfbHoLxiRk8Bjo65?=
 =?us-ascii?Q?sLunHObkQe1bhKJxSEhcB1jLovxpS5RhuP0RUtNkw2tDojkjXtCbm/I7OH8o?=
 =?us-ascii?Q?SUx9OpKBxhllDUzLW4tQc4dl9PO+vQDAZyyZGPmYgRB+T0GRzDtvDsizy/wv?=
 =?us-ascii?Q?AIiuIR9j/U2y/H/D46/HbOGkS3XfZqWgcDQbvHpfeURQ81NqtR5pbSJPzbwY?=
 =?us-ascii?Q?WKHHLT7Z7Iu+Ev2CSN7Em65nxHzLHjGw7ucKF50W+OPyeyd1GSjG1w1ytDUI?=
 =?us-ascii?Q?nLDsOhYufFcao1Z0oISirfx3UgYqZgdWYSjqJYtuhJID1UwsBLsxwNtLLYRL?=
 =?us-ascii?Q?9doWOnDb9labotsM0GSC2xQBcHKWy0uI/v1VdcnCpJM3jQdKuHr4cptzKpD5?=
 =?us-ascii?Q?2+iST5N7S9bYycolyV+mEb9ZlNX/7qJ5znc538Fjf8BGmJJ5qJHz+w6IqnX9?=
 =?us-ascii?Q?3Hlg04tl1nx5UO97nOgYNxiZ66t4+eIL3Gw8gbFnNctI58K9QgDs7CYKAglg?=
 =?us-ascii?Q?oO8xDPoBx+AFgSS0rKZ/wcMN6c2mH6Hlavc2FTNWeI6iscVpw+Alx1zVt1ZM?=
 =?us-ascii?Q?rZ/KYS7oKPpCcMvg32GUt28yYb+4zoGE6qvs0n049c4AGtnJZG3ad6gkMuxN?=
 =?us-ascii?Q?RJLj0LB+yuCytbXFgwIGzJobDBpH5m3pjPWLjAE0eBMTokiMiHp4zoLoD8Oy?=
 =?us-ascii?Q?q8viGkKll1E5RX4pnO00LTgs6qfjx8rJ0G9ucMg6ZRAMEbn/Jsf8bMOhUbc4?=
 =?us-ascii?Q?lC6SPWbu8PX2vtxX9wxOiT8YLylU+Zf+rNP6m1c2T6xtgpedsRroNvtAJN5M?=
 =?us-ascii?Q?+b1h5pjHSaITo04APoLYSO+wyZ2Lep24He7os0ca9Zpv0WavlvCzyErIE+oW?=
 =?us-ascii?Q?Mpr2gncbp4h2PERInbTpC4ZMMZrpjppI6v9blbpaYAZEGampNMrJRV4W2czQ?=
 =?us-ascii?Q?OZuNkmxlObLNMUGCVLUB7XmACMNBtW6O3+R50Srb9iRlH33MzJspVd/mumdK?=
 =?us-ascii?Q?dmX8dKz8SJbapqaTAEEpIZk9dl/jt5uSNQfbClBcz6zQoo+2EJWrTBn1V/uS?=
 =?us-ascii?Q?X1kwIWy2x0PNgYypMZfZZyb+ZMaDuWYnDUS9RWk7jqfLOqZXlfO7XZffywil?=
 =?us-ascii?Q?Z3Yv0lrmbl/ZVfEW0Vp8vsmuP2T9q6dhjF3OVOB3wN3KgtAX7Y/klySg/f7e?=
 =?us-ascii?Q?lPTC6KwOMPIJnJQhnlsgfJn5lfVjt5bpKuEc54Lp43f1HPmU7EODoJs9/vA6?=
 =?us-ascii?Q?aeWSoqpia0VU2M+c2UijakcMUly14Bab44/DZ35kP6nWqnzkpfN0ZkqE6O/m?=
 =?us-ascii?Q?vSMsl+KEUHvnFUPdz+9FYcVtBslMXxz+VLf3BqVmu0g7XU/BSIfCxb8nG7h+?=
 =?us-ascii?Q?zmAGOpX9CcMueyehfSqE1e/mEte0DvmGShPLZU2ynARbn/zQcL96w172Kz/6?=
 =?us-ascii?Q?9Vj7SanwPt1XCwbBGM7dgjCk0UBZyzIHVCTb9VN14HJqtKGl8Tx0DuE5/31X?=
 =?us-ascii?Q?CcfZPQOTk6KsUX81G+mbUVG+BzkmMg0AnITLl91kV1l3jSCgSHb79btauqsl?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sqmwUqvp+Ev8aY9/XmwnhV+LOMRETob5P36KFz01ZVtaWW2U1wnPLAHJdEJ9VNExDuVs2X9Q9+2ZB+WU9X7o4rQX2l671nCpHnO7HopgF1x7mUkPIs4/HzErg63AWe5h9OUA5htVc26Z6M3qQEe9KrXHRYGHCMIp4sdtDJptQXltHSISME39nDzfImKT2ZpKPQFx4SSpd6pz4XYf9P5LGquwxKZTNl37sVK+2ecRliL/bQuF1T1K2AwMXpWsWmB1YEp6DDB4Ensj23lfjp93ipkXVx3SmO3/u7+yQL5oIvNSF6hQ20toZLEORTDDGcf4tdwIQnUr54r/casf/3WKGsGhTTKc47ovkd2gHZQM0OvAadcpKCGurAf8BgApvFwh2PXulh3c2Nn9kG959rdT6Hm9ilEGTqwd1mVzzJNVI5UZX/Qwv1WD0I2+S5Qdbw9tOgnNrYS8Wv6hQUW479EDbHnQF46m9xxIF+J1qoXF1m0dknd0GsXA/DYzFnibieZgZA87HXENBT0ZbOsYQPuDcwRfbMooutRo4q7RFmLqrpmTmeRZSwKKvfcKexUudquBDqsv9+E6Bjc7cEqSHFzfmVHAdrfXL/n638oS+M1XwNAHoLUEPSrkj+Q4BoqyS2jRlO0AIql4aV3vgta+b8jSnSGVhpYfbc/GqqYOI+8BpASA+2+FQdbWdGyGO2jgnGnAomeMisNMg1MA80qp8xTnuRdABBBgr937kq3QWZri0NrBh7Us7YeWG+6H/ODZfv+ultS4RwMo2fo8gugrTgiH9jX3FQ2Rs1X8u6+pM6GpF9EcZfRToU1TFGFPQe8GF2b7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b9a8b8-8aa2-4298-5499-08db769c595c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:29.0443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGJp4Dg5zGkvIQHVZL0GdYw569CMkfjXMsZbVWhXZzCIOroGGVTpx9Z2QiEsQ+kP9VDzk6cBCPUOqjwBR7M5R2kQijttDK6rf/vHlhCvtMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-GUID: o7hbXkQWK8Ln3XkKkuf816dWexL-8g8s
X-Proofpoint-ORIG-GUID: o7hbXkQWK8Ln3XkKkuf816dWexL-8g8s
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
index b6149ed8acb4..6cadbc6e6d11 100644
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
index 3882266fbbf3..83f78b6f563b 100644
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
