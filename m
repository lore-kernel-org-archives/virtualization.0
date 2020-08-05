Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA43C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:44:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1952070A
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfwC1Aau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1952070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 35F0F2094C;
	Wed,  5 Aug 2020 11:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtm6+TCHu61X; Wed,  5 Aug 2020 11:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3D03F2052B;
	Wed,  5 Aug 2020 11:44:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21783C0051;
	Wed,  5 Aug 2020 11:44:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02FE8C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F2D0F877FA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xnUJiOuC3SP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:44:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9829E85A1D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596627860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st8bBehsTAufbhHFpNAjUz+GFm9Sypep/hQM+t1/5CA=;
 b=XfwC1AauJ+Ynyf7GGbaByEHholuNiLN53kf2NFHwpPq6fOcXid0WrOTOQkWEdkoMDPyBAT
 j1cMNPb4N0G6qBj6wVeu9MbntG19tvh14aIs5tzeeoK1s1m0ou1jtSEPFNwTH01GNXFQvI
 OrkSEeJb3vVHlk3+F7xsoFQC/AZ6lhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-fWxrBka4MpKRCGz_tKngnA-1; Wed, 05 Aug 2020 07:44:19 -0400
X-MC-Unique: fWxrBka4MpKRCGz_tKngnA-1
Received: by mail-wm1-f70.google.com with SMTP id s4so2352280wmh.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 04:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=st8bBehsTAufbhHFpNAjUz+GFm9Sypep/hQM+t1/5CA=;
 b=jusZsG08jwx7hZW7cMsHBkdDkZRfeYLeKYiSYGIr/NjDDWZ3UkeDqEpYzqWZ2n7SY0
 vB5MZMvErMMyxy7rIj+LS2LhGovFVRmDlPtUGgnljxAL59Ap5XtCVdrM/GxNHt1CcWL9
 Gw57cSq4LNuzsxpsfakJRHgtO9IMlSbqQdodwFCMzflhUqW3po+sVL/4ZsVgq1WvWdSx
 Yto8rEQ/E3R7NYiHgRQ5YkJGAAgDCTjMl67GScPTLy7S1nJdbNbJEmgIu5Cw0VcBZ4LC
 NCrd/3IRBf6JvUVUW49f/wI6JrRN+SGLJ3nbZ/8W6IHsLj/w8IS1TqhqvvdnRvFVI3B4
 zjHw==
X-Gm-Message-State: AOAM531UqudZRCNxz62OhjOYQtCDefEz/QIznVI62OYg1IeGOm1QnWHk
 turhwvGcYfweTZpbO6PwLQUfcJMTtUoy9fWXz7R+CexkjBEG0sVgeTF36ZKX6et7CLGRBcB/sQ9
 x48PDy+lpPILQwZfnw4BYStoYudGVstC0z44Zv1cXUw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr3135807wml.106.1596627857905; 
 Wed, 05 Aug 2020 04:44:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOkFykdUhPDpT8zbjlSuYH0hAbQAOKS37RNUEgvX/NjN6jmiXOGVeJFe+LNfzuJxKvZFKtEw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr3135788wml.106.1596627857703; 
 Wed, 05 Aug 2020 04:44:17 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id m8sm2491089wro.75.2020.08.05.04.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 04:44:16 -0700 (PDT)
Date: Wed, 5 Aug 2020 07:44:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 22/24] vdpa_sim: fix endian-ness of config space
Message-ID: <20200805074105-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-23-mst@redhat.com>
 <dd24f2e6-4aef-4a26-374c-2349fe1e6a66@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dd24f2e6-4aef-4a26-374c-2349fe1e6a66@redhat.com>
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

T24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMDI6MjE6MDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNCDkuIrljYg1OjAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBWRFBBIHNpbSBhY2Nlc3NlcyBjb25maWcgc3BhY2UgYXMgbmF0aXZlIGVuZGlhbiAtIHRo
aXMgaXMKPiA+IHdyb25nIHNpbmNlIGl0J3MgYSBtb2Rlcm4gZGV2aWNlIGFuZCBhY3R1YWxseSB1
c2VzIExFLgo+ID4gCj4gPiBJdCBvbmx5IHN1cHBvcnRzIG1vZGVybiBndWVzdHMgc28gd2UgY291
bGQgcHVudCBhbmQKPiA+IGp1c3QgZm9yY2UgTEUsIGJ1dCBsZXQncyB1c2UgdGhlIGZ1bGwgdmly
dGlvIEFQSXMgc2luY2UgcGVvcGxlCj4gPiB0ZW5kIHRvIGNvcHkvcGFzdGUgY29kZSwgYW5kIHRo
aXMgaXMgbm90IGRhdGEgcGF0aCBhbnl3YXkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+
ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9k
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ID4gaW5kZXggYTliYzVlMGZiMzUzLi5m
YTA1ZTA2NWZmNjkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYwo+ID4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiA+IEBAIC0y
NCw2ICsyNCw3IEBACj4gPiAgICNpbmNsdWRlIDxsaW51eC9ldGhlcmRldmljZS5oPgo+ID4gICAj
aW5jbHVkZSA8bGludXgvdnJpbmdoLmg+Cj4gPiAgICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4g
PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19ieXRlb3JkZXIuaD4KPiA+ICAgI2luY2x1ZGUgPGxp
bnV4L3Zob3N0X2lvdGxiLmg+Cj4gPiAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25m
aWcuaD4KPiA+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX25ldC5oPgo+ID4gQEAgLTcy
LDYgKzczLDIzIEBAIHN0cnVjdCB2ZHBhc2ltIHsKPiA+ICAgCXU2NCBmZWF0dXJlczsKPiA+ICAg
fTsKPiA+ICsvKiBUT0RPOiBjcm9zcy1lbmRpYW4gc3VwcG9ydCAqLwo+ID4gK3N0YXRpYyBpbmxp
bmUgYm9vbCB2ZHBhc2ltX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0p
Cj4gPiArewo+ID4gKwlyZXR1cm4gdmlydGlvX2xlZ2FjeV9pc19saXR0bGVfZW5kaWFuKCkgfHwK
PiA+ICsJCSh2ZHBhc2ltLT5mZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19GX1ZFUlNJT05fMSkp
Owo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgaW5saW5lIHUxNiB2ZHBhc2ltMTZfdG9fY3B1KHN0
cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCBfX3ZpcnRpbzE2IHZhbCkKPiA+ICt7Cj4gPiArCXJldHVy
biBfX3ZpcnRpbzE2X3RvX2NwdSh2ZHBhc2ltX2lzX2xpdHRsZV9lbmRpYW4odmRwYXNpbSksIHZh
bCk7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBpbmxpbmUgX192aXJ0aW8xNiBjcHVfdG9fdmRw
YXNpbTE2KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB1MTYgdmFsKQo+ID4gK3sKPiA+ICsJcmV0
dXJuIF9fY3B1X3RvX3ZpcnRpbzE2KHZkcGFzaW1faXNfbGl0dGxlX2VuZGlhbih2ZHBhc2ltKSwg
dmFsKTsKPiA+ICt9Cj4gPiArCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbV9k
ZXY7Cj4gPiAgIHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYV90b19zaW0oc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhKQo+ID4gQEAgLTMwNiw3ICszMjQsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX25ldF9jb25maWdfb3BzOwo+ID4gICBzdGF0aWMgc3Ry
dWN0IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRlKHZvaWQpCj4gPiAgIHsKPiA+IC0Jc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnICpjb25maWc7Cj4gPiAgIAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbTsK
PiA+ICAgCXN0cnVjdCBkZXZpY2UgKmRldjsKPiA+ICAgCWludCByZXQgPSAtRU5PTUVNOwo+ID4g
QEAgLTMzMSwxMCArMzQ4LDcgQEAgc3RhdGljIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0
ZSh2b2lkKQo+ID4gICAJaWYgKCF2ZHBhc2ltLT5idWZmZXIpCj4gPiAgIAkJZ290byBlcnJfaW9t
bXU7Cj4gPiAtCWNvbmZpZyA9ICZ2ZHBhc2ltLT5jb25maWc7Cj4gPiAtCWNvbmZpZy0+bXR1ID0g
MTUwMDsKPiA+IC0JY29uZmlnLT5zdGF0dXMgPSBWSVJUSU9fTkVUX1NfTElOS19VUDsKPiA+IC0J
ZXRoX3JhbmRvbV9hZGRyKGNvbmZpZy0+bWFjKTsKPiA+ICsJZXRoX3JhbmRvbV9hZGRyKHZkcGFz
aW0tPmNvbmZpZy5tYWMpOwo+ID4gICAJdnJpbmdoX3NldF9pb3RsYigmdmRwYXNpbS0+dnFzWzBd
LnZyaW5nLCB2ZHBhc2ltLT5pb21tdSk7Cj4gPiAgIAl2cmluZ2hfc2V0X2lvdGxiKCZ2ZHBhc2lt
LT52cXNbMV0udnJpbmcsIHZkcGFzaW0tPmlvbW11KTsKPiA+IEBAIC00NDgsNiArNDYyLDcgQEAg
c3RhdGljIHU2NCB2ZHBhc2ltX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEp
Cj4gPiAgIHN0YXRpYyBpbnQgdmRwYXNpbV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4gPiAgIHsKPiA+ICAgCXN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltID0gdmRwYV90b19zaW0odmRwYSk7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyAq
Y29uZmlnID0gJnZkcGFzaW0tPmNvbmZpZzsKPiA+ICAgCS8qIERNQSBtYXBwaW5nIG11c3QgYmUg
ZG9uZSBieSBkcml2ZXIgKi8KPiA+ICAgCWlmICghKGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElP
X0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gPiBAQCAtNDU1LDYgKzQ3MCwxMiBAQCBzdGF0aWMgaW50
IHZkcGFzaW1fc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTY0IGZlYXR1
cmVzKQo+ID4gICAJdmRwYXNpbS0+ZmVhdHVyZXMgPSBmZWF0dXJlcyAmIHZkcGFzaW1fZmVhdHVy
ZXM7Cj4gPiArCS8qIFdlIG9ubHkga25vdyB3aGV0aGVyIGd1ZXN0IGlzIHVzaW5nIHRoZSBsZWdh
Y3kgaW50ZXJmYWNlIGhlcmUsIHNvCj4gPiArCSAqIHRoYXQncyB0aGUgZWFybGllc3Qgd2UgY2Fu
IHNldCBjb25maWcgZmllbGRzLgo+ID4gKwkgKi8KPiAKPiAKPiBXZSBjaGVjayB3aGV0aGVyIG9y
IG5vdCBBQ0NFU1NfUExBVEZPUk0gaXMgc2V0IGJlZm9yZSB3aGljaCBpcyBwcm9iYWJseSBhCj4g
aGludCB0aGF0IG9ubHkgbW9kZXJuIGRldmljZSBpcyBzdXBwb3J0ZWQuIFNvIEkgd29uZGVyIGp1
c3QgZm9yY2UgTEUgYW5kCj4gZmFpbCBpZiBWRVJTSU9OXzEgaXMgbm90IHNldCBpcyBiZXR0ZXI/
Cj4gCj4gVGhhbmtzCj4gCgpIbW0gZ29vZCBwb2ludC4gQXMgdXN1YWwgbGVnYWN5IGRvZXMgbm90
IGhhdmUgYSBjbGVhbiB3YXkgdG8gZmFpbCB0aG91Z2gsCmFyZSB3ZSBzdXJlIHdlIGRvbid0IGV2
ZXIgd2FudCB0byBzdXBwb3J0IGxlZ2FjeSBndWVzdHM/CgoKPiA+ICsKPiA+ICsJY29uZmlnLT5t
dHUgPSBjcHVfdG9fdmRwYXNpbTE2KHZkcGFzaW0sIDE1MDApOwo+ID4gKwljb25maWctPnN0YXR1
cyA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwgVklSVElPX05FVF9TX0xJTktfVVApOwo+ID4g
ICAJcmV0dXJuIDA7Cj4gPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
