Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF58EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 03:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8809B8294A;
	Thu, 28 Apr 2022 03:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vOtXbNqvT3oy; Thu, 28 Apr 2022 03:46:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8C25827FB;
	Thu, 28 Apr 2022 03:46:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7A06C0032;
	Thu, 28 Apr 2022 03:46:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36228C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BAA64051D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7DxMAtlYKan7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:46:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF6C64010D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651117568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PysP071vsdzg+AYtgM43Jv6G4Yc6NYLrTxTaRTUDRRA=;
 b=cuEUJkugRQmh7ddhFK4WTtWfYF7AST6iNjzZ2B9UC2tR9nOT0kW0FUSqQnkFuCPmUeOrTi
 rw6HM51dUxrmd3+VT7EGvFDxJHt7m3XQ+zXFGLAgktGg9j6rWDlK76D9/LHOxCVGmQJ4f9
 PB4SNMQ02Z+z+vSETWM1b9VDVknXoM0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-mqpNT3BZPI6vUbqgFW8zFA-1; Wed, 27 Apr 2022 23:46:06 -0400
X-MC-Unique: mqpNT3BZPI6vUbqgFW8zFA-1
Received: by mail-lf1-f69.google.com with SMTP id
 bp36-20020a05651215a400b004722f090903so1243022lfb.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 20:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PysP071vsdzg+AYtgM43Jv6G4Yc6NYLrTxTaRTUDRRA=;
 b=e9j3Q3IgMILL/tMZ4RPQypIxWgmx0n+AY2yHjNpKdQTnCxmy9RoAkYdRsL/UOaicN+
 I8p9HCzwYN/t3sPhljZo/5Kujt+Pb3mS0wqJrQzamWcF5Q4J9GQ4sF4vHSfQ8jjy7KGt
 +7m4N50asQmWwDzhEcytrTQW3KC/hUcDPIvAuO7+3Xnnu15mhdtURDuYJXyRphj8t1Cp
 dXAjUgQOU3XrAHZs823kJP7y0ccUM68wosBjBGhg+lavZLZZkk+iFa7l9jMJX8I4zhxI
 9AEzuZz6D75gPn8BUxOm4xQYfNg5zeqGqhLNPNxqtdgqO0HBm55xq1+Kh7wNuq9xXtDE
 9nDw==
X-Gm-Message-State: AOAM530Wkk7NoUjrLMyRMgfut0LNNJCbB9ihFxjJauK0YulDy1xqaFRq
 s/guoCLe05yIpW3uwedE6TRkEi9PDO1IS8uBo8Be7FVXG+Jd5LZGeBYpjy4Sct7TG0D6Xa7+LRQ
 lF/KZhF+TFhBfUkWvJthCgNrAlQjcOBg/Dl4J4+dgpt79uWzpW94YB1IEgg==
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr23037834lfu.471.1651117565416; 
 Wed, 27 Apr 2022 20:46:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrMXH3xs932KXDj4oihyw/ZsxZNXihwzCtWef8Zgy1842y47Rf2KL1q1rvwUlz6Fz+FW8fuZHnc8IPfe45plE=
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr23037823lfu.471.1651117565212; Wed, 27
 Apr 2022 20:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com>
 <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
 <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com>
 <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
 <CACGkMEuJhrSxNc3v7hijSpBdA4X6aC-gA2Ogwed4oODUT_DJ6w@mail.gmail.com>
 <CACLfguV9Za0fa7vXaPxLEKUY2brnNitW6i=Gofdt00cFBwss_Q@mail.gmail.com>
In-Reply-To: <CACLfguV9Za0fa7vXaPxLEKUY2brnNitW6i=Gofdt00cFBwss_Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 11:45:53 +0800
Message-ID: <CACGkMEuiXh-qXrz_ycQT_jjM0RpOe-G36w_eZyJEJNFp2UdVRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: add the check for id_table in struct
 vdpa_mgmt_dev
To: Cindy Lu <lulu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMTE6MjEgQU0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEFwciAyOCwgMjAyMiBhdCAxMTowNyBBTSBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUsIEFwciAyOCwgMjAy
MiBhdCA5OjU2IEFNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBXZWQsIEFwciAyNywgMjAyMiBhdCAxMjowNCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g5ZyoIDIwMjIvNC8yNyAx
MDowMSwgQ2luZHkgTHUg5YaZ6YGTOgo+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQg
NTowMCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
PiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAyOjI3IFBNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+ID4+PiBUbyBzdXBwb3J0IHRoZSBkeW5hbWljIGlkcyBpbiB2cF92
ZHBhLCB3ZSBuZWVkIHRvIGFkZCB0aGUgY2hlY2sgZm9yCj4gPiA+ID4gPj4+IGlkIHRhYmxlLiBJ
ZiB0aGUgaWQgdGFibGUgaXMgTlVMTCwgd2lsbCBub3Qgc2V0IHRoZSBkZXZpY2UgdHlwZQo+ID4g
PiA+ID4+Pgo+ID4gPiA+ID4+PiBTaWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPgo+ID4gPiA+ID4+PiAtLS0KPiA+ID4gPiA+Pj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwg
MTEgKysrKysrKy0tLS0KPiA+ID4gPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4+Pgo+ID4gPiA+ID4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiA+ID4gPiA+Pj4gaW5k
ZXggMWVhNTI1NDMzYTVjLi4wOWVkZDkyY2VkZTAgMTAwNjQ0Cj4gPiA+ID4gPj4+IC0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhLmMKPiA+ID4gPiA+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+
ID4gPiA+ID4+PiBAQCAtNDkyLDEwICs0OTIsMTMgQEAgc3RhdGljIGludCB2ZHBhX21nbXRkZXZf
ZmlsbChjb25zdCBzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgc3RydWN0IHNrX2J1ZmYgKm0K
PiA+ID4gPiA+Pj4gICAgICAgICAgaWYgKGVycikKPiA+ID4gPiA+Pj4gICAgICAgICAgICAgICAg
ICBnb3RvIG1zZ19lcnI7Cj4gPiA+ID4gPj4+Cj4gPiA+ID4gPj4+IC0gICAgICAgd2hpbGUgKG1k
ZXYtPmlkX3RhYmxlW2ldLmRldmljZSkgewo+ID4gPiA+ID4+PiAtICAgICAgICAgICAgICAgaWYg
KG1kZXYtPmlkX3RhYmxlW2ldLmRldmljZSA8PSA2MykKPiA+ID4gPiA+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgc3VwcG9ydGVkX2NsYXNzZXMgfD0gQklUX1VMTChtZGV2LT5pZF90YWJsZVtp
XS5kZXZpY2UpOwo+ID4gPiA+ID4+PiAtICAgICAgICAgICAgICAgaSsrOwo+ID4gPiA+ID4+PiAr
ICAgICAgIGlmIChtZGV2LT5pZF90YWJsZSAhPSBOVUxMKSB7Cj4gPiA+ID4gPj4+ICsgICAgICAg
ICAgICAgICB3aGlsZSAobWRldi0+aWRfdGFibGVbaV0uZGV2aWNlKSB7Cj4gPiA+ID4gPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChtZGV2LT5pZF90YWJsZVtpXS5kZXZpY2UgPD0gNjMp
Cj4gPiA+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3VwcG9ydGVkX2Ns
YXNzZXMgfD0KPiA+ID4gPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEJJVF9VTEwobWRldi0+aWRfdGFibGVbaV0uZGV2aWNlKTsKPiA+ID4gPiA+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaSsrOwo+ID4gPiA+ID4+PiArICAgICAgICAgICAgICAgfQo+ID4g
PiA+ID4+PiAgICAgICAgICB9Cj4gPiA+ID4gPj4gVGhpcyB3aWxsIGNhdXNlIDAgdG8gYmUgYWR2
ZXJ0aXNlZCBhcyB0aGUgc3VwcG9ydGVkIGNsYXNzZXMuCj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBJ
IHdvbmRlciBpZiB3ZSBjYW4gc2ltcGx5IHVzZSBWSVJUSU9fREVWX0FOWV9JRCBoZXJlIChhbmQg
bmVlZCB0bwo+ID4gPiA+ID4+IGV4cG9ydCBpdCB0byB2aWEgdUFQSSBwcm9iYWJseSkuCj4gPiA+
ID4gPj4KPiA+ID4gPiA+PiBUaGFua3MKPiA+ID4gPiA+Pgo+ID4gPiA+ID4gbGlrZSB0aGUgYmVs
b3cgb25lPyBub3Qgc3VyZSBpZiB0aGlzIG9rIHRvIHVzZSBsaWtlIHRoaXM/Cj4gPiA+ID4gPiBz
dGF0aWMgc3RydWN0IHZpcnRpb19kZXZpY2VfaWQgdnBfdmRwYV9pZF90YWJsZVtdID0gewo+ID4g
PiA+ID4geyBWSVJUSU9fREVWX0FOWV9JRCwgVklSVElPX0RFVl9BTllfSUQgfSwKPiA+ID4gPiA+
IHsgMCB9LAo+ID4gPiA+ID4gfTsKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gU29tZXRoaW5nIGxp
a2UgdGhpcy4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gSSBo
YXZlIGNoZWNrZWQgdGhlIGNvZGUsIHRoaXMgbWF5YmUgY2FuIG5vdCB3b3JrLCBiZWNhdXNlIHRo
ZQo+ID4gPiAjZGVmaW5lIFZJUlRJT19ERVZfQU5ZX0lEIDB4ZmZmZmZmZmYKPiA+ID4gIGl0IHdh
bnQndCB3b3JrIGluCj4gPiA+ICAgICAgICAgICAgICAgICBzdXBwb3J0ZWRfY2xhc3NlcyB8PSBC
SVRfVUxMKG1kZXYtPmlkX3RhYmxlW2ldLmRldmljZSk7Cj4gPiA+IGlmIHdlIGNoYW5lIHRvCj4g
PiA+ICAgICAgICAgICAgIHN1cHBvcnRlZF9jbGFzc2VzIHw9IFZJUlRJT19ERVZfQU5ZX0lEOwo+
ID4gPiB0aGUgdmRwYSBkZXYgc2hvdyB3aWxsIGJlCj4gPiA+IHBjaS8wMDAwOjAwOjA0LjA6Cj4g
PiA+ICAgc3VwcG9ydGVkX2NsYXNzZXMgbmV0IGJsb2NrIDwgdW5rbm93biBjbGFzcyA+IDwgdW5r
bm93biBjbGFzcyA+IDwKPiA+ID4gdW5rbm93biBjbGFzcyA+IDwgdW5rbm93biBjbGFzcyA+IDwg
dW5rbm93biBjbGFzcyA+IDwgdW5rbm93Pgo+ID4gPiAgIG1heF9zdXBwb3J0ZWRfdnFzIDMKPiA+
Cj4gPiBUaGF0J3Mgd2h5IEkgc3VnZ2VzdCBleHBvcnRpbmcgdGhlIEFOWV9JRCB2aWEgdUFQSSBh
bmQgdGhlbiB3ZSBjYW4gZml4Cj4gPiB0aGUgdXNlcnNwYWNlLgo+ID4KPiBzdXJlLkJ1dCBJIHRo
aW5rIG1heWJlIHdlIGNhbiBmaXggdGhpcyBpbiBhbm90aGVyIHBhdGNoLCBzaW5jZSBpdAo+IHJl
bGF0ZWQgdG8gdXNlcnNwYWNlCgpZZXMuCgo+Cj4gPiA+ICAgZGV2X2ZlYXR1cmVzIENTVU0gR1VF
U1RfQ1NVTSBDVFJMX0dVRVNUX09GRkxPQURTIE1BQyBHVUVTVF9UU080Cj4gPiA+IEdVRVNUX1RT
TzYgR1VFU1RfRUNOIEdVRVNUX1VGTyBIT1NUX1RTTzQgSE9TVF9UU082IEhPU1RfCj4gPiA+ICBJ
IHRoaW5rIHdlIGNhbiB1c2UKPiA+ID4gc3RhdGljIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlk
X3RhYmxlW10gPSB7Cj4gPiA+IHsgVklSVElPX0lEX05FVCwgVklSVElPX0RFVl9BTllfSUQgfSwK
PiA+ID4geyAwIH0sCj4gPiA+IH07Cj4gPiA+ICBpZiB3ZSBuZWVkIHRvIGFkZCBhbm90aGVyIHR5
cGUgb2YgZGV2aWNlLCB3ZSBjYW4gYWRkIHRoZSBkZXZpY2UgaWQgYXQgdGhhdCB0eXBlCj4gPiA+
Cj4gPgo+ID4gTXkgcG9pbnQgaXMgdGhhdCwgd2UgaGF2ZSBzdXBwb3J0ZWQgYW55IHZpcnRpbyBk
ZXZpY2VzIGJlZm9yZS4gQnV0Cj4gPiBhZnRlciB0aGlzIGNoYW5nZSwgd2Ugb25seSBzdXBwb3J0
IHZpcnRpby1uZXQuCj4gPgo+ID4gU28gaWYgd2UgY2hvb3NlIHRvIHVzZSBpZCBhcnJheXMsIGxl
dCdzIGp1c3QgYWRkIGFsbCBwb3NzaWJsZSB2aXJ0aW8KPiA+IGRldmljZXMgdGhhdCBhcmUgc3Vw
cG9ydGVkIGJ5IHRoZSBrZXJuZWwgaGVyZS4KPiA+Cj4gc29ycnnvvIwgSSBkaWRuJ3QgbWFrZSBp
dCBjbGVhcmx5LCAgSSBtZWFuICB3ZSBjYW4gdXNlIHRoZSB2cF92ZHBhIGRldmljZSBpZCBhcwo+
ICBzdGF0aWMgc3RydWN0IHZpcnRpb19kZXZpY2VfaWQgaWRfdGFibGVbXSA9IHsKPiAgeyBWSVJU
SU9fSURfTkVULCBWSVJUSU9fREVWX0FOWV9JRCB9LAo+IHsgMCB9LAo+IHNpbmNlIGl0IG5vdyBv
bmx5IHN1cHBvcnQgdGhlIG5ldCBkZXZpY2UKClRoaXMgaXMgbm90IHdoYXQgSSByZWFkIGZyb20g
dGhlIGNvZGU6CgpzdGF0aWMgaW50IHZpcnRpb192ZHBhX3Byb2JlKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYSkKewouLi4KdmRfZGV2LT52ZGV2LmlkLmRldmljZSA9IG9wcy0+Z2V0X2RldmljZV9p
ZCh2ZHBhKTsKICAgICAgICBpZiAodmRfZGV2LT52ZGV2LmlkLmRldmljZSA9PSAwKQogICAgICAg
ICAgICAgICAgZ290byBlcnI7Cgp2ZF9kZXYtPnZkZXYuaWQudmVuZG9yID0gb3BzLT5nZXRfdmVu
ZG9yX2lkKHZkcGEpOwogICAgICAgIHJldCA9IHJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoJnZkX2Rl
di0+dmRldik7Ci4uLgp9Cgo/CgpUaGFua3MKCj4gIGFuZCBUaGlzIHdpbGwgbWFrZSB0aGUgdnBf
dmRwYSB3b3JrLgo+Cj4gVGhhbmtzCj4gY2luZHkKPgo+ID4gVGhhbmtzCj4gPgo+ID4gPiBUaGFu
a3MKPiA+ID4gY2luZHkKPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+ID4+PiAgICAgICAgICBpZiAobmxhX3B1dF91NjRfNjRiaXQobXNnLCBWRFBBX0FUVFJfTUdN
VERFVl9TVVBQT1JURURfQ0xBU1NFUywKPiA+ID4gPiA+Pj4gLS0KPiA+ID4gPiA+Pj4gMi4zNC4x
Cj4gPiA+ID4gPj4+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
