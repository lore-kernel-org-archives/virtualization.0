Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4079AC7EE2E
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB5D24094C;
	Tue, 13 Jun 2023 01:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB5D24094C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=LTbGy6AT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=zWuKkE2Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kka4XNwAPn-a; Tue, 13 Jun 2023 01:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 640EF40990;
	Tue, 13 Jun 2023 01:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 640EF40990
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40CFAC007A;
	Tue, 13 Jun 2023 01:33:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 646F7C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BA9780EC5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BA9780EC5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=LTbGy6AT; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=zWuKkE2Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J5D0Tzf3cKDV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9FD180D96
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9FD180D96
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:33 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNtXu031424; Tue, 13 Jun 2023 01:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CqYv+HW/Z5blkoUTp1T53GmbfrWtqueDFx4zgyErd4w=;
 b=LTbGy6ATchTjFOnJCTZcwv05SZWnQTgJcWMyg2fPhENHaCbVSkrsMFmsa3vhRjIzvuP1
 AwkZ/3qbXt9hTiNqHwhyWfqVvRvUdoxgADIut8FDPomqTNw28MVtKIZjwNpDhCCMMQqh
 H+uyN9p467sTLuCQTFGwlHnjvIHB1FQuHd752txtpKh1wUOqiegIHi9PhgkEXvJZi5SQ
 d0RoI2Ly9S4Zg25MsdESdO4OZR5jwL8/HxSHyWEuuuAg+J+u6zWo/WJEtvfoSSIdIzwW
 6Cl0NFu4NH2yzpRCNw60nbA1lbt/kSwZEH/5juH+wqAtHn7Jns2eBebHUrLLuBymUijE aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstv3hj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:32 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D0Ugg4008984; Tue, 13 Jun 2023 01:33:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3sqfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DroQGs6J3Rp43gOZC4rbRTwStPOS0eOd26rL30p7GbTBmmVJkQjLTpJ9laOKkl5/36E18QvgbIJ5kpl0lgPmGslqP3XcIjLi493AF6lXN9AERz/EK+5GRiNp53to/nu4XVtHv9bKgpddxwXr0HEaIe1b4V13ikCsp9NQI3pvat/aBb9OxENuCo8YgNYFFwiU6/bgCdvgdVFspNU8vqkFV/yQASDXwQCNed4keOgDYKtWBqXlTD5ivLn+SZOtYJRGfYJahVZTKPfMiNVlZlducneY1vDf4/R7+l2sGYP+tT85SN8bqvFv9uv4AfMklWlGdBrVGhrONs8os4fLOQeJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqYv+HW/Z5blkoUTp1T53GmbfrWtqueDFx4zgyErd4w=;
 b=BXeACW078ixNWQ8Avug8o7HkmI2XKc+uRZnIXiRjHDCR+mlmvFRqdINC30pjsviJLZ8EEAA8NkP3GobJjaFV25rZoweMPtmGn/Uk6qmHS9w2BO3aHU/yTXfWm1VZrVsAzuCGX8RJe8uX3GL312ViTk3w5R5FRhXMM7wOSxKHVxoQsmAzyakbvN3iIJv59hguOtOoxWqCJoLwYas19r9y62JEvQhjd2epq3Fr3JhVTuC1jwRu2KSd6xL8bcYs00HKjX9h5Rswr9mTb8q6QWM4dAsYoCdjXQ5Rd/MpZ3qu9XzyYNT52YiIzz4Ky4GIS4xibguCOeXwt0h5YFxuL5z9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqYv+HW/Z5blkoUTp1T53GmbfrWtqueDFx4zgyErd4w=;
 b=zWuKkE2ZcPSXKyR/6yQZMFdtWRfeOYnbvUYbgYnZONDX4cyn9RqEw2x7c7BxCCa69mJpej83qp5glw2Zn0Lyw6c4vaZxvC9m1ajKtZ/yoi1EAorVnK+p8XMvJqY3YUI3rycepdTAgB/qEk2cBlTUMA/JtJIbSe8HxrsWrTK749c=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Tue, 13 Jun 2023 01:33:20 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:20 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 17/17] vhost: Allow worker switching while work is queueing
Date: Mon, 12 Jun 2023 20:32:48 -0500
Message-Id: <20230613013248.12196-18-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:8:57::11) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c01f115-e683-4101-dada-08db6bae2b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vueOBVHfXYbPv6Va1P4fCUAiBIQSLrh2jFG3N/Q391VxvRrlpQmrAc9AryV+HgsE7NgpNFMEl8DQfcXM616OhupDt0De4ymGSlXxCigTlWE83/bOVMFVllIxGxDFFc6q6kSIGYqUOeV8meqSneFARdU6DXoiMux5a15vnT3ZsPm2V7nvgrEdvjQ66NlRPL0d1GR8Bj3KXCPd00zhR+PrlAB5CfSxuGu2LHWf74kqSqFVnDBo/OoTQSmir76w2WVu4FjN32dYv+7uop4daah+yZzZnPJyd/HTmVwahCFimmuhUDAlKxoukNvrJe7jK46xSnbP/+G/0VQ2TlrukhAmotaFiMta2xDuRANYbpnqlW0e3819jwUj6VJNX6InNtLiV0oUfk6DsOFiKLXyVBSTiu27DaH+vu18dcF7oJUJmXUvt3xC776MPYzzwL36oFgtiIgooHX2jukbNdLkX6J81/ymOxwn9GXTweZ6tHMvo6d1rJF6N7updeW8v4AI526ZNcHALc99tMU9mRWTJXNS+ZVB2TPx8btD4khllTgQcEnJYz8L1Nlrs//m9ghMmIdo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(8676002)(107886003)(8936002)(478600001)(5660300002)(41300700001)(6666004)(316002)(6486002)(186003)(66476007)(66946007)(6512007)(66556008)(6506007)(26005)(4326008)(1076003)(2616005)(2906002)(30864003)(83380400001)(38100700002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mo1E01YnoJvZj91E0rZrLhkuN73RU8B3sbmEylirhPnUs/6sZyRFR/zo0uZm?=
 =?us-ascii?Q?ljvVIzoTHQMAWFV/cXbqqzJXgbQMR7HTBrovtu9daOr17x60ERDjmAggp89t?=
 =?us-ascii?Q?0OB/M7Fl4mpWq7y4cvU6f0GBEbAH9QbN4TY5PnUucPCbyUMHh9rKUkKVx4nz?=
 =?us-ascii?Q?3XERSvSYAcHoUbYLm/xMn6+H9XVe+5bVJWvKiLdYa8iy5TMLnx07RWlrh52j?=
 =?us-ascii?Q?j7PDZBYQ/bVdVeaf+vCNdvC9pP7+p+7KkCJxPj8VbOptIjVoWPJoKBmfm/Fx?=
 =?us-ascii?Q?1O1dKXAXQkLP4ochaKkm+EWUD9JUXKRojyzjP0ZwH1vA6p32vWViCw8hY+rk?=
 =?us-ascii?Q?23OgH5Juwle92OjnacLF4CADLzeXdrXdjEgnCh7DwmcliVrNyahx2hfMgGSw?=
 =?us-ascii?Q?0frPzu6h8tGdzWbLNLLCZFfVvAyhdPJFBx/Rx25Vr/sEi1uVsGgHQoCR4Pl5?=
 =?us-ascii?Q?GreVJWicJemuUYG1kMaSVNNU4v+e6iOGPpL3fneHjzrfgwjsevBRzTRCgxoH?=
 =?us-ascii?Q?Z42ZBOelhv/WESI9RotDtPCMK+aSY0hLEauUnOIMtMJNjWYZ4j4kT8iV57Wn?=
 =?us-ascii?Q?6ZUfoeY2MT0oJA5ArC1iw9q+NEvDWtgGPZxHI/k9YF9dzi5YXNrkcGjTDMcX?=
 =?us-ascii?Q?RdyE1UaCMnsT8RxQpO6puWflrHSYBqVRl0ja4lW4w7OQO32FwBjoX1kxxYMq?=
 =?us-ascii?Q?GhFCxfHj9pZDm7S7Y8B1bO9TjR1n5eyhNjqwvyeNzMWpNqVuWzOb0pwMeybB?=
 =?us-ascii?Q?BnVw4wjKIw+Tr5R3AuM740JQiYCiPC6T+QE+EgvBX775wBO3hjXO3H3o7QHM?=
 =?us-ascii?Q?/SeAvJWG//EUC5oYHnVO7v33MBOZMEjT5+Zd2JqChSUFhG2q+OLQoAzsaYnA?=
 =?us-ascii?Q?XV2wqahT09cPZerftFCNMeI6itokR1CWaB7SWB+x/kkjXMbwxIW+W6/K34Ha?=
 =?us-ascii?Q?QsDPzfr5R5eunDF1M7zQGKxPNdR1+uxlW7rM5FLRXBrf54fSRAClNbPFHV4N?=
 =?us-ascii?Q?G6HZbmCidlnJH/yNbgH3p9WFP3nBL8/0zS9ken1sC7C08sNlcitqdyh/rCQ8?=
 =?us-ascii?Q?ObhM+t9uBKsjKXfTqb9B9hDtn4AFx2rLc57jYsEkhSt3Oyi4UrD59+6gI3Ov?=
 =?us-ascii?Q?/xoyVZSfrsUrZDHF6++YL8C6GVm4pChWerFZm7kIjsFIwFI6FXzE6QUAgwfQ?=
 =?us-ascii?Q?AuklVTzNS4yYO44AhAsccRvSfH13YNXuHmCPQbiXcvjS6U7+ILCQ21gVKMTB?=
 =?us-ascii?Q?qN+MiWC8LU3yiD+EkZW/AJFn6TMgGifu0A9PVsaOXPIbaAJkreZOFTjqsW3W?=
 =?us-ascii?Q?J8ZUafU+Y9truHeTT6L7GxCy8L2vheEQkAgiLhpVnR2HdOG4N2g3CWAbeARA?=
 =?us-ascii?Q?nkXi0BmRfuta/atMUSe9C0OXQSpeAlqDIamu63lzic8Cj8QNQbdiicyzGuuX?=
 =?us-ascii?Q?LzH0gQTVYkEiQyK24KoZKOIW8KVPI4/9jZCtzf0BG2Zixj65Xi92la6eB9JB?=
 =?us-ascii?Q?+Wp4VwxHjTdd4N7l1oKskDCMkHxgRDaz4MAFWS1zoUb4LLgGsuSj6CpmxyyQ?=
 =?us-ascii?Q?xLzTp6n/Daz1wBymSJeXpdvPDvtASYfuiDkdfqou6b+IUyFIXDJgpzHideF2?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cQ5OIDmgYIWQOFOQ1tzp5B7bZSlAFAglHahn/FqQzygFzYQUhDHjPHXxRdXPg+QB7gce4ThT5o7DQ1cwZ+NfVO9dpL3z5x4NAnLasg3Dmnu6poQjCNylyfiqf/9mvvQPFa7PMc04ZdGHPGpnBcy6EE3Sft9iFlz7v7uMp0gb3/Jio4Vcymo+io2iO2MSe0CqJnoGDYFkb4JkTO+pGkZ+vt/P2mfHdcstV3ph467++M/LwkL/dBqQDiDPoMuDABqQ+zmRy1Xgu1WZGLecFzvuyxAAltxUWks0Adnf4zMD8fe44U6HBOqMAcml/G/MErXSfGfVKeP/qoHFNtWlOCF2tnsgN+opbW3xqBgssnl2Gv/ote4Num/boRzR56v3mV2dGekCuHYZa3N4JWs585EB0Xj2VVUSiC0U7KWp9VenCG9Fp232gz2epRrnL05ZcSaESruG75hCM0mbUD7yPTxna1LU1wDlL1V+iQkE7PB9F2MfKqXtC8dUKoOyOIz5G6atbZTRp2p5J9MG/n5rRKAvSav+qiFCPJPVF6h5sAqdMB5O3imSwsMBL1P0wIM7CAEDBGybKpJtZck7ZO7RPvSEJHIOqfiI0hLU/G1Fq7ySxbaVOXgtx6k2toeWf9U9LnsME0aZpfDQRTC24hERfp8+j6FtDhF7FQyRsGuDL0sNgncoivlKfRrO52sGpY/D46lnNYQHfzzGwfS1bRlprj2WQfLHOpz725Ymh2LK5MiMuWNylrG21tJe6KlXBCkyE4HNLWbc4joQgRCcCPOLoorqig6ZgdsjMvd/EqVkR4Xqe/sGYqtYuw5s4M0ah3JHhlpi
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c01f115-e683-4101-dada-08db6bae2b66
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:20.0972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSs5KPCRXvcvlsak4TqNokZQYJCxtoSvyAJmBC1iLKY6VVmbdFzOZEBnG+zH4GrLHCyk+SlKLl0N/8lY/l3wDH1POIUPQY4YPdQfIZiAhUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: m0CboPM8ZahV8o43ahUnf-MxkjnlZm2W
X-Proofpoint-ORIG-GUID: m0CboPM8ZahV8o43ahUnf-MxkjnlZm2W
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

This patch drops the requirement that we can only switch workers if work
has not been queued by using RCU for the vq based queueing paths and a
mutex for the device wide flush.

We can also use this to support SIGKILL properly in the future where we
should exit almost immediately after getting that signal. With this
patch, when get_signal returns true, we can set the vq->worker to NULL
and do a synchronize_rcu to prevent new work from being queued to the
vhost_task that has been killed.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c      | 151 +++++++++++++++++++++++++++----------
 drivers/vhost/vhost.h      |   4 +-
 include/uapi/linux/vhost.h |   4 +-
 3 files changed, 114 insertions(+), 45 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a4f97b56f1b4..ab79b064aade 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -233,16 +233,9 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-static bool vhost_worker_queue(struct vhost_worker *worker,
+static void vhost_worker_queue(struct vhost_worker *worker,
 			       struct vhost_work *work)
 {
-	if (!worker)
-		return false;
-	/*
-	 * vsock can queue while we do a VHOST_SET_OWNER, so we have a smp_wmb
-	 * when setting up the worker. We don't have a smp_rmb here because
-	 * test_and_set_bit gives us a mb already.
-	 */
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
@@ -251,47 +244,85 @@ static bool vhost_worker_queue(struct vhost_worker *worker,
 		llist_add(&work->node, &worker->work_list);
 		vhost_task_wake(worker->vtsk);
 	}
-
-	return true;
 }
 
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 {
-	return vhost_worker_queue(vq->worker, work);
+	struct vhost_worker *worker;
+	bool queued = false;
+
+	rcu_read_lock();
+	worker = rcu_dereference(vq->worker);
+	if (worker) {
+		queued = true;
+		vhost_worker_queue(worker, work);
+	}
+	rcu_read_unlock();
+
+	return queued;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
-static void vhost_worker_flush(struct vhost_worker *worker)
+void vhost_vq_flush(struct vhost_virtqueue *vq)
 {
 	struct vhost_flush_struct flush;
 
 	init_completion(&flush.wait_event);
 	vhost_work_init(&flush.work, vhost_flush_work);
 
-	if (vhost_worker_queue(worker, &flush.work))
+	if (vhost_vq_work_queue(vq, &flush.work))
 		wait_for_completion(&flush.wait_event);
 }
+EXPORT_SYMBOL_GPL(vhost_vq_flush);
 
-void vhost_vq_flush(struct vhost_virtqueue *vq)
+/**
+ * vhost_worker_flush - flush a worker
+ * @worker: worker to flush
+ *
+ * This does not use RCU to protect the worker, so the device or worker
+ * mutex must be held.
+ */
+static void vhost_worker_flush(struct vhost_worker *worker)
 {
-	vhost_worker_flush(vq->worker);
+	struct vhost_flush_struct flush;
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+
+	vhost_worker_queue(worker, &flush.work);
+	wait_for_completion(&flush.wait_event);
 }
-EXPORT_SYMBOL_GPL(vhost_vq_flush);
 
 void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	unsigned long i;
 
-	xa_for_each(&dev->worker_xa, i, worker)
+	xa_for_each(&dev->worker_xa, i, worker) {
+		mutex_lock(&worker->mutex);
+		if (!worker->attachment_cnt) {
+			mutex_unlock(&worker->mutex);
+			continue;
+		}
 		vhost_worker_flush(worker);
+		mutex_unlock(&worker->mutex);
+	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
-	return !llist_empty(&vq->worker->work_list);
+	struct vhost_worker *worker;
+	bool has_work = false;
+
+	rcu_read_lock();
+	worker = rcu_dereference(vq->worker);
+	if (worker && !llist_empty(&worker->work_list))
+		has_work = true;
+	rcu_read_unlock();
+
+	return has_work;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_has_work);
 
@@ -501,7 +532,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->log = NULL;
 		vq->indirect = NULL;
 		vq->heads = NULL;
-		vq->worker = NULL;
+		rcu_assign_pointer(vq->worker, NULL);
 		vq->dev = dev;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
@@ -603,6 +634,7 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	if (!vtsk)
 		goto free_worker;
 
+	mutex_init(&worker->mutex);
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
 	worker->vtsk = vtsk;
@@ -627,13 +659,54 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 				     struct vhost_worker *worker)
 {
-	if (vq->worker)
-		vq->worker->attachment_cnt--;
+	struct vhost_worker *old_worker;
+
+	old_worker = rcu_dereference_check(vq->worker,
+					   lockdep_is_held(&vq->dev->mutex));
+
+	mutex_lock(&worker->mutex);
 	worker->attachment_cnt++;
-	vq->worker = worker;
+	mutex_unlock(&worker->mutex);
+	rcu_assign_pointer(vq->worker, worker);
+
+	if (!old_worker)
+		return;
+	/*
+	 * Take the worker mutex to make sure we see the work queued from
+	 * device wide flushes which doesn't use RCU for execution.
+	 */
+	mutex_lock(&old_worker->mutex);
+	old_worker->attachment_cnt--;
+	/*
+	 * We don't want to call synchronize_rcu for every vq during setup
+	 * because it will slow down VM startup. If we haven't done
+	 * VHOST_SET_VRING_KICK and not done the driver specific
+	 * SET_ENDPOINT/RUNNUNG then we can skip the sync since there will
+	 * not be any works queued for scsi and net.
+	 */
+	mutex_lock(&vq->mutex);
+	if (!vhost_vq_get_backend(vq) && !vq->kick) {
+		mutex_unlock(&vq->mutex);
+		mutex_unlock(&old_worker->mutex);
+		/*
+		 * vsock can queue anytime after VHOST_VSOCK_SET_GUEST_CID.
+		 * Warn if it adds support for multiple workers but forgets to
+		 * handle the early queueing case.
+		 */
+		WARN_ON(!old_worker->attachment_cnt &&
+			!llist_empty(&old_worker->work_list));
+		return;
+	}
+	mutex_unlock(&vq->mutex);
+
+	/* Make sure new vq queue/flush/poll calls see the new worker */
+	synchronize_rcu();
+	/* Make sure whatever was queued gets run */
+	vhost_worker_flush(old_worker);
+	mutex_unlock(&old_worker->mutex);
 }
 
- /* Caller must have device and virtqueue mutex */
+ /* Caller must have device mutex */
 static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 				  struct vhost_vring_worker *info)
 {
@@ -644,15 +717,6 @@ static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	if (!dev->use_worker)
 		return -EINVAL;
 
-	/*
-	 * We only allow userspace to set a virtqueue's worker if it's not
-	 * active and polling is not enabled. We also assume drivers
-	 * supporting this will not be internally queueing works directly or
-	 * via calls like vhost_dev_flush at this time.
-	 */
-	if (vhost_vq_get_backend(vq) || vq->kick)
-		return -EBUSY;
-
 	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
 	if (!worker || worker->id != info->worker_id)
 		return -ENODEV;
@@ -686,8 +750,12 @@ static int vhost_free_worker(struct vhost_dev *dev,
 	if (!worker || worker->id != info->worker_id)
 		return -ENODEV;
 
-	if (worker->attachment_cnt)
+	mutex_lock(&worker->mutex);
+	if (worker->attachment_cnt) {
+		mutex_unlock(&worker->mutex);
 		return -EBUSY;
+	}
+	mutex_unlock(&worker->mutex);
 
 	vhost_worker_destroy(dev, worker);
 	return 0;
@@ -720,6 +788,7 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 {
 	struct vhost_vring_worker ring_worker;
 	struct vhost_worker_state state;
+	struct vhost_worker *worker;
 	struct vhost_virtqueue *vq;
 	long ret;
 	u32 idx;
@@ -753,7 +822,6 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	if (ret)
 		return ret;
 
-	mutex_lock(&vq->mutex);
 	switch (ioctl) {
 	case VHOST_ATTACH_VRING_WORKER:
 		if (copy_from_user(&ring_worker, argp, sizeof(ring_worker))) {
@@ -767,8 +835,15 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 			ret = -EFAULT;
 		break;
 	case VHOST_GET_VRING_WORKER:
+		worker = rcu_dereference_check(vq->worker,
+					       lockdep_is_held(&dev->mutex));
+		if (!worker) {
+			ret = -EINVAL;
+			break;
+		}
+
 		ring_worker.index = idx;
-		ring_worker.worker_id = vq->worker->id;
+		ring_worker.worker_id = worker->id;
 
 		if (copy_to_user(argp, &ring_worker, sizeof(ring_worker)))
 			ret = -EFAULT;
@@ -778,7 +853,6 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 		break;
 	}
 
-	mutex_unlock(&vq->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vhost_worker_ioctl);
@@ -813,11 +887,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 			err = -ENOMEM;
 			goto err_worker;
 		}
-		/*
-		 * vsock can already try to queue so make sure the worker
-		 * is setup before vhost_vq_work_queue sees vq->worker is set.
-		 */
-		smp_wmb();
 
 		for (i = 0; i < dev->nvqs; i++)
 			__vhost_vq_attach_worker(dev->vqs[i], worker);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 4920ca63b8de..f1e7d4d13219 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -28,6 +28,8 @@ struct vhost_work {
 
 struct vhost_worker {
 	struct vhost_task	*vtsk;
+	/* Used to serialize device wide flushing with worker swapping. */
+	struct mutex		mutex;
 	struct llist_head	work_list;
 	u64			kcov_handle;
 	u32			id;
@@ -76,7 +78,7 @@ struct vhost_vring_call {
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
-	struct vhost_worker *worker;
+	struct vhost_worker __rcu *worker;
 
 	/* The actual ring of buffers. */
 	struct mutex mutex;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 155710585979..dc03a5a14c47 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -90,9 +90,7 @@
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
 /* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
- * virtqueues. This must be done before VHOST_SET_VRING_KICK and the driver
- * specific ioctl to activate the virtqueue (VHOST_SCSI_SET_ENDPOINT,
- * VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING) has been run.
+ * virtqueues.
  *
  * This will replace the virtqueue's existing worker. If the replaced worker
  * is no longer attached to any virtqueues, it can be freed with
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
