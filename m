Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF6C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 13:32:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6307460E9B
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 13:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6307460E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CF0C83AB0;
	Wed, 11 Aug 2021 13:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ik7AfGUzX47D; Wed, 11 Aug 2021 13:32:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C506583AA0;
	Wed, 11 Aug 2021 13:32:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88287C0010;
	Wed, 11 Aug 2021 13:32:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12398C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 13:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E51D383AAF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 13:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UiQePStzgBlP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 13:32:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9819683AAE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 13:32:33 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17BDVuQn011430; Wed, 11 Aug 2021 13:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6nTtSVh9pBkPNQRkIiMo5aVF+Yy76E/hffMAZYISHBs=;
 b=GbdFQX+QjQAO1144k6B1Qw4JPImm+tMHLBoNEm5EuDZmOvFZBbbn3OjDUmi7PPpudSV9
 nNnDQsWUPo6GLF2BABc9FJa14Cp+vzreVxjgnhZmvBbtexHRhKTA+5/tZb+3fqs5fc7x
 wSGl8vHypfyiXeEo06p9wqOJm7CoHnR8QmntuNnjOzy40mqOkfkwtW2prmJ6G7wyrHxs
 pa8ShwDmS0EgQqc78+kqS8sUOYmcK9uWVjURb9TrauChx9JxUO2V0IDYgk9pJnYMrNlJ
 FUpy5SnBbPCNvkjah0f/UzWz0oGUjiYMYOSIPaFafeVEa0eO5PQcxeAT2sCFLg/U76fe hQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=6nTtSVh9pBkPNQRkIiMo5aVF+Yy76E/hffMAZYISHBs=;
 b=qH73vT6xEkQyTSSlrJRXygBWkWAJR3tL7v3MDzrJKcGMaWRQj6DVx5QKo7OVkr2lvma4
 /hEMzOU0IxQ2a1J/JG3kuJq+jAtpPaWHohqFCicU6xAIAjbXqL7FJpTIan79CDxIcugV
 +VIm4k5I/9JfWwvX4OfEltutLALkB5yNMaT0arTo15G1dyphnQXsHG7uYyzx3o1I++o2
 UupSF/GdA2VLuff15DefEpjygycMjk7R5fq2M2ORijfOzWTzN5GwzP/WNV3ApC7dJjFW
 1oOtjpM67Md6PDAZUhaaJI1nRxqphHvYs3o+cBT4a22wQ8hjXBeDeCILV0P4SUhuCn8/ Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3abwqgt4mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Aug 2021 13:32:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BDUOZR119322;
 Wed, 11 Aug 2021 13:32:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
 by aserp3020.oracle.com with ESMTP id 3accra1169-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Aug 2021 13:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGPmfSHHrhmLqZgfnNRdX2rJoYnre4T6oWRgPSd/jYhVesjiu98OPM0zZoYZb/2nDx4XGugOxDBHJGp9TGu5/GRRtAQiCYhHDxvTTYj+9MrpjplwwqBKuuXcSko0elemSaLudwePb63QMe65VTrxoTPL8OXIuIY8V2WVAb7TwG4yDtT9NrNnbOVK4PbUT93kHgmnCCR/PWhq1LLOkjgdsVj3m/OUfAVpgDDlr0Ly1gUb4lpwQi85L5rPin9RUeWFk2/qJi7W8xZB+J4fz6PFAJ9jeL5po5XUhlfBA+0/CJSQXmVtdEMsDFiqopMvuEgfDAtxADRKDy431W1qqxCCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nTtSVh9pBkPNQRkIiMo5aVF+Yy76E/hffMAZYISHBs=;
 b=UrBZGhlAZ6FRii3akXsVerQMVOFUYR11mX3HGWc0VvdHven+F7YfU6t9b0YkLSQ0ROAesBsgtrsNVKAt2wR7ip0/nLMjgzJCGX1QH1QH3DXmTQdlco4/xGAsTdS9SQbZ/SbaDJrSazz6GxGFjmp8ASgCSu74FJNW+zEHsF8WIPjujK8AYxYbkewPaG/wteXseCRnzxjzy+UTTXB0A7/f6+MUPXv7YavFP8PdfxGkskFRzSx4NWCTgU8/yuzoRMalIPYmAIytgOgBKiod3+SVnAGw5VKS1n5SXWGgip/LSKwPySjTPS5SP1gaHAfCAgm5lRgBfv+Jxi9dOEpz+5p0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nTtSVh9pBkPNQRkIiMo5aVF+Yy76E/hffMAZYISHBs=;
 b=EDEGrKpM9L0D3oYMKq3wT8JgJhbuGCPSEz36IiWqAgkYRYI/Rz1ZNzUiBm6MUMAzJsI91rpPS4IHMRslz9w2U+RUFAg0RK6v6KVg+ZD3J2xSfPWBtQnrG3jP2HgzY6F94xx7j5CYfjy+bKEV0MdYrpuPZGVKRlxuptvCokhrBLI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1895.namprd10.prod.outlook.com
 (2603:10b6:903:123::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 13:32:29 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::856c:c91e:aaf8:11d]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::856c:c91e:aaf8:11d%3]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 13:32:28 +0000
Date: Wed, 11 Aug 2021 16:32:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [bug report] vhost_net: basic polling support
Message-ID: <20210811133210.GV22532@kadam>
References: <20210811121344.GA14245@kili>
 <CACGkMEtuoTA20jtHQotF0G4h4EqUuQoiWdSq=URDb3mPPyc+TA@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CACGkMEtuoTA20jtHQotF0G4h4EqUuQoiWdSq=URDb3mPPyc+TA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by
 JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13 via Frontend Transport; Wed, 11 Aug 2021 13:32:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5be88f2-c5f3-4261-ad85-08d95ccc76ca
X-MS-TrafficTypeDiagnostic: CY4PR10MB1895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1895F13E428CE67DEC0439608EF89@CY4PR10MB1895.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEZ2zr9XWkQ7dC5/Bo14/i2mDlea08I4ChV8i00BjUmCr6kltICaCzpSN5IiAWRNaTIIuq2Cbn7GwBEwzvSsx3NEdfuSpa1ZueDRUteyzixLsyCsGRd0A5ndo79YKoDglWxNd705zpEjYbOBHZ/N4QVM5LAxUQsatEoXSO5h4gEla1LsC8+JKR4SF4IdVkZJMQATzTcpt+Jw8uKh5b/DSn/BIoDVdUfU+refWJ078ZlGmdxeaaDkvOvLx31rlQjxErxXMRWzIvhry13awKb/sPmOo245RWH8TPmWtuqcr6yTHGfhtwcy1za+BtqVtv6g8bqhu32LO6B90LNRVU9DPRot+9ws3eHXqHmczuDFOYwSlmorYpZVM+nyJO4RBxlnuROl3zL8sVymydq5pJs4B6dcI2ceU2WvHDbt+2H5+p+ACaqkeVpnrO/Argz8FsTv7ReSeMyweX82Pz+4Aq+8ox9vOBkjERds8dAMhX5Qpq0krOt/807U3lKCVNszG8Rc1SaS0bLCGgiVe62L2NZGrnWnJ9AFaWvcXozHHMJG1cFWazLjSL5JQIrW6hUDfvrrCX22E8+mJMimA8v0U4RypgzFDvOfzyZ+8tyRy84myZw/JzseaRybRlR03ligyrmUUmsune6F0VzqudF0XI+I9AFjcI0FQqnFzWxDzK6CKcZSzpcEV1OHcZUvJSh839Qe/tuq19zkSXDfAuiLUCiv5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1001MB2358.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(346002)(376002)(136003)(39860400002)(9686003)(44832011)(52116002)(9576002)(186003)(55016002)(33656002)(1076003)(26005)(478600001)(53546011)(38100700002)(956004)(316002)(4326008)(6916009)(5660300002)(86362001)(66556008)(6496006)(66476007)(83380400001)(66946007)(8676002)(2906002)(38350700002)(33716001)(6666004)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gOL3tU2rOesm3OLnpBS9/aEzR0yC2uBhhfknx7UYdoW2x2japme6pjT5Tt2c?=
 =?us-ascii?Q?vmuUspkHjX3leoS2YQ/bnlvyl+t1zbGDIwhM09cPQdYaUIlA48hVm16QDyFl?=
 =?us-ascii?Q?yGKLCG18mLLS2p1FBiWAZOmSMOEJqC4iz3howX1J1QtxBPDAUNlISg5oOVV0?=
 =?us-ascii?Q?yD9uLRvMLBKu/sBG4EmqEiIzFn7GhIS2F9jDSxjBc6c62gfrq2/W3XdZFBHx?=
 =?us-ascii?Q?plbE7Kz+0A13+uN+ERNCV59TQ+eFZdGPJHMrv0NWumF3UXZnOcLr5ZdV5pIS?=
 =?us-ascii?Q?pXG3bOclhmgHDX1DR/VIKZlAf8WQ8GeWMBGgIBZnr7VS2JtSmoQoAi66QT3E?=
 =?us-ascii?Q?CPxMBiooYS2lv+/DpQSdLqog9ZrBw0hXyCfmfCVIjsipHDKGVJWnQWIFXscL?=
 =?us-ascii?Q?CGALSCSQ1dp7S+kVRYwSHfyIeYU7/Zo6WqtDA6G6LrjUxFKOa1mTrXOkMQpn?=
 =?us-ascii?Q?AKlUuA2z1C2vBuhV1WBLnr4Une+FauIRa82TGUHLK7YQ8GO8Ed1bgPVQDzFC?=
 =?us-ascii?Q?H3Ldxdu8JhKdrRd64dkQFelNoS2ztZFEq9Wd8UU6O91S4nSRz6IQ7yPaHrzS?=
 =?us-ascii?Q?3aaSHJylbrtcVia1M5LwPI+TkM5gDVcWXJLsjH3UPJ6zcg7sOGV0mHslxSaS?=
 =?us-ascii?Q?Hr4lYzEB/Wlp76sSynkqCzVdutU9ElPN7WoCh0af4FyXc6Tqj9+e8y3LIiGI?=
 =?us-ascii?Q?aF46+ZMtK3OsI4xRhDYurGZTkFcts2bzFBf9QX0Z+fGpSSutEudplTFv65aG?=
 =?us-ascii?Q?/N/lGI33LuzRhgkuroFuupgKPcm2xa5Pgb1byQzw9Wz/PfJt3ea/BNYN+ZoV?=
 =?us-ascii?Q?j/mV4jtfbuGmhiC83KuCpAtDSz6/Wqp/+7e3nrU3iFChGcolvwei9JN9Xq0W?=
 =?us-ascii?Q?4/iV9KVW0l+k/rWCdEhTPdx2BdOf4sj/sJ9t1WVZBqCPWt9L8ujCBWaYQ5cU?=
 =?us-ascii?Q?eHQD2N219c0VG7p3FgKRJlqx4xP4f6Bb08qTYrwjO8CRxEZCKwM0JsaLeRyj?=
 =?us-ascii?Q?J1V8XNg0wxOGcHUy/4OwZE5NuKSnDsWaHkD0zzitdLrSj639Zk+IjJlXWMYb?=
 =?us-ascii?Q?ekJQUJ3KqARYeYcPfWIUJM6faBZaRIa89B5d4xc4a7QOFVzqnqxh1Z5wCheT?=
 =?us-ascii?Q?QrfeENyfbHCHdXggDZ23srufEiKrew8ODdZaC1UtMF4uNi5MFj2NGt11ABlS?=
 =?us-ascii?Q?mi/XvyISHoVZzNXcX6JpJBAmkBhY/Dzqnn0GXlZM0XWYb7NRvdzL3w8b3Sl1?=
 =?us-ascii?Q?3pK8G/1Mico0IqA7MIRqo2fSabetudOw74D4VbyV34m09ZXwoAozIdgzgkvG?=
 =?us-ascii?Q?UHwtUgY6T4SB3QozxV2vdG0h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5be88f2-c5f3-4261-ad85-08d95ccc76ca
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 13:32:28.8802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZDiAxoEuhMDruSMc8hLHUz8xbnAXOQUMs6/Hhcq46TI9qYOFtOB4O3SaxJPjtwttqR33JOxCOTR3puRH2pgoirLWkTaqM+JFXdkSetgqJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1895
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110091
X-Proofpoint-ORIG-GUID: Sb_ojS7ZX6dTAVVxVN0FXj5nqhqOi6lm
X-Proofpoint-GUID: Sb_ojS7ZX6dTAVVxVN0FXj5nqhqOi6lm
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Aug 11, 2021 at 08:51:22PM +0800, Jason Wang wrote:
> Hi Dan:
> 
> On Wed, Aug 11, 2021 at 8:14 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Jason Wang,
> >
> > The patch 030881372460: "vhost_net: basic polling support" from Mar
> > 4, 2016, leads to the following
> > Smatch static checker warning:
> >
> >         drivers/vhost/vhost.c:2565 vhost_new_msg()
> >         warn: sleeping in atomic context
> >
> > vers/vhost/net.c
> >    509  static void vhost_net_busy_poll(struct vhost_net *net,
> >    510                                  struct vhost_virtqueue *rvq,
> >    511                                  struct vhost_virtqueue *tvq,
> >    512                                  bool *busyloop_intr,
> >    513                                  bool poll_rx)
> >    514  {
> >    515          unsigned long busyloop_timeout;
> >    516          unsigned long endtime;
> >    517          struct socket *sock;
> >    518          struct vhost_virtqueue *vq = poll_rx ? tvq : rvq;
> >    519
> >    520          /* Try to hold the vq mutex of the paired virtqueue. We can't
> >    521           * use mutex_lock() here since we could not guarantee a
> >    522           * consistenet lock ordering.
> >    523           */
> >    524          if (!mutex_trylock(&vq->mutex))
> >    525                  return;
> >    526
> >    527          vhost_disable_notify(&net->dev, vq);
> >    528          sock = vhost_vq_get_backend(rvq);
> >    529
> >    530          busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
> >    531                                       tvq->busyloop_timeout;
> >    532
> >    533          preempt_disable();
> >                 ^^^^^^^^^^^^^^^^^
> > This bumps the preemp_count.
> >
> > I guess this is to disable page faults?
> 
> No, it's intended since we will use busy_clock() which uses the per
> cpu variable.
> 
> >
> >    534          endtime = busy_clock() + busyloop_timeout;
> >    535
> >    536          while (vhost_can_busy_poll(endtime)) {
> >    537                  if (vhost_has_work(&net->dev)) {
> >    538                          *busyloop_intr = true;
> >    539                          break;
> >    540                  }
> >    541
> >    542                  if ((sock_has_rx_data(sock) &&
> >    543                       !vhost_vq_avail_empty(&net->dev, rvq)) ||
> >
> > The call tree from here to the GFP_KERNEL is very long...
> >
> > vhost_vq_avail_empty()
> > -> vhost_get_avail_idx()
> >    -> __vhost_get_user()
> >       -> __vhost_get_user_slow()
> >          -> translate_desc()
> >             -> vhost_iotlb_miss vhost_new_msg()  <-- GFP_KERNEL
> 
> This won't happen in reality since:
> 
> We will make sure the IOTLB contains the translation for avail idx.
> See vq_meta_prefetch() that will be called at the begining of
> handle_tx() and handle_rx().
> 
> So it looks like a false positive to me.

Thanks for looking at this.  These warnings are very complicated for
me to review because of the long call trees...  Smatch is pretty good
at tracking state within a function but at the function boundaries a
lot of state is lost.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
