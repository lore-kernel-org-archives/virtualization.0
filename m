Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C913C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 11:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B723441748;
	Tue,  5 Jul 2022 11:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B723441748
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y+g0Rbdm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZsXaoeSQ9VM; Tue,  5 Jul 2022 11:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01F8340941;
	Tue,  5 Jul 2022 11:34:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01F8340941
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C823EC0032;
	Tue,  5 Jul 2022 11:34:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F599C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4CB44097B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4CB44097B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ii13hIvX-42
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:34:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E96740941
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E96740941
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyNl3NtuGWwEeqjb2CHrABw6FuhdW9Y2GHmgRyq5zGmTFUsOaUqAS0P6tsMx3rjl3XTmB8SVS/eWJ97V+ZRDOl7/cOKxcw8jcm5M9celaRjKybk9Rc6cqBwnAwseIe/nJk7htuqTEIrKkKnlZjd+X5EeUYXmpCgMW9++lq8IwWwM2maP+hraqCGkCWDcViwHa9UmHFHovwszL+PS8EyxBlqxJh4ZjIAeTTd1F2RXVfkTOpU+yZScsN3QYIUr8IZAbU02mBj1FsNFDIvVwkGh2Rq1Egc5ZEipqcEaugqRQsH0JViOK3UBPZP9WqYTEohZoTu7w39b79J18iAWFEqENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TXhxapzxVOZ4HEw3o7/f3/JBLUEle02467ayjlVvFs=;
 b=CTmAcJBoWIUwyuyP9W8szIDH+aH/SxdRa4AOb1ZOY7XxtjVOA1oZVouRuDXwjUs+dWH46oS0466T3mRlqrLPWmyRe+3Wg8pSCvRpVos/Mrv+0ZDMUCUlJoCE9Ge9/OIqPYSVL1Amt3HbpsKQAsrqRTueZRT71k0xxir1qbnSX4OcP1mv+ovDQKWXggLlifDw5c5NKM65fy9HcD14pRiSMxKVnbRl6ESMoynWWqewOnjdqDgDoBK1pFgo1kw1DzaUhoPSLsuUIpYNauNtFKV4xHnRxBP7E06/kiRFaigJ1u/5tzkftntLc2fF5KXUlAdCS4Q+CNAfXOehUhfZk2ZWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TXhxapzxVOZ4HEw3o7/f3/JBLUEle02467ayjlVvFs=;
 b=y+g0RbdmutH7JcYbOA2J5ReFR+RZ6EctZK0Naltuk0cYaT5iQXYPCZ8PVyhyYLwtrLCa98KYOgRw8rJNdSzvf8gA5lLNsDWrZxU8usx07oqG46D4mFj2AUDF0w5TE52HpL3a7cPRvaf1q2efnB8OVgHqrOTvBxHM6tMDX0j6I7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3314.namprd12.prod.outlook.com (2603:10b6:408:45::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 11:33:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 11:33:59 +0000
Message-ID: <a42237c9-6304-4b06-cede-2175c7e7b87d@amd.com>
Date: Tue, 5 Jul 2022 13:33:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/2] drm/gem: Properly annotate WW context on
 drm_gem_lock_reservations() error
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20220701090240.1896131-2-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cfd42e6-0da2-47da-555f-08da5e7a4078
X-MS-TrafficTypeDiagnostic: BN8PR12MB3314:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uh10KPZUPrS3d9rZjjif4aIxItaKYdv3du3AK2JdlsYi1TD93YtygxKP7BVSJeQe8AREmZB0VKzDjyyf9YrX/weFgrlt04kb4YiVS8mLbFyecqmPkgGNxK8OrM8O1Nw46Zpxz87IUeQFcf7uu11d13nt7mpwlIoXSD+5oplgoVT9ySRB5UJ3eiYGwEP15Ft14pkh2dFIXc9hlBtY3jNRuGjsUcfku2XrNwjJ5WJWBwIGLUFN9HW0jSGqX4DM8PWL9g6CvLpaDdBz+CY5YexFuMQVq8HGX8j9xuVdYT40JvI3AHj50j6octEKZNnAtgrGZxuTOXsLg8eLwgig0DNkWqg+XVmlJtpvrQHBG/ySTPSHnYq8EW77fq2gX9UCoeFnqaK68YxC/mDQSBlrWZQKwbiI+9H8SrYyWS5zcmN+djfYmGgo4sqHYbC0zWui9+0hWP1Tjl0fI3l2sx0GMyMJGhjk5NDH3Qze7cniGG2q53g9FHdXmZTJDK98UlIvinfSgD3V4qIYUPYs49IrHgpFeIAfEQwV+LLnDs2ioUj7nFGiHfXtFMG5MHkUI4Hqr7+U63LAeK+BwFmAxf8c3dBxrwjgG+BTl2/nlwIW3i77b1GuR3N13Q2C2RrmODdkfKBoKa6BVFZ9RU3S4wPTm58mVsJvhNebSxBXxGkDOKVOWWaz7OCLb9bqa9eXv4x0PUcmcvCQvhM05rvY95Q08C9CEYMYo5cW0mdiAdqfgGNJoqqCrpMSEZCpd/jfkOGted5VTtCQqReBA3NcRHIP3urZO6CjZ1HT8EpIjp4Itu+Uaq/cqn+Oi15BsTBKu6uRyXFht2/VMa7ceU+XEkXu6EK67wazXPF2nl+NQbR438/Txs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(186003)(83380400001)(2616005)(66574015)(66476007)(8936002)(66946007)(36756003)(31686004)(5660300002)(4326008)(26005)(7416002)(6512007)(6666004)(86362001)(478600001)(8676002)(110136005)(41300700001)(316002)(6506007)(66556008)(38100700002)(6486002)(921005)(31696002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlzWDdIWjRNbGhzeFZEYk4xWFZaVkU3MldESStSbHo5dkM5ODZFQkRMKzZo?=
 =?utf-8?B?Z2hHd2RQcE56ZUROdlZhK1d5ZzUwam5wMHZzY0tMOHVWbGEyRVMyTzlVWXhu?=
 =?utf-8?B?dEZrbjd2L1llb2JUWUl3Y2tPQUxBVDRKUUtTV3U3ZGgvdzl2NmRzdmYrYThZ?=
 =?utf-8?B?RHd5RE9xTHZsTFlvZGVwdjRrT2ZtQktxOTkzUWIvODdkK2d2ZXozcXdoT21n?=
 =?utf-8?B?RE1lUVRyQkxEV3NleXBkdzNSUDhacWlMVzZueTIzby90T09Pbm9aZ0Z5NU9m?=
 =?utf-8?B?SERMNE1RT29DbzBGd05YUldtM2pxVWlTZkpOTy9OT1pzYlZYZ3FZQlpZSytI?=
 =?utf-8?B?KytFaEE2ZDljSlp3a3VnVmc3MTNvdlE2TzROdVM5UmpMbWxSd0ttbFIyVjlD?=
 =?utf-8?B?N0Q5RVdaNFU0a3hBSlYydlFBUjBJQkIxL0pHMVBxV0VaT01iSURPRmhLUWQ5?=
 =?utf-8?B?Y29XZHp0c3dYN3VzUG5FUFRVVGh0YnlpblBKRDFpZStMWXVHRmFLMXBFMnNi?=
 =?utf-8?B?c0V0Ym9zRzJGbnAwS3FYRW1RSHpzMktYaW4yOTFKaXRHMVo4YWxNVmExY0Zz?=
 =?utf-8?B?L25BYjlCWEdjUXhQVEZOc2szTnYxUVB3My9YVzkyc1BqNm1EeVJBQjFOUDJF?=
 =?utf-8?B?YjczUnl0REcwY2pxWFBoNng4V0Z0SW45R21vMlI4Ri9KT1ZOUWlTWCtuYzBr?=
 =?utf-8?B?WDJXTkExZElKMGEyU3pnMTQxUkVveStjUjV2ZnZKak9LamtSOTZmTlBWWFVl?=
 =?utf-8?B?ZEFyK0VRelMzRHVNRStQbWljTS9mMG4wL1owNjcwRkc1d0hmOGRDbVN2aTZY?=
 =?utf-8?B?NU0vaStrRFhrd3crVXlwYkNtNGYvSzNvZ3VnYkZkbWRwbHhYWkNxSDBjdGVC?=
 =?utf-8?B?M3R3bnRqcVlPaUFQcXY4SWdRUUFpR1M5azRwS1VPYmZvYWltRGFRMzdOOGta?=
 =?utf-8?B?WWtKMDdIU25oSHpMM1pScWNUbFdGOXhjc0ltK0IvYTczRVRwZFZTVlFlWUQy?=
 =?utf-8?B?QlR3cVovQUJETGJxSEpnb01iVkcvR2NoRUh6YmM2aEoydnVYKzdmZDUwZVRV?=
 =?utf-8?B?RzBGZ1VHRFlpVm9CVDJydXJCWFlsWEc0cTZhV3IyWEJhSk1lUmdEVll2dm9E?=
 =?utf-8?B?NWQ3dU91bVkwbGljdnpnZGNUSW1aZWwrSDRsZW9YMkdYb2lZSjM3Ykl6cC9v?=
 =?utf-8?B?UkswOFVjUjZpMkhMTjhzdS9nclc5L0tob1lWZnp5VG1iTUtiRTFtYmlJMVBN?=
 =?utf-8?B?aWVmVWtyREw2Ry85VVRmN2VkTk82YjNuUDU5WW43UVA0cEkzbG5ITzZTK1My?=
 =?utf-8?B?Z2ZGbW5XZEhBeUIwRnJXOE5Oc3NCMTh3TTBzTGJOMi85V3Q3Q2pzd1Bmdzl1?=
 =?utf-8?B?OUxkS0Z1QllnZFBpZUo1MlpRVEJRK2FsWmVqSS9aampKM0FmdzVRdVZIcXh0?=
 =?utf-8?B?aU5YVkRsbHVuaWFnNWNoUEdCRzQ0ZU4yMllnSE11YmdodVdlMEgwNVkwbzdZ?=
 =?utf-8?B?QTNFWXdmbTlQRWxLQ1NMZm9xWEZRcW00dmcySXlwcmN5Rjh4ays3Q2gwQUFj?=
 =?utf-8?B?QXZPVkpiczI4dzduendCQnVjaENRdlRSdzMyaUpXRjZUVEI3Y281cy92aUZJ?=
 =?utf-8?B?VFgxRStIVzVsTnphMlo3YmFMdUx6dDhYZUk0ZUVlUlRUMmg1Q25uejVMNjZI?=
 =?utf-8?B?NXIveFhNRWttNFFkU1RtcE0rQkErWVBRYXpTd3ZJTWl1cW5tQ0hqYXZrZ2Jy?=
 =?utf-8?B?YUx0TmVWU0tJYmNsUysxZHZkMyswazZENDZoMEV1Y05RV2pPSENiNGpGZGVn?=
 =?utf-8?B?amQ1Q0JlMHpWRVdhb1hiSTUrbjU3WXVDTCtWMFd6bGNWOEVRcmVkN1VSYVoz?=
 =?utf-8?B?Vk1WOWhCclRYS242OGQ5MFhjZnphV21vT3hFeFlVdE9VQ3FSTnFFQnI3NWha?=
 =?utf-8?B?ZERBMGVqRm91NHdrVGo2WjlVQTlIc1h0WTN3eFdZNmVqMVJyS2dsbzlKNEVG?=
 =?utf-8?B?QkFaQVJuWk9tczlWUm9oc1hRd2Mrb01HT0crb1dKUGxUMkwxeU5uV0RZeVZw?=
 =?utf-8?B?dUl4R21oUTFIeDVzeDZLVEhjTVFPWjBzcFBIYmc5NUFiZFV0d2w5aTNsamE4?=
 =?utf-8?Q?WDRWGM/Xw5Jzc+RGH2xUTm3/H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfd42e6-0da2-47da-555f-08da5e7a4078
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 11:33:58.9964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4PQRWCPqIp8ku3dByaTcWRszQok7AR4OujmYczTFAoqdQdm9Y/WZIuDiBrlIdQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3314
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMDEuMDcuMjIgdW0gMTE6MDIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gVXNlIHd3X2Fj
cXVpcmVfZmluaSgpIGluIHRoZSBlcnJvciBjb2RlIHBhdGhzLiBPdGhlcndpc2UgbG9ja2RlcAo+
IHRoaW5rcyB0aGF0IGxvY2sgaXMgaGVsZCB3aGVuIGxvY2sncyBtZW1vcnkgaXMgZnJlZWQgYWZ0
ZXIgdGhlCj4gZHJtX2dlbV9sb2NrX3Jlc2VydmF0aW9ucygpIGVycm9yLiBUaGUgd3dfYWNxdWly
ZV9jb250ZXh0IG5lZWRzIHRvIGJlCj4gYW5ub3RhdGVkIGFzICJyZWxlYXNlZCIsIHdoaWNoIGZp
eGVzIHRoZSBub2lzeSAiV0FSTklORzogaGVsZCBsb2NrIGZyZWVkISIKPiBzcGxhdCBvZiBWaXJ0
SU8tR1BVIGRyaXZlciB3aXRoIENPTkZJR19ERUJVR19NVVRFWEVTPXkgYW5kIGVuYWJsZWQgbG9j
a2RlcC4KPgo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gRml4ZXM6IDdlZGMzZTNiOTc1
YjUgKCJkcm06IEFkZCBoZWxwZXJzIGZvciBsb2NraW5nIGFuIGFycmF5IG9mIEJPIHJlc2VydmF0
aW9ucy4iKQo+IFJldmlld2VkLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJv
bUBsaW51eC5pbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0
cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ry
bV9nZW0uYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+IGluZGV4IGViMGMyZDA0MWYxMy4uODZkNjcwYzcx
Mjg2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4gQEAgLTEyMjYsNyArMTIyNiw3IEBAIGRybV9nZW1fbG9j
a19yZXNlcnZhdGlvbnMoc3RydWN0IGRybV9nZW1fb2JqZWN0ICoqb2JqcywgaW50IGNvdW50LAo+
ICAgCQlyZXQgPSBkbWFfcmVzdl9sb2NrX3Nsb3dfaW50ZXJydXB0aWJsZShvYmotPnJlc3YsCj4g
ICAJCQkJCQkJCSBhY3F1aXJlX2N0eCk7Cj4gICAJCWlmIChyZXQpIHsKPiAtCQkJd3dfYWNxdWly
ZV9kb25lKGFjcXVpcmVfY3R4KTsKPiArCQkJd3dfYWNxdWlyZV9maW5pKGFjcXVpcmVfY3R4KTsK
PiAgIAkJCXJldHVybiByZXQ7Cj4gICAJCX0KPiAgIAl9Cj4gQEAgLTEyNTEsNyArMTI1MSw3IEBA
IGRybV9nZW1fbG9ja19yZXNlcnZhdGlvbnMoc3RydWN0IGRybV9nZW1fb2JqZWN0ICoqb2Jqcywg
aW50IGNvdW50LAo+ICAgCQkJCWdvdG8gcmV0cnk7Cj4gICAJCQl9Cj4gICAKPiAtCQkJd3dfYWNx
dWlyZV9kb25lKGFjcXVpcmVfY3R4KTsKPiArCQkJd3dfYWNxdWlyZV9maW5pKGFjcXVpcmVfY3R4
KTsKPiAgIAkJCXJldHVybiByZXQ7Cj4gICAJCX0KPiAgIAl9CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
