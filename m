Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC70C32796
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 09:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D7E260E40;
	Wed, 24 Aug 2022 09:28:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D7E260E40
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VJEVo3/R;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DyMnybPk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CiFZRWdeaFA0; Wed, 24 Aug 2022 09:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0760D60E4F;
	Wed, 24 Aug 2022 09:28:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0760D60E4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3EABC0032;
	Wed, 24 Aug 2022 09:28:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27528C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BD6840B24
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BD6840B24
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=VJEVo3/R; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=DyMnybPk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DdusuvUbCLQv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:28:09 +0000 (UTC)
X-Greylist: delayed 00:06:18 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55D2540B66
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55D2540B66
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:28:08 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 888C133F59;
 Wed, 24 Aug 2022 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661332907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uqn5PolJzqk2m09wCP/1yzHIZM168OJrXMXgNbyyr4s=;
 b=VJEVo3/REdBcYurI865omlR6bcjdN9hzj90HDZMPB3hfaGJ2nzRoG1Qd2CKuzz2Cqh4wDw
 RdIFBf1FthEFhpyrfBqr1hDQVFix5fwYGor1opN78ZXmv/ipzREa6bhS7ahnGy/Um/Bxvj
 5j7Cmm8aS0YLBAI10zAeYPHLaLWV8G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661332907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uqn5PolJzqk2m09wCP/1yzHIZM168OJrXMXgNbyyr4s=;
 b=DyMnybPk/hOR//Vdwa0UkxBxgSMpoXE9Jvyhww54C6gNvMq+WQedDYyFbXsC2ZLMXHIwPX
 Hgaw/P/ElNC7zrDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CA2A13780;
 Wed, 24 Aug 2022 09:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qyPNGavtBWPofQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 24 Aug 2022 09:21:47 +0000
Message-ID: <2ff3d36b-f044-71cc-8001-d7f4073282c1@suse.de>
Date: Wed, 24 Aug 2022 11:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: Virtio-net - add timeouts to control commands
In-Reply-To: <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gOC8yNC8yMiAxMTowNiwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBXZWQsIEF1ZyAyNCwgMjAy
MiBhdCAzOjUyIFBNIEFsdmFybyBLYXJzeiA8YWx2YXJvLmthcnN6QHNvbGlkLXJ1bi5jb20+IHdy
b3RlOgo+Pgo+PiBJIHRoaW5rIHRoYXQgd2Ugc2hvdWxkIGFkZCBhIHRpbWVvdXQgdG8gdGhlIGNv
bnRyb2wgdmlydHF1ZXVlIGNvbW1hbmRzLgo+PiBJZiB0aGUgaHlwZXJ2aXNvciBjcmFzaGVzIHdo
aWxlIGhhbmRsaW5nIGEgY29udHJvbCBjb21tYW5kLCB0aGUgZ3Vlc3QKPj4gd2lsbCBzcGluIGZv
cmV2ZXIuCj4+IFRoaXMgbWF5IG5vdCBiZSBuZWNlc3NhcnkgZm9yIGEgdmlydHVhbCBlbnZpcm9u
bWVudCwgd2hlbiBib3RoIHRoZQo+PiBoeXBlcnZpc29yIGFuZCB0aGUgZ3Vlc3QgT1MgcnVuIGlu
IHRoZSBzYW1lIGJhcmUgbWV0YWwsIGJ1dCB0aGlzCj4+IGlzIG5lZWRlZCBmb3IgYSBwaHlzaWNh
bCBuZXR3b3JrIGRldmljZSBjb21wYXRpYmxlIHdpdGggVmlydElPLgo+Pgo+PiAoSW4gdGhlc2Ug
Y2FzZXMsIHRoZSBuZXR3b3JrIGRldmljZSBhY3RzIGFzIHRoZSBoeXBlcnZpc29yLCBhbmQgdGhl
Cj4+IHNlcnZlciBhY3RzIGFzCj4+IHRoZSBndWVzdCBPUykuCj4+Cj4+IFRoZSBuZXR3b3JrIGRl
dmljZSBtYXkgZmFpbCB0byBhbnN3ZXIgYSBjb250cm9sIGNvbW1hbmQsIG9yIG1heSBjcmFzaCwg
bGVhZGluZwo+PiB0byBhIHN0YWxsIGluIHRoZSBzZXJ2ZXIuCj4+Cj4+IE15IGlkZWEgaXMgdG8g
YWRkIGEgYmlnIGVub3VnaCB0aW1lb3V0LCB0byBhbGxvdyB0aGUgc2xvdyBkZXZpY2VzIHRvCj4+
IGNvbXBsZXRlIHRoZSBjb21tYW5kLgo+Pgo+PiBJIHdyb3RlIGEgc2ltcGxlIHBhdGNoIHRoYXQg
cmV0dXJucyBmYWxzZSBmcm9tIHZpcnRuZXRfc2VuZF9jb21tYW5kIGluCj4+IGNhc2Ugb2YgdGlt
ZW91dHMuCj4+Cj4+IFRoZSB0aW1lb3V0IGFwcHJvYWNoIGludHJvZHVjZXMgc29tZSBzZXJpb3Vz
IHByb2JsZW1zIGluIGNhc2VzIHdoZW4KPj4gdGhlIG5ldHdvcmsgZGV2aWNlIGRvZXMgYW5zd2Vy
IHRoZSBjb250cm9sIGNvbW1hbmQsIGJ1dCBhZnRlciB0aGUKPj4gdGltZW91dC4KPj4KPj4gKiBU
aGUgZGV2aWNlIHdpbGwgdGhpbmsgdGhhdCB0aGUgY29tbWFuZCBzdWNjZWVkZWQsIHdoaWxlIHRo
ZSBzZXJ2ZXIgd29uJ3QuCj4+ICAgICBUaGlzIG1heSBiZSBzZXJpb3VzIHdpdGggdGhlIFZJUlRJ
T19ORVRfQ1RSTF9NUV9WUV9QQUlSU19TRVQgY29tbWFuZC4KPj4gICAgIFRoZSBzZXJ2ZXIgbWF5
IHJlY2VpdmUgcGFja2V0cyBpbiBhbiB1bmV4cGVjdGVkIHF1ZXVlLgo+Pgo+PiAqIHZpcnRxdWV1
ZV9nZXRfYnVmIHdpbGwgcmV0dXJuIHRoZSBwcmV2aW91cyByZXNwb25zZSBmb3IgdGhlIG5leHQK
Pj4gY29udHJvbCBjb21tYW5kLgo+Pgo+PiBBZGRyZXNzaW5nIHRoaXMgY2FzZSBieSBhZGRpbmcg
YSB0aW1lb3V0ICB0byB0aGUgc3BlYyB3b24ndCBiZSBlYXN5LAo+PiBzaW5jZSB0aGUgbmV0d29y
ayBkZXZpY2UgYW5kIHRoZSBzZXJ2ZXIgaGF2ZSBkaWZmZXJlbnQgY2xvY2tzLCBhbmQgdGhlCj4+
IHNlcnZlciB3b24ndCBrbm93IHdoZW4gZXhhY3RseSB0aGUgbmV0d29yayBkZXZpY2Ugbm90aWNl
ZCB0aGUga2ljay4KPj4KPj4gU28gbWF5YmUgd2Ugc2hvdWxkIGNhbGwgdmlydG5ldF9yZW1vdmUg
aWYgd2UgcmVhY2ggYSB0aW1lb3V0Lgo+IAo+IE9yIHJlc2V0IGJ1dCBjYW4gd2Ugc2ltcGx5IHVz
ZSBpbnRlcnJ1cHQgaW5zdGVhZCBvZiB0aGUgYnVzeSB3YWl0aW5nPwo+IAoKVGhlcmUgYXJlIHR3
byBwb3NzaWJsZSB3YXlzIG9mIGhhbmRsaW5nIHRoaXM6CmEpIGxldCB0aGUgZGV2aWNlIGRvIHRo
ZSB0aW1lb3V0OiBwYXNzIGluIGEgdGltZW91dCB2YWx1ZSB3aXRoIHRoZSAKY29tbWFuZCwgYW5k
IGFsbG93IHRoZSBkZXZpY2UgdG8gcmV0dXJuIGFuIEVUSU1FRE9VVCBlcnJvciB3aGVuIHRoZSAK
dGltZW91dCBleHBpcmVzLiBUaGVuIGl0J3MgdXAgdG8gdGhlIGRldmljZSB0byBkbyB0aGUgbmVj
ZXNzYXJ5IHRpbWVvdXQgCmhhbmRsaW5nOyB0aGUgc2VydmVyIHdvbid0IGJlIGludm9sdmVkIGF0
IGFsbCAoZXhjZXB0IGZvciBoYW5kbGluZyBhbiAKRVRJTUVET1VUIGVycm9yKQpiKSBpbXBsZW1l
bnQgYW4gJ2Fib3J0JyBjb21tYW5kLiBXaXRoIHRoYXQgdGhlIHNlcnZlciBjb250cm9scyB0aGUg
CnRpbWVvdXQsIGFuZCBpcyBhbGxvd2VkIHRvIHNlbmQgYW4gJ2Fib3J0JyBjb21tYW5kIHdoZW4g
dGhlIHRpbWVvdXQgCmV4cGlyZXMuIFRoYXQgcmVxdWlyZXMgdGhlIGRldmljZSB0byBiZSBhYmxl
IHRvIGFib3J0IGNvbW1hbmRzICh3aGljaCAKbm90IGFsbCBkZXZpY2VzIGFyZSBhYmxlIHRvKSwg
YnV0IGF2b2lkcyBoYXZpbmcgdG8gaW1wbGVtZW50IGEgdGltZW91dCAKaGFuZGxpbmcgaW4gdGhl
IGRldmljZS4KCldlIGNhbiBhY3R1YWxseSBzcGVjaWZ5IGJvdGggbWV0aG9kcywgYW5kIGhhdmUg
Y29uZmlndXJhdGlvbiBiaXRzIAppbmRpY2F0aW5nIHdoaWNoIG1ldGhvZCBpcyBzdXBwb3J0ZWQg
YnkgdGhlIGRldmljZS4KCkkgYW0gdmVyeSBtdWNoIGluIGZhdm91ciBvZiBoYXZpbmcgdGltZW91
dHMgZm9yIHZpcnRpbyBjb21tYW5kczsgd2UndmUgCmhhZCBzZXZlcmFsIG1hc3NpdmUgY3VzdG9t
ZXIgZXNjYWxhdGlvbnMgd2hpY2ggY291bGQgaGF2ZSBiZWVuIHNvbHZlZCBpZiAKd2Ugd2VyZSBh
YmxlIHRvIHNldCB0aGUgY29tbWFuZCB0aW1lb3V0IGluIHRoZSBWTS4KQXMgdGhpcyB3YXMgZm9y
IHZpcnRpby1zY3NpL3ZpcnRpby1ibG9jayBJIHdvdWxkIGFkdm9jYXRlIHRvIGhhdmUgYSAKZ2Vu
ZXJpYyB2aXJ0aW8gY29tbWFuZCB0aW1lb3V0LCBub3QgYSBwcm90b2NvbC1zcGVjaWZpYyBvbmUu
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2Vy
bmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6
IEZlbGl4IEltZW5kw7ZyZmZlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
