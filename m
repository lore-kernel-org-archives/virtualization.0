Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B817BC25B0E
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 04:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4434741B7E;
	Thu, 18 Aug 2022 04:34:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4434741B7E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fr+5mVDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fPWEgIhlJIQ3; Thu, 18 Aug 2022 04:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2503141B72;
	Thu, 18 Aug 2022 04:34:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2503141B72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEB06C0032;
	Thu, 18 Aug 2022 04:34:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F15C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C574961139
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:34:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C574961139
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fr+5mVDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v32KxnRnS35I
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:34:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6306660E06
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6306660E06
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660797269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTFivvm9yHWKcVUkneavFwNxYuu+2L1pR/LF0ZMw4pU=;
 b=Fr+5mVDFc6LZbisV7Pkoxe+7Id8XPzsSrL7mH+ZR2pUkyhyHpQ/ZnVs/3S0zkMlHAsD+88
 MBokZIq1HBpPpX0MXSVDAx+4GZGmIEgo1zW//MMmbqf968tKNt5xS7RrzjqGKvGuXsSP2D
 caZ+szDtEBQ7v4LRoTtjvp/p5OqV4lc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-3b7s-0ruOgu_R0CBLSBqBQ-1; Thu, 18 Aug 2022 00:34:28 -0400
X-MC-Unique: 3b7s-0ruOgu_R0CBLSBqBQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 g186-20020a636bc3000000b0041c3d64031cso292787pgc.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 21:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=TTFivvm9yHWKcVUkneavFwNxYuu+2L1pR/LF0ZMw4pU=;
 b=FVGzXQHHVtz/Bbj6tE2ktcyepFwbokx7aMIaSeII2Nqr/HnMUZ7Yc9PChdFip3T4aM
 x9qVCN6EOBccT5g34GA7L4CMhgkQ1XCsWV+DlEVJT/ZhXbvucn6Gnazya1EO4bqyqknR
 P/f3luVha4OjRbp5pG3chphQMDglppIHxVG7eEaT/ngu5B6EDdeQJeLnLIBXZ2Ok0IfQ
 Nbyypkzcd8gjHN/c6Z19rHNhk1XV7WFqWQKaNv+5rUF3rAHbafCFEK93hSemBVF3WSXp
 ZG7i2GL8JrX+SP4/wGhDW3UoHJtcGAX0rQPhRHlnwFwyo/0Y4Uok6nBIFSWgCEjvWbEf
 3zdQ==
X-Gm-Message-State: ACgBeo0j7WgJpTZvnfSURQvBpmKjW5RYKJsDNy4J2fNCchgzzc6oXgX+
 EstM+/kuJ7h/Uq1QzQVv2tTli+1HscWF62qqdF8J7tr7eFnjGNf7THqYI57ukgzZzKfKy1w0fPZ
 ZdQEYIqRt75MX1LxVrup5bMSTBQztWqJU5NGjpprrpw==
X-Received: by 2002:a63:8848:0:b0:41c:45da:2db9 with SMTP id
 l69-20020a638848000000b0041c45da2db9mr1153083pgd.206.1660797267591; 
 Wed, 17 Aug 2022 21:34:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7J3KtemYhLGoQErkrW2ImQSRRyS97OCrKf8dXjnhmz4oWC74Pc+PzZXQUPK8eeQKBWL8Ujlw==
X-Received: by 2002:a63:8848:0:b0:41c:45da:2db9 with SMTP id
 l69-20020a638848000000b0041c45da2db9mr1153060pgd.206.1660797267343; 
 Wed, 17 Aug 2022 21:34:27 -0700 (PDT)
Received: from [10.72.13.223] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a170902db0b00b001637529493esm299625plx.66.2022.08.17.21.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Aug 2022 21:34:26 -0700 (PDT)
Message-ID: <2747ac1f-390e-99f9-b24e-f179af79a9da@redhat.com>
Date: Thu, 18 Aug 2022 12:34:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 3/6] vsock: add netdev to vhost/virtio vsock
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
 <20220816123701-mutt-send-email-mst@kernel.org>
 <20220816110717.5422e976@kernel.org> <YvtAktdB09tM0Ykr@bullseye>
 <20220816160755.7eb11d2e@kernel.org> <YvtVN195TS1xpEN7@bullseye>
 <20220816181528.5128bc06@kernel.org> <Yvt2f5i5R9NNNYUL@bullseye>
 <20220817131437-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817131437-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzgvMTggMDE6MjAsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gVHVl
LCBBdWcgMTYsIDIwMjIgYXQgMTA6NTA6NTVBTSArMDAwMCwgQm9iYnkgRXNobGVtYW4gd3JvdGU6
Cj4+Pj4+IEVoLCBJIHdhcyBob3BpbmcgaXQgd2FzIGEgc2lkZSBjaGFubmVsIG9mIGFuIGV4aXN0
aW5nIHZpcnRpb19uZXQKPj4+Pj4gd2hpY2ggaXMgbm90IHRoZSBjYXNlLiBHaXZlbiB0aGUgemVy
by1jb25maWcgcmVxdWlyZW1lbnQgSURLIGlmCj4+Pj4+IHdlJ2xsIGJlIGFibGUgdG8gZml0IHRo
aXMgaW50byBuZXRkZXYgc2VtYW50aWNzIDooCj4+Pj4gSXQncyBjZXJ0YWlubHkgcG9zc2libGUg
dGhhdCBpdCBtYXkgbm90IGZpdCA6LyBJIGZlZWwgdGhhdCBpdCBwYXJ0aWFsbHkKPj4+PiBkZXBl
bmRzIG9uIHdoYXQgd2UgbWVhbiBieSB6ZXJvLWNvbmZpZy4gSXMgaXQgIm5vIGNvbmZpZyByZXF1
aXJlZCB0bwo+Pj4+IGhhdmUgYSB3b3JraW5nIHNvY2tldCIgb3IgaXMgaXQgIm5vIGNvbmZpZyBy
ZXF1aXJlZCwgYnV0IGFsc28gbm8KPj4+PiB0dW5pbmcvcG9saWN5L2V0Yy4uLiBzdXBwb3J0ZWQi
Pwo+Pj4gVGhlIHZhbHVlIG9mIHR1bmluZyB2cyBjb25mdXNpb24gb2YgYSBzdHJhbmdlIG5ldGRl
diBmbG9hdGluZyBhcm91bmQKPj4+IGluIHRoZSBzeXN0ZW0gaXMgaGFyZCB0byBlc3RpbWF0ZSB1
cGZyb250Lgo+PiBJIHRoaW5rICJhIHN0cmFuZ2UgbmV0ZGV2IGZsb2F0aW5nIGFyb3VuZCIgaXMg
YSB0b3RhbAo+PiBtaXNjaGFyYWN0ZXJpemF0aW9uLi4uIHZzb2NrIGlzIGEgbmV0d29ya2luZyBk
ZXZpY2UgYW5kIGl0IHN1cHBvcnRzCj4+IHZzb2NrIG5ldHdvcmtzLiBTdXJlLCBpdCBpcyBhIHZp
cnR1YWwgZGV2aWNlIGFuZCB0aGUgcm91dGluZyBpcyBkb25lIGluCj4+IGhvc3Qgc29mdHdhcmUs
IGJ1dCB0aGUgc2FtZSBpcyB0cnVlIGZvciB2aXJ0aW8tbmV0IGFuZCBWTS10by1WTSB2bGFuLgo+
Pgo+PiBUaGlzIHBhdGNoIGFjdHVhbGx5IHVzZXMgbmV0ZGV2IGZvciBpdHMgaW50ZW5kZWQgcHVy
cG9zZTogdG8gc3VwcG9ydCBhbmQKPj4gbWFuYWdlIHRoZSB0cmFuc21pc3Npb24gb2YgcGFja2V0
cyB2aWEgYSBuZXR3b3JrIGRldmljZSB0byBhIG5ldHdvcmsuCj4+Cj4+IEZ1cnRoZXJtb3JlLCBp
dCBhY3R1YWxseSBwcmVwYXJlcyB2c29jayB0byBlbGltaW5hdGUgYSAic3RyYW5nZSIgdXNlIG9m
Cj4+IGEgbmV0ZGV2LiBUaGUgbmV0ZGV2IGluIHZzb2NrbW9uIGlzbid0IGV2ZW4gdXNlZCB0byB0
cmFuc21pdAo+PiBwYWNrZXRzLCBpdCdzICJmbG9hdGluZyBhcm91bmQiIGZvciBubyBvdGhlciBy
ZWFzb24gdGhhbiBpdCBpcyBuZWVkZWQgdG8KPj4gc3VwcG9ydCBwYWNrZXQgY2FwdHVyZSwgd2hp
Y2ggdnNvY2sgY291bGRuJ3Qgc3VwcG9ydCBiZWNhdXNlIGl0IGRpZG4ndAo+PiBoYXZlIGEgbmV0
ZGV2Lgo+Pgo+PiBTb21ldGhpbmcgc21lbGxzIHdoZW4gd2UgYXJlIHJlcXVpcmVkIHRvIGJ1aWxk
IHdvcmthcm91bmQga2VybmVsIG1vZHVsZXMKPj4gdGhhdCB1c2UgbmV0ZGV2IGZvciBjaXBob25p
bmcgcGFja2V0cyBvZmYgdG8gdXNlcnNwYWNlLCB3aGVuIHdlIGNvdWxkCj4+IGluc3RlYWQgYmUg
dXNpbmcgbmV0ZGV2IGZvciBpdHMgaW50ZW5kZWQgcHVycG9zZSBhbmQgZ2V0IHRoZSBzYW1lIGFu
ZAo+PiBtb3JlIGJlbmVmaXQuCj4gU28gd2hhdCBoYXBwZW5zIHdoZW4gdXNlcnNwYWNlIGluZXZp
dGFibHkgYXR0ZW1wdHMgdG8gYmluZCBhIHJhdwo+IHBhY2tldCBzb2NrZXQgdG8gdGhpcyBkZXZp
Y2U/IEFzc2lnbiBpdCBhbiBJUD8gU2V0IHVwIHNvbWUgZmlyZXdhbGwKPiBydWxlcz8KPgo+IFRo
ZXNlIHRoaW5ncyBhbGwgbmVlZCB0byBiZSBhZGRyZXNzZWQgYmVmb3JlIG1lcmdpbmcgc2luY2Ug
dGhleSBhZmZlY3QgVUFQSS4KCgpJdCdzIHBvc3NpYmxlIGlmCgoxKSBleHRlbmQgdmlydGlvLW5l
dCB0byBoYXZlIHZzb2NrIHF1ZXVlcwoKMikgcHJlc2VudCB2c29jayBkZXZpY2Ugb24gdG9wIG9m
IHZpcnRpby1uZXQgdmlhIGUuZyBhdXhpbGlhcnkgYnVzCgpUaGVuIHJhdyBzb2NrZXQgc3RpbGwg
d29yayBhdCBldGhlcm5ldCBsZXZlbCB3aGlsZSB2c29jayB3b3JrcyB0b28uCgpUaGUgdmFsdWUg
aXMgdG8gc2hhcmUgY29kZXMgYmV0d2VlbiB0aGUgdHdvIHR5cGUgb2YgZGV2aWNlcyAocXVldWVz
KS4KClRoYW5rcwoKCj4KPj4+IFRoZSBuaWNlIHRoaW5nIGFib3V0IHVzaW5nIGEgYnVpbHQtaW4g
ZnEgd2l0aCBubyB1c2VyIHZpc2libGUga25vYnMgaXMKPj4+IHRoYXQgdGhlcmUncyBubyBleHRy
YSB1QVBJLiBXZSBjYW4gYWx3YXlzIHJpcCBpdCBvdXQgYW5kIHJlcGxhY2UgbGF0ZXIuCj4+PiBB
bmQgaXQgc2hvdWxkbid0IGJlIGNvbnRyb3ZlcnNpYWwsIG1ha2luZyB0aGUgcGF0aCB0byB1cHN0
cmVhbSBzbW9vdGhlci4KPj4gVGhlIGlzc3VlIGlzIHRoYXQgYWZ0ZXIgcHVsbGluZyBpbiBmcSBm
b3Igb25lIGtpbmQgb2YgZmxvdyBtYW5hZ2VtZW50LAo+PiB0aGVuIGFzIHVzZXJzIG9ic2VydmUg
b3RoZXIgZmxvdyBpc3N1ZXMsIHdlIHdpbGwgbmVlZCB0byByZS1pbXBsZW1lbnQKPj4gcGZpZm8s
IGFuZCB0aGVuIFRCRiwgYW5kIHRoZW4gd2UgbmVlZCB0byBidWlsZCBhbiBpbnRlcmZhY2UgdG8g
bGV0IHVzZXJzCj4+IHNlbGVjdCBvbmUsIGFuZCB0byBjaG9vc2UgcXVldWUgc2l6ZXMuLi4gYW5k
IHRoZW4gYWZ0ZXIgYXdoaWxlIHdlJ3ZlCj4+IG5lZWRsZXNzbHkgcmUtaW1wbGVtZW50ZWQgaHVn
ZSBjaHVua3Mgb2YgdGhlIHRjIHN5c3RlbS4KPj4KPj4gSSBkb24ndCBzZWUgYW55IGdvb2QgcmVh
c29uIHRvIHJlc3RyaWN0IHZzb2NrIHVzZXJzIHRvIHVzaW5nIHN1Ym9wdGltYWwKPj4gYW5kIHJp
Z2lkIHF1ZXVpbmcuCj4+Cj4+IFRoYW5rcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
