Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADB3C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:43:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77D060E96
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 03:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D77D060E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6205407C8;
	Wed, 13 Oct 2021 03:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vc5BqL8bP6rL; Wed, 13 Oct 2021 03:43:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4950F407AC;
	Wed, 13 Oct 2021 03:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DA5CC0011;
	Wed, 13 Oct 2021 03:43:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2877C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7656282925
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qwf9RhalEpwE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:43:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9B69827FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634096596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viNFpeHUzGfzCjmB9yRefzHm78IOUsLSu1zbF0ytupY=;
 b=PjSedjJnm814UuBRqx8FHJx2VzF1kWmbHkkJBs5mgT2Qs/l7FZTT6NlBN+Bwat2Jh/Y5ar
 vpYFStUAfvZVLFXT5B+YuhVbmMyLyD8cYWyHSYQoxi4FNS0r/80EyJZIi3gyQlutdmHLZN
 QL2ClTiGWSEdCV9NeOAr/paTDULOAxM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-wT0N8H04Nb2WQ1PPl00N8Q-1; Tue, 12 Oct 2021 23:43:13 -0400
X-MC-Unique: wT0N8H04Nb2WQ1PPl00N8Q-1
Received: by mail-pj1-f71.google.com with SMTP id
 nv1-20020a17090b1b4100b001a04861d474so1026352pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 20:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=viNFpeHUzGfzCjmB9yRefzHm78IOUsLSu1zbF0ytupY=;
 b=TCXffJ8+U9ff+Xjc9p3jNB2nYhVWbRUmybBr2Rc1J3uuVeeVHL+azXTILyP+vm9VCE
 Dp/YZhKpDDZ2su5bJoNYVjhg+itTz17/o/Nq9D99Is5BMrIcge4gUztVoHATngq3ug/f
 NsNqmDdBmry6B2L0agqbuEevCyrnrFSSAppUMl79dHo1hNnAUeFH6fo9cHiYC1ebCQgX
 +adOxio5KEsmpHPQpoTGHenlMOLeH5sUArW8rOowRfbrUHsIJU16wJKbxesjnL/lpmL5
 bWLTajqci885KWsFBXROftAMxloRgcGPN8pcBiS2BMGLulUL6qFbQ1fJ7hqd+IKqU9Ik
 uFqQ==
X-Gm-Message-State: AOAM532jTLdsf0agk3YHmW7jL0TtygEJ0WwrQPw1D8nmDPIjthDIDp5/
 2Xzanwle0djH9vYl2x1zFq6gVXrrxczB49ecMIoYgKKE+KIz6FAY7D9jvtEn/cZVZV+YnXpn77V
 z4coJ7I87x4dCDMD2tqQNMCQY8Bcq9QOmBYj1FMXE4g==
X-Received: by 2002:a63:fe41:: with SMTP id x1mr25959365pgj.272.1634096592027; 
 Tue, 12 Oct 2021 20:43:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2pd81zis2PSX9uBg+qZtuoSWTKUrks0MjxebPhb/fQXmwGqhUME9gYkJdg+QhcG8rw6onOQ==
X-Received: by 2002:a63:fe41:: with SMTP id x1mr25959348pgj.272.1634096591746; 
 Tue, 12 Oct 2021 20:43:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w185sm11845546pfd.113.2021.10.12.20.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 20:43:11 -0700 (PDT)
Subject: Re: [RFC PATCH v4 09/20] vdpa: Save call_fd in vhost-vdpa
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-10-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <607201ea-db7f-0264-7dd7-fa19143b3abf@redhat.com>
Date: Wed, 13 Oct 2021 11:43:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001070603.307037-10-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzEwLzEg5LiL5Y2IMzowNSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IFdlIG5l
ZWQgdG8ga25vdyBpdCB0byBzd2l0Y2ggdG8gU2hhZG93IFZpcnRRdWV1ZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaW5j
bHVkZS9ody92aXJ0aW8vdmhvc3QtdmRwYS5oIHwgMiArKwo+ICAgaHcvdmlydGlvL3Zob3N0LXZk
cGEuYyAgICAgICAgIHwgNSArKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmggYi9pbmNs
dWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmgKPiBpbmRleCA0OGFhZTU5ZDhlLi5mZGRhYzI0OGIz
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaAo+ICsrKyBiL2lu
Y2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaAo+IEBAIC0zMCw2ICszMCw4IEBAIHR5cGVkZWYg
c3RydWN0IHZob3N0X3ZkcGEgewo+ICAgICAgIEdQdHJBcnJheSAqc2hhZG93X3ZxczsKPiAgICAg
ICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXY7Cj4gICAgICAgUUxJU1RfRU5UUlkodmhvc3RfdmRwYSkg
ZW50cnk7Cj4gKyAgICAvKiBGaWxlIGRlc2NyaXB0b3IgdGhlIGRldmljZSB1c2VzIHRvIGNhbGwg
Vk0vU1ZRICovCj4gKyAgICBpbnQgY2FsbF9mZFtWSVJUSU9fUVVFVUVfTUFYXTsKCgpBbnkgcmVh
c29uIHdlIGRvbid0IGRvIHRoaXMgZm9yIGtpY2tfZmQgb3Igd2h5IAp2aXJ0aW9fcXVldWVfZ2V0
X2d1ZXN0X25vdGlmaWVyKCkgY2FuJ3Qgd29yayBoZXJlPyBOZWVkIGEgY29tbWVudCBvciAKY29t
bWl0IGxvZy4KCkkgdGhpbmsgd2UgbmVlZCB0byBoYXZlIGEgY29uc2lzdGVudCB3YXkgdG8gaGFu
ZGxlIGJvdGgga2ljayBhbmQgY2FsbCBmZC4KClRoYW5rcwoKCj4gICAgICAgVmhvc3RWRFBBSG9z
dE5vdGlmaWVyIG5vdGlmaWVyW1ZJUlRJT19RVUVVRV9NQVhdOwo+ICAgfSBWaG9zdFZEUEE7Cj4g
ICAKPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9z
dC12ZHBhLmMKPiBpbmRleCAzNmM5NTRhNzc5Li41N2E4NTc0NDRhIDEwMDY0NAo+IC0tLSBhL2h3
L3ZpcnRpby92aG9zdC12ZHBhLmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAg
LTY1Miw3ICs2NTIsMTIgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19raWNrKHN0
cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdf
Y2FsbChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfZmlsZSAqZmlsZSkKPiAgIHsKPiArICAg
IHN0cnVjdCB2aG9zdF92ZHBhICp2ID0gZGV2LT5vcGFxdWU7Cj4gKyAgICBpbnQgdmRwYV9pZHgg
PSB2aG9zdF92ZHBhX2dldF92cV9pbmRleChkZXYsIGZpbGUtPmluZGV4KTsKPiArCj4gICAgICAg
dHJhY2Vfdmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbChkZXYsIGZpbGUtPmluZGV4LCBmaWxlLT5m
ZCk7Cj4gKwo+ICsgICAgdi0+Y2FsbF9mZFt2ZHBhX2lkeF0gPSBmaWxlLT5mZDsKPiAgICAgICBy
ZXR1cm4gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhPU1RfU0VUX1ZSSU5HX0NBTEwsIGZpbGUpOwo+
ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
