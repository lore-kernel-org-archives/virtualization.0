Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1109FEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C39D60F56;
	Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C39D60F56
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=cs6wg08B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=fp6ToeUq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8WyQVB7v9Fu; Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4339D60797;
	Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4339D60797
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A0EBC0095;
	Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB17AC0037
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4128405A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4128405A6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=cs6wg08B; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=fp6ToeUq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k9bfCBZvod4m
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24E9540570
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24E9540570
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:23 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMi6VV023184; Mon, 26 Jun 2023 23:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=nc31CUAe1jvvoyE3iTakkOwIBEvmlAgcYJ0zfIEOREo=;
 b=cs6wg08BtwFHujo+LwMuzPoJco/JTuaCutEs220GxBuTbxymdA8Htn9hjuW4SNw47pRt
 IrrkLRBaY0xDNRXU7AKF7iz+jIsnFZPxK+LzzVUF7MNdDyin+md9VHpR7PCizIAlI6Jn
 JzGaX9Sxc8fxWMAyc/zPIMnKkOFB52vcyfZPFPSVc/kNQ8URi4OQuLCeAdjYX3UC876p
 QxMTadLhzioPVDkKHD1PY5gtj70BLhmzuIvmFp/EJo0gUD5BXuiJhbElGT3QnxSBEtR6
 TIrMjEAdqUPn/OPCSc5d5OpeDQPP03dSgZeXi8JzrSvoWOQQKFhXDTnzYIR+ElzqQSC9 kA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq933uev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QLDFCu018832; Mon, 26 Jun 2023 23:23:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3ywgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEpRDsY5+A9J6BAnvQ7B0rRa6RI6u3D/rCUX+EZwHLfZripZAwIvYoyI9Z80sUnjmUuSrR46xzDhzwJutpVQp/QaxxgXRdYym16Sq8CVGP63DtrkTidKDl5lLGspAZdmfpxdERTlaLmcooCoPxRP6hvR7TVTacQFIA870U8G7MthF7tBfD6abHXkTwZ2BU3pprfw3VoTRsGw1iUF2Yu1S9DIsrQ5iS2JdLO8gjGOy+gCS8+D13XG7AI0V6cYoxUUA8isS6QPZYYGlb01ftXiBJLyf4MInI4O9hVCqRoGBtm+hfmiCCuIYfpLipFMRGew8drEBgqzDcQ86Mc2Aj6oZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc31CUAe1jvvoyE3iTakkOwIBEvmlAgcYJ0zfIEOREo=;
 b=PbqnmcQ7kXwam9+rLnSinjUuNwhn+ruIgxkJRwzZkzKBZSjt7NevxfL/U8Lwv+vEF/PC+yt+keUtt0X3W/ydPTUQ2q9YOia4QfpORS0emp1LApUyMwHCqRsT++D0qaAKLqM5djmCoJ1r1uukLXQiOYbzasdz+N6YTecZVUGkBIXA17M7vMc3+23HGgX0ogfCKWakCeMn7TvbOqEzOt6ABBnb22Yt+xHrLwIng/POPoHs85AVGo7J8VpR+VmDbn7Q8qZrpgEgW5WDEA6ba1x3hUdVxdJG/tjakeMnSRbwwZoJ6/sm3t2ZfxsDQDC7LQYbG8mc5rMERydXEB5MjT//Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc31CUAe1jvvoyE3iTakkOwIBEvmlAgcYJ0zfIEOREo=;
 b=fp6ToeUqoQLsuLTmSOxxpCcNo+E7f89r3tpeZA5A0vSQKWMC6QQZUYtKOK6rMx0qjeYIOMpQw3OJY3ZP/740t/woM1TyepzCGf+XF98c7MRO3Opewcd+qaFQ5M7hFA25iguUT2YauO5sNvuUNQsu4yyuL2xWcQH9ccKF/UCXI+k=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:10 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:10 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 00/17] vhost: multiple worker support
Date: Mon, 26 Jun 2023 18:22:50 -0500
Message-Id: <20230626232307.97930-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DS7PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::7) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8be594-323c-4627-3690-08db769c4dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKZWgZYqNrzfm6ZXRbytvmf/5ScV0Oh8mj3QfWqU5FlDAVmyP2QtIs8T/jYpWfRc3dMTMJZR0CFJTzxaB3TGTeC99WfP0/Q6xWUSmU+fq3abAU1zIkEga/3FES2HAaOCSgyUz6MT2XXsBLwGN3te3tHSIPuBMYMg8xaXCWb2aOkIuOUHy4X+2ca7lOieH7THdgQ6bhXXA8LM5Oi00u2Dly6anrN9nCs0X7ctdUZNf1u5SHuKJNU8RYiOZqpRUURvKjFvMbreUOKRBcCt5O1BzEduQLrFzbIqeCvDjQbqeI1du6a1zbL146qUnNyb3pLsmYC32fJqp91Yi9oyPyrQn0SrDwlj0egmierr+imAzESzMDWsBJQjRPAzj90zY24zXQGeUGqkVtOKZSxaHYZtD5EH9Y+8AfOuAbIHk8ClCyhCRRgkdXybcIi5mLyish98W0dGYQ5P3BDBNvH6AhpLEJyTFrPfLFHiVlOOkf+BA2j6mk7uXgrCbvuOBpLqYh4KnF1sK26ZG9j5U1Sb0LBqPgxyf50h5DEmkNu2p5BbBfLJe2Y+o1fMrRopBGhIdgCB3t1KBc2bnYoTkYfCYyzWYobw9EVN0wyYh11/ztvvKnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0twjRbKJMb/+/nUDEVZD0H7Rk815LzoEUVx4bjff1zbvcGQfPp9IOFYjXOIi?=
 =?us-ascii?Q?a7xp6SowShN0vemY23cnCls4lQ8y8pyrkF68CNvOzVZeKuBEn5lxEuagWPnm?=
 =?us-ascii?Q?xGwtPc6NodThdIAWMhLV2cFsEKsT0w5wpy5DpWHMPRaJaVWyht1fgpcezeQv?=
 =?us-ascii?Q?HXuZK6l1ZYi4+ke93DaFvrBq8a9OsbSMAPHgzuEfTF0EXo+kbCitdzlEGgJo?=
 =?us-ascii?Q?7OAPuXpG9NmTNp+tq5FnCgLxFerXCLmZbw6vZ/PVxBuzFeq+mMrJ4HT/r9F9?=
 =?us-ascii?Q?kgenR1PWc5bfuCjMryvs38GZLaNx66D+6SxEw2d/DtJKvvxteRiakvPPRHi/?=
 =?us-ascii?Q?zRxvHZnuY/yprH/564ZUQAptNqjbFIBoGvmybXsiRBRfF2tFiQ3uLf71xWV3?=
 =?us-ascii?Q?DciYHcxKkDuNUbLHg3mFYhRJuZnWWyTcA5T0S6f4gW29NNzsJZd63EPpuKUt?=
 =?us-ascii?Q?d66NQkEesh0rt3VKtdkN1c7fdfHAGBOxxpfMHcyfF7WJW9Fy2fWsbqSZuofn?=
 =?us-ascii?Q?i8PxmQfdP1TM5Tt9sEJwe87TV1dwSJFKML8g8ZdcmboeagDKN2znz2Ph+DSh?=
 =?us-ascii?Q?+YhcOgQ62xtGO8WjULkysC5zACk8KITpPFsDPpRvwDkYP4AGX7rQv3MpslEI?=
 =?us-ascii?Q?gKzIj8SocI+J8fxZ/W6zs0gzCLtDsTP9ZIK7aV77Kgm6JOZyhXI7KbuGKsN7?=
 =?us-ascii?Q?WLOQr2fIcNyaMTzw8uuUDemiQuXefmyPmHc2+Sl8Arc7ou7YabBUnC1NKL1v?=
 =?us-ascii?Q?17LOrWQSBTaVpLKfHPmE0dVoJKMVOZdEs+oIL0Mbb1Wj0UPLlyDPg3BuHOtM?=
 =?us-ascii?Q?GjSc0IxWtYmVaUC+D467EzBXyyokJt1L/lrX4eJLiOU+2e1fwzI1T6odqsNm?=
 =?us-ascii?Q?C/+YkydUVrLWzQcJkGl8qBe2K4jlloEyQAW6C54TuBkNBI/2KNLwFIM5///z?=
 =?us-ascii?Q?oCThcxax/gIrRzDOG7d1QW95ZiT3nZSDxjk/O3t7y8/dgQCCpfb5Ere8g7Pe?=
 =?us-ascii?Q?c6hT+2oPdW/yaeAXwYkzG3eKTgR+mGyrgu5GqaLXhVMBxxCB4WFAETWiNy8E?=
 =?us-ascii?Q?h7A/2UR+xMPagHcEhlgJtqXcXnNU+dCTIW+B9qslU8KKlaqgi4IefOzjcjYa?=
 =?us-ascii?Q?QizyuBBEfmb5IhvalXIekN5jKUBFHEyH3zXCNNpsUlGhQYYYuACwEZ6C6NpT?=
 =?us-ascii?Q?a3WhjOoko5kZrkeX/g/iWz6qYB2FF+LW/ujX1Wpnedt3MAPcuHPh1jvO1sQB?=
 =?us-ascii?Q?tZSkk4BwEDrU8K6Akc1c7m7VCzvuoghlXOoW2Wh2QX9hHX9R2j7/IRK/YdMo?=
 =?us-ascii?Q?5SnlBL7ETZfnNNDubNAeKz7GbOr/ReeZ4iqf6Zrrc34Pa1pMuMrJ+tgB+2l8?=
 =?us-ascii?Q?WCyaxxSvxxqoavzEr34xnMuRr0PGRCbDpk1yRB60Fm3I4cPyF4wYAGyqiNXG?=
 =?us-ascii?Q?6BdHrzx+HfHnU2YQaMUbQ2ZXZm8FTYbTMNYGliTm+UnOpXVAIrOg4NdDKjBG?=
 =?us-ascii?Q?NIYfsD1nGeqMklHmBBhElroi3cdxnqdn9TaMyWf0Chj04twNT/aVM7IpU7YU?=
 =?us-ascii?Q?oCS1YYQE3/RK6wbeJLRBoLHi8r2NXO4zKc2QUjoBAHsRchT+6qFBFTYrk2kW?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XYauC5m8d0z6hAB8p5Jb2dWHvWGgCqQJIVpzNZYen8uCCtnzRGsy/XAZL+B7yVMRa24kCf1Rc1XTAvQan9J4iffahlGkBIPR7JeGTSXJ3PaoCz8Sal/BWzoJbCXQztZEUC5Ht+4p1neItRHunv85cNEPW4n4CeCu6pbX+1C2Wag4BhCPDM7TLQqAZ/uAx5L4jWbvBkqU9RzFG9rke1N/tTR0EAWMgDjvJmF1oyIPDK3m4VM+QZ1S12ADTWlyb9CTcP0EFvVxKfbK95mz2yzdxw/Vo7VhIhwStzA4B5zSf2DlL76H0ApdLJbi8PxV2zMJ36/t13Z405kM8XyIGL8Yg9VXnzsdvTLlE+Hr3Q7fk5BVWQ8M5X7wd7rLhUJVutZ7qatf/zonTJ7HirRIWJ2tEAps+owOkNyLdCJfvTXdSD8jjB7+Zrhb7cnpUcPyXDNTmXCKklJs5dH4OhKhdV1VYHD0d897FO7Mrf8PNe3oKHCfvso5eEhVhVMcmavmHsIRY5MBBqs/w7Rq+Q4fkoKVzRyt9o5rhznnJgeRJJs1kwH5r5JrWthQxmgDwHfA+QVF2l457yqbOApseTI7GY3AR75yIrs01XsLf5cjmx+R5GuFAXfcRwdrr6qMC9oKkVCcxGPpsTQKTi1UfqD3cB9jK48FXopOPbkFkXzGu1UQcTVNadX6PJ/WJ/Dd2Z3rV3tMQvJ6qHqQBpr9YmA7jhNfkOmh3tJhu4/YqAjsYKxoGRJa7C6f1Mw/FOY25KpsSuuh/7+H7Wy4LLWimSTxkd0ng2pC1usdAnECYuoi2UuZxDotWtVSL2tHtsMgskxUvmau
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8be594-323c-4627-3690-08db769c4dec
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:09.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbltD+XYFQhqMjqAkEQDonJiddIP3dKtKzNBT2jDWCvaWac1pKyog4PvzARWLxenjU3bR0ysVjunH3eycIc1UThr+RKJOzxzcXVFRcSdQTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=815
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: qo0dHANn1yFaQfH_zEur89HfW7EG1303
X-Proofpoint-GUID: qo0dHANn1yFaQfH_zEur89HfW7EG1303
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

The following patches were built over Linux's tree. The also apply over
the mst vhost branch if you revert the previous vhost worker patchset.

The patches allow us to support multiple vhost workers tasks per device.
The design is a modified version of Stefan's original idea where userspace
has the kernel create a worker and we pass back the pid. In this version
instead of passing the pid between user/kernel space we use a worker_id
which is just an integer managed by the vhost driver and we allow
userspace to create and free workers and then attach them to virtqueues
at setup time.

All review comments from the past reviews should be handled. If I didn't
reply to a review comment, I agreed with the comment and should have
handled it in this posting. Let me know if I missed one.

Results:
--------

fio jobs        1       2       4       8       12      16
----------------------------------------------------------
1 worker        160k   488k     -       -       -       -
worker per vq   160k   310k    620k    1182K    1564K   2002k

Notes:
0. This used a simple fio command:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=$JOBS_ABOVE

and I used a VM with 16 vCPUs and 16 virtqueues.

1. The patches were tested with LIO's emulate_pr=0 which drops the
LIO PR lock use. This was a bottleneck at around 12 vqs/jobs.

2. Because we have a hard limit of 1024 cmds, if the num jobs * iodepth
was greater than 1024, I would decrease iodepth. So 12 jobs used 85 cmds,
and 16 used 64.

3. The perf issue above at 2 jobs is because when we only have 1 worker
we execute more cmds per vhost_work due to all vqs funneling to one worker.
I have 2 patches that fix this. One is just submit from the worker thread
instead of kikcing off to a workqueue like how the vhost block patches do.
I'll post this after the worker support is merged. I'm also working on
patches to add back batching during lio completion and do polling on the
submission side.

We will still want the threading patches, because if we batch at the fio
level plus use the vhost theading patches, we can see a big boost like
below. So hopefully doing it at the kernel will allow apps to just work
without having to be smart like fio.

fio using io_uring and batching with the iodepth_batch* settings:

fio jobs        1       2       4       8       12      16
-------------------------------------------------------------
1 worker        494k    520k    -       -       -       -
worker per vq   496k    878k    1542k   2436k   2304k   2590k

V9:
- Fix vhost_dev_reset_owner handling. Make sure a virtqueue's
worker is cleared so when the vhost_dev is reused the old worker is
not used.
- Remove old/unused attach ioctl copy to user code.

V8:
- Rebase.
- Move comments about assumptions so it's in the body of the code
instead of top of function so it's more clear.
- Added patch for RCU support and swapping workers while works are
running.

V7:
- Add more comments about assumptions.
- Drop refcounting and just use an attachment_cnt variable, so there
is no confusion about when a worker is freed.
- Do a opt-in model, because vsiock has an issue where it can queue works
before it's running and it doesn't even need multiple workers, so there
is no point in chaning the driver or core code.
- Add back get worker ioctl.
- Broke up last patches to make it easier to read.

V6:
- Rebase against vhost_task patchset.
- Used xa instead of idr.

V5:
- Rebase against user_worker patchset.
- Rebase against flush patchset.
- Redo vhost-scsi tmf flush handling so it doesn't access vq->worker.

V4:
- fix vhost-sock VSOCK_VQ_RX use.
- name functions called directly by ioctl cmd's to match the ioctl cmd.
- break up VHOST_SET_VRING_WORKER into a new, free and attach cmd.
- document worker lifetime, and cgroup, namespace, mm, rlimit
inheritance, make it clear we currently only support sharing within the
device.
- add support to attach workers while IO is running.
- instead of passing a pid_t of the kernel thread, pass a int allocated
by the vhost layer with an idr.

V3:
- fully convert vhost code to use vq based APIs instead of leaving it
half per dev and half per vq.
- rebase against kernel worker API.
- Drop delayed worker creation. We always create the default worker at
VHOST_SET_OWNER time. Userspace can create and bind workers after that.

V2:
- change loop that we take a refcount to the worker in
- replaced pid == -1 with define.
- fixed tabbing/spacing coding style issue
- use hash instead of list to lookup workers.
- I dropped the patch that added an ioctl cmd to get a vq's worker's
pid. I saw we might do a generic netlink interface instead.




_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
