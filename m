Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F40FC7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 03:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 145B640383;
	Wed, 10 May 2023 03:49:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 145B640383
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=3eLCbR86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZQiCMqJ2TknC; Wed, 10 May 2023 03:49:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B9F140291;
	Wed, 10 May 2023 03:49:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B9F140291
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20650C0036;
	Wed, 10 May 2023 03:49:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24AB3C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0437F4263A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0437F4263A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=3eLCbR86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1UM7NpvLI4kY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:49:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54A4242077
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54A4242077
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:49:45 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-436161f2cf2so459347137.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1683690584; x=1686282584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EI3dcKXw4MhS4ti0/DI9c0u69YLYabnxg/e6vkj4TDk=;
 b=3eLCbR86w+2RQbTKOZka2AFvBx7g3Zj+idJSXkQMLalMFcGXeUz+XfvSjS5T3uv4tC
 ipbYKnmAnxFqtIVoYb9RRc5rWc8sSZhMBetTu/C84ZGz+xO5n46P7DxYAjCWVKh/bbB6
 zQ7X8BJpXXEa5XKfssyss21KSZ2HVUbaWfYmpNAR+B9M1rfFQrCE33GyKnSywu0Srhcy
 wlA6oN61GpbDDJunhNaEKhWlN2tYP9Cvy7flCv1W+OC1dPkdup2MESB1tUqfcZBxCqdI
 AwXrCWE2QhMWEc+DDu0ix4QKDbYBsc/wFjMoh7T7VtmDSWtwZi63QsOKmJzpVGp9lmaD
 x4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683690584; x=1686282584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EI3dcKXw4MhS4ti0/DI9c0u69YLYabnxg/e6vkj4TDk=;
 b=K27Bnw89SCpKAn+DlcBK3yCq/50tKe1gtt+zmYNylkJQhwodm8N2W5qyfhyEQR0Sw8
 BcNy7h3fn/zz8EIrr/MrIalnyjLZcx6NevJlFqdw3+XZMpIfR4NFx0+H9IN4VRCc0ezX
 6mFRSYXcXfxamw9CBP8TgC0+LZuIh+aJmdavcrCKWVJ6ctaNhOVvFmTIjRkVzjRXSmjc
 n05ZaUnr19wgewgkl/iDKEeCqGcP7FBoapJxbDJr9xGgCXmAw1NMKqIyzA8gIMsHa2vc
 eO32NpeqK6kGOs8ua66GuNsjly8p1Lvheci8XOEiA5rl4pCjsJHhiRrtNZ/PIsJN795v
 uSCA==
X-Gm-Message-State: AC+VfDyBjbwbhWhiGEIAq6L2n/D4fQMFwzRFfVJqU/8B1h2L5vJl7bvk
 7x3JLT95xaSFnK6QHL0taO5E4tzEtr7YgEwQqO51Rg==
X-Google-Smtp-Source: ACHHUZ5W4HIi6OHBDK+zBBO2lQH7G6noO4SUmFIUN+gOf8a5U8CeUgGQGiYpYu38azJw/nTo5dfKqporeqDX0nEv7wI=
X-Received: by 2002:a67:f9c2:0:b0:435:5255:a1fd with SMTP id
 c2-20020a67f9c2000000b004355255a1fdmr3666179vsq.3.1683690584107; Tue, 09 May
 2023 20:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-2-mie@igel.co.jp>
 <20230427182812.GA262399@bhelgaas>
In-Reply-To: <20230427182812.GA262399@bhelgaas>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Wed, 10 May 2023 12:49:33 +0900
Message-ID: <CANXvt5oYq3CL9gPFZevAx30_Q=Ad1rsG2oCp7p9aNhNZaHvN+A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] PCI: endpoint: introduce a helper to implement
 pci ep virtio function
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ren Zhijie <renzhijie2@huawei.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SSdsbCBmaXggdGhlIHR5cG8gYW5kIHNvbWUgc3R5bGVzIHlvdSBtZW50aW9uZWQuCkluIHRoaXMg
ZS1tYWlsLCBJIHJlcGx5IHRvIHRoZSBvdGhlciBjb21tZW50cy4KMjAyM+W5tDTmnIgyOOaXpSjp
h5EpIDM6MjggQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjoKPgo+IFNpbXBsZSB0
eXBvcywgZG9uJ3QgcmVwb3N0IHVudGlsIHRoZXJlJ3MgbW9yZSBzdWJzdGFudGl2ZSBmZWVkYmFj
ay4KPgo+IE9uIFRodSwgQXByIDI3LCAyMDIzIGF0IDA3OjQ0OjI2UE0gKzA5MDAsIFNodW5zdWtl
IE1pZSB3cm90ZToKPiA+IFRoZSBMaW51eCBQQ0llIEVuZHBvaW50IGZyYW1ld29yayBzdXBwb3J0
cyB0byBpbXBsZW1lbnQgUENJZSBlbmRwb2ludAo+ID4gZnVuY3Rpb25zIHVzaW5nIGEgUENJZSBj
b250cm9sbGVyIG9wZXJhdGluZyBpbiBlbmRwb2ludCBtb2RlLgo+ID4gSXQgaXMgcG9zc2JsZSB0
byByZWFsaXplIHRoZSBiZWhhdmlvciBvZiBQQ0llIGRldmljZSwgc3VjaCBhcyB2aXJ0aW8gUENJ
Cj4gPiBkZXZpY2UuIFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIHNldG9mIGhlbHBlciBmdW5jdGlv
bnMgYW5kIGRhdGEgc3RydWN0dXJlcwo+ID4gdG8gaW1wbGVtZW50IGEgUENJZSBlbmRwb2ludCBm
dW5jdGlvbiB0aGF0IGJlaGF2ZXMgYXMgYSB2aXJ0aW8gZGV2aWNlLgo+Cj4gcy9wb3NzYmxlL3Bv
c3NpYmxlLwo+IHMvc2V0b2Yvc2V0IG9mLwo+Cj4gPiBUaG9zZSBmdW5jdGlvbnMgZW5hYmxlIHRo
ZSBpbXBsZW1lbnRhdGlvbiBQQ0llIGVuZHBvaW50IGZ1bmN0aW9uIHRoYXQKPiA+IGNvbXBseSB3
aXRoIHRoZSB2aXJ0aW8gbGVjYWN5IHNwZWNpZmljYXRpb24uIEJlY2F1c2UgbW9kZXJuIHZpcnRp
bwo+ID4gc3BlY2lmaWNhdGlvbnMgcmVxdWlyZSBkZXZpY2VzIHRvIGltcGxlbWVudCBjdXN0b20g
UENJZSBjYXBhYmlsaXRpZXMsIHdoaWNoCj4gPiBhcmUgbm90IGN1cnJlbnRseSBzdXBwb3J0ZWQg
YnkgZWl0aGVyIFBDSWUgY29udHJvbGxlcnMvZHJpdmVycyBvciB0aGUgUENJZQo+ID4gZW5kcG9p
bnQgZnJhbWV3b3JrLgo+Cj4gcy9pbXBsZW1lbnRhdGlvbiBQQ0llIGVuZHBvaW50IGZ1bmN0aW9u
L2ltcGxlbWVudGF0aW9uIG9mIFBDSWUgZW5kcG9pbnQgZnVuY3Rpb25zLwo+IHMvbGVjYWN5L2xl
Z2FjeS8gKFdoYXQgZG9lcyAibGVnYWN5IiBtZWFuPyAgSXMgdGhlcmUgYSBzcGVjIGZvciB0aGlz
PykKWWVzLCBpdCBpcyBkZWZpbmVkIGluIHNwZWMuCj4gSSBndWVzcyAibGVnYWN5IHZpcnRpbyIg
ZGV2aWNlcyBuZWVkIG5vdCBpbXBsZW1lbnQgY3VzdG9tIFBDSWUKPiBjYXBhYmlsaXRpZXMsIGJ1
dCAibW9kZXJuIHZpcnRpbyIgZGV2aWNlcyBtdXN0IGltcGxlbWVudCB0aGVtPwpUaGF0IEkgd2Fu
dGVkIHRvIGV4cGxhaW4gaGVyZS4KPiBDYXBpdGFsaXplICJFbmRwb2ludCBmcmFtZXdvcmsiIGNv
bnNpc3RlbnRseTsgc29tZXRpbWVzIGl0J3MKPiAiRW5kcG9pbnQiLCBvdGhlciB0aW1lcyBpdCdz
ICJlbmRwb2ludCIuCkknbGwgdGFrZSBjYXJlIHRvIGJlIGNvbnNpc3RlbnQuCj4gPiBXaGlsZSB0
aGlzIHBhdGNoIHByb3ZpZGVzIGZ1bmN0aW9ucyBmb3IgbmVnb3RpYXRpbmcgd2l0aCBob3N0IGRy
aXZlcnMgYW5kCj4gPiBjb3B5aW5nIGRhdGEsIGVhY2ggUENJZSBmdW5jdGlvbiBkcml2ZXIgbXVz
dCBpbXBsIGVtZW50IG9wZXJhdGlvbnMgdGhhdAo+ID4gZGVwZW5kIG9uIGVhY2ggc3BlY2lmaWMg
ZGV2aWNlLCBzdWNoIGFzIG5ldHdvcmssIGJsb2NrLCBldGMuCj4KPiBzL2ltcGwgZW1lbnQvaW1w
bGVtZW50Lwo+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19wY2kuaD4KPiA+ICsjaW5jbHVk
ZSA8bGludXgvdmlydGlvX2NvbmZpZy5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9rdGhyZWFkLmg+
Cj4KPiBUeXBpY2FsbHkgdGhlIGhlYWRlciBpbmNsdWRlcyB3b3VsZCBiZSBhbHBoYWJldGl6ZWQg
aWYgcG9zc2libGUuCkknbGwgdHJ5IHRvIHJlb3JkZXIgdGhlbS4KPiA+ICsgICAgIHZxX3ZpcnQg
PSBwY2lfZXBjX21hcF9hZGRyKGVwZi0+ZXBjLCBlcGYtPmZ1bmNfbm8sIGVwZi0+dmZ1bmNfbm8s
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cV9wY2lfYWRkciwgdnFfcGh5
cywgdnFfc2l6ZSk7Cj4gPiArICAgICBpZiAoSVNfRVJSKHZxX3ZpcnQpKSB7Cj4gPiArICAgICAg
ICAgICAgIHByX2VycigiRmFpbGVkIHRvIG1hcCB2aXJ0dXF1ZXVlIHRvIGxvY2FsIik7Cj4KPiBz
L3ZpcnR1cXVldWUvdmlydHF1ZXVlLwo+Cj4gSSBrbm93IHlvdSBwcm9iYWJseSBkb24ndCBoYXZl
IGFueSB3YXkgdG8gdXNlIGRldl9lcnIoKSwgYnV0IHRoaXMKPiBtZXNzYWdlIHJlYWxseSBuZWVk
cyBzb21lIGNvbnRleHQsIGxpa2UgYSBkcml2ZXIgbmFtZSBhbmQgaW5zdGFuY2Ugb3IKPiBzb21l
dGhpbmcuCkknbGwgdHJ5IHRvIHVzZSB0aGUgZGV2XyogZnVuY3Rpb24gYXBwcm9wcmlhdGVseSBJ
ZiBwb3NzaWJsZS4KPiA+ICsjZGVmaW5lIFZJUlRJT19QQ0lfTEVHQUNZX0NGR19CQVIgMAo+Cj4g
V2hhdCBtYWtlcyB0aGlzIGEgImxlZ2FjeSBjZmcgQkFSIj8gIElzIHRoZXJlIHNvbWUgc3BlYyB0
aGF0IGNvdmVycwo+IHZpcnRpbyBCQVIgdXNhZ2U/Clllcy4gVmlydGlvIExlZ2FjeSBpbnRlcmZh
Y2UgZGVmaW5lcyB0aGUgUENJIEJBUiBudW1iZXIgdG8gdXNlLgpodHRwczovL2RvY3Mub2FzaXMt
b3Blbi5vcmcvdmlydGlvL3ZpcnRpby92MS4yL2NzZDAxL3ZpcnRpby12MS4yLWNzZDAxLmh0bWwj
eDEtMTQ1MDAwMTAKCj4gPiArICogZXBmX3ZpcnRpb19pbml0IC0gaW5pdGlhbGl6ZSBzdHJ1Y3Qg
ZXBmX3ZpcnRpbyBhbmQgc2V0dXAgQkFSIGZvciB2aXJ0aW8KPiA+ICsgKiBAZXZpbzogc3RydWN0
IGVwZl92aXJ0aW8gdG8gaW5pdGlhbGl6ZS4KPiA+ICsgKiBAaGRyOiBwY2kgY29uZmlndXJhdGlv
biBzcGFjZSB0byBzaG93IHJlbW90ZSBob3N0Lgo+ID4gKyAqIEBiYXJfc2l6ZTogcGNpIEJBUiBz
aXplIGl0IGRlcGVuZHMgb24gdGhlIHZpcnRpbyBkZXZpY2UgdHlwZS4KPgo+IHMvcGNpL1BDSS8g
KHRoZXJlIHdlcmUgYWxzbyBhIGZldyBtb3JlIGluc3RhbmNlcyBhYm92ZSBpbiBtZXNzYWdlcyBv
cgo+IGNvbW1lbnRzKQo+Cj4gPiArICogZXBmX3ZpcnRpb19maW5hbCAtIGZpbmFsaXplIHN0cnVj
dCBlcGZfdmlydGlvLiBpdCBmcmVlcyBiYXIgYW5kIG1lbW9yaWVzCj4gPiArICogQGV2aW86IHN0
cnVjdCBlcGZfdmlydGlvIHRvIGZpbmFsaXplLgo+Cj4gcy9iYXIvQkFSLwo+Cj4gPiArc3RhdGlj
IHZvaWQgZXBmX3ZpcnRpb19tb25pdG9yX3Fub3RpZnkoc3RydWN0IGVwZl92aXJ0aW8gKmV2aW8p
Cj4gPiArewo+ID4gKyAgICAgY29uc3QgdTE2IHFuX2RlZmF1bHQgPSBldmlvLT5udnE7Cj4gPiAr
ICAgICB1MTYgdG1wOwo+ID4gKwo+ID4gKyAgICAgLyogU2luY2UgdGhlcmUgaXMgbm8gd2F5IHRv
IHN5bmNocm9uaXplIGJldHdlZW4gdGhlIGhvc3QgYW5kIEVQIGZ1bmN0aW9ucywKPiA+ICsgICAg
ICAqIGl0IGlzIHBvc3NpYmxlIHRvIG1pc3MgbXVsdGlwbGUgbm90aWZpY2F0aW9ucy4KPgo+IE11
bHRpLWxpbmUgY29tbWVudCBzdHlsZS4KPgo+ID4gKyAgICAgZXJyID0gZXBmX3ZpcnRpb19uZWdv
dGlhdGVfdnEoZXZpbyk7Cj4gPiArICAgICBpZiAoZXJyIDwgMCkgewo+ID4gKyAgICAgICAgICAg
ICBwcl9lcnIoImZhaWxlZCB0byBuZWdvdGljYXRlIGNvbmZpZ3Mgd2l0aCBkcml2ZXJcbiIpOwo+
Cj4gcy9uZWdvdGljYXRlL25lZ290aWF0ZS8KPgo+ID4gKyAqIGVwZl92aXJ0aW9fcmVzZXQgLSBy
ZXNldCB2aXJ0aW8gc3RhdHVzCj4KPiBTb21lIG9mIHRoZSBmdW5jdGlvbiBkZXNjcmlwdGlvbnMg
ZW5kIHdpdGggYSBwZXJpb2QgKCIuIikgYW5kIG90aGVycwo+IGRvbid0LiAgUGxlYXNlIGZpZ3Vy
ZSBvdXQgd2hhdCB0aGUgbW9zdCBjb21tb24gc3R5bGUgaXMgYW5kIHVzZSB0aGF0Cj4gY29uc2lz
dGVudGx5LgpJIGFncmVlLiBJJ2xsIGZpeCB0byBiZSBjb25zaXN0ZW50Lgo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIGRzdCA9IHBjaV9lcGNfbWFwX2FkZHIoZXBmLT5lcGMsIGVwZi0+ZnVuY19u
bywKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVwZi0+
dmZ1bmNfbm8sIGRiYXNlLCAmcGh5cywKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNsZW4pOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChJU19F
UlIoZHN0KSkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJmYWls
ZWQgdG8gbWFwIHBjaSBtbW9lcnkgc3BhY3QgdG8gbG9jYWxcbiIpOwo+Cj4gcy9wY2kvUENJLwo+
IHMvbW1vZXJ5L21lbW9yeS8KPiBzL3NwYWN0L3NwYWNlLyA/Cj4KPiBBbHNvIGJlbG93Lgo+Cj4g
SUlSQyBzb21lIHByZXZpb3VzIG1lc3NhZ2VzIHN0YXJ0ZWQgd2l0aCBhIGNhcGl0YWwgbGV0dGVy
LiAgUGxlYXNlCj4gbWFrZSB0aGVtIGFsbCBjb25zaXN0ZW50LgpTdXJlLgo+ID4gKyAgICAgICAg
ICAgICBpZiAoZGlyID09IERNQV9NRU1fVE9fREVWKSB7Cj4gPiArICAgICAgICAgICAgICAgICAg
ICAgcGNpX2VwY191bm1hcF9hZGRyKGVwZi0+ZXBjLCBlcGYtPmZ1bmNfbm8sCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVwZi0+dmZ1bmNfbm8sIHBoeXMsIGRz
dCwgc2xlbik7Cj4gPiArICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPiArICAgICAgICAgICAgICAg
ICAgICAgcGNpX2VwY191bm1hcF9hZGRyKGVwZi0+ZXBjLCBlcGYtPmZ1bmNfbm8sCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVwZi0+dmZ1bmNfbm8sIHBoeXMs
IHNyYywgc2xlbik7Cj4gPiArICAgICAgICAgICAgIH0KPiA+ICsgICAgIH0KPiA+ICsKPiA+ICsg
ICAgIHJldHVybiAxOwo+Cj4gSSBndWVzcyB0aGlzIGZ1bmN0aW9uIHJldHVybnMgZWl0aGVyIGEg
bmVnYXRpdmUgZXJyb3IgY29kZSBvciB0aGUKPiB2YWx1ZSAxPyAgVGhhdCBzZWVtcyBzb3J0IG9m
IHdlaXJkIChJIHRoaW5rICJuZWdhdGl2ZSBlcnJvciBjb2RlIG9yCj4gKnplcm8qIGlzIG1vcmUg
dHlwaWNhbCksIGJ1dCBtYXliZSB5b3UncmUgZm9sbG93aW5nIHNvbWUgY29udmVudGlvbj8KSXQg
aGFzIHRvIGJlIDAuIEl0IGlzIG15IG1pc3Rha2UuCgpTb21lIHZyaW5naCBmdW5jdGlvbnMgcmV0
dXJuIDAgKGRhdGEgZG9lcyBub3QgZXhpc3QpLCAxIChpdCBleGlzdHMpLApvciBlcnJvci4gQnV0
IHRoaXMgZnVuY3Rpb25zIGlzIG5vdCByZWxhdGVkLgo+ID4gKyNpbmNsdWRlIDxsaW51eC9wY2kt
ZXBmLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3BjaS1lcGMuaD4KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvdnJpbmdoLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2RtYWVuZ2luZS5oPgo+Cj4gQWxwaGEg
b3JkZXIgaWYgcG9zc2libGUKWWVzLgo+ID4gKyAgICAgLyogVmlydHVhbCBhZGRyZXNzIG9mIHBj
aSBjb25maWd1cmF0aW9uIHNwYWNlICovCj4KPiBzL3BjaS9QQ0kvCj4KPiA+ICsgICAgIC8qIENh
bGxiYWNrIGZ1bmN0aW9uIGFuZCBwYXJhbWV0ZXIgZm9yIHF1ZXVlIG5vdGlmY2F0aW9uCj4gPiAr
ICAgICAgKiBOb3RlOiBQQ0kgRVAgZnVuY3Rpb24gY2Fubm90IGRldGVjdCBxbm90aWZ5IGFjY3Vy
YXRlbHksIHRoZXJlZm9yZSB0aGlzCj4gPiArICAgICAgKiBjYWxsYmFjayBmdW5jdGlvbiBzaG91
bGQgY2hlY2sgYWxsIG9mIHZpcnRxdWV1ZSdzIGNoYW5nZXMuCj4gPiArICAgICAgKi8KPgo+IE11
bHRpLWxpbmUgY29tbWVudCBzdHlsZS4KPgo+IEJqb3JuCgpCZXN0IHJlZ2FyZHMsClNodW5zdWtl
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
