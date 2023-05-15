Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0271BC7EE24
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 20:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78C7E6145D;
	Mon, 15 May 2023 20:41:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78C7E6145D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lZxlQ4Eu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfzh4NgaiZxn; Mon, 15 May 2023 20:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C4DC860D4C;
	Mon, 15 May 2023 20:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4DC860D4C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91D15C0037;
	Mon, 15 May 2023 20:41:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A15E1C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 20:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6615341C03
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 20:41:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6615341C03
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lZxlQ4Eu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 76osydYgaVHV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 20:41:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD80741BF4
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::618])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD80741BF4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 20:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBJDtb/91sjMgr5w0PVOjMXteIinqU1VTBNL0CUB0/FFniM1zJMDkYz2NSYXoDk6SaSqcoxGydlubHXPHodIgWyaUskawCLxEhI2jAz2cMC+6crlfJPAi6IM0WFwqVtpYr7NT8ib+AcE7QS1S956nZ6t441GQRiaPXh71YlYu3hVxQR1jcA71XohmMzAXnUTT6+k0n82bym5ed050eBNqj5w1d7ZBTKJ7lVCvzNMIabEpHRzLgTzHhQv3HN2SzQwpuhvHsZhvk+zyEKFh9RGrse+Bq3vC+/PUBnIaQGeDEvyUSyyG+hgdm6wt3I9GKmz3EQddiWAjvLyoHs7WeeLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q3cqYtMlrIJ6B93ma9EqEpxQou8H7e/8iSjSeqzZwY=;
 b=Yi/dXoPNCkTG23e0gq7K2EKEmNvHXcFWpqyDDtXYZR0kuFIFqM/ZfsHGJC5YN99lbfoPNq7V06wdCXG+y5oJhdiKqIYEbw9LzvSbA0LhXLQtiVymw4DyixRrc1gEHtkqh5W3zp/x142bmCxRvU/FR8ggj9i0F7t+/9tgfs/y0eRkwu6nKCrC1SPiIfdELhvd01VcWNjPxrHiZj684mgenLZl/dpKGlb8/hNpCzEysLQBGtMEUoCKYiMdif7hqtFoc3CLtkChOTG8qyvgdhY09WWzMuwdOCYmMDzPlMcFv44pSvUajY4HWGKILFNeSPgDI+DquvX74bz39wCzfczHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q3cqYtMlrIJ6B93ma9EqEpxQou8H7e/8iSjSeqzZwY=;
 b=lZxlQ4EurmzjRC88ryluuqpN+wVWUzcddRScxPfxsBbhFQ3KH5OuhhXZDZCbnuWPrzyb0Rl/TATJYE7mEJfMSpPu0yIl3XZ06K/KyQEpwQyGCh/uLQ+U0+hIYcOEkhwMX44ZjrlaPKZKdIo4U+dzpjFqnwvk+lGKDNqp4n1PIhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Mon, 15 May 2023 20:41:15 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:41:15 +0000
Message-ID: <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
Date: Mon, 15 May 2023 13:41:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
In-Reply-To: <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbe5979-2258-4b54-472c-08db5584ba05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +u7TL+75HiVwKIYrve+kldDyUO06VtEmRrt2I0/LsVFGX6sIHDP2eB92zxX5iysrXi3PWwpetGVJqNTRxP2HjtrCl+xTF473Ray+7CLlxSMlsTyKeWEwyVl43ixS0Txi0bnYlxa4mLpnza2H94Ici9MQ90Zf6YGHKTfMkDwJHXyqwXI3FgSo3JnmZ1r+/YQWB2+4Bpa4rbXBg4lQb/7nfBgxfPx2w1nMFvxJJk177CHyhXGkCIVnUS8OwDj9QVydoekVMPmNW+zNnYjDXdGdVyrgZunz47uaeGpegfhNd4c5SPr2mEfGO9xpiDpVC0doXMiOJlAIJ8AMsQKBk5d/nU9HY/76vVSIV0Q6UkKDvbb1aEhXPtOdPq7EhK6PtPMmk1uSI/oENp627d5i7LbNUhBUJc0oq7HoO0HrlX4LXoK+b7MAaLHIUC3+rhXViMEQnuOx7sQQt5qCjHe/qGuAK2gpUlxKsTQCDH0ebND+9hHWPk8A2OwVt9CpyHxXcWpXz23wHlv18Z+Fkkyyl1WiuiJZ990jkaVwI1M51xYN7K45uMxEpeU9bjLRT9WEyJ4y0l45+ObjRzY19KhgBfXJxeTpzx8NLr2N30/rFOvk5tsSjpkEnJKbzQiyg9eqn8UJJlMKcOxwblsnL+plrKI9JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(2906002)(66946007)(36756003)(53546011)(6506007)(66556008)(5660300002)(66476007)(186003)(8676002)(6512007)(26005)(6666004)(6486002)(41300700001)(83380400001)(6916009)(478600001)(4326008)(316002)(31686004)(44832011)(31696002)(8936002)(86362001)(2616005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVkbUhYSUJMWFdBS2ppYzJyeENLekczRTRuQnNPUTlzWFdoN1MyVjBWQlZM?=
 =?utf-8?B?NVR0MHRPZ2tEeWY5SVF1Tk90MVNnY1NBWUVkbWplOHVnSXpoZkdGdUFZd090?=
 =?utf-8?B?MEVYMEhCYnNiMVRpajhiRS9RM2I1UTlmaXFaalNianppV3NwTXA0NThLSHc4?=
 =?utf-8?B?M1B1ZVRWay9UNlgrUnk4dkw4RG12L3NhOHZXcUpZbzJTcURCbnQ4YlphaVV1?=
 =?utf-8?B?ME82eWFpVU1vY2pVRjlqU3Jpc1JkRHJ1c3hqZWxZOWdMeUxKZHFvWlJQZGlz?=
 =?utf-8?B?eUxhT0piNGhOSTFPRFpxR2N6Yk92bjZ2cDNqd2NSbzFvbFRPUlZseVo1OWU3?=
 =?utf-8?B?MlFPQkJSdVg4U0p2NlJibU1GL1B1SkhxMDdkdkp2RTEyK1VvWGNMY1J3TjRZ?=
 =?utf-8?B?SWt1RGxyT1d2YlNoUlE2Sys2WlBZbGVMNTU0Q0UxeXgxQkhqaHZ0ZW1qaSsx?=
 =?utf-8?B?ZVJXdUxEWWhOYlhxTUVtWGgwbjNodUg5MzJoWThUY3lBd2diOHIyWGJTT3pN?=
 =?utf-8?B?ZStEK1kzbkxMOHJpamRiYVdYWEcrMG95T0F5U01QYWNPQW41a2Y1ODFRZkFM?=
 =?utf-8?B?QitKRWlDci81eWZ6T2RuL1NBVjRpaWF0NWlqRzFYK1Q5LzRoa2lvekx2UUI4?=
 =?utf-8?B?dnNwRTNqbWxKRXNHSStnQ1BXcmw0TTM5YzlvN1VGUU1oc2xJenowc3dsMXA3?=
 =?utf-8?B?QzBXRE1BZkhmNTVPcVAxTURHK1RPWnlSSk0waWkvcXRBRmRvVjNUYXlKU3lH?=
 =?utf-8?B?b0ZkaVZsNVQvUVZhZ0ppY0lwU3dDM2dXbWwvOUlLRSs5OVlqcyt5MktjcmVE?=
 =?utf-8?B?R2xZenJ6UmdRSTg4cTQ4SDRpVWY1RmZDaHFFM3FzazluZFhSNUpYbWNYd1lD?=
 =?utf-8?B?UHNHS2pCempKeFJnMmc4Y1dEL29jcjNYd3BIemlvRndNVXBWLzBLb05YQmpU?=
 =?utf-8?B?OVQ5TFBySXlheVl4NDA1RlN5V2ZQM0xIUEp4S0dlQ2tZaG5Ya0NjcTR2dG00?=
 =?utf-8?B?NHc4TDJaSFZUd1kyVWhMRG5qSmMrZkorZEwwV0VNWjdFellDNlQ4UTN0MHd1?=
 =?utf-8?B?UWZBRXpBbjhLZ0d5Q3pqLy92VThUSFNXd3hlREtNQy9hRE01OWdJTC83dGVn?=
 =?utf-8?B?dm1QQ0wvZlhaN21OWXN4MjQ2RHVON1l5eHBzSjVnbkx5emhEb08vdkFOUHQ0?=
 =?utf-8?B?OTV2MnlqWGVka2pncnlvcEx6dm9qL05uMHZBT3oyMkpnTE9Vdld1b1ROam50?=
 =?utf-8?B?L0tkQWtIczZHREZoZnpQTEVmeGt0WGNPSVphaEQ3V0NoMGRhSkxXbEJQeTkz?=
 =?utf-8?B?OUpYajVXamNYeFozUmhvZlFQTnJIVE10U2Eyc1BVcjc2elI3K1pVTlBkT3pV?=
 =?utf-8?B?VzNVQk41bklEYkpmMkRnOXUvazVZbkg2aHU1NWpBVSswcWIraEpFTlB4bkh2?=
 =?utf-8?B?Sk1qU3ZiVHBBSEhuOXFjTnBWVk1tWDlaamtJNEV4WmFoZnlVTko0bEErNHVF?=
 =?utf-8?B?L3NnVFBQRHdXdERhOWVkSVdlVjQxb0FoQm5qVi9WV1UwTDlxN0VCeVBobndI?=
 =?utf-8?B?am1PaE9JSElWQk94TVc2bjRiZjBoZHRRSzYrS24wbzJGMjdJNEZWbmtvc1dk?=
 =?utf-8?B?RHRNU1NiYlhldjhzZW1Janpxay9oV2Y5T2llSU4xeXEyaDJ3dnVIbXJYN3VH?=
 =?utf-8?B?OGpXdmRjV2dBbkJqN09SNFlNdVNHME92eUFrVFBBWG5rWW1PS1VFRFpTbEho?=
 =?utf-8?B?Q0dKNE9ud0cyZE51OXFEc3loQ05zWXAxblc2VXRteFNmWTJsL3pLSlBRQWVI?=
 =?utf-8?B?aldwNlhDY0ZBa24vcE0wUEF2QUFVMnFuT3ZzU2NjdURNcWRPV2p4U0IrWDd4?=
 =?utf-8?B?TXI4R2lYSHNCUGUzblhlQ3RRRkdnMmZmdXVKT2k2MFNFUWhKTHExS3Z2N3Jk?=
 =?utf-8?B?TW0xU3ByT05SVktlSFExUjd1bHNxNlJKRFdDWHhmdlplNVNFb01hMVFxU0pW?=
 =?utf-8?B?ZGZIU0dDYmVmTytNejJMZTNrd04yejk3U0pOTlgzeVppU2Z5bUhUK003NzBw?=
 =?utf-8?B?VWUrOWFaSUNKZm1YemZZZTFjdmk5cG5MWGV1WVhEQVlhOFgrUTFsNUJnRjBy?=
 =?utf-8?Q?jArAtCN8zWmFJMU0CjL3CtF5O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbe5979-2258-4b54-472c-08db5584ba05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:41:14.9778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CIopnxBWQnTozNzJYdC8sKkpVmyGu76zW3mJhEAChtLeecIjiP5dQyXnJRdvk8ylgpe2AatEenc1l1f2uytzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
Cc: virtualization@lists.linux-foundation.org, drivers@pensando.io,
 mst@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS85LzIzIDE6NDYgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBPbiBNb24sIEFw
ciAyNCwgMjAyMyBhdCAwMzo1MDozMFBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB2aWEgCj4gVmly
dHVhbGl6YXRpb24gd3JvdGU6Cj4+IFVzZSB0aGUgcmlnaHQgc3RydWN0cyBmb3IgUEFDS0VEIG9y
IHNwbGl0IHZxcyB3aGVuIHNldHRpbmcgYW5kCj4+IGdldHRpbmcgdGhlIHZyaW5nIGJhc2UuCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29t
Pgo+PiAtLS0KPj4gZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTggKysrKysrKysrKysrKy0tLS0t
Cj4+IGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8wqAgOCArKysrKystLQo+PiAyIGZpbGVzIGNoYW5n
ZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4gaW5kZXggZjEx
YmRiZTRjMmM1Li5mNjRlZmRhNDhmMjEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4gQEAgLTE2MzMsMTcgKzE2MzMs
MjUgQEAgbG9uZyB2aG9zdF92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2ICpkLCAKPj4gdW5z
aWduZWQgaW50IGlvY3RsLCB2b2lkIF9fdXNlciAqYXJnCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByID0gLUVGQVVMVDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocy5udW0gPiAweGZmZmYp
IHsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByID0gLUVJ
TlZBTDsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVh
azsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2
cSwgVklSVElPX0ZfUklOR19QQUNLRUQpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW0gJiAweGZmZmY7Cj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnEtPmxhc3RfdXNl
ZF9pZHggPSAocy5udW0gPj4gMTYpICYgMHhmZmZmOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfSBlbHNlIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAocy5udW0gPiAweGZmZmYpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IC1FSU5WQUw7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2cS0+bGFzdF9hdmFpbF9p
ZHggPSBzLm51bTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW07Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIEZvcmdldCB0aGUgY2FjaGVkIGluZGV4IHZhbHVlLiAqLwo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2cS0+YXZhaWxfaWR4ID0gdnEtPmxhc3RfYXZh
aWxfaWR4Owo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gwqDCoMKgwqDC
oCBjYXNlIFZIT1NUX0dFVF9WUklOR19CQVNFOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzLmluZGV4ID0gaWR4Owo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy5udW0gPSB2
cS0+bGFzdF9hdmFpbF9pZHg7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodmhv
c3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLm51bSA9ICh1MzIpdnEtPmxhc3RfYXZh
aWxfaWR4IHwgCj4+ICgodTMyKXZxLT5sYXN0X3VzZWRfaWR4IDw8IDE2KTsKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzLm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiAKPiBUaGUgY2hhbmdl
cyBMR1RNLCBidXQgc2luY2Ugd2UgYXJlIGNoYW5naW5nIHRoZSBVQVBJLCBzaG91bGQgd2UKPiB1
cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gb2YgVkhPU1RfU0VUX1ZSSU5HX0JBU0UgYW5kCj4gVkhP
U1RfR0VUX1ZSSU5HX0JBU0UgaW4gaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0Lmg/CgpDb3JyZWN0
IG1lIGlmIEknbSB3cm9uZywgYnV0IEkgZG9uJ3QgdGhpbmsgd2UncmUgY2hhbmdpbmcgYW55dGhp
bmcgaW4gCnRoZSBVQVBJIGhlcmUsIGp1c3QgZml4aW5nIGNvZGUgdG8gd29yayBjb3JyZWN0bHkg
d2l0aCB3aGF0IGlzIGFscmVhZHkgCmhhcHBlbmluZy4KCnNsbgoKCj4gCj4gVGhhbmtzLAo+IFN0
ZWZhbm8KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
