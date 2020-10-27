Return-Path: <SRS0=a9Wa=EC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD11DC388F9
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 12:36:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337842076D
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1BNOWCaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337842076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D91586FA8;
	Tue, 27 Oct 2020 12:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y9xylJEEbg7C; Tue, 27 Oct 2020 12:36:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 424F786F90;
	Tue, 27 Oct 2020 12:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C9F0C088B;
	Tue, 27 Oct 2020 12:36:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E208C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 12:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D7B35203EA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 12:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qf-Be9rBkoIC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 12:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by silver.osuosl.org (Postfix) with ESMTPS id 5AC1D20353
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 12:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLlrvziaIyuU3SspzYokz812M6cAod9QDKRsYTjeVro9M9hRQj7GGw7BPR11x2cN1uLC6DJssjbXuhiQ0L+yR2tZfVSBxjuzoiOJmAjVIMmbFYkt1oiLTIFtFSnyJXFECom9XqjoiFGTi9kLxE/2UfRmSAEzA8h2sCIqTZGe7A5k5OFfikGzDcHKgn7WMqDC1Q5SDou1EsnyzT8X5UPY67SqzkCOfvxJT8qlj9SpuitPsqKc2iQ1Fhpeixn5s2dwl91IfEBmPiwe1foLrgcKuu9EOrnwE507Ep3ExZudvwlyEtcT0IvyGWVybbwAj+fTl9w2/h56WpZDufSwZlZ5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0uywEG7ytgt5hsUFXKH12dLQ6cokqZFnsWdRhpAxSs=;
 b=flQrEhDqknXkt2sCJuTO1KNW94HMgu43a/2yhpYZzhqPEb67GWtAJTEglRNDTqyVPexm8r9lCnynn1V8CbpmOzRsmRZnuF768h9IuzCtSkgTcI0+r5y+LdA1hqsyIOMkb6coLwu7+D+WBu5d1vfverFBpkJqF1APxaneI4tOcLprgjPG3HyB7RhSCcrEQkKNgAqsIcSRUr+xIHZrgnY943oaPnwDsnK6RAa5WmBCvi9t5CwPj/YyVZF65JKhUM2sBFybGz2vluHsMLG5XhXhTXAsowXsUQm0pqtFQ1+O+pi3LpjMMehXSAfOlQTBN0/GiLHe39Pi1K+ZmuuKV7evuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0uywEG7ytgt5hsUFXKH12dLQ6cokqZFnsWdRhpAxSs=;
 b=1BNOWCazcq7ahc70MoqU1trdaxNis6GohUxx3jzCA98xFHWR7SURRJNv5VqHsjjiZ9JzcV0S3t2selQp5r1wwDDrs1J6Bhu6WZmCc0JId52tWvLW6gWqHiRlDgpAuG18kXXKdaD6B25uN/2ofrPdV5tLTaPZnrWGY1SegCZ3zOQ=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 12:21:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 12:21:40 +0000
Subject: Re: [PATCH 8/8] dma-buf: use krealloc_array()
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Gustavo Padovan
 <gustavo@padovan.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Robert Richter <rric@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20201027121725.24660-1-brgl@bgdev.pl>
 <20201027121725.24660-9-brgl@bgdev.pl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0b41d541-30a9-a020-f065-fb55dc766bc1@amd.com>
Date: Tue, 27 Oct 2020 13:21:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201027121725.24660-9-brgl@bgdev.pl>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:208:122::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 12:21:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a9ccb29-0bf0-4bbc-8097-08d87a72dbcb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:
X-Microsoft-Antispam-PRVS: <MN2PR12MB453650BEAA05349A6A4E2BA283160@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqEq0WXz7JKgB6Ql3KJBLH5AYrTjK5M2jtAgZS6kH16rbGMXsVzP+JfXQ7zg8W69imE0I//FAjeKtQnAD2TIhsEiBUwKveQd4GNpiZ8yylbm7Jo9XSV3isikrahqC98Wy9DyBPGDIKgL3GFq47D2+03ouhYdRXwuSlIhrYKdBT3WRcB0uo2g1m3Dsh/3vwIvxUHq9zYmJHagvGRHwmNyGgJshBakvkmsOxNy2PlAFU+1p7FmH+xcizm15aKfdSC9HAQZ8usGklEJFwFGrkeY0RSB8H1Wx7VB0dzabYQej+qYBNkaVsjHHHWi2SRxyczrreMc/2KPgliWfBJi/aLcnDtWVjvpduwqEr3fo5Yb24OTL1jrpkAW0b4VBzxvpnk2v0QlMFTGy+8CD7/dszJWow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(4744005)(7406005)(5660300002)(83380400001)(66556008)(16526019)(66946007)(52116002)(8936002)(316002)(186003)(66476007)(6486002)(31696002)(110136005)(2616005)(6666004)(7416002)(2906002)(4326008)(478600001)(86362001)(8676002)(36756003)(31686004)(921003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 97vJT1bWj4JuIqlB3lM08hOS0mbbkIwaaXA6HIMCZNnSevvdudkGUonMw0ndN+QpRlA3y/XWlf7zdiV3f60aiQYfbK7Tuu0gok7qk8Kl4TtW79Z7FeFIk1HsvnAP+Zmo2/deeOl+GNycCCX/ePKCNbThOaY8bQWv/LKUJ794ioHxdrFjF2EE40yqHrqZXlGhsc6t+I4WvCjqt7ly60LO6dFIDRDCYa7+2jDo7JtpulC9ytwm0TfqnuILkPJkGod2Si10tRDxSTD3YbcQorkCNTDRccQAGoCBCGKn0qt24xJIrZLswFNBb8rSvGBTu3oPpieaN9G4b9qp7jZ4E8OSOzTKaxKh0pEA7oHFxtv7HRHDJ8KScCMGjOdazN6IarDcf2jYchVCQYWactUH82DiKZJNQdy7tU3WVEMjf7W9y7hkWJIMOhzOlP/qeN9QpKC4UWJXzzH0z25BhlJCvYeCg55+ik2Wbe2MA0E8w6hkNtvdZKm59W6/JOCPWqC/uYvlUuTKFo4lewjVZfO9egZcJtNyWpX5Cnt8jcUiyeXOCo1Q5mVHaOazxJ+8hqYEABObaNNuMLo9QMuAYlP0Tg/YpLq7PNSaGJ9q9w6r9h+wfBvv7MOvej0d9laooqe/jvbEXyzdahKmpZVzcDACJCTJqp3RCr1ukyHHzTTj+/BYVJc4vZO0ue9kBNsIHg955Dio0EYLPZmb6JNURZI/lHBgJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9ccb29-0bf0-4bbc-8097-08d87a72dbcb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 12:21:40.8550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEKxYQK0NHX7xk+/r0yZhJpur2OX1UekLRtALy6oFy5OGVfFhixUWxfCnPfM0nef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-gpio@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-media@vger.kernel.org,
 linux-edac@vger.kernel.org
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

QW0gMjcuMTAuMjAgdW0gMTM6MTcgc2NocmllYiBCYXJ0b3N6IEdvbGFzemV3c2tpOgo+IEZyb206
IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4KPiBVc2Ug
dGhlIGhlbHBlciB0aGF0IGNoZWNrcyBmb3Igb3ZlcmZsb3dzIGludGVybmFsbHkgaW5zdGVhZCBv
ZiBtYW51YWxseQo+IGNhbGN1bGF0aW5nIHRoZSBzaXplIG9mIHRoZSBuZXcgYXJyYXkuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUu
Y29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KCj4gLS0tCj4gICBkcml2ZXJzL2RtYS1idWYvc3luY19maWxlLmMgfCA0ICsrLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9kbWEtYnVmL3N5bmNfZmlsZS5jIGIvZHJpdmVycy9kbWEtYnVmL3N5bmNf
ZmlsZS5jCj4gaW5kZXggNWE1YTFkYTAxYTAwLi4yOTI1ZWEwM2VlZjAgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9kbWEtYnVmL3N5bmNfZmlsZS5jCj4gKysrIGIvZHJpdmVycy9kbWEtYnVmL3N5bmNf
ZmlsZS5jCj4gQEAgLTI3MCw4ICsyNzAsOCBAQCBzdGF0aWMgc3RydWN0IHN5bmNfZmlsZSAqc3lu
Y19maWxlX21lcmdlKGNvbnN0IGNoYXIgKm5hbWUsIHN0cnVjdCBzeW5jX2ZpbGUgKmEsCj4gICAJ
CWZlbmNlc1tpKytdID0gZG1hX2ZlbmNlX2dldChhX2ZlbmNlc1swXSk7Cj4gICAKPiAgIAlpZiAo
bnVtX2ZlbmNlcyA+IGkpIHsKPiAtCQluZmVuY2VzID0ga3JlYWxsb2MoZmVuY2VzLCBpICogc2l6
ZW9mKCpmZW5jZXMpLAo+IC0JCQkJICBHRlBfS0VSTkVMKTsKPiArCQluZmVuY2VzID0ga3JlYWxs
b2NfYXJyYXkoZmVuY2VzLCBpLAo+ICsJCQkJCSBzaXplb2YoKmZlbmNlcyksIEdGUF9LRVJORUwp
Owo+ICAgCQlpZiAoIW5mZW5jZXMpCj4gICAJCQlnb3RvIGVycjsKPiAgIAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
