Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7157BC433E0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 08:44:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7B020784
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 08:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7B020784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 72CAC203A3;
	Wed, 30 Dec 2020 08:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2UdbZC3XiajN; Wed, 30 Dec 2020 08:44:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4B33520011;
	Wed, 30 Dec 2020 08:44:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26EF0C088B;
	Wed, 30 Dec 2020 08:44:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B01AC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 08A268700F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jtijfBPLYOLP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:44:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 65AED85958
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609317870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9okFBNwasiSQQCSpJ72vtfGTHuNhhqn6FTR4CcWUioo=;
 b=KBClIo+y4/a+t+sRR4pBvw14xFMk5BVHVHcE/YAiBTL6ZOt4/X4bfcSns77KctSZe9LxOT
 mnK/KYHDgnheI2knkX3Ym0JuFv9US+8RLFYKzoF9sDhxgkomxMQVUiUh6BEFT06ebwipYf
 5DaqIWF0VtfB2wWPLjTRp3od0burfM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-aMFY9chTMXuEksfzWhLj5Q-1; Wed, 30 Dec 2020 03:44:25 -0500
X-MC-Unique: aMFY9chTMXuEksfzWhLj5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F9631005504;
 Wed, 30 Dec 2020 08:44:24 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D10D60BFA;
 Wed, 30 Dec 2020 08:44:18 +0000 (UTC)
Subject: Re: [PATCH rfc 2/3] virtio-net: support receive timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-3-willemdebruijn.kernel@gmail.com>
 <20201228145953.08673c8c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+FuTSe630QvTRM-0fnz=B+QRfii=sbsb-Qp5tTc2zbMgxcQyw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <10395a75-fb31-639f-40b2-d6fd60938247@redhat.com>
Date: Wed, 30 Dec 2020 16:44:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+FuTSe630QvTRM-0fnz=B+QRfii=sbsb-Qp5tTc2zbMgxcQyw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Network Development <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjkg5LiK5Y2IODo1NywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBPbiBN
b24sIERlYyAyOCwgMjAyMCBhdCA1OjU5IFBNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5v
cmc+IHdyb3RlOgo+PiBPbiBNb24sIDI4IERlYyAyMDIwIDExOjIyOjMyIC0wNTAwIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4+PiBGcm9tOiBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1iQGdvb2ds
ZS5jb20+Cj4+Pgo+Pj4gQWRkIG9wdGlvbmFsIFBUUCBoYXJkd2FyZSB0aW1lc3RhbXAgb2ZmbG9h
ZCBmb3IgdmlydGlvLW5ldC4KPj4+Cj4+PiBBY2N1cmF0ZSBSVFQgbWVhc3VyZW1lbnQgcmVxdWly
ZXMgdGltZXN0YW1wcyBjbG9zZSB0byB0aGUgd2lyZS4KPj4+IEludHJvZHVjZSB2aXJ0aW8gZmVh
dHVyZSBWSVJUSU9fTkVUX0ZfUlhfVFNUQU1QLiBJZiBuZWdvdGlhdGVkLCB0aGUKPj4+IHZpcnRp
by1uZXQgaGVhZGVyIGlzIGV4cGFuZGVkIHdpdGggcm9vbSBmb3IgYSB0aW1lc3RhbXAuIEEgaG9z
dCBtYXkKPj4+IHBhc3MgcmVjZWl2ZSB0aW1lc3RhbXBzIGZvciBhbGwgb3Igc29tZSBwYWNrZXRz
LiBBIHRpbWVzdGFtcCBpcyB2YWxpZAo+Pj4gaWYgbm9uLXplcm8uCj4+Pgo+Pj4gVGhlIHRpbWVz
dGFtcCBzdHJhZGRsZXMgKHZpcnR1YWwpIGhhcmR3YXJlIGRvbWFpbnMuIExpa2UgUFRQLCB1c2UK
Pj4+IGludGVybmF0aW9uYWwgYXRvbWljIHRpbWUgKENMT0NLX1RBSSkgYXMgZ2xvYmFsIGNsb2Nr
IGJhc2UuIEl0IGlzCj4+PiBndWVzdCByZXNwb25zaWJpbGl0eSB0byBzeW5jIHdpdGggaG9zdCwg
ZS5nLiwgdGhyb3VnaCBrdm0tY2xvY2suCj4+IFdvdWxkIHRoaXMgbm90IGJlIGNvbmZ1c2luZyB0
byBzb21lIHVzZXIgc3BhY2UgU1cgdG8gaGF2ZSBhIE5JQyB3aXRoCj4+IG5vIFBIQyBkZWxpdmVy
IEhXIHN0YW1wcz8KPj4KPj4gSSdkIENDIFJpY2hhcmQgb24gdGhpcywgdW5sZXNzIHlvdSBhbHJl
YWR5IGRpc2N1c3NlZCB3aXRoIGhpbSBvZmZsaW5lLgo+IFRoYW5rcywgZ29vZCBwb2ludC4gSSBz
aG91bGQgaGF2ZSBpbmNsdWRlZCBSaWNoYXJkLgo+Cj4gVGhlcmUgaXMgYSB3ZWxsIHVuZGVyc3Rv
b2QgbWV0aG9kIGZvciBzeW5jaHJvbml6aW5nIGd1ZXN0IGFuZCBob3N0Cj4gY2xvY2sgaW4gS1ZN
IHVzaW5nIHB0cF9rdm0uIEZvciB2aXJ0dWFsIGVudmlyb25tZW50cyB3aXRob3V0IE5JQwo+IGhh
cmR3YXJlIG9mZmxvYWQsIHRoZSB3aGVuIGhvc3QgdGltZXN0YW1wcyBpbiBzb2Z0d2FyZSwgdGhp
cyBzdWZmaWNlcy4KPgo+IFN5bmNpbmcgaG9zdCB3aXRoIE5JQyBpcyBhc3N1bWVkIGlmIHRoZSBo
b3N0IGFkdmVydGlzZXMgdGhlIGZlYXR1cmUKPiBhbmQgaW1wbGVtZW50cyB1c2luZyByZWFsIGhh
cmR3YXJlIHRpbWVzdGFtcHMuCgoKT3IgaXQgY291bGQgYmUgdXNlZnVsIGZvciB2aXJ0aW8gaGFy
ZHdhcmUgd2hlbiB0aGVyZSdzIG5vIEtWTSB0aGF0IApwcm92aWRlcyBQVFAuCgpUaGFua3MKCgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
