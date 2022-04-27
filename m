Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531A9C43219
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 14:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D63D84014C;
	Wed, 27 Apr 2022 14:10:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0RGFZT9kAPmi; Wed, 27 Apr 2022 14:10:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28359404D0;
	Wed, 27 Apr 2022 14:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02385C0039;
	Wed, 27 Apr 2022 14:10:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8D14C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF264419E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D3NZ4v3ZRx52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:10:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40575419E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGq4qouSjKepHTDgmrScIM8Y2w3aipkAzgEhWtZboeAC/qvuNF73gb2uUuIi8QmtB5Q6RNpDsiJdImHmv/fj/RhahI/nC3p37JIFob31QDkVboho9TsXUmXBj3bVWFl93jBVUt+UEG4wFN+6V1W/6s0MWpxpFFpCVONRpc71150Z24dbfMti5DhiNoFFew4ims3vFtd9qnp7kCZD8t6yhdSo47AUdcx8AR4o4eO3E2AkY+w+VUZLXRBHw7U/oUnp6IQXh8167DNRoJ+tlh7Ha/u+lRi8APyaUWJeyGLSM4BErcIqQa14TtYMB80G5EZQOVOi1k/jVliasQOwC8T2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiQKMgHKfWwR2IuJOkUtq3i/GbNxbvccwSVvcoxnB90=;
 b=hD5gH+8wpxbeJ7fAvvHDpnuOZKa5tYrILwPGppSlz8ZEXI6ud54UuyCOIq84ScFp0PZ5Cz74ldl7aOlKTdacrRxUmYat8/2KdHajhgbQ1YiiVnWVkOld6e+ZbL+Bz63yw/XGNM2JE2g4UaSVgEYV2XpsBgxsFBLhhSgtfynP98CQbwVCaQSE9ovSOlnxrAh1I32KrD49y9oLyYVIFKP9/0j7ebL1MJcx8ziC8T4GLaKEkBOKt0E1/4BEwkPlLdznDwf0mXJMOavGgoACy5QT+B4hrnjEGPfOymA+Mp/qtwBRM0ju8vV3J/jbkzLJ3sJ3SbGSQXQVNtN3EO1WWE8xBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiQKMgHKfWwR2IuJOkUtq3i/GbNxbvccwSVvcoxnB90=;
 b=dJJEZH0bdurHGLM7Byk0bLVo3NJe0lI3c6BxiRox9fKEeqQCpTxMXqFHq6Xp0WeWeEnEHt1HzRg/c5tB9Ht1pZz0c5sG4f1T0GRy2Bh3k2SWFZtyf75/VrNvtwV3jUVlFyay2JlRB7LEi5nHEwcz99kskLbwx1n/vdQM5ogluho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB3118.namprd12.prod.outlook.com (2603:10b6:208:c6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 14:09:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 14:09:58 +0000
Message-ID: <c959d3ea-1187-3e88-287b-27e75f0225e8@amd.com>
Date: Wed, 27 Apr 2022 09:09:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Content-Language: en-US
To: Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
 <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
In-Reply-To: <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
X-ClientProxiedBy: MN2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:208:120::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76156ede-2110-476c-088f-08da28579cd2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3118:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31182DFD31BE471FDEC6F4C7ECFA9@MN2PR12MB3118.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 267Du0EWzGz4w1LzxZHJD7O4owB0RLnMBp0dx7a1P7/6gBFKQVAAusNK5fRTLNkpIGXy0h4Po70l26fcO+4UrBC6NrwklrVhWql3oFUwvL452w4Nk+oOJ2t3OWLmvUB2Y5ICzQuqd3/JJdu1SjdvFRb+OVe13e6cFn1zMcZFlAYFs3vqaMotfm9iPRU337iM2n00mw7/Cl/2BRj8Y9JShwUkQU6NGmDKVBCWZ0QGq5tV4u+ErDgC9oYPWJe7tyASf11GQTZUrjbclyI24D5Osb2iHNJkdvsw6oUvjn4/O3TMkPBOOrs1JYo61NpPEyzdSyu/1Nr2b0DC1epEUqVCzrDhZZdSfO7zDXAufRNMR1jJ0HB0Zo+9jDtaO5WoO/DfJJy9VpAc19eKCB/5PFIFAwz8fY/Tz1yE8h23Lk3VjtHdMJ7aOUglwo8ZHnJMHRRtI8VsACvyxsjtKI0lYNIt7fBuJhT7k253UeIQtXTXUrL7qAenMf/8SB323WBTvwlgA3m7zGL34tj63ddzGOqjyeYY+dPi6cD1z3dQC+GTBUe4/ibDIbGt1iDnLxXLhV11Ic4m+iArDNjNWlWzS3wAAjMF4ti7Kg/fq2VfduDmXWhWrUm76xG1q2N3iKnWf+B8fl+D5f/mWP/Pw4/dGPsJYxVnMWUV4h1cPTUrKynVkaxIwfcizJL70U/2V0AIDq6PfpVq+R0bIr2Rucj3xpZw4PKnSbjDH44zGtY+HIaH2Dn/3Jje1oAzNnNAMfPotFdQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(186003)(8936002)(36756003)(6486002)(316002)(83380400001)(2616005)(66556008)(66476007)(31686004)(53546011)(6666004)(2906002)(38100700002)(54906003)(7416002)(31696002)(86362001)(26005)(110136005)(6506007)(8676002)(4326008)(6512007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldiV3E1QkdtdzcwNzdsT0ljekxkeE4wcTRyZEZFQURzL0xzbmkvSzE1ME8x?=
 =?utf-8?B?NmErR3dQblYrYWd4bThWeWlTRS8yZUlNd3RJNGRhZFhmVnVjYTh3SVpCVm5h?=
 =?utf-8?B?N0M1TkFhS3NFSUNzc1NOUjdYdmNMWFVhcmxBRDIrTHdDTVpaVytmYVpvQVhk?=
 =?utf-8?B?NVdRWTBqOTVwSmF2N2pBcm1PNHdJdHRna3p5NjBqVWZVYWxHa1VxOU51enkv?=
 =?utf-8?B?NmVjVzZabHVpUFMvQ3laRzg5WFpleDRCZjloaVBZS3RWZXVnVmZLTUN3bDJV?=
 =?utf-8?B?d1NNV1Fnd1VydFBGUStHQmE1UDF5aktRMGVuQWR1bmdxQ1pmOHRKcVgxYVoz?=
 =?utf-8?B?VWZSYVNwdGtpK2RhQXZjSHV0QThjMnhHcDN0eUk2RFRGeisyaG5lb3JZQldO?=
 =?utf-8?B?eVdKSkhWdFlZMU16TmM5Q3lqQmJ0SE8xbHVPazc1aWM2WWNhazRxNzNkY0V2?=
 =?utf-8?B?ejFlYm5SNE1uZTYrR2NvK1dERFB5a2hUZFZnTU56Ry93MUNBWnZ0bDczV2Yv?=
 =?utf-8?B?NHJDN2J1SXV4ZXJLT3lIdnhUZHYyV01jbzlaZXIrTUtFbStyWUZhYmYvWUsz?=
 =?utf-8?B?WHdjV093U2gzWVUwQm45VStrWHQ2SVltbnZDbGYyU0NjNVNxZEY0MmhrVXQy?=
 =?utf-8?B?bWViUVNyWDhzRU4yRTl6TXVEVXh5b3VabXB5cFcwSm5NRzY0aFZlWmczRVpn?=
 =?utf-8?B?elVRNWpnaGw2THBPSzZLWlFYUGZnS0hHTHFHWGYyYXlDQTU1cDFibW00aVJh?=
 =?utf-8?B?L1VBTkNWTUtPc1pqYnZJWGM2akV3c3hTRXNkVG84em1iVFIvTjFZMEdMdjB0?=
 =?utf-8?B?SlJBOTlwUzBIS3Y3a2YyNUZ0NWVhRWFSN1ZPY1BiVmpja1dnM0pTWXpNK3dC?=
 =?utf-8?B?dkErR1UwSGdwWG1lVVJIQmFGZHg2YUpsNFJpaGlBak80MEROVHZGTHJLWUxD?=
 =?utf-8?B?c3I2OWVwTVdkSXBoVFhJbHRNQWtUdTVubyt2Y2dkOUM5dGVMWFJXeTFtMkRY?=
 =?utf-8?B?RXpVVnN0OGNlSmJWSGNaYmlqNUpBaEgweG1mQVd0SkdjVE1udysvc3NUMk1E?=
 =?utf-8?B?czllVkJGblNDdnhsbmFsV2NDaytFS1NoZ0QzVHpucHd0YUV1Z3FtdTJxbnJv?=
 =?utf-8?B?MStBTEZndzJ5MWtDSFNQM1prdzZaeUx6SzRwZlRuQithOHVXNHlTUFFtSXFh?=
 =?utf-8?B?a3lwa2tQZGsycElQMGl5L25hOFQvRVBJOGR4ZS9MMzNuWS9xUEg2QWFuSkdW?=
 =?utf-8?B?cFdreHRZZStsZmk5cmxmalJaenhCK01tZFpETldWOXdYbThESXFEdWR0YVV5?=
 =?utf-8?B?Tm9Na3hXK1RwczRnYnhPdlJWQjNVTlhMdWlsaUlkS2xoVW53U3RMQTBIenhl?=
 =?utf-8?B?dS9UWTJidGkvYXVrdzI4WUF6b0FkaElyWG51Q2liMkI5aXJhMnNLblJPenVs?=
 =?utf-8?B?ZjdrajdKajB1aVpjc1ZtYmNmOTg4VGdUUUlFSS9LL0szN3VEUkVzTnB6MUZY?=
 =?utf-8?B?VGpDOWFQeWd1elBqMXMrTzQ1SFh0NnNvMDdJZnJTeHBNbVNMVEprQnRsMmxT?=
 =?utf-8?B?T2tiSVZrSmxWQkFncVBDR3dDTEsyUk1sdmhFQ2s3MWlRb2dBMlFsS2Z2MGN4?=
 =?utf-8?B?RFNubFpkVzJtMlZKaWtjRmF6bWdCbHQyMXJwVnRhQmxrR1lZN2FwR2xzeGR4?=
 =?utf-8?B?S1VxKzhaeE5OQ1VNZnZ3T04wbGVQcDZldU1wZWR0KzZ5dDdQTmNubnY2aEJX?=
 =?utf-8?B?RDY0TnVLTmIrVjdKTEdPRkVVc0FtSGVRc3Mvb1BUL1phUk5uYjRnTFM5NnMz?=
 =?utf-8?B?V0JwVWFpSjBOMVkxYitwSnFUeXJPaHN4cVBHUFJsZXQ1MGcyZHZYUU1CSFN0?=
 =?utf-8?B?VUFYdE1la295WUoxNE9TakhzNGdmYjFHMFpVMnRRTXJXUG8yN0ZwdlU4RTIy?=
 =?utf-8?B?ZUpHbk1KZWdHMjN5ekNOV3VzR3NCbmZiVElRTlg3NWFpZjJIbThLLzFwUkdl?=
 =?utf-8?B?QndUMWdkTFhNaTdZQUt2NzB3SnNLOEcwUGpCZmxma0NIM1ZPVnNhV052bStC?=
 =?utf-8?B?L05scnRmL3RQajFqUHo1OGdEN3BMSzRhbS9hL2d4bzA4TXpLdk0wankvaDFN?=
 =?utf-8?B?OHd2bFJGMFFweUsvNDJoZWYzZ2FMTzFQMWMraGgvWW8rRkJodlU4cWw2M2M0?=
 =?utf-8?B?UklYRm56Z2ovMW9FSi9qT0FSSndsdWNPSFcxVWlUZWNDdnkrdWhFUTI0akVn?=
 =?utf-8?B?dmpsUEVwbnI4MXd2WTVveHIyNVg0a1RGSzhtbVlqVitiVE5EckY1SDhlcUN1?=
 =?utf-8?B?bUwzNlU3NGR0WG0raDhFQ2JucHdDYUdaSE03bmwvYzBHWlQya3JsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76156ede-2110-476c-088f-08da28579cd2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 14:09:58.6979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1f2EgLdqJKQXQxH9kLGyqHC1IIoBdf7fcvVZRnIGHk3pYJ94mwD75Rx7z1yz8VsSgrDIJoRdtzmeWXbTcBV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3118
Cc: linux-hyperv@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, Dexuan Cui <decui@microsoft.com>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>
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
From: Tom Lendacky via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNC8yNy8yMiAwNzozNywgSnVlcmdlbiBHcm9zcyB3cm90ZToKPiBPbiAyNy4wNC4yMiAxNDoy
OCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOgo+PiBPbiBXZWQsIEFwciAyNywgMjAyMiBhdCAwODoz
NzozMUFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOgo+Pj4gT24gMjYuMDQuMjIgMTk6MzUs
IEJvcmlzbGF2IFBldGtvdiB3cm90ZToKPj4+PiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwMzo0
MDoyMVBNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOgo+Pj4+PiDCoMKgIC8qIHByb3RlY3Rl
ZCB2aXJ0dWFsaXphdGlvbiAqLwo+Pj4+PiDCoMKgIHN0YXRpYyB2b2lkIHB2X2luaXQodm9pZCkK
Pj4+Pj4gwqDCoCB7Cj4+Pj4+IMKgwqDCoMKgwqDCoCBpZiAoIWlzX3Byb3RfdmlydF9ndWVzdCgp
KQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+Pj4+ICvCoMKgwqAgcGxhdGZv
cm1fc2V0X2ZlYXR1cmUoUExBVEZPUk1fVklSVElPX1JFU1RSSUNURURfTUVNX0FDQ0VTUyk7Cj4+
Pj4KPj4+PiBLaW5kYSBsb25nLWlzaCBmb3IgbXkgdGFzdGUuIEknbGwgcHJvYmFibHkgY2FsbCBp
dDoKPj4+Pgo+Pj4+IMKgwqDCoMKgcGxhdGZvcm1fc2V0KCkKPj4+Pgo+Pj4+IGFzIGl0IGlzIGlt
cGxpY2l0IHRoYXQgaXQgc2V0cyBhIGZlYXR1cmUgYml0Lgo+Pj4KPj4+IE9rYXksIGZpbmUgd2l0
aCBtZS4KPj4+Cj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0
X2lkZW50aXR5LmMgCj4+Pj4+IGIvYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYwo+
Pj4+PiBpbmRleCBiNDNiYzI0ZDJiYjYuLjYwNDNiYTZjZDE3ZCAxMDA2NDQKPj4+Pj4gLS0tIGEv
YXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYwo+Pj4+PiArKysgYi9hcmNoL3g4Ni9t
bS9tZW1fZW5jcnlwdF9pZGVudGl0eS5jCj4+Pj4+IEBAIC00MCw2ICs0MCw3IEBACj4+Pj4+IMKg
wqAgI2luY2x1ZGUgPGxpbnV4L21tLmg+Cj4+Pj4+IMKgwqAgI2luY2x1ZGUgPGxpbnV4L21lbV9l
bmNyeXB0Lmg+Cj4+Pj4+IMKgwqAgI2luY2x1ZGUgPGxpbnV4L2NjX3BsYXRmb3JtLmg+Cj4+Pj4+
ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm0tZmVhdHVyZS5oPgo+Pj4+PiDCoMKgICNpbmNsdWRl
IDxhc20vc2V0dXAuaD4KPj4+Pj4gwqDCoCAjaW5jbHVkZSA8YXNtL3NlY3Rpb25zLmg+Cj4+Pj4+
IEBAIC01NjYsNiArNTY3LDEwIEBAIHZvaWQgX19pbml0IHNtZV9lbmFibGUoc3RydWN0IGJvb3Rf
cGFyYW1zICpicCkKPj4+Pj4gwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qIFNFViBzdGF0ZSBjYW5ub3QgYmUgY29udHJvbGxlZCBieSBhIGNvbW1hbmQg
bGluZSBvcHRpb24gKi8KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21lX21lX21hc2sgPSBt
ZV9tYXNrOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBTZXQgcmVzdHJpY3RlZCBt
ZW1vcnkgYWNjZXNzIGZvciB2aXJ0aW8uICovCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBwbGF0Zm9y
bV9zZXRfZmVhdHVyZShQTEFURk9STV9WSVJUSU9fUkVTVFJJQ1RFRF9NRU1fQUNDRVNTKTsKClRo
aXMgaXMgd2F5IGVhcmx5IGluIHRoZSBib290LCBidXQgaXQgYXBwZWFycyB0aGF0IG1hcmtpbmcg
dGhlIHBsYXRmb3JtIApmZWF0dXJlIGJpdG1hcCBhcyBfX3JlYWRfbW9zdGx5IHB1dHMgdGhpcyBp
biB0aGUgLmRhdGEgc2VjdGlvbiwgc28gYXZvaWRzIAp0aGUgaXNzdWUgb2YgYnNzIGJlaW5nIGNs
ZWFyZWQuCgpURFggc3VwcG9ydCBhbHNvIHVzZXMgdGhlIGFyY2hfaGFzX3Jlc3RyaWN0ZWRfdmly
dGlvX21lbW9yeV9hY2Nlc3MoKSAKZnVuY3Rpb24gYW5kIHdpbGwgbmVlZCB0byBiZSB1cGRhdGVk
LgoKU2VlbXMgbGlrZSBhIGxvdCBvZiBjaGFuZ2VzLCBJIGp1c3Qgd29uZGVyIGlmIHRoZSB0aGUg
YXJjaF9oYXMuLi4oKSAKZnVuY3Rpb24gY291bGRuJ3QgYmUgdXBkYXRlZCB0byBhbHNvIGluY2x1
ZGUgYSBYZW4gY2hlY2s/CgpUaGFua3MsClRvbQoKPj4+Pgo+Pj4+IEh1aCwgd2hhdCBkb2VzIHRo
YXQgaGF2ZSB0byBkbyB3aXRoIFNNRT8KPj4+Cj4+PiBJIHBpY2tlZCB0aGUgZnVuY3Rpb24gd2hl
cmUgc2V2X3N0YXR1cyBpcyBiZWluZyBzZXQsIGFzIHRoaXMgc2VlbWVkIHRvIGJlCj4+PiB0aGUg
Y29ycmVjdCBwbGFjZSB0byBzZXQgdGhlIGZlYXR1cmUgYml0Lgo+Pgo+PiBXaGF0IEkgZG9uJ3Qg
dW5kZXJzdGFuZCBpcyB3aGF0IGRvZXMgcmVzdHJpY3RlZCBtZW1vcnkgYWNjZXNzIGhhdmUgdG8g
ZG8KPj4gd2l0aCBBTUQgU0VWIGFuZCBob3cgZG9lcyBwbGF5IHRvZ2V0aGVyIHdpdGggd2hhdCB5
b3UgZ3V5cyBhcmUgdHJ5aW5nIHRvCj4+IGRvPwo+Pgo+PiBUaGUgYmlnIHBpY3R1cmUgcGxzLgo+
IAo+IEFoLCBva2F5Lgo+IAo+IEZvciBzdXBwb3J0IG9mIHZpcnRpbyB3aXRoIFhlbiB3ZSB3YW50
IHRvIG5vdCBvbmx5IHN1cHBvcnQgdGhlIHZpcnRpbwo+IGRldmljZXMgbGlrZSBLVk0sIGJ1dCB1
c2UgZ3JhbnRzIGZvciBsZXR0aW5nIHRoZSBndWVzdCBkZWNpZGUgd2hpY2gKPiBwYWdlcyBhcmUg
YWxsb3dlZCB0byBiZSBtYXBwZWQgYnkgdGhlIGJhY2tlbmQgKGRvbTApLgo+IAo+IEluc3RlYWQg
b2YgcGh5c2ljYWwgZ3Vlc3QgYWRkcmVzc2VzIHRoZSBndWVzdCB3aWxsIHVzZSBncmFudC1pZHMg
KHBsdXMKPiBvZmZzZXQpLiBJbiBvcmRlciB0byBiZSBhYmxlIHRvIGhhbmRsZSB0aGlzIGF0IHRo
ZSBiYXNpYyB2aXJ0aW8gbGV2ZWwKPiBpbnN0ZWFkIG9mIHRoZSBzaW5nbGUgdmlydGlvIGRldmlj
ZSBkcml2ZXJzLCB3ZSBuZWVkIHRvIHVzZSBkZWRpY2F0ZWQKPiBkbWEtb3BzLiBBbmQgdGhvc2Ug
d2lsbCBiZSB1c2VkIGJ5IHZpcnRpbyBvbmx5LCBpZiB0aGUgInJlc3RyaWN0ZWQKPiB2aXJ0aW8g
bWVtb3J5IHJlcXVlc3QiIGZsYWcgaXMgc2V0LCB3aGljaCBpcyB1c2VkIGJ5IFNFViwgdG9vLiBJ
biBvcmRlcgo+IHRvIGxldCB2aXJ0aW8gc2V0IHRoaXMgZmxhZywgd2UgbmVlZCBhIHdheSB0byBj
b21tdW5pY2F0ZSB0byB2aXJ0aW8KPiB0aGF0IHRoZSBydW5uaW5nIHN5c3RlbSBpcyBlaXRoZXIg
YSBTRVYgZ3Vlc3Qgb3IgYSBYZW4gZ3Vlc3QuCj4gCj4gSFRILAo+IAo+IAo+IEp1ZXJnZW4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
