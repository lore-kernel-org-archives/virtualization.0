Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C00C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:39:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C33664DF0
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C33664DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D69086256;
	Thu, 18 Feb 2021 05:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xpDClXgMN0Nv; Thu, 18 Feb 2021 05:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A21D86239;
	Thu, 18 Feb 2021 05:39:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62EDAC000E;
	Thu, 18 Feb 2021 05:39:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C3D8C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DF396003C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Onv55TutbtH7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:39:39 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 54714605A1; Thu, 18 Feb 2021 05:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31D6E6058F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613626775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhTlxA1FLz1h5UBYFU/B2CUChRQ+ZuRS8//lQ8J+LZ4=;
 b=RfmzTJYOPHCxm3c+cZcOw+z23QO3sYwVfddk7YEiZGpl+UGpWvkdP/ySfVDLU/EX2Bhpn7
 yoeWw4K1vNoBgsqpL5W5O3HP0L5zHET0BV5jJRTwyb4FXUzMdNkE2fW5SNmFBZtxPNMgKN
 YdNmkkegpKm+htQIGSicqRwkBcw00ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-IXJnW8ceNM2IaYZxlPlt1A-1; Thu, 18 Feb 2021 00:39:31 -0500
X-MC-Unique: IXJnW8ceNM2IaYZxlPlt1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CDCE100830D;
 Thu, 18 Feb 2021 05:39:30 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C32B5C730;
 Thu, 18 Feb 2021 05:39:21 +0000 (UTC)
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <weiwan@google.com>
References: <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
 <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
 <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
 <9b0b8f2a-8476-697e-9002-e9947e3eab63@redhat.com>
 <CA+FuTScVOuoHKtrdrRFswjA3Zq1-7sgMVhnP2iMB5sYFFS8NFg@mail.gmail.com>
 <50ae0b71-df87-f26c-8b4d-8035f9f6a58d@redhat.com>
 <CAF=yD-J5-60D=JDwvpecjaO6J03SZHoHJyCsR3B1HbP1-jbqng@mail.gmail.com>
 <00de1b0f-f2aa-de54-9c7e-472643400417@redhat.com>
 <CAF=yD-K9xTBStGR5BEiS6WZd=znqM_ENcj9_nb=rrpcMORqE8g@mail.gmail.com>
 <CAEA6p_Bi1OMTas0W4VuxAMz8Frf+vBNc8c7xCDUxb_uwUy8Zgw@mail.gmail.com>
 <20210210040802-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b077d6c-aeca-8266-4579-fae02c8b31de@redhat.com>
Date: Thu, 18 Feb 2021 13:39:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210040802-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
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

Ck9uIDIwMjEvMi8xMCDkuIvljYg1OjE0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VHVlLCBGZWIgMDksIDIwMjEgYXQgMTA6MDA6MjJBTSAtMDgwMCwgV2VpIFdhbmcgd3JvdGU6Cj4+
IE9uIFR1ZSwgRmViIDksIDIwMjEgYXQgNjo1OCBBTSBXaWxsZW0gZGUgQnJ1aWpuCj4+IDx3aWxs
ZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToKPj4+Pj4+PiBJIGhhdmUgbm8gcHJl
ZmVyZW5jZS4gSnVzdCBjdXJpb3VzLCBlc3BlY2lhbGx5IGlmIGl0IGNvbXBsaWNhdGVzIHRoZSBw
YXRjaC4KPj4+Pj4+Pgo+Pj4+Pj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LiBJdCdzIHByb2Jh
Ymx5IG9rIGZvciBuZXQuIEJ1dCB3ZSBwcm9iYWJseSBuZWVkCj4+Pj4+PiB0byBkb2N1bWVudCB0
aGUgYXNzdW1wdGlvbnMgdG8gbWFrZSBzdXJlIGl0IHdhcyBub3QgYWJ1c2VkIGluIG90aGVyIGRy
aXZlcnMuCj4+Pj4+Pgo+Pj4+Pj4gSW50cm9kdWNlIG5ldyBwYXJhbWV0ZXJzIGZvciBmaW5kX3Zx
cygpIGNhbiBoZWxwIHRvIGVsaW1pbmF0ZSB0aGUgc3VidGxlCj4+Pj4+PiBzdHVmZnMgYnV0IEkg
YWdyZWUgaXQgbG9va3MgbGlrZSBhIG92ZXJraWxsLgo+Pj4+Pj4KPj4+Pj4+IChCdHcsIEkgZm9y
Z2V0IHRoZSBudW1iZXJzIGJ1dCB3b25kZXIgaG93IG11Y2ggZGlmZmVyZW5jZSBpZiB3ZSBzaW1w
bGUKPj4+Pj4+IHJlbW92ZSB0aGUgZnJlZV9vbGRfeG1pdHMoKSBmcm9tIHRoZSByeCBOQVBJIHBh
dGg/KQo+Pj4+PiBUaGUgY29tbWl0dGVkIHBhdGNoc2V0IGRpZCBub3QgcmVjb3JkIHRob3NlIG51
bWJlcnMsIGJ1dCBJIGZvdW5kIHRoZW0KPj4+Pj4gaW4gYW4gZWFybGllciBpdGVyYXRpb246Cj4+
Pj4+Cj4+Pj4+ICAgICBbUEFUQ0ggbmV0LW5leHQgMC8zXSB2aXJ0aW8tbmV0IHR4IG5hcGkKPj4+
Pj4gICAgIGh0dHBzOi8vbGlzdHMub3BlbndhbGwubmV0L25ldGRldi8yMDE3LzA0LzAyLzU1Cj4+
Pj4+Cj4+Pj4+IEl0IGRpZCBzZWVtIHRvIHNpZ25pZmljYW50bHkgcmVkdWNlIGNvbXB1dGUgY3lj
bGVzICgiR2N5YyIpIGF0IHRoZQo+Pj4+PiB0aW1lLiBGb3IgaW5zdGFuY2U6Cj4+Pj4+Cj4+Pj4+
ICAgICAgIFRDUF9SUiBMYXRlbmN5ICh1cyk6Cj4+Pj4+ICAgICAgIDF4Ogo+Pj4+PiAgICAgICAg
IHA1MCAgICAgICAgICAgICAgMjQgICAgICAgMjQgICAgICAgMjEKPj4+Pj4gICAgICAgICBwOTkg
ICAgICAgICAgICAgIDI3ICAgICAgIDI3ICAgICAgIDI3Cj4+Pj4+ICAgICAgICAgR2N5Y2xlcyAg
ICAgICAgIDI5OSAgICAgIDQzMiAgICAgIDMwOAo+Pj4+Pgo+Pj4+PiBJJ20gY29uY2VybmVkIHRo
YXQgcmVtb3ZpbmcgaXQgbm93IG1heSBjYXVzZSBhIHJlZ3Jlc3Npb24gcmVwb3J0IGluIGEKPj4+
Pj4gZmV3IG1vbnRocy4gVGhhdCBpcyBoaWdoZXIgcmlzayB0aGFuIHRoZSBzcHVyaW91cyBpbnRl
cnJ1cHQgd2FybmluZwo+Pj4+PiB0aGF0IHdhcyBvbmx5IHJlcG9ydGVkIGFmdGVyIHllYXJzIG9m
IHVzZS4KPj4+Pgo+Pj4+IFJpZ2h0Lgo+Pj4+Cj4+Pj4gU28gaWYgTWljaGFlbCBpcyBmaW5lIHdp
dGggdGhpcyBhcHByb2FjaCwgSSdtIG9rIHdpdGggaXQuIEJ1dCB3ZQo+Pj4+IHByb2JhYmx5IG5l
ZWQgdG8gYSBUT0RPIHRvIGludmVudCB0aGUgaW50ZXJydXB0IGhhbmRsZXJzIHRoYXQgY2FuIGJl
Cj4+Pj4gdXNlZCBmb3IgbW9yZSB0aGFuIG9uZSB2aXJ0cXVldWVzLiBXaGVuIE1TSS1YIGlzIGVu
YWJsZWQsIHRoZSBpbnRlcnJ1cHQKPj4+PiBoYW5kbGVyICh2cmluZ19pbnRlcnJ1cCgpKSBhc3N1
bWVzIHRoZSBpbnRlcnJ1cHQgaXMgdXNlZCBieSBhIHNpbmdsZQo+Pj4+IHZpcnRxdWV1ZS4KPj4+
IFRoYW5rcy4KPj4+Cj4+PiBUaGUgYXBwcm9hY2ggdG8gc2NoZWR1bGUgdHgtbmFwaSBmcm9tIHZp
cnRuZXRfcG9sbF9jbGVhbnR4IGluc3RlYWQgb2YKPj4+IGNsZWFuaW5nIGRpcmVjdGx5IGluIHRo
aXMgcngtbmFwaSBmdW5jdGlvbiB3YXMgbm90IGVmZmVjdGl2ZSBhdAo+Pj4gc3VwcHJlc3Npbmcg
dGhlIHdhcm5pbmcsIEkgdW5kZXJzdGFuZC4KPj4gQ29ycmVjdC4gSSB0cmllZCB0aGUgYXBwcm9h
Y2ggdG8gc2NoZWR1bGUgdHggbmFwaSBpbnN0ZWFkIG9mIGRpcmVjdGx5Cj4+IGRvIGZyZWVfb2xk
X3htaXRfc2ticygpIGluIHZpcnRuZXRfcG9sbF9jbGVhbnR4KCkuIEJ1dCB0aGUgd2FybmluZwo+
PiBzdGlsbCBoYXBwZW5zLgo+IFR3byBxdWVzdGlvbnMgaGVyZTogaXMgdGhlIGRldmljZSB1c2lu
ZyBwYWNrZWQgb3Igc3BsaXQgdnFzPwo+IEFuZCBpcyBldmVudCBpbmRleCBlbmFibGVkPwo+Cj4g
SSB0aGluayBvbmUgaXNzdWUgaXMgdGhhdCBhdCB0aGUgbW9tZW50IHdpdGggc3BsaXQgYW5kIGV2
ZW50IGluZGV4IHdlCj4gZG9uJ3QgYWN0dWFsbHkgZGlzYWJsZSBldmVudHMgYXQgYWxsLgoKCkRv
IHdlIHJlYWxseSBoYXZlIGEgd2F5IHRvIGRpc2FibGUgdGhhdD8gKFdlIGRvbid0IGhhdmUgYSBm
bGFnIGxpa2UgCnBhY2tlZCB2aXJ0cXVldWUpCgpPciB5b3UgbWVhbiB0aGUgdHJpY2sgWzFdIHdo
ZW4gSSBwb3N0IHR4IGludGVycnVwdCBSRkM/CgpUaGFua3MKClsxXSBodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAxNS8yLzkvMTEzCgoKPgo+IHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9kaXNhYmxlX2Ni
X3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiB7Cj4gICAgICAgICAgc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPgo+ICAgICAgICAgIGlmICghKHZxLT5zcGxp
dC5hdmFpbF9mbGFnc19zaGFkb3cgJiBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCkpIHsKPiAg
ICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgfD0gVlJJTkdfQVZB
SUxfRl9OT19JTlRFUlJVUFQ7Cj4gICAgICAgICAgICAgICAgICBpZiAoIXZxLT5ldmVudCkKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LnZyaW5nLmF2YWlsLT5mbGFncyA9Cj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X3RvX3ZpcnRpbzE2KF92cS0+dmRl
diwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnEt
PnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyk7Cj4gICAgICAgICAgfQo+IH0KPgo+IENhbiB5b3Ug
dHJ5IHlvdXIgbmFwaSBwYXRjaCArIGRpc2FibGUgZXZlbnQgaW5kZXg/Cj4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
