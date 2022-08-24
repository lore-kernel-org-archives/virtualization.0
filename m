Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9DCC32793
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 09:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA49560E3E;
	Wed, 24 Aug 2022 09:25:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA49560E3E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0wXMhZdc;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Zsk/A+0+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tKtqGz4lws9a; Wed, 24 Aug 2022 09:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E00E60E2A;
	Wed, 24 Aug 2022 09:25:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E00E60E2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF29C0032;
	Wed, 24 Aug 2022 09:25:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E248C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFC4D60E2A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFC4D60E2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MyzaI4UXrl8p
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83060605EC
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83060605EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 09:24:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E76F33F96;
 Wed, 24 Aug 2022 09:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661333094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GosGyRasfLQTI37/Gv5JZWHz1qn+5JXZ3XDF3rQAl4s=;
 b=0wXMhZdckbicGFiSNBKweAJwgIzJrX5WkI52wa2lJJbbnrE10IEo1yTa3phaQQWdpiHAzc
 FHt8FEePw8y7z/PsFsytsTDn/c5lUaW4QOVts205MKFmHCvh+RnDgbB9BPfc18YzIewpvc
 tAmrCJHt32W4Hs99Rk28vCn2zX65Peo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661333094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GosGyRasfLQTI37/Gv5JZWHz1qn+5JXZ3XDF3rQAl4s=;
 b=Zsk/A+0+Vk/t4D5SGTNwbTNWvI7dgkvtV2oBCvrYFhdIgqxGDSV6e8lp4erXJv72ErpLpN
 +o8yFVrxs8SiZ1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0211513780;
 Wed, 24 Aug 2022 09:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DRHFOmXuBWNOfwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 24 Aug 2022 09:24:53 +0000
Message-ID: <bedae890-80e6-9777-caff-98749d46ba3b@suse.de>
Date: Wed, 24 Aug 2022 11:24:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Virtio-net - add timeouts to control commands
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
 <CAJs=3_Cnf29Om2yB=JkdASuu=YBPRmZ4i7ncFfTzrftTkYZVmQ@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAJs=3_Cnf29Om2yB=JkdASuu=YBPRmZ4i7ncFfTzrftTkYZVmQ@mail.gmail.com>
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

T24gOC8yNC8yMiAxMToxNiwgQWx2YXJvIEthcnN6IHdyb3RlOgo+IEhpIEphc29uLAo+IAo+PiBP
ciByZXNldCBidXQgY2FuIHdlIHNpbXBseSB1c2UgaW50ZXJydXB0IGluc3RlYWQgb2YgdGhlIGJ1
c3kgd2FpdGluZz8KPiAKPiBJIGFncmVlIHRoYXQgdGltZW91dHMgYXJlIG5vdCBuZWVkZWQgdXNp
bmcgaW50ZXJydXB0cy4KClF1aXRlIHRoZSBjb250cmFyeS4KVGhlcmUgaXMgbm8gZ3VhcmFudGVl
IHRoYXQgYSBjb21wbGV0aW9uIGZvciBhIGdpdmVuIGNvbW1hbmQgd2lsbCBiZSAKc2lnbmFsZWQg
YXQgYWxsOyBpZiB0aGUgY29tcGxldGlvbiBpcyBuZXZlciBwb3N0ZWQgdG8gdGhlIHZpcnRpbyBx
dWV1ZSAKdGhlIFZNIHdpbGwgc3BpbiBmb3JldmVyLgoKPiBUaGlzIGNhbiBiZSBkb25lLCBidXQg
c2VlbXMgbGlrZSBhIGJpZyBjaGFuZ2UuCj4gQWxsIGZ1bmN0aW9ucyBjYWxsaW5nIHZpcnRuZXRf
c2VuZF9jb21tYW5kIGV4cGVjdCB0byBnZXQgYSByZXNwb25zZSBpbW1lZGlhdGVseS4KPiBUaGlz
IG1heSBiZSBkaWZmaWN1bHQsIHNpbmNlIHNvbWUgb2YgdGhlIGNvbW1hbmRzIGFyZSBzZW50IGlu
IHRoZQo+IHByb2JlIGZ1bmN0aW9uLgoKVGhpcyBpcyBhIHNpbXBsaXN0aWMgYXBwcm9hY2guIF9B
bnlfIGNvbW1hbmQgc2VudCB2aWEgdmlydGlvIHdpbGwgaGF2ZSAKdG8gaGF2ZSBzb21lIHNvcnQg
b2YgaGFuZGxpbmcgaW4gdGhlIGhvc3QsIHNvIGFuIGltbWVkaWF0ZSByZXNwb25zZSBpcyAKbm90
IGd1YXJhbnRlZWQuCkVzcGVjaWFsbHkgdmlydGlvLWJsb2NrIGNvbW1hbmQgd2lsbCBfbm90XyBi
ZSBoYW5kbGVkIGltbWVkaWF0ZWx5LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJl
aW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
