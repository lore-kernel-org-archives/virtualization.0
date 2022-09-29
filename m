Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C12C07E9D
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9E9B41995;
	Thu, 29 Sep 2022 07:49:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9E9B41995
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L208wYi8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNqL2_J7eXDj; Thu, 29 Sep 2022 07:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1D5E419E6;
	Thu, 29 Sep 2022 07:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1D5E419E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B839C0033;
	Thu, 29 Sep 2022 07:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 427B1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D5EA83E66
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D5EA83E66
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L208wYi8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rd7iUPFbVMk5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:49:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 430C083E2C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 430C083E2C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664437765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5qI7b94+taNEfTbBkn8B22CaCzkL3JdPIVHISnwlAM=;
 b=L208wYi82H10CqNSRYw74uwGEA7nCMw45v9APz93lT2IrcCVN3BDhBr+mdJqJoxNORjj2B
 BubTGMEdGBM4qsijX90KMTIs4LNwjsNxgcGpU2yJ8Tum4nT5tFm6aCFTxTzVEAnu83iheH
 9B0YpmUptED8QgsqgkyULydb1czr6pc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318--xLGmyp-PYefVQhQMzEiGg-1; Thu, 29 Sep 2022 03:49:24 -0400
X-MC-Unique: -xLGmyp-PYefVQhQMzEiGg-1
Received: by mail-wr1-f69.google.com with SMTP id
 k30-20020adfb35e000000b0022cc5ecd872so192955wrd.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=B5qI7b94+taNEfTbBkn8B22CaCzkL3JdPIVHISnwlAM=;
 b=MNw+M2yfhyWxbGf1+xVKs1KdjTYDukZA2zMdMfvtxDADZ1FjbPhSI9cBaY6Q+hAuot
 a8cRO726sDQtHKt1IFw7lF+imNvtgN2vw9FMrbGK/xggkkj+tWOFVVU9KxeLiZym6aDq
 MWl8HP4z8MorQEqDF1KJIR9bzNJ5DVUIMTmUEj6DYtxSQddNYG0hv5hYwCLgX84mHlKJ
 rn9IABm1ZHRsQyrgt76vtYfGAz+aMKIwBSxFm4hzmM/u3SgNJyxb19VHpkEUR02RHCHi
 ugu3MLKjquqXcq8OUJmFFSoLR3/pnCE5N4HhahKqqrZqDJKcr3OVcPT13uTpB/wXi+oY
 1Niw==
X-Gm-Message-State: ACrzQf1EqVo+hPMCGjJ8CjNjPTP75j/wYk8xkirN7+eI75kDyIggzE4J
 Ag9/m7JMJVmaKClOfmT62moguI+RfhIEpyli+alLCnN7luC1sxE7iiYvnXZ7TUeIyHTGIazNpLX
 hbEbKGv/68dbkBjH9kKnYzqAhQ7Pukuvp7mSCmZ55/A==
X-Received: by 2002:a05:600c:4fd2:b0:3b4:cab9:44f0 with SMTP id
 o18-20020a05600c4fd200b003b4cab944f0mr9860809wmq.73.1664437762951; 
 Thu, 29 Sep 2022 00:49:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4msH8Z/F3t4GcEn/O8enUvxnRZFEtbEHz6nKwdRFvfOH+ZEpp/nXVxoWlaKXFvrX79zD/DFA==
X-Received: by 2002:a05:600c:4fd2:b0:3b4:cab9:44f0 with SMTP id
 o18-20020a05600c4fd200b003b4cab944f0mr9860792wmq.73.1664437762720; 
 Thu, 29 Sep 2022 00:49:22 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b003b4de550e34sm3503540wmb.40.2022.09.29.00.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:49:22 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:49:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929034807-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <CADgJSGHxPWXJjbakEeWnqF42A03yK7Dpw6U1SKNLhk+B248Ymg@mail.gmail.com>
 <20220929031419-mutt-send-email-mst@kernel.org>
 <20220929074606.yqzihpcc7cl442c5@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220929074606.yqzihpcc7cl442c5@sgarzare-redhat>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDk6NDY6MDZBTSArMDIwMCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOgo+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjE5OjE0QU0gLTA0MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDA4OjE0
OjI0QU0gKzA5MDAsIEp1bmljaGkgVWVrYXdhICjkuIrlt53ntJTkuIApIHdyb3RlOgo+ID4gPiAy
MDIy5bm0OeaciDI55pelKOacqCkgMDoxMSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJl
ZGhhdC5jb20+Ogo+ID4gPiA+Cj4gPiA+ID4gT24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMDU6MzE6
NThBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID5PbiBXZWQsIFNl
cCAyOCwgMjAyMiBhdCAxMDoyODoyM0FNICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4gPiA+ID4gPj4gT24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMDM6NDU6MzhQTSArMDkwMCwgSnVu
aWNoaSBVZWthd2Egd3JvdGU6Cj4gPiA+ID4gPj4gPiBXaGVuIGNvcHlpbmcgYSBsYXJnZSBmaWxl
IG92ZXIgc2Z0cCBvdmVyIHZzb2NrLCBkYXRhIHNpemUgaXMgdXN1YWxseSAzMmtCLAo+ID4gPiA+
ID4+ID4gYW5kIGttYWxsb2Mgc2VlbXMgdG8gZmFpbCB0byB0cnkgdG8gYWxsb2NhdGUgMzIgMzJr
QiByZWdpb25zLgo+ID4gPiA+ID4+ID4KPiA+ID4gPiA+PiA+IENhbGwgVHJhY2U6Cj4gPiA+ID4g
Pj4gPiAgWzxmZmZmZmZmZmI2YTBkZjY0Pl0gZHVtcF9zdGFjaysweDk3LzB4ZGIKPiA+ID4gPiA+
PiA+ICBbPGZmZmZmZmZmYjY4ZDZhZWQ+XSB3YXJuX2FsbG9jX2ZhaWxlZCsweDEwZi8weDEzOAo+
ID4gPiA+ID4+ID4gIFs8ZmZmZmZmZmZiNjhkODY4YT5dID8gX19hbGxvY19wYWdlc19kaXJlY3Rf
Y29tcGFjdCsweDM4LzB4YzgKPiA+ID4gPiA+PiA+ICBbPGZmZmZmZmZmYjY2NDYxOWY+XSBfX2Fs
bG9jX3BhZ2VzX25vZGVtYXNrKzB4ODRjLzB4OTBkCj4gPiA+ID4gPj4gPiAgWzxmZmZmZmZmZmI2
NjQ2ZTU2Pl0gYWxsb2Nfa21lbV9wYWdlcysweDE3LzB4MTkKPiA+ID4gPiA+PiA+ICBbPGZmZmZm
ZmZmYjY2NTNhMjY+XSBrbWFsbG9jX29yZGVyX3RyYWNlKzB4MmIvMHhkYgo+ID4gPiA+ID4+ID4g
IFs8ZmZmZmZmZmZiNjY2ODJmMz5dIF9fa21hbGxvYysweDE3Ny8weDFmNwo+ID4gPiA+ID4+ID4g
IFs8ZmZmZmZmZmZiNjZlMGQ5ND5dID8gY29weV9mcm9tX2l0ZXIrMHg4ZC8weDMxZAo+ID4gPiA+
ID4+ID4gIFs8ZmZmZmZmZmZjMDY4OWFiNz5dIHZob3N0X3Zzb2NrX2hhbmRsZV90eF9raWNrKzB4
MWZhLzB4MzAxIFt2aG9zdF92c29ja10KPiA+ID4gPiA+PiA+ICBbPGZmZmZmZmZmYzA2ODI4ZDk+
XSB2aG9zdF93b3JrZXIrMHhmNy8weDE1NyBbdmhvc3RdCj4gPiA+ID4gPj4gPiAgWzxmZmZmZmZm
ZmI2ODNkZGNlPl0ga3RocmVhZCsweGZkLzB4MTA1Cj4gPiA+ID4gPj4gPiAgWzxmZmZmZmZmZmMw
NjgyN2UyPl0gPyB2aG9zdF9kZXZfc2V0X293bmVyKzB4MjJlLzB4MjJlIFt2aG9zdF0KPiA+ID4g
PiA+PiA+ICBbPGZmZmZmZmZmYjY4M2RjZDE+XSA/IGZsdXNoX2t0aHJlYWRfd29ya2VyKzB4ZjMv
MHhmMwo+ID4gPiA+ID4+ID4gIFs8ZmZmZmZmZmZiNmViMzMyZT5dIHJldF9mcm9tX2ZvcmsrMHg0
ZS8weDgwCj4gPiA+ID4gPj4gPiAgWzxmZmZmZmZmZmI2ODNkY2QxPl0gPyBmbHVzaF9rdGhyZWFk
X3dvcmtlcisweGYzLzB4ZjMKPiA+ID4gPiA+PiA+Cj4gPiA+ID4gPj4gPiBXb3JrIGFyb3VuZCBi
eSBkb2luZyBrdm1hbGxvYyBpbnN0ZWFkLgo+ID4gPiA+ID4+ID4KPiA+ID4gPiA+PiA+IFNpZ25l
ZC1vZmYtYnk6IEp1bmljaGkgVWVrYXdhIDx1ZWthd2FAY2hyb21pdW0ub3JnPgo+ID4gPiA+ID4K
PiA+ID4gPiA+TXkgd29ycnkgaGVyZSBpcyB0aGF0IHRoaXMgaW4gbW9yZSBvZiBhIHdvcmsgYXJv
dW5kLgo+ID4gPiA+ID5JdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbm90IGFsbG9jYXRlIG1lbW9yeSBz
byBhZ2dyZXNzaXZlbHk6Cj4gPiA+ID4gPmlmIHdlIGFyZSBzbyBzaG9ydCBvbiBtZW1vcnkgd2Ug
c2hvdWxkIHByb2JhYmx5IHByb2Nlc3MKPiA+ID4gPiA+cGFja2V0cyBvbmUgYXQgYSB0aW1lLiBJ
cyB0aGF0IHZlcnkgaGFyZCB0byBpbXBsZW1lbnQ/Cj4gPiA+ID4KPiA+ID4gPiBDdXJyZW50bHkg
dGhlICJ2aXJ0aW9fdnNvY2tfcGt0IiBpcyBhbGxvY2F0ZWQgaW4gdGhlICJoYW5kbGVfa2ljayIK
PiA+ID4gPiBjYWxsYmFjayBvZiBUWCB2aXJ0cXVldWUuIFRoZW4gdGhlIHBhY2tldCBpcyBtdWx0
aXBsZXhlZCBvbiB0aGUgcmlnaHQKPiA+ID4gPiBzb2NrZXQgcXVldWUsIHRoZW4gdGhlIHVzZXIg
c3BhY2UgY2FuIGRlLXF1ZXVlIGl0IHdoZW5ldmVyIHRoZXkgd2FudC4KPiA+ID4gPgo+ID4gPiA+
IFNvIG1heWJlIHdlIGNhbiBzdG9wIHByb2Nlc3NpbmcgdGhlIHZpcnRxdWV1ZSBpZiB3ZSBhcmUg
c2hvcnQgb24gbWVtb3J5LAo+ID4gPiA+IGJ1dCB3aGVuIGNhbiB3ZSByZXN0YXJ0IHRoZSBUWCB2
aXJ0cXVldWUgcHJvY2Vzc2luZz8KPiA+ID4gPgo+ID4gPiA+IEkgdGhpbmsgYXMgbG9uZyBhcyB0
aGUgZ3Vlc3QgdXNlZCBvbmx5IDRLIGJ1ZmZlcnMgd2UgaGFkIG5vIHByb2JsZW0sIGJ1dAo+ID4g
PiA+IG5vdyB0aGF0IGl0IGNhbiBjcmVhdGUgbGFyZ2VyIGJ1ZmZlcnMgdGhlIGhvc3QgbWF5IG5v
dCBiZSBhYmxlIHRvCj4gPiA+ID4gYWxsb2NhdGUgaXQgY29udGlndW91c2x5LiBTaW5jZSB0aGVy
ZSBpcyBubyBuZWVkIHRvIGhhdmUgdGhlbSBjb250aWd1b3VzCj4gPiA+ID4gaGVyZSwgSSB0aGlu
ayB0aGlzIHBhdGNoIGlzIG9rYXkuCj4gPiA+ID4KPiA+ID4gPiBIb3dldmVyLCBpZiB3ZSBzd2l0
Y2ggdG8gc2tfYnVmZiAoYXMgQm9iYnkgaXMgYWxyZWFkeSBkb2luZyksIG1heWJlIHdlCj4gPiA+
ID4gZG9uJ3QgaGF2ZSB0aGlzIHByb2JsZW0gYmVjYXVzZSBJIHRoaW5rIHRoZXJlIGlzIHNvbWUg
a2luZCBvZgo+ID4gPiA+IHByZS1hbGxvY2F0ZWQgcG9vbC4KPiA+ID4gPgo+ID4gPiAKPiA+ID4g
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3ISBJIHdhcyB3b25kZXJpbmcgaWYgdGhpcyBpcyBhIHJl
YXNvbmFibGUgd29ya2Fyb3VuZCAoYXMKPiA+ID4gd2UgZm91bmQgdGhhdCB0aGlzIHBhdGNoIG1h
a2VzIGEgcmVsaWFibHkgY3Jhc2hpbmcgc3lzdGVtIGludG8gYQo+ID4gPiByZWxpYWJseSBzdXJ2
aXZpbmcgc3lzdGVtLikKPiA+ID4gCj4gPiA+IAo+ID4gPiAuLi4gU291bmRzIGxpa2UgaXQgaXMg
YSByZWFzb25hYmxlIHBhdGNoIHRvIHVzZSBiYWNrcG9ydGVkIHRvIG9sZGVyIGtlcm5lbHM/Cj4g
PiAKPiA+IEhtbS4gR29vZCBwb2ludCBhYm91dCBzdGFibGUuIE9LLgo+IAo+IFJpZ2h0LCBzbyBp
biB0aGlzIGNhc2UgSSB0aGluayBpcyBiZXR0ZXIgdG8gYWRkIGEgRml4ZXMgdGFnLiBTaW5jZSB3
ZSB1c2VkCj4ga21hbGxvYyBmcm9tIHRoZSBiZWdpbm5pbmcgd2UgY2FuIHVzZSB0aGUgZm9sbG93
aW5nOgo+IAo+IEZpeGVzOiA0MzNmYzU4ZTZiZjIgKCJWU09DSzogSW50cm9kdWNlIHZob3N0X3Zz
b2NrLmtvIikKPiAKPiA+IAo+ID4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+Cj4gPiAKPiAKPiBATWljaGFlbCBhcmUgeW91IHF1ZXVlaW5nIHRoaXMsIG9yIHNo
b3VsZCBpdCBnbyB0aHJvdWdoIG5ldCB0cmVlPwo+IAo+IFRoYW5rcywKPiBTdGVmYW5vCgpuZXQg
dHJlZSB3b3VsZCBiZSBwcmVmZXJhYmxlLCBteSBwdWxsIGZvciB0aGlzIHJlbGVhc2UgaXMga2lu
ZCBvZiByZWFkeSAuLi4ga3ViYT8KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
