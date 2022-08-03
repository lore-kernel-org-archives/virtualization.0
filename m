Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E82C19F28
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 08:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DDC060BF5;
	Wed,  3 Aug 2022 08:10:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DDC060BF5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1hAlDte
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SWN4L5QBXs0V; Wed,  3 Aug 2022 08:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D67F60BEC;
	Wed,  3 Aug 2022 08:10:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D67F60BEC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 649C8C0033;
	Wed,  3 Aug 2022 08:10:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25373C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9F14404DD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:10:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9F14404DD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1hAlDte
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-69zxiBZXLc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:10:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16C2D403C1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16C2D403C1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659514227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFeFt7/Q6YyFCUhtAPK93QqSOTH5I5qZoSCr2HzCN+4=;
 b=h1hAlDteA1MRDNQ/hy55t3aougYWf04tu2uUvRiZ1moKcE79crSkkdTgR9PIwqaBz5R3uh
 RpgQn7FPL43oHlJaFX6lrkivvVdI2aDdNaBeEKLaeOh74vokpuT0yDLYM89cFaH7AcW2St
 IvDr4Ar/ld4Fxe+8glHGz1Ti2S7zplY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-lpc0aCF5MumlR01nZTgtzQ-1; Wed, 03 Aug 2022 04:10:24 -0400
X-MC-Unique: lpc0aCF5MumlR01nZTgtzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B947811E87;
 Wed,  3 Aug 2022 08:10:24 +0000 (UTC)
Received: from localhost (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EEAF90A00;
 Wed,  3 Aug 2022 08:10:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: virtio: virtio on Linux
In-Reply-To: <87tu6trcrs.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Organization: Red Hat GmbH
References: <20220802124222.3563378-1-ricardo.canuelo@collabora.com>
 <87pmhi8wsg.fsf@redhat.com>
 <87tu6trcrs.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date: Wed, 03 Aug 2022 10:10:22 +0200
Message-ID: <87mtcl928h.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: kernel@collabora.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

T24gV2VkLCBBdWcgMDMgMjAyMiwgUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNv
bGxhYm9yYS5jb20+IHdyb3RlOgoKPj4gdjEuMiBpcyBvdXQgbm93IDopCj4+Cj4+IChJIHRoaW5r
IGl0IHdvdWxkIGJlIGJldHRlciB0byByZWZlciB0byB0aGUgYmFzZSBzcGVjIGRpcmVjdG9yeT8p
Cj4KPiBEbyB5b3UgbWVhbiB0aGlzPyBodHRwczovL2RvY3Mub2FzaXMtb3Blbi5vcmcvdmlydGlv
L3ZpcnRpby8KPiBPciBzaG91bGQgSSBsaW5rIHRoZSBzb3VyY2UgcmVwbyBpbnN0ZWFkPwo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMKCkhtLi4uIHRoaXMgc2hvdWxk
IHJlZmVyIHRvIHRoZSBPQVNJUyBzaXRlLCBidXQgdGhlIGJhc2UgZGlyZWN0b3J5Cmxpc3Rpbmcg
aXMgYSBiaXQgdWdseS4gTWF5YmUgcmVmZXIgdG8gdjEuMiwgYW5kIGFkZCBhIG5vdGUgdGhhdCB0
aGVyZQptaWdodCBiZSBsYXRlciB2ZXJzaW9ucyBhdmFpbGFibGU/CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
