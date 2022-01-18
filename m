Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5BFC433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 17:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A70081B48;
	Tue, 18 Jan 2022 17:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FcoCPlW6RREe; Tue, 18 Jan 2022 17:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06E1C81A99;
	Tue, 18 Jan 2022 17:25:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAC86C0031;
	Tue, 18 Jan 2022 17:25:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26824C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 152F7409C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iDop8nrAI6vf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:25:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1DEC409C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642526749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rR/bu37Is80SlqeUGWI0t9CgSie0s+VhhWDwdSOZaOM=;
 b=RWgdM5xQ7zosII5pAJiQKnPWw03CgZWk7+ZgUaLK3F4fLfo19cNlOUf5jKYEucEchnWbaR
 FfxW6kMDIL+/fEr6UK20x1UcR0RCoAbCJvOR+oUtniZDK5NYfjq4n6KXI9QplccN1MyKCi
 2kakOTfNbGdWGXku4Xdwf9V7ps3mYL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-p40EvUEhNN6kNZ7FxO2S4Q-1; Tue, 18 Jan 2022 12:25:46 -0500
X-MC-Unique: p40EvUEhNN6kNZ7FxO2S4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51FCB11185D0;
 Tue, 18 Jan 2022 17:10:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B74817A3F9;
 Tue, 18 Jan 2022 17:10:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: acknowledge all features before access
In-Reply-To: <20220118104318-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220114200744.150325-1-mst@redhat.com>
 <d6c4e521-1538-bbbf-30e6-f658a095b3ae@redhat.com>
 <20220117032429-mutt-send-email-mst@kernel.org>
 <87mtjuv8od.fsf@redhat.com>
 <20220118104318-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Tue, 18 Jan 2022 18:10:05 +0100
Message-ID: <871r15dl76.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gVHVlLCBKYW4gMTggMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMDE6Mzg6NDJQTSArMDEwMCwgQ29y
bmVsaWEgSHVjayB3cm90ZToKPj4gT24gTW9uLCBKYW4gMTcgMjAyMiwgIk1pY2hhZWwgUy4gVHNp
cmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4gCj4+ID4gT24gTW9uLCBKYW4gMTcsIDIw
MjIgYXQgMDI6MzE6NDlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gPj4gCj4+ID4+IOWc
qCAyMDIyLzEvMTUg5LiK5Y2INDowOSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPj4gPj4g
PiBAQCAtNDk1LDYgKzQ5NCwxMCBAQCBpbnQgdmlydGlvX2RldmljZV9yZXN0b3JlKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICpkZXYpCj4+ID4+ID4gICAJLyogV2UgaGF2ZSBhIGRyaXZlciEgKi8KPj4g
Pj4gPiAgIAl2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19EUklWRVIpOwo+
PiA+PiA+ICsJcmV0ID0gZGV2LT5jb25maWctPmZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4+ID4+
ID4gKwlpZiAocmV0KQo+PiA+PiA+ICsJCWdvdG8gZXJyOwo+PiA+PiAKPj4gPj4gCj4+ID4+IElz
IHRoaXMgcGFydCBvZiBjb2RlIHJlbGF0ZWQ/Cj4+ID4+IAo+PiA+PiBUaGFua3MKPj4gPj4gCj4+
ID4KPj4gPiBZZXMuIHZpcnRpb19maW5hbGl6ZV9mZWF0dXJlcyBubyBsb25nZXIgY2FsbHMgZGV2
LT5jb25maWctPmZpbmFsaXplX2ZlYXR1cmVzLgo+PiA+Cj4+ID4gSSB0aGluayB0aGUgZGV2LT5j
b25maWctPmZpbmFsaXplX2ZlYXR1cmVzIGNhbGxiYWNrIGlzIGFjdHVhbGx5Cj4+ID4gYSBtaXNu
b21lciBub3csIGl0IGp1c3Qgc2VuZHMgdGhlIGZlYXR1cmVzIHRvIGRldmljZSwKPj4gPiBmaW5h
bGl6ZSBpcyBGRUFUVVJFU19PSy4gUmVuYW1pbmcgdGhhdCBpcyBhIGJpZ2dlcgo+PiA+IHBhdGNo
IHRob3VnaCwgYW5kIEknZCBsaWtlIHRoaXMgb25lIHRvIGJlIGNoZXJyeS1waWNrYWJsZQo+PiA+
IHRvIHN0YWJsZS4KPj4gCj4+IERvIHdlIHdhbnQgdG8gYWRkIGEgY29tbWVudCBiZWZvcmUgdGhl
IGNhbGxzIHRvIC0+ZmluYWxpemVfZmVhdHVyZXMoKQo+PiAoLyogd3JpdGUgZmVhdHVyZXMgdG8g
ZGV2aWNlICovKSBhbmQgYWRhcHQgdGhlIGNvbW1lbnQgaW4gdmlydGlvX3JpbmcuaD8KPj4gU2hv
dWxkIHN0aWxsIGJlIHN0YWJsZS1mcmllbmRseSwgYW5kIGdpdmluZyB0aGUgY2FsbGJhY2sgYSBi
ZXR0ZXIgbmFtZQo+PiBjYW4gYmUgYSBmb2xsb3ctdXAgcGF0Y2guCj4KPiBTb3JyeSB3aGljaCBj
b21tZW50IGluIHZpcnRpb19yaW5nLmg/Cj4gQ291bGQgbm90IGZpbmQgYW55dGhpbmcuCgpUeXBv
OyBJIG1lbnQgdmlydGlvX2NvbmZpZy5oLi4uCgo+Cj4+ID4KPj4gPj4gPiArCj4+ID4+ID4gICAJ
cmV0ID0gdmlydGlvX2ZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4+ID4+ID4gICAJaWYgKHJldCkK
Pj4gPj4gPiAgIAkJZ290byBlcnI7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
