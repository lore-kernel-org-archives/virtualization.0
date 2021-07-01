Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC6FC11F67
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 23:59:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3703613FA
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 23:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3703613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 702DE405F0;
	Thu,  1 Jul 2021 23:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GReP0UfdcRVP; Thu,  1 Jul 2021 23:59:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AEEA405F1;
	Thu,  1 Jul 2021 23:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D51EC001A;
	Thu,  1 Jul 2021 23:59:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F079C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 23:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 577DB60664
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 23:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="JY/kASLy";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="UsTF+J9m"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YLf_79hd6Wml
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 23:59:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 377356065A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 23:59:26 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 161NvMPG017740; Thu, 1 Jul 2021 23:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=12fCPRs/iEnUCy+4VQFt+IQ98olDsSRfNbqXLIn5x00=;
 b=JY/kASLybdN8SA3NXiMWsSYR/DcVnpzyfkItvPLh1H2lask9IpWRwREnL7u/QSg9wJRv
 BUZZjM5jv0Z3rL4LmZ64X/NVkd8UGWEUU6RDzbTsglDmDPUPQQrkpDvq7AtNZQM4dy2E
 Njk83f8VecAAhIS8xgdRUZCAyy9dPzx+WTiY995F9/oRpLHPDWjeqwBiKG/ykP8eR4tZ
 u81JRZ4SfWw7qDSuFKKf1ifY58yWE6sRhmWGFl9fIqJRqjZRVqbTaeDVGh+J0V9ca85R
 7WO5/ytEPOL0axd77S3CFfnktfnQSvXn2WxcpqwONypsLTBHrys2b3YamjkFWWhNAUPb ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 39grmaujjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Jul 2021 23:59:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 161NtxRn117237;
 Thu, 1 Jul 2021 23:59:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
 by aserp3020.oracle.com with ESMTP id 39dv2bg9h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Jul 2021 23:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyY1qcToclvZytnXYHM596/UkuDraExF0/k1oZLWslS19+nsRRYUNim9S6aDDgIOmL9utdTW64JV9GtZ1Wf3nyhLtk8wkXsjvCvW6T9XnhdHDZYTjfuJ5PiA5DpORF2ouRsUOmqBP9dbcN7fX2n5o84NF1mlM0F19IpwoOr2UenF5J8/f93Ek8ke3opMGdMAGkt/cnUNxtOLVy9wu6Qx03LXfCl6kLQZOGJ0u7/y11D0Pp/hVYeqMsNCvMFU6qz9Y7dilCvZK4cJsyIBoFYLmoGa2NSi6Z8Fa9xx/YQWd18hvpJfpTNAhCx0G13lbbaBYDZHv+Bt5R8uTxj55YeKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12fCPRs/iEnUCy+4VQFt+IQ98olDsSRfNbqXLIn5x00=;
 b=jGcRkYkjU7k+60/Z0sF+pJ878HiW+OGUYITJBrspKX/a4NxZtit0RcE8xhTCexX66Z3v0HPS/ad51AiNP/lXvUk9nRdVnERJ83+w7Vl73XHIUuOZmbedTH9UqtTHIa+zxivURzj94MfxCHfdpkmia74ZOA2KPuLCPtIyJC2255RLPsAKK4Qm5hv/89dVYa0AIhsAo3momN0gxgjOjbmGJqdxeZdtLBeAUp0YXg4f26JwPrEHu5m7F9O36jxXSdnmhqG1tNt8GUbu+JIscexQKX1IsjQeiiV3EkjhGoqM/4fmrLj/+V1mOcwuOoY1k0/ak+F/1BhkgFEZ+cqLJMmKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12fCPRs/iEnUCy+4VQFt+IQ98olDsSRfNbqXLIn5x00=;
 b=UsTF+J9mdRSLY6SyHYJ+QgikWSjGDzBhA7TGJYJuMNd7kBBB37Z7Ow/osgBMHqJLYZ2ST+lGj10Lq6b8e29DK5w6St6FaTv6mfhSa4RP7IgyqWxfxra5k7shJrAqC7xpNziJr1jh9vV/cqo4bGgzz8e7EpjodEnjr51GxOSw4lg=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3577.namprd10.prod.outlook.com (2603:10b6:5:152::16)
 by DM6PR10MB2858.namprd10.prod.outlook.com (2603:10b6:5:65::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 23:59:16 +0000
Received: from DM6PR10MB3577.namprd10.prod.outlook.com
 ([fe80::31a2:972b:6d8e:7398]) by DM6PR10MB3577.namprd10.prod.outlook.com
 ([fe80::31a2:972b:6d8e:7398%7]) with mapi id 15.20.4287.024; Thu, 1 Jul 2021
 23:59:16 +0000
Subject: Re: [PATCH 2/3] kernel/fork, cred.c: allow copy_process to take user
From: michael.christie@oracle.com
To: Christian Brauner <christian.brauner@ubuntu.com>
References: <20210624030804.4932-1-michael.christie@oracle.com>
 <20210624030804.4932-3-michael.christie@oracle.com>
 <20210629130450.tvrweqy7z2hlwsbh@wittgenstein>
 <6927dc85-6f8d-c1f5-f92d-9bcd36cce2bb@oracle.com>
Message-ID: <2cbbebab-e9cf-0833-c0de-31eb3ba6cd5e@oracle.com>
Date: Thu, 1 Jul 2021 18:59:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <6927dc85-6f8d-c1f5-f92d-9bcd36cce2bb@oracle.com>
Content-Language: en-US
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:3:9a::29) To DM6PR10MB3577.namprd10.prod.outlook.com
 (2603:10b6:5:152::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [20.15.0.3] (73.88.28.6) by
 DM5PR19CA0043.namprd19.prod.outlook.com (2603:10b6:3:9a::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23 via Frontend Transport; Thu, 1 Jul 2021 23:59:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c459adc-2768-40d1-96e0-08d93cec3b2c
X-MS-TrafficTypeDiagnostic: DM6PR10MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR10MB285885E3DB790681E5A375C8F1009@DM6PR10MB2858.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZfrBaiprb1aXkwRGwosUscknCMjYr5SPWfU5mJ6Ojr50D+u2Vcmuc6sQKW2RLgO660Ec/418gqU3ii6LPgxF5iFyTSurVEfXluVAPl4+26BUcd+3hBdJ7waX2g8D7Q+744JqTh2/PQyd7wwi5tAF8pH7tMWMNCZyaa+G59ZerqW+teG0+w12wS5kNwnYg7MSk2Hof2+HQYTfiT3Tf9UcyJyMUG0rYejrBVqFR5OS86tAgN2vxb+gNF71IA+2WiNW27xPA5vh9K/P6ZfvbuibOiK+S74f8cEk8GDIFsh+zrHI0AHTLYPYgLWvE7sWjUoIhnEpstiO0nqdNclKHmqGRo+LX2GC1cT3mDnwHsUJfgURCTOKXgb1Gc9LATT4M2oqFCGiKGjbTnqHPFousHZrfxMeEPqnhuTZIslVWrtfctthJiVvqU684VwBojdonXxjbVDIDCkSD6nJ8FxSNIpQJDF+LFdi6i27MfSlou6Mzvl0Lf67P528rHp2sLywQVx+XpF+7JdEknbbJrNPwO72rx+yxR/OXAr0MS5VAqcRgIwMTYqGiRyBQY6OnlIOyP/yrALWUS9yMVFHifrlEqPONKMBJaJPJxqHKjpKaMLlDh1njwpXawczfM+0rUB2LpmsByVSPmH063eMdPWtzDjMWicL9IkBkOwskKI1vUt/aL5NZyIcdVnvMbCJZRrfeRrVWL7t0/5JeMWt7g+X26+w2Oi/QVkYgagZN1WvxjZGNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB3577.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(316002)(2906002)(16576012)(36756003)(6916009)(6706004)(38100700002)(16526019)(8936002)(66946007)(9686003)(31686004)(66476007)(8676002)(66556008)(31696002)(5660300002)(53546011)(83380400001)(478600001)(6486002)(4326008)(7416002)(26005)(86362001)(2616005)(186003)(956004)(78286007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBOV3pic3I2NFMwUWg1UmN4eXJocEt2VU9hU0RicE56YUFuZlRtL25oYlhJ?=
 =?utf-8?B?dHZ3eXZrSllNQVd0UEFvY1RVNEFlRmNVUFFob1RCUnBiN2VsMGlUQnZIWlJC?=
 =?utf-8?B?dWY2d2NaU0NTUE82YWl4MmxCZjJ1NTBFMHJza2cwME9RZ2k1QTVVSkJMMnAz?=
 =?utf-8?B?d3FBWHJWVlNKd3NXakxlT01XOEx4SytiL042c0N4Mm1XYjZYbXNtMVllS1N1?=
 =?utf-8?B?blhTWHZwQXdWL01PT0k3bXgxTUJuVHd6c0NIZlJtK01XcElpWHpDZzlaMEFa?=
 =?utf-8?B?YzRPbk40OUlQVjZHNEJUTlpsaHJidHorT0JFVGx6Yk1xU2FkaVdBQ2swWlZk?=
 =?utf-8?B?SWNyREpCdmRIOWg1Tm43ZExQVC9DeUZTaWxyMEhzdmlFNzBuRVFyZnlGNTVD?=
 =?utf-8?B?WTlDdmVsR1ZtdmEvdjJoTGFRQzh2MS9hSFo2K0QwekR6OHVwdFFjV1ZFZUlK?=
 =?utf-8?B?d1JSMkk1NS91ckw2WW5POWoveFoyY0E2bzcyNmtJL0N5Ty81akljRmF6K0k3?=
 =?utf-8?B?dHpHMWRucU1Ic1pwOUZwWExiM29RY1cxTkdCQVZxNXA5bHVKbVU0Q2ZrZDM5?=
 =?utf-8?B?dFFYWXR2dkx0aSswK3FMNFdaclVJZFJCcVVLT3ZMMm5GejcvdHJiQlJ1VGpP?=
 =?utf-8?B?RzBKQnAzUzlHQ002WktVekhXREYzK3Rzd0JONnEwQ1VNVXlZM2NubHlSWnZI?=
 =?utf-8?B?YU5ZRC9SNnZ4Sk1zMjA3czdzMHdXSXpqcllEeWY3UU9lNGRpMEpUeDBYNzVk?=
 =?utf-8?B?V28vYUF5UTRpKzA3RmNoYkU0MWplRkh4VXYxdVdldmlRaGtKVnlKRW5NZDRT?=
 =?utf-8?B?dWlKN0N0ZG1hRDhrV1JkR0hXK0FucmllNXorWTZPQTZXMjRvc05vK1h4aksy?=
 =?utf-8?B?MU9kRnJYQzhTTndBNjYrMEpINlI4dThVSmNVbS9IdDZZWEJ0RXlaOGxHVVR4?=
 =?utf-8?B?dzlCSGJwVWFGSXpTUFpwVTlXT1F5V1JEUEdndnVwa2pFcVQ4RjBvMm5zQlc0?=
 =?utf-8?B?QjFaTXZHVVlXRGMwTXdkSHdQOUZ6dldQSHI5b3FvQVBJVENKcjk0YTlFdkQy?=
 =?utf-8?B?c1FoVi9KT3pyeGp5ajdCSUxnam5SalBlN3kyakc0SGEzazdYbzMrWElPL2My?=
 =?utf-8?B?NTkzc1hNUmVlcGY2V2E4L0FjRDF4UzdWSkZVcXRoVlVaM2NoeUpkMXBISnpL?=
 =?utf-8?B?SzVSazN3ei9iMzY2VXZzRHRZamNoZ0djQ1N5blpTMnp2d29oaHlyeGFqK3ZH?=
 =?utf-8?B?UGRmZ0FuOFZkdEtCai9YaVdJMlBtZU1PSGJ4N3RNYUd0eVIvemhTODlYbHRh?=
 =?utf-8?B?bW9BL0lMdEY2VGpHbUxqTmVtS2IvT0N1UjdCdDZJay8xaGtRNUhwTmZuZjlE?=
 =?utf-8?B?NzN0SzZUZUEyUWFRakxxZktzc214YWl6QUZrTEpzYXVXemZuQ1dVRnVqMm5l?=
 =?utf-8?B?b05rajlLZkFvYWY0eit6UEd2MGwvYXE1NHBGdWZ2MTI5eU1EYmU5aElYT3dF?=
 =?utf-8?B?eVhBMlR1OWRJajIvMHdxbGxqT2FHcUdJcnlVMStqY21JOXRXbjdzNXJiWFRQ?=
 =?utf-8?B?dU1rNEx0MENBUHpVcUIxRzV3RnpYdm5kbk4yYjBmRGJ2bTBtcWlQZFNtT005?=
 =?utf-8?B?SVdoZlhKdUVVclk1USthWTAxcm1ya2NmMVdVN1N6VDd0a3RKM0UwS21Tbi83?=
 =?utf-8?B?SHhnWEZ6MUtITUZ5MmVMQmpMTXd1dnRIemRzVkZVM3gyUzI4NVVTaytINjg5?=
 =?utf-8?Q?NbnOqplIcjLyqIlnn9SwqqvyMkfq5Hb2s4r3YXV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c459adc-2768-40d1-96e0-08d93cec3b2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3577.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 23:59:16.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOqjT6TLiTnuZ/VJSfQmFFBXpp/Tk+f0niWnX3A1JLBSONJwYBvGNROtmnEco+/T2+vCTBZvAfAshvlmNDw+Q9NyCsm6M0WAGdusQ9EmR1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2858
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10032
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107010139
X-Proofpoint-GUID: IXf0dmWglPwdVPOzyCuxmWYGIQ0PGV4a
X-Proofpoint-ORIG-GUID: IXf0dmWglPwdVPOzyCuxmWYGIQ0PGV4a
Cc: mst@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 akpm@linux-foundation.org, christian@brauner.io
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

On 6/29/21 11:53 AM, Mike Christie wrote:
> On 6/29/21 8:04 AM, Christian Brauner wrote:
>> On Wed, Jun 23, 2021 at 10:08:03PM -0500, Mike Christie wrote:
>>> This allows kthread to pass copy_process the user we want to check for the
>>> RLIMIT_NPROC limit for and also charge for the new process. It will be used
>>> by vhost where userspace has that driver create threads but the kthreadd
>>> thread is checked/charged.
>>>
>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>> ---
>>>  include/linux/cred.h |  3 ++-
>>>  kernel/cred.c        |  7 ++++---
>>>  kernel/fork.c        | 12 +++++++-----
>>>  3 files changed, 13 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/cred.h b/include/linux/cred.h
>>> index 14971322e1a0..9a2c1398cdd4 100644
>>> --- a/include/linux/cred.h
>>> +++ b/include/linux/cred.h
>>> @@ -153,7 +153,8 @@ struct cred {
>>>  
>>>  extern void __put_cred(struct cred *);
>>>  extern void exit_creds(struct task_struct *);
>>> -extern int copy_creds(struct task_struct *, unsigned long);
>>> +extern int copy_creds(struct task_struct *, unsigned long,
>>> +		      struct user_struct *);
>>>  extern const struct cred *get_task_cred(struct task_struct *);
>>>  extern struct cred *cred_alloc_blank(void);
>>>  extern struct cred *prepare_creds(void);
>>> diff --git a/kernel/cred.c b/kernel/cred.c
>>> index e1d274cd741b..e006aafa8f05 100644
>>> --- a/kernel/cred.c
>>> +++ b/kernel/cred.c
>>> @@ -330,7 +330,8 @@ struct cred *prepare_exec_creds(void)
>>>   * The new process gets the current process's subjective credentials as its
>>>   * objective and subjective credentials
>>>   */
>>> -int copy_creds(struct task_struct *p, unsigned long clone_flags)
>>> +int copy_creds(struct task_struct *p, unsigned long clone_flags,
>>> +	       struct user_struct *user)
>>>  {
>>>  	struct cred *new;
>>>  	int ret;
>>> @@ -351,7 +352,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>>>  		kdebug("share_creds(%p{%d,%d})",
>>>  		       p->cred, atomic_read(&p->cred->usage),
>>>  		       read_cred_subscribers(p->cred));
>>> -		atomic_inc(&p->cred->user->processes);
>>> +		atomic_inc(&user->processes);
>>
>> Hey Mike,
>>
>> This won't work anymore since this has moved into ucounts. So in v5.14
>> atomic_inc(&p->cred->user->processes);
>> will have been replaced by
>> inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>>
> Will do.
> 
>> From what I can see from your code vhost will always create this kthread
>> for current. So you could e.g. add an internal flag/bitfield entry to
>> struct kernel_clone_args that you can use to tell copy_creds() that you
>> want to charge this thread against current's process limit.
> 
> If I understood you, I don't think a flag/bit will work. When vhost does
> a kthread call we do kthread_create -> __kthread_create_on_node. This creates
> a tmp kthread_create_info struct and adds it to the kthread_create_list list.
> It then wakes up the kthreadd thread. kthreadd will then loop over the list,
> and do the:
> 
> kernel_thread -> kernel_clone -> copy_process ->  copy_creds
> 
> So copy_creds sees current == kthreadd.
> 
> I think I would have to add a task_struct pointer to kernel_clone_args
> and kthread_create_info. If copy_creds sees kernel_clone_args->user_task
> then it would use that.

One question/clarification. For 5.14, I could pass in the struct task_struct
or struct ucounts (in a previous mail I wrote user_struct).

I could also just have vhost.c do inc_rlimit_ucounts and is_ucounts_overlimit
directly.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
