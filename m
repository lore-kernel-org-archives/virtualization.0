Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DBCEB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 02:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA68C60D79;
	Mon, 26 Jun 2023 02:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA68C60D79
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YKRwn9Fv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IBEszaVaBp-w; Mon, 26 Jun 2023 02:32:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2302F606AA;
	Mon, 26 Jun 2023 02:32:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2302F606AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1399C0037;
	Mon, 26 Jun 2023 02:32:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BEA5C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42E5960BED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:32:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42E5960BED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MLPyBFFffrpa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:32:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C88C606AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C88C606AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687746750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZ1WUC2XaTDLAdztiJ+SNJb8lLSc6pt2wNnqA/v0RF0=;
 b=YKRwn9FvKp8q18cX+C46RbmxrNFb5cq5A5EXCQ4IS/8SAcmOd1lbARu0MgHA4Ijc7u0Tr5
 nBgPvDKwIWf6YwejOqcY/ZWeu/8nE9flj1zO0njNMgWBBnMM2GRMzeXAxUQ7lYhwR8brnj
 BPP477+XZXdxbKW+dS/LBIpmq/xK3ec=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-SUdR8pHKOsS6KJ4LIWXpKw-1; Sun, 25 Jun 2023 22:32:28 -0400
X-MC-Unique: SUdR8pHKOsS6KJ4LIWXpKw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f0176dcc1eso1302483e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 19:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687746746; x=1690338746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZ1WUC2XaTDLAdztiJ+SNJb8lLSc6pt2wNnqA/v0RF0=;
 b=MU96kSRGAI9SxTZTYDgAOISnhxflRt2EJ8aNFHGEN3fpXRymmxJMazZ5eg5/u/kuLM
 7Ks88NLPLV5aZ2hFkW+1oIDWiaR1qtWeyF6ELETm+gPgioU6u0Ib+2/tJjx1bULAX1ey
 tQyMIckdtGehQezsMWIJQ5wsbMEjVlDTIqfvxlFl7gHL5N+XGXWFJ2+ebh7uyG2SClQu
 EPBhbkxa8bLmzI3VCFJTm2D+MPvwO7ymqKXYDuBSn8vB2aO/V7TIt8sBBiJUXV8Gh12G
 U3jcJ6dV2lsjJiCdC6ncRHBrEQ+2AS00t/OWsn/APd94udE+MCwlf3jQgWrQehn554Ic
 /lJg==
X-Gm-Message-State: AC+VfDxaclLoL/QLKr8ziBLK5p38NlgYI0zzSnhNoAgcpkXKL2D/yIiI
 NpylZmljkhL5qVT6yN2KEDim4/Uasyq87srE6xww2gF+5RCG4E6OJXLF4NSPeXyOeS3tDY6ecpv
 OENQDBubHaUQ0LvwFWZuN8TLIP/2nTrbeZSVqOpvBWlo7AQmwwLjz3e0lCA==
X-Received: by 2002:a05:6512:3f24:b0:4fa:d522:a38f with SMTP id
 y36-20020a0565123f2400b004fad522a38fmr1259890lfa.26.1687746746628; 
 Sun, 25 Jun 2023 19:32:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FdAnKPOJNqGeSO27Dqe8b1OEOCMZtaGOpYKRbVPJezchuGu7aN4dSgY6TvhkaYgBlornvrv0nxL3Ac3yegGg=
X-Received: by 2002:a05:6512:3f24:b0:4fa:d522:a38f with SMTP id
 y36-20020a0565123f2400b004fad522a38fmr1259888lfa.26.1687746746348; Sun, 25
 Jun 2023 19:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151420.1019504-1-lingshan.zhu@intel.com>
 <20230612151420.1019504-2-lingshan.zhu@intel.com>
In-Reply-To: <20230612151420.1019504-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 10:32:15 +0800
Message-ID: <CACGkMEspGu+N-CpE8J=Ux3m=+zMOByGPJU=My2U-BGW9QOHNhg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] vDPA/ifcvf: dynamic allocate vq data stores
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

T24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMzoxNOKAr1BNIFpodSBMaW5nc2hhbiA8bGluZ3NoYW4u
emh1QGludGVsLmNvbT4gd3JvdGU6Cj4KPiBUaGlzIGNvbW1pdCBkeW5hbWljYWxseSBhbGxvY2F0
ZXMgdGhlIGRhdGEKPiBzdG9yZXMgZm9yIHRoZSB2aXJ0cXVldWVzIGJhc2VkIG9uCj4gdmlydGlv
X3BjaV9jb21tb25fY2ZnLm51bV9xdWV1ZXMuCgpXaGlsZSBhdCBpdCwgaXQncyBiZXR0ZXIgdG8g
YWxsb2NhdGUgdnJpbmdfbG1fY2ZnIGFzIHdlbGwgYW5kIGRyb3AKSUZDVkZfTUFYX1FVRVVFUy4K
ClRoYW5rcwoKPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGlu
dGVsLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDMgKysr
Cj4gIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAyICstCj4gIGRyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAyICsrCj4gIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiBpbmRleCAx
YjVkYTExZjU0MDMuLmY4NjQ5NWFjZTgyNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+
IEBAIC0xMzQsNiArMTM0LDkgQEAgaW50IGlmY3ZmX2luaXRfaHcoc3RydWN0IGlmY3ZmX2h3ICpo
dywgc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4gICAgICAgICB9Cj4KPiAgICAgICAgIGh3LT5ucl92
cmluZyA9IHZwX2lvcmVhZDE2KCZody0+Y29tbW9uX2NmZy0+bnVtX3F1ZXVlcyk7Cj4gKyAgICAg
ICBody0+dnJpbmcgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgdnJpbmdfaW5mbykgKiBody0+bnJf
dnJpbmcsIEdGUF9LRVJORUwpOwo+ICsgICAgICAgaWYgKCFody0+dnJpbmcpCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOwo+Cj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaHctPm5y
X3ZyaW5nOyBpKyspIHsKPiAgICAgICAgICAgICAgICAgdnBfaW93cml0ZTE2KGksICZody0+Y29t
bW9uX2NmZy0+cXVldWVfc2VsZWN0KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuaCBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBpbmRleCAz
MTEwZmZjNTBjYWYuLmZhNzk3MTg0MDU2YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+
IEBAIC03NCw3ICs3NCw3IEBAIHN0cnVjdCBpZmN2Zl9odyB7Cj4gICAgICAgICB1NjQgZGV2X2Zl
YXR1cmVzOwo+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpj
b21tb25fY2ZnOwo+ICAgICAgICAgdm9pZCBfX2lvbWVtICpkZXZfY2ZnOwo+IC0gICAgICAgc3Ry
dWN0IHZyaW5nX2luZm8gdnJpbmdbSUZDVkZfTUFYX1FVRVVFU107Cj4gKyAgICAgICBzdHJ1Y3Qg
dnJpbmdfaW5mbyAqdnJpbmc7Cj4gICAgICAgICB2b2lkIF9faW9tZW0gKiBjb25zdCAqYmFzZTsK
PiAgICAgICAgIGNoYXIgY29uZmlnX21zaXhfbmFtZVsyNTZdOwo+ICAgICAgICAgc3RydWN0IHZk
cGFfY2FsbGJhY2sgY29uZmlnX2NiOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDZl
NDdhYzJjNjY5YS4uMmFmMGRlNzcxYjQ5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
QEAgLTgzMCw2ICs4MzAsNyBAQCBzdGF0aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2
ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4gICAgICAgICByZXR1cm4g
MDsKPgo+ICBlcnI6Cj4gKyAgICAgICBrZnJlZShpZmN2Zl9tZ210X2Rldi0+dmYudnJpbmcpOwo+
ICAgICAgICAga2ZyZWUoaWZjdmZfbWdtdF9kZXYpOwo+ICAgICAgICAgcmV0dXJuIHJldDsKPiAg
fQo+IEBAIC04NDAsNiArODQxLDcgQEAgc3RhdGljIHZvaWQgaWZjdmZfcmVtb3ZlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2KQo+Cj4gICAgICAgICBpZmN2Zl9tZ210X2RldiA9IHBjaV9nZXRfZHJ2ZGF0
YShwZGV2KTsKPiAgICAgICAgIHZkcGFfbWdtdGRldl91bnJlZ2lzdGVyKCZpZmN2Zl9tZ210X2Rl
di0+bWRldik7Cj4gKyAgICAgICBrZnJlZShpZmN2Zl9tZ210X2Rldi0+dmYudnJpbmcpOwo+ICAg
ICAgICAga2ZyZWUoaWZjdmZfbWdtdF9kZXYpOwo+ICB9Cj4KPiAtLQo+IDIuMzkuMQo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
