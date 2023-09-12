Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF46CA0ECA
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 07:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B102418D1;
	Tue, 12 Sep 2023 07:41:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B102418D1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibkztNct
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id An96G9qhwBb7; Tue, 12 Sep 2023 07:41:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A210417B3;
	Tue, 12 Sep 2023 07:41:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A210417B3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A03AC0039;
	Tue, 12 Sep 2023 07:41:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 130EDC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9B96418BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9B96418BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZidMWIcubHV8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:41:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D642D417B3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:41:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D642D417B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694504461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmEyY93Ck8WkDOQRoCLqGrbPgTcfdcNt9t1RcylOzYQ=;
 b=ibkztNctLiWa96/rf1B0qJANpKoVkP2z5st5lVROef4cpjLHK43RhDyUkG78HTLM4RPBZg
 cu2FY73m5I9B34gqdZq35un34M2jif5+FjT1g1x7OuiWZOQveoYtJ7AbV9zt1XV5+XVkSR
 RpXw1rVw7ApXDQv+78ds8fbKRNYvcD4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-427AufUHMlKJpr7rG9IUmg-1; Tue, 12 Sep 2023 03:39:21 -0400
X-MC-Unique: 427AufUHMlKJpr7rG9IUmg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500b5dbf113so5427075e87.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694504360; x=1695109160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmEyY93Ck8WkDOQRoCLqGrbPgTcfdcNt9t1RcylOzYQ=;
 b=j4T/fl8Gb66rUuq71t6lduSRBaIdCFzxvU/S84Pq4FJ7TY1EfCuAHsUjVqruAKBCz0
 J0zU2UcCAyC7PC5vTKtE7KtP9I8GiM5XdfG1mjqEkMYBAdBzIlz9dOZnOGjnRbJ7Qo+s
 gHZUX9K95G3X+Zjy409ZFW3uOpIB33ih7CymXe6O1WnzWpSbPlNjwAlZX9KNaLEqaIa+
 NDiLE8B0wipwiO+JQTnF86mvTRU3sJFeQ85e/+gs0oNbX8z66tp7B+C4gEJ2YB/R49gg
 wE8PUJO1BFTanxE9pQI6oyEawnBEBMoHjq44G0InqV3fvRENgjP8TizKKwlXwPt1F7iw
 pP0A==
X-Gm-Message-State: AOJu0YwlGIyy40gPEQj5iCPO8qqYpKguNHuygAs6hTl8raQSB4FiXKTT
 qaL5/I9De94w6ZZ88TZXO32WRKBoeeWryoI85+yqRcXtRzvWtRJQnnCnuF+vUVCelF741x+H/i+
 27bGdXgmqWkjVoA8CAagm9RgAzcmeek0sh5OH3rfkk+cjteeWJlYuOB8t9g==
X-Received: by 2002:a05:6512:2316:b0:502:adbc:9b74 with SMTP id
 o22-20020a056512231600b00502adbc9b74mr7946545lfu.68.1694504360155; 
 Tue, 12 Sep 2023 00:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5gCC4PBq6IeJnmSasULynPErX2GOpzHNHa9ZcLnpFdOr478ISKQkds33cuYD+0XpwR2uPx/pX3MJrAV2owaA=
X-Received: by 2002:a05:6512:2316:b0:502:adbc:9b74 with SMTP id
 o22-20020a056512231600b00502adbc9b74mr7946526lfu.68.1694504359782; Tue, 12
 Sep 2023 00:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-4-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 15:39:08 +0800
Message-ID: <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 maxime.coquelin@redhat.com
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTE6MDDigK9BTSBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEluIFZEVVNFX1ZRX0dFVF9JTkZPLCB0aGUgZHJpdmVyIHdpbGwgc3lu
YyB0aGUgbGFzdF9hdmFpbF9pZHgKPiB3aXRoIHJlY29ubmVjdCBpbmZvLCBBZnRlciBtYXBwaW5n
IHRoZSByZWNvbm5lY3QgcGFnZXMgdG8gdXNlcnNwYWNlCj4gVGhlIHVzZXJzcGFjZSBBcHAgd2ls
bCB1cGRhdGUgdGhlIHJlY29ubmVjdF90aW1lIGluCj4gc3RydWN0IHZob3N0X3JlY29ubmVjdF92
cmluZywgSWYgdGhpcyBpcyBub3QgMCB0aGVuIGl0IG1lYW5zIHRoaXMKPiB2cSBpcyByZWNvbm5l
Y3RlZCBhbmQgd2lsbCB1cGRhdGUgdGhlIGxhc3RfYXZhaWxfaWR4Cj4KPiBTaWduZWQtb2ZmLWJ5
OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV91
c2VyL3ZkdXNlX2Rldi5jIHwgMTMgKysrKysrKysrKysrKwo+ICBpbmNsdWRlL3VhcGkvbGludXgv
dmR1c2UuaCAgICAgICAgIHwgIDYgKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2
LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gaW5kZXggMmM2OWY0MDA0
YTZlLi42ODBiMjNkYmRkZTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92
ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBA
QCAtMTIyMSw2ICsxMjIxLDggQEAgc3RhdGljIGxvbmcgdmR1c2VfZGV2X2lvY3RsKHN0cnVjdCBm
aWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1
c2VfdnFfaW5mbyB2cV9pbmZvOwo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfdmlydHF1
ZXVlICp2cTsKPiAgICAgICAgICAgICAgICAgdTMyIGluZGV4Owo+ICsgICAgICAgICAgICAgICBz
dHJ1Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyAqYXJlYTsKPiArICAgICAgICAgICAgICAgc3RydWN0
IHZob3N0X3JlY29ubmVjdF92cmluZyAqdnFfcmVjb25uZWN0Owo+Cj4gICAgICAgICAgICAgICAg
IHJldCA9IC1FRkFVTFQ7Cj4gICAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmdnFf
aW5mbywgYXJncCwgc2l6ZW9mKHZxX2luZm8pKSkKPiBAQCAtMTI1Miw2ICsxMjU0LDE3IEBAIHN0
YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50
IGNtZCwKPgo+ICAgICAgICAgICAgICAgICB2cV9pbmZvLnJlYWR5ID0gdnEtPnJlYWR5Owo+Cj4g
KyAgICAgICAgICAgICAgIGFyZWEgPSAmdnEtPnJlY29ubmVjdF9pbmZvOwo+ICsKPiArICAgICAg
ICAgICAgICAgdnFfcmVjb25uZWN0ID0gKHN0cnVjdCB2aG9zdF9yZWNvbm5lY3RfdnJpbmcgKilh
cmVhLT52YWRkcjsKPiArICAgICAgICAgICAgICAgLypjaGVjayBpZiB0aGUgdnEgaXMgcmVjb25u
ZWN0LCBpZiB5ZXMgdGhlbiB1cGRhdGUgdGhlIGxhc3RfYXZhaWxfaWR4Ki8KPiArICAgICAgICAg
ICAgICAgaWYgKCh2cV9yZWNvbm5lY3QtPmxhc3RfYXZhaWxfaWR4ICE9Cj4gKyAgICAgICAgICAg
ICAgICAgICAgdnFfaW5mby5zcGxpdC5hdmFpbF9pbmRleCkgJiYKPiArICAgICAgICAgICAgICAg
ICAgICh2cV9yZWNvbm5lY3QtPnJlY29ubmVjdF90aW1lICE9IDApKSB7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgdnFfaW5mby5zcGxpdC5hdmFpbF9pbmRleCA9Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2cV9yZWNvbm5lY3QtPmxhc3RfYXZhaWxfaWR4Owo+ICsgICAgICAg
ICAgICAgICB9Cj4gKwo+ICAgICAgICAgICAgICAgICByZXQgPSAtRUZBVUxUOwo+ICAgICAgICAg
ICAgICAgICBpZiAoY29weV90b191c2VyKGFyZ3AsICZ2cV9pbmZvLCBzaXplb2YodnFfaW5mbykp
KQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3VhcGkvbGludXgvdmR1c2UuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oCj4gaW5kZXgg
MTFiZDQ4YzcyYzZjLi5kNTg1NDI1ODAzZmQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZkdXNlLmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaAo+IEBAIC0zNTAs
NCArMzUwLDEwIEBAIHN0cnVjdCB2ZHVzZV9kZXZfcmVzcG9uc2Ugewo+ICAgICAgICAgfTsKPiAg
fTsKPgo+ICtzdHJ1Y3Qgdmhvc3RfcmVjb25uZWN0X3ZyaW5nIHsKPiArICAgICAgIF9fdTE2IHJl
Y29ubmVjdF90aW1lOwo+ICsgICAgICAgX191MTYgbGFzdF9hdmFpbF9pZHg7Cj4gKyAgICAgICBf
Qm9vbCBhdmFpbF93cmFwX2NvdW50ZXI7CgpQbGVhc2UgYWRkIGEgY29tbWVudCBmb3IgZWFjaCBm
aWVsZC4KCkFuZCBJIG5ldmVyIHNhdyBfQm9vbCBpcyB1c2VkIGluIHVhcGkgYmVmb3JlLCBtYXli
ZSBpdCdzIGJldHRlciB0bwpwYWNrIGl0IHdpdGggbGFzdF9hdmFpbF9pZHggaW50byBhIF9fdTMy
LgoKQnR3LCBkbyB3ZSBuZWVkIHRvIHRyYWNrIGluZmxpZ2h0IGRlc2NyaXB0b3JzIGFzIHdlbGw/
CgpUaGFua3MKCj4gK307Cj4gKwo+ICAjZW5kaWYgLyogX1VBUElfVkRVU0VfSF8gKi8KPiAtLQo+
IDIuMzQuMwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
