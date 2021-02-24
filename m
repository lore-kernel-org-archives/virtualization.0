Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC8C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 18:24:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7E464E6B
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 18:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7E464E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53AA06F69A;
	Wed, 24 Feb 2021 18:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4imJWqlmTxHu; Wed, 24 Feb 2021 18:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A058C60711;
	Wed, 24 Feb 2021 18:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66CF1C000A;
	Wed, 24 Feb 2021 18:24:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F0D5C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C17283C25
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ogumHI9S";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="i3RqpYJL"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OoZgAJ_PqwS9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:24:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0174E83CC9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:24:49 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OIEk5F004355;
 Wed, 24 Feb 2021 18:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lsJ4lFDNojE98d6dfL68DHzOJ6gtdU8Akm+nWaXMxX0=;
 b=ogumHI9SKP2vwZuN9Tn94k95KKki3VHrjjnB8yFt6Ep71C1OT8yxb+HplCSVaCjHuS50
 2tsj8SBaCCE6oHReclH+uZKXBhvfQyE5FVzPjJofbtkQQV6WzmRFFMUzWZBIgLo0kxCx
 n+zRC/EXxXKahQ6BwIDggjVDhIHrood8Euju6inEbTQYAyTF0AzazSZr2v/9216ytXYI
 PcIwdtdR/C+J0xKntJxlraUFgLRQkVAKiw6/ZiwFKFxq3PF3NWPPW+LJfM70MuMZOLOb
 eLV0cOKO11+pasCVlbqM/u/tNeK9hA9tLLIoh+K9gZkarRFKjraeOqwDoNxi47bEI+wv zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 36ttcmbwx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Feb 2021 18:24:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OIAYbo050742;
 Wed, 24 Feb 2021 18:24:47 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com
 (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
 by userp3030.oracle.com with ESMTP id 36ucc07cee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Feb 2021 18:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw0RLQ5VXbaVOIKE3RtDCmD9wOXWYDmcPe6F9M1WRQNSw0e644gqZ3e+Nszlc2zeFjRJQAa7/6JvqExZNapwvNdAu0ceY09RDxILmA99Ev37uS21W4J/h42kQU2LHxJZX/67DHoUr872AGO3gP4bW0o3BR6Jr9qYr7PaBN9n2PIvoG5TngZCfRxNzs8NUTgYg2cA7sFNQg3RFS12ZKp7cIxbrr/6AOOlLT2v9AiZJQZaz18QxIhKz57vtsRv1jT1eNHYOKWaNDOsyUpurKhFdNZOf1od3tmU/jQT6kBs+cNH719nj0k3xWyryUMA3hgnuUGhkbZRzLxwydG5OFxJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsJ4lFDNojE98d6dfL68DHzOJ6gtdU8Akm+nWaXMxX0=;
 b=Kay0o1fsooLTtxsN2K6weC4HwRyygmS57+t8/5j4HADN5LBPbx2aIXJXEC2f5pIv6SXxwLdWPa0rkfc4l7XgKwwfJ1H8url+Yqsi2bx7pNOezHqHvtaaYif3/F1bxr23JxXnMEkajmbwXXft46KeBrcgHtoOxUmi1Xm6hE43ZO5Jt7RmzHW2IIF+bN2l37Y7NULCYw9hIog+SuO1HP9WNYC4XJEsL4HomvsJqIj0edeo8SsaGitA6XaqnWyKofstdvdWYbhl+88tEI7iHhJSWXtG9qXzWW3tD+a/d1hpmUh7j7Icv/B8GRRJBsNfmHWgf5Bs7A/sHoRHDf7xMwmd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsJ4lFDNojE98d6dfL68DHzOJ6gtdU8Akm+nWaXMxX0=;
 b=i3RqpYJLWnTZ4WxPw+k2Xg/BvKwhi+M6Vhq/Cp+U5ofoIz+jszLnb2cJZ9vx7LkwaSlIwiOEpxwYI4cMqk/kRN11l3JfEps90PdIXbUmMATqQo6dB92BlLK8r+GYP4MRFUc5gTZ7l3pxRVkzB+xZZf+dIdIfW/nu7wH57a00W3Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 24 Feb
 2021 18:24:45 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 18:24:44 +0000
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
Date: Wed, 24 Feb 2021 10:24:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210224000057-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Originating-IP: [24.6.170.153]
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.6.170.153) by
 BYAPR11CA0086.namprd11.prod.outlook.com (2603:10b6:a03:f4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 18:24:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9773255c-1259-4f01-0e4a-08d8d8f1756c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4543:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4543FFDD5B0376A6B80DD20AB19F9@SJ0PR10MB4543.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88+Z3gsGFzoRx3yPbdDhYNWlMRx8zlABgRKZaH2Wp5GnbjXejONOiQ+sTzS32E8vgeY/Q5DGJxHDPQtROTXUag3cPx2PMpOcxlr+VisrRxH9hWMNoW11Fun5mE8Ug6NjdAqzVIFC0aGET6Q/qdj6eMtWm0VckBpHKUhhCadIFOODKHCrZjKX/X80niAVN0poymHxnNhpJOIqAbWBUoMYPOzo2unbUG4FbeZAcqqArWzHl4e3Da3DGmgwYo6y6vWlOaH71nK7tUgZz7E57fYBCVldzgTu0/LzNDtNaflOiQHCXtMAJGmkZZ3ERHXrAGJ0cLqa8wIbONzFxeqSPsQ+XXSOM9nh7frCVIDgliWkJtCnRRMUZEqDm7kFxMyJlNYSJp6TDahgwScu7UsNCCeWete9PZnvfhumYr/CZyHDR4bMowp/bjmkgTcf7X5kpu/SEpioUqiirmGheJPZONEwmR+U3yeRM/0UXjwCoz2e2qhCrqofXdFtw7f7K9z9wrAIDWHiUQgbXBcVfw4HqURf80/Tud8j6Eajlk3R6H9mvEExmVXzMvdlG8/5WXrxpwK29hAjw909Yc6fhwedY8E5x/0BjAYsWcZE9zRf8XLfyk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(396003)(366004)(346002)(376002)(66946007)(66476007)(8676002)(8936002)(6916009)(5660300002)(66556008)(4326008)(83380400001)(36916002)(53546011)(16576012)(26005)(2906002)(16526019)(478600001)(186003)(956004)(2616005)(316002)(31696002)(36756003)(6486002)(31686004)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZVZNYS9maFFacTRpTEhHdGhJZUJNVXViWGlXNGt4Z1V1cGVmMWFIR0VzYmFC?=
 =?utf-8?B?MWZhcmx3Z2ZjNnJXOUdjMWN2U2JkejFLYXRaNUN5eVhQbUZWT2hqcjlQT0Mv?=
 =?utf-8?B?Y0JnTVZJREZBVks5U3g5TlNSRjU0OXdpUlpZQ2VOQ05XQVUrQjIzVi90bjJW?=
 =?utf-8?B?MWRlbW1LNktNV2pxYW1Bb3JCb1FYV1dvNEFSVHN6ZTRmeVQxL3NjNHBsUWk0?=
 =?utf-8?B?U3BaWXlGT1pPRmZYcTg2aCt1cjh0ODh4R2xuTW9CZUpQYzB3QzRPeERKbldR?=
 =?utf-8?B?a1ppaFNvMmE5d0hNL05WbE9taHBXWnJuN3JJMnJWOU9oR21pUFF1Sy9sRStB?=
 =?utf-8?B?cjE2T2txRHQvcTQ1eDYyWVRoYnVsWEZ4WHpvcVpVVzhIWTdLR0hDVTZCNUg3?=
 =?utf-8?B?TzJUNXlDRTRzZWJpQTdydjd6M1YwcjF1aURwS0hhQUFjalVZNE1UcWltUG1r?=
 =?utf-8?B?Z0pzVFluUUpJNWdUcDJkY3l6ZG5WZlBPRGFESGJsNGpJZ3djUlVlTWNJNzU1?=
 =?utf-8?B?bllmcWY1aGl5REFLcW00dCtwL2RQSVBoSHBVUGRlaCttbFMxYUtEaUVyNndm?=
 =?utf-8?B?VDczSDhnN0xwYXlXU3NyVnFPL3FLdDlHWXVNUE1RckF0WU9xb3lyODVpa1p0?=
 =?utf-8?B?R1lBMUNOdEZ2TTVtbVZrUHRhcGt2RE00WU1ra3NiRCtsQ0RySDN2MzQ5eXdJ?=
 =?utf-8?B?Zmp1VzJaKzFRYjg3Y0RlTnY4MjlBandvTFBIa3hHeFB5WEVnV2NNMlVPMFBm?=
 =?utf-8?B?WWlJU2lMOURVdkVVZWZNK09sQm53RWgxV2dZRXNmZVY1QVRGb1MwU3lvaGdR?=
 =?utf-8?B?b1l4ZnNweldUaDlXakxWcXBtcjdKRFlpanNzMS9hVnd2eUcvK0NNZk5vQnNE?=
 =?utf-8?B?dDBPRDIwQUtUYkF0dW1UWFY1bkNsazhRZ3dkZzRjRlk5Z081QnN4bmk5OTJZ?=
 =?utf-8?B?akJXN0pOT3BLRkdxOHVnakhtTjJOWHpxeFVUV2IvZkhkUGVQMXlQL09KSTBU?=
 =?utf-8?B?NkJrOUlvK1BpVUhZYWdjNTJlc21Tb2UwbUVpZ2xwRno3b0RSbGp6V1pIUkJK?=
 =?utf-8?B?MnJzMVBhMVdoVGpNNFo0c2sxRlJCM1B2QkJQUXhlUzVGV0ZmUUZaMEwxTit0?=
 =?utf-8?B?Rk1ZT1l3VDVPaTZiZFVRS0ZOMkhWYXNicDNXZnhPdzQzZUJXQ2JhZWZEbnpl?=
 =?utf-8?B?SXBud2wrYlhVMEhwVkFNcFBmN3IvQlpDbUczdllQZkJhc1R1MUk0VTZnMUJN?=
 =?utf-8?B?ZVJTSkQ3RXl2YnZwbWJRN1BoU2ZhRnduSmQycStvRUl4TGthZmNZakNKTXcw?=
 =?utf-8?B?emxHZ3RSMlo4bFV5bXEvVEliWmJLZ09rRDZ6c2M3Ty9JbzhnanlWNUNBSEhQ?=
 =?utf-8?B?Yzk3b0lGM2cweUxuaUZ6eDNsZzlVTUc4U0xqZ3JBem8wSHljQUFaR3dxMEJs?=
 =?utf-8?B?eFlDaGpyTS9yZ3dqZnMyeGFEQ1haZjhEbmIxYk5ManFSWlE2ZHZJS3k0eHZo?=
 =?utf-8?B?aHFmcXBTN0lsMDI1eFZIb3Q5K0Z0RnZzc2VpbWFienN4RSsvODNvQ1lnSlIw?=
 =?utf-8?B?cFltTUx6NjRQRDhMQktTK2EzbkMvWW9VTGlaamhROTdURU0vME1LSDRKNnRP?=
 =?utf-8?B?VEx2ZFZHWWlCKzJyZWNBYTlOYm1LK0h4MWRzQ2JLUzZvZGtxMVhpM1FLaXIw?=
 =?utf-8?B?Zy9qKzNkTENscklQVTFSMkZZWWlieUJRbHRROXVLQ0t3NDN2clo1UDlBWVFC?=
 =?utf-8?Q?VmVaRk5dUrS+i1pHrfgCIZKkD51SqGtf0pZmes1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9773255c-1259-4f01-0e4a-08d8d8f1756c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 18:24:44.2888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq754Bt8owMX7osWi+lfFkU32mcRnJ6Qdv5t2uDv8fOAd34eaRpbtDZhxFgDaGrKe/6Hv8TAPzv4EMwCWfR4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240141
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

CgpPbiAyLzIzLzIwMjEgOTowNCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFR1
ZSwgRmViIDIzLCAyMDIxIGF0IDExOjM1OjU3QU0gLTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+
Cj4+IE9uIDIvMjMvMjAyMSA1OjI2IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBP
biBUdWUsIEZlYiAyMywgMjAyMSBhdCAxMDowMzo1N0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pj4+IE9uIDIwMjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4g
T24gMi8yMS8yMDIxIDExOjM0IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+PiBP
biBNb24sIEZlYiAyMiwgMjAyMSBhdCAxMjoxNDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pj4+Pj4+IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+
Pj4+Pj4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMg
aXMgaW52b2tlZAo+Pj4+Pj4+PiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxl
Z2FjeSBndWVzdHMgdG8gcmVzZXQKPj4+Pj4+Pj4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25maWcg
c3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+Pj4+Pj4+IGFyZSBzZXQuIFdlIHNo
b3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sKPj4+Pj4+Pj4gYW5k
IGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPj4+Pj4+Pj4KPj4+Pj4+
Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNvdWxkIGFj
Y2Vzcwo+Pj4+Pj4+PiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBp
bnN0YW5jZSwgd2hlbgo+Pj4+Pj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0
aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPj4+Pj4+Pj4gd2lsbCB0cnkgdG8gYWNjZXNzIGFuZCB2
YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+Pj4+Pj4+PiBzcGFjZSBiZWZv
cmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4+Pj4+Pj4gVGhpcyBsb29rcyBsaWtlIGEgc3Bl
YyB2aW9sYXRpb246Cj4+Pj4+Pj4KPj4+Pj4+PiAiCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUgZm9sbG93
aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBpZgo+Pj4+Pj4+IFZJ
UlRJT19ORVRfRl9NVFUgaXMKPj4+Pj4+PiBzZXQuCj4+Pj4+Pj4gVGhpcyBmaWVsZCBzcGVjaWZp
ZXMgdGhlIG1heGltdW0gTVRVIGZvciB0aGUgZHJpdmVyIHRvIHVzZS4KPj4+Pj4+PiAiCj4+Pj4+
Pj4KPj4+Pj4+PiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRoaXM/Cj4+Pj4+Pj4K
Pj4+Pj4+PiBUaGFua3MKPj4+Pj4+IEFuZCBhbHNvOgo+Pj4+Pj4KPj4+Pj4+IFRoZSBkcml2ZXIg
TVVTVCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+Pj4+Pj4g
MS4gUmVzZXQgdGhlIGRldmljZS4KPj4+Pj4+IDIuIFNldCB0aGUgQUNLTk9XTEVER0Ugc3RhdHVz
IGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZpY2UuCj4+Pj4+PiAzLiBTZXQg
dGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1Mga25vd3MgaG93IHRvIGRyaXZlIHRo
ZQo+Pj4+Pj4gZGV2aWNlLgo+Pj4+Pj4gNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRzLCBhbmQg
d3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMKPj4+Pj4+IHVuZGVyc3Rvb2QgYnkgdGhl
IE9TIGFuZCBkcml2ZXIgdG8gdGhlCj4+Pj4+PiBkZXZpY2UuIER1cmluZyB0aGlzIHN0ZXAgdGhl
IGRyaXZlciBNQVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdyaXRlKQo+Pj4+Pj4gdGhlIGRldmljZS1z
cGVjaWZpYyBjb25maWd1cmF0aW9uCj4+Pj4+PiBmaWVsZHMgdG8gY2hlY2sgdGhhdCBpdCBjYW4g
c3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcgaXQuCj4+Pj4+PiA1LiBTZXQgdGhl
IEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldwo+
Pj4+Pj4gZmVhdHVyZSBiaXRzIGFmdGVyIHRoaXMgc3RlcC4KPj4+Pj4+IDYuIFJlLXJlYWQgZGV2
aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6Cj4+
Pj4+PiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKPj4+Pj4+IHN1cHBvcnQgb3VyIHN1
YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KPj4+Pj4+IDcuIFBl
cmZvcm0gZGV2aWNlLXNwZWNpZmljIHNldHVwLCBpbmNsdWRpbmcgZGlzY292ZXJ5IG9mIHZpcnRx
dWV1ZXMKPj4+Pj4+IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+Pj4+
Pj4gcmVhZGluZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8gY29u
ZmlndXJhdGlvbgo+Pj4+Pj4gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMuCj4+
Pj4+PiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBk
ZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gc28gYWNjZXNzaW5nIGNv
bmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVSRVNfT0sgaXMgYSBzcGVjIHZpb2xhdGlvbiwgcmlnaHQ/
Cj4+Pj4+IEl0IGlzLCBidXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0aGlzIGNvbW1pdCB0
cmllcyB0byBhZGRyZXNzLiBJCj4+Pj4+IHRob3VnaHQgdGhlIGxlZ2FjeSBndWVzdCBzdGlsbCBu
ZWVkcyB0byBiZSBzdXBwb3J0ZWQuCj4+Pj4+Cj4+Pj4+IEhhdmluZyBzYWlkLCBhIHNlcGFyYXRl
IHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBkcml2ZXIKPj4+Pj4gaXNz
dWUgd2hlcmUgdGhpcyBkaXNjcmVwYW5jeSBpcyBpbnRyb2R1Y2VkIHRvIHZpcnRuZXRfdmFsaWRh
dGUoKSAoc2luY2UKPj4+Pj4gY29tbWl0IGZlMzZjYmUwNjcpLiBCdXQgaXQncyBub3QgdGVjaG5p
Y2FsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+Pj4+Pgo+Pj4+PiAtU2l3ZWkKPj4+PiBJIHRo
aW5rIGl0J3MgYSBidWcgdG8gcmVhZCBjb25maWcgc3BhY2UgaW4gdmFsaWRhdGUsIHdlIHNob3Vs
ZCBtb3ZlIGl0IHRvCj4+Pj4gdmlydG5ldF9wcm9iZSgpLgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+PiBJ
IHRha2UgaXQgYmFjaywgcmVhZGluZyBidXQgbm90IHdyaXRpbmcgc2VlbXMgdG8gYmUgZXhwbGlj
aXRseSBhbGxvd2VkIGJ5IHNwZWMuCj4+PiBTbyBvdXIgd2F5IHRvIGRldGVjdCBhIGxlZ2FjeSBn
dWVzdCBpcyBib2d1cywgbmVlZCB0byB0aGluayB3aGF0IGlzCj4+PiB0aGUgYmVzdCB3YXkgdG8g
aGFuZGxlIHRoaXMuCj4+IFRoZW4gbWF5YmUgcmV2ZXJ0IGNvbW1pdCBmZTM2Y2JlMDY3IGFuZCBm
cmllbmRzLCBhbmQgaGF2ZSBRRU1VIGRldGVjdCBsZWdhY3kKPj4gZ3Vlc3Q/IFN1cHBvc2VkbHkg
b25seSBjb25maWcgc3BhY2Ugd3JpdGUgYWNjZXNzIG5lZWRzIHRvIGJlIGd1YXJkZWQgYmVmb3Jl
Cj4+IHNldHRpbmcgRkVBVFVSRVNfT0suCj4+Cj4+IC1TaXdpZQo+IERldGVjdGluZyBpdCBpc24n
dCBlbm91Z2ggdGhvdWdoLCB3ZSB3aWxsIG5lZWQgYSBuZXcgaW9jdGwgdG8gbm90aWZ5Cj4gdGhl
IGtlcm5lbCB0aGF0IGl0J3MgYSBsZWdhY3kgZ3Vlc3QuIFVnaCA6KApXZWxsLCBhbHRob3VnaCBJ
IHRoaW5rIGFkZGluZyBhbiBpb2N0bCBpcyBkb2FibGUsIG1heSBJIGtub3cgd2hhdCB0aGUgCnVz
ZSBjYXNlIHRoZXJlIHdpbGwgYmUgZm9yIGtlcm5lbCB0byBsZXZlcmFnZSBzdWNoIGluZm8gZGly
ZWN0bHk/IElzIAp0aGVyZSBhIGNhc2UgUUVNVSBjYW4ndCBkbyB3aXRoIGRlZGljYXRlIGlvY3Rs
cyBsYXRlciBpZiB0aGVyZSdzIGluZGVlZCAKZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBt
b2Rlcm4pIG5lZWRlZD8KCk9uZSBvZiB0aGUgcmVhc29uIEkgYXNrZWQgaXMgaWYgdGhpcyBpb2N0
bCBiZWNvbWVzIGEgbWFuZGF0ZSBmb3IgCnZob3N0LXZkcGEga2VybmVsLiBRRU1VIHdvdWxkIHJl
amVjdCBpbml0aWFsaXplIHZob3N0LXZkcGEgaWYgZG9lc24ndCAKc2VlIHRoaXMgaW9jdGwgY29t
aW5nPwoKSWYgaXQncyBvcHRpb25hbCwgc3VwcG9zZSB0aGUga2VybmVsIG1heSBuZWVkIGl0IG9u
bHkgd2hlbiBpdCBiZWNvbWVzIApuZWNlc3Nhcnk/CgpUaGFua3MsCi1TaXdlaQoKCj4KPgo+Pj4+
Pj4+PiBSZWplY3RpbmcgcmVzZXQgdG8gMAo+Pj4+Pj4+PiBwcmVtYXR1cmVseSBjYXVzZXMgY29y
cmVjdCBNVFUgYW5kIGxpbmsgc3RhdHVzIHVuYWJsZSB0byBsb2FkCj4+Pj4+Pj4+IGZvciB0aGUg
dmVyeSBmaXJzdCBjb25maWcgc3BhY2UgYWNjZXNzLCByZW5kZXJpbmcgaXNzdWVzIGxpa2UKPj4+
Pj4+Pj4gZ3Vlc3Qgc2hvd2luZyBpbmFjY3VyYXRlIE1UVSB2YWx1ZSwgb3IgZmFpbHVyZSB0byBy
ZWplY3QKPj4+Pj4+Pj4gb3V0LW9mLXJhbmdlIE1UVS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gRml4ZXM6
IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvcgo+Pj4+Pj4+PiBz
dXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExp
dSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4+Pj4+PiAtLS0KPj4+Pj4+Pj4gICDCoMKgIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0tLS0tLQo+Pj4+
Pj4+PiAgIMKgwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNCBkZWxldGlvbnMo
LSkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+Pj4+Pj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
Pj4+Pj4+PiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+Pj4+Pj4+PiAtLS0gYS9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+IEBAIC0xNDkwLDE0ICsxNDkwLDYgQEAgc3Rh
dGljIHU2NAo+Pj4+Pj4+PiBtbHg1X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldikKPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgcmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVy
ZXM7Cj4+Pj4+Pj4+ICAgwqDCoCB9Cj4+Pj4+Pj4+IC1zdGF0aWMgaW50IHZlcmlmeV9taW5fZmVh
dHVyZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+Pj4+Pj4+PiB1NjQgZmVhdHVyZXMp
Cj4+Pj4+Pj4+IC17Cj4+Pj4+Pj4+IC3CoMKgwqAgaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxMKFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FT1BOT1RTVVBQOwo+Pj4+Pj4+PiAtCj4+Pj4+Pj4+IC3CoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+
Pj4+IC19Cj4+Pj4+Pj4+IC0KPj4+Pj4+Pj4gICDCoMKgIHN0YXRpYyBpbnQgc2V0dXBfdmlydHF1
ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPj4+Pj4+Pj4gICDCoMKgIHsKPj4+Pj4+
Pj4gICDCoMKgwqDCoMKgwqAgaW50IGVycjsKPj4+Pj4+Pj4gQEAgLTE1NTgsMTggKzE1NTAsMTMg
QEAgc3RhdGljIGludAo+Pj4+Pj4+PiBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdTY0Cj4+Pj4+Pj4+IGZlYXR1cmVzKQo+Pj4+Pj4+PiAgIMKgwqAgewo+
Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19t
dmRldih2ZGV2KTsKPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQg
Km5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+Pj4+Pj4+IC3CoMKgwqAgaW50IGVy
cjsKPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgcHJpbnRfZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVz
LCB0cnVlKTsKPj4+Pj4+Pj4gLcKgwqDCoCBlcnIgPSB2ZXJpZnlfbWluX2ZlYXR1cmVzKG12ZGV2
LCBmZWF0dXJlcyk7Cj4+Pj4+Pj4+IC3CoMKgwqAgaWYgKGVycikKPj4+Pj4+Pj4gLcKgwqDCoMKg
wqDCoMKgIHJldHVybiBlcnI7Cj4+Pj4+Pj4+IC0KPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgbmRl
di0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gZmVhdHVyZXMgJgo+Pj4+Pj4+PiBuZGV2LT5tdmRl
di5tbHhfZmVhdHVyZXM7Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIG5kZXYtPmNvbmZpZy5tdHUg
PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbmRldi0+bXR1KTsKPj4+Pj4+Pj4gICDCoMKgwqDC
oMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwKPj4+
Pj4+Pj4gVklSVElPX05FVF9TX0xJTktfVVApOwo+Pj4+Pj4+PiAtwqDCoMKgIHJldHVybiBlcnI7
Cj4+Pj4+Pj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+Pj4+ICAgwqDCoCB9Cj4+Pj4+Pj4+ICAg
wqDCoCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZp
Y2UKPj4+Pj4+Pj4gKnZkZXYsIHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpjYikKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
