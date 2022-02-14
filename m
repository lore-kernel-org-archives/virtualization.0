Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F954C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 06:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C718C60C09;
	Mon, 14 Feb 2022 06:16:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7tYXzXVEKO8; Mon, 14 Feb 2022 06:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 48D4E605AC;
	Mon, 14 Feb 2022 06:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2769AC0011;
	Mon, 14 Feb 2022 06:16:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99084C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86A124032B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GUwjCBp_8D5w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91EEF4035A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 06:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644819370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NF1/NPeUWNiJlC0A0ifogeZR5Lr3JaYAP0Q8qqKkG4w=;
 b=i0AE170/khedPhxaGArFncU9iQhb6c+zWHEKN/PurPBBXaaM+GXY2wzOfTkPE4IQg32FR6
 KXxDj4x4wV0EK4qQ8v4UJfgIsWlxIZdb5eut16N0cghdBFzcrczxy0PG4lg3YZIKE6fSJu
 XKErU05Pn/Evthqw67wYt4Qo6F4QLdI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-FAg4Ch8iMk6qgmucD0sfyg-1; Mon, 14 Feb 2022 01:16:06 -0500
X-MC-Unique: FAg4Ch8iMk6qgmucD0sfyg-1
Received: by mail-pj1-f71.google.com with SMTP id
 hi22-20020a17090b30d600b001b8b33cf0efso11443855pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 22:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NF1/NPeUWNiJlC0A0ifogeZR5Lr3JaYAP0Q8qqKkG4w=;
 b=OXGzdMc5ytuSFVQw5kuX3HlwxxnybecljB4mmhGWnj7DBgC0L/T5fCvEA3jzYzwmbq
 4cuMFqYKJWl35WRIi67MKSyr/EXWKbF78V9Ao/G/JXJgdjJZTBPRw2vUR72nruDvxgRc
 CU61HY/j/oRqeHVjL2HR53RJVQxyrNOYroF5UVKJDLUeHJH2x3eDq9L1QLU/GXL3KS7w
 dPAT1YzcHhyFVFWzqwaXooEfjysbQX830cnQwt+ukJZnZCuhO+rYptBCelxMylzvhnkv
 L2phRiLjoCmpEQfvQLo3WhGxes6igePLp/Hvg5vvYkusrxl3Dc7sGzH3bWE4mGpvCweh
 wwlg==
X-Gm-Message-State: AOAM530ZjmaoQNVAUHSwBuiAeILgq4WOZD2aCKWhejlGLSZzLgjZvYfR
 n5LBSrpbH4eSF/+1BJF7a+wdZ7XQA/wilTkou5wya8wLeWMI3CfeDgSIjRyv5ePLVb1vAuexB6O
 hmQ7jvdX5HNzU1DObN/e6egcgytzTZVQjCJnsEcpvFg==
X-Received: by 2002:a05:6a00:1892:: with SMTP id
 x18mr12764899pfh.20.1644819365632; 
 Sun, 13 Feb 2022 22:16:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6SwUZsLff3cs83pvyeBxbCmftVQTztg6Yvm98p1XlJI3EP/KbBrzcE7/YJjwVZOOLrhfVig==
X-Received: by 2002:a05:6a00:1892:: with SMTP id
 x18mr12764878pfh.20.1644819365375; 
 Sun, 13 Feb 2022 22:16:05 -0800 (PST)
Received: from [10.72.12.239] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w2sm18461513pfb.139.2022.02.13.22.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Feb 2022 22:16:04 -0800 (PST)
Message-ID: <5b9e287a-08bd-10b9-4159-5b36f192a387@redhat.com>
Date: Mon, 14 Feb 2022 14:15:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH V4 1/4] vDPA/ifcvf: implement IO read/write helpers in the
 header file
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20220203072735.189716-1-lingshan.zhu@intel.com>
 <20220203072735.189716-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220203072735.189716-2-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzIvMyDkuIvljYgzOjI3LCBaaHUgTGluZ3NoYW4g5YaZ6YGTOgo+IHJlLWltcGxl
bWVudCBJTyByZWFkL3dyaXRlIGhlbHBlcnMgaW4gdGhlIGhlYWRlciBmaWxlLCBzbyB0aGF0Cj4g
dGhleSBjYW4gYmUgdXRpbGl6ZWQgYW1vbmcgbW9kdWxlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFpo
dSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KCgpJIHdvbmRlciBpZiB3ZSBjYW4g
c2ltcGx5IHVzZSBpbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmguCgpUaGUgYWNjZXNz
b3JzIHZwX2lvcmVhZFgvd3JpdGVYKCkgdGhlcmUgd2VyZSBkZWNvdXBsZWQgZnJvbSB0aGUgCnZp
cnRpb19wY2lfbW9kZXJuX2RldmljZSBzdHJ1Y3R1cmUuCgpUaGFua3MKCgo+IC0tLQo+ICAgZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDM2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgMzcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2Vy
dGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9iYXNlLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gaW5k
ZXggN2Q0MWRmZTQ4YWRlLi4zOTc2OTJhZTY3MWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNl
LmMKPiBAQCAtMTAsNDIgKzEwLDYgQEAKPiAgIAo+ICAgI2luY2x1ZGUgImlmY3ZmX2Jhc2UuaCIK
PiAgIAo+IC1zdGF0aWMgaW5saW5lIHU4IGlmY19pb3JlYWQ4KHU4IF9faW9tZW0gKmFkZHIpCj4g
LXsKPiAtCXJldHVybiBpb3JlYWQ4KGFkZHIpOwo+IC19Cj4gLXN0YXRpYyBpbmxpbmUgdTE2IGlm
Y19pb3JlYWQxNiAoX19sZTE2IF9faW9tZW0gKmFkZHIpCj4gLXsKPiAtCXJldHVybiBpb3JlYWQx
NihhZGRyKTsKPiAtfQo+IC0KPiAtc3RhdGljIGlubGluZSB1MzIgaWZjX2lvcmVhZDMyKF9fbGUz
MiBfX2lvbWVtICphZGRyKQo+IC17Cj4gLQlyZXR1cm4gaW9yZWFkMzIoYWRkcik7Cj4gLX0KPiAt
Cj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBpZmNfaW93cml0ZTgodTggdmFsdWUsIHU4IF9faW9tZW0g
KmFkZHIpCj4gLXsKPiAtCWlvd3JpdGU4KHZhbHVlLCBhZGRyKTsKPiAtfQo+IC0KPiAtc3RhdGlj
IGlubGluZSB2b2lkIGlmY19pb3dyaXRlMTYodTE2IHZhbHVlLCBfX2xlMTYgX19pb21lbSAqYWRk
cikKPiAtewo+IC0JaW93cml0ZTE2KHZhbHVlLCBhZGRyKTsKPiAtfQo+IC0KPiAtc3RhdGljIGlu
bGluZSB2b2lkIGlmY19pb3dyaXRlMzIodTMyIHZhbHVlLCBfX2xlMzIgX19pb21lbSAqYWRkcikK
PiAtewo+IC0JaW93cml0ZTMyKHZhbHVlLCBhZGRyKTsKPiAtfQo+IC0KPiAtc3RhdGljIHZvaWQg
aWZjX2lvd3JpdGU2NF90d29wYXJ0KHU2NCB2YWwsCj4gLQkJCQkgIF9fbGUzMiBfX2lvbWVtICps
bywgX19sZTMyIF9faW9tZW0gKmhpKQo+IC17Cj4gLQlpZmNfaW93cml0ZTMyKCh1MzIpdmFsLCBs
byk7Cj4gLQlpZmNfaW93cml0ZTMyKHZhbCA+PiAzMiwgaGkpOwo+IC19Cj4gLQo+ICAgc3RydWN0
IGlmY3ZmX2FkYXB0ZXIgKnZmX3RvX2FkYXB0ZXIoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIHsK
PiAgIAlyZXR1cm4gY29udGFpbmVyX29mKGh3LCBzdHJ1Y3QgaWZjdmZfYWRhcHRlciwgdmYpOwo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IGluZGV4IGM0ODY4NzNmMzcwYS4uOTQ5YjRmYjlkNTU0
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiArKysgYi9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gQEAgLTQyLDYgKzQyLDQzIEBACj4gICAj
ZGVmaW5lIGlmY3ZmX3ByaXZhdGVfdG9fdmYoYWRhcHRlcikgXAo+ICAgCSgmKChzdHJ1Y3QgaWZj
dmZfYWRhcHRlciAqKWFkYXB0ZXIpLT52ZikKPiAgIAo+ICtzdGF0aWMgaW5saW5lIHU4IGlmY19p
b3JlYWQ4KHU4IF9faW9tZW0gKmFkZHIpCj4gK3sKPiArCXJldHVybiBpb3JlYWQ4KGFkZHIpOwo+
ICt9Cj4gKwo+ICtzdGF0aWMgaW5saW5lIHUxNiBpZmNfaW9yZWFkMTYoX19sZTE2IF9faW9tZW0g
KmFkZHIpCj4gK3sKPiArCXJldHVybiBpb3JlYWQxNihhZGRyKTsKPiArfQo+ICsKPiArc3RhdGlj
IGlubGluZSB1MzIgaWZjX2lvcmVhZDMyKF9fbGUzMiBfX2lvbWVtICphZGRyKQo+ICt7Cj4gKwly
ZXR1cm4gaW9yZWFkMzIoYWRkcik7Cj4gK30KPiArCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBpZmNf
aW93cml0ZTgodTggdmFsdWUsIHU4IF9faW9tZW0gKmFkZHIpCj4gK3sKPiArCWlvd3JpdGU4KHZh
bHVlLCBhZGRyKTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2b2lkIGlmY19pb3dyaXRlMTYo
dTE2IHZhbHVlLCBfX2xlMTYgX19pb21lbSAqYWRkcikKPiArewo+ICsJaW93cml0ZTE2KHZhbHVl
LCBhZGRyKTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2b2lkIGlmY19pb3dyaXRlMzIodTMy
IHZhbHVlLCBfX2xlMzIgX19pb21lbSAqYWRkcikKPiArewo+ICsJaW93cml0ZTMyKHZhbHVlLCBh
ZGRyKTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2b2lkIGlmY19pb3dyaXRlNjRfdHdvcGFy
dCh1NjQgdmFsLAo+ICsJCQkJICBfX2xlMzIgX19pb21lbSAqbG8sIF9fbGUzMiBfX2lvbWVtICpo
aSkKPiArewo+ICsJaWZjX2lvd3JpdGUzMigodTMyKXZhbCwgbG8pOwo+ICsJaWZjX2lvd3JpdGUz
Mih2YWwgPj4gMzIsIGhpKTsKPiArfQo+ICsKPiAgIHN0cnVjdCB2cmluZ19pbmZvIHsKPiAgIAl1
NjQgZGVzYzsKPiAgIAl1NjQgYXZhaWw7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
