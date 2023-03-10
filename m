Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B5BC6FA99
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 22:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5646141733;
	Fri, 10 Mar 2023 22:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5646141733
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=MHNa4f8r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=OX4GhFas
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83tF9if2MaKY; Fri, 10 Mar 2023 22:04:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36DAB41727;
	Fri, 10 Mar 2023 22:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36DAB41727
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 060F9C0089;
	Fri, 10 Mar 2023 22:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04529C0094
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 22:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9B1660F62
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 22:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9B1660F62
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=MHNa4f8r; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=OX4GhFas
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ks52wxRHMiDR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 22:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0390C60F9A
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0390C60F9A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 22:03:58 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32ALhwqj001351; Fri, 10 Mar 2023 22:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=20MEqU52fkJqviH/yEm3F2iccp74ffcwAYB+++uuyd4=;
 b=MHNa4f8rIW7fqSSiY/zwDerwcbkS+lTMjTLF+ZHP1+mmlYD/lXidvq/40OKaZz0ZaR9b
 SI7mWXyYa0s+DUj8rT3oIdmfyuMlrEilWE3PFoOUWTRl10yp7hGgajbXkM2Bv90B1dIG
 1Ryr9U8mqSm8AfG+CKm0za4FD4aRgn7jkpIwD0LNqQpe+ivc50Akp3CB7qrunsWEb/Jv
 FGLnkWrCJRvmYvbuEBC9hgcdSW9f/xZ+g3TSj4PS1fmcxi1pR4PBXwFolXe+5Uuk/DdA
 IRvaQq18sh9/Anm263YSQcO6SFOBD5GkzkTPWO2stYYZwiXsJl52k5RZ7NN/+SNhevQI 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4181644a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Mar 2023 22:03:50 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32AM03SK034983; Fri, 10 Mar 2023 22:03:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3p6fubfdtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Mar 2023 22:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M66eMXC1jt6NTuaGZ1jbOOsH5qFcCnn/9nSdmkUAVAmIBZbagKjeq+6wob+M8doPcn4tOYK6/0LrSrc24tJZYXpUcrtFkkIgMhlVA72PjC5l9QJpl9reD1tc1P7D7ntm26qds3E5sFyGpf/TsdnoE2dxrdyOXuvsKlf6+g7XSw3XVKH333Qbx5Oh3SZWLBxsoLIROf2QzoxbNhUkfYV2i5zLGrb2PYLCikSEmtGTqksf+QmFlwryZJ+vE7fdNqXwHM/bRmLoBbIv1tavJ9Bf4F52WXgdleh+ZWGdL8Be2h1+hVU/UnRCm2fN5NOgZ02igj5AHVp1oOTDKcTUAsPeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20MEqU52fkJqviH/yEm3F2iccp74ffcwAYB+++uuyd4=;
 b=OASgwm6P4aQt/CFMApVRocj2YdNJKje3QDD956G9W3zSi6Q+IV9fsGacZsyJndYMbz60w14F5dHM1wrFfQON4wM3wTs+4bAittQ+iOp0dANtARPMEq1lqb2nE25PP48hMuJNfFJjNuxpWVcHq/PuieRHo3KFYSof3as4+R1pYmMamQkRF/Oxs9X4PclBgXC3PWBudIjLAG+vf+mtmbqFblxiWpZ79aQoRcU7G7MQAbx5hD3K780blp4q9vswSZlMsPDYapH5K/rajqSoA5VBx2GIX5zFNo1EEccIg2X53aWs6iDYaG2ISODkkr4v/vbxMEIiMVP5/2vASvtITH0wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20MEqU52fkJqviH/yEm3F2iccp74ffcwAYB+++uuyd4=;
 b=OX4GhFasJdd5UOJUXKkzaojR5JlCX8aR2DehJ+19NjOnxnUhtyGj7yv+k0LJ+6jqpdffKyy4W78DRntz7m9bcNOM6arXQ3YKy+M+IIQsuH3DpZpyUFBqf6B71E+p7FCmiBFhmpJMHUVTRoD5jAm911yevnymm8Cjs80o+fZkW7E=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY5PR10MB5940.namprd10.prod.outlook.com (2603:10b6:930:2b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:47 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:47 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, brauner@kernel.org,
 ebiederm@xmission.com, torvalds@linux-foundation.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] fork: Add kernel_clone_args flag to ignore signals
Date: Fri, 10 Mar 2023 16:03:28 -0600
Message-Id: <20230310220332.5309-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY5PR10MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 66faaa3e-ad66-4ad5-ae02-08db21b3523c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxTTm2Rr4tM9Lk2x45qvTla4q7cZChStK0abhiYOmcXrcaxpAHbe+lpNFdtrImtDRdTBqrQnGrt1kzU2oNmSgnsFD8YykZ/eO9k8x6x8LjyUzG8Hkasow5QpVJdKrF4Q7ADd0Zsm1YxdRDs8UWWqHEYKMKnF1EmX/hannIU9V6hsyFcHjtqnnTZk5WTcvk1qaQt2LhS17+p2cfBiZPGxdClrXiYD3HvMkkjxzwG7d9BNZnhlYnSgIoOLDxpFSVaRaybmoERTxu5ISD5lAZfK0GmUK4GEqbVnzoWoNhzG/P9suciXWzJlbogaK57QABYX/B1m/IsDC5Rb6HRnfRUPiHWMKepQxsYMXWreRwzAuDTnLLcJ5wBQ967qorCVZtnCPP05KWEODbB6GCxqFsFwqOwvfg+nVZvZPqqNJzzS/Z/eA0Zq+tctH4yS4ZsODRqVHbFJkim9Q39iaKdMcVcpdTDp7EbeVGnyK3CdsaTE84SsD1zjNoa5HWTMo29yJfDseuda77GuJqVlqztjZZ2bKzXkyPhCevsoKTpNky5BDyfjTKul63XuNN1+D1VE6ytrCXCcwR7nw5YICc5NG1YMRLSiaU3JTFUniUpDvRuKvcpc2n//bt8udLVAlEgHh/b3ABW8mDO+Q78k/Pl7he/tIip9008NI+FYM4lZjw7ht+GgJkro6aXk4YBXuO+uFfIt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199018)(36756003)(6666004)(83380400001)(478600001)(54906003)(921005)(6506007)(316002)(38100700002)(2616005)(6486002)(6512007)(26005)(186003)(1076003)(41300700001)(2906002)(7416002)(5660300002)(66476007)(8936002)(66946007)(8676002)(66556008)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7qp5eUKFxnCDBHYMaaZCL10U91SzeKtM6V0uPjTb0FWzvgd6SltI9A2kXFX?=
 =?us-ascii?Q?5VHdML6ifye1rItFT5XNWu+Z578M8WLRBQaGLI8njEXrZiUTz4MqKL7cTTU8?=
 =?us-ascii?Q?lFUEM1H4BlWoNcO2f4Pj1KbVzERjFHEcNYsldM0YBaO1zROoYa2CcGXUa1W6?=
 =?us-ascii?Q?5JBF9D7BP+Y/2WJFc1YKSnxpiq8hHoUKeIuQX6nnAFDtNwzMmwNeKTz1PK+v?=
 =?us-ascii?Q?s//QnP0NZ7pEO2PsIVRGzBhoEaZjHcqKkFJtsv06t2nXqVrpejZh6LiDq1po?=
 =?us-ascii?Q?bMQUf0t5rDxmFpOEzJsB9B6PHgXADnwgwKgXPBOZbEmscz02GWiEl4udfPXp?=
 =?us-ascii?Q?M5psjnWNuyIleaizrvgcZj/pP1ds2UIqlS9OA7BMtY4G9LMywFdLulht0WGj?=
 =?us-ascii?Q?ZGMNAoXDtKp8ecrOEXmB+ufO9tzYBKYP1000ibvsd1w2rpa//KT4xgrEIGmb?=
 =?us-ascii?Q?1NmDpJyDFe7RBmJFlCYsygYPCBU2OdpjPb6oJRom6WTcDctXXc9VmdNCMcTw?=
 =?us-ascii?Q?6BeGpYbzOMLEyeAQFvIvQR7Udnie2zB7mK/iDM1JffX1vs+3vjpT0PaTRGbj?=
 =?us-ascii?Q?dM8VrffplUajblREdZIjxEqsBeQIrqlTYWgF/kIFCWmqKER8el5iBcgoz+nM?=
 =?us-ascii?Q?dvK9aMc+Z+xrWskK2uP98zdw3bvjVOgT8ZSuzxygiEc5K+wvO9LAqrqCpoIF?=
 =?us-ascii?Q?bJWMcCrgQTBM3MEhZIVyTj2Fctwic8nKtvaHgRwUFE+P/OayScmaROEl8OaE?=
 =?us-ascii?Q?4snYdWNistJ2bBWDp7fsjULMdO58nGVz7alhDDHRcJNS44O/WeXwmxXQVNDe?=
 =?us-ascii?Q?KKIMGEsTvAyQxrty5udH6iR0i9XU959QtDOWEn/nhNR3TkkSNJXjWPj9dd7/?=
 =?us-ascii?Q?loo3v6dVWD3CogYm1ESpCf4OPiJ3GVInU2jbYP/a+ciVfBG00flBrXo1jI0d?=
 =?us-ascii?Q?d220vWfKE9P3HaIHOAtfd4nuVX225HatKhyH765cX4HV2UB1fr9IDw36lIux?=
 =?us-ascii?Q?M5krQflMlHa41eJHUDzBcLZnmE46YurdMbasp00SU+UMGqTOlNLx3vz4GWWe?=
 =?us-ascii?Q?0e9XAwZKsIvzSGtwqm38vFEHruBRGPmzSyZGdV32hG4ooJh6HWDmA65EOGYt?=
 =?us-ascii?Q?h+JAFi9hwv5WwPqxhZo1Sr9ihWQ3dsfFw6Ftgr5Ix0ZQsLqGAZkFZz61Ls6a?=
 =?us-ascii?Q?sozuZFd/xqJFbsCpke0aED5ntQqi4ba5itDmYUpJ/EnDx2cbbBE1GYEXICYz?=
 =?us-ascii?Q?DJ8OfOFPTMXec/20gJrnru5/+E37BCZn4jC+5OCwTvT+RAlAYivOjoSetZyH?=
 =?us-ascii?Q?tSGSMGkmhsyp707FwqpyWbyYqgLrakUvxgVnC4/1Qroxa00ay4OQ3+77rFBP?=
 =?us-ascii?Q?9yChC31wo0+vvgMIGEzOjOQ0XOVHnj7vT7nFHee9IzDEXDQ80FM8UtosxfHa?=
 =?us-ascii?Q?C4ISFWKnQdje/0DFCEBOf08fGsJoSlqD1rtPSs/+EL30vqTuxhRGrIs9CcAN?=
 =?us-ascii?Q?RyRFu37DyA+flbF5v9JgQkEIYysRPWevYdR2V8CBiX43dS6oR3DjnMPPESQB?=
 =?us-ascii?Q?yh2yva7LmxjGSrR4NACahUq3TSJVsN4o0jdyM9uz9zJCtm6LgypczI7o6LAC?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?I/nCNzbaFYqvLaIEAaToCEEDi1Qpi0dP2AJqt0hV9tnivioi+fLw25aU5SuZ?=
 =?us-ascii?Q?nK18DXvoMtY2uQZHN5FIjS1dt5Pxk0WFgTctPkMSrHSQZxmcspRONsQPO+7m?=
 =?us-ascii?Q?kSjr4RnZZBwip9JivzBJB+V5nvJtJO3FveFtBGO3wxUbATg7QQGFNBeIINfv?=
 =?us-ascii?Q?L/OFl/+rsSQ8Lfb1vcdzjfOLFHLbV5DavN2TiPJXp4MTVG1QxGy/WbfygvVW?=
 =?us-ascii?Q?IO0+LyRGWvjNGHLFzXq0xh4yjenhziYBLEcsJW8xYa+qjRxaQdtEHM4jsL5m?=
 =?us-ascii?Q?mXiF/SwOUDSV3CXYdcTngR6I/Q8rcGf1ybfzfviTz59Q3oCgEXMBSOcCZX7k?=
 =?us-ascii?Q?muF945+iUumfpjF40ahTBvhrRrEDkiRbB+Wsr29qlE8ONyqaXND+Ib63iAUH?=
 =?us-ascii?Q?4ggfLY9CfQwQ4UKVAbilgsjPm/UlKUNA18DQ6InV9wcPbAq+0f4XwqawA+VS?=
 =?us-ascii?Q?BX6au3QUmbtElqoHtEal0y7ByDXKd39cRUG4seYKd2Nh+0sHRSVPolc2dFP2?=
 =?us-ascii?Q?yDWMbBAU2vBMJYkMMFL6HIM9A1DOXAjPSPhovAEAwpDN0HIM5w0bDtX0O8AE?=
 =?us-ascii?Q?mxGbmq+d26Pp7G2KHkoeIZl7TIRMTcLwJKMNWKy0wmR+98Uieyh77oFj0q0M?=
 =?us-ascii?Q?LaRRKGPyVAzYX3P1gquGfSxb4QUSki5/fp1hJVFRLDnPeGw10JSpNc9tVLhp?=
 =?us-ascii?Q?OmXrTEfmEvp0g+y3N81n2L/cC67Cgjgk3a17hOSfARoaIE0NNJ4hh/RsqUEL?=
 =?us-ascii?Q?hzfI5gLceAT2rcCKUE9nZ0Ook0SayWFySegwjVCvhffYdRhqUr1eukgDhBvM?=
 =?us-ascii?Q?vwj9jRgUhlq5DsF3qf7fTQQ8i0Pys5rvNA3JUFaJd7K8woDnbQZ0SBu3x+4f?=
 =?us-ascii?Q?09TfI5QyugWvZtFgphWJBDdRtdxPnfXvaKSC9CxxogYc0sxPSUIgF9q3+TAx?=
 =?us-ascii?Q?Q5n6ogcM3u1kEEI9x+DOBWrrj+BkmGj1mweNHpgTPPFCDSHRy6hi8+Xfj3Vk?=
 =?us-ascii?Q?hbojuvpB11USdfhsdSQSdOPBAVKe3UKfdCOHB5eQ2Yl9lQo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66faaa3e-ad66-4ad5-ae02-08db21b3523c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:47.2971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHm6HYIEzCt5/5jk/WZlPMAiEpxNWhIBHgIcBqiWSf/8F2K+NRebB68zL4HCWk35Z2zUL1OymP7gyI32Cu9cw8sjkpvfYXBp3/VfApJ6bDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100176
X-Proofpoint-ORIG-GUID: _LRIsCuipV2wcVVGmmd_atBwGahH2TAd
X-Proofpoint-GUID: _LRIsCuipV2wcVVGmmd_atBwGahH2TAd
Cc: Christoph Hellwig <hch@lst.de>
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

Since:

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

kthreads have been ignoring signals by default, and the vhost layer has
never had a need to change that. This patch adds an option flag,
USER_WORKER_SIG_IGN, handled in copy_process() after copy_sighand()
and copy_signals() so vhost_tasks added in the next patches can continue
to ignore singals.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 4f816048794f..00c54bfac0b5 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,6 +29,7 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
+	u32 ignore_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/kernel/fork.c b/kernel/fork.c
index 258163ea5cd2..244aae6c2395 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2287,6 +2287,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->ignore_signals)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
