Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FEAE95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 10:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 567A740134;
	Mon,  9 Oct 2023 10:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 567A740134
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H3h789HK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTICzmXHWu1b; Mon,  9 Oct 2023 10:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BCCEE4026F;
	Mon,  9 Oct 2023 10:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCCEE4026F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8958AC0071;
	Mon,  9 Oct 2023 10:52:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEF76C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6AC081EC6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6AC081EC6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H3h789HK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DVW3rc6KrRsN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:52:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C056381327
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:52:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C056381327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696848761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjiO4Hvw+fsOPZZWLwNP0lglpX+bcklExOuRO6AMksY=;
 b=H3h789HK7duTEvHL78Xk4XnbQOuBu6axCQyRI2B+cAfT3y78VMJUBd70/uVMO5kWkEJYul
 UjuUnO/GJOqxqd1DG4Q4ejs2NKhou6IaCurgD3qh6kApHS8B8troCugWo0AMg2AJr4YEqf
 ITrra3M0bJ2TV9WjvKRnrOTT45xXkBU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-XjvFutTqPzWd3-vEHEQSdA-1; Mon, 09 Oct 2023 06:52:39 -0400
X-MC-Unique: XjvFutTqPzWd3-vEHEQSdA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4067f186039so33399925e9.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 03:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696848758; x=1697453558;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HjiO4Hvw+fsOPZZWLwNP0lglpX+bcklExOuRO6AMksY=;
 b=LF0axTIa69rvLS1wIRVEu+HdaQn8+qX56Hnqu8igpHmAPXevH3RTnndtmXC4ujJcFc
 xnP75Ab48x/rmauN37z61WAz8BHVlbrX32BssYd7WBOPGGpajpviAm9iGP2Q1nyxHb6O
 /gu6BIwRXss0kK8sozviN4MS9dwYcldiSxG4xQkCHKzSdsfojkpTEip7i0/zXU7091Ez
 G224Hso7RcU2YJ6JAVoFwhIB8EAEwCwQUKRW2tnrHf0njozqRjkSbDJWlDPaiGUhuKaB
 q4Ndv88nF3wBsklK/V11zCpcTb6xMrWBzDllqLYE2XSS5P8yMAjyLCaJljEFO72jGnqM
 fDTw==
X-Gm-Message-State: AOJu0YwzgRTOw8KsEIx0EF0MZIT46iwwU2ce+HOlI9llBqFO3B3XB1f9
 yoeNP1CtQ4Q7Sv/+m2AiSG9s1mOHEDWOyuCaUwILK1eOv/zf6PuA2Ir8RWnKjD8owzGim7klrJf
 3+lKXXJNKujkUbBQyRgJgfAgotkYlIA/STmlsMRM41w==
X-Received: by 2002:a7b:cd8e:0:b0:405:3a3d:6f53 with SMTP id
 y14-20020a7bcd8e000000b004053a3d6f53mr12910444wmj.3.1696848758034; 
 Mon, 09 Oct 2023 03:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgWahkpsmLf/aOwZysFtiHkjovc5aRAyJtzXWyUzsNyUbJBrMocRm41ehhlwu8cg3xsXBpvA==
X-Received: by 2002:a7b:cd8e:0:b0:405:3a3d:6f53 with SMTP id
 y14-20020a7bcd8e000000b004053a3d6f53mr12910428wmj.3.1696848757617; 
 Mon, 09 Oct 2023 03:52:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5caf:857a:f352:c1fc:cf50])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a056000110300b0031c6581d55esm9224958wrw.91.2023.10.09.03.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 03:52:36 -0700 (PDT)
Date: Mon, 9 Oct 2023 06:52:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liming Wu <liming.wu@jaguarmicro.com>
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
Message-ID: <20231009063735-mutt-send-email-mst@kernel.org>
References: <20230926050021.717-1-liming.wu@jaguarmicro.com>
 <20230926050021.717-2-liming.wu@jaguarmicro.com>
 <CACGkMEujvBtAx=1eTqSrzyjBde=0xpC9D0sRVC7wHHf_aqfqwg@mail.gmail.com>
 <PSAPR06MB3942238B1D7218934A2BB8B4E1CEA@PSAPR06MB3942.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PSAPR06MB3942238B1D7218934A2BB8B4E1CEA@PSAPR06MB3942.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "398776277@qq.com" <398776277@qq.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBPY3QgMDksIDIwMjMgYXQgMDI6NDQ6NTVBTSArMDAwMCwgTGltaW5nIFd1IHdyb3Rl
Ogo+IAo+IAo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgOCwgMjAy
MyAxMjozNiBQTQo+ID4gVG86IExpbWluZyBXdSA8bGltaW5nLnd1QGphZ3Vhcm1pY3JvLmNvbT4K
PiA+IENjOiBNaWNoYWVsIFMgLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IGt2bUB2Z2VyLmtl
cm5lbC5vcmc7Cj4gPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyAzOTg3NzYyNzdAcXEuY29tCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gdG9vbHMvdmly
dGlvOiBBZGQgaGludHMgd2hlbiBtb2R1bGUgaXMgbm90IGluc3RhbGxlZAo+ID4gCj4gPiBPbiBU
dWUsIFNlcCAyNiwgMjAyMyBhdCAxOjAw4oCvUE0gPGxpbWluZy53dUBqYWd1YXJtaWNyby5jb20+
IHdyb3RlOgo+ID4gPgo+ID4gPiBGcm9tOiBMaW1pbmcgV3UgPGxpbWluZy53dUBqYWd1YXJtaWNy
by5jb20+Cj4gPiA+Cj4gPiA+IE5lZWQgdG8gaW5zbW9kIHZob3N0X3Rlc3Qua28gYmVmb3JlIHJ1
biB2aXJ0aW9fdGVzdC4KPiA+ID4gR2l2ZSBzb21lIGhpbnRzIHRvIHVzZXJzLgo+ID4gPgo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgV3UgPGxpbWluZy53dUBqYWd1YXJtaWNyby5jb20+Cj4g
PiA+IC0tLQo+ID4gPiAgdG9vbHMvdmlydGlvL3ZpcnRpb190ZXN0LmMgfCA0ICsrKysKPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3ZpcnRpby92aXJ0aW9fdGVzdC5jIGIvdG9vbHMvdmlydGlvL3ZpcnRpb190ZXN0LmMK
PiA+ID4gaW5kZXggMDI4ZjU0ZTY4NTRhLi5jZTJjNGQ5M2Q3MzUgMTAwNjQ0Cj4gPiA+IC0tLSBh
L3Rvb2xzL3ZpcnRpby92aXJ0aW9fdGVzdC5jCj4gPiA+ICsrKyBiL3Rvb2xzL3ZpcnRpby92aXJ0
aW9fdGVzdC5jCj4gPiA+IEBAIC0xMzUsNiArMTM1LDEwIEBAIHN0YXRpYyB2b2lkIHZkZXZfaW5m
b19pbml0KHN0cnVjdCB2ZGV2X2luZm8qIGRldiwKPiA+IHVuc2lnbmVkIGxvbmcgbG9uZyBmZWF0
dXJlcykKPiA+ID4gICAgICAgICBkZXYtPmJ1ZiA9IG1hbGxvYyhkZXYtPmJ1Zl9zaXplKTsKPiA+
ID4gICAgICAgICBhc3NlcnQoZGV2LT5idWYpOwo+ID4gPiAgICAgICAgIGRldi0+Y29udHJvbCA9
IG9wZW4oIi9kZXYvdmhvc3QtdGVzdCIsIE9fUkRXUik7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICBp
ZiAoZGV2LT5jb250cm9sIDwgMCkKPiA+ID4gKyAgICAgICAgICAgICAgIGZwcmludGYoc3RkZXJy
LCAiSW5zdGFsbCB2aG9zdF90ZXN0IG1vZHVsZSIgXAo+ID4gPiArICAgICAgICAgICAgICAgIigu
L3Zob3N0X3Rlc3Qvdmhvc3RfdGVzdC5rbykgZmlyc3RseVxuIik7Cj4gPiAKPiA+IFRoZXJlIHNo
b3VsZCBiZSBtYW55IG90aGVyIHJlYXNvbnMgdG8gZmFpbCBmb3Igb3BlbigpLgo+ID4gCj4gPiBM
ZXQncyB1c2Ugc3RyZXJyb3IoKT8KPiBZZXMsICBUaGFua3MgZm9yIHRoZSByZXZpZXcuIAo+IFBs
ZWFzZSByZWNoZWNrZWQgdGhlIGNvZGUgYXMgZm9sbG93Ogo+IC0tLSBhL3Rvb2xzL3ZpcnRpby92
aXJ0aW9fdGVzdC5jCj4gKysrIGIvdG9vbHMvdmlydGlvL3ZpcnRpb190ZXN0LmMKPiBAQCAtMTM1
LDYgKzEzNSwxMSBAQCBzdGF0aWMgdm9pZCB2ZGV2X2luZm9faW5pdChzdHJ1Y3QgdmRldl9pbmZv
KiBkZXYsIHVuc2lnbmVkIGxvbmcgbG9uZyBmZWF0dXJlcykKPiAgICAgICAgIGRldi0+YnVmID0g
bWFsbG9jKGRldi0+YnVmX3NpemUpOwo+ICAgICAgICAgYXNzZXJ0KGRldi0+YnVmKTsKPiAgICAg
ICAgIGRldi0+Y29udHJvbCA9IG9wZW4oIi9kZXYvdmhvc3QtdGVzdCIsIE9fUkRXUik7Cj4gKwo+
ICsgICAgICAgaWYgKGRldi0+Y29udHJvbCA9PSBOVUxMKQoKCj8/PwpXaHkgYXJlIHlvdSBjb21w
YXJpbmcgYSBmaWxlIGRlc2NyaXB0b3IgdG8gTlVMTD8KCj4gKyAgICAgICAgICAgICAgIGZwcmlu
dGYoc3RkZXJyLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICIlczogQ2hlY2sgd2hldGhlciB2
aG9zdF90ZXN0LmtvIGlzIGluc3RhbGxlZC5cbiIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
c3RyZXJyb3IoZXJybm8pKTsKCgpObywgZG8gbm90IHN1Z2dlc3QgY2hlY2tpbmcgdW5jb25kaXRp
b25hbGx5IHRoaXMgaXMganVzdCB3YXN0aW5nIHVzZXIncwp0aW1lLiAgWW91IHdvdWxkIGhhdmUg
dG8gY2hlY2sgdGhlIGV4YWN0IGVycm5vIHZhbHVlLiBZb3Ugd2lsbCBlaXRoZXIKZ2V0IEVOT0VO
VCBvciBFTk9ERVYgaWYgbW9kdWxlIGlzIG5vdCBsb2FkZWQuIE90aGVyIGVycm9ycyBpbmRpY2F0
ZQpvdGhlciBwcm9ibGVtcy4gIEFuZCB3aGF0IG1hdHRlcnMgaXMgd2hldGhlciBpdCdzIGxvYWRl
ZCwgbm90IGluc3RhbGxlZAotIHZob3N0X3Rlc3Qua28gd2lsbCBub3QgZ2V0IGF1dG8tbG9hZGVk
IGV2ZW4gaWYgaW5zdGFsbGVkLgoKCj4gICAgICAgICBhc3NlcnQoZGV2LT5jb250cm9sID49IDAp
Owo+ICAgICAgICAgciA9IGlvY3RsKGRldi0+Y29udHJvbCwgVkhPU1RfU0VUX09XTkVSLCBOVUxM
KTsKPiAgICAgICAgIGFzc2VydChyID49IDApOwo+ICAKPiBUaGFua3MKPiAKCkluIHNob3J0LCBJ
IGFtIG5vdCBhcHBseWluZyB0aGlzIHBhdGNoLiBJZiB5b3UgcmVhbGx5IHdhbnQgdG8gbWFrZQp0
aGluZ3MgYSBiaXQgZWFzaWVyIGluIGNhc2Ugb2YgZXJyb3JzLCByZXBsYWNlIGFsbCBhc3NlcnQg
ciA+PSAwIHdpdGgKYSBtYWNybyB0aGF0IHByaW50cyBvdXQgc3RyZXJyb3IoZXJybm8pLCB0aGF0
IHNob3VsZCBiZSBlbm91Z2guCk1heWJlIHByaW50IGZpbGUvbGluZSBudW1iZXIgdG9vIHdoaWxl
IHdlIGFyZSBhdCBpdC4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
