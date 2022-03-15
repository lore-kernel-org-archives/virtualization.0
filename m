Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03BCC433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 14:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7210C40A22;
	Tue, 15 Mar 2022 14:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blx-xCBJEcUS; Tue, 15 Mar 2022 14:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A2071400C9;
	Tue, 15 Mar 2022 14:53:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70433C001A;
	Tue, 15 Mar 2022 14:53:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D063C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C27681244
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-fK3P3EaEaU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:53:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3388E8139A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647356010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv+3ovGKwDTOrBOb0CBCSF9P9oG+MybmZmM71ErkNhE=;
 b=DbYjSLQZfuplAPrWEvO7EERSsCyDRewwLCKNkivjR74KUoCOuQKQ43wFNujFnYtHn/b08r
 dOehwXccKnyVPipokaZmOL7jcG54vXqHlrBVakikbzmRFL3ltLJmvoLTg3LTDuPwQW9iid
 CzfOn9lbDXxYU+Zk3j/JE8ApEsmP6C0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-eP_TaNakMZmZypzkp_lnOw-1; Tue, 15 Mar 2022 10:53:29 -0400
X-MC-Unique: eP_TaNakMZmZypzkp_lnOw-1
Received: by mail-wr1-f70.google.com with SMTP id
 9-20020adf8009000000b00203d6cb4c60so512760wrk.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 07:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vv+3ovGKwDTOrBOb0CBCSF9P9oG+MybmZmM71ErkNhE=;
 b=3VtUChVjDQK7+4XW++2CTaf+mGAmPXUvRMUw5MM8/y0JEu1TiI89otcFkDJV61q3C2
 exGGTqNRzIC0UX/bhAYwT3mDcGWYcNq0jZm//L4n1CYGroHrz+5fTbF/9aayAcm/4gIj
 bqaMy3Pd3JoV/c5A6vJvXLLbDqE3bAZHTjSOjhdA4yjUpx7notKwWNa0kbbnjIXJCWtV
 Ba2nEO34UDVUEc9eWfROxFOtfOzHX+JzNl7GLmmmRFW8zZ4lZRg3GINHpfYfGESCJ4kp
 E5z4e9DvmZQrykLoM3Wkc0GHLa8msFnDXUaVhgTRSv7GsS9RTDFzgtgQNxtfsuDOZ7tI
 R40Q==
X-Gm-Message-State: AOAM533crQbWsn0S6vV5jnyfdiwfUMdK5Hsw9Iz53bGRsywHYhcZJt27
 OOYcAeVGESSa0ksbTBI9IdE7xU35kPJV/szJE9e8sRfymz6MVWywpWSyQIKHH3OCCY44qcHM4Wq
 6Ur9NlPPC6LUSRhqUsh7vEEj3fFDyADHL795ERTFTxw==
X-Received: by 2002:a05:600c:4e94:b0:389:e900:5ba9 with SMTP id
 f20-20020a05600c4e9400b00389e9005ba9mr3786078wmq.166.1647356008374; 
 Tue, 15 Mar 2022 07:53:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNv0nAdQhLiCI3Puh8sIvNuqxUpLK8JinaItSHy7MtiHhOeNXZjQJTiNstvQh9XDren6dRkw==
X-Received: by 2002:a05:600c:4e94:b0:389:e900:5ba9 with SMTP id
 f20-20020a05600c4e9400b00389e9005ba9mr3786063wmq.166.1647356008149; 
 Tue, 15 Mar 2022 07:53:28 -0700 (PDT)
Received: from redhat.com ([2.53.2.35]) by smtp.gmail.com with ESMTPSA id
 n1-20020a5d5981000000b00203d8ea8c94sm1348768wri.84.2022.03.15.07.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 07:53:27 -0700 (PDT)
Date: Tue, 15 Mar 2022 10:53:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220315105155-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <YjCmBkjgtQZffiXw@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, pbonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBNYXIgMTUsIDIwMjIgYXQgMTE6NDM6MThQTSArMDkwMCwgU3V3YW4gS2ltIHdyb3Rl
Ogo+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDA0OjU5OjIzUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiBPbiBNb24sIE1hciAxNCwgMjAyMiBhdCA4OjMzIFBNIFN1d2FuIEtpbSA8c3V3
YW4ua2ltMDI3QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+ID4gT24gTW9uLCBNYXIgMTQsIDIw
MjIgYXQgMDI6MTQ6NTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPgo+ID4gPiA+
IOWcqCAyMDIyLzMvMTEg5LiL5Y2IMTE6MjgsIFN1d2FuIEtpbSDlhpnpgZM6Cj4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaAo+ID4gPiBiL2luY2x1
ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmgKPiA+ID4gPiA+IGluZGV4IGQ4ODhmMDEzZDlmZi4u
M2ZjYWY5MzdhZmUxIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19ibGsuaAo+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsu
aAo+ID4gPiA+ID4gQEAgLTExOSw4ICsxMTksOSBAQCBzdHJ1Y3QgdmlydGlvX2Jsa19jb25maWcg
ewo+ID4gPiA+ID4gICAgICAqIGRlYWxsb2NhdGlvbiBvZiBvbmUgb3IgbW9yZSBvZiB0aGUgc2Vj
dG9ycy4KPiA+ID4gPiA+ICAgICAgKi8KPiA+ID4gPiA+ICAgICBfX3U4IHdyaXRlX3plcm9lc19t
YXlfdW5tYXA7Cj4gPiA+ID4gPiArICAgX191OCB1bnVzZWQxOwo+ID4gPiA+ID4gLSAgIF9fdTgg
dW51c2VkMVszXTsKPiA+ID4gPiA+ICsgICBfX3ZpcnRpbzE2IG51bV9wb2xsX3F1ZXVlczsKPiA+
ID4gPiA+ICAgfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4gVGhpcyBsb29rcyBsaWtlIGEgaW1wbGVtZW50YXRpb24gc3BlY2lmaWMgKHZpcnRpby1ibGst
cGNpKSBvcHRpbWl6YXRpb24sCj4gPiA+IGhvdwo+ID4gPiA+IGFib3V0IG90aGVyIGltcGxlbWVu
dGF0aW9uIGxpa2Ugdmhvc3QtdXNlci1ibGs/Cj4gPiA+Cj4gPiA+IEkgZGlkbuKAmXQgY29uc2lk
ZXIgdmhvc3QtdXNlci1ibGsgeWV0LiBCdXQgZG9lcyB2aG9zdC11c2VyLWJsayBhbHNvCj4gPiA+
IHVzZSB2cml0aW9fYmxrX2NvbmZpZyBhcyBrZXJuZWwtcWVtdSBpbnRlcmZhY2U/Cj4gPiA+Cj4g
PiAKPiA+IFllcywgYnV0IHNlZSBiZWxvdy4KPiA+IAo+ID4gCj4gPiA+Cj4gPiA+IERvZXMgdmhv
c3QtdXNlci1ibGsgbmVlZCBhZGRpdGlvbmFsIG1vZGlmaWNhdGlvbiB0byBzdXBwb3J0IHBvbGxp
bmcKPiA+ID4gaW4ga2VybmVsIHNpZGU/Cj4gPiA+Cj4gPiAKPiA+IAo+ID4gTm8sIGJ1dCB0aGUg
aXNzdWUgaXMsIHRoaW5ncyBsaWtlIHBvbGxpbmcgbG9va3Mgbm90IGEgZ29vZCBjYW5kaWRhdGUg
Zm9yCj4gPiB0aGUgYXR0cmlidXRlcyBiZWxvbmdpbmcgdG8gdGhlIGRldmljZSBidXQgdGhlIGRy
aXZlci4gU28gSSBoYXZlIG1vcmUKPiA+IHF1ZXN0aW9uczoKPiA+IAo+ID4gMSkgd2hhdCBkb2Vz
IGl0IHJlYWxseSBtZWFuIGZvciBoYXJkd2FyZSB2aXJ0aW8gYmxvY2sgZGV2aWNlcz8KPiA+IDIp
IERvZXMgZHJpdmVyIHBvbGxpbmcgaGVscCBmb3IgdGhlIHFlbXUgaW1wbGVtZW50YXRpb24gd2l0
aG91dCBwb2xsaW5nPwo+ID4gMykgVXNpbmcgYmxrX2NvbmZpZyBtZWFucyB3ZSBjYW4gb25seSBn
ZXQgdGhlIGJlbmVmaXQgZnJvbSB0aGUgbmV3IGRldmljZQo+IAo+IDEpIHdoYXQgZG9lcyBpdCBy
ZWFsbHkgbWVhbiBmb3IgaGFyZHdhcmUgdmlydGlvIGJsb2NrIGRldmljZXM/Cj4gMykgVXNpbmcg
YmxrX2NvbmZpZyBtZWFucyB3ZSBjYW4gb25seSBnZXQgdGhlIGJlbmVmaXQgZnJvbSB0aGUgbmV3
IGRldmljZQo+IAo+IFRoaXMgcGF0Y2ggYWRkcyBkZWRpY2F0ZWQgSFcgcXVldWUgZm9yIHBvbGxp
bmcgcHVycG9zZSB0byB2aXJ0aW8KPiBibG9jayBkZXZpY2UuCj4gCj4gU28gSSB0aGluayBpdCBj
YW4gYmUgYSBuZXcgaHcgZmVhdHVyZS4gQW5kIGl0IGNhbiBiZSBhIG5ldyBkZXZpY2UKPiB0aGF0
IHN1cHBvcnRzIGh3IHBvbGwgcXVldWUuCj4gCj4gQlRXLCBJIGhhdmUgb3RoZXIgaWRlYSBhYm91
dCBpdC4KPiAKPiBIb3cgYWJvdXQgYWRkaW5nIOKAnG51bS1wb2xsLXF1ZXVlcyIgcHJvcGVydHkg
YXMgYSBkcml2ZXIgcGFyYW1ldGVyCj4gbGlrZSBOVk1lIGRyaXZlciwgbm90IHRvIFFFTVUgdmly
dGlvLWJsay1wY2kgcHJvcGVydHk/Cj4gCj4gSWYgdGhlbiwgd2UgZG9u4oCZdCBuZWVkIHRvIG1v
ZGlmeSB2aXJ0aW9fYmxrX2NvbmZpZy4KPiBBbmQgd2UgY2FuIGFwcGx5IHRoZSBwb2xsaW5nIGZl
YXR1cmUgb25seSB0byB2aXJ0aW8tYmxrLXBjaS4KPiBCdXQgY2FuIFFFTVUgcGFzcyDigJxudW0t
cG9sbC1xdWV1ZXMiIHRvIHZpcnRpby1ibGsgZHJpdmVyIHBhcmFtPwoKU2FtZSBhcyBhbnkgb3Ro
ZXIgZHJpdmVyIHBhcmFtZXRlciwgcGFzcyBpdCBvbiBrZXJuZWwgY29tbWFuZCBsaW5lLgoKPiAK
PiAKPiAyKSBEb2VzIGRyaXZlciBwb2xsaW5nIGhlbHAgZm9yIHRoZSBxZW11IGltcGxlbWVudGF0
aW9uIHdpdGhvdXQgcG9sbGluZz8KPiAKPiBTb3JyeSwgSSBkaWRuJ3QgdW5kZXJzdGFuZCB5b3Vy
IHF1ZXN0aW9uLiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gbW9yZSBhYm91dD8KPiAKPiBSZWdh
cmRzLAo+IFN1d2FuIEtpbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
