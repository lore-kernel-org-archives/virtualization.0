Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AED5C77B62
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 08:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4D4641FD3;
	Fri, 31 Mar 2023 08:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4D4641FD3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WK7nctRk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0WJZqmIxjUT; Fri, 31 Mar 2023 08:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F01641FAF;
	Fri, 31 Mar 2023 08:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F01641FAF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5727DC0091;
	Fri, 31 Mar 2023 08:00:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96411C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 08:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 778DF421D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 08:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 778DF421D1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WK7nctRk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Axkq3SlAmLds
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 08:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF623421E1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF623421E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680249629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M2zRQCJfE4IfmCVgFP+fSUH3fGzboBASzjg7r7jVyXI=;
 b=WK7nctRkKI6G9Kl5jIX4eqjHX7+LMGIfL5CpkF7BgxODQuOKvnmGAb+TL9G9sZEFYXNI9c
 2AiD0DzmMh/SWwoULJDPHLG5ZEU2XJRLult+5YFVCebD1YoSyXY9XSrYttbhAWaBX1nqCU
 tJkluQLfkbaaDj2Srm0rf4XJtrBk7GI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-_4Cb4fZGNdS3CbFRYVgwUQ-1; Fri, 31 Mar 2023 04:00:28 -0400
X-MC-Unique: _4Cb4fZGNdS3CbFRYVgwUQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 p10-20020a05600c358a00b003edf7d484d4so10996116wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 01:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680249627;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M2zRQCJfE4IfmCVgFP+fSUH3fGzboBASzjg7r7jVyXI=;
 b=FZuiLc8b0RzJPZHM/vKboITKteGEWTrlUW17tSCPLGawpyoP5AGSMZFWZ0NjHm/yGi
 79AUbTsHozIo8MqXUR/bd7zExEgJkoaD7l0LDf+8E4ZWrLXuARnMCYcQG8Rq/mRgb0l5
 1AIHCyE6bY3wIDWmfHelMqyG+66CSfWpmc+xQqnKY9L6MMFEdpBJ6s1jwz6niBw+PupX
 2HRRnqyOu9sezFQtFd3eMIB3w+6YaRFj/ykTGxMWVKh/zvMd25kNrvHF9voPeu09UR3X
 MDTrbTs+cv0dk6B023ji4K0oWrFLTLDawFepAoKD4Q1kJmLAa7YGv/19YVgKXIEsAHVu
 azkA==
X-Gm-Message-State: AAQBX9d7gSTaqBo0krOIDPkXNEWnJRkStZHyX9khg84z6yjWUnNNjY0Q
 jHYE3xl2zzuATJB2nP571/ZqUhc3ROHhq5IcNWuuenDDHPNzfZ506rAx1e9TTCkOZ2myBZseObR
 9D/Ft7pdBWjMozgi55vzfIFhZe7F0xKcODf2iK4BFUA==
X-Received: by 2002:adf:e70c:0:b0:2ce:9f35:59c7 with SMTP id
 c12-20020adfe70c000000b002ce9f3559c7mr17844652wrm.45.1680249627455; 
 Fri, 31 Mar 2023 01:00:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYg1o6rqxhuN/GDlXyBevUxypRmEZ8q6c+KByR/Zvjl+kNcSKPYKcRt2PJxPmhUH9Buxct8w==
X-Received: by 2002:adf:e70c:0:b0:2ce:9f35:59c7 with SMTP id
 c12-20020adfe70c000000b002ce9f3559c7mr17844624wrm.45.1680249627100; 
 Fri, 31 Mar 2023 01:00:27 -0700 (PDT)
Received: from redhat.com ([2.52.159.107]) by smtp.gmail.com with ESMTPSA id
 y11-20020adfd08b000000b002c55b0e6ef1sm1520733wrh.4.2023.03.31.01.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Mar 2023 01:00:26 -0700 (PDT)
Date: Fri, 31 Mar 2023 04:00:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/16] virtio-net: split virtio-net.c
Message-ID: <20230331035942-mutt-send-email-mst@kernel.org>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
 <20230330015412-mutt-send-email-mst@kernel.org>
 <1680247317.9193828-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEt2M3zaytjOmhTuSx6wnerZBrVoQxgbUuAv0WmUu50Hiw@mail.gmail.com>
 <1680248880.8897254-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1680248880.8897254-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgMDM6NDg6MDBQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIEZyaSwgMzEgTWFyIDIwMjMgMTU6MzU6MTQgKzA4MDAsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgMzozMeKA
r1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBUaHUsIDMwIE1hciAyMDIzIDAyOjE3OjQzIC0wNDAwLCAiTWljaGFlbCBTLiBUc2ly
a2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgTWFyIDI4LCAyMDIz
IGF0IDA1OjI4OjMxUE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+IENvbnNpZGVy
aW5nIHRoZSBjb21wbGV4aXR5IG9mIHZpcnRpby1uZXQuYyBhbmQgdGhlIG5ldyBmZWF0dXJlcyB3
ZSB3YW50Cj4gPiA+ID4gPiB0byBhZGQsIGl0IGlzIHRpbWUgdG8gc3BsaXQgdmlydGlvLW5ldC5j
IGludG8gbXVsdGlwbGUgaW5kZXBlbmRlbnQKPiA+ID4gPiA+IG1vZHVsZSBmaWxlcy4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBUaGlzIGlzIGJlbmVmaWNpYWwgdG8gdGhlIG1haW50ZW5hbmNlIGFuZCBh
ZGRpbmcgbmV3IGZ1bmN0aW9ucy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBBbmQgQUZfWERQIHN1cHBv
cnQgd2lsbCBiZSBhZGRlZCBsYXRlciwgdGhlbiBhIHNlcGFyYXRlIHhzay5jIGZpbGUgd2lsbAo+
ID4gPiA+ID4gYmUgYWRkZWQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBwYXRjaHNldCBzcGxp
dCB2aXJ0aW8tbmV0LmMgaW50byB0aGVzZSBwYXJ0czoKPiA+ID4gPiA+Cj4gPiA+ID4gPiAqIHZp
cnRuZXQuYzogICAgICAgICB2aXJ0aW8gbmV0IGRldmljZSBvcHMgKG5hcGksIHR4LCByeCwgZGV2
aWNlIG9wcywgLi4uKQo+ID4gPiA+ID4gKiB2aXJ0bmV0X2NvbW1vbi5jOiAgdmlydGlvIG5ldCBj
b21tb24gY29kZQo+ID4gPiA+ID4gKiB2aXJ0bmV0X2V0aHRvb2wuYzogdmlydGlvIG5ldCBldGh0
b29sIGNhbGxiYWNrcwo+ID4gPiA+ID4gKiB2aXJ0bmV0X2N0cmwuYzogICAgdmlydGlvIG5ldCBj
dHJsIHF1ZXVlIGNvbW1hbmQgQVBJcwo+ID4gPiA+ID4gKiB2aXJ0bmV0X3ZpcnRpby5jOiAgdmly
dGlvIG5ldCB2aXJ0aW8gY2FsbGJhY2tzL29wcyAoZHJpdmVyIHJlZ2lzdGVyLCB2aXJ0aW8gcHJv
YmUsIHZpcnRpbyBmcmVlLCAuLi4pCj4gPiA+ID4gPgo+ID4gPiA+ID4gUGxlYXNlIHJldmlldy4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEkgZG9u
J3QgZmVlbCB0aGlzIGlzIGFuIGltcHJvdmVtZW50IGFzIHByZXNlbnRlZCwgd2lsbCBuZWVkIG1v
cmUgd29yawo+ID4gPiA+IHRvIG1ha2UgY29kZSBwbGFjZW1lbnQgbW9yZSBsb2dpY2FsLgo+ID4g
Pgo+ID4gPiBZZXMsIHRoaXMgZG9lcyBuZWVkIHNvbWUgdGltZSBhbmQgZW5lcmd5LiBCdXQgSSB0
aGluayB0aGlzIGFsd2F5cyBuZWVkIHRvIGRvLAo+ID4gPiBqdXN0IHdoZW4gdG8gZG8gaXQuIEkg
dGhpbmsgaXQgaXMgY3VycmVudGx5IGFuIG9wcG9ydHVuaXR5Lgo+ID4gPgo+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gRm9yIGV4YW1wbGUgd2hlcmUgZG8gSSBmaW5kIGNvZGUgdG8gdXBkYXRlIHJxIHN0
YXRzPwo+ID4gPiA+IFJ4IGRhdGEgcGF0aCBzaG91bGQgYmUgdmlydG5ldC5jPwo+ID4gPiA+IE5v
IGl0J3MgaW4gdmlydG5ldF9ldGh0b29sLmMgYmVjYXVzZSBycSBzdGF0cyBjYW4gYmUKPiA+ID4g
PiBhY2Nlc3NlZCBieSBldGh0b29sLgo+ID4gPgo+ID4gPiBUaGF0J3Mgd2hhdCBJIGRvLgo+ID4g
Pgo+ID4gPiA+IEEgYnVuY2ggb2Ygc3R1ZmYgc2VlbXMgdG8gYmUgaW4gaGVhZGVycyBqdXN0IGJl
Y2F1c2Ugb2YgdGVjaG5pY2FsaXRpZXMuCj4gPiA+ID4gdmlydGlvIGNvbW1vbiBzZWVtcyB0byBi
ZSBhIGR1bXBpbmcgZ3JvdW5kIHdpdGggbm8gZ3VpZGluZyBwcmluY2lwbGUgYXQKPiA+ID4gPiBh
bGwuCj4gPiA+Cj4gPiA+IFllcywgSSBhZ3JlZSwgd2l0aCB0aGUgZGV2ZWxvcG1lbnQgb2YgdGlt
ZSwgY29tbW9uIHdpbGwgaW5kZWVkIGJlY29tZSBhIGR1bXBpbmcKPiA+ID4gZ3JvdXAuIFRoaXMg
aXMgc29tZXRoaW5nIHdlIHNob3VsZCBwYXkgYXR0ZW50aW9uIHRvIGFmdGVyIHRoaXMuCj4gPiA+
Cj4gPiA+Cj4gPiA+ID4gZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRuZXRfdmlydGlvLmMgaXMgd2Vp
cmQgd2l0aAo+ID4gPiA+IHZpcnQgcmVwZWF0ZWQgdGhyZWUgdGltZXMgaW4gdGhlIHBhdGguCj4g
PiA+Cj4gPiA+IEFueSBnb29kIGlkZWEuCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGVzZSB0aGlu
Z3Mgb25seSBnZXQgbXVya2llciB3aXRoIHRpbWUsIGF0IHRoZSBwb2ludCBvZiByZW9yZwo+ID4g
PiA+IEkgd291bGQgZXhwZWN0IHZlcnkgbG9naWNhbCBwbGFjZW1lbnQsIHNpbmNlCj4gPiA+ID4g
d2l0aG91dCBjbGVhciBndWlkaW5nIHJ1bGUgZmluZGluZyB3aGVyZSBzb21ldGhpbmcgaXMgYmVj
b21lcyBoYXJkZXIgYnV0Cj4gPiA+ID4gbW9yZSBpbXBvcnRhbnRseSB3ZSdsbCBub3cgZ2V0IGVu
ZGxlc3MgaGVhcnRidXJuIGFib3V0IHdoZXJlIGRvZXMgZWFjaCBuZXcKPiA+ID4gPiBmdW5jdGlv
biBnby4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhlIHJlb3JnIGlzIHVuZm9ydHVuYXRlbHkg
bm90IGZyZWUgLSBmb3IgZXhhbXBsZSBnaXQgbG9nIC0tZm9sbG93IHdpbGwKPiA+ID4gPiBubyBs
b25nZXIgZWFzaWx5IG1hdGNoIHZpcnRpbyBiZWNhdXNlIC0tZm9sbG93IHdvcmtzIHdpdGggZXhh
Y3RseSBvbmUKPiA+ID4gPiBwYXRoLgo+ID4gPgo+ID4gPiBPbmUgZGF5IHdlIHdpbGwgZmFjZSB0
aGlzIHByb2JsZW0uCj4gPiA+Cj4gPiA+ID4gSXQncyBub3cgYWxzbyBleHRyYSB3b3JrIHRvIGtl
ZXAgaGVhZGVycyBzZWxmLWNvbnNpc3RlbnQuCj4gPiA+Cj4gPiA+IENhbiB3ZSBtYWtlIGl0IHNp
bXBsZXIsIGZpcnN0IGNvbXBsZXRlIHRoZSBzcGxpdC4KPiA+ID4KPiA+ID4KPiA+ID4gPiBTbyBp
dCBiZXR0ZXIgYmUgYSBiaWcgaW1wcm92ZW1lbnQgdG8gYmUgd29ydGggaXQuCj4gPiA+Cj4gPiA+
Cj4gPiA+IE9yIGFib3V0IHNwbGl0LCBkbyB5b3UgaGF2ZSBhbnkgYmV0dGVyIHRob3VnaHRzPyBP
ciBkbyB5b3UgdGhpbmsgd2UgaGF2ZSBhbHdheXMKPiA+ID4gYmVlbiBsaWtlIHRoaXMgYW5kIG1h
a2UgVmlydGlvLU5ldCBtb3JlIGFuZCBtb3JlIGNvbXBsaWNhdGVkPwo+ID4KPiA+IE15IGZlZWxp
bmcgaXMgdGhhdCBtYXliZSBpdCdzIHdvcnRoIGl0IHRvIHN0YXJ0IHVzaW5nIGEgc2VwYXJhdGUg
ZmlsZQo+ID4gZm9yIHhzayBzdXBwb3J0Lgo+IAo+IEkgYWdyZWUuCj4gCj4gQE1pY2hhZWwgYXQg
dGhpcyBwb2ludCwgd2hhdCBpcyB5b3VyIHRob3VnaHQ/Cj4gCj4gCj4gVGhhbmtzLgo+IAoKSSBh
bSBmaW5lIHdpdGggZWl0aGVyIGFkZGluZyBqdXN0IHhzayBpbiBhIG5ldyBmaWxlIG9yIGV2ZW4K
anVzdCBhZGRpbmcgaW4gc2FtZSBmaWxlIHdvcmtpbmcgb24gYSBzcGxpdCBsYXRlci4KCgo+ID4K
PiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBYdWFuIFpodW8gKDE2KToKPiA+ID4gPiA+
ICAgdmlydGlvX25ldDogYWRkIGEgc2VwYXJhdGUgZGlyZWN0b3J5IGZvciB2aXJ0aW8tbmV0Cj4g
PiA+ID4gPiAgIHZpcnRpb19uZXQ6IG1vdmUgc3RydWN0IHRvIGhlYWRlciBmaWxlCj4gPiA+ID4g
PiAgIHZpcnRpb19uZXQ6IGFkZCBwcmVmaXggdG8gdGhlIHN0cnVjdCBpbnNpZGUgaGVhZGVyIGZp
bGUKPiA+ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGluZyBjcHUtcmVsYXRlZCBmdW5zCj4g
PiA+ID4gPiAgIHZpcnRpb19uZXQ6IHNlcGFyYXRlIHZpcnRuZXRfY3RybF9zZXRfcXVldWVzKCkK
PiA+ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGUgdmlydG5ldF9jdHJsX3NldF9tYWNfYWRk
cmVzcygpCj4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHJlbW92ZSBsb2NrIGZyb20gdmlydG5ldF9h
Y2tfbGlua19hbm5vdW5jZSgpCj4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHNlcGFyYXRpbmcgdGhl
IEFQSXMgb2YgY3EKPiA+ID4gPiA+ICAgdmlydGlvX25ldDogaW50cm9kdWNlIHZpcnRuZXRfcnFf
dXBkYXRlX3N0YXRzKCkKPiA+ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGluZyB0aGUgZnVu
Y3Mgb2YgZXRodG9vbAo+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiBpbnRyb2R1Y2UgdmlydG5ldF9k
ZXZfcnhfcXVldWVfZ3JvdXAoKQo+ID4gPiA+ID4gICB2aXJ0aW9fbmV0OiBpbnRyb2R1Y2Ugdmly
dG5ldF9nZXRfbmV0ZGV2KCkKPiA+ID4gPiA+ICAgdmlydGlvX25ldDogcHJlcGFyZSBmb3Igdmly
dGlvCj4gPiA+ID4gPiAgIHZpcnRpb19uZXQ6IG1vdmUgdmlydG5ldF9bZW4vZGlzXWFibGVfZGVs
YXllZF9yZWZpbGwgdG8gaGVhZGVyIGZpbGUKPiA+ID4gPiA+ICAgdmlydGlvX25ldDogYWRkIEFQ
SXMgdG8gcmVnaXN0ZXIvdW5yZWdpc3RlciB2aXJ0aW8gZHJpdmVyCj4gPiA+ID4gPiAgIHZpcnRp
b19uZXQ6IHNlcGFyYXRpbmcgdGhlIHZpcnRpbyBjb2RlCj4gPiA+ID4gPgo+ID4gPiA+ID4gIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKy0KPiA+
ID4gPiA+ICBkcml2ZXJzL25ldC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICA4ICstCj4gPiA+ID4gPiAgZHJpdmVycy9uZXQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgMiArLQo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICB8ICAgMTEgKwo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICB8ICAgMTAgKwo+ID4gPiA+ID4gIC4uLi9uZXQve3Zp
cnRpb19uZXQuYyA9PiB2aXJ0aW8vdmlydG5ldC5jfSAgICB8IDIzNjggKystLS0tLS0tLS0tLS0t
LS0KPiA+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydG5ldC5oICAgICAgICAgICAgICAg
ICAgfCAgMjEzICsrCj4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRuZXRfY29tbW9u
LmMgICAgICAgICAgIHwgIDEzOCArCj4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRu
ZXRfY29tbW9uLmggICAgICAgICAgIHwgICAxNCArCj4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmly
dGlvL3ZpcnRuZXRfY3RybC5jICAgICAgICAgICAgIHwgIDI3MiArKwo+ID4gPiA+ID4gIGRyaXZl
cnMvbmV0L3ZpcnRpby92aXJ0bmV0X2N0cmwuaCAgICAgICAgICAgICB8ICAgNDUgKwo+ID4gPiA+
ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2V0aHRvb2wuYyAgICAgICAgICB8ICA1Nzgg
KysrKwo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2V0aHRvb2wuaCAgICAg
ICAgICB8ICAgIDggKwo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X3ZpcnRp
by5jICAgICAgICAgICB8ICA4ODAgKysrKysrCj4gPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlv
L3ZpcnRuZXRfdmlydGlvLmggICAgICAgICAgIHwgICAgOCArCj4gPiA+ID4gPiAgMTUgZmlsZXMg
Y2hhbmdlZCwgMjM2NiBpbnNlcnRpb25zKCspLCAyMTkxIGRlbGV0aW9ucygtKQo+ID4gPiA+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vS2NvbmZpZwo+ID4gPiA+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vTWFrZWZpbGUKPiA+ID4gPiA+
ICByZW5hbWUgZHJpdmVycy9uZXQve3ZpcnRpb19uZXQuYyA9PiB2aXJ0aW8vdmlydG5ldC5jfSAo
NTAlKQo+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vdmly
dG5ldC5oCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby92
aXJ0bmV0X2NvbW1vbi5jCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0
L3ZpcnRpby92aXJ0bmV0X2NvbW1vbi5oCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2N0cmwuYwo+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vdmlydG5ldF9jdHJsLmgKPiA+ID4gPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRuZXRfZXRodG9vbC5jCj4gPiA+ID4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2V0aHRvb2wu
aAo+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vdmlydG5l
dF92aXJ0aW8uYwo+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0
aW8vdmlydG5ldF92aXJ0aW8uaAo+ID4gPiA+ID4KPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiAyLjMy
LjAuMy5nMDExOTVjZjlmCj4gPiA+ID4KPiA+ID4KPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0Cj4gPiBWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4gaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
