Return-Path: <SRS0=fPht=DW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AAEC433DF
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 14:16:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BC020757
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nOxo+crc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BC020757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 528A987EC9;
	Thu, 15 Oct 2020 14:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ghBtATmYvb7j; Thu, 15 Oct 2020 14:16:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DC2687E30;
	Thu, 15 Oct 2020 14:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94BC2C07FF;
	Thu, 15 Oct 2020 14:16:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 306D5C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 14:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E2D2F2E664
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 14:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wmTTjpL9LH8L
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 14:16:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by silver.osuosl.org (Postfix) with ESMTPS id A47CA2E65F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 14:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIEdIhAerksJz7LFA0/2tMVoP1eYy2m2Ya1PNPh5OrBDlo8nj2XEoSxbXWxo4Mz4DolOmzMtA+KEn8NPqB3wSk9m0s6LI/lDt/nJZ9hnUN1NTFw4XWEZa2dFSf9EimZAzUy4pn80DinZrRTZX4USS51MIogLo6gfidx5GriksHEWABTdpSuaHvrZpvThRPVgxiFnvjsGJ3PHFlgNcXfAtpZm/L8qGUaBN41c1wIdCb7/Ae6z4yntsDE9uVAK/FuqGrUhYQmzhO4SyJuZ4YfE747oNTNqVm7I7KSi/SioaWn8VRY/j3oqSSeUcKT+0yGuLT7jwmxpUBlYLCCfKvhhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyDMUj3c5Q/kAKqLamJTbfJcmn3zhWOYAX0CC7GZMQ8=;
 b=QTNqZ9bvtZskR6e39cbFMEBGtNy7Gf+S6js8Ub00HbZEp+CGzn2K162OqBmSWT8ES5GJ7/kzJQJPLlLK1j8+u/UGGHOBZTLmSHlyqgg9ab3Il9iXLyehrlLzJUepHURVQIUqsOTAADU8wVy1o7OWjazoxzMRRp+3DxADPI5Gd/9w1vdGMaxEtyMDH9cF0P0e9+DxWgeeDMBABuSGo9BJwCsIn1Gv8EO86RdopZzGKtyLe6df0sx3LnpTVFr7Tfc3hdKOF/S4UnbFmvXSXc5niVn/UlLb2DnpFFaPIy1+EzN6mIfQrZBOBHJynyVzYVZGSyvE5yVcpD0LjkwcAGNy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyDMUj3c5Q/kAKqLamJTbfJcmn3zhWOYAX0CC7GZMQ8=;
 b=nOxo+crch41rHvdBum9AtQW7CBZ126KH3aDpN2sdW8FdpdjZbswJpvxloNTgfl1wbbtTMqly2HlxcVx4TvM6PlGXkzFSfFVWW9yGEdv0x9BPzobGw3xK0pMx4gILw82yOirM5xL9KTkjHX/CPtKbLkvdQgS8nhnLq3vxj2lQpBk=
Authentication-Results: lists.linaro.org; dkim=none (message not signed)
 header.d=none;lists.linaro.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 14:00:57 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 14:00:57 +0000
Subject: Re: [PATCH v4 04/10] drm/exynos: Remove empty
 exynos_drm_gem_prime_{vmap,vunmap}()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, sam@ravnborg.org, alexander.deucher@amd.com,
 kraxel@redhat.com, l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
 christian.gmeiner@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org,
 krzk@kernel.org, yuq825@gmail.com, bskeggs@redhat.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, hjc@rock-chips.com, heiko@sntech.de,
 hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 oleksandr_andrushchenko@epam.com, ray.huang@amd.com,
 sumit.semwal@linaro.org, emil.velikov@collabora.com, luben.tuikov@amd.com,
 apaneers@amd.com, linus.walleij@linaro.org, melissa.srw@gmail.com,
 chris@chris-wilson.co.uk, miaoqinglang@huawei.com
References: <20201015123806.32416-1-tzimmermann@suse.de>
 <20201015123806.32416-5-tzimmermann@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7a6f6526-1b67-61c8-2239-50f2bfbdc29d@amd.com>
Date: Thu, 15 Oct 2020 16:00:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201015123806.32416-5-tzimmermann@suse.de>
Content-Language: en-US
X-Originating-IP: [80.187.123.114]
X-ClientProxiedBy: AM0PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.137.56] (80.187.123.114) by
 AM0PR08CA0005.eurprd08.prod.outlook.com (2603:10a6:208:d2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Thu, 15 Oct 2020 14:00:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc82f225-0f8a-43ae-cb58-08d87112bccd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4690BB9C565CA20B6B0332C883020@BL0PR12MB4690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JBOwexIirDjBJSp39MdGx4etjX+D1JSxS0P8TKGjAx1Bmi1T/HpRGzkBUKpTm/XTd+/LrRMDocaj0Ux25QJ6ln93vwns8Cz82KXZp7az7wmFCwWDpKO5vCP3wdZhpKpdPGUQqsKTDxaSn4+A1aVXQOp4XRT0QJbqMPxQi8X7LBscjIL6rbKrxyCaaXEiW3RU34nFc6HjddNFg2AT4/Bh8f0C3aGvk/tUDErgOCm/9tDgXNzjn9lVfTaLEsbwx1LnZADAqpstprcTTr3gIx0vfW6ojRELLMSUc9DWwsuGmk5tjPuih28IqGJm18Oh6fI8Pm17X9yq8xQQYf0gRbte3FCMU0f4zIQiP/BB9JGvacfcxiCYo5ytMK9w9TN1SfHsjr9k38s3MzdcvZ1rClA8wEbsJP6VUXTqHQt7W/Qon9GVQQ+FvBVIvKlzQuqmAMf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(956004)(478600001)(31686004)(8676002)(7416002)(4326008)(8936002)(7406005)(52116002)(186003)(2906002)(16526019)(26005)(6486002)(34490700002)(31696002)(83380400001)(16576012)(2616005)(86362001)(6666004)(316002)(66946007)(66556008)(5660300002)(66476007)(36756003)(921003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: L+lw87r0GARxt6cpx/CQ9Knf+dyyeSpa0SnuyLreuQ4Ft54/jY4lbP8rZ5fgVHeZXyxczESkVI0XZU6KBk94qGVEzWZZ5+57Kb77FSr1MnmNvk5plVOe07W0Ju2YnE7dyIT4jMLY5Jaqw1CqI5/d7vfCVjJEriMzHd1ALMy2hXA8wH40hv9U/S/RE7aIjNjSl3FlWorHI/NaKLuCh3VBY5dDrHnxySi4nl6kVkttFn1vl6/Ralb3uGiSNjawA+PQzTCjlxFz5bP2njR4gEsbIBaF4gXPYLh6Tz4LxOhfHFmLj38gWfj7HZdcdMfLfSy/ukOkLME1tQ2gRj3cKz9E9DiMUsGPbP5GaCZzjGzYrCElmJbtLn8ZlrVcx3hrAFHV6g1ZKTCikLz3QTDjKJcV68T4rvyQYR9taf5IJQkqDSbLCTPjFD3+vU6GAAta3DPSJQXGaGUchlpve77w02No8FlfZIYKGJ7n99pRq1GLG0ir7UPHltbBjl3bysAZAQxszNBUZ7+bcXMEj9fa23yQ3FXp4ec8tT6tMVLazB8Djb2GLFu4mBgMuXx83KOgE3CtDf3tvNRHKx4kCrZMtIbBF7NXZigE7/BDE8xK86q78Owkpk4BOQelhulmZKJ1hIPekqr/gm5sTJXpG8JiW5Djxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc82f225-0f8a-43ae-cb58-08d87112bccd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 14:00:57.0375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NidAfpRa2NMLEGdnFWdYvsER8j3pbm+Oaf1NwO8cr9OAacK7WMR3KCrCNNQSGLqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4690
Cc: linux-samsung-soc@vger.kernel.org, lima@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
 spice-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMTUuMTAuMjAgdW0gMTQ6Mzggc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoKPiBUaGUgZnVu
Y3Rpb25zIGV4eW5vc19kcm1fZ2VtX3ByaW1lX3t2bWFwLHZ1bm1hcH0oKSBhcmUgZW1wdHkuIFJl
bW92ZQo+IHRoZW0gYmVmb3JlIGNoYW5naW5nIHRoZSBpbnRlcmZhY2UgdG8gdXNlIHN0cnVjdCBk
cm1fYnVmX21hcC4gQXMgYSBzaWRlCj4gZWZmZWN0IG9mIHJlbW92aW5nIGRybV9nZW1fcHJpbWVf
dm1hcCgpLCB0aGUgZXJyb3IgY29kZSBjaGFuZ2VzIGZyb20KPiBFTk9NRU0gdG8gRU9QTk9UU1VQ
UC4KPgo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fZ2VtLmMgfCAx
MiAtLS0tLS0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9nZW0u
aCB8ICAyIC0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9nZW0uYwo+IGluZGV4IGU3YTZlYjk2ZjY5Mi4uMTNh
MzU2MjNhYzA0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2Ry
bV9nZW0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9nZW0uYwo+
IEBAIC0xMzcsOCArMTM3LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0
cnVjdCBleHlub3NfZHJtX2dlbV92bV9vcHMgPSB7Cj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGRy
bV9nZW1fb2JqZWN0X2Z1bmNzIGV4eW5vc19kcm1fZ2VtX29iamVjdF9mdW5jcyA9IHsKPiAgIAku
ZnJlZSA9IGV4eW5vc19kcm1fZ2VtX2ZyZWVfb2JqZWN0LAo+ICAgCS5nZXRfc2dfdGFibGUgPSBl
eHlub3NfZHJtX2dlbV9wcmltZV9nZXRfc2dfdGFibGUsCj4gLQkudm1hcCA9IGV4eW5vc19kcm1f
Z2VtX3ByaW1lX3ZtYXAsCj4gLQkudnVubWFwCT0gZXh5bm9zX2RybV9nZW1fcHJpbWVfdnVubWFw
LAo+ICAgCS52bV9vcHMgPSAmZXh5bm9zX2RybV9nZW1fdm1fb3BzLAo+ICAgfTsKPiAgIAo+IEBA
IC00NzEsMTYgKzQ2OSw2IEBAIGV4eW5vc19kcm1fZ2VtX3ByaW1lX2ltcG9ydF9zZ190YWJsZShz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+ICAgCXJldHVybiAmZXh5bm9zX2dlbS0+YmFzZTsKPiAg
IH0KPiAgIAo+IC12b2lkICpleHlub3NfZHJtX2dlbV9wcmltZV92bWFwKHN0cnVjdCBkcm1fZ2Vt
X29iamVjdCAqb2JqKQo+IC17Cj4gLQlyZXR1cm4gTlVMTDsKPiAtfQo+IC0KPiAtdm9pZCBleHlu
b3NfZHJtX2dlbV9wcmltZV92dW5tYXAoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosIHZvaWQg
KnZhZGRyKQo+IC17Cj4gLQkvKiBOb3RoaW5nIHRvIGRvICovCj4gLX0KPiAtCj4gICBpbnQgZXh5
bm9zX2RybV9nZW1fcHJpbWVfbW1hcChzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwKPiAgIAkJ
CSAgICAgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQo+ICAgewo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fZ2VtLmggYi9kcml2ZXJzL2dwdS9kcm0v
ZXh5bm9zL2V4eW5vc19kcm1fZ2VtLmgKPiBpbmRleCA3NGU5MjZhYmVmZjAuLmEyMzI3MmZiOTZm
YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fZ2VtLmgK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fZ2VtLmgKPiBAQCAtMTA3
LDggKzEwNyw2IEBAIHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqCj4gICBleHlub3NfZHJtX2dlbV9w
cmltZV9pbXBvcnRfc2dfdGFibGUoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKPiAgIAkJCQkgICAg
IHN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0dGFjaCwKPiAgIAkJCQkgICAgIHN0cnVjdCBz
Z190YWJsZSAqc2d0KTsKPiAtdm9pZCAqZXh5bm9zX2RybV9nZW1fcHJpbWVfdm1hcChzdHJ1Y3Qg
ZHJtX2dlbV9vYmplY3QgKm9iaik7Cj4gLXZvaWQgZXh5bm9zX2RybV9nZW1fcHJpbWVfdnVubWFw
KHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLCB2b2lkICp2YWRkcik7Cj4gICBpbnQgZXh5bm9z
X2RybV9nZW1fcHJpbWVfbW1hcChzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwKPiAgIAkJCSAg
ICAgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKTsKPiAgIAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
