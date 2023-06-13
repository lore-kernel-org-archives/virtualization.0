Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34490C88CB4
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CEB640994;
	Tue, 13 Jun 2023 01:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CEB640994
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=lkkA7vMO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=X/MsQCRr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yVtL0B6L9BOI; Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C976E402D5;
	Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C976E402D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35F5FC0029;
	Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DC30C0091
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9475940A8B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9475940A8B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=lkkA7vMO; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=X/MsQCRr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vI3lWUE_HPGY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B2DF408B6
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B2DF408B6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjWZ016684; Tue, 13 Jun 2023 01:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qpo8NvtLxdl70EWgiQHmFKeQkASzxT90SDu3SN5Xp2c=;
 b=lkkA7vMOK6CO6CxexZ6I4t4aMP0rgpSTe/5mv0nfqmyWOhlVuvxyR/bpMpSlqzLDabHi
 B3W7xZ17d7oZ3hgeiWg+ZW0rfcE0ijyRc23ua6J3oTETOfsmjl/5Asj6jCi9t4wFY7EE
 nnxuQLKMVHb5B65M5nwT/8rarRyo8qy1f81070Q27/7TZfqiI6EgYy6zptRnQOHiZg85
 YVrescjU+XGjJMSVEo4TkTQ/vYuV2xlJ7Zchq2qtv0X5YgsaJeOcipnGUrDWdaltU102
 /aoeSWZ4B+Ao6suYrRedMqoywI6RFasUkcs7ANXQPLqhnKHu1KxvOh9fJ5mQ7Vd4lxFB Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3c5f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:21 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRM021613; Tue, 13 Jun 2023 01:33:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-11
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfVbcONU+3MIJFkSWz8A5ThEnZhtT3Yezq0FqWLMTaDjRQCj87iOxASbAprywL65moPCVcbV2YtcO6JVXK4ayts3OoAPUYBdfAztK3hJyh9JwuU7wiFrgi5Nm3+JWwW1UjysS9JO6xm9yG6rK0PvkqK+h9upyA1anwzNljnaVbG0I+InhIYVG7vz2MMZ/PDIcnSXWcDnWU4h2SpCwPwzyHibLStHB9BiWvlB1lXby00HPcB8WLNTgVStOAFCxr1P3XQLBfEkTbOUWhaX8q4liH1Pb1TMoVk+tWEDJh9IF5cipBTHDpOs9SlmUMDP1xZkF5n8C/5OPSiUJVd1QAoOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpo8NvtLxdl70EWgiQHmFKeQkASzxT90SDu3SN5Xp2c=;
 b=XpUaMDivGbx2JVQT8wPRDFLVgY71nwANGoBDgiNykN5G7Y1gRe0eZ/JuOAeCToFTEIluZlXfP3FQM7VgddDE/Li4faS8MZeQ1D5uf/VQG/iVc2RmT8A3y5E0bE6JNGUHyljLhdv08Rc+KWOy071CWImqy6vFVH713cvkUyCzL5mn++AjapGDB7mG8MN3NTZOuLWaxqxGAnXRbNJvZBfbRuugtILkyYgpmbBOdbD4/8/y79ZVG5QAKJrqOPOmOG31GkBsUmNGoOx8Ne4CzHHIMX29ym0RzzzIGi94GH8xS6loafI+8Sl/mWC1qx1bCwsc/AqqwLeSLtvaZD8VpTWQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpo8NvtLxdl70EWgiQHmFKeQkASzxT90SDu3SN5Xp2c=;
 b=X/MsQCRrcn0HLlZczfqW7G9b+cUjc8zvwGGb/VMSKNw+M9NkQ8blLE07pu5rJ0Fd2/ZE7ZfUWehgzaBSg+iurQJlBtOsIpnXUfs6AVEeynp7UHuwhtQMkW/WdnXyVKoenKs6NoGGjtDMwHZ3HJQ9VALDU5QhkueTiUATE8TYfsI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:15 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:15 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 14/17] vhost: replace single worker pointer with xarray
Date: Mon, 12 Jun 2023 20:32:45 -0500
Message-Id: <20230613013248.12196-15-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::16) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0d0cfd-8236-4b40-9814-08db6bae288f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xap8l2sobi3cBRPu/gP3wSjmg2nDwd2wQUkqUb0+Bs0Fsjkb8aOgz5Nx+EvBFbnsytCuOLTFxDhFoEZrppmF2Un6qjzAnH+a/+3WJEOZ7eRN3Ap2AUDfosomfWltguvE5TDnFQ5xr4lfefNb0utcYBFWMSBCZv+7yltM/z/M9LMC/tpkndlksnhOWJ8YbgD7ZQU4Z7OK6euCpCo2nc78Q60PNKn2Bf3VYCnDjXGgeOv7J6FRiAkV1tZh3ePlDAhDxZcP/IaBYeHQX0t3RYT2xij/hJtCwpVGjA3YX66UkFV8FfNS/L8uFVkWoNlUAmfdshjiCXIl2J4nXxUWP+pnR/FTk7XKzk2AcvPe4zCSkHioB8n5MImOIyzoDnPjdxxzK13um+DOvE9WBLU0so0aU02CRKNbL2Hx2u6MF64I+c7Qv438UGc79AV2DAo0IKWYEOV4Svgw6pNivoFslthipNUj5eoDy9wIn+C3vGULRbiCL4K/dLQnz38Atof3AIYmu5JtyzTjoXT94BLMgGsLhgKCwQEGO03pAg1U+POY+/tjOTHAayBZIKqm5LhLUduj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8MYEHKhm1tMrLvIRBL+SCQPlZ+NrMSIv4XVNRTYfn/wMnQ//iqZgsvHwtAk?=
 =?us-ascii?Q?3mkuIHfW8QoO6aW5mcxHoQl0J4TVYN3sPrE4JbTpBmwRjnmiRWZ1OI8k1wgP?=
 =?us-ascii?Q?yzATu+IlIbuMn7LIVf9Y1tKOSkhDov5pcY4ihXxDKXLHNB88g+kMqPueXArx?=
 =?us-ascii?Q?i3kuCXlOXH6oLEezMEBax6YaPdZh1hxpVWrTiJPitDN8oePxkpTeEZSz5EO4?=
 =?us-ascii?Q?Pro0zCyUx4J1AeCDzBc2Dwgve2XkDaXUDHi8MLqJUGphPkfvPxx2XmOQEVVt?=
 =?us-ascii?Q?pDbd7X17fyhX8MrxZiOONmhh3Nh8Ttk/l8+nJlMtUkikfvld/QuaftQbvQOw?=
 =?us-ascii?Q?tfEWXyiJ7MXwhjqbPkFzMHOxTw94GMRwQ2RFXeinvysnoqGvIIuK1fXO7puP?=
 =?us-ascii?Q?NUFc3mKV6XiyZ5l5Lx9ewbgFaYoYDia1NbTItpJ3Fde6L2dFxsNIGzwl1ZPe?=
 =?us-ascii?Q?eimSzxtOEqa1J8jlYCP1eP0vpyUtvTGqyDGg+cvj2Yj3wdkIxZiwQW/UE8A9?=
 =?us-ascii?Q?L+Q3Egxp+LzDs7isVlD6xW9BgqdiJg54Y1M3LqQvgikQ8OJjAiQQKjueBVCs?=
 =?us-ascii?Q?Sq6URcHuiFYDV/oWV76Iv1KdN17ZkvYQeoVFw3bPKaMYc9ehxzgl5NcupkYS?=
 =?us-ascii?Q?xmy0EB+nE7Q1Q89U5vAfQGN9SZxbP82UQThjAo0afoDROm21aHsU1iqQGdD4?=
 =?us-ascii?Q?1G7WAou4y3EmkYLwVkFAKWDU5O5Y8QnIZ1iDrrblCdFozXHzsT2TNQ6pH65a?=
 =?us-ascii?Q?+dYYA8aBRg7U0ti4W+eaAA/ohV++jduGRPBCKAg6Ft6iuXtIGdj8oVN/GAI6?=
 =?us-ascii?Q?i3yKsgVnp0uy37T2E9k39X9Nn0kGZo1nQNqs/3kMCxmsPYlIiUeGT/68n70V?=
 =?us-ascii?Q?1A6D0xoczyYqK7gh+BxVh+h2THyx0AvyYu38o+AiyweTCEI+SQ50bxoWV/QX?=
 =?us-ascii?Q?ZEWNRPfGAWTGYa9MkQmQ5ebAlQAMB+Bp8zscgOXHd6vBX+nusO7fYP/24QQ0?=
 =?us-ascii?Q?qPUCFatMeuCpALY/fIhKzLeFGxV2Np82dRHvHBqlEykrOwdSYzVNlbb2P74+?=
 =?us-ascii?Q?9iZMgdy/ApEBVd6O8p4vgranQ1/EuQYLEH9RoaSzfOf0i/ANYGHm/IYr0e69?=
 =?us-ascii?Q?R6kHrL6vEYPBq0R5AmdQG043US/VjEiUs7AUkNklLS/biaOl42D8TaUSMW91?=
 =?us-ascii?Q?X3KF1i6svfpqw4BGOu9mnHN6c+zZDl8spJQsTP7hOnOvYWOJFTGTSVrd9kb6?=
 =?us-ascii?Q?mY3LxPvcf9c1NM8Wg5jhoJwdRksR/Unifd70PnSrH45HGlRlP00s2uSTJphK?=
 =?us-ascii?Q?b8QzrAZFqhk0aaz+x0MsEZibsYBmSu8LPYqA9My73qAwPIiRg9RNbknvDhaX?=
 =?us-ascii?Q?epcRFBUq8smY5tLXI+cFuoaadD/VcApw8GPea0J6emOJU/XKHJs3FWf1+9IQ?=
 =?us-ascii?Q?cOCng9F/DKw+OwIgodkhtYLRX1NiXG000dRYulj+6J1xI7FJl+gXpWdy4icq?=
 =?us-ascii?Q?5SPt5PV1uwRvGo6uUB0azRq1lDksKHl13RuhMg7yFl9WMO4emFzXiywgTnVC?=
 =?us-ascii?Q?QHS4iQfM6tZLi0/j6+0UolIEJUTd5+JjD0a7DS/Dg5gksKf5Bov1LyqMmgDK?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bbDsnyWKrBJSgCSzm7pgXDp1/0r4lJYVjtkqv42a6yuBsgGsCSYGqCrDvaGPYO7gJx5XJj2VAXA6+UD9qaF6py3LfR+vqDR+qaiBJu0cL/x8WgQ+MnBWWN3XDexxFQD2xBbtYoozFYie0svN//6zKeOR4/uS3jAJi/3tFRllPtrye0ljkWsAJLSiXfiVNMySGD0idLgo4jkSAXGeL7koXcwPugKdc1g2QdSPB61BOT7rbVoko1iF57iLp4MbYor/YWe6OcM5WW77z0GMyI4PywiFrdDcg/feHWGsVpoyQbzszM7e3LCHQvkviuQhPlv2miQkBaeAut2B5pedx4YBIpq/D1sZebQTexRTLv4iTTaLvc8yLv+BUs6sMvfOxAlRngicEOs0uvgXKyeABooLaskrZe3XLx+KdPpN+FTTLEhhfxv3FUq3x/uJ1q469+B94XnkBv43ygiYijbGEjTEFn+otlnpEWjyw6GUDLQdd199/0FTLhBS6ecA/KSEVHZR7OdJq1JoEtPTuiVjHeKmO3U0aXgFI3eZbYlLFE1GQ3JMfkZzn+NmpiuZ8u7nopSVFGfcRviRNleiNMjso31Rqeww+yJugUtklO4hx4QDUeJkyME/XuVWhRNW4YbN/mNYwOPnubBPR8ej/qdRfo9SBy+QmUpOi5FpW3+Xst632YzcAbGvGiPckAglgJjW9HtarZmB84OkRNvo5N+tS0hiTuynPVjVswKI0fl0Hd9+DXl+KxTN18IflOBVfhbQ84kjm4Vi/MNs9wHm+6s9Lox6VIX4bFMigQMsb3OxW02D3cnFcNgIpMCETSf2lbcw+cMW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0d0cfd-8236-4b40-9814-08db6bae288f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:15.3117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQ9QFlPokt0gsA0HAOIaInB+YEX9jPgzJ/bUuf8GLqRgSXMCuCYdIPOKp6CjImsFJtTjvKIoshX8dL5kHI1b6/PacJV8hjK+PYKMBipliPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: rUDFKqmB952xJw3vCL8TRQihhQGVH4d5
X-Proofpoint-ORIG-GUID: rUDFKqmB952xJw3vCL8TRQihhQGVH4d5
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

The next patch allows userspace to create multiple workers per device,
so this patch replaces the vhost_worker pointer with an xarray so we
can store mupltiple workers and look them up.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 61 +++++++++++++++++++++++++++++++------------
 drivers/vhost/vhost.h |  3 ++-
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0db093dfaa22..f07f92a67e59 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -280,7 +280,11 @@ EXPORT_SYMBOL_GPL(vhost_vq_flush);
 
 void vhost_dev_flush(struct vhost_dev *dev)
 {
-	vhost_worker_flush(dev->worker);
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_worker_flush(worker);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
@@ -481,7 +485,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	dev->worker = NULL;
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -491,7 +494,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
 	spin_lock_init(&dev->iotlb_lock);
-
+	xa_init_flags(&dev->worker_xa, XA_FLAGS_ALLOC);
 
 	for (i = 0; i < dev->nvqs; ++i) {
 		vq = dev->vqs[i];
@@ -554,15 +557,32 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_free(struct vhost_dev *dev)
+static void vhost_worker_destroy(struct vhost_dev *dev,
+				 struct vhost_worker *worker)
 {
-	if (!dev->worker)
+	if (!worker)
 		return;
 
-	WARN_ON(!llist_empty(&dev->worker->work_list));
-	vhost_task_stop(dev->worker->vtsk);
-	kfree(dev->worker);
-	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	xa_erase(&dev->worker_xa, worker->id);
+	vhost_task_stop(worker->vtsk);
+	kfree(worker);
+}
+
+static void vhost_workers_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	if (!dev->use_worker)
+		return;
+	/*
+	 * Free the default worker we created and cleanup workers userspace
+	 * created but couldn't clean up (it forgot or crashed).
+	 */
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_worker_destroy(dev, worker);
+	xa_destroy(&dev->worker_xa);
 }
 
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
@@ -570,6 +590,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
+	int ret;
+	u32 id;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
@@ -584,16 +606,18 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
 	worker->vtsk = vtsk;
-	/*
-	 * vsock can already try to queue so make sure llist and vtsk are both
-	 * set before vhost_work_queue sees dev->worker is set.
-	 */
-	smp_wmb();
-	dev->worker = worker;
 
 	vhost_task_start(vtsk);
+
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+	worker->id = id;
+
 	return worker;
 
+stop_worker:
+	vhost_task_stop(vtsk);
 free_worker:
 	kfree(worker);
 	return NULL;
@@ -650,6 +674,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 			err = -ENOMEM;
 			goto err_worker;
 		}
+		/*
+		 * vsock can already try to queue so make sure the worker
+		 * is setup before vhost_vq_work_queue sees vq->worker is set.
+		 */
+		smp_wmb();
 
 		for (i = 0; i < dev->nvqs; i++)
 			dev->vqs[i]->worker = worker;
@@ -751,7 +780,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	vhost_worker_free(dev);
+	vhost_workers_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index b850f534bc9a..31937e98c01b 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -30,6 +30,7 @@ struct vhost_worker {
 	struct vhost_task	*vtsk;
 	struct llist_head	work_list;
 	u64			kcov_handle;
+	u32			id;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -159,7 +160,6 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -169,6 +169,7 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
+	struct xarray worker_xa;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
