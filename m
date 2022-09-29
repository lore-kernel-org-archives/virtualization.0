Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D841C07E9D
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8832361116;
	Thu, 29 Sep 2022 07:46:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8832361116
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFLJG56n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0JcweHxIJpNc; Thu, 29 Sep 2022 07:46:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9F626110E;
	Thu, 29 Sep 2022 07:46:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9F626110E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C67E2C0033;
	Thu, 29 Sep 2022 07:46:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB3F1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1783419D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1783419D5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFLJG56n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFubHVg7oRwr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:46:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 571B2418C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 571B2418C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664437581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTeJi7UgmzQ/b6hrAHhKny7zyVKlQu4YxKFzX8ABb+c=;
 b=IFLJG56nSuxw1vdenngGdb/cbB1WIeVul0A6EpbPAHeHW5Fh9BAli97XND04Gn4iVQtdG5
 U13Oz1Dv+CuqOze3d0PDSIDAvT6eVtjDkp8oDEZ4mb7kO5+NXONK4pEFWAypV+4kx/hXUV
 7hCOHmctclrjgLiWP896m7QRltdUll4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-VFR6d3zbOLidCdOQ6BeXTg-1; Thu, 29 Sep 2022 03:46:17 -0400
X-MC-Unique: VFR6d3zbOLidCdOQ6BeXTg-1
Received: by mail-qt1-f199.google.com with SMTP id
 fx6-20020a05622a4ac600b0035a70ba1cbcso383185qtb.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=CTeJi7UgmzQ/b6hrAHhKny7zyVKlQu4YxKFzX8ABb+c=;
 b=G6hASUCmFFdxS1IOTWcPbDrsZ7R5f1clvkZVd+M4rfpjyDe4uRbORenLy5+TljG8tK
 2mcApTuDmrE5TNF4LI2VUt0ngsJyrTb5WibMn6pkWgRM4sLkIqmQWe2FJA4pLqM1/44h
 DoHDk+zIOnZ2gHm+CbcF5irOv6qOX5h5cnqcQqqb8kqvbZWO96gc+ua0Q48JzHNEPPNj
 Yp3DrhAvm1LQAlwj1/vMSOf71Pm0AOAn5/TB6zNAn/rd+cAObPOacfJx5AEFRJ5c6pTq
 qUeed0sS9kWk18gnMGDPTc31tVXaoanMUjO6uwmyWSBF3HikUA82qWHGobaPX7KFcmPn
 uY6w==
X-Gm-Message-State: ACrzQf0+aVghz2npJb6+/Ix824eQDjIqBKPbeKgql9pK0CvTeddNEmSh
 pazGFIHS4Ymk2px9GYISDxQ/SN1rwiLu/10JwoAg11k3U7zaC1Iw+1r3VKi3ateV06lBf5UVMoL
 j6qCmwR5oLzbtbETFhTJ7FkrLdZYRZ36wFhEvLLTuZg==
X-Received: by 2002:a05:622a:130a:b0:35b:b454:8644 with SMTP id
 v10-20020a05622a130a00b0035bb4548644mr1290445qtk.624.1664437577106; 
 Thu, 29 Sep 2022 00:46:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dDCrWsLDOvnsEf6oCJ6887s3Ijw/iX2+31X38ns8+Iv+1dFbn5hFI6/D3we8A3D89rQC8bw==
X-Received: by 2002:a05:622a:130a:b0:35b:b454:8644 with SMTP id
 v10-20020a05622a130a00b0035bb4548644mr1290431qtk.624.1664437576804; 
 Thu, 29 Sep 2022 00:46:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 w12-20020ac843cc000000b0035bb6c3811asm4780775qtn.53.2022.09.29.00.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:46:16 -0700 (PDT)
Date: Thu, 29 Sep 2022 09:46:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929074606.yqzihpcc7cl442c5@sgarzare-redhat>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <CADgJSGHxPWXJjbakEeWnqF42A03yK7Dpw6U1SKNLhk+B248Ymg@mail.gmail.com>
 <20220929031419-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220929031419-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 Junichi Uekawa =?utf-8?B?KOS4iuW3nee0lOS4gCk=?= <uekawa@google.com>
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

T24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6MTk6MTRBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+T24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDg6MTQ6MjRBTSArMDkwMCwgSnVu
aWNoaSBVZWthd2EgKOS4iuW3nee0lOS4gCkgd3JvdGU6Cj4+IDIwMjLlubQ55pyIMjnml6Uo5pyo
KSAwOjExIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT46Cj4+ID4KPj4g
PiBPbiBXZWQsIFNlcCAyOCwgMjAyMiBhdCAwNTozMTo1OEFNIC0wNDAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4+ID4gPk9uIFdlZCwgU2VwIDI4LCAyMDIyIGF0IDEwOjI4OjIzQU0gKzAy
MDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj4gPiA+PiBPbiBXZWQsIFNlcCAyOCwgMjAy
MiBhdCAwMzo0NTozOFBNICswOTAwLCBKdW5pY2hpIFVla2F3YSB3cm90ZToKPj4gPiA+PiA+IFdo
ZW4gY29weWluZyBhIGxhcmdlIGZpbGUgb3ZlciBzZnRwIG92ZXIgdnNvY2ssIGRhdGEgc2l6ZSBp
cyB1c3VhbGx5IDMya0IsCj4+ID4gPj4gPiBhbmQga21hbGxvYyBzZWVtcyB0byBmYWlsIHRvIHRy
eSB0byBhbGxvY2F0ZSAzMiAzMmtCIHJlZ2lvbnMuCj4+ID4gPj4gPgo+PiA+ID4+ID4gQ2FsbCBU
cmFjZToKPj4gPiA+PiA+ICBbPGZmZmZmZmZmYjZhMGRmNjQ+XSBkdW1wX3N0YWNrKzB4OTcvMHhk
Ygo+PiA+ID4+ID4gIFs8ZmZmZmZmZmZiNjhkNmFlZD5dIHdhcm5fYWxsb2NfZmFpbGVkKzB4MTBm
LzB4MTM4Cj4+ID4gPj4gPiAgWzxmZmZmZmZmZmI2OGQ4NjhhPl0gPyBfX2FsbG9jX3BhZ2VzX2Rp
cmVjdF9jb21wYWN0KzB4MzgvMHhjOAo+PiA+ID4+ID4gIFs8ZmZmZmZmZmZiNjY0NjE5Zj5dIF9f
YWxsb2NfcGFnZXNfbm9kZW1hc2srMHg4NGMvMHg5MGQKPj4gPiA+PiA+ICBbPGZmZmZmZmZmYjY2
NDZlNTY+XSBhbGxvY19rbWVtX3BhZ2VzKzB4MTcvMHgxOQo+PiA+ID4+ID4gIFs8ZmZmZmZmZmZi
NjY1M2EyNj5dIGttYWxsb2Nfb3JkZXJfdHJhY2UrMHgyYi8weGRiCj4+ID4gPj4gPiAgWzxmZmZm
ZmZmZmI2NjY4MmYzPl0gX19rbWFsbG9jKzB4MTc3LzB4MWY3Cj4+ID4gPj4gPiAgWzxmZmZmZmZm
ZmI2NmUwZDk0Pl0gPyBjb3B5X2Zyb21faXRlcisweDhkLzB4MzFkCj4+ID4gPj4gPiAgWzxmZmZm
ZmZmZmMwNjg5YWI3Pl0gdmhvc3RfdnNvY2tfaGFuZGxlX3R4X2tpY2srMHgxZmEvMHgzMDEgW3Zo
b3N0X3Zzb2NrXQo+PiA+ID4+ID4gIFs8ZmZmZmZmZmZjMDY4MjhkOT5dIHZob3N0X3dvcmtlcisw
eGY3LzB4MTU3IFt2aG9zdF0KPj4gPiA+PiA+ICBbPGZmZmZmZmZmYjY4M2RkY2U+XSBrdGhyZWFk
KzB4ZmQvMHgxMDUKPj4gPiA+PiA+ICBbPGZmZmZmZmZmYzA2ODI3ZTI+XSA/IHZob3N0X2Rldl9z
ZXRfb3duZXIrMHgyMmUvMHgyMmUgW3Zob3N0XQo+PiA+ID4+ID4gIFs8ZmZmZmZmZmZiNjgzZGNk
MT5dID8gZmx1c2hfa3RocmVhZF93b3JrZXIrMHhmMy8weGYzCj4+ID4gPj4gPiAgWzxmZmZmZmZm
ZmI2ZWIzMzJlPl0gcmV0X2Zyb21fZm9yaysweDRlLzB4ODAKPj4gPiA+PiA+ICBbPGZmZmZmZmZm
YjY4M2RjZDE+XSA/IGZsdXNoX2t0aHJlYWRfd29ya2VyKzB4ZjMvMHhmMwo+PiA+ID4+ID4KPj4g
PiA+PiA+IFdvcmsgYXJvdW5kIGJ5IGRvaW5nIGt2bWFsbG9jIGluc3RlYWQuCj4+ID4gPj4gPgo+
PiA+ID4+ID4gU2lnbmVkLW9mZi1ieTogSnVuaWNoaSBVZWthd2EgPHVla2F3YUBjaHJvbWl1bS5v
cmc+Cj4+ID4gPgo+PiA+ID5NeSB3b3JyeSBoZXJlIGlzIHRoYXQgdGhpcyBpbiBtb3JlIG9mIGEg
d29yayBhcm91bmQuCj4+ID4gPkl0IHdvdWxkIGJlIGJldHRlciB0byBub3QgYWxsb2NhdGUgbWVt
b3J5IHNvIGFnZ3Jlc3NpdmVseToKPj4gPiA+aWYgd2UgYXJlIHNvIHNob3J0IG9uIG1lbW9yeSB3
ZSBzaG91bGQgcHJvYmFibHkgcHJvY2Vzcwo+PiA+ID5wYWNrZXRzIG9uZSBhdCBhIHRpbWUuIElz
IHRoYXQgdmVyeSBoYXJkIHRvIGltcGxlbWVudD8KPj4gPgo+PiA+IEN1cnJlbnRseSB0aGUgInZp
cnRpb192c29ja19wa3QiIGlzIGFsbG9jYXRlZCBpbiB0aGUgImhhbmRsZV9raWNrIgo+PiA+IGNh
bGxiYWNrIG9mIFRYIHZpcnRxdWV1ZS4gVGhlbiB0aGUgcGFja2V0IGlzIG11bHRpcGxleGVkIG9u
IHRoZSByaWdodAo+PiA+IHNvY2tldCBxdWV1ZSwgdGhlbiB0aGUgdXNlciBzcGFjZSBjYW4gZGUt
cXVldWUgaXQgd2hlbmV2ZXIgdGhleSB3YW50Lgo+PiA+Cj4+ID4gU28gbWF5YmUgd2UgY2FuIHN0
b3AgcHJvY2Vzc2luZyB0aGUgdmlydHF1ZXVlIGlmIHdlIGFyZSBzaG9ydCBvbiBtZW1vcnksCj4+
ID4gYnV0IHdoZW4gY2FuIHdlIHJlc3RhcnQgdGhlIFRYIHZpcnRxdWV1ZSBwcm9jZXNzaW5nPwo+
PiA+Cj4+ID4gSSB0aGluayBhcyBsb25nIGFzIHRoZSBndWVzdCB1c2VkIG9ubHkgNEsgYnVmZmVy
cyB3ZSBoYWQgbm8gcHJvYmxlbSwgYnV0Cj4+ID4gbm93IHRoYXQgaXQgY2FuIGNyZWF0ZSBsYXJn
ZXIgYnVmZmVycyB0aGUgaG9zdCBtYXkgbm90IGJlIGFibGUgdG8KPj4gPiBhbGxvY2F0ZSBpdCBj
b250aWd1b3VzbHkuIFNpbmNlIHRoZXJlIGlzIG5vIG5lZWQgdG8gaGF2ZSB0aGVtIGNvbnRpZ3Vv
dXMKPj4gPiBoZXJlLCBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgb2theS4KPj4gPgo+PiA+IEhvd2V2
ZXIsIGlmIHdlIHN3aXRjaCB0byBza19idWZmIChhcyBCb2JieSBpcyBhbHJlYWR5IGRvaW5nKSwg
bWF5YmUgd2UKPj4gPiBkb24ndCBoYXZlIHRoaXMgcHJvYmxlbSBiZWNhdXNlIEkgdGhpbmsgdGhl
cmUgaXMgc29tZSBraW5kIG9mCj4+ID4gcHJlLWFsbG9jYXRlZCBwb29sLgo+PiA+Cj4+Cj4+IFRo
YW5rIHlvdSBmb3IgdGhlIHJldmlldyEgSSB3YXMgd29uZGVyaW5nIGlmIHRoaXMgaXMgYSByZWFz
b25hYmxlIHdvcmthcm91bmQgKGFzCj4+IHdlIGZvdW5kIHRoYXQgdGhpcyBwYXRjaCBtYWtlcyBh
IHJlbGlhYmx5IGNyYXNoaW5nIHN5c3RlbSBpbnRvIGEKPj4gcmVsaWFibHkgc3Vydml2aW5nIHN5
c3RlbS4pCj4+Cj4+Cj4+IC4uLiBTb3VuZHMgbGlrZSBpdCBpcyBhIHJlYXNvbmFibGUgcGF0Y2gg
dG8gdXNlIGJhY2twb3J0ZWQgdG8gb2xkZXIga2VybmVscz8KPgo+SG1tLiBHb29kIHBvaW50IGFi
b3V0IHN0YWJsZS4gT0suCgpSaWdodCwgc28gaW4gdGhpcyBjYXNlIEkgdGhpbmsgaXMgYmV0dGVy
IHRvIGFkZCBhIEZpeGVzIHRhZy4gU2luY2Ugd2UgCnVzZWQga21hbGxvYyBmcm9tIHRoZSBiZWdp
bm5pbmcgd2UgY2FuIHVzZSB0aGUgZm9sbG93aW5nOgoKRml4ZXM6IDQzM2ZjNThlNmJmMiAoIlZT
T0NLOiBJbnRyb2R1Y2Ugdmhvc3RfdnNvY2sua28iKQoKPgo+QWNrZWQtYnk6IE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4KCkBNaWNoYWVsIGFyZSB5b3UgcXVldWVpbmcgdGhp
cywgb3Igc2hvdWxkIGl0IGdvIHRocm91Z2ggbmV0IHRyZWU/CgpUaGFua3MsClN0ZWZhbm8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
