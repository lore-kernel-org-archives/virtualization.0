Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B787CCA47C
	for <virtualization@archiver.kernel.org>; Fri, 15 Jul 2022 11:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE77460B33;
	Fri, 15 Jul 2022 11:04:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE77460B33
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Zchzez7v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oylb30wJC0oi; Fri, 15 Jul 2022 11:04:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0BFD960A4F;
	Fri, 15 Jul 2022 11:04:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BFD960A4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5C1DC0033;
	Fri, 15 Jul 2022 11:04:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A861C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 11:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11EB584F4E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 11:04:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11EB584F4E
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Zchzez7v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d1dTE4SBsGbK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 11:04:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01BE684A51
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01BE684A51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jul 2022 11:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAaFaLPZsF/vPwiHDX3dYoY0O7lwOazI8mFAwEJ9D/tYkiM5Xrz4MKlF3gpLeJY0YwNwrj64tVn8x/faEi+rmLtxQpem8dbswzqcaQmJGD/1j06gcTpzfuNWNOCedlkvK2VlAVr7D2Jh5r9YIjm5rC+nWwujwP8vEv+lukDRTBoTuU7FXyISyOWfcwO4jTRvdW/6WOpT8PBSnZKhVXz6X5hueN8KnggeGrYryLl+vMzO5uo3zGgXDZXxqjZiS7YH147FSHljeKxidZt2TXuBiZ+MSH11zG/UMmiSvIKkE20yNhQdgRsG6+Lnbt+JEUVQZk+DmsTXJhUe04EM8W5+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6nwuZk6jxCDh5cJ3kvuPX4Ekl6Mq2DMQkBCuVkfDGw=;
 b=mGiwZC2SHJLNUX8F6K0JwbiLII7mBk40S1auc9jb9jCu6HEB5TMwS8riId1N/Y83RPOeflfal4lH0oM7EPYxOdhzL3Gse1fCskWJRh6V+pPiCfbJ1Frhf0iFJcp3kPoBBpPRjdo2v0MbA2YbozY3lUJGPlh68MifY5I8kAAfjsPPeTcQSnvch0emAh8/VK3FY8H4gEY+eNt+I5woguAgBJ9cjW7YDXTRO/vMCe13LIuvlOHDv+oqNrIJVQIuAc6jYiJ+/Piy2KJJR6GudvpbQ1ZIwDO7V34W3xnitaONzqcXNYOmc397OZ0p23iI/ZAIGlUPmCJhZ61baa/YOsAuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6nwuZk6jxCDh5cJ3kvuPX4Ekl6Mq2DMQkBCuVkfDGw=;
 b=Zchzez7v9oX/JvKQOPe0idy21fo84o0VffIT8B+g0Rp1cgXPlJG1CdYYERUueoyVJSUh1jfw9bzkisacu/mTeWu6VylAihCl92XCebzmMWHC0vQebpJaORnxcU0ecOua3uAoi4IBNd1uKN/2Nnmxhm4JqxEsD9q7cBZsbH2owDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Fri, 15 Jul
 2022 11:04:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.013; Fri, 15 Jul 2022
 11:04:31 +0000
Message-ID: <c6024ebb-4b3d-60c8-f0e7-006f994c9fae@amd.com>
Date: Fri, 15 Jul 2022 13:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/6] dma-buf: Add _unlocked postfix to function names
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robdclark@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Thierry Reding
 <thierry.reding@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>
References: <20220715005244.42198-1-dmitry.osipenko@collabora.com>
 <20220715005244.42198-2-dmitry.osipenko@collabora.com>
 <43c06f53-bad8-af99-0b57-781dbf716768@amd.com>
 <5c98385b-f154-0128-6f4b-5fac89529201@collabora.com>
In-Reply-To: <5c98385b-f154-0128-6f4b-5fac89529201@collabora.com>
X-ClientProxiedBy: AS9PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03ca3e4b-87ad-47c4-1e3a-08da6651cb0d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwu9HL1s/vpEK9NNLUhFqEEFCwwT70yFJas+vVnygSr4WcdgQzdpStTtgLb1JrNKmLg9YO/hpENuI58uOiWv4vOVfLml04yEZFOX0CoScjqEqWtHVvDTToBBxQ5IWgcWXhcV89ErwmP6+YlJmfvnc5+ckUwywNdZ1NMcgjDgpBFq2+6nBSVJ3c3CW9Soo9yUGVGNtyF24TIoHEAm0LwuiLnd7CCilm2C0GcAQ4EkiBckt5Z/v7i80R4zeiv7XfPuH0lAoeonRufwfbmtePUQhmbiNrusR/Wt1xN90thdj29JbUXBQZjKiPk4Las8q+t45Z3zidJHYvdQdGAbb2X2pXsdAT5EC94HaqXuMWADzYeeNuMafjiSWvFleiwegUTckXVitA0GvkBERs3IxBLSj4VwjW7QtsoR6DJnPEPoQyOuYTDe4/u5oiyHMuTyQzPJd+1hIfLbxB53o7Wrb8LdupY8u6ncPUC2SotNIXmNL1HUcciB/UNnJsIWfCUQJEJO780bTU4I+YgzeY7FRCkEe+A7zJoAELbVhqVnirroiVLOrzoESUzHfJgyjADk40Nrsu7MQTmY9v6mkgxfHLbVbbL4tZZPvuBPXW2UI1yGrkIOSZBb3pVsQOH9apkG5PDfYpNMqIVKQXiLPzUBA3MTp+WZzafAwfz34Zeb3GZBQlhyC2WlXNlgoR1KvwMbcRQStnR/u7SQz7QmIMJZRGjoqJymidjsXIF1EYH2WEO6QJR0fs2pncZArPbOeQtrnhl+FISOTxwRVJqok7xUY1ZK9FcVroWUnpRZZ0NYnXJNI5aldEzVZBj7VxUvEpxRHd5aBv7w7zUjIu1WBJ+p9LZQow6x2aEXiK9bDq4SCOuw3p8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(66556008)(316002)(66476007)(7416002)(4326008)(38100700002)(41300700001)(31696002)(5660300002)(2906002)(7406005)(186003)(6486002)(8676002)(6666004)(921005)(36756003)(66574015)(83380400001)(110136005)(66946007)(6512007)(8936002)(6506007)(31686004)(2616005)(478600001)(53546011)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTFtR1A5a0NlWEI0R3pudjErN3hvWGxHbGdZYlUzU2tYUy9uY1ZOeHVxZGw2?=
 =?utf-8?B?eHlRWk9GKzZGRm9BVk85Q3h0aWFaY2VzVVo0anNXTzNEVmpGcXBVa01vZUFk?=
 =?utf-8?B?Q2V4K1NSNlM3ZFlkMjdkeUJHeHY4b0ZDWGdDVFZqb0JheGVPZjMvUnhCeHNp?=
 =?utf-8?B?K3dJMDU5Z2ozcFFrdVp3L1RWNS9ESzVLRjFzTXR1R2J2R2xLVTA5SHBGVVA2?=
 =?utf-8?B?OGZDcnc5dEl6a1JPOVZLMFpKdXRGYjQ3S3pxMlRRVDJWeUQ0M0ZjNkVQOGFh?=
 =?utf-8?B?RDVFUTM5SmNhVVhFcERUNjZITjQyRWNWbGpYODUySm9RdE9Ub2hyQU1FU0Rh?=
 =?utf-8?B?NDhTbWxQWmo2ZVJrNFYrMEpEOHFEaE1WTXJvaUtxd3hKYzlNVnVJMy9ieWQ0?=
 =?utf-8?B?Y2l2T216Zmx3cEY5SWhNdCtyNFBhejFRZ2kwazhabTNud1A3RisxTWJaaXVE?=
 =?utf-8?B?OEplQVExMHhpY2ZYc1g4bU9sYUdDYU5rU3RkcGxVRi96dXNXOUNQWXpmQUwx?=
 =?utf-8?B?TnBBcXZ2UGp3KzBxRWxuak1hZzNDd2N2eitINzIwTWdiU3F5Wmp3d2RadDFM?=
 =?utf-8?B?YzJsZ2xZdHFQUUpCK1RmanMrUWlyWXNCRzJlWU5obmxNY2hGdEhaUjRuelhi?=
 =?utf-8?B?M0xOdTRMQ2JWS3RQRHZxTlYxeUdNek9jUFZMM1Q2S0o3K3BFRUtITTlCdXp2?=
 =?utf-8?B?aWJzaElEYjhKbVhzWUllUWVTeTkrNit4STlhRzVGa1dnOWxxVDdKTkpKRGNP?=
 =?utf-8?B?ZHJ5L0c4M05iYkZzTTArUWVleFUyU2xYMXhHd0Jyank5eEJHcnpyYVhBU21R?=
 =?utf-8?B?enE5ZkxISm9IaXNMaUZVWC9CVk1GZFJha1l3YnVTQ1VZQ0RhT0ZkSm9hVzlH?=
 =?utf-8?B?akg1Y1JvUms3aHUrczdzQU52YmkzWnNsSmZuWmhIcnBla0JTN1JiaVpsVGRr?=
 =?utf-8?B?Z3c4S0V6d0xVTnl2Q2tUK1hqUU9pNVU3WGEwZ1BGN0FXSEx0aXRBUC9meksv?=
 =?utf-8?B?TkRUU3JHR09HeFRXYVRuMUtVakpwRFhNdFBvcmtCaGFzb2pNc0JHMDBKd3Ft?=
 =?utf-8?B?OWdvT0NEMUphdC9leEVqa1Brbk9qRmJFM3hCNUNDSDN0YURTdnVTMlM2elFG?=
 =?utf-8?B?RUd3ZU1JWldEaWh6aDAwT2pwamFQYU8xVHo5aWwwR0xvbUQvUEtudWxxcVRF?=
 =?utf-8?B?Z0dEc1RDZDdMMzZ2NzV5SEpaeHFsOVpiWjg2Y3pzS0RreDJCYUdIcVpqOWh1?=
 =?utf-8?B?TWFIQVB1MExOOGdIaXVNRk9Sa1pRKy9ZNHpBYkpRVDhyUUZNNSsrTVpsMGVG?=
 =?utf-8?B?TXM0NDg1QUhTU1J1anRaeFRLU1dtNVdneXQ4Q09GbWlUWTBFbDYzOWxKVHkr?=
 =?utf-8?B?eWxTWG5ZT1ZjNzJhb1Z6MGd4Q1FhWExweXdabzdhYjl0WmpNZzY2d1dkR2Iv?=
 =?utf-8?B?ZkxiTmpXWFI0ZU5OL2NVU24yNnpVT0VTODRTS3J0aUU5U2hLSE5QVmF6VTE3?=
 =?utf-8?B?U1Exd2FHVGJkT0p0eWlRQ21VK1VHQU9Ta3VzUGFxcGwxWmdPVFp1emd0RGRE?=
 =?utf-8?B?S0M1VU1sVHpITXhFd3YzbXFaMk9lNmZpZ3V4WjZrYjRuY2gyTXhlWG9rSVBZ?=
 =?utf-8?B?N2Jzazl4a1hha3FMZlZpTEFKS3NFQlpqYmh0SG5YWmN3bUtuWS9HekpWeGcr?=
 =?utf-8?B?L2JkTjRlTEJSTDN2NGhsblgzQys3cXNiWnJ1MGNXRmNoT0tCR3pQRVJESnEr?=
 =?utf-8?B?Rjhwd1NNK3FpZndMT0JpVlZTL2liQ0cxaEdHNUc0aGU5UVdPaWlJdmNQd01n?=
 =?utf-8?B?QjJzcit0elZoYmJFUitBMDFaQVU1NVNqcTE3bUpIajFSR2MzYmdzc3hhMmVN?=
 =?utf-8?B?UXZDYWhDd1N5aklWREV3ZUt3SzdWMW1sdEZQY3lnTk9pcmpxQTJYQjViTnMw?=
 =?utf-8?B?QnY1ZURxL0krUUYyYjh2OU9zMi9YWk5sVjdFbU9lUXNnczRMa05xS25EQmNM?=
 =?utf-8?B?ekJjU2tQQTViMWxrNno5ZERDaGlHb0hHcnZoRFZTZXkzM3JsaS80SFVROEFh?=
 =?utf-8?B?WkVXeE9vdHorWTFPWHE0ZUF4RUZqZmdjNTFxQml1ajl4aHcxZnpVWHlJRFBO?=
 =?utf-8?B?M0hjUkdsdW8zelR4UEpLTUlSM051bTVmRDVnbW1iWmJUVTFOcmtIa2hsQ2xJ?=
 =?utf-8?Q?LWO7z7gqcMc42JltizS1LALtTgwy7F4gZqPlkLSw+xqP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca3e4b-87ad-47c4-1e3a-08da6651cb0d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 11:04:31.3083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWxf0JIvQSgFVOsGvL1oEJcveYBkNOLQpZ8Rst9LCvm3O7Qk5VVgUud1oOBUuQWa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
Cc: linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, linux-media@vger.kernel.org
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

QW0gMTUuMDcuMjIgdW0gMTE6MzEgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gNy8xNS8y
MiAxMDoxOSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IC1zdHJ1Y3Qgc2dfdGFibGUgKmRt
YV9idWZfbWFwX2F0dGFjaG1lbnQoc3RydWN0IGRtYV9idWZfYXR0YWNobWVudAo+Pj4gKmF0dGFj
aCwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIGRtYV9k
YXRhX2RpcmVjdGlvbiBkaXJlY3Rpb24pCj4+PiArc3RydWN0IHNnX3RhYmxlICoKPj4+ICtkbWFf
YnVmX21hcF9hdHRhY2htZW50X3VubG9ja2VkKHN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0
dGFjaCwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBkbWFfZGF0YV9k
aXJlY3Rpb24gZGlyZWN0aW9uKQo+PiBUaGUgbG9ja2luZyBzdGF0ZSBvZiBtYXBwaW5nIGFuZCB1
bm1hcHBpbmcgb3BlcmF0aW9ucyBkZXBlbmQgb24gaWYgdGhlCj4+IGF0dGFjaG1lbnQgaXMgZHlu
YW1pYyBvciBub3QuCj4+Cj4+IFNvIHRoaXMgaGVyZSBpcyBub3QgYSBnb29kIGlkZWEgYXQgYWxs
IHNpbmNlIGl0IHN1Z2dlc3RzIHRoYXQgdGhlCj4+IGZ1bmN0aW9uIGlzIGFsd2F5cyBjYWxsZWQg
d2l0aG91dCBob2xkaW5nIHRoZSBsb2NrLgo+IEkgaGFkIHRoZSBzYW1lIHRob3VnaHQgd2hpbGUg
d2FzIHdvcmtpbmcgb24gdGhpcyBwYXRjaCBhbmQgaW5pdGlhbGx5IHdhcwo+IHRoaW5raW5nIGFi
b3V0IGFkZGluZyBhbiAidW5sb2NrZWQiIGFsaWFzIHRvIGRtYV9idWZfbWFwX2F0dGFjaG1lbnQo
KS4KPiBJbiB0aGUgZW5kIEkgZGVjaWRlZCB0aGF0IGl0IHdpbGwgY3JlYXRlIGV2ZW4gbW9yZSBj
b25mdXNpb24gYW5kIGl0J3MKPiBzaW1wbGVyIGp1c3QgdG8gcmVuYW1lIHRoaXMgZnVuYyBoZXJl
IHNpbmNlIHRoZXJlIGFyZSBvbmx5IHR3byBkcml2ZXJzCj4gdXNpbmcgdGhlIGR5bmFtaWMgbWFw
cGluZy4KPgo+IERvIHlvdSBoYXZlIHN1Z2dlc3Rpb25zIGhvdyB0byBpbXByb3ZlIGl0PwoKSnVz
dCBrZWVwIGl0IGFzIGl0IGlzLiBUaGUgdWx0aW1hdGl2ZSBnb2FsIGlzIHRvIHN3aXRjaCBhbGwg
ZHJpdmVycyBvdmVyIAp0byB0aGUgZHluYW1pYyBtYXBwaW5nIG9yIGF0IGxlYXN0IG92ZXIgdG8g
YXNzdW1lIHRoYXQgdGhlIG1hcC91bm1hcCAKY2FsbGJhY2tzIGFyZSBjYWxsZWQgd2l0aCB0aGUg
bG9jayBoZWxkLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
