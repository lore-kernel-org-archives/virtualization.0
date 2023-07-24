Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48100EB64DD
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 20:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE69641732;
	Mon, 24 Jul 2023 20:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE69641732
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOWLNZ34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CPt8rsrqZ0Ks; Mon, 24 Jul 2023 20:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E334A41711;
	Mon, 24 Jul 2023 20:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E334A41711
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B91A8C0072;
	Mon, 24 Jul 2023 20:09:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6511C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB96660B71
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB96660B71
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOWLNZ34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RXXcPS2FbR6d
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:09:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC59760AB9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:09:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC59760AB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690229343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOK3VNMDEhYbwTWfQtq0KlS34ajRoQ4mypTKeCUsMYk=;
 b=jOWLNZ34OsoVFdE8LJI/IL13jrB6yOTOJvdFTK78ydmfzhaG7d7pelP+tM7EeoCd0a8R/T
 bCyL1cY10maCZSiFb4KY+6ETW1sucb6YAMekHUC4q8uJHEAj/Xsi0Em+PmPUuy+sYPUMD9
 iML0rcRRrM0mv6HoqfdPfwOmjg77rh8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8RinK_yuNpqt3f-8Abt7oA-1; Mon, 24 Jul 2023 16:08:59 -0400
X-MC-Unique: 8RinK_yuNpqt3f-8Abt7oA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-98e1085308eso200453966b.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 13:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690229338; x=1690834138;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kOK3VNMDEhYbwTWfQtq0KlS34ajRoQ4mypTKeCUsMYk=;
 b=XCOvsYRYzd4HEQGtrKUoIdF3LwMBpvIYmdxRrIzlSLS0tznqL9O/AJRV5zPFDXC4rp
 bxcz6xoJWeYWZZ0/m/VbL+EKiKJO45lD5du6KDSVhMVkwLGBggCRJ/JP/Fh7Pd1Dyo54
 0zY6n0DU2FHOiEccYO/DgLvEmzX/TH02iWjyXK7p4hok5TrGVQF/L618FkjVnGipH6o5
 Po8c8if5ZyjbEOqVejHmjjvXSTxMew5YGLokOu8Qp5ZtqNvhAphK1MCHLPuavNFfQATR
 Kf2p0t1+KbcFfrffuXAgAUlhjaiJ//nZ56ojj6GhdRtFTiQmRt4LyduufFAj6YGwh/9g
 qryg==
X-Gm-Message-State: ABy/qLYme2JXm+om5U1WB1WAYes6pO5ZOSDlgQfmoHaMIi2vGIihTova
 b6SQqysPIMZksj38c60WXxwYclWIOMQ+OlnlpabmFTaRbByVXcSiCJbjTlYWLm7gi2/IBklIDCG
 QppqbKIvpth1xZP6kIOZJYI8qAsFhsP2VeDGs6RzbiA==
X-Received: by 2002:a17:907:7842:b0:993:da0b:8783 with SMTP id
 lb2-20020a170907784200b00993da0b8783mr267690ejc.3.1690229337975; 
 Mon, 24 Jul 2023 13:08:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrvXhzOPkOHGgAkG8J2sNtDRwC7cMGTPcbiWhXRtw55DcqDqX8Mw31Z+/l2pn2sf19GTmPPA==
X-Received: by 2002:a17:907:7842:b0:993:da0b:8783 with SMTP id
 lb2-20020a170907784200b00993da0b8783mr267670ejc.3.1690229337700; 
 Mon, 24 Jul 2023 13:08:57 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 lc28-20020a170906dffc00b0098e422d6758sm7145529ejc.219.2023.07.24.13.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 13:08:57 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:08:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
Message-ID: <20230724160836-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
 <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
 <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
 <20230724050005-mutt-send-email-mst@kernel.org>
 <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMTE6NDI6NDJBTSArMDAwMCwgRHJhZ29zIFRhdHVsZWEg
d3JvdGU6Cj4gT24gTW9uLCAyMDIzLTA3LTI0IGF0IDA1OjE2IC0wNDAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4gPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAwODozODowNEFNICswMDAw
LCBEcmFnb3MgVGF0dWxlYSB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIE1vbiwgMjAyMy0wNy0yNCBh
dCAxNToxMSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiBPbiBTdW4sIEp1bCAyMywg
MjAyMyBhdCA2OjAy4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9uIFN1biwgSnVsIDIzLCAyMDIzIGF0IDA1OjQ4OjQ2
UE0gKzA4MDAsIExpbiBNYSB3cm90ZToKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gU3VyZSwg
dGhhdCBpcyBhbm90aGVyIHVuZGVyZ29pbmcgdGFzayBJJ20gd29ya2luZyBvbi4gSWYgdGhlIG5s
YXR0cgo+ID4gPiA+ID4gPiA+IGlzCj4gPiA+ID4gPiA+ID4gcGFyc2VkIHdpdGgKPiA+ID4gPiA+
ID4gPiBOTF9WQUxJREFURV9VTlNQRUMsIGFueSBmb3Jnb3R0ZW4gbmxhdHRyIHdpbGwgYmUgcmVq
ZWN0ZWQsIHRoZXJlZm9yZQo+ID4gPiA+ID4gPiA+ICh3aGljaCBpcyB0aGUgZGVmYXVsdAo+ID4g
PiA+ID4gPiA+IGZvciBtb2Rlcm4gbmxhX3BhcnNlKS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
IEZvciB0aGUgZ2VuZXJhbCBuZXRsaW5rIGludGVyZmFjZSwgdGhlIGRlY2lkaW5nIGZsYWcgc2hv
dWxkIGJlCj4gPiA+ID4gPiA+IGdlbmxfb3BzLnZhbGlkYXRlIGRlZmluZWQgaW4KPiA+ID4gPiA+
ID4gZWFjaCBvcHMuIFRoZSBkZWZhdWx0IHZhbGlkYXRlIGZsYWcgaXMgc3RyaWN0LCB3aGlsZSB0
aGUgZGV2ZWxvcGVyIGNhbgo+ID4gPiA+ID4gPiBvdmVyd3JpdGUgdGhlIGZsYWcKPiA+ID4gPiA+
ID4gd2l0aCBHRU5MX0RPTlRfVkFMSURBVEVfU1RSSUNUIHRvIGVhc2UgdGhlIHZhbGlkYXRpb24u
IFRoYXQgaXMgdG8gc2F5LAo+ID4gPiA+ID4gPiBzYWZlciBjb2RlIHNob3VsZAo+ID4gPiA+ID4g
PiBlbmZvcmNlIE5MX1ZBTElEQVRFX1NUUklDVCBieSBub3Qgb3ZlcndyaXRpbmcgdGhlIHZhbGlk
YXRlIGZsYWcuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBSZWdyYWRzCj4gPiA+ID4gPiA+IExp
bgo+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9oIEkgc2VlLgo+ID4gPiA+ID4gCj4g
PiA+ID4gPiBJdCBzdGFydGVkIGhlcmU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IGNvbW1pdCAzM2Iz
NDc1MDNmMDE0ZWJmNzYyNTczMjdjYmM3MDAxYzZiNzIxOTU2Cj4gPiA+ID4gPiBBdXRob3I6IFBh
cmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPiA+ID4gPiA+IERhdGU6wqDCoCBUdWUgSmFu
IDUgMTI6MzI6MDAgMjAyMSArMDIwMAo+ID4gPiA+ID4gCj4gPiA+ID4gPiDCoMKgwqAgdmRwYTog
RGVmaW5lIHZkcGEgbWdtdCBkZXZpY2UsIG9wcyBhbmQgYSBuZXRsaW5rIGludGVyZmFjZQo+ID4g
PiA+ID4gCj4gPiA+ID4gPiB3aGljaCBkaWQ6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC52YWxpZGF0ZSA9IEdFTkxfRE9OVF9WQUxJREFURV9TVFJJ
Q1QgfAo+ID4gPiA+ID4gR0VOTF9ET05UX1ZBTElEQVRFX0RVTVAsCj4gPiA+ID4gPiAKPiA+ID4g
PiA+IAo+ID4gPiA+ID4gd2hpY2ggd2FzIG1vc3QgbGlrZWx5IGp1c3QgYSBjb3B5IHBhc3RlIGZy
b20gc29tZXdoZXJlLCByaWdodCBQYXJhdj8KPiA+ID4gPiA+IAo+ID4gPiA+ID4gYW5kIHRoZW4g
ZXZlcnlvbmUga2VwdCBjb3B5aW5nIHRoaXMgYXJvdW5kLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBQ
YXJhdiwgRWxpIGNhbiB3ZSBkcm9wIHRoZXNlPyBUaGVyZSdzIGEgdGlueSBjaGFuY2Ugb2YgYnJl
YWtpbmcKPiA+ID4gPiA+IHNvbWV0aGluZwo+ID4gPiA+ID4gYnV0IEkgZmVlbCB0aGVyZSBhcmVu
J3QgdGhhdCBtYW55IHVzZXJzIG91dHNpZGUgbWx4NSB5ZXQsIHNvIGlmIHlvdQo+ID4gPiA+ID4g
Z3V5cyBjYW4gdGVzdCBvbiBtbHg1IGFuZCBjb25maXJtIG5vIGJyZWFrYWdlLCBJIHRoaW5rIHdl
IGFyZSBnb29kLgo+ID4gPiA+IAo+ID4gPiA+IEFkZGluZyBEcmFnb3MuCj4gPiA+ID4gCj4gPiA+
IEkgd2lsbCBjaGVjay4gSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIGNvcnJlY3RseTog
eW91IHdhbnQgbWUgdG8gZHJvcAo+ID4gPiB0aGUKPiA+ID4gLnZhbGlkYXRlIGZsYWdzIGFsbCB0
b2dldGhlciBpbiBhbGwgdmRwYSBvcHMgYW5kIGNoZWNrLCByaWdodD8KPiA+ID4gCj4gPiA+IFRo
YW5rcywKPiA+ID4gRHJhZ29zCj4gPiAKPiA+IHllcyAtIEkgc3VzcGVjdCB5b3Ugd2lsbCB0aGVu
IG5lZWQgdGhpcyBwYXRjaCB0byBtYWtlIHRoaW5ncyB3b3JrLgo+ID4gCj4gWWVwLiBBZGRpbmcg
dGhlIHBhdGNoIGFuZCByZW1vdmluZyB0aGUgLnZhbGlkYXRlIGNvbmZpZyBvbiB0aGUgdmRwYV9u
bF9vcHMKPiBzZWVtcyB0byB3b3JrIGp1c3QgZmluZS4KPiAKPiBUaGFua3MsCj4gRHJhZ29zCgpP
SywgcG9zdCBhIHBhdGNoPwoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
