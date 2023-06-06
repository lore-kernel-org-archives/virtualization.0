Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053A7C77B73
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 02:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F5FF41579;
	Tue,  6 Jun 2023 02:03:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F5FF41579
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PeVbaO1W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id daTvmypQT2-g; Tue,  6 Jun 2023 02:03:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6A5D54155B;
	Tue,  6 Jun 2023 02:03:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A5D54155B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AE57C007A;
	Tue,  6 Jun 2023 02:03:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD3A7C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC1E160F91
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC1E160F91
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PeVbaO1W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUPgCsLWi0_4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9FC060F83
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9FC060F83
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686016980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6C9VSQMGK50X1DW2+MpQLN1ZZJnh0O9qWc8VaDzp0=;
 b=PeVbaO1WVIrPOZtbLxloBeCGEootFMrU8jgRnc8gxTb/zWYqj0ygj0ArFpQdOFaZc3AjR/
 /BA91/8FHfEv47dDbtEYM5DPmSmyhB8QiPo7tYH1Z79FhFhL59sCc8aBXPy2QtF7+KJa48
 k/z2Nrky20RO7RtB0ccd6UudSy/WvuU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-9WxnDzCBMeWYp35HjfMdpQ-1; Mon, 05 Jun 2023 22:02:59 -0400
X-MC-Unique: 9WxnDzCBMeWYp35HjfMdpQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f61f59c230so1818070e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 19:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686016978; x=1688608978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/G6C9VSQMGK50X1DW2+MpQLN1ZZJnh0O9qWc8VaDzp0=;
 b=RWIM7DZkxnYjWqCduwsz3eK/N9t6YzRGkRG6umQLooD68l5k9/pID4Z4zDfznriPED
 /u10M1K5F3e8sXmea0aZ3oUH+75tXnwzOU3ZfEtWDBVGshu/Y8UDSVUUA+l7UAu+KHH6
 v6PZLHJVb0mF+wuOw8d6f5VpknE38IZvtwVDKnSxZD0WBwsGLnwe4H4/gO16HAbD1bid
 MJYDbNPgyrucX+pIePx1PuGZ5J3kN8UHr0f5S7MAsyPiEJSNNkuWUAiOiJu1FLCnTiIm
 6bvJeHJllybgcbtKL+uETLl+cfBQTm5iB4dpkBuc/4nUlCZIorPv7ZVuRbg7MEqZ/irJ
 5DaQ==
X-Gm-Message-State: AC+VfDwNG1EtnPpiOHvTgzzW5rc027fdka8hWv9faerjCqBB6rHQ6BWI
 4GDWLBB0Tp6NzAfNoyqNWe0x0Zb67xm0KWNAlij7ekmuCOOyNN6jRzfiTateRnPJ8ztRj8+iwJv
 rMZS2OJqa/I0Zh/HXXwB1iPy0m9ARVqGOVxqFBuFMML52yo8IcyXDNEHN6g==
X-Received: by 2002:ac2:53bc:0:b0:4f6:13f1:38a4 with SMTP id
 j28-20020ac253bc000000b004f613f138a4mr329976lfh.41.1686016977881; 
 Mon, 05 Jun 2023 19:02:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cIrBnY4kB+bFDDnz2MbnqOP3zSg9ihJbXJhmZVFaL69cW56OPxFnisU6fg5GCTP07K87hMgp4Ask3xq2jWEU=
X-Received: by 2002:ac2:53bc:0:b0:4f6:13f1:38a4 with SMTP id
 j28-20020ac253bc000000b004f613f138a4mr329964lfh.41.1686016977603; Mon, 05 Jun
 2023 19:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230605210237.60988-1-brett.creeley@amd.com>
In-Reply-To: <20230605210237.60988-1-brett.creeley@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jun 2023 10:02:46 +0800
Message-ID: <CACGkMEuurGtxQW4a9xnEzBsjHV+tKPPPFr8+qUm2=OoYH8pSsA@mail.gmail.com>
Subject: Re: [RFC PATCH net] virtio_net: Prevent napi_weight changes with
 VIRTIO_NET_F_NOTF_COAL support
To: Brett Creeley <brett.creeley@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCA1OjAz4oCvQU0gQnJldHQgQ3JlZWxleSA8YnJldHQuY3Jl
ZWxleUBhbWQuY29tPiB3cm90ZToKPgo+IENvbW1pdCA2OTliMDQ1YThlNDMgKCJuZXQ6IHZpcnRp
b19uZXQ6IG5vdGlmaWNhdGlvbnMgY29hbGVzY2luZwo+IHN1cHBvcnQiKSBhZGRlZCBzdXBwb3J0
IGZvciBWSVJUSU9fTkVUX0ZfTk9URl9DT0FMLiBUaGUgZ2V0X2NvYWxlc2NlCj4gY2FsbCBtYWRl
IGNoYW5nZXMgdG8gcmVwb3J0ICIxIiBpbiB0eF9tYXhfY29hbGVzY2VkX2ZyYW1lcyBpZgo+IFZJ
UlRJT19ORVRfRl9OT1RGX0NPQUwgaXMgbm90IHN1cHBvcnRlZCBhbmQgbmFwaS53ZWlnaHQgaXMg
bm9uLXplcm8uCj4gSG93ZXZlciwgdGhlIG5hcGlfd2VpZ2h0IHZhbHVlIGNvdWxkIHN0aWxsIGJl
IGNoYW5nZWQgYnkgdGhlCj4gc2V0X2NvYWxlc2NlIGNhbGwgcmVnYXJkbGVzcyBvZiB3aGV0aGVy
IG9yIG5vdCB0aGUgZGV2aWNlIHN1cHBvcnRzCj4gVklSVElPX05FVF9GX05PVEZfQ09BTC4KPgo+
IEl0IHNlZW1zIGxpa2UgdGhlIHR4X21heF9jb2FsZXNjZWRfZnJhbWVzIHZhbHVlIHNob3VsZCBu
b3QgY29udHJvbCBtb3JlCj4gdGhhbiAxIHRoaW5nIChpLmUuIG5hcGlfd2VpZ2h0IGFuZCB0aGUg
ZGV2aWNlJ3MgdHhfbWF4X3BhY2tldHMpLiBTbywgZml4Cj4gdGhpcyBieSBvbmx5IGFsbG93aW5n
IHRoZSBuYXBpX3dlaWdodCBjaGFuZ2UgaWYgVklSVElPX05FVF9GX05PVEZfQ09BTAo+IGlzIG5v
dCBzdXBwb3J0ZWQgYnkgdGhlIHZpcnRpbyBkZXZpY2UuCj4KPiBJdCB3YXNuJ3QgY2xlYXIgdG8g
bWUgaWYgdGhpcyB3YXMgdGhlIGludGVuZGVkIGJlaGF2aW9yLCBzbyB0aGF0J3Mgd2h5Cj4gSSdt
IHNlbmRpbmcgdGhpcyBhcyBhbiBSRkMgcGF0Y2ggaW5pdGlhbGx5LiBCYXNlZCBvbiB0aGUgZmVl
ZGJhY2ssIEkKPiB3aWxsIHJlc3VibWl0IGFzIGFuIG9mZmljaWFsIHBhdGNoLgoKSXQgc2VlbXMg
dGhlIGN1cnJlbnQgY29kZSBpcyBmaW5lIHNpbmNlOgoKQmVmb3JlIHR4IGNvYWxlc2NpbmcsIHdl
IGhhdmUgdHdvIG1vZGVzIGZvciB0eCBpbnRlcnJ1cHQ6CgoxKSBUWCBOQVBJIG1vZGUsIHVzaW5n
IE5BUEkgdG8gcmVjeWNsZSB4bWl0IHBhY2tldHMKMikgVFggbm8tTkFQSSBtb2RlLCBkZXBlbmRz
IG9uIHRoZSBzdGFydF94bWl0KCkgdG8gcmVjeWNsZSB4bWl0IHBhY2tldHMKCkVhY2ggaGFzIHRo
ZWlyIG93biB1c2UgY2FzZXMuIEUuZyAxKSBzZWVtcyB0byBoYXZlIGJldHRlciBidWZmZXIKaW50
ZXJhY3Rpb24gd2l0aCBUQ1AuIEJ1dCAyKSBzZWVtcyB0byBiZWhhdmUgYmV0dGVyIGlmIHVzZXIg
Y2FyZXMKYWJvdXQgUFBTIGFuZCBpdCBjYW4gZ2l2ZXMgdXMgMnggUFBTIHdoZW4gdXNpbmcgYSB2
aG9zdC11c2VyIGJhY2tlbmQuCgpTbyB3ZSBsZWF2ZSBhbiBvcHRpb24gdG8gc3dpdGNoIGJldHdl
ZW4gdGhvc2UgdHdvIHZpYSBzcS5uYXBpX3dlaWdodAoKZXRodG9vbCAtQyB0eC1mcmFtZXMtaXJx
IDAgLy8gVG8gZGlzYWJsZSB0eCBpbnRlcnJ1cHRzCmV0aHRvb2wgLUMgdHgtZnJhbWVzLWlycSAx
IC8vIFRvIGVuYWJsZSB0eCBpbnRlcnJ1cHRzCgpBZnRlciB0eCBpbnRyIGNvbGVhc2luZywgd2Ug
d2FudCB0byBzdGljayB0byB0aGlzIEFQSS4KCmV0aHRvb2wgLUMgdHgtZnJhbWVzLWlycSAwIC8v
IFRvIGRpc2FibGUgdHggaW50ZXJydXB0cwpldGh0b29sIC1DIHR4LWZyYW1lcy1pcnEgTiAoTj49
MSkgLy8gVG8gZW5hYmxlIHR4IGludGVycnVwdHMKClRoYW5rcwoKPgo+IEZpeGVzOiA2OTliMDQ1
YThlNDMgKCJuZXQ6IHZpcnRpb19uZXQ6IG5vdGlmaWNhdGlvbnMgY29hbGVzY2luZyBzdXBwb3J0
IikKPiBTaWduZWQtb2ZmLWJ5OiBCcmV0dCBDcmVlbGV5IDxicmV0dC5jcmVlbGV5QGFtZC5jb20+
Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDI0ICsrKysrKysrKysrKystLS0t
LS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNDg2YjU4NDkwMzNkLi5lMjgzODc4NjY5MDkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gQEAgLTI5OTAsMTkgKzI5OTAsMjEgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Nl
dF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgaW50IHJldCwgaSwg
bmFwaV93ZWlnaHQ7Cj4gICAgICAgICBib29sIHVwZGF0ZV9uYXBpID0gZmFsc2U7Cj4KPiAtICAg
ICAgIC8qIENhbid0IGNoYW5nZSBOQVBJIHdlaWdodCBpZiB0aGUgbGluayBpcyB1cCAqLwo+IC0g
ICAgICAgbmFwaV93ZWlnaHQgPSBlYy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgPyBOQVBJX1BP
TExfV0VJR0hUIDogMDsKPiAtICAgICAgIGlmIChuYXBpX3dlaWdodCBeIHZpLT5zcVswXS5uYXBp
LndlaWdodCkgewo+IC0gICAgICAgICAgICAgICBpZiAoZGV2LT5mbGFncyAmIElGRl9VUCkKPiAt
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOwo+IC0gICAgICAgICAgICAgICBl
bHNlCj4gLSAgICAgICAgICAgICAgICAgICAgICAgdXBkYXRlX25hcGkgPSB0cnVlOwo+IC0gICAg
ICAgfQo+IC0KPiAtICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmktPnZkZXYsIFZJUlRJ
T19ORVRfRl9OT1RGX0NPQUwpKQo+ICsgICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2aS0+
dmRldiwgVklSVElPX05FVF9GX05PVEZfQ09BTCkpIHsKPiAgICAgICAgICAgICAgICAgcmV0ID0g
dmlydG5ldF9zZW5kX25vdGZfY29hbF9jbWRzKHZpLCBlYyk7Cj4gLSAgICAgICBlbHNlCj4gKyAg
ICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAgICAvKiBDYW4ndCBjaGFuZ2UgTkFQSSB3ZWln
aHQgaWYgdGhlIGxpbmsgaXMgdXAgKi8KPiArICAgICAgICAgICAgICAgbmFwaV93ZWlnaHQgPSBl
Yy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgPwo+ICsgICAgICAgICAgICAgICAgICAgICAgIE5B
UElfUE9MTF9XRUlHSFQgOiAwOwo+ICsgICAgICAgICAgICAgICBpZiAobmFwaV93ZWlnaHQgXiB2
aS0+c3FbMF0ubmFwaS53ZWlnaHQpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoZGV2
LT5mbGFncyAmIElGRl9VUCkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAtRUJVU1k7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdXBkYXRlX25hcGkgPSB0cnVlOwo+ICsgICAgICAgICAgICAgICB9
Cj4gKwo+ICAgICAgICAgICAgICAgICByZXQgPSB2aXJ0bmV0X2NvYWxfcGFyYW1zX3N1cHBvcnRl
ZChlYyk7Cj4gKyAgICAgICB9Cj4KPiAgICAgICAgIGlmIChyZXQpCj4gICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7Cj4gLS0KPiAyLjE3LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
