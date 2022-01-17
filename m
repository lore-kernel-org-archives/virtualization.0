Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DFDC433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 21:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D842D40493;
	Mon, 17 Jan 2022 21:45:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rmach6-8FTj9; Mon, 17 Jan 2022 21:45:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A854403EC;
	Mon, 17 Jan 2022 21:44:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CF0AC0039;
	Mon, 17 Jan 2022 21:44:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D500C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 21:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DD1C60A78
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 21:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fsk1QOa8R3Ma
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 21:44:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7587D600CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 21:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642455894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CyA4F2l4Ga8KW0MgR+7KYufjdXJ2AvOgHyksYubBhw=;
 b=JcTpW353ACewlfGk0AXeiodWUjaI1Ru2vfp1UnCeUQYYYM26c4TvJK3YYKy9raj/HjBjiP
 JID4CDBfedDyv7UhpC/FE/6HTfflNffVYuKNhRNO5M6XsuTbOuMrzzXHDHHm3uMi0PPgfn
 6gJ2JZRZzzX0uGwM3eZ8gg/iwKPq+cQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-Tyzgpj92OEmPX_zsmCBrag-1; Mon, 17 Jan 2022 16:44:53 -0500
X-MC-Unique: Tyzgpj92OEmPX_zsmCBrag-1
Received: by mail-ed1-f69.google.com with SMTP id
 ee53-20020a056402293500b004022f34edcbso4478163edb.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 13:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0CyA4F2l4Ga8KW0MgR+7KYufjdXJ2AvOgHyksYubBhw=;
 b=yfheNZ/9U8xoncZgihcYq+4XCyTJfm9JHS/rDEPII2cVwiTaOpS50WUAmdSXxor7l/
 1/NHzVynr2O903C3Qu0wwe414xqfDy/J8k03+/o6+USO/ySk53EA5el7V87Ya9ORKDFf
 /6TqDV5AlcwbOjFCK5ZkYvJHtjX5OnX91NqwIPWHZ70Sg3qQYO7JtzbLEMkTnG/UNxUo
 4T3XF4tCEBfjBUUNRCCKCqAXPHPG2Yn0aMK2l3s4tqLIdlry6q7ezWAdv7J6hNd/PEdX
 Hp5+MhG4TbE702kLTstjKaHniDmedzAxvmVTOv0X+P9uiMy3ybkUBv3cO9qjpTmsowfy
 XSTg==
X-Gm-Message-State: AOAM530CYb5sFe3iUwHihcYMiBcOUZ/smYiHGUnKDcT9TQDtNNdtgdh5
 ZpSWdr6Lx8oMOSJggsyNpUhXoJ76Hka/bnHIWYLEAlGHkNVWdHo/u7Fh3FjfEPw3S+7rD4zfNhY
 eeqb71DQHOl2/cz/sFo7O5zbKlpi6yJKtvjtKjQKYww==
X-Received: by 2002:a17:907:62a3:: with SMTP id
 nd35mr18836052ejc.650.1642455892080; 
 Mon, 17 Jan 2022 13:44:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/if0AA69UEdFPdjv36EaSPlb3X89ozwxa4kaHHPL/Xm4Ik082CAGiBTzwK/mjl2j6tlWgLw==
X-Received: by 2002:a17:907:62a3:: with SMTP id
 nd35mr18836030ejc.650.1642455891787; 
 Mon, 17 Jan 2022 13:44:51 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id s16sm6331099edt.30.2022.01.17.13.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 13:44:48 -0800 (PST)
Date: Mon, 17 Jan 2022 16:44:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_mem: break device on remove
Message-ID: <20220117164427-mutt-send-email-mst@kernel.org>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
 <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
 <20220117033644-mutt-send-email-mst@kernel.org>
 <44f4ee97-562c-ce37-a5af-9f58e052f3a9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <44f4ee97-562c-ce37-a5af-9f58e052f3a9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMTE6MjU6MTJBTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6Cj4gT24gMTcuMDEuMjIgMDk6NDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
PiA+IE9uIE1vbiwgSmFuIDE3LCAyMDIyIGF0IDA5OjMxOjU2QU0gKzAxMDAsIERhdmlkIEhpbGRl
bmJyYW5kIHdyb3RlOgo+ID4+IE9uIDE3LjAxLjIyIDA4OjU1LCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4gPj4+IE9uIE1vbiwgSmFuIDE3LCAyMDIyIGF0IDAyOjQwOjExUE0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPj4+Pgo+ID4+Pj4g5ZyoIDIwMjIvMS8xNSDkuIrljYg1OjQzLCBN
aWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4+Pj4+IEEgY29tbW9uIHBhdHRlcm4gZm9yIGRl
dmljZSByZXNldCBpcyBjdXJyZW50bHk6Cj4gPj4+Pj4gdmRldi0+Y29uZmlnLT5yZXNldCh2ZGV2
KTsKPiA+Pj4+PiAuLiBjbGVhbnVwIC4uCj4gPj4+Pj4KPiA+Pj4+PiByZXNldCBwcmV2ZW50cyBu
ZXcgaW50ZXJydXB0cyBmcm9tIGFycml2aW5nIGFuZCB3YWl0cyBmb3IgaW50ZXJydXB0Cj4gPj4+
Pj4gaGFuZGxlcnMgdG8gZmluaXNoLgo+ID4+Pj4+Cj4gPj4+Pj4gSG93ZXZlciBpZiAtIGFzIGlz
IGNvbW1vbiAtIHRoZSBoYW5kbGVyIHF1ZXVlcyBhIHdvcmsgcmVxdWVzdCB3aGljaCBpcwo+ID4+
Pj4+IGZsdXNoZWQgZHVyaW5nIHRoZSBjbGVhbnVwIHN0YWdlLCB3ZSBoYXZlIGNvZGUgYWRkaW5n
IGJ1ZmZlcnMgLyB0cnlpbmcKPiA+Pj4+PiB0byBnZXQgYnVmZmVycyB3aGlsZSBkZXZpY2UgaXMg
cmVzZXQuIE5vdCBnb29kLgo+ID4+Pj4+Cj4gPj4+Pj4gVGhpcyB3YXMgcmVwcm9kdWNlZCBieSBy
dW5uaW5nCj4gPj4+Pj4gCW1vZHByb2JlIHZpcnRpb19jb25zb2xlCj4gPj4+Pj4gCW1vZHByb2Jl
IC1yIHZpcnRpb19jb25zb2xlCj4gPj4+Pj4gaW4gYSBsb29wLCBhbmQgdGhpcyByZWFzb25pbmcg
c2VlbXMgdG8gYXBwbHkgdG8gdmlydGlvIG1lbSB0aG91Z2gKPiA+Pj4+PiBJIGNvdWxkIG5vdCBy
ZXByb2R1Y2UgaXQgdGhlcmUuCj4gPj4+Pj4KPiA+Pj4+PiBGaXggdGhpcyB1cCBieSBjYWxsaW5n
IHZpcnRpb19icmVha19kZXZpY2UgKyBmbHVzaCBiZWZvcmUgcmVzZXQuCj4gPj4+Pj4KPiA+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4+
Pj4+IC0tLQo+ID4+Pj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jIHwgMiArKwo+ID4+
Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4+Pj4+Cj4gPj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYyBiL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19tZW0uYwo+ID4+Pj4+IGluZGV4IDM4YmVjZDhkNTc4Yy4uMzNiOGExMThhM2FlIDEwMDY0
NAo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYwo+ID4+Pj4+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYwo+ID4+Pj4+IEBAIC0yODg4LDYgKzI4ODgsOCBA
QCBzdGF0aWMgdm9pZCB2aXJ0aW9fbWVtX3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
dikKPiA+Pj4+PiAgIAkJdmlydGlvX21lbV9kZWluaXRfaG90cGx1Zyh2bSk7Cj4gPj4+Pj4gICAJ
LyogcmVzZXQgdGhlIGRldmljZSBhbmQgY2xlYW51cCB0aGUgcXVldWVzICovCj4gPj4+Pj4gKwl2
aXJ0aW9fYnJlYWtfZGV2aWNlKHZkZXYpOwo+ID4+Pj4+ICsJZmx1c2hfd29yaygmdm0tPndxKTsK
PiA+Pj4+Cj4gPj4+Pgo+ID4+Pj4gV2Ugc2V0IHZtLT5yZW1vdmluZyB0byB0cnVlIGFuZCBjYWxs
IGNhbmNlbF93b3JrX3N5bmMoKSBpbgo+ID4+Pj4gdmlydGlvX21lbV9kZWluaXRfaG90cGx1Zygp
LiBJc24ndCBpcyBzdWZmaWNpZW50Pwo+ID4+Pj4KPiA+Pj4+IFRoYW5rcwo+ID4+Pgo+ID4+Pgo+
ID4+PiBIbW0gSSB0aGluayB5b3UgYXJlIHJpZ2h0LiBEYXZpZCwgSSB3aWxsIGRyb3AgdGhpcyBm
b3Igbm93Lgo+ID4+PiBVcCB0byB5b3UgdG8gY29uc2lkZXIgd2hldGhlciBzb21lIGNlbnRyYWwg
Y2FwYWJpbGl0eSB3aWxsIGJlCj4gPj4+IGhlbHBmdWwgYXMgYSByZXBsYWNlbWVudCBmb3IgdGhl
IHZpcnRpby1tZW0gc3BlY2lmaWMgInJlbW92aW5nIiBmbGFnLgo+ID4+Cj4gPj4gSXQncyBhbGwg
YSBiaXQgdHJpY2t5IGJlY2F1c2Ugd2UgYWxzbyBoYXZlIHRvIGhhbmRsZSBwZW5kaW5nIHRpbWVy
cyBhbmQKPiA+PiBwZW5kaW5nIG1lbW9yeSBvbmxpbmluZy9vZmZsaW5pbmcgb3BlcmF0aW9ucyBp
biBhIGNvbnRyb2xsZWQgd2F5LiBNYXliZQo+ID4+IHdlIGNvdWxkIGNvbnZlcnQgdG8gdmlydGlv
X2JyZWFrX2RldmljZSgpIGFuZCB1c2UgdGhlCj4gPj4gJmRldi0+dnFzX2xpc3RfbG9jayBhcyBh
IHJlcGxhY2VtZW50IGZvciB0aGUgcmVtb3ZhbF9sb2NrLiBIb3dldmVyLCBJJ20KPiA+PiBub3Qg
MTAwJSBzdXJlIGlmIGl0J3MgbmljZSB0byB1c2UgdGhhdCBsb2NrIGZyb20KPiA+PiBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fbWVtLmMgZGlyZWN0bHkuCj4gPiAKPiA+IFdlIGNvdWxkIGFkZCBhbiBB
UEkgaWYgeW91IGxpa2UuIE9yIG1heWJlIGl0IG1ha2VzIHNlbnNlIHRvIGFkZCBhCj4gPiBzZXBh
cmF0ZSBvbmUgdGhhdCBsZXRzIHlvdSBmaW5kIG91dCB0aGF0IHJlbW92YWwgc3RhcnRlZC4gTmVl
ZCB0byBmaWd1cmUKPiA+IG91dCBob3cgdG8gaGFuZGxlIHN1c3BlbmQgdG9vIHRoZW4gLi4uCj4g
PiBHZW5lcmFsbHkgd2UgaGF2ZSB0aGVzZSBjaGVja3MgdGhhdCBkZXZpY2UgaXMgbm90IGdvaW5n
IGF3YXkKPiA+IHNwcmlua2xlZCBvdmVyIGFsbCBkcml2ZXJzIGFuZCBJIGRvbid0IGxpa2UgaXQs
IGJ1dAo+ID4gaXQncyBub3QgZWFzeSB0byBidWlsZCBhIHNhbmUgQVBJIHRvIGhhbmRsZSBpdCwg
ZXNwZWNpYWxseQo+ID4gZm9yIGhpZ2ggc3BlZWQgdGhpbmdzIHdoZW4gd2UgY2FuJ3QgdGFrZSBs
b2NrcyBiZWNhdXNlIHBlcmZvcm1hbmNlLgo+IAo+IFRoZSBpbnRlcmVzdGluZyBjYXNlIG1pZ2h0
IGJlIGhvdyB0byBoYW5kbGUgdmlydGlvX21lbV9yZXRyeSgpLCB3aGVyZWJ5Cj4gd2UgY29uZGl0
aW9uYWxseSBxdWV1ZSB3b3JrIGlmICFyZW1vdmluZy4KPiAKPiBIYXZpbmcgdGhhdCBzYWlkLCBp
biBhbiBpZGVhbCB3b3JsZCB3ZSBjb3VsZCBkZW55IHJlbW92YWwgcmVxdWVzdHMgZm9yCj4gdmly
dGlvX21lbSBjb21wbGV0ZWx5IGlmIHRoZXJlIGlzIHN0aWxsIGFueSBtZW1vcnkgYWRkZWQgdG8g
dGhlIHN5c3RlbSAuLi4KPiAKPiAKPiAtLSAKPiBUaGFua3MsCj4gCj4gRGF2aWQgLyBkaGlsZGVu
YgoKCnJlbW92YWwgcmVxdWVzdHMgbWlnaHQgY29tZSBmcm9tIGd1ZXN0IGFkbWluLgoKLS0gCk1T
VAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
