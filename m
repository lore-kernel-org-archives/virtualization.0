Return-Path: <SRS0=XTWN=G2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54783C433DB
	for <virtualization@archiver.kernel.org>; Sat, 23 Jan 2021 08:03:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4B9224D4
	for <virtualization@archiver.kernel.org>; Sat, 23 Jan 2021 08:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4B9224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63CE687523;
	Sat, 23 Jan 2021 08:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BRDO8qhkfBRO; Sat, 23 Jan 2021 08:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 516508750E;
	Sat, 23 Jan 2021 08:03:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 359A4C08A1;
	Sat, 23 Jan 2021 08:03:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7305DC013A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Jan 2021 08:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5910686861
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Jan 2021 08:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60Gc7QCW8COI
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Jan 2021 08:03:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 463ED86123
 for <virtualization@lists.linux-foundation.org>;
 Sat, 23 Jan 2021 08:03:41 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10N7xwDR161880;
 Sat, 23 Jan 2021 08:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gCmGgXxSeISHB33iCZf753xjAXlJpm3Ivl5T5OoObjQ=;
 b=AFv7IMqHPOz22Pue8vb+pIasctoaMuJbrtyb/HqzOg+uvziyh/AEyt7lRA1Xd0Dym3iD
 KsU6TBYm19yeBAOADjoisVelMUhvNM4SZ8lAMV6KKherSvIHFO5NrzmOJXhKVe8FyHZ9
 x497HCuvgVMztdF8rYFoj6wrflavhPiesJJF6JOCpS7zjDf31ERl3oJ4qvbb8KTOxHq5
 e0Dw/v1+YznTpG0ubxJ4/Vt1rBJ4L8PzrqIZSW/7A/IjvVJmhFMkL+5oVaUu5jmVkiU3
 6/6vhgrpo8wBq95RXMciRojKAvIKSfjg9/Q0C6hMzx3KdV2ZfibI5udkrCHNscnJfYXQ vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 3689aa8h9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 Jan 2021 08:03:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10N80rw1155890;
 Sat, 23 Jan 2021 08:01:39 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
 by aserp3030.oracle.com with ESMTP id 3689u8yxdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 Jan 2021 08:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z164jpLugkGDSBNNEOw+wkTug2kS0Evq5mYaq4rn506lCBpf2dJ92BKWfqAfUZePdEqVsStzrEJTVQIKecDlvTfqp87Q+FL6J+lRubQ0TUawd63/DPgbsqTU40/IXEbceYbkwEPOuzvZPa3xe3rc6k1yM0/mwKHDWKNNBeGS+b0UO/NNPG1d6cNpj7A+qeqbOBnoxrIIP8jMo/0TaLu2+T8GueNd8MtLg3PBCRI10VaVngpnFfm1em9CiG7T9NSfiF/F2g76SNbZR3uM3zx/rvKKRs5/X2zRanRra2XsM+qE8JmjAaJAbBOP32MP7VNWggIze16uVE4RGjSY0XtojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCmGgXxSeISHB33iCZf753xjAXlJpm3Ivl5T5OoObjQ=;
 b=S9OPa8CDxkgcYCf9yfmY77rz/2dSRmbMMjD6rkj+oycsXh6KeOlTKr0OavKrfDad6xt8Qx6y616wfQBKWWaBK8uAc0GEb7FCRblR5Cl7LxB/DqGCFeE0faIKfQEzNAzkQrU4XwGBzFJYXKs4S74xtpRo09U1BmeqLEu56F6xlD1chlcnMQbNkTQtTeaHTJQNS3U0jAC7OaWzuOMBCAYwBD6vS8gpPljgev2zXP4eFUeQH025m3xNBcBfDJzut8q9Mea2Km4Gs1SHbXqFRyuFK6B+U2xd4mHJr6dx+0IhK9avvTOFW8teXlUowoWfI62tNbS4ScAoNBSkCsJTvlMOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCmGgXxSeISHB33iCZf753xjAXlJpm3Ivl5T5OoObjQ=;
 b=zVeDdhe1jem4ID4cR7M1lMytwQVCBMhP8sj3vbglBXBtAj+vtD2xexdjX52wAkQakV0h2P5NMS+9NawnX+JmSw8Ej/a3tGuRR5M6c+WYaxO9quRRo+mm8Q37DEgtrATIPUzdO/b/Chx6crsg6JeRnkT72ZqVo7QY8KLsaCww1mQ=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BYAPR10MB3445.namprd10.prod.outlook.com (2603:10b6:a03:81::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Sat, 23 Jan
 2021 08:01:37 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::644d:92e4:7b5d:f8c1]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::644d:92e4:7b5d:f8c1%5]) with mapi id 15.20.3784.016; Sat, 23 Jan 2021
 08:01:37 +0000
Subject: Re: [PATCH 1/1] vhost scsi: allocate vhost_scsi with GFP_NOWAIT to
 avoid delay
To: Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 netdev@vger.kernel.org
References: <20210121050328.7891-1-dongli.zhang@oracle.com>
 <3aa5c6ca-abd3-13c4-b6a6-504f3a52bae7@redhat.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <5a03abaf-cbd6-242c-c965-b2da577da816@oracle.com>
Date: Sat, 23 Jan 2021 00:01:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <3aa5c6ca-abd3-13c4-b6a6-504f3a52bae7@redhat.com>
Content-Language: en-US
X-Originating-IP: [2601:646:c303:6700::a4a4]
X-ClientProxiedBy: CH2PR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:610:56::33) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:646:c303:6700::a4a4] (2601:646:c303:6700::a4a4) by
 CH2PR14CA0053.namprd14.prod.outlook.com (2603:10b6:610:56::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Sat, 23 Jan 2021 08:01:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ad90007-3404-4e8e-f617-08d8bf751bae
X-MS-TrafficTypeDiagnostic: BYAPR10MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3445F6F2B7328D77CEB8C585F0BF9@BYAPR10MB3445.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kx7EdzgraX3RYqdRVfaajWHDxsOK4IKqs5pPEDSamtK92H7P2WlQGxeSzWq+hT4HiRBITMBu5lacSMxb5iOkD50Zmw053/Su59zhs2HJQw9ZrVVQ85CYWMvgk9AI+GWnka9/gJIGdXMIqD23RS2bhEuDJwVWu3TjKQKG3Rbl0hJG8ZKWYGdz3vAzYh3t9lVO2p9axSaX4tUWQYYcQkY8Mv6eAsJ/6GjM0Ii7DE5iVxwVOo3anp91oxddzXFfhKYi1vWE8gA7ySYA2muRObJDnEpFbsgtvAEak8Wj1H28Q+Q1Qw/Lk5jJXrjRubdEM7CLwdqJaFlcdwfVUEPRoynxcVG/iWUKI5UipqSPHMM7kzgQpLR7aOfAc0heYrEbnRrcuJhuuH3CFfwgLW7CeCJe2IS7VrcX36NmbJjbbnT+at2Ny0+EDQsUbNJr63Omi2zGGonRO52sVNDQi9q5DiOr2bLMJfGgIjTDPOGNkhToNJJ9T+5hCrI/MbDG7sONN2Kzayp1M1yUJ93YrXA6fhEfU8p6+7Dd26NWf1TXGzQN++ApvtXTIlCPGw1r/uF4ayLW2jIrro1WxGE8XLNH7+qTZg+IIraD820Hz0ZbkpEW4Ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(66946007)(107886003)(5660300002)(66556008)(478600001)(53546011)(6666004)(2616005)(86362001)(16526019)(8936002)(66476007)(186003)(36756003)(44832011)(2906002)(83380400001)(6486002)(8676002)(31686004)(31696002)(4326008)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGRrTUZxQ3dTZHltMTFuOGROYmQ0b29MNGVTMStMdVFnM3MwQmhDdThwa0hp?=
 =?utf-8?B?alZnNGQyZG41MjJocElXdnkzanFKTndHSzFLQkcvdVBETnZDc0g2bUQzUmtr?=
 =?utf-8?B?RWRXUjM1bUVjU0xJdDdBVFhLSWZxQkZnOHNlKzQ2L2FhdXowUWs0V2NNb2Rz?=
 =?utf-8?B?L3BUZVc3dTdTSnZNWEtzK09UNjVDeW1wSk1yalFxRGswVGRaNldMc0lQV2FD?=
 =?utf-8?B?ZllrbDVKSXRrakM4R2YyZVR5VERYUzNpL0luM3MzU0JLUGVZMklWQWlZSERX?=
 =?utf-8?B?Y2lGRURKOFFZWGhiZmxXalJBeTNRMzJUQ2hzSzd1elZieDJrdnV6dFpEbGxM?=
 =?utf-8?B?MTAxN0N6aFFaeFdtQXBrQ0IrQlVMdHk0U0hDekhtZlByQzBqSEprM2ovY05C?=
 =?utf-8?B?bG5WZmNCMjNUYTJWMDhtUUlZN2Fod1NpZjlPSVhEaGFIRXk1MTR0dDhhRmdP?=
 =?utf-8?B?cm9wVVdGQWkzT3B4TWVUMkJRYTdQemRGU0xES2ZQY21QRUc2SzlHV3RURnpS?=
 =?utf-8?B?Q1YyM05PWlkxd3VlOTA5RnJsNHF4ZHZRdGdPdU9uNzU5d1FDYVlMOG9TL1JH?=
 =?utf-8?B?bjNMYStMNUtvMkRlK0lYNlVoRXdrV0k1Q1lSUHE3bXVTbmRmcTU1U2ZlUkNU?=
 =?utf-8?B?YkIvYVU5ZGxrb3ZUVDhJMDAyZXNJdldZSjAvRzBCWmxZQnlHa3plUzRZMVdH?=
 =?utf-8?B?Z1BJaDc4WTRsc2tkdzEyYm95ZTh3bTkvUkNkdkQ1UmlISXVrZ21PMkMva1dx?=
 =?utf-8?B?QTN4cmlOTXFmdzZDaHh2NmVud2NPQUdlQytxK2hzQ1h0c2t0UTVnVit2VGlE?=
 =?utf-8?B?NStBeDZSUDJaV1RPdGNscC94YUxWbHJDbjFxTUlaRWJjcUlkL3VYaENpZk1G?=
 =?utf-8?B?Qmg3bVlMbnZZbk5zcEwvR1FZWjFDb3hmS0JNcVkza2MxVkFnVW9xVU9IUUZW?=
 =?utf-8?B?cDMwOGNQV1JHT2V1U1l2YysyZmJ2OG52eXc4eE10SGJlcHhrWEdSOEFPVElE?=
 =?utf-8?B?YTlwMjBocG0rUlpMRCt6MnI3RWRVR1JKcXZobXlKb1BYNE9naG1GSnJlMDB5?=
 =?utf-8?B?TUdPTVp5VkIrblZJUHFlekZicCtwSFQ5SEZLempTZUp2Wm5IMmh3dGZyVTAr?=
 =?utf-8?B?b3JxUWlodVo0TTVxallpbHdzWEZHb3E5YWlBNGNiWDlpQW1PSXZ0bCs1VDVW?=
 =?utf-8?B?MEd5YXZWZ0xreHh4dzRmK2RWa3l4Mzk4ZmFXc1ZtSThzMTVBamxtNXp4alNk?=
 =?utf-8?B?bkM2QjJhYnlUZHhJM2c3RmhxbjNHQWFsVkYxRloxQk5uNzdNSHM1ekJWb214?=
 =?utf-8?B?bVlCUnVXRmh2OVphYWxWVjZMQ2Z6WDRTWThvSmN4cnZJNlRiaXp3QzdhR2Fa?=
 =?utf-8?B?QU1nVGIweWY3bnc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad90007-3404-4e8e-f617-08d8bf751bae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2021 08:01:37.1144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIAgfjeV14FbFBAuVnu7sj8XyLTUAf/5LwA/OeUjbRfy900N2WqNBiLrpie4TAWNpiKwIXDtt5ANSN30tJLWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3445
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230043
Cc: aruna.ramakrishna@oracle.com, mst@redhat.com, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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

CgpPbiAxLzIxLzIxIDE6MDAgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gCj4gT24gMjAyMS8xLzIx
IDEzOjAzLCBEb25nbGkgWmhhbmcgd3JvdGU6Cj4+IFRoZSBzaXplIG9mICdzdHJ1Y3Qgdmhvc3Rf
c2NzaScgaXMgb3JkZXItMTAgKH4yLjNNQikuIEl0IG1heSB0YWtlIGxvbmcgdGltZQo+PiBkZWxh
eSBieSBremFsbG9jKCkgdG8gY29tcGFjdCBtZW1vcnkgcGFnZXMgd2hlbiB0aGVyZSBpcyBhIGxh
Y2sgb2YKPj4gaGlnaC1vcmRlciBwYWdlcy4gQXMgYSByZXN1bHQsIHRoZXJlIGlzIGxhdGVuY3kg
dG8gY3JlYXRlIGEgVk0gKHdpdGgKPj4gdmhvc3Qtc2NzaSkgb3IgdG8gaG90YWRkIHZob3N0LXNj
c2ktYmFzZWQgc3RvcmFnZS4KPj4KPj4gVGhlIHByaW9yIGNvbW1pdCA1OTVjYjc1NDk4M2QgKCJ2
aG9zdC9zY3NpOiB1c2Ugdm1hbGxvYyBmb3Igb3JkZXItMTAKPj4gYWxsb2NhdGlvbiIpIHByZWZl
cnMgdG8gZmFsbGJhY2sgb25seSB3aGVuIHJlYWxseSBuZWVkZWQsIHdoaWxlIHRoaXMgcGF0Y2gK
Pj4gY2hhbmdlcyBhbGxvY2F0aW9uIHRvIEdGUF9OT1dBSVQgaW4gb3JkZXIgdG8gYXZvaWQgdGhl
IGRlbGF5IGNhdXNlZCBieQo+PiBtZW1vcnkgcGFnZSBjb21wYWN0Lgo+Pgo+PiBDYzogQXJ1bmEg
UmFtYWtyaXNobmEgPGFydW5hLnJhbWFrcmlzaG5hQG9yYWNsZS5jb20+Cj4+IENjOiBKb2UgSmlu
IDxqb2UuamluQG9yYWNsZS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IERvbmdsaSBaaGFuZyA8ZG9u
Z2xpLnpoYW5nQG9yYWNsZS5jb20+Cj4+IC0tLQo+PiBBbm90aGVyIG9wdGlvbiBpcyB0byByZXdv
cmsgYnkgcmVkdWNpbmcgdGhlIHNpemUgb2YgJ3N0cnVjdCB2aG9zdF9zY3NpJywKPj4gZS5nLiwg
YnkgcmVwbGFjaW5nIGlubGluZSB2aG9zdF9zY3NpLnZxcyB3aXRoIGp1c3QgbWVtb3J5IHBvaW50
ZXJzIHdoaWxlCj4+IGVhY2ggdmhvc3Rfc2NzaS52cXNbaV0gc2hvdWxkIGJlIGFsbG9jYXRlZCBz
ZXBhcmF0ZWx5LiBQbGVhc2UgbGV0IG1lCj4+IGtub3cgaWYgdGhhdCBvcHRpb24gaXMgYmV0dGVy
Lgo+Pgo+PiDCoCBkcml2ZXJzL3Zob3N0L3Njc2kuYyB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3Njc2kuYyBiL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4+IGluZGV4IDRjZTlmMDBh
ZTEwZS4uODVlYWE0ZTg4M2Y0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+
PiArKysgYi9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+PiBAQCAtMTgxNCw3ICsxODE0LDcgQEAgc3Rh
dGljIGludCB2aG9zdF9zY3NpX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0Cj4+IGZp
bGUgKmYpCj4+IMKgwqDCoMKgwqAgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqKnZxczsKPj4gwqDC
oMKgwqDCoCBpbnQgciA9IC1FTk9NRU0sIGk7Cj4+IMKgIC3CoMKgwqAgdnMgPSBremFsbG9jKHNp
emVvZigqdnMpLCBHRlBfS0VSTkVMIHwgX19HRlBfTk9XQVJOIHwKPj4gX19HRlBfUkVUUllfTUFZ
RkFJTCk7Cj4+ICvCoMKgwqAgdnMgPSBremFsbG9jKHNpemVvZigqdnMpLCBHRlBfTk9XQUlUIHwg
X19HRlBfTk9XQVJOKTsKPj4gwqDCoMKgwqDCoCBpZiAoIXZzKSB7Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCB2cyA9IHZ6YWxsb2Moc2l6ZW9mKCp2cykpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KCF2cykKPiAKPiAKPiBDYW4gd2UgdXNlIGt2emFsbG9jPwo+IApUaGFuayB5b3UgdmVyeSBtdWNo
IGZvciB0aGUgc3VnZ2VzdGlvbi4KClRvIHVzZSAnR0ZQX05PV0FJVCcgd2lsbCBhdm9pZCBhbnkg
ZGlyZWN0IGNvbXBhY3QgaW4gX19hbGxvY19wYWdlc19zbG93cGF0aCgpLAp3aGlsZSB0byB1c2Ug
a3Z6YWxsb2MoKSB3aWxsIGp1c3QgYXZvaWQgcmV0cnlpbmcgZGlyZWN0IGNvbXBhY3QgZm9yIG11
bHRpcGxlIHRpbWVzLgoKQWx0aG91Z2ggdGhlIGxhdHRlciB3aWxsIHN0aWxsIGRvIGRpcmVjdCBj
b21wYWN0ICh3aXRob3V0IHJldHJ5KSwgSSB0aGluayBpdCBpcwpiZXR0ZXIgdGhhbiB0aGUgZm9y
bWVyIHVzaW5nIEdGUF9OT1dBSVQuCgpJIHdpbGwgc2VuZCB2MiB3aXRoIGt2emFsbG9jKCkuCgpU
aGFuayB5b3UgdmVyeSBtdWNoIQoKRG9uZ2xpIFpoYW5nCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
