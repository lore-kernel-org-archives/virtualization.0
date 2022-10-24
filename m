Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269A5C38A2D
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 19:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 774A240354;
	Mon, 24 Oct 2022 19:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 774A240354
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=qSy06LAo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hWL9DJ56
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a1KRDbOHnGl8; Mon, 24 Oct 2022 19:14:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3178D40345;
	Mon, 24 Oct 2022 19:14:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3178D40345
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F401EC0032;
	Mon, 24 Oct 2022 19:14:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9126C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 19:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A80740345
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 19:14:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A80740345
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GjQYxePbeRaw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 19:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90D9F40331
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90D9F40331
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 19:14:34 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OI9dKl021695;
 Mon, 24 Oct 2022 19:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4cy2K+1CabXZ0C7cVn7bTZ7hEiuQ3xAWDkdeM2PQwfI=;
 b=qSy06LAodx26Bvu0sca6x4lKGbjFPNfLvyjuljwuuARzU8lqiHwKkfW6alSTrxUH09Az
 RwiMAuHVC9WKPOsB+B838EDkgs3CYJ0XxoUGZlnqYp0vEfQH+hO02Nh2s+lY/pIQdrl4
 K5krsuEMNQKnX/H4VpoxIDzNI5CBxlBiqsLYWmGeNsdkt7VEcSN4YB55FGD1xlSYiGYJ
 1N556H8qQvVzcIa5C2M7zDQI7/rE5upOD3W6UGnfyUy5t4czD/VF/TCKNn+cjONrQMa0
 Kj2EVb9yN5jjvTowmqZ86sJYuzTH+m83n5ri+24D7Bx1aqrSKnhqejincnb3EMKKkDSn tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc9395064-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Oct 2022 19:14:33 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29OGfhg9039855; Mon, 24 Oct 2022 19:14:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3kc6y9wgr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Oct 2022 19:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1zJX+ItbRCo3Gdi7xzh/MC8MxeplRrFJ84gqemJHsSo9k37UtxX2p0QtW8LY5fIWJ28VMkRooOhacOkEum/kHtZ/uB9zGd9CNVeHC02Kru3Kj5ekz8QqqrcltRHBVxNI4DiCqTPFsyrGX+cJN8hAN8MBA2gpeVXJf0hCZw8Ya2OmVP119WNHikLDoNTAjctF9dzl8QG7izA/DjeNNAxDNe2tGyUdXwKgpZMwwXyi/V858yehHxmZWNlDMHaT5Ilq0Y6Y17EgyCnXUsdMLedtyWYnVvujUNRbiwjyH51EK4BQKENw0F74kj8oowFaI9QjAmDXbA1uPLVgKvmAJkufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cy2K+1CabXZ0C7cVn7bTZ7hEiuQ3xAWDkdeM2PQwfI=;
 b=m4U9zT5rfLs2nOvVuWnBsfGvogJQ4Z2/lm4NAdsgCajiQF9riMCp2u1GBNPiQn6N4KImfNqrzwqXG9M+4jEGOR80R4yGTqd0Pl3YHIt2EQwIoMrvKGazupNzYllQfiX3pXCraAUrzCml028UCM1KIei0IOEBSEcJ/k8Tppvcu+TX1eoqYJuv29HuuTDZTggwnPJE7ui/W+WO3UFhuqqS6NGH+I+g9Xz5eQin9txhe5/7r+B+AdiTS5azyvS9I50agfWZps0YLucppBbXtgAgq1oZD2MRokJqpIbW1AkWYMlxvxvRBZnbfJ63ft/7eYJUK3YvX+sP+H4Jt1TX4Avkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cy2K+1CabXZ0C7cVn7bTZ7hEiuQ3xAWDkdeM2PQwfI=;
 b=hWL9DJ56vZpb7A/SfxtCZT75UuZI1vZpJA/KOdTbLz09GCK6sbq9soTdEJdhYqIBOU6Vc+8I7w1fL1PBNkqQ6+a92qC21yxMqiQg+MiWgJCtegLeRErLbJ2fZZmdDHQbD0EzusAwsPvIEkJnxB5pM84GxU1CZCKq63KkwDj1wmw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4401.namprd10.prod.outlook.com (2603:10b6:303:94::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 19:14:30 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Mon, 24 Oct 2022
 19:14:30 +0000
Message-ID: <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
Date: Mon, 24 Oct 2022 12:14:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a3471a-87a6-4222-9602-08dab5f3f9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ibpXm7aeq8FadaYEH9h60JdhYnFM301R9G8l4hFWQxH/v4JPs0YruGkgst5oQtAd05gU5tdynrK+wZQLY4gEJVyTmH8LwhxYRIouNkML0NhJhE6iD+akYHxIX4L8v5smKKUr6KwgKWHgLFP/bqqOZNFy3J9LYldOT4S4hWoicbIutJJCPJGHvUPcx/oyVw4gNt2iYPZIwWRvZbliqg9K59IenRqbBgn8IZYdL00w5WvJW+RIb7tLksp5hKCilh/iKsK1xXUPGa6p1saTgelpaDVwxTqbiiLZ0jXctpAGuWZRerWiWQclETIj0GhP/Tvtj28WEAsCQMW7Zn5On2i3dC6TElH+EnKr+3Ko6X8wqu/fDMmLPTSZAO4Pvb9NsNe1IZHmUO9M+UIrT57j1h1WUx8Ld7mfMopofSkbl4pFd1KJuZnvJazfoGlVcBouNZ+qWpOfLi84IuAQxSlF3taV0kgZ8yNhpmparCqiWtvFtqRt1PgkfKQbJVJ6sYjHUhKiF86kfnUuGQCwhkVmV37osygiQFLa7Hd3HrWAhUR9Og0MkrDMWVzzorLTjZoeHTKnrP0DKq8mDbI8XkHsqUJKzslkFAGpj5bWtS3DvHkh6jDAgb1Bdx7zI8zC3/1ZD8o4ujGOK623ubD0L05CEAEE7baEkY0foIMhSb6a3CAUL4Th6JmO7bALSrMoTJqs1FjGMAH23X0I8Gu8cJHNK+hRVJJNPsfku+1Cs8QslDZh1Gs8UuHjz+nuySI24SIyF8Xm7Xs6ev+6h/iy8ZL2cQodR+YT3xsUH9OWQJcxwvcHas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(31696002)(83380400001)(86362001)(31686004)(6486002)(478600001)(66556008)(4326008)(8676002)(66476007)(66946007)(6916009)(6666004)(6506007)(53546011)(36756003)(5660300002)(36916002)(8936002)(6512007)(41300700001)(26005)(38100700002)(186003)(2616005)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtvVEJSajFWaWpzYWdITnp6Q3cwaUtZR3hXZVFteWtUUDM3SHM0WXNyWlBR?=
 =?utf-8?B?V3d2Zkt3NllXM2l3cUlMMzhQUERmcXdYOVFaSEN6T29odjhFcEUybmhVbTJv?=
 =?utf-8?B?TjJTblNJV0RZYmorRmljNm9PamdXa2s4VUMwa1o3NkpGQ0hiNzEvTXNuR0NP?=
 =?utf-8?B?V3JiSlhObjN1cWJHakRzU0VmL3B5bEdpZ3RkcTBQQTZYT051VURLZ3plSURn?=
 =?utf-8?B?VzVueHRHVjY5M25LNlRiNTFwalVyWnY3aFpnVndHMnl1NXhIc0Zsck52V2ZC?=
 =?utf-8?B?UmQyM1pCb3dHcGg3MjhzbFlHdGpGMjNyUFZpWklOcEdJeTVtWUpmUnN4UDRw?=
 =?utf-8?B?UEw3S1V5Y1NrbDNIelkydjlidlRGaXlOVUgxek5JMUk3UENPbmZYd2xRUGlj?=
 =?utf-8?B?bEJSSytBWmhFRWdZS1VKVkZqcWczZXY1RFBqNllSdkZYcnJFcmxwRzVtbmJt?=
 =?utf-8?B?Z0FBR094bm5MUDlrZ0ozMXdudThRb3M2bEo0bnhLcEg3UklwYmRBeVFXYlFv?=
 =?utf-8?B?UmhraGl1UW81UThMM292MWltREU0OHlWQ01ScXVmSFl0aExwMjdlVHZQRkJk?=
 =?utf-8?B?MEZ2Z3ZvMS9WZVZ6cTZWTTFoVlZBOFk1QUsxRStzczh0bzhZR09qZ2gyMGQx?=
 =?utf-8?B?L0ozRGhYbUNTSkRBMVBxeW9Pb0YwY243VWYvK1V4YVVDNFVnZzB5eWRWWVhM?=
 =?utf-8?B?dGVINzFuQlVrd2hTd08vdThvNk5xS3BFWUtJVjlmMHZSaFRNejNDaEJWVXJ4?=
 =?utf-8?B?aUR2S25JOUUxc1F0VWtzTHhhTUl2cWdBRUJYeHNNUWdGWlJJWG9IY0tnZWNr?=
 =?utf-8?B?N21UcG4rOHdEQVk5M2gyMWJUVmRsbnBjSGJMQk04TEZPQklIbWhlWnVJYnpO?=
 =?utf-8?B?YzhKYmpLOUNJcllCbTR5Z2FHUFVuTm5aakR4TEJ3dmJLOWI0dHdTeDJrNFBI?=
 =?utf-8?B?UEs2OXRIcU55ODhYSDhTOG5rMlhNc0dTZGdGN3BFK1ZRVndIUmNZbEdYTnJ6?=
 =?utf-8?B?SFpzYnRGRG5TTnNCMm1WYTF2YlpUMVlYaEVJRDByaklaZzkvR2NWdE5kQ0RE?=
 =?utf-8?B?cURHdEdRVlliS3dkdFJVU2hQUFJ2SGxEN2FNT0hLaHNXbkFtdUFPdTRzV0JE?=
 =?utf-8?B?OURYWS9hWHUyZDR5VXhCUG1SNlRBRElrcUtXakE1bzRmTGNpeEh1ZlJXQWJs?=
 =?utf-8?B?NGVMZUR6RlphLzFucXZSbElYWFhUa0JUZGVuMDlJZ3lBbEo0akRnZlZMNVZX?=
 =?utf-8?B?QUFIeTVQSHNDY1RNNThBemtrOUd2M0VyR1M3YUpIc1FOMDJMbmdiNE0xMW1i?=
 =?utf-8?B?OXg0NEtPdzRYZ3NjTy85TnBoQ2ZTa3BFdGd4M2sxbGJGaHdMcDVwRFk4VDZj?=
 =?utf-8?B?LzhtL1dzRGJjZDVkZjA1MWNncTVmMHh1MXpFU3UzQ3VqaDVqVGgzMTVxTDN4?=
 =?utf-8?B?UTFzTTVOODdYQy8wVE5FSnNmUUhTUXhyeHBaTWN3cmJsMWFPdzBmeThtUGF5?=
 =?utf-8?B?NTNrNUM0RU9UTW84d2ljOHZibFBOQVlxK25pQmljUGpXK2t1bjkrb2xnY0ZP?=
 =?utf-8?B?UmZEMERNaDdEVk4xZlBqbzZGcTUreTlsWXhsUTBZblRPcmtRZlYvY1VnNS9o?=
 =?utf-8?B?MHpVNVN1dUpVYW5wSzVMOGpPcTYwYSs1NVY1bngzUmwybVJKYXFuWWhYS3Jx?=
 =?utf-8?B?dHdheTFMYW9yVjYxMEJHZ1pPL2tqM2FiVVlpSmZjTXVKVmxKRVBOeVVVekdD?=
 =?utf-8?B?MVBWQ240NFRDZWlHdFo0ZExpUnJyQ0tLRDAvSjA4by9zLzNKaDhPc1UvSDVp?=
 =?utf-8?B?djZIaUwrWWY0ZThla3BFSEUrS2lCYmRlR2RrTTZ6dit6YmZLeDZIOGpzUWFJ?=
 =?utf-8?B?RFVPQ1lqT3B0cU5IYW9OWXlxSmQ0VG5ZWXRZZFBZQVBOM00zVVF3QkJDWm1B?=
 =?utf-8?B?VlpyTll5MUZpUzRPTXhrNlVLSC9ObVVFUGVpaG9vMWQ4dkQyQXV4T0o0R0NH?=
 =?utf-8?B?K3ExLytkYkpITHpRbGdzMndkZTB1UmwyT1R4QmR1MDdvMlBnR0daSU5IYTFH?=
 =?utf-8?B?MlpCT2NlME5OTXBIbVpJb1NCU1ZFUDRhZlM0MkV5MVIxeWE0WWQ0UFU3eHV2?=
 =?utf-8?Q?XeTPp8fx1jgjefAPNvmO9UdsB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a3471a-87a6-4222-9602-08dab5f3f9ed
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:14:30.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvYl0OubD7X426Xpw9O/tkpsOrE9t9G0Q3FyubZwZV/v2lxUowKrRuM0nYxSUM+RYDppfPImmT76pDFyy5CVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240116
X-Proofpoint-GUID: SVGfvUcSeBkrIeJQB95z99WQdmHSRD_V
X-Proofpoint-ORIG-GUID: SVGfvUcSeBkrIeJQB95z99WQdmHSRD_V
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxMC8yNC8yMDIyIDE6NDAgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gU2F0LCBPY3Qg
MjIsIDIwMjIgYXQgNzo0OSBBTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdy
b3RlOgo+PiBMaXZlIG1pZ3JhdGlvbiBvZiB2ZHBhIHdvdWxkIHR5cGljYWxseSByZXF1aXJlIHJl
LWluc3RhdGUgdmRwYQo+PiBkZXZpY2Ugd2l0aCBhbiBpZGVudGlhbCBzZXQgb2YgY29uZmlncyBv
biB0aGUgZGVzdGluYXRpb24gbm9kZSwKPj4gc2FtZSB3YXkgYXMgaG93IHNvdXJjZSBub2RlIGNy
ZWF0ZWQgdGhlIGRldmljZSBpbiB0aGUgZmlyc3QKPj4gcGxhY2UuIEluIG9yZGVyIHRvIHNhdmUg
b3JjaGVzdHJhdGlvbiBzb2Z0d2FyZSBmcm9tIG1lbW9yaXppbmcKPj4gYW5kIGtlZXBpbmcgdHJh
Y2sgb2YgdmRwYSBjb25maWcsIGl0IHdpbGwgYmUgaGVscGZ1bCBpZiB0aGUgdmRwYQo+PiB0b29s
IHByb3ZpZGVzIHRoZSBhaWRzIGZvciBleHBvcnRpbmcgdGhlIGluaXRpYWwgY29uZmlncyBhcy1p
cywKPj4gdGhlIHdheSBob3cgdmRwYSBkZXZpY2Ugd2FzIGNyZWF0ZWQuIFRoZSAidmRwYSBkZXYg
c2hvdyIgY29tbWFuZAo+PiBzZWVtcyB0byBiZSB0aGUgcmlnaHQgdmVoaWNsZSBmb3IgdGhhdC4g
SXQgaXMgdW5saWtlIHRoZSAidmRwYSBkZXYKPj4gY29uZmlnIHNob3ciIGNvbW1hbmQgb3V0cHV0
IHdoaWNoIHVzdWFsbHkgZ29lcyB3aXRoIHRoZSBsaXZlIHZhbHVlCj4+IGluIHRoZSBkZXZpY2Ug
Y29uZmlnIHNwYWNlLCBhbmQgaXMgbm90IHF1aXRlIHJlbGlhYmxlIHN1YmplY3QgdG8KPj4gdGhl
IGR5bmFtaWNzIG9mIGZlYXR1cmUgbmVnb3RpYXRpb24gb3IgcG9zc2libGUgY2hhbmdlIGJ5IHRo
ZQo+PiBkcml2ZXIgdG8gdGhlIGNvbmZpZyBzcGFjZS4KPj4KPj4gRXhhbXBsZXM6Cj4+Cj4+IDEp
IENyZWF0ZSB2RFBBIGJ5IGRlZmF1bHQgd2l0aG91dCBhbnkgY29uZmlnIGF0dHJpYnV0ZQo+Pgo+
PiAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHBjaS8wMDAwOjQxOjA0LjIgbmFtZSB2ZHBhMAo+PiAk
IHZkcGEgZGV2IHNob3cgdmRwYTAKPj4gdmRwYTA6IHR5cGUgbmV0d29yayBtZ210ZGV2IHBjaS8w
MDAwOjQxOjA0LjIgdmVuZG9yX2lkIDU1NTUgbWF4X3ZxcyA5IG1heF92cV9zaXplIDI1Ngo+PiAk
IHZkcGEgZGV2IC1qcCBzaG93IHZkcGEwCj4+IHsKPj4gICAgICAiZGV2Ijogewo+PiAgICAgICAg
ICAidmRwYTAiOiB7Cj4+ICAgICAgICAgICAgICAidHlwZSI6ICJuZXR3b3JrIiwKPj4gICAgICAg
ICAgICAgICJtZ210ZGV2IjogInBjaS8wMDAwOjQxOjA0LjIiLAo+PiAgICAgICAgICAgICAgInZl
bmRvcl9pZCI6IDU1NTUsCj4+ICAgICAgICAgICAgICAibWF4X3ZxcyI6IDksCj4+ICAgICAgICAg
ICAgICAibWF4X3ZxX3NpemUiOiAyNTYsCj4+ICAgICAgICAgIH0KPj4gICAgICB9Cj4+IH0KPj4K
Pj4gMikgQ3JlYXRlIHZEUEEgd2l0aCBjb25maWcgYXR0cmlidXRlKHMpIHNwZWNpZmllZAo+Pgo+
PiAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHBjaS8wMDAwOjQxOjA0LjIgbmFtZSB2ZHBhMCBcCj4+
ICAgICAgbWFjIGU0OjExOmM2OmQzOjQ1OmYwIG1heF92cV9wYWlycyA0Cj4+ICQgdmRwYSBkZXYg
c2hvdwo+PiB2ZHBhMDogdHlwZSBuZXR3b3JrIG1nbXRkZXYgcGNpLzAwMDA6NDE6MDQuMiB2ZW5k
b3JfaWQgNTU1NSBtYXhfdnFzIDkgbWF4X3ZxX3NpemUgMjU2Cj4+ICAgIGluaXRpYWxfY29uZmln
OiBtYWMgZTQ6MTE6YzY6ZDM6NDU6ZjAgbWF4X3ZxX3BhaXJzIDQKPj4gJCB2ZHBhIGRldiAtanAg
c2hvdwo+PiB7Cj4+ICAgICAgImRldiI6IHsKPj4gICAgICAgICAgInZkcGEwIjogewo+PiAgICAg
ICAgICAgICAgInR5cGUiOiAibmV0d29yayIsCj4+ICAgICAgICAgICAgICAibWdtdGRldiI6ICJw
Y2kvMDAwMDo0MTowNC4yIiwKPj4gICAgICAgICAgICAgICJ2ZW5kb3JfaWQiOiA1NTU1LAo+PiAg
ICAgICAgICAgICAgIm1heF92cXMiOiA5LAo+PiAgICAgICAgICAgICAgIm1heF92cV9zaXplIjog
MjU2LAo+PiAgICAgICAgICAgICAgImluaXRpYWxfY29uZmlnIjogewo+PiAgICAgICAgICAgICAg
ICAgICJtYWMiOiAiZTQ6MTE6YzY6ZDM6NDU6ZjAiLAo+PiAgICAgICAgICAgICAgICAgICJtYXhf
dnFfcGFpcnMiOiA0Cj4+ICAgICAgICAgICAgICB9Cj4+ICAgICAgICAgIH0KPj4gICAgICB9Cj4+
IH0KPj4KPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29t
Pgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgMzkgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMo
KykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEv
dmRwYS5jCj4+IGluZGV4IGJlYmRlZDYuLmJmYjhmNTQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
dmRwYS92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+PiBAQCAtNjc3LDYgKzY3
Nyw0MSBAQCBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rldl9kZWxfc2V0X2RvaXQoc3RydWN0IHNr
X2J1ZmYgKnNrYiwgc3RydWN0IGdlbmxfaW5mbyAqaQo+PiAgIH0KPj4KPj4gICBzdGF0aWMgaW50
Cj4+ICt2ZHBhX2Rldl9pbml0Y2ZnX2ZpbGwoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1
Y3Qgc2tfYnVmZiAqbXNnLCB1MzIgZGV2aWNlX2lkKQo+PiArewo+PiArICAgICAgIHN0cnVjdCB2
ZHBhX2Rldl9zZXRfY29uZmlnICpjZmcgPSAmdmRldi0+aW5pdF9jZmc7Cj4+ICsgICAgICAgaW50
IGVyciA9IC1FTVNHU0laRTsKPj4gKwo+PiArICAgICAgIGlmICghY2ZnLT5tYXNrKQo+PiArICAg
ICAgICAgICAgICAgcmV0dXJuIDA7Cj4+ICsKPj4gKyAgICAgICBzd2l0Y2ggKGRldmljZV9pZCkg
ewo+PiArICAgICAgIGNhc2UgVklSVElPX0lEX05FVDoKPj4gKyAgICAgICAgICAgICAgIGlmICgo
Y2ZnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUikpICE9IDAg
JiYKPj4gKyAgICAgICAgICAgICAgICAgICBubGFfcHV0KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01BQ0FERFIsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoY2ZnLT5u
ZXQubWFjKSwgY2ZnLT5uZXQubWFjKSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IGVycjsKPj4gKyAgICAgICAgICAgICAgIGlmICgoY2ZnLT5tYXNrICYgQklUX1VMTChWRFBBX0FU
VFJfREVWX05FVF9DRkdfTVRVKSkgIT0gMCAmJgo+PiArICAgICAgICAgICAgICAgICAgIG5sYV9w
dXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSwgY2ZnLT5uZXQubXR1KSkKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPj4gKyAgICAgICAgICAgICAgIGlm
ICgoY2ZnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCkpICE9
IDAgJiYKPj4gKyAgICAgICAgICAgICAgICAgICBubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9E
RVZfTkVUX0NGR19NQVhfVlFQLAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNm
Zy0+bmV0Lm1heF92cV9wYWlycykpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBl
cnI7Cj4+ICsgICAgICAgICAgICAgICBicmVhazsKPj4gKyAgICAgICBkZWZhdWx0Ogo+PiArICAg
ICAgICAgICAgICAgYnJlYWs7Cj4+ICsgICAgICAgfQo+PiArCj4+ICsgICAgICAgaWYgKChjZmct
Pm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMpKSAhPSAwICYmCj4+ICsgICAg
ICAgICAgIG5sYV9wdXRfdTY0XzY0Yml0KG1zZywgVkRQQV9BVFRSX0RFVl9GRUFUVVJFUywKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2ZnLT5kZXZpY2VfZmVhdHVyZXMsIFZEUEFf
QVRUUl9QQUQpKQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiBBIHF1ZXN0aW9uOiBJ
ZiBhbnkgb2YgdGhvc2UgYWJvdmUgYXR0cmlidXRlcyB3ZXJlIG5vdCBwcm92aXNpb25lZCwKPiBz
aG91bGQgd2Ugc2hvdyB0aGUgb25lcyB0aGF0IGFyZSBpbmhlcml0ZWQgZnJvbSB0aGUgcGFyZW50
PwpBIHNpbXBsZSBhbnN3ZXIgd291bGQgYmUgeWVzLCBidXQgdGhlIGxvbmcgYW5zd2VyIGlzIHRo
YXQgSSBhbSBub3Qgc3VyZSAKaWYgdGhlcmUncyBhbnkgZm9yIHRoZSBtb21lbnQgLSB0aGVyZSdz
IG5vwqAgZGVmYXVsdCB2YWx1ZSBmb3IgbXR1LCBtYWMsIAphbmQgbWF4X3ZxcCB0aGF0IGNhbiBi
ZSBpbmhlcml0ZWQgZnJvbSB0aGUgcGFyZW50IChtYXhfdnFwIGJ5IGRlZmF1bHQgCmJlaW5nIDEg
aXMgc3BlYyBkZWZpbmVkLCBub3Qgc29tZXRoaW5nIGluaGVyaXRlZCBmcm9tIHRoZSBwYXJlbnQp
LiBBbmQgCnRoZSBkZXZpY2VfZmVhdHVyZXMgaWYgaW5oZXJpdGVkIGlzIGRpc3BsYXllZCBhdCAn
dmRwYSBkZXYgY29uZmlnIHNob3cnIApvdXRwdXQuIENhbiB5b3UgcmVtaW5kIG1lIG9mIGEgZ29v
ZCBleGFtcGxlIGZvciBpbmhlcml0ZWQgdmFsdWUgdGhhdCB3ZSAKbWF5IHdhbnQgdG8gc2hvdyBo
ZXJlPwoKClRoYW5rcywKLVNpd2VpCgoKPgo+IFRoYW5rcwo+Cj4+ICsKPj4gKyAgICAgICByZXR1
cm4gMDsKPj4gK30KPj4gKwo+PiArc3RhdGljIGludAo+PiAgIHZkcGFfZGV2X2ZpbGwoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLCB1MzIgcG9ydGlkLCB1MzIg
c2VxLAo+PiAgICAgICAgICAgICAgICBpbnQgZmxhZ3MsIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sg
KmV4dGFjaykKPj4gICB7Cj4+IEBAIC03MTUsNiArNzUwLDEwIEBAIHN0YXRpYyBpbnQgdmRwYV9u
bF9jbWRfZGV2X2RlbF9zZXRfZG9pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZ2VubF9p
bmZvICppCj4+ICAgICAgICAgIGlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTUlO
X1ZRX1NJWkUsIG1pbl92cV9zaXplKSkKPj4gICAgICAgICAgICAgICAgICBnb3RvIG1zZ19lcnI7
Cj4+Cj4+ICsgICAgICAgZXJyID0gdmRwYV9kZXZfaW5pdGNmZ19maWxsKHZkZXYsIG1zZywgZGV2
aWNlX2lkKTsKPj4gKyAgICAgICBpZiAoZXJyKQo+PiArICAgICAgICAgICAgICAgZ290byBtc2df
ZXJyOwo+PiArCj4+ICAgICAgICAgIGdlbmxtc2dfZW5kKG1zZywgaGRyKTsKPj4gICAgICAgICAg
cmV0dXJuIDA7Cj4+Cj4+IC0tCj4+IDEuOC4zLjEKPj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
