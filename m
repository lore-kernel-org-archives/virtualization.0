Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887F9C54EE9
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 06:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2230A60BBA;
	Thu,  1 Sep 2022 06:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2230A60BBA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JOsa0PLZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-JJiyr_gzla; Thu,  1 Sep 2022 06:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93F9C60AE5;
	Thu,  1 Sep 2022 06:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93F9C60AE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54ACAC0033;
	Thu,  1 Sep 2022 06:55:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 767DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43AEB60AE8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:55:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43AEB60AE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkIElleb5xUI
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 072BF60AE5
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 072BF60AE5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neBzB0/O4hnlq3ymTWFbFsEgcMXcPV+f7tXm5XvXctAY2+zrKSqnpxZjd3Bq/WLIwnIgFmJmrR0aVTaZLvLEi3PGm/yzVTp4A+wqWEQ6sPlE5lt2+5F7rLLjNd88XMue81+WwW5qaXLr8ZDirfz6PC5wnLHGl94oVMZKnHsokZF7OdOwcpNYT0Nsg7TUBVqZFLbgEVXbVHlmLUw3vhIWRNfby/CTK4BiP7QdMfziqePE1VxQk95fZKUMYzwW0AwY+akJ4pZGxWUSjlbFXrduKUdNCwWnxb3WKQxNXGri3K9pnYR/Ji7CB7vdM84YcOQCZcIUHRGBwVyR0fdVP06W7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akN2a1Wgmqf1q4N6+stU9PFi00lxSLd6MVgNGbipNas=;
 b=iGfykgLkTjZ9Gd6WJHt62zVq7CqqcfW2Uys7ueQDg6J52Tg7jU2KS+Ax80C+AE1z2eUDDhvEUzue0YKspY32Q2NFHfhg8ufpA99y9gsRsGsb7cTN+ujnJ3mu1oGtX+VjTzwGLj34+FH/yjIIbkVYfe/e7JUhjqxoV92bfH4S5aD1C2SZbvsDL/bdUaeBGxI3AecvAL8Ms7H6J23aFGiUXuhIt4aNkDqg9NnF1LB/o0jFNIx5CBpaBrM+nLmQxAuEspfqln5Jqnj7lxgSHx3RMjUyKNQqT37qZumx3gvfZ4nCw2HTi+wV0Jw9WXOuq0+mfij3UXzw0uyY9gq0DCjfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akN2a1Wgmqf1q4N6+stU9PFi00lxSLd6MVgNGbipNas=;
 b=JOsa0PLZMZgez0uuEzWIw1IpWh/JAekz/rllcbVfNs4f1vVMrL+LAX3Br8pUo9So1KF/rqkkhqFh2mCk3kcbDZnszgGbUbxt84l3YvB4guInZLmEBArRPqPxTMbYGksnBWBLD/Jyec7fw/H7wUQo20JAo+E9HwOUmcwuC2/0eUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:55:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 06:55:16 +0000
Message-ID: <ad72df13-920e-6b22-80ae-ecf2e6bc5b55@amd.com>
Date: Thu, 1 Sep 2022 08:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 11/21] misc: fastrpc: Prepare to dynamic dma-buf
 locking specification
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
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Qiang Yu <yuq825@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Tomi Valkeinen <tomba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-12-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-12-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AS8P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23112121-b4a2-47fe-3dc5-08da8be6ecd6
X-MS-TrafficTypeDiagnostic: DM4PR12MB6039:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HRW5bqonJ5VobVy0GTfxPygJxSFhNLJHVvnhRc7TuhcMW+9cnhuBZ7TS3ikydx6eNTo6jMI54qtUTz1qb5sUykQ5uJj9xoKqaEQ3WtYJAaYhs3a6Xmll38shJ886vhH2x8reCYDPFu0cw6IQsDijSXq2TK9dm/RYTaOP3Zmha5NlYw5XS3MiaroNqPzYlIZXaoRrAZWfPOZYaoU5O8GF3BtMULgihu+mLlHQq9k+DlgJh9Ro3V9ikSl7xncvoP3VAzut1p21WXK9RpKZwTOEsixsrRECCIq9y2g5gQs5pcqTGVG5h6tD+EtZMzmIu9F/ajRZTX9FM5yZIDvfnCYFSTuCjIhDMm7nPTkk7RcreFw9n8xg3t+oqkexfeoUXDT0YRQuyY8dBdo+NPgqRldR/RcxLaZ+uIJ4OljE9I8OqLjvPz238RVoywTQoGQctP7GaFDrMdApkpQT+HS+PQ6YrmtlHobzHnZovye1ubGxwbbCBXHqHCtTQnoxrSJwpCnXj5f06JsT0w45XqFeolbbGsUamvpwmDeJVXyDLb/XOvnYGO/kIxg1FU8BaUkwxbon5UtMrmqOuxHek7VStq/cHcySl3Q6zuyXwv9qwX9nk/VzB6k4W0I6nYzCHC2bcoiX+vXYwQWTATefvDW6tnAD+DZ+VVHv7Ivnt1hc+QfNRmIMzYuxJ0Z1lUwqv0Qg4x4ElmSJtNhEZhaapxeO3CjhXfMSO4zWWrdBtdPY7HhUaScDFTj5fyjy3K2xr1mguwnvu+GEijS3vqm+yI9+rHFeo2+xpzXrqS4rmGchkjOyZkN1JKCZGUM+rZ38qwueBPE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(2906002)(6506007)(6666004)(8676002)(66476007)(4326008)(66556008)(66946007)(316002)(478600001)(36756003)(6486002)(2616005)(41300700001)(6512007)(110136005)(26005)(31696002)(921005)(86362001)(186003)(66574015)(83380400001)(7406005)(8936002)(5660300002)(31686004)(7416002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJWcENQdG9QeU1sLzVONlFiTTY1WUs4dGNKQTR3dDRCcy9Ic2Vnd1I1NmY2?=
 =?utf-8?B?bXR6U2hsbVpQU1JRTVE0d01Nbjk1cTQ4OGNCeVUrSHJrb1NoNzZsSzJ1eFVo?=
 =?utf-8?B?ODRzaWhCK1F2UlVwSGhDYlZZaUJhZFFmaDJkT2U4MXJNWW9yeWFPVDcxS1Rx?=
 =?utf-8?B?TzBIUTZXNEVpbXQxcHBkVHVXYmVqUXpGcFkwQWRaenlYaTBmYkk2L2pXOWdk?=
 =?utf-8?B?d2tHVUVlQzRFRjU5ZUpJZGZadEpEMnYzUzM5WjJONFNKVXRTdzNjVi91VWNP?=
 =?utf-8?B?NlUzVjNUZ096aENxbHVqRGxqZzE0cEdEUzczcVlqMWpDaFUxYmk2c0labnox?=
 =?utf-8?B?ajlPb2RKRnV1LzZkN1VvQTNxeUpkU1lZRDRTR1l3YjVnMnNCazduNTlvZFhE?=
 =?utf-8?B?YUNxWjR4VDVkTXhaMnBkbERhQ1crSXZOSHdxdGJML2V3UUxOS3FORmVzRHQ0?=
 =?utf-8?B?VnFmbDd3WUIxUTJ2ZkMzY01Jck4rY05YTGFrMFVkcFF4UG1QTi84cG5jSTRm?=
 =?utf-8?B?NWJSVEpKT2RXdjExc2JKTGhOKzZxSWIvQU9WUHYwazhCSUNqZW9aOVZrSndm?=
 =?utf-8?B?MjdXbEdwSW91eGRRUU5UaGVTV0FjZnc5RnFvSWZzTmpyVmdpQ0xLdkpMNGdw?=
 =?utf-8?B?OE40SUVBSGRwOGZyVFdTc1NnQVA1T1pRWmU3SFc0bWVFaHFFakxGOTIwMmky?=
 =?utf-8?B?TWJ2MlowVXY3VXM4TGdSclNKSzRQendRMGF4TWtJMnNTUXljNnJNTkwraXFj?=
 =?utf-8?B?NTZUMmF1UmpIR1NyZ25ObXFUTE1vYUYzN1NIWHlOVzFpTTR1dUZHc3Y3b1li?=
 =?utf-8?B?dW01Y0Myd3l1SmJtcFZ5VHlkWkdmY3pYUERsTVdyUlRVS2JFeDUzS21CRVE0?=
 =?utf-8?B?bWtIT2QyTWJOdCtRdnljclY1ZSsreHJiRXBSdXZ6Zy81dEhBZHBxWXFyNWEw?=
 =?utf-8?B?L0VMdld2T0o2MjRHNjV2NVJhUW1SVldKS2xhY1MzK3hrV2dpcC9DK2xCTFRl?=
 =?utf-8?B?NHhYRmMvcmJ5Q2lDVHk5Y2tQNlRxaFBhVEtwVENxbTFmaVNBOVg2NTVWb0hY?=
 =?utf-8?B?Z2ptWVpaN1lrQ2RGc1ZvTUVJTDBRelB2R2h2S1pHQXU3a0ZRRStkV2k5b2Vw?=
 =?utf-8?B?Y2FHUURDd1NqbTdHcWdvd01PMy9NTmlXMDJWUnJDcGNnRk9vTEV0eFdxaWtW?=
 =?utf-8?B?RWwvdU5jVk11Skp0aXYrc3BKcFN0ZWcrQkFwc3NEU0hLdFlJUWRBNHROcVJw?=
 =?utf-8?B?UGpVVWR2VVpydVFmUVZtdVcyWUNXQWh5RG4vK3F1WG1mVHVMZ2E2S1grRWZM?=
 =?utf-8?B?Qk1WRndhOGkyKzlmQ2xUQzZaekZWVXZRb1NMT0s4a2JuYWt4SlJwVk05anZ5?=
 =?utf-8?B?ek9jUGtLWUk5aE9BQmRUcmJVTVFzZlBuRnYvUFR5eEFnODY3dUlrZFQvNnFr?=
 =?utf-8?B?SmhzNlRwQ2VvT2xHbzJvenF0NjBiYXJMcjJuTnpiRVYvT3JQZWIraGh6RWVP?=
 =?utf-8?B?N0xjZ0VyUlNOSnZ1NkYrUWpRcytad1NNc3VEeWx3UGFGNzNvWWdBMXhqbEkr?=
 =?utf-8?B?a0pwdzl0MjZqQW0zUFlwTXFsc3hLSmlOWXo5VVRXZkUwSEZkdkwvTVJuYjFp?=
 =?utf-8?B?S2hUSDJjN21kOXFqeVVlcUltZ3QzQUxzL2FNY25FdTJIQUdNRkFXejJ3clhS?=
 =?utf-8?B?cHhHeE9JVytsNmRMSUFKejJlMHRDMDV3OXJERDdlTDZtK2ZVM3k4MXk0Z0pB?=
 =?utf-8?B?eUNFdlhGSlpQaTc3MjNzbUZ3cmJNLzR5K0RNZGpsWG9HSmRmSmJ2UzI0VDVa?=
 =?utf-8?B?aW1HYWdibHdkVDFDZXRTTEhobFdhS1l6ZWpaa0pTWWNuVHdrb0FNR21QTzJE?=
 =?utf-8?B?OHQyOEFCOE1WU3Vmc0xTV2o1UWM4dFI1ODdVRnFiUHdqcEdoZTlIN21Zd011?=
 =?utf-8?B?SU1JK1dpRGVEODRYUGFpZVdOdzVVazdLTmlDMS9RUE4zUmptbXJER2hCTW9J?=
 =?utf-8?B?R2NkQkF3eGF1TVBFVTA3cUZJbTk1amtaRncwY0xoZ0wwWUpuNDY4WGN1dkJi?=
 =?utf-8?B?VmJzVjZZOGZlTUI3SXUxRHFTTlFDQ1dWVFNMYWdpUjJMVEdNUE9Lcm9GTUh2?=
 =?utf-8?Q?oEoievHDTiOq5zZuuIUPVMSsz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23112121-b4a2-47fe-3dc5-08da8be6ecd6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:55:16.0892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQumFulxCHigYDaK47wSc4r97LXHDMk3BbjcwK0KyL9avvdD90aj3cnvKX+tKRNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
Cc: linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 linux-media@vger.kernel.org
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gUHJlcGFyZSBm
YXN0cnBjIHRvIHRoZSBjb21tb24gZHluYW1pYyBkbWEtYnVmIGxvY2tpbmcgY29udmVudGlvbiBi
eQo+IHN0YXJ0aW5nIHRvIHVzZSB0aGUgdW5sb2NrZWQgdmVyc2lvbnMgb2YgZG1hLWJ1ZiBBUEkg
ZnVuY3Rpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3Np
cGVua29AY29sbGFib3JhLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9taXNjL2Zhc3RycGMuYyB8IDYg
KysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9mYXN0cnBjLmMgYi9kcml2ZXJzL21pc2Mv
ZmFzdHJwYy5jCj4gaW5kZXggOTNlYmQxNzRkODQ4Li42ZmNmYjJlOWY3YTcgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9taXNjL2Zhc3RycGMuYwo+ICsrKyBiL2RyaXZlcnMvbWlzYy9mYXN0cnBjLmMK
PiBAQCAtMzEwLDggKzMxMCw4IEBAIHN0YXRpYyB2b2lkIGZhc3RycGNfZnJlZV9tYXAoc3RydWN0
IGtyZWYgKnJlZikKPiAgIAkJCQlyZXR1cm47Cj4gICAJCQl9Cj4gICAJCX0KPiAtCQlkbWFfYnVm
X3VubWFwX2F0dGFjaG1lbnQobWFwLT5hdHRhY2gsIG1hcC0+dGFibGUsCj4gLQkJCQkJIERNQV9C
SURJUkVDVElPTkFMKTsKPiArCQlkbWFfYnVmX3VubWFwX2F0dGFjaG1lbnRfdW5sb2NrZWQobWFw
LT5hdHRhY2gsIG1hcC0+dGFibGUsCj4gKwkJCQkJCSAgRE1BX0JJRElSRUNUSU9OQUwpOwo+ICAg
CQlkbWFfYnVmX2RldGFjaChtYXAtPmJ1ZiwgbWFwLT5hdHRhY2gpOwo+ICAgCQlkbWFfYnVmX3B1
dChtYXAtPmJ1Zik7Cj4gICAJfQo+IEBAIC03MjYsNyArNzI2LDcgQEAgc3RhdGljIGludCBmYXN0
cnBjX21hcF9jcmVhdGUoc3RydWN0IGZhc3RycGNfdXNlciAqZmwsIGludCBmZCwKPiAgIAkJZ290
byBhdHRhY2hfZXJyOwo+ICAgCX0KPiAgIAo+IC0JbWFwLT50YWJsZSA9IGRtYV9idWZfbWFwX2F0
dGFjaG1lbnQobWFwLT5hdHRhY2gsIERNQV9CSURJUkVDVElPTkFMKTsKPiArCW1hcC0+dGFibGUg
PSBkbWFfYnVmX21hcF9hdHRhY2htZW50X3VubG9ja2VkKG1hcC0+YXR0YWNoLCBETUFfQklESVJF
Q1RJT05BTCk7Cj4gICAJaWYgKElTX0VSUihtYXAtPnRhYmxlKSkgewo+ICAgCQllcnIgPSBQVFJf
RVJSKG1hcC0+dGFibGUpOwo+ICAgCQlnb3RvIG1hcF9lcnI7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
