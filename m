Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A03C433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 10:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE88A4102A;
	Thu, 24 Mar 2022 10:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nyddU3q2rlNF; Thu, 24 Mar 2022 10:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F3104102C;
	Thu, 24 Mar 2022 10:41:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80808C001A;
	Thu, 24 Mar 2022 10:41:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CABEC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8FCD4102C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKtXLgxkIcyn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:41:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C15264102A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648118481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OvBKk/+HLZmNRskDmekTHB534l4JPKA4u8XTXdTGyQ=;
 b=GLipVtTIKvJx1Apk7P1EjIJguyLYwJY3dYUEY8lbKWZ1XowgTcKvBsIrYOow181XhQ6JnM
 cM2it9ETR+vromRgYhiqIS1Z/a9Nj669bD8sJV2zPadDvqIH8cNQL6zW8pY/sTvJJthglM
 MyE15+JJuQDO+Vr3zS6EaAbK/rS6qLA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-A6xatQRIP_-8ZHwxoWmEIA-1; Thu, 24 Mar 2022 06:41:20 -0400
X-MC-Unique: A6xatQRIP_-8ZHwxoWmEIA-1
Received: by mail-wr1-f69.google.com with SMTP id
 p16-20020adfc390000000b00204006989c2so1538247wrf.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 03:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8OvBKk/+HLZmNRskDmekTHB534l4JPKA4u8XTXdTGyQ=;
 b=lyx2zJ2CvfJ3mFQsvEeBMzW5E12g/9BUdfi6DXG2k4cXtttkynRCpeM/RINR+e/AkV
 PSoA+XdeFKR5vIgVKYxgRbvEo/58+pJIhNdNEWi4GAP6gUDgBQ98OZcCCLGQRzqR04G+
 LAkBphhRg7eRkuhDZR7Dl/i7tS3pMtLFTZcdDvbtKUDgZYFnoNU+E1AiEzXdBbKmhoww
 KYzhm+XeskAmccaWUbqDSCMUmbp4Xy68u6A/YF7BDD47Wl+JZM/L7+NQozVDkDAp6VYB
 GMBfVSV5h881yjJdZzQxcdkXC7dz09S+7Ivekucuf9Agb/TCFDnJ6rFDzQ2OLLLn+cmS
 +ySQ==
X-Gm-Message-State: AOAM530RA6ONMUKLycZ5iU+lBKTD8yrCiCEdYqzlf9D4QTQqB9+7BN/Q
 0wsd23UAOhULU5yRhIi5+fdcPRs40d0w22Ye2mEkMYNlL1EfkaY6zVo4rTgvVTvdrCzut3Yn6DY
 JcHc08MbNuimW1FrF3Sq/KkqQZbxem7LIjoS3KN4D/Q==
X-Received: by 2002:a5d:588c:0:b0:205:7f17:3901 with SMTP id
 n12-20020a5d588c000000b002057f173901mr4013057wrf.359.1648118479193; 
 Thu, 24 Mar 2022 03:41:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6MexWfBe1P56SU4SL1cOl7ph2su9545mGcG+WgBu99yzVzrPwubKoaLoLbd6EFDGKjjxqrg==
X-Received: by 2002:a5d:588c:0:b0:205:7f17:3901 with SMTP id
 n12-20020a5d588c000000b002057f173901mr4013033wrf.359.1648118478935; 
 Thu, 24 Mar 2022 03:41:18 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 a11-20020a056000188b00b00204109f7826sm2515734wri.28.2022.03.24.03.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 03:41:14 -0700 (PDT)
Date: Thu, 24 Mar 2022 06:41:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 16/16] virtio_ring: introduce virtqueue_resize()
Message-ID: <20220324063723-mutt-send-email-mst@kernel.org>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
 <e61a9ff4-621b-e7ec-b819-1b4c7e38fa67@redhat.com>
 <1648110896.1444745-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1648110896.1444745-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gVGh1LCBNYXIgMjQsIDIwMjIgYXQgMDQ6MzQ6NTZQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIFR1ZSwgMjIgTWFyIDIwMjIgMTQ6MDI6NDcgKzA4MDAsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAyMDIyLzMvMTQg5LiL5Y2INTozNCwg
WHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gSW50cm9kdWNlIHZpcnRxdWV1ZV9yZXNpemUoKSB0byBp
bXBsZW1lbnQgdGhlIHJlc2l6ZSBvZiB2cmluZy4KPiA+ID4gQmFzZWQgb24gdGhlc2UsIHRoZSBk
cml2ZXIgY2FuIGR5bmFtaWNhbGx5IGFkanVzdCB0aGUgc2l6ZSBvZiB0aGUgdnJpbmcuCj4gPiA+
IEZvciBleGFtcGxlOiBldGh0b29sIC1HLgo+ID4gPgo+ID4gPiB2aXJ0cXVldWVfcmVzaXplKCkg
aW1wbGVtZW50cyByZXNpemUgYmFzZWQgb24gdGhlIHZxIHJlc2V0IGZ1bmN0aW9uLiBJbgo+ID4g
PiBjYXNlIG9mIGZhaWx1cmUgdG8gYWxsb2NhdGUgYSBuZXcgdnJpbmcsIGl0IHdpbGwgZ2l2ZSB1
cCByZXNpemUgYW5kIHVzZQo+ID4gPiB0aGUgb3JpZ2luYWwgdnJpbmcuCj4gPiA+Cj4gPiA+IER1
cmluZyB0aGlzIHByb2Nlc3MsIGlmIHRoZSByZS1lbmFibGUgcmVzZXQgdnEgZmFpbHMsIHRoZSB2
cSBjYW4gbm8KPiA+ID4gbG9uZ2VyIGJlIHVzZWQuIEFsdGhvdWdoIHRoZSBwcm9iYWJpbGl0eSBv
ZiB0aGlzIHNpdHVhdGlvbiBpcyBub3QgaGlnaC4KPiA+ID4KPiA+ID4gVGhlIHBhcmFtZXRlciBy
ZWN5Y2xlIGlzIHVzZWQgdG8gcmVjeWNsZSB0aGUgYnVmZmVyIHRoYXQgaXMgbm8gbG9uZ2VyCj4g
PiA+IHVzZWQuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4g
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDMgKysKPiA+ID4gICAyIGZpbGVzIGNo
YW5nZWQsIDcwIGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+
IGluZGV4IGZiMGFiZjlhMmY1Ny4uYjFkZGUwODZhOGE0IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+ID4gQEAgLTI1MjgsNiArMjUyOCw3MyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICp2
cmluZ19jcmVhdGVfdmlydHF1ZXVlKAo+ID4gPiAgIH0KPiA+ID4gICBFWFBPUlRfU1lNQk9MX0dQ
TCh2cmluZ19jcmVhdGVfdmlydHF1ZXVlKTsKPiA+ID4KPiA+ID4gKy8qKgo+ID4gPiArICogdmly
dHF1ZXVlX3Jlc2l6ZSAtIHJlc2l6ZSB0aGUgdnJpbmcgb2YgdnEKPiA+ID4gKyAqIEB2cTogdGhl
IHN0cnVjdCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4KPiA+ID4gKyAqIEBudW06IG5l
dyByaW5nIG51bQo+ID4gPiArICogQHJlY3ljbGU6IGNhbGxiYWNrIGZvciByZWN5Y2xlIHRoZSB1
c2VsZXNzIGJ1ZmZlcgo+ID4gPiArICoKPiA+ID4gKyAqIFdoZW4gaXQgaXMgcmVhbGx5IG5lY2Vz
c2FyeSB0byBjcmVhdGUgYSBuZXcgdnJpbmcsIGl0IHdpbGwgc2V0IHRoZSBjdXJyZW50IHZxCj4g
PiA+ICsgKiBpbnRvIHRoZSByZXNldCBzdGF0ZS4gVGhlbiBjYWxsIHRoZSBwYXNzZWQgY2IgdG8g
cmVjeWNsZSB0aGUgYnVmZmVyIHRoYXQgaXMKPiA+ID4gKyAqIG5vIGxvbmdlciB1c2VkLiBPbmx5
IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMgc3VjY2Vzc2Z1bGx5IGNyZWF0ZWQsIHRoZSBvbGQKPiA+
ID4gKyAqIHZyaW5nIHdpbGwgYmUgcmVsZWFzZWQuCj4gPiA+ICsgKgo+ID4gPiArICogQ2FsbGVy
IG11c3QgZW5zdXJlIHdlIGRvbid0IGNhbGwgdGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVy
YXRpb25zCj4gPiA+ICsgKiBhdCB0aGUgc2FtZSB0aW1lIChleGNlcHQgd2hlcmUgbm90ZWQpLgo+
ID4gPiArICoKPiA+ID4gKyAqIFJldHVybnMgemVybyBvciBhIG5lZ2F0aXZlIGVycm9yLgo+ID4g
PiArICogLUVOT01FTTogY3JlYXRlIG5ldyB2cmluZyBmYWlsLiBCdXQgdnEgY2FuIHN0aWxsIHdv
cmsKPiA+ID4gKyAqIC1FQlVTWTogIHJlc2V0L3JlLWVuYWJsZSB2cSBmYWlsLiB2cSBtYXkgY2Fu
bm90IHdvcmsKPiA+ID4gKyAqIC1FTk9FTlQ6IG5vdCBzdXBwb3J0IHJlc2l6ZQo+ID4gPiArICog
LUUyQklHLy1FSU5WQUw6IHBhcmFtIG51bSBlcnJvcgo+ID4gPiArICovCj4gPiA+ICtpbnQgdmly
dHF1ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdTMyIG51bSwKPiA+ID4gKwkJICAg
ICB2b2lkICgqcmVjeWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikpCj4gPiA+
ICt7Cj4gPiA+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSB2cS0+dmRldjsKPiA+ID4g
Kwl2b2lkICpidWY7Cj4gPiA+ICsJaW50IGVycjsKPiA+ID4gKwo+ID4gPiArCWlmIChudW0gPiB2
cS0+bnVtX21heCkKPiA+ID4gKwkJcmV0dXJuIC1FMkJJRzsKPiA+ID4gKwo+ID4gPiArCWlmICgh
bnVtKQo+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ID4gKwo+ID4gPiArCWlmICh0b192dnEo
dnEpLT5wYWNrZWQudnJpbmcubnVtID09IG51bSkKPiA+ID4gKwkJcmV0dXJuIDA7Cj4gPgo+ID4K
PiA+IEFueSByZWFzb24gd2UgbmVlZCB0byBjaGVjayBhIHBhY2tlZCBzcGVjaWZpYyBhdHRyaWJ1
dGUgaGVyZT8KPiAKPiBUaGlzIGlzIGEgbWlzdGFrZS4gU29ycnkgZm9yIHRoaXMuCj4gCj4gPgo+
ID4KPiA+ID4gKwo+ID4gPiArCWlmICghdnEtPnZkZXYtPmNvbmZpZy0+cmVzZXRfdnEpCj4gPiA+
ICsJCXJldHVybiAtRU5PRU5UOwo+ID4gPiArCj4gPiA+ICsJaWYgKCF2cS0+dmRldi0+Y29uZmln
LT5lbmFibGVfcmVzZXRfdnEpCj4gPiA+ICsJCXJldHVybiAtRU5PRU5UOwo+ID4gPiArCj4gPiA+
ICsJZXJyID0gdnEtPnZkZXYtPmNvbmZpZy0+cmVzZXRfdnEodnEpOwo+ID4gPiArCWlmIChlcnIp
IHsKPiA+ID4gKwkJaWYgKGVyciAhPSAtRU5PRU5UKQo+ID4gPiArCQkJZXJyID0gLUVCVVNZOwo+
ID4gPiArCQlyZXR1cm4gZXJyOwo+ID4gPiArCX0KPiA+ID4gKwo+ID4gPiArCXdoaWxlICgoYnVm
ID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKHZxKSkgIT0gTlVMTCkKPiA+ID4gKwkJcmVj
eWNsZSh2cSwgYnVmKTsKPiA+ID4gKwo+ID4gPiArCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRl
diwgVklSVElPX0ZfUklOR19QQUNLRUQpKQo+ID4gPiArCQllcnIgPSB2aXJ0cXVldWVfcmVzaXpl
X3BhY2tlZCh2cSwgbnVtKTsKPiA+ID4gKwllbHNlCj4gPiA+ICsJCWVyciA9IHZpcnRxdWV1ZV9y
ZXNpemVfc3BsaXQodnEsIG51bSk7Cj4gPiA+ICsKPiA+ID4gKwlpZiAoZXJyKQo+ID4gPiArCQll
cnIgPSAtRU5PTUVNOwo+ID4KPiA+Cj4gPiBTbyB0aGlzIGFzc3VtZXMgdGhhdCB0aGUgLUVOT01F
TSBpcyB0aGUgb25seSBwb3NzaWJsZSBlcnJvciB2YWx1ZSBmb3IKPiA+IHZpcnRxdWV1ZV9yZXNp
emVfeHh4KCkuIElzIHRoaXMgdHJ1ZT8gKEUuZyB3cm9uZyBzaXplKQo+IAo+IFllcywgSSB3YW50
IHRoZSB1c2VyIHRvIGtub3cgYXQgd2hpY2ggc3RlcCB0aGUgZXJyb3IgaXMgcmV0dXJuZWQuCj4g
Cj4gPgo+ID4KPiA+ID4gKwo+ID4gPiArCWlmICh2cS0+dmRldi0+Y29uZmlnLT5lbmFibGVfcmVz
ZXRfdnEodnEpKQo+ID4gPiArCQlyZXR1cm4gLUVCVVNZOwo+ID4gPiArCj4gPiA+ICsJcmV0dXJu
IGVycjsKPiA+ID4gK30KPiA+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9yZXNpemUp
Owo+ID4gPiArCj4gPiA+ICAgLyogT25seSBhdmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiA+
ID4gICBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBp
bmRleCwKPiA+ID4gICAJCQkJICAgICAgdW5zaWduZWQgaW50IG51bSwKPiA+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+
IGluZGV4IGQ1OWFkYzRiZTA2OC4uYzg2ZmYwMmUwY2EwIDEwMDY0NAo+ID4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+
ID4gQEAgLTkxLDYgKzkxLDkgQEAgZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRkcihz
dHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPiA+ICAgZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2F2
YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gPiAgIGRtYV9hZGRyX3QgdmlydHF1
ZXVlX2dldF91c2VkX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ID4gPgo+ID4gPiAraW50
IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUzMiBudW0sCj4gPiA+ICsJ
CSAgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpKTsK
PiA+Cj4gPgo+ID4gSSB3b25kZXIgd2hhdCdzIHRoZSBhZHZhbnRhZ2VzIG9mIGNvdXBsaW5nIHZp
cnRxdWV1ZV9yZXNldCBpbgo+ID4gdmlydHF1ZXVlX3Jlc2l6ZSgpLgo+IAo+IFRoaXMgaXMgTWlj
aGFlbCdzIGNvbW1lbnQgb24gdGhlIHByZXZpb3VzIHZlcnNpb24KPiAKPiA+Cj4gPiBJdCBsb29r
cyB0byBtZSBpdCB3b2xkIGJlIG1vcmUgZmxleGlibGUgdG8gbGV0IHRoZSBkcml2ZXIgZG86Cj4g
Pgo+ID4gcmVzdCgpCj4gPgo+ID4gZGV0YWNoKCkKPiA+Cj4gPiByZXNpemUoKQo+ID4KPiA+IGVu
YWJsZV9yZXNldCgpCj4gPgo+ID4gT25lIHJlYXNvbiBpcyB0aGF0IGluIHRoZSBmdXR1cmUgd2Ug
bWF5IHdhbnQgdG8gYWRkIG1vcmUgZnVuY3Rpb25hbGl0eQo+ID4gZS5nIHN3aXRjaGluZyBQQVNJ
RCBkdXJpbmcgdmlydHF1ZXVlIHJlc2V0Lgo+IAo+IE1pY2hhZWwsIGZyb20gSmFzb24gV2FuZydz
IHBsYW4sIHNob3VsZCB3ZSBnbyBiYWNrIHRvIHRoZSBvcmlnaW5hbCA0IGFwaSBtb2RlbD8KPiAK
PiBUaGFua3MuCgoKSmFzb24sIEkgZmVlbCBhIHNpbmdsZSBhcGkgaXMgcHJlZmVyYWJsZSwgYmVj
YXVzZSB0aGUgbmVlZCB0byBkbyByZXNldAphcyBwYXJ0IG9mIHJlc2l6ZSBpcyBhbiBpbXBsZW1l
bnRhdGlvbiBkZXRhaWwsIEkgY2FuIGVhc2lseQppbWFnaW5lIHZpcnRpbyBzcGVjIGJlaW5nIGV4
dGVuZGVkIHdpdGggYSByZXNpemUgaW50ZXJmYWNlCndoaWNoIGRvZXMgbm90IHJlcXVpcmUgYSBx
dWV1ZSByZXNldC4KCk1ha2VzIHNlbnNlIHRvIHlvdT8KCj4gCj4gPgo+ID4gVGhhbmtzCj4gPgo+
ID4KPiA+ID4gKwo+ID4gPiAgIC8qKgo+ID4gPiAgICAqIHZpcnRpb19kZXZpY2UgLSByZXByZXNl
bnRhdGlvbiBvZiBhIGRldmljZSB1c2luZyB2aXJ0aW8KPiA+ID4gICAgKiBAaW5kZXg6IHVuaXF1
ZSBwb3NpdGlvbiBvbiB0aGUgdmlydGlvIGJ1cwo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
