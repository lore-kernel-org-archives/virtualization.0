Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0991CC77B6E
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 05:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7260F4279F;
	Fri, 14 Apr 2023 05:10:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7260F4279F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hg+xz4X+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1uN1h2Hzdlf; Fri, 14 Apr 2023 05:10:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6544542742;
	Fri, 14 Apr 2023 05:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6544542742
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FD99C0037;
	Fri, 14 Apr 2023 05:10:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F906C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E18F740204
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:10:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E18F740204
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hg+xz4X+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mWIrPxTKwr6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:10:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11A7C400FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11A7C400FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681449015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnDvwf1R/OovgMAVg9WiYCMbtU1kpmzHDOYZjnYe0Qg=;
 b=Hg+xz4X+46GkDVqzGYnDX5u3A8We4nES2JtE2f5mjrw5kLOXd2QgVIrt2aPEJaPeNZ0hsa
 V+HyqUA8zNA7Hb8LmjJkRtMpLh/YxHczeklRkCXgtqUtvTr7vAvFxGIz/n5ZXUjVuOqzA1
 TJbM+msE97i5u6DtH5KjLcwJiJDY4cM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-9Fz3z0yEOSCPMn0RH-KAjA-1; Fri, 14 Apr 2023 01:10:11 -0400
X-MC-Unique: 9Fz3z0yEOSCPMn0RH-KAjA-1
Received: by mail-oo1-f72.google.com with SMTP id
 s64-20020a4a5143000000b00541befd168bso5277538ooa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 22:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681449011; x=1684041011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnDvwf1R/OovgMAVg9WiYCMbtU1kpmzHDOYZjnYe0Qg=;
 b=I3VQ7W+O2hs0jTKTzzXW8hJjtbZ9hEf8G+1IoYqgZtCGdXqmEeXRWC42HkPHEKSb5e
 cY2K/0+7P0Sqrl4qJ8XHuTiwkd84rVhwJophsxVXB7LFqQ2wapYDbJ8JNlgo6Ov6kmG/
 eG9OIZkOzw6MfFsmmxxKZNrei8N6CoQRoO+TIVPGifbvvV6EqajV784TU/Ha53R731q0
 DdLVrqVREx6NbU8NKAhOJ3vcpLQ1V0008N4cg6f4IchbdrWFoP/Z610eUci7kk0B7UkK
 Me8HACJP/0Z0JQ/WHq0Nm3ONlIsp2lAWhMgk1vOuNAKTldpi4lZ7A+7Ar7bgpNbufoai
 aofg==
X-Gm-Message-State: AAQBX9fl+TSi45aDvPK9IGxIZ1aXyVkEy2xBdRa1qW8nrsI+vNiNnJ4q
 bzq1Q/KeFB+axZkdKgnu082c2MA6y+SNOJma4SYgBC/5eMIhb5wlLVWqQzlG/fgGAPDo3LIIdAw
 sy9+q0fNHk5TitCzRB86Q1tGbgR03jSJUFZMXXk10k53z7Wkybmw1nX42Aw==
X-Received: by 2002:a05:6870:2495:b0:177:b9c0:bcba with SMTP id
 s21-20020a056870249500b00177b9c0bcbamr3833504oaq.3.1681449011197; 
 Thu, 13 Apr 2023 22:10:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350aAWQ/zE3JzE+BJztmF9q8RTKt9Is6pPgO3saF+6nNCza+95hIGVBIaLglcjHvYzkHy1o1BpD43DUoFBOps7+M=
X-Received: by 2002:a05:6870:2495:b0:177:b9c0:bcba with SMTP id
 s21-20020a056870249500b00177b9c0bcbamr3833491oaq.3.1681449010955; Thu, 13 Apr
 2023 22:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-3-jasowang@redhat.com>
 <1681370820.0675354-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuJuZKGMhVwFmD0ZMa7V7TdGu6qaXF24Gg67TzMbs8ANA@mail.gmail.com>
In-Reply-To: <CACGkMEuJuZKGMhVwFmD0ZMa7V7TdGu6qaXF24Gg67TzMbs8ANA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 13:10:00 +0800
Message-ID: <CACGkMEvuFoc=8S666npEnTXuZZLMJVA8tzNAspfrTzR4L7NdgQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy waiting
 for cvq command
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

QWRkaW5nIG5ldGRldi4KCk9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDE6MDnigK9QTSBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgQXByIDEzLCAyMDIz
IGF0IDM6MzHigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90
ZToKPiA+Cj4gPiBPbiBUaHUsIDEzIEFwciAyMDIzIDE0OjQwOjI3ICswODAwLCBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gV2UgdXNlZCB0byBidXN5IHdhaXRp
bmcgb24gdGhlIGN2cSBjb21tYW5kIHRoaXMgdGVuZHMgdG8gYmUKPiA+ID4gcHJvYmxlbWF0aWMg
c2luY2UgdGhlcmUgbm8gd2F5IGZvciB0byBzY2hlZHVsZSBhbm90aGVyIHByb2Nlc3Mgd2hpY2gK
PiA+ID4gbWF5IHNlcnZlIGZvciB0aGUgY29udHJvbCB2aXJ0cXVldWUuIFRoaXMgbWlnaHQgYmUg
dGhlIGNhc2Ugd2hlbiB0aGUKPiA+ID4gY29udHJvbCB2aXJ0cXVldWUgaXMgZW11bGF0ZWQgYnkg
c29mdHdhcmUuIFRoaXMgcGF0Y2ggc3dpdGNoZXMgdG8gdXNlCj4gPiA+IGNvbXBsZXRpb24gdG8g
YWxsb3cgdGhlIENQVSB0byBzbGVlcCBpbnN0ZWFkIG9mIGJ1c3kgd2FpdGluZyBmb3IgdGhlCj4g
PiA+IGN2cSBjb21tYW5kLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiAtLS0KPiA+ID4gQ2hhbmdlcyBzaW5jZSBWMToKPiA+
ID4gLSB1c2UgY29tcGxldGlvbiBmb3Igc2ltcGxpY2l0eQo+ID4gPiAtIGRvbid0IHRyeSB0byBo
YXJkZW4gdGhlIENWUSBjb21tYW5kIHdoaWNoIHJlcXVpcmVzIG1vcmUgdGhvdWdodAo+ID4gPiBD
aGFuZ2VzIHNpbmNlIFJGQzoKPiA+ID4gLSBicmVhayB0aGUgZGV2aWNlIHdoZW4gdGltZW91dAo+
ID4gPiAtIGdldCBidWZmZXIgbWFudWFsbHkgc2luY2UgdGhlIHZpcnRpbyBjb3JlIGNoZWNrIG1v
cmVfdXNlZCgpIGluc3RlYWQKPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgfCAyMSArKysrKysrKysrKysrKy0tLS0tLS0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGlu
ZGV4IDJlNTZiYmY4Njg5NC4uZDNlYjhmZDZjOWRjIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
PiA+IEBAIC0xOSw2ICsxOSw3IEBACj4gPiA+ICAjaW5jbHVkZSA8bGludXgvYXZlcmFnZS5oPgo+
ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2ZpbHRlci5oPgo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2tl
cm5lbC5oPgo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2NvbXBsZXRpb24uaD4KPiA+ID4gICNpbmNs
dWRlIDxuZXQvcm91dGUuaD4KPiA+ID4gICNpbmNsdWRlIDxuZXQveGRwLmg+Cj4gPiA+ICAjaW5j
bHVkZSA8bmV0L25ldF9mYWlsb3Zlci5oPgo+ID4gPiBAQCAtMjk1LDYgKzI5Niw4IEBAIHN0cnVj
dCB2aXJ0bmV0X2luZm8gewo+ID4gPgo+ID4gPiAgICAgICAvKiBmYWlsb3ZlciB3aGVuIFNUQU5E
QlkgZmVhdHVyZSBlbmFibGVkICovCj4gPiA+ICAgICAgIHN0cnVjdCBmYWlsb3ZlciAqZmFpbG92
ZXI7Cj4gPiA+ICsKPiA+ID4gKyAgICAgc3RydWN0IGNvbXBsZXRpb24gY29tcGxldGlvbjsKPiA+
ID4gIH07Cj4gPiA+Cj4gPiA+ICBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ID4gQEAgLTE3
MDksNiArMTcxMiwxMyBAQCBzdGF0aWMgYm9vbCB0cnlfZmlsbF9yZWN2KHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpLCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gPiA+ICAgICAgIHJldHVybiAh
b29tOwo+ID4gPiAgfQo+ID4gPgo+ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9jdnFfZG9uZShz
dHJ1Y3QgdmlydHF1ZXVlICpjdnEpCj4gPiA+ICt7Cj4gPiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpID0gY3ZxLT52ZGV2LT5wcml2Owo+ID4gPiArCj4gPiA+ICsgICAgIGNvbXBsZXRl
KCZ2aS0+Y29tcGxldGlvbik7Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gIHN0YXRpYyB2b2lkIHNr
Yl9yZWN2X2RvbmUoc3RydWN0IHZpcnRxdWV1ZSAqcnZxKQo+ID4gPiAgewo+ID4gPiAgICAgICBz
dHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IHJ2cS0+dmRldi0+cHJpdjsKPiA+ID4gQEAgLTIxNjks
MTIgKzIxNzksOCBAQCBzdGF0aWMgYm9vbCB2aXJ0bmV0X3NlbmRfY29tbWFuZChzdHJ1Y3Qgdmly
dG5ldF9pbmZvICp2aSwgdTggY2xhc3MsIHU4IGNtZCwKPiA+ID4gICAgICAgaWYgKHVubGlrZWx5
KCF2aXJ0cXVldWVfa2ljayh2aS0+Y3ZxKSkpCj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIHZp
LT5jdHJsLT5zdGF0dXMgPT0gVklSVElPX05FVF9PSzsKPiA+ID4KPiA+ID4gLSAgICAgLyogU3Bp
biBmb3IgYSByZXNwb25zZSwgdGhlIGtpY2sgY2F1c2VzIGFuIGlvcG9ydCB3cml0ZSwgdHJhcHBp
bmcKPiA+ID4gLSAgICAgICogaW50byB0aGUgaHlwZXJ2aXNvciwgc28gdGhlIHJlcXVlc3Qgc2hv
dWxkIGJlIGhhbmRsZWQgaW1tZWRpYXRlbHkuCj4gPiA+IC0gICAgICAqLwo+ID4gPiAtICAgICB3
aGlsZSAoIXZpcnRxdWV1ZV9nZXRfYnVmKHZpLT5jdnEsICZ0bXApICYmCj4gPiA+IC0gICAgICAg
ICAgICAhdmlydHF1ZXVlX2lzX2Jyb2tlbih2aS0+Y3ZxKSkKPiA+ID4gLSAgICAgICAgICAgICBj
cHVfcmVsYXgoKTsKPiA+ID4gKyAgICAgd2FpdF9mb3JfY29tcGxldGlvbigmdmktPmNvbXBsZXRp
b24pOwo+ID4gPiArICAgICB2aXJ0cXVldWVfZ2V0X2J1Zih2aS0+Y3ZxLCAmdG1wKTsKPiA+ID4K
PiA+ID4gICAgICAgcmV0dXJuIHZpLT5jdHJsLT5zdGF0dXMgPT0gVklSVElPX05FVF9PSzsKPiA+
ID4gIH0KPiA+ID4gQEAgLTM2NzIsNyArMzY3OCw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9maW5k
X3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiA+ID4KPiA+ID4gICAgICAgLyogUGFyYW1l
dGVycyBmb3IgY29udHJvbCB2aXJ0cXVldWUsIGlmIGFueSAqLwo+ID4gPiAgICAgICBpZiAodmkt
Pmhhc19jdnEpIHsKPiA+ID4gLSAgICAgICAgICAgICBjYWxsYmFja3NbdG90YWxfdnFzIC0gMV0g
PSBOVUxMOwo+ID4gPiArICAgICAgICAgICAgIGNhbGxiYWNrc1t0b3RhbF92cXMgLSAxXSA9IHZp
cnRuZXRfY3ZxX2RvbmU7Cj4gPgo+ID4gVGhpcyBkZXBlbmRzIHRoZSBpbnRlcnJ1cHQsIHJpZ2h0
Pwo+Cj4gTm90IG5lY2Vzc2FyaWx5LCB3ZSBoYXZlIElTUiBmb3IgYXQgbGFzdCBQQ0k6Cj4KPiBz
dGF0aWMgaXJxcmV0dXJuX3QgdnBfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKm9wYXF1ZSkKPiB7
Cj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IG9wYXF1ZTsKPiAg
ICAgICAgIHU4IGlzcjsKPgo+ICAgICAgICAgLyogcmVhZGluZyB0aGUgSVNSIGhhcyB0aGUgZWZm
ZWN0IG9mIGFsc28gY2xlYXJpbmcgaXQgc28gaXQncyB2ZXJ5Cj4gICAgICAgICAgKiBpbXBvcnRh
bnQgdG8gc2F2ZSBvZmYgdGhlIHZhbHVlLiAqLwo+ICAgICAgICAgaXNyID0gaW9yZWFkOCh2cF9k
ZXYtPmlzcik7Cj4gLi4uCj4gfQo+Cj4gPgo+ID4gSSB3b3JyeSB0aGF0IHRoZXJlIG1heSBiZSBz
b21lIGRldmljZXMgdGhhdCBtYXkgbm90IHN1cHBvcnQgaW50ZXJydXB0aW9uIG9uIGN2cS4KPgo+
IElzIHRoZSBkZXZpY2UgdXNpbmcgSU5UWCBvciBNU0ktWD8KPgo+ID4gQWx0aG91Z2ggdGhpcyBt
YXkgbm90IGJlIGluIGxpbmUgd2l0aCBTUEVDLCBpdCBtYXkgY2F1c2UgcHJvYmxlbSBvbiB0aGUg
ZGV2aWNlcwo+ID4gdGhhdCBjYW4gd29yayBub3JtYWxseSBhdCBwcmVzZW50Lgo+Cj4gVGhlbiB0
aGUgaW1wbGVtZW50YXRpb24gaXMgYnVnZ3ksIGl0IG1pZ2h0IG5vdCB3b3JrIGZvciBkcml2ZXJz
IG90aGVyCj4gdGhhbiBMaW51eC4gV29ya2luZyBhcm91bmQgc3VjaCBidWdneSBpbXBsZW1lbnRh
dGlvbiBpcyBzdWJvcHRpbWFsLgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4K
PiA+ID4gICAgICAgICAgICAgICBuYW1lc1t0b3RhbF92cXMgLSAxXSA9ICJjb250cm9sIjsKPiA+
ID4gICAgICAgfQo+ID4gPgo+ID4gPiBAQCAtNDEyMiw2ICs0MTI4LDcgQEAgc3RhdGljIGludCB2
aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiAgICAgICBpZiAo
dmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpCj4gPiA+ICAgICAgICAgICAg
ICAgdmlydG5ldF9pbml0X2RlZmF1bHRfcnNzKHZpKTsKPiA+ID4KPiA+ID4gKyAgICAgaW5pdF9j
b21wbGV0aW9uKCZ2aS0+Y29tcGxldGlvbik7Cj4gPiA+ICAgICAgIGVuYWJsZV9yeF9tb2RlX3dv
cmsodmkpOwo+ID4gPgo+ID4gPiAgICAgICAvKiBzZXJpYWxpemUgbmV0ZGV2IHJlZ2lzdGVyICsg
dmlydGlvX2RldmljZV9yZWFkeSgpIHdpdGggbmRvX29wZW4oKSAqLwo+ID4gPiAtLQo+ID4gPiAy
LjI1LjEKPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
