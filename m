Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D97C7618D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 07:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4074E819F5;
	Tue,  4 Apr 2023 07:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4074E819F5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a625BTxi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZtYCufAoqb4F; Tue,  4 Apr 2023 07:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B6C59819ED;
	Tue,  4 Apr 2023 07:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6C59819ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91F36C0036;
	Tue,  4 Apr 2023 07:05:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2031C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C4AA4037C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C4AA4037C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a625BTxi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jFx2Ags0uFei
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6BFA40129
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6BFA40129
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680591951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbEFZeUWw7TWBolJqCKE2aBXeVBn4ZeUp2elECINKbc=;
 b=a625BTxitr+zXPte9jy0/H4A1fAdIq/mPE1bHDsTgn8H0ej8wDpSKYuYv6BtU/3Y3zb/xR
 bDzcONYPXS/4dURx+IdrXgmZf34I/E9qpNoJBZOlWFwhOZRg09C3ZCWH1bgeNOir0j2GPW
 n3Gr7BZqpRU8KMsuNNPrWZDnizgnxcg=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-hVRNCKCNMRWP5Eg_jryTFw-1; Tue, 04 Apr 2023 03:05:50 -0400
X-MC-Unique: hVRNCKCNMRWP5Eg_jryTFw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-17a678c2de9so16752339fac.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 00:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680591949; x=1683183949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbEFZeUWw7TWBolJqCKE2aBXeVBn4ZeUp2elECINKbc=;
 b=MFs9Wt1BN4QgrE/t0ajxTgFW0501P/5Bpy2j32XChKqXCSJjEmuAXDcBHGvZI/cZwb
 e7BnxZeqHeuBuq7HVrQ3dFxQZg/4qGOm9fC1zCpNvqpTYncDQW7D76PptwUfdW0wYWPO
 lUJOZdseHMlLNt9KGnE8MHfveHxoWaHx0Miq3knS+hNPE022ryfWpQqmqj5DYP9H8HS8
 6cToxoKWvjdGuMmrjDLeW8HI8UknNP90KIg7fJd4RFxmNoSHDsV4D/rQ7alzWtbS27mp
 MSGs7xy29Cup9bXcsePYu04Jn7il/X9id6RtsCk2KZNYmrN0TF6zIGRk0quY/AP5XxFb
 HH8A==
X-Gm-Message-State: AAQBX9eYLu6/I/2gxGDeW1/klye/fLGzVTVL7PZLHXm65zIadmdV6Bvr
 s3sw08Pcu/WvyljngE+ny2sKCTTmF63FsqtNGZ1Wmo/vvdAT7DmiETIaWJb3+n3eFn/KGfuYpom
 EszX9raBI7Z+myQPIo+tmEq2ITYVoIt7moZpqEyON5yw4aSnax60smkXemA==
X-Received: by 2002:a05:6870:88a4:b0:17e:255e:b1 with SMTP id
 m36-20020a05687088a400b0017e255e00b1mr845891oam.9.1680591949746; 
 Tue, 04 Apr 2023 00:05:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350bc29kvu9WWqXG26ab5DezEJs5HLj1sfuRS8TyrPlaUu5YmYYdFHxvXrQx9+f431uKUXP7RYmenzO867X5ceNE=
X-Received: by 2002:a05:6870:88a4:b0:17e:255e:b1 with SMTP id
 m36-20020a05687088a400b0017e255e00b1mr845884oam.9.1680591949546; Tue, 04 Apr
 2023 00:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-3-michael.christie@oracle.com>
In-Reply-To: <20230328021717.42268-3-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 15:05:38 +0800
Message-ID: <CACGkMEsMhfZJ1sWfn38O+0ncGruOvGxeEw8aNQxnEAewmP0fWQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] vhost,
 vhost-net: add helper to check if vq has work
To: Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTA6MTfigK9BTSBNaWtlIENocmlzdGllCjxtaWNoYWVs
LmNocmlzdGllQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gSW4gdGhlIG5leHQgcGF0Y2hlcyBlYWNo
IHZxIG1pZ2h0IGhhdmUgZGlmZmVyZW50IHdvcmtlcnMgc28gb25lIGNvdWxkCj4gaGF2ZSB3b3Jr
IGJ1dCBvdGhlcnMgZG8gbm90LiBGb3IgbmV0LCB3ZSBvbmx5IHdhbnQgdG8gY2hlY2sgc3BlY2lm
aWMgdnFzLAo+IHNvIHRoaXMgYWRkcyBhIGhlbHBlciB0byBjaGVjayBpZiBhIHZxIGhhcyB3b3Jr
IHBlbmRpbmcgYW5kIGNvbnZlcnRzCj4gdmhvc3QtbmV0IHRvIHVzZSBpdC4KPgo+IFNpZ25lZC1v
ZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNvbT4KCkFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBk
cml2ZXJzL3Zob3N0L25ldC5jICAgfCAyICstCj4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDYg
KysrLS0tCj4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8IDIgKy0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aG9zdC9uZXQuYyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiBpbmRleCAwNzE4MWNkOGQ1MmUu
LjhlZDYzNjUxYjllYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L25ldC5jCj4gKysrIGIv
ZHJpdmVycy92aG9zdC9uZXQuYwo+IEBAIC01NDYsNyArNTQ2LDcgQEAgc3RhdGljIHZvaWQgdmhv
c3RfbmV0X2J1c3lfcG9sbChzdHJ1Y3Qgdmhvc3RfbmV0ICpuZXQsCj4gICAgICAgICBlbmR0aW1l
ID0gYnVzeV9jbG9jaygpICsgYnVzeWxvb3BfdGltZW91dDsKPgo+ICAgICAgICAgd2hpbGUgKHZo
b3N0X2Nhbl9idXN5X3BvbGwoZW5kdGltZSkpIHsKPiAtICAgICAgICAgICAgICAgaWYgKHZob3N0
X2hhc193b3JrKCZuZXQtPmRldikpIHsKPiArICAgICAgICAgICAgICAgaWYgKHZob3N0X3ZxX2hh
c193b3JrKHZxKSkgewo+ICAgICAgICAgICAgICAgICAgICAgICAgICpidXN5bG9vcF9pbnRyID0g
dHJ1ZTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgICAgICAgICAg
fQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zo
b3N0LmMKPiBpbmRleCBlMDQxZTExNmFmZWUuLjY1NjdhZWQ2OWViYiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBAQCAt
MjYyLDExICsyNjIsMTEgQEAgdm9pZCB2aG9zdF93b3JrX3F1ZXVlKHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwgc3RydWN0IHZob3N0X3dvcmsgKndvcmspCj4gIEVYUE9SVF9TWU1CT0xfR1BMKHZob3N0
X3dvcmtfcXVldWUpOwo+Cj4gIC8qIEEgbG9ja2xlc3MgaGludCBmb3IgYnVzeSBwb2xsaW5nIGNv
ZGUgdG8gZXhpdCB0aGUgbG9vcCAqLwo+IC1ib29sIHZob3N0X2hhc193b3JrKHN0cnVjdCB2aG9z
dF9kZXYgKmRldikKPiArYm9vbCB2aG9zdF92cV9oYXNfd29yayhzdHJ1Y3Qgdmhvc3RfdmlydHF1
ZXVlICp2cSkKPiAgewo+IC0gICAgICAgcmV0dXJuIGRldi0+d29ya2VyICYmICFsbGlzdF9lbXB0
eSgmZGV2LT53b3JrZXItPndvcmtfbGlzdCk7Cj4gKyAgICAgICByZXR1cm4gdnEtPndvcmtlciAm
JiAhbGxpc3RfZW1wdHkoJnZxLT53b3JrZXItPndvcmtfbGlzdCk7Cj4gIH0KPiAtRVhQT1JUX1NZ
TUJPTF9HUEwodmhvc3RfaGFzX3dvcmspOwo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2aG9zdF92cV9o
YXNfd29yayk7Cj4KPiAgdm9pZCB2aG9zdF9wb2xsX3F1ZXVlKHN0cnVjdCB2aG9zdF9wb2xsICpw
b2xsKQo+ICB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaCBiL2RyaXZlcnMv
dmhvc3Qvdmhvc3QuaAo+IGluZGV4IGU3MmI2NjViYTNhNS4uMGRkZTExOWZiMGVlIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3Qu
aAo+IEBAIC00NSw3ICs0NSw2IEBAIHN0cnVjdCB2aG9zdF9wb2xsIHsKPgo+ICB2b2lkIHZob3N0
X3dvcmtfaW5pdChzdHJ1Y3Qgdmhvc3Rfd29yayAqd29yaywgdmhvc3Rfd29ya19mbl90IGZuKTsK
PiAgdm9pZCB2aG9zdF93b3JrX3F1ZXVlKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgc3RydWN0IHZo
b3N0X3dvcmsgKndvcmspOwo+IC1ib29sIHZob3N0X2hhc193b3JrKHN0cnVjdCB2aG9zdF9kZXYg
KmRldik7Cj4KPiAgdm9pZCB2aG9zdF9wb2xsX2luaXQoc3RydWN0IHZob3N0X3BvbGwgKnBvbGws
IHZob3N0X3dvcmtfZm5fdCBmbiwKPiAgICAgICAgICAgICAgICAgICAgICBfX3BvbGxfdCBtYXNr
LCBzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpOwo+IEBAIC0xOTUsNiArMTk0LDcgQEAgaW50IHZob3N0
X2dldF92cV9kZXNjKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKiwKPiAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZob3N0X2xvZyAqbG9nLCB1bnNpZ25lZCBpbnQgKmxvZ19udW0pOwo+ICB2
b2lkIHZob3N0X2Rpc2NhcmRfdnFfZGVzYyhzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICosIGludCBu
KTsKPgo+ICtib29sIHZob3N0X3ZxX2hhc193b3JrKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZx
KTsKPiAgYm9vbCB2aG9zdF92cV9pc19zZXR1cChzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSk7
Cj4gIGludCB2aG9zdF92cV9pbml0X2FjY2VzcyhzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICopOwo+
ICBpbnQgdmhvc3RfYWRkX3VzZWQoc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqLCB1bnNpZ25lZCBp
bnQgaGVhZCwgaW50IGxlbik7Cj4gLS0KPiAyLjI1LjEKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
