Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE46C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 11:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 772EB6104F;
	Tue,  5 Jul 2022 11:39:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 772EB6104F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ERdvSHk2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7J_VjWdZ_HVq; Tue,  5 Jul 2022 11:39:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 743A960E72;
	Tue,  5 Jul 2022 11:39:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 743A960E72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32801C0032;
	Tue,  5 Jul 2022 11:39:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 827A7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A68160E72
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A68160E72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YaEhH7QQI6fK
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:39:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07EFC60F10
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07EFC60F10
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 11:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwIx9mx/0TyfwGU/h6nnC6NamuuLlMxx9EabhZJo8UyQeIwoKY2dmwM2sLy+bcHeBnJe0Xyir/ay8StyDohBlQfBofMTKnRUNvjO0zvwsI6AyQdNkeqAHsK6PjtNFMpQwXNx/XJOwECi4oh6lXCLecZMTUBIrLz3Bfv2kj/opCS9HOFNkZAwhyoLGoC1hrG803jExd/LOUJP1gW8mjtAa3KLZTLaJeoawKhdyzcfeQYWLrHheVVID7CivHPXg2T1M+g+gUNgWjJdMmyO45mIGxlQcgnE141XvblJ5AK8QPdBVdS9PNhrLFZkihCjjdRbLN8zxuJ+WmAqnaHdBlccAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DelXAiXGlRk2fvklJFbMtwD03U+BlcNKX6rBMkC+Bog=;
 b=dhQF1QYunGhYPKZ7AXD9Uqf4lBW7FN4zzFE8lbbViV8HCug4Z4Ew29wych5FZrW5B3fq2gm/3z1DTaWJ4ImCbE889Vsv615RUGaUNbWtQYozp6o/BssvCT2n8TB1vUu+7lL9U0Wx2j3cJBy9UQcRumTZeUDvMdb1mywRyGR41gpNk8q8oWfBJxi3c7wm5Li8gk+jljqWRFHYxLx+YxofCFzO/22rqAz9GVv6aHPaMH3zOAYvfRJAo6g/H5dIAS+YyM3oBjmu6Em2W3ULrhQuOWCkDI3Bdb0vn+suvIpNiHHWziXW/q7ZNCc1I66yPmKoOExvlvQ7LMtW1u49j093RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DelXAiXGlRk2fvklJFbMtwD03U+BlcNKX6rBMkC+Bog=;
 b=ERdvSHk2iGUleAGTWkVf7m38KUzCtnOwtp8C5HbR+98EkLg4Apcd9QjD9ZO2EphLoHnoy4ibjJ49h/vn3Q/Xaz5voQSoCb3ImVJimzM1Rs+6UY6ho9k+jwXpc4FL4EYvY3DN+e60Yg6Oc+qotumR+DVMrihqSU5ATdVCNqpO2z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 11:39:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 11:39:28 +0000
Message-ID: <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
Date: Tue, 5 Jul 2022 13:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
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
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
In-Reply-To: <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 338052e8-da48-42ec-1e94-08da5e7b0493
X-MS-TrafficTypeDiagnostic: DM4PR12MB5134:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyccyBLXdTD266a08cWaMRDyeZSrWSYubPUefUJy8Srck42wiYv4IHcbkJdsRluMLoTadhBGKDMZU5CZAXAS/4VrSYCYMedIwYLTDnjvdgIvxG0gV/0SW7A40XqumyF/KcBt/ggO1UvWdcsXtura/Ej7441xftKUg2pZ4yVeclkqA4S6fDLp/KpLnq2fKM1XHzamwaRsgh8BsHiS77JCtbETUQW/KQqzDL07qhtrY/0JOmNqtaKJvdCuE7/xO2go+EE7e8757aj4lYY/Ol5SMyjC4QU1+Q09bxGFlm/8kgBwBxCXBboMY0kXK1ztoZ7J9+guHb9q6MUkiPJxOZqc0/sitnbNBnm6DC+/R5TgOzvi5GyNNTd0gKEamGaD2pjzYstJ1sxN17w62f5Y/Du8Ug9gGDH9NJS9i2P5HsT4gg5JOIFLBDscKX6yak2fk8M/9oA9kdn4tEszcPymfB3GHEGT1n1PQyhLFt67l+4plzzJWXvbDDp2suRgnuOe1DOr3IiQzO6lj09y+cWKbkDf6OMK9Ot4i66XlT+9etWw5TzPvHByCPmoz82po6Kcw+LOZ3TyzvFmVEdwogg8PZVK4qPtr7fmGlp7g89gzgcX+2uUAj8gd+cELA9Tbk246WZmKWxWNyGOv50nuRZ1RuBjThWY1BsPDwH2T6kmm9wpwl9brnCdL2fBIZ0EonWyFHsIc+6Fpt0uo394ajrucjTjf/y+cZy6b3vR+F4gfPcnO0m1S2aNcbCD0332ORzKJi0XbNDOI8zGKAzvAwoI3kUtDc7BZAyRpFX7keJdi6RtmNkmjbar0QA2WZmds9pEhG0rMluVPRoMkhjZzkyiixVyz9/3Sl8aSpgwaDTdxpa9UyLEW+zbFXGVl5Cd0K6ZGFly
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(8936002)(7416002)(5660300002)(66574015)(4326008)(8676002)(66476007)(66556008)(66946007)(86362001)(41300700001)(921005)(31696002)(6666004)(110136005)(316002)(186003)(26005)(36756003)(6512007)(2616005)(6506007)(6486002)(2906002)(38100700002)(31686004)(83380400001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lZMnBqZDRGMVhoN05qNUZNTy9YdCt1d2hpdUFBbHF2YllJa3YxWFJFYm1P?=
 =?utf-8?B?VmNVU2RTQW0zaTM2dTBzVW5ZKzIrdjRFdEZjeW5ReHE2dFU3MTROT0pVMklN?=
 =?utf-8?B?UW5McS9IMlBzWDV0bE8zanYvemROcUcrSTR1Vnh6TEdMQWMwOFZYNTM3T0ll?=
 =?utf-8?B?aXBjSlp6L3RNeGFyeGt2YTdhLzRMcnRZT2ZBa0FLZFFlUEk2aENhaFg4NmlX?=
 =?utf-8?B?c1lVcVJOdUo3MjhaWkl4RUV6dHRnZGdzWEJYUHkweXZUVDVvUGZtdjU0WVg4?=
 =?utf-8?B?MG5GOXJvQ3B3RUd2TGszb1YzeTJuSkltOGpPdS9ReXJta3R1L2xFLzlueE42?=
 =?utf-8?B?ckdyOUx2QVBJUStVUUxxd044MUxEcUdSK0pLVlRUdkdLUCs4VW9vN25PWnUv?=
 =?utf-8?B?VEVyTGZRQjlQL001djJCemdpQjMwR0krZCtwQ0VmQ1dwMVNmQk9IWUNvbTdE?=
 =?utf-8?B?Zzk4SFpMYkxyRUhjdTkwVFFmN2lJa25NL3VldEFNNXJicWZOK29WVnFnZ3NF?=
 =?utf-8?B?K21LcFozS2ROaGtJa3BUVG01d1QyRzdzdHZURVBNSlF0U2sxZmhxaW1zb3pJ?=
 =?utf-8?B?eTA2RTh2aTF6N0VWMFhkUVBrRW5WUmU4aDZicFhSUVlDdWVqSXVqNVJjS1p6?=
 =?utf-8?B?Q0NzbWdMcS9ha3ZJZkdmYXQ3SHBYSUlMNlc5NEJuVTNLQldQM0tNblE2Y0Vt?=
 =?utf-8?B?WW9QV2YwWlJSb2VJZWtiejJNdjZmU2F3M1pTOTBRcnNxL0NsclliSmh3TERZ?=
 =?utf-8?B?UmtLRHBsMk03R3JybUg1aWp1RDlWRGRMcW8zODJQa0tPVUFWNUx5RUpNYk9H?=
 =?utf-8?B?KzBDSlJxQkxvWEFSb3UxQTFpQTU1c0grRmVDWWFiaXNuRFZhdmU3TU1jMlY0?=
 =?utf-8?B?SjhkQUNvVGNFZmJXcmo1RzR0dkVqMFhKU2UybTkzTHdubjIzdjdOVkliQlZa?=
 =?utf-8?B?ZnN2dEYvMjhEZDI0TWxJN3NvU1ZJcnZieGlHNE9GVXVrRlBid2RJdVc0NWtj?=
 =?utf-8?B?RFlsRDlERG4wOHFwRlQrb0QxbktNcThoUm03enhJMDVMRFFseGFUSTZaUzlZ?=
 =?utf-8?B?bDB2UU9zYnAzcnV0U096UXhJS3NEV0tZejdTdzRQNS9idFlpUE4wYUJ5aS9B?=
 =?utf-8?B?cWpZZDdydTZQZ1VacWNtdUo4K0s4bGlJZ3ZmVkhmMjM0cFVuSkNiTzlTK2pr?=
 =?utf-8?B?ODZKWGVGN3ZKRGpJeFk5Y2oxL1RjTGdOTUhhLzhiWnhad0Z6cXZ4ZVI1dFZG?=
 =?utf-8?B?MkdCMm83MXhkY3BtVXN6bHBNRzcySTRrM1FpOFVQYTlqSTFZKzNhWUZDdGJ5?=
 =?utf-8?B?dGtrTGErbXNVeDhPT3M4eHBQL1R3OHEvRHkwdEN1TzhGaHJCTkNoM0tOVFc4?=
 =?utf-8?B?U0F2Qk00aWN2SnZXakJSV1ZJeURVdVBwTDNxRk9taXcydGtkZHBxZm0vdk5t?=
 =?utf-8?B?OERuQ2FPUk8zVDdpRlVQRXZMYiswSTA2bjl0QkR3MktQQ3NoM2JYTlNkQjAw?=
 =?utf-8?B?TzVtenJxQlVvVUtHaHFVL0xPZ2poYmRqM3JFTVhwUzNoemxJam55K3RQNm9s?=
 =?utf-8?B?VFdqejZsYnQxck9HZkNtd0w0c05OR1I4enpqZkZUYXdhUGdISXlRN1dTdzBU?=
 =?utf-8?B?OC9WMlZpcmFlUjhNVStkbUZHeVNIZ3lrU253Ym9jdkEzSEprV2R6R01kNCtl?=
 =?utf-8?B?SmdFdVhDOVROK3dTMXdTVkQ4TTliQUh5Nm1qbm5qZFBvOHA4NCtLSmZYYW1T?=
 =?utf-8?B?bEllSzNtQnJUcXYyOUd0dGdlODVDNWxTZStPZVc2SUhuSmYvcytKbWpBNUNC?=
 =?utf-8?B?SDk2QUpjZ2ZCNFpuaEJublQ2Y2RPQ2Y4VndacW12QUdZTHphd29seDdGSERs?=
 =?utf-8?B?WkFMZ09lRHFXTzVvUnFBVDE5TFVUTmh6c0pFend1dlJmSlIzOC9Sc05jb2V5?=
 =?utf-8?B?WFVrV0RpMVVIdHBVOTlWbTJpMVhmcXh5T0lmb1BkT0ZZUnNsMWJEV3dTSHFM?=
 =?utf-8?B?SDJxRldYOTF5V0FWWm5VMzFIL0NINWdFVHZDcWNFNVoveExlMXU3cHYyczhn?=
 =?utf-8?B?QTUxbWxYaGtadDc2ckljbUhjcTc4T2dDSGFCRVdZc01rZllvWmtBWVc1bE9R?=
 =?utf-8?Q?J3u/J4OOsNmhhd4mVxEdC4n5M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338052e8-da48-42ec-1e94-08da5e7b0493
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 11:39:27.9272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhrDG4CkCs7BPCqORgpsPG3xyRFbBDynlhHUnJXvjofnxQa9vgRVq86jm44x9Jg5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
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

QW0gMDEuMDcuMjIgdW0gMTE6MDIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gRHJpdmVycyB0
aGF0IHVzZSBkcm1fZ2VtX21tYXAoKSBhbmQgZHJtX2dlbV9tbWFwX29iaigpIGhlbHBlcnMgZG9u
J3QKPiBoYW5kbGUgaW1wb3J0ZWQgZG1hLWJ1ZnMgcHJvcGVybHksIHdoaWNoIHJlc3VsdHMgaW4g
bWFwcGluZyBvZiBzb21ldGhpbmcKPiBlbHNlIHRoYW4gdGhlIGltcG9ydGVkIGRtYS1idWYuIE9u
IE5WSURJQSBUZWdyYSB3ZSBnZXQgYSBoYXJkIGxvY2t1cCB3aGVuCj4gdXNlcnNwYWNlIHdyaXRl
cyB0byB0aGUgbWVtb3J5IG1hcHBpbmcgb2YgYSBkbWEtYnVmIHRoYXQgd2FzIGltcG9ydGVkIGlu
dG8KPiBUZWdyYSdzIERSTSBHRU0uCj4KPiBNYWpvcml0eSBvZiBEUk0gZHJpdmVycyBwcm9oaWJp
dCBtYXBwaW5nIG9mIHRoZSBpbXBvcnRlZCBHRU0gb2JqZWN0cy4KPiBNYXBwaW5nIG9mIGltcG9y
dGVkIEdFTXMgcmVxdWlyZSBzcGVjaWFsIGNhcmUgZnJvbSB1c2Vyc3BhY2Ugc2luY2UgaXQKPiBz
aG91bGQgc3luYyBkbWEtYnVmIGJlY2F1c2UgbWFwcGluZyBjb2hlcmVuY3kgb2YgdGhlIGV4cG9y
dGVyIGRldmljZSBtYXkKPiBub3QgbWF0Y2ggdGhlIERSTSBkZXZpY2UuIExldCdzIHByb2hpYml0
IHRoZSBtYXBwaW5nIGZvciBhbGwgRFJNIGRyaXZlcnMKPiBmb3IgY29uc2lzdGVuY3kuCj4KPiBT
dWdnZXN0ZWQtYnk6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4Lmlu
dGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5r
b0Bjb2xsYWJvcmEuY29tPgoKSSdtIHByZXR0eSBzdXJlIHRoYXQgdGhpcyBpcyB0aGUgcmlnaHQg
YXBwcm9hY2gsIGJ1dCBpdCdzIGNlcnRhaW5seSBtb3JlIAp0aGFuIHBvc3NpYmxlIHRoYXQgc29t
ZWJvZHkgYWJ1c2VkIHRoaXMgYWxyZWFkeS4KCkFueXdheSBwYXRjaCBpcyBSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiAKc2luY2UgeW91IGFy
ZSByZWFsbHkgZml4aW5nIGEgbWFqb3Igc3RhYmlsaXR5IHByb2JsZW0gaGVyZS4KClJlZ2FyZHMs
CkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jICAgICAgICAg
ICAgICB8IDQgKysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVyLmMg
fCA5IC0tLS0tLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiBpbmRleCA4NmQ2NzBjNzEyODYuLmZjOWVjNDJmYTBh
YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2RybV9nZW0uYwo+IEBAIC0xMDM0LDYgKzEwMzQsMTAgQEAgaW50IGRybV9nZW1f
bW1hcF9vYmooc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosIHVuc2lnbmVkIGxvbmcgb2JqX3Np
emUsCj4gICB7Cj4gICAJaW50IHJldDsKPiAgIAo+ICsJLyogRG9uJ3QgYWxsb3cgaW1wb3J0ZWQg
b2JqZWN0cyB0byBiZSBtYXBwZWQgKi8KPiArCWlmIChvYmotPmltcG9ydF9hdHRhY2gpCj4gKwkJ
cmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICAgCS8qIENoZWNrIGZvciB2YWxpZCBzaXplLiAqLwo+ICAg
CWlmIChvYmpfc2l6ZSA8IHZtYS0+dm1fZW5kIC0gdm1hLT52bV9zdGFydCkKPiAgIAkJcmV0dXJu
IC1FSU5WQUw7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hl
bHBlci5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVyLmMKPiBpbmRleCA4
YWQwZTAyOTkxY2EuLjYxOTBmNTAxODk4NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2dlbV9zaG1lbV9oZWxwZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3No
bWVtX2hlbHBlci5jCj4gQEAgLTYwOSwxNyArNjA5LDggQEAgRVhQT1JUX1NZTUJPTF9HUEwoZHJt
X2dlbV9zaG1lbV92bV9vcHMpOwo+ICAgICovCj4gICBpbnQgZHJtX2dlbV9zaG1lbV9tbWFwKHN0
cnVjdCBkcm1fZ2VtX3NobWVtX29iamVjdCAqc2htZW0sIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hKQo+ICAgewo+IC0Jc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSAmc2htZW0tPmJhc2U7
Cj4gICAJaW50IHJldDsKPiAgIAo+IC0JaWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgewo+IC0JCS8q
IERyb3AgdGhlIHJlZmVyZW5jZSBkcm1fZ2VtX21tYXBfb2JqKCkgYWNxdWlyZWQuKi8KPiAtCQlk
cm1fZ2VtX29iamVjdF9wdXQob2JqKTsKPiAtCQl2bWEtPnZtX3ByaXZhdGVfZGF0YSA9IE5VTEw7
Cj4gLQo+IC0JCXJldHVybiBkbWFfYnVmX21tYXAob2JqLT5kbWFfYnVmLCB2bWEsIDApOwo+IC0J
fQo+IC0KPiAgIAlyZXQgPSBkcm1fZ2VtX3NobWVtX2dldF9wYWdlcyhzaG1lbSk7Cj4gICAJaWYg
KHJldCkgewo+ICAgCQlkcm1fZ2VtX3ZtX2Nsb3NlKHZtYSk7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
