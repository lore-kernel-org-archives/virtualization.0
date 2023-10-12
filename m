Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD9CCDB482
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 14:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CE1141E4C;
	Thu, 12 Oct 2023 14:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CE1141E4C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PBt13n27
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lb-2AWHsiRCw; Thu, 12 Oct 2023 14:50:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0821341E47;
	Thu, 12 Oct 2023 14:50:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0821341E47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D767FC0039;
	Thu, 12 Oct 2023 14:50:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3695BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 14:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C2398223A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 14:50:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C2398223A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PBt13n27
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CV6PrTv9XJW9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 14:50:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FFF68220C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 14:50:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FFF68220C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697122249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5BqCXztfnjL1n8qvwFlaYSxk8LlaToCm50XqHKuKoc=;
 b=PBt13n27kwwmEqNC5QqMyrzRMe/2iICdkLnRZfW2muChHnWCzpAQNNZx8frVjwNXJAfTO0
 o3WIoIrih8gcu9UUHLNk8jgVEOTrzKVtZ8rQnmEw3xVP7VPCEBT4D+6tZ+YxP8asROHoX/
 Ds+oWZHRlzKt5yaey2gRIB+LPWEG9Ew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-OZ_vwzWIORyVpdoyS3GqlA-1; Thu, 12 Oct 2023 10:50:38 -0400
X-MC-Unique: OZ_vwzWIORyVpdoyS3GqlA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso8610285e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697122237; x=1697727037;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j5BqCXztfnjL1n8qvwFlaYSxk8LlaToCm50XqHKuKoc=;
 b=O1UCnIX0QrVTjBoxIzSGXZ9syWHTLKIjw1ImjnLkVsMsT1T7NAf7AI3t800sMGeetM
 dfIbQgTVd9OEuTIbCglbjaR+siZEXe4OD4W2148iLVbIkw6KHsuszU0EpuIls6L7K/zq
 TF398dzBCk/GwnVtfYmlEfzONuE+QhWuSJeC6A2eJvKPodc0Ci9BqLW6oL4eXznaatiy
 /iXS/izslfPbsWrUFCf3wHtrJPlKT+KGL4T65i060TgzBBCkLEojrZKuaTGnM5gF3Prw
 P8KknQzFwZxep3sHKpZFKsTVjfVS+E0bwA1muP8tmct+BtkJeqQpg/Bs1yuzMlWlG/UC
 n8LA==
X-Gm-Message-State: AOJu0YxpnQ0NiHJY854Dr3ZfTkEurtqI5tTewEBjvqtusRFz0uec953o
 Y7JeLw/MTvTEAtjplv05VwJSmDlGGBborXtZtKeFPTpacPOihg8rvA9GvWp8oalRny2kUvGdqxB
 HRqoqmz4bgKXxoJQi8aYYpoIgFAss2kL9pyjUxLo1lA==
X-Received: by 2002:a05:600c:228a:b0:406:592b:e5aa with SMTP id
 10-20020a05600c228a00b00406592be5aamr21389551wmf.14.1697122237110; 
 Thu, 12 Oct 2023 07:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF2Vo5PT8GSdHGVGE5cwCLnapcKJkvbtEZBt90uz120dcdtwDAi2HYtfKCc8opIa1m8atskQ==
X-Received: by 2002:a05:600c:228a:b0:406:592b:e5aa with SMTP id
 10-20020a05600c228a00b00406592be5aamr21389522wmf.14.1697122236749; 
 Thu, 12 Oct 2023 07:50:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05600c22c600b00406408dc788sm19240wmg.44.2023.10.12.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 07:50:36 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:50:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 00/22] virtio-net: support AF_XDP zero copy
Message-ID: <20231012050829-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011100057.535f3834@kernel.org>
 <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
 <1697099560.6227698-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697099560.6227698-1-xuanzhuo@linux.alibaba.com>
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMDQ6MzI6NDBQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIFRodSwgMTIgT2N0IDIwMjMgMTU6NTA6MTMgKzA4MDAsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgOTo1OOKA
r0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBXZWQsIDExIE9jdCAyMDIzIDEwOjAwOjU3IC0wNzAwLCBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIDExIE9jdCAyMDIzIDE3OjI3
OjA2ICswODAwIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+ICMjIEFGX1hEUAo+ID4gPiA+ID4K
PiA+ID4gPiA+IFhEUCBzb2NrZXQoQUZfWERQKSBpcyBhbiBleGNlbGxlbnQgYnlwYXNzIGtlcm5l
bCBuZXR3b3JrIGZyYW1ld29yay4gVGhlIHplcm8KPiA+ID4gPiA+IGNvcHkgZmVhdHVyZSBvZiB4
c2sgKFhEUCBzb2NrZXQpIG5lZWRzIHRvIGJlIHN1cHBvcnRlZCBieSB0aGUgZHJpdmVyLiBUaGUK
PiA+ID4gPiA+IHBlcmZvcm1hbmNlIG9mIHplcm8gY29weSBpcyB2ZXJ5IGdvb2QuIG1seDUgYW5k
IGludGVsIGl4Z2JlIGFscmVhZHkgc3VwcG9ydAo+ID4gPiA+ID4gdGhpcyBmZWF0dXJlLCBUaGlz
IHBhdGNoIHNldCBhbGxvd3MgdmlydGlvLW5ldCB0byBzdXBwb3J0IHhzaydzIHplcm9jb3B5IHht
aXQKPiA+ID4gPiA+IGZlYXR1cmUuCj4gPiA+ID4KPiA+ID4gPiBZb3UncmUgbW92aW5nIHRoZSBk
cml2ZXIgYW5kIGFkZGluZyBhIG1ham9yIGZlYXR1cmUuCj4gPiA+ID4gVGhpcyByZWFsbHkgbmVl
ZHMgdG8gZ28gdmlhIG5ldCBvciBicGYuCj4gPiA+ID4gSWYgeW91IGhhdmUgZGVwZW5kZW5jaWVz
IGluIG90aGVyIHRyZWVzIHBsZWFzZSB3YWl0IGZvcgo+ID4gPiA+IGFmdGVyIHRoZSBtZXJnZSB3
aW5kb3cuCj4gPiA+Cj4gPiA+Cj4gPiA+IElmIHNvLCBJIGNhbiByZW1vdmUgdGhlIGZpcnN0IHR3
byBjb21taXRzLgo+ID4gPgo+ID4gPiBUaGVuLCB0aGUgc3EgdXNlcyB0aGUgcHJlbWFwcGVkIG1v
ZGUgYnkgZGVmYXVsdC4KPiA+ID4gQW5kIHdlIGNhbiB1c2UgdGhlIGFwaSB2aXJ0cXVldWVfZG1h
X21hcF9zaW5nbGVfYXR0cnMgdG8gcmVwbGFjZSB0aGUKPiA+ID4gdmlydHF1ZXVlX2RtYV9tYXBf
cGFnZV9hdHRycy4KPiA+ID4KPiA+ID4gQW5kIHRoZW4gSSB3aWxsIGZpeCB0aGF0IG9uIHRoZSB0
b3AuCj4gPiA+Cj4gPiA+IEhpIE1pY2hlYWwgYW5kIEphc29uLCBpcyB0aGF0IG9rIGZvciB5b3U/
Cj4gPgo+ID4gSSB3b3VsZCBnbyB3aXRoIHdoYXQgbG9va3MgZWFzeSBmb3IgeW91IGJ1dCBJIHRo
aW5rIEpha3ViIHdhbnRzIHRoZQo+ID4gc2VyaWVzIHRvIGdvIHdpdGggbmV4dC1uZXh0ICh0aGlz
IGlzIHdoYXQgd2UgZGlkIGluIHRoZSBwYXN0IGZvcgo+ID4gbmV0d29ya2luZyBzcGVjaWZpYyBm
ZWF0dXJlcyB0aGF0IGlzIGRvbmUgaW4gdmlydGlvLW5ldCkuIFNvIHdlIG5lZWQKPiA+IHRvIHR3
ZWFrIHRoZSBwcmVmaXggdG8gdXNlIG5ldC1uZXh0IGluc3RlYWQgb2Ygdmhvc3QuCj4gCj4gT0su
Cj4gCj4gSSB3aWxsIGZpeCB0aGF0IGluIG5leHQgdmVyc2lvbi4KPiAKPiBUaGFua3MuCgpTY2Fs
aW5nIHNjb3BlIGJhY2sgYXMgZmFyIGFzIHBvc3NpYmxlIGlzIGEgZ29vZCBpZGVhIGdlbmVyYWxs
eS4KSSBhbSBub3Qgc3VyZSBob3cgdGhpcyB3aWxsIHdvcmsgdGhvdWdoLiBMZXQncyBzZWUuCgo+
ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
