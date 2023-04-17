Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04BDC77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 03:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 801C382252;
	Mon, 17 Apr 2023 03:32:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 801C382252
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UZnWxHo4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYOJ6wbMudBD; Mon, 17 Apr 2023 03:32:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1797B8224B;
	Mon, 17 Apr 2023 03:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1797B8224B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D56B0C0037;
	Mon, 17 Apr 2023 03:32:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 043FFC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEE9A404D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:32:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEE9A404D4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UZnWxHo4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i4aVtaJdC0wC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05D844026F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05D844026F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 03:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681702323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ot4mAzk1dD+VO6IKPj86pu2eAQn+6tiF/RKoyglMHgI=;
 b=UZnWxHo4sA0NIvSoynBwRyocZ9WTNn0L+0gJhDsPIytg6ct6IaFMbqV7LgsrU+yeN9tfac
 kNZvTxP6Bc0YwKAOfF+x6M2Iy6sD3O+vDfIXP61wyNMq2UJ9Bq6wNUKP7xr9Zd8fbKb6qG
 Fku+CpW9zRYXlt42HxtrkEO9As6VJOs=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-aP3N7WpNN664Q6LbJ9hZCA-1; Sun, 16 Apr 2023 23:32:02 -0400
X-MC-Unique: aP3N7WpNN664Q6LbJ9hZCA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-187910199b4so6028960fac.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681702321; x=1684294321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ot4mAzk1dD+VO6IKPj86pu2eAQn+6tiF/RKoyglMHgI=;
 b=QWvybfdi7bECA4jEagljRA4Nra9STzsUx14QDd1pbBlqeJv+WG9dSntm1BKdzX8AVz
 58UXcFaaM2CzAgWjEA0gTTNJt/O/zFUkbVABFpisVtJiQkDDaK1ppwA0UNvI1Ko8MVyL
 TkVaP6ascTKjh756bEbggYhWM0WeWDeEbBdZW2sZ0x9T2RmGS4qRk+IgLV+NiEWMdPu9
 GenXAb4ovaieWCFiCN0CwRbmRQTakUPNyIxIods9lE0sdCGdrlOoCdDnM25T4wNV1RhN
 vgKyz+61zSKzFdLcR+qHnIb2wevgsjmtjbrVCj477vjSmlAaC7Ug2KFvBV3GegrtzWUy
 a7nw==
X-Gm-Message-State: AAQBX9fPsg1iYLQY224UzlC+xVM5i4B0qb3v+iwsxeVRlzNnySzDUXVj
 gz/cDYp60kTzYdXdWwyDXMnwH5MbkqLdqWAfGVhpyAOQ3im+01is4rmVVH7v1TuNQtC+KhCtg65
 lc1QD0pTCvIOweFYGoxYG6Hb98TRxvV16N+XReXkebx8srLvldbT3Wd2sRg==
X-Received: by 2002:a05:6870:b605:b0:184:5497:53e6 with SMTP id
 cm5-20020a056870b60500b00184549753e6mr4511734oab.3.1681702321616; 
 Sun, 16 Apr 2023 20:32:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1OSW7Q3WyPX8YhgEEOJFU2G0q8lgnrVvLOt3ciyV8fmwl1u54r2QQlagOxp9oJTR/pFZt15KWbVevkS6IVh0=
X-Received: by 2002:a05:6870:b605:b0:184:5497:53e6 with SMTP id
 cm5-20020a056870b60500b00184549753e6mr4511728oab.3.1681702321435; Sun, 16 Apr
 2023 20:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230415021959.197891-1-lulu@redhat.com>
In-Reply-To: <20230415021959.197891-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Apr 2023 11:31:50 +0800
Message-ID: <CACGkMEtu=Xiqc1JJrRVZ40dGsP8su_USq3ZJAWKgb4QaA4F5xw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost_vdpa: fix unmap process in no-batch mode
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

T24gU2F0LCBBcHIgMTUsIDIwMjMgYXQgMTA6MjDigK9BTSBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IFdoaWxlIHVzaW5nIHRoZSBuby1iYXRjaCBtb2RlIHdpdGggdklPTU1V
IGVuYWJsZWQKPiBRZW11IHdpbGwgY2FsbCBhIGxhcmdlIG1lbW9yeSB0byB1bm1hcC4gTXVjaCBs
YXJnZXIgdGhhbiB0aGUgbWVtb3J5Cj4gbWFwcGVkIHRvIHRoZSBrZXJuZWwuIFRoZSBpb3RsYiBp
cyBOVUxMIGluIHRoZSBrZXJuZWwgYW5kIHdpbGwgcmV0dXJuIGZhaWwuCgpUaGlzIHBhdGNoIGxv
b2tzIGdvb2QgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgYWJvdmUuIEkgdGhpbmsgaXQncwpi
ZXR0ZXIgdG8gZXhwbGFpbiB3aHkgc3VjaCBsYXJnZSB1bm1hcCB3aWxsIGxlYWQgdG8gdGhpcyBl
cnJvcjoKCklzIGl0IGEgYmF0Y2hlZCB1bm1hcCBvciBhIFswLCBVTE9OR19NQVhdIG1hcD8gSG93
IGNvdWxkIHdlIGVuZCB1cCB0aGUgTlVMTD8KCj4gV2hpY2ggY2F1c2VzIGZhaWx1cmUuCj4gVG8g
Zml4IHRoaXMsIHdlIHdpbGwgbm90IHJlbW92ZSB0aGUgQVMgd2hpbGUgdGhlIGlvdGxiLT5ubWFw
cyBpcyAwLgo+IFRoaXMgd2lsbCBmcmVlIGluIHRoZSB2aG9zdF92ZHBhX2NsZWFuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgoKRG8gd2UgbmVlZCBhIGZpeCB0
YWcgYW5kIGRvZXMgaXQgbmVlZCB0byBnbyBmb3IgLXN0YWJsZT8KClRoYW5rcwoKPiAtLS0KPiAg
ZHJpdmVycy92aG9zdC92ZHBhLmMgfCA4ICstLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0
L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggN2JlOWQ5ZDhmMDFjLi43NGM3
ZDFmOTc4YjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC04NTEsMTEgKzg1MSw3IEBAIHN0YXRpYyB2b2lkIHZob3N0
X3ZkcGFfdW5tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAgICAgICAgICAgICAgIGlmICgh
di0+aW5fYmF0Y2gpCj4gICAgICAgICAgICAgICAgICAgICAgICAgb3BzLT5zZXRfbWFwKHZkcGEs
IGFzaWQsIGlvdGxiKTsKPiAgICAgICAgIH0KPiAtICAgICAgIC8qIElmIHdlIGFyZSBpbiB0aGUg
bWlkZGxlIG9mIGJhdGNoIHByb2Nlc3NpbmcsIGRlbGF5IHRoZSBmcmVlCj4gLSAgICAgICAgKiBv
ZiBBUyB1bnRpbCBCQVRDSF9FTkQuCj4gLSAgICAgICAgKi8KPiAtICAgICAgIGlmICghdi0+aW5f
YmF0Y2ggJiYgIWlvdGxiLT5ubWFwcykKPiAtICAgICAgICAgICAgICAgdmhvc3RfdmRwYV9yZW1v
dmVfYXModiwgYXNpZCk7Cj4gKwo+ICB9Cj4KPiAgc3RhdGljIGludCB2aG9zdF92ZHBhX3ZhX21h
cChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiBAQCAtMTExMiw4ICsxMTA4LDYgQEAgc3RhdGljIGlu
dCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdTMy
IGFzaWQsCj4gICAgICAgICAgICAgICAgIGlmICh2LT5pbl9iYXRjaCAmJiBvcHMtPnNldF9tYXAp
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgb3BzLT5zZXRfbWFwKHZkcGEsIGFzaWQsIGlvdGxi
KTsKPiAgICAgICAgICAgICAgICAgdi0+aW5fYmF0Y2ggPSBmYWxzZTsKPiAtICAgICAgICAgICAg
ICAgaWYgKCFpb3RsYi0+bm1hcHMpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfdmRw
YV9yZW1vdmVfYXModiwgYXNpZCk7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAg
ZGVmYXVsdDoKPiAgICAgICAgICAgICAgICAgciA9IC1FSU5WQUw7Cj4gLS0KPiAyLjM0LjMKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
