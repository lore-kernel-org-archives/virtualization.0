Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD40C001DC
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 16:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA9E140105;
	Mon, 31 Jul 2023 16:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA9E140105
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Hv4hUdd8;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wwSc7l6C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uCng9ikdJpjW; Mon, 31 Jul 2023 16:22:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5DED4409E6;
	Mon, 31 Jul 2023 16:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DED4409E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24D46C0072;
	Mon, 31 Jul 2023 16:22:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D36DEC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 16:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4C3481E7E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 16:22:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4C3481E7E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Hv4hUdd8; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wwSc7l6C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wcg7niL0uXWN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 16:22:33 +0000 (UTC)
X-Greylist: delayed 415 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 31 Jul 2023 16:22:33 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC53081E55
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC53081E55
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 16:22:33 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4AD22216F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690820135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq+S+i/DgAUfNeyWvaFz1Jcgybqkj9izNmHb6ulL26w=;
 b=Hv4hUdd8qPZOq8Vkdrf+XI4uE+WJMTAWIxgfW12Z/0FOiGiRQEPstVE60ksGymlOzkUMIk
 h3kTCBs9JZ8iSIfXh1rIpCEoIg3xVSUR85qbCvy73bU3kYfx/nFoPLgL8EOHjSF3NfzEtP
 C34fW2lRhpsx6oW1+Oe4NRUQmXbdchQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690820135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq+S+i/DgAUfNeyWvaFz1Jcgybqkj9izNmHb6ulL26w=;
 b=wwSc7l6CYki36CsDb/VNLqw0fJPNnhnwuDviGbBqkjquM9Qac9p/2JJOWXCmKPjQKHDRuh
 AlfNXF98uNv1NhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAB4C1322C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 16:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GL+LLCfex2RIDgAAMHmgww
 (envelope-from <hare@suse.de>)
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 16:15:35 +0000
Message-ID: <bca7e5ab-6e3a-c768-f850-609cf006e82c@suse.de>
Date: Mon, 31 Jul 2023 18:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] virtio: a new vcpu watchdog driver
Content-Language: en-US
To: virtualization@lists.linux-foundation.org
References: <20230731012512.235085-1-zhanghao1@kylinos.cn>
 <1690770650.9714553-1-xuanzhuo@linux.alibaba.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1690770650.9714553-1-xuanzhuo@linux.alibaba.com>
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

T24gNy8zMS8yMyAwNDozMCwgWHVhbiBaaHVvIHdyb3RlOgo+IE9uIE1vbiwgMzEgSnVsIDIwMjMg
MDk6MjU6MTIgKzA4MDAsICJ6aGFuZ2hhbzEiIDx6aGFuZ2hhbzFAa3lsaW5vcy5jbj4gd3JvdGU6
Cj4+IEEgbmV3IHZpcnRpbyBwY2kgZHJpdmVyIGlzIGFkZGVkIGZvciBsaXN0ZW5pbmcgdG8gdmNw
dXMKPj4gaW5zaWRlIGd1ZXN0LiBFYWNoIHZjcHUgY3JlYXRlcyBhIGNvcnJlc3BvbmRpbmcgdGhy
ZWFkIHRvCj4+IHBlcmlvZGljYWxseSBzZW5kIGRhdGEgdG8gcWVtdSdzIGJhY2stZW5kIHdhdGNo
ZG9nIGRldmljZS4KPj4gSWYgYSB2Q1BVIGlzIGluIHRoZSBzdGFsbCBzdGF0ZSwgZGF0YSBjYW5u
b3QgYmUgc2VudCB0bwo+PiBiYWNrLWVuZCB2aXJ0aW8gZGV2aWNlLiBBcyBhIHJlc3VsdCwgdGhl
IGJhY2stZW5kIGRldmljZQo+PiBjYW4gZGV0ZWN0IHRoYXQgdGhlIGd1ZXN0IGlzIGluIHRoZSBz
dGFsbCBzdGF0ZS4KPj4KPj4gVGhlIGRyaXZlciBpcyBtYWlubHkgdXNlZCB3aXRoIHRoZSBiYWNr
LWVuZCB3YXRjaGRvZyBkZXZpY2Ugb2YgcWVtdS4KPj4KPj4gVGhlIHFlbXUgYmFja2VuZCB3YXRj
aGRvZyBkZXZpY2UgaXMgaW1wbGVtZW50ZWQgYXMgZm9sbG93Ogo+PiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsLzIwMjMwNzA1MDgxODEzLjQxMTUyNi0xLXpoYW5naGFvMUBreWxp
bm9zLmNuLwo+IAo+IAo+IEkgdGhpbmsgd2UgbmVlZCB0byBpbnRyb2R1Y2UgdGhpcyBuZXcgZGV2
aWNlIHRvIHRoZSB2aXJ0aW8gc3BlYyBmaXJzdGx5Lgo+IApBbmQgd2hlbiBoYXZpbmcgYSB3YXRj
aGRvZyBkcml2ZXJzOiBzaG91bGRuJ3QgeW91IHdhdGNoIHRoZSB2aXJ0aW8gcXVldWUgCl9pdHNl
bGZfPyBUaGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCB0aGUgdmlydGlvIHF1ZXVlIG1ha2VzIGZv
cndhcmQgCnByb2dyZXNzIC4uLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5l
Y2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2
ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogSXZvIFRvdGV2LCBBbmRyZXcK
TXllcnMsIEFuZHJldyBNY0RvbmFsZCwgTWFydGplIEJvdWRpZW4gTW9lcm1hbgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
