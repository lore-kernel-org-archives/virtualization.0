Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1F5C61DA4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 03:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B20E410D3;
	Mon,  6 Mar 2023 03:40:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B20E410D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GZLPMUkF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ANSd96S41BX; Mon,  6 Mar 2023 03:40:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 316BC4091C;
	Mon,  6 Mar 2023 03:40:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 316BC4091C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 096A2C0071;
	Mon,  6 Mar 2023 03:40:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F289C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BD99410D3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:40:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BD99410D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4okX_lQGy8UE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:39:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 839F04091C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 839F04091C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 03:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678073997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2raSa3hUXrD0UxgB5JD2asiwlzXPJgZKFQwSYhV7VHo=;
 b=GZLPMUkF7RK2EVnIUJl/lBkRYfTjx3jxOdqfrFG9ml2iCFna7eyfNcARulr7obBZ3iPjNI
 5AqnHrWUBYVz5h0lquFwHNdnX2x5zqeoV1Ugf3yavJBReZrNMgDiyjooZz5sEED14e+zmY
 S4QhTJB06Tvvf4ybZMOPL0mbsGnzCMA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-myNHKpS_Ph6AIRutBfdJrw-1; Sun, 05 Mar 2023 22:39:56 -0500
X-MC-Unique: myNHKpS_Ph6AIRutBfdJrw-1
Received: by mail-oo1-f70.google.com with SMTP id
 e137-20020a4a558f000000b0051a14b3d779so2466546oob.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Mar 2023 19:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678073995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2raSa3hUXrD0UxgB5JD2asiwlzXPJgZKFQwSYhV7VHo=;
 b=sozSN1o5HHz5jMRR7RFfdTwJMDo6JAsTrjV0VQVrPoTL3tEpdo3yRTJW8n/x7UJLIt
 7kF4qjFzRr4GkoYMePaxf1w4zauTh/M8ePKq547nNwP9Z8o4euRaMoVKFrAL0rM4ZpGo
 j+TFJW7+XL0Q9+FWSiz27GS6X4wRMitpZa36Fbc1nigwAyrXWpCYdvpDdf0hPLwvNBuk
 v02d2sT/gy023F3LXfKRPJuYHBIwu3wr6avXbNH2iBKlPLqLjXCdntdHrYQdlPyBJNBv
 vQ2Om64V9RNpNhFAeV7HDi1iguKiB6GLsY/anJ5eCZOKFL+JNqTqY30evwLcs2KmHKG+
 5rbw==
X-Gm-Message-State: AO0yUKVU+lOa43GBg6pAltUum0SJwua8BZqjgmZc9TMkNM6RN+HcmIBN
 Q2RMAo4PB9QhuBG1nBcAmAcHlRXUMBaAb9AVms9kh0EbDGKtT40Erex0H+3GPXUS/Wftw4j+xL5
 UzKB/YLAomkRNYGGwCfmNwfeY4TIqHMty5GhyDGw0w908hxdbHryc1FZJiw==
X-Received: by 2002:a05:6808:143:b0:383:fef9:6cac with SMTP id
 h3-20020a056808014300b00383fef96cacmr3010763oie.9.1678073995469; 
 Sun, 05 Mar 2023 19:39:55 -0800 (PST)
X-Google-Smtp-Source: AK7set+NvN/Yhk2koNFmx2bScLZ46uREUzaqxEZnnpvOmqWcUrK4gI747FAPVMXfQqCfUURXUHiB+nsMAQFXT0Pcw/w=
X-Received: by 2002:a05:6808:143:b0:383:fef9:6cac with SMTP id
 h3-20020a056808014300b00383fef96cacmr3010754oie.9.1678073995222; Sun, 05 Mar
 2023 19:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20230305154942.1770925-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230305154942.1770925-1-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Mar 2023 11:39:44 +0800
Message-ID: <CACGkMEuc_MtVpM2bJH20dmXC30Po8Fbd2Y-xv-Q=O13=pLSLpA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: unify notifications coalescing structs
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gU3VuLCBNYXIgNSwgMjAyMyBhdCAxMTo0OeKAr1BNIEFsdmFybyBLYXJzeiA8YWx2YXJvLmth
cnN6QHNvbGlkLXJ1bi5jb20+IHdyb3RlOgo+Cj4gVW5pZnkgdmlydGlvX25ldF9jdHJsX2NvYWxf
dHggYW5kIHZpcnRpb19uZXRfY3RybF9jb2FsX3J4IHN0cnVjdHMgaW50byBhCj4gc2luZ2xlIHN0
cnVjdCwgdmlydGlvX25ldF9jdHJsX2NvYWwsIGFzIHRoZXkgYXJlIGlkZW50aWNhbC4KPgo+IFRo
aXMgcGF0Y2ggZm9sbG93cyB0aGUgVmlydElPIHNwZWMgcGF0Y2g6Cj4gaHR0cHM6Ly9saXN0cy5v
YXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDIvbXNnMDA0MzEuaHRt
bAo+Cj4gU2lnbmVkLW9mZi1ieTogQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fyc3pAc29saWQtcnVu
LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jICAgICAgICB8IDE1ICsrKysr
KystLS0tLS0tLQo+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIHwgMjQgKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MjUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggZmI1ZTY4ZWQzZWMuLjg2YjZiM2Uw
MjU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0yODgzLDEyICsyODgzLDExIEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9zZW5kX25vdGZfY29hbF9jbWRzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBldGh0b29sX2NvYWxl
c2NlICplYykKPiAgewo+ICAgICAgICAgc3RydWN0IHNjYXR0ZXJsaXN0IHNnc190eCwgc2dzX3J4
Owo+IC0gICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9jb2FsX3R4IGNvYWxfdHg7Cj4gLSAg
ICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX2NvYWxfcnggY29hbF9yeDsKPiArICAgICAgIHN0
cnVjdCB2aXJ0aW9fbmV0X2N0cmxfY29hbCBjb2FsX3BhcmFtczsKPgo+IC0gICAgICAgY29hbF90
eC50eF91c2VjcyA9IGNwdV90b19sZTMyKGVjLT50eF9jb2FsZXNjZV91c2Vjcyk7Cj4gLSAgICAg
ICBjb2FsX3R4LnR4X21heF9wYWNrZXRzID0gY3B1X3RvX2xlMzIoZWMtPnR4X21heF9jb2FsZXNj
ZWRfZnJhbWVzKTsKPiAtICAgICAgIHNnX2luaXRfb25lKCZzZ3NfdHgsICZjb2FsX3R4LCBzaXpl
b2YoY29hbF90eCkpOwo+ICsgICAgICAgY29hbF9wYXJhbXMubWF4X3VzZWNzID0gY3B1X3RvX2xl
MzIoZWMtPnR4X2NvYWxlc2NlX3VzZWNzKTsKPiArICAgICAgIGNvYWxfcGFyYW1zLm1heF9wYWNr
ZXRzID0gY3B1X3RvX2xlMzIoZWMtPnR4X21heF9jb2FsZXNjZWRfZnJhbWVzKTsKPiArICAgICAg
IHNnX2luaXRfb25lKCZzZ3NfdHgsICZjb2FsX3BhcmFtcywgc2l6ZW9mKGNvYWxfcGFyYW1zKSk7
Cj4KPiAgICAgICAgIGlmICghdmlydG5ldF9zZW5kX2NvbW1hbmQodmksIFZJUlRJT19ORVRfQ1RS
TF9OT1RGX0NPQUwsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19O
RVRfQ1RSTF9OT1RGX0NPQUxfVFhfU0VULAo+IEBAIC0yODk5LDkgKzI4OTgsOSBAQCBzdGF0aWMg
aW50IHZpcnRuZXRfc2VuZF9ub3RmX2NvYWxfY21kcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwK
PiAgICAgICAgIHZpLT50eF91c2VjcyA9IGVjLT50eF9jb2FsZXNjZV91c2VjczsKPiAgICAgICAg
IHZpLT50eF9tYXhfcGFja2V0cyA9IGVjLT50eF9tYXhfY29hbGVzY2VkX2ZyYW1lczsKPgo+IC0g
ICAgICAgY29hbF9yeC5yeF91c2VjcyA9IGNwdV90b19sZTMyKGVjLT5yeF9jb2FsZXNjZV91c2Vj
cyk7Cj4gLSAgICAgICBjb2FsX3J4LnJ4X21heF9wYWNrZXRzID0gY3B1X3RvX2xlMzIoZWMtPnJ4
X21heF9jb2FsZXNjZWRfZnJhbWVzKTsKPiAtICAgICAgIHNnX2luaXRfb25lKCZzZ3NfcngsICZj
b2FsX3J4LCBzaXplb2YoY29hbF9yeCkpOwo+ICsgICAgICAgY29hbF9wYXJhbXMubWF4X3VzZWNz
ID0gY3B1X3RvX2xlMzIoZWMtPnJ4X2NvYWxlc2NlX3VzZWNzKTsKPiArICAgICAgIGNvYWxfcGFy
YW1zLm1heF9wYWNrZXRzID0gY3B1X3RvX2xlMzIoZWMtPnJ4X21heF9jb2FsZXNjZWRfZnJhbWVz
KTsKPiArICAgICAgIHNnX2luaXRfb25lKCZzZ3NfcngsICZjb2FsX3BhcmFtcywgc2l6ZW9mKGNv
YWxfcGFyYW1zKSk7Cj4KPiAgICAgICAgIGlmICghdmlydG5ldF9zZW5kX2NvbW1hbmQodmksIFZJ
UlRJT19ORVRfQ1RSTF9OT1RGX0NPQUwsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFZJUlRJT19ORVRfQ1RSTF9OT1RGX0NPQUxfUlhfU0VULAo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19u
ZXQuaAo+IGluZGV4IGI0MDYyYmVkMTg2Li5jZTA0NDI2MGUwMiAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19uZXQuaAo+IEBAIC0zNjcsMjggKzM2NywxOCBAQCBzdHJ1Y3QgdmlydGlvX25ldF9oYXNo
X2NvbmZpZyB7Cj4gICAqIEF2YWlsYWJsZSB3aXRoIHRoZSBWSVJUSU9fTkVUX0ZfTk9URl9DT0FM
IGZlYXR1cmUgYml0Lgo+ICAgKi8KPiAgI2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfTk9URl9DT0FM
ICAgICAgICAgICAgICA2Cj4gLS8qCj4gLSAqIFNldCB0aGUgdHgtdXNlY3MvdHgtbWF4LXBhY2tl
dHMgcGFyYW1ldGVycy4KPiAtICovCj4gLXN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfY29hbF90eCB7
Cj4gLSAgICAgICAvKiBNYXhpbXVtIG51bWJlciBvZiBwYWNrZXRzIHRvIHNlbmQgYmVmb3JlIGEg
VFggbm90aWZpY2F0aW9uICovCj4gLSAgICAgICBfX2xlMzIgdHhfbWF4X3BhY2tldHM7Cj4gLSAg
ICAgICAvKiBNYXhpbXVtIG51bWJlciBvZiB1c2VjcyB0byBkZWxheSBhIFRYIG5vdGlmaWNhdGlv
biAqLwo+IC0gICAgICAgX19sZTMyIHR4X3VzZWNzOwo+IC19OwoKSXMgdGhpcyB0b28gbGF0ZSB0
byBiZSBjaGFuZ2VkPwoKVGhhbmtzCgo+IC0KPiAtI2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfTk9U
Rl9DT0FMX1RYX1NFVCAgICAgICAgICAgICAgIDAKPgo+ICAvKgo+IC0gKiBTZXQgdGhlIHJ4LXVz
ZWNzL3J4LW1heC1wYWNrZXRzIHBhcmFtZXRlcnMuCj4gKyAqIFNldCB0aGUgbWF4X3VzZWNzL21h
eF9wYWNrZXRzIGNvYWxlc2NpbmcgcGFyYW1ldGVycyBmb3IgYWxsIHRyYW5zbWl0L3JlY2VpdmUg
dmlydHF1ZXVlcy4KPiAgICovCj4gLXN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfY29hbF9yeCB7Cj4g
LSAgICAgICAvKiBNYXhpbXVtIG51bWJlciBvZiBwYWNrZXRzIHRvIHJlY2VpdmUgYmVmb3JlIGEg
Ulggbm90aWZpY2F0aW9uICovCj4gLSAgICAgICBfX2xlMzIgcnhfbWF4X3BhY2tldHM7Cj4gLSAg
ICAgICAvKiBNYXhpbXVtIG51bWJlciBvZiB1c2VjcyB0byBkZWxheSBhIFJYIG5vdGlmaWNhdGlv
biAqLwo+IC0gICAgICAgX19sZTMyIHJ4X3VzZWNzOwo+ICtzdHJ1Y3QgdmlydGlvX25ldF9jdHJs
X2NvYWwgewo+ICsgICAgICAgLyogTWF4aW11bSBudW1iZXIgb2YgcGFja2V0cyB0byBzZW5kL3Jl
Y2VpdmUgYmVmb3JlIGEgVFgvUlggbm90aWZpY2F0aW9uICovCj4gKyAgICAgICBfX2xlMzIgbWF4
X3BhY2tldHM7Cj4gKyAgICAgICAvKiBNYXhpbXVtIG51bWJlciBvZiBtaWNyb3NlY29uZHMgdG8g
ZGVsYXkgYSBUWC9SWCBub3RpZmljYXRpb24gKi8KPiArICAgICAgIF9fbGUzMiBtYXhfdXNlY3M7
Cj4gIH07Cj4KPiArI2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfTk9URl9DT0FMX1RYX1NFVCAgICAg
ICAgICAgICAgIDAKPiAgI2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfTk9URl9DT0FMX1JYX1NFVCAg
ICAgICAgICAgICAgIDEKPgo+ICAjZW5kaWYgLyogX1VBUElfTElOVVhfVklSVElPX05FVF9IICov
Cj4gLS0KPiAyLjM0LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
