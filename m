Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E5C77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 03:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F9BC400EF;
	Mon, 15 May 2023 03:51:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F9BC400EF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XH0/cDku
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IT7jnOaRsaQA; Mon, 15 May 2023 03:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F4BD4013D;
	Mon, 15 May 2023 03:51:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F4BD4013D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF782C0037;
	Mon, 15 May 2023 03:51:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15957C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 03:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E530383D19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 03:50:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E530383D19
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XH0/cDku
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NWeC58hBzZqK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 03:50:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2511C83D15
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2511C83D15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 03:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684122658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ug4lOczkCVIqRxzALymxlBcZQCDDkaOfinDuNkIF8Bg=;
 b=XH0/cDkuVSox5vqtm77Rbb/EFA3YWt9sWzZtFN/mh7ZVWfV+v3Usr/7myA9pYbxnDCNdgf
 ew3r6lJ3sK2E46dzTRTTD+0zTkrbRn+kTDUvndBwCGtLyfMHbg34X2W9QDHiVrEiBjm1SV
 wTNuS2EVHAjR9Q6Ere3Ii1+5r+rqaRY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-oAxVIIbMPZqnoUb8OhYrmw-1; Sun, 14 May 2023 23:50:56 -0400
X-MC-Unique: oAxVIIbMPZqnoUb8OhYrmw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ac7cefaa9dso58679781fa.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 20:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684122655; x=1686714655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ug4lOczkCVIqRxzALymxlBcZQCDDkaOfinDuNkIF8Bg=;
 b=Zbh+r5BuqE9rORu0IoHAoJvCNPsNl1UhFSW329AMFd+y7xzMClzC0+VdAFarKJWuL0
 3YMYCSwLGOgCvvRhhOE3Esqs3DsqgvIPFyVf/xf+p+rDkzceyE+1upZhs78FtJ8lX0lw
 XhyBUI11iNBvrUGnjkx2V7pwE1HjMrZIVkD5AU4zQCvPZqzPuw/cLHjtL8RB3kkOJQKZ
 SmadRC4/0hfeJooVwXqiURdTFX0Ae2GUEqae3lrP2vY65quob3ilIA1qEpBN1DoOtzau
 HjF/tbyhOG70xN6MSbI12ghcC/8K7wsIOxF/KbtmAkhFEk0mktRwUBCrabUpsmK3rosU
 UphQ==
X-Gm-Message-State: AC+VfDwLhYLBsej8ViOVhR7uw3zv/7+VJ0fpbfvPpzrzFy+Q1fFR0W0K
 iK6rGGODjoSzCJKfzd4FSWMPj043V5TIHrCkBx+AKs1GTPFN8H5n3IRy80tuFPIfnOqJomkIwPv
 iRMfLYFANjiAsx5ecJOhgNve+Gs9ANrBXTEnIUstw1/SdTLcN+jus4KNP3g==
X-Received: by 2002:a2e:984e:0:b0:298:ad8e:e65 with SMTP id
 e14-20020a2e984e000000b00298ad8e0e65mr6982125ljj.21.1684122655288; 
 Sun, 14 May 2023 20:50:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6O/xEgaCMEOq33lgXSdrKWYLGsR3UXF2SvNMhY54xBDhrM4Eis+wInccl5RJLEz0xoou22llWe2dqCNpmkfTQ=
X-Received: by 2002:a2e:984e:0:b0:298:ad8e:e65 with SMTP id
 e14-20020a2e984e000000b00298ad8e0e65mr6982120ljj.21.1684122655078; Sun, 14
 May 2023 20:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-8-shannon.nelson@amd.com>
In-Reply-To: <20230503181240.14009-8-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 May 2023 11:50:44 +0800
Message-ID: <CACGkMEv_sz4-XVH3-QNZZ+xQCZaQK_pzOcFqHS4si38fifVbpg@mail.gmail.com>
Subject: Re: [PATCH v5 virtio 07/11] pds_vdpa: virtio bar setup for vdpa
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, simon.horman@corigine.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 drivers@pensando.io
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

T24gVGh1LCBNYXkgNCwgMjAyMyBhdCAyOjEz4oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+IHdyb3RlOgo+Cj4gUHJlcCBhbmQgdXNlIHRoZSAibW9kZXJuIiB2aXJ0
aW8gYmFyIHV0aWxpdGllcyB0byBnZXQgb3VyCj4gdmlydGlvIGNvbmZpZyBzcGFjZSByZWFkeS4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29t
PgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4g
LS0tCj4gIGRyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5jIHwgMjUgKysrKysrKysrKysrKysrKysr
KysrKysrKwo+ICBkcml2ZXJzL3ZkcGEvcGRzL2F1eF9kcnYuaCB8ICAzICsrKwo+ICAyIGZpbGVz
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
cGRzL2F1eF9kcnYuYyBiL2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5jCj4gaW5kZXggYWE3NDhj
ZjU1ZDJiLi4wYzRhMTM1YjE0ODQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3Bkcy9hdXhf
ZHJ2LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvcGRzL2F1eF9kcnYuYwo+IEBAIC00LDYgKzQsNyBA
QAo+ICAjaW5jbHVkZSA8bGludXgvYXV4aWxpYXJ5X2J1cy5oPgo+ICAjaW5jbHVkZSA8bGludXgv
cGNpLmg+Cj4gICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0
aW9fcGNpX21vZGVybi5oPgo+Cj4gICNpbmNsdWRlIDxsaW51eC9wZHMvcGRzX2NvbW1vbi5oPgo+
ICAjaW5jbHVkZSA8bGludXgvcGRzL3Bkc19jb3JlX2lmLmg+Cj4gQEAgLTE5LDEyICsyMCwyMiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGF1eGlsaWFyeV9kZXZpY2VfaWQgcGRzX3ZkcGFfaWRfdGFi
bGVbXSA9IHsKPiAgICAgICAgIHt9LAo+ICB9Owo+Cj4gK3N0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2
aWNlX2lkX2NoZWNrKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ICt7Cj4gKyAgICAgICBpZiAocGRl
di0+ZGV2aWNlICE9IFBDSV9ERVZJQ0VfSURfUEVOU0FORE9fVkRQQV9WRiB8fAo+ICsgICAgICAg
ICAgIHBkZXYtPnZlbmRvciAhPSBQQ0lfVkVORE9SX0lEX1BFTlNBTkRPKQo+ICsgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT0RFVjsKPiArCj4gKyAgICAgICByZXR1cm4gUENJX0RFVklDRV9JRF9Q
RU5TQU5ET19WRFBBX1ZGOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IHBkc192ZHBhX3Byb2JlKHN0
cnVjdCBhdXhpbGlhcnlfZGV2aWNlICphdXhfZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3Qgc3RydWN0IGF1eGlsaWFyeV9kZXZpY2VfaWQgKmlkKQo+Cj4gIHsKPiAgICAgICAg
IHN0cnVjdCBwZHNfYXV4aWxpYXJ5X2RldiAqcGFkZXYgPQo+ICAgICAgICAgICAgICAgICBjb250
YWluZXJfb2YoYXV4X2Rldiwgc3RydWN0IHBkc19hdXhpbGlhcnlfZGV2LCBhdXhfZGV2KTsKPiAr
ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZhdXhfZGV2LT5kZXY7Cj4gICAgICAgICBzdHJ1
Y3QgcGRzX3ZkcGFfYXV4ICp2ZHBhX2F1eDsKPiAgICAgICAgIGludCBlcnI7Cj4KPiBAQCAtNDEs
OCArNTIsMjEgQEAgc3RhdGljIGludCBwZHNfdmRwYV9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2Rl
dmljZSAqYXV4X2RldiwKPiAgICAgICAgIGlmIChlcnIpCj4gICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX2ZyZWVfbWVtOwo+Cj4gKyAgICAgICAvKiBGaW5kIHRoZSB2aXJ0aW8gY29uZmlndXJhdGlv
biAqLwo+ICsgICAgICAgdmRwYV9hdXgtPnZkX21kZXYucGNpX2RldiA9IHBhZGV2LT52Zl9wZGV2
Owo+ICsgICAgICAgdmRwYV9hdXgtPnZkX21kZXYuZGV2aWNlX2lkX2NoZWNrID0gcGRzX3ZkcGFf
ZGV2aWNlX2lkX2NoZWNrOwo+ICsgICAgICAgdmRwYV9hdXgtPnZkX21kZXYuZG1hX21hc2sgPSBE
TUFfQklUX01BU0soUERTX0NPUkVfQUREUl9MRU4pOwo+ICsgICAgICAgZXJyID0gdnBfbW9kZXJu
X3Byb2JlKCZ2ZHBhX2F1eC0+dmRfbWRldik7Cj4gKyAgICAgICBpZiAoZXJyKSB7Cj4gKyAgICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LCAiVW5hYmxlIHRvIHByb2JlIGZvciB2aXJ0aW8gY29uZmln
dXJhdGlvbjogJXBlXG4iLAo+ICsgICAgICAgICAgICAgICAgICAgICAgIEVSUl9QVFIoZXJyKSk7
Cj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfbWdtdF9pbmZvOwo+ICsgICAgICAgfQo+
ICsKPiAgICAgICAgIHJldHVybiAwOwo+Cj4gK2Vycl9mcmVlX21nbXRfaW5mbzoKPiArICAgICAg
IHBjaV9mcmVlX2lycV92ZWN0b3JzKHBhZGV2LT52Zl9wZGV2KTsKPiAgZXJyX2ZyZWVfbWVtOgo+
ICAgICAgICAga2ZyZWUodmRwYV9hdXgpOwo+ICAgICAgICAgYXV4aWxpYXJ5X3NldF9kcnZkYXRh
KGF1eF9kZXYsIE5VTEwpOwo+IEBAIC01NSw2ICs3OSw3IEBAIHN0YXRpYyB2b2lkIHBkc192ZHBh
X3JlbW92ZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYXV4X2RldikKPiAgICAgICAgIHN0cnVj
dCBwZHNfdmRwYV9hdXggKnZkcGFfYXV4ID0gYXV4aWxpYXJ5X2dldF9kcnZkYXRhKGF1eF9kZXYp
Owo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJmF1eF9kZXYtPmRldjsKPgo+ICsgICAg
ICAgdnBfbW9kZXJuX3JlbW92ZSgmdmRwYV9hdXgtPnZkX21kZXYpOwo+ICAgICAgICAgcGNpX2Zy
ZWVfaXJxX3ZlY3RvcnModmRwYV9hdXgtPnBhZGV2LT52Zl9wZGV2KTsKPgo+ICAgICAgICAga2Zy
ZWUodmRwYV9hdXgpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL2F1eF9kcnYuaCBi
L2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5oCj4gaW5kZXggZGNlYzc4MmU3OWViLi45OWUwZmYz
NDBiZmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmgKPiArKysgYi9k
cml2ZXJzL3ZkcGEvcGRzL2F1eF9kcnYuaAo+IEBAIC00LDYgKzQsOCBAQAo+ICAjaWZuZGVmIF9B
VVhfRFJWX0hfCj4gICNkZWZpbmUgX0FVWF9EUlZfSF8KPgo+ICsjaW5jbHVkZSA8bGludXgvdmly
dGlvX3BjaV9tb2Rlcm4uaD4KPiArCj4gICNkZWZpbmUgUERTX1ZEUEFfRFJWX0RFU0NSSVBUSU9O
ICAgICJBTUQvUGVuc2FuZG8gdkRQQSBWRiBEZXZpY2UgRHJpdmVyIgo+ICAjZGVmaW5lIFBEU19W
RFBBX0RSVl9OQU1FICAgICAgICAgICBLQlVJTERfTU9ETkFNRQo+Cj4gQEAgLTE2LDYgKzE4LDcg
QEAgc3RydWN0IHBkc192ZHBhX2F1eCB7Cj4KPiAgICAgICAgIGludCB2Zl9pZDsKPiAgICAgICAg
IHN0cnVjdCBkZW50cnkgKmRlbnRyeTsKPiArICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVy
bl9kZXZpY2UgdmRfbWRldjsKPgo+ICAgICAgICAgaW50IG5pbnRyczsKPiAgfTsKPiAtLQo+IDIu
MTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
