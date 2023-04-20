Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EA3C77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 05:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA4EA416AE;
	Thu, 20 Apr 2023 05:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA4EA416AE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b93x6vbJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4le-7IeRTD2f; Thu, 20 Apr 2023 05:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA39F41295;
	Thu, 20 Apr 2023 05:58:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA39F41295
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EF78C0037;
	Thu, 20 Apr 2023 05:58:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49869C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DCAA60FE0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DCAA60FE0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b93x6vbJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id imeb00ceYKM7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B3CA60FB1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B3CA60FB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 05:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681970294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KF057K4EPoEi7HYYfZLwh+5zZUpwuxGtMZEQhcs8a28=;
 b=b93x6vbJIU2Es5eNY+9lRhou387iHPVZCnDvZQVzRXrqHEaT79caWVJMIRom9R3yrEwlCq
 bZgm745D9MZ5DZkV+eExfp8otYCjEKat+BEK6z+LEyqM6tmgY8RTuQCUqUUnhI5FpO/Xi7
 kSldXQmsqP0FLeC9gQktP+ZnVbbMxmg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-gKr-NHQIMOSIHYnXeDmtKQ-1; Thu, 20 Apr 2023 01:58:13 -0400
X-MC-Unique: gKr-NHQIMOSIHYnXeDmtKQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5473a58c200so48105eaf.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 22:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681970293; x=1684562293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KF057K4EPoEi7HYYfZLwh+5zZUpwuxGtMZEQhcs8a28=;
 b=MvVK6B9HBPSTtk2yyScDO4eQYqt3bTCTpGBuiSADEyheC1dh5Tmh7w/pHuMaB9Oevp
 SYhWDMqVhHBGFsfle31dFOntvjfSPyW0rj8OY9TDw4jUpcImr25ThXBf7Sm5u9spkZJv
 kdAJrhtzUNoFJEB6WkIq+hsi9xN5YZAFtR86P751woxCxR4vONTHtzIUEvH7+56Wsdcv
 feZChuREvYYv+bf9BPWpqVvJcMQqd/ecIb8VJVdERKh7iFhZRqli2kLEfcaXLcclxFtp
 +Q7RgasUJYab+XNlqTxpCf+LlT0l3j7qX+R9xzlyAmAy0Ss70JcRSHyLqgU9yUGcFucf
 QHgA==
X-Gm-Message-State: AAQBX9eLgLq8wvzmVVYfvfuOwwlNQwEHxNW5fG5g8tTmVi2cKKUdSjmk
 ChYhfZXR6CHgPAGr3d3+3+0hqP6cR+/LwN+LMORo05+LIAGHgVXvcxTqP58i7U6oTrVoDwHttwk
 yrvrMus+O499UDt5o483JLE9RpbR21yp1D3lnH0nKrnLq0o4QVAiBlnge7Q==
X-Received: by 2002:a05:6870:6490:b0:17a:a59a:e931 with SMTP id
 cz16-20020a056870649000b0017aa59ae931mr442661oab.11.1681970292992; 
 Wed, 19 Apr 2023 22:58:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350aVtat0i5n6ON9ylDd4Y/gR2oczno6DFTBOtnGidKe3fSEPldtrEE9PXjuS68IAkvnrT0r72lkQGvdaZmGEdy4=
X-Received: by 2002:a05:6870:6490:b0:17a:a59a:e931 with SMTP id
 cz16-20020a056870649000b0017aa59ae931mr442643oab.11.1681970292689; Wed, 19
 Apr 2023 22:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 13:58:01 +0800
Message-ID: <CACGkMEv9KjfQzXKX27jmNeedn03HXob5p0E5Z2LT9GMut8VemA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/14] virtio_net: mergeable xdp: put old page
 immediately
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSW4gdGhlIHhkcCBpbXBsZW1lbnRhdGlvbiBvZiB2
aXJ0aW8tbmV0IG1lcmdlYWJsZSwgaXQgYWx3YXlzIGNoZWNrcwo+IHdoZXRoZXIgdHdvIHBhZ2Ug
aXMgdXNlZCBhbmQgYSBwYWdlIGlzIHNlbGVjdGVkIHRvIHJlbGVhc2UuIFRoaXMgaXMKPiBjb21w
bGljYXRlZCBmb3IgdGhlIHByb2Nlc3Npbmcgb2YgYWN0aW9uLCBhbmQgYmUgY2FyZWZ1bC4KPgo+
IEluIHRoZSBlbnRpcmUgcHJvY2Vzcywgd2UgaGF2ZSBzdWNoIHByaW5jaXBsZXM6Cj4gKiBJZiB4
ZHBfcGFnZSBpcyB1c2VkIChQQVNTLCBUWCwgUmVkaXJlY3QpLCB0aGVuIHdlIHJlbGVhc2UgdGhl
IG9sZAo+ICAgcGFnZS4KPiAqIElmIGl0IGlzIGEgZHJvcCBjYXNlLCB3ZSB3aWxsIHJlbGVhc2Ug
dHdvLiBUaGUgb2xkIHBhZ2Ugb2J0YWluZWQgZnJvbQo+ICAgYnVmIGlzIHJlbGVhc2UgaW5zaWRl
IGVycl94ZHAsIGFuZCB4ZHBfcGFnZSBuZWVkcyBiZSByZWxhc2VkIGJ5IHVzLgo+Cj4gQnV0IGlu
IGZhY3QsIHdoZW4gd2UgYWxsb2NhdGUgYSBuZXcgcGFnZSwgd2UgY2FuIHJlbGVhc2UgdGhlIG9s
ZCBwYWdlCj4gaW1tZWRpYXRlbHkuIFRoZW4ganVzdCBvbmUgaXMgdXNpbmcsIHdlIGp1c3QgbmVl
ZCB0byByZWxlYXNlIHRoZSBuZXcKPiBwYWdlIGZvciBkcm9wIGNhc2UuIE9uIHRoZSBkcm9wIHBh
dGgsIGVycl94ZHAgd2lsbCByZWxlYXNlIHRoZSB2YXJpYWJsZQo+ICJwYWdlIiwgc28gd2Ugb25s
eSBuZWVkIHRvIGxldCAicGFnZSIgcG9pbnQgdG8gdGhlIG5ldyB4ZHBfcGFnZSBpbgo+IGFkdmFu
Y2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MK
Cgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxOSArKysrKysrLS0tLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+IGluZGV4IGUyNTYwYjZmNzk4MC4uNDI0MzVlNzYyZDcyIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+IEBAIC0xMjQ1LDYgKzEyNDUsOSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2Vp
dmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKCF4ZHBfcGFnZSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gZXJyX3hkcDsKPiAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXQgPSBWSVJUSU9fWERQ
X0hFQURST09NOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBwdXRfcGFnZShwYWdlKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICBwYWdlID0geGRwX3BhZ2U7Cj4gICAgICAgICAgICAg
ICAgIH0gZWxzZSBpZiAodW5saWtlbHkoaGVhZHJvb20gPCB2aXJ0bmV0X2dldF9oZWFkcm9vbSh2
aSkpKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgeGRwX3Jvb20gPSBTS0JfREFUQV9BTElH
TihWSVJUSU9fWERQX0hFQURST09NICsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvKSk7Cj4gQEAg
LTEyNTksMTEgKzEyNjIsMTIgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdl
YWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwYWdlX2FkZHJlc3MocGFnZSkgKyBvZmZzZXQsIGxlbik7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgZnJhbWVfc3ogPSBQQUdFX1NJWkU7Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
b2Zmc2V0ID0gVklSVElPX1hEUF9IRUFEUk9PTTsKPiAtICAgICAgICAgICAgICAgfSBlbHNlIHsK
PiAtICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcGFnZSA9IHBhZ2U7Cj4gKwo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHBhZ2UgPSB4ZHBfcGFnZTsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gLSAgICAgICAgICAgICAg
IGRhdGEgPSBwYWdlX2FkZHJlc3MoeGRwX3BhZ2UpICsgb2Zmc2V0Owo+ICsgICAgICAgICAgICAg
ICBkYXRhID0gcGFnZV9hZGRyZXNzKHBhZ2UpICsgb2Zmc2V0Owo+ICAgICAgICAgICAgICAgICBl
cnIgPSB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhkZXYsIHZpLCBycSwgJnhkcCwgZGF0YSwg
bGVuLCBmcmFtZV9zeiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJm51bV9idWYsICZ4ZHBfZnJhZ3NfdHJ1ZXN6LCBzdGF0cyk7Cj4gICAgICAgICAg
ICAgICAgIGlmICh1bmxpa2VseShlcnIpKQo+IEBAIC0xMjc4LDggKzEyODIsNiBAQCBzdGF0aWMg
c3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFoZWFkX3NrYikpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfZnJhZ3M7Cj4KPiAtICAg
ICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0gcGFnZSkpCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdXRfcGFnZShwYWdlKTsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gaGVhZF9za2I7Cj4gICAgICAgICAgICAgICAgIGNhc2UgWERQX1RYOgo+IEBAIC0x
Mjk3LDggKzEyOTksNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICp4ZHBfeG1pdCB8PSBWSVJUSU9fWERQX1RYOwo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh4ZHBfcGFnZSAhPSBwYWdlKSkKPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8geGRwX3htaXQ7Cj4gICAgICAgICAgICAgICAgIGNhc2UgWERQX1JFRElSRUNUOgo+IEBAIC0x
MzA3LDggKzEzMDcsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVy
cikKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcF9mcmFnczsK
PiAgICAgICAgICAgICAgICAgICAgICAgICAqeGRwX3htaXQgfD0gVklSVElPX1hEUF9SRURJUjsK
PiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0gcGFnZSkp
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdXRfcGFnZShwYWdlKTsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIHhkcF94bWl0Owo+ICAgICAgICAgICAgICAgICBkZWZhdWx0Ogo+IEBAIC0x
MzIxLDkgKzEzMTksNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBl
cnJfeGRwX2ZyYWdzOwo+ICAgICAgICAgICAgICAgICB9Cj4gIGVycl94ZHBfZnJhZ3M6Cj4gLSAg
ICAgICAgICAgICAgIGlmICh1bmxpa2VseSh4ZHBfcGFnZSAhPSBwYWdlKSkKPiAtICAgICAgICAg
ICAgICAgICAgICAgICBfX2ZyZWVfcGFnZXMoeGRwX3BhZ2UsIDApOwo+IC0KPiAgICAgICAgICAg
ICAgICAgaWYgKHhkcF9idWZmX2hhc19mcmFncygmeGRwKSkgewo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHNoaW5mbyA9IHhkcF9nZXRfc2hhcmVkX2luZm9fZnJvbV9idWZmKCZ4ZHApOwo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzaGluZm8tPm5yX2ZyYWdzOyBp
KyspIHsKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
