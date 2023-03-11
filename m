Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573D5C6FD1C
	for <virtualization@archiver.kernel.org>; Sat, 11 Mar 2023 19:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE35441B31;
	Sat, 11 Mar 2023 19:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE35441B31
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XCTDw51e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCXg6eOYFimw; Sat, 11 Mar 2023 19:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A3C7415FE;
	Sat, 11 Mar 2023 19:15:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A3C7415FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 018C4C0071;
	Sat, 11 Mar 2023 19:15:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFF07C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B64FF41B31
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:15:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B64FF41B31
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJ7JiE6znDu8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:15:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB316415FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB316415FE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678562118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8Qyu+0I7e5+wByj0r24z51cw7ysaFBsNZQFvfJyvK8=;
 b=XCTDw51e++YG+VawkzEZJMC33cOPo4VhdaLWV4xbFlOZELkE7wtRqUzQmq8FoiidB21Ma5
 ddBZS03RE4CB0N4q7A/OMx9sZAFK5iSY4q/U1Jb7IbWJLyZ8sHfvLWuhce6nIgs2w+7SFu
 o69Sl6TQUYd5Qu6nKmQQOWpKDm6/KwM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-nseqhKdbMyuDXm2ATdZSRQ-1; Sat, 11 Mar 2023 14:15:17 -0500
X-MC-Unique: nseqhKdbMyuDXm2ATdZSRQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 t1-20020a7bc3c1000000b003dfe223de49so5491615wmj.5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 11:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678562116;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U8Qyu+0I7e5+wByj0r24z51cw7ysaFBsNZQFvfJyvK8=;
 b=QLP4HXsZqhZQmCew30dUx2b7O43HSbNupLI/mmYylx5swM2uGJYKyjFT2GYb7uMcSQ
 xpLl+f9t+XPcY85yQa4UadtI1L2G9zYfQPwpCwhZilIc56iWrHMY+1+IFlRpYyJi7Ee0
 i8f+QBO91vEnwIWgCHp6qjbX+Afm6ad7drmA2y7h1p7LorZH9QRrLciR3KypRVqtmzV3
 lzEA+2aeR4dYe/otU/5qmX7/3+sBIrGBmQJm3U0edrb8gJkw8CEu0TWC7ScFuj04+jqR
 JMPCSHbCvE36npVsZEXXQQwx4fBnXCcElXaNjXyDFCJUj5VkUw7YgbDG2zKrKXr5c7mm
 Dzrw==
X-Gm-Message-State: AO0yUKWjoPKF0jX3A4/Z61exd6DZ1n87DaqUdJtmUaXHpXuSaTnxpTGt
 48mNA6/ZVDcXu9c38WGyWMvT3kzbNxI0nMIBYGZt7L7CmPkYBPTEC/8pGUU3XZBjdLmxL+TGuJS
 380S48tZIJsXKqOrc5+sLYslyU72cMcaE40CtTLGnpA==
X-Received: by 2002:a05:600c:5107:b0:3df:e1e9:201d with SMTP id
 o7-20020a05600c510700b003dfe1e9201dmr6207027wms.40.1678562115910; 
 Sat, 11 Mar 2023 11:15:15 -0800 (PST)
X-Google-Smtp-Source: AK7set96M5dPOa2xYmlmAGYkZvOKRptdsLbtTB1fIalkMaZYMMMU2r6s84fcwBbGUwoLesMEVUOzsQ==
X-Received: by 2002:a05:600c:5107:b0:3df:e1e9:201d with SMTP id
 o7-20020a05600c510700b003dfe1e9201dmr6207018wms.40.1678562115654; 
 Sat, 11 Mar 2023 11:15:15 -0800 (PST)
Received: from redhat.com ([2.52.29.35]) by smtp.gmail.com with ESMTPSA id
 i2-20020a05600c290200b003ed1fa34bd3sm487743wmd.13.2023.03.11.11.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Mar 2023 11:15:15 -0800 (PST)
Date: Sat, 11 Mar 2023 14:15:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/11] Use copy_process in vhost layer
Message-ID: <20230311141346-mutt-send-email-mst@kernel.org>
References: <20230310220332.5309-1-michael.christie@oracle.com>
 <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com
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

T24gU2F0LCBNYXIgMTEsIDIwMjMgYXQgMDk6MjE6MTRBTSAtMDgwMCwgTGludXMgVG9ydmFsZHMg
d3JvdGU6Cj4gT24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgMjowNOKAr1BNIE1pa2UgQ2hyaXN0aWUK
PiA8bWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tPiB3cm90ZToKPiA+Cj4gPiBUaGUgZm9sbG93
aW5nIHBhdGNoZXMgd2VyZSBtYWRlIG92ZXIgTGludXMncyB0cmVlIGFuZCBhcHBseSBvdmVyIG5l
eHQuIFRoZXkKPiA+IGFsbG93IHRoZSB2aG9zdCBsYXllciB0byB1c2UgY29weV9wcm9jZXNzIGlu
c3RlYWQgb2YgdXNpbmcKPiA+IHdvcmtxdWV1ZV9zdHJ1Y3RzIHRvIGNyZWF0ZSB3b3JrZXIgdGhy
ZWFkcyBmb3IgVk0ncyBkZXZpY2VzLgo+IAo+IE9rLCBhbGwgdGhlc2UgcGF0Y2hlcyBsb29rZWQg
ZmluZSB0byBtZSBmcm9tIGEgcXVpY2sgc2NhbiAtIG5vdGhpbmcKPiB0aGF0IEkgcmVhY3RlZCB0
byBhcyBvYmplY3Rpb25hYmxlLCBhbmQgc2V2ZXJhbCBvZiB0aGVtIGxvb2tlZCBsaWtlCj4gbmlj
ZSBjbGVhbnVwcy4KPiAKPiBUaGUgb25seSBvbmUgSSB3ZW50ICJXaHkgZG8geW91IGRvIGl0IHRo
YXQgd2F5IiBmb3Igd2FzIGluIDEwLzExCj4gKGVudGlyZWx5IGludGVybmFsIHRvIHZob3N0LCBz
byBJIGRvbid0IGZlZWwgdG9vIHN0cm9uZ2x5IGFib3V0IHRoaXMpCj4gaG93IHlvdSBtYWRlICJz
dHJ1Y3Qgdmhvc3Rfd29ya2VyIiBiZSBhIHBvaW50ZXIgaW4gInN0cnVjdCB2aG9zdF9kZXYiLgo+
IAo+IEl0IF9sb29rc18gdG8gbWUgbGlrZSBpdCBjb3VsZCBqdXN0IGhhdmUgYmVlbiBhbiBlbWJl
ZGRlZCBzdHJ1Y3R1cmUKPiByYXRoZXIgdGhhbiBhIHNlcGFyYXRlIGFsbG9jYXRpb24uCj4gCj4g
SU9XLCB3aHkgZG8KPiAKPiAgICB2aG9zdF9kZXYtPndvcmtlcgo+IAo+IGluc3RlYWQgb2YgZG9p
bmcKPiAKPiAgIHZob3N0X2Rldi53b3JrZXIKPiAKPiBhbmQganVzdCBoYXZpbmcgaXQgYWxsIGlu
IHRoZSBzYW1lIGFsbG9jYXRpb24/Cj4gCj4gTm90IGEgYmlnIGRlYWwuIE1heWJlIHlvdSB3YW50
ZWQgdGhlICd0ZXN0IGlmIHdvcmtlciBwb2ludGVyIGlzIE5VTEwnCj4gY29kZSB0byBzdGF5IGFy
b3VuZCwgYW5kIGJhc2ljYWxseSB1c2UgdGhhdCBwb2ludGVyIGFzIGEgZmxhZyB0b28uIE9yCj4g
bWF5YmUgdGhlcmUgaXMgc29tZSBvdGhlciByZWFzb24geW91IHdhbnQgdG8ga2VlcCB0aGF0IHNl
cGFyYXRlLi4KPiAKPiAgICAgICAgICAgICAgICBMaW51cwoKSSBhZ3JlZSB3aXRoIExpbnVzIGhl
cmUsIHNsaWdodGx5IGJldHRlciBlbWJlZGRlZCwgYnV0IG5vIGh1Z2UgZGVhbC4KV2hpY2ggdHJl
ZSBpcyB0aGlzIGdvaW5nIG9uPwpJZiBub3QgbWluZSBoZXJlJ3MgbXkgYWNrOgoKQWNrZWQtYnk6
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CgotLSAKTVNUCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
