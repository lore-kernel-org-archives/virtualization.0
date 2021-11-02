Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE94C433FE
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 05:26:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C827A60F70
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 05:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C827A60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87A2A402D8;
	Tue,  2 Nov 2021 05:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYU5u0uSiA64; Tue,  2 Nov 2021 05:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35EDB402D1;
	Tue,  2 Nov 2021 05:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17AD1C0012;
	Tue,  2 Nov 2021 05:26:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 838D3C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 786F8606E7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9jye1m5alGRs
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:26:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88834606CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 05:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635830768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bajX0FLkv/tXMkVBnTHf1Bd8wxQJJ2cX8rqdOASLHZs=;
 b=HtCCgkNBPm2a7MPmyeN504o+ZaTIN3/abLfVam6368OV5/q6r01llYyTp232YrKCmDEXKC
 pHAoiaHnNL6VMNjYGkt9KL97KFUwiRqD7Yv3Nlnx+na1V0/Y1/pvoY9pJa6MfjcsEXwH0U
 sq1KBt9Ie9QiZZC3YJ735rgrE3ToMiw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-v1lp2rn_N8e6VWCckw35GA-1; Tue, 02 Nov 2021 01:26:07 -0400
X-MC-Unique: v1lp2rn_N8e6VWCckw35GA-1
Received: by mail-lf1-f69.google.com with SMTP id
 bq29-20020a056512151d00b003ffce2467adso6574929lfb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 22:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bajX0FLkv/tXMkVBnTHf1Bd8wxQJJ2cX8rqdOASLHZs=;
 b=x0o799aO3CqPN51vDGGTefKP49XRY2y3B8UmnxWJILVf/93tM3MIOemDYvxxgqLTi5
 vhNIz0Y2euQYFB6VuwPoWQlJhDIwwWL0QgM0+GM9eoE2FE5nyVKxIO2syKTFb4SXnhF7
 +rz5Cgk0fTvwbWnYoG+EZxXpMx3Cc3YjQuGt21AjRxXYyAToIPIsdAY23/JuR7c5NRnd
 fqwqKqzBdQGY7bEHR42sCSp92cS3bXYyDXb7rdNQgVGWpVIcsr4lDPY1vsEK6sNeEZw+
 vdndCZcY9WM/qCCbflXhi6ZNEwehAzpE2FYXDp3H1dY5IZQrT50PZpC4vu45VKnbfnqZ
 mnXw==
X-Gm-Message-State: AOAM533Nu3RoRJLasmpQzEd7BCVUiorRD09YR4GmXAD10H4///0HA612
 dAHBpFPJmrP2+U5U18xz6Oprbs7soKU5lIpoZBlvuL+g77WwwpCJq25ve4KMIpf89Xbr+FUa9G4
 Ta6z/9xl4HjR6HImzb7nlYWJrl4HVchV3V6CVWi/8jfZZsVz6HAUUmlN5Jw==
X-Received: by 2002:a05:651c:1254:: with SMTP id
 h20mr36382262ljh.420.1635830765673; 
 Mon, 01 Nov 2021 22:26:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaDvnbh3/QxnYwKDlAGBulhKs/ymZFxgmAXKGQQ5IuYUOoQAtoot7ukBQPvQCm3+fRXhfU3cKGVoh91JJ3zgs=
X-Received: by 2002:a05:651c:1254:: with SMTP id
 h20mr36382225ljh.420.1635830765441; 
 Mon, 01 Nov 2021 22:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-22-eperezma@redhat.com>
In-Reply-To: <20211029183525.1776416-22-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Nov 2021 13:25:54 +0800
Message-ID: <CACGkMEt8fusPLj3=E1GETzotMOhkuTAzD_bON0hQEjNecg2GcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 21/26] vhost: Add vhost_svq_valid_guest_features to
 shadow vq
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Parav Pandit <parav@mellanox.com>
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

T24gU2F0LCBPY3QgMzAsIDIwMjEgYXQgMjo0NCBBTSBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBUaGlzIGFsbG93cyBpdCB0byB0ZXN0IGlmIHRoZSBndWVz
dCBoYXMgYWtub3dsZWRnZSBhbiBpbnZhbGlkIHRyYW5zcG9ydAo+IGZlYXR1cmUgZm9yIFNWUS4g
VGhpcyB3aWxsIGluY2x1ZGUgcGFja2VkIHZxIGxheW91dCBvciBldmVudF9pZHgsCj4gd2hlcmUg
VmlydElPIGRldmljZSBuZWVkcyBoZWxwIGZyb20gU1ZRLgo+Cj4gVGhlcmUgaXMgbm90IG5lZWRl
ZCBhdCB0aGlzIG1vbWVudCwgYnV0IHNpbmNlIFNWUSB3aWxsIG5vdCByZS1uZWdvdGlhdGUKPiBm
ZWF0dXJlcyBhZ2FpbiB3aXRoIHRoZSBndWVzdCwgYSBmYWlsdXJlIGluIGFja25vd2xlZGdlIHRo
ZW0gaXMgZmF0YWwKPiBmb3IgU1ZRLgo+CgpJdCdzIG5vdCBjbGVhciB0byBtZSB3aHkgd2UgbmVl
ZCB0aGlzLiBNYXliZSB5b3UgY2FuIGdpdmUgbWUgYW4KZXhhbXBsZS4gRS5nIGlzbid0IGl0IHN1
ZmZpY2llbnQgdG8gZmlsdGVyIG91dCB0aGUgZGV2aWNlIHdpdGgKZXZlbnRfaWR4PwoKVGhhbmtz
Cgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+
IC0tLQo+ICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIHwgMSArCj4gIGh3L3Zp
cnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCA2ICsrKysrKwo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC1zaGFk
b3ctdmlydHF1ZXVlLmggYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4gaW5k
ZXggOTQ2YjJjNjI5NS4uYWM1NTU4ODAwOSAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5oCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVl
dWUuaAo+IEBAIC0xNiw2ICsxNiw3IEBACj4gIHR5cGVkZWYgc3RydWN0IFZob3N0U2hhZG93Vmly
dHF1ZXVlIFZob3N0U2hhZG93VmlydHF1ZXVlOwo+Cj4gIGJvb2wgdmhvc3Rfc3ZxX3ZhbGlkX2Rl
dmljZV9mZWF0dXJlcyh1aW50NjRfdCAqZmVhdHVyZXMpOwo+ICtib29sIHZob3N0X3N2cV92YWxp
ZF9ndWVzdF9mZWF0dXJlcyh1aW50NjRfdCAqZmVhdHVyZXMpOwo+Cj4gIHZvaWQgdmhvc3Rfc3Zx
X3NldF9zdnFfa2lja19mZChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3ZxX2tpY2tf
ZmQpOwo+ICB2b2lkIHZob3N0X3N2cV9zZXRfZ3Vlc3RfY2FsbF9ub3RpZmllcihWaG9zdFNoYWRv
d1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgY2FsbF9mZCk7Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgYi9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1
ZS5jCj4gaW5kZXggNmUwNTA4YTIzMS4uY2I5ZmZjYjAxNSAxMDA2NDQKPiAtLS0gYS9ody92aXJ0
aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuYwo+IEBAIC02Miw2ICs2MiwxMiBAQCBib29sIHZob3N0X3N2cV92YWxpZF9k
ZXZpY2VfZmVhdHVyZXModWludDY0X3QgKmRldl9mZWF0dXJlcykKPiAgICAgIHJldHVybiB0cnVl
Owo+ICB9Cj4KPiArLyogSWYgdGhlIGd1ZXN0IGlzIHVzaW5nIHNvbWUgb2YgdGhlc2UsIFNWUSBj
YW5ub3QgY29tbXVuaWNhdGUgKi8KPiArYm9vbCB2aG9zdF9zdnFfdmFsaWRfZ3Vlc3RfZmVhdHVy
ZXModWludDY0X3QgKmd1ZXN0X2ZlYXR1cmVzKQo+ICt7Cj4gKyAgICByZXR1cm4gdHJ1ZTsKPiAr
fQo+ICsKPiAgLyogRm9yd2FyZCBndWVzdCBub3RpZmljYXRpb25zICovCj4gIHN0YXRpYyB2b2lk
IHZob3N0X2hhbmRsZV9ndWVzdF9raWNrKEV2ZW50Tm90aWZpZXIgKm4pCj4gIHsKPiAtLQo+IDIu
MjcuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
