Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD64FC6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 05:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BE1B60B0F;
	Thu, 23 Mar 2023 05:38:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BE1B60B0F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jRP63FLc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ezu5Y-epj-W2; Thu, 23 Mar 2023 05:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 94CB7606A0;
	Thu, 23 Mar 2023 05:38:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94CB7606A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76E7BC0071;
	Thu, 23 Mar 2023 05:38:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 136E4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB0F64014D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB0F64014D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jRP63FLc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lcIAfwaakge
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:38:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE210400FD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE210400FD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679549925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jri6+NrCPtekgZqOyxyD0WomJ0of3wHnx2G0FZIYbvw=;
 b=jRP63FLcR6Ur8HrqW/tGj2b08UCSnscv6aXimAVdZxs5jqlxVymoPpN6l4Mpue1tDT3slj
 C6MgpB01iukcOTVFXf2aBO+4WWLEEX0ZUO2yuEDL8d0vwRDiEFWhR379IvN0rC5L+eMIAJ
 GycNWob5SF7wE8TjfWj4T3w504kIzGo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-YepVks22OnaiPb5mWm1o8A-1; Thu, 23 Mar 2023 01:38:44 -0400
X-MC-Unique: YepVks22OnaiPb5mWm1o8A-1
Received: by mail-ot1-f72.google.com with SMTP id
 d14-20020a0568301b6e00b0069f3c72187cso4847237ote.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 22:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679549923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jri6+NrCPtekgZqOyxyD0WomJ0of3wHnx2G0FZIYbvw=;
 b=a0P7X6ILIRZYXhDgyelZ3sIBd9e0DXyuW84j0jbvAU4EuiiOWHdpTHiTuWpExurUxS
 PREgypDui30XZxwe42o4l2HMLp3xJ9KM4kysASyMm9XMLgF1XmpkiAMbFIZeb63BKXOl
 XEGQoOKHE1myy50dQlGtY5g+DxrjwlTbzQD4iby8D3a7nPvQK9jtpyLVBUwbDfUbxJsb
 TQmQSpzV6L5/e4gJAcubl3PXgfbG+NIlKcLRtX24bxVpZS+jwZga6DmS9vAXyx5pBEBW
 8p/zjylaokNSIw+VbFDzoAotcZpS+QuSiuj1BLhXooh88ItlmK68ZUub3VEoPoq03eA/
 mw2w==
X-Gm-Message-State: AO0yUKURlWlmlyyKHLNxpiROsFRmtURJ4UZJnRp+22Yw+2MMono5pKxt
 HqbeecgCfKEDORDu1t95U16jilaIQZ16W1q2pOrJlwdrDPkQkwj7ueUtjsm1gG2RfAYV+0UlGJj
 r47alIy/sk9GwIXphAlhM/HJv/AXprtynN8YAGZgVcFhNCyupI/iwDuwEJA==
X-Received: by 2002:a54:4189:0:b0:384:c4a:1b49 with SMTP id
 9-20020a544189000000b003840c4a1b49mr1724141oiy.9.1679549922160; 
 Wed, 22 Mar 2023 22:38:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set9edpIRb55hBUWyafl2NYnWiJJoCRnUZ/SSVGI/aYqPK/FO76woi7mOTZOqxI9TFyPNpDP1uoPL8mvJSXFe5hc=
X-Received: by 2002:a54:4189:0:b0:384:c4a:1b49 with SMTP id
 9-20020a544189000000b003840c4a1b49mr1724117oiy.9.1679549921765; Wed, 22 Mar
 2023 22:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-2-xuanzhuo@linux.alibaba.com>
 <4bd07874-b1ad-336b-b15e-ba56a10182e9@huawei.com>
 <1679535365.5410192-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1679535365.5410192-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 13:38:30 +0800
Message-ID: <CACGkMEvS7N1tXFD2-2n2upY15JF6=0uaAebewsP8=K+Cwbtgsg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page
 immediately
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgOTo0M+KAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCAyMiBNYXIgMjAyMyAxNjoyMjoxOCAr
MDgwMCwgWXVuc2hlbmcgTGluIDxsaW55dW5zaGVuZ0BodWF3ZWkuY29tPiB3cm90ZToKPiA+IE9u
IDIwMjMvMy8yMiAxMTowMywgWHVhbiBaaHVvIHdyb3RlOgo+ID4gPiBJbiB0aGUgeGRwIGltcGxl
bWVudGF0aW9uIG9mIHZpcnRpby1uZXQgbWVyZ2VhYmxlLCBpdCBhbHdheXMgY2hlY2tzCj4gPiA+
IHdoZXRoZXIgdHdvIHBhZ2UgaXMgdXNlZCBhbmQgYSBwYWdlIGlzIHNlbGVjdGVkIHRvIHJlbGVh
c2UuIFRoaXMgaXMKPiA+ID4gY29tcGxpY2F0ZWQgZm9yIHRoZSBwcm9jZXNzaW5nIG9mIGFjdGlv
biwgYW5kIGJlIGNhcmVmdWwuCj4gPiA+Cj4gPiA+IEluIHRoZSBlbnRpcmUgcHJvY2Vzcywgd2Ug
aGF2ZSBzdWNoIHByaW5jaXBsZXM6Cj4gPiA+ICogSWYgeGRwX3BhZ2UgaXMgdXNlZCAoUEFTUywg
VFgsIFJlZGlyZWN0KSwgdGhlbiB3ZSByZWxlYXNlIHRoZSBvbGQKPiA+ID4gICBwYWdlLgo+ID4g
PiAqIElmIGl0IGlzIGEgZHJvcCBjYXNlLCB3ZSB3aWxsIHJlbGVhc2UgdHdvLiBUaGUgb2xkIHBh
Z2Ugb2J0YWluZWQgZnJvbQo+ID4gPiAgIGJ1ZiBpcyByZWxlYXNlIGluc2lkZSBlcnJfeGRwLCBh
bmQgeGRwX3BhZ2UgbmVlZHMgYmUgcmVsYXNlZCBieSB1cy4KPiA+ID4KPiA+ID4gQnV0IGluIGZh
Y3QsIHdoZW4gd2UgYWxsb2NhdGUgYSBuZXcgcGFnZSwgd2UgY2FuIHJlbGVhc2UgdGhlIG9sZCBw
YWdlCj4gPiA+IGltbWVkaWF0ZWx5LiBUaGVuIGp1c3Qgb25lIGlzIHVzaW5nLCB3ZSBqdXN0IG5l
ZWQgdG8gcmVsZWFzZSB0aGUgbmV3Cj4gPiA+IHBhZ2UgZm9yIGRyb3AgY2FzZS4gT24gdGhlIGRy
b3AgcGF0aCwgZXJyX3hkcCB3aWxsIHJlbGVhc2UgdGhlIHZhcmlhYmxlCj4gPiA+ICJwYWdlIiwg
c28gd2Ugb25seSBuZWVkIHRvIGxldCAicGFnZSIgcG9pbnQgdG8gdGhlIG5ldyB4ZHBfcGFnZSBp
bgo+ID4gPiBhZHZhbmNlLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDE1ICsrKysrKy0tLS0tLS0tLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiBp
bmRleCBlMjU2MGI2Zjc5ODAuLjRkMmJmMWNlMDczMCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
ID4gPiBAQCAtMTI0NSw2ICsxMjQ1LDkgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZl
X21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgIGlmICgheGRwX3BhZ2UpCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGVycl94ZHA7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0ID0gVklSVElPX1hEUF9I
RUFEUk9PTTsKPiA+ID4gKwo+ID4gPiArICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2Up
Owo+ID4KPiA+IHRoZSBlcnJvciBoYW5kbGluZyBvZiB4ZHBfbGluZWFyaXplX3BhZ2UoKSBkb2Vz
IG5vdCBzZWVtcyBzZWxmIGNvbnRhaW5lZC4KPiA+IERvZXMgaXQgbm90IHNlZW0gYmV0dGVy77ya
Cj4gPiAxLiBpZiB4ZHBfbGluZWFyaXplX3BhZ2UoKSBzdWNjZXNlZCwgY2FsbCBwdXRfcGFnZSgp
IGZvciBmaXJzdCBidWZmZXIganVzdAo+ID4gICAgYXMgcHV0X3BhZ2UoKSBpcyBjYWxsIGZvciBv
dGhlciBidWZmZXIKPiA+IDIuIG9yIGNhbGwgdmlydHF1ZXVlX2dldF9idWYoKSBhbmQgcHV0X3Bh
Z2UoKSBmb3IgYWxsIHRoZSBidWZmZXIgb2YgdGhlIHBhY2tldAo+ID4gICAgc28gdGhlIGVycm9y
IGhhbmRsaW5nIGlzIG5vdCBuZWVkZWQgb3V0c2lkZSB0aGUgdmlydHF1ZXVlX2dldF9idWYoKS4K
PiA+Cj4gPiBJbiB0aGF0IGNhc2UsIGl0IHNlZW1zIHdlIGNhbiBqdXN0IGRvIGJlbG93IHdpdGhv
dXQgeGRwX3BhZ2U6Cj4gPiBwYWdlID0geGRwX2xpbmVhcml6ZV9wYWdlKHJxLCBudW1fYnVmLCBw
YWdlLCAuLi4pOwo+Cj4KPiBUaGlzIGRvZXMgbG9vayBiZXR0ZXIuCj4KPiBJbiBmYWN0LCB3ZSBh
bHJlYWR5IGhhdmUgdnEgcmVzZXQsIHdlIGNhbiBsb2FkIFhEUCBiYXNlZCBvbiB2cSByZXNldC4K
PiBJbiB0aGlzIHdheSwgd2UgY2FuIHJ1biB3aXRob3V0IHhkcF9saW5lYXJpemVfcGFnZS4KClRo
ZSBnb2FsIGlzIHRvIHRyeSBvdXIgYmVzdCBub3QgdG8gZHJvcCBwYWNrZXRzLCBzbyBJIHRoaW5r
IGl0J3MKYmV0dGVyIHRvIGtlZXAgaXQuCgpUaGFua3MKCj4KPgo+ID4KPiA+Cj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgcGFnZSA9IHhkcF9wYWdlOwo+ID4gPiAgICAgICAgICAgICB9IGVsc2Ug
aWYgKHVubGlrZWx5KGhlYWRyb29tIDwgdmlydG5ldF9nZXRfaGVhZHJvb20odmkpKSkgewo+ID4g
PiAgICAgICAgICAgICAgICAgICAgIHhkcF9yb29tID0gU0tCX0RBVEFfQUxJR04oVklSVElPX1hE
UF9IRUFEUk9PTSArCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplb2Yoc3RydWN0IHNrYl9zaGFyZWRfaW5mbykpOwo+ID4gPiBAQCAtMTI1OSw2
ICsxMjYyLDkgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdl
X2FkZHJlc3MocGFnZSkgKyBvZmZzZXQsIGxlbik7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ZnJhbWVfc3ogPSBQQUdFX1NJWkU7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0ID0g
VklSVElPX1hEUF9IRUFEUk9PTTsKPiA+ID4gKwo+ID4gPiArICAgICAgICAgICAgICAgICAgIHB1
dF9wYWdlKHBhZ2UpOwo+ID4gPiArICAgICAgICAgICAgICAgICAgIHBhZ2UgPSB4ZHBfcGFnZTsK
PiA+Cj4gPiBJdCBzZWVtcyB3ZSBjYW4gbGltaXQgdGhlIHNjb3BlIG9mIHhkcF9wYWdlIGluIHRo
aXMgImVsc2UgaWYiIGJsb2NrLgo+ID4KPiA+ID4gICAgICAgICAgICAgfSBlbHNlIHsKPiA+ID4g
ICAgICAgICAgICAgICAgICAgICB4ZHBfcGFnZSA9IHBhZ2U7Cj4gPiA+ICAgICAgICAgICAgIH0K
PiA+Cj4gPiBJdCBzZWVtcyB0aGUgYWJvdmUgZWxzZSBibG9jayBpcyBub3QgbmVlZGVkIGFueW1v
cmUuCj4KPiBZZXMsIHRoZSBmb2xsb3ctdXAgcGF0Y2ggaGFzIHRoaXMgb3B0aW1pemF0aW9uLgo+
Cj4KPiA+Cj4gPiA+IEBAIC0xMjc4LDggKzEyODQsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYg
KnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFoZWFkX3NrYikpCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gPiA+Cj4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgaWYgKHVubGlrZWx5KHhkcF9wYWdlICE9IHBhZ2UpKQo+ID4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGhl
YWRfc2tiOwo+ID4gPiAgICAgICAgICAgICBjYXNlIFhEUF9UWDoKPiA+ID4gQEAgLTEyOTcsOCAr
MTMwMSw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3hkcF9mcmFnczsKPiA+ID4gICAgICAgICAgICAgICAgICAgICB9Cj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgKnhkcF94bWl0IHw9IFZJUlRJT19YRFBfVFg7Cj4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgaWYgKHVubGlrZWx5KHhkcF9wYWdlICE9IHBhZ2UpKQo+ID4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgZ290byB4ZHBf
eG1pdDsKPiA+ID4gICAgICAgICAgICAgY2FzZSBYRFBfUkVESVJFQ1Q6Cj4gPiA+IEBAIC0xMzA3
LDggKzEzMDksNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgaWYgKGVycikK
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcF9mcmFnczsKPiA+
ID4gICAgICAgICAgICAgICAgICAgICAqeGRwX3htaXQgfD0gVklSVElPX1hEUF9SRURJUjsKPiA+
ID4gLSAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0gcGFnZSkpCj4g
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBwdXRfcGFnZShwYWdlKTsKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiA+ID4gICAgICAgICAgICAgICAg
ICAgICBnb3RvIHhkcF94bWl0Owo+ID4gPiAgICAgICAgICAgICBkZWZhdWx0Ogo+ID4gPiBAQCAt
MTMyMSw5ICsxMzIxLDYgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJs
ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiAgICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3hkcF9mcmFnczsKPiA+ID4gICAgICAgICAgICAgfQo+ID4gPiAgZXJyX3hkcF9mcmFnczoK
PiA+ID4gLSAgICAgICAgICAgaWYgKHVubGlrZWx5KHhkcF9wYWdlICE9IHBhZ2UpKQo+ID4gPiAt
ICAgICAgICAgICAgICAgICAgIF9fZnJlZV9wYWdlcyh4ZHBfcGFnZSwgMCk7Cj4gPgo+ID4gSXQg
c2VlbXMgX19mcmVlX3BhZ2VzKCkgYW5kIHB1dF9wYWdlKCkgaXMgdXNlZCBpbnRlcmNoYW5nZWFi
bHkgaGVyZS4KPiA+IFBlcmhhcHMgdXNpbmcgX19mcmVlX3BhZ2VzKCkgaGF2ZSBwZXJmb3JtYW5j
ZSByZWFzb24/IEFzIHRoZSBjb21tZW50IGJlbG93Ogo+ID4KPiA+IGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y2LjMtcmMzL3NvdXJjZS9uZXQvY29yZS9wYWdlX3Bvb2wuYyNMNTAw
Cj4KPgo+IFllcywgYnV0IG5vdyB3ZSBkb24ndCBzZWVtIHRvIGJlIHZlcnkgZ29vZCB0byBkaXN0
aW5ndWlzaCBpdC4gQnV0IEkgdGhpbmsKPiBpdCBkb2Vzbid0IG1hdHRlci4gVGhpcyBsb2dpYyBp
cyByYXJlIHVuZGVyIGFjdHVhbCBzaXR1YXRpb24uCj4KPiBUaGFua3MuCj4KPgo+ID4KPiA+ID4g
LQo+ID4gPiAgICAgICAgICAgICBpZiAoeGRwX2J1ZmZfaGFzX2ZyYWdzKCZ4ZHApKSB7Cj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgc2hpbmZvID0geGRwX2dldF9zaGFyZWRfaW5mb19mcm9tX2J1
ZmYoJnhkcCk7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IHNoaW5m
by0+bnJfZnJhZ3M7IGkrKykgewo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
