Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BA5E95A8E
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 04:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06F926104A;
	Sun,  8 Oct 2023 04:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06F926104A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HJK044Al
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGcG5gd9ZRKS; Sun,  8 Oct 2023 04:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C6C660BDC;
	Sun,  8 Oct 2023 04:32:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C6C660BDC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5793CC0071;
	Sun,  8 Oct 2023 04:32:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 073FCC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5A1960FCA
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5A1960FCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6T3ILwW2huu
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:32:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B00A60BDC
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B00A60BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696739526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGKZy6hh7XkDoI8fqTHJe3BoYI4y32WZwlGdvF1uXgU=;
 b=HJK044AlEUDeM7A84G5p1m5zTG3ul2Q9v7EaGGFR98ceeLGt+rg1fDSBZiBVG3gmRz13UX
 Mtiqvg6fw/EkuMnhYygnrOd7Y/hxbPHj0TSBCroLT/vm+VCZlIn+oVVZyUQxtwg9aMvqvu
 05OoV/z+oUCfyAxKx/0/UiIERsHkSXs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-0gatD2m1O0S1nlx3hir91A-1; Sun, 08 Oct 2023 00:32:04 -0400
X-MC-Unique: 0gatD2m1O0S1nlx3hir91A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5068bf0b425so1391402e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 21:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696739522; x=1697344322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGKZy6hh7XkDoI8fqTHJe3BoYI4y32WZwlGdvF1uXgU=;
 b=fXbH23Kfm6jYRi+06KWOlNuqKVfUlODJUJXS8wYzrhvQTesI3V7JA3cjhLU+g6NOZX
 YyXpMQum5IcOhRILlirAX9MHTduAnPc8YEazq3bnyUdjdNsy8c54JhFlDaoFeVhTh/py
 G2IfSONyCgi4zzuHgiYDsYZnt84ILSRzEmrshEhEDdZqzJPQekg9N0NXwIDowVpDwxZt
 KiM5whuaBmBr46cm4OViG5TiYKT4wdFsAh5KHWKOOkp9LIepSc0wB00MJNjV+BAQuiwf
 iPn+n5sH82sb/PcGBLqX7HoCciBnAyAjTlglfD+ncyXss58CJUq/r/opAI8kRWR1FtLe
 MGlQ==
X-Gm-Message-State: AOJu0YwKbhsLtcUlVLWyplh4NHpA82eePShkYtDVdzZJpPC6E/ntuUWR
 gWekOLbGpE5Ixl13HHZM0eZcpkBbbEbTKqq1dvrWLqb236p6d1kvBfwdFLbiH1aEu+CGsztwvCK
 qDP72ivGQSpmay1evyoZ5V/zjsgrT3BfsoswexbwUr8ciGEndGPaUqA6qKduQis5PRTwm3zM=
X-Received: by 2002:ac2:5f62:0:b0:4fe:5860:7abf with SMTP id
 c2-20020ac25f62000000b004fe58607abfmr8456275lfc.13.1696739522311; 
 Sat, 07 Oct 2023 21:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkNprEfoQumi1c14qFNXAOSdZmI4/5M4Sat2CzVMVr8abYBs/xz/wq4KBN3pMrKjL2uWpdt2IjcYYyICU1aTI=
X-Received: by 2002:ac2:5f62:0:b0:4fe:5860:7abf with SMTP id
 c2-20020ac25f62000000b004fe58607abfmr8456271lfc.13.1696739522089; Sat, 07 Oct
 2023 21:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230925035830.117710-1-xuanzhuo@linux.alibaba.com>
 <20230925035830.117710-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230925035830.117710-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:31:51 +0800
Message-ID: <CACGkMEsbmhD1wXtaP3n2BfQR2ci70N6NUvv2xPd-8Hoonfmjaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio_pci: add build offset check for the new common
 cfg items
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMTE6NTjigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IEFkZCBjaGVja3MgdG8gdGhlIGNoZWNrX29mZnNl
dHModm9pZCkgZm9yIHF1ZXVlX25vdGlmeV9kYXRhIGFuZAo+IHF1ZXVlX3Jlc2V0Lgo+Cj4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCkFja2Vk
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYyB8IDQgKysrKwo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVy
bl9kZXYuYwo+IGluZGV4IGVmNjY2N2RlMWIzOC4uNDdjYjQxMTYwZTFhIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBAQCAtMjAzLDYgKzIwMywxMCBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgY2hlY2tfb2Zmc2V0cyh2b2lkKQo+ICAgICAgICAgICAgICAgICAgICAg
IG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcsIHF1ZXVlX3VzZWRfbG8pKTsK
PiAgICAgICAgIEJVSUxEX0JVR19PTihWSVJUSU9fUENJX0NPTU1PTl9RX1VTRURISSAhPQo+ICAg
ICAgICAgICAgICAgICAgICAgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcs
IHF1ZXVlX3VzZWRfaGkpKTsKPiArICAgICAgIEJVSUxEX0JVR19PTihWSVJUSU9fUENJX0NPTU1P
Tl9RX05EQVRBICE9Cj4gKyAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRp
b19wY2lfbW9kZXJuX2NvbW1vbl9jZmcsIHF1ZXVlX25vdGlmeV9kYXRhKSk7Cj4gKyAgICAgICBC
VUlMRF9CVUdfT04oVklSVElPX1BDSV9DT01NT05fUV9SRVNFVCAhPQo+ICsgICAgICAgICAgICAg
ICAgICAgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnLCBxdWV1
ZV9yZXNldCkpOwo+ICB9Cj4KPiAgLyoKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
