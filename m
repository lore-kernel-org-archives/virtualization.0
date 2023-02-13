Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F3C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 11:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A875280C0F;
	Mon, 13 Feb 2023 11:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A875280C0F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHOGRawe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f_YZZOKbOLSZ; Mon, 13 Feb 2023 11:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1880080BBE;
	Mon, 13 Feb 2023 11:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1880080BBE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE468C0033;
	Mon, 13 Feb 2023 11:59:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5977AC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 11:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3461C40606
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 11:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3461C40606
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BHOGRawe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hL18K218jgca
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 11:59:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A552403EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A552403EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676289588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46CLETJ40hAAVjqperX0UsKESJ1sk6fyhGA6Z8UODrY=;
 b=BHOGRaweKbcWyDCBLFKybJ1rdG0rOsp+IdPrjQzK7+FG6g6BDTTs3h7/HAdSv3QGuTFMkp
 B2qmE52aXwLit40dK8XNawFzepSti0Sk1BAvmB7XLUQeD5kNj9iBrn2dg2/IrCjMxKB5lQ
 CEdiCD1lL10VCwHcec8EvxiwAjY8ky0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-MJ0YkNB1P4iL8ae98JTn9g-1; Mon, 13 Feb 2023 06:59:45 -0500
X-MC-Unique: MJ0YkNB1P4iL8ae98JTn9g-1
Received: by mail-ed1-f72.google.com with SMTP id
 g25-20020aa7c859000000b004a3fe4cbb0cso7381650edt.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 03:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46CLETJ40hAAVjqperX0UsKESJ1sk6fyhGA6Z8UODrY=;
 b=FmtjBdT+ypC3GRu3lIx6lqyV3YVPsuN6kYGsjLAax1kjb7F74D12vQlK5nFoH24ztW
 SwFg8akjGZ1Ia5YhLvCi7j19YrwVAktiQ1cYLRRe01MxY4WktRHTghuLL7oZQP6U+V4u
 MxxcZ7gmIqRPVb/8ami3pd6j5kfEro8EqDKSrNt4bc1CvYn/aDSj4PqhpLzEldXvlCgM
 ABuM+pB+aZyQ/T94jDmMOIBgx0Xq0S/EPweShpDvzd/TbM1mcOf0PeGdTQO1y9jg1M2W
 LRZBzco9Efw7wNlcDSw2CXE2xN+k2LTmckbVISYJfhkQnJACLDNWWFHOrsdRaddBVv1e
 mO7g==
X-Gm-Message-State: AO0yUKUCXAkW603dtPf90qOPQ3O8Isxtuk3Oofw5lT44wuAv79AWGdlR
 TpreXR6ugNbclZDtDrghgcQHXqcqWLaY/FpneScCPwC1eXvlq9v+qN/YTyHr4sJ7u9clYn3nHSn
 HnO3JTK4kVfh/6e6DTU7lFP9DxGtJFhqMlcF2IZFqrA==
X-Received: by 2002:a17:907:6ea8:b0:870:94e:13f9 with SMTP id
 sh40-20020a1709076ea800b00870094e13f9mr33062277ejc.0.1676289584024; 
 Mon, 13 Feb 2023 03:59:44 -0800 (PST)
X-Google-Smtp-Source: AK7set9TdRlIREvM6fdM6jWVJOrK0vCr8EsGV3icl24AFGs3qHQf2X49gvhr+Cs+XywSMqELN9alyw==
X-Received: by 2002:a17:907:6ea8:b0:870:94e:13f9 with SMTP id
 sh40-20020a1709076ea800b00870094e13f9mr33062269ejc.0.1676289583874; 
 Mon, 13 Feb 2023 03:59:43 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 mf17-20020a170906cb9100b008a60ed04e42sm6651265ejb.110.2023.02.13.03.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 03:59:43 -0800 (PST)
Date: Mon, 13 Feb 2023 06:59:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20230213065116-mutt-send-email-mst@kernel.org>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
 <20221219023253-mutt-send-email-mst@kernel.org>
 <CACycT3utDJFZtWzqCUXJaqRjkCXPMTAi+VJd3g6dw25vWqaduw@mail.gmail.com>
 <20230127032039-mutt-send-email-mst@kernel.org>
 <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3u=vULuZ9-ZakBjxmbu88iUb+xB2mHJUnHA_8SuUV7H4w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
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

T24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgMDc6NTM6NTVQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCA0OjIyIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgRGVjIDE5LCAyMDIyIGF0IDA1
OjM2OjAyUE0gKzA4MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgRGVjIDE5LCAy
MDIyIGF0IDM6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBNb24sIERlYyAwNSwgMjAyMiBhdCAwNDo0MToxN1BNICswODAw
LCBYaWUgWW9uZ2ppIHdyb3RlOgo+ID4gPiA+ID4gRXhwb3J0IGlycV9jcmVhdGVfYWZmaW5pdHlf
bWFza3MoKSBzbyB0aGF0IHNvbWUgbW9kdWxlcwo+ID4gPiA+ID4gY2FuIG1ha2UgdXNlIG9mIGl0
IHRvIGltcGxlbWVudCBpbnRlcnJ1cHQgYWZmaW5pdHkKPiA+ID4gPiA+IHNwcmVhZGluZyBtZWNo
YW5pc20uCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGll
eW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4gPiA+ID4KPiA+ID4gPiBTbyB0aGlzIGdvdCBuYWNrZWQs
IHdoYXQncyB0aGUgcGxhbiBub3c/Cj4gPiA+ID4KPiA+ID4KPiA+ID4gSeKAmGQgbGlrZSB0byBj
aGVjayB3aXRoIENocmlzdG9waCBhZ2FpbiBmaXJzdC4KPiA+ID4KPiA+ID4gSGkgQ2hyaXN0b3Bo
LAo+ID4gPgo+ID4gPiBKYXNvbiB3aWxsIHBvc3Qgc29tZSBwYXRjaGVzIHRvIGdldCByaWQgb2Yg
dGhlIERNQSBBUEkgZm9yIHZEUEEKPiA+ID4gc2ltdWxhdG9ycy4gQW5kIHRoZSBpcnEgYWZmaW5p
dHkgYWxnb3JpdGhtIGlzIGluZGVwZW5kZW50IG9mIHRoZSBJUlEKPiA+ID4gc3Vic3lzdGVtIElJ
VUMuIFNvIGNvdWxkIHlvdSBhbGxvdyB0aGlzIHBhdGNoIHNvIHRoYXQgd2UgY2FuIHJldXNlIHRo
ZQo+ID4gPiBhbGdvcml0aG0gdG8gc2VsZWN0IHRoZSBiZXN0IENQVSAocGVyLWNwdSBhZmZpbml0
eSBpZiBwb3NzaWJsZSwgb3IgYXQKPiA+ID4gbGVhc3QgcGVyLW5vZGUpIHRvIHJ1biB0aGUgdmly
dHF1ZXVlJ3MgaXJxIGNhbGxiYWNrLgo+ID4gPgo+ID4gPiBUaGFua3MsCj4gPiA+IFlvbmdqaQo+
ID4KPiA+IEkgdGhpbmsgeW91IG5lZWQgdG8gZXhwbGFpbiB3aHkgeW91IGFyZSBidWlsZGluZyBs
b3cgbGV2ZWwKPiA+IGFmZmluaXR5IG1hc2tzLgo+IAo+IEluIFZEVVNFIGNhc2UsIHdlIHVzZSB3
b3JrcXVldWUgdG8gcnVuIHRoZSB2aXJ0cXVldWUncyBpcnEgY2FsbGJhY2suCj4gTm93IEkgd2Fu
dCB0byBxdWV1ZSB0aGUgaXJxIGNhbGxiYWNrIGt3b3JrIHRvIG9uZSBzcGVjaWZpYyBDUFUgdG8g
Z2V0Cj4gcGVyLWNwdSBhZmZpbml0eSBpZiBwb3NzaWJsZSwgb3IgYXQgbGVhc3QgcGVyLW5vZGUu
IFNvIEkgbmVlZCB0byB1c2UKPiB0aGlzIGZ1bmN0aW9uIHRvIGJ1aWxkIHRoZSBsb3cgbGV2ZWwg
YWZmaW5pdHkgbWFza3MgZm9yIGVhY2gKPiB2aXJ0cXVldWUuCj4gCj4gPiB3aGF0J3MgdGhlIHBs
YW4gbm93Pwo+ID4KPiAKPiBJZiB0aGVyZSBpcyBubyBvYmplY3Rpb24sIEknbGwgcG9zdCBhIG5l
dyB2ZXJzaW9uLgo+IAo+IFRoYW5rcywKPiBZb25namkKCkkgZG91YnQgeW91IG1hZGUgYSBjb252
aWNpbmcgY2FzZSBoZXJlIC0gSSB0aGluayBDaHJpc3RvcGggd2FzIHNheWluZyBpZgppdCBpcyBu
b3QgYW4gaXJxIGl0IHNob3VsZCBub3QgdXNlIGFuIGlycSBhZmZpbml0eSBBUEkuClNvIGEgbmV3
IEFQSSBwb3NzaWJseSBzaGFyaW5nIGltcGxlbWVudGF0aW9uIHdpdGggaXJxIGFmZmluaXR5Cmlz
IGNhbGxlZCBmb3IgdGhlbj8gTWF5YmUuCgoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
