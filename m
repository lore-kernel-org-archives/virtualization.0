Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75476C07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 17:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB6D24010D;
	Tue, 27 Sep 2022 17:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB6D24010D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMkO5OCa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wzdgBjvLLkZE; Tue, 27 Sep 2022 17:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 760B9400AB;
	Tue, 27 Sep 2022 17:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 760B9400AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E386C0032;
	Tue, 27 Sep 2022 17:56:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31C82C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F16E940292
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F16E940292
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMkO5OCa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gXNiQcIdp3nz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:56:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7E2840291
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7E2840291
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 17:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664301370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylam0E0Yl8o7oIuCiSoTBfRDDfyFUS+FtVqqi8D5J/k=;
 b=dMkO5OCaCx+H3aHrX64rvCwHkMcThT/A9KdRjQ4tfJeg1F5JeIOqzjlm/9TZELyxIkqb+V
 cQ+qNfHkRawyFfUvlA1NjLxBoGXvnfNaaEIjgBPS2OPamG4h8qw/2D+qvvkM8jktK+NBat
 fslaYWUCnENV8TPkBD9CR1mH8FG2bF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-ck4DGBHvPG6NtC2upHkIAQ-1; Tue, 27 Sep 2022 13:56:09 -0400
X-MC-Unique: ck4DGBHvPG6NtC2upHkIAQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 b5-20020a05600c4e0500b003b499f99aceso8944043wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 10:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date;
 bh=ylam0E0Yl8o7oIuCiSoTBfRDDfyFUS+FtVqqi8D5J/k=;
 b=yVfHVspTKyl7U5wtq1Zrv2Uss2+zwCt41qWjq/mpyfheyi8r9zF4KCyDJsRdKP++SO
 rre6N5dpLFB8WJN8UZR8GafPRV9nqjLRLGBky9zvcinQ7gm7jozeQUKSStzvLYsIPiKE
 EyVBpO+LchB5JylzuHLPnBm4PH6yJHGdmWOw9xUHIz+XuNYxbDLxpsSUM/J9cYoBdRUA
 qQhRUenCrvJKoP3yOEuBNglV2Zm4oX/Xpd+ypdMK4bHibbregjQDW3JtxKqz5d37L+/m
 WPIQ420fNIlQ7C03/roohJdC49bErWWnAfaFWflFadkAmGZ1x+vkaH/Sn4phd0r6+LmJ
 r5dg==
X-Gm-Message-State: ACrzQf3O5ZBElLrZbZMjnyhRoza810htQv5Ln0xZwnkJbW8KDXspoNs8
 L45ZbQRwQSuO1bU8e4f7pq0HTGnG/pZr55mqNGOr+Pw0tT7pmRGxEZ4flh89DhvsLR8SjDDKb9S
 Itpt/1IW/JezegnassJ8I5OW3j2KT8AW/JUk98w/Vbg==
X-Received: by 2002:a05:600c:1906:b0:3b4:c979:e639 with SMTP id
 j6-20020a05600c190600b003b4c979e639mr3579332wmq.10.1664301366030; 
 Tue, 27 Sep 2022 10:56:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7FqAzRoJe8tYb81tymnL2G1w/i5A9eSO1xA6YLlCwZrMepZTryND4cUgsUZdpNmVpZgnJ9bg==
X-Received: by 2002:a05:600c:1906:b0:3b4:c979:e639 with SMTP id
 j6-20020a05600c190600b003b4c979e639mr3579316wmq.10.1664301365775; 
 Tue, 27 Sep 2022 10:56:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it.
 [146.241.104.40]) by smtp.gmail.com with ESMTPSA id
 i24-20020a1c5418000000b003a601a1c2f7sm15224452wmb.19.2022.09.27.10.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 10:56:05 -0700 (PDT)
Message-ID: <85cccb780608e830024fc82a8e4f703031646f4e.camel@redhat.com>
Subject: Re: [PATCH net-next 0/4] shrink struct ubuf_info
From: Paolo Abeni <pabeni@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Sep 2022 19:56:04 +0200
In-Reply-To: <bbb212f6-0165-0747-d99d-b49acbb02a80@gmail.com>
References: <cover.1663892211.git.asml.silence@gmail.com>
 <7fef56880d40b9d83cc99317df9060c4e7cdf919.camel@redhat.com>
 <021d8ea4-891c-237d-686e-64cecc2cc842@gmail.com>
 <bbb212f6-0165-0747-d99d-b49acbb02a80@gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
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

T24gVHVlLCAyMDIyLTA5LTI3IGF0IDE4OjE2ICswMTAwLCBQYXZlbCBCZWd1bmtvdiB3cm90ZToK
PiBPbiA5LzI3LzIyIDE1OjI4LCBQYXZlbCBCZWd1bmtvdiB3cm90ZToKPiA+IEhlbGxvIFBhb2xv
LAo+ID4gCj4gPiBPbiA5LzI3LzIyIDE0OjQ5LCBQYW9sbyBBYmVuaSB3cm90ZToKPiA+ID4gSGVs
bG8sCj4gPiA+IAo+ID4gPiBPbiBGcmksIDIwMjItMDktMjMgYXQgMTc6MzkgKzAxMDAsIFBhdmVs
IEJlZ3Vua292IHdyb3RlOgo+ID4gPiA+IHN0cnVjdCB1YnVmX2luZm8gaXMgbGFyZ2UgYnV0IG5v
dCBhbGwgZmllbGRzIGFyZSBuZWVkZWQgZm9yIGFsbAo+ID4gPiA+IGNhc2VzLiBXZSBoYXZlIGxp
bWl0ZWQgc3BhY2UgaW4gaW9fdXJpbmcgZm9yIGl0IGFuZCBsYXJnZSB1YnVmX2luZm8KPiA+ID4g
PiBwcmV2ZW50cyBzb21lIHN0cnVjdCBlbWJlZGRpbmcsIGV2ZW4gdGhvdWdoIHdlIHVzZSBvbmx5
IGEgc3Vic2V0Cj4gPiA+ID4gb2YgdGhlIGZpZWxkcy4gSXQncyBhbHNvIG5vdCB2ZXJ5IGNsZWFu
IHRyeWluZyB0byB1c2UgdGhpcyB0eXBlbGVzcwo+ID4gPiA+IGV4dHJhIHNwYWNlLgo+ID4gPiA+
IAo+ID4gPiA+IFNocmluayBzdHJ1Y3QgdWJ1Zl9pbmZvIHRvIG9ubHkgbmVjZXNzYXJ5IGZpZWxk
cyB1c2VkIGluIGdlbmVyaWMgcGF0aHMsCj4gPiA+ID4gbmFtZWx5IC0+Y2FsbGJhY2ssIC0+cmVm
Y250IGFuZCAtPmZsYWdzLCB3aGljaCB0YWtlIG9ubHkgMTYgYnl0ZXMuIEFuZAo+ID4gPiA+IG1h
a2UgTVNHX1pFUk9DT1BZIGFuZCBzb21lIG90aGVyIHVzZXJzIHRvIGVtYmVkIGl0IGludG8gYSBs
YXJnZXIgc3RydWN0Cj4gPiA+ID4gdWJ1Zl9pbmZvX21zZ3pjIG1pbWlja2luZyB0aGUgZm9ybWVy
IHVidWZfaW5mby4KPiA+ID4gPiAKPiA+ID4gPiBOb3RlLCB4ZW4vdmhvc3QgbWF5IGFsc28gaGF2
ZSBzb21lIGNsZWFuaW5nIG9uIHRvcCBieSBjcmVhdGluZwo+ID4gPiA+IG5ldyBzdHJ1Y3RzIGNv
bnRhaW5pbmcgdWJ1Zl9pbmZvIGJ1dCB3aXRoIHByb3BlciB0eXBlcy4KPiA+ID4gCj4gPiA+IFRo
YXQgc291bmRzIGEgYml0IHNjYXJpbmcgdG8gbWUuIElmIEkgcmVhZCBjb3JyZWN0bHksIGV2ZXJ5
IHVhcmcgdXNlcgo+ID4gPiBzaG91bGQgY2hlY2sgJ3VhcmctPmNhbGxiYWNrID09IG1zZ196ZXJv
Y29weV9jYWxsYmFjaycgYmVmb3JlIGFjY2Vzc2luZwo+ID4gPiBhbnkgJ2V4dGVuZCcgZmllbGRz
Lgo+ID4gCj4gPiBQcm92aWRlcnMgb2YgdWJ1Zl9pbmZvIGFjY2VzcyB0aG9zZSBmaWVsZHMgdmlh
IGNhbGxiYWNrcyBhbmQgc28gYWxyZWFkeQo+ID4ga25vdyB0aGUgYWN0dWFsIHN0cnVjdHVyZSB1
c2VkLiBUaGUgbmV0IGNvcmUsIG9uIHRoZSBvcHBvc2l0ZSwgc2hvdWxkCj4gPiBrZWVwIGl0IGVu
Y2Fwc3VsYXRlZCBhbmQgbm90IHRvdWNoIHRoZW0gYXQgYWxsLgo+ID4gCj4gPiBUaGUgc2VyaWVz
IGxpc3RzIGFsbCBwbGFjZXMgd2hlcmUgd2UgdXNlIGV4dGVuZGVkIGZpZWxkcyBqdXN0IG9uIHRo
ZQo+ID4gbWVyaXQgb2Ygc3RyaXBwaW5nIHRoZSBzdHJ1Y3R1cmUgb2YgdGhvc2UgZmllbGRzIGFu
ZCBzdWNjZXNzZnVsbHkKPiA+IGJ1aWxkaW5nIGl0LiBUaGUgb25seSB1c2VyIGluIG5ldC9pcHZ7
NCw2fS8qIGlzIE1TR19aRVJPQ09QWSwgd2hpY2gKPiA+IGFnYWluIHVzZXMgY2FsbGJhY2tzLgo+
ID4gCj4gPiBTb3VuZHMgbGlrZSB0aGUgcmlnaHQgZGlyZWN0aW9uIGZvciBtZS4gVGhlcmUgaXMg
YSBjb3VwbGUgb2YKPiA+IHBsYWNlcyB3aGVyZSBpdCBtaWdodCBnZXQgdHlwZSBzYWZlciwgaS5l
LiBhZGRpbmcgdHlwZXMgaW5zdGVhZAo+ID4gb2Ygdm9pZCogaW4gZm9yIHN0cnVjdCB0dW5fbXNn
X2N0bCBhbmQgZ2V0dGluZyByaWQgb2Ygb25lIG1hY3JvCj4gPiBoaWRpbmcgdHlwZXMgaW4geGVu
LiBCdXQgc2VlbXMgbW9yZSBsaWtlIFRPRE8gZm9yIGxhdGVyLgo+ID4gCj4gPiA+IEFGQUlDUyB0
aGUgY3VycmVudCBjb2RlIHNvbWV0aW1lcyBkb24ndCBkbyB0aGUKPiA+ID4gZXhwbGljaXQgdGVz
dCBiZWNhdXNlIHRoZSBjb25kaXRpb24gaXMgc29tZXdoYXQgaW1wbGllZCwgd2hpY2ggaW4gdHVy
bgo+ID4gPiBpcyBxdWl0ZSBoYXJkIHRvIHRyYWNrLgo+ID4gPiAKPiA+ID4gY2xlYXJpbmcgdWFy
Zy0+emVyb2NvcHkgZm9yIHRoZSAnd3JvbmcnIHVhcmcgd2FzIGFybWxlc3MgYW5kIHVuZGV0ZWN0
ZWQKPiA+ID4gYmVmb3JlIHRoaXMgc2VyaWVzLCBhbmQgYWZ0ZXIgd2lsbCB0cmlnZ2VyIGFuIG9v
cHMuLgo+ID4gCj4gPiBBbmQgbm93IHdlIGRvbid0IGhhdmUgdGhpcyBmaWVsZCBhdCBhbGwgdG8g
YWNjZXNzLCBjb25zaWRlcmluZyB0aGF0Cj4gPiBub2JvZHkgYmxpbmRseSBjYXN0cyBpdC4KPiA+
IAo+ID4gPiBUaGVyZSBpcyBzb21lIG5vaXNlIGR1ZSB0byB1YXJnIC0+IHVhcmdfemMgcmVuYW1p
bmcgd2hpY2ggbWFrZSB0aGUKPiA+ID4gc2VyaWVzIGhhcmRlciB0byByZXZpZXcuIEhhdmUgeW91
IGNvbnNpZGVyZWQgaW5zdGVhZCBrZWVwaW5nIHRoZSBvbGQKPiA+ID4gbmFtZSBhbmQgaW50cm9k
dWNpbmcgYSBzbWFsbGVyICdzdHJ1Y3QgdWJ1Zl9pbmZvX2NvbW1vbic/IHRoZSBvdmVyYWxsCj4g
PiA+IGNvZGUgc2hvdWxkIGJlIG1vc3RseSB0aGUgc2FtZSwgYnV0IGl0IHdpbGwgYXZvaWQgdGhl
IGFib3ZlIG1lbnRpb25lZAo+ID4gPiBub2lzZS4KPiA+IAo+ID4gSSBkb24ndCB0aGluayB0aGVy
ZSB3aWxsIGJlIGxlc3Mgbm9pc2UgdGhpcyB3YXksIGJ1dCBsZXQgbWUgdHJ5Cj4gPiBhbmQgc2Vl
IGlmIEkgY2FuIGdldCByaWQgb2Ygc29tZSBjaHVybi4KPiAKPiBJdCBkb2Vzbid0IGxvb2sgYW55
IGJldHRlciBmb3IgbWUKPiAKPiBUTDtEUjsgVGhpcyBzZXJpZXMgY29udmVydHMgb25seSAzIHVz
ZXJzOiB0YXAsIHhlbiBhbmQgTVNHX1pFUk9DT1BZCj4gYW5kIGRvZXNuJ3QgdG91Y2ggY29yZSBj
b2RlLiBJZiB3ZSBkbyB1YnVmX2luZm9fY29tbW9uIHRob3VnaCBJJ2QgbmVlZAo+IHRvIGNvbnZl
cnQgbG90cyBvZiBwbGFjZXMgaW4gc2tidWZmLmMgYW5kIG11bHRpcGxlIHBsYWNlcyBhY3Jvc3MK
PiB0Y3AvdWRwLCB3aGljaCBpcyBtdWNoIHdvcnNlLsKgCgpVaG1tLi4uIEkgdW5kZXJsb29rIHRo
ZSBmYWN0IHdlIG11c3QgcHJlc2VydmUgdGhlIGN1cnJlbnQgYWNjZXNzb3JzIGZvcgp0aGUgY29t
bW9uIGZpZWxkcy4KCkkgZ3Vlc3Mgc29tZXRoaW5nIGxpa2UgdGhlIGZvbGxvd2luZyBjb3VsZCBk
byAoY29tcGxldGVseSB1bnRlc3RlZCwKaG9wZWZ1bGx5IHNob3VsZCBpbGx1c3RyYXRlIHRoZSBp
ZGVhKToKCnN0cnVjdCB1YnVmX2luZm8gewoJc3RydWN0X2dyb3VwX3RhZ2dlZCh1YnVmX2luZm9f
Y29tbW9uLCBjb21tb24sCgkJdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3Qgc2tfYnVmZiAqLCBzdHJ1
Y3QgdWJ1Zl9pbmZvICosCiAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHplcm9jb3B5X3N1
Y2Nlc3MpOwoJCXJlZmNvdW50X3QgcmVmY250OwoJICAgICAgICB1OCBmbGFnczsKCSk7CgoJdW5p
b24gewogICAgICAgICAgICAgICAgc3RydWN0IHsKICAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgbG9uZyBkZXNjOwogICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpjdHg7CiAgICAg
ICAgICAgICAgICB9OwogICAgICAgICAgICAgICAgc3RydWN0IHsKICAgICAgICAgICAgICAgICAg
ICAgICAgdTMyIGlkOwogICAgICAgICAgICAgICAgICAgICAgICB1MTYgbGVuOwogICAgICAgICAg
ICAgICAgICAgICAgICB1MTYgemVyb2NvcHk6MTsKICAgICAgICAgICAgICAgICAgICAgICAgdTMy
IGJ5dGVsZW47CiAgICAgICAgICAgICAgICB9OwogICAgICAgIH07CgogICAgICAgIHN0cnVjdCBt
bXBpbiB7CiAgICAgICAgICAgICAgICBzdHJ1Y3QgdXNlcl9zdHJ1Y3QgKnVzZXI7CiAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgbnVtX3BnOwogICAgICAgIH0gbW1wOwp9OwoKVGhlbiB5b3Ug
c2hvdWxkIGJlIGFibGUgdG86Ci0gYWNjZXNzIHVidWZfaW5mby0+Y2FsbGJhY2sswqAKLSBhY2Nl
c3MgdGhlIHNhbWUgZmllbGQgdmlhIHVidWZfaW5mby0+Y29tbW9uLmNhbGxiYWNrCi0gZGVjbGFy
ZSB2YXJpYWJsZXMgYXMgJ3N0cnVjdCB1YnVmX2luZm9fY29tbW9tJyB3aXRoIGFwcHJvcHJpYXRl
CmNvbnRlbnRzLgoKV0RZVD8KClRoYW5rcywKClBhb2xvCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
