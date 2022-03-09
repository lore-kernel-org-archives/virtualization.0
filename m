Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A436BC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C8A68290B;
	Wed,  9 Mar 2022 09:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rvm6oGNE4io8; Wed,  9 Mar 2022 09:15:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA65F82865;
	Wed,  9 Mar 2022 09:14:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C209C0012;
	Wed,  9 Mar 2022 09:14:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 095F7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0636382865
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nw1OH_iN4w2I
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:14:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 057CA82884
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646817296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sc9oWQ1T35bRoFzTSlgzenvWUozmVf90/ZtKZIwMHUs=;
 b=EKDNhhxOZjbWhJTtS+5mu33ZxOh0SeHPZqD+cVEut5kfNE0s5AjOfpjguJ2GDhEjKWN+RS
 /HJM6vDYpIsezzr6gZwxNd01AtqjvtJFvR9nr1JZr0ebyix6xSqAViqHf4xQaYVbi2rGfG
 enLTGSFPvPAA4fmkIJ2gprJVLPynKmQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-I_qZoQaLNT2isZosQPH0yg-1; Wed, 09 Mar 2022 04:14:55 -0500
X-MC-Unique: I_qZoQaLNT2isZosQPH0yg-1
Received: by mail-pj1-f69.google.com with SMTP id
 e1-20020a17090a280100b001bf44b6d74bso3459830pjd.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 01:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sc9oWQ1T35bRoFzTSlgzenvWUozmVf90/ZtKZIwMHUs=;
 b=wZ/jmAguFJU3faR1xjSKy3hcIuGHfaT4lQ3qia0dN2OFCaMV9j408IaWSTvnpfPgy9
 GnQjUn2jJKxf6A07hmm5CezzoET29erTqhd8EULaQcjw1sZUA4ZcoZgrbz/is8yCLdco
 hAIn8roFUxjOrYb2TmBrvPPYVAaYVl9CA2Jl6ZWrJUT0W2UGMf6aV5Y0YPrCpX2aRf6Z
 6vgE8aPtPGQXzSX1LxZD5+FYP/E77cNR9MDNeW1po+7Z2cEzskMFz2BfvPFWoJj5teIQ
 TuGOg/bR+OWnf4pFbgrUNxTeFdhbB6FWgVZRdK/sBeQBXb8CMZ4BLAwEPVUcsIqe3f76
 CQ7w==
X-Gm-Message-State: AOAM532eIeiXTrTpPqw3GxlNXXb3VHJCCYqCP67isTosV3SHRHz6RZfz
 nD1OI3tItnWR1agjr5lZ6JPeJWWZizZwx9Pr+tMn0VXbJBlV8hcVpP1hrJd4DoHAg7ksa9KIcAU
 WjiUlQainRJEV/v0LCCs1iGR3wx92y0aDTuVxdxDoFg==
X-Received: by 2002:a17:90b:1b43:b0:1bf:6180:367a with SMTP id
 nv3-20020a17090b1b4300b001bf6180367amr9413305pjb.172.1646817294458; 
 Wed, 09 Mar 2022 01:14:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybmsMuEBcxZ7oYSDw9tPVnvRoFjWIEzgnMTihTr3NYtzJOE9wVfTp/SLtdAOZZcYSLhnlPZw==
X-Received: by 2002:a17:90b:1b43:b0:1bf:6180:367a with SMTP id
 nv3-20020a17090b1b4300b001bf6180367amr9413201pjb.172.1646817294071; 
 Wed, 09 Mar 2022 01:14:54 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a63df51000000b0036b9776ae5bsm1721846pgj.85.2022.03.09.01.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 01:14:53 -0800 (PST)
Message-ID: <7ff78ff8-bdd0-bb5e-1cea-cf1126226feb@redhat.com>
Date: Wed, 9 Mar 2022 17:14:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 24/26] virtio_net: support rx/tx queue reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-25-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-25-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFRoaXMgcGF0Y2gg
aW1wbGVtZW50cyB0aGUgcmVzZXQgZnVuY3Rpb24gb2YgdGhlIHJ4LCB0eCBxdWV1ZXMuCj4KPiBC
YXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcg
bnVtIG9mIHRoZQo+IHF1ZXVlLiBBbmQgcXVpY2tseSByZWN5Y2xlIHRoZSBidWZmZXIgaW4gdGhl
IHF1ZXVlLgo+Cj4gSW4gdGhlIHByb2Nlc3Mgb2YgdGhlIHF1ZXVlIGRpc2FibGUsIGluIHRoZW9y
eSwgYXMgbG9uZyBhcyB2aXJ0aW8KPiBzdXBwb3J0cyBxdWV1ZSByZXNldCwgdGhlcmUgd2lsbCBi
ZSBubyBleGNlcHRpb25zLgo+Cj4gSG93ZXZlciwgaW4gdGhlIHByb2Nlc3Mgb2YgdGhlIHF1ZXVl
IGVuYWJsZSwgdGhlcmUgbWF5IGJlIGV4Y2VwdGlvbnMgZHVlIHRvCj4gbWVtb3J5IGFsbG9jYXRp
b24uICBJbiB0aGlzIGNhc2UsIHZxIGlzIG5vdCBhdmFpbGFibGUsIGJ1dCB3ZSBzdGlsbCBoYXZl
Cj4gdG8gZXhlY3V0ZSBuYXBpX2VuYWJsZSgpLiBCZWNhdXNlIG5hcGlfZGlzYWJsZSBpcyBzaW1p
bGFyIHRvIGEgbG9jaywKPiBuYXBpX2VuYWJsZSBtdXN0IGJlIGNhbGxlZCBhZnRlciBjYWxsaW5n
IG5hcGlfZGlzYWJsZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxMDcg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTA3IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA0MDlhOGUxODA5MTguLmZm
ZmYzMjNkY2VmMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjUxLDYgKzI1MSwxMSBAQCBzdHJ1Y3Qg
cGFkZGVkX3ZuZXRfaGRyIHsKPiAgIAljaGFyIHBhZGRpbmdbNF07Cj4gICB9Owo+ICAgCj4gK3N0
YXRpYyB2b2lkIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSwKPiArCQkJCQlzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EpOwo+ICtzdGF0aWMgdm9pZCB2aXJ0
bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gKwkJCQkJ
c3RydWN0IHJlY2VpdmVfcXVldWUgKnJxKTsKPiArCj4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJh
bWUodm9pZCAqcHRyKQo+ICAgewo+ICAgCXJldHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJU
SU9fWERQX0ZMQUc7Cj4gQEAgLTEzNjksNiArMTM3NCw5IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRf
bmFwaV9lbmFibGUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFw
aSkKPiAgIHsKPiAgIAluYXBpX2VuYWJsZShuYXBpKTsKPiAgIAo+ICsJaWYgKHZxLT5yZXNldCkK
PiArCQlyZXR1cm47Cj4gKwoKCkxldCdzIFdBUk5fT05DRSgpIGhlcmU/CgoKPiAgIAkvKiBJZiBh
bGwgYnVmZmVycyB3ZXJlIGZpbGxlZCBieSBvdGhlciBzaWRlIGJlZm9yZSB3ZSBuYXBpX2VuYWJs
ZWQsIHdlCj4gICAJICogd29uJ3QgZ2V0IGFub3RoZXIgaW50ZXJydXB0LCBzbyBwcm9jZXNzIGFu
eSBvdXRzdGFuZGluZyBwYWNrZXRzIG5vdy4KPiAgIAkgKiBDYWxsIGxvY2FsX2JoX2VuYWJsZSBh
ZnRlciB0byB0cmlnZ2VyIHNvZnRJUlEgcHJvY2Vzc2luZy4KPiBAQCAtMTQxMyw2ICsxNDIxLDEw
IEBAIHN0YXRpYyB2b2lkIHJlZmlsbF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAg
IAkJc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxID0gJnZpLT5ycVtpXTsKPiAgIAo+ICAgCQluYXBp
X2Rpc2FibGUoJnJxLT5uYXBpKTsKPiArCQlpZiAocnEtPnZxLT5yZXNldCkgewo+ICsJCQl2aXJ0
bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiArCQkJY29udGludWU7Cj4gKwkJ
fQoKClRoaXMgc2VlbXMgcmFjeSBhbmQgaXQncyBhIGhpbnQgdGhhdCB3ZSBuZWVkIHN5bmMgd2l0
aCB0aGUgcmVmaWxsIHdvcmsgCmR1cmluZyByZXNldCBsaWtlIHdoYXQgd2UgZGlkIGluIHZpcnRu
ZXRfY2xvc2UoKToKCiDCoMKgwqDCoMKgwqDCoCAvKiBNYWtlIHN1cmUgcmVmaWxsX3dvcmsgZG9l
c24ndCByZS1lbmFibGUgbmFwaSEgKi8KIMKgwqDCoMKgwqDCoMKgIGNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygmdmktPnJlZmlsbCk7CgoKPiAgIAkJc3RpbGxfZW1wdHkgPSAhdHJ5X2ZpbGxfcmVj
dih2aSwgcnEsIEdGUF9LRVJORUwpOwo+ICAgCQl2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwg
JnJxLT5uYXBpKTsKPiAgIAo+IEBAIC0xNTIzLDYgKzE1MzUsOSBAQCBzdGF0aWMgdm9pZCB2aXJ0
bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gICAJaWYgKCFzcS0+
bmFwaS53ZWlnaHQgfHwgaXNfeGRwX3Jhd19idWZmZXJfcXVldWUodmksIGluZGV4KSkKPiAgIAkJ
cmV0dXJuOwo+ICAgCj4gKwlpZiAoc3EtPnZxLT5yZXNldCkKPiArCQlyZXR1cm47CgoKSXQgbG9v
a3MgdG8gbWUgd2UnZCBiZXR0ZXIgZWl0aGVyIFdBUk4gb3IganVzdCByZW1vdmUgdGhpcy4gU2lu
Y2UgaXQgCmxvb2tzIGxpa2UgYSB3b3JrYXJvdW5kIGZvciB0aGUgdW4tc3luY2hyb25pemVkIE5B
UEkgc29tZWhvdy4KCgo+ICsKPiAgIAlpZiAoX19uZXRpZl90eF90cnlsb2NrKHR4cSkpIHsKPiAg
IAkJZG8gewo+ICAgCQkJdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiBAQCAtMTc2OSw2
ICsxNzg0LDk4IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZm
ICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gICAJcmV0dXJuIE5FVERFVl9UWF9PSzsK
PiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRuZXRfcnhfdnFfcmVzZXQoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksCj4gKwkJCSAgICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiBy
aW5nX251bSkKCgpJdCdzIGJldHRlciB0byByZW5hbWUgdGhpcyBhcyB2aXJ0bmV0X3J4X3Jlc2l6
ZSgpLgoKCj4gK3sKPiArCWludCBlcnI7Cj4gKwo+ICsJLyogc3RvcCBuYXBpICovCj4gKwluYXBp
X2Rpc2FibGUoJnJxLT5uYXBpKTsKPiArCgoKSGVyZSwgYXMgZGlzY3Vzc2VkIGFib3ZlLCB3ZSBu
ZWVkIHN5bmNocm9uaXplIHdpdGggdGhlIHJlZmlsbCB3b3JrLgoKCj4gKwkvKiByZXNldCB0aGUg
cXVldWUgKi8KPiArCWVyciA9IHZpcnRpb19yZXNldF92cShycS0+dnEpOwo+ICsJaWYgKGVycikK
PiArCQlnb3RvIGVycjsKCgpCdHcsIG1vc3QgY29tbWVudCBvZiB0aGlzIGZ1bmN0aW9uIHNlZW1z
IHVzZWxlc3Mgc2luY2UgY29kZSBhbHJlYWR5IApleHBsYWluIHRoZW1zZWx2ZXMuCgoKPiArCj4g
KwkvKiBmcmVlIGJ1ZnMgKi8KPiArCXZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmcyh2aSwgcnEp
Owo+ICsKPiArCS8qIHJlc2V0IHZyaW5nLiAqLwo+ICsJZXJyID0gdmlydHF1ZXVlX3Jlc2V0X3Zy
aW5nKHJxLT52cSwgcmluZ19udW0pOwo+ICsJaWYgKGVycikKPiArCQlnb3RvIGVycjsKPiArCj4g
KwkvKiBlbmFibGUgcmVzZXQgcXVldWUgKi8KPiArCWVyciA9IHZpcnRpb19lbmFibGVfcmVzZXRx
KHJxLT52cSk7Cj4gKwlpZiAoZXJyKQo+ICsJCWdvdG8gZXJyOwo+ICsKPiArCS8qIGZpbGwgcmVj
diAqLwo+ICsJaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4gKwkJc2No
ZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+cmVmaWxsLCAwKTsKPiArCj4gKwkvKiBlbmFibGUgbmFw
aSAqLwo+ICsJdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4gKwlyZXR1
cm4gMDsKPiArCj4gK2VycjoKPiArCW5ldGRldl9lcnIodmktPmRldiwKPiArCQkgICAicmVzZXQg
cnggcmVzZXQgdnEgZmFpbDogcnggcXVldWUgaW5kZXg6ICVsZCBlcnI6ICVkXG4iLAo+ICsJCSAg
IHJxIC0gdmktPnJxLCBlcnIpOwo+ICsJdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+
bmFwaSk7Cj4gKwlyZXR1cm4gZXJyOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IHZpcnRuZXRfdHhf
dnFfcmVzZXQoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gKwkJCSAgICAgICBzdHJ1Y3Qgc2Vu
ZF9xdWV1ZSAqc3EsIHUzMiByaW5nX251bSkKPiArewoKCkl0IGxvb2tzIHRvIG1lIGl0J3MgYmV0
dGVyIHRvIHJlbmFtZSB0aGlzIGFzICJ2aXJ0bmV0X3J4X3Jlc2l6ZSgpIgoKCj4gKwlzdHJ1Y3Qg
bmV0ZGV2X3F1ZXVlICp0eHE7Cj4gKwlpbnQgZXJyLCBxaW5kZXg7Cj4gKwo+ICsJcWluZGV4ID0g
c3EgLSB2aS0+c3E7Cj4gKwo+ICsJdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBx
aW5kZXgpOwo+ICsJX19uZXRpZl90eF9sb2NrX2JoKHR4cSk7Cj4gKwo+ICsJLyogc3RvcCB0eCBx
dWV1ZSBhbmQgbmFwaSAqLwo+ICsJbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBxaW5kZXgp
Owo+ICsJdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKCgpUaGVyZSdzIG5vIG5l
ZWQgdG8gaG9sZCB0eCBsb2NrIGZvciBuYXBpIGRpc2FibGUuCgpUaGFua3MKCgo+ICsKPiArCV9f
bmV0aWZfdHhfdW5sb2NrX2JoKHR4cSk7Cj4gKwo+ICsJLyogcmVzZXQgdGhlIHF1ZXVlICovCj4g
KwllcnIgPSB2aXJ0aW9fcmVzZXRfdnEoc3EtPnZxKTsKPiArCWlmIChlcnIpIHsKPiArCQluZXRp
Zl9zdGFydF9zdWJxdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+ICsJCWdvdG8gZXJyOwo+ICsJfQo+
ICsKPiArCS8qIGZyZWUgYnVmcyAqLwo+ICsJdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWZzKHZp
LCBzcSk7Cj4gKwo+ICsJLyogcmVzZXQgdnJpbmcuICovCj4gKwllcnIgPSB2aXJ0cXVldWVfcmVz
ZXRfdnJpbmcoc3EtPnZxLCByaW5nX251bSk7Cj4gKwlpZiAoZXJyKQo+ICsJCWdvdG8gZXJyOwo+
ICsKPiArCS8qIGVuYWJsZSByZXNldCBxdWV1ZSAqLwo+ICsJZXJyID0gdmlydGlvX2VuYWJsZV9y
ZXNldHEoc3EtPnZxKTsKPiArCWlmIChlcnIpCj4gKwkJZ290byBlcnI7Cj4gKwo+ICsJLyogc3Rh
cnQgdHggcXVldWUgYW5kIG5hcGkgKi8KPiArCW5ldGlmX3N0YXJ0X3N1YnF1ZXVlKHZpLT5kZXYs
IHFpbmRleCk7Cj4gKwl2aXJ0bmV0X25hcGlfdHhfZW5hYmxlKHZpLCBzcS0+dnEsICZzcS0+bmFw
aSk7Cj4gKwlyZXR1cm4gMDsKPiArCj4gK2VycjoKPiArCW5ldGRldl9lcnIodmktPmRldiwKPiAr
CQkgICAicmVzZXQgdHggcmVzZXQgdnEgZmFpbDogdHggcXVldWUgaW5kZXg6ICVsZCBlcnI6ICVk
XG4iLAo+ICsJCSAgIHNxIC0gdmktPnNxLCBlcnIpOwo+ICsJdmlydG5ldF9uYXBpX3R4X2VuYWJs
ZSh2aSwgc3EtPnZxLCAmc3EtPm5hcGkpOwo+ICsJcmV0dXJuIGVycjsKPiArfQo+ICsKPiAgIC8q
Cj4gICAgKiBTZW5kIGNvbW1hbmQgdmlhIHRoZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sg
c3RhdHVzLiAgQ29tbWFuZHMKPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMg
aW5kaWNhdGVkIGJ5IGZlYXR1cmUgYml0cywgc2hvdWxkCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
