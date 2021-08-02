Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472D9C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 04:45:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43BE610A1
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 04:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D43BE610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C039403F9;
	Mon,  2 Aug 2021 04:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hwczr9SXEWj6; Mon,  2 Aug 2021 04:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F0BD403E7;
	Mon,  2 Aug 2021 04:45:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DEE4C0010;
	Mon,  2 Aug 2021 04:45:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8F9FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 04:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D283760677
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 04:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IsHSm24zlWpu
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 04:45:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1131A60657
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 04:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627879514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWU1k5rzzQ7Vi8eeYiIsQOirmMRXBw0kSKn136zOB28=;
 b=JpsxOPlB/qRZ7Dx0aRNKXyHEZ82qp2t6scCPNwe+oY+eGvXrzZrmIebgK+A70l3+udYcaN
 9L6F9AV11ex1lWDkHcMxz13nb61uLM5P09RWbkokrXJp8G+290H2dQc9dkZobbelv1zvaL
 huHHSd+EyV8EK6HMwRZJFgjT/yoOleM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-n7NQ9iGONOewyI9Rifb8-w-1; Mon, 02 Aug 2021 00:45:13 -0400
X-MC-Unique: n7NQ9iGONOewyI9Rifb8-w-1
Received: by mail-pl1-f199.google.com with SMTP id
 i7-20020a17090332c7b0290124e63feb68so12635696plr.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 01 Aug 2021 21:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=CWU1k5rzzQ7Vi8eeYiIsQOirmMRXBw0kSKn136zOB28=;
 b=i0ZvihAwx6Uid9FINHe9FgzCKjZ6Yp5AMqLGkJBZCKiW7MIipd65RTA4ROXtkSB+Oc
 3vsupj9X9Hj1q0WcHZvqLPx+Ubeu5r8Fa8+BygyqGrejKDB0wjFs+xcD3VPYyh1sTEC2
 VAvIeSh3KE4l4NBHrhCOTKQko2U4m265sT+SsLaxqqqc3zeDBlIfmUr45cqIZ8hWZEVS
 3JabvGOuKaoB+PXqGYTxn2LSxvYSvBPp5XFBu91v0XofzQOcc17JOyjqqDZy7dLhj9TC
 AJnT8pP2eRVZCAMo1TaGTe4Udjw15pxIvfUPOYEDn8ZhTO91/8w80F/rQ/sX++8zAtoA
 dUMw==
X-Gm-Message-State: AOAM531Xnd4YNMOs6p9Q03qnzria7OnFSDgeRHVgZAvnvGNOXEr0eVmB
 dIsIS01rO879OtG7iA163qfCe7CapFUw814N02f4/Q29aFJ2HWokCblsMgpLfjaWrgITFJYHcsG
 nYK0AfvnHUi4cKYdE7x10Sy1CzhCFzVNCxpqf+OXezg==
X-Received: by 2002:a63:1359:: with SMTP id 25mr541177pgt.79.1627879512322;
 Sun, 01 Aug 2021 21:45:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoXngPrq5rRn9UeJyNSEFumVnGGLTEtq2/2ysIovNTb7ygYq/sFdvyihjsErzHXJFXhFvKSg==
X-Received: by 2002:a63:1359:: with SMTP id 25mr541160pgt.79.1627879512138;
 Sun, 01 Aug 2021 21:45:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j128sm10345988pfd.38.2021.08.01.21.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Aug 2021 21:45:11 -0700 (PDT)
Subject: Re: [PATCH net v2 0/2] virtio-net: fix for build_skb()
To: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
 <20210601070610-mutt-send-email-mst@kernel.org>
 <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ec67d98-190e-343d-bc2b-6f42a7ee6402@redhat.com>
Date: Mon, 2 Aug 2021 12:45:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730051643.54198a9e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

CtTaIDIwMjEvNy8zMCDPws7nODoxNiwgSmFrdWIgS2ljaW5za2kg0LS1wDoKPiBPbiBUdWUsIDEg
SnVuIDIwMjEgMDc6MDY6NDMgLTA0MDAgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+PiBPbiBU
dWUsIEp1biAwMSwgMjAyMSBhdCAwMjozOTo1OFBNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4+
PiAjMSBGaXhlZCBhIHNlcmlvdXMgZXJyb3IuCj4+PiAjMiBGaXhlZCBhIGxvZ2ljYWwgZXJyb3Is
IGJ1dCB0aGlzIGVycm9yIGRpZCBub3QgY2F1c2UgYW55IHNlcmlvdXMgY29uc2VxdWVuY2VzLgo+
Pj4KPj4+IFRoZSBsb2dpYyBvZiB0aGlzIHBpZWNlIGlzIHJlYWxseSBtZXNzeS4gRm9ydHVuYXRl
bHksIG15IHJlZmFjdG9yZWQgcGF0Y2ggY2FuIGJlCj4+PiBjb21wbGV0ZWQgd2l0aCBhIHNtYWxs
IGFtb3VudCBvZiB0ZXN0aW5nLgo+PiBMb29rcyBnb29kLCB0aGFua3MhCj4+IEFsc28gbmVlZGVk
IGZvciBzdGFibGUgSSB0aGluay4KPj4KPj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+Cj4gSnVzdCBhIGhlYWRzIHVwIGZvbGtzLCBsb29rcyBsaWtlIHdlIGVu
ZGVkIHVwIG1lcmdpbmcgYm90aCB0aGlzIGFuZCB0aGUKPiBuZXQtbmV4dCB2ZXJzaW9uIG9mIHRo
ZSBwYXRjaCBzZXQ6Cj4KPiA4ZmI3ZGE5ZTk5MDcgdmlydGlvX25ldDogZ2V0IGJ1aWxkX3NrYigp
IGJ1ZiBieSBkYXRhIHB0cgo+IDVjMzc3MTFkOWYyNyB2aXJ0aW8tbmV0OiBmaXggZm9yIHVuYWJs
ZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzcwo+Cj4gYW5kCj4KPiA3YmY2NDQ2MGUz
YjIgdmlydGlvLW5ldDogZ2V0IGJ1aWxkX3NrYigpIGJ1ZiBieSBkYXRhIHB0cgo+IDZjNjZjMTQ3
YjlhNCB2aXJ0aW8tbmV0OiBmaXggZm9yIHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3Ig
YWRkcmVzcwo+Cj4gQXJlIHlvdSBva2F5IHdpdGggdGhlIGNvZGUgYXMgaXMgb3Igc2hvdWxkIHdl
IGNvbW1pdCBzb21ldGhpbmcgbGlrZToKCgpJIHRoaW5rIHdlIG5lZWQgY29tbWl0IHRoZSBmb2xs
b3dpbmcgY29kZXMgc2luY2UgaXQncyBtb3JlIGVhc2llciB0byBiZSAKdW5kZXJzdG9vZC4KClRo
YW5rcwoKCj4KPiAtLS0KPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA1NmMzZjg1MTkwOTMuLjc0NDgyYTUy
ZjA3NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMzgwLDcgKzM4MCw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
c2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCQkJICAg
c3RydWN0IHBhZ2UgKnBhZ2UsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gICAJCQkJICAgdW5zaWdu
ZWQgaW50IGxlbiwgdW5zaWduZWQgaW50IHRydWVzaXplLAo+ICAgCQkJCSAgIGJvb2wgaGRyX3Zh
bGlkLCB1bnNpZ25lZCBpbnQgbWV0YXNpemUsCj4gLQkJCQkgICBib29sIHdob2xlX3BhZ2UpCj4g
KwkJCQkgICB1bnNpZ25lZCBpbnQgaGVhZHJvb20pCj4gICB7Cj4gICAJc3RydWN0IHNrX2J1ZmYg
KnNrYjsKPiAgIAlzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmICpoZHI7Cj4gQEAgLTM5
OCwyOCArMzk4LDE2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJZWxzZQo+ICAgCQloZHJfcGFkZGVkX2xlbiA9IHNpemVv
ZihzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyKTsKPiAgIAo+IC0JLyogSWYgd2hvbGVfcGFnZSwgdGhl
cmUgaXMgYW4gb2Zmc2V0IGJldHdlZW4gdGhlIGJlZ2lubmluZyBvZiB0aGUKPiArCS8qIElmIGhl
YWRyb29tIGlzIG5vdCAwLCB0aGVyZSBpcyBhbiBvZmZzZXQgYmV0d2VlbiB0aGUgYmVnaW5uaW5n
IG9mIHRoZQo+ICAgCSAqIGRhdGEgYW5kIHRoZSBhbGxvY2F0ZWQgc3BhY2UsIG90aGVyd2lzZSB0
aGUgZGF0YSBhbmQgdGhlIGFsbG9jYXRlZAo+ICAgCSAqIHNwYWNlIGFyZSBhbGlnbmVkLgo+ICAg
CSAqCj4gICAJICogQnVmZmVycyB3aXRoIGhlYWRyb29tIHVzZSBQQUdFX1NJWkUgYXMgYWxsb2Mg
c2l6ZSwgc2VlCj4gICAJICogYWRkX3JlY3ZidWZfbWVyZ2VhYmxlKCkgKyBnZXRfbWVyZ2VhYmxl
X2J1Zl9sZW4oKQo+ICAgCSAqLwo+IC0JaWYgKHdob2xlX3BhZ2UpIHsKPiAtCQkvKiBCdWZmZXJz
IHdpdGggd2hvbGVfcGFnZSB1c2UgUEFHRV9TSVpFIGFzIGFsbG9jIHNpemUsCj4gLQkJICogc2Vl
IGFkZF9yZWN2YnVmX21lcmdlYWJsZSgpICsgZ2V0X21lcmdlYWJsZV9idWZfbGVuKCkKPiAtCQkg
Ki8KPiAtCQl0cnVlc2l6ZSA9IFBBR0VfU0laRTsKPiAtCj4gLQkJLyogcGFnZSBtYXliZSBoZWFk
IHBhZ2UsIHNvIHdlIHNob3VsZCBnZXQgdGhlIGJ1ZiBieSBwLCBub3QgdGhlCj4gLQkJICogcGFn
ZQo+IC0JCSAqLwo+IC0JCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW4gLSBvZmZzZXRfaW5fcGFn
ZShwKTsKPiAtCQlidWYgPSAoY2hhciAqKSgodW5zaWduZWQgbG9uZylwICYgUEFHRV9NQVNLKTsK
PiAtCX0gZWxzZSB7Cj4gLQkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbjsKPiAtCQlidWYgPSBw
Owo+IC0JfQo+ICsJdHJ1ZXNpemUgPSBoZWFkcm9vbSA/IFBBR0VfU0laRSA6IHRydWVzaXplOwo+
ICsJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29tOwo+ICsJYnVmID0gcCAtIGhl
YWRyb29tOwo+ICAgCj4gICAJbGVuIC09IGhkcl9sZW47Cj4gICAJb2Zmc2V0ICs9IGhkcl9wYWRk
ZWRfbGVuOwo+IEBAIC05NzgsNyArOTY2LDggQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNl
aXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgCQkJCXB1dF9wYWdlKHBh
Z2UpOwo+ICAgCQkJCWhlYWRfc2tiID0gcGFnZV90b19za2IodmksIHJxLCB4ZHBfcGFnZSwgb2Zm
c2V0LAo+ICAgCQkJCQkJICAgICAgIGxlbiwgUEFHRV9TSVpFLCBmYWxzZSwKPiAtCQkJCQkJICAg
ICAgIG1ldGFzaXplLCB0cnVlKTsKPiArCQkJCQkJICAgICAgIG1ldGFzaXplLAo+ICsJCQkJCQkg
ICAgICAgVklSVElPX1hEUF9IRUFEUk9PTSk7Cj4gICAJCQkJcmV0dXJuIGhlYWRfc2tiOwo+ICAg
CQkJfQo+ICAgCQkJYnJlYWs7Cj4gQEAgLTEwMjksNyArMTAxOCw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
c2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAly
Y3VfcmVhZF91bmxvY2soKTsKPiAgIAo+ICAgCWhlYWRfc2tiID0gcGFnZV90b19za2IodmksIHJx
LCBwYWdlLCBvZmZzZXQsIGxlbiwgdHJ1ZXNpemUsICF4ZHBfcHJvZywKPiAtCQkJICAgICAgIG1l
dGFzaXplLCAhIWhlYWRyb29tKTsKPiArCQkJICAgICAgIG1ldGFzaXplLCBoZWFkcm9vbSk7Cj4g
ICAJY3Vycl9za2IgPSBoZWFkX3NrYjsKPiAgIAo+ICAgCWlmICh1bmxpa2VseSghY3Vycl9za2Ip
KQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
