Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E0C47083
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:02:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCCC613F3
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCCC613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1C3D404E7;
	Thu,  3 Jun 2021 03:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6vd9zM70PyMH; Thu,  3 Jun 2021 03:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B09B404D7;
	Thu,  3 Jun 2021 03:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 555F4C000E;
	Thu,  3 Jun 2021 03:02:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 495E1C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24D39404E9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AhUzQ0y6YwPy
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:02:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EDAD404D7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622689355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5v7V01P50/MU+rNJexPycRVWZFkh/NJWCZ7iWh6s3/0=;
 b=hZijpXbgU+OyQGyhLW6ycOZyVS6gHEnHDBgklvml6KC9ve5BSKPCTc8sBliaZvN3sMYcn6
 o2uNExWiq65YD1YMErv3bGoAXelHAOAHZTdloU9yRAfOsmiBjO6IHXTrXo/VS6s/UzsPqN
 GpbbkDyNEHF2JsQj23yRYdTl5v6awr0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-FS_JuM7NMe-LviH1MMQcdw-1; Wed, 02 Jun 2021 23:02:31 -0400
X-MC-Unique: FS_JuM7NMe-LviH1MMQcdw-1
Received: by mail-pj1-f72.google.com with SMTP id
 kk5-20020a17090b4a05b029016102a8423cso4540838pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 20:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5v7V01P50/MU+rNJexPycRVWZFkh/NJWCZ7iWh6s3/0=;
 b=o6y5py+VqLFX0obYXjgTKv5jb4giwoxjwj1P64s4raqdGbVm0pebughPGAGbvzL+Oi
 do29/l8vFgbC5YQkpPfmoA90trE1DDaVKx3S0hnY9ohaEEZuECWpQK/lUhtWvldIL8mR
 uHhpPtwSNW52FMQ75YavXe/+MuKehnP7RtDQpQnaeXc+qbyZFzwnJ6Vg2/wb8+zG+qoB
 SzZGrjnw/e6T3onl1TWKirsjvKsLpsfIQMbfVB3z6LUkmypVc2IepZgm0E+Fk/vPeIwz
 aXB3gVfdqKY8PLUJeM05JgWeKj2gbepl8NWKteI1w3FMnM0oTsjEmZ3N8LksXm/oW/Z7
 rzuQ==
X-Gm-Message-State: AOAM533AUCML3QZ3A175QXrrSXdNmJdrYrjcMSAZ9+Rj2/MKoY2fZZxY
 0EuefQN/3ftWCUY50qXJlghk+097O1DM+EaC3Bg73Ra4Nea+em5tNwcqWw7hq6/ll/tAzAJptWp
 cjgLa1vLg6Thvybo6hgJ/YGQLk20OnHMRklfytD575g==
X-Received: by 2002:a17:90a:e54e:: with SMTP id
 ei14mr4156591pjb.53.1622689350894; 
 Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwhDfm3DFenSc3jf0+IF7vZ3fiL+QyQZqc2ItshCLLfoqd1jKoY3Jfm/f4//A4m6OHVAGWYQ==
X-Received: by 2002:a17:90a:e54e:: with SMTP id
 ei14mr4156577pjb.53.1622689350622; 
 Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q191sm791649pfq.108.2021.06.02.20.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
 <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
 <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
Date: Thu, 3 Jun 2021 11:02:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
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

CuWcqCAyMDIxLzYvMyDkuIrljYgxMDo1NiwgQW5kaSBLbGVlbiDlhpnpgZM6Cj4KPj4KPj4gSSBh
Z3JlZSwgYnV0IEkgd2FudCB0byBrbm93IHdoeSBpbmRpcmVjdCBkZXNjcmlwdG9yIG5lZWRzIHRv
IGJlIAo+PiBkaXNhYmxlZC4gVGhlIHRhYmxlIGNhbid0IGJlIHdyb3RlIGJ5IHRoZSBkZXZpY2Ug
c2luY2UgaXQncyBub3QgCj4+IGNvaGVyZW50IHN3aW90bGIgbWFwcGluZy4KPgo+IEkgaGFkIGFs
bCBraW5kcyBvZiBwcm9ibGVtcyB3aXRoIHVuaW5pdGlhbGl6ZWQgZW50cmllcyBpbiB0aGUgaW5k
aXJlY3QgCj4gdGFibGUuIFNvIEkgZ2F2ZSB1cCBvbiBpdCBhbmQgY29uY2x1ZGVkIGl0IHdvdWxk
IGJlIHRvbyBkaWZmaWN1bHQgdG8gCj4gc2VjdXJlLgo+Cj4KPiAtQW5kaQo+Cj4KCk9rLCBidXQg
d2hhdCBJIG1lYW50IGlzIHRoaXMsIGlmIHdlIGRvbid0IHJlYWQgZnJvbSB0aGUgZGVzY3JpcHRv
ciByaW5nLCAKYW5kIHZhbGlkYXRlIGFsbCB0aGUgb3RoZXIgbWV0YWRhdGEgc3VwcGxpZWQgYnkg
dGhlIGRldmljZSAodXNlZCBpZCBhbmQgCmxlbikuIFRoZW4gdGhlcmUgc2hvdWxkIGJlIG5vIHdh
eSBmb3IgdGhlIGRldmljZSB0byBzdXBwcmVzcyB0aGUgZG1hIApmbGFncyB0byB3cml0ZSB0byB0
aGUgaW5kaXJlY3QgZGVzY3JpcHRvciB0YWJsZS4KCk9yIGRvIHlvdSBoYXZlIGFuIGV4YW1wbGUg
aG93IGl0IGNhbiBkbyB0aGF0PwoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
