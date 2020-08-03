Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54ACC433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:25:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BC52075A
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkWCPBbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BC52075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3D8302107D;
	Mon,  3 Aug 2020 21:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QgM8Z1aavHZm; Mon,  3 Aug 2020 21:25:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D783420369;
	Mon,  3 Aug 2020 21:25:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B436BC0051;
	Mon,  3 Aug 2020 21:25:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF0CC004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9647B8669A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 83GgWbzkD6AV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:25:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A3F308666C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596489948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikyGbz8nQh5TDiGS3xQaFtP/qkuV7YgDHYZBs2e8q6U=;
 b=gkWCPBbfw+DKM9GTBApFdddGS/80tzAa27YUnk/sRRgfql3qDekVUpX3iZD2km7Pwmql9j
 +BvW212lAeIxj2ulnsCN5nZUcX1GRe4oNlfAUcizhjPiBEEdvS0nIBrzsHlHg+hW8N3QpD
 NcBm9VFReeUcHqmeMxG+vIaukiNmRFE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-OvDhbRqZOwqFXyf0y-bvFA-1; Mon, 03 Aug 2020 17:25:46 -0400
X-MC-Unique: OvDhbRqZOwqFXyf0y-bvFA-1
Received: by mail-ej1-f71.google.com with SMTP id y10so14900983ejd.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=Tk3Rs2qegFZypVO27BFx2r1W0ZQxCF8/+L4irxiO1hU=;
 b=iY5U0UOudIb7cEjWwIlHe4PKFMWokdu9Ruhy8xlfLcOR7vOAayC3l9dIHVjQQgOJfQ
 GI0mqyZ90zz/2BtMaqZMJC0eKXFrhjfGGI1q9VT37PJzcUYItzGCRayiZoPv4JbTchCt
 3rkbJS65oLT5jTkYzko2lpU6eBOw+iEv4yTd0MlkNiS744eG7ZvcoIW+0NIx4i2uyC30
 6WXOIUeDHcqdG/fRlFG0TeWDjxdp29ezEhTGcbdbQCZbMUZGjqqXUcgZsAY1AG24ayzo
 gGvWJy+Lx8WDnuUwwd5kOPKbiGGl/bVhcQ72cmoNXHEMz6CO+PN5ke2KpILiHtsAWWFR
 pJYA==
X-Gm-Message-State: AOAM530ARriG7cWRt2A39LTbzl+YIxKOKBY3qsUfoLE+Vm39pRGaF7EA
 EpZ+DOBK6phwzAD8zhDare6g5TsG++l2OV+6GdN+kJG4ZLtk/0ktqBsUDOz9q6cN6iIEHY5JT3i
 1OAjJkgwhFna1F5ruAhrv3ulzMGtYP/0ab+oqhc9zsA==
X-Received: by 2002:a05:6402:1c88:: with SMTP id
 cy8mr17907692edb.24.1596489945576; 
 Mon, 03 Aug 2020 14:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIzMUK8S+nJcTcQT4uN8ACgajCm5UUzF876hPGAe/y0hA1rXHhbvCvLJ2m4UbiIBnQqAQZqA==
X-Received: by 2002:a05:6402:1c88:: with SMTP id
 cy8mr17907686edb.24.1596489945433; 
 Mon, 03 Aug 2020 14:25:45 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6449.dip0.t-ipconnect.de. [91.12.100.73])
 by smtp.gmail.com with ESMTPSA id
 i5sm3342356edt.52.2020.08.03.14.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 14:25:45 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 01/24] virtio_balloon: fix sparse warning
Date: Mon, 3 Aug 2020 23:25:44 +0200
Message-Id: <D9D808BB-4A2F-459D-8E2C-CC0C6E0D5C99@redhat.com>
References: <20200803205814.540410-2-mst@redhat.com>
In-Reply-To: <20200803205814.540410-2-mst@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17F80)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

Cgo+IEFtIDAzLjA4LjIwMjAgdW0gMjI6NTggc2NocmllYiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPjoKPiAKPiDvu79iYWxsb29uIHVzZXMgdmlydGlvMzJfdG9fY3B1IGluc3Rl
YWQgb2YgY3B1X3RvX3ZpcnRpbzMyCj4gdG8gY29udmVydCBhIG5hdGl2ZSBlbmRpYW4gbnVtYmVy
IHRvIHZpcnRpby4KPiBObyBwcmFjdGljYWwgZGlmZmVyZW5jZSBidXQgbWFrZXMgc3BhcnNlIHdh
cm4uCj4gRml4IGl0IHVwLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+CgpJIHRoaW5rIEkgYWNrZWQgdGhpcyBvbmUgYWxyZWFkeS4KCkFja2Vk
LWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4KCj4gLS0tCj4gZHJpdmVy
cy92aXJ0aW8vdmlydGlvX2JhbGxvb24uYyB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX2JhbGxvb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxsb29uLmMKPiBpbmRl
eCA1NGZkOTg5ZjkzNTMuLjhiYzE3MDRmZmRmMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fYmFsbG9vbi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX2JhbGxvb24u
Ywo+IEBAIC02MDAsNyArNjAwLDcgQEAgc3RhdGljIGludCBzZW5kX2NtZF9pZF9zdGFydChzdHJ1
Y3QgdmlydGlvX2JhbGxvb24gKnZiKQo+ICAgIHdoaWxlICh2aXJ0cXVldWVfZ2V0X2J1Zih2cSwg
JnVudXNlZCkpCj4gICAgICAgIDsKPiAKPiAtICAgIHZiLT5jbWRfaWRfYWN0aXZlID0gdmlydGlv
MzJfdG9fY3B1KHZiLT52ZGV2LAo+ICsgICAgdmItPmNtZF9pZF9hY3RpdmUgPSBjcHVfdG9fdmly
dGlvMzIodmItPnZkZXYsCj4gICAgICAgICAgICAgICAgICAgIHZpcnRpb19iYWxsb29uX2NtZF9p
ZF9yZWNlaXZlZCh2YikpOwo+ICAgIHNnX2luaXRfb25lKCZzZywgJnZiLT5jbWRfaWRfYWN0aXZl
LCBzaXplb2YodmItPmNtZF9pZF9hY3RpdmUpKTsKPiAgICBlcnIgPSB2aXJ0cXVldWVfYWRkX291
dGJ1Zih2cSwgJnNnLCAxLCAmdmItPmNtZF9pZF9hY3RpdmUsIEdGUF9LRVJORUwpOwo+IC0tIAo+
IE1TVAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
