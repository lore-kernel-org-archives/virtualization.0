Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715C0C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 07:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 091FC6101B;
	Tue,  4 Apr 2023 07:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 091FC6101B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aK7OEXmo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHk61nZzF6zq; Tue,  4 Apr 2023 07:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AC1761008;
	Tue,  4 Apr 2023 07:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AC1761008
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66678C0036;
	Tue,  4 Apr 2023 07:09:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1282CC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E105C40476
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E105C40476
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aK7OEXmo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sudh-5p9xkcw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B8C44037C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B8C44037C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680592144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZCn8PVteVOUwvxMXzTbJHfx4cmLwcUSMwZEJuiZLik=;
 b=aK7OEXmo3OnEC5Y9F41xI+ICSnJCrLftyLLapOFYN07nU8o2H2UycEH0m2dotrHcS3CnFR
 N4xy4bG8bUT5+73HTOtdn7ihpD98CCq7ImxGhfLONeDPwQk7ztFhusm2Wwg6zix+GqD9sC
 +W8ZtGIk8fkgfwLOCZv55WyWRpOq05c=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-j73o9CLCNiaHhF9P1IfSOA-1; Tue, 04 Apr 2023 03:09:02 -0400
X-MC-Unique: j73o9CLCNiaHhF9P1IfSOA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-17e7104c589so16922851fac.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 00:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680592142; x=1683184142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZCn8PVteVOUwvxMXzTbJHfx4cmLwcUSMwZEJuiZLik=;
 b=aqsuKOEcg5cJtMDE//KGdzuJDDZ4wjLy0Hj19Gw+Yc5mc0eamTpqVa/AV9oDHTWpIE
 FQWkTOo+JXB11Sg67w0DD0sGaFe8dC+v1wFJvGn3HCY2VtXJH+QhXLXEHzjSxwH944km
 Rs26VRyecL+XUBKBxzsdI5ItZewCJP143ytPW7K6SZK7Cu+3I4uhdbrAbWQgmKA2FCTq
 Tg9mzBppvHh+fIdluepjHEULc2iYBZSBHrEoxg+ebbPvgzrrRwEb3afEJLASNxTUCs2V
 rsBESNyGNM/0SD2o1N6VqJdTKNu2ayzSc66er2cWlTuvMdmLicIWtG4DJkVoBCWbwTX0
 vtNw==
X-Gm-Message-State: AAQBX9fpMB8ylAOVBg4nnYYGVX7RSS6Rgyf/A0NzYg2VqIbyamtSrrWG
 M6et70BOXeLw9JI5zsTg4G0ad51qHrI7KgZL6ang6DpY0whYJg67WJi9UV6Fo51ATdmZ8oJnTYm
 wAig5eaXjR86C8hLlfU+sRpFn1WaJwMNvXdBsQMrL617z716lI2QhDb8PwA==
X-Received: by 2002:a05:6870:88a4:b0:17e:255e:b1 with SMTP id
 m36-20020a05687088a400b0017e255e00b1mr848735oam.9.1680592142057; 
 Tue, 04 Apr 2023 00:09:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350aq2EZAinKDe5bud4FMcFaofiSBs+LTM3HEuCwv1fUaBaKg084A3NY2CDgBfhuTJ9aOKcofqnB+g9y8aOl5qYo=
X-Received: by 2002:a05:6870:88a4:b0:17e:255e:b1 with SMTP id
 m36-20020a05687088a400b0017e255e00b1mr848730oam.9.1680592141880; Tue, 04 Apr
 2023 00:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-5-michael.christie@oracle.com>
In-Reply-To: <20230328021717.42268-5-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 15:08:50 +0800
Message-ID: <CACGkMEu5bQHvKj3GEHuqx7Nd1rCq9nWSjj3Tcm422K0r=WjfgA@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] vhost: take worker or vq instead of dev for
 flushing
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
LmNocmlzdGllQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBoYXMgdGhlIGNvcmUg
d29yayBmbHVzaCBmdW5jdGlvbiB0YWtlIGEgd29ya2VyLiBXaGVuIHdlCj4gc3VwcG9ydCBtdWx0
aXBsZSB3b3JrZXJzIHdlIGNhbiB0aGVuIGZsdXNoIGVhY2ggd29ya2VyIGR1cmluZyBkZXZpY2UK
PiByZW1vdmFsLCBzdG9wcGFnZSwgZXRjLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWlrZSBDaHJpc3Rp
ZSA8bWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmhvc3Qvdmhvc3Qu
YyB8IDI0ICsrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0
L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCBjYzI2MjhiYTlhNzcuLjYx
NjBhYTFjYzkyMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9k
cml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBAQCAtMjQ3LDYgKzI0NywyMCBAQCBzdGF0aWMgdm9pZCB2
aG9zdF93b3JrX3F1ZXVlX29uKHN0cnVjdCB2aG9zdF93b3JrZXIgKndvcmtlciwKPiAgICAgICAg
IH0KPiAgfQo+Cj4gK3N0YXRpYyB2b2lkIHZob3N0X3dvcmtfZmx1c2hfb24oc3RydWN0IHZob3N0
X3dvcmtlciAqd29ya2VyKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3Qgdmhvc3RfZmx1c2hfc3RydWN0
IGZsdXNoOwo+ICsKPiArICAgICAgIGlmICghd29ya2VyKQo+ICsgICAgICAgICAgICAgICByZXR1
cm47Cj4gKwo+ICsgICAgICAgaW5pdF9jb21wbGV0aW9uKCZmbHVzaC53YWl0X2V2ZW50KTsKPiAr
ICAgICAgIHZob3N0X3dvcmtfaW5pdCgmZmx1c2gud29yaywgdmhvc3RfZmx1c2hfd29yayk7Cj4g
Kwo+ICsgICAgICAgdmhvc3Rfd29ya19xdWV1ZV9vbih3b3JrZXIsICZmbHVzaC53b3JrKTsKPiAr
ICAgICAgIHdhaXRfZm9yX2NvbXBsZXRpb24oJmZsdXNoLndhaXRfZXZlbnQpOwo+ICt9Cj4gKwo+
ICB2b2lkIHZob3N0X3dvcmtfcXVldWUoc3RydWN0IHZob3N0X2RldiAqZGV2LCBzdHJ1Y3Qgdmhv
c3Rfd29yayAqd29yaykKPiAgewo+ICAgICAgICAgdmhvc3Rfd29ya19xdWV1ZV9vbihkZXYtPndv
cmtlciwgd29yayk7Cj4gQEAgLTI2MSwxNSArMjc1LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwodmhv
c3RfdnFfd29ya19xdWV1ZSk7Cj4KPiAgdm9pZCB2aG9zdF9kZXZfZmx1c2goc3RydWN0IHZob3N0
X2RldiAqZGV2KQo+ICB7Cj4gLSAgICAgICBzdHJ1Y3Qgdmhvc3RfZmx1c2hfc3RydWN0IGZsdXNo
Owo+IC0KPiAtICAgICAgIGlmIChkZXYtPndvcmtlcikgewo+IC0gICAgICAgICAgICAgICBpbml0
X2NvbXBsZXRpb24oJmZsdXNoLndhaXRfZXZlbnQpOwo+IC0gICAgICAgICAgICAgICB2aG9zdF93
b3JrX2luaXQoJmZsdXNoLndvcmssIHZob3N0X2ZsdXNoX3dvcmspOwo+IC0KPiAtICAgICAgICAg
ICAgICAgdmhvc3Rfd29ya19xdWV1ZShkZXYsICZmbHVzaC53b3JrKTsKPiAtICAgICAgICAgICAg
ICAgd2FpdF9mb3JfY29tcGxldGlvbigmZmx1c2gud2FpdF9ldmVudCk7Cj4gLSAgICAgICB9Cj4g
KyAgICAgICB2aG9zdF93b3JrX2ZsdXNoX29uKGRldi0+d29ya2VyKTsKPiAgfQo+ICBFWFBPUlRf
U1lNQk9MX0dQTCh2aG9zdF9kZXZfZmx1c2gpOwo+Cj4gLS0KPiAyLjI1LjEKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
