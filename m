Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2EEEB64D9
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5691160D4F;
	Mon, 26 Jun 2023 23:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5691160D4F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=JB3FXsHq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=CbKwhEJl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ERFjarEcY16; Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4490760EF4;
	Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4490760EF4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33565C0091;
	Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41945C0037
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0654081E5B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0654081E5B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=JB3FXsHq; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=CbKwhEJl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jlG5jE6Y2pki
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BD3481773
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BD3481773
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:26 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QN4kXB018419; Mon, 26 Jun 2023 23:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0lIbe3BKHnt4wvwxFZESIQVQ0xB/JTFwNIyquGjcuMk=;
 b=JB3FXsHqdp6fKlNT5+ewGxGa99QT191S1I3GEzH+e4/KVNTdxJMSBWeP3ZSTmmYt2cmi
 v/cs7MsirxFhnO9mDb8XtN1bDc7JMfEDIuw/lqZ1PlUHoCW0cMVJ1m/doLDYd+mrF3MW
 TIJTa6DjTf31ZQypugSUWJPkQJ4Ws13V+qhpJR83zcsl47a/WKSxwaKYEgoSkM0/Ljvn
 AJwlnpSofkGmI0HG+vS9NwJyOCcd9dYdSNxGY8htQ035ZIj1byCISuXZgmJ8cqqG99xZ
 Oi779m/h4S9E9ihPelTvh4lQtDtmT0xGIPPyjvMnCtOuUY6sPO8yZgbIXi0sMzhuWH3p vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhckvtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:25 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMiWsj018844; Mon, 26 Jun 2023 23:23:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3ywm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSK8ffRfZd6QWA/4CRCQqHwCX+GaweStos4OonkrjftadcwENfWkGlfdttzqatofrdJYTmb6vcuw2J8vVJFL4GwWcNTtUx6RRAk0OTRsNgh4KWHsKuRdnALVO10ePaPMK1aX5t8PzyhB4HwmUsyqtDagtrNO2VyIvq+rKkRSQNsg1xtmvmzKnipX39HUeI22vrGsp3uNUfCeUe4hTD0GJPM4xXu86BcYQYVzRhqFpOEsny5U7ewOVYGimAOiGYwZrBpsAjho2zBEUJsSoeFVKRwB8XkpgbDjXVRPFreOwAJr/7Ih71tO6qpTynyKSqibLU510QRYKpnLD0SK4YGCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lIbe3BKHnt4wvwxFZESIQVQ0xB/JTFwNIyquGjcuMk=;
 b=O5EbJkCPiAaBXMtB+1XjeAdcNwEsct+JamL5F0KBNjcWlfGqUWDkrd6xzfWifEBO2H3qTQF08IKqJ1OKj9pbuiY0x0JnWB84saegpoVgqeU000ET/mDbNUs9oUeZOgfM1ewzkA9IE/baB5TZiQbIbhtbYNiKJgB2/U6WOK9Tg9e0XMRd/fztPalEuVMPr67JJahYPOln8tmB3HVRz0wGfWUz5vEGsCWInubG9r3AX67tjL1C8ABxpw190hg/7leY+VWMc6yV5tb16FB1558u43RvCzfDL4bzLubGbaGhfVTJgwk4YEteaNTz3WUejz+LTSIVZPG/H+F9NzifxdeqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lIbe3BKHnt4wvwxFZESIQVQ0xB/JTFwNIyquGjcuMk=;
 b=CbKwhEJlLPqSZkInNTUW9miQeCohTEc7wP+vs2DCwRf/zxXFOnaaUZZB5tesRWXc47wEtWNOijM3OCoc081wPsV7hTaVB2ZzmO0KWz7v0no3AjnWCJTHnJKziH/oIeCkUC366wFH5W4AYCTMjpiFG7b6GFuzhE435/IWYJNmXo4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:23 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:23 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 08/17] vhost_sock: convert to vhost_vq_work_queue
Date: Mon, 26 Jun 2023 18:22:58 -0500
Message-Id: <20230626232307.97930-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::33) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 48864822-024a-4c45-d9d7-08db769c55cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtCwZRLmZjR2K9ZwJ0VbQIIkQ0MyeP/+yk2t33EPYCMTd+oXZaofiUqYbsm/fM0pNlAEwkEKhy0Cg6Kb36GUGUyJBLJCLr/XZw6vEvs1MhDX3/8pwMgdKnl3OU3HSwweYwYZu0eHsXSmVQzr605fHntmX9dY/qiSV3T3EO86gGpuYXyndwVyJz9hN0/MNMO93EOSCtYknmHQSpf56yi3OOAh4iwXS0RZTFL+QFjdcyNv1FpsQdP2zVvd0OQZNdQLHe49Up0XjfuCiIFbETxa0gBDIAQovvBX1eEKhrAkmwmkmqqlPaQ45ctRHbH0X/YsS2yUOO3XR81lKSskAaNecjaGOuZUJbV+CU8Fl/q/bhMuEtDGJdw4ME5QQpehNFoS0l0qOAGeEriwccTnyUYioRNsCn94a5Ad6uiGtkoIBE5fSVZ3YS9Dru+E1MTDUCY6YMGCKHJ40PWQWXgDLCrsshh5UH9JfwwTAJfV5O20eSHV+WQmLbHpNXo2B0QezKI6t0bj84oW/8N22GpjtuGjYWnaQWP8zteMHycOJzmL3wL93K8tEvZfLmuGRq4rp6wyvELPuaj/HbGdkJyUyqcUA+C3NRw4ZeddG5Z459clAR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LRa9ZHn8UgO5fbGwQhlpV1BlVK2yxe3m7QtepyqrClhXVBPmpyaJD0+D3Lrm?=
 =?us-ascii?Q?tdJIbiK9Il8n28iIeFr8+pOvswk7klc/3rDE8diYKgFyzfuqjNbMPeuJjjzX?=
 =?us-ascii?Q?buBcIv1g2fuBC/7X8RAme3Ek1GNKN0Fzai2msZX35SLzCSMN+QeRlAFO9g6Z?=
 =?us-ascii?Q?9JOCT1BvtXF7HRluBqKrt8ADkHh1KuxRdvN3oqvzE46Jz8SXclA8EzmmGEiP?=
 =?us-ascii?Q?5y2xCyQHzmZDHdG9l4pv16DbKtoMGkFjFrsmchJni0Wb8NvD7XSgcdQfCKF0?=
 =?us-ascii?Q?xzpTDiGNnyu+e2CRgtArPE99CAQejABy5aVElz6Wea2E8AJkvt4puOjpO/pB?=
 =?us-ascii?Q?//oVT371Ihd1VN4tZdkrfXPg00mLTKIzKOSf4omb+CWysX4TVe1BgkVZKhfm?=
 =?us-ascii?Q?LsGzxIrlDTANHVet+Ggihj3g3NZbzCRTm/JeeAY1QMhpdMN/B9h8LCnF45qr?=
 =?us-ascii?Q?LBi2oGIpLdyl+ln4jEZZwf7e0Qd1qG071ryMjduxmYo+LLjzBz81yRTk0oIo?=
 =?us-ascii?Q?kHeD69rAgA4IcTlwCnQxJO6N3oWJxFSxGVIj5Fy8kTWVH3l4GSSTP9DoIR/4?=
 =?us-ascii?Q?j9dVcxyn/WgGm6xmx+xGm3RTbrG6G4IH+U9JevNuOzEvzWC3XInJU/aPXei6?=
 =?us-ascii?Q?yqIeysjt7WzgaXqwQqLvmQ2zW5h00qizffnfqMQnkKD6fpxi5d0dhbyLRRg7?=
 =?us-ascii?Q?SLlrsP/WNSeLfKe2LVgs+hIq2rqwORggNXGEDn6NU7cVrWyQxQFxTNdSb2/E?=
 =?us-ascii?Q?2t3PZaerIFJFeZBdn67+D50aSu4H+O9vt/JBDJHplSMe6HZ9XHzzPT+AWYyv?=
 =?us-ascii?Q?iVzsWkC5P8UNkzAhFm7Syh8UJ0HTg5OvTyd6mvucZdikvw8fu4AsgF/d7/LA?=
 =?us-ascii?Q?WeEYAcABO/2fYMUd90067/REehGZliljLD12E6DP9WXJOxcIvXz2MN9utN//?=
 =?us-ascii?Q?RgThqiVxMqHpCbQJdCJaY7MVFjnII9Xf6wvqVXeUMkwj9YwJMu7sg6VdFtDw?=
 =?us-ascii?Q?dhWnxmwEYnJ/CeGBJ/aMwJOIa/+P8jG4F8k6wivta56cv0G2gAXEq7J9WTws?=
 =?us-ascii?Q?POkynDpF7ps3pROiDh9oZLat3zYSi/3bky59Uo//J5xWe/pQKdfodO0sxGbt?=
 =?us-ascii?Q?VkO82sqwT9kAa4tDKIpiluIX+X1LYsnycO9Ea0N+4HOis2aN8DaeP5D8td6Q?=
 =?us-ascii?Q?7X+/TsegLQeJt673jZQWQtCbzEV1iTwcmnYugyw7l3el6V1iPqYN2PvrhKjX?=
 =?us-ascii?Q?rF5iCfnIpVpvwZ+w0b6azbkotsmHU7O/ROakO1DA0x2YcCjJr85i1VedM8Fi?=
 =?us-ascii?Q?ARUC+7l358oNQ9/6nQXyygFqtY8exi7IcFVuuUr2vR5XRBzk28EqLt4goPcy?=
 =?us-ascii?Q?/CBkyOmDiDz0hjomWz/AKVUjJRSQLvEBJjR901pQltq6SxDiHcEJ4u+/V210?=
 =?us-ascii?Q?2IP/MBUi1DvLuYNjiw6iBN/DqWj5bRgXD37oGEFLbdnA4iI9iHAtUBhPb6CU?=
 =?us-ascii?Q?AJQxUWHOISHa6e7b0j7ZE5FfedTaa3hoBrGPES1Upc0AMhz4+YgUnCT+Hmp5?=
 =?us-ascii?Q?euMpo/PU2dF7uk9MiGJghQtTP81nGs0GmbrY12tZX2jq5AmwmePdw5Ajwu+H?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ecs/foAtgz5UO+36kiu1adH0J66omEHckXSz7oabG1QdedSNjHGQIpQ+uFs1pI9hb+byH3BzRSVXvL6ChCYpqu18fmox5XnmEsmLMu4/ny7lATpb9hNmq4GeKoyJ771GIuQ+/uZx6jRfEGoPiVvpYLALSXY6osABnkFlmWbJXNC/tS0Nw3+gQ/kEd5H2CrptCapboCiiDq1OUpOpgJaGsrc0c610lB6UpVozyjpdwbPi4HqsoESgchAw6cP2qJcnCedj0gLnLdG6/mTQhQBx6ljAUijsyAbfwfRQIy8lQqBuO1IpQIPKCV2OxYIwd8wsYtmDFQNJKg8fV19+4uWaJvlQ72fRJ96E9R3/zYRtohQtNcFVUwhgEzm0PmtBIoGWOkHfKjTu56XTVE/EWr3RpBsYPDx2wz1U6msRqOVFw7DMS6LmbxffdcB0scz8Jcc6PxoRWigAmd75iq86LQBS6GyYfjee16BRI/ri8kJOsFLXtJWy8pQfahHYc7aGdC5lPrnYMGym3vaoZRhcuy4cQx2+OX1EMHta73D4qC4jgVtQBiEEA0OGK0JStde8JAd4HoLf0Pz/1GyrK6qTT5jPp5ng10zM8pBzF5ZwJCsPcw4bcjPvSvWRC7T6WaXFXeS70vk4/1pwl28oZKRahagvQ8BbvciSoOZcR+Cw1v39aufBd+mpXkdV6Yxpd/nIRdm7zha05UCCsl2e5UkCpi1KjVpX3lD2lJz5JiaS106eAJzH9g8YKpI79idZF+XUU3IoXnx0NQ9jIV2FW7nu10nXlWuSqthu9dUh7VbXDObcnT8NERV6rDlJBI8IexoyeaOT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48864822-024a-4c45-d9d7-08db769c55cf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:23.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdwPnRIrnlRzKqIi1i93caSFBTkMqLrWVOik9IbKa1Mb7UasP+oB7dHC19gMDvsekHeHIMyGhBG8OZBfchy7cwsBIsemoxgUmOoXTYnz58Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260218
X-Proofpoint-GUID: fUBg_wLvIYPVPBXFEyEFjCKdQFeSCCjL
X-Proofpoint-ORIG-GUID: fUBg_wLvIYPVPBXFEyEFjCKdQFeSCCjL
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

Convert from vhost_work_queue to vhost_vq_work_queue, so we can drop
vhost_work_queue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 6578db78f0ae..817d377a3f36 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -285,7 +285,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
 		atomic_inc(&vsock->queued_replies);
 
 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
 	rcu_read_unlock();
 	return len;
@@ -583,7 +583,7 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
