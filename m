Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC3C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 10:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAEA081454;
	Wed, 24 Aug 2022 10:19:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAEA081454
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EkNPufe2;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qj8AuW31
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zi5PvbArHgtV; Wed, 24 Aug 2022 10:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F40281337;
	Wed, 24 Aug 2022 10:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F40281337
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 027C4C0033;
	Wed, 24 Aug 2022 10:19:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B861C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 491EC60E67
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:19:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 491EC60E67
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=EkNPufe2; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qj8AuW31
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qdaTAZ563CKd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:19:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C99260E4E
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C99260E4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:19:28 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1CD0620394;
 Wed, 24 Aug 2022 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661336366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plYJsIZh65rL0IucezhbTq91tM6oKEaefmk4MmL7PcA=;
 b=EkNPufe2KiFr3+gTWRz/jGyxW5k7OpstvOAJkw3cj+CX0pkJTOufvSrASIqvV9D7XbGqyo
 2IW4M4imr8TChckiSdGOJrRe2YYgANdwYPjjQMrYAlP9jXctrzSU8KaCYMWyb05SZ9WEG8
 y4b7wN3p9x2vrHgV+XQAJXhbjNxR/V0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661336366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plYJsIZh65rL0IucezhbTq91tM6oKEaefmk4MmL7PcA=;
 b=qj8AuW319tLekHWZ6XO5le8JNdJ8V4UCY+jc+Tw0HO9YL/hTS/wHT+24lyeEZ9k6Dyxiy0
 Xjbq4VdFnRs3TgCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0109413AC0;
 Wed, 24 Aug 2022 10:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FbX/OS37BWMPGAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 24 Aug 2022 10:19:25 +0000
Message-ID: <f0406458-319d-129b-655f-11343d99743d@suse.de>
Date: Wed, 24 Aug 2022 12:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
 <2ff3d36b-f044-71cc-8001-d7f4073282c1@suse.de>
 <CAJs=3_AUiaDtyRTMcDd_DGuiKZVKuMUSZRUosQa7wU=5UZwtqw@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: Virtio-net - add timeouts to control commands
In-Reply-To: <CAJs=3_AUiaDtyRTMcDd_DGuiKZVKuMUSZRUosQa7wU=5UZwtqw@mail.gmail.com>
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

T24gOC8yNC8yMiAxMTo0MiwgQWx2YXJvIEthcnN6IHdyb3RlOgo+IEhpIEhhbm5lcywKPiAKPj4g
YSkgbGV0IHRoZSBkZXZpY2UgZG8gdGhlIHRpbWVvdXQ6IHBhc3MgaW4gYSB0aW1lb3V0IHZhbHVl
IHdpdGggdGhlCj4+IGNvbW1hbmQsIGFuZCBhbGxvdyB0aGUgZGV2aWNlIHRvIHJldHVybiBhbiBF
VElNRURPVVQgZXJyb3Igd2hlbiB0aGUKPj4gdGltZW91dCBleHBpcmVzLiBUaGVuIGl0J3MgdXAg
dG8gdGhlIGRldmljZSB0byBkbyB0aGUgbmVjZXNzYXJ5IHRpbWVvdXQKPj4gaGFuZGxpbmc7IHRo
ZSBzZXJ2ZXIgd29uJ3QgYmUgaW52b2x2ZWQgYXQgYWxsIChleGNlcHQgZm9yIGhhbmRsaW5nIGFu
Cj4+IEVUSU1FRE9VVCBlcnJvcikKPiAKPiAKPiBUaGlzIHdvbid0IHdvcmsgaWYgdGhlIGRldmlj
ZSBjcmFzaGVzLgo+IAo+Pgo+PiBiKSBpbXBsZW1lbnQgYW4gJ2Fib3J0JyBjb21tYW5kLiBXaXRo
IHRoYXQgdGhlIHNlcnZlciBjb250cm9scyB0aGUKPj4gdGltZW91dCwgYW5kIGlzIGFsbG93ZWQg
dG8gc2VuZCBhbiAnYWJvcnQnIGNvbW1hbmQgd2hlbiB0aGUgdGltZW91dAo+PiBleHBpcmVzLiBU
aGF0IHJlcXVpcmVzIHRoZSBkZXZpY2UgdG8gYmUgYWJsZSB0byBhYm9ydCBjb21tYW5kcyAod2hp
Y2gKPj4gbm90IGFsbCBkZXZpY2VzIGFyZSBhYmxlIHRvKSwgYnV0IGF2b2lkcyBoYXZpbmcgdG8g
aW1wbGVtZW50IGEgdGltZW91dAo+PiBoYW5kbGluZyBpbiB0aGUgZGV2aWNlLgo+IAo+IAo+IEkg
YWN0dWFsbHkgdGhvdWdodCBhYm91dCB0aGlzIGlkZWEuCj4gVGhpcyBtYXkgd29yaywgYnV0IHlv
dSdsbCBzdGlsbCBoYXZlIGEgZmV3IG1vbWVudHMgd2hlbiB0aGUgc2VydmVyCj4gYXNzdW1lcyB0
aGF0IHRoZSBjb21tYW5kIGZhaWxlZCwgYW5kIHRoZSBuZXR3b3JrIGRldmljZSBhc3N1bWVzIHRo
YXQKPiBpdCBzdWNjZWVkZWQuCj4gU28gdGhlIHNlcnZlciBtYXkgc3RpbGwgcmVjZWl2ZSBwYWNr
ZXRzIGluIGFuIHVuZXhwZWN0ZWQgcXVldWUuCj4gCj4gCk5vLiBUaGUgc2VydmVyIG1heSBvbmx5
IGFzc3VtZSB0aGF0IHRoZSBjb21tYW5kIGZhaWxlZCB1bnRpbCBpdCBnZXRzIHRoZSAKcmVzcG9u
c2UgZm9yIHRoZSBhYm9ydCBjb21tYW5kLgpCZWZvcmUgdGhhdCB0aGUgc3RhdGUgb2YgdGhlIGNv
bW1hbmQgaXMgdW5kZWZpbmVkLCBhbmQgdGhlIHNlcnZlciBtYXkgCm5vdCBhc3N1bWUgYW55dGhp
bmcgaGVyZS4KCkFuZCB0aGVuIHdlIGdldCBpbnRvIHRoZSBmdW4gdG9waWMgb2YgdGltaW5nIG91
dCBhYm9ydHMsIHdoaWNoIHJlYWxseSAKY2FuIG9ubHkgYmUgcmVzb2x2ZWQgaWYgeW91IGhhdmUg
YSBmb29sLXByb29mIHdheSBvZiByZXNldHRpbmcgdGhlIHF1ZXVlIAppdHNlbGYuIEJ1dCBJIGd1
ZXNzIHZpcnRpbyBjYW4gZG8gdGhhdCAocmlnaHQ/KS4KCj4+Cj4+IEkgYW0gdmVyeSBtdWNoIGlu
IGZhdm91ciBvZiBoYXZpbmcgdGltZW91dHMgZm9yIHZpcnRpbyBjb21tYW5kczsgd2UndmUKPj4g
aGFkIHNldmVyYWwgbWFzc2l2ZSBjdXN0b21lciBlc2NhbGF0aW9ucyB3aGljaCBjb3VsZCBoYXZl
IGJlZW4gc29sdmVkIGlmCj4+IHdlIHdlcmUgYWJsZSB0byBzZXQgdGhlIGNvbW1hbmQgdGltZW91
dCBpbiB0aGUgVk0uCj4+IEFzIHRoaXMgd2FzIGZvciB2aXJ0aW8tc2NzaS92aXJ0aW8tYmxvY2sg
SSB3b3VsZCBhZHZvY2F0ZSB0byBoYXZlIGEKPj4gZ2VuZXJpYyB2aXJ0aW8gY29tbWFuZCB0aW1l
b3V0LCBub3QgYSBwcm90b2NvbC1zcGVjaWZpYyBvbmUuCj4gCj4gVGhpcyBtYXkgYmUgZGlmZmlj
dWx0IHRvIGltcGxlbWVudC4KPiBFc3BlY2lhbGx5IHdoZW4gbXVsdGlwbGUgY29tbWFuZHMgbWF5
IGJlIHF1ZXVlZCBhdCB0aGUgc2FtZSB0aW1lLCBhbmQKPiB0aGUgZGV2aWNlIGNhbiBoYW5kbGUg
dGhlIGNvbW1hbmRzIGluIGFueSBvcmRlci4KPiBXZSdsbCBuZWVkIHRvIGFkZCBpZGVudGlmaWVy
cyBmb3IgZXZlcnkgY29tbWFuZC4KPiAKV2h5LCBidXQgb2YgY291cnNlLiBZb3UgY2Fubm90IGFz
c3VtZSBpbi1vcmRlciBkZWxpdmVyeSBvZiB0aGUgCmNvbXBsZXRpb25zOyBpbiBmYWN0LCB0aGF0
J3MgdGhlIHdob2xlIF9wb2ludF8gb2YgaGF2aW5nIGEgcXVldWUtYmFzZWQgCkkvTyBjb21tYW5k
IGRlbGl2ZXJ5IG1ldGhvZC4KCj4gSSdtIGFjdHVhbGx5IHJlZmVycmluZyBoZXJlIHRvIHRoZSBM
aW51eCBrZXJuZWwgaW1wbGVtZW50YXRpb24gb2YKPiB2aXJ0bmV0IGNvbnRyb2wgY29tbWFuZHMs
IGluIHdoaWNoIHRoZSBzZXJ2ZXIgc3BpbnMgZm9yIGEgcmVzcG9uc2UuCgpTaGVlc2guIFNwaW5u
aW5nIGZvciBhIHJlc3BvbnNlIGlzIG5ldmVyIGEgZ29vZCBpZGVhLCBhcyB0aGlzIG1lYW5zIAp5
b3UnbGwgZW5kIHVwIHdpdGggYSBub24taW50ZXJydXB0aWJsZSBjb21tYW5kIGluIHRoZSBndWVz
dCAoZXNzZW50aWFsbHkgCmFuIGlvY3RsIGludG8gdGhlIGh5cGVydmlzb3IpLgoKQW5kIHJlYWxs
eSwgaWRlbnRpZnlpbmcgdGhlIGNvbW1hbmQgaXNuJ3QgaGFyZC4gRWFjaCBjb21tYW5kIGFscmVh
ZHkgaGFzIAphbiBpZGVudGlmaWVyIChuYW1lbHkgdGhlIHZpcnRpbyByaW5nIGluZGV4KSwgc28g
aWYgaW4gZG91YnQgeW91IGNhbiAKYWx3YXlzIHVzZSB0aGF0LgpUbyBiZSBmb29scHJvb2YsIHRo
b3VnaCwgeW91IG1pZ2h0IHdhbnQgdG8gYWRkIGEgJ3JlYWwnIGlkZW50aWZpZXIgKGxpa2UgCmEg
MzIgb3IgNjQgYml0IGNvbW1hbmQgdGFnKSwgd2hpY2ggd291bGQgZXZlbiBhbGxvdyB5b3UgdG8g
Y2F0Y2ggCnVuaW5pdGlhbGl6ZWQgLyBjb21wbGV0ZWQgY29tbWFuZHMuIFRlbmRzIHRvIGJlIHF1
aXRlIGltcG9ydGFudCB3aGVuIAppbXBsZW1lbnRpbmcgYW4gJ2Fib3J0JyBjb21tYW5kLCBhcyB0
aGUgY29tbWFuZCByZWZlcnJlZCB0byBieSB0aGUgCidhYm9ydCcgY29tbWFuZCBtaWdodCBoYXZl
IGJlZW4gY29tcGxldGVkIGJ5IHRoZSB0aW1lIHRoZSBoeXBlcnZpc29yIApwcm9jZXNzZXMgdGhl
IGFib3J0IGNvbW1hbmQuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJ
CSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdl
cm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
