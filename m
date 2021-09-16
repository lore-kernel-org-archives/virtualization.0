Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA4C433FE
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F7A6113A
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70F7A6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4671E4071A;
	Thu, 16 Sep 2021 21:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ewBXFi0S-jpg; Thu, 16 Sep 2021 21:21:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7894C40713;
	Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 512C6C0026;
	Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E1CCC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DB4D614EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="lLHnqz85";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="wB6fwUT0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="pthlpSgm"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GgyoZyd5O9ZW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B160E6080F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GJxiiZ019726; 
 Thu, 16 Sep 2021 21:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dEKbVwcYKEj6PtXOfVUbjWSi2YavsG6EPXSMPVWDcE0=;
 b=lLHnqz85dFBn22dtv8CXQO9ZJLgx0bTaydJKu/V7udgZPCudzAqZeEA6bEYtK3vToq4Y
 /HvQrSrB5419iwSY/ic4JYG4QUyNli3a7ukNIWqCTYitxLwe8dc5CRz1/bq2Bdj8KnJ9
 rTCGQLEixq1EcOiBqRCP5IUkJTPONOcP9f+uthg6zvTkyqs1WZ4l6I7vlzlJgIabXIIc
 6f5G/otFP/AhKM/BTvjhUHVRLS0h6lH3MY4bRRrcFkVGG2JkTGgKpGZfwhws048a6sIz
 ZOzsAUv5CAB/carJkH5VLIlZ963Xfbuyn1aRVG5NvGC/l9ncGTkgCAAD7CmE+Izr5GWi nA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=dEKbVwcYKEj6PtXOfVUbjWSi2YavsG6EPXSMPVWDcE0=;
 b=wB6fwUT0yzKBNFqd4ds8YE1jgOnYWiMpZ5iFJO33zkftS++gi1Ytfknvl4jGfACOqR0z
 k4smN06WJyQN+ZXT9A4Ga3DkITDpxCMrQKukAUe/lkcs7fNzOc1qkhsykf60faVyoL2u
 mpq/cVh0UsWV5FVigXW++IP6Ju3OnEMW4vmerZizV+9duyoPsEwiBQS0nYk/DOhhoey3
 37HM7GOiIhVv8NeQj+JDsSQovpQSyvF9kaKJJQqEeFQaLBSgQzFfbpwmLHaoJMthOug0
 ZY2a5VphjtubDnWqB0xVf/HWbRL1mbOVHDTjEoJ0ZzgZu1GLKdykbq9VIM+KulGU8LfK uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3t92m6qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5Y3v011322;
 Thu, 16 Sep 2021 21:21:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvwg-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naX/87BKvpD5bVa9vy+dw1H4uhCW58PHGHiBsZuStWqh6wiv40U07XZPsJhQsHhrghmFtBaIGMYu8fazR9cvNOwfIKCafpLRgyYnnc0jB8JNanUwJvY5CFQUVXBEKMUcWgRkOsXihLxRRrHR5nlLSZS7DPFsX3+M0NwGUZNzgdurSLUMZVGlOw5BLIbxopCMIrB2FT2ghtUftMRG40fvamMmzAIKBskvXfU8m6frwKxiGpn1HXVq2D5f+zbCZrQo4Hb0jRqWYudLUW2byoZlF8yjncnH3707eQ00RHMY0WiSVg16adHHF4Tb8I256VmWu2qRqfFXLnqSAUl7/d0HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dEKbVwcYKEj6PtXOfVUbjWSi2YavsG6EPXSMPVWDcE0=;
 b=IqpYsD6sLKVHffEfYGxa9kMZW5gO2RWRz02/mkDeSAHdfLIYH6rdHtDph51z1MzeqPrRfVePKelBhgQNpQZGStPgyemSafK+++xwFbv8Z6z/DFnMqQOpnpiYH0BSlNYE1l197K7347VrmpdqWKjnhL8FzqQaEpqjS+FR/H4lMrR1nq7qX6XyIiYjJZkBprVfT2piS7yEd4yOJUHUiNkyrljtBrSYZ1wKwZx4yRDNo5/0IJyw/OOPuZa0M/M4aXrjVaNX0Ug3/cOf32s/vEMBB9pUfpGcvwu1kogBZBz9SHS1UQUe4e6DgBCUuLIA4mJPU4N6ZCQ/MSBHt6MPrkg5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEKbVwcYKEj6PtXOfVUbjWSi2YavsG6EPXSMPVWDcE0=;
 b=pthlpSgmscv/OGJ8CyxFwJ3YR8rN/Maw/1NmIckgWXzJCwzJcleShs1ES6pzBjDjzDwu+VW0wEohdalG0NpwJqcFT94BmkNq37JU5HA2S/BH7ItHd/Sd1FPaXoL4hDMnYIXMY4HtbXr4HOq19C0wKBtmHVaWXhQtoUW4jomRyww=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:11 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:11 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] vhost: remove cgroup code
Date: Thu, 16 Sep 2021 16:20:51 -0500
Message-Id: <20210916212051.6918-9-michael.christie@oracle.com>
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
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da181553-3758-4baf-f98d-08d97957e7b7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2935CBB7687715ECA16F2EB2F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ol63cmSBpT/HTF+qaTFMV9yMkyMdiqUQKePvdhLu75o2wTiHQO/wfu1wjso/sTtBgPFOGb9fpkbd5JOeRxMQeYEN3LUswPHKj9VZzcnu3Uu0kjdeb1CrOnMPmo/QJ6o3VHtpw4meD4I8ozT+sIi94DB7Kn2HbkAZBAZGYQm6KXtT5gGpI2A3wiSHIDLYmVn524jK0akKzUyTjx1y9J3DUr6AYYSG+F7DwoDMHWCnvTxlul4z3XS5XMlRXTh27PXy7CAoy0IcDsrdB42sla1NbcccIF1YGq2hX2Zu/G3UHicdIqENbR1H9jJie8j0IW8vOm3rgs9Qnvbyya5TGVKITHA8nWFxGUuSnNS9fNmFXm5LU2bye+FZ4tEfuHLs3Xr/C1nRr+SX16Qj0QyiR9hO7QawpuZ5lte7USq/CgKEsm/oQVcU8vUYkfK9fsiOnMbPMlJdpq165RtX7Ndx1lFwW/tAOOULY/1DXZXkgh1K9Y4aLsyKvfPwv3XiZmKtqTmCaokxMsuL2r8IF0i4XOHEY3OFCklKUL7djyq8ao+OmUR1BIYLVE+5old59wRUIO/t69OoaWM9UBshc4DY6rdqE5mbNySQVdIWSOWqixT1aGBs9cSkGpjxT1QM1Xbg5yQuTWnv83nba/3BNvEHp+3KNhmoZf9bZYkc2+37a1bOQ9OrmqOewF1S4rsBTNfD43Ku2/EozA8vQ369htsEQ639hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZRRXeZsg+FDLdGZw1DdHBgne/mfiHpv9vzGnNqUk78IH0ouFEIMIYkeWNpd?=
 =?us-ascii?Q?mKlBrmTxLEsCXpVgUYGr2uYQab9dU4jkZDO0cdsWbyQ0F6K91wvZKiRuvQlL?=
 =?us-ascii?Q?zQwPrPajsXmwnZtUl7BK7ET5u3RONhNtaRKwsUt7X2YrjLSkpeDtTqj9Qx9d?=
 =?us-ascii?Q?PU+oaTgAMbVvSDK9W34WLj2OMfPyom74buj306tuBb+jllsG83D8YcQTLP0k?=
 =?us-ascii?Q?YWQFdmr20MICzd2q1WPerzVjzY8qTSBNCwNIdDs0PnMbV089NZ1u6dQntFIa?=
 =?us-ascii?Q?/HSeoa1DbpOWPFnxHzhUnk6VI35sF39Mwc1JZBeUik3V8jXzk+Yryl90bBUc?=
 =?us-ascii?Q?JACVpd5YIZrbVkAVAw9Z3A5ns/9BSwoYAyZhGkSsCgx7fEam0fTvKiUshPsB?=
 =?us-ascii?Q?9JBufV1o9fxLi8cdd8PgP1xpM1Jd/fByXysOmgd8ryLUb0KkwOw2D9u0dvA6?=
 =?us-ascii?Q?12xq3sCZg5CtRjqOekKQEBYo14uy7ZDBVuqxu9IPqPZApk/duOePywf1rhMN?=
 =?us-ascii?Q?X0sFmAxnmHmNZskTv1RZTM4dKs0cGckRNgIAkRgojm+B2my6R0sUhUo7ZuXj?=
 =?us-ascii?Q?DuWmqmMPaAhgv/CxytQxTvrE31Qxo55vse9e3hgoa/3EbxTfTl7yt3sMKsLI?=
 =?us-ascii?Q?itgMDhWTikpuQecUFF5W9Q/dSduqi9TSsXvmcZ4hsEbVm2MXRQ9zA/sxfjJj?=
 =?us-ascii?Q?641LcTkDY3CC/pCXMhbMCKaOKFQXaXrEVpG3Snj24b1+BGe87jdxB7QynMvF?=
 =?us-ascii?Q?3acTjvflmlNdOb/KAT8ePpWcdnhvtVyWUSOmUvSUgjq/18PqcQq99ZOPxlko?=
 =?us-ascii?Q?TsUN3t2EvuFlcSMpS9bDWKCB3jWqgpoigrfJf9Gw8EsCRjlQ+KEk7KiuDXjk?=
 =?us-ascii?Q?uYhqQkqGh/dVWuzde6RKKYPOh17FLtp9cl80ewJBgMZS0MVUtgZIdL2LHtXE?=
 =?us-ascii?Q?Bn4zaNeeUB4M2mJBzUd8sQg8iNTn5z2whrvc5wGWz/FXnK5SMqJL+abWISUa?=
 =?us-ascii?Q?OxFV5GyzPAroOFa+om0sDwTDbZMcDacgTYKVKk/pM7Oh2cI5lGkdf2ci6tLf?=
 =?us-ascii?Q?By1aZPelRQ4tjMX54CvseKXPxUternnyDMvb2NbG8LmaC5EiYyas/uty1ntJ?=
 =?us-ascii?Q?qPf/qbCjMLjMtuZlxxbUG5+Ul5GpJ04NQzpiGVmXJX8JvZwl3P9VBXSBMLns?=
 =?us-ascii?Q?/i9X37FM9Giq7zRK6kLy1oR0fIrUqc5Go4Nnx2etpEljXCPXtVvc8RB5fdEZ?=
 =?us-ascii?Q?KYBUfB4s2iUnyMk5KYm0jkbD+4nUUG+VlOfPU7XLInCNOuU4movQBruPOvHj?=
 =?us-ascii?Q?KL1jS9tN5sVenDXwiK0UTmrj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da181553-3758-4baf-f98d-08d97957e7b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:11.3791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsnxQxi3YUJQQk2d1KqZrfopn3SJ8oSKxVhv6BusuXNO8iOMPmz4Psq3bmT4f2EFJeJwdCo3FvoZFEZRz7PbeVKxnF7QsHtGNyzjChAzTiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-ORIG-GUID: 0OkHgCRhnlJ7p1RVM3OFV_jyOb93E7ms
X-Proofpoint-GUID: 0OkHgCRhnlJ7p1RVM3OFV_jyOb93E7ms
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

We inherit v1 and v2 cgroups from copy_process now, so we can drop the v1
only code.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6e58417b13fc..b561c5ea00fc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
-#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -515,31 +514,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
-struct vhost_attach_cgroups_struct {
-	struct vhost_work work;
-	struct task_struct *owner;
-	int ret;
-};
-
-static void vhost_attach_cgroups_work(struct vhost_work *work)
-{
-	struct vhost_attach_cgroups_struct *s;
-
-	s = container_of(work, struct vhost_attach_cgroups_struct, work);
-	s->ret = cgroup_attach_task_all(s->owner, current);
-}
-
-static int vhost_attach_cgroups(struct vhost_dev *dev)
-{
-	struct vhost_attach_cgroups_struct attach;
-
-	attach.owner = current;
-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
-	vhost_work_queue(dev, &attach.work);
-	vhost_work_dev_flush(dev);
-	return attach.ret;
-}
-
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
