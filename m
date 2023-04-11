Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14554C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 05:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4FC861424;
	Tue, 11 Apr 2023 05:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4FC861424
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EgL8bP3L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mxVzcgGYIVnw; Tue, 11 Apr 2023 05:16:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2CD7F61422;
	Tue, 11 Apr 2023 05:16:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CD7F61422
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 085EEC0036;
	Tue, 11 Apr 2023 05:16:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD71CC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A35F861424
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:16:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A35F861424
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V1UW6SgjW7Qc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:16:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA7C061423
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA7C061423
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681190200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJ5snzJuJJ7DDC2bBMWooauMIWWD4nqLy+A3mf7B3xw=;
 b=EgL8bP3LpPZE52/c+2ZU2B+dn77gd4POp+kFo4f+QXb0i4f9HvZUHYF3e/IG6brsKO+c7q
 110YsCbtxgYnufiBWhpob1419I5bHnV419NaBPVFSJ/aDKpIGBajOEirQja0dFjfDnpwIG
 IVOml7tLwJo7pn25QyC65bQmDMR96TA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-C7oq95QXNqqedjNSeF80tA-1; Tue, 11 Apr 2023 01:16:38 -0400
X-MC-Unique: C7oq95QXNqqedjNSeF80tA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-518d6f87a47so144944a12.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 22:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681190198; x=1683782198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJ5snzJuJJ7DDC2bBMWooauMIWWD4nqLy+A3mf7B3xw=;
 b=S1z6Jvj/RDsFpY5ytOfwZ0Q/orTey6nmacagLupg8HTrS11CNn5Ckvj45JBpvK0fXH
 GnWBhVYGAVwQLC1rclKrXIGZdW+mGUPfPqbHwF2B3IdLj9JFu4fO7CqdKoLMAlGU/6OJ
 FEvnbKofPHUpG9sG9l+5PVT3CPAPqaLjouFbznelGuvO/6tYv/WWliC3MTSSwefTtnBc
 D4G4mab216ML1lhI8ObfiTnFqJ2W66Bp7AjwEdYZHw/dZCijpCmiEPPBk5Z3yxyDPB7T
 OgC2tXj0OPR64aPC/ebKHi0cLsts8Bsvbm/gGk5q1BviBx6fufa+vsgbbAvYxq7144bO
 xgKw==
X-Gm-Message-State: AAQBX9emMq1RnRan8fLgcWCBQWF+K83uCtcePHoiGzB/5OlcCr7F/vEP
 DsMD2XpAvaXWzSOQeGkdm94EYgNFiyyFdOE8nnY78s/5NOK3mvxmqZKSZ+xfydRm4Yjmbl67rxw
 TewGCyO1Z7lvht+kBwGI0mPPQnMj0ddhxZAcoLp0xYw==
X-Received: by 2002:a62:4e54:0:b0:636:8db5:cd45 with SMTP id
 c81-20020a624e54000000b006368db5cd45mr7902081pfb.30.1681190197749; 
 Mon, 10 Apr 2023 22:16:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350bTDltjXVJVtt5fnMiaMOLA/Xekvb4dAgaRjHs3X084Okba8IGMiLIZ52OQ9wllO+x2u9LJIQ==
X-Received: by 2002:a62:4e54:0:b0:636:8db5:cd45 with SMTP id
 c81-20020a624e54000000b006368db5cd45mr7902069pfb.30.1681190197414; 
 Mon, 10 Apr 2023 22:16:37 -0700 (PDT)
Received: from [10.72.12.112] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a62ab16000000b006372791d708sm3300251pff.104.2023.04.10.22.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 22:16:36 -0700 (PDT)
Message-ID: <71bb8651-e0d3-8eb5-1eea-57b65e629e16@redhat.com>
Date: Tue, 11 Apr 2023 13:16:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] vdpa/snet: support getting and setting VQ state
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, mst@redhat.com
References: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
 <20230410100237.3499578-2-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230410100237.3499578-2-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIzLzQvMTAgMTg6MDIsIEFsdmFybyBLYXJzeiDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBh
ZGRzIHRoZSBnZXRfdnFfc3RhdGUgYW5kIHNldF92cV9zdGF0ZSB2RFBBIGNhbGxiYWNrcy4KPgo+
IEluIG9yZGVyIHRvIGdldCB0aGUgVlEgc3RhdGUsIHRoZSBzdGF0ZSBuZWVkcyB0byBiZSByZWFk
IGZyb20gdGhlIERQVS4KPiBJbiBvcmRlciB0byBhbGxvdyB0aGF0LCB0aGUgb2xkIG1lc3NhZ2lu
ZyBtZWNoYW5pc20gaXMgcmVwbGFjZWQgd2l0aCBhIG5ldywKPiBmbGV4aWJsZSBjb250cm9sIG1l
Y2hhbmlzbS4KPiBUaGlzIG1lY2hhbmlzbSBhbGxvd3MgdG8gcmVhZCBkYXRhIGZyb20gdGhlIERQ
VS4KPgo+IFRoZSBtZWNoYW5pc20gY2FuIGJlIHVzZWQgaWYgdGhlIG5lZ290aWF0ZWQgY29uZmln
IHZlcnNpb24gaXMgMiBvcgo+IGhpZ2hlci4KPgo+IElmIHRoZSBuZXcgbWVjaGFuaXNtIGlzIHVz
ZWQgd2hlbiB0aGUgY29uZmlnIHZlcnNpb24gaXMgMSwgaXQgd2lsbCBjYWxsCj4gc25ldF9zZW5k
X2N0cmxfbXNnX29sZCwgd2hpY2ggaXMgY29uZmlnIDEgY29tcGF0aWJsZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL3ZkcGEvc29saWRydW4vTWFrZWZpbGUgICAgIHwgICAxICsKPiAgIGRyaXZlcnMv
dmRwYS9zb2xpZHJ1bi9zbmV0X2N0cmwuYyAgfCAzMjMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiAgIGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X2h3bW9uLmMgfCAgIDIgKy0KPiAg
IGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X21haW4uYyAgfCAxMTIgKysrKy0tLS0tLQo+ICAg
ZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oICB8ICAxOSArLQo+ICAgNSBmaWxlcyBj
aGFuZ2VkLCAzODYgaW5zZXJ0aW9ucygrKSwgNzEgZGVsZXRpb25zKC0pCj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfY3RybC5jCgoKWy4uLl0KCgo+IEBA
IC0yMCwxMCArMjAsMTUgQEAKPiAgICNkZWZpbmUgU05FVF9JTkZPKHBkZXYsIGZtdCwgLi4uKSBk
ZXZfaW5mbygmKHBkZXYpLT5kZXYsICIlcyJmbXQsICJzbmV0X3ZkcGE6ICIsICMjX19WQV9BUkdT
X18pCj4gICAjZGVmaW5lIFNORVRfREJHKHBkZXYsIGZtdCwgLi4uKSBkZXZfZGJnKCYocGRldikt
PmRldiwgIiVzImZtdCwgInNuZXRfdmRwYTogIiwgIyNfX1ZBX0FSR1NfXykKPiAgICNkZWZpbmUg
U05FVF9IQVNfRkVBVFVSRShzLCBmKSAoKHMpLT5uZWdvdGlhdGVkX2ZlYXR1cmVzICYgQklUX1VM
TChmKSkKPiArLyogQ2hlY2sgaWYgbmVnb3RpYXRlZCBjb25maWcgdmVyc2lvbiBpcyBhdCBsZWFz
dCBAdmVyICovCj4gKyNkZWZpbmUgU05FVF9DRkdfVkVSKHNuZXQsIHZlcikgKChzbmV0KS0+cHNu
ZXQtPm5lZ290aWF0ZWRfY2ZnX3ZlciA+PSAodmVyKSkKPiArCj4gICAvKiBWUSBzdHJ1Y3QgKi8K
PiAgIHN0cnVjdCBzbmV0X3ZxIHsKPiAgIAkvKiBWUSBjYWxsYmFjayAqLwo+ICAgCXN0cnVjdCB2
ZHBhX2NhbGxiYWNrIGNiOwo+ICsJLyogVlEgaW5pdGlhbCBzdGF0ZSAqLwo+ICsJc3RydWN0IHZk
cGFfdnFfc3RhdGUgaW5pdGFsX3N0YXRlOwoKCkkgZ3Vlc3MgeW91IG1lYW50ICJpbml0aWFsX3N0
YXRlIiByZWFsbHkgaGVyZS4KCkJ0dywgd2hvIGlzIHVzZWQgdG8gaW5pdGlhbGl6ZSBpbml0aWFs
X3N0YXRlIChlc3BlY2lhbGx5IHRoZSBjYXNlIGZvciAKcGFja2VkIHJpbmcpPwoKSW4gc25ldF9z
ZXRfdnFfc3RhdGUoKSwgb25seSB0aGUgdmFsdWUgdGhhdCBpcyBzZXQgYnkgYnVzIGlzIGNoZWNr
ZWQgYnV0IApub3QgdGhlIGluaXRhbF9zdGF0ZS4KClRoYW5rcwoKCj4gICAJLyogZGVzYyBiYXNl
IGFkZHJlc3MgKi8KPiAgIAl1NjQgZGVzY19hcmVhOwo+ICAgCS8qIGRldmljZSBiYXNlIGFkZHJl
c3MgKi8KPiBAQCAtNTEsNiArNTYsMTAgQEAgc3RydWN0IHNuZXQgewo+ICAgCXN0cnVjdCB2ZHBh
X2RldmljZSB2ZHBhOwo+ICAgCS8qIENvbmZpZyBjYWxsYmFjayAqLwo+ICAgCXN0cnVjdCB2ZHBh
X2NhbGxiYWNrIGNiOwo+ICsJLyogVG8gbG9jayB0aGUgY29udHJvbCBtZWNoYW5pc20gKi8KPiAr
CXN0cnVjdCBtdXRleCBjdHJsX2xvY2s7Cj4gKwkvKiBTcGlubG9jayB0byBwcm90ZWN0IGNyaXRp
Y2FsIHBhcnRzIGluIHRoZSBjb250cm9sIG1lY2hhbmlzbSAqLwo+ICsJc3BpbmxvY2tfdCBjdHJs
X3NwaW5sb2NrOwo+ICAgCS8qIGFycmF5IG9mIHZpcnF1ZXVlcyAqLwo+ICAgCXN0cnVjdCBzbmV0
X3ZxICoqdnFzOwo+ICAgCS8qIFVzZWQgZmVhdHVyZXMgKi8KPiBAQCAtMTE3LDggKzEyNiw4IEBA
IHN0cnVjdCBzbmV0X2NmZyB7Cj4gICAJdTMyIGtpY2tfb2ZmOwo+ICAgCS8qIE9mZnNldCBpbiBQ
Q0kgQkFSIGZvciBIVyBtb25pdG9yaW5nICovCj4gICAJdTMyIGh3bW9uX29mZjsKPiAtCS8qIE9m
ZnNldCBpbiBQQ0kgQkFSIGZvciBTTkVUIG1lc3NhZ2VzICovCj4gLQl1MzIgbXNnX29mZjsKPiAr
CS8qIE9mZnNldCBpbiBQQ0kgQkFSIGZvciBDb250cm9sIG1lY2hhbmlzbSAqLwo+ICsJdTMyIGN0
cmxfb2ZmOwo+ICAgCS8qIENvbmZpZyBnZW5lcmFsIGZsYWdzIC0gZW51bSBzbmV0X2NmZ19mbGFn
cyAqLwo+ICAgCXUzMiBmbGFnczsKPiAgIAkvKiBSZXNlcnZlZCBmb3IgZnV0dXJlIHVzYWdlICov
Cj4gQEAgLTE5MSw0ICsyMDAsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc25ldF93cml0ZTY0KHN0
cnVjdCBzbmV0ICpzbmV0LCB1MzIgb2ZmLCB1NjQgdmFsKQo+ICAgdm9pZCBwc25ldF9jcmVhdGVf
aHdtb24oc3RydWN0IHBjaV9kZXYgKnBkZXYpOwo+ICAgI2VuZGlmCj4gICAKPiArdm9pZCBzbmV0
X2N0cmxfY2xlYXIoc3RydWN0IHNuZXQgKnNuZXQpOwo+ICtpbnQgc25ldF9kZXN0cm95X2Rldihz
dHJ1Y3Qgc25ldCAqc25ldCk7Cj4gK2ludCBzbmV0X3JlYWRfdnFfc3RhdGUoc3RydWN0IHNuZXQg
KnNuZXQsIHUxNiBpZHgsIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlICpzdGF0ZSk7Cj4gKwo+ICAgI2Vu
ZGlmIC8vX1NORVRfVkRQQV9IXwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
