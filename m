Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43926C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 10:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D28CD417E4;
	Tue, 26 Apr 2022 10:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iPz7dgLIQLG0; Tue, 26 Apr 2022 10:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B762417F7;
	Tue, 26 Apr 2022 10:34:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC1B5C0032;
	Tue, 26 Apr 2022 10:34:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 630B2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 603F8813F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OrRFjR-BUnrD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:34:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CE16813F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650969292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KtGuWPPIAuIhHsklidM2yMTGEn7vTMVZjRfQnOlbXVg=;
 b=OhqonEROXNZOkQ8Q5TQK+hievkoJqFwhMUmbvNQTfcQc5uXqlZSNhfIUTx4rp0ffQsyxhM
 p6OYlFLtGd0JiGjKbgKNRWwhmI+1g/wsS1eB8J/WqY/EcfxGTdzIVCyKC7JTRthlWeTiGT
 M0tyzxSS/mKj5JqSVqZhGuG7+k7Nvgk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-9mIwJ_YuNHmK_a_28fK5Hg-1; Tue, 26 Apr 2022 06:34:50 -0400
X-MC-Unique: 9mIwJ_YuNHmK_a_28fK5Hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CA53185A7A4;
 Tue, 26 Apr 2022 10:34:50 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9502AC159B3;
 Tue, 26 Apr 2022 10:34:48 +0000 (UTC)
Date: Tue, 26 Apr 2022 11:34:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v4 2/8] crypto-akcipher: Introduce akcipher types to qapi
Message-ID: <YmfKxistn+fCjvr1@redhat.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
 <20220411104327.197048-3-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220411104327.197048-3-pizhenwei@bytedance.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: helei.sig11@bytedance.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBBcHIgMTEsIDIwMjIgYXQgMDY6NDM6MjFQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToKPiBGcm9tOiBMZWkgSGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gCj4gSW50cm9k
dWNlIGFrY2lwaGVyIHR5cGVzLCBhbHNvIGluY2x1ZGUgUlNBIHJlbGF0ZWQgdHlwZXMuCj4gCj4g
U2lnbmVkLW9mZi1ieTogTGVpIEhlIDxoZWxlaS5zaWcxMUBieXRlZGFuY2UuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICBx
YXBpL2NyeXB0by5qc29uIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspCgpzbmlwCgo+
ICsjIwo+ICsjIEBRQ3J5cHRvQWtDaXBoZXJPcHRpb25zOgo+ICsjCj4gKyMgVGhlIG9wdGlvbnMg
dGhhdCBhcmUgYXZhaWxhYmxlIGZvciBhbGwgYXN5bW1ldHJpYyBrZXkgYWxnb3JpdGhtcwo+ICsj
IHdoZW4gY3JlYXRpbmcgYSBuZXcgUUNyeXB0b0FrQ2lwaGVyLgo+ICsjCj4gKyMgU2luY2U6IDcu
MQo+ICsjIwo+ICt7ICd1bmlvbic6ICdRQ3J5cHRvQWtDaXBoZXJPcHRpb25zJywKPiArICAnYmFz
ZSc6IHsgJ2FsZ29yaXRobSc6ICdRQ3J5cHRvQWtDaXBoZXJBbGdvcml0aG0nIH0sCj4gKyAgJ2Rp
c2NyaW1pbmF0b3InOiAnYWxnb3JpdGhtJywKPiArICAnZGF0YSc6IHsgJ3JzYSc6ICdRQ3J5cHRv
QWtDaXBoZXJPcHRpb25zUlNBJyB9fQoKSSBtaXN0YWtlbmx5IHN1Z2dlc3RlZCAnYWxnb3JpdGht
JyBoZXJlLCBidXQgZm9yIGNvbnNpc3RlbmN5CndpdGggb3RoZXIgZmllbGRzLCBJIHNob3VsZCBo
YXZlIHNhaWQganVzdCAnYWxnJy4KCldpdGggdGhhdCBjaGFuZ2UKCiAgUmV2aWV3ZWQtYnk6IERh
bmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+CgoKV2l0aCByZWdhcmRzLApE
YW5pZWwKLS0gCnw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tICAgIGh0dHBzOi8vd3d3
LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5nZSA6fAp8OiBodHRwczovL2xpYnZpcnQub3JnICAg
ICAgICAgLW8tICAgICAgICAgICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwKfDog
aHR0cHM6Ly9lbnRhbmdsZS1waG90by5vcmcgICAgLW8tICAgIGh0dHBzOi8vd3d3Lmluc3RhZ3Jh
bS5jb20vZGJlcnJhbmdlIDp8CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
