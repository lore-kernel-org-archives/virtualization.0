Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25C5C7618E
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 05:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73D93415C6;
	Wed, 26 Apr 2023 05:10:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73D93415C6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g+rZg2fV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTsrCTJyf3bz; Wed, 26 Apr 2023 05:10:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7C264015A;
	Wed, 26 Apr 2023 05:10:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7C264015A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C98BDC0037;
	Wed, 26 Apr 2023 05:10:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 624D7C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3660861367
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:10:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3660861367
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g+rZg2fV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IyvPACgWuVkN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:10:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 573F461169
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 573F461169
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682485827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3Ny4efVb8ydV9pXVcmRmQNchXKIVGruv8lOL9xkX30=;
 b=g+rZg2fVK3NUKJ4VmsshpPlyV91w6pD2wrLYRbFlLcZYCAVhqS1lhJEdCSmVVVznlV/QXP
 nT9N1709bj07eVjSUgmrLzljZ2PHCw8mEHLVFVYuKz1DamKvA8+Y6zFdaSmG20pLLQXpxB
 KiSP2W6jPAW4FqZFPTMvm77ZrASyg1U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Z2O7iVlSNkWY_rV2e2a4tg-1; Wed, 26 Apr 2023 01:10:25 -0400
X-MC-Unique: Z2O7iVlSNkWY_rV2e2a4tg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-51f10bda596so3726350a12.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 22:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682485824; x=1685077824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3Ny4efVb8ydV9pXVcmRmQNchXKIVGruv8lOL9xkX30=;
 b=GcYaa164h/HLxhf3F7tiYbdFCjWRcMuBYOxdamEYWj9+FniCOHlIULg4Dzqrgqih6Q
 wS5I2fdfyli1VZ8j6HP/X2IswYzveVj4weGFeSNC+RZCiuIQaD1eYvYl+PMuC/lio59t
 NMhU10HKt8WntSTEbaZhbbfBssgSGaQTGAGm6Ls4K93HRbnz3EPecz7jFiIo6MgHHQ0C
 EjTccrn2USg9qXPCw8Xhs87Tx6t32xcXgHqn2RlnK7SHAaDIm795NCPNOd8gyqjt1blR
 Ng4cwOaYafUKrMzCJlSuhHx5EefZITfBnAg5Py9YciJmuzIlQYjIRt+NZMwKU8f3c36E
 MhfQ==
X-Gm-Message-State: AAQBX9fxZkR+jq23fVfbCc5pwTZXawAI7DqoLlDKHDs9yEgFHkGwT6NV
 JLaTaS7U/GJrWElXYoRUjXg+XG4OJiLxThZn/irGhupYnlHkPnZIUk8Q5zNsXJSIRin8y8Tdry6
 KlXsYOGo4Qat/AjRDFhT4ullL579+RSfcmSfy10qAfQ==
X-Received: by 2002:a17:902:9f88:b0:1a5:3da:84cb with SMTP id
 g8-20020a1709029f8800b001a503da84cbmr18640342plq.21.1682485824181; 
 Tue, 25 Apr 2023 22:10:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350YQFbk1Az3FlIw+77FXIYNhjdPkVZI8Ob7xOa9Ldk7RHjccfWeKgxiKQY5E2Ynj8GBXyMemuA==
X-Received: by 2002:a17:902:9f88:b0:1a5:3da:84cb with SMTP id
 g8-20020a1709029f8800b001a503da84cbmr18640327plq.21.1682485823905; 
 Tue, 25 Apr 2023 22:10:23 -0700 (PDT)
Received: from [10.72.12.241] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a170902bcc400b001a980a23802sm3299652pls.111.2023.04.25.22.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 22:10:23 -0700 (PDT)
Message-ID: <c130a02f-08d1-314c-859d-5a62ff01fb0f@redhat.com>
Date: Wed, 26 Apr 2023 13:10:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] a vendor driver should not set _CONFIG_S_FAILED
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230331204854.20082-6-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230331204854.20082-6-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzQvMSAwNDo0OCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBWSVJUSU9fQ09ORklH
X1NfRkFJTEVEIGluZGljYXRlcyB0aGUgZ3Vlc3QgZHJpdmVyIGhhcyBnaXZlbiB1cAo+IHRoZSBk
ZXZpY2UgZHVlIHRvIGZhdGFsIGVycm9ycy4gU28gaXQgaXMgdGhlIGd1ZXN0IGRlY2lzaW9uLAo+
IHRoZSB2ZW5kb3IgZHJpdmVyIHNob3VsZCBub3Qgc2V0IHRoaXMgc3RhdHVzIHRvIHRoZSBkZXZp
Y2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5j
b20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MK
Cgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQgKy0tLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jCj4gaW5kZXggMTVjNjE1N2VlODQxLi5mMjI4ZmJhNzRjNjEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBAQCAtNDIzLDkgKzQyMyw3IEBAIHN0YXRpYyB2b2lk
IGlmY3ZmX3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1OCBz
dGF0dXMpCj4gICAJICAgICEoc3RhdHVzX29sZCAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0sp
KSB7Cj4gICAJCXJldCA9IGlmY3ZmX3JlcXVlc3RfaXJxKHZmKTsKPiAgIAkJaWYgKHJldCkgewo+
IC0JCQlzdGF0dXMgPSBpZmN2Zl9nZXRfc3RhdHVzKHZmKTsKPiAtCQkJc3RhdHVzIHw9IFZJUlRJ
T19DT05GSUdfU19GQUlMRUQ7Cj4gLQkJCWlmY3ZmX3NldF9zdGF0dXModmYsIHN0YXR1cyk7Cj4g
KwkJCUlGQ1ZGX0VSUih2Zi0+cGRldiwgImZhaWxlZCB0byByZXF1ZXN0IGlycSB3aXRoIGVycm9y
ICVkXG4iLCByZXQpOwo+ICAgCQkJcmV0dXJuOwo+ICAgCQl9Cj4gICAJfQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
