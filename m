Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8DFC77B73
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 14:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B418C81E93;
	Mon,  5 Jun 2023 14:21:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B418C81E93
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFvKU4CC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Onf_KcYFoWXt; Mon,  5 Jun 2023 14:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 484E581E63;
	Mon,  5 Jun 2023 14:21:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 484E581E63
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 309E4C0037;
	Mon,  5 Jun 2023 14:21:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7652EC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5026E81E93
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:21:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5026E81E93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id InBSUXyoo-Rt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:21:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A62181E86
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A62181E86
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685974863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjyQfaah7kzAAP89Moz/93/MPg42FDVwN2Cl77zMEpo=;
 b=bFvKU4CCkO+sRyaQa6AH37WvE49CfeylwxGzBaKcNV6wAhLMl9HRf3MOF1yPzxpqoQFTgs
 t5WmPGcFC7yRjd26tIrHeKdp1Eg2q9HR0ueIjxofLuU4UT/kyCQAfTcmfDj98lt4OCiBDu
 pxUk/YsUA1RdUDNCvHgpq3i3ziFQDss=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-NLSdgJxbOI2ev26fbE6asw-1; Mon, 05 Jun 2023 10:21:01 -0400
X-MC-Unique: NLSdgJxbOI2ev26fbE6asw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CA2338025EA;
 Mon,  5 Jun 2023 14:21:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.144])
 by smtp.corp.redhat.com (Postfix) with SMTP id 6DD771121314;
 Mon,  5 Jun 2023 14:20:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon,  5 Jun 2023 16:20:39 +0200 (CEST)
Date: Mon, 5 Jun 2023 16:20:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230605142034.GD32275@redhat.com>
References: <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
 <20230531072449.GA25046@redhat.com>
 <CACGkMEv2kB9J1qGYkGkywk1YHV2gU2fMr7qx4vEv9L5f6qL5mg@mail.gmail.com>
 <20230531091432.GB25046@redhat.com>
 <CACGkMEvNrC5gc4ppp0QG-SNSbs_snrqwPkNBotffRRDJA1VJjQ@mail.gmail.com>
 <20230601074315.GA13133@redhat.com>
 <CACGkMEss2LkUiUKaEkhBWwFDBBz31T3N94a0=zSD1d+Fhb1zyQ@mail.gmail.com>
 <20230602175846.GC555@redhat.com>
 <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=whKyWvzg=7_m1o_KLC3zb9FjTBHftc36-5M9X78AxwRXg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, ebiederm@xmission.com, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org
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

T24gMDYvMDIsIExpbnVzIFRvcnZhbGRzIHdyb3RlOgo+Cj4gT24gRnJpLCBKdW4gMiwgMjAyMyBh
dCAxOjU54oCvUE0gT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4g
PiBBcyBJIHNhaWQgZnJvbSB0aGUgdmVyeSBiZWdpbm5pbmcsIHRoaXMgY29kZSBpcyBmaW5lIG9u
IHg4NiBiZWNhdXNlCj4gPiBhdG9taWMgb3BzIGFyZSBmdWxseSBzZXJpYWxpc2VkIG9uIHg4Ni4K
Pgo+IFllcy4gT3RoZXIgYXJjaGl0ZWN0dXJlcyByZXF1aXJlIF9fc21wX21iX197YmVmb3JlLGFm
dGVyfV9hdG9taWMgZm9yCj4gdGhlIGJpdCBzZXR0aW5nIG9wcyB0byBhY3R1YWxseSBiZSBtZW1v
cnkgYmFycmllcnMuCj4KPiBXZSAqc2hvdWxkKiBwcm9iYWJseSBoYXZlIGFjcXVpcmUvcmVsZWFz
ZSB2ZXJzaW9ucyBvZiB0aGUgYml0IHRlc3Qvc2V0Cj4gaGVscGVycywgYnV0IHdlIGRvbid0LCBz
byB0aGV5IGVuZCB1cCBiZWluZyBmdWxsIG1lbW9yeSBiYXJyaWVycyB3aXRoCj4gdGhvc2UgdGhp
bmdzLiBXaGljaCBpc24ndCBvcHRpbWFsLCBidXQgSSBkb3VidCBpdCBtYXR0ZXJzIG9uIG1vc3QK
PiBhcmNoaXRlY3R1cmVzLgo+Cj4gU28gbWF5YmUgd2UnbGwgc29tZSBkYXkgaGF2ZSBhICJ0ZXN0
X2JpdF9hY3F1aXJlKCkiIGFuZCBhCj4gInNldF9iaXRfcmVsZWFzZSgpIiBldGMuCgpJbiB0aGlz
IHBhcnRpY3VsYXIgY2FzZSB3ZSBuZWVkIGNsZWFyX2JpdF9yZWxlYXNlKCkgYW5kIGlpdWMgaXQg
aXMKYWxyZWFkeSBoZXJlLCBqdXN0IGl0IGlzIG5hbWVkIGNsZWFyX2JpdF91bmxvY2soKS4KClNv
IGRvIHlvdSBhZ3JlZSB0aGF0IHZob3N0X3dvcmtlcigpIG5lZWRzIHNtcF9tYl9fYmVmb3JlX2F0
b21pYygpCmJlZm9yZSBjbGVhcl9iaXQoKSBvciBqdXN0IGNsZWFyX2JpdF91bmxvY2soKSB0byBh
dm9pZCB0aGUgcmFjZSB3aXRoCnZob3N0X3dvcmtfcXVldWUoKSA/CgpMZXQgbWUgcHJvdmlkZSBh
IHNpbXBsaWZpZWQgZXhhbXBsZToKCglzdHJ1Y3QgaXRlbSB7CgkJc3RydWN0IGxsaXN0X25vZGUJ
bGxpc3Q7CgkJdW5zaWduZWQgbG9uZwkJZmxhZ3M7Cgl9OwoKCXN0cnVjdCBsbGlzdF9oZWFkIEhF
QUQgPSB7fTsJLy8gZ2xvYmFsCgoJdm9pZCBxdWV1ZShzdHJ1Y3QgaXRlbSAqaXRlbSkKCXsKCQkv
LyBlbnN1cmUgdGhpcyBpdGVtIHdhcyBhbHJlYWR5IGZsdXNoZWQKCQlpZiAoIXRlc3RfYW5kX3Nl
dF9iaXQoMCwgJml0ZW0tPmZsYWdzKSkKCQkJbGxpc3RfYWRkKGl0ZW0tPmxsaXN0LCAmSEVBRCk7
CgoJfQoKCXZvaWQgZmx1c2godm9pZCkKCXsKCQlzdHJ1Y3QgbGxpc3Rfbm9kZSAqaGVhZCA9IGxs
aXN0X2RlbF9hbGwoJkhFQUQpOwoJCXN0cnVjdCBpdGVtICppdGVtLCAqbmV4dDsKCgkJbGxpc3Rf
Zm9yX2VhY2hfZW50cnlfc2FmZShpdGVtLCBuZXh0LCBoZWFkLCBsbGlzdCkKCQkJY2xlYXJfYml0
KDAsICZpdGVtLT5mbGFncyk7Cgl9CgpJIHRoaW5rIHRoaXMgY29kZSBpcyBidWdneSBpbiB0aGF0
IGZsdXNoKCkgY2FuIHJhY2Ugd2l0aCBxdWV1ZSgpLCB0aGUgc2FtZQp3YXkgYXMgdmhvc3Rfd29y
a2VyKCkgYW5kIHZob3N0X3dvcmtfcXVldWUoKS4KCk9uY2UgZmx1c2goKSBjbGVhcnMgYml0IDAs
IHF1ZXVlKCkgY2FuIGNvbWUgb24gYW5vdGhlciBDUFUgYW5kIHJlLXF1ZXVlCnRoaXMgaXRlbSBh
bmQgY2hhbmdlIGl0ZW0tPmxsaXN0Lm5leHQuIFdlIG5lZWQgYSBiYXJyaWVyIGJlZm9yZSBjbGVh
cl9iaXQoKQp0byBlbnN1cmUgdGhhdCBuZXh0ID0gbGxpc3RfZW50cnkoaXRlbS0+bmV4dCkgaW4g
bGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpCmNvbXBsZXRlcyBiZWZvcmUgdGhlIHJlc3VsdCBv
ZiBjbGVhcl9iaXQoKSBpcyB2aXNpYmxlIHRvIHF1ZXVlKCkuCgpBbmQsIEkgZG8gbm90IHRoaW5r
IHdlIGNhbiByZWx5IG9uIGNvbnRyb2wgZGVwZW5kZW5jeSBiZWNhdXNlLi4uIGJlY2F1c2UKSSBm
YWlsIHRvIHNlZSB0aGUgbG9hZC1zdG9yZSBjb250cm9sIGRlcGVuZGVuY3kgaW4gdGhpcyBjb2Rl
LApsbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKCkgbG9hZHMgaXRlbS0+bGxpc3QubmV4dCBidXQg
ZG9lc24ndCBjaGVjayB0aGUKcmVzdWx0IHVudGlsIHRoZSBuZXh0IGl0ZXJhdGlvbi4KCk5vPwoK
T2xlZy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
