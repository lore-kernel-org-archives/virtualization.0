Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF26C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 08:33:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C2760F02
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 08:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53C2760F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ADC483B56;
	Wed,  4 Aug 2021 08:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydMP5birv7Hh; Wed,  4 Aug 2021 08:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 978DF83AB4;
	Wed,  4 Aug 2021 08:33:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 702F0C001A;
	Wed,  4 Aug 2021 08:33:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13511C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 028C4606DA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7qFyWLPSQOcH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:33:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B7E76067B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628066006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pu0a7lvcVcx3k9JzblDeMR6k/r0nIYwunXvj5hzSi7c=;
 b=SNMAbSdYvYBtA54NwuQhSNLe6nSMASNWQlQh80cOomQ9HnvQit4cKgbte4MBeVdaX3oS7E
 OEM5eakoPcVNSXgYW/fcGcPwS5waiX4T0XqjWMECuKSa3Qp8MhCC8TI1LXlZSt2ndYeXbE
 FJbrTvK8AiKQsDz/aONhxA73JyIXo0I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-860JlugePf2nviQMmMScIg-1; Wed, 04 Aug 2021 04:33:25 -0400
X-MC-Unique: 860JlugePf2nviQMmMScIg-1
Received: by mail-pj1-f69.google.com with SMTP id
 f62-20020a17090a28c4b02901733dbfa29cso5849740pjd.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 01:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pu0a7lvcVcx3k9JzblDeMR6k/r0nIYwunXvj5hzSi7c=;
 b=Y/INYDB0PW0A1Ia5PNubFmulfKUbKndvKmA2wwOZ1JMazkeWUweyJMGlgT9X2pGtgW
 EWNVvmQqC24e4hUYYMspF6k0n0aCGkE4pf9SOauQrfSCY+fybbRdaqBdFlfUqoU51HLr
 5Utu9h8HGdKnY7xDcZ7ksg25yQsta5a+rHM/U57EL+Pqa29Hkr22CYKAFrQtmUwzxoxu
 JUXmY6+qmFh0xE1R2BxjdVnMpOxKw1bFB045DpWCD/HSQvacK13JI6mOT4ejamipHrXb
 rXqLevZk9RhiEIGyVpnpUPvvDLPMJ+dmBUASoERweCfT/hLqZkpCU1MaKCzKMkGteXUk
 cCgA==
X-Gm-Message-State: AOAM531hhDM34uVf1SoE19A3nrcJJNwN5ziDSbLTFi3bMuzQSWDBqAm5
 Mmfjli5CfJfbPXivDTGt2Uln71OwZW5iFzkIfF9v2RQfKaiPBPfh4Hl8PDEtxeUwGPXyUkoqtqN
 ic2vqGPF2dnAqYuw7R54qX/6DVkAZSOKST9PDrGOTXg==
X-Received: by 2002:a17:90a:d910:: with SMTP id
 c16mr8668194pjv.62.1628066004065; 
 Wed, 04 Aug 2021 01:33:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGRA+b96dTvWH6rNF0GvUzAXXF5DIHsXTKRy/aLxqgmWgMfbwupx2NN3JsBxmvFmLwQEe/ug==
X-Received: by 2002:a17:90a:d910:: with SMTP id
 c16mr8668175pjv.62.1628066003910; 
 Wed, 04 Aug 2021 01:33:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i24sm1831736pfr.207.2021.08.04.01.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 01:33:23 -0700 (PDT)
Subject: Re: [PATCH v10 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on
 reset failure
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-6-xieyongji@bytedance.com>
 <55191de0-1a03-ff0d-1a49-afc419014bab@redhat.com>
 <CACycT3sfiFizYQckHi5k4MpVpOOQCEwJhC-cToAnXaBVHTDPQQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f9311396-c461-e14a-d24e-0f8cd6458a11@redhat.com>
Date: Wed, 4 Aug 2021 16:33:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sfiFizYQckHi5k4MpVpOOQCEwJhC-cToAnXaBVHTDPQQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzgvMyDkuIvljYg1OjUwLCBZb25namkgWGllIOWGmemBkzoKPiBPbiBUdWUsIEF1
ZyAzLCAyMDIxIGF0IDQ6MTAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IOWcqCAyMDIxLzcvMjkg5LiL5Y2IMzozNCwgWGllIFlvbmdqaSDlhpnpgZM6Cj4+
PiBSZS1yZWFkIHRoZSBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSBpdCdzIHNldCB0byB6ZXJvIGR1
cmluZwo+Pj4gcmVzZXR0aW5nLiBPdGhlcndpc2UsIGZhaWwgdGhlIHZob3N0X3ZkcGFfc2V0X3N0
YXR1cygpIGFmdGVyIHRpbWVvdXQuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8
eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvdmhvc3QvdmRw
YS5jIHwgMTEgKysrKysrKysrKy0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRw
YS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+IGluZGV4IGIwN2FhMTYxZjdhZC4uZGQwNWMx
ZTExMzNjIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+ICsrKyBiL2Ry
aXZlcnMvdmhvc3QvdmRwYS5jCj4+PiBAQCAtMTU3LDcgKzE1Nyw3IEBAIHN0YXRpYyBsb25nIHZo
b3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0
dXNwKQo+Pj4gICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+PiAg
ICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+
Pj4gICAgICAgIHU4IHN0YXR1cywgc3RhdHVzX29sZDsKPj4+IC0gICAgIGludCBudnFzID0gdi0+
bnZxczsKPj4+ICsgICAgIGludCB0aW1lb3V0ID0gMCwgbnZxcyA9IHYtPm52cXM7Cj4+PiAgICAg
ICAgdTE2IGk7Cj4+Pgo+Pj4gICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmc3RhdHVzLCBzdGF0
dXNwLCBzaXplb2Yoc3RhdHVzKSkpCj4+PiBAQCAtMTczLDYgKzE3MywxNSBAQCBzdGF0aWMgbG9u
ZyB2aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU4IF9fdXNlciAq
c3RhdHVzcCkKPj4+ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4KPj4+ICAgICAg
ICBvcHMtPnNldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPj4+ICsgICAgIGlmIChzdGF0dXMgPT0g
MCkgewo+Pj4gKyAgICAgICAgICAgICB3aGlsZSAob3BzLT5nZXRfc3RhdHVzKHZkcGEpKSB7Cj4+
PiArICAgICAgICAgICAgICAgICAgICAgdGltZW91dCArPSAyMDsKPj4+ICsgICAgICAgICAgICAg
ICAgICAgICBpZiAodGltZW91dCA+IFZEUEFfUkVTRVRfVElNRU9VVF9NUykKPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOwo+Pj4gKwo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIG1zbGVlcCgyMCk7Cj4+PiArICAgICAgICAgICAgIH0KPj4KPj4gU3BlYyBoYXMg
aW50cm9kdWNlZCB0aGUgcmVzZXQgYSBvbmUgb2YgdGhlIGJhc2ljIGZhY2lsaXR5LiBBbmQgY29u
c2lkZXIKPj4gd2UgZGlmZmVyIHJlc2V0IGhlcmUuCj4+Cj4+IFRoaXMgbWFrZXMgbWUgdGhpbmsg
aWYgaXQncyBiZXR0ZXIgdG8gaW50cm9kdWNlIGEgZGVkaWNhdGVkIHZkcGEgb3BzIGZvcgo+PiBy
ZXNldD8KPj4KPiBEbyB5b3UgbWVhbiByZXBsYWNlIHRoZSBvcHMuc2V0X3N0YXR1cyh2ZGV2LCAw
KSB3aXRoIHRoZSBvcHMucmVzZXQoKT8KPiBUaGVuIHdlIGNhbiByZW1vdmUgdGhlIHRpbWVvdXQg
cHJvY2Vzc2luZyB3aGljaCBpcyBkZXZpY2Ugc3BlY2lmaWMKPiBzdHVmZi4KCgpFeGFjdGx5LgoK
VGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
