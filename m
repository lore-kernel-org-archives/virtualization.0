Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A69BC07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 13:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A82261019;
	Tue, 27 Sep 2022 13:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A82261019
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bhzQleTH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qiw_2fIbR7Fw; Tue, 27 Sep 2022 13:50:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1448560B10;
	Tue, 27 Sep 2022 13:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1448560B10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D221BC0032;
	Tue, 27 Sep 2022 13:50:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1F0BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 13:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCAE0403AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 13:50:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCAE0403AC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bhzQleTH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lUdO4VWhwk13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 13:50:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F33D34051D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F33D34051D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664286609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofqCX7PnDwCH2641aVSgoebhxmiEcI1UVFpct2yGqJc=;
 b=bhzQleTHu30qw65vffS5qJ6dNJ15NeK4DLmTdEzzVxEEKOWdHbx3waAsSDZ3z56IJ3CN2p
 wGOlq+2L8YIqgNxHcduLAPEELBJNVcPgR0hAHNS51t5OlauoaHC8oikU2PZMzgn2GgMRxJ
 Ml6gv9gppTQ4kqkCXgQInAtM281PtzE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130-EoiPfRCaOVycxFzKt9ilpw-1; Tue, 27 Sep 2022 09:50:01 -0400
X-MC-Unique: EoiPfRCaOVycxFzKt9ilpw-1
Received: by mail-qt1-f197.google.com with SMTP id
 g21-20020ac87d15000000b0035bb6f08778so6767761qtb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 06:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date;
 bh=ofqCX7PnDwCH2641aVSgoebhxmiEcI1UVFpct2yGqJc=;
 b=Rzlg1kkYFKA33o9jaIRXARa+lAPiAXqT5H9GGMzWr9kAsVwJ+jjfzxid1kllaNRW8E
 lIFv9cUV9v6kvMHorg9qP7yEjpt2edmxgPhJrBjzwZezdDbJMYoFJpvGo0RLaevsQVSl
 TFviTgEftYAayIbJT/JNKILP7en8o6gJ6kv5nAZGiqKPfQjcXuIh96sDQtMAR/zvVo3s
 oyjwQ6JOfSc05XDdY0sXWX/fiql1VwtedVje0W1qQ1cK1reyOtEpPgSQv6nDBB9DVo2W
 RNeY1gSd+vKDx9+Mb0iSOUIjb5OZxVwlQxQqhwuQFUxQic/DbWQoNKlyIgxAz6BaP6lo
 kVyw==
X-Gm-Message-State: ACrzQf26vGtCz5vpvXLNhmdefJ9KRUsQeDq+kN+uh9WA7Lv6YcxlvckM
 Nn3KETE/tNRJZXCR9fMQyMBVuWZher5q7nzcAIadfl1yBOJ8GcDNUFlq7of+JiqHTy4oiSm5j9b
 esqs0mgIvKByjnRCn3sLiqQtGLnrDE3U4yrxiFvq3qg==
X-Received: by 2002:ac8:7dc7:0:b0:35c:c050:16aa with SMTP id
 c7-20020ac87dc7000000b0035cc05016aamr22041919qte.455.1664286600562; 
 Tue, 27 Sep 2022 06:50:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7c0Ohy85DoU6iQp5X+btljELCKn/uXSAjNiHTKbhnRxjc5Y3nT0n3WTDb8R9S/7JggYSEMwg==
X-Received: by 2002:ac8:7dc7:0:b0:35c:c050:16aa with SMTP id
 c7-20020ac87dc7000000b0035cc05016aamr22041898qte.455.1664286600331; 
 Tue, 27 Sep 2022 06:50:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it.
 [146.241.104.40]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05620a255000b006b98315c6fbsm1038185qko.1.2022.09.27.06.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 06:49:59 -0700 (PDT)
Message-ID: <7fef56880d40b9d83cc99317df9060c4e7cdf919.camel@redhat.com>
Subject: Re: [PATCH net-next 0/4] shrink struct ubuf_info
From: Paolo Abeni <pabeni@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Sep 2022 15:49:55 +0200
In-Reply-To: <cover.1663892211.git.asml.silence@gmail.com>
References: <cover.1663892211.git.asml.silence@gmail.com>
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

SGVsbG8sCgpPbiBGcmksIDIwMjItMDktMjMgYXQgMTc6MzkgKzAxMDAsIFBhdmVsIEJlZ3Vua292
IHdyb3RlOgo+IHN0cnVjdCB1YnVmX2luZm8gaXMgbGFyZ2UgYnV0IG5vdCBhbGwgZmllbGRzIGFy
ZSBuZWVkZWQgZm9yIGFsbAo+IGNhc2VzLiBXZSBoYXZlIGxpbWl0ZWQgc3BhY2UgaW4gaW9fdXJp
bmcgZm9yIGl0IGFuZCBsYXJnZSB1YnVmX2luZm8KPiBwcmV2ZW50cyBzb21lIHN0cnVjdCBlbWJl
ZGRpbmcsIGV2ZW4gdGhvdWdoIHdlIHVzZSBvbmx5IGEgc3Vic2V0Cj4gb2YgdGhlIGZpZWxkcy4g
SXQncyBhbHNvIG5vdCB2ZXJ5IGNsZWFuIHRyeWluZyB0byB1c2UgdGhpcyB0eXBlbGVzcwo+IGV4
dHJhIHNwYWNlLgo+IAo+IFNocmluayBzdHJ1Y3QgdWJ1Zl9pbmZvIHRvIG9ubHkgbmVjZXNzYXJ5
IGZpZWxkcyB1c2VkIGluIGdlbmVyaWMgcGF0aHMsCj4gbmFtZWx5IC0+Y2FsbGJhY2ssIC0+cmVm
Y250IGFuZCAtPmZsYWdzLCB3aGljaCB0YWtlIG9ubHkgMTYgYnl0ZXMuIEFuZAo+IG1ha2UgTVNH
X1pFUk9DT1BZIGFuZCBzb21lIG90aGVyIHVzZXJzIHRvIGVtYmVkIGl0IGludG8gYSBsYXJnZXIg
c3RydWN0Cj4gdWJ1Zl9pbmZvX21zZ3pjIG1pbWlja2luZyB0aGUgZm9ybWVyIHVidWZfaW5mby4K
PiAKPiBOb3RlLCB4ZW4vdmhvc3QgbWF5IGFsc28gaGF2ZSBzb21lIGNsZWFuaW5nIG9uIHRvcCBi
eSBjcmVhdGluZwo+IG5ldyBzdHJ1Y3RzIGNvbnRhaW5pbmcgdWJ1Zl9pbmZvIGJ1dCB3aXRoIHBy
b3BlciB0eXBlcy4KClRoYXQgc291bmRzIGEgYml0IHNjYXJpbmcgdG8gbWUuIElmIEkgcmVhZCBj
b3JyZWN0bHksIGV2ZXJ5IHVhcmcgdXNlcgpzaG91bGQgY2hlY2sgJ3VhcmctPmNhbGxiYWNrID09
IG1zZ196ZXJvY29weV9jYWxsYmFjaycgYmVmb3JlIGFjY2Vzc2luZwphbnkgJ2V4dGVuZCcgZmll
bGRzLiBBRkFJQ1MgdGhlIGN1cnJlbnQgY29kZSBzb21ldGltZXMgZG9uJ3QgZG8gdGhlCmV4cGxp
Y2l0IHRlc3QgYmVjYXVzZSB0aGUgY29uZGl0aW9uIGlzIHNvbWV3aGF0IGltcGxpZWQsIHdoaWNo
IGluIHR1cm4KaXMgcXVpdGUgaGFyZCB0byB0cmFjay7CoAoKY2xlYXJpbmcgdWFyZy0+emVyb2Nv
cHkgZm9yIHRoZSAnd3JvbmcnIHVhcmcgd2FzIGFybWxlc3MgYW5kIHVuZGV0ZWN0ZWQKYmVmb3Jl
IHRoaXMgc2VyaWVzLCBhbmQgYWZ0ZXIgd2lsbCB0cmlnZ2VyIGFuIG9vcHMuLgoKVGhlcmUgaXMg
c29tZSBub2lzZSBkdWUgdG8gdWFyZyAtPiB1YXJnX3pjIHJlbmFtaW5nIHdoaWNoIG1ha2UgdGhl
CnNlcmllcyBoYXJkZXIgdG8gcmV2aWV3LiBIYXZlIHlvdSBjb25zaWRlcmVkIGluc3RlYWQga2Vl
cGluZyB0aGUgb2xkCm5hbWUgYW5kIGludHJvZHVjaW5nIGEgc21hbGxlciAnc3RydWN0IHVidWZf
aW5mb19jb21tb24nPyB0aGUgb3ZlcmFsbApjb2RlIHNob3VsZCBiZSBtb3N0bHkgdGhlIHNhbWUs
IGJ1dCBpdCB3aWxsIGF2b2lkIHRoZSBhYm92ZSBtZW50aW9uZWQKbm9pc2UuCgpUaGFua3MhCgpQ
YW9sbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
