Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EBEC6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 16:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2617340901;
	Tue, 25 Apr 2023 16:21:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2617340901
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CQZ4AVEK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JuE2i0r5NifU; Tue, 25 Apr 2023 16:21:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7C594400D2;
	Tue, 25 Apr 2023 16:21:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C594400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E905C0036;
	Tue, 25 Apr 2023 16:21:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD472C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 16:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90FB382023
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 16:21:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90FB382023
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CQZ4AVEK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TUqTsxwueRF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 16:21:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAD798201C
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::625])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAD798201C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 16:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IogN4t1DRwoZVqeCTgLb3ec7XdVaLZ3nTKCPeA4AY0bZGrjVMHhfIBC73J0CFZvuzgexcSfAm9Q9jrAXgdF8k0DmCD5QJGJSJnXhBBkojTzxmUjjvYRYn/ymdp+CdtNHpn4ii5GZzMKvlOL4YOXrSBcvu+/pEv6o5iyvFnr6oqyOMBG6onZF4bFqyb5UXvZXZOyeQb3466ofGthukSL1F1N9KdPVDH/WJVEKLNBXJ00nI81xpenCviPrKJcD2M1oHHGIpCWzisfLQTphHaWWs0h8jFxi3tuuUJS5IlT8XpCispwG5qfHUJsxDVnX5h++OMJPt0jOPZmVQ5VBlG2ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pkrVI61aGZ80nvFU3fxD4CmVvsh3M0YdQ3wFBoN+ig=;
 b=lYajqfWH3qkfM5ahCOmkAl3IGllyX3JuL4DQrXGZM55rrjj3csxC6MbZ222pKbojenarcmdIKlqdz0bHzCUwqahCQ7dJvlwMUeG3drrnXQEH1OisxbVQXWjobeQF+cKNFI2x/2WP3In1dWncfigrUjdA2a7B65m/jNIRwnkToQWQtpChnwUIacFpp7IGS5lrcUAZgPULY71CWTisy4+fuh1swTOTl1c5KCw8NMS4I3Boh84gXnbudEiAA21Elav0D5Cr6lloVK+gk3vZq2h9XH/0QCk58Yf3zRWiFdSXjItdWIkV9ARVHum5vDdoEjNfm8JM9y7PqnpdM02UnjK7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pkrVI61aGZ80nvFU3fxD4CmVvsh3M0YdQ3wFBoN+ig=;
 b=CQZ4AVEK6BdHDlq9UkzUVOjYBUlwt8NCyu42SoTffGWdvtTH3dbxXJ9JiokPzqRCzrpcSGwNNPnNTlXiuUV8YkKe5U1qN3VUvov3qcSKFI0/bu955Gb+ILk4RoqVI12I1h4NMvTUUfd/aKo5Fn3TbNNCSwhoI6U6edDv0vdgbqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Tue, 25 Apr 2023 16:21:48 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 16:21:48 +0000
Message-ID: <bcce1faa-5539-6388-8816-d9e0a4248061@amd.com>
Date: Tue, 25 Apr 2023 09:21:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] vhost_vdpa: better PACKED support
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230425020807-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425020807-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: fc069f36-a1c5-40af-a097-08db45a92b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DjDGWwUu8VNZRXkUb1BSaDHO9G0a7vjdm6773fVHaS5tNN8y2G1OEONlUSBNgzmuXywE8a6hyjyQbY6jHtJY1RHW3oWsyZK4F/EjaYop1zeqf22XH4jBk3zGqJwZIXlEVMdSABZVx1f8+9Tk6jf/s4NBQnJdk2+63DZLpULnLjPGoF9esDqANRp1tpgxae1EG8LJOHBZKfiEZZgE0Bt5o7d+6wtdzEucEZxPQBuZ8v1uK6PclWMhLc2Sg5j5Z8IKWgvyly8lnf1SyvGppBuNVbRXML2Z6++A/7MkosOiFmiM4C44gU+ASUFdBpj5yYPQW2RA73zMaC1wp26iNssuU8OxJkX6wRZUGMQJs1CySStxWzRx/GzHCCBCdOqPRKbFlaKiVwtsF5v1jBWWBf1x11ycnmZR8A/zPi9gVorffHxGlu7vxCICw4XGI6VwIwTJGj9lT7bA0HlI4ZetY34i1WUtB1r/e3hqsuOkFIbJnNX8pFqDSjPpm7gb8qYSKUIsJLun5Wb+aYDrH7yPQesSt6C34jgMn2+xOxqmQAU4PCFCdXn1ejUYFRNmFMRFQ1MMADSqotR7ocnXdE/XogzWvqF6Odf2cogjZez19829C0yn5SbQ/8IUQqLC7NwcY9R7SIudzjYbqlC/qLYEkSJlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(966005)(38100700002)(6506007)(53546011)(6512007)(26005)(186003)(2616005)(83380400001)(8936002)(44832011)(2906002)(8676002)(5660300002)(36756003)(478600001)(6486002)(316002)(6666004)(4326008)(6916009)(66556008)(41300700001)(66946007)(86362001)(66476007)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEZQQkM1WUVnRUVoNmF6Zk5oTmJESEpBZHNwQXFodjBPK1RWUkgzTVFrRUwv?=
 =?utf-8?B?US9xMkF1VnlVVkZXYy9qWXJmY2Y0Y0Q5L2orNi94c3NUSkU5dVZQMjR0TFYr?=
 =?utf-8?B?SFZXZkR4VTBNc0lSUHN1SmNsUmFxTjZUa1V5S05UVU1GRVJXK1d1eEJPWmdK?=
 =?utf-8?B?VGFNOXVXbXVrMlFjZWVNZ1gzN3A0MHptVkVxdTBsYW5TM1RHVGx4dFEvY3Vu?=
 =?utf-8?B?NC8xSVZEUElKSTJQYjNPU1ljWXhCM3ZTd2hyWnRac0pjci82djdPNEJJTWQz?=
 =?utf-8?B?L0lQVit5L0pEeVNNZ1YwUDM3UHZNd2hkR2M2cHVEaDkwVVpidE02NUFTYXlC?=
 =?utf-8?B?YUlBU2xaNjlsdXV0dU9jdStieEdmTGkvN01BSlllRk02RGxmbk9obTFINmZO?=
 =?utf-8?B?Uk1ZcHdaY2lzQVFIdWlWeWNtOTZLaUgrazBURFBMeTU3QjRacWZVZkVWMEh1?=
 =?utf-8?B?RUxGTXBHbytQaW1kQlhzL3pxZC9NS2l2cmJNbnhZSDlncVVwU045MmpvbWd2?=
 =?utf-8?B?MEtQVVJ1WHl6am5OVkN5dWFEREFNSldGRTdGLzZ5VTRJSm5abDF6MTM0TVF1?=
 =?utf-8?B?VjF3UUtoT3pPL2FVdWRlbkUzeUVMWHRTS2lFUy9UK2dlU3ZOT2FnanczNzF5?=
 =?utf-8?B?M2RsV0hGa0N1T2NRQlRNWmtXNXQ1MFJiTGVHOEszOTRsUGR0TTdRVExOS2FI?=
 =?utf-8?B?dVdiZnR3d1hoV3p3N0lCd0RkUzIwdUdFRUgyQ3R5eEQ3bUo2Vk1XOUZSMGJu?=
 =?utf-8?B?QWVqbWhYZFczVU9IQXdJNDlaNjhZM3VlSmlVTEhGQlVsS3lNdDFSSXFxTmgz?=
 =?utf-8?B?VGdvV010dW5JQmxWSWVhS0ZEWVFmTEsvcVNaU0c1L1R0Zm5oM1J1bllvR0lk?=
 =?utf-8?B?V0xNeURpQ0tLRVZ3QndHWDZzZ1ZRWGJMekIyemREVUZrODdQVStPeXcrYmRl?=
 =?utf-8?B?SWhXNXVaMythR2JCbTRLYmJlUENqS1BIbnJ6dVJDZkFkY1VnTnJzQU9IbFBT?=
 =?utf-8?B?bGpqclFEaXlieGJFeVRGT0tKaTBON0R6WE03a2xNZU9iOG5xOGtOU0FuZzln?=
 =?utf-8?B?REdRZUZ0K0QrTzdRakxORy81WHNQT0N4QWpzRkU0WHBWTFFkdW1XVFZpUCs4?=
 =?utf-8?B?RUtldFdTYU80VkswSXhTNkNWcmxlazJrWXlaRHc5MTFWL28wcjhyT0RUTmdi?=
 =?utf-8?B?TlNJb2pvVWRTUlR0WUNIZGRLZWZXblRLS0dPVUgyYUdhaXZoU1N4MFA0RjN5?=
 =?utf-8?B?UWN2dzRZdlhmckxmS1YwZ1p4ZTNwRlY5VUFQMXhCN1ZrNzdoZlJac25iaEJ5?=
 =?utf-8?B?L3hoY05ia1RITWdvQmpHYWgrNWVFZW1jWEJ3dEFFYUMvNFlLL2xJbUNLNVNw?=
 =?utf-8?B?eE9iVEZlWk40aFdQMmVQei9JSTdjUWUzNTI3aVJvMitSS054OThsN090dXFi?=
 =?utf-8?B?SVVtRTlNV2NSVGVFZ1ZOMndqMlNoMC9tTU4zaHh1VVY0SUcrandlb3NYa0FL?=
 =?utf-8?B?bWRWWkRDU21xVm5mTGJQNmlIVU9TNHBkTUJ1QmdUQ09XNHd5WVhZZHpKMEJs?=
 =?utf-8?B?eDRMbzhEWmZTZTEzRGZGTll4WVFPdkNScTQvd1JESmprUStwSE0yUTVteWtG?=
 =?utf-8?B?ajFNd1FrKzFEdWNITkNWWWszMTNaM1FxY3oyRm1kS0hRenA5Tm54eUpORlpN?=
 =?utf-8?B?VGdzSGNjWVR3Y0c1R3o1MFE2bHhacjlkOUJrVHJlcSsyZmlnMno2bllTNFFS?=
 =?utf-8?B?bnFOSStObE14b0k3UGZmN1dkdWdIR3NYYUdITTV2UFp0SEV6enNZdFQybkZT?=
 =?utf-8?B?T2MzN2VzMDhnMDNGeUlEeHduVEM1QURwY25CdlJCWHF1Y3FtWW5xRElBZkFa?=
 =?utf-8?B?RkRSZU5ZdW1nQ3RUWHl4c1lCR3RyZWxJSHdsRHp0QzFzS2FUMFRqdmxoQkht?=
 =?utf-8?B?R0MzR1RibVJzb0V0VDhXaUdyd0hRNXdjOGtoTENZRnFyakRrOG5WQm04UFUv?=
 =?utf-8?B?alNodXlqL1g1TXVRR1kyd041SWxPTHFLSHlsSEFLL1lVeHp3dXlRdFowUStP?=
 =?utf-8?B?YW1zdTFDaXEzNUp2blNLVTU3RDNtNzhPem5xRnh3alRndzROYm82WGlmVWx0?=
 =?utf-8?Q?hJ8I2kN3tB4SZTM4xWPff/zxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc069f36-a1c5-40af-a097-08db45a92b5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:21:48.4856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwX+7mPFnJcvLWDHtE3btm8yEXu8d6IL77zAchbkxTNsxTCHsqm9gxxY3lf/babCOlLR9ZSgZgxR6QiR+NBrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 4/24/23 11:08 PM, Michael S. Tsirkin wrote:
> 
> On Mon, Apr 24, 2023 at 03:50:28PM -0700, Shannon Nelson wrote:
>> While testing our vDPA driver with QEMU we found that vhost_vdpa was
>> missing some support for PACKED VQs.  Adding these helped us get further
>> in our testing.  The first patch makes sure that the vhost_vdpa vqs are
>> given the feature flags, as done in other vhost variants.  The second
>> and third patches use the feature flags to properly format and pass
>> set/get_vq requests.
> 
> This missed the merge window most likely, unless there's
> a reason to send a second pull towards the end of it. We'll see.

Understood - we'll keep our fingers crossed for good luck :-)
Thanks for the help.

sln


> 
>> v1:
>>   - included wrap counter in packing answers for VHOST_GET_VRING_BASE
>>   - added comments to vhost_virtqueue fields last_avail_idx and last_used_idx
>>
>> v0:
>>     https://lists.linuxfoundation.org/pipermail/virtualization/2023-April/066253.html
>>   - initial version
>>
>> Shannon Nelson (3):
>>    vhost_vdpa: tell vqs about the negotiated
>>    vhost: support PACKED when setting-getting vring_base
>>    vhost_vdpa: support PACKED when setting-getting vring_base
>>
>>   drivers/vhost/vdpa.c  | 34 ++++++++++++++++++++++++++++++----
>>   drivers/vhost/vhost.c | 18 +++++++++++++-----
>>   drivers/vhost/vhost.h |  8 ++++++--
>>   3 files changed, 49 insertions(+), 11 deletions(-)
>>
>> --
>> 2.17.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
