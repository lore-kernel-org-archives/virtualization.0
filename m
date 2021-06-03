Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A38C4708F
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:12:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF6D61263
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF6D61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B78560B20;
	Thu,  3 Jun 2021 03:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tLT8P-xdeqew; Thu,  3 Jun 2021 03:12:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7F5B606A3;
	Thu,  3 Jun 2021 03:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5025C000E;
	Thu,  3 Jun 2021 03:12:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52361C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B6A54058A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQvjwPTzPP6Q
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:12:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F14EF40587
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622689939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SFoKK+EC51c+l97246xTlvBZUhCQaLSTmUMS8zlQcZk=;
 b=iqVxoi6aZSzI25GKxN9wOR/AS6BnAngo2u2PhwAoj22wOGtuNvtVDhj2hgPWNxakgI6GzB
 aE8w+O7mSm3VDy/+Gk1gxo6vgKSS3r2Wr4oX0uZTLHyorIYoVFWKVEf765UhYGUOuues3G
 CCY/+cwURxXTCAOLrFfrd32hZXFjb/Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-7G3qa5EVOxGx4jX6SNVczA-1; Wed, 02 Jun 2021 23:12:17 -0400
X-MC-Unique: 7G3qa5EVOxGx4jX6SNVczA-1
Received: by mail-pj1-f69.google.com with SMTP id
 15-20020a17090a0f0fb029016ad0f32fd0so2088787pjy.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 20:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SFoKK+EC51c+l97246xTlvBZUhCQaLSTmUMS8zlQcZk=;
 b=t2wFIPZ8P/wNKbA79QY1pwV6fXPUYZZbNlUrhmIyIC0zTQhlyHhIT8HR7tBhHQljTb
 4c/HaZQ/WY+FDf7EIhCMTQ0KB4xSaxPj2+/3TpTDE+K8WA7asJO2b1c57sAMtptahd3p
 paZ9gKA9GDN4BnpESfGHFG6ucGMvIFkBVdn66wlaFrP32g8OGtYr50EpK6kKN7BS+qDc
 Q9W9NlQ5xe8HJ7DbmbYfuk9JVG3nzgXh9aPSNlS9MjfLs0vhxHr5LaDziLr/OVLuxZyT
 2Bd8NeIceTLPwfjrUJEqn84O9E16OWbQyRF0xa114KqW/pWGCnUiTZAaRYRNnZlx6NZV
 Fvug==
X-Gm-Message-State: AOAM53244yPrDHC4FBOyyMIZit2JaoR4YP4RsOey5vNr9jLSv5i/12mW
 91ijan0hbK7IOLalbkqTJf2v96hfvTGZt2iL4yDOcl2NNYi03mX6n+GqJBFMepQr7qy5f973FBT
 XDKL8ceUky8rPBD6K2bzSQTz0M3o44rsIHU1KptjsNon+35nUEUQVZlXG+NeW1KPF84mh/9vvgm
 HJTdQOL3CDO6C3B84Csw==
X-Received: by 2002:a62:92cd:0:b029:28f:29e6:449 with SMTP id
 o196-20020a6292cd0000b029028f29e60449mr30324451pfd.75.1622689936398; 
 Wed, 02 Jun 2021 20:12:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkn2v8Zrup0MBnXn4X+oF/0R4owcwDUsFQap52pM8H4wQ8OK2VUJyp6BRfCEq9v0xsTdxLtg==
X-Received: by 2002:a62:92cd:0:b029:28f:29e6:449 with SMTP id
 o196-20020a6292cd0000b029028f29e60449mr30324415pfd.75.1622689935924; 
 Wed, 02 Jun 2021 20:12:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p26sm778208pfw.178.2021.06.02.20.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 20:12:14 -0700 (PDT)
Subject: Re: [RFC v3 06/29] virtio-net: Honor VIRTIO_CONFIG_S_DEVICE_STOPPED
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-7-eperezma@redhat.com>
 <e64b9813-66e5-2417-3feb-65f0376db7e0@redhat.com>
 <4146c924-e871-5a94-253e-e9e09456f74b@redhat.com>
 <CAJaqyWeV+za=xeKHb9vn=Y+0mfekCb8w5dmWNMgzQ6uOtU3jxw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <16776ace-38eb-7a9f-366c-26e650badef3@redhat.com>
Date: Thu, 3 Jun 2021 11:12:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeV+za=xeKHb9vn=Y+0mfekCb8w5dmWNMgzQ6uOtU3jxw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 virtualization@lists.linux-foundation.org, Eric Blake <eblake@redhat.com>,
 Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzYvMSDkuIvljYgzOjEzLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gV2VkLCBNYXkgMjYsIDIwMjEgYXQgMzoxMCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNiDkuIrljYg5OjA2LCBKYXNvbiBXYW5n
IOWGmemBkzoKPj4+IOWcqCAyMDIxLzUvMjAg5LiK5Y2IMTI6MjgsIEV1Z2VuaW8gUMOpcmV6IOWG
memBkzoKPj4+PiBTbyB0aGUgZ3Vlc3QgY2FuIHN0b3AgYW5kIHN0YXJ0IG5ldCBkZXZpY2UuIEl0
IGltcGxlbWVudHMgdGhlIFJGQwo+Pj4+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJj
aGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMDEyL21zZzAwMDI3Lmh0bWwKPj4+Pgo+Pj4+Cj4+Pj4g
VG8gc3RvcCAoYXMgInBhdXNlIikgdGhlIGRldmljZSBpcyByZXF1aXJlZCB0byBtaWdyYXRlIHN0
YXR1cyBhbmQgdnJpbmcKPj4+PiBhZGRyZXNzZXMgYmV0d2VlbiBkZXZpY2UgYW5kIFNWUS4KPj4+
Pgo+Pj4+IFRoaXMgaXMgYSBXSVAgY29tbWl0OiBhcyB3aXRoIFZJUlRJT19GX1FVRVVFX1NUQVRF
LCBpcyBpbnRyb2R1Y2VkIGluCj4+Pj4gdmlydGlvX2NvbmZpZy5oIGJlZm9yZSBvZiBldmVuIHBy
b3Bvc2luZyBmb3IgdGhlIGtlcm5lbCwgd2l0aCBubyBmZWF0dXJlCj4+Pj4gZmxhZywgYW5kLCB3
aXRoIG5vIGNoZWNraW5nIGluIHRoZSBkZXZpY2UuIEl0IGFsc28gbmVlZHMgYSBtb2RpZmllZAo+
Pj4+IHZwX3ZkcGEgZHJpdmVyIHRoYXQgc3VwcG9ydHMgdG8gc2V0IGFuZCByZXRyaWV2ZSBzdGF0
dXMuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVk
aGF0LmNvbT4KPj4+PiAtLS0KPj4+PiAgICBpbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgv
dmlydGlvX2NvbmZpZy5oIHwgMiArKwo+Pj4+ICAgIGh3L25ldC92aXJ0aW8tbmV0LmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCA0ICsrKy0KPj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fY29uZmlnLmgKPj4+PiBiL2luY2x1ZGUv
c3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fY29uZmlnLmgKPj4+PiBpbmRleCA1OWZhZDNl
YjQ1Li5iM2Y2YjEzNjVkIDEwMDY0NAo+Pj4+IC0tLSBhL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVy
cy9saW51eC92aXJ0aW9fY29uZmlnLmgKPj4+PiArKysgYi9pbmNsdWRlL3N0YW5kYXJkLWhlYWRl
cnMvbGludXgvdmlydGlvX2NvbmZpZy5oCj4+Pj4gQEAgLTQwLDYgKzQwLDggQEAKPj4+PiAgICAj
ZGVmaW5lIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0sgICAgNAo+Pj4+ICAgIC8qIERyaXZlciBo
YXMgZmluaXNoZWQgY29uZmlndXJpbmcgZmVhdHVyZXMgKi8KPj4+PiAgICAjZGVmaW5lIFZJUlRJ
T19DT05GSUdfU19GRUFUVVJFU19PSyAgICA4Cj4+Pj4gKy8qIERldmljZSBpcyBzdG9wcGVkICov
Cj4+Pj4gKyNkZWZpbmUgVklSVElPX0NPTkZJR19TX0RFVklDRV9TVE9QUEVEIDMyCj4+Pj4gICAg
LyogRGV2aWNlIGVudGVyZWQgaW52YWxpZCBzdGF0ZSwgZHJpdmVyIG11c3QgcmVzZXQgaXQgKi8K
Pj4+PiAgICAjZGVmaW5lIFZJUlRJT19DT05GSUdfU19ORUVEU19SRVNFVCAgICAweDQwCj4+Pj4g
ICAgLyogV2UndmUgZ2l2ZW4gdXAgb24gdGhpcyBkZXZpY2UuICovCj4+Pj4gZGlmZiAtLWdpdCBh
L2h3L25ldC92aXJ0aW8tbmV0LmMgYi9ody9uZXQvdmlydGlvLW5ldC5jCj4+Pj4gaW5kZXggOTZh
M2NjODM1Ny4uMmQzY2FlYTI4OSAxMDA2NDQKPj4+PiAtLS0gYS9ody9uZXQvdmlydGlvLW5ldC5j
Cj4+Pj4gKysrIGIvaHcvbmV0L3ZpcnRpby1uZXQuYwo+Pj4+IEBAIC0xOTgsNyArMTk4LDkgQEAg
c3RhdGljIGJvb2wgdmlydGlvX25ldF9zdGFydGVkKFZpcnRJT05ldCAqbiwKPj4+PiB1aW50OF90
IHN0YXR1cykKPj4+PiAgICB7Cj4+Pj4gICAgICAgIFZpcnRJT0RldmljZSAqdmRldiA9IFZJUlRJ
T19ERVZJQ0Uobik7Cj4+Pj4gICAgICAgIHJldHVybiAoc3RhdHVzICYgVklSVElPX0NPTkZJR19T
X0RSSVZFUl9PSykgJiYKPj4+PiAtICAgICAgICAobi0+c3RhdHVzICYgVklSVElPX05FVF9TX0xJ
TktfVVApICYmIHZkZXYtPnZtX3J1bm5pbmc7Cj4+Pj4gKyAgICAgICAgKCEobi0+c3RhdHVzICYg
VklSVElPX0NPTkZJR19TX0RFVklDRV9TVE9QUEVEKSkgJiYKPj4+PiArICAgICAgICAobi0+c3Rh
dHVzICYgVklSVElPX05FVF9TX0xJTktfVVApICYmCj4+Pj4gKyAgICAgICAgdmRldi0+dm1fcnVu
bmluZzsKPj4+PiAgICB9Cj4+Pj4gICAgICBzdGF0aWMgdm9pZCB2aXJ0aW9fbmV0X2Fubm91bmNl
X25vdGlmeShWaXJ0SU9OZXQgKm5ldCkKPj4+Cj4+PiBJdCBsb29rcyB0byBtZSB0aGlzIGlzIG9u
bHkgdGhlIHBhcnQgb2YgcGF1c2UuCj4gRm9yIFNWUSB3ZSBuZWVkIHRvIHN3aXRjaCB2cmluZyBh
ZGRyZXNzZXMsIGFuZCBhIGZ1bGwgcmVzZXQgb2YgdGhlCj4gZGV2aWNlIGlzIHJlcXVpcmVkIGZv
ciB0aGF0LiBBY3R1YWxseSwgdGhlIHBhdXNlIGlzIGp1c3QgdXNlZCB0bwo+IHJlY292ZXIKPgo+
IElmIHlvdSBwcmVmZXIgdGhpcyBjb3VsZCBiZSBzZW50IGFzIGEgc2VwYXJhdGUgc2VyaWVzIHdo
ZXJlIHRoZSBmdWxsCj4gcGF1c2UvcmVzdW1lIGN5Y2xlIGlzIGltcGxlbWVudGVkLCBhbmQgdGhl
biBTVlEgdXNlcyB0aGUgcGF1c2UgcGFydC4KPiBIb3dldmVyIHRoZXJlIGFyZSBubyB1c2UgZm9y
IHRoZSByZXN1bWUgcGFydCBhdCB0aGUgbW9tZW50LgoKClRoYXQgd291bGQgYmUgZmluZSBpZiB5
b3UgY2FuIHNlbmQgaXQgaW4gYW5vdGhlciBzZXJpZXMuCgoKPgo+PiBBbmQgZXZlbiBmb3IgcGF1
c2UsIEkgZG9uJ3Qgc2VlIGFueXRoaW5nIHRoYXQgcHJldmVudHMgcngvdHggZnJvbSBiZWluZwo+
PiBleGVjdXRlZD8gKEUuZyB2aXJ0aW9fbmV0X2hhbmRsZV90eF9iaCBvciB2aXJ0aW9fbmV0X2hh
bmRsZV9yeCkuCj4+Cj4gdmlydGlvX25ldF9zdGFydGVkIGlzIGNhbGxlZCBmcm9tIHZpcnRpb19u
ZXRfc2V0X3N0YXR1cy4gSWYKPiBfU19ERVZJQ0VfU1RPUFBFRCBpcyB0cnVlLCB0aGUgZm9ybWVy
IHJldHVybiBmYWxzZSwgYW5kIHZhcmlhYmxlCj4gcXVldWVfc3RhcnRlZCBpcyBmYWxzZSBpbiB0
aGUgbGF0dGVyOgo+ICAgIHF1ZXVlX3N0YXJ0ZWQgPQo+ICAgICAgICAgICAgICB2aXJ0aW9fbmV0
X3N0YXJ0ZWQobiwgcXVldWVfc3RhdHVzKSAmJiAhbi0+dmhvc3Rfc3RhcnRlZDsKPgo+IEFmdGVy
IHRoYXQsIGl0IHNob3VsZCB3b3JrIGxpa2UgYSByZWd1bGFyIGRldmljZSByZXNldCBvciBsaW5r
IGRvd24gaWYKPiBJJ20gbm90IHdyb25nLCBhbmQgdGhlIGxhc3QgcGFydCBvZiB2aXJ0aW9fbmV0
X3NldF9zdGF0dXMgc2hvdWxkCj4gZGVsZXRlIHRpbWVyIG9yIGNhbmNlbCBiaC4KCgpZb3UgYXJl
IHJpZ2h0LgoKVGhhbmtzCgoKPgo+PiBUaGFua3MKPj4KPj4KPj4+IFdlIHN0aWxsIG5lZWQgdGhl
IHJlc3VtZT8KPj4+Cj4+PiBUaGFua3MKPj4+Cj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
