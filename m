Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B73C4708D
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 04:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE851400DD;
	Wed,  4 Jan 2023 04:23:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE851400DD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dX4OggbB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4RDvgYKwo3dq; Wed,  4 Jan 2023 04:23:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6148C401C9;
	Wed,  4 Jan 2023 04:23:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6148C401C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37A82C0033;
	Wed,  4 Jan 2023 04:23:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5124C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6EBD417E6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:23:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6EBD417E6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dX4OggbB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0wW5IFcbg_5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:23:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CC01417E2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CC01417E2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 04:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672806196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgnhlnuG8Qrqs2IY3wKLTrPyEJc3j7HXcojektB5wC8=;
 b=dX4OggbB1vWakCHXlWzjIO5VQatLatKpu1f22gqVi5xh4+l02F5vuRnO+n2xSSH21XisKk
 +HOw0VhxFnPa0+Gdoq/wL4sM81HxjgohYXAchD853e5Hzx92pS0PZAj018CDa+XvMwH8+4
 HHPh+qEhI9lE5INra/iwez9uMcX0Vns=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-idgroUyCOjySYFLHaeW7XQ-1; Tue, 03 Jan 2023 23:23:14 -0500
X-MC-Unique: idgroUyCOjySYFLHaeW7XQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 e11-20020a63d94b000000b0048988ed9a6cso14745667pgj.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Jan 2023 20:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgnhlnuG8Qrqs2IY3wKLTrPyEJc3j7HXcojektB5wC8=;
 b=AfGMZx8+Poiorwv3wXVnQvUgzeeikTHs8sbsR6Mu+iRqJnzLPPT5KJvXzLodwpEaXS
 DeQbh7kyMuNuk3WHS0vp7vfia1Pu+rEzxLVZOe4cCGXmO4oF5Ed92UQlIMXgBzkwWbPf
 xccdubTVMP9k1HYCmstTlAf+qApPrEzupY0XRB30uTNBVHfOgxGtTMRhv68bX2N9vqoq
 Cn4vrZQcXYQGzL4zBRvDTd3gD4F+0pxAUSPw1CI2XzjbFHlvVd2DZy+hMRU0rU35Ngza
 VuS7VxAPZh10L/EbLsbo5xL4IZVw+8s46PmkNrORMeSZtFLpYc+934cqspTTp4o71FEQ
 KsJg==
X-Gm-Message-State: AFqh2krjvPCrFXn0lmqtm8yrtyQ1XyCOIDzl6BfIC0QODOGMLok9VMhT
 G2lIui7Tnsi9A+iyx/rEGHeGKtc2OMQI7oQje2YS5v/uzf8avphuH5rUAr1f+NLc4M4fP9RX274
 VQOTWQDWtINAyPLZa0mbnvodWG6QZa8JqusJBlS5VTg==
X-Received: by 2002:a17:90a:a28:b0:223:f78c:15d with SMTP id
 o37-20020a17090a0a2800b00223f78c015dmr50555165pjo.41.1672806193513; 
 Tue, 03 Jan 2023 20:23:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvowa9FjwdVvcjzcMHRWWWzT3O0PY8GaSTGVqf+/FTk/nR/PayTpQ5bku/F9FLYRf2r3tu2LQ==
X-Received: by 2002:a17:90a:a28:b0:223:f78c:15d with SMTP id
 o37-20020a17090a0a2800b00223f78c015dmr50555150pjo.41.1672806193244; 
 Tue, 03 Jan 2023 20:23:13 -0800 (PST)
Received: from [10.72.12.120] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 ml4-20020a17090b360400b00217090ece49sm20040933pjb.31.2023.01.03.20.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 20:23:12 -0800 (PST)
Message-ID: <50eb0df0-89fe-a5df-f89f-07bf69bd00ae@redhat.com>
Date: Wed, 4 Jan 2023 12:23:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH net V2] virtio-net: correctly enable callback during
 start_xmit
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221215032719.72294-1-jasowang@redhat.com>
 <20221215034740-mutt-send-email-mst@kernel.org>
 <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
 <20221215042918-mutt-send-email-mst@kernel.org>
 <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
 <CACGkMEsu_OFFs15d2dzNbfSjzAZfYXLn9CNcO3ELPbDqZsndzg@mail.gmail.com>
In-Reply-To: <CACGkMEsu_OFFs15d2dzNbfSjzAZfYXLn9CNcO3ELPbDqZsndzg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

CuWcqCAyMDIyLzEyLzIzIDE0OjI5LCBKYXNvbiBXYW5nIOWGmemBkzoKPiBPbiBGcmksIERlYyAx
NiwgMjAyMiBhdCAxMTo0MyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgNTozNSBQTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+IE9uIFRodSwgRGVjIDE1LCAyMDIyIGF0IDA1OjE1
OjQzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4gT24gVGh1LCBEZWMgMTUsIDIwMjIg
YXQgNTowMiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+
Pj4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgMTE6Mjc6MTlBTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Pj4+IENvbW1pdCBhNzc2NmVmMThiMzMoInZpcnRpb19uZXQ6IGRpc2FibGUgY2Ig
YWdncmVzc2l2ZWx5IikgZW5hYmxlcwo+Pj4+Pj4gdmlydHF1ZXVlIGNhbGxiYWNrIHZpYSB0aGUg
Zm9sbG93aW5nIHN0YXRlbWVudDoKPj4+Pj4+Cj4+Pj4+PiAgICAgICAgICBkbyB7Cj4+Pj4+PiAg
ICAgICAgICAgICAuLi4uLi4KPj4+Pj4+ICAgICAgICB9IHdoaWxlICh1c2VfbmFwaSAmJiBraWNr
ICYmCj4+Pj4+PiAgICAgICAgICAgICAgICAgdW5saWtlbHkoIXZpcnRxdWV1ZV9lbmFibGVfY2Jf
ZGVsYXllZChzcS0+dnEpKSk7Cj4+Pj4+Pgo+Pj4+Pj4gV2hlbiBOQVBJIGlzIHVzZWQgYW5kIGtp
Y2sgaXMgZmFsc2UsIHRoZSBjYWxsYmFjayB3b24ndCBiZSBlbmFibGVkCj4+Pj4+PiBoZXJlLiBB
bmQgd2hlbiB0aGUgdmlydHF1ZXVlIGlzIGFib3V0IHRvIGJlIGZ1bGwsIHRoZSB0eCB3aWxsIGJl
Cj4+Pj4+PiBkaXNhYmxlZCwgYnV0IHdlIHN0aWxsIGRvbid0IGVuYWJsZSB0eCBpbnRlcnJ1cHQg
d2hpY2ggd2lsbCBjYXVzZSBhIFRYCj4+Pj4+PiBoYW5nLiBUaGlzIGNvdWxkIGJlIG9ic2VydmVk
IHdoZW4gdXNpbmcgcGt0Z2VuIHdpdGggYnVyc3QgZW5hYmxlZC4KPj4+Pj4+Cj4+Pj4+PiBGaXhp
bmcgdGhpcyBieSB0cnlpbmcgdG8gZW5hYmxlIHR4IGludGVycnVwdCBhZnRlciB3ZSBkaXNhYmxl
IFRYIHdoZW4KPj4+Pj4+IHdlJ3JlIG5vdCB1c2luZyBuYXBpIG9yIGtpY2sgaXMgZmFsc2UuCj4+
Pj4+Pgo+Pj4+Pj4gRml4ZXM6IGE3NzY2ZWYxOGIzMyAoInZpcnRpb19uZXQ6IGRpc2FibGUgY2Ig
YWdncmVzc2l2ZWx5IikKPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+IFRoZSBwYXRjaCBpcyBuZWVkZWQgZm9yIC1z
dGFibGUuCj4+Pj4+PiBDaGFuZ2VzIHNpbmNlIFYxOgo+Pj4+Pj4gLSBlbmFibGUgdHggaW50ZXJy
dXB0IGFmdGVyIHdlIGRpc2FibGUgdHgKPj4+Pj4+IC0tLQo+Pj4+Pj4gICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAyICstCj4+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+IGluZGV4IDg2ZTUy
NDU0YjViNS4uZGNmM2E1MzZkNzhhIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+IEBA
IC0xODczLDcgKzE4NzMsNyBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+Pj4+Pj4gICAgICAgICAqLwo+
Pj4+Pj4gICAgICAgIGlmIChzcS0+dnEtPm51bV9mcmVlIDwgMitNQVhfU0tCX0ZSQUdTKSB7Cj4+
Pj4+PiAgICAgICAgICAgICAgICBuZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4+Pj4+
PiAtICAgICAgICAgICAgIGlmICghdXNlX25hcGkgJiYKPj4+Pj4+ICsgICAgICAgICAgICAgaWYg
KCghdXNlX25hcGkgfHwgIWtpY2spICYmCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgdW5saWtl
bHkoIXZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpKSkgewo+Pj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAvKiBNb3JlIGp1c3QgZ290IHVzZWQsIGZyZWUgdGhlbSB0aGVuIHJl
Y2hlY2suICovCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXRfc2ti
cyhzcSwgZmFsc2UpOwo+Pj4+PiBUaGlzIHdpbGwgd29yayBidXQgdGhlIGZvbGxvd2luZyBsaW5l
cyBhcmU6Cj4+Pj4+Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzcS0+dnEtPm51
bV9mcmVlID49IDIrTUFYX1NLQl9GUkFHUykgewo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBuZXRpZl9zdGFydF9zdWJxdWV1ZShkZXYsIHFudW0pOwo+Pj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgfQo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBhbmQgSSB0
aG91Z2h0IHdlIGFyZSBzdXBwb3NlZCB0byBrZWVwIGNhbGxiYWNrcyBlbmFibGVkIHdpdGggbmFw
aT8KPj4+PiBUaGlzIHNlZW1zIHRvIGJlIHRoZSBvcHBvc2l0ZSBsb2dpYyBvZiBjb21taXQgYTc3
NjZlZjE4YjMzIHRoYXQKPj4+PiBkaXNhYmxlcyBjYWxsYmFja3MgZm9yIE5BUEkuCj4+Pj4KPj4+
PiBJdCBzYWlkOgo+Pj4+Cj4+Pj4gICAgICBUaGVyZSBhcmUgY3VycmVudGx5IHR3byBjYXNlcyB3
aGVyZSB3ZSBwb2xsIFRYIHZxIG5vdCBpbiByZXNwb25zZSB0byBhCj4+Pj4gICAgICBjYWxsYmFj
azogc3RhcnQgeG1pdCBhbmQgcnggbmFwaS4gIFdlIGN1cnJlbnRseSBkbyB0aGlzIHdpdGggY2Fs
bGJhY2tzCj4+Pj4gICAgICBlbmFibGVkIHdoaWNoIGNhbiBjYXVzZSBleHRyYSBpbnRlcnJ1cHRz
IGZyb20gdGhlIGNhcmQuICBVc2VkIG5vdCB0byBiZQo+Pj4+ICAgICAgYSBiaWcgaXNzdWUgYXMg
d2UgcnVuIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCBidXQgdGhhdCBpcyBubyBsb25nZXIgdGhl
Cj4+Pj4gICAgICBjYXNlLCBhbmQgaW4gc29tZSBjYXNlcyB0aGUgcmF0ZSBvZiBzcHVyaW91cyBp
bnRlcnJ1cHRzIGlzIHNvIGhpZ2gKPj4+PiAgICAgIGxpbnV4IGRldGVjdHMgdGhpcyBhbmQgYWN0
dWFsbHkga2lsbHMgdGhlIGludGVycnVwdC4KPj4+Pgo+Pj4+IE15IHVuZGVyc2F0bmRpbmcgaXMg
dGhhdCBpdCB0cmllcyB0byBkaXNhYmxlIGNhbGxiYWNrcyBvbiBUWC4KPj4+IEkgdGhpbmsgd2Ug
d2FudCB0byBkaXNhYmxlIGNhbGxiYWNrcyB3aGlsZSBwb2xsaW5nLCB5ZXMuIGhlcmUgd2UgYXJl
IG5vdAo+Pj4gcG9sbGluZywgYW5kIEkgdGhpbmsgd2Ugd2FudCBhIGNhbGxiYWNrIGJlY2F1c2Ug
b3RoZXJ3aXNlIG5vdGhpbmcgd2lsbAo+Pj4gb3JwaGFuIHNrYnMgYW5kIGEgc29ja2V0IGNhbiBi
ZSBibG9ja2VkLCBub3QgdHJhbnNtaXR0aW5nIGFueXRoaW5nIC0gYQo+Pj4gZGVhZGxvY2suCj4+
IEknbSBub3Qgc3VyZSBob3cgSSBnb3QgaGVyZSwgZGlkIHlvdSBtZWFuIGEgcGFydGlhbCByZXZl
cnQgb2YKPj4gYTc3NjZlZjE4YjMzICh0aGUgcGFydCB0aGF0IGRpc2FibGVzIFRYIGNhbGxiYWNr
cyBvbiBzdGFydF94bWl0KT8KPiBNaWNoYWVsLCBhbnkgaWRlYSBvbiB0aGlzPwo+Cj4gVGhhbmtz
CgoKTWljaGFlbCwgYW55IGNvbW1lbnQ/CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
