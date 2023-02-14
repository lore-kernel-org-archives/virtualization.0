Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8FEC61DA4
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 13:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C55F60B89;
	Tue, 14 Feb 2023 13:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C55F60B89
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a9hxGbNm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ka69Jw0OOsHI; Tue, 14 Feb 2023 13:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D373D60C04;
	Tue, 14 Feb 2023 13:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D373D60C04
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D156C0032;
	Tue, 14 Feb 2023 13:59:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8463DC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 13:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F34F80D7E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 13:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F34F80D7E
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=a9hxGbNm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FjC7czWx_m84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 13:59:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0919C80C98
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0919C80C98
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 13:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0vuYf8UOaJ1hsTXinVLDnk7BpyFeAO3h0A+iDuVzCO2q8DG4WuwhkqMMJTjseQv7q0EMv6FZx65wne6HTsK3PnbgbT77mmrdMOze2o6TsaPs8S3y61N0hdC3q0qPXXY1/o7+eM48riYNwPnPuOhj7dZSlGb2IYNoIH9774fsWFbFzrIWRJoPnr2mucRIEiPpXUTvFi1S8Hvy/OZ9pp3SNqitPwUeFHXjFR72asMWQMgruvqlAjUNhHtPMCqEhmo07ew4v3qBwm6m0WG4xUJMcThnFen/vl/O0sXYUT7IjauH0gm32ESHaQJJJlAUn3t69YyYMdq6be9AyE+PYvd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5J3EwnAfqcroXmVU+6Cy2FNea1vMFGSWLx6pXlj8fPc=;
 b=Ju8JxyqlxQqwYCTlQm/xC8eM3bMOmpr//U0ybnkKtLZRD87B401egog/lNXKe9np0NTH3/xczf1+u6Ji+Lg2frkbYNf9GYmP4Tw01J7h15CxaO7DcriWnmAI8Mn0RZevCV5h28e2GYlfFs/60FHMhv/OF8RL4uSJX4t2Ikr7cUHOrMHsAjdQbUyka/meDm5ZcMB8/yH2+0lJ4LxRSOmEJyGNREgaKXoyMG3Pue7aIHKXuqYhylfP8D3Y8oiH7lTEAZAzGMcMrNwH+t36DS/7Zpda4oIoEoFGK6Vz5XxFRbcgGawNgoKsVfNqlE14cyqlefLLOg5LU00ny39HeocxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J3EwnAfqcroXmVU+6Cy2FNea1vMFGSWLx6pXlj8fPc=;
 b=a9hxGbNmSW7MJaTKEuPBpcmw9mut/QbttnqJve0NugeGhnEmSVeP4BSRhiZC3W4jgnz59jvxavUpBZNfcP1iJXvJiujW5iiB1Md2X8x6n9Dj+FIYDzKmYh/DoHw9QH8qwOtOLBkkRFhzdRuBNVx296UzOdWX0GAG0Is9ZBqScvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Tue, 14 Feb
 2023 13:59:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 13:59:45 +0000
Message-ID: <f1256a51-5c4d-ab44-3867-931f7d2c0695@amd.com>
Date: Tue, 14 Feb 2023 14:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/gem: Expose the buffer object handle to userspace last
Content-Language: en-US
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org
References: <20230214125050.1205394-1-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20230214125050.1205394-1-tvrtko.ursulin@linux.intel.com>
X-ClientProxiedBy: FR3P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec58fab-f6c1-4ac4-6a38-08db0e93ba60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OEbT8BHCKauSFGaRyjwXGMvv8hd2oEXpw7iWfZwFq8PLwJ+gU1DCU5azbPGWht56jn6GMGzmxLIRbxTRQ/IwiEMVsfHKyv8JMaJhqHlMddMjULfrgsKVj2wS6yU9Hn3tn1D2P1CvxhPwxiZPwQ0dSQB2CIlEbk8OyEPiRAHd3FCiZBLAqo8ttAFakW58bUuCDILT2oBfwP0YoHOyR1QBaIBK+B06YQ2slWCKwL+tDzWl8tk4Xtx44boc9i/y48Qp/wGqb0Qr1iGZ+FjDcjVB5eBurpCvW+P3YOGlxIkUqxyzQrc8W6qJomMjKY/5TW//A2shN1DrlEjYooJDCwxkrN/piuq7812Xcl+rpEhy7um9WZR5pi1OimX+QFYzl6tIV4CpvYTAUJ6MQceX5PksBYqa0oG8jJRxD5aVgudLScKBbfjyED2jV+t0tH0nUc/OHGbjvoW8BGiOYnZq4Sv1/hITII8ZCPUy/ZIGP8j82ssPjCzcQ3QHHqSXE34pCy7nOu0AV0W9ZEJiDvvzyPE475wGMwBpZaD7Yyy/exDZySADKpcZWANRDcrwXMvkZRoWgB9j1abhAXyBKVYorj5fk8Mo0P+hwlmIMaxxOoMZEBula/+cky0L7Ya0+2CdKM7Lb+WlvBeVE6m5jDY3XluIJX9F9lDxMwDD3oEyT2Rk6AJ0jz0yww4qBgw1QBhWyAKY689Cg1k2gAhKz9bps9fFugDqCqeJlHRRXEJg/iLiWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(2616005)(86362001)(31696002)(26005)(5660300002)(54906003)(6512007)(316002)(36756003)(6666004)(6486002)(478600001)(6506007)(7416002)(186003)(31686004)(38100700002)(66574015)(41300700001)(2906002)(83380400001)(66476007)(66946007)(8936002)(8676002)(4326008)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdPSkpRM2s4MEg4dGJRRG5URGdUZkI2RldsOWFvVStpVTV1bjI2ZUtzbmZ5?=
 =?utf-8?B?T3h2aUI3QU1sb0g3cTl1ZnpJWVNKMWNOT0tyZTJvQVp3WFl2YlM0cTRPVUJ2?=
 =?utf-8?B?cTZoRDQyQ0x1U3RPSWF6K09rdm0rR1hZNkpFS3RBQUV2Mm40SnloN0ZhbDZr?=
 =?utf-8?B?aDAwRGE1Z1IyQlB2NXVIU2dWZFkyTE4rMGZGVmhCZ3FzN0gzSStsRHVscFFP?=
 =?utf-8?B?OFgrVnpZSHFOYjdDSE16N2IzZHp4SWF6OUozQk9lMzJqdHdtYjhoVTVUdk1v?=
 =?utf-8?B?UnIxc1ljTEM5dk5ibFpTaXR5WGIwb01RWTBGYW9oSUJ3UTQ4Sm9HR3hMUytr?=
 =?utf-8?B?d0VxeS9MUnlwZjhqSkNCNGFWbUhtcW1OOXNjVGc5VkdvelJEdnhkSWtqUEJa?=
 =?utf-8?B?YncycXU1ejNGRTUvVDlZYmxXbTE5Z0RRMEVSVzFMRktKU21Lbk9haHNjWVdz?=
 =?utf-8?B?SEw3RHgySWgzVFZpb3BjZjhXTHdHUjM0VEtyRXdZbkVWeUhYVDdVdXVPQW40?=
 =?utf-8?B?QVpOUTRQL0FTR1lJSWNBK1BxOFZUVkprQW1ZaXh1NzNkZXJCTm1zblFzRm1l?=
 =?utf-8?B?M0JFdmlIeDFlcWdKSGdaZUxndzdmSVlkamd5YThGVzl5MzJYSFhORjRTbTNY?=
 =?utf-8?B?Y0Vnd1c5SysvMjJLZHRrWE54blhEYmwvaVhRbkpkOUxRTFRibmxyUkpYd1k0?=
 =?utf-8?B?RCszR2pKdzdHcEJWRWlqYzVaNVNjTVBGK05OMkZSNU9TeDdyUDlONTFneFBN?=
 =?utf-8?B?VnFSVjNUTEVWT0VXa2doNmJsOVFENXJ1WFo5dkkvS3NlYTNhUkpTeStYR09o?=
 =?utf-8?B?ODNsTDREKzA4VFB0d3NVdkVGRnJvWnN3RjViaDk1aTd2VEhtMlQ3RCtvUTlt?=
 =?utf-8?B?bTNObEgrUHN0TTE4R1k5N2h2YlV0SkxvRnRYUGVOcDcvVzJHQVg1WUZwR09q?=
 =?utf-8?B?SWIwM0Q0TUwydCs5d1psaGZVYXNqNzZDSzQrem1GdDJhQ2hrNUg1cW5NaFhv?=
 =?utf-8?B?ZFlpYTgvdjM1ME1iaGRVYlZxUWs4ZnhoYS9IWkZtb0hva0VJeW1BV3ZTUXJt?=
 =?utf-8?B?MEV5VGpiVDQzM05lbjRXOERyakRpRnYreE1OaXNOdGlyMy9Qc0UxM0NQS1BD?=
 =?utf-8?B?TUNsQTdSVGdUWlBBQkh6WE12SGtWLzRsSEI4YkJHNVVRMDgwWmdrdEVJU1d2?=
 =?utf-8?B?ZmUzOTVRQnpUMGg1dVU0dFUvWW5UeWE3U0tHWXNWWFIwN1pBZEZvcTFuR0Rj?=
 =?utf-8?B?b0NhMkNtWmlqaFg5RXg4K0VsUDBYb0tJUGVlbFM0NlNZaTJzTitxdXpWaWxr?=
 =?utf-8?B?OWJWckJrMUoxNHlJdzhxZlhqdW1xZDBIYjY3TjZJMThEMHN0bmd3aVh2aklz?=
 =?utf-8?B?WkhKTHc1bXpmcm4rRHR3QTdoSnN4bTVlVkNtekVCYm9kREpDNi9kSUdEZnhF?=
 =?utf-8?B?ZWZPdzhoLzB4YXdVSE84Ukx5R3dCVWhCQzlwS3h5eVlMd3RjbWE4S3dXanNM?=
 =?utf-8?B?QlZ1aitjRVM1SmtFNmVWcFcyc1VYQTk4ei9DTWhJeTFLdnVQOWZCVmxYY2w0?=
 =?utf-8?B?bVp6M1puMDlLWkN1UmVnVjdwUUZxb09qOGhzYTJ2bkVXMjdGejVybENZNHVv?=
 =?utf-8?B?cllZMDhSSmRaOWluRU5rdVlKTnFSQ3ROUzFidFg0ZDdrT0U2bUM1bTVackR0?=
 =?utf-8?B?U010UFc4ZVFaY29hM2xjK3ZDaWtJeEc0ZFpjcVFYYmk3S2dVZmNxOTFnS3V5?=
 =?utf-8?B?QXdFc0kvQUdqNjcrK3lnOXYzUVpJQ1lLTHVYWEVaNUwwc3ZyVXVZSks2QW54?=
 =?utf-8?B?SVFmZlJ3RER6dEFUL0xrZ3NMby9ST3llWk03Nlh5alNmWk93WGttUFRKMFpO?=
 =?utf-8?B?dnlBZEpIcURvWGQyMTc3RjYvN0pyQk5xeExmU1ZTYWJmTVlJdjFmUnBoQUJH?=
 =?utf-8?B?T0Iyb0Y0aXVJUFpzdWI1MmFuRmdUOVNacEk4SUFQSGhUcS9pNFlma0lweVBI?=
 =?utf-8?B?N2pORkJxV1lmeWtYT0xzbWwvekVSNGdpM1hubnJHSUdpZk5qc01KUCttc1Q5?=
 =?utf-8?B?WXlKRnIvSUxod0ZVWXIrS1hocFFIVXhhMmlSYmdOdjJReDJaK1hJVDd6QW5s?=
 =?utf-8?Q?XCeZjHTjvI3gnSOZtY0ChEkIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec58fab-f6c1-4ac4-6a38-08db0e93ba60
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 13:59:45.5731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BDvXdpGLdBK4tCURmduEUW8POFINqmtP3AnU+MMfMCWn/PecwPi+OVI4URtQHZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
Cc: Rob Clark <robdclark@chromium.org>, lima@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Herrmann <dh.herrmann@gmail.com>, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, David Airlie <airlied@gmail.com>,
 Zack Rusin <zackr@vmware.com>
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

QW0gMTQuMDIuMjMgdW0gMTM6NTAgc2NocmllYiBUdnJ0a28gVXJzdWxpbjoKPiBGcm9tOiBUdnJ0
a28gVXJzdWxpbiA8dHZydGtvLnVyc3VsaW5AaW50ZWwuY29tPgo+Cj4gQ3VycmVudGx5IGRybV9n
ZW1faGFuZGxlX2NyZWF0ZV90YWlsIGV4cG9zZXMgdGhlIGhhbmRsZSB0byB1c2Vyc3BhY2UKPiBi
ZWZvcmUgdGhlIGJ1ZmZlciBvYmplY3QgY29uc3RydWN0aW9ucyBpcyBjb21wbGV0ZS4gVGhpcyBh
bGxvd2luZwo+IG9mIHdvcmtpbmcgYWdhaW5zdCBhIHBhcnRpYWxseSBjb25zdHJ1Y3RlZCBvYmpl
Y3QsIHdoaWNoIG1heSBhbHNvIGJlIGluCj4gdGhlIHByb2Nlc3Mgb2YgaGF2aW5nIGl0cyBjcmVh
dGlvbiBmYWlsLCBjYW4gaGF2ZSBhIHJhbmdlIG9mIG5lZ2F0aXZlCj4gb3V0Y29tZXMuCj4KPiBB
IGxvdCBvZiB0aG9zZSB3aWxsIGRlcGVuZCBvbiB3aGF0IHRoZSBpbmRpdmlkdWFsIGRyaXZlcnMg
YXJlIGRvaW5nIGluCj4gdGhlaXIgb2JqLT5mdW5jcy0+b3BlbigpIGNhbGxiYWNrcywgYW5kIGFs
c28gd2l0aCBhIGNvbW1vbiBmYWlsdXJlIG1vZGUKPiBiZWluZyAtRU5PTUVNIGZyb20gZHJtX3Zt
YV9ub2RlX2FsbG93Lgo+Cj4gV2UgY2FuIG1ha2Ugc3VyZSBub25lIG9mIHRoaXMgY2FuIGhhcHBl
biBieSBhbGxvY2F0aW5nIGEgaGFuZGxlIGxhc3QsCj4gYWx0aG91Z2ggd2l0aCBhIGRvd25zaWRl
IHRoYXQgbW9yZSBvZiB0aGUgZnVuY3Rpb24gbm93IHJ1bnMgdW5kZXIgdGhlCj4gZGV2LT5vYmpl
Y3RfbmFtZV9sb2NrLgo+Cj4gTG9va2luZyBpbnRvIHRoZSBpbmRpdmlkdWFsIGRyaXZlcnMgb3Bl
bigpIGhvb2tzLCB3ZSBoYXZlCj4gYW1kZ3B1X2dlbV9vYmplY3Rfb3BlbiB3aGljaCBzZWVtcyBs
aWtlIGl0IGNvdWxkIGhhdmUgYSBwb3RlbnRpYWwgc2VjdXJpdHkKPiBpc3N1ZSB3aXRob3V0IHRo
aXMgY2hhbmdlLgo+Cj4gQSBjb3VwbGUgZHJpdmVycyBsaWtlIHF4bF9nZW1fb2JqZWN0X29wZW4g
YW5kIHZtd19nZW1fb2JqZWN0X29wZW4KPiBpbXBsZW1lbnQgbm8tb3AgaG9va3Mgc28gbm8gaW1w
YWN0IGZvciB0aGVtLgo+Cj4gQSBidW5jaCBvZiBvdGhlciByZXF1aXJlIGEgZGVlcGVyIGxvb2sg
YnkgaW5kaXZpZHVhbCBvd25lcnMgdG8gYXNzZXMgZm9yCj4gaW1wYWN0LiBUaG9zZSBhcmUgbGlt
YV9nZW1fb2JqZWN0X29wZW4sIG5vdXZlYXVfZ2VtX29iamVjdF9vcGVuLAo+IHBhbmZyb3N0X2dl
bV9vcGVuLCByYWRlb25fZ2VtX29iamVjdF9vcGVuIGFuZCB2aXJ0aW9fZ3B1X2dlbV9vYmplY3Rf
b3Blbi4KPgo+IFB1dHRpbmcgYXNpZGUgdGhlIHJpc2sgYXNzZXNtZW50IG9mIHRoZSBhYm92ZSwg
c29tZSBjb21tb24gc2NlbmFyaW9zIHRvCj4gdGhpbmsgYWJvdXQgYXJlIGFsb25nIHRoZXNlIGxp
bmVzOgo+Cj4gMSkKPiBVc2Vyc3BhY2UgY2xvc2VzIGEgaGFuZGxlIGJ5IHNwZWN1bGF0aXZlbHkg
Imd1ZXNzaW5nIiBpdCBmcm9tIGEgc2Vjb25kCj4gdGhyZWFkLgo+Cj4gVGhpcyByZXN1bHRzIGlu
IGFuIHVucmVhY2hhYmxlIGJ1ZmZlciBvYmplY3Qgc28sIGEgbWVtb3J5IGxlYWsuCj4KPiAyKQo+
IFNhbWUgYXMgMSksIGJ1dCBvYmplY3QgaXMgaW4gdGhlIHByb2Nlc3Mgb2YgZ2V0dGluZyBjbG9z
ZWQgKGZhaWxlZAo+IGNyZWF0aW9uKS4KPgo+IFRoZSBzZWNvbmQgdGhyZWFkIGlzIHRoZW4gYWJs
ZSB0byByZS1jeWNsZSB0aGUgaGFuZGxlIGFuZCBpZHJfcmVtb3ZlIHdvdWxkCj4gaW4gdGhlIGZp
cnN0IHRocmVhZCB3b3VsZCB0aGVuIHJlbW92ZSB0aGUgaGFuZGxlIGl0IGRvZXMgbm90IG93biBm
cm9tIHRoZQo+IGlkci4KPgo+IDMpCj4gR29pbmcgYmFjayB0byB0aGUgZWFybGllciBwZXIgZHJp
dmVyIHByb2JsZW0gc3BhY2UgLSBpbmRpdmlkdWFsIGltcGFjdAo+IGFzc2VzbWVudCBvZiBhbGxv
d2luZyBhIHNlY29uZCB0aHJlYWQgdG8gYWNjZXNzIGFuZCBvcGVyYXRlIG9uIGEgcGFydGlhbGx5
Cj4gY29uc3RydWN0ZWQgaGFuZGxlIC8gb2JqZWN0LiAoQ2FuIHNvbWV0aGluZyBjcmFzaD8gTGVh
ayBpbmZvcm1hdGlvbj8pCj4KPiBJbiB0ZXJtcyBvZiBpZGVudGlmeWluZyB3aGVuIHRoZSBwcm9i
bGVtIHN0YXJ0ZWQgSSB3aWxsIHRhZyBzb21lIHBhdGNoZXMKPiBhcyByZWZlcmVuY2VzLCBidXQg
bm90IGFsbCwgaWYgZXZlbiBhbnksIG9mIHRoZW0gYWN0dWFsbHkgcG9pbnQgdG8gYQo+IGJyb2tl
biBzdGF0ZS4gSSBhbSBqdXN0IGlkZW50aWZ5aW5nIHBvaW50cyBhdCB3aGljaCBtb3JlIG9wcG9y
dHVuaXR5IGZvcgo+IGlzc3VlcyB0byBhcmlzZSB3YXMgYWRkZWQuCgpZZXMgSSd2ZSBsb29rZWQg
aW50byB0aGlzIG9uY2UgYXMgd2VsbCwgYnV0IGNvdWxkbid0IGNvbXBsZXRlbHkgc29sdmUgaXQg
CmZvciBzb21lIHJlYXNvbi4KCkdpdmUgbWUgYSBkYXkgb3IgdHdvIHRvIGdldCB0aGlzIHRlc3Rl
ZCBhbmQgYWxsIHRoZSBsb2dpYyBzd2FwcGVkIGJhY2sgCmludG8gbXkgaGVhZCBhZ2Fpbi4KCkNo
cmlzdGlhbi4KCj4KPiBSZWZlcmVuY2VzOiAzMDRlZGEzMjkyMGIgKCJkcm0vZ2VtOiBhZGQgaG9v
a3MgdG8gbm90aWZ5IGRyaXZlciB3aGVuIG9iamVjdCBoYW5kbGUgaXMgY3JlYXRlZC9kZXN0cm95
ZWQiKQo+IFJlZmVyZW5jZXM6IGNhNDgxYzliMmEzYSAoImRybS9nZW06IGltcGxlbWVudCB2bWEg
YWNjZXNzIG1hbmFnZW1lbnQiKQo+IFJlZmVyZW5jZXM6IGIzOWI1Mzk0ZmFiYyAoImRybS9nZW06
IEFkZCBkcm1fZ2VtX29iamVjdF9mdW5jcyIpCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBDYzogUm9iIENsYXJrIDxyb2JkY2xhcmtAY2hyb21pdW0ub3JnPgo+IENjOiBC
ZW4gU2tlZ2dzIDxic2tlZ2dzQHJlZGhhdC5jb20+Cj4gQ2M6IERhdmlkIEhlcnJtYW5uIDxkaC5o
ZXJybWFubkBnbWFpbC5jb20+Cj4gQ2M6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMu
b3JnPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPgo+IENjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gQ2M6IGxpbWFAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IG5vdXZlYXVAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+
Cj4gQ2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gQ2M6IHNw
aWNlLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBaYWNrIFJ1c2luIDx6YWNrckB2
bXdhcmUuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyB8IDQ4ICsrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9kcm1fZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4gaW5kZXggYWEx
NWM1MmFlMTgyLi5lM2Q4OTdiY2EwZjIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ry
bV9nZW0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiBAQCAtMzU2LDUyICsz
NTYsNTIgQEAgZHJtX2dlbV9oYW5kbGVfY3JlYXRlX3RhaWwoc3RydWN0IGRybV9maWxlICpmaWxl
X3ByaXYsCj4gICAJCQkgICB1MzIgKmhhbmRsZXApCj4gICB7Cj4gICAJc3RydWN0IGRybV9kZXZp
Y2UgKmRldiA9IG9iai0+ZGV2Owo+IC0JdTMyIGhhbmRsZTsKPiAgIAlpbnQgcmV0Owo+ICAgCj4g
ICAJV0FSTl9PTighbXV0ZXhfaXNfbG9ja2VkKCZkZXYtPm9iamVjdF9uYW1lX2xvY2spKTsKPiAg
IAlpZiAob2JqLT5oYW5kbGVfY291bnQrKyA9PSAwKQo+ICAgCQlkcm1fZ2VtX29iamVjdF9nZXQo
b2JqKTsKPiAgIAo+ICsJcmV0ID0gZHJtX3ZtYV9ub2RlX2FsbG93KCZvYmotPnZtYV9ub2RlLCBm
aWxlX3ByaXYpOwo+ICsJaWYgKHJldCkKPiArCQlnb3RvIGVycl9wdXQ7Cj4gKwo+ICsJaWYgKG9i
ai0+ZnVuY3MtPm9wZW4pIHsKPiArCQlyZXQgPSBvYmotPmZ1bmNzLT5vcGVuKG9iaiwgZmlsZV9w
cml2KTsKPiArCQlpZiAocmV0KQo+ICsJCQlnb3RvIGVycl9yZXZva2U7Cj4gKwl9Cj4gKwo+ICAg
CS8qCj4gLQkgKiBHZXQgdGhlIHVzZXItdmlzaWJsZSBoYW5kbGUgdXNpbmcgaWRyLiAgUHJlbG9h
ZCBhbmQgcGVyZm9ybQo+IC0JICogYWxsb2NhdGlvbiB1bmRlciBvdXIgc3BpbmxvY2suCj4gKwkg
KiBHZXQgdGhlIHVzZXItdmlzaWJsZSBoYW5kbGUgdXNpbmcgaWRyIGFzIHRoZSBfbGFzdF8gc3Rl
cC4KPiArCSAqIFByZWxvYWQgYW5kIHBlcmZvcm0gYWxsb2NhdGlvbiB1bmRlciBvdXIgc3Bpbmxv
Y2suCj4gICAJICovCj4gICAJaWRyX3ByZWxvYWQoR0ZQX0tFUk5FTCk7Cj4gICAJc3Bpbl9sb2Nr
KCZmaWxlX3ByaXYtPnRhYmxlX2xvY2spOwo+IC0KPiAgIAlyZXQgPSBpZHJfYWxsb2MoJmZpbGVf
cHJpdi0+b2JqZWN0X2lkciwgb2JqLCAxLCAwLCBHRlBfTk9XQUlUKTsKPiAtCj4gICAJc3Bpbl91
bmxvY2soJmZpbGVfcHJpdi0+dGFibGVfbG9jayk7Cj4gICAJaWRyX3ByZWxvYWRfZW5kKCk7Cj4g
ICAKPiAtCW11dGV4X3VubG9jaygmZGV2LT5vYmplY3RfbmFtZV9sb2NrKTsKPiAgIAlpZiAocmV0
IDwgMCkKPiAtCQlnb3RvIGVycl91bnJlZjsKPiAtCj4gLQloYW5kbGUgPSByZXQ7Cj4gKwkJZ290
byBlcnJfY2xvc2U7Cj4gICAKPiAtCXJldCA9IGRybV92bWFfbm9kZV9hbGxvdygmb2JqLT52bWFf
bm9kZSwgZmlsZV9wcml2KTsKPiAtCWlmIChyZXQpCj4gLQkJZ290byBlcnJfcmVtb3ZlOwo+ICsJ
bXV0ZXhfdW5sb2NrKCZkZXYtPm9iamVjdF9uYW1lX2xvY2spOwo+ICAgCj4gLQlpZiAob2JqLT5m
dW5jcy0+b3Blbikgewo+IC0JCXJldCA9IG9iai0+ZnVuY3MtPm9wZW4ob2JqLCBmaWxlX3ByaXYp
Owo+IC0JCWlmIChyZXQpCj4gLQkJCWdvdG8gZXJyX3Jldm9rZTsKPiAtCX0KPiArCSpoYW5kbGVw
ID0gcmV0Owo+ICAgCj4gLQkqaGFuZGxlcCA9IGhhbmRsZTsKPiAgIAlyZXR1cm4gMDsKPiAgIAo+
ICtlcnJfY2xvc2U6Cj4gKwlpZiAob2JqLT5mdW5jcy0+Y2xvc2UpCj4gKwkJb2JqLT5mdW5jcy0+
Y2xvc2Uob2JqLCBmaWxlX3ByaXYpOwo+ICAgZXJyX3Jldm9rZToKPiAgIAlkcm1fdm1hX25vZGVf
cmV2b2tlKCZvYmotPnZtYV9ub2RlLCBmaWxlX3ByaXYpOwo+IC1lcnJfcmVtb3ZlOgo+IC0Jc3Bp
bl9sb2NrKCZmaWxlX3ByaXYtPnRhYmxlX2xvY2spOwo+IC0JaWRyX3JlbW92ZSgmZmlsZV9wcml2
LT5vYmplY3RfaWRyLCBoYW5kbGUpOwo+IC0Jc3Bpbl91bmxvY2soJmZpbGVfcHJpdi0+dGFibGVf
bG9jayk7Cj4gLWVycl91bnJlZjoKPiAtCWRybV9nZW1fb2JqZWN0X2hhbmRsZV9wdXRfdW5sb2Nr
ZWQob2JqKTsKPiArZXJyX3B1dDoKPiArCWlmICgtLW9iai0+aGFuZGxlX2NvdW50ID09IDApCj4g
KwkJZHJtX2dlbV9vYmplY3RfcHV0KG9iaik7Cj4gKwo+ICsJbXV0ZXhfdW5sb2NrKCZkZXYtPm9i
amVjdF9uYW1lX2xvY2spOwo+ICsKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+ICAgCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
