Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E80C433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 03:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00EE640348;
	Tue, 18 Jan 2022 03:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ealIsjfdejXR; Tue, 18 Jan 2022 03:10:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 839CF4033D;
	Tue, 18 Jan 2022 03:10:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F519C0039;
	Tue, 18 Jan 2022 03:10:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E452C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0798960C1B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oYjEwPhdesJr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:10:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FBF460C12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642475417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHROM3H3Gj1zTOOoCmnC85BRDlwA1UmiYl4rywuZ64M=;
 b=OhaYyvy6YdxwX7M+UtuoOPGDIcaDk0oMXJtpbHGVl4Fzy4F77DEBQmH7ppr50tjPBoGwft
 AQVjCnycuEawzS/yMlt3qXNt5+UyniRQ4CxzWeyATYCIQ/Y2jDb0eCJ/x+TechdpAMqAcb
 K4fLkwAIjAMJgQxv7U1x57GRSptKRQo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-42PkP9qlPoqt0yn4zndNig-1; Mon, 17 Jan 2022 22:10:07 -0500
X-MC-Unique: 42PkP9qlPoqt0yn4zndNig-1
Received: by mail-pj1-f71.google.com with SMTP id
 x11-20020a17090a6b4b00b001b404624896so1059834pjl.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 19:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VHROM3H3Gj1zTOOoCmnC85BRDlwA1UmiYl4rywuZ64M=;
 b=Ljl0D3Try3EhI53lO1sVA/F12qGZtZa1eXMI1U0o8boPcS5bUV0bM/48eYKFYKR5WT
 KBsdvvS/RDNkRfYaYI6YpNFcRfZqpCIueIfZfIY/ydclnBRd9B0CzUPVin25K1/pEU1A
 dhTnHGVOCiJ8oCvexEUNDt/eOMy9vYYUHgs+B/7lHaMbkCWgs5dQBGthZS1hmipcTLUB
 3Fwc23ozKsLy5WMHeBfns8U7QLQnxGc/Zm3s9mz2M3IHMD/ChP8wZqOfUocQv5o55xXT
 AlMO0z1YkrxaR28TcC5bw7nKDvOyQiTIivxccgMhNuf96TiQODTibC2ZeGzUAcRraDOr
 o6EQ==
X-Gm-Message-State: AOAM531+4rIg4O3HXEIqcsub/uWuG0DDS5Qp6EYIFA7ppuNDH12ATzVX
 bIEa/I5IuJlbiOzxZ9lleupVArfFTetgjXyi2znv/mpoI4TNeUJtcQsgWRLE3nLDJoGuCIc99Ye
 sp8iJux3jeVdvpN5Y8sVlTByx6fzU3go3rs3GWwadiA==
X-Received: by 2002:a63:2210:: with SMTP id i16mr14992528pgi.532.1642475406806; 
 Mon, 17 Jan 2022 19:10:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpr917B1MdxpHfy21aTB02UTG9DuJi4ylO0bN/YcI+iiqs3Cv0o2sHKTxbfK+NwUV144Z2mw==
X-Received: by 2002:a63:2210:: with SMTP id i16mr14992512pgi.532.1642475406468; 
 Mon, 17 Jan 2022 19:10:06 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m3sm14672061pfa.183.2022.01.17.19.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jan 2022 19:10:05 -0800 (PST)
Message-ID: <545d11f3-0b4e-da61-91f3-595ed5608334@redhat.com>
Date: Tue, 18 Jan 2022 11:09:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC 3/3] vdpasim_net: control virtqueue support
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com
References: <20220117092921.1573-1-longpeng2@huawei.com>
 <20220117092921.1573-4-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220117092921.1573-4-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzEvMTcg5LiL5Y2INToyOSwgTG9uZ3BlbmcoTWlrZSkg5YaZ6YGTOgo+IEZyb206
IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPgo+IEludHJvZHVjZXMgdGhlIGNvbnRy
b2wgdmlydHF1ZXVlIHN1cHBvcnQgZm9yIHZkcGFzaW1fbmV0LCBiYXNlZCBvbgo+IEphc29uJ3Mg
UkZDIFsxXS4KPgo+IFsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qva3Zt
L3BhdGNoLzIwMjAwOTI0MDMyMTI1LjE4NjE5LTI1LWphc293YW5nQHJlZGhhdC5jb20vCgoKSSdk
IGV4cGVjdCB0byBpbXBsZW1lbnQgdGhlIHJlY2VpdmUgZmlsdGVyIGFzIHdlbGxbMV0uIFRoaXMg
Z2l2ZXMgdXMgYSAKY2hhbmNlIHRvIHRlc3QgdGhpcy4KClRoYW5rcwoKWzFdIGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDIwLzkvMjMvMTI2OQoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyA8
bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW1fbmV0LmMgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICAxIGZpbGUg
Y2hhbmdlZCwgODEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgYi9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW1fbmV0LmMKPiBpbmRleCA3NmRkMjRhYmM3OTEuLmU5ZTM4OGZkM2NmZiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMKPiArKysg
Yi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMKPiBAQCAtMjYsOSArMjYsODUg
QEAKPiAgICNkZWZpbmUgRFJWX0xJQ0VOU0UgICJHUEwgdjIiCj4gICAKPiAgICNkZWZpbmUgVkRQ
QVNJTV9ORVRfRkVBVFVSRVMJKFZEUEFTSU1fRkVBVFVSRVMgfCBcCj4gLQkJCQkgKDFVTEwgPDwg
VklSVElPX05FVF9GX01BQykpCj4gKwkJCQkgKDFVTEwgPDwgVklSVElPX05FVF9GX01BQykgfCBc
Cj4gKwkJCQkgKDFVTEwgPDwgVklSVElPX05FVF9GX0NUUkxfVlEpIHwgXAo+ICsJCQkJICgxVUxM
IDw8IFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSKSkKPiAgIAo+IC0jZGVmaW5lIFZEUEFTSU1f
TkVUX1ZRX05VTQkyCj4gKyNkZWZpbmUgVkRQQVNJTV9ORVRfVlFfTlVNCTMKPiArCj4gK3ZpcnRp
b19uZXRfY3RybF9hY2sgdmRwYXNpbV9uZXRfaGFuZGxlX2N0cmxfbWFjKHN0cnVjdCB2ZHBhc2lt
ICp2ZHBhc2ltLAo+ICsJCQkJCQl1OCBjbWQpCj4gK3sKPiArCXN0cnVjdCB2ZHBhc2ltX3ZpcnRx
dWV1ZSAqY3ZxID0gJnZkcGFzaW0tPnZxc1syXTsKPiArCXZpcnRpb19uZXRfY3RybF9hY2sgc3Rh
dHVzID0gVklSVElPX05FVF9FUlI7Cj4gKwlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKmNvbmZp
ZyA9IHZkcGFzaW0tPmNvbmZpZzsKPiArCXNpemVfdCByZWFkOwo+ICsKPiArCXN3aXRjaCAoY21k
KSB7Cj4gKwljYXNlIFZJUlRJT19ORVRfQ1RSTF9NQUNfQUREUl9TRVQ6Cj4gKwkJcmVhZCA9IHZy
aW5naF9pb3ZfcHVsbF9pb3RsYigmY3ZxLT52cmluZywgJmN2cS0+b3V0X2lvdiwKPiArCQkJCQkg
ICAgICh2b2lkICopY29uZmlnLT5tYWMsIEVUSF9BTEVOKTsKPiArCQlpZiAocmVhZCA9PSBFVEhf
QUxFTikKPiArCQkJc3RhdHVzID0gVklSVElPX05FVF9PSzsKPiArCQlicmVhazsKPiArCWRlZmF1
bHQ6Cj4gKwkJYnJlYWs7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIHN0YXR1czsKPiArfQo+ICsKPiAr
c3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfaGFuZGxlX2N2cShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bSkKPiArewo+ICsJc3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICpjdnEgPSAmdmRwYXNpbS0+dnFz
WzJdOwo+ICsJdmlydGlvX25ldF9jdHJsX2FjayBzdGF0dXMgPSBWSVJUSU9fTkVUX0VSUjsKPiAr
CXN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfaGRyIGN0cmw7Cj4gKwlzaXplX3QgcmVhZCwgd3JpdGU7
Cj4gKwlpbnQgZXJyOwo+ICsKPiArCWlmICghKHZkcGFzaW0tPmZlYXR1cmVzICYgKDFVTEwgPDwg
VklSVElPX05FVF9GX0NUUkxfVlEpKSkKPiArCQlyZXR1cm47Cj4gKwo+ICsJaWYgKCFjdnEtPnJl
YWR5KQo+ICsJCXJldHVybjsKPiArCj4gKwl3aGlsZSAodHJ1ZSkgewo+ICsJCWVyciA9IHZyaW5n
aF9nZXRkZXNjX2lvdGxiKCZjdnEtPnZyaW5nLCAmY3ZxLT5vdXRfaW92LCAmY3ZxLT5pbl9pb3Ys
Cj4gKwkJCQkJICAgJmN2cS0+aGVhZCwgR0ZQX0FUT01JQyk7Cj4gKwkJaWYgKGVyciA8PSAwKQo+
ICsJCQlicmVhazsKPiArCj4gKwkJcmVhZCA9IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigmY3ZxLT52
cmluZywgJmN2cS0+aW5faW92LCAmY3RybCwKPiArCQkJCQkgICAgIHNpemVvZihjdHJsKSk7Cj4g
KwkJaWYgKHJlYWQgIT0gc2l6ZW9mKGN0cmwpKQo+ICsJCQlicmVhazsKPiArCj4gKwkJc3dpdGNo
IChjdHJsLmNsYXNzKSB7Cj4gKwkJY2FzZSBWSVJUSU9fTkVUX0NUUkxfTUFDOgo+ICsJCQlzdGF0
dXMgPSB2ZHBhc2ltX25ldF9oYW5kbGVfY3RybF9tYWModmRwYXNpbSwgY3RybC5jbWQpOwo+ICsJ
CQlicmVhazsKPiArCQlkZWZhdWx0Ogo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwo+ICsJCS8qIE1h
a2Ugc3VyZSBkYXRhIGlzIHdyb3RlIGJlZm9yZSBhZHZhbmNpbmcgaW5kZXggKi8KPiArCQlzbXBf
d21iKCk7Cj4gKwo+ICsJCXdyaXRlID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZjdnEtPnZyaW5n
LCAmY3ZxLT5vdXRfaW92LAo+ICsJCQkJCSAgICAgICZzdGF0dXMsIHNpemVvZiAoc3RhdHVzKSk7
Cj4gKwkJdnJpbmdoX2NvbXBsZXRlX2lvdGxiKCZjdnEtPnZyaW5nLCBjdnEtPmhlYWQsIHdyaXRl
KTsKPiArCQl2cmluZ2hfa2lvdl9jbGVhbnVwKCZjdnEtPmluX2lvdik7Cj4gKwkJdnJpbmdoX2tp
b3ZfY2xlYW51cCgmY3ZxLT5vdXRfaW92KTsKPiArCj4gKwkJLyogTWFrZSBzdXJlIHVzZWQgaXMg
dmlzaWJsZSBiZWZvcmUgcmFzaW5nIHRoZSBpbnRlcnJ1cHQuICovCj4gKwkJc21wX3dtYigpOwo+
ICsKPiArCQlsb2NhbF9iaF9kaXNhYmxlKCk7Cj4gKwkJaWYgKHZyaW5naF9uZWVkX25vdGlmeV9p
b3RsYigmY3ZxLT52cmluZykgPiAwKQo+ICsJCQl2cmluZ2hfbm90aWZ5KCZjdnEtPnZyaW5nKTsK
PiArCQlsb2NhbF9iaF9lbmFibGUoKTsKPiArCX0KPiArfQo+ICAgCj4gICBzdGF0aWMgdm9pZCB2
ZHBhc2ltX25ldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIHsKPiBAQCAtNDIs
NiArMTE4LDkgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCj4gICAKPiAgIAlzcGluX2xvY2soJnZkcGFzaW0tPmxvY2spOwo+ICAgCj4gKwkv
KiBwcm9jZXNzIGN0cmwgdnEgZmlyc3QgKi8KPiArCXZkcGFzaW1fbmV0X2hhbmRsZV9jdnEodmRw
YXNpbSk7Cj4gKwo+ICAgCWlmICghKHZkcGFzaW0tPnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19E
UklWRVJfT0spKQo+ICAgCQlnb3RvIG91dDsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
