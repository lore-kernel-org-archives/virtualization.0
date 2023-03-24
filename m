Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F873C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 09:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BE4D41DBC;
	Fri, 24 Mar 2023 09:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BE4D41DBC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yt6JR7Yi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b5tl8u88JqZn; Fri, 24 Mar 2023 09:12:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 77BCA41DB8;
	Fri, 24 Mar 2023 09:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77BCA41DB8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 587E5C0071;
	Fri, 24 Mar 2023 09:12:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1781AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7CE241DBE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:12:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7CE241DBE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jnd2pGlMjIgk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:12:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 058B741DBA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 058B741DBA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679649153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlQS4mF9DF39LuCMy+j/gzmWPJpejHPdHY+MZDF3ta0=;
 b=Yt6JR7YiA+85EJjJrZSf1sFxWz5kAuqZWuhKeUqfroX+YV39tKW//jI/uuZiEOVeoHxSti
 b+tx1iyItExTu/tJpTOJ3zOU4ndN6DhCUOFKmSYZOWFWGcbrv+atF6j9Ck4yb0djH77qa/
 PAwi6xWvx5awz4YUa/NRYdADudBdMRg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-VSvlHvd5PcOqUVdFRE2hjQ-1; Fri, 24 Mar 2023 05:12:31 -0400
X-MC-Unique: VSvlHvd5PcOqUVdFRE2hjQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 l11-20020adfc78b000000b002db44581302so90457wrg.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 02:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679649150;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZlQS4mF9DF39LuCMy+j/gzmWPJpejHPdHY+MZDF3ta0=;
 b=mejW8ni/VBNCz5LI+NELSVYEvBMFAmClDXRBexustSaiEvgDh0726RjKYkreVA/7cS
 uWuYwoCyDmMgjiThA8+yzFT0tfittuuk+3igm5g85dGdiYwDW0mLSExkOmo0L+GQVvqx
 Ayorwlum0pCvNLSpKD5x0Mgj0t/TAOVIboHEiH2JdXNkVM7phJ1o8NjK5RRu2zwbCGmT
 EE2khQ0Myt/fIdJdG7GVUao+Yn9wAAEiZI3s4o34m9CcayqSNH3HtAZdGQ0Z8vbsx7tJ
 gmvt+/nTEyothEBgHaR5+G0PKnlYz4EcZuYR1bkKupFU+b537d5jp31lu9AtlruosT1k
 kosw==
X-Gm-Message-State: AO0yUKX7yo1zbV6npdKBknpnOtqpggNrPEN0MeLqxu10aHOQZS/D4VMQ
 u35YoBvA+eg4HfrIzxRnLdMRM3PgKp3IQ77x5TxOgZl5YsH0vcILbjrT9lSojsI5qkWMzfFJwYS
 H+Estc8L6rc22o3YcjeuUz7AYmWpHCCFqV67TuFZDnA==
X-Received: by 2002:a7b:c416:0:b0:3ee:f1a4:8895 with SMTP id
 k22-20020a7bc416000000b003eef1a48895mr1552727wmi.24.1679649150186; 
 Fri, 24 Mar 2023 02:12:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set9PHxHrqsJ7v2XCZueLpq6LHVNUDvUsvo02wUs4Ag9qTFq7DHLrspMawYKVjo+lFCfmEDKdcg==
X-Received: by 2002:a7b:c416:0:b0:3ee:f1a4:8895 with SMTP id
 k22-20020a7bc416000000b003eef1a48895mr1552708wmi.24.1679649149840; 
 Fri, 24 Mar 2023 02:12:29 -0700 (PDT)
Received: from redhat.com ([2.52.12.190]) by smtp.gmail.com with ESMTPSA id
 n42-20020a05600c502a00b003edf2ae2432sm4377159wmr.7.2023.03.24.02.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 02:12:29 -0700 (PDT)
Date: Fri, 24 Mar 2023 05:12:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
Message-ID: <20230324051153-mutt-send-email-mst@kernel.org>
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xie Yongji <xieyongji@bytedance.com>, tglx@linutronix.de, hch@lst.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMDI6Mjc6NTJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCAxOjMx4oCvUE0gWGllIFlvbmdqaSA8eGlleW9u
Z2ppQGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+ID4KPiA+IFRvIHN1cHBvcnQgaW50ZXJydXB0IGFm
ZmluaXR5IHNwcmVhZGluZyBtZWNoYW5pc20sCj4gPiB0aGlzIG1ha2VzIHVzZSBvZiBncm91cF9j
cHVzX2V2ZW5seSgpIHRvIGNyZWF0ZQo+ID4gYW4gaXJxIGNhbGxiYWNrIGFmZmluaXR5IG1hc2sg
Zm9yIGVhY2ggdmlydHF1ZXVlCj4gPiBvZiB2ZHBhIGRldmljZS4gVGhlbiB3ZSB3aWxsIHVuaWZ5
IHNldF92cV9hZmZpbml0eQo+ID4gY2FsbGJhY2sgdG8gcGFzcyB0aGUgYWZmaW5pdHkgdG8gdGhl
IHZkcGEgZGV2aWNlIGRyaXZlci4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4
aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiAKPiBUaGlua2luZyBoYXJkIG9mIGFsbCB0aGUgbG9n
aWNzLCBJIHRoaW5rIEkndmUgZm91bmQgc29tZXRoaW5nIGludGVyZXN0aW5nLgo+IAo+IENvbW1p
dCBhZDcxNDczZDljNDM3ICgidmlydGlvX2JsazogdXNlIHZpcnRpbyBJUlEgYWZmaW5pdHkiKSB0
cmllcyB0bwo+IHBhc3MgaXJxX2FmZmluaXR5IHRvIHRyYW5zcG9ydCBzcGVjaWZpYyBmaW5kX3Zx
cygpLiAgVGhpcyBzZWVtcyBhCj4gbGF5ZXIgdmlvbGF0aW9uIHNpbmNlIGRyaXZlciBoYXMgbm8g
a25vd2xlZGdlIG9mCj4gCj4gMSkgd2hldGhlciBvciBub3QgdGhlIGNhbGxiYWNrIGlzIGJhc2Vk
IG9uIGFuIElSUQo+IDIpIHdoZXRoZXIgb3Igbm90IHRoZSBkZXZpY2UgaXMgYSBQQ0kgb3Igbm90
ICh0aGUgZGV0YWlscyBhcmUgaGlkZWQgYnkKPiB0aGUgdHJhbnNwb3J0IGRyaXZlcikKPiAzKSBo
b3cgbWFueSB2ZWN0b3JzIGNvdWxkIGJlIHVzZWQgYnkgYSBkZXZpY2UKPiAKPiBUaGlzIG1lYW5z
IHRoZSBkcml2ZXIgY2FuJ3QgYWN0dWFsbHkgcGFzcyBhIHJlYWwgYWZmaW5pdHkgbWFza3Mgc28g
dGhlCj4gY29tbWl0IHBhc3NlcyBhIHplcm8gaXJxIGFmZmluaXR5IHN0cnVjdHVyZSBhcyBhIGhp
bnQgaW4gZmFjdCwgc28gdGhlCj4gUENJIGxheWVyIGNhbiBidWlsZCBhIGRlZmF1bHQgYWZmaW5p
dHkgYmFzZWQgdGhhdCBncm91cHMgY3B1cyBldmVubHkKPiBiYXNlZCBvbiB0aGUgbnVtYmVyIG9m
IE1TSS1YIHZlY3RvcnMgKHRoZSBjb3JlIGxvZ2ljIGlzIHRoZQo+IGdyb3VwX2NwdXNfZXZlbmx5
KS4gSSB0aGluayB3ZSBzaG91bGQgZml4IHRoaXMgYnkgcmVwbGFjaW5nIHRoZQo+IGlycV9hZmZp
bml0eSBzdHJ1Y3R1cmUgd2l0aAo+IAo+IDEpIGEgYm9vbGVhbiBsaWtlIGF1dG9fY2Jfc3ByZWFk
aW5nCj4gCj4gb3IKPiAKPiAyKSBxdWV1ZSB0byBjcHUgbWFwcGluZwo+IAo+IFNvIGVhY2ggdHJh
bnNwb3J0IGNhbiBkbyBpdHMgb3duIGxvZ2ljIGJhc2VkIG9uIHRoYXQuIFRoZW4gdmlydGlvLXZE
UEEKPiBjYW4gcGFzcyB0aGF0IHBvbGljeSB0byBWRFVTRSB3aGVyZSB3ZSBvbmx5IG5lZWQgYSBn
cm91cF9jcHVzX2V2ZW5seSgpCj4gYW5kIGF2b2lkIGR1cGxpY2F0aW5nIGlycV9jcmVhdGVfYWZm
aW5pdHlfbWFza3MoKT8KPiAKPiBUaGFua3MKCkkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2hh
dCB5b3UgcHJvcG9zZS4gQ2FyZSB0byBwb3N0IGEgcGF0Y2g/CkFsc28gZG9lcyBpdCBoYXZlIHRv
IGJsb2NrIHRoaXMgcGF0Y2hzZXQgb3IgY2FuIGl0IGJlIGRvbmUgb24gdG9wPwoKPiA+IC0tLQo+
ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCA2OCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gaW5kZXggZjcyNjk2YjRjMWMyLi5mMzgyNmY0MmI3
MDQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiBAQCAtMTMsNiArMTMsNyBAQAo+ID4g
ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+
ID4gICNpbmNsdWRlIDxsaW51eC91dWlkLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2dyb3VwX2Nw
dXMuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvdmlydGlvLmg+Cj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3ZkcGEuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvdmlydGlvX2NvbmZpZy5oPgo+ID4gQEAgLTI3
Miw2ICsyNzMsNjYgQEAgc3RhdGljIHZvaWQgdmlydGlvX3ZkcGFfZGVsX3ZxcyhzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPiA+ICAgICAgICAgICAgICAgICB2aXJ0aW9fdmRwYV9kZWxfdnEo
dnEpOwo+ID4gIH0KPiA+Cj4gPiArc3RhdGljIHZvaWQgZGVmYXVsdF9jYWxjX3NldHMoc3RydWN0
IGlycV9hZmZpbml0eSAqYWZmZCwgdW5zaWduZWQgaW50IGFmZnZlY3MpCj4gPiArewo+ID4gKyAg
ICAgICBhZmZkLT5ucl9zZXRzID0gMTsKPiA+ICsgICAgICAgYWZmZC0+c2V0X3NpemVbMF0gPSBh
ZmZ2ZWNzOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgc3RydWN0IGNwdW1hc2sgKgo+ID4gK2Ny
ZWF0ZV9hZmZpbml0eV9tYXNrcyh1bnNpZ25lZCBpbnQgbnZlY3MsIHN0cnVjdCBpcnFfYWZmaW5p
dHkgKmFmZmQpCj4gPiArewo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgYWZmdmVjcyA9IDAsIGN1
cnZlYywgdXNlZHZlY3MsIGk7Cj4gPiArICAgICAgIHN0cnVjdCBjcHVtYXNrICptYXNrcyA9IE5V
TEw7Cj4gPiArCj4gPiArICAgICAgIGlmIChudmVjcyA+IGFmZmQtPnByZV92ZWN0b3JzICsgYWZm
ZC0+cG9zdF92ZWN0b3JzKQo+ID4gKyAgICAgICAgICAgICAgIGFmZnZlY3MgPSBudmVjcyAtIGFm
ZmQtPnByZV92ZWN0b3JzIC0gYWZmZC0+cG9zdF92ZWN0b3JzOwo+ID4gKwo+ID4gKyAgICAgICBp
ZiAoIWFmZmQtPmNhbGNfc2V0cykKPiA+ICsgICAgICAgICAgICAgICBhZmZkLT5jYWxjX3NldHMg
PSBkZWZhdWx0X2NhbGNfc2V0czsKPiA+ICsKPiA+ICsgICAgICAgYWZmZC0+Y2FsY19zZXRzKGFm
ZmQsIGFmZnZlY3MpOwo+ID4gKwo+ID4gKyAgICAgICBpZiAoIWFmZnZlY3MpCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIE5VTEw7Cj4gPiArCj4gPiArICAgICAgIG1hc2tzID0ga2NhbGxvYyhu
dmVjcywgc2l6ZW9mKCptYXNrcyksIEdGUF9LRVJORUwpOwo+ID4gKyAgICAgICBpZiAoIW1hc2tz
KQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ID4gKwo+ID4gKyAgICAgICAvKiBG
aWxsIG91dCB2ZWN0b3JzIGF0IHRoZSBiZWdpbm5pbmcgdGhhdCBkb24ndCBuZWVkIGFmZmluaXR5
ICovCj4gPiArICAgICAgIGZvciAoY3VydmVjID0gMDsgY3VydmVjIDwgYWZmZC0+cHJlX3ZlY3Rv
cnM7IGN1cnZlYysrKQo+ID4gKyAgICAgICAgICAgICAgIGNwdW1hc2tfc2V0YWxsKCZtYXNrc1tj
dXJ2ZWNdKTsKPiA+ICsKPiA+ICsgICAgICAgZm9yIChpID0gMCwgdXNlZHZlY3MgPSAwOyBpIDwg
YWZmZC0+bnJfc2V0czsgaSsrKSB7Cj4gPiArICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHRo
aXNfdmVjcyA9IGFmZmQtPnNldF9zaXplW2ldOwo+ID4gKyAgICAgICAgICAgICAgIGludCBqOwo+
ID4gKyAgICAgICAgICAgICAgIHN0cnVjdCBjcHVtYXNrICpyZXN1bHQgPSBncm91cF9jcHVzX2V2
ZW5seSh0aGlzX3ZlY3MpOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICAgIGlmICghcmVzdWx0KSB7
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShtYXNrcyk7Cj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPiA+ICsgICAgICAgICAgICAgICB9Cj4gPiArCj4g
PiArICAgICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IHRoaXNfdmVjczsgaisrKQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgY3B1bWFza19jb3B5KCZtYXNrc1tjdXJ2ZWMgKyBqXSwgJnJl
c3VsdFtqXSk7Cj4gPiArICAgICAgICAgICAgICAga2ZyZWUocmVzdWx0KTsKPiA+ICsKPiA+ICsg
ICAgICAgICAgICAgICBjdXJ2ZWMgKz0gdGhpc192ZWNzOwo+ID4gKyAgICAgICAgICAgICAgIHVz
ZWR2ZWNzICs9IHRoaXNfdmVjczsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gKyAgICAgICAvKiBG
aWxsIG91dCB2ZWN0b3JzIGF0IHRoZSBlbmQgdGhhdCBkb24ndCBuZWVkIGFmZmluaXR5ICovCj4g
PiArICAgICAgIGlmICh1c2VkdmVjcyA+PSBhZmZ2ZWNzKQo+ID4gKyAgICAgICAgICAgICAgIGN1
cnZlYyA9IGFmZmQtPnByZV92ZWN0b3JzICsgYWZmdmVjczsKPiA+ICsgICAgICAgZWxzZQo+ID4g
KyAgICAgICAgICAgICAgIGN1cnZlYyA9IGFmZmQtPnByZV92ZWN0b3JzICsgdXNlZHZlY3M7Cj4g
PiArICAgICAgIGZvciAoOyBjdXJ2ZWMgPCBudmVjczsgY3VydmVjKyspCj4gPiArICAgICAgICAg
ICAgICAgY3B1bWFza19zZXRhbGwoJm1hc2tzW2N1cnZlY10pOwo+ID4gKwo+ID4gKyAgICAgICBy
ZXR1cm4gbWFza3M7Cj4gPiArfQo+ID4gKwo+ID4gIHN0YXRpYyBpbnQgdmlydGlvX3ZkcGFfZmlu
ZF92cXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBudnFzLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cXNbXSwK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnFfY2FsbGJhY2tfdCAqY2FsbGJh
Y2tzW10sCj4gPiBAQCAtMjgyLDkgKzM0MywxNSBAQCBzdGF0aWMgaW50IHZpcnRpb192ZHBhX2Zp
bmRfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgbnZxcywKPiA+
ICAgICAgICAgc3RydWN0IHZpcnRpb192ZHBhX2RldmljZSAqdmRfZGV2ID0gdG9fdmlydGlvX3Zk
cGFfZGV2aWNlKHZkZXYpOwo+ID4gICAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2
ZF9nZXRfdmRwYSh2ZGV2KTsKPiA+ICAgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29w
cyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ID4gKyAgICAgICBzdHJ1Y3QgaXJxX2FmZmluaXR5IGRl
ZmF1bHRfYWZmZCA9IHsgMCB9Owo+ID4gKyAgICAgICBzdHJ1Y3QgY3B1bWFzayAqbWFza3M7Cj4g
PiAgICAgICAgIHN0cnVjdCB2ZHBhX2NhbGxiYWNrIGNiOwo+ID4gICAgICAgICBpbnQgaSwgZXJy
LCBxdWV1ZV9pZHggPSAwOwo+ID4KPiA+ICsgICAgICAgbWFza3MgPSBjcmVhdGVfYWZmaW5pdHlf
bWFza3MobnZxcywgZGVzYyA/IGRlc2MgOiAmZGVmYXVsdF9hZmZkKTsKPiA+ICsgICAgICAgaWYg
KCFtYXNrcykKPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiA+ICsKPiA+ICAg
ICAgICAgZm9yIChpID0gMDsgaSA8IG52cXM7ICsraSkgewo+ID4gICAgICAgICAgICAgICAgIGlm
ICghbmFtZXNbaV0pIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHZxc1tpXSA9IE5VTEw7
Cj4gPiBAQCAtMjk4LDYgKzM2NSw3IEBAIHN0YXRpYyBpbnQgdmlydGlvX3ZkcGFfZmluZF92cXMo
c3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBudnFzLAo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgZXJyID0gUFRSX0VSUih2cXNbaV0pOwo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBlcnJfc2V0dXBfdnE7Cj4gPiAgICAgICAgICAgICAgICAgfQo+ID4g
KyAgICAgICAgICAgICAgIG9wcy0+c2V0X3ZxX2FmZmluaXR5KHZkcGEsIGksICZtYXNrc1tpXSk7
Cj4gPiAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgIGNiLmNhbGxiYWNrID0gdmlydGlvX3ZkcGFf
Y29uZmlnX2NiOwo+ID4gLS0KPiA+IDIuMjAuMQo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
