Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34634C433B4
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 18:50:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD46D613BA
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 18:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD46D613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C191405A0;
	Tue,  4 May 2021 18:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DxmZWiHFz3YS; Tue,  4 May 2021 18:50:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0ECA940119;
	Tue,  4 May 2021 18:50:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D14E8C000E;
	Tue,  4 May 2021 18:50:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2394DC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03BA040130
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xe9kN90sts2C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:49:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9C2B40119
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 18:49:58 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144IUnql156752;
 Tue, 4 May 2021 18:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xsA10InXqRbDMGv2m/ZRqCcZxTKsWUwLSPubXXfI0/Y=;
 b=Q9sHsQuaSnF/1uXkRm5yng+P3o2kAeBQ5rTHGqofV2yvQT1O7GiE7hhZTa8YQcXTxcKn
 B4br0I2G+fyI4e62xbv4cKqXHUe9cmXbLnDRZlWDKr/pK1uDTNlu3c18PdP8EmQ5Mq0u
 v4Cp3/6V655lNWiQBITnE21+LKc4qyTYJyLflQORWm0u07fFvhcP9JR0m9NJ6sw4VthZ
 19hcqLZ2PhfGw+H4a13+KIpOWEHp6x7upjSu5MwkxPERglZbtWSFuxx8b9FrRo2p21yo
 1DV38aNzH9ccCYWsY+d3Xs5gn3+VduExlNOH77uFKE2dgWU97JhZMnLDyCfWU3fzvga1 Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 389h13xxup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 May 2021 18:49:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144IVQ6K037463;
 Tue, 4 May 2021 18:49:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by userp3020.oracle.com with ESMTP id 389grsd8k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 May 2021 18:49:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXPQp3rRFU6WMiN99WFCLgkERpnBjCF5Rg5oxjZqiS/m2XCV71VMPHl5uzldkOtnl5vSy/cwEmeBc91NmUhbB24I7bcvoRc/1W6FkRvLYLBENf5VYjxgikPpW9skfscMw1Mdp3qC7ZKABC501DMIhOL6zlMsf00OK8jQujAD5tfMBAefEN2COxyJTc0JF0/CJ95ohf70mzN6U5piHQiMCpT7PBsW/+yFp6x1d1fQQMLVsLzhMC0m+BM/gGvmDndKvmekt1Zp+7J5S74rhoMTJHA5ca2/2Z9h/BAQar75O4ZqkcIGK25uHh1dhcZ7xyz9l/6/i2aQESWwIoshejZADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsA10InXqRbDMGv2m/ZRqCcZxTKsWUwLSPubXXfI0/Y=;
 b=Gt1plmFZbzdsSsGnJAhFD2SZLKauw+2R3OUDs0nThrj0SpSl20XioKw0xJPqRT0n0tV9uT2Vz8l+sc1N2pFOt4D0w1Fpsib9EZfUKvLsB9Alu8MwsyJK+zx2rgy7Zy1zUxCy169HiA57w0o2LhZW3X7xO0LxffSlNBRHp0/aVe50mfYiGzhpDk8Dn8/0uK0Rxvn/InvUQqgE8yr5dAGeHZ+AKRCMw21JOfmIqOYlGMRdmpDdDogehK54O9dazDq8+Fs9MOpq1X0Cu0Iv9fbB1GMIj7E5ei1t+R99JHHunAndjmyBrCeRZDwZhWC1k8t1RdNbgKUiIBHkx7VJwhoaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsA10InXqRbDMGv2m/ZRqCcZxTKsWUwLSPubXXfI0/Y=;
 b=uprL9+U37tkR+vcpLnXWqiTVSIeu+TDcF/sQsEXSGTgG078dz/2KEH9AD46AeRNyr1iO9piUdsycKaV9zFSeOPvV3+ijfrjQMfzuDXZpk8/Hr7wBuMleOHxyUFCOEIMia1qEfaaJt/wXPqWrMMzmD90ztMxpXpSOntZ/2nE2itw=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Tue, 4 May
 2021 18:49:54 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:49:54 +0000
Subject: Re: [PATCH RFC 12/14] vhost: add vhost_dev pointer to vhost_work
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210428223714.110486-1-michael.christie@oracle.com>
 <20210428223714.110486-14-michael.christie@oracle.com>
 <20210504153331.e2c34qii25kvpxdf@steredhat>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <c14ae1a1-9626-ee2c-0815-5cdf3945daab@oracle.com>
Date: Tue, 4 May 2021 13:49:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210504153331.e2c34qii25kvpxdf@steredhat>
Content-Language: en-US
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:3:117::23) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [20.15.0.204] (73.88.28.6) by
 DM5PR13CA0061.namprd13.prod.outlook.com (2603:10b6:3:117::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 18:49:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d012a9f-acf2-468a-d34f-08d90f2d6842
X-MS-TrafficTypeDiagnostic: BY5PR10MB4337:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43374ED651503510C24C67F0F15A9@BY5PR10MB4337.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAK5p94X8UAguyRJo7cbMBft7UFUN5iKVhPV2bgXD0RAH9w6CQRqI/i/3l/akNdXISB950yPDrThkAM7Xioqs9gf7BRlzZ1GkS4b32suvg2jmop2zMYIwvWLrAeUjxpgwcyay3NgBk8jn9bCfxp5JNEX4hLQ+jnJSZMEWEDS742QSd2UWDWqiNRamaase8q65RK8eGe+3MEDRsWaN06WeOdcvF/O01UJ0f8eTwDpfnMbUgAI4OM9lr5uuesRDsYdzH9G2lkComU8S6NrgCtnbDesukicVp6MSwetDr0cYXh8PnvgCWw2/NgXB4gYZ58YEd7HY699jdtrBTt3AKfvRdHiPmPLYOzFbFROMs9xIUjkSIfgUBFZ08hdNA6+K3bNE/1cdsTA98R4GCVVMMOQBBUl5OBB3TEFKLivb55kan4fEyKhb8H3nd3wcksP4gJNtHIWOBPXvZNOJZN3jDThYn+lC3RxvaoAxMdQZ96UaouiSOPquOWTner7NSfFkdoJeDrgQkmcbmFzMONSosr2NX0g+ksCWrbz7lGI3Yw799BuAQJ/PkvAVRDdLAyTaJlnQwRfHMDLKNGNItXiEci9RE787kdLHZ+jgIHV0rEg4OmEOL/IzQ/PMWEyoYA/S5KJLI+hY5Ss3y8i2gGoijRk9HtAecmOrpwS/RyTZ+XpVyn5IrfULaP1ryEUCs0oF7Gx+xUWkG0JRa+w5OvU2NS1uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(396003)(366004)(39860400002)(136003)(346002)(26005)(5660300002)(8676002)(2616005)(478600001)(4326008)(31686004)(2906002)(38100700002)(16526019)(8936002)(956004)(186003)(53546011)(6916009)(66556008)(66476007)(16576012)(66946007)(83380400001)(316002)(36756003)(31696002)(6486002)(86362001)(6706004)(78286007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YU1Fa1UyaDNJVTllamNQK09zc0RsdkhqWU5TLzRrUnRoVFhZbDFRek44TDNm?=
 =?utf-8?B?SEFqSVZMcHJUejc4dVU4VnVBQXkvTFJ3N1cvRStDa0dzNTRSLytSZ2lmTUNV?=
 =?utf-8?B?aFV4Yzk4TlhnamlGOXpueEVrbDJWdnVrcVQ1RVdoZklPMFNjRytjNlpXNlR0?=
 =?utf-8?B?VXRhMnNPelRGYjhZK0poeEhqMG55b1lDYzhscVhBUGVnSCtlWkk2dzlEeW1p?=
 =?utf-8?B?ODdUTVREaWZlU3BkOU8wK2pqdVgwdUp4STk0MUliTXRzaXdvTHoyczFma2FM?=
 =?utf-8?B?UXArWDh0WUZTTCtYeEcyOWVFSGxKT0liNUp2MjVlZm1HY1JyajJWRFFqUGps?=
 =?utf-8?B?Q3VadnY1UW8xemhzcDU0Ym5IS0Z5bzNTeUNWRktaV3lYbnhKUlhQMkZReTFB?=
 =?utf-8?B?djFFL3g5aXMxWklJRzc5dWVqUWMxb1hSOEtpSGs4TW1oK3RLQlZZTFNSQ1Vz?=
 =?utf-8?B?TkttNlFmbkFsb282OXAySjVZa1pNYktUYU9pN2xwWVFkUnRqMGI5V2VGNjdl?=
 =?utf-8?B?QmdmeDM2ZHpiMTFvUnpLVnNyeHMrTWNmdEZ6RGNHa3E5RGJmM3o4OENrdUc1?=
 =?utf-8?B?TGRBaC9IV0RyMkpObklhaysvQzdicGl0d3FrZzV5VXp4TlRiVURiUVVRSlli?=
 =?utf-8?B?eElqTWU5dDBRMWhLamJZSGZzTG8zZXYxZytFQWM3d2I1SlVmbDNzUWh1MTV4?=
 =?utf-8?B?UnhpT2poeVZOc2NUMUE4aWphZ3VzQnZ6K0RqODhnZ1kwOVFTOS9vZlNIT3RF?=
 =?utf-8?B?N1E1S0syZWNLV2t1WHlyYnkwQWxsTWsyWGNlQ0h3QlNaOGV1dDRUR3F1c1Q1?=
 =?utf-8?B?SytQbWJBallJbkowcll2R0tNMkcrZEJsVFJ0eExrRjFOSXFwTVFNSlBOZ3Rt?=
 =?utf-8?B?NlJDTUdZbjJ6cFNQM0tXTVdtSlRKazZJNUFLOHppTEkybStTb2cxRG13UWpJ?=
 =?utf-8?B?Q21ucFQ1bE1DbzhYVktoNk9ua3BQS0FnUjhKbWNWaVlCMFB0dTB0dTZUL1F2?=
 =?utf-8?B?SGZEaEJtVzhSN1NWQmw4T0lOTENvNklRSUxodGgwb3dRd1J0QzdFOG9XT0xF?=
 =?utf-8?B?RHRDUW5PT1d5akw1LzRFUGpMV3BOaWZQT1c5dTZHNGZSUFZFc0llc2JCbXhP?=
 =?utf-8?B?cEcwUXVZNitFV0xxKzRnNmVhaTFSczkwdDAwRGlYbTFEYnZrbDBMWmJETEVM?=
 =?utf-8?B?ZDFWd0hwWW9MbDhVaFRsZFdEWUlvOThZKzBlQlZNaEpvVmFPcVNyRys2aW9R?=
 =?utf-8?B?M0U5NlhZVElUb3l4VUNreW1rNzUvczk0cUw0aVg1YjFXZUhBVDZ4Y0VVU2Fq?=
 =?utf-8?B?ZndZNnRwU1Rha3hpSVI4TVpEOEpNdGhHR0EyU0c2VmRPU1B3NHFzZGttUlZp?=
 =?utf-8?B?eTlkWHZvVEp6ajhBSFZjTlc3akJnNDNkSkpETGxKRDhrZzlPYzhsaXFYdHRZ?=
 =?utf-8?B?L1krQmlGYUJQOGFpUkdCSFZZWVNISm1obTZibnE4bVJqcHNwZDA2VnhiNjV3?=
 =?utf-8?B?WkxGcU0rZzdBS0wwUGE4L3hTV3A0VnhQRVpFY00xalJYSGlHS2hXMndzdnZk?=
 =?utf-8?B?V0wvUys3anE2TStwWExjRFZGTThsYXFHVmQwanhCU3V3bjdZa1lKYjgrUE13?=
 =?utf-8?B?c0QvVDRDbEtOQTJSSEFLRzBmVEgvU0VNOE9ld1ZlWHdXMElwb3VYbDNSQWFt?=
 =?utf-8?B?SHNscGVXK3FGdzVzbHZ0ZmJPaTAwQXlld2JaN0xWcWthb1kxTG1mY3RXdEdj?=
 =?utf-8?Q?RYhmyIsxZQMA+z000XXE7WWkTnhFtQD4yUZbQv1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d012a9f-acf2-468a-d34f-08d90f2d6842
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:49:54.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEEeIY1y3qpQX5szkWyTY5clh7lIV8gqCkxBCqOEyEs3ej0aR6sbmQcaCaVBcVhkfS7G05Hd/UXaQzL0Egj/PVmZt8w3NfxxdC0w5WoOYRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105040122
X-Proofpoint-ORIG-GUID: rohmXZMa4bzzFNYtTnsWlxhPYCZBxQB8
X-Proofpoint-GUID: rohmXZMa4bzzFNYtTnsWlxhPYCZBxQB8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040122
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS80LzIxIDEwOjMzIEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24gV2VkLCBB
cHIgMjgsIDIwMjEgYXQgMDU6Mzc6MTJQTSAtMDUwMCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPj4g
VGhlIG5leHQgcGF0Y2ggYWxsb3dzIGEgdmhvc3Rfd29ya2VyIHRvIGhhbmRsZSBkaWZmZXJlbnQg
ZGV2aWNlcy4gVG8KPj4gcHJlcGFyZSBmb3IgdGhhdCwgdGhpcyBwYXRjaCBhZGRzIGEgcG9pbnRl
ciB0byB0aGUgZGV2aWNlIG9uIHRoZSB3b3JrIHNvCj4+IHdlIGNhbiBnZXQgdG8gdGhlIGRpZmZl
cmVudCBtbXMgaW4gdGhlIHZob3N0X3dvcmtlciB0aHJlYWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNvbT4KPj4gLS0tCj4+IGRy
aXZlcnMvdmhvc3Qvc2NzaS5jwqAgfMKgIDcgKysrKy0tLQo+PiBkcml2ZXJzL3Zob3N0L3Zob3N0
LmMgfCAyNCArKysrKysrKysrKysrKy0tLS0tLS0tLS0KPj4gZHJpdmVycy92aG9zdC92aG9zdC5o
IHwgMTAgKysrKysrLS0tLQo+PiBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMgfMKgIDMgKystCj4+IDQg
ZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Njc2kuYyBiL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4+
IGluZGV4IDJmODRjZjYwMmFiMy4uMGU4NjI1MDNiNmE4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3Njc2kuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+PiBAQCAtMTgwOCw3
ICsxODA4LDcgQEAgc3RhdGljIGludCB2aG9zdF9zY3NpX29wZW4oc3RydWN0IGlub2RlICppbm9k
ZSwgc3RydWN0IGZpbGUgKmYpCj4+IMKgwqDCoMKgaWYgKCF2cXMpCj4+IMKgwqDCoMKgwqDCoMKg
IGdvdG8gZXJyX3ZxczsKPj4KPj4gLcKgwqDCoCB2aG9zdF93b3JrX2luaXQoJnZzLT52c19ldmVu
dF93b3JrLCB2aG9zdF9zY3NpX2V2dF93b3JrKTsKPj4gK8KgwqDCoCB2aG9zdF93b3JrX2luaXQo
JnZzLT5kZXYsICZ2cy0+dnNfZXZlbnRfd29yaywgdmhvc3Rfc2NzaV9ldnRfd29yayk7Cj4+Cj4+
IMKgwqDCoMKgdnMtPnZzX2V2ZW50c19uciA9IDA7Cj4+IMKgwqDCoMKgdnMtPnZzX2V2ZW50c19t
aXNzZWQgPSBmYWxzZTsKPj4gQEAgLTE4MjMsNyArMTgyMyw3IEBAIHN0YXRpYyBpbnQgdmhvc3Rf
c2NzaV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmKQo+PiDCoMKgwqDC
oMKgwqDCoCB2cXNbaV0gPSAmc3ZxLT52cTsKPj4gwqDCoMKgwqDCoMKgwqAgc3ZxLT52cyA9IHZz
Owo+PiDCoMKgwqDCoMKgwqDCoCBpbml0X2xsaXN0X2hlYWQoJnN2cS0+Y29tcGxldGlvbl9saXN0
KTsKPj4gLcKgwqDCoMKgwqDCoMKgIHZob3N0X3dvcmtfaW5pdCgmc3ZxLT5jb21wbGV0aW9uX3dv
cmssCj4+ICvCoMKgwqDCoMKgwqDCoCB2aG9zdF93b3JrX2luaXQoJnZzLT5kZXYsICZzdnEtPmNv
bXBsZXRpb25fd29yaywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZob3N0X3Nj
c2lfY29tcGxldGVfY21kX3dvcmspOwo+PiDCoMKgwqDCoMKgwqDCoCBzdnEtPnZxLmhhbmRsZV9r
aWNrID0gdmhvc3Rfc2NzaV9oYW5kbGVfa2ljazsKPj4gwqDCoMKgwqB9Cj4+IEBAIC0yMDE3LDcg
KzIwMTcsOCBAQCBzdGF0aWMgaW50IHZob3N0X3Njc2lfcG9ydF9saW5rKHN0cnVjdCBzZV9wb3J0
YWxfZ3JvdXAgKnNlX3RwZywKPj4gwqDCoMKgwqBpZiAoIXRtZikKPj4gwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FTk9NRU07Cj4+IMKgwqDCoMKgSU5JVF9MSVNUX0hFQUQoJnRtZi0+cXVldWVfZW50
cnkpOwo+PiAtwqDCoMKgIHZob3N0X3dvcmtfaW5pdCgmdG1mLT52d29yaywgdmhvc3Rfc2NzaV90
bWZfcmVzcF93b3JrKTsKPj4gK8KgwqDCoCB2aG9zdF93b3JrX2luaXQoJnRwZy0+dmhvc3Rfc2Nz
aS0+ZGV2LCAmdG1mLT52d29yaywKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aG9zdF9z
Y3NpX3RtZl9yZXNwX3dvcmspOwo+Pgo+IAo+IGBjaGVja3BhdGNoLnBsIC0tc3RyaWN0YCBjb21w
bGFpbnMgaGVyZToKPiAKPiBDSEVDSzogQWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVu
dGhlc2lzCj4gIzc0OiBGSUxFOiBkcml2ZXJzL3Zob3N0L3Njc2kuYzoyMDM2Ogo+ICvCoMKgwqAg
dmhvc3Rfd29ya19pbml0KCZ0cGctPnZob3N0X3Njc2ktPmRldiwgJnRtZi0+dndvcmssCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aG9zdF9zY3NpX3RtZl9yZXNwX3dvcmspOwo+IAoKV2ls
bCBmaXggYW5kIHVzZSBzdHJpY3QgZnJvbSBub3cgb24gdG9vLgoKCgo+PiDCoMKgwqDCoG11dGV4
X2xvY2soJnZob3N0X3Njc2lfbXV0ZXgpOwo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9z
dC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+IGluZGV4IGZlY2RhZTBkMThjNy4u
N2JhMGMzMDNiYjk4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4gKysr
IGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+IEBAIC0xODEsMTAgKzE4MSwxMiBAQCBzdGF0aWMg
aW50IHZob3N0X3BvbGxfd2FrZXVwKHdhaXRfcXVldWVfZW50cnlfdCAqd2FpdCwgdW5zaWduZWQg
bW9kZSwgaW50IHN5bmMsCj4+IMKgwqDCoMKgcmV0dXJuIDA7Cj4+IH0KPj4KPj4gLXZvaWQgdmhv
c3Rfd29ya19pbml0KHN0cnVjdCB2aG9zdF93b3JrICp3b3JrLCB2aG9zdF93b3JrX2ZuX3QgZm4p
Cj4+ICt2b2lkIHZob3N0X3dvcmtfaW5pdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHN0cnVjdCB2
aG9zdF93b3JrICp3b3JrLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZob3N0X3dvcmtf
Zm5fdCBmbikKPj4gewo+PiDCoMKgwqDCoGNsZWFyX2JpdChWSE9TVF9XT1JLX1FVRVVFRCwgJndv
cmstPmZsYWdzKTsKPj4gwqDCoMKgwqB3b3JrLT5mbiA9IGZuOwo+PiArwqDCoMKgIHdvcmstPmRl
diA9IGRldjsKPj4gfQo+PiBFWFBPUlRfU1lNQk9MX0dQTCh2aG9zdF93b3JrX2luaXQpOwo+Pgo+
PiBAQCAtMjAwLDcgKzIwMiw3IEBAIHZvaWQgdmhvc3RfcG9sbF9pbml0KHN0cnVjdCB2aG9zdF9w
b2xsICpwb2xsLCB2aG9zdF93b3JrX2ZuX3QgZm4sCj4+IMKgwqDCoMKgcG9sbC0+d3FoID0gTlVM
TDsKPj4gwqDCoMKgwqBwb2xsLT52cSA9IHZxOwo+Pgo+PiAtwqDCoMKgIHZob3N0X3dvcmtfaW5p
dCgmcG9sbC0+d29yaywgZm4pOwo+PiArwqDCoMKgIHZob3N0X3dvcmtfaW5pdChkZXYsICZwb2xs
LT53b3JrLCBmbik7Cj4+IH0KPj4gRVhQT1JUX1NZTUJPTF9HUEwodmhvc3RfcG9sbF9pbml0KTsK
Pj4KPj4gQEAgLTI2OSwxMiArMjcxLDEzIEBAIHZvaWQgdmhvc3Rfd29ya19xdWV1ZShzdHJ1Y3Qg
dmhvc3RfZGV2ICpkZXYsIHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKQo+PiB9Cj4+IEVYUE9SVF9T
WU1CT0xfR1BMKHZob3N0X3dvcmtfcXVldWUpOwo+Pgo+PiAtc3RhdGljIHZvaWQgdmhvc3Rfd29y
a19kZXZfZmx1c2hfb24oc3RydWN0IHZob3N0X3dvcmtlciAqd29ya2VyKQo+PiArc3RhdGljIHZv
aWQgdmhvc3Rfd29ya19kZXZfZmx1c2hfb24oc3RydWN0IHZob3N0X2RldiAqZGV2LAo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZob3N0X3dvcmtlciAq
d29ya2VyKQo+PiB7Cj4+IMKgwqDCoMKgc3RydWN0IHZob3N0X2ZsdXNoX3N0cnVjdCBmbHVzaDsK
Pj4KPj4gwqDCoMKgwqBpbml0X2NvbXBsZXRpb24oJmZsdXNoLndhaXRfZXZlbnQpOwo+PiAtwqDC
oMKgIHZob3N0X3dvcmtfaW5pdCgmZmx1c2gud29yaywgdmhvc3RfZmx1c2hfd29yayk7Cj4+ICvC
oMKgwqAgdmhvc3Rfd29ya19pbml0KGRldiwgJmZsdXNoLndvcmssIHZob3N0X2ZsdXNoX3dvcmsp
Owo+Pgo+PiDCoMKgwqDCoHZob3N0X3dvcmtfcXVldWVfb24oJmZsdXNoLndvcmssIHdvcmtlcik7
Cj4+IMKgwqDCoMKgd2FpdF9mb3JfY29tcGxldGlvbigmZmx1c2gud2FpdF9ldmVudCk7Cj4+IEBA
IC0yODUsNyArMjg4LDcgQEAgdm9pZCB2aG9zdF93b3JrX2Rldl9mbHVzaChzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYpCj4+IMKgwqDCoMKgaW50IGk7Cj4+Cj4+IMKgwqDCoMKgZm9yIChpID0gMDsgaSA8
IGRldi0+bnVtX3dvcmtlcnM7IGkrKykKPj4gLcKgwqDCoMKgwqDCoMKgIHZob3N0X3dvcmtfZGV2
X2ZsdXNoX29uKGRldi0+d29ya2Vyc1tpXSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCB2aG9zdF93b3Jr
X2Rldl9mbHVzaF9vbihkZXYsIGRldi0+d29ya2Vyc1tpXSk7Cj4+IH0KPj4gRVhQT1JUX1NZTUJP
TF9HUEwodmhvc3Rfd29ya19kZXZfZmx1c2gpOwo+Pgo+PiBAQCAtMzA1LDcgKzMwOCw3IEBAIEVY
UE9SVF9TWU1CT0xfR1BMKHZob3N0X2hhc193b3JrKTsKPj4KPj4gdm9pZCB2aG9zdF92cV93b3Jr
X2ZsdXNoKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxKQo+PiB7Cj4+IC3CoMKgwqAgdmhvc3Rf
d29ya19kZXZfZmx1c2hfb24odnEtPndvcmtlcik7Cj4+ICvCoMKgwqAgdmhvc3Rfd29ya19kZXZf
Zmx1c2hfb24odnEtPmRldiwgdnEtPndvcmtlcik7Cj4+IH0KPj4gRVhQT1JUX1NZTUJPTF9HUEwo
dmhvc3RfdnFfd29ya19mbHVzaCk7Cj4+Cj4+IEBAIC01NzIsMTQgKzU3NSwxNSBAQCBzdGF0aWMg
dm9pZCB2aG9zdF9hdHRhY2hfY2dyb3Vwc193b3JrKHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKQo+
PiDCoMKgwqDCoHMtPnJldCA9IGNncm91cF9hdHRhY2hfdGFza19hbGwocy0+b3duZXIsIGN1cnJl
bnQpOwo+PiB9Cj4+Cj4+IC1zdGF0aWMgaW50IHZob3N0X2F0dGFjaF9jZ3JvdXBzX29uKHN0cnVj
dCB2aG9zdF93b3JrZXIgKndvcmtlcikKPj4gK3N0YXRpYyBpbnQgdmhvc3RfYXR0YWNoX2Nncm91
cHNfb24oc3RydWN0IHZob3N0X2RldiAqZGV2LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF93b3JrZXIgKndvcmtlcikKPj4gewo+PiDCoMKgwqDC
oHN0cnVjdCB2aG9zdF9hdHRhY2hfY2dyb3Vwc19zdHJ1Y3QgYXR0YWNoOwo+Pgo+PiDCoMKgwqDC
oGF0dGFjaC5vd25lciA9IGN1cnJlbnQ7Cj4+IC3CoMKgwqAgdmhvc3Rfd29ya19pbml0KCZhdHRh
Y2gud29yaywgdmhvc3RfYXR0YWNoX2Nncm91cHNfd29yayk7Cj4+ICvCoMKgwqAgdmhvc3Rfd29y
a19pbml0KGRldiwgJmF0dGFjaC53b3JrLCB2aG9zdF9hdHRhY2hfY2dyb3Vwc193b3JrKTsKPj4g
wqDCoMKgwqB2aG9zdF93b3JrX3F1ZXVlX29uKCZhdHRhY2gud29yaywgd29ya2VyKTsKPj4gLcKg
wqDCoCB2aG9zdF93b3JrX2Rldl9mbHVzaF9vbih3b3JrZXIpOwo+PiArwqDCoMKgIHZob3N0X3dv
cmtfZGV2X2ZsdXNoX29uKGRldiwgd29ya2VyKTsKPj4gwqDCoMKgwqByZXR1cm4gYXR0YWNoLnJl
dDsKPj4gfQo+Pgo+PiBAQCAtNjczLDcgKzY3Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgdmhvc3Rfd29y
a2VyICp2aG9zdF93b3JrZXJfY3JlYXRlKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPj4gwqDCoMKg
wqB3b3JrZXItPnRhc2sgPSB0YXNrOwo+PiDCoMKgwqDCoHdha2VfdXBfcHJvY2Vzcyh0YXNrKTsg
LyogYXZvaWQgY29udHJpYnV0aW5nIHRvIGxvYWRhdmcgKi8KPj4KPj4gLcKgwqDCoCByZXQgPSB2
aG9zdF9hdHRhY2hfY2dyb3Vwc19vbih3b3JrZXIpOwo+PiArwqDCoMKgIHJldCA9IHZob3N0X2F0
dGFjaF9jZ3JvdXBzX29uKGRldiwgd29ya2VyKTsKPj4gwqDCoMKgwqBpZiAocmV0KQo+PiDCoMKg
wqDCoMKgwqDCoCBnb3RvIHN0b3Bfd29ya2VyOwo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC92aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4+IGluZGV4IDY0ZGMwMDMzNzM4
OS4uMDUxZGVhNGUzYWI2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPj4g
KysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4+IEBAIC0yMSw5ICsyMSwxMCBAQCB0eXBlZGVm
IHZvaWQgKCp2aG9zdF93b3JrX2ZuX3QpKHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKTsKPj4KPj4g
I2RlZmluZSBWSE9TVF9XT1JLX1FVRVVFRCAxCj4+IHN0cnVjdCB2aG9zdF93b3JrIHsKPj4gLcKg
wqDCoCBzdHJ1Y3QgbGxpc3Rfbm9kZcKgwqDCoMKgwqAgbm9kZTsKPj4gLcKgwqDCoCB2aG9zdF93
b3JrX2ZuX3TCoMKgwqDCoMKgwqDCoMKgwqAgZm47Cj4+IC3CoMKgwqAgdW5zaWduZWQgbG9uZ8Kg
wqDCoMKgwqDCoMKgwqDCoCBmbGFnczsKPj4gK8KgwqDCoCBzdHJ1Y3QgbGxpc3Rfbm9kZcKgwqDC
oCBub2RlOwo+PiArwqDCoMKgIHZob3N0X3dvcmtfZm5fdMKgwqDCoMKgwqDCoMKgIGZuOwo+PiAr
wqDCoMKgIHVuc2lnbmVkIGxvbmfCoMKgwqDCoMKgwqDCoCBmbGFnczsKPiAKPiBNYXliZSB3ZSBz
aG91bGQgbW92ZSB0aGVzZSBjaGFuZ2VzIGluIGFub3RoZXIgcGF0Y2ggc2luY2UgdGhleSBhcmUg
bm90IHJlbGF0ZWQuCgoKV2lsbCBkby4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
