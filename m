Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56852C433F5
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 23:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE6AA60749;
	Mon, 29 Nov 2021 23:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NPbutouSA1k; Mon, 29 Nov 2021 23:00:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 871B86061A;
	Mon, 29 Nov 2021 23:00:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E94EC001C;
	Mon, 29 Nov 2021 23:00:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60506C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 23:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4757640465
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 23:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="rDw9S7qD";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="LsPzqq4T"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nxYQCO9WVOfm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 23:00:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E073440323
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 23:00:02 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATMK4Pv026611; 
 Mon, 29 Nov 2021 23:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m53GZPvX/lEGh9dfgrapW90hg591Sy4E2OSZr41XCz0=;
 b=rDw9S7qDylKux6Yno1KxhO7HIRbQEUMnBqTQu4N21/mvbIyHHRQz7qDMCOy1KQ9TtPrG
 Xd3yNCrSPktSihefn8ymybUIKuWju4iOi++nE/Dk8kYnHVzM2TubcP0mHWI2DMwyUjXe
 IjiXAM+MkRQChGbCNGmYgi8v0OW0bB2lgP+Se8f5aTEOg+H+hV8dUwZ1aocTosRE12TU
 O8DS90qMWAXowuA6zRlfvkn7nYQ6OPu69F/7a02a8eKKYhtMfj3Qb2oHJQMvfyTh5Brd
 0ogHxTg7Sin8CszfLREbzQDlYZOwR6KPV6ADIar7xx1P/tFCzU4++NHF/5zI7uCB2GKU FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c4v9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Nov 2021 23:00:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATMpi9G004897;
 Mon, 29 Nov 2021 22:59:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by userp3030.oracle.com with ESMTP id 3ck9sx9wxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Nov 2021 22:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRPqrcMDWOkUSsR0dJguMV2ZMhwH1vvNrOf9g8/MXNDSryaBZvF+LS+C5O8BD37gu/MhiE++Zlvrn/BH+70o8fMPnu4+A42XgE7oFz5wLdeLs00/CDII5K7oJKIBpej1jX+Qk7cCKqZ6fM0rTcO0TDXP0qQzoAtbu8TXjRpeumgCy0W7f2jnl74aPjQfHs+K1OaEnLAN88S9g4HQg44FEsD4uUQK/3dZIROnTcOhFy28bPcvtZdgDMLmPZq4IQuuK1QHJb6wOXp2xlfOFptbwaUJg92mIme2ua/BSuG9bhgVzOP4iH45bDa+PfC4dG+QLe7vDVC9Ho6089ng6+uMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m53GZPvX/lEGh9dfgrapW90hg591Sy4E2OSZr41XCz0=;
 b=Wm/XmUPHH1zfgv6zBN2RWV6TDf/tPXLB2QtC4uOpI2kmkEQ68KTbgvxxqoNuZz0Lq6HNgqUiReI1kQjlKYE83nMtdfU20nKh50X/oh/DZZbVNASATBHFcuew6OyQvRxP42xHZD1uzbu6LDwdnaz9YRmt8C5S+oErK0Y8CXQP7E/hcmCsnisqItHoSI3ZMeOqjryMhxe+TbSNFMPizmyrOtFhKJYRYXC9iQvyrbeBi8SQ7qr7dy05RD2iNyNjL6xUQTmrqjbhivIHBgv4Xw8WrmYx4mi7yHHGkfcUaHZvUn0MzVuSuOW8aHsBzj38LNhwARhwS3tyTpCMUt+IFiO2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m53GZPvX/lEGh9dfgrapW90hg591Sy4E2OSZr41XCz0=;
 b=LsPzqq4TA3+r7rf0iHLY0vGsQ7ieG66i2Y5YMH8Orp2q+bb1lQJnR4Gkh7lZbEkMrJtD2QDbMdeCXhBcRTdPOr6KPquJA/muX4M1jIhxluXr/Z05eU726X+BefgPGhTGfZnIzjJ45HI3ZhrxcUdQt+A4h7jKs/BWIyWIMmmSrTU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2583.namprd10.prod.outlook.com (2603:10b6:a02:b2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 22:59:22 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 22:59:22 +0000
Message-ID: <6327c070-2c13-13a8-521f-138e3ab17a6e@oracle.com>
Date: Mon, 29 Nov 2021 14:59:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] net/mlx5_vdpa: Increase the limit on the number of
 virtuques
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20211124171953.57858-1-elic@nvidia.com>
 <20211125022011-mutt-send-email-mst@kernel.org>
 <20211125072953.GA213638@mtl-vdi-166.wap.labs.mlnx>
 <20211125111936-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211125111936-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.65.134.137] (138.3.200.9) by
 BYAPR07CA0103.namprd07.prod.outlook.com (2603:10b6:a03:12b::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend
 Transport; Mon, 29 Nov 2021 22:59:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4c9bfb-dab5-4b7a-f6ef-08d9b38be1fa
X-MS-TrafficTypeDiagnostic: BYAPR10MB2583:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2583367D5D12C48D7016A9F3B1669@BYAPR10MB2583.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dv9Ig0XhKQjuX2Vkg9t9vSsaHsn1iYerEv8aDfSJs4/hwFu5b3x1uSjdRv0VOObCoX0KHgYCwk4hO/4Cz8r6tKaiptDs7GymT3nybo9cnPxg53TCJheYziHgui/TCmVG8N+SsfswyoOb3syJYCCbbYPMHBlEgu489YyZ3IE44/GO9AS9JqURpv13VtxnXkKkMHwv03nc3Ld5XB12MRB9k9aei017zwkVYyhGK0MrJJsDyVd6woZXSvb1m24IPyRy/BePNky7mx22UiOpnsrj+V0pFllSsf8Lr75MyOmS1NNozaNH9G6BBlnTUr9DvZx+/xCWf4AUdy6AsUeS8staxQciIzR5WtRiogkFgOJzN36mHUTRIA/wV8JZ9vaMfLyXGC5Ape7Rjf10Z5mZt0kriadTALGxwFcXBE3bbN9ac9yuXQcJnaf3XgyylXq9i5L+OAteC2VD88LoRLn6Axp5RcuKTFh9zgocSNhONP6CMVtcpsahHrQkF+fuMZeFXHSPrSw8T8rWR/e+FyRzm7WPgE/7hl1Q3cDD9kDU4HkyqNvADMgDcqqsw/yiXKnOBQFuYWclsziN0fu4JEEsms3qWdOqGynyrhOLN1oegndB12aNeia/iaUgcv69THH/NUdznWJkLF2oaPdKBYoKENAv4I5pCinpn/S8xUiR+PmMcHLlQQbu70r7m1yxvMOOF7KgM2ZNDo/zwqGGa2iAvASZDOkjJSJFJn14YIv+fnKfpcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(66556008)(316002)(36916002)(5660300002)(31686004)(66946007)(2906002)(66476007)(53546011)(26005)(508600001)(16576012)(110136005)(36756003)(8676002)(956004)(4326008)(83380400001)(2616005)(186003)(86362001)(8936002)(6486002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVBaTFKNUZheEExT1R6OUN5U0FUL3N5Mm9JT3pxTDhQb0tIOVp3Z1lGZXgv?=
 =?utf-8?B?cFhrc3hwdHRHdEtlcnZzZXRVUmZBVmxWNFdWeVpZb0xFa0p4S0xERTYvYTZK?=
 =?utf-8?B?Tm53TW1EdGdPTE04dWdVc1I0cVhQSGhpMDM0RTViSEkweE45dHo1eG51Qzds?=
 =?utf-8?B?QnV5enVYcTQvUjRTeE50TTRYZ2tuMlV5VTE2V2s0cTVGbEJ3Snp0Nk5wTnpW?=
 =?utf-8?B?NDdjRVdhSzIrMWFQM01VRFV2NjZoZlRnaUpaWW1OZ2NYN1pEckVCQ285Q0k1?=
 =?utf-8?B?ek1laDhYOWhSUTZOdDZHWlVKRWVQeDQxY09hZVFqTk9vemdaSGNyQjlEdnhR?=
 =?utf-8?B?UjVxRWJJVDhzWThQTld4UXovR3FBZTU5QzlNVjhUeUZqdWlVV2xoU0x2UnhB?=
 =?utf-8?B?QU5lT2FkRzZicm9YVTZFMjdTWHN2dHpUa3VQWUU0UzVIQkJzNGxpaW9Vd1J2?=
 =?utf-8?B?QTdBMWJFWmhQZEN6bU1DcERFdlE3TGQ0SzZLeEFlQXpONzZpcG9OWEVMb3lW?=
 =?utf-8?B?V0plNzJTQytIdk9RemdtRWFZLzFKRmxIMitsWThIdzh3akV4WWhDSFJZS3VT?=
 =?utf-8?B?YitsanRzbFNDR3FnVXNDOGwvVTZpa2svUEYzZnNRVEQ2Q2dYRkVjVmI3WjZQ?=
 =?utf-8?B?QSs2UngxMGlMTzdCWHdXTkZNWVlLK0VaVWhHdGJQRUhlbkVvV05VVHc5aVJO?=
 =?utf-8?B?S3Z0aW9aQ0JCZkk2RWFyaXpzK25ka3p5bjdJQ3R4UnUzYVd3ZDlqZlVBZUdm?=
 =?utf-8?B?dUplUG1MaUIvU3NNTDRHVnhtWkIvQWRuVEdxN25FaitkajRZeWRudGRsamdp?=
 =?utf-8?B?VmkwYTdxWk96djJ4Q3liNktCMk8xaGpjTkRuNFRUM3M5ay95UldQWHdGajFr?=
 =?utf-8?B?bXFPS3FBeDFiOHRMRzNiMlpmbDJvbEtONUJ1VmdVZXJWd2cxSnRLSk45M2Jj?=
 =?utf-8?B?Wmg5byttNWpoODh5T2MrU2o4RC9nSWRNdk9yQUs1VFpqLy9WbEEvcCtPYW54?=
 =?utf-8?B?K2VlazhLSGUvdE1pUkE1amM2RjlSTzFTNmdPcFVaRlYwb0ozeDBMUDVYajI0?=
 =?utf-8?B?R2FjOHVNbXluUFkxTHBhZkR2Y0N6YVljb3ptMG1sWVZSbDBOWUJuODV6Qkdq?=
 =?utf-8?B?WTZZVFhaRXp6Q3NRckE3QUhJNUJEeDMwajV2bUR3TGhRWWZiYll4dG5oMk1W?=
 =?utf-8?B?Sml2M2lVaG1yOVl6eXFMbXJ5bFg2R2JMNzkxMnRhd3c0ODN0MU5HeXZkUEFu?=
 =?utf-8?B?d3VXUW9nZzdnSDdKSGxUa1lydStYY0NyOFQwclhqVDd0bitTMlpMM21peWtv?=
 =?utf-8?B?SndYVzZmTlgrc2Z5OFBQRVBtY0tvdHc4VUw1WXhLMXlOOUg3dnRSWVg4MWtC?=
 =?utf-8?B?ZHZnOHM2Z3FJM09IWTNUN2pCTFg0c2l1MXBYZVdlU0l2MFNDZ1BiMm54b2lk?=
 =?utf-8?B?NDVHZmU2UzMybzVzRnp5YVdaRWc0ZEdHTmFVVXFXZks0ci9tYVBXNktuUUxs?=
 =?utf-8?B?L09jazNpTlp3UE96RkY0ZTVQU3QwL3BPbDRudmpVUzk5V3UwWCtoTjRacENF?=
 =?utf-8?B?bVk3NmIrZnJRcnBNbUdZYzd1TWwxc3BnRVphc09GTDJkTzZHV2Zvb1pyeGFm?=
 =?utf-8?B?V0dWVmtLWXVlL0YxU3FSWnZXWmIydzRSVHNQWUFLdFo3T1E0WlRkTEFwbnht?=
 =?utf-8?B?SmtFQ2ZiSjR3TlZEMFBsTjhSeUlVS1A2TWRoZkFtQldpb3NDUDlCSWhHOWpp?=
 =?utf-8?B?anFFR0VJN3BETld2Ym01bGRvdXg5RnA4TVE2cTNCR2ZoN1B2YkhLTUlOWndH?=
 =?utf-8?B?bSsyU2ZNcS9sMVRiQ29CL1RJOU8xQXdidGhLUDJxMkRRdnhsdjZEVm5CazUy?=
 =?utf-8?B?SVo4ZVU4Tk03T0VEekhPWHBXNmNVT3BZNWFISC8rZGY4d1RFaXR3c0pXL09o?=
 =?utf-8?B?dDE3YWZwdUJ2NFJVbzlJeVJrek54Z2VMWS9IbDQwRWxqWEYwa1NobHAyMzhE?=
 =?utf-8?B?WXZEb0RhNDBKMEovcFBGeldRMkVhU0VDUU5TSU01RWRzcFpRZnh5eHdBQ0NF?=
 =?utf-8?B?UFNPbkduL0hLVmk1S1dXTFJtK214bDJBYTk1QUFxTU5DMmNqN0hDcWs1Z0sr?=
 =?utf-8?B?Mmd0cWlYdEpRaWluakZoZE9SR1ZocGgybFdVa2xOZXNvM1ErWFlNenZHWmhI?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4c9bfb-dab5-4b7a-f6ef-08d9b38be1fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 22:59:22.5880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWp018KzXirGFSdwmeXdy73CeDf/bX36/HORpux6aGVd3EoS2L4l/YC7vFl7iulZ9EAwHITUIwCDvFaYrZ4UFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2583
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290108
X-Proofpoint-ORIG-GUID: 10zjmSkc2cwpw4erFvAfxYsDWklkI3zu
X-Proofpoint-GUID: 10zjmSkc2cwpw4erFvAfxYsDWklkI3zu
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 11/25/2021 8:22 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 25, 2021 at 09:29:53AM +0200, Eli Cohen wrote:
>> On Thu, Nov 25, 2021 at 02:21:43AM -0500, Michael S. Tsirkin wrote:
>>> On Wed, Nov 24, 2021 at 07:19:53PM +0200, Eli Cohen wrote:
>>>> Increase the limit on the maximum number of supported virtqueues to 256
>>>> to match hardware capabilities.
>>> Hmm and are we going to have to tweak it each time new hardware/firmware
>>> is out? Can't this be queried in some way?
>> I thought to make the allocation dynamic once we have support for
>> setting max queues through vdpa tool.
>
> Well this will make things a bit harder to figure out then,
> right now you can assume no vdpa tool support -> max 16 VQs.
> The patch breaks this. Is there a motivation to up this right now,
> or should we just wait a bit for vdpa tool support?
+1 on waiting for vdpa tool support.

-Siwei

>
>>> In fact there's a suggestion in code to remove the limitation -
>>> any plans to do this?
>> Can you be more speicifc, where?
> It's right there in the patch:
>
>    /* We will remove this limitation once mlx5_vdpa_alloc_resources()
>     * provides for driver space allocation
>     */
>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> typo in subject
>> What typo?
> virtuques. ispell is your friend.
>
>>>> ---
>>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> index ed7a63e48335..8f2918a8efc6 100644
>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> @@ -135,7 +135,7 @@ struct mlx5_vdpa_virtqueue {
>>>>   /* We will remove this limitation once mlx5_vdpa_alloc_resources()
>>>>    * provides for driver space allocation
>>>>    */
>>>> -#define MLX5_MAX_SUPPORTED_VQS 16
>>>> +#define MLX5_MAX_SUPPORTED_VQS 256
>>>>   
>>>>   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>>>>   {
>>>> -- 
>>>> 2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
