Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF4C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 09:03:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FCC64DF2
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 09:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FCC64DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D60CC871B4;
	Fri, 12 Feb 2021 09:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9dBh9D8H61VQ; Fri, 12 Feb 2021 09:03:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCB51871A5;
	Fri, 12 Feb 2021 09:03:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D1CCC08A1;
	Fri, 12 Feb 2021 09:03:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5359EC0174
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 411A58706D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nR-cV-g2CuSi
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:03:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D4BE5871A5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ2whSrg69UxpzP3kX6DJcOb5ttpZzZ9YGu/YedAR3fFxtDb8hrF46Y80USMKv8vYRWeoFSPZASCZnRMCAg3M/4lpChPR0JdyVmTEshWSWIk0L0nV1xhypOpfJez4w5qUahO3G35jIzOaBIIBH+VGSTM1p+Wy7eWrYHTgHa+CrqYeqHbS22eO58TOGMBMeDphn/KT/IwH8OLgF6WmJiHFkTARJFh0KREZLho61lnGHqbMGBKmdtrI8ewN2G9N9e87gRCGe+ftylm0FV6/UO1dQEuIHkbqGN+qV5lV3NeMzarVCxx5hr1+wyTqSxgiRj+2PBdRU4P7qVxI1mbli4Vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKaWv2POJi4E5OlJm7vcCYOCRPml3K5oYzIOiTebirc=;
 b=E9drSFIvThmAY1FVB+X/P0YNKuywXqtDn+YOK3mrBca4ZS6gzNkHqBNEX/nOLaqaN9HhU1Xxy37UAyYjJxBnLOTNf0kmjeLipksSja5tTB7lXOHxPQBWyqLpkBzfDgod8+R6C/GK0n4nyg4XF10JXAIooSIGI9RgQ9Su9E0lIBiIRCu2Bg7JzS9CCEAzT2FsPM+BjgLBhzrY9Ei/ABb1vwg2NrmDuiTmUxd4WqEybYb+fxIrYg7evLTdvZEmq+7WIeuyEtlk5KvdEuS9SlJjJLFE07Inpjzfe7LF0AB52H9cQ23X3OeRgQP5z9jOETnWz06DNHncPrSdz2oIBN8xTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKaWv2POJi4E5OlJm7vcCYOCRPml3K5oYzIOiTebirc=;
 b=LQbwOiUh4CwV9ut173Kf0TQRpB67D99A9xIotrw047xzG5/SwN0b85tLATnQ8eJzlv89h5Tyd1ZpBNRfoYFtuaLgwNEAdwpB9W4Ca8EfHIia4lDaTJpDCBCP8MojjXRzkIfH3IoGeKYr5EkCJ6h5SgVmSjaVHMDMGbS4ucYAuR4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 08:47:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.027; Fri, 12 Feb 2021
 08:47:55 +0000
Subject: Re: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
 <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
 <8ba4ad64be3546bda9a2ed2129bf98e4@intel.com>
 <20210209084453.5oqepy7zdwtxgrpu@sirius.home.kraxel.org>
 <2ef01dc941684a15a4f30e6239ae42df@intel.com>
 <8ac10b1d-3d64-4e39-42e6-6c65b61f0794@amd.com>
 <fd23d4d08ea84ca3b8a7610a8fb866d5@intel.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e3222c34-31ee-b43e-65b0-6ab01423d52b@amd.com>
Date: Fri, 12 Feb 2021 09:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <fd23d4d08ea84ca3b8a7610a8fb866d5@intel.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:5e65:14a3:85f5:f2bf]
X-ClientProxiedBy: AM0PR02CA0210.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:5e65:14a3:85f5:f2bf]
 (2a02:908:1252:fb60:5e65:14a3:85f5:f2bf) by
 AM0PR02CA0210.eurprd02.prod.outlook.com (2603:10a6:20b:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Fri, 12 Feb 2021 08:47:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee240c9f-b585-42b3-1a2f-08d8cf32e405
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4318B4DF40894B5F0AC4E40E838B9@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZpQklN/AkBzSB68vU5uEOr+DO8woPfY9+K22T4FHGPC80YIPTBmDg9ild/hFptwvuEfaiOpBa7EOhRwb/591VPtuMLYBAq4IfVvBB5TtrQPyA20o1XkncK3V/g2ZjAZ+0vrXDezu4y857wAFx1zPxrR12I/jAjn0Tj0sApl6e/SbL4waQ+quU7ifhLhs5eM6dlXCbYSjICEq8IePf6yjV38xZZssYA9d5h90hPOlbco2EmCVlJu2NdQDGd1oYDMl2A9tQx0aRw2AHnFOGD7z3USgIWg1Z7tIs87rmkekQXpD453VMWUXTU+Q7mwJPWIj2QJ+isN3ds9vYqdEaOA8BjTwnrQtdeG5xa1gpUfwThQHUbkob5Sao+vWfaj3VPKjReodZHUhSgHapW46kJZG6TBrrWU4gPmA4jo6kuo7Jl44bO3hqwYw9V7RUz3nUHylgR5zi+auCUfikoThIi9oQzliGZMEOR/KQ75WFVIimLJ7SjKR2hDGJKh3VrVzbV1Lxx9piakMWoNe6Z0gpF2bPbnBms/QZMPRIu29xsiLyh/zZgQlNdOGyV+tGcIVy0hSLoNO8mvMbDdu8Yhb802c1ck7EUbtecWmCJejWLZd78I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(2616005)(316002)(54906003)(52116002)(110136005)(86362001)(478600001)(36756003)(4326008)(16526019)(186003)(31686004)(66946007)(83380400001)(8676002)(66556008)(66476007)(8936002)(5660300002)(6486002)(2906002)(7416002)(6666004)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T3NIWTBBVGp5WlVRSS9SOVFIZUVjOTR2WjhxMzBFWndrak5ybGNQZlFodk1z?=
 =?utf-8?B?d3EyVlc3algvcGlOMDA2ODkzNE90VCtudE4xT2g0NHlxUUdMdU8zeHEwT29l?=
 =?utf-8?B?bDVybUFIcE4xVUtjRWhIYUdCcnBscU9sMzlwUm9uOTRsYWExcUtYY2wxZERC?=
 =?utf-8?B?dUdKc01rRmxlYUovRVZOazJFMDNWOTBiY0o3L0pjMWk5MGhKZmVNR3hvRUtq?=
 =?utf-8?B?aDFnR1V0ZkNqd0hjNklPQXhKSU1YaytjNEIzSUl3V1A1MSs0WU84VjRuMWNS?=
 =?utf-8?B?Ynp5TjNBS3FmdW1NMVJVd2FwdlExSVJqNytiUGJscnBjVnZRS2ZZMFVra2wv?=
 =?utf-8?B?cytuQUFhNGFmeGpxUTBsZFhyV0MyMXNVUHhsNEx6L00zYmtjdEV5SUZkdnM3?=
 =?utf-8?B?VzF0eE1BVXczNEo0Wno3V3JpbUlORnZIZzN1bEw5RVE0YjJsNDVCdzBJWjdy?=
 =?utf-8?B?QWwrWnVBK0NGTHdlZ1F0eThacTdCa3VzUjFwZHFIdHNjN2k5VVVyM29BNk5O?=
 =?utf-8?B?cUNVUERXTitOeXFzTEo2NlVzK1hiVFZxN3JGQ2Q2NzNQRWdWNDV4bjhONENo?=
 =?utf-8?B?RjlnanhNMUJYSnJSTnJaS3JlaFIxSk5VQUh1b3ZFeTZSejJZT1RqRzFJTUxV?=
 =?utf-8?B?UVV1SjBNeW5FQWdlRlFTd3dNTEJPeG1idU9CT1pKS3NmL3ZrOE14QUdjSERh?=
 =?utf-8?B?VFowa0UxVWtwNHB3NXpRSXl3V2h2WFpwMndHdXdWR0swYkZrUU9YMythd25X?=
 =?utf-8?B?WXVJM1FJYkpQWXpEZEJWYSttVGU0MVVGNTZkWGcxNHNoRWo5UTN6TVdxMU9Q?=
 =?utf-8?B?SjZKWHZ5eXZZWENuZllQVDZBQnE2eGR4NlRMbzRNR3p3MVJDU3BBUU05aGFv?=
 =?utf-8?B?ckJ1VTF1Y1kwcWVMTExsSWtCNGYzMmNWdGs5cnJjZ0lhOHV4WFJtTmlZNmYw?=
 =?utf-8?B?ZHdIL0JJRUFNRWlOdnU1LzBNRkRwYW8vWnhvRnRZSVhlcFEzNTFUelRjZ08z?=
 =?utf-8?B?RlRGcHRncWswbzJjVEtwSjdHdy83WFcyMG0rdGdDejU2aWlYUzRleENGeFFR?=
 =?utf-8?B?dEdYVDk2NVg4WTJMMy8zbXJYOUxMa1VaQytsYytpK21vZElwRnBCNUJUSlk5?=
 =?utf-8?B?YWFIcis3dFlRUkNUMWw4cW53ZVI1UXA5QzkvamdxaElNUmtidGZRUWVHdHJU?=
 =?utf-8?B?SGViYmtGcXFnRSt3cVB6VlplekRHdEsvRVB2RVhiYlNEaE1wOVBRNW9rV1o1?=
 =?utf-8?B?S2lUZ1dvSDBkdmJHbnBTc1RQeFRhdmVLZkNDcVZHcVk1MmdwUE1pbkwxbUxY?=
 =?utf-8?B?bVJXc3JlVldwUXRqM01CMzVYUU5iMkllSmJ4NlVSaFlZYUZzbDJka2ZVc3FH?=
 =?utf-8?B?ZDBmeU8zM0NPbE1BTmZhR0RSSk4zU2NXZitEcWRaelFHZGN6WVZMc2wvc1Vj?=
 =?utf-8?B?K0ltemU1QVAwNWlBS3BKWVhBZGMrb0JoMEE4a2xjV01sUnJDOTB6ZEJGckNO?=
 =?utf-8?B?RnFPU0ltb0xGekdTandqVUp1M1JyYWYrTm9ZS3NUeFBydndIZVVrakUxR2R4?=
 =?utf-8?B?bWY1QUdDVjRJT2JIUVB6QUFIQUQyZWtOY2h1d1VkZHVRUEVBajlKWW5PWU1E?=
 =?utf-8?B?QU1UcXJWek5TVnJYUC8wRE03SnNxOWx2a0hEdWlVSlhFYTZkL3krak9zZHVE?=
 =?utf-8?B?RGVGQVpVaXR2ZXZvS0UzNFRJZlVmQ01PZS9DNHNEMngzZ3VCRFkxTnBNUzk3?=
 =?utf-8?B?R2hrTTlxSHVHdjFLai9XOTlQa2NLVWoyajNyR1R2WnpnZ1IwTHYwTDJEQ042?=
 =?utf-8?B?a2pmNHd4T0hqYlB5VGtnQStaOG5wTk5PeTR4cCtDREVJckFwdXYrdkZETFpD?=
 =?utf-8?Q?zl3W78sbd3IvS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee240c9f-b585-42b3-1a2f-08d8cf32e405
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 08:47:55.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERFuBY4xNulP8rQs13GXjVYd5qk6iGDNqWh1t4hPaR/AYKW5JpH83qfuvVs2OcwN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
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

Hi Vivek,

Am 12.02.21 um 09:36 schrieb Kasireddy, Vivek:
> Hi Christian,
>
>> Hi Vivek,
>>
>>> [Kasireddy, Vivek] What if I do mmap() on the fd followed by mlock()
>>> or mmap() followed by get_user_pages()? If it still fails, would
>>> ioremapping the device memory and poking at the backing storage be an
>>> option? Or, if I bind the passthrough'd GPU device to vfio-pci and tap
>>> into the memory region associated with the device memory, can it be made to work?
>> get_user_pages() is not allowed on mmaped DMA-bufs in the first place.
>>
>> Daniel is currently adding code to make sure that this is never ever used.
>>
>>> And, I noticed that for PFNs that do not have valid struct page
>>> associated with it, KVM does a memremap() to access/map them. Is this an option?
>> No, even for system memory which has a valid struct page touching it when it is part of a
>> DMA-buf is illegal since the reference count and mapping fields in struct page might be
>> used for something different.
>>
>> Keep in mind that struct page is a heavily overloaded structure for different use cases. You
>> can't just use it for a different use case than what the owner of the page has intended it.
> [Kasireddy, Vivek] What is your recommended/acceptable way for doing what I am trying to
> do?

I'm not an expert on virtualisation, but Gerd seems to have a couple of 
ideas of how to get this working.

In general I think it is pretty much impossible to export stuff from the 
guest to the host by DMA-buf.

This is because of the fundamental concept of DMA-buf that the exporter 
needs to setup mappings (both CPU page tables as well as stuff like 
IOMMU). When the guest exports something it would mean that you give the 
guest control over the IOMMU and/or host page tables. And that is not 
something you can do as far as I can see.

You can only export stuff the other way around so that the host is 
providing the memory and the guest is consuming it. If I understand it 
correctly that's exactly what Gerd is suggesting here.

Regards,
Christian.

>
> Thanks,
> Vivek
>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Vivek
>>>> take care,
>>>>     Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
