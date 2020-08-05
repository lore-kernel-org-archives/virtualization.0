Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DFAC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:45:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFFA22D05
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN1laApu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFFA22D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D2B6877FD;
	Wed,  5 Aug 2020 11:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGrTvbWcC9BV; Wed,  5 Aug 2020 11:45:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9649185A1D;
	Wed,  5 Aug 2020 11:45:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E90BC0051;
	Wed,  5 Aug 2020 11:45:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49D34C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 43293877F8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgTh7z1jrHpm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:45:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 70EF485A1D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596627953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvhF/2Uq1kX64zND5Z4WYms1vSnLsR66mXtK5h4mjnE=;
 b=AN1laApuH9yql3is7Ifu/vRkcn4JkZg0Dj/aOnfKa3N5I70xTHCpUlX0EMGOMBxh8gri+h
 OhLz9fISfh39YfsLA31b4Bd4fStWYe9O7pLjee5tl2OX88asHy8vj9pIfniPDi9QQHdcmT
 lAQu9vz6WhjkcAnrnquCTQhxL/fqa34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-Id0m6u5oNtu_ghf52-1mfA-1; Wed, 05 Aug 2020 07:45:51 -0400
X-MC-Unique: Id0m6u5oNtu_ghf52-1mfA-1
Received: by mail-wm1-f71.google.com with SMTP id u14so1876121wml.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 04:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dvhF/2Uq1kX64zND5Z4WYms1vSnLsR66mXtK5h4mjnE=;
 b=qq3nm3b7hyaIVsqw+AvQYbby5/NEPdGPFMjUYyXoRIOeomagvCOOSvrDC5m1Ktq9Cj
 vY8yPDtkvpXldqQff33Mvk5+GgzPS65S6hgLrGrJzbbyXsa60rCFDOPTqufubgWN53Az
 PG8kF5oZ4ubYIQEvV5LbGhgewGNuLj1xGYMH2/0ntCyz+1zzYiajXHpo5w4Sasv35NWm
 oBKrVCFmK20P2dGOCrmKGyb4SEdZGaSmS3qyEW9L8oWpZ0qP0+OdomLt8FlfZsseqt5I
 jtwip8siaE0yd6KXN34RkswpPhPJi4IV1QHSzHBXKLrGY5kdaoeiHt8cK4moG+CkKnVV
 0EVQ==
X-Gm-Message-State: AOAM530gzI/30hoXU6g3b5LhqGIQeJiK6aaUFyWLXNh9H7oS7djxQZKn
 f70EUrlqOQAXYlNuAvwwOsTHZwbScbYt1QDx97Ig60g1IWG8MExzB/8B6Q7Pfj98Xo1RaagJcZL
 o1zYmORkkO+HYcy7TG9THAw5Xse4eCJCO6yTKJV9ROg==
X-Received: by 2002:a1c:a590:: with SMTP id o138mr2959635wme.4.1596627950598; 
 Wed, 05 Aug 2020 04:45:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUqGQTkpCDTfa2ZGtGXUiAZzqSzaobMzIluThYVUCvwubI43LF+I4IqyX+82lokvtNLNwvgg==
X-Received: by 2002:a1c:a590:: with SMTP id o138mr2959613wme.4.1596627950321; 
 Wed, 05 Aug 2020 04:45:50 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id o2sm2693544wrh.70.2020.08.05.04.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 04:45:49 -0700 (PDT)
Date: Wed, 5 Aug 2020 07:45:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
Message-ID: <20200805074434-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMDI6Mjg6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNCDkuIrljYg0OjU4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBDdXJyZW50bHkgYWxsIGNvbmZpZyBzcGFjZSBmaWVsZHMgYXJlIG9mIHRoZSB0eXBlIF9f
dVhYLgo+ID4gVGhpcyBjb25mdXNlcyBwZW9wbGUgYW5kIHNvbWUgZHJpdmVycyAobm90YWJseSB2
ZHBhKQo+ID4gYWNjZXNzIHRoZW0gdXNpbmcgQ1BVIGVuZGlhbi1uZXNzIC0gd2hpY2ggb25seQo+
ID4gd29ya3Mgd2VsbCBmb3IgbGVnYWN5IG9yIExFIHBsYXRmb3Jtcy4KPiA+IAo+ID4gVXBkYXRl
IHZpcnRpb19jcmVhZC92aXJ0aW9fY3dyaXRlIG1hY3JvcyB0byBhbGxvdyBfX3ZpcnRpb1hYCj4g
PiBhbmQgX19sZVhYIGZpZWxkIHR5cGVzLiBGb2xsb3ctdXAgcGF0Y2hlcyB3aWxsIGNvbnZlcnQK
PiA+IGNvbmZpZyBzcGFjZSB0byB1c2UgdGhlc2UgdHlwZXMuCj4gPiAKPiA+IFNpZ25lZC1vZmYt
Ynk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICAgaW5j
bHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IGluZGV4IDNiNGVhZTVhYzVl
My4uNjRkYTQ5MTkzNmY3IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29u
ZmlnLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gPiBAQCAtNiw2
ICs2LDcgQEAKPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPgo+ID4gICAjaW5jbHVkZSA8bGlu
dXgvdmlydGlvLmg+Cj4gPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYnl0ZW9yZGVyLmg+Cj4g
PiArI2luY2x1ZGUgPGxpbnV4L2NvbXBpbGVyX3R5cGVzLmg+Cj4gPiAgICNpbmNsdWRlIDx1YXBp
L2xpbnV4L3ZpcnRpb19jb25maWcuaD4KPiA+ICAgc3RydWN0IGlycV9hZmZpbml0eTsKPiA+IEBA
IC0yODcsMTIgKzI4OCw1NyBAQCBzdGF0aWMgaW5saW5lIF9fdmlydGlvNjQgY3B1X3RvX3ZpcnRp
bzY0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1NjQgdmFsKQo+ID4gICAJcmV0dXJuIF9f
Y3B1X3RvX3ZpcnRpbzY0KHZpcnRpb19pc19saXR0bGVfZW5kaWFuKHZkZXYpLCB2YWwpOwo+ID4g
ICB9Cj4gPiArLyoKPiA+ICsgKiBPbmx5IHRoZSBjaGVja2VyIGRpZmZlcmVudGlhdGVzIGJldHdl
ZW4gX192aXJ0aW9YWCBhbmQgX191WFggdHlwZXMuIEJ1dCB3ZQo+ID4gKyAqIHRyeSB0byBzaGFy
ZSBhcyBtdWNoIGNvZGUgYXMgd2UgY2FuIHdpdGggdGhlIHJlZ3VsYXIgR0NDIGJ1aWxkLgo+ID4g
KyAqLwo+ID4gKyNpZiAhZGVmaW5lZChDT05GSUdfQ0NfSVNfR0NDKSAmJiAhZGVmaW5lZChfX0NI
RUNLRVJfXykKPiA+ICsKPiA+ICsvKiBOb3QgYSBjaGVja2VyIC0gd2UgY2FuIGtlZXAgdGhpbmdz
IHNpbXBsZSAqLwo+ID4gKyNkZWZpbmUgX192aXJ0aW9fbmF0aXZlX3R5cGVvZih4KSB0eXBlb2Yo
eCkKPiA+ICsKPiA+ICsjZWxzZQo+ID4gKwo+ID4gKy8qCj4gPiArICogV2UgYnVpbGQgdGhpcyBv
dXQgb2YgYSBjb3VwbGUgb2YgaGVscGVyIG1hY3JvcyBpbiBhIHZhaW4gYXR0ZW1wdCB0bwo+ID4g
KyAqIGhlbHAgeW91IGtlZXAgeW91ciBsdW5jaCBkb3duIHdoaWxlIHJlYWRpbmcgaXQuCj4gPiAr
ICovCj4gPiArI2RlZmluZSBfX3ZpcnRpb19waWNrX3ZhbHVlKHgsIHR5cGUsIHRoZW4sIG90aGVy
d2lzZSkJCQlcCj4gPiArCV9fYnVpbHRpbl9jaG9vc2VfZXhwcihfX3NhbWVfdHlwZSh4LCB0eXBl
KSwgdGhlbiwgb3RoZXJ3aXNlKQo+ID4gKwo+ID4gKyNkZWZpbmUgX192aXJ0aW9fcGlja190eXBl
KHgsIHR5cGUsIHRoZW4sIG90aGVyd2lzZSkJCQlcCj4gPiArCV9fdmlydGlvX3BpY2tfdmFsdWUo
eCwgdHlwZSwgKHRoZW4pMCwgb3RoZXJ3aXNlKQo+ID4gKwo+ID4gKyNkZWZpbmUgX192aXJ0aW9f
cGlja19lbmRpYW4oeCwgeDE2LCB4MzIsIHg2NCwgb3RoZXJ3aXNlKQkJCVwKPiA+ICsJX192aXJ0
aW9fcGlja190eXBlKHgsIHgxNiwgX191MTYsCQkJCQlcCj4gPiArCQlfX3ZpcnRpb19waWNrX3R5
cGUoeCwgeDMyLCBfX3UzMiwJCQkJXAo+ID4gKwkJCV9fdmlydGlvX3BpY2tfdHlwZSh4LCB4NjQs
IF9fdTY0LAkJCVwKPiA+ICsJCQkJb3RoZXJ3aXNlKSkpCj4gPiArCj4gPiArI2RlZmluZSBfX3Zp
cnRpb19uYXRpdmVfdHlwZW9mKHgpIHR5cGVvZigJCQkJCVwKPiA+ICsJX192aXJ0aW9fcGlja190
eXBlKHgsIF9fdTgsIF9fdTgsCQkJCQlcCj4gPiArCQlfX3ZpcnRpb19waWNrX2VuZGlhbih4LCBf
X3ZpcnRpbzE2LCBfX3ZpcnRpbzMyLCBfX3ZpcnRpbzY0LAlcCj4gPiArCQkJX192aXJ0aW9fcGlj
a19lbmRpYW4oeCwgX19sZTE2LCBfX2xlMzIsIF9fbGU2NCwJCVwKPiA+ICsJCQkJX192aXJ0aW9f
cGlja19lbmRpYW4oeCwgX191MTYsIF9fdTMyLCBfX3U2NCwJXAo+ID4gKwkJCQkJLyogTm8gb3Ro
ZXIgdHlwZSBhbGxvd2VkICovCQlcCj4gPiArCQkJCQkodm9pZCkwKSkpKSkKPiA+ICsKPiA+ICsj
ZW5kaWYKPiA+ICsKPiA+ICsjZGVmaW5lIF9fdmlydGlvX25hdGl2ZV90eXBlKHN0cnVjdG5hbWUs
IG1lbWJlcikgXAo+ID4gKwlfX3ZpcnRpb19uYXRpdmVfdHlwZW9mKCgoc3RydWN0bmFtZSopMCkt
Pm1lbWJlcikKPiA+ICsKPiA+ICsjZGVmaW5lIF9fdmlydGlvX3R5cGVjaGVjayhzdHJ1Y3RuYW1l
LCBtZW1iZXIsIHZhbCkgXAo+ID4gKwkJLyogTXVzdCBtYXRjaCB0aGUgbWVtYmVyJ3MgdHlwZSwg
YW5kIGJlIGludGVnZXIgKi8gXAo+ID4gKwkJdHlwZWNoZWNrKF9fdmlydGlvX25hdGl2ZV90eXBl
KHN0cnVjdG5hbWUsIG1lbWJlciksICh2YWwpKQo+ID4gKwo+ID4gKwo+ID4gICAvKiBDb25maWcg
c3BhY2UgYWNjZXNzb3JzLiAqLwo+ID4gICAjZGVmaW5lIHZpcnRpb19jcmVhZCh2ZGV2LCBzdHJ1
Y3RuYW1lLCBtZW1iZXIsIHB0cikJCQlcCj4gPiAgIAlkbyB7CQkJCQkJCQlcCj4gPiAgIAkJbWln
aHRfc2xlZXAoKTsJCQkJCQlcCj4gPiAgIAkJLyogTXVzdCBtYXRjaCB0aGUgbWVtYmVyJ3MgdHlw
ZSwgYW5kIGJlIGludGVnZXIgKi8JXAo+ID4gLQkJaWYgKCF0eXBlY2hlY2sodHlwZW9mKCgoKHN0
cnVjdG5hbWUqKTApLT5tZW1iZXIpKSwgKihwdHIpKSkgXAo+ID4gKwkJaWYgKCFfX3ZpcnRpb190
eXBlY2hlY2soc3RydWN0bmFtZSwgbWVtYmVyLCAqKHB0cikpKQlcCj4gPiAgIAkJCSgqcHRyKSA9
IDE7CQkJCQlcCj4gCj4gCj4gQSBzaWxseSBxdWVzdGlvbizCoCBjb21wYXJlIHRvIHVzaW5nIHNl
dCgpL2dldCgpIGRpcmVjdGx5LCB3aGF0J3MgdGhlIHZhbHVlCj4gb2YgdGhlIGFjY2Vzc29ycyBt
YWNybyBoZXJlPwo+IAo+IFRoYW5rcwoKZ2V0L3NldCBkb24ndCBjb252ZXJ0IHRvIHRoZSBuYXRp
dmUgZW5kaWFuLCBJIGd1ZXNzIHRoYXQncyB3aHkKZHJpdmVycyB1c2UgY3JlYWQvY3dyaXRlLiBJ
dCBpcyBhbHNvIG5pY2UgdGhhdCB0aGVyZSdzIHR5cGUKc2FmZXR5LCBjaGVja2luZyB0aGUgY29y
cmVjdCBpbnRlZ2VyIHdpZHRoIGlzIHVzZWQuCgo+IAo+ID4gICAJCQkJCQkJCQlcCj4gPiAgIAkJ
c3dpdGNoIChzaXplb2YoKnB0cikpIHsJCQkJCVwKPiA+IEBAIC0zMjIsNyArMzY4LDcgQEAgc3Rh
dGljIGlubGluZSBfX3ZpcnRpbzY0IGNwdV90b192aXJ0aW82NChzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldiwgdTY0IHZhbCkKPiA+ICAgCWRvIHsJCQkJCQkJCVwKPiA+ICAgCQltaWdodF9zbGVl
cCgpOwkJCQkJCVwKPiA+ICAgCQkvKiBNdXN0IG1hdGNoIHRoZSBtZW1iZXIncyB0eXBlLCBhbmQg
YmUgaW50ZWdlciAqLwlcCj4gPiAtCQlpZiAoIXR5cGVjaGVjayh0eXBlb2YoKCgoc3RydWN0bmFt
ZSopMCktPm1lbWJlcikpLCAqKHB0cikpKSBcCj4gPiArCQlpZiAoIV9fdmlydGlvX3R5cGVjaGVj
ayhzdHJ1Y3RuYW1lLCBtZW1iZXIsICoocHRyKSkpCVwKPiA+ICAgCQkJQlVHX09OKCgqcHRyKSA9
PSAxKTsJCQkJXAo+ID4gICAJCQkJCQkJCQlcCj4gPiAgIAkJc3dpdGNoIChzaXplb2YoKnB0cikp
IHsJCQkJCVwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
