Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356CC433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 06:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BD50611BC;
	Thu,  7 Apr 2022 06:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9vRxXqFWSfy; Thu,  7 Apr 2022 06:39:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7BCE4605A5;
	Thu,  7 Apr 2022 06:39:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5517CC002C;
	Thu,  7 Apr 2022 06:39:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9941BC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7685440160
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Y9It5YUs1Lq
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C8D540133
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649313592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OG5GNjyBBg6GuhhD2ccdgmToZso90lqtSFSgk9L3dxA=;
 b=TLWnOWdFViG+e9pc2+o4WlqIBWmvhxp2PqJgOMUGv61nnna/QH2PDBIu2ao6nbPlRRz4hV
 HRVfVLa++012r5PjXBLmEze+Le2ujm2euFCEVshVVljcSc3KmqHvEh/9qtJWbaKd/ESjhU
 D9O59RIBC40tDou5HxUPw3oa4YWDOOI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-t-tcaQn-P4uXV0JfXOfdOQ-1; Thu, 07 Apr 2022 02:39:51 -0400
X-MC-Unique: t-tcaQn-P4uXV0JfXOfdOQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 nm20-20020a17090b19d400b001ca8fa98274so5272985pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 23:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OG5GNjyBBg6GuhhD2ccdgmToZso90lqtSFSgk9L3dxA=;
 b=LM/ZunRYCxv3VVcRf3/jQIDtZSZaOCpqor/pSooOFKQha7rQFdXIr9QXvpdlv8s5IU
 vHwpnnyCVHmcst+jOGHa3IntCZe+WJurcLcyOOWKcW4QxjKS/j0WnP7Dab4sDmoluj6P
 B6srVJKyDIYP0qF3ZuX8OiMybPYVJ58CcIwjtYyhY67UQ+1H5PwZgtRXPZb2KvbHQrE9
 W8pnay8RsHx2Re2gBS/P3OTYTI4lfQsXBAbc1fZt3w1hZMvw/ng5jgd7SIhnAkmMTAcv
 rKPNV1mqHnMhz9AzzcGF0DEKsVDWyBYNQcsFRsVsttzIb+0v9EDwrWNk8aB77MBX5Zzt
 alTg==
X-Gm-Message-State: AOAM530t+MK1pd84ElKCo8uUg9ORbTzhebNYN2Ry3kDpU7PnAOyFjpU1
 dagSbwf7wl71QB9ZvthUxRMxIk/54StqyPGwLPpGSD8MviUvRYbSeWXZth3IyqZtH73FMhv/agi
 Q3gtsnueIwsE0esgzmIrZ44KDvd+g8RsLXgElTuVlww==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id
 oa2-20020a17090b1bc200b001c99cd1a4femr14137783pjb.136.1649313590177; 
 Wed, 06 Apr 2022 23:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZZmLkK2KTu+6hYyXHJCHf5jxdVnoM5DfGypuoK3qjvhEKnIVHWTGSZ5+lZz0DskhFVkG9gw==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id
 oa2-20020a17090b1bc200b001c99cd1a4femr14137760pjb.136.1649313589934; 
 Wed, 06 Apr 2022 23:39:49 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a637d10000000b00381268f2c6fsm18145927pgc.4.2022.04.06.23.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Apr 2022 23:39:49 -0700 (PDT)
Message-ID: <726caf4c-3dde-8a47-e665-6b2b963304b6@redhat.com>
Date: Thu, 7 Apr 2022 14:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 5/5] virtio: harden vring IRQ
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-6-jasowang@redhat.com>
 <20220406080135-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406080135-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

CuWcqCAyMDIyLzQvNiDkuIvljYg4OjA0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9u
IFdlZCwgQXByIDA2LCAyMDIyIGF0IDA0OjM1OjM4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IFRoaXMgaXMgYSByZXdvcmsgb24gdGhlIHByZXZpb3VzIElSUSBoYXJkZW5pbmcgdGhhdCBp
cyBkb25lIGZvcgo+PiB2aXJ0aW8tcGNpIHdoZXJlIHNldmVyYWwgZHJhd2JhY2tzIHdlcmUgZm91
bmQgYW5kIHdlcmUgcmV2ZXJ0ZWQ6Cj4+Cj4+IDEpIHRyeSB0byB1c2UgSVJRRl9OT19BVVRPRU4g
d2hpY2ggaXMgbm90IGZyaWVuZGx5IHRvIGFmZmluaXR5IG1hbmFnZWQgSVJRCj4+ICAgICB0aGF0
IGlzIHVzZWQgYnkgc29tZSBkZXZpY2Ugc3VjaCBhcyB2aXJ0aW8tYmxrCj4+IDIpIGRvbmUgb25s
eSBmb3IgUENJIHRyYW5zcG9ydAo+Pgo+PiBJbiB0aGlzIHBhdGNoLCB3ZSB0cmllcyB0byBib3Jy
b3cgdGhlIGlkZWEgZnJvbSB0aGUgSU5UWCBJUlEgaGFyZGVuaW5nCj4+IGluIHRoZSByZXZlcnRl
ZCBjb21taXQgMDgwY2Q3YzNhYzg3ICgidmlydGlvLXBjaTogaGFyZGVuIElOVFggaW50ZXJydXB0
cyIpCj4+IGJ5IGludHJvZHVjaW5nIGEgZ2xvYmFsIGRldmljZV9yZWFkeSB2YXJpYWJsZSBmb3Ig
ZWFjaAo+PiB2aXJ0aW9fZGV2aWNlLiBUaGVuIHdlIGNhbiB0byB0b2dnbGUgaXQgZHVyaW5nCj4+
IHZpcnRpb19yZXNldF9kZXZpY2UoKS92aXJ0aW9fZGV2aWNlX3JlYWR5KCkuIEEKPj4gdmlydGlv
X3N5bmNob3JuaXplX3ZxcygpIGlzIHVzZWQgaW4gYm90aCB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkg
YW5kCj4+IHZpcnRpb19yZXNldF9kZXZpY2UoKSB0byBzeW5jaHJvbml6ZSB3aXRoIHRoZSB2cmlu
ZyBjYWxsYmFja3MuIFdpdGgKPj4gdGhpcywgdnJpbmdfaW50ZXJydXB0KCkgY2FuIHJldHVybiBj
aGVjayBhbmQgZWFybHkgaWYgZHJpdmVyX3JlYWR5IGlzCj4+IGZhbHNlLgo+Pgo+PiBOb3RlIHRo
YXQgdGhlIGhhcmRlbmluZyBpcyBvbmx5IGRvbmUgZm9yIHZyaW5nIGludGVycnVwdCBzaW5jZSB0
aGUKPj4gY29uZmlnIGludGVycnVwdCBoYXJkZW5pbmcgaXMgYWxyZWFkeSBkb25lIGluIGNvbW1p
dCAyMmI3MDUwYTAyNGQ3Cj4+ICgidmlydGlvOiBkZWZlciBjb25maWcgY2hhbmdlZCBub3RpZmlj
YXRpb25zIikuIEJ1dCB0aGUgbWV0aG9kIHRoYXQgaXMKPj4gdXNlZCBieSBjb25maWcgaW50ZXJy
dXB0IGNhbid0IGJlIHJldXNlZCBieSB0aGUgdnJpbmcgaW50ZXJydXB0Cj4+IGhhbmRsZXIgYmVj
YXVzZSBpdCB1c2VzIHNwaW5sb2NrIHRvIGRvIHRoZSBzeW5jaHJvbml6YXRpb24gd2hpY2ggaXMK
Pj4gZXhwZW5zaXZlLgo+Pgo+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+Cj4+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Cj4+IENjOiAi
UGF1bCBFLiBNY0tlbm5leSIgPHBhdWxtY2tAa2VybmVsLm9yZz4KPj4gQ2M6IE1hcmMgWnluZ2ll
ciA8bWF6QGtlcm5lbC5vcmc+Cj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpby5jICAgICAgIHwg
MTEgKysrKysrKysrKysKPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICB8ICA5ICsr
KysrKysrLQo+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgIHwgIDIgKysKPj4gICBp
bmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8ICA4ICsrKysrKysrCj4+ICAgNCBmaWxlcyBj
aGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jCj4+IGlu
ZGV4IDhkZGU0NGVhMDQ0YS4uMmYzYTZmOGUzZDljIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW8uYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYwo+PiBAQCAtMjIw
LDYgKzIyMCwxNyBAQCBzdGF0aWMgaW50IHZpcnRpb19mZWF0dXJlc19vayhzdHJ1Y3QgdmlydGlv
X2RldmljZSAqZGV2KQo+PiAgICAqICovCj4+ICAgdm9pZCB2aXJ0aW9fcmVzZXRfZGV2aWNlKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4+ICAgewo+PiArCWlmIChSRUFEX09OQ0UoZGV2LT5k
cml2ZXJfcmVhZHkpKSB7Cj4+ICsJCS8qCj4+ICsJCSAqIFRoZSBiZWxvdyB2aXJ0aW9fc3luY2hy
b25pemVfdnFzKCkgZ3VhcmFudGVlcyB0aGF0IGFueQo+PiArCQkgKiBpbnRlcnJ1cHQgZm9yIHRo
aXMgbGluZSBhcnJpdmluZyBhZnRlcgo+PiArCQkgKiB2aXJ0aW9fc3luY2hyb25pemVfdnFzKCkg
aGFzIGNvbXBsZXRlZCBpcyBndWFyYW50ZWVkIHRvIHNlZQo+PiArCQkgKiBkcml2ZXJfcmVhZHkg
PT0gZmFsc2UuCj4+ICsJCSAqLwo+PiArCQlXUklURV9PTkNFKGRldi0+ZHJpdmVyX3JlYWR5LCBm
YWxzZSk7Cj4+ICsJCXZpcnRpb19zeW5jaHJvbml6ZV92cXMoZGV2KTsKPj4gKwl9Cj4+ICsKPj4g
ICAJZGV2LT5jb25maWctPnJlc2V0KGRldik7Cj4+ICAgfQo+PiAgIEVYUE9SVF9TWU1CT0xfR1BM
KHZpcnRpb19yZXNldF9kZXZpY2UpOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4gaW5kZXggY2ZiMDI4
Y2EyMzhlLi5hNDU5MmU1NWM5ZjggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiBAQCAtMjEy
NywxMCArMjEyNywxNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgbW9yZV91c2VkKGNvbnN0IHN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxKQo+PiAgIAlyZXR1cm4gdnEtPnBhY2tlZF9yaW5nID8gbW9y
ZV91c2VkX3BhY2tlZCh2cSkgOiBtb3JlX3VzZWRfc3BsaXQodnEpOwo+PiAgIH0KPj4gICAKPj4g
LWlycXJldHVybl90IHZyaW5nX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpfdnEpCj4+ICtpcnFy
ZXR1cm5fdCB2cmluZ19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqdikKPj4gICB7Cj4+ICsJc3Ry
dWN0IHZpcnRxdWV1ZSAqX3ZxID0gdjsKPj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9
IF92cS0+dmRldjsKPj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3Zx
KTsKPj4gICAKPj4gKwlpZiAoIVJFQURfT05DRSh2ZGV2LT5kcml2ZXJfcmVhZHkpKSB7Cj4KPiBJ
IGFtIG5vdCBzdXJlIHdoeSB3ZSBuZWVkIFJFQURfT05DRSBoZXJlLCBpdCdzIGRvbmUgdW5kZXIg
bG9jay4KCgpJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgd2hpY2ggbG9jayBkaWQgeW91IG1lYW4g
aGVyZT8gKE5vdGUgdGhlIGlycSAKaGFuZGxlciBkb2Vzbid0IGhvbGQgdGhlIGlycSBkZXNjcmlw
dG9yIGxvY2spLgoKVGhhbmtzCgoKPgo+Cj4gQWNjcmRpbmdseSwgc2FtZSB0aGluZyBhYm92ZSBm
b3IgUkVBRF9PTkNFIGFuZCBXUklURV9PTkNFLgo+Cj4KPj4gKwkJZGV2X3dhcm5fb25jZSgmdmRl
di0+ZGV2LCAidmlydGlvIHZyaW5nIElSUSByYWlzZWQgYmVmb3JlIERSSVZFUl9PSyIpOwo+PiAr
CQlyZXR1cm4gSVJRX05PTkU7Cj4+ICsJfQo+PiArCj4+ICAgCWlmICghbW9yZV91c2VkKHZxKSkg
ewo+PiAgIAkJcHJfZGVidWcoInZpcnRxdWV1ZSBpbnRlcnJ1cHQgd2l0aCBubyB3b3JrIGZvciAl
cFxuIiwgdnEpOwo+PiAgIAkJcmV0dXJuIElSUV9OT05FOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPj4gaW5kZXggNTQ2NGYz
OTg5MTJhLi5kZmEyNjM4YTI5M2UgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+PiBAQCAtOTUsNiArOTUsNyBAQCBk
bWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsK
Pj4gICAgKiBAZmFpbGVkOiBzYXZlZCB2YWx1ZSBmb3IgVklSVElPX0NPTkZJR19TX0ZBSUxFRCBi
aXQgKGZvciByZXN0b3JlKQo+PiAgICAqIEBjb25maWdfZW5hYmxlZDogY29uZmlndXJhdGlvbiBj
aGFuZ2UgcmVwb3J0aW5nIGVuYWJsZWQKPj4gICAgKiBAY29uZmlnX2NoYW5nZV9wZW5kaW5nOiBj
b25maWd1cmF0aW9uIGNoYW5nZSByZXBvcnRlZCB3aGlsZSBkaXNhYmxlZAo+PiArICogQGRyaXZl
cl9yZWFkeTogd2hlaHRlciB0aGUgZHJpdmVyIGlzIHJlYWR5IChlLmcgZm9yIHZyaW5nIGNhbGxi
YWNrcykKPj4gICAgKiBAY29uZmlnX2xvY2s6IHByb3RlY3RzIGNvbmZpZ3VyYXRpb24gY2hhbmdl
IHJlcG9ydGluZwo+PiAgICAqIEBkZXY6IHVuZGVybHlpbmcgZGV2aWNlLgo+PiAgICAqIEBpZDog
dGhlIGRldmljZSB0eXBlIGlkZW50aWZpY2F0aW9uICh1c2VkIHRvIG1hdGNoIGl0IHdpdGggYSBk
cml2ZXIpLgo+PiBAQCAtMTA5LDYgKzExMCw3IEBAIHN0cnVjdCB2aXJ0aW9fZGV2aWNlIHsKPj4g
ICAJYm9vbCBmYWlsZWQ7Cj4+ICAgCWJvb2wgY29uZmlnX2VuYWJsZWQ7Cj4+ICAgCWJvb2wgY29u
ZmlnX2NoYW5nZV9wZW5kaW5nOwo+PiArCWJvb2wgZHJpdmVyX3JlYWR5Owo+PiAgIAlzcGlubG9j
a190IGNvbmZpZ19sb2NrOwo+PiAgIAlzcGlubG9ja190IHZxc19saXN0X2xvY2s7IC8qIFByb3Rl
Y3RzIFZRcyBsaXN0IGFjY2VzcyAqLwo+PiAgIAlzdHJ1Y3QgZGV2aWNlIGRldjsKPj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0
aW9fY29uZmlnLmgKPj4gaW5kZXggMDhiNzNkOWJiZmYyLi5jOWUyMDdiZjJjOWMgMTAwNjQ0Cj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvdmlydGlvX2NvbmZpZy5oCj4+IEBAIC0yNDYsNiArMjQ2LDE0IEBAIHZvaWQgdmlydGlvX2Rl
dmljZV9yZWFkeShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+PiAgIHsKPj4gICAJdW5zaWdu
ZWQgc3RhdHVzID0gZGV2LT5jb25maWctPmdldF9zdGF0dXMoZGV2KTsKPj4gICAKPj4gKwl2aXJ0
aW9fc3luY2hyb25pemVfdnFzKGRldik7Cj4+ICsgICAgICAgIC8qCj4+ICsgICAgICAgICAqIFRo
ZSBhYm92ZSB2aXJ0aW9fc3luY2hyb25pemVfdnFzKCkgbWFrZSBzdXJlCj4KPiBtYWtlcyBzdXJl
Cj4KPj4gKyAgICAgICAgICogdnJpbmdfaW50ZXJydXB0KCkgd2lsbCBzZWUgdGhlIGRyaXZlciBz
cGVjaWZpYyBzZXR1cCBpZiBpdAo+PiArICAgICAgICAgKiBzZWUgZHJpdmVyX3JlYWR5IGFzIHRy
dWUuCj4gc2Vlcwo+Cj4+ICsgICAgICAgICAqLwo+PiArCVdSSVRFX09OQ0UoZGV2LT5kcml2ZXJf
cmVhZHksIHRydWUpOwo+PiArCj4+ICAgCUJVR19PTihzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1Nf
RFJJVkVSX09LKTsKPj4gICAJZGV2LT5jb25maWctPnNldF9zdGF0dXMoZGV2LCBzdGF0dXMgfCBW
SVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKTsKPj4gICB9Cj4+IC0tIAo+PiAyLjI1LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
