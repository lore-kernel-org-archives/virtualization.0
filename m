Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F564EB64DC
	for <virtualization@archiver.kernel.org>; Sat, 15 Jul 2023 14:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EDAC81FF5;
	Sat, 15 Jul 2023 14:20:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EDAC81FF5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ciXIek8B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=X8eJ9tkJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlm3v_wosF98; Sat, 15 Jul 2023 14:20:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D119481FE9;
	Sat, 15 Jul 2023 14:20:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D119481FE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CA84C0071;
	Sat, 15 Jul 2023 14:20:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 629CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jul 2023 14:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 391F6404D5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jul 2023 14:20:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 391F6404D5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ciXIek8B; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=X8eJ9tkJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZ8drPAcB1XV
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jul 2023 14:20:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 604BC404B0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 604BC404B0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jul 2023 14:20:34 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36FADm44024940; Sat, 15 Jul 2023 14:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=EaRC+kVq4FR5BPXQORfIddOCjt7E+aZjTcyG9s/rUcM=;
 b=ciXIek8BTgGr9zJAxK/1futq+4pNt46jwNtzEeSz1pl0HBIocR+fpCpnTIfzlkXY4VNQ
 B6gZC2OI6AYZNC+aUUWleIpHP/UkNvkPI5PWi0r5tmpViFZ1r8Do5uL+Cyp1lXlzP0VJ
 OBNb3ENx2sop9Nvs8zKimIJ+L7+tmnk5Z44gSDoj5pwdFm2m+tEjXYw/vjHUE0P1MpKW
 NcuBjEJsKGAUyneHoMp0Q/poJASf+0oUiSdeFqPC/9R85J5Sxh9bVdVoX9khBl2zqOjb
 TGoz6mVs/367QcF4FY7yxKW4D53OxSQzs4RVRama77S3PCUgrm0faPWl7A4EDTlvJ64o uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a0etr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jul 2023 14:20:33 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36FB20aW019304; Sat, 15 Jul 2023 14:20:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw21mt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jul 2023 14:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6gJciM5cS4x5Veh9XYeXf8nnbo0pypKrhFyyM0dKVWGOgsdIgOoID/sFKXMCO92cySCaDo9/Jn4ahl6+2ALJtFc0c1j9CN9fI1GOTyXZvCM4aO5H32Id8ixMKZqQcqIdrlCiTvCR8sSc/VmSs5gbG67sEly3w28ckvmK0+unoHdM9huUvmOOn8x5HLgkg8IUpDBrdY3o5rwDIOlH/cWA8cw73YC2NGtuNJ3miQMNhISX448MxOCbN+U+vjEOG5GVa2rs1UxtEGIeorPqzg4GON0e9v1FGv9glorbOgjxCe1lc/i6v9UPcjJud+rdNmxLclWgSZrQrk+eOIvmyj7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaRC+kVq4FR5BPXQORfIddOCjt7E+aZjTcyG9s/rUcM=;
 b=HJIK4ibSE5hod715hcn3/7LplNqLcvhCMXHRe3skiK/EIj9WSRCTKmfoJtmvDB8YQJY+labQ4uaDcZPuCxh5tSlEXxxPxDj+jcApMKoctNYagMiyAn9ioNfHWQ4JOFmlMZxrkMJOuPKvWF6ysJNWCD55NpuXbTrqiXPl3C/YF3caHrDj7wD7IRGWx2cBFtyZGT0PDFbpa4OOzpJYPXipxRHUrrtjkYLXvOizCaetc1Nw+b7gM4eCs/xVdh8kJ+Z4aGHmTt2FsdD1L8Y+HKNed3Mtteq6yoplKDNm1W194S0lyZTrJArkAahgH6D7UGeTqbNu0WTRhAEVWL6JCbNGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaRC+kVq4FR5BPXQORfIddOCjt7E+aZjTcyG9s/rUcM=;
 b=X8eJ9tkJQGq2hDdPFmyK2NE1Q9Pew4udBUuDcdaQeKuj1tKOTP3qQBJc5IVf/HKrFtfj1ZmVTz075lVpq6p+oafUDxy1oc8EYWyLjPtuczPDUUDqW0/n9mXzOaCqwSG38EOgYnOb4gKlFkwE/3hH0qXzgmKRUd9nW11eg4S6OnA=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CYYPR10MB7569.namprd10.prod.outlook.com (2603:10b6:930:bb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 15 Jul
 2023 14:20:30 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 14:20:29 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 1/1] MAINTAINERS: add vhost-scsi entry and myself as a
 co-maintainer
Date: Sat, 15 Jul 2023 09:20:27 -0500
Message-Id: <20230715142027.5572-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: DM6PR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:5:337::30) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CYYPR10MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: eabaad52-cae2-48a2-080d-08db853ea44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mY0/wPxJ7SezEdWWrXGjoXgUCJusqM5MbCWQZQYMoPPN7ojQIhhBwaho+IDB2jtImxZMZad+7IFuJ5GDeyrLMuf8HfQCc283jLZ/gmDy1joCTkCOTXsfyPRRiq4UyO7GIXYgzIFIEXqOW6/aHGcNjAK7FdT49BG+C/+hlB7Q9f2VXaVMGW10LqDNi8dAThyVWMNt2S2+gVyoyXo/CLLo0LyOL3oC0e4pUNdbSgKUYd918Llien/MLx1a/Zul6sAjgfEx7HYiW6pwwLMAuTM0kNz889gcjeYEl/uDBX32WhVH5UurjooZvwIU905RJWsTh9vr6nAX9didKv2oQ1hYDfuNSUEiRgZ404DOg1XsT7ptsTpbQfFZPyLFJ9R9d1zdGFlicTcNKE3NxetoiZDO89Qbli+xf26nW4DxVZi25mPmN1nvoZi9h/GlAOOC4L3nENGnChN9o+XjbJ3fOLlrHIHHzgUaXtkh4xxEG/7Dv8kWskXMycz9qtHkBN2qShAVPytwsjPyPWsrYrY/BiVZFt1Mzf94FoTF+CmOpnDOqPVdw7EIDbpyk50ZeFaxQcS1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(2616005)(26005)(6506007)(1076003)(107886003)(186003)(66476007)(83380400001)(66946007)(4326008)(66556008)(316002)(5660300002)(8936002)(41300700001)(6486002)(6512007)(2906002)(478600001)(38100700002)(36756003)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HZYm4Z86o9Bn3TGohKfytDQa0Oy+Tp6xUNQtK5gpQh051PThrjqjd+tC0em?=
 =?us-ascii?Q?Q3hxLtt9b5cMYNYkUjRzfv3VYL5SFrexjha+R30UjLY9CvC6pSpfVqUUm1Ve?=
 =?us-ascii?Q?cbSPry7My4EJIaQIyP5p7pUQq/2CZiIYrPIAibo1dgRQUFyxyJtQ37SrG8Ie?=
 =?us-ascii?Q?ZgiR6HGVLySphRVknyICs/nTCWN2OZ/4kXbnX36BnwPgL7CrJycJ906N9D4p?=
 =?us-ascii?Q?NMT7gsyFJ8wVfeZUsdUsFHN1G6iGvPsNEVqSS8zM6YE8AeRsojF0lbrEzZ19?=
 =?us-ascii?Q?7JjFBwtHkmz5ivkYI/R/B29efBQJZwJCY79+wf9p8kGJBz+XAoABB9eeLNkC?=
 =?us-ascii?Q?Fo3Wn1f7ypg7cl5agqStTUWSu0bN8Ms6Y2GWJl2TWezPjdpjG7xWLvTv82Xq?=
 =?us-ascii?Q?jYToSydiyUWqqSPPOzz8nYNA1+/k98cx/MGl62g7Itr533GcOHv8OYv8ivgg?=
 =?us-ascii?Q?2owULeg8MbzuT0N/uOd4xgKUQaTcVde4NmmiDEdLohOjEBlcEtTVsxTWVQSx?=
 =?us-ascii?Q?mvEbDNdEbVEiJY5ZOt99IZ+erskxvsDwXPalXZmvnOwardm3U6SsqAgnUZ3u?=
 =?us-ascii?Q?UGNwHc7r3Hxspwc/14Nw1SrG8w8EE8U3+BjqfisL9ockdOaXuk6gF5fJJeda?=
 =?us-ascii?Q?sD6W77K/D2dEogjGauUnyuWRiIWgX9bbXUGgyRge7TNNrCkpU2npC/C+ZA4p?=
 =?us-ascii?Q?Qq2KurFLHbVb0Zqo55pn9u4rSizO/elO/Bpx0QZJv973RCbX6B3M2+VITQ2o?=
 =?us-ascii?Q?QgONfw6UxnJWUuRvu6CnsCUyBSljJycSb8txRoHH9+bxqUTcpufoaESHHkl9?=
 =?us-ascii?Q?66bnB2bm6EqIwq9+pSZR46xGNjHiqWhbVLXBglv2gKJOi09XlcbV8hvia+Bi?=
 =?us-ascii?Q?5AQGxlXRH+8cqzTxBtitcu/x24VPbOcaxmgH+NQ87+M0xR8R7ojKhtNepVYn?=
 =?us-ascii?Q?LuIojuhREr4kXU21UXiyYaWIS9UzuUNRmOS1Cmkei3pLZL0GlbeMfQYa+Pf4?=
 =?us-ascii?Q?svFbeQmuabMaOnKlDUUTdwFPHMAlGY7WHH9G4N7Rrn+UcA/d2o69EcAPDDCs?=
 =?us-ascii?Q?gD8V9p3sAPWbdxt7Rt3GEdKtrHfAO7nw9mZU0xLSVdVzX1fVtWcFbSJxmTTJ?=
 =?us-ascii?Q?a2scL5baD6hO9ol2/TvW1TWPHRR1egY83OAoXE4gHfG8oi3ZXUpMQpC8pxTw?=
 =?us-ascii?Q?rTq4M+XleeJOs8fnkvz5lRCT7IvB0+4fS0bsaD6EhIv0gSVQcHfOnS5kxrX6?=
 =?us-ascii?Q?EzODgP8olEDYnSTfhH05cxAqR/zFoAR+DY8Y4v3rZYVSqd6PHcBoNOZyyE5M?=
 =?us-ascii?Q?erKCR4e9AU5ziSFPV6Tiv/gK6vH1QdXeGy46qpNDcm9NL/j+j4p2/3ypI2FC?=
 =?us-ascii?Q?bkMgvjEifaUGjoEd2Ibk67KzbnzY541eu56IIpWv7BpNAilRxmqfKY36J0yV?=
 =?us-ascii?Q?s6LlbCW/gwSIzOybWfBUZdGEeIvycEnqd0ijuFuu34ATFH3TWoIWoRQtEa5D?=
 =?us-ascii?Q?BA+uOVev0XSKAVhAWmQUfh8Vh/gTVmB+6G5PdmzStb1Cqe2IB1Jd7YMy7okN?=
 =?us-ascii?Q?vselL5o4CJGkcrtmbkbR5kGWyT0sxI7cfavMbzD28WKh62MoLv+y2WCSe3VE?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oHAw3o1VIaEx2tgxhBpE2pNOG85x/1rk1OB/BCzjipCh14xM9vIjwO+5yLAtxGW/nTZfoe41Xvex8hNfOpoj8TaX7D9NHgfeirfLq/1TenW0P0k4adL/28iTtnwA54egFJYU70Yqkwk0ZdetPhfNCldE3cJohixNIOvIzkElFutP/bBLwybUWy9nz2OthVmTE8sR7OwxZIO7k+if4QuVtRbD6IUBXNliWEg6pCgFwid0aqHrLUgpXI9ihCOKmSMSnjrnMudSn83QE+jbBDu9VS9ach39cuxzSeCBE8J1Rg2SnLkYn3RDkVwikerZ3kikrgrq43KG396fD3XnMAnk+rE4K8o9n21Mw32DDiYSsZJk3Rm9QTbbPWPiEwTHKnYmCgC/vOlnZxAD4yg100UGYYleawo74Pk8CClqzxpixc+26qGlBqnY9wVUQHig/9DVTQqqnMFMj7HekVi7EvQqxawDUPA36JHJPhCxu31xyWb/WD3yf4tf2rqQqu4G1oqTw0JG6Y+6PRyielpy7ONWdRb03c9ChIEfgJ5kU446ZeQQJ3U7wMDy9Wm2GJovtAFwU0PfeH+e/o7F8cNklTFdWCam2UamsV+MtcqgXevQVNH7eS7Y0LTCBaIubE04He2qPmDy0qnPzFE5PHKVflbD98gN3+EBTkxMy+4gE0zQiQpGisBM3x7bF46JXHV4hPMc0efJpNyAWzLC9O5VAvkJD+lHhe05KM0bum6O68bHV97eJL7sHWthCYhO0T0yyITv+6cFtCpplyuiY1Y9C6cBhqXqrYHfu7JbxFOQnGrTqUKR2l28ElPw4LSZAyC54bT9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabaad52-cae2-48a2-080d-08db853ea44a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 14:20:29.6736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtCoNVtzgbT/Do8Pp/iZJK7esnGpdUXtrtOpsqO+TrZvEMnagpeeSBnMinIaZur5fPzPNf4HeJL1vgXKjEeD6HQ8G+NYRLKX3sUmHXT0hyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307150135
X-Proofpoint-GUID: -Ra369WY4dJ8O7yrYRHB4ctX7vBzYB2T
X-Proofpoint-ORIG-GUID: -Ra369WY4dJ8O7yrYRHB4ctX7vBzYB2T
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

I've been doing a lot of the development on vhost-scsi the last couple of
years, so per Michael T's suggestion this adds me as co-maintainer.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..2c4a8a860ae0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22458,7 +22458,6 @@ L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/block/virtio_blk.c
 F:	drivers/scsi/virtio_scsi.c
-F:	drivers/vhost/scsi.c
 F:	include/uapi/linux/virtio_blk.h
 F:	include/uapi/linux/virtio_scsi.h
 
@@ -22557,6 +22556,16 @@ F:	include/linux/vhost_iotlb.h
 F:	include/uapi/linux/vhost.h
 F:	kernel/vhost_task.c
 
+VIRTIO HOST (VHOST-SCSI)
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	Jason Wang <jasowang@redhat.com>
+M:	Mike Christie <michael.christie@oracle.com>
+R:	Paolo Bonzini <pbonzini@redhat.com>
+R:	Stefan Hajnoczi <stefanha@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/vhost/scsi.c
+
 VIRTIO I2C DRIVER
 M:	Conghui Chen <conghui.chen@intel.com>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
