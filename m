Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19711C7EE24
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 06:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90EDB42A32;
	Thu, 18 May 2023 06:52:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90EDB42A32
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i1HYo2Xf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOMGIpbEAPXk; Thu, 18 May 2023 06:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CFDED402A8;
	Thu, 18 May 2023 06:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFDED402A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A18F1C008E;
	Thu, 18 May 2023 06:52:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FBAEC008D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37A4260F1F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37A4260F1F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i1HYo2Xf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6KW_lvbD7C6T
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67EEC60E79
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67EEC60E79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684392718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkFIO4JB0kCKLYorwk2Xk7z2g3UGzgq7ytGmS0GYkoA=;
 b=i1HYo2XfEB7OSNlL187OouHHrNvdl9h163u8c9r7+3P03HDvhRuSPMvFur5q6uN7kcj+HP
 a3ea7pEGBL4OwHML+F9q0xkh3NbpAkB1AT2LjWQm9YJ2k0W/bs6MtfPrdHphQD4+/7ffUZ
 enUhDSx0FjYubEhBVEEiICnd0f1F6zE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-WdqAvW4NNm-OLy7sm5cDDw-1; Thu, 18 May 2023 02:51:57 -0400
X-MC-Unique: WdqAvW4NNm-OLy7sm5cDDw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f397572596so1016316e87.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 23:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684392716; x=1686984716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkFIO4JB0kCKLYorwk2Xk7z2g3UGzgq7ytGmS0GYkoA=;
 b=H5KmBHSQv7rcYKGKyileY61guA4NesRzXDfaB8Q+kCrBZDFydDMSWrFXipqrKP1OJR
 VFunyCS6Zu/DQQNGKyeyUItHuPUGLRLlOmAyk3qoubSdbW50Kyykfze8MZNQg9fh2sTv
 jqiVAGkc06YIhyyNvg0bj3OMCaGxddHi5s4fcaSSQz5o2uPnCyDCIZaficqtQGydFKYV
 2CxwpCnqOGE+Hcb6ZPwZeyfbhgbiMn+B8On+TsNupxC55LTRhLt5AECaavXQ3fc26JYg
 GJpWplNGxcCjA4FMyVgtwAIIBN1IqebW5VJmxJU7A8ZQkudoj+A7O4IgsKMMJE/7hCBu
 Xa5Q==
X-Gm-Message-State: AC+VfDwMHKZ4JV/xugyoWj2ik0zdPeA00awX5VZKo7uROIvwowCbG3YQ
 CrPgPK66MMm55n+nFPwvyzFNX0s2ji/bJKmRNX2rTjPN5W+A35AG26dozF0cWuE8ldyIuMRpchT
 XALF2rfanTirgHfEvdhz7t7AsIm5Ld9r7rZ2YzObZezJnAt0aWRKJcrRI0g==
X-Received: by 2002:ac2:4acd:0:b0:4f2:4df1:9718 with SMTP id
 m13-20020ac24acd000000b004f24df19718mr938894lfp.17.1684392715985; 
 Wed, 17 May 2023 23:51:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QdGVGArRB7rfrXFrbKqrEIqAHdNXYdYFM9RGy5fPFe5tnY2BtxBe27Z2Y1B7hq/zEmWcn4z2ooZMgj5n8kok=
X-Received: by 2002:ac2:4acd:0:b0:4f2:4df1:9718 with SMTP id
 m13-20020ac24acd000000b004f24df19718mr938887lfp.17.1684392715690; Wed, 17 May
 2023 23:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
 <20230517022249.20790-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230517022249.20790-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 14:51:44 +0800
Message-ID: <CACGkMEvcXvtz99mLyOvtTJh1swbLR4e8M=B0k3BdK+-Pdy-bFQ@mail.gmail.com>
Subject: Re: [PATCH vhost v9 02/12] virtio_ring: simplify the reference of
 desc state inside detach_buf_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMTA6MjPigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IFRoZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8gc2lt
cGxpZnkgdGhlIHJlZmVyZW5jZSB0byBzdGF0ZS4gSXQgaXMKPiBjb252ZW5pZW50IGZvciBzdWJz
ZXF1ZW50IGNvbW1pdC4KCkl0J3MgYmV0dGVyIHRvIGJlIHZlcmJvc2UsIGUuZyBob3cgaXQgY2Fu
IHNpbXBsaWZ5IHRoZSBmb2xsb3dpbmcgcGF0Y2hlcy4KClRoYW5rcwoKCj4KPiBTaWduZWQtb2Zm
LWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTIgKysrKysrKy0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiBpbmRleCBjNTYzMjE1YmU2YjkuLjQ3OTIwMzM0NmMzNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+IEBAIC03NDQsMTEgKzc0NCwxNCBAQCBzdGF0aWMgYm9vbCB2aXJ0cXVldWVfa2lja19wcmVw
YXJlX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgc3RhdGljIHZvaWQgZGV0YWNoX2J1
Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQsCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICoqY3R4KQo+ICB7Cj4gKyAgICAgICBz
dHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqc3RhdGU7Cj4gICAgICAgICB1bnNpZ25lZCBp
bnQgaSwgajsKPiAgICAgICAgIF9fdmlydGlvMTYgbmV4dGZsYWcgPSBjcHVfdG9fdmlydGlvMTYo
dnEtPnZxLnZkZXYsIFZSSU5HX0RFU0NfRl9ORVhUKTsKPgo+ICsgICAgICAgc3RhdGUgPSAmdnEt
PnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF07Cj4gKwo+ICAgICAgICAgLyogQ2xlYXIgZGF0YSBwdHIu
ICovCj4gLSAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5kYXRhID0gTlVMTDsKPiAr
ICAgICAgIHN0YXRlLT5kYXRhID0gTlVMTDsKPgo+ICAgICAgICAgLyogUHV0IGJhY2sgb24gZnJl
ZSBsaXN0OiB1bm1hcCBmaXJzdC1sZXZlbCBkZXNjcmlwdG9ycyBhbmQgZmluZCBlbmQgKi8KPiAg
ICAgICAgIGkgPSBoZWFkOwo+IEBAIC03NjcsOCArNzcwLDcgQEAgc3RhdGljIHZvaWQgZGV0YWNo
X2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQs
Cj4gICAgICAgICB2cS0+dnEubnVtX2ZyZWUrKzsKPgo+ICAgICAgICAgaWYgKHZxLT5pbmRpcmVj
dCkgewo+IC0gICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzYyAqaW5kaXJfZGVzYyA9Cj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFk
XS5pbmRpcl9kZXNjOwo+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzYyAqaW5kaXJf
ZGVzYyA9IHN0YXRlLT5pbmRpcl9kZXNjOwo+ICAgICAgICAgICAgICAgICB1MzIgbGVuOwo+Cj4g
ICAgICAgICAgICAgICAgIC8qIEZyZWUgdGhlIGluZGlyZWN0IHRhYmxlLCBpZiBhbnksIG5vdyB0
aGF0IGl0J3MgdW5tYXBwZWQuICovCj4gQEAgLTc4NSw5ICs3ODcsOSBAQCBzdGF0aWMgdm9pZCBk
ZXRhY2hfYnVmX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCBpbnQg
aGVhZCwKPiAgICAgICAgICAgICAgICAgICAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5k
aXJlY3QodnEsICZpbmRpcl9kZXNjW2pdKTsKPgo+ICAgICAgICAgICAgICAgICBrZnJlZShpbmRp
cl9kZXNjKTsKPiAtICAgICAgICAgICAgICAgdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5k
aXJfZGVzYyA9IE5VTEw7Cj4gKyAgICAgICAgICAgICAgIHN0YXRlLT5pbmRpcl9kZXNjID0gTlVM
TDsKPiAgICAgICAgIH0gZWxzZSBpZiAoY3R4KSB7Cj4gLSAgICAgICAgICAgICAgICpjdHggPSB2
cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5pbmRpcl9kZXNjOwo+ICsgICAgICAgICAgICAgICAq
Y3R4ID0gc3RhdGUtPmluZGlyX2Rlc2M7Cj4gICAgICAgICB9Cj4gIH0KPgo+IC0tCj4gMi4zMi4w
LjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
