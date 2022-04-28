Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBDEC433FE
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 03:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D71B40528;
	Thu, 28 Apr 2022 03:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBoffsmGAms7; Thu, 28 Apr 2022 03:07:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 199334010D;
	Thu, 28 Apr 2022 03:07:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2A39C0039;
	Thu, 28 Apr 2022 03:07:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8752C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3FE740159
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Keerq0ZYQ-IK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:07:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F14D14010D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651115245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvU+ADphMHmXkpmACAoIK7qVjhSn7tp2TJRJg05m6I4=;
 b=c0PbJLG0nE6x8exUOo3pOe5W5W3/YmgXDNwLOn18rvjdb2tqQFgpN9dvAhqGFH6X84Z0L3
 wn8WhKRrkrWvS6WC0gNlL/Klqk51DWs2a2NNesdol405z5rFPbGP6jNHduPmzInaSS0e56
 UtEc8jWKJT2HnWbpqW+8OH6HQx1cHoE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-hS1CTnk7PF2Nn3CJVmKXIQ-1; Wed, 27 Apr 2022 23:07:24 -0400
X-MC-Unique: hS1CTnk7PF2Nn3CJVmKXIQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 c11-20020a056512104b00b00471f86be758so1435296lfb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 20:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TvU+ADphMHmXkpmACAoIK7qVjhSn7tp2TJRJg05m6I4=;
 b=wEOZw58U3cxzQ1ewIZ3JMyYUief5/rC4g2YMz8FLlfCl4ujafOR0K6QN9US0HNp5GM
 RPncgUAnpdauKL4rvJ3ydSi5xO87xksgQxW6861zBNpU47o93oULw3PeVF1gkGA3p6Vf
 oGzzYvBjJCUw7gaCNAaaf+ylBJ+zewxVZF0jR7xwBBwLKNO+NN4f6sQvgV6RDit0uvDX
 MSctTDkm65qvBjLyw5mz2rNelVuIzn7cVEIvfdlgrCkpEUMsGZJeWj1k7//uSw79ENYc
 aRqhVQItRWzpwrPsvOZ+5c9XUYTl8xyM1bzh5SJqz1FA9nhDG1/ZICx5SlIQIsiAOEPq
 VbKA==
X-Gm-Message-State: AOAM53221JDmLxSFiqR7ojJYPQVPGiE6XmYDGM5nD9jQWJlVGygn00EF
 HRFvgvCv1MjouKJ4H+nND0jDFzjskJJSvKnmQCiQ+IJu5NSlbSYZquNAfMVzQ+c/v4ZfxXxmR6g
 fTS+3Qx9bZFD9vx0FLuAy+UgENL+uwUGZUAe0DOEtO2/2OZOU3Cfp7AiCUw==
X-Received: by 2002:a05:6512:33c2:b0:472:33dd:9f46 with SMTP id
 d2-20020a05651233c200b0047233dd9f46mr2359737lfg.98.1651115242949; 
 Wed, 27 Apr 2022 20:07:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8yMqQeXm0E0kg5h+lxPojpYyv2bDl4nXCwoI/TLwDC/R/01jvRHOvf69oY3waWTTt+1EpXJ4YjqEow7KB2bM=
X-Received: by 2002:a05:6512:33c2:b0:472:33dd:9f46 with SMTP id
 d2-20020a05651233c200b0047233dd9f46mr2359731lfg.98.1651115242769; Wed, 27 Apr
 2022 20:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-1-lulu@redhat.com>
 <CACGkMEuMZJRw1TBfY5pTkSAD5MnGvUCu5Eqi=bWD5yc1-hc9YQ@mail.gmail.com>
 <CACLfguUOoeiWrq_2s6NrNB4HwaAbeBYy2TGo0mhO-xswy9G7yw@mail.gmail.com>
 <46c9f96a-8fcf-fae8-5fd7-53557d59c324@redhat.com>
 <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
In-Reply-To: <CACLfguW+9OMPMUpehp+Zut7JosFtg2gzr7t7gZ6U-AdtV89S3g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 11:07:11 +0800
Message-ID: <CACGkMEuJhrSxNc3v7hijSpBdA4X6aC-gA2Ogwed4oODUT_DJ6w@mail.gmail.com>
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgOTo1NiBBTSBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29t
PiB3cm90ZToKPgo+IE9uIFdlZCwgQXByIDI3LCAyMDIyIGF0IDEyOjA0IFBNIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDlnKggMjAyMi80LzI3IDEw
OjAxLCBDaW5keSBMdSDlhpnpgZM6Cj4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDU6MDAg
UE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+PiBPbiBNb24s
IEFwciAyNSwgMjAyMiBhdCAyOjI3IFBNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPj4+IFRvIHN1cHBvcnQgdGhlIGR5bmFtaWMgaWRzIGluIHZwX3ZkcGEsIHdlIG5lZWQg
dG8gYWRkIHRoZSBjaGVjayBmb3IKPiA+ID4+PiBpZCB0YWJsZS4gSWYgdGhlIGlkIHRhYmxlIGlz
IE5VTEwsIHdpbGwgbm90IHNldCB0aGUgZGV2aWNlIHR5cGUKPiA+ID4+Pgo+ID4gPj4+IFNpZ25l
ZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+Cj4gPiA+Pj4gLS0tCj4gPiA+Pj4g
ICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgMTEgKysrKysrKy0tLS0KPiA+ID4+PiAgIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+Pj4KPiA+ID4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiA+
ID4+PiBpbmRleCAxZWE1MjU0MzNhNWMuLjA5ZWRkOTJjZWRlMCAxMDA2NDQKPiA+ID4+PiAtLS0g
YS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gPiA+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+
ID4gPj4+IEBAIC00OTIsMTAgKzQ5MiwxMyBAQCBzdGF0aWMgaW50IHZkcGFfbWdtdGRldl9maWxs
KGNvbnN0IHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqbQo+ID4g
Pj4+ICAgICAgICAgIGlmIChlcnIpCj4gPiA+Pj4gICAgICAgICAgICAgICAgICBnb3RvIG1zZ19l
cnI7Cj4gPiA+Pj4KPiA+ID4+PiAtICAgICAgIHdoaWxlIChtZGV2LT5pZF90YWJsZVtpXS5kZXZp
Y2UpIHsKPiA+ID4+PiAtICAgICAgICAgICAgICAgaWYgKG1kZXYtPmlkX3RhYmxlW2ldLmRldmlj
ZSA8PSA2MykKPiA+ID4+PiAtICAgICAgICAgICAgICAgICAgICAgICBzdXBwb3J0ZWRfY2xhc3Nl
cyB8PSBCSVRfVUxMKG1kZXYtPmlkX3RhYmxlW2ldLmRldmljZSk7Cj4gPiA+Pj4gLSAgICAgICAg
ICAgICAgIGkrKzsKPiA+ID4+PiArICAgICAgIGlmIChtZGV2LT5pZF90YWJsZSAhPSBOVUxMKSB7
Cj4gPiA+Pj4gKyAgICAgICAgICAgICAgIHdoaWxlIChtZGV2LT5pZF90YWJsZVtpXS5kZXZpY2Up
IHsKPiA+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAobWRldi0+aWRfdGFibGVbaV0u
ZGV2aWNlIDw9IDYzKQo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Vw
cG9ydGVkX2NsYXNzZXMgfD0KPiA+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQklUX1VMTChtZGV2LT5pZF90YWJsZVtpXS5kZXZpY2UpOwo+ID4gPj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGkrKzsKPiA+ID4+PiArICAgICAgICAgICAgICAgfQo+ID4gPj4+
ICAgICAgICAgIH0KPiA+ID4+IFRoaXMgd2lsbCBjYXVzZSAwIHRvIGJlIGFkdmVydGlzZWQgYXMg
dGhlIHN1cHBvcnRlZCBjbGFzc2VzLgo+ID4gPj4KPiA+ID4+IEkgd29uZGVyIGlmIHdlIGNhbiBz
aW1wbHkgdXNlIFZJUlRJT19ERVZfQU5ZX0lEIGhlcmUgKGFuZCBuZWVkIHRvCj4gPiA+PiBleHBv
cnQgaXQgdG8gdmlhIHVBUEkgcHJvYmFibHkpLgo+ID4gPj4KPiA+ID4+IFRoYW5rcwo+ID4gPj4K
PiA+ID4gbGlrZSB0aGUgYmVsb3cgb25lPyBub3Qgc3VyZSBpZiB0aGlzIG9rIHRvIHVzZSBsaWtl
IHRoaXM/Cj4gPiA+IHN0YXRpYyBzdHJ1Y3QgdmlydGlvX2RldmljZV9pZCB2cF92ZHBhX2lkX3Rh
YmxlW10gPSB7Cj4gPiA+IHsgVklSVElPX0RFVl9BTllfSUQsIFZJUlRJT19ERVZfQU5ZX0lEIH0s
Cj4gPiA+IHsgMCB9LAo+ID4gPiB9Owo+ID4KPiA+Cj4gPiBTb21ldGhpbmcgbGlrZSB0aGlzLgo+
ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4gSSBoYXZlIGNoZWNrZWQgdGhlIGNvZGUsIHRoaXMgbWF5
YmUgY2FuIG5vdCB3b3JrLCBiZWNhdXNlIHRoZQo+ICNkZWZpbmUgVklSVElPX0RFVl9BTllfSUQg
MHhmZmZmZmZmZgo+ICBpdCB3YW50J3Qgd29yayBpbgo+ICAgICAgICAgICAgICAgICBzdXBwb3J0
ZWRfY2xhc3NlcyB8PSBCSVRfVUxMKG1kZXYtPmlkX3RhYmxlW2ldLmRldmljZSk7Cj4gaWYgd2Ug
Y2hhbmUgdG8KPiAgICAgICAgICAgICBzdXBwb3J0ZWRfY2xhc3NlcyB8PSBWSVJUSU9fREVWX0FO
WV9JRDsKPiB0aGUgdmRwYSBkZXYgc2hvdyB3aWxsIGJlCj4gcGNpLzAwMDA6MDA6MDQuMDoKPiAg
IHN1cHBvcnRlZF9jbGFzc2VzIG5ldCBibG9jayA8IHVua25vd24gY2xhc3MgPiA8IHVua25vd24g
Y2xhc3MgPiA8Cj4gdW5rbm93biBjbGFzcyA+IDwgdW5rbm93biBjbGFzcyA+IDwgdW5rbm93biBj
bGFzcyA+IDwgdW5rbm93Pgo+ICAgbWF4X3N1cHBvcnRlZF92cXMgMwoKVGhhdCdzIHdoeSBJIHN1
Z2dlc3QgZXhwb3J0aW5nIHRoZSBBTllfSUQgdmlhIHVBUEkgYW5kIHRoZW4gd2UgY2FuIGZpeAp0
aGUgdXNlcnNwYWNlLgoKPiAgIGRldl9mZWF0dXJlcyBDU1VNIEdVRVNUX0NTVU0gQ1RSTF9HVUVT
VF9PRkZMT0FEUyBNQUMgR1VFU1RfVFNPNAo+IEdVRVNUX1RTTzYgR1VFU1RfRUNOIEdVRVNUX1VG
TyBIT1NUX1RTTzQgSE9TVF9UU082IEhPU1RfCj4gIEkgdGhpbmsgd2UgY2FuIHVzZQo+IHN0YXRp
YyBzdHJ1Y3QgdmlydGlvX2RldmljZV9pZCBpZF90YWJsZVtdID0gewo+IHsgVklSVElPX0lEX05F
VCwgVklSVElPX0RFVl9BTllfSUQgfSwKPiB7IDAgfSwKPiB9Owo+ICBpZiB3ZSBuZWVkIHRvIGFk
ZCBhbm90aGVyIHR5cGUgb2YgZGV2aWNlLCB3ZSBjYW4gYWRkIHRoZSBkZXZpY2UgaWQgYXQgdGhh
dCB0eXBlCj4KCk15IHBvaW50IGlzIHRoYXQsIHdlIGhhdmUgc3VwcG9ydGVkIGFueSB2aXJ0aW8g
ZGV2aWNlcyBiZWZvcmUuIEJ1dAphZnRlciB0aGlzIGNoYW5nZSwgd2Ugb25seSBzdXBwb3J0IHZp
cnRpby1uZXQuCgpTbyBpZiB3ZSBjaG9vc2UgdG8gdXNlIGlkIGFycmF5cywgbGV0J3MganVzdCBh
ZGQgYWxsIHBvc3NpYmxlIHZpcnRpbwpkZXZpY2VzIHRoYXQgYXJlIHN1cHBvcnRlZCBieSB0aGUg
a2VybmVsIGhlcmUuCgpUaGFua3MKCj4gVGhhbmtzCj4gY2luZHkKPgo+Cj4KPiA+ID4KPiA+ID4K
PiA+ID4+PiAgICAgICAgICBpZiAobmxhX3B1dF91NjRfNjRiaXQobXNnLCBWRFBBX0FUVFJfTUdN
VERFVl9TVVBQT1JURURfQ0xBU1NFUywKPiA+ID4+PiAtLQo+ID4gPj4+IDIuMzQuMQo+ID4gPj4+
Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
