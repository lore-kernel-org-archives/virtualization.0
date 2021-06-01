Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B72C47080
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:56:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F21261375
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F21261375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFDF783C79;
	Tue,  1 Jun 2021 08:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id voVs49b-oJ_b; Tue,  1 Jun 2021 08:55:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CB3883C61;
	Tue,  1 Jun 2021 08:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49982C000D;
	Tue,  1 Jun 2021 08:55:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0978CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E34014044F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8gfcDh5aOw3O
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:55:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79C5B40339
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622537754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PY7QvG98jjhMnaQtt0qVDMLMnjgFKr3v5evHIzJFZPU=;
 b=gJ3aoqGDA7aSMhZGffwJItHWkXshCl0FpcnQvf8PPPqQDck8B+xUqFPcfLOFbZzfK1bh8U
 0MSSFH4M7F8Ek8/YX8YQnjuRfibJ3nD1AsW7oh31adbMSh6gUg0LefrnPziWcoSEPkuXK3
 Bh1CcmbIWl2pBhmlqUbzMORfB2K3OQI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-k-lmUnKUNj2B02YTjPwu5g-1; Tue, 01 Jun 2021 04:55:53 -0400
X-MC-Unique: k-lmUnKUNj2B02YTjPwu5g-1
Received: by mail-pf1-f198.google.com with SMTP id
 s5-20020aa78d450000b02902ace63a7e93so7003342pfe.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 01:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PY7QvG98jjhMnaQtt0qVDMLMnjgFKr3v5evHIzJFZPU=;
 b=kBHFowT3LrAIioG++Tfau+DEt97xC6tpT9lKlkrggsOkqw+fDWN9s+qWR8g/NLjBMi
 seoWMTkl+yPyjIR+1mx1WyBhxIotjH99iQc6oG1qkiDhfWfE3YhgrzDguFv6ky6GymWg
 E7mVOAGNRvVcFoLypAljOPmQ59SO+BFtI2R1hk4V3tNyj7sBtGhDHgROaOManfA6uGQl
 U0Vydkj4nOddHJpgB6etGkyiQwMCeFBs1RYzIAmL4QEQRdVhZlU0+H9EY1hzqKAoXmHJ
 hdnIlAdOxf7iFeY3J0I9SB1aCXOdwWc/szMeg1SKhnZ4omyTCUAs7HWNagBuEuzU5Ko6
 V/9g==
X-Gm-Message-State: AOAM530aIorNutWh5heO927zdMWY+bs697q/Yt4BQjocpANm8i8Jd7NT
 wI7998W2HG+OgIaFgUofvc9Ro/lSx/LiOqDulPN7zNN5rH109vE3DaG6YWZ+3vYI+w1v6QiLY0A
 a1KKBe8dQYW7yV4BJC6NNLn+mlpkG4UamIQOo9X4EhA==
X-Received: by 2002:a63:b507:: with SMTP id y7mr27012031pge.74.1622537752108; 
 Tue, 01 Jun 2021 01:55:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKw7SvOWAkrqbo3g5ghE03u4CDleLTZxkw6OTAQFt0JQyWPfxEXSmv/ACbNht9ydqPWa3N+Q==
X-Received: by 2002:a63:b507:: with SMTP id y7mr27012023pge.74.1622537751925; 
 Tue, 01 Jun 2021 01:55:51 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n17sm2261391pfv.125.2021.06.01.01.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 01:55:51 -0700 (PDT)
Subject: Re: [PATCH net v2 2/2] virtio_net: get build_skb() buf by data ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
 <20210601064000.66909-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3e0f4152-b41f-5cd4-ee38-95bae89ad1b2@redhat.com>
Date: Tue, 1 Jun 2021 16:55:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601064000.66909-3-xuanzhuo@linux.alibaba.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8xIM/CzucyOjQwLCBYdWFuIFpodW8g0LS1wDoKPiBJbiB0aGUgY2FzZSBvZiBt
ZXJnZSwgdGhlIHBhZ2UgcGFzc2VkIGludG8gcGFnZV90b19za2IoKSBtYXkgYmUgYSBoZWFkCj4g
cGFnZSwgbm90IHRoZSBwYWdlIHdoZXJlIHRoZSBjdXJyZW50IGRhdGEgaXMgbG9jYXRlZC4gU28g
d2hlbiB0cnlpbmcgdG8KPiBnZXQgdGhlIGJ1ZiB3aGVyZSB0aGUgZGF0YSBpcyBsb2NhdGVkLCB3
ZSBzaG91bGQgZ2V0IGJ1ZiBiYXNlZCBvbgo+IGhlYWRyb29tIGluc3RlYWQgb2Ygb2Zmc2V0Lgo+
Cj4gVGhpcyBwYXRjaCBzb2x2ZXMgdGhpcyBwcm9ibGVtLiBCdXQgaWYgeW91IGRvbid0IHVzZSB0
aGlzIHBhdGNoLCB0aGUKPiBvcmlnaW5hbCBjb2RlIGNhbiBhbHNvIHJ1biwgYmVjYXVzZSBpZiB0
aGUgcGFnZSBpcyBub3QgdGhlIHBhZ2Ugb2YgdGhlCj4gY3VycmVudCBkYXRhLCB0aGUgY2FsY3Vs
YXRlZCB0YWlscm9vbSB3aWxsIGJlIGxlc3MgdGhhbiAwLCBhbmQgd2lsbCBub3QKPiBlbnRlciB0
aGUgbG9naWMgb2YgYnVpbGRfc2tiKCkgLiBUaGUgc2lnbmlmaWNhbmNlIG9mIHRoaXMgcGF0Y2gg
aXMgdG8KPiBtb2RpZnkgdGhpcyBsb2dpY2FsIHByb2JsZW0sIGFsbG93aW5nIG1vcmUgc2l0dWF0
aW9ucyB0byB1c2UKPiBidWlsZF9za2IoKS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgfCAxNyArKysrKystLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgoKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA2YjkyOWFjYTE1NWEuLmZhNDA3ZWI4
YjQ1NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtNDAxLDE4ICs0MDEsMTMgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgIAkvKiBJ
ZiBoZWFkcm9vbSBpcyBub3QgMCwgdGhlcmUgaXMgYW4gb2Zmc2V0IGJldHdlZW4gdGhlIGJlZ2lu
bmluZyBvZiB0aGUKPiAgIAkgKiBkYXRhIGFuZCB0aGUgYWxsb2NhdGVkIHNwYWNlLCBvdGhlcndp
c2UgdGhlIGRhdGEgYW5kIHRoZSBhbGxvY2F0ZWQKPiAgIAkgKiBzcGFjZSBhcmUgYWxpZ25lZC4K
PiArCSAqCj4gKwkgKiBCdWZmZXJzIHdpdGggaGVhZHJvb20gdXNlIFBBR0VfU0laRSBhcyBhbGxv
YyBzaXplLCBzZWUKPiArCSAqIGFkZF9yZWN2YnVmX21lcmdlYWJsZSgpICsgZ2V0X21lcmdlYWJs
ZV9idWZfbGVuKCkKPiAgIAkgKi8KPiAtCWlmIChoZWFkcm9vbSkgewo+IC0JCS8qIEJ1ZmZlcnMg
d2l0aCBoZWFkcm9vbSB1c2UgUEFHRV9TSVpFIGFzIGFsbG9jIHNpemUsCj4gLQkJICogc2VlIGFk
ZF9yZWN2YnVmX21lcmdlYWJsZSgpICsgZ2V0X21lcmdlYWJsZV9idWZfbGVuKCkKPiAtCQkgKi8K
PiAtCQl0cnVlc2l6ZSA9IFBBR0VfU0laRTsKPiAtCQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVu
IC0gb2Zmc2V0Owo+IC0JCWJ1ZiA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsKPiAtCX0gZWxzZSB7Cj4g
LQkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbjsKPiAtCQlidWYgPSBwOwo+IC0JfQo+ICsJdHJ1
ZXNpemUgPSBoZWFkcm9vbSA/IFBBR0VfU0laRSA6IHRydWVzaXplOwo+ICsJdGFpbHJvb20gPSB0
cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29tOwo+ICsJYnVmID0gcCAtIGhlYWRyb29tOwo+ICAgCj4g
ICAJbGVuIC09IGhkcl9sZW47Cj4gICAJb2Zmc2V0ICs9IGhkcl9wYWRkZWRfbGVuOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
