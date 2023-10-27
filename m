Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B070C25B47
	for <virtualization@archiver.kernel.org>; Fri, 27 Oct 2023 06:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFDB94ED9D;
	Fri, 27 Oct 2023 06:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFDB94ED9D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RItVTjtP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t1GibQsyyKwT; Fri, 27 Oct 2023 06:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C4844ED99;
	Fri, 27 Oct 2023 06:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C4844ED99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C53F9C0071;
	Fri, 27 Oct 2023 06:32:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F07B2C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 06:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4C754ED9C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 06:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4C754ED9C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rqUwvO7RG_aa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 06:32:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C28CA4ED99
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 06:32:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C28CA4ED99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698388340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxDkgS0LFdb0zrxOK5z/6YMxINonlxbWmMRbtDHv7CM=;
 b=RItVTjtPI880Q2DZbJtyon2+NVscikqqwJZG0FSqkgZjfFgiobV04408vKd6YWOTJa52gA
 isaVF3Dnqvr+gBBbgVmjsF2gA6KPxF9wP96lKTE5ayorLxy9aCUUKUL4itWXcZX+XDN679
 mAwOspTS8/XCx3YEdpujn98u3vS6Dos=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-s9Y0PcPUOEy4jLKx54sLHg-1; Fri, 27 Oct 2023 02:32:08 -0400
X-MC-Unique: s9Y0PcPUOEy4jLKx54sLHg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c503804667so18390041fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 23:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698388327; x=1698993127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxDkgS0LFdb0zrxOK5z/6YMxINonlxbWmMRbtDHv7CM=;
 b=S/JVjcj6e4JjaZ2D6DsLR0ttmOmUBjW6O5//pZqqoYtC0aycaBHGrz32pt0V3G5zcn
 sLIyiMnh7e/k+yeGbUJH9dkbGxNAUNQO6zVV6ilcKTILX+EQ+ObgLjczu6cxrD29e0Ub
 WM7Y97cJhBAyxSGKXd6tj020thuPMvV8jhAlBe6skYgnrSICv4UzdPhT3QD9RfC1ruUF
 JgJB1K1OxYtLsAN3prmcrdLYSz7SSHZ9r3CNDJ6iDXvfM8me6q8+iByOkSKTL/po2hdG
 kPxAwL5oE3JFbYlyqFvKXyZqcDJ63i0l9fEIQ3d/X8FIkrdTApLhzKlZsLzADEF/66Xq
 0Nuw==
X-Gm-Message-State: AOJu0YzVJIPpQ/bemKyJYTJlPIUE16IaScZUy/JkUCVqBhbVg3QvVMfP
 jlX9QCosfHwi9zULGR4JLO/EmpJrLLfocF9erKvbmJ4c2LLy35ViqwrSVTDe2zpme4YzTxoxbrU
 2vJ4EVmEdZ+puFVu7KscsI8MpU12yCVP+L3B5+kSt6Kdmk7w07IDQwsyLgg==
X-Received: by 2002:a19:ac01:0:b0:507:b15b:8b88 with SMTP id
 g1-20020a19ac01000000b00507b15b8b88mr1178194lfc.65.1698388327383; 
 Thu, 26 Oct 2023 23:32:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYiELfA5C7GIEPjiLdoikmssHWmewGe+r2BT1FO6KFjk37oJ/xRsKtzheJyFQ2V4ExxBcUM65fs6HpyHCi300=
X-Received: by 2002:a19:ac01:0:b0:507:b15b:8b88 with SMTP id
 g1-20020a19ac01000000b00507b15b8b88mr1178176lfc.65.1698388327046; Thu, 26 Oct
 2023 23:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Oct 2023 14:31:56 +0800
Message-ID: <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com>
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To: Steve Sistare <steven.sistare@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org
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

T24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgNDowN+KAr0FNIFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5z
aXN0YXJlQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gbWx4NV92ZHBhIGRvZXMgbm90IHByZXNlcnZl
IHVzZXJsYW5kJ3MgdmlldyBvZiB2cmluZyBiYXNlIGZvciB0aGUgY29udHJvbAo+IHF1ZXVlIGlu
IHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6Cj4KPiBpb2N0bCBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+
IGlvY3RsIFZIT1NUX1ZEUEFfU0VUX1NUQVRVUyBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LCj4g
ICBtbHg1X3ZkcGFfc2V0X3N0YXR1cygpCj4gICAgIHNldHVwX2N2cV92cmluZygpCj4gICAgICAg
dnJpbmdoX2luaXRfaW90bGIoKQo+ICAgICAgICAgdnJpbmdoX2luaXRfa2VybigpCj4gICAgICAg
ICAgIHZyaC0+bGFzdF9hdmFpbF9pZHggPSAwOwo+IGlvY3RsIFZIT1NUX0dFVF9WUklOR19CQVNF
Cj4KPiBUbyBmaXgsIHJlc3RvcmUgdGhlIHZhbHVlIG9mIGN2cS0+dnJpbmcubGFzdF9hdmFpbF9p
ZHggYWZ0ZXIgY2FsbGluZwo+IHZyaW5naF9pbml0X2lvdGxiLgo+Cj4gU2lnbmVkLW9mZi1ieTog
U3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgIDcgKysrKysrLQo+ICBkcml2ZXJzL3Zob3N0
L3ZyaW5naC5jICAgICAgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgaW5jbHVkZS9saW51eC92cmluZ2guaCAgICAgICAgICAgIHwgIDIgKysKPiAgMyBmaWxlcyBj
aGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jCj4gaW5kZXggOTQ2NDg4Yjg5ODlmLi5mNjQ3NTgxNDMxMTUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gQEAgLTI3OTUsMTMgKzI3OTUsMTggQEAgc3RhdGlj
IGludCBzZXR1cF9jdnFfdnJpbmcoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+ICAgICAg
ICAgc3RydWN0IG1seDVfY29udHJvbF92cSAqY3ZxID0gJm12ZGV2LT5jdnE7Cj4gICAgICAgICBp
bnQgZXJyID0gMDsKPgo+IC0gICAgICAgaWYgKG12ZGV2LT5hY3R1YWxfZmVhdHVyZXMgJiBCSVRf
VUxMKFZJUlRJT19ORVRfRl9DVFJMX1ZRKSkKPiArICAgICAgIGlmIChtdmRldi0+YWN0dWFsX2Zl
YXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9WUSkpIHsKPiArICAgICAgICAgICAg
ICAgdTE2IGxhc3RfYXZhaWxfaWR4ID0gY3ZxLT52cmluZy5sYXN0X2F2YWlsX2lkeDsKPiArCj4g
ICAgICAgICAgICAgICAgIGVyciA9IHZyaW5naF9pbml0X2lvdGxiKCZjdnEtPnZyaW5nLCBtdmRl
di0+YWN0dWFsX2ZlYXR1cmVzLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNTFg1X0NWUV9NQVhfRU5ULCBmYWxzZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKHN0cnVjdCB2cmluZ19kZXNjICopKHVpbnRwdHJfdCljdnEtPmRlc2Nf
YWRkciwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCB2
cmluZ19hdmFpbCAqKSh1aW50cHRyX3QpY3ZxLT5kcml2ZXJfYWRkciwKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCB2cmluZ191c2VkICopKHVpbnRwdHJf
dCljdnEtPmRldmljZV9hZGRyKTsKPgo+ICsgICAgICAgICAgICAgICBpZiAoIWVycikKPiArICAg
ICAgICAgICAgICAgICAgICAgICB2cmluZ2hfc2V0X2Jhc2VfaW90bGIoJmN2cS0+dnJpbmcsIGxh
c3RfYXZhaWxfaWR4KTsKCkJ0dywgdnJpbmdoX3NldF9iYXNlX2lvdGxiKCkgZGVzZXJ2ZXMgYW4g
aW5kZXBlbmRlbnQgcGF0Y2ggYW5kIGl0CnNlZW1zIGl0IGlzIG5vdCBzcGVjaWZpYyB0byBJT1RM
Qiwgc28gd2UgcHJvYmFibHkgbmVlZCBhbiBpbmRpcmVjdGlvbgp0byBoYXZlIHZyaW5naF9zZXRf
YmFzZSgpIGZpcnN0LgoKT3IgSSB3b25kZXIgaWYgaXQncyBiZXR0ZXIgdG8ganVzdCBpbnRyb2R1
Y2UgYSBuZXcgcGFyYW1ldGVyIHRvCnZyaW5naF9pbml0X2lvdGxiKCkuLi4KClRoYW5rcwoKPiAr
ICAgICAgIH0KPiAgICAgICAgIHJldHVybiBlcnI7Cj4gIH0KPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+IGluZGV4IDdiOGZk
OTc3ZjcxYy4uNzk5NzYyYzgzMDA3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJpbmdo
LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gQEAgLTU5NSw2ICs1OTUsMjQgQEAg
c3RhdGljIGlubGluZSB2b2lkIF9fdnJpbmdoX25vdGlmeV9kaXNhYmxlKHN0cnVjdCB2cmluZ2gg
KnZyaCwKPiAgICAgICAgIH0KPiAgfQo+Cj4gK3N0YXRpYyBpbmxpbmUgaW50IF9fdnJpbmdoX3Nl
dF9iYXNlKHN0cnVjdCB2cmluZ2ggKnZyaCwgdTE2IGlkeCwKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50ICgqcHV0dTE2KShjb25zdCBzdHJ1Y3QgdnJpbmdoICp2cmgsCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfX3ZpcnRpbzE2ICpwLCB1MTYgdmFsKSkKPiArewo+
ICsgICAgaW50IHJldDsKPiArCj4gKyAgICByZXQgPSBwdXR1MTYodnJoLCAmdnJoLT52cmluZy5h
dmFpbC0+aWR4LCBpZHgpOwo+ICsgICAgaWYgKHJldCkKPiArICAgICAgICByZXR1cm4gcmV0Owo+
ICsKPiArICAgIHJldCA9IHB1dHUxNih2cmgsICZ2cmgtPnZyaW5nLnVzZWQtPmlkeCwgaWR4KTsK
PiArICAgIGlmIChyZXQpCj4gKyAgICAgICAgcmV0dXJuIHJldDsKPiArCj4gKyAgICB2cmgtPmxh
c3RfYXZhaWxfaWR4ID0gdnJoLT5sYXN0X3VzZWRfaWR4ID0gaWR4Owo+ICsgICAgcmV0dXJuIDA7
Cj4gK30KPiArCj4gIC8qIFVzZXJzcGFjZSBhY2Nlc3MgaGVscGVyczogaW4gdGhpcyBjYXNlLCBh
ZGRyZXNzZXMgYXJlIHJlYWxseSB1c2Vyc3BhY2UuICovCj4gIHN0YXRpYyBpbmxpbmUgaW50IGdl
dHUxNl91c2VyKGNvbnN0IHN0cnVjdCB2cmluZ2ggKnZyaCwgdTE2ICp2YWwsIGNvbnN0IF9fdmly
dGlvMTYgKnApCj4gIHsKPiBAQCAtMTQ1Niw2ICsxNDc0LDE4IEBAIHZvaWQgdnJpbmdoX3NldF9p
b3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gIH0K
PiAgRVhQT1JUX1NZTUJPTCh2cmluZ2hfc2V0X2lvdGxiKTsKPgo+ICsvKioKPiArICogdnJpbmdo
X3NldF9iYXNlX2lvdGxiIC0gc2V0IGF2YWlsX2lkeCBhbmQgdXNlZF9pZHgKPiArICogQHZyaDog
dGhlIHZyaW5nCj4gKyAqIEBpZHg6IHRoZSB2YWx1ZSB0byBzZXQKPiArICovCj4gK2ludCB2cmlu
Z2hfc2V0X2Jhc2VfaW90bGIoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaWR4KQo+ICt7Cj4gKyAg
ICByZXR1cm4gX192cmluZ2hfc2V0X2Jhc2UodnJoLCBpZHgsIHB1dHUxNl9pb3RsYik7Cj4gK30K
PiArRVhQT1JUX1NZTUJPTCh2cmluZ2hfc2V0X2Jhc2VfaW90bGIpOwo+ICsKPiArCj4gIC8qKgo+
ICAgKiB2cmluZ2hfZ2V0ZGVzY19pb3RsYiAtIGdldCBuZXh0IGF2YWlsYWJsZSBkZXNjcmlwdG9y
IGZyb20gcmluZyB3aXRoCj4gICAqIElPVExCLgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3ZyaW5naC5oIGIvaW5jbHVkZS9saW51eC92cmluZ2guaAo+IGluZGV4IGMzYTgxMTdkYWJlOC4u
ZTliOGFmNGU2YTVlIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdnJpbmdoLmgKPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4gQEAgLTMwNiw2ICszMDYsOCBAQCBpbnQgdnJpbmdo
X2luaXRfaW90bGJfdmEoc3RydWN0IHZyaW5naCAqdnJoLCB1NjQgZmVhdHVyZXMsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19hdmFpbCAqYXZhaWwsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ191c2VkICp1c2VkKTsKPgo+ICtpbnQgdnJpbmdo
X3NldF9iYXNlX2lvdGxiKHN0cnVjdCB2cmluZ2ggKnZyaCwgdTE2IGlkeCk7Cj4gKwo+ICBpbnQg
dnJpbmdoX2dldGRlc2NfaW90bGIoc3RydWN0IHZyaW5naCAqdnJoLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgdnJpbmdoX2tpb3YgKnJpb3YsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCB2cmluZ2hfa2lvdiAqd2lvdiwKPiAtLQo+IDIuMzkuMwo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
