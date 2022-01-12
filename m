Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC30BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 06:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 380C64054B;
	Wed, 12 Jan 2022 06:31:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNKTDM5zTeig; Wed, 12 Jan 2022 06:31:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61CAF40126;
	Wed, 12 Jan 2022 06:30:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40CCCC002F;
	Wed, 12 Jan 2022 06:30:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E0E8C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 06:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 484B060C1F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 06:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kSId1NvD41gy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 06:30:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03DAE60C10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 06:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641969054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bK7XyK/gVW/nDtWgdJaGpYWUQoRdCOb/XtgxbXgPvnM=;
 b=N6qvUggzkydd0+GqfyLYAn0bcLJhIAve31LxzLXZJUf9Tpv/TfsmyCkJSrNlG/xGOSynu/
 CfEIvT7FXJcnb4EtroEg+xCxwKG9BOPBj0XQk5pWn1HTGBhAr0Uc0eYYvXAJEEzeG2hRTl
 COgLe6AaIbKNTtxJJOIDcVojOSlghfg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-fnJweq0-M0iuMpiZ1QV6fQ-1; Wed, 12 Jan 2022 01:30:50 -0500
X-MC-Unique: fnJweq0-M0iuMpiZ1QV6fQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 z9-20020a05640240c900b003fea688a17eso1346941edb.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 22:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bK7XyK/gVW/nDtWgdJaGpYWUQoRdCOb/XtgxbXgPvnM=;
 b=HhUcVgtoGPcsRYVzuldPepMJmAyfADOCs1fyquEiZdxgilvp8J/GQ71CCq3Te/bOLL
 7a5aCw+kSzw+zm47TfuIka6d4htwlL3vpIktFaxo+gvodNBrZjxzLB9w2vUL6anrWU7W
 hX5xegj7Lo1MS8EUjryHuvI2eB9oFp6OhKY8We6YHMHzUuXleZCVXW+n3/Drq8liowiF
 IJVtwCWo66qndfLlYJG3XV/XYidiRnDwVl3Exd6mtuZ5SDo5pvMrEtM2RZowWnOkZifa
 0b3ahnjc4jN4fMp47GKPtjvv5ZhbN9DsEZegB8+TORYCeugZFezdzIQwn2D4ZNpcGVN/
 X4Hw==
X-Gm-Message-State: AOAM532iDSVUWtwWzsj3RI749PbXm0dNQdP8iA4dGDpJXnopiwIUHKXc
 yscSJ0CwZSQEKFvw6cQqAwWo1VJr8NhgkH0VmXF7NFVgoEihBO7eS78xDgu0xxYP4kgbdAh+SFG
 08roDcoESINHo8QvnlG7SMRetFNnyjp87cHO+81/oFA==
X-Received: by 2002:a17:906:a148:: with SMTP id
 bu8mr6318691ejb.421.1641969049557; 
 Tue, 11 Jan 2022 22:30:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNjiZRz5Py3VHe2DjEuMPn36+kac6X/JVuHHlQgUeOHbPVat7+JLR0moBJobNitXh5a97tOw==
X-Received: by 2002:a17:906:a148:: with SMTP id
 bu8mr6318683ejb.421.1641969049356; 
 Tue, 11 Jan 2022 22:30:49 -0800 (PST)
Received: from redhat.com ([2.55.132.148])
 by smtp.gmail.com with ESMTPSA id h2sm4186388ejo.169.2022.01.11.22.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 22:30:48 -0800 (PST)
Date: Wed, 12 Jan 2022 01:30:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220112013018-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBKYW4gMTIsIDIwMjIgYXQgMTA6MjM6MDdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCA3OjUyIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgSmFuIDExLCAyMDIyIGF0IDEx
OjM2OjQyQU0gKzA4MDAsIOadjuS4nOWNhyB3cm90ZToKPiA+ID4gV2hlbiB2aXJ0aW8gdmRwYSBk
ZXZpY2UgcmVtb3ZlZCwgdGhlIGFibm9ybWFsIGRhbWFnZSBvZiB0aGUgZGV2aWNlIGNhbm5vdCBi
ZQo+ID4gPiBwZXJjZWl2ZWQgbm9ybWFsbHksIHdoaWNoIHdpbGwgY2F1c2UgcHJvYmxlbXMgc2lt
aWxhciB0bzoKPiA+ID4KPiA+ID4gNDNiYjQwYzViOTI2Cj4gPgo+ID4KPiA+IFNob3VsZCBpbmNs
dWRlIHRoZSBzdWJqZWN0IG9mIHRoZSBwYXRjaCB0b28uCj4gPgo+ID4gPiBIZW5jZSwgYWRkIHRo
ZSBhYmlsaXR5IHRvIGFib3J0IHRoZSBjb21tYW5kIG9uIHN1cnByaXNlIHJlbW92YWwKPiA+ID4K
PiA+ID4gU2lnbmVkLW9mZi1ieTogZG9uZ3NoZW5nIGxpIDxsaWRvbmdzaGVuZ0BkYXl1ZHB1LmNv
bT4KPiA+Cj4gPiBXaGVuIHJlbW92aW5nIGdyYWNlZnVsbHksCj4gPiBJIGFtIG5vdCBzdXJlIHdl
IHNob3VsZCBicmVhayBkZXZpY2UgdW5jb25kaXRpb25hbGx5IGxpa2UgdGhpcwo+ID4gYmVmb3Jl
IGdpdmluZyBkcml2ZXJzIGEgY2hhbmNlIHRvIGNsZWFuIHVwLgo+ID4gU2hvdWxkIHdlIGp1c3Qg
ZG8gaXQgZm9yIHN1cnByaXNlIHJlbW92YWw/Cj4gCj4gVGhhdCByZXF1aXJlcyBhIG5ldyBtZXRo
b2QgdG8gcXVlcnkgd2hldGhlciBpdCdzIGEgc3VycHJpc2UgcmVtb3ZhbC4KPiAKPiBUaGFua3MK
CldlIGNhbiBjaGVjayBwY2lfZGV2aWNlX2lzX3ByZXNlbnQgbGlrZSB2aXJ0aW8gZG9lcy4KCj4g
Pgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAxICsKPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMKPiA+ID4gaW5kZXggNGE5ZGRiNDRiMmE3Li5mZDkzMDQwOWQxOTAgMTAwNjQ0Cj4gPiA+
IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+ID4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gPiBAQCAtMzc0LDYgKzM3NCw3IEBAIHN0YXRpYyB2b2lk
IHZpcnRpb192ZHBhX3JlbW92ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gPiA+ICB7Cj4g
PiA+ICAgc3RydWN0IHZpcnRpb192ZHBhX2RldmljZSAqdmRfZGV2ID0gdmRwYV9nZXRfZHJ2ZGF0
YSh2ZHBhKTsKPiA+ID4KPiA+ID4gKyB2aXJ0aW9fYnJlYWtfZGV2aWNlKHZkX2Rldi0+dmRldik7
Cj4gPiA+ICAgdW5yZWdpc3Rlcl92aXJ0aW9fZGV2aWNlKCZ2ZF9kZXYtPnZkZXYpOwo+ID4gPiAg
fQo+ID4gPgo+ID4gPiAtLQo+ID4gPiAyLjE3LjEKPiA+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
