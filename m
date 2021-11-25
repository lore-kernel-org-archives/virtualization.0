Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814B0C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 12:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0D6060716;
	Thu, 25 Nov 2021 12:04:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9y_ZelgcEqC; Thu, 25 Nov 2021 12:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D7BE6067A;
	Thu, 25 Nov 2021 12:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22FE9C001C;
	Thu, 25 Nov 2021 12:04:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BFE5C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 12:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0DFF400F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 12:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QlSp9rNa_QaN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 12:04:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5561400F0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637841882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3pVl0kkbRL9wlqXrxeUcmJA6blq5l7kvBORl/ZbdwE=;
 b=CxZTRGsYb5U8mFFaZxJ0x4nE3COnzZ6elVzQTdfHCcSCRtyaKg+nFJfMcOmYfNenEv2RiD
 mqN9KlXxLbctBvkgwx6jnh7xFDrE57UJotm/wIeYkZht39eJgSfe66xaE7qq0TijZADsFb
 WRt97x8Rt+OiObbGjTU+BT3z60IjWi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-p8NDlZe4PfC7_v_1qa6qaQ-1; Thu, 25 Nov 2021 07:04:39 -0500
X-MC-Unique: p8NDlZe4PfC7_v_1qa6qaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79E1100C663;
 Thu, 25 Nov 2021 12:04:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B07518171;
 Thu, 25 Nov 2021 12:04:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1E7DD180092A; Thu, 25 Nov 2021 13:04:25 +0100 (CET)
Date: Thu, 25 Nov 2021 13:04:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211125120425.s7kzzuvtdhqgyf3g@sirius.home.kraxel.org>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
 <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
 <58911901bd7b4bc3a99642214106bc2f@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58911901bd7b4bc3a99642214106bc2f@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "srutherford@google.com" <srutherford@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "Kleen,
 Andi" <andi.kleen@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gVGh1LCBOb3YgMjUsIDIwMjEgYXQgMDg6NDM6NTVBTSArMDAwMCwgV2FuZywgV2VpIFcgd3Jv
dGU6Cj4gT24gVGh1cnNkYXksIE5vdmVtYmVyIDI1LCAyMDIxIDI6MzggUE0sIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+IFdlIHRob3VnaHQgYWJvdXQgdmlydGlvLW1taW8uIFRoZXJlIGFyZSBzb21l
IGJhcnJpZXJzOgo+ID4gPiAxKSBJdCB3YXNuJ3Qgb3JpZ2luYWxseSBpbnRlbmRlZCBmb3IgeDg2
IG1hY2hpbmVzLiBUaGUgb25seSBtYWNoaW5lCj4gPiA+IHR5cGUgaW4gUUVNVSB0aGF0IHN1cHBv
cnRzIGl0ICh0byBydW4gb24geDg2KSBpcyBtaWNyb3ZtLiBCdXQKPiA+ID4gIm1pY3Jvdm0iIGRv
ZXNu4oCZdCBzdXBwb3J0IFREWCBjdXJyZW50bHksIGFuZCBhZGRpbmcgdGhpcyBzdXBwb3J0IG1p
Z2h0Cj4gPiBuZWVkIGxhcmdlciBlZmZvcnQuCj4gPiAKPiA+IENhbiB5b3UgZXhwbGFpbiB3aHkg
bWljcm92bSBuZWVkcyBsYXJnZXIgZWZmb3J0PyBJdCBsb29rcyB0byBtZSBpdCBmaXRzIGZvciBU
RFgKPiA+IHBlcmZlY3RseSBzaW5jZSBpdCBoYXMgbGVzcyBhdHRhY2sgc3VyZmFjZS4KPiAKPiBU
aGUgbWFpbiB0aGluZyBpcyBURFZGIGRvZXNu4oCZdCBzdXBwb3J0IG1pY3Jvdm0gc28gZmFyICh0
aGUgYmFzZWQgT1ZNRgo+IHN1cHBvcnQgZm9yIG1pY3Jvdm0gaXMgc3RpbGwgdW5kZXIgdGhlaXIg
Y29tbXVuaXR5IGRpc2N1c3Npb24pLgoKSW5pdGlhbCBtaWNyb3ZtIHN1cHBvcnQgKGRpcmVjdCBr
ZXJuZWwgYm9vdCBvbmx5KSBpcyBtZXJnZWQgaW4gdXBzdHJlYW0KT1ZNRi4gIEJldHRlciBkZXZp
Y2Ugc3VwcG9ydCBpcyB1bmRlcndheTogdmlydGlvLW1taW8gcGF0Y2hlcyBhcmUgb3V0CmZvciBy
ZXZpZXcsIHBhdGNoZXMgZm9yIHBjaWUgc3VwcG9ydCBleGlzdC4KClREWCBwYXRjaGVzIGZvciBP
Vk1GIGFyZSB1bmRlciByZXZpZXcgdXBzdHJlYW0sIEkgaGF2bid0IG5vdGljZWQKYW55dGhpbmcg
d2hpY2ggd291bGQgYmUgYSBibG9ja2VyIGZvciBtaWNyb3ZtLiAgSWYgaXQgZG9lc24ndCB3b3Jr
Cm91dC1vZi10aGUtYm94IGl0IHNob3VsZCBiZSBtb3N0bHkgd2lyaW5nIHVwIHRoaW5ncyBuZWVk
ZWQgb24gZ3Vlc3QKKG92bWYpIGFuZC9vciBob3N0IChxZW11KSBzaWRlLgoKKHNhbWUgZ29lcyBm
b3Igc2V2IGJ0dykuCgo+IERvIHlvdSBndXlzIHRoaW5rIGl0IGlzIHBvc3NpYmxlIHRvIGFkZCB2
aXJ0aW8tbW1pbyBzdXBwb3J0IGZvciBxMzU/Cj4gKGUuZy4gY3JlYXRlIGEgc3BlY2lhbCBwbGF0
Zm9ybSBidXMgaW4gc29tZSBmYXNoaW9uIGZvciBtZW1vcnkgbWFwcGVkIGRldmljZXMpCj4gTm90
IHN1cmUgaWYgdGhlIGVmZm9ydCB3b3VsZCBiZSBsYXJnZXIuCgpJJ2QgcmF0aGVyIGV4cGxvcmUg
dGhlIG1pY3Jvdm0gcGF0aCB0aGFuIG1ha2luZyBxMzUgZXZlbiBtb3JlCmZyYW5rZW5zdGVpbiB0
aGFuIGl0IGFscmVhZHkgaXMuCgpBbHNvIHRoZSBwY2llIGhvc3QgYnJpZGdlIGlzIHByZXNlbnQg
aW4gcTM1IG5vIG1hdHRlciB3aGF0LCBzbyBvbmUgb2YKdGhlIHJlYXNvbnMgdG8gdXNlIHZpcnRp
by1tbWlvICgid2UgY2FuIHJlZHVjZSB0aGUgYXR0YWNoIHN1cmZhY2UgYnkKdHVybmluZyBvZmYg
cGNpZSIpIGdvZXMgYXdheS4KCnRha2UgY2FyZSwKICBHZXJkCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
