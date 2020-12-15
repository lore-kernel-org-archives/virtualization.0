Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77173C4361B
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 11:43:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C432226A
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 11:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C432226A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 59AB6204FF;
	Tue, 15 Dec 2020 11:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WY0Ijanu2aLG; Tue, 15 Dec 2020 11:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1ADF32034C;
	Tue, 15 Dec 2020 11:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11B2DC088E;
	Tue, 15 Dec 2020 11:43:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8F70C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 11:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9FC8187259
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 11:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T4R1YX2bWT4X
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 11:43:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A743D8724E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608032608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goME2hSqTlOZFsUal75epX/X/O/RKF0nPblt3Kqiumo=;
 b=dHnKGqCOCkmxSwmrTTs0c61t1CPX+Qju5y0KkQdNVP87l15YPWAN+VGgMyZiPGAy5aFRrU
 JMa3JfMoZoznXgGt4QQitq78RU6YE11ybLKJe10plWLqpZ/3O2emZeeqEpYDmXdbtr+SG2
 M6qvgOwKeNwrTyAdBY3CcuSG6aqh5ZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-iOB7hn-XNDmBwe5DBDxg0A-1; Tue, 15 Dec 2020 06:43:26 -0500
X-MC-Unique: iOB7hn-XNDmBwe5DBDxg0A-1
Received: by mail-wm1-f69.google.com with SMTP id f187so893366wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 03:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=goME2hSqTlOZFsUal75epX/X/O/RKF0nPblt3Kqiumo=;
 b=lbFwup/EPkhfX9nQGdZb/HZhAHte1qeqove0NO/itNlWLF8Ow//+CwoQq6lAXAmLqt
 79vElW6Bhc816AoeDwz27B01d2PpPfcGzlK5L0SFILi/u3DEopoIsqkLV8y0xJUx/p5s
 6BLELnGW6lX/FfRG2Mpb5YyOfTB25PIUV7EMeVbKVtmhQNIWpFJr6C/ABNdqpwPFNt1X
 gYIhn6nplhNb4isaWuCrk2I3ofnEcn0Az6k3SsjnpzZYucodzzjo8vD3/2AZZ0qV2fdb
 MzaykhT/K8LAj6OtzZuePpeiXJORwfBzBkaY1ri6x8vlF+Lwqqs/kC4QPBJdxOKASJeL
 0W2w==
X-Gm-Message-State: AOAM531FnakR2P4pB9oD9DcZmFVnmiIsiXiM4AaiVOOoPhmKn+z6/Yks
 vdDM11ZlzJDHyL25zhhR5qGDpDzFS/RBHNfOb+71k4wXAiPNdlERwUF/ib0Bw+xB8spFGk54aa/
 zqPS0zH5jzacivzknd4wHHMufDLlTxyxIKzw15ZsxRw==
X-Received: by 2002:adf:dc8b:: with SMTP id r11mr34084493wrj.131.1608032605703; 
 Tue, 15 Dec 2020 03:43:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtRGa2/ozBxM2PzGAqC+oThXH0iygkOmEWn3nkmpSJjKPNiTziBynhYs0F2alwvlB4gj+hEg==
X-Received: by 2002:adf:dc8b:: with SMTP id r11mr34084475wrj.131.1608032605492; 
 Tue, 15 Dec 2020 03:43:25 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it.
 [79.13.204.15])
 by smtp.gmail.com with ESMTPSA id 90sm37250897wrl.60.2020.12.15.03.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Dec 2020 03:43:24 -0800 (PST)
Date: Tue, 15 Dec 2020 12:43:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 13/19] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
Message-ID: <CAGxU2F4Eeb68J6PuapCneZtEqnyU2MVhCd4VZyVh-o-kxvQBkA@mail.gmail.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-14-sgarzare@redhat.com>
 <829a5026-a68c-6d02-49ef-f237dcae2460@redhat.com>
 <20201209110745.p4ybybanzip2lav3@steredhat>
MIME-Version: 1.0
In-Reply-To: <20201209110745.p4ybybanzip2lav3@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Ck9uIFdlZCwgRGVjIDksIDIwMjAgYXQgMTI6MDcgUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPiBPbiBNb24sIERlYyAwNywgMjAyMCBhdCAwMToyOTox
N1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+T24gMjAyMC8xMi80IOS4iuWNiDE6
MDUsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+PlRoZSBnZXRfY29uZmlnIGNhbGxiYWNr
IGNhbiBiZSB1c2VkIGJ5IHRoZSBkZXZpY2UgdG8gZmlsbCB0aGUKPiA+PmNvbmZpZyBzdHJ1Y3R1
cmUuCj4gPj5UaGUgY2FsbGJhY2sgd2lsbCBiZSBpbnZva2VkIGluIHZkcGFzaW1fZ2V0X2NvbmZp
ZygpIGJlZm9yZSBjb3B5aW5nCj4gPj5ieXRlcyBpbnRvIGNhbGxlciBidWZmZXIuCj4gPj4KPiA+
Pk1vdmUgdkRQQS1uZXQgY29uZmlnIHVwZGF0ZXMgZnJvbSB2ZHBhc2ltX3NldF9mZWF0dXJlcygp
IGluIHRoZQo+ID4+bmV3IHZkcGFzaW1fbmV0X2dldF9jb25maWcoKSBjYWxsYmFjay4KPiA+Pgo+
ID4+U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29t
Pgo+ID4+LS0tCj4gPj52MzoKPiA+Pi0gY2hlY2tlZCBpZiBnZXRfY29uZmlnIGNhbGxiYWNrIGlz
IHNldCBiZWZvcmUgY2FsbCBpdAo+ID4+LS0tCj4gPj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiA+PiAgMSBm
aWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+ID4+Cj4gPj5k
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ID4+aW5kZXggZmU3MWVkNzg5MGUxLi5mOTM1YWRlMDgw
NmIgMTAwNjQ0Cj4gPj4tLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ID4+
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiA+PkBAIC02MCw2ICs2MCw4
IEBAIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSB7Cj4gPj4gICNkZWZpbmUgVkRQQVNJTV9ORVRf
RkVBVFVSRVMgICAgICAgIChWRFBBU0lNX0ZFQVRVUkVTIHwgXAo+ID4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICgxVUxMIDw8IFZJUlRJT19ORVRfRl9NQUMpKQo+ID4+K3N0cnVjdCB2
ZHBhc2ltOwo+ID4+Kwo+ID4+ICBzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciB7Cj4gPj4gICAgICB1
NjQgc3VwcG9ydGVkX2ZlYXR1cmVzOwo+ID4+ICAgICAgc2l6ZV90IGNvbmZpZ19zaXplOwo+ID4+
QEAgLTY3LDYgKzY5LDcgQEAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgewo+ID4+ICAgICAgdTMy
IGlkOwo+ID4+ICAgICAgd29ya19mdW5jX3Qgd29ya19mbjsKPiA+PisgICAgIHZvaWQgKCpnZXRf
Y29uZmlnKShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdm9pZCAqY29uZmlnKTsKPiA+PiAgfTsK
PiA+PiAgLyogU3RhdGUgb2YgZWFjaCB2ZHBhc2ltIGRldmljZSAqLwo+ID4+QEAgLTUyMiw4ICs1
MjUsNiBAQCBzdGF0aWMgdTY0IHZkcGFzaW1fZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYSkKPiA+PiAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJlcykKPiA+PiAgewo+ID4+ICAgICAgc3RydWN0IHZk
cGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiA+Pi0gICAgIHN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZyAqY29uZmlnID0KPiA+Pi0gICAgICAgICAgICAgKHN0cnVjdCB2aXJ0aW9f
bmV0X2NvbmZpZyAqKXZkcGFzaW0tPmNvbmZpZzsKPiA+PiAgICAgIC8qIERNQSBtYXBwaW5nIG11
c3QgYmUgZG9uZSBieSBkcml2ZXIgKi8KPiA+PiAgICAgIGlmICghKGZlYXR1cmVzICYgKDFVTEwg
PDwgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gPj5AQCAtNTMxLDE2ICs1MzIsNiBAQCBz
dGF0aWMgaW50IHZkcGFzaW1fc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwg
dTY0IGZlYXR1cmVzKQo+ID4+ICAgICAgdmRwYXNpbS0+ZmVhdHVyZXMgPSBmZWF0dXJlcyAmIHZk
cGFzaW0tPmRldl9hdHRyLnN1cHBvcnRlZF9mZWF0dXJlczsKPiA+Pi0gICAgIC8qIFdlIGdlbmVy
YWxseSBvbmx5IGtub3cgd2hldGhlciBndWVzdCBpcyB1c2luZyB0aGUgbGVnYWN5IGludGVyZmFj
ZQo+ID4+LSAgICAgICogaGVyZSwgc28gZ2VuZXJhbGx5IHRoYXQncyB0aGUgZWFybGllc3Qgd2Ug
Y2FuIHNldCBjb25maWcgZmllbGRzLgo+ID4+LSAgICAgICogTm90ZTogV2UgYWN0dWFsbHkgcmVx
dWlyZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gYWJvdmUgd2hpY2gKPiA+Pi0gICAgICAqIGlt
cGxpZXMgVklSVElPX0ZfVkVSU0lPTl8xLCBidXQgbGV0J3Mgbm90IHRyeSB0byBiZSBjbGV2ZXIg
aGVyZS4KPiA+Pi0gICAgICAqLwo+ID4+LQo+ID4+LSAgICAgY29uZmlnLT5tdHUgPSBjcHVfdG9f
dmRwYXNpbTE2KHZkcGFzaW0sIDE1MDApOwo+ID4+LSAgICAgY29uZmlnLT5zdGF0dXMgPSBjcHVf
dG9fdmRwYXNpbTE2KHZkcGFzaW0sIFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPiA+Pi0gICAgIG1l
bWNweShjb25maWctPm1hYywgbWFjYWRkcl9idWYsIEVUSF9BTEVOKTsKPiA+Cj4gPgo+ID5QYXRj
aCBsb29rcyBnb29kIHRvIG1lLgo+ID4KPiA+QnV0IHdlIG5lZWQgTWljaGFlbCB0byBjb25maXJt
IHdoZXRoZXIgZG9pbmcgbW92aW5nIGxpa2UgdGhpcyBpcyBzYWZlLgo+ID5JIGd1ZXNzIHdoYXQg
aGFzIGJlZW4gZG9uZSB3ZXJlIHRyeWluZyB0byBtYWtlIHN1cmUgZ2V0X2NvbmZpZygpIGZhaWwK
PiA+YmVmb3JlIHNldF9mZWF0dXJlcygpLCBidXQgaXQncyBub3QgY2xlYXIgdG8gbWUgd2hldGhl
ciBpdCdzIHVzZWZ1bC4KPgo+IElJVUMsIGFsc28gbG9va2luZyB0aGUgUUVNVSBjb2RlLCB0aGUg
c2V0X2ZlYXR1cmVzKCkgc2hvdWxkIGJlIGNhbGxlZAo+IGV2ZXJ5IHRpbWUgYmVmb3JlIGdldF9j
b25maWcoKSwgYnV0IHRvIGJlIHN1cmUsIGluIGdldF9jb25maWcoKSwgSSBjYW4KPiBjaGVjayBm
b3IgZXhhbXBsZSBpZiAndmRwYXNpbS0+ZmVhdHVyZXMnIGlzIG5vdCB6ZXJvICh3ZSByZXF1aXJl
Cj4gVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIHNldCkuCgpXb3JraW5nIG9uIHRoaXMgSSBqdXN0
IHJlYWxpemVkIHRoYXQgd2UgYWxyZWFkeSBjaGVjayBpbiAKdmRwYV9nZXRfY29uZmlnKCkgdGhh
dCBzZXRfZmVhdHVyZXMoKSBpcyBjYWxsZWQsIHNvIEkgdGhpbmsgdGhlIG1vdmluZyAKaXMgc2Fm
ZS4KCkknbGwgcHV0IHRoZXNlIGNvbnNpZGVyYXRpb25zIGluIHRoZSBjb21taXQgbWVzc2FnZS4K
ClRoYW5rcywKU3RlZmFubwoKPgo+IEBNaWNoYWVsIGFueSBzdWdnZXN0aW9uPwo+Cj4gVGhhbmtz
LAo+IFN0ZWZhbm8KPgo+ID4KPiA+VGhhbmtzCj4gPgo+ID4KPiA+Pi0KPiA+PiAgICAgIHJldHVy
biAwOwo+ID4+ICB9Cj4gPj5AQCAtNTk1LDggKzU4NiwxMyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2lt
X2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1bnNpZ25lZCBpbnQgb2Zmc2V0
LAo+ID4+ICB7Cj4gPj4gICAgICBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2lt
KHZkcGEpOwo+ID4+LSAgICAgaWYgKG9mZnNldCArIGxlbiA8IHZkcGFzaW0tPmRldl9hdHRyLmNv
bmZpZ19zaXplKQo+ID4+LSAgICAgICAgICAgICBtZW1jcHkoYnVmLCB2ZHBhc2ltLT5jb25maWcg
KyBvZmZzZXQsIGxlbik7Cj4gPj4rICAgICBpZiAob2Zmc2V0ICsgbGVuID4gdmRwYXNpbS0+ZGV2
X2F0dHIuY29uZmlnX3NpemUpCj4gPj4rICAgICAgICAgICAgIHJldHVybjsKPiA+PisKPiA+Pisg
ICAgIGlmICh2ZHBhc2ltLT5kZXZfYXR0ci5nZXRfY29uZmlnKQo+ID4+KyAgICAgICAgICAgICB2
ZHBhc2ltLT5kZXZfYXR0ci5nZXRfY29uZmlnKHZkcGFzaW0sIHZkcGFzaW0tPmNvbmZpZyk7Cj4g
Pj4rCj4gPj4rICAgICBtZW1jcHkoYnVmLCB2ZHBhc2ltLT5jb25maWcgKyBvZmZzZXQsIGxlbik7
Cj4gPj4gIH0KPiA+PiAgc3RhdGljIHZvaWQgdmRwYXNpbV9zZXRfY29uZmlnKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSwgdW5zaWduZWQgaW50IG9mZnNldCwKPiA+PkBAIC03MzksNiArNzM1LDE2
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fYmF0Y2hfY29u
ZmlnX29wcyA9IHsKPiA+PiAgICAgIC5mcmVlICAgICAgICAgICAgICAgICAgID0gdmRwYXNpbV9m
cmVlLAo+ID4+ICB9Owo+ID4+K3N0YXRpYyB2b2lkIHZkcGFzaW1fbmV0X2dldF9jb25maWcoc3Ry
dWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZvaWQgKmNvbmZpZykKPiA+Pit7Cj4gPj4rICAgICBzdHJ1
Y3QgdmlydGlvX25ldF9jb25maWcgKm5ldF9jb25maWcgPQo+ID4+KyAgICAgICAgICAgICAoc3Ry
dWN0IHZpcnRpb19uZXRfY29uZmlnICopY29uZmlnOwo+ID4+Kwo+ID4+KyAgICAgbmV0X2NvbmZp
Zy0+bXR1ID0gY3B1X3RvX3ZkcGFzaW0xNih2ZHBhc2ltLCAxNTAwKTsKPiA+PisgICAgIG5ldF9j
b25maWctPnN0YXR1cyA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwgVklSVElPX05FVF9TX0xJ
TktfVVApOwo+ID4+KyAgICAgbWVtY3B5KG5ldF9jb25maWctPm1hYywgbWFjYWRkcl9idWYsIEVU
SF9BTEVOKTsKPiA+Pit9Cj4gPj4rCj4gPj4gIHN0YXRpYyBpbnQgX19pbml0IHZkcGFzaW1fZGV2
X2luaXQodm9pZCkKPiA+PiAgewo+ID4+ICAgICAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgZGV2
X2F0dHIgPSB7fTsKPiA+PkBAIC03NDcsNiArNzUzLDcgQEAgc3RhdGljIGludCBfX2luaXQgdmRw
YXNpbV9kZXZfaW5pdCh2b2lkKQo+ID4+ICAgICAgZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVz
ID0gVkRQQVNJTV9ORVRfRkVBVFVSRVM7Cj4gPj4gICAgICBkZXZfYXR0ci5udnFzID0gVkRQQVNJ
TV9WUV9OVU07Cj4gPj4gICAgICBkZXZfYXR0ci5jb25maWdfc2l6ZSA9IHNpemVvZihzdHJ1Y3Qg
dmlydGlvX25ldF9jb25maWcpOwo+ID4+KyAgICAgZGV2X2F0dHIuZ2V0X2NvbmZpZyA9IHZkcGFz
aW1fbmV0X2dldF9jb25maWc7Cj4gPj4gICAgICBkZXZfYXR0ci53b3JrX2ZuID0gdmRwYXNpbV9u
ZXRfd29yazsKPiA+PiAgICAgIHZkcGFzaW1fZGV2ID0gdmRwYXNpbV9jcmVhdGUoJmRldl9hdHRy
KTsKPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
