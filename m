Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C48C001B1
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4057D40A55;
	Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4057D40A55
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=mguVJ4Sn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=A5GeEX0C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JxPn-E_6RVHu; Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 062D940900;
	Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 062D940900
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D40C1C0037;
	Mon, 26 Jun 2023 23:23:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2345C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F6D081773
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F6D081773
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=mguVJ4Sn; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=A5GeEX0C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 42O97TGkk2cn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FECE81919
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FECE81919
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMi6BB023162; Mon, 26 Jun 2023 23:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hcOUCpoFEQdE+XrbWXbQsglUDxBoc6QR8K8zZ2N+/7U=;
 b=mguVJ4SnSbm5Iv6nA8RLH/MFuGXuDAnopZiqKKBJgQYFAW7Sg7Nw4j+yPl+iZHnvvDNf
 MCvivm1xhgv+NqHUhHc+tYPAldtZoYKfl3+J6n45XOVeCY+0UVlzsN4OItXj//3GHxTG
 HXZsCfYQx6muUiD5nvPZJ8/TWdhnpjVe5280+5ALLtvEPczjsan37heNDsfUbI+7YvFa
 /JciBKUzG6h4nSJRqf1nlpgpjz4iCbXgLskyGciFV1ovew364m2gDSIylopECUIpDPGT
 RXshDBv5bbzTbaW4iTe8KrG1cWGbERbOnTCJTv7gFxPIBmLPLWms16nEqPM3zy+uixUB QA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq933uew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QLDFCv018832; Mon, 26 Jun 2023 23:23:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3ywgs-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZVkS90aanpdcAorTddIdUj6pn1JDavPypPbjZxASL1IwVaBeQcCrOzZEubtVjl6+1ocbsHlRD6FekOoWaklucKVCUnIcF+9bBVJxSMOCDYAKblBM8lnsTQ6EVP3/04SpPaJI8Sd8y0rHy2KdpEdvniSOsuRORkv8gMCVoRSPzRQX4OI/s1W9VGtjra6L03zz9XtKBBwtubQpmriRTDLU+wDOSC9/BApSW+C7U0ChN/5wHKffyDqliqkHsnFPktXmvSAvCmOKamTXJ+1MWXiF68y2rk16kRueqcDHggMr+8uB/WKS2oyeSHPQGtM5G8s/OO/FKIx37WwWb2UGZAIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcOUCpoFEQdE+XrbWXbQsglUDxBoc6QR8K8zZ2N+/7U=;
 b=BYitOUoMT9rTDqLg0hlUaca6d8uQomlIGSzHDJGhWfT8jpX9AfhnHYr9mI/qr7c6YQhqumSZRONuDWFM7iiKtvehazOIs+rR+dYZIdisxQaMt4V41FVvXCIVMIqtJ8FmjozDcuqgnCV+3Gc1UWIyB3yDXT+rczxkY/P67ZaCWfhMQ15TtNov6ng6xsXQlvFJLo2MmqmLUYF4P1wZw8HH7n52Ln4ORbAL/CjNbL1UpHU7Qn03GkGK4dTXHdzAdaTADHjA4Q78zTiU9EP+ciM7iOd4Gt9OIqk5oH+6ithM5OMBimeNh/LI8INsF7BnGo7ceCMBz5dzf5ysgdi47rGioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcOUCpoFEQdE+XrbWXbQsglUDxBoc6QR8K8zZ2N+/7U=;
 b=A5GeEX0CM5sYBhOo9Dh4NxrZ4JpqXSyD7SVwmrR8Xvz8Sd+7GAWGt8uVm/5GyTqQHA07F+F8JcF5Ax0b96Hy9Z5kMrgetFq7Atbo5EWrV4q3RUtUTaXpLgKJKNYQ0k2m3s/RTQ1JQxs7KCUqlnM32UDmEfY03cnvzGo/Tox9uZU=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:13 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:13 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 02/17] vhost: dynamically allocate vhost_worker
Date: Mon, 26 Jun 2023 18:22:52 -0500
Message-Id: <20230626232307.97930-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::22) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 88523bb2-ba58-461c-a2fe-08db769c502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpiVtwIpVB41RW94IzQxagwikYT/hNVVKYoOyP2R71PTKdSyjDfTNY7hUQf4Wsd+nd+FK2h/w8ouW/ihvqcqAGAjC9H964lA+BaK4zQKAk9W5VUkZncX4+67ECqHNcgh5PGF5TtMfeXToOPjOD436e1NsU6/ha8im1hwpxWKp98X4E1T75ylDwA0zEv8ahPxSYiqR3+IrOhUWHlpnOmBDEWKcTBQR+Zj/CUesQXe1oGErhljK0VFMDAPqNZbuYIxxgEomi+VisAupiyeMsrF7SRU5hf5THAwEiyMa+7Z6dUE8StGx5yjC5R6hREu0FMLmwQ8S4vxHO34JXRTcbI+2Fp0ZIp1T+/evOr0BG8g5+XE0q8s+o8v2BSjmTN4haqjVdW11u1xbAIwgSTEEJKqv01I/nGMNT5URT4IQFH7BRk4FEMLYj11/HYbdD3ExHDCFAhr9VBnUIYDznurTvsE3WG7uZkmO50dAcXP2rQR85MyLYwX+dfoqbNJG12LmcCxPmNJv5XhQ5DFNmIqmEyQH+frzDmTlVMYhqjhq2A2vmEk+rMn9KdMOP/Ma/ImblFBH/gJ7krox5pyo/V5GDwp6bEDhgb4qcIdknhpr4BxNgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ve0S/5D5eMsWLEGml8AlFo3Q3AkCvPaBChiAEX/Gf1ldHN/5PQrbSZHeSQFE?=
 =?us-ascii?Q?bStyEvZs/jYCEz4ZBn5nlRdVvJ5ZIXQ4xwOxPe5u8juYwqr5TEprLhqIImJr?=
 =?us-ascii?Q?TGZ7dOI68vgsnUVorEH0OKcg80loOqFe3QusCyFjlCk31vL/0PSqFstYa9+K?=
 =?us-ascii?Q?3Zi8sScMnRtFcnvVgVOGu57vlfjmXjLw/Gwm4QhjIkyK27eK9gmpxgbmlB+h?=
 =?us-ascii?Q?0DwB5Oxxc8fejH9LGtvPt4P508WXS1gZrmMEB4rJGZiCf9Ep3IuN31q4L5td?=
 =?us-ascii?Q?wi6VBFv1HWEfELqJtRPmWQifETFm5R10Q9/5rg96ELFmdEEVsSq5eoLWIjnI?=
 =?us-ascii?Q?W3fLvv2hU0ArOcIgZ8ppsEzIiGRCkYUmKj0UYx/SCPJg3BR7itEOErFl8bmF?=
 =?us-ascii?Q?wg7Ha+VaKUvOOytSVnfff7XUXMpkfFCiTDvfrdVYBvmnFxL+eiLAY8IRmYH3?=
 =?us-ascii?Q?v7ihqJGmONq4WptWAiqLNC2f8kA6DGHog1myFKRAhlA2OWJ888jqjdLpgJIL?=
 =?us-ascii?Q?qXWUoKR+kuM24iM43gpK79vdtdobBgC4hM1cZ/NG6wGUKgjeovwj9z+B4I62?=
 =?us-ascii?Q?W4jcRN2aKH3MU4tO3HaKldbxEqMOzxpvmeWip4TPpIk0f+tEv2ipn1GDYcIu?=
 =?us-ascii?Q?ltrQAqij7G65fF2yaT+AnYJVeLzqPJ9nki3MXX+bTA9wpwH7h2o6+HrFnahR?=
 =?us-ascii?Q?GHyWpL3H+6Exty9r2lEmEiPHBs2l0pBqS/w0QR54nTWfvrDZ1OukZDlStk0n?=
 =?us-ascii?Q?dCTmanfZuSAdh7YHRhZLfue2E4HaCZSZMeJoOZwKZ1PosWA2v0dXiMoGAwyp?=
 =?us-ascii?Q?AjoqQ6yLoZoofwnfxETs5Fp8iH2WD4IZ5XOZi+xJ14XFMjx4fWx4D9tVG1zk?=
 =?us-ascii?Q?RFFnrL2OyJbJGQZ/c2R9+xxnNKNUqsKSsk66/7XiJjhrNHdAn8rklRA32gm8?=
 =?us-ascii?Q?GXg/Dp8j1fYztwGE4EgPCC2mhqEYZB4evyoFk5+SYj6oCwRu4TvL0ilAffgi?=
 =?us-ascii?Q?xfadIKwTA5Wa/tkOPzihgOf5jUNimNHk8wbwwbvOYcRzSPqsF6AqyzXwrgtV?=
 =?us-ascii?Q?um/aQkwplak6FM2ICAoysUO62iOSEZPg3gUje5RWrK9LcGWbKusNdirwDSdR?=
 =?us-ascii?Q?MIf5eOBqER76KNXyBN63pcSbZLG949ZABaaJlMCG4iGuojCL3oYB9KG4WOgV?=
 =?us-ascii?Q?wspk+bUZRj6I3MIrM4kiC/Crfc60d63deH11B7tQ+8ZD/+gthMZ1bifEAFCb?=
 =?us-ascii?Q?n3m7LFod6W1hVAkUOofj2AyeNLf9xuBwa26cgmRuo/+ar5L0k04Tq8Fi+mFP?=
 =?us-ascii?Q?pG8Quh4msW5CboBd6i5+kvkfWV38UkOnaThUxxl26f/vl0ZJKBMir0f6bUwy?=
 =?us-ascii?Q?kwRkhy3a5RrXJ9bWmJZA/+OGKwMg/Q6+amXPyU/KAAZd6JN5ZbGQtsJN8R7s?=
 =?us-ascii?Q?Y4g78uZLWPwFbPFW/bzW6Ib96lCbN1eW7hVlyevqj/lsNNO3HPIXWRBp/WXw?=
 =?us-ascii?Q?Ty2W5d8649z24z2LzqUppqaWg63tk04fL19HgBXnOxOqDgCeCLRQDGDzqqaE?=
 =?us-ascii?Q?Jylrxg7wV2PUkKO1B9XK1H9Jtt1ZAJcYrD0xGjgDAT0exyf4jv/RQUji7ScI?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: io5KZDE/c94qMMCza+w5K0nud+ql0yhVVyc7W82tdDpeeTKuoAvtt7VYxtDHLTrU6tqnEqFX1AwZWCa0VpIkjEzrfskq9Rm9HxKTwu4BB1E8fPRnyvUUPkWHdOuZ5mCbJFTzxrdY2wCl8dDRHLPFMCtlAl0nsGozgMUj6S2sGgMSSv2D8fWg5vzhg5nwoFhLyomZR2qvpWAidJgN4TvZO/gi/qiS+oBmQszfUL9A4INQU82rqT5V3j7eESicJtL/FiskzwzM1IoFvm6KwZftk0OiIatpvFRXG4k6RuntO+vFdoEfccA3jX8HRIPB81yA36H1le7/r5PAc+UmB4c/HXaAhnRDXZ+pD9L016PWJcitKSpm6sbXj1iaa98xpOah8a6oz127sa1KED4uv0Pb3fdPFPAxaV096NPyBwvZX21cGVm7T3k4aHYTj0aYgju8qwX6rIQepJ46Zj4oe4692dfzLCrs07Vizzah2A8xTUAAj6LhGO7WdV3H0O1p3q0T6xLrvaSuk4fOMSM05M1YAc6uZiOJ0eQCVVH65r8t16pjxAnm91GEAeV9W57b0dNow9Fb/JpbwQkj4lU9zVbANLUI5y74pFYCTJyT7zHHSMCmP2HTmD+Q7oGBG4Rs6M1wdsd3Q7dl4CwHjtomb1dfOe+VoVdpyEqvgAOV6n66AUZC5jit3QVojl4w7xyffMVD8X8lcPvm9JUkBfrOGHcnU2libvQVbq8+EQA6jXTtS3vNaqfJ0iwdyo8RMMkreUagbuo33EuIjmHNh/BvIuduyDC+6fO8IcM073vqJ51NP2BVcsBfGLsPEuRzS7Ya3cDc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88523bb2-ba58-461c-a2fe-08db769c502f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:13.6333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpJ49oJ98jZYu2RmXX8DuTAtpYxGlwEMpvx5ygez+Ws3z5gOCNBg33j4jnJMXjMvlsEDPKlmNefsO28NKtD4150bMYGS0cAFmAvPTpWENiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: ZSMqZcCma5i-eVyuuMHoQBbFgyJUyp5o
X-Proofpoint-GUID: ZSMqZcCma5i-eVyuuMHoQBbFgyJUyp5o
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

This patchset allows us to allocate multiple workers, so this has us
move from the vhost_worker that's embedded in the vhost_dev to
dynamically allocating it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 66 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  4 +--
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 82966ffb4a5c..dfd96cf6a152 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -235,36 +235,40 @@ void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
 
-	if (dev->worker.vtsk) {
-		init_completion(&flush.wait_event);
-		vhost_work_init(&flush.work, vhost_flush_work);
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
 
-		vhost_work_queue(dev, &flush.work);
+	if (vhost_work_queue(dev, &flush.work))
 		wait_for_completion(&flush.wait_event);
-	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
-void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
+bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
-	if (!dev->worker.vtsk)
-		return;
-
+	if (!dev->worker)
+		return false;
+	/*
+	 * vsock can queue while we do a VHOST_SET_OWNER, so we have a smp_wmb
+	 * when setting up the worker. We don't have a smp_rmb here because
+	 * test_and_set_bit gives us a mb already.
+	 */
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->worker.work_list);
-		vhost_task_wake(dev->worker.vtsk);
+		llist_add(&work->node, &dev->worker->work_list);
+		vhost_task_wake(dev->worker->vtsk);
 	}
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->worker.work_list);
+	return !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -458,8 +462,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	memset(&dev->worker, 0, sizeof(dev->worker));
-	init_llist_head(&dev->worker.work_list);
+	dev->worker = NULL;
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -533,30 +536,47 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 
 static void vhost_worker_free(struct vhost_dev *dev)
 {
-	if (!dev->worker.vtsk)
+	if (!dev->worker)
 		return;
 
-	WARN_ON(!llist_empty(&dev->worker.work_list));
-	vhost_task_stop(dev->worker.vtsk);
-	dev->worker.kcov_handle = 0;
-	dev->worker.vtsk = NULL;
+	WARN_ON(!llist_empty(&dev->worker->work_list));
+	vhost_task_stop(dev->worker->vtsk);
+	kfree(dev->worker);
+	dev->worker = NULL;
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
+	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
 
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_worker, &dev->worker, name);
+	vtsk = vhost_task_create(vhost_worker, worker, name);
 	if (!vtsk)
-		return -ENOMEM;
+		goto free_worker;
+
+	init_llist_head(&worker->work_list);
+	worker->kcov_handle = kcov_common_handle();
+	worker->vtsk = vtsk;
+	/*
+	 * vsock can already try to queue so make sure llist and vtsk are both
+	 * set before vhost_work_queue sees dev->worker is set.
+	 */
+	smp_wmb();
+	dev->worker = worker;
 
-	dev->worker.kcov_handle = kcov_common_handle();
-	dev->worker.vtsk = vtsk;
 	vhost_task_start(vtsk);
 	return 0;
+
+free_worker:
+	kfree(worker);
+	return -ENOMEM;
 }
 
 /* Caller should have device mutex */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 37ce869f8a5c..6cd72d0b5245 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -44,7 +44,7 @@ struct vhost_poll {
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
-void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
+bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 bool vhost_has_work(struct vhost_dev *dev);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
@@ -158,7 +158,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
