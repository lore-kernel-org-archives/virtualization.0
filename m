Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45B3C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 04:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1666F40C43;
	Thu, 23 Mar 2023 04:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1666F40C43
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CBKgMjCc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K7g93lJMFB2Y; Thu, 23 Mar 2023 04:05:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 922874011C;
	Thu, 23 Mar 2023 04:05:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 922874011C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A311C0035;
	Thu, 23 Mar 2023 04:05:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB769C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 04:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EC6541BE0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 04:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EC6541BE0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CBKgMjCc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pw7qEkQEVFKW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 04:05:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BB8A41BDE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BB8A41BDE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 04:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679544319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOnNIGAilJ7fmmyy5EpSRdCYNuyde6MJKsXQO3HGUMs=;
 b=CBKgMjCcZ3N/ihZhKCpLA/O6zsAuTmDrzlVoVz37HURwKe+On9oGGFU3FGDawU/WNaUoMs
 Ukb9IYtvysipBO+ac+l7mPV8t7jHsJl9d0ZMWIXH5++Lbpt3YGEutFO1m2PWBFNO7xXblM
 NoxZBr+zlzBA90z7XsqFMt5vR7Mzc0s=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662--oDs4KhSMueoOPIw_v7OLQ-1; Thu, 23 Mar 2023 00:05:15 -0400
X-MC-Unique: -oDs4KhSMueoOPIw_v7OLQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-177bf70751bso10843142fac.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 21:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679544315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOnNIGAilJ7fmmyy5EpSRdCYNuyde6MJKsXQO3HGUMs=;
 b=WWvx5RmG2ofFEokXmtyF/chURwFpjaCv1GWcAW3zwY80nV5ntBYji2ZUFs0NqNnFDP
 hIRlRDt8HrYozzECpgb1QYzaWiLIcM1rifni4mZqiJat78zyk4k9G7AC4MCngrXsprIi
 PfJsbtSTo24rytUaswxU9xKRqxPRhnbtzCCJ07FqgH2wKavkJkevpTVwlZwbznvTbQk4
 wPXkhIUJXIlA4Y/MIqiu+Xha91Q18V8LsfZFkyT+Si1N3hTrEVchzvAcHEHx3p+IOuPh
 Ne/X+7GSktf0Bf9Qrdu7OQIhtDvYbYdtQwjQjo6oi9peCK3n8leokxpWQ8+2xcxIJ8kF
 j/Aw==
X-Gm-Message-State: AO0yUKXKwYM25kwygyLGp34/Vazz3c+jwD58fVV15lkL6rpDUl81X9Nw
 mQmafjnwyfd0QMdiKHe+Rk7HLiJK2P8jg0tPQbDdklkjzDQ6evUEv3m1ZYwn2v7zqyVEh4QruRK
 dE8H67H+FdqSwcZKDN2n7Fs+HZtrJr3NjU/vAxabnea+ky5fxXDFIsfopdw==
X-Received: by 2002:a05:6871:4d10:b0:17a:d3d2:dc75 with SMTP id
 ug16-20020a0568714d1000b0017ad3d2dc75mr540512oab.3.1679544315257; 
 Wed, 22 Mar 2023 21:05:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set8FZEdSFvyHWpm4kjJu22TgDTHMafGQoxV36094gItSoHHuYJ036I/iI+eBjzGXAFHDuZI3p37rdKRjhcjHm+s=
X-Received: by 2002:a05:6871:4d10:b0:17a:d3d2:dc75 with SMTP id
 ug16-20020a0568714d1000b0017ad3d2dc75mr540500oab.3.1679544315023; Wed, 22 Mar
 2023 21:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230322191038.44037-1-shannon.nelson@amd.com>
 <20230322191038.44037-2-shannon.nelson@amd.com>
In-Reply-To: <20230322191038.44037-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 12:05:04 +0800
Message-ID: <CACGkMEvMvd9rwWZYTuc_gU1fSm8XPa=7=EOKjjzy7Mr=qEyqgA@mail.gmail.com>
Subject: Re: [PATCH v3 virtio 1/8] virtio: allow caller to override device id
 and DMA mask
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMzoxMeKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IFRvIGFsbG93IGEgYml0IG9mIGZsZXhpYmlsaXR5
IHdpdGggdmFyaW91cyB2aXJ0aW8gYmFzZWQgZGV2aWNlcywgYWxsb3cKPiB0aGUgY2FsbGVyIHRv
IHNwZWNpZnkgYSBkaWZmZXJlbnQgZGV2aWNlIGlkIGFuZCBETUEgbWFzay4gIFRoaXMgYWRkcwo+
IGZpZWxkcyB0byBzdHJ1Y3QgWFhYIHRvIHNwZWNpZnkgYW4gb3ZlcnJpZGUgZGV2aWNlIGlkIGNo
ZWNrIGFuZCBhIERNQSBtYXNrLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2hhbm5vbiBOZWxzb24gPHNo
YW5ub24ubmVsc29uQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bW9kZXJuX2Rldi5jIHwgMzYgKysrKysrKysrKysrKysrKystLS0tLS0tLS0KPiAgaW5jbHVkZS9s
aW51eC92aXJ0aW9fcGNpX21vZGVybi5oICAgICAgfCAgNiArKysrKwo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDMwIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBpbmRleCA4NjljYjQ2YmVmOTYuLjZhZDFiYjlhZThmYSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+ICsr
KyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4gQEAgLTIyMSwxOCAr
MjIxLDI1IEBAIGludCB2cF9tb2Rlcm5fcHJvYmUoc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2Rl
dmljZSAqbWRldikKPgo+ICAgICAgICAgY2hlY2tfb2Zmc2V0cygpOwo+Cj4gLSAgICAgICAvKiBX
ZSBvbmx5IG93biBkZXZpY2VzID49IDB4MTAwMCBhbmQgPD0gMHgxMDdmOiBsZWF2ZSB0aGUgcmVz
dC4gKi8KPiAtICAgICAgIGlmIChwY2lfZGV2LT5kZXZpY2UgPCAweDEwMDAgfHwgcGNpX2Rldi0+
ZGV2aWNlID4gMHgxMDdmKQo+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsKPiAtCj4g
LSAgICAgICBpZiAocGNpX2Rldi0+ZGV2aWNlIDwgMHgxMDQwKSB7Cj4gLSAgICAgICAgICAgICAg
IC8qIFRyYW5zaXRpb25hbCBkZXZpY2VzOiB1c2UgdGhlIFBDSSBzdWJzeXN0ZW0gZGV2aWNlIGlk
IGFzCj4gLSAgICAgICAgICAgICAgICAqIHZpcnRpbyBkZXZpY2UgaWQsIHNhbWUgYXMgbGVnYWN5
IGRyaXZlciBhbHdheXMgZGlkLgo+IC0gICAgICAgICAgICAgICAgKi8KPiAtICAgICAgICAgICAg
ICAgbWRldi0+aWQuZGV2aWNlID0gcGNpX2Rldi0+c3Vic3lzdGVtX2RldmljZTsKPiArICAgICAg
IGlmIChtZGV2LT5kZXZpY2VfaWRfY2hlY2tfb3ZlcnJpZGUpIHsKPiArICAgICAgICAgICAgICAg
ZXJyID0gbWRldi0+ZGV2aWNlX2lkX2NoZWNrX292ZXJyaWRlKHBjaV9kZXYpOwo+ICsgICAgICAg
ICAgICAgICBpZiAoZXJyKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4g
KyAgICAgICAgICAgICAgIG1kZXYtPmlkLmRldmljZSA9IHBjaV9kZXYtPmRldmljZTsKCldoaWxl
IGF0IHRoaXMsIHdvdWxkIGl0IGJlIGJldHRlciB0byBsZXQgdGhlIGRldmljZV9pZF9jaGVja19v
dmVycmlkZQp0byByZXR1cm4gdGhlIG1kZXYtPmlkLmRldmljZSA/CgpPdGhlcnMgbG9vayBnb29k
LgoKVGhhbmtzCgo+ICAgICAgICAgfSBlbHNlIHsKPiAtICAgICAgICAgICAgICAgLyogTW9kZXJu
IGRldmljZXM6IHNpbXBseSB1c2UgUENJIGRldmljZSBpZCwgYnV0IHN0YXJ0IGZyb20gMHgxMDQw
LiAqLwo+IC0gICAgICAgICAgICAgICBtZGV2LT5pZC5kZXZpY2UgPSBwY2lfZGV2LT5kZXZpY2Ug
LSAweDEwNDA7Cj4gKyAgICAgICAgICAgICAgIC8qIFdlIG9ubHkgb3duIGRldmljZXMgPj0gMHgx
MDAwIGFuZCA8PSAweDEwN2Y6IGxlYXZlIHRoZSByZXN0LiAqLwo+ICsgICAgICAgICAgICAgICBp
ZiAocGNpX2Rldi0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBjaV9kZXYtPmRldmljZSA+IDB4MTA3ZikK
PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsKPiArCj4gKyAgICAgICAg
ICAgICAgIGlmIChwY2lfZGV2LT5kZXZpY2UgPCAweDEwNDApIHsKPiArICAgICAgICAgICAgICAg
ICAgICAgICAvKiBUcmFuc2l0aW9uYWwgZGV2aWNlczogdXNlIHRoZSBQQ0kgc3Vic3lzdGVtIGRl
dmljZSBpZCBhcwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIHZpcnRpbyBkZXZpY2UgaWQs
IHNhbWUgYXMgbGVnYWN5IGRyaXZlciBhbHdheXMgZGlkLgo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAqLwo+ICsgICAgICAgICAgICAgICAgICAgICAgIG1kZXYtPmlkLmRldmljZSA9IHBjaV9k
ZXYtPnN1YnN5c3RlbV9kZXZpY2U7Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgLyogTW9kZXJuIGRldmljZXM6IHNpbXBseSB1c2UgUENJIGRldmlj
ZSBpZCwgYnV0IHN0YXJ0IGZyb20gMHgxMDQwLiAqLwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IG1kZXYtPmlkLmRldmljZSA9IHBjaV9kZXYtPmRldmljZSAtIDB4MTA0MDsKPiArICAgICAgICAg
ICAgICAgfQo+ICAgICAgICAgfQo+ICAgICAgICAgbWRldi0+aWQudmVuZG9yID0gcGNpX2Rldi0+
c3Vic3lzdGVtX3ZlbmRvcjsKPgo+IEBAIC0yNjAsNyArMjY3LDEyIEBAIGludCB2cF9tb2Rlcm5f
cHJvYmUoc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldikKPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIGVyciA9IGRtYV9z
ZXRfbWFza19hbmRfY29oZXJlbnQoJnBjaV9kZXYtPmRldiwgRE1BX0JJVF9NQVNLKDY0KSk7Cj4g
KyAgICAgICBpZiAobWRldi0+ZG1hX21hc2tfb3ZlcnJpZGUpCj4gKyAgICAgICAgICAgICAgIGVy
ciA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBjaV9kZXYtPmRldiwKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZGV2LT5kbWFfbWFza19vdmVy
cmlkZSk7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAgICAgICAgICAgIGVyciA9IGRtYV9zZXRfbWFz
a19hbmRfY29oZXJlbnQoJnBjaV9kZXYtPmRldiwKPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBETUFfQklUX01BU0soNjQpKTsKPiAgICAgICAgIGlmIChl
cnIpCj4gICAgICAgICAgICAgICAgIGVyciA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBj
aV9kZXYtPmRldiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBETUFfQklUX01BU0soMzIpKTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0
aW9fcGNpX21vZGVybi5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oCj4gaW5k
ZXggYzRlZWI3OWIwMTM5Li44NDc2NWJiZDhkYzUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC92aXJ0aW9fcGNpX21vZGVybi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21v
ZGVybi5oCj4gQEAgLTM4LDYgKzM4LDEyIEBAIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZp
Y2Ugewo+ICAgICAgICAgaW50IG1vZGVybl9iYXJzOwo+Cj4gICAgICAgICBzdHJ1Y3QgdmlydGlv
X2RldmljZV9pZCBpZDsKPiArCj4gKyAgICAgICAvKiBhbHQuIGNoZWNrIGZvciB2ZW5kb3Igdmly
dGlvIGRldmljZSwgcmV0dXJuIDAgb3IgLUVSUk5PICovCj4gKyAgICAgICBpbnQgKCpkZXZpY2Vf
aWRfY2hlY2tfb3ZlcnJpZGUpKHN0cnVjdCBwY2lfZGV2ICpwZGV2KTsKPiArCj4gKyAgICAgICAv
KiBhbHQuIG1hc2sgZm9yIGRldmljZXMgd2l0aCBsaW1pdGVkIERNQSBzcGFjZSAqLwo+ICsgICAg
ICAgdTY0IGRtYV9tYXNrX292ZXJyaWRlOwo+ICB9Owo+Cj4gIC8qCj4gLS0KPiAyLjE3LjEKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
