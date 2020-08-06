Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F2BC433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA1E22CF7
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B042Axnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA1E22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6A4C881D9;
	Thu,  6 Aug 2020 05:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9EY8rmbOFXG; Thu,  6 Aug 2020 05:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DBE92881BC;
	Thu,  6 Aug 2020 05:55:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A3CC0050;
	Thu,  6 Aug 2020 05:55:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86C11C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 75895881D9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g7HY477qD4RE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6F3EE881BC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596693353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv95cTkdzqIZ8eUeXOL4xgSOD8IhzvwipbFF4KLUn3o=;
 b=B042AxnumN3Aaupv53ldh3dpth2vvHopyZbLQ8ArflF7SJH89bD0zEv7drHs7FOpW3IsB/
 fGoRO6nJ4wBcFW3xVsm8u8tjEcDaM2YixlrrqOjtKzcAUscpy/VXvfHdz3Uqcm6cGD/i1R
 66ZHlZuWHYS+CFbkblMe/XSs681+hmk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-F9xREKvFOgK-UiuCZFypPg-1; Thu, 06 Aug 2020 01:55:51 -0400
X-MC-Unique: F9xREKvFOgK-UiuCZFypPg-1
Received: by mail-wm1-f72.google.com with SMTP id u144so3672248wmu.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 22:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vv95cTkdzqIZ8eUeXOL4xgSOD8IhzvwipbFF4KLUn3o=;
 b=YAG8pHkSdQPHal6SKJYgTBwLygwL0UChWRQ8HBRNqPOols7XqMPtqWXltSrrQcU30f
 +m5zHVe1DwrtwOeqS1g3JI4Y+9c/I7CTGzlnkJ3HLeHJAZBIl5AxuPtT7OD3Dp39Xw3O
 0Q/Rj84IPoR6FY/Ew6SjkcaW8eg0Hp86IyvzKl9Hd/lpKy6X1uDPaEmUMP5k8L3q9fUd
 3UZMPatD67FXVzpjPhoY0ElOZkzJ8QOAPESrX63OZYo2PTAFfsOx5VDBKHCiAh9W9/iM
 0sRsreNXZRPytbn5kGVE0e/sc451HQ0vAkNAoGhI9rVYBbbBvtrCsesE74mfMNzg6i8Q
 VO1g==
X-Gm-Message-State: AOAM530tvAwGqSyW79FZD7RQJCUqYBbWhPvmZ13PqBCOfKlJgwjzTolP
 dgH0INBmJ7itfvinrxBlEhux8+l3P4p9XpeVXII7w6aeaxwBOn8dJ59oKxPT37nmfbXoLkLsSQK
 J3SL66UxU/ijdNoPTgUVGxMqTwqf8TW5p4vdXYPT+4w==
X-Received: by 2002:a1c:2646:: with SMTP id m67mr6675526wmm.137.1596693350422; 
 Wed, 05 Aug 2020 22:55:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx08gE4aA+Do8IVciL8GUnVeLcSzewgPqTloEUDa1j+r/zSmJ0raKbrtSORsged7mQQ8WpiLw==
X-Received: by 2002:a1c:2646:: with SMTP id m67mr6675504wmm.137.1596693350147; 
 Wed, 05 Aug 2020 22:55:50 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id k184sm5157635wme.1.2020.08.05.22.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 22:55:49 -0700 (PDT)
Date: Thu, 6 Aug 2020 01:55:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4/4] vhost: vdpa: report iova range
Message-ID: <20200806015513-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-5-jasowang@redhat.com>
 <20200805085635-mutt-send-email-mst@kernel.org>
 <357f681b-fdee-cc04-3cf3-04035c555893@redhat.com>
MIME-Version: 1.0
In-Reply-To: <357f681b-fdee-cc04-3cf3-04035c555893@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

T24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMTE6Mjk6MTZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNSDkuIvljYg4OjU4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBXZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0N0FNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgaW9jdGwgZm9yIHZob3N0
LXZkcGEgZGV2aWNlIHRoYXQgY2FuCj4gPiA+IHJlcG9ydCB0aGUgaW92YSByYW5nZSBieSB0aGUg
ZGV2aWNlLiBGb3IgZGV2aWNlIHRoYXQgZGVwZW5kcyBvbgo+ID4gPiBwbGF0Zm9ybSBJT01NVSwg
d2UgZmV0Y2ggdGhlIGlvdmEgcmFuZ2UgdmlhIERPTUFJTl9BVFRSX0dFT01FVFJZLiBGb3IKPiA+
ID4gZGV2aWNlcyB0aGF0IGhhcyBpdHMgb3duIERNQSB0cmFuc2xhdGlvbiB1bml0LCB3ZSBmZXRj
aCBpdCBkaXJlY3RseQo+ID4gPiBmcm9tIHZEUEEgYnVzIG9wZXJhdGlvbi4KPiA+ID4gCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+IC0t
LQo+ID4gPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMjcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrCj4gPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggICAg
ICAgfCAgNCArKysrCj4gPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggfCAg
NSArKysrKwo+ID4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQo+ID4gPiAK
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPiA+ID4gaW5kZXggNzdhMGM5ZmI2Y2MzLi5hZDIzZTY2Y2JmNTcgMTAwNjQ0Cj4gPiA+
IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4gPiA+IEBAIC0zMzIsNiArMzMyLDMwIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0
X2NvbmZpZ19jYWxsKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgX191c2VyICphcmdwKQo+ID4g
PiAgIAlyZXR1cm4gMDsKPiA+ID4gICB9Cj4gPiA+ICsKPiA+ID4gK3N0YXRpYyBsb25nIHZob3N0
X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBfX3VzZXIgKmFy
Z3ApCj4gPiA+ICt7Cj4gPiA+ICsJc3RydWN0IGlvbW11X2RvbWFpbl9nZW9tZXRyeSBnZW87Cj4g
PiA+ICsJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPiA+ID4gKwljb25zdCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4gPiA+ICsJc3RydWN0
IHZob3N0X3ZkcGFfaW92YV9yYW5nZSByYW5nZTsKPiA+ID4gKwlzdHJ1Y3QgdmRwYV9pb3ZhX3Jh
bmdlIHZkcGFfcmFuZ2U7Cj4gPiA+ICsKPiA+ID4gKwlpZiAoIW9wcy0+c2V0X21hcCAmJiAhb3Bz
LT5kbWFfbWFwKSB7Cj4gPiBXaHkgbm90IGp1c3QgY2hlY2sgaWYgKG9wcy0+Z2V0X2lvdmFfcmFu
Z2UpIGRpcmVjdGx5Pwo+IAo+IAo+IEJlY2F1c2Ugc2V0X21hcCB8fCBkbWFfb3BzIGlzIGEgaGlu
dCB0aGF0IHRoZSBkZXZpY2UgaGFzIGl0cyBvd24gRE1BCj4gdHJhbnNsYXRpb24gbG9naWMuCj4g
Cj4gRGV2aWNlIHdpdGhvdXQgZ2V0X2lvdmFfcmFuZ2UgZG9lcyBub3QgbmVjZXNzYXJpbHkgbWVh
bnQgaXQgdXNlIElPTU1VCj4gZHJpdmVyLgo+IAo+IFRoYW5rcwoKT0sgbGV0J3MgYWRkIHNvbWUg
Y29kZSBjb21tZW50cyBwbGVhc2UsIGFuZCBjaGVjayBnZXRfaW92YV9yYW5nZQppcyBhY3R1YWxs
eSB0aGVyZSBiZWZvcmUgY2FsbGluZy4KCj4gCj4gPiAKPiA+IAo+ID4gCj4gPiAKPiA+ID4gKwkJ
aW9tbXVfZG9tYWluX2dldF9hdHRyKHYtPmRvbWFpbiwKPiA+ID4gKwkJCQkgICAgICBET01BSU5f
QVRUUl9HRU9NRVRSWSwgJmdlbyk7Cj4gPiA+ICsJCXJhbmdlLnN0YXJ0ID0gZ2VvLmFwZXJ0dXJl
X3N0YXJ0Owo+ID4gPiArCQlyYW5nZS5lbmQgPSBnZW8uYXBlcnR1cmVfZW5kOwo+ID4gPiArCX0g
ZWxzZSB7Cj4gPiA+ICsJCXZkcGFfcmFuZ2UgPSBvcHMtPmdldF9pb3ZhX3JhbmdlKHZkcGEpOwo+
ID4gPiArCQlyYW5nZS5zdGFydCA9IHZkcGFfcmFuZ2Uuc3RhcnQ7Cj4gPiA+ICsJCXJhbmdlLmVu
ZCA9IHZkcGFfcmFuZ2UuZW5kOwo+ID4gPiArCX0KPiA+ID4gKwo+ID4gPiArCXJldHVybiBjb3B5
X3RvX3VzZXIoYXJncCwgJnJhbmdlLCBzaXplb2YocmFuZ2UpKTsKPiA+ID4gKwo+ID4gPiArfQo+
ID4gPiArCj4gPiA+ICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV92cmluZ19pb2N0bChzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwKPiA+ID4gICAJCQkJICAgdm9pZCBfX3Vz
ZXIgKmFyZ3ApCj4gPiA+ICAgewo+ID4gPiBAQCAtNDQyLDYgKzQ2Niw5IEBAIHN0YXRpYyBsb25n
IHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ID4gPiAgIAlj
YXNlIFZIT1NUX1ZEUEFfU0VUX0NPTkZJR19DQUxMOgo+ID4gPiAgIAkJciA9IHZob3N0X3ZkcGFf
c2V0X2NvbmZpZ19jYWxsKHYsIGFyZ3ApOwo+ID4gPiAgIAkJYnJlYWs7Cj4gPiA+ICsJY2FzZSBW
SE9TVF9WRFBBX0dFVF9JT1ZBX1JBTkdFOgo+ID4gPiArCQlyID0gdmhvc3RfdmRwYV9nZXRfaW92
YV9yYW5nZSh2LCBhcmdwKTsKPiA+ID4gKwkJYnJlYWs7Cj4gPiA+ICAgCWRlZmF1bHQ6Cj4gPiA+
ICAgCQlyID0gdmhvc3RfZGV2X2lvY3RsKCZ2LT52ZGV2LCBjbWQsIGFyZ3ApOwo+ID4gPiAgIAkJ
aWYgKHIgPT0gLUVOT0lPQ1RMQ01EKQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAo+ID4gPiBpbmRleCAwYzIz
NDk2MTJlNzcuLjg1MDk1Njk4MGUyNyAxMDA2NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L3Zob3N0LmgKPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgKPiA+ID4g
QEAgLTE0NCw0ICsxNDQsOCBAQAo+ID4gPiAgIC8qIFNldCBldmVudCBmZCBmb3IgY29uZmlnIGlu
dGVycnVwdCovCj4gPiA+ICAgI2RlZmluZSBWSE9TVF9WRFBBX1NFVF9DT05GSUdfQ0FMTAlfSU9X
KFZIT1NUX1ZJUlRJTywgMHg3NywgaW50KQo+ID4gPiArCj4gPiA+ICsvKiBHZXQgdGhlIHZhbGlk
IGlvdmEgcmFuZ2UgKi8KPiA+ID4gKyNkZWZpbmUgVkhPU1RfVkRQQV9HRVRfSU9WQV9SQU5HRQlf
SU9XKFZIT1NUX1ZJUlRJTywgMHg3OCwgXAo+ID4gPiArCQkJCQkgICAgIHN0cnVjdCB2aG9zdF92
ZHBhX2lvdmFfcmFuZ2UpCj4gPiA+ICAgI2VuZGlmCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBl
cy5oCj4gPiA+IGluZGV4IDY2OTQ1N2NlNWM0OC4uNDAyNWI1YTM2MTc3IDEwMDY0NAo+ID4gPiAt
LS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaAo+ID4gPiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaAo+ID4gPiBAQCAtMTI3LDYgKzEyNywxMSBAQCBzdHJ1
Y3Qgdmhvc3RfdmRwYV9jb25maWcgewo+ID4gPiAgIAlfX3U4IGJ1ZlswXTsKPiA+ID4gICB9Owo+
ID4gPiArc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSB7Cj4gPiA+ICsJX191NjQgc3RhcnQ7
Cj4gPiA+ICsJX191NjQgZW5kOwo+ID4gPiArfTsKPiA+ID4gKwo+ID4gCj4gPiBQbHMgZG9jdW1l
bnQgZmllbGRzLiBBbmQgSSB0aGluayBmaXJzdC9sYXN0IGlzIGEgYmV0dGVyIEFQSSAuLi4KPiA+
IAo+ID4gPiAgIC8qIEZlYXR1cmUgYml0cyAqLwo+ID4gPiAgIC8qIExvZyBhbGwgd3JpdGUgZGVz
Y3JpcHRvcnMuIENhbiBiZSBjaGFuZ2VkIHdoaWxlIGRldmljZSBpcyBhY3RpdmUuICovCj4gPiA+
ICAgI2RlZmluZSBWSE9TVF9GX0xPR19BTEwgMjYKPiA+ID4gLS0gCj4gPiA+IDIuMjAuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
