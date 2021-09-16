Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0548C433EF
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666BB60FC0
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 666BB60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2923F40717;
	Thu, 16 Sep 2021 21:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALUSZV9mgc8v; Thu, 16 Sep 2021 21:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CDA44071B;
	Thu, 16 Sep 2021 21:21:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBF32C001C;
	Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68EE5C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FEAD4051E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="0sEqTI8a";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="rashDUC1";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="wa/mTvC4"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iZxRn54PDoZd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89ED54158B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GKAN41002313; 
 Thu, 16 Sep 2021 21:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vcmGjG8muQWTS6Tm6cSSUcAgQtfvakSSgO2weyw1GZg=;
 b=0sEqTI8av8s2sXY6rImZVZpjUizxHyNd156zn4PJiOu0rN11FpkXDGs0x+006bc987E8
 Q1B8jGaXtMEYX0Ucs3G/ZPP2u4o9vHUpJLMr+ehbQIHLnyzoatx3JdKpRWmGenjPfvVN
 6YnLzNPgCfp6wqqcFC1hkNsHDg9JFsuFRfodmkrJTG1x6WsXng7umj8tqKNaRZcXmZVX
 mBI9bYwE0Sy4GwMypUE5/U/P0uUvLoNFyBa4Z56ZDA+zyEHL6cddLw0bUpCbXUl2uTWQ
 jC2GJLDAd8JICr9wJEjwLUY13bvrPQNG3kdz5jlwHVZ9TwNgX6oL72vEk8dwbpJfaO9F +A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=vcmGjG8muQWTS6Tm6cSSUcAgQtfvakSSgO2weyw1GZg=;
 b=rashDUC1LAxrprLMNxpCPWjRGbf9knGaHvfcnT+zUwCSA3rujLi7qNf1tcfyHxv5QvaH
 lt1Nr+U08LcJ5KYqNXtl2QfH86LvXBqPo2QQgnoin8mnR8II8sCSms0Btn7Oj9mP/iF5
 Pd0Zr4JPjq8K/lbjLKoiQcJC1eUQ5Ki9oDdmVx3f9IcHI4VneTlUKoT4YnWpYC83pgJK
 X3NfH0bIerxke/Kt2CVgXvhBdK8jOjQ1Ez7RkUeweL+Mvu/JaFnwGS79JiiYJRJabH3Y
 ljvLgfJr3sKj9OoRO4NhaHiWizm8SvN/+J4Lf/aHHURrAiRqI2HEdpGJA5b4NQFAdwnS 4A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3jysnkcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNt011268;
 Thu, 16 Sep 2021 21:21:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ditA0kPcXt3fF/V/b/3iOkWm8jSVk8Ao2trI+85VOEifqCFxs1JbSSCeV1/Ds/9jJfO2xXkm2xHB4ZbzG/vA3GwspKl4VSdmz3UrWpvDaQ4H0cOp23vsYUjPr4rOHgmJh0pEnaNNaQey6yaLz6e8p9QgfLkiX8AoZ+aJWza01ovPp2ullb41btUsjEE3AKqbbdS3dXC3B4wRFUHo7+3AaRGnJA859kd1Z2O2O9Pt/IrCKgIKYVr3S24/w0PIgSbyisNMIEXoMlBDEYBdZainSVgFZONwJqhnoERmKIJM3mB2/XC1ppozGjBsox2CdfiaTQTspM1N42HxLX4aj7Gisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vcmGjG8muQWTS6Tm6cSSUcAgQtfvakSSgO2weyw1GZg=;
 b=WiTAdKtrRPI3gLQm0fpyEhERZtxndCCGcVbtqjIvsZZpjygG4mnodKcbETbnTWVhkoqu7q5We5uUjsQ7OlhPErx83mgeaY3hWZVsnon/+7sxxK5KbVfOq6df+Za1G+W/lF7jvwbkVSmXEu9Wx8bgNwG9scbGjOgzWRxpQsFn37vFVrla+sr6/mjWd2d7Zly596MMcXbWrU39vJuJ+WQFuKH+gEvLvND0wOOpRQ6RQB+CLGXkNIKIKkob70Q2DReg082pgcnRoYAJyj/g7m/p85TgQJIpNw7dFY3UeX3k2DsCbPkWwhbAaQEvwCMyM7snritolrKVd3s3KH8yEhgJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcmGjG8muQWTS6Tm6cSSUcAgQtfvakSSgO2weyw1GZg=;
 b=wa/mTvC4siuVOyFdpAma6FKs/5uXpMUbjRcdmXQIYsXDsZPlHH4j5G/gjRdXb6zC4wdipNgJkFrG1I1aABgqCSl6DSP6LUnICHchrza3S0x768bRFmXHThk/Zg+Os5KUUwTqTuwroesJueuGxMihsOxIUnCxX6MhScvALHO6h5M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:07 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:07 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] io_uring: switch to kernel_copy_process
Date: Thu, 16 Sep 2021 16:20:48 -0500
Message-Id: <20210916212051.6918-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916212051.6918-1-michael.christie@oracle.com>
References: <20210916212051.6918-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:3:12b::13) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d428777-7826-4b80-f54f-08d97957e5b6
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB293570818BF66054AB564359F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTi+un5P/jmDWUi+iX79DN6JAklEQWcUQeC5ghakOF4K/BnY1s6vL1dtJtSdCmKMnPVDsYt+c47ebsN2IojCEDIU4QKozQevWCwzQ7qLP3KfLTmThe8hOMARmsEYPH1g/GX2NmMlKdViUxPxmF0x2r7KFd68iICfANbDD3JARD+SlkYkUIvrUc0//DSOZla0GSXMO/j8ECrVq1kONSOoD2XA/BVwYcdloDwTL+GkSn8ONwTaB4c07BgkD5J20k6UcfL0RNDJdjvGggl0ztw4WQTYC/JlxRPntLuOvxfdKwFCqdX0/WehTr05Na41Hg3Z9KdyHAfa+I5OzQFBYim0YfCvEWzIa+rIfikt+TqR9DBNWkM4MuzlkUB8uJZoJ641423tIDJxXPcX16tCzK369PAFzNWZnxiIH/vuv2y8kyk/mo4vhvtpGG0/kRKvf7q+f7S4EFk8t8UTaOaEmRH2CbBO7RffrM5AMcwwP7AHQCpnJQhVTcqhkoZHZ9uwydOHLF0LL11sk7Nyk7qSGoIHhuWdqHm8V7vrn9C5v6nIUknsqgwKVC+fUZv466gj8ee5EUkWlZf2BekhpZ++43C7D98lI7LONE9m4GpSz6bNXCa6qKppCClLKrCo/Zs70f49JPjfQjRCR4mpyNVjHdp2t4qXQOH8L8prNylhozUu8Kj6O3NDOFlqAQzrzVgwIYmuyJ3euzXLxTpdP7aFPlXxKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qeUG7oVD6ur2Qb/Lux+hBFtqvtjLhnnzVdmg6G33+4sNi0GcXwVX8rrvXAIM?=
 =?us-ascii?Q?H44KR/CA3Ax5XPFBL6qwO9px/9dhg69qeVW6q91bNXlezTyBOjmU/0mctspI?=
 =?us-ascii?Q?8Ucb85cZnoworgTet4JNAq71Zy8HYAEnc1AtgLlL7b7Mwhy9dFGMR4MaatR8?=
 =?us-ascii?Q?vHvJNTlB4AUWX2T2pgWS6sCTTadxyfx6LM1Xxs8QQe5IUrcOryNrJ/rLrdCr?=
 =?us-ascii?Q?IP0+M5A26a4TRihRw8QT7NVDkFI99Mvao51mH/Z2rdtdJYFherldunY8MHf4?=
 =?us-ascii?Q?vfUD9uLUpTSuNaTtQNcsjW8PICoEa0Hf82GaNHOLytC0dDu6qMFWABqqEScg?=
 =?us-ascii?Q?kcXcRZNEMVSq3K03yCdX33zFk1yQ42dw9GlyJEfGXE6WraToHqU8K+FiJcSq?=
 =?us-ascii?Q?CCax+vsr2+b74k2OZC9eAfMbmISN97THX3z5KHBd32RBgmyIImhsGb/rLdEJ?=
 =?us-ascii?Q?CMzwB/9/dESOVU4OJeRtrThJiyVZGWBYCQb2WiCQTPkd9Af88BEgcJ2B+xCV?=
 =?us-ascii?Q?7ske5Vv+0nrvz4PICIxHX7+QSrFZzz0tbvoPZQNzrGfD1lOCusKrNjoEC66g?=
 =?us-ascii?Q?HC5cssB9mZX3nVxywG3LzbH4LjvZOow90SXx8Q+d2HB4sONKK71ysWu8359Z?=
 =?us-ascii?Q?G/8rPa4kdiLWjxqxGXKsq4YAeW0A1kZG3apwaN3jrrNotyX7S6n6I5+3bt5Q?=
 =?us-ascii?Q?4HsGg2qSxRQ4qFuRMyFf9kNvUKShQTlekyDVbGslP7fLMb/ZgHjwuVF3vYn6?=
 =?us-ascii?Q?W3hApZTLwee3qNYK+EFEfoBKiIZfIM0A0Q1oDSDB/XAKYZ79yu3ruKPHHqGx?=
 =?us-ascii?Q?6hIaoQLAjnJ8rnVNzKpF2LqX3kleyW1CgQXfnbMv+jwTqGdmoFScrnlNAr1G?=
 =?us-ascii?Q?mdLd4HSgfpDKrHRHwhbg76EOJplMZEumCXoj63q7KO+VhUrDvi5rVnmXOrNe?=
 =?us-ascii?Q?p//CFvGeNwVnpymI6BtkyHg5vCq7LTFbAbVA1NXMe728wuvS/63iyqD/veLm?=
 =?us-ascii?Q?eEcdD1/YCvc1T8j4iMSMMP+LpiVAt89jS7h8gmYi8wzJrQ1U8vXdXIRWT1DP?=
 =?us-ascii?Q?nfE+nSsKqRZqR/lUkTs8sgl63TA0GXJwX40ycLuJMTy1WFN7A5mDV3chtdcg?=
 =?us-ascii?Q?63cD5ghvTRzIYDLjQ+mhtTEM5nbdRvTLQHksLeFEjgQJ3xjyrgp2TkxBDfNb?=
 =?us-ascii?Q?kH2oK/X5nkrTrBZPemvs/SLE6xVQHbyKkYsBW/jqjmYH1LuszNPPhlDGjsXq?=
 =?us-ascii?Q?bp1/YiNMiUuKqkmw1Z8QBJ0J18K+p9KkHduFs0r6NfUc+2r+zOsFjTSMNOra?=
 =?us-ascii?Q?cGIniXtBqDGhASosaNjNg0Fi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d428777-7826-4b80-f54f-08d97957e5b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:07.4723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsBne4e+d4mvg8eJsmvp7aK/40WOSjbdBNkKqamOf/eQTvN9OWW+2yDHoGQjNYzbiYI4z9+ZtXOmi/5CVmYiF8F2wGP1KJBMw2NkL9lFUx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-GUID: HDpf_VCRcfFsiI2gIdAYz0Am8UHeoFnx
X-Proofpoint-ORIG-GUID: HDpf_VCRcfFsiI2gIdAYz0Am8UHeoFnx
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

Convert io_uring and io-wq to use kernel_copy_process.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 fs/io-wq.c                 |  9 +++++++--
 fs/io_uring.c              |  5 ++++-
 include/linux/sched/task.h |  1 -
 kernel/fork.c              | 22 ----------------------
 4 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 6c55362c1f99..6fccba5bdc65 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -68,6 +68,9 @@ struct io_worker {
 
 #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
 
+#define IO_WQ_CLONE_FLAGS	CLONE_FS|CLONE_FILES|CLONE_SIGHAND| \
+				CLONE_THREAD|CLONE_IO
+
 struct io_wqe_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
@@ -687,7 +690,8 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_copy_process(io_wqe_worker, worker, wqe->node,
+				  IO_WQ_CLONE_FLAGS, 1, 0);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -757,7 +761,8 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_copy_process(io_wqe_worker, worker, wqe->node,
+				  IO_WQ_CLONE_FLAGS, 1, 0);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 16fb7436043c..2493a78ddd7d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8519,6 +8519,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|
+					CLONE_THREAD|CLONE_IO;
 		struct task_struct *tsk;
 		struct io_sq_data *sqd;
 		bool attached;
@@ -8560,7 +8562,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		tsk = kernel_copy_process(io_sq_thread, sqd, NUMA_NO_NODE,
+					  flags, 1, 0);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 4a6100a24894..f43e81c907e1 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -85,7 +85,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
 					unsigned long clone_flags,
 					int io_thread, int no_files);
diff --git a/kernel/fork.c b/kernel/fork.c
index 1dda1d4ea77b..9011cbe83fe8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2518,28 +2518,6 @@ struct mm_struct *copy_init_mm(void)
 	return dup_mm(NULL, &init_mm);
 }
 
-/*
- * This is like kernel_clone(), but shaved down and tailored to just
- * creating io_uring workers. It returns a created task, or an error pointer.
- * The returned task is inactive, and the caller must fire it up through
- * wake_up_new_task(p). All signals are blocked in the created task.
- */
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
-{
-	unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
-				CLONE_IO;
-	struct kernel_clone_args args = {
-		.flags		= ((lower_32_bits(flags) | CLONE_VM |
-				    CLONE_UNTRACED) & ~CSIGNAL),
-		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.stack		= (unsigned long)fn,
-		.stack_size	= (unsigned long)arg,
-		.io_thread	= 1,
-	};
-
-	return copy_process(NULL, 0, node, &args);
-}
-
 /**
  * kernel_copy_process - create a copy of a process to be used by the kernel
  * @fn: thread stack
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
