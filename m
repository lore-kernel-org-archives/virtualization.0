Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B62C4708F
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:11:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D01A610A0
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 06:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D01A610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B63440361;
	Mon, 31 May 2021 06:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VSyLXm0C51ax; Mon, 31 May 2021 06:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92BFB40360;
	Mon, 31 May 2021 06:11:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63518C000E;
	Mon, 31 May 2021 06:11:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D83F7C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9ED74014B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJfsbQPP8S2z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:11:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C20B940134
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622441480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFtzwgziSoZ8iozEmB6Ecc/Oz0muKre3EGFmRB+A8Zw=;
 b=LxEXndpd9iVJjq8e5kSD3QD2JezW9fNkuZeibjWMjA5xFEkEvkf4YmPn5q0PCzU97oWWAX
 oZplPss0QNoUonOEh8Dfn9jDgj/z0pwa9qm3bjEHGbtTyjrMTVwtgkYMfWQzKOroSS3Mtn
 7nDbxtz2mboIwRupyCv24NMpOF5bIB0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-sc_CbJMEMq6vcABjodjo0Q-1; Mon, 31 May 2021 02:11:17 -0400
X-MC-Unique: sc_CbJMEMq6vcABjodjo0Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 pf14-20020a17090b1d8eb029015c31e36747so6647394pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 23:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gFtzwgziSoZ8iozEmB6Ecc/Oz0muKre3EGFmRB+A8Zw=;
 b=Usd2qGyRiEG+J/Y6dTM97UlbwHJzlE2AN/HTf05W3r/0kNWFrcXgHsLRHcZuMfapaD
 Q6bIF/4rGiS2E/qPpM1UtQ7IM3iUPfmKLoTBFmM0NFq3exe581r7jpTUF6KA4Mi9ChsJ
 nu95Grb5KHR0x33xB076VSoE5ZAS6ELgnZCW1Y94A0ZZEGHPYI6gyn3zcbsjsVQC22To
 25ejZDDsUtJNONMo6rob65iexfZ81lYbqhn0rs9OeLFMnQqL9fozjfkG+B7xbxdLxgIi
 qUYed7etWJNlKX0mwSy89/z2CJl6SJIeMzwWy0H+Y56N02Ie4U1552uep2jYnD8rKaDH
 nl8Q==
X-Gm-Message-State: AOAM532jAM/6jueV4+B+eeeLZvajWycTmbZ+8CJW7G93iaWWn2b6TG0c
 DM16KhC2KSdpBQ8z2MpWw5ivhxOmFdy2CS3fc1ZqYfyh9MRLwg2SLFijjMiuN8MtoQXH+m+NhVD
 Wj+SXdNF62ONob2WlpOnPtJRnEO37KECH3IHMYRVJQg==
X-Received: by 2002:a63:2bd5:: with SMTP id
 r204mr20901090pgr.426.1622441476730; 
 Sun, 30 May 2021 23:11:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxutLeevxA6LuaKonk96FQO3so1MTRdYBSNys4UBNveOmY1P9CbnJDYcS/TPJxyyRyHmM3yvA==
X-Received: by 2002:a63:2bd5:: with SMTP id
 r204mr20901072pgr.426.1622441476476; 
 Sun, 30 May 2021 23:11:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a9sm9621387pfo.69.2021.05.30.23.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 23:11:16 -0700 (PDT)
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210514151637.117596-1-xuanzhuo@linux.alibaba.com>
 <20210514151637.117596-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2920ec92-43ac-714f-69b5-281467d1d5ad@redhat.com>
Date: Mon, 31 May 2021 14:10:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210514151637.117596-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIxLzUvMTQg5LiL5Y2IMTE6MTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW4gdGhlIGNh
c2Ugb2YgbWVyZ2UsIHRoZSBwYWdlIHBhc3NlZCBpbnRvIHBhZ2VfdG9fc2tiKCkgbWF5IGJlIGEg
aGVhZAo+IHBhZ2UsIG5vdCB0aGUgcGFnZSB3aGVyZSB0aGUgY3VycmVudCBkYXRhIGlzIGxvY2F0
ZWQuCgoKSSBkb24ndCBnZXQgaG93IHRoaXMgY2FuIGhhcHBlbj8KCk1heWJlIHlvdSBjYW4gZXhw
bGFpbiBhIGxpdHRsZSBiaXQgbW9yZT8KCnJlY2VpdmVfbWVyZ2VhYmxlKCkgY2FsbCBwYWdlX3Rv
X3NrYigpIGluIHR3byBwbGFjZXM6CgoxKSBYRFBfUEFTUyBmb3IgbGluZWFyaXplZCBwYWdlICwg
aW4gdGhpcyBjYXNlIHdlIHVzZSB4ZHBfcGFnZQoyKSBwYWdlX3RvX3NrYigpIGZvciAibm9ybWFs
IiBwYWdlLCBpbiB0aGlzIGNhc2UgdGhlIHBhZ2UgY29udGFpbnMgdGhlIGRhdGEKClRoYW5rcwoK
Cj4gU28gd2hlbiB0cnlpbmcgdG8KPiBnZXQgdGhlIGJ1ZiB3aGVyZSB0aGUgZGF0YSBpcyBsb2Nh
dGVkLCB5b3Ugc2hvdWxkIGRpcmVjdGx5IHVzZSB0aGUKPiBwb2ludGVyKHApIHRvIGdldCB0aGUg
YWRkcmVzcyBjb3JyZXNwb25kaW5nIHRvIHRoZSBwYWdlLgo+Cj4gQXQgdGhlIHNhbWUgdGltZSwg
dGhlIG9mZnNldCBvZiB0aGUgZGF0YSBpbiB0aGUgcGFnZSBzaG91bGQgYWxzbyBiZQo+IG9idGFp
bmVkIHVzaW5nIG9mZnNldF9pbl9wYWdlKCkuCj4KPiBUaGlzIHBhdGNoIHNvbHZlcyB0aGlzIHBy
b2JsZW0uIEJ1dCBpZiB5b3UgZG9u4oCZdCB1c2UgdGhpcyBwYXRjaCwgdGhlCj4gb3JpZ2luYWwg
Y29kZSBjYW4gYWxzbyBydW4sIGJlY2F1c2UgaWYgdGhlIHBhZ2UgaXMgbm90IHRoZSBwYWdlIG9m
IHRoZQo+IGN1cnJlbnQgZGF0YSwgdGhlIGNhbGN1bGF0ZWQgdGFpbHJvb20gd2lsbCBiZSBsZXNz
IHRoYW4gMCwgYW5kIHdpbGwgbm90Cj4gZW50ZXIgdGhlIGxvZ2ljIG9mIGJ1aWxkX3NrYigpIC4g
VGhlIHNpZ25pZmljYW5jZSBvZiB0aGlzIHBhdGNoIGlzIHRvCj4gbW9kaWZ5IHRoaXMgbG9naWNh
bCBwcm9ibGVtLCBhbGxvd2luZyBtb3JlIHNpdHVhdGlvbnMgdG8gdXNlCj4gYnVpbGRfc2tiKCku
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29t
Pgo+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+IC0tLQo+
ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgOCArKysrKystLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCAz
ZTQ2YzEyZGRlMDguLjA3M2ZlYzRjMGRmMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtNDA3LDggKzQw
NywxMiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpLAo+ICAgCQkgKiBzZWUgYWRkX3JlY3ZidWZfbWVyZ2VhYmxlKCkgKyBnZXRfbWVy
Z2VhYmxlX2J1Zl9sZW4oKQo+ICAgCQkgKi8KPiAgIAkJdHJ1ZXNpemUgPSBQQUdFX1NJWkU7Cj4g
LQkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIG9mZnNldDsKPiAtCQlidWYgPSBwYWdlX2Fk
ZHJlc3MocGFnZSk7Cj4gKwo+ICsJCS8qIHBhZ2UgbWF5YmUgaGVhZCBwYWdlLCBzbyB3ZSBzaG91
bGQgZ2V0IHRoZSBidWYgYnkgcCwgbm90IHRoZQo+ICsJCSAqIHBhZ2UKPiArCQkgKi8KPiArCQl0
YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gb2Zmc2V0X2luX3BhZ2UocCk7Cj4gKwkJYnVmID0g
KGNoYXIgKikoKHVuc2lnbmVkIGxvbmcpcCAmIFBBR0VfTUFTSyk7Cj4gICAJfSBlbHNlIHsKPiAg
IAkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbjsKPiAgIAkJYnVmID0gcDsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
