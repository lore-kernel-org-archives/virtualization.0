Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C63EC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 17:04:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BBC6108B
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 17:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3BBC6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71E4A80DF5;
	Mon, 13 Sep 2021 17:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HccgsVHGiR8w; Mon, 13 Sep 2021 17:04:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6955E80DEA;
	Mon, 13 Sep 2021 17:04:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6D8C000F;
	Mon, 13 Sep 2021 17:04:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABCA6C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 17:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E2F46060B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 17:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="nxDY8HIi";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="pUJ9v2Hs";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="fcc9cFNY"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id elmpNuHpIopN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 17:04:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5E1D605F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 17:04:12 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFuwmY029775; 
 Mon, 13 Sep 2021 17:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R6s9ve1maOYOCDStzgiB/hy1g3qQ7b0R+bjaP4ZHsOU=;
 b=nxDY8HIi29/myI4yGiz7778s3Bm1DplLiMd3qh1Gt6V6U+l3zp41fPEj+7poJHk44ToE
 cRaKswVKZ07U1vrHKRQjepM1GdQNGYpPgysXuTfjEL3Xywoa48WrjCf8pawT0gNjtJ2H
 PZ/wccK1cUqHqCDpUt9+BMHuc9Z9I5FeDxMi5/W6qGaRkcmBN/cyhh0uaTJxyDwZnARR
 MPRgYmkeC6M0BXbOO4SdJqZWdZXmkHSmxjCnS+hBTt30pc1hHSh1SnX/7PIwkwhV/XYg
 H3wyDFaHy49uexZSz/y9ccUG6NEHgnGwOvfVMUrcKLzanGxVZO2fCPKKddJ1lkIUQLXI Mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R6s9ve1maOYOCDStzgiB/hy1g3qQ7b0R+bjaP4ZHsOU=;
 b=pUJ9v2HsSg0CpLGCdgRe0hHwJaFn1dR1FfmVaUU8dmiDBDbxrYphOnV/6pomvu7M1/VO
 3kOja9em+8oec84uUbUTEg+IhS76evKhSW4AmCMuOkr1w59UvAQOujapvo7LkCq8/+Wb
 02/TUMdkZKBhk2QyswXc+N7p9IFVU1WYXJUqmH52Cv0PIr8gPFnLSgrbIhWF93fOtz0W
 eFxNOQLaubO+yxYvOAegVrxTNIxTDpSUntd3niSFCHx5GZxzGBw+GTHVst5Owt4Y80mj
 3o5Bc1KkCMdq4XCaxZjxY/eRrrZCm+5GrchmwU3Cszg+RorC0xLA/xvweNd/4bIgTpBl /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b1jkjbg6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Sep 2021 17:04:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18DGtMR9133406;
 Mon, 13 Sep 2021 17:04:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
 by userp3020.oracle.com with ESMTP id 3b167qqmxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Sep 2021 17:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdMSJr4hz8GCrNSteBE1uq7vOTSGUp6kFEyCEIVi7xxQtPvpm3f+gGQhECWbdBgbNad5f6Bl7y5+OP0coRKElEZbUAVYuAIRf0IMW1gfibNujVydVj7FrUVrYbEgNxRZraXhAbVvsOarOp6aiIAsG8YNgQRUEXoooZ9MlCNwkUIyI0sT6o54MnFwk3zD/Mo015J1tmKIm+riyuBDLHak0jduaxPzg/hk7YrA9TnMUaBCG9F3bbmBf3zyOGFi2v280dRGU6lQPcnNGTF7bwnP1kdjg4QB2hITSOoMwcoBkkrGsqJMeAGxsKyXwWNNnOwbNtboEsGW2MIIunpY/TGRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=R6s9ve1maOYOCDStzgiB/hy1g3qQ7b0R+bjaP4ZHsOU=;
 b=B4XmgGwrkphQBXRbpAngnu+fXzV3yJUbYCJOzpcLYDoN8CzEOfR/pUGR/0QY/ZC94Mj5X3XaZBW+aUXcBaSLtejRVB/gn5qLMZM71stKiRTmmPXkFFUYWbWt6zxFRwbHd41YnhsVAljUpOsHHFDa84V0/TVgXjhDehPj8t9VoQHyLRxFXWws94Hfw4cxkpI4hDOaIg35Q58m3IL9Pkf3sEyKRaCCUw6MqA8aKPFMdRD4JyHtIJgKBvcHzN0bHksccIUyfiqRR01vjgH4ppG9Er9LlCMtboWDf8OGkI7rRt2GkvzPxby0OyYsJ/9/t/YpmGJIjj/2urVqQb2LiU9JAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6s9ve1maOYOCDStzgiB/hy1g3qQ7b0R+bjaP4ZHsOU=;
 b=fcc9cFNY6qH+1ZSpkH2Y4p6zfqofRpb7ompaeTZVgJunlJSTeiiweAww2HaM/yPhxBZaJ76GRHTfHWMiSbZg8AzKFXGc7OTQ7OaUtvwrq5Kdy2TXGUtiENU5Rj2uiy/9bXqzdzxypbVNVkImWA5m7mlu6puMVMDRNn/eiX9Iekw=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB4001.namprd10.prod.outlook.com (2603:10b6:a03:1f9::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 17:04:07 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 17:04:07 +0000
Subject: Re: question on vhost, limiting kernel threads and NPROC
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <b6d181c2-ec7b-913b-3eea-142fcce7c104@oracle.com>
 <YOwwGbOhkDEy/KvQ@stefanha-x1.localdomain>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <cb6824cb-e730-e842-dbbb-95de49a72cd7@oracle.com>
Date: Mon, 13 Sep 2021 12:04:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YOwwGbOhkDEy/KvQ@stefanha-x1.localdomain>
Content-Language: en-US
X-ClientProxiedBy: DM5PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:4:4b::24) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from [20.15.0.204] (73.88.28.6) by
 DM5PR15CA0038.namprd15.prod.outlook.com (2603:10b6:4:4b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 17:04:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38fd9558-bd62-4f35-33c5-08d976d87f6c
X-MS-TrafficTypeDiagnostic: BY5PR10MB4001:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4001E2D5647A8FBB509FA814F1D99@BY5PR10MB4001.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXJomQJNo4Xjw3iA3RIkG5axaNDdfLRD+sLwL89xINAknTSBzqc9Sn+OhV0huCPLVHBKSdIuWmIOVS3UAGIsYDef9RxS7h00UNniOXsT3uV55MO9RKe7nt7vYYRNbFTc/iYL+qRBqSa00iKeeXwYokaayZUlZZYlgwZ5LZwAjRGOwzVmFjkS41KmrQ4kcalM7ZGgWSI4oa77BfQwSqD0kNCxXRc6rX98b3jSslhgKqm7Xqr3GMTMk99x5t4K9B1rptO6pF1g644KO49rvmzFXprBbnq2gGd6weDbVRAQzdMomkjAd4DyjVHFWS1v9jWKsZhjooVVtrayAMuzs7pRz0osy7elsaOib4OQKUucEqkcu+y2hPHS2tY7g+OM+kOoE79tfZkm73Om5E13cmVGwJbTUP3SqmMSG2uwU1IpTA74UsjUabdjpQOx2IdfVqpfQfV7iNP7MfwChMGUt1nZOj/XkAkIWPAAhqNqvsw2v7ATS4HlupGGCN0ubQqx24ghkr2iy027EHq1qDLv0IYSw0bJHvBbAifEOV7VDhSkuFXND1+8delGEk87cVQwkmpKDCT1Hx/G8f1Lsun1YIKCoMhOJyMa4ohydQ5E2wc6YGLn9LnNYCdwt4Ij2tI+a1bapGV5SGeCjPrgZNZmL6BagOq2zj0nrsA4yf7pQ2BWYvx34ZWRt2xFzB0Hx4bte53UEaiiG+bPu5HHDEPb7hy0Fvr27cE2HgS0YmoKXhZMPpti14hYQanJ3HjXKe85LSC/y+VqSYQMidRplBNaYGoOlKVpIlQTpQXkeJKTaGVvruQb3fZAsLQrcyrVLmEawZmbNrdEcdAlWSSrZr8nGs2sCj+Z87dhszZsB20oUeS+R/xSCKtR0/OhUZ9YMmv4C75F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(316002)(6916009)(54906003)(16576012)(31686004)(966005)(2906002)(86362001)(36756003)(2616005)(956004)(6706004)(83380400001)(8936002)(31696002)(26005)(6486002)(30864003)(66476007)(38100700002)(186003)(5660300002)(53546011)(66946007)(8676002)(4326008)(66556008)(78286007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?EGDRQbmMlAB60NaOpdG7xg6rjVHiUfu4T8rhKVKnTaaJ99zNno0XhxYQ?=
 =?Windows-1252?Q?ul8jkM/XV5AAHqPliX3PefUYs4kSGwjG6S63gu7pedUz3MNndQKMRUgP?=
 =?Windows-1252?Q?TU3yTgmz8VkPrQ180sHfQUfSR7c+QvWK/3EZor5J72/0wWO0+Sol5k0i?=
 =?Windows-1252?Q?yU5ciWF7Bn9EYrnkgOO3bE9hUN5uv8CP7vywru/ADvmTa+vPdOadim9V?=
 =?Windows-1252?Q?kMJlFGqdz90bLG4HPMsEUugJkq7jKReh+NeoPcBXqfckbYkw+ZlU+gO6?=
 =?Windows-1252?Q?haYqxauE1iMEZGAo+DFy6KBpUZXezjbZ1FRgMlNcaJXBE8Fq7ncED+OO?=
 =?Windows-1252?Q?yr+WE9Ed94M0WuoPdct0OvCrFDTaOX7ePR4Lc1G8HqzeBWRFs0iJC8jd?=
 =?Windows-1252?Q?NCm4f5P01sK1X06W3PhmRARozZ76+40W7z5ctjOfBno+vMumkakhrhqB?=
 =?Windows-1252?Q?+L2mU3P/igslTUlMeiAoqEkj8HcCAwfVxgsEEnxpVj8tcFl3+jBsvFDK?=
 =?Windows-1252?Q?vzC1Wuww0dNWAwvB+vhPR4KW96Fqm9oGFSKJ+dnUj7BrgHbDDRCFV+01?=
 =?Windows-1252?Q?lRwCDzLbi7kcQvrXavJfS91eVPwnZOUxhGAknwRsaxVThU/sYmw6qGq2?=
 =?Windows-1252?Q?UcuMHvgraBX0NkYcPRqPagu9XDFd53ih+zUk6yRLztO5i0ZQWoBboErh?=
 =?Windows-1252?Q?8IrhfXIDv3lKMLGP+ta0TKsK1dDr6yw27ArB93OjpsTw1pzkv8FFvZWo?=
 =?Windows-1252?Q?uDrvD5vyyzto1QF5sPDnxXwDYB/HN1zmxM2Y3bz5XlmNhhZZB3AW1zJ1?=
 =?Windows-1252?Q?0BjRd1bweZTuLnFLqImqSFv/xN4z45++jcSVnrEaYL3nZAQS1ObDhmGP?=
 =?Windows-1252?Q?8qCisCyeA5N1+j5HU7eS8qESkYwO1ptjNYtdHwnWf2NACYUoifDmNhV0?=
 =?Windows-1252?Q?HCVKmpiqbr084btqy5O8dMrkZTA3gK08lQqKtOHiY40+PIDbnHXfa68g?=
 =?Windows-1252?Q?7VwhA6TuoH+tNTcXeKihFHI9r5lUm7dLPDtmiPMcu8lOZmkLEHhR3LDL?=
 =?Windows-1252?Q?UKU3w4dkUkZy+nBkDl8rcg/ZjtzqtfjGQ/CdwHfPA2cZ7CJ1zUYMEqX8?=
 =?Windows-1252?Q?Oh3aHzvNHUHh4UaZsv4xRNa8WK1NlbXAUSQqUyrNpp5MsS/u9mrxM28L?=
 =?Windows-1252?Q?hWAS3Ub1gp+G1EplRS3vvXE9oPSSQHBhH6xcOb8jwWxQTNezVftKFxCZ?=
 =?Windows-1252?Q?hcOfG2qwQ/393imdI0Nm4sbDxP+Mze+yZx+NXe6L5QUcaJ8xN7XfNsO9?=
 =?Windows-1252?Q?zLKah0PNCUCQm36Toedv0yNu4SOJ03Du/mNX6Lh4pz9mqXBBdv9wVANm?=
 =?Windows-1252?Q?FmxFcdy+f7ccXAiyq8YOwK11kv9CDe46D7eVAmLjYOtwcpyP0jv8kUxU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fd9558-bd62-4f35-33c5-08d976d87f6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 17:04:07.5255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1i8FbE2t2sTmAwJnDjilmNKg2Wfu78aMjFtkoxg/vR9SwTdgj2FhfB+coZQVT/I6CVHaEq5ZjoZg/ZDU4rt+igFONyyROpji8/LgEdaDeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4001
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130110
X-Proofpoint-GUID: XmQBAuZAe9yVj-FV782VShyNmxI7WDb3
X-Proofpoint-ORIG-GUID: XmQBAuZAe9yVj-FV782VShyNmxI7WDb3
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@ubuntu.com>
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

I just realized I forgot to cc the virt list so adding now.

Christian see the very bottom for a different fork patch.

On 7/12/21 7:05 AM, Stefan Hajnoczi wrote:
> On Fri, Jul 09, 2021 at 11:25:37AM -0500, Mike Christie wrote:
>> Hi,
>>
>> The goal of this email is to try and figure how we want to track/limit the
>> number of kernel threads created by vhost devices.
>>
>> Background:
>> -----------
>> For vhost-scsi, we've hit a issue where the single vhost worker thread can't
>> handle all IO the being sent from multiple queues. IOPs is stuck at around
>> 500K. To fix this, we did this patchset:
>>
>> https://lore.kernel.org/linux-scsi/20210525180600.6349-1-michael.christie@oracle.com/
>>
>> which allows userspace to create N threads and map them to a dev's virtqueues.
>> With this we can get around 1.4M IOPs.
>>
>> Problem:
>> --------
>> While those patches were being reviewed, a concern about tracking all these
>> new possible threads was raised here:
>>
>> https://lore.kernel.org/linux-scsi/YL45CfpHyzSEcAJv@stefanha-x1.localdomain/
>>
>> To save you some time, the question is what does other kernel code using the
>> kthread API do to track the number of kernel threads created on behalf of
>> a userspace thread. The answer is they don't do anything so we will have to
>> add that code.
>>
>> I started to do that here:
>>
>> https://lkml.org/lkml/2021/6/23/1233
>>
>> where those patches would charge/check the vhost device owner's RLIMIT_NPROC
>> value. But, the question of if we really want to do this has come up which is
>> why I'm bugging lists like libvirt now.
>>
>> Question/Solution:
>> ------------------
>> I'm bugging everyone so we can figure out:
>>
>> If we need to specifically track the number of kernel threads being made
>> for the vhost kernel use case by the RLIMIT_NPROC limit?
>>
>> Or, is it ok to limit the number of devices with the RLIMIT_NOFILE limit.
>> Then each device has a limit on the number of threads it can create.
> 
> Do we want to add an interface where an unprivileged userspace process
> can create large numbers of kthreads? The number is indirectly bounded
> by RLIMIT_NOFILE * num_virtqueues, but there is no practical way to
> use that rlimit since num_virtqueues various across vhost devices and
> RLIMIT_NOFILE might need to have a specific value to control file
> descriptors.
> 
> io_uring worker threads are limited by RLIMIT_NPROC. I think it makes
> sense in vhost too where the device instance is owned by a specific
> userspace process and can be accounted against that process' rlimit.
> 
> I don't have a specific use case other than that I think vhost should be
> safe and well-behaved.
> 

Sorry for the late reply. I finally got to go on PTO and used like 2
years worth in one super long vacation :)

I still don't have a RLIMIT_NPROC use case and it wasn't not clear to
me if that has to be handled before merging. However, I might have got
lucky and found a bug where the fix will handle your request too.

It looks like cgroup v2 is supposed to work, but for vhost threads
it doesn't because the kernel functions we use just support v1. If
we change the vhost layer to create threads like how io_uring does
then we get the RLIMIT_NPROC checks and also cgroup v2 support.

Christian, If you didn't like this patch

https://lkml.org/lkml/2021/6/23/1233

then I'm not sure how much you will like what is needed to support the
above. Here is a patch which includes what we would need from the fork
related code. On one hand, it's nicer because it fits into the PF FLAG
code like you requested. But, I have to add a no_files arg. See below:


----------------------------------------------


From 351d476e8db0a78b9bdf22d77dd1abe66c0eac40 Mon Sep 17 00:00:00 2001
From: Mike Christie <michael.christie@oracle.com>
Date: Mon, 13 Sep 2021 11:20:20 -0500
Subject: [PATCH] fork: allow cloning of userspace procs from kernel

Userspace apps/processes like Qemu call into the vhost layer to create
worker threads which execute IO on behalf of VMs. If users set RIMIT
or cgroup limits or setup v2 cgroups or namespaces, the worker thread
is not accounted for or even setup correctly. The reason is that vhost
uses the kthread api which inherits those attributes/values from the
kthreadd thread. This patch allows kernel modules to work like the
io_uring code which can call kernel_clone from the userspace thread's
context and directly inherit its attributes like cgroups from and will
check limits like RLIMIT_NPROC against that userspace thread.

Note: this patch combines 2 changes that should be separate patches. I'm
including both in one patch to just make it easier to get an idea of what
needs to be done. If we are ok with this then I'll break it up into a
proper patchset.

This patch does the following:

1. Separates the PF_IO_WORKER flag behavior that controls signals and exit
cleanup into a new flag PF_USER_WORKER, so the vhost layer can use it
without the PF_IO_WORKER scheduling/IO behavior.

2. It adds a new no_files kernel_clone_args field. This is needed by vhost
because tools like qemu/libvirt do not always do a close() on the vhost
device. For some devices they just rely on the process exit reaping/cleanup
code to do a close() on all open FDs. However, if the vhost worker threads
have the device open (CLONE_FILES not set) or have a refcount on the
files_struct (CLONE_FILES set) then we can leak or possibly crash.

leak - qemu just exits and expects the put done by the process exit
code will be the last put on the fd. But becuase the worker thread has a
ref to the fd or to the process's files_struct then it will never get the
last put and so the vhost device's release function will never be called.

crash - if we add signal handling to the worker threads then it can
happen where the worker thread might get the signal and exit before
qemu has called the vhost cleanup releated ioctls and we can end up
crashing referencing what should be a valid device still.
---
 arch/x86/kernel/process.c  |  4 ++--
 include/linux/sched.h      |  1 +
 include/linux/sched/task.h |  5 ++++-
 init/main.c                |  4 ++--
 kernel/fork.c              | 24 +++++++++++++++++++-----
 kernel/kthread.c           |  3 ++-
 kernel/signal.c            |  4 ++--
 kernel/umh.c               |  5 +++--
 8 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..1c5d516fb508 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -178,9 +178,9 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(p->flags & PF_USER_WORKER)) {
 		/*
-		 * An IO thread is a user space thread, but it doesn't
+		 * A user worker thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
 		 *
 		 * In order to indicate that to tools like gdb,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d88641..0c9b3f62d85f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1577,6 +1577,7 @@ extern struct pid *cad_pid;
 #define PF_VCPU			0x00000001	/* I'm a virtual CPU */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
+#define PF_USER_WORKER		0x00000008	/* Userspace kernel thread  */
 #define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
 #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
 #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef02be869cf2..2a8f9b8c3868 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -32,6 +32,8 @@ struct kernel_clone_args {
 	size_t set_tid_size;
 	int cgroup;
 	int io_thread;
+	int no_files;
+	int user_worker;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
@@ -86,7 +88,8 @@ extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
-extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
+extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags,
+			   int no_files, int user_worker);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
 
diff --git a/init/main.c b/init/main.c
index f5b8246e8aa1..18f3b126df93 100644
--- a/init/main.c
+++ b/init/main.c
@@ -676,7 +676,7 @@ noinline void __ref rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	pid = kernel_thread(kernel_init, NULL, CLONE_FS);
+	pid = kernel_thread(kernel_init, NULL, CLONE_FS, 0, 0);
 	/*
 	 * Pin init on the boot CPU. Task migration is not properly working
 	 * until sched_init_smp() has been run. It will set the allowed
@@ -689,7 +689,7 @@ noinline void __ref rest_init(void)
 	rcu_read_unlock();
 
 	numa_default_policy();
-	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
+	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES, 0, 0);
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2cc5995..9528940d83d7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1458,7 +1458,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1470,6 +1471,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -1954,11 +1960,14 @@ static __latent_entropy struct task_struct *copy_process(
 		goto fork_out;
 	if (args->io_thread) {
 		/*
-		 * Mark us an IO worker, and block any signal that isn't
-		 * fatal or STOP
+		 * Mark us an IO worker.
 		 */
 		p->flags |= PF_IO_WORKER;
+	}
+
+	if (args->user_worker) {
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		p->flags |= PF_USER_WORKER;
 	}
 
 	/*
@@ -2104,7 +2113,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
@@ -2452,6 +2461,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
 		.io_thread	= 1,
+		.user_worker	= 1,
 	};
 
 	return copy_process(NULL, 0, node, &args);
@@ -2548,7 +2558,8 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 /*
  * Create a kernel thread.
  */
-pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags,
+		    int no_files, int user_worker)
 {
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
@@ -2556,10 +2567,13 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
+		.no_files	= no_files,
+		.user_worker	= user_worker,
 	};
 
 	return kernel_clone(&args);
 }
+EXPORT_SYMBOL_GPL(kernel_thread);
 
 #ifdef __ARCH_WANT_SYS_FORK
 SYSCALL_DEFINE0(fork)
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a8567168..724c7ec63307 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -339,7 +339,8 @@ static void create_kthread(struct kthread_create_info *create)
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD,
+			    0, 0);
 	if (pid < 0) {
 		/* If user was SIGKILLed, I release the structure. */
 		struct completion *done = xchg(&create->done, NULL);
diff --git a/kernel/signal.c b/kernel/signal.c
index a3229add4455..3f901067b266 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2795,11 +2795,11 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 		/*
-		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
 		 * we cannot call do_exit() on their behalf.
 		 */
-		if (current->flags & PF_IO_WORKER)
+		if (current->flags & PF_USER_WORKER)
 			goto out;
 
 		/*
diff --git a/kernel/umh.c b/kernel/umh.c
index 36c123360ab8..a6b7b733bd99 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -132,7 +132,8 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 
 	/* If SIGCLD is ignored do_wait won't populate the status. */
 	kernel_sigaction(SIGCHLD, SIG_DFL);
-	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
+	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD,
+			    0, 0);
 	if (pid < 0)
 		sub_info->retval = pid;
 	else
@@ -172,7 +173,7 @@ static void call_usermodehelper_exec_work(struct work_struct *work)
 		 * that always ignores SIGCHLD to ensure auto-reaping.
 		 */
 		pid = kernel_thread(call_usermodehelper_exec_async, sub_info,
-				    CLONE_PARENT | SIGCHLD);
+				    CLONE_PARENT | SIGCHLD, 0, 0);
 		if (pid < 0) {
 			sub_info->retval = pid;
 			umh_complete(sub_info);
-- 
2.25.1







_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
