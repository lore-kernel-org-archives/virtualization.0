Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B7FE95A8E
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 04:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C4F82CA5;
	Sun,  8 Oct 2023 04:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5C4F82CA5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6l4pr8y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jlvnAV12noWO; Sun,  8 Oct 2023 04:37:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A92D82C35;
	Sun,  8 Oct 2023 04:37:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A92D82C35
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 505FBC0071;
	Sun,  8 Oct 2023 04:37:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E359C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46F754193E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:37:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46F754193E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B6l4pr8y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFlO9gePRD53
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:37:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A44441927
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:37:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A44441927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696739836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvtyRRz+nwNRt7FvkUoa8BCNkTJILEam9tMkM/HCha0=;
 b=B6l4pr8yQzXZ/JR/fj9i8U3rdeJoIBERalTxYo3XhlCLPysUCw2OzrYCKPHp9RkiFoG/Sk
 VOGM/C+cguuv4/yNVZsBKA04RvMX7h7XhFWhMzz3wQmTRj2fx3FNuHUoSdVQWqsrsyCmV0
 ayU8Ozsr9bobnJC9MZlpX+wYulvU6BY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-qvWf9cwTNLOZ1Gg6ZK5jPw-1; Sun, 08 Oct 2023 00:37:13 -0400
X-MC-Unique: qvWf9cwTNLOZ1Gg6ZK5jPw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5042bc93273so3032941e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 21:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696739832; x=1697344632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvtyRRz+nwNRt7FvkUoa8BCNkTJILEam9tMkM/HCha0=;
 b=sG4qL8KHT1AGUlEz+pI51QeBSkxE6ACZ/CiJtGphyqzcAdZDxEn3uutXrdHVgN3tKd
 Vu9QE2giLfDIDTFBH3ctJXFrdKbqAsaOUkiFVA14Rw5rsoJ6BbRkAfTtK7ROdmITITGg
 twwlRCfI9/gyTMfR//kqWF+t9EkabUDmO4t3tM2TA5Cnen5y6fAup555/IsAD1co21Cc
 b8MWQFrE35Szd4qfaQYyne9xfib5vNSewvM44g+D5CnR3NMkAcuZuXp7aZzSeI7JOtAR
 52yVh6s6mY/f+TiqVWEM+QFylADVPfRv8RNgo0qK2TisqVTu1gZUy3U4b/q4k1ci9cJp
 WfYw==
X-Gm-Message-State: AOJu0YwDvpGeT5CavF+xPLmf2o2oqg9h3evFGmJmCJEtIkQ07HO69avK
 MSyBOYhQBucFDXlBaiWjdm2I7EyH5fExgstiBxCDa4xcLz2wzUTiT+LG4ms3w9xm3LiKzmtJ0ec
 H5AwasUYI0FcC6M8RvQSVaUbX5TwN7W8PxYY7kCZVEBJux0rqaPrDIkWksw==
X-Received: by 2002:ac2:4c9b:0:b0:500:9a15:9054 with SMTP id
 d27-20020ac24c9b000000b005009a159054mr8820043lfl.20.1696739831934; 
 Sat, 07 Oct 2023 21:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbwdFniTDysoOdy55vJ9mvDY2iLbB22GYbgOhSxJ2xBXcK3O2G6gfgJld3IG0br8gYtQV4XFjb14Blx0X7c18=
X-Received: by 2002:ac2:4c9b:0:b0:500:9a15:9054 with SMTP id
 d27-20020ac24c9b000000b005009a159054mr8820036lfl.20.1696739831548; Sat, 07
 Oct 2023 21:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20230926050021.717-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:37:00 +0800
Message-ID: <CACGkMEtF7hZ8kGYi8rF68SzZqdYJ6i1SeuVU2hiBTY-FLapSBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/virtio: Add dma sync api for virtio test
To: liming.wu@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: 398776277@qq.com, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTowMOKAr1BNIDxsaW1pbmcud3VAamFndWFybWljcm8u
Y29tPiB3cm90ZToKPgo+IEZyb206IExpbWluZyBXdSA8bGltaW5nLnd1QGphZ3Vhcm1pY3JvLmNv
bT4KPgo+IEZpeGVzOiA4YmQyZjcxMDU0YmQgKCJ2aXJ0aW9fcmluZzogaW50cm9kdWNlIGRtYSBz
eW5jIGFwaSBmb3IgdmlydHF1ZXVlIikKPiBhbHNvIGFkZCBkbWEgc3luYyBhcGkgZm9yIHZpcnRp
byB0ZXN0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTGltaW5nIFd1IDxsaW1pbmcud3VAamFndWFybWlj
cm8uY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFu
a3MKCj4gLS0tCj4gIHRvb2xzL3ZpcnRpby9saW51eC9kbWEtbWFwcGluZy5oIHwgMTIgKysrKysr
KysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvdmlydGlvL2xpbnV4L2RtYS1tYXBwaW5nLmggYi90b29scy92aXJ0aW8vbGludXgv
ZG1hLW1hcHBpbmcuaAo+IGluZGV4IDgzNGE5MGJkMzI3MC4uODIyZWNhYThlNGRmIDEwMDY0NAo+
IC0tLSBhL3Rvb2xzL3ZpcnRpby9saW51eC9kbWEtbWFwcGluZy5oCj4gKysrIGIvdG9vbHMvdmly
dGlvL2xpbnV4L2RtYS1tYXBwaW5nLmgKPiBAQCAtMjQsMTEgKzI0LDIzIEBAIGVudW0gZG1hX2Rh
dGFfZGlyZWN0aW9uIHsKPiAgI2RlZmluZSBkbWFfbWFwX3BhZ2UoZCwgcCwgbywgcywgZGlyKSAo
cGFnZV90b19waHlzKHApICsgKG8pKQo+Cj4gICNkZWZpbmUgZG1hX21hcF9zaW5nbGUoZCwgcCwg
cywgZGlyKSAodmlydF90b19waHlzKHApKQo+ICsjZGVmaW5lIGRtYV9tYXBfc2luZ2xlX2F0dHJz
KGQsIHAsIHMsIGRpciwgYSkgKHZpcnRfdG9fcGh5cyhwKSkKPiAgI2RlZmluZSBkbWFfbWFwcGlu
Z19lcnJvciguLi4pICgwKQo+Cj4gICNkZWZpbmUgZG1hX3VubWFwX3NpbmdsZShkLCBhLCBzLCBy
KSBkbyB7ICh2b2lkKShkKTsgKHZvaWQpKGEpOyAodm9pZCkocyk7ICh2b2lkKShyKTsgfSB3aGls
ZSAoMCkKPiAgI2RlZmluZSBkbWFfdW5tYXBfcGFnZShkLCBhLCBzLCByKSBkbyB7ICh2b2lkKShk
KTsgKHZvaWQpKGEpOyAodm9pZCkocyk7ICh2b2lkKShyKTsgfSB3aGlsZSAoMCkKPgo+ICsjZGVm
aW5lIHNnX2RtYV9hZGRyZXNzKHNnKSAoMCkKPiArI2RlZmluZSBkbWFfbmVlZF9zeW5jKHYsIGEp
ICgwKQo+ICsjZGVmaW5lIGRtYV91bm1hcF9zaW5nbGVfYXR0cnMoZCwgYSwgcywgciwgdCkgZG8g
eyBcCj4gKyAgICAgICAodm9pZCkoZCk7ICh2b2lkKShhKTsgKHZvaWQpKHMpOyAodm9pZCkocik7
ICh2b2lkKSh0KTsgXAo+ICt9IHdoaWxlICgwKQo+ICsjZGVmaW5lIGRtYV9zeW5jX3NpbmdsZV9y
YW5nZV9mb3JfY3B1KGQsIGEsIG8sIHMsIHIpIGRvIHsgXAo+ICsgICAgICAgKHZvaWQpKGQpOyAo
dm9pZCkoYSk7ICh2b2lkKShvKTsgKHZvaWQpKHMpOyAodm9pZCkocik7IFwKPiArfSB3aGlsZSAo
MCkKPiArI2RlZmluZSBkbWFfc3luY19zaW5nbGVfcmFuZ2VfZm9yX2RldmljZShkLCBhLCBvLCBz
LCByKSBkbyB7IFwKPiArICAgICAgICh2b2lkKShkKTsgKHZvaWQpKGEpOyAodm9pZCkobyk7ICh2
b2lkKShzKTsgKHZvaWQpKHIpOyBcCj4gK30gd2hpbGUgKDApCj4gICNkZWZpbmUgZG1hX21heF9t
YXBwaW5nX3NpemUoLi4uKSBTSVpFX01BWAo+Cj4gICNlbmRpZgo+IC0tCj4gMi4zNC4xCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
