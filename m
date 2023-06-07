Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA497C7EE23
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 19:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4070360C19;
	Wed,  7 Jun 2023 19:23:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4070360C19
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=1jx8XfG7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=NiGDXKu2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5imvFywx-EZ8; Wed,  7 Jun 2023 19:23:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A536660BBE;
	Wed,  7 Jun 2023 19:23:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A536660BBE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AAA7C0037;
	Wed,  7 Jun 2023 19:23:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6AA3C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE8B34016E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE8B34016E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=1jx8XfG7; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=NiGDXKu2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8vRQzOrlaQtN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76B7C4016A
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76B7C4016A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:45 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357ElP5p007974; Wed, 7 Jun 2023 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=kDgvGCdY+zaGTT6A/bohsnEj0EpinswzGqGmeteJYOs=;
 b=1jx8XfG7BAeGq33ttMU0QqsMWXHweXZyyu/w1k78MIw8CgeKr/3HO/UWPbZh7bDEubov
 jLFS1+lHEeKPN94YnGI4YpCH+F4npfwNEzuD+l7t9ByrHrAyPRLcq3B0zJubzACvKuFk
 oRgy+Jw0Ltovcufx8T6/qBpnVs31ZLPuCf70N0BxVrs6K2mcfdNqLMBpduhPyUPPbso5
 4eBn+72oi3mjGg7ylCoddk2e5Sasl5ePiYcip6rvw2a8OL6XoI88xs6XGh090aJV5V//
 GfRBFqBFGBPtKILhWT0/tcSb7U7jnl8FACQ5Ue/Y66+XIBBkp5lZnx6tnSYA+9MtPET4 Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rjjbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 19:23:44 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357J1rFq037112; Wed, 7 Jun 2023 19:23:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6hnw3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 19:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjt3siTC1HT9n7zCUNVn3RIXRrjswrY3+h8Q6gjk/j6T2q0Y1+gnB6sEskchi6LpdyTOIu4V+suo2Mk4qk5OEsbw6C3+Qm74/tEXOdw1oYQGo6cwTmAWxdXXLlZb+irXQMFUL1fBjGYhSd95SwGzznOlhnlXc50gwuC4mtX0q8LpoAyaeu0U/GHJcAW+hosZ5QUh1EhtCoIQRsNr7aTHO/1V+9sqAN3SR8vwF5r83KoZ7Pt/yprtOP71OpKcvhndr1ABEN7sAWeGVVi6G55eykg6UIP3WUhdiouh5gDEH5DM7k/yh1YDDo91CLp0U/LhR/wm92FvDFrDOJuGaxCc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDgvGCdY+zaGTT6A/bohsnEj0EpinswzGqGmeteJYOs=;
 b=SqTo8/MgsKeXWcWTaer8d6MNqrt0m02YZxs6mn7lSVsIIHSgvrU+jXV+Ht4yOY8tO8dZx0XTGtwsbwHkLvAoxpAdRqzcl95Bv6eX0i+jMMqnViUfkh/vvO9kAZICM193O6CrA7gqRHGsHe0X/mmeyh1SbYv4/FvK36JG7HPKqP6gilq5Pjk3D21eNJXaMhOzcuqtmKjLeNfugHdHjkOMDZkmGHw6ODP9BXcAESJmRNXJFkGPEEzWCMsGJj6PuwXd5KGyR3EXxDun7ZEUJ3BSW3hX2d9+PbAJUqUWc9Nry+ML658gHnV3vUXgdwKZ4/DbN04upfyQpNlxavxEck0GVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDgvGCdY+zaGTT6A/bohsnEj0EpinswzGqGmeteJYOs=;
 b=NiGDXKu2v17hu5TsTqL04GzGdyjYUIVxLsSVGsd3OXu1wxY6KkOcU9ZG+NW/pjmp80G3g9P31rWlKAOxqfBHDL8mHphJa4mDp7SnoUhnbRyR641iDbALi7feuI5EY7DYKghthcCLvTScK3EOcMO1cqWuvrgiTquTAPTvKxEJDpo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Wed, 7 Jun
 2023 19:23:41 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 19:23:41 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: vhost: Fix vhost_task regressions in 6.4-rc
Date: Wed,  7 Jun 2023 14:23:36 -0500
Message-Id: <20230607192338.6041-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM6PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:5:333::12) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad8d5b8-0015-4d8d-8e5e-08db678cb38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynN+62/PmbuuFionaC/uPBZFkrlZaEhW3AHVkc7Tm//TrtoP14O2V1O+nINu2brt3ZAdvbN/BdNHVZioG3Kc+zSV0AuZCTCyERZU7SteQ8OBko6DDzc+WFBgHb1XIAPDhiD5UEUHhNI2P7KLhNBBnfe6P/dy1iVXKSokx8z31ID5rvs4vnjTbE5GexWqvmPk1nkpn2zXpOynslJz0ogWZ8iZ56IokIpNxjQ67K1kiP5DNUJaqxxwM48+o6WB3SAxo7qYxqO9MgRT3xu2FAAzygbY8HjR4E+SQ43ZrWDYRlGkKyFL47Sg3lTw1xMiXyC+FoAFqkOhJee5MzEVItc/qrMtOpy8fou7AW6jlt2ZrOAC1G+qiZzNhD1HZT+s2aJHAR9PW5F3MMtFcTE9yQTIy4zWXNaka8iNfF4WBKLFvy2++Bwrb52vG43mBt+ai/WXV4cM9iUZgOjVDELXhEy/LWL0XYBpGOAK7Bc+3yw4YLO3xxSAUf7fNF4FbBLeD6dbGUbL1MRSG8gN26kBeqJvyucbEiQ4Vzrjd70xBiiZT8pmuQ9LYRULco5qT3Inrn/x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(41300700001)(66556008)(66946007)(66476007)(38100700002)(4744005)(2906002)(8676002)(8936002)(316002)(5660300002)(2616005)(478600001)(6506007)(6666004)(6486002)(26005)(86362001)(186003)(1076003)(36756003)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AYFYQ6C1fN8WmFE2vPqQ84Au9dM0TS3tqqAk23mAFm7yYmn09lwTZtpArjA4?=
 =?us-ascii?Q?TlIl+M+Sh3htUbqk2DN+62pWN3LlnxtHmPZXtNdpYW1pBKOUFVFBOSl9Q3E6?=
 =?us-ascii?Q?iaB/OQ9dzQvYCtsSJtUofHGGtsWAiG+c6dK78M+TDm3uGXlXF3MniBA0LWpV?=
 =?us-ascii?Q?PaCYrD93Rsn619Xd3UQkf/mZ+6qTN76rBOl+TtUWGJiDIuYcbfrp3D4G1T4h?=
 =?us-ascii?Q?EqObnxOFIvOIGsExg2ZmSU0vUVeYj25GVHYiYWq6IGY/ai55FC+afMhoOydy?=
 =?us-ascii?Q?DlqVbdDMQL8Uq0XNxrcL0PtKkWIhas/l/QWNqaaB8sjaunC+mlTJNngNFU7q?=
 =?us-ascii?Q?k3BaN2p+5gmz0rxGe9U7G/sYiG1o83LbglLSkwu02TXE5JowFaZDl58cFzkL?=
 =?us-ascii?Q?iENqOGWlVc8LLS6PRnfVFukK67T10OgjEb8vPcQbaxd+e0Hao64mQLQ65t07?=
 =?us-ascii?Q?zK7qiTOnaaLODW7pQNhsjod6bck1V5vwNdzwUN20BPcK5+PCWY572kG98TrP?=
 =?us-ascii?Q?SDlPIrfigfvC/4ye7fOflkYTg+Zdhs6grSVAs2qQfcIoJDenAmMlF9cKs6t5?=
 =?us-ascii?Q?yj4MLNay+aRC6JFl9hZwoR39kVBcH1Y2rfhnsWGYiHTfblQZjMd+OvkwizV/?=
 =?us-ascii?Q?AHsVD9VACV/isdXPoULik3lq0CV6iJezEFNeGJKBode+NreefRdMSVpwqDpD?=
 =?us-ascii?Q?4w7hO7I6mwtz6nwynIIyBGM0WnhMs8XjSa8FZb5wdS6cV1NeodJ41Om8/fnc?=
 =?us-ascii?Q?tfkk3Uncc2FBzQnMfzc12kvlay8/uMZmaO/c6Axx0QGpp6A1Q/PMr47mXQZ2?=
 =?us-ascii?Q?fBBqygQgj33IRjTVNmspSlDHM2iB0l05INbCoq4I8eJzLzMA+tAyylxWMLw1?=
 =?us-ascii?Q?23XeLN2gODaqMngpZ7tTyXi692OXkq0B1zEGVqvDujRiv3Y42HroCk93T8pd?=
 =?us-ascii?Q?rGLc2823l6jl4EmcFCPIFLvI/U5FadQWNc/KGcNU1wvprCF4ET05W0NsKu+n?=
 =?us-ascii?Q?oJuGa2IrtrUhaarVr/FgAAkNr3vS0HAc7vrjCrq5JE2IbB1377SHU2dxdJOO?=
 =?us-ascii?Q?RkEigBKZh7IJorFnyM8p+7ZRk/Z3uOavNst50KQArh+vWj5NJTCL/kP++8cs?=
 =?us-ascii?Q?fM+d1/fqa0CPPzB5BMEdNIA2SpQLrBIkMpFkUgpZLXGS9JBT+zA03Ru3zrGy?=
 =?us-ascii?Q?VRlDVED4JH2ZsBXOiYqvYuCFilxxbpJc01cndL4BPNHW5K1JpL29XqxDmeyw?=
 =?us-ascii?Q?BvBX5YhsYn4FJsxYrjEFCA1G5yzUtA8u1EPr4H88xIWfnsf5vJQq/A/sVbHg?=
 =?us-ascii?Q?XCUKA5hYB3Wjixd8jRZJDxWL8+nTYvn7waUEsh42fEBPdFZUaKaf8VQfauxM?=
 =?us-ascii?Q?iRmIH1j96AvhsZPO14Ifpm8TaPdUb/s2traYTLMguoCiLgqLWMll+h/FPVyn?=
 =?us-ascii?Q?Y4ts+aKohhwfEvfLroZ5iTxEmVo0j5U9JZoBmZw3KcwQ7x38gAifL2WOC8oc?=
 =?us-ascii?Q?dSoF4yX7RoneaS0Uo+HAcXSF3iM3vw4PYnsJc5nIHyMfd64zUHiJHfTls08r?=
 =?us-ascii?Q?rw9SMTu3Z6bXxdayqZW/wVVx9F+vjz5iHbDnpefiT13BNePoNy3uC1RHeGmp?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oTr6usk5oVFtwdJgtLxxgocFyKgzXKyYzNlZf++tsCu+1GNJvP7jy1waHXvhwfSY/HVMcT7xQym3xOV+xs2P/RTE/ObXeZcAMSGuQKMO57Z2Pfk5HDHaQ/hworrQZzzDhl/jX6tqKmYGME6ishuCszKolPUtfNLXJsqIefcKwM1S2IOPlr9UbIs0ESyzkjUYhB+B3JnteGWgNTKk81OsnO/pNRActndiG7n+U9w+lQ0a8PN68F5vSkaEv8fQDaPrZxOn3cQAFiRtHGPDObNWeIDkzxtlHum8saefqNFshKRvM/nBh4NhgmRf5WYxLv/KK8ub0JVEZlGgGz691CWpmjS2KFZf3aiBCrMogTArp6DD8lJOMuM0Du4f02WeL08A+fH8sAXutXZUNuQPeaml0TDTZ+eaaxj2Rf+XEmQ70+Xbvks7ws8b9s84RayeDvyd1vkvwapb25pnTI2KcfV2lVlofzrsmhbpfU5KblHn7uTCoP7p9358S1weWOZrrMRVSWZwIWS/xMDgmCsudGbuCLilU5c18HrjNkdeQwJgOMBJQmPZJ5/oD14vnUyeD3393nxmcKlZDXZfahj0GJTH9PTUE4zLk9Xuzbb3HOprreHiDxNgC1Ts4OE/4Tir0yESXRWPU9uj7acldE6rQB8QgDg5aY6eD01czioPsbby0LFEjAoTJhTpGMkvmxbAP0qIWX/pZNRhPXsbzEIA1j9ttsG2ftM9COkaKAysJsW633k+1n1J8ToNox7JlHUV59w9Hv9lzpVkQgFhoQ467/2HUfZjSQKydA1AyO5SkHlxJvBQ06sFwJepCYf8sQhqiTGP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8d5b8-0015-4d8d-8e5e-08db678cb38e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:23:40.9728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8/8xzsrVSZLTcX9I0cvQ/hDlYghWyJoWoJibgAPOQRf/jvqrug7V0v79m4Z1i+XEVQJMMa9NrB04yK2pl8+FwWxGYqT4+QFhpBrypz3WSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_10,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=806 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070167
X-Proofpoint-ORIG-GUID: V-gbZrM6v2taKkNyce1jPMPbYF5iNPgw
X-Proofpoint-GUID: V-gbZrM6v2taKkNyce1jPMPbYF5iNPgw
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

The following patches were made over Linus's tree which contains a
vhost change missing in mst's vhost branch. These patches fix two
issues caused by the vhost_task patches:
1. I was setting dev->worker too early and this caused crashes when
vsock would queue work before VHOST_SET_OWNER.

2. The patch that Linus's tree contains which vhost does not yet
have converted vhost_tasks to use CLONE_THREAD. That required a
change to how we set the task state, but I completely messed up
and moved when we set ourself to interruptible too late.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
