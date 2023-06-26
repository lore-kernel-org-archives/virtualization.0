Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A838EB64DD
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D425F605A5;
	Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D425F605A5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=QVC2DbcN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Jtycq/2i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXKdGFc6a5_Q; Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E837A60625;
	Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E837A60625
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C18BEC0091;
	Mon, 26 Jun 2023 23:23:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD558C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4771605A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4771605A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KK1BpIz7a02J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2F2F60594
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2F2F60594
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QNCorM008322; Mon, 26 Jun 2023 23:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+O+D7A0FpVZwelVLdU21kAnDCuEg/CEvI65q1nLHaok=;
 b=QVC2DbcNOcOKMgD34wOhTQ9zltyslvQ/zLXrTHDev9k0VdkDUhjcv42fFb1gPw/C5eDM
 BXUmxyLbCyNUDm3/IzB/+Q/LUrGArOtv59wIHWfUkuuw22NVKJ7aADNsh38DOdQlKmCA
 3vMpVOid7hf3kyyvdaJydVJQHVkPE7jPjp7zlB77Aa+bHTV0Vl6CS8WzNQIAAkfQifa7
 fjFrwfQ46HLaMNsFhSt1fLJr1gX81fQEfR+OVXWqqRZc585E4T2hGvI3yH1Q5ZgBJJFA
 iwGA4Q9PtiTpgc0hn/UVv9nYHeAcBX5rgojPl103ezWTKjy3EdOxBNViDQ6haN3oqAV8 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdbtqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:23 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QLDFCw018832; Mon, 26 Jun 2023 23:23:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3ywgs-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbhEnzpfG7WKzoNL+amb7gpAfA4Xn8Nru3fMrI5QBn+6fyTLCtsVU8n9zNNc2blMkK1m7p9pijrZQUyJdZehVrdj7Q5jD6LkscGfoXawYOZr4HnObXbn1mVlkx4nkqjMeB116/FeWolrKveBo11B9vSSEGVHn7cTJKcloqZZu/ZYBCtARrg2M1plMbL4FCZ7Wc7CcmFkpI39J0gZuiq0TxiqqRoRGyTq6Ewe/beZU1CVra8zpSC6o3k27RI9vE5HS4ZhBhOLzk+wEzxat5kQUGd/6lStJsh77m6DLUu3SaL5ZKbwkzZVmQWiUd0YbGUwij/TnmlpoccAraXLpZ6K2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O+D7A0FpVZwelVLdU21kAnDCuEg/CEvI65q1nLHaok=;
 b=E1kZ8tnmujrZ+jse9IhqdTxVoIoP1viyt2bmbiYFXddRnP9ya5bcvFxIYmm9GY0js2/qa4Q0CryHpB/euIKQW4Pt9l8VhG9x5O+fldwdtkULC9PHdyFtElp4O2vxMmY2iTl36MrLwQ6zDw0L+F+AsyWpcMIXK/6cGby/Lw+XUyOGUqrjA51QcE4+t2Bc87bROaakQYuYz0YEft5kyZ0yyPeDnu+zrsoGhhrjxeq43cLj8x6LXS3R853IxCaD1VTAuLX1kuKfnq3WTUuVSLan7aCjaKuynlZNBQ6sXrm9zgGNmtiQrBeeMshnuwoRmOc32uJefXsqDpg6AIttYNCaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O+D7A0FpVZwelVLdU21kAnDCuEg/CEvI65q1nLHaok=;
 b=Jtycq/2i3EqAB0JuZUVSriLsgpQCII598nbw8S3+WAk2ANcbviOxaESencLbz44nghcYbssVzcDdjNH59UzaRaWZEJmsV/8RwYenJO9qU/uK7kh8oecs1FET7xmBLBbDcOKccjXdfJ0Pnk/vnjngHsSl3Obm2UBQ5D+1kJ25USw=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:16 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:16 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 04/17] vhost, vhost_net: add helper to check if vq has work
Date: Mon, 26 Jun 2023 18:22:54 -0500
Message-Id: <20230626232307.97930-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::28) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: db5b681d-fb2f-41b0-af35-08db769c51f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hqcfPfmI3ZORchpAErA6T8jpPx7JO3DR7vq7ZuDIO70vBINKhNtj/GbmakWCqojntoSQYw4O3otdiP+5n7qSpo3fcJq90t1v8lSbHZnArXuOMl7j5KKviXxOAL/oGLN8mhD2sJH9ecN4y/grC7vFLIEkHuAxPKEO85uRQACU2ExYr7Tl+sz8vo1LyLipK3EbCzs3xFeXXLWKrnPfvhZJptyb9iiV56+t0dNU8md8MHs0laglaFmJdEOvwLwkrbBGQl/ogMt446vMtMDNxtNNUkPkoe3e24oebA6ORmxgyOtX/24avV7PrZxuATVbd/2JLn5VS1fU2a6aTwGuPON//8h3t7JWyUvJGmTkSJvVPUZU208z71yVf2pe5dghfbL3XDIwzgQtUdSRDlcMqLvMKUyO0QccgZC66uyOZNE7sF35UXkKjmreIOB3eyAiPMPqRjxNhMkrBYpy8GkN7sSvbk30tvI8O972W3HQntD4nF2p/LqE255jk+/33PiJvmrIisz/RRtNg4RCMAp70Ho0PHNw1M1dTUxVa1z1T3AJHA13eA5fHZl+4GP5iubwyT1B+i0y6CmiTPI29UedK4YdPN0kaBfA55a+eLTuKJMRgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iF+dd31wNP3REQ29ywykXKCleCsJsHWAIZ64g3WEnzXQYXjYzyFoFtvzbBh?=
 =?us-ascii?Q?VL4XloGSFZifi6XiU6ldgX5ee5wVdld0wDFNFIkxKIrFRVcPp6fZObB0IGEH?=
 =?us-ascii?Q?7BZxZj3PfIBHaiMtPV1Bv//J4pWhTVO+0fiinhbuMynereHN5t96RoUisisw?=
 =?us-ascii?Q?9g+PD8KwSuf+tSyBe73b14xDn6SL/vejkake9UnTEILRHci5Qr1DkC2OQB6Q?=
 =?us-ascii?Q?3lApDiVpeytz7DLsCjad3PyJPP/3DNLHqTL0flhj0qJykGAB8MPIyhIkFkn1?=
 =?us-ascii?Q?V1+hyaMXpXy4yO5X4nVyBZQpvsl1nEBJGO3UqOUOLsXsbrM8+9D9DXlMg6uG?=
 =?us-ascii?Q?qFqvg5mzZB/5t10+37/trbsknGyOZp0Ms550TnVHTn9vyE8eW13bOtnjTFFL?=
 =?us-ascii?Q?jtvK0TQNazf0BaN969TztarJ+cJbIKntaK3AKRaGCuW/F3uKywazpwlbnOlS?=
 =?us-ascii?Q?jLWw78lGkMnS3MeM9j63KrOT77YmwG/L0ok8eIFJm3oM68WenrBY7N6gGW9N?=
 =?us-ascii?Q?Ishp0p/+MT07n8Mteokakaba9rUV9DiMO/ozwk3FY7Ls74yak2gjrX3HVtmv?=
 =?us-ascii?Q?3AceFU6pBg7PHWclrhbcsqnyexW4sEwhmBlRRknHlm+sIvpXKvY2ypq2epZR?=
 =?us-ascii?Q?OBoMjAOZ2F7dHJlRcvX5iaz+n6CGyDXEPuq7SYvzOBiR+U3DEX5TKZ/+3wme?=
 =?us-ascii?Q?WjEUAcGnxQTJB/dbc2pKjF11xRexEXFuW4fghCZl3XJPB03EAVklSMfC12+j?=
 =?us-ascii?Q?Yp/fznjmjkNMDNxCtnhn6iRWMiQZWL/mY6qjLsKHqyiyz3BXelRWJKFDQBxy?=
 =?us-ascii?Q?Eo+vS7sRYhdk3K3bkQpsAIscqbY4TO38VvEgWtJEHm+h6jt+rzal/v+iEBb9?=
 =?us-ascii?Q?jMafJI7RW9uWLKaa/tp5js7JAYw3X6tJvyZwOqbZ4z+kGr/aqLOMEa6Fz0yQ?=
 =?us-ascii?Q?FGwMqFabeWbg1te7HXKCJi0q/T92tPUG1wBKvCZmsOpJbNZwwiI09uRfLQdZ?=
 =?us-ascii?Q?EVGfO/rbRIeiVMCSfp/G9r/+3yn2WCSGvnnI1yK4TUOU4XbiaqVlaJokPs1g?=
 =?us-ascii?Q?t/ZxEwDSXLPinTshL1vkV/xVzeutQWCUC8dTr90XN1L5RTdCqjDoUcI7813U?=
 =?us-ascii?Q?p/z9ginN0PGf5/rA+zvbBlOwfhGBxgS/1tAo64y8Umu/l1tjvPLq2rFVNjmz?=
 =?us-ascii?Q?P4+V7l1Kb+0LyuEzUCWihL1CA0bxFxmbPeIEE4QL+mPnqJFZmXIqbmnkhxYW?=
 =?us-ascii?Q?SP6t/yQyG7CzqPJmH4bHAt1ORHovKHhQalgo4LY/H7aLfTovAsT/MEHaXrxR?=
 =?us-ascii?Q?mk88ojLJigcAg0vUAB0u5JJ8JwJ1Oe6njMl4I39774TElNOU2lZW7hx2e4fF?=
 =?us-ascii?Q?4o/UPuynCBaAJwK+f02uOwuFJc0EbRqqr4Knna+GKSS0HT2f4Z/ndwjsIXWB?=
 =?us-ascii?Q?9L8Hc0OfNcmJt5lZLBVrSI0H3GQn4t04kOYQK2iNfKDa+bgCLKhvDHjlefXi?=
 =?us-ascii?Q?Ucr2NF69MT0dSOJNMetBuNKPve8U8rZyey4xVyC5y7TO20xwOfscKPUidsFD?=
 =?us-ascii?Q?wRzlGXCgsMRkssQz6+1FGiqFYFR7dtkiz3GuCFYIvGElhrqNZ+BXhMa0hfl8?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nmJs4VlQU8f8FfiBFuNcSq1EY0Snfzo+7KVB7fVPLYmaZ7cO1/TPg887U/a1RS9D43TDRG8Fs6fY5J4ZeKhbi14ucnehmQaRdrAqYgaN4Jmysb7ChEX2iypbzVMF3f2+MIPvkE0C9v0NCuUi5pWfeP3i/0mTv+E7bJjDeyYtTbX0q7y2v+N6FwynLcAwCmsUjbpeXJgqPLfWccaxF+jn939zSA0AFPfK6R2oJu1HZxQV0WtrfrM3ViAgxcJz+A3udUlAMqRlkRYBXYKMg9BPexHj5UA4tm2kyVp6MelaqEfbwATzyR+fcVW46eoB/h18l4XSsK4tONwEmCBZJlEGRLVB0CI2g8hPHn/usIRC+7pAMQZeRsR134Mb0giqxPQFjYiVKPAqKl/8E2Ptp4l1HHXCqtrEP/78kIdmOQeGEIJMP2GE6tHIl/X/te9XIpWBjcNTlBOwmkm+/Um6Tt34Uf0xJ+bLYvVwLKOVvlie2g7z27BnZWmiwmHCd6y6dTVfRrDH7y0zPvXimbAgGgNRjUKBwtn8YqgkLh37illbti8dc2wmRfAbgEAieQh3g60+lL5/dMRczzxbJcwZkqNQPDP8H/gPxGgDUnaKGN2602iBqcfiua145QfoWGgDMmWgezpb2FzoPJsUa0vnMLcCFkSwEI+8VxsR3EwxQEXuHPZ9/nbFWiPnOCQ3JUxs5wRETYUhqiXTWWJEooQrrPE+Nc5nfAcJYAjDkWh3xcjz2qdEQkUHWNdczFEamFjQL8+WFbCKisVQgwtYE6WQh3h3ehhpECKfMdKThRN/K9WRSw6qP6upQdH/6Yr4AKva0X60
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5b681d-fb2f-41b0-af35-08db769c51f4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:16.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTCaELEBQY0hCdxbZw22hx8EdmayUIGexm3Zst/Km5oUl4lqsn4EJ3yVsR4KGedGjN82opj8afdUOWuLxor5jQEP9I3W4aVecxYAplpxBoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260218
X-Proofpoint-GUID: myGeej1EuZPjfGovP6d1DKch70_qKSPc
X-Proofpoint-ORIG-GUID: myGeej1EuZPjfGovP6d1DKch70_qKSPc
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

In the next patches each vq might have different workers so one could
have work but others do not. For net, we only want to check specific vqs,
so this adds a helper to check if a vq has work pending and converts
vhost-net to use it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 2 +-
 drivers/vhost/vhost.c | 6 +++---
 drivers/vhost/vhost.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ae2273196b0c..98bb957eb3b9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -546,7 +546,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	endtime = busy_clock() + busyloop_timeout;
 
 	while (vhost_can_busy_poll(endtime)) {
-		if (vhost_has_work(&net->dev)) {
+		if (vhost_vq_has_work(vq)) {
 			*busyloop_intr = true;
 			break;
 		}
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index db88464c1691..aafb23e12477 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -266,11 +266,11 @@ bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
 /* A lockless hint for busy polling code to exit the loop */
-bool vhost_has_work(struct vhost_dev *dev)
+bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
-	return !llist_empty(&dev->worker->work_list);
+	return !llist_empty(&vq->worker->work_list);
 }
-EXPORT_SYMBOL_GPL(vhost_has_work);
+EXPORT_SYMBOL_GPL(vhost_vq_has_work);
 
 void vhost_poll_queue(struct vhost_poll *poll)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0baacc245934..d5728f986744 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -45,7 +45,6 @@ struct vhost_poll {
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
-bool vhost_has_work(struct vhost_dev *dev);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 		     __poll_t mask, struct vhost_dev *dev);
@@ -199,6 +198,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
+bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
 int vhost_vq_init_access(struct vhost_virtqueue *);
 int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
