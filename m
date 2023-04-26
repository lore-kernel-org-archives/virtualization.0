Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC7FC77B61
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 03:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F61741BD4;
	Wed, 26 Apr 2023 03:16:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F61741BD4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bslConQF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7I_TUqZJlC3; Wed, 26 Apr 2023 03:16:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6B08841977;
	Wed, 26 Apr 2023 03:16:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B08841977
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4453BC0037;
	Wed, 26 Apr 2023 03:16:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0148C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A60A541991
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:16:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A60A541991
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4QyFzmdNNzE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:16:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5558B41977
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5558B41977
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682479014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YY+zUiI918bhRekp/k04uyQHuZyBvT9YitN/0BGqWBg=;
 b=bslConQF2DVBQTOtRZaejLOfNqN8o0EPZs0x110w+C6IZMu4YU5NYaCluKvHdjYl1Jcp5v
 mlrrLJHr0kqV/7Z+PTRpp7L872KpjPFLFHEScpInzF3f9jVA8YE3x6WC6Y8FVm5ZwbsTGx
 Y4/dYkY/5mMgQZLGqkQipER/YqYQZPc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-dRCFpPVROEyDZ_HijwcCHQ-1; Tue, 25 Apr 2023 23:16:52 -0400
X-MC-Unique: dRCFpPVROEyDZ_HijwcCHQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-640f5191c79so3959799b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 20:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682479012; x=1685071012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YY+zUiI918bhRekp/k04uyQHuZyBvT9YitN/0BGqWBg=;
 b=fW2tVadV3nU0Is7vtZ2lO0zFXrMYBzpvpJ/PLgboSkTXBalKM9anfRV1Q/GtUWpQM2
 AfyUung7vIsPGe3YkdroE+hEudjORsWzCNG+wfTET+p89jQw7xQrUnAtU0l0ZsgYOMEE
 ig5nU8ba/kOzhlvVdzhustKlBReta61bCujn9yw36pUe8+7GAvDKeMl8dHdOSAFiGz6d
 rvdw8XokY3y4QjIzC6tTUY1CLXeVeDDxqiAYL/K+Sco5fs06HBCY6msjyuDGysO02Mkg
 vQgSR+isjU8eHJz3nL/YR3C+123slpdTZifzvUpFR5LwoWazPAX8I7yCHzuOpPl/4Adv
 /xcg==
X-Gm-Message-State: AC+VfDxG3yd0s8o8BrVZSUpXP7PQthvzlzNRlqGfoCrk+vJbXiMo/X2b
 vnYitFTvbucCFV96Bh8khS6BETwTJh+S+ZuvhRCop8XdzRgEaguhMPZ1bCb0U4bPdl0s/mBt1RP
 AgwcDIkGdRQ9LhnB4inZO9xTFzkurxaH91g63kdUrHg==
X-Received: by 2002:a05:6a20:5482:b0:f5:ae09:cdf2 with SMTP id
 i2-20020a056a20548200b000f5ae09cdf2mr1273124pzk.17.1682479011868; 
 Tue, 25 Apr 2023 20:16:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TBpoXENwf1shIIT69AtLezqAGfiV1jveqvkQ53XfFHqioJ3xhSxQbFjMMo+u+zHPQJ9jDTA==
X-Received: by 2002:a05:6a20:5482:b0:f5:ae09:cdf2 with SMTP id
 i2-20020a056a20548200b000f5ae09cdf2mr1273106pzk.17.1682479011512; 
 Tue, 25 Apr 2023 20:16:51 -0700 (PDT)
Received: from [10.72.13.54] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a656151000000b0050927cb606asm8563730pgv.13.2023.04.25.20.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 20:16:51 -0700 (PDT)
Message-ID: <8f14df81-c1af-7b55-7473-187ed3b13fef@redhat.com>
Date: Wed, 26 Apr 2023 11:16:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next v3 15/15] virtio_net: introduce
 virtnet_build_skb()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-16-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230423105736.56918-16-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIzLzQvMjMgMTg6NTcsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBsb2dpYyBpcyB1
c2VkIGluIG11bHRpcGxlIHBsYWNlcywgbm93IHdlIHNlcGFyYXRlIGl0IGludG8KPiBhIGhlbHBl
ci4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MK
Cgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzQgKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDEzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDgxMWNmMTA0NmRmMi4uZjc2OGU2
ODNkYWRiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC00NDMsNiArNDQzLDIyIEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgbWVyZ2VhYmxlX2N0eF90b190cnVlc2l6ZSh2b2lkICptcmdfY3R4KQo+ICAgCXJl
dHVybiAodW5zaWduZWQgbG9uZyltcmdfY3R4ICYgKCgxIDw8IE1SR19DVFhfSEVBREVSX1NISUZU
KSAtIDEpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqdmlydG5ldF9idWls
ZF9za2Iodm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgYnVmbGVuLAo+ICsJCQkJCSB1bnNpZ25lZCBp
bnQgaGVhZHJvb20sCj4gKwkJCQkJIHVuc2lnbmVkIGludCBsZW4pCj4gK3sKPiArCXN0cnVjdCBz
a19idWZmICpza2I7Cj4gKwo+ICsJc2tiID0gYnVpbGRfc2tiKGJ1ZiwgYnVmbGVuKTsKPiArCWlm
ICh1bmxpa2VseSghc2tiKSkKPiArCQlyZXR1cm4gTlVMTDsKPiArCj4gKwlza2JfcmVzZXJ2ZShz
a2IsIGhlYWRyb29tKTsKPiArCXNrYl9wdXQoc2tiLCBsZW4pOwo+ICsKPiArCXJldHVybiBza2I7
Cj4gK30KPiArCj4gICAvKiBDYWxsZWQgZnJvbSBib3R0b20gaGFsZiBjb250ZXh0ICovCj4gICBz
dGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LAo+ICAgCQkJCSAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiBAQCAtNDc2LDEzICs0OTIs
MTAgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSwKPiAgIAo+ICAgCS8qIGNvcHkgc21hbGwgcGFja2V0IHNvIHdlIGNhbiByZXVzZSB0
aGVzZSBwYWdlcyAqLwo+ICAgCWlmICghTkVUX0lQX0FMSUdOICYmIGxlbiA+IEdPT0RfQ09QWV9M
RU4gJiYgdGFpbHJvb20gPj0gc2hpbmZvX3NpemUpIHsKPiAtCQlza2IgPSBidWlsZF9za2IoYnVm
LCB0cnVlc2l6ZSk7Cj4gKwkJc2tiID0gdmlydG5ldF9idWlsZF9za2IoYnVmLCB0cnVlc2l6ZSwg
cCAtIGJ1ZiwgbGVuKTsKPiAgIAkJaWYgKHVubGlrZWx5KCFza2IpKQo+ICAgCQkJcmV0dXJuIE5V
TEw7Cj4gICAKPiAtCQlza2JfcmVzZXJ2ZShza2IsIHAgLSBidWYpOwo+IC0JCXNrYl9wdXQoc2ti
LCBsZW4pOwo+IC0KPiAgIAkJcGFnZSA9IChzdHJ1Y3QgcGFnZSAqKXBhZ2UtPnByaXZhdGU7Cj4g
ICAJCWlmIChwYWdlKQo+ICAgCQkJZ2l2ZV9wYWdlcyhycSwgcGFnZSk7Cj4gQEAgLTk0NiwxMyAr
OTU5LDEwIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9zbWFsbF9idWlsZF9za2Io
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJYnVmbGVuID0gU0tCX0RBVEFfQUxJR04oR09P
RF9QQUNLRVRfTEVOICsgaGVhZHJvb20pICsKPiAgIAkJU0tCX0RBVEFfQUxJR04oc2l6ZW9mKHN0
cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiAgIAo+IC0Jc2tiID0gYnVpbGRfc2tiKGJ1ZiwgYnVm
bGVuKTsKPiAtCWlmICghc2tiKQo+ICsJc2tiID0gdmlydG5ldF9idWlsZF9za2IoYnVmLCBidWZs
ZW4sIGhlYWRyb29tLCBsZW4pOwo+ICsJaWYgKHVubGlrZWx5KCFza2IpKQo+ICAgCQlyZXR1cm4g
TlVMTDsKPiAgIAo+IC0Jc2tiX3Jlc2VydmUoc2tiLCBoZWFkcm9vbSk7Cj4gLQlza2JfcHV0KHNr
YiwgbGVuKTsKPiAtCj4gICAJYnVmICs9IGhlYWRlcl9vZmZzZXQ7Cj4gICAJbWVtY3B5KHNrYl92
bmV0X2hkcihza2IpLCBidWYsIHZpLT5oZHJfbGVuKTsKPiAgIAo+IEBAIC0xMDI4LDEyICsxMDM4
LDEwIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9zbWFsbF94ZHAoc3RydWN0IG5l
dF9kZXZpY2UgKmRldiwKPiAgIAkJZ290byBlcnJfeGRwOwo+ICAgCX0KPiAgIAo+IC0Jc2tiID0g
YnVpbGRfc2tiKGJ1ZiwgYnVmbGVuKTsKPiAtCWlmICghc2tiKQo+ICsJc2tiID0gdmlydG5ldF9i
dWlsZF9za2IoYnVmLCBidWZsZW4sIHhkcC5kYXRhIC0gYnVmLCBsZW4pOwo+ICsJaWYgKHVubGlr
ZWx5KCFza2IpKQo+ICAgCQlnb3RvIGVycjsKPiAgIAo+IC0Jc2tiX3Jlc2VydmUoc2tiLCB4ZHAu
ZGF0YSAtIGJ1Zik7Cj4gLQlza2JfcHV0KHNrYiwgbGVuKTsKPiAgIAlpZiAobWV0YXNpemUpCj4g
ICAJCXNrYl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7Cj4gICAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
