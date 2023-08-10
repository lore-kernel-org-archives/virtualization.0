Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8CAC001E0
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 19:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B95D383FB4;
	Thu, 10 Aug 2023 19:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B95D383FB4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGf3OcNT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mriNNUJ7WE5v; Thu, 10 Aug 2023 19:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4476883F9D;
	Thu, 10 Aug 2023 19:41:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4476883F9D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13059C0071;
	Thu, 10 Aug 2023 19:41:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1E57C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96DFF409AD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96DFF409AD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGf3OcNT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9hWCI3tBjaa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:41:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D62F04071B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:41:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D62F04071B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691696491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjLGJi3RZ2FKk2d3ScuHRczD0+DLJgOXpSTBakwEXCY=;
 b=hGf3OcNTpyuxn9Vj00C+u7E5W6NJXthXoOWqcU1NU0PXxxsuK4uz63sPIo/Pq+P1MWAaJO
 8uGFhQXotNbVoOqpZewNhCIivNFVnMs97xmO2Xb7E+34N+scoyXJ0dTLz+WdBUAqD1vnXK
 wrzc0ObT3VV1nNd6jvAO7f9uBabO/h4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-jNNYcIY-MLSJs7RKzz7BoQ-1; Thu, 10 Aug 2023 15:41:28 -0400
X-MC-Unique: jNNYcIY-MLSJs7RKzz7BoQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe4bda379fso8355585e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691696487; x=1692301287;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjLGJi3RZ2FKk2d3ScuHRczD0+DLJgOXpSTBakwEXCY=;
 b=MNCvi1GY7k5tCELyAwolR5wfC/5qC6XydZA/Hd231rPndFvCNeCa3k8gap6rogupN6
 Xr+QI88OqfI/AJXElhLp3y0QNxl2GJmK5aoo10YwDtWMCsoYYSxcdBK/QLiO08qHDsZa
 Hlx9eYQgzawcPOKJMenQoDrQVh6zUP+iTLIWz8uUA6kYHmHTvFa4O4BOvm5QgWQdqClH
 hPivLzfDwO74KOXvXnkGOqauPn6wjhkhqtmd4i1ZcVZh+y+p+r+B7thKbyuYLjfhEeFP
 H6bG2rov6ZZY3eF2C/k5Y3W9Xw3DdWsFZJJB/pUjwsTOaE7yN8tK6M9Qp05DQy78LKaa
 PmjA==
X-Gm-Message-State: AOJu0Yx2g+XgFuYHQ9mTEqsGoBfHi1d9zJXahbePBgOKrrnu4qyHCli2
 flnSJc2akaOUivW9OlIGJmyCDJ4C3HccfWH0jXy8SPXgjkY/Qc7c+EBfIB6/uMV7Vkxkvz5njb+
 FRbvc0QXGoY2DOQFt5rtxb+XzvP3OAfwABgGlBP0BMA==
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id
 v22-20020a1cf716000000b003fc009273d6mr2740464wmh.11.1691696487031; 
 Thu, 10 Aug 2023 12:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1U/nfcisU1GAe+gXcGkGEXKKOPDNR8Kh/fdNV5Dl10o59b7VmDZSZgwpMeakhNHq8pJgijA==
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id
 v22-20020a1cf716000000b003fc009273d6mr2740454wmh.11.1691696486695; 
 Thu, 10 Aug 2023 12:41:26 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6102000000b003141e629cb6sm3022146wrt.101.2023.08.10.12.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 12:41:25 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:41:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230810153744-mutt-send-email-mst@kernel.org>
References: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMTA6MzA6NTZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIEp1bCAzMSwgMjAyMyBhdCAyOjMw4oCvUE0gSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0
NuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCAwNDo1OTozM1BNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+ID4gVGhleSByZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRh
a2VzIGZvcmV2ZXIgdG8KPiA+ID4gPiA+IHByb2dyYW0gd2lsbCBjcmVhdGUgaXNzdWVzIGluIHRo
ZSBuZXR3b3JraW5nIHN0YWNrLgo+ID4gPiA+Cj4gPiA+ID4gVW5mb3J0dW5hdGVseSwgaXQncyBu
b3QgcmFyZSBhcyB0aGUgZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRlZAo+ID4gPiA+IHZp
YSBmaXJtd2FyZSBvciBzb2Z0d2FyZS4KPiA+ID4KPiA+ID4gQ3VycmVudGx5IHRoYXQgbWVhbiBv
bmUgZWl0aGVyIGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+ID4gPiBj
YW4gbWVldCBkZWFkbGluZXMsIG9yIGxvc2VzIGFiaWxpdHkgdG8gcmVwb3J0IGVycm9ycyBiYWNr
Lgo+ID4gPgo+ID4gPiA+ID4gQnV0IGlmIHRoZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlz
IGZsYWcgdG9vLgo+ID4gPiA+Cj4gPiA+ID4gVGhpcyBtYXkgaGF2ZSBmYWxzZSBuZWdhdGl2ZXMg
YW5kIG1heSBjb25mdXNlIHRoZSBtYW5hZ2VtZW50Lgo+ID4gPiA+Cj4gPiA+ID4gTWF5YmUgd2Ug
Y2FuIGV4dGVuZCB0aGUgbmV0d29ya2luZyBjb3JlIHRvIGFsbG93IHNvbWUgZGV2aWNlIHNwZWNp
ZmljCj4gPiA+ID4gY29uZmlndXJhdGlvbnMgdG8gYmUgZG9uZSB3aXRoIGRldmljZSBzcGVjaWZp
YyBsb2NrIHdpdGhvdXQgcnRubC4gRm9yCj4gPiA+ID4gZXhhbXBsZSwgc3BsaXQgdGhlIHNldF9j
aGFubmVscyB0bwo+ID4gPiA+Cj4gPiA+ID4gcHJlX3NldF9jaGFubmVscwo+ID4gPiA+IHNldF9j
aGFubmVscwo+ID4gPiA+IHBvc3Rfc2V0X2NoYW5uZWxzCj4gPiA+ID4KPiA+ID4gPiBUaGUgZGV2
aWNlIHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qgd2l0aG91dCBh
IHJ0bmwgbG9jaz8KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPgo+ID4gPiBXb3Vs
ZCB0aGUgYmVuZWZpdCBiZSB0aGF0IGVycm9ycyBjYW4gYmUgcmVwb3J0ZWQgdG8gdXNlcnNwYWNl
IHRoZW4/Cj4gPiA+IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8gc2hvdyBo
b3cgdGhpcyB3b3JrcyBmb3IgYXQgbGVhc3QKPiA+ID4gb25lIGNhcmQgYmVzaWRlcyB2aXJ0aW8u
Cj4gPgo+ID4gRXZlbiBmb3IgdmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhl
Cj4gPiB2aXJ0bmV0X3NlbmRfY29tbWFuZCgpIGFuZCBuZXRpZl9zZXRfcmVhbF9udW1fdHhfcXVl
dWVzKCkgbmVlZCB0bwo+ID4gYXBwZWFyIHRvIGJlIGF0b21pYyB0byB0aGUgbmV0d29ya2luZyBj
b3JlLgo+ID4KPiA+IEkgd29uZGVyIGlmIHdlIGNhbiByZS1jb25zaWRlciB0aGUgd2F5IG9mIGEg
dGltZW91dCBoZXJlIGFuZCBjaG9vc2UgYQo+ID4gc2FuZSB2YWx1ZSBhcyBhIHN0YXJ0Lgo+IAo+
IE1pY2hhZWwsIGFueSBtb3JlIGlucHV0IG9uIHRoaXM/Cj4gCj4gVGhhbmtzCgpJIHRoaW5rIHRo
aXMgaXMganVzdCBtaXNzaW9uIGNyZWVwLiBXZSBhcmUgdHJ5aW5nIHRvIGZpeAp2ZHVzZSAtIGxl
dCdzIGRvIHRoYXQgZm9yIHN0YXJ0ZXJzLgoKUmVjb3ZlcmluZyBmcm9tIGZpcm13YXJlIHRpbWVv
dXRzIGlzIGZhciBmcm9tIHRyaXZpYWwgYW5kCmp1c3QgYXNzdW1pbmcgdGhhdCBqdXN0IGJlY2F1
c2UgaXQgdGltZWQgb3V0IGl0IHdpbGwgbm90CmFjY2VzcyBtZW1vcnkgaXMganVzdCBhcyBsaWtl
bHkgdG8gY2F1c2UgbWVtb3J5IGNvcnJ1cHRpb24Kd2l0aCB3b3JzZSByZXN1bHRzIHRoYW4gYW4g
aW5maW5pdGUgc3Bpbi4KCkkgcHJvcG9zZSB3ZSBmaXggdGhpcyBmb3IgdmR1c2UgYW5kIGFzc3Vt
ZSBoYXJkd2FyZS9maXJtd2FyZQppcyB3ZWxsIGJlaGF2ZWQuIE9yIG1heWJlIG5vdCB3ZWxsIGJl
aGF2ZWQgZmlybXdhcmUgd2lsbApzZXQgdGhlIGZsYWcgbG9zaW5nIGVycm9yIHJlcG9ydGluZyBh
YmlsaXR5LgoKCgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4KPiA+ID4gLS0KPiA+ID4g
TVNUCj4gPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
