Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A652EC433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:17:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B8F22BEA
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B8F22BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0C6BC85ABB;
	Mon, 18 Jan 2021 15:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ayF69aQq9vY; Mon, 18 Jan 2021 15:17:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EBAA85A80;
	Mon, 18 Jan 2021 15:17:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63A87C08A1;
	Mon, 18 Jan 2021 15:17:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0F56C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C0FF85A84
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:17:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LCKxGLwDvI_f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D9AE885A80
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610983022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psrfvoG3s6Q5vxt3L2I9TwaBLHc6rZJ8JZ9ILZMQQLQ=;
 b=JuvWhx5oP7Yc3rdL+gESQ/2QsljbZPwx/i7widicX6kLayT2feEe/9tOo1bnUdhnYcfYHF
 lO20Fd17husvOABD7+sQ3GETKJlBbMXfIupM64Lfn2PgOVzzXOaBWUlhfycv/hnMGRbfc0
 /uxhX7Bq4pu11JUfpJJd1ZG/H9NzoNg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-c7j0QhrDNPy_YVC4cp4v-Q-1; Mon, 18 Jan 2021 10:17:00 -0500
X-MC-Unique: c7j0QhrDNPy_YVC4cp4v-Q-1
Received: by mail-wr1-f71.google.com with SMTP id w5so8366802wrl.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 07:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=psrfvoG3s6Q5vxt3L2I9TwaBLHc6rZJ8JZ9ILZMQQLQ=;
 b=ch9nQWODBxNL9fq8FblLuk5nx8cv0pP4NMzTtmMtgr91CEiMefvoPjbIFUa43YJN35
 UI9q0TU+sT1I43BK/ruVvQ2lpFN/NHsNhO1TGhqCWTKcEyM8fBQ2qpRTVjQE/lRh6p3T
 CTjI4ccI4f24PqV5PzpVOtkTltYtslXdSNExuO2FXckhhdCh4owq+WQg+h3oQaNoeMNy
 7obpmN4M/QAROrFRQsdCZ7OoMVD3k6d+1naDqRZMA5AFR0fQpRoRB7hSFqrolq+wZRfo
 iZTKSndCqrJbL5s56MPXQI/Q63kXD+Thijf9bqmfgvQhQ9X0Fnr5193YOcbLvDZa9hKx
 kuQQ==
X-Gm-Message-State: AOAM531EsGKGGNQrSH+8f/cSCNgwrkc+mXeDWrrTkdPb4IYmtqfgRBDQ
 G3gWhW7s97ZsFKHvEnMWUAT7ybY/aAK68inqgSCv5QBSRjXoW28dam2b4RpPzoMECyQ9XEcySDo
 l/YeVb6rCsqe1T40PbrCTr40S3WpJ3jKvufcEVJferQ==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr26882336wrm.1.1610983019798; 
 Mon, 18 Jan 2021 07:16:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXG3dAk6icAdSs8xnG72+nZUruxeveo9BolCI0f5eiHmFFp/RlmpfjavbAYMBXV+ShJ7Tvbw==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr26882310wrm.1.1610983019631; 
 Mon, 18 Jan 2021 07:16:59 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id z130sm28028318wmb.33.2021.01.18.07.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 07:16:58 -0800 (PST)
Date: Mon, 18 Jan 2021 16:16:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>, stsp <stsp2@yandex.ru>
Subject: Re: [RFC PATCH v2 00/13] virtio/vsock: introduce SOCK_SEQPACKET
 support.
Message-ID: <CAGxU2F4v9_a9frgM61fh7UYTcWeGpNaAEXTUgnj8hvdU81PW5Q@mail.gmail.com>
References: <20210115053553.1454517-1-arseny.krasnov@kaspersky.com>
 <2fd6fc75-c534-7f70-c116-50b1c804b594@yandex.ru>
MIME-Version: 1.0
In-Reply-To: <2fd6fc75-c534-7f70-c116-50b1c804b594@yandex.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, netdev <netdev@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gRnJpLCBKYW4gMTUsIDIwMjEgYXQgMTI6NTk6MzBQTSArMDMwMCwgc3RzcCB3cm90ZToKPjE1
LjAxLjIwMjEgMDg6MzUsIEFyc2VueSBLcmFzbm92INC/0LjRiNC10YI6Cj4+ICAgICAgVGhpcyBw
YXRjaHNldCBpbXBlbGVtZW50cyBzdXBwb3J0IG9mIFNPQ0tfU0VRUEFDS0VUIGZvciB2aXJ0aW8K
Pj50cmFuc3BvcnQuCj4+ICAgICAgQXMgU09DS19TRVFQQUNLRVQgZ3VhcmFudGVlcyB0byBzYXZl
IHJlY29yZCBib3VuZGFyaWVzLCBzbyB0bwo+PmRvIGl0LCBuZXcgcGFja2V0IG9wZXJhdGlvbiB3
YXMgYWRkZWQ6IGl0IG1hcmtzIHN0YXJ0IG9mIHJlY29yZCAod2l0aAo+PnJlY29yZCBsZW5ndGgg
aW4gaGVhZGVyKSwgc3VjaCBwYWNrZXQgZG9lc24ndCBjYXJyeSBhbnkgZGF0YS4gIFRvIHNlbmQK
Pj5yZWNvcmQsIHBhY2tldCB3aXRoIHN0YXJ0IG1hcmtlciBpcyBzZW50IGZpcnN0LCB0aGVuIGFs
bCBkYXRhIGlzIHNlbnQKPj5hcyB1c3VhbCAnUlcnIHBhY2tldHMuIE9uIHJlY2VpdmVyJ3Mgc2lk
ZSwgbGVuZ3RoIG9mIHJlY29yZCBpcyBrbm93bgo+PmZyb20gcGFja2V0IHdpdGggc3RhcnQgcmVj
b3JkIG1hcmtlci4gTm93IGFzICBwYWNrZXRzIG9mIG9uZSBzb2NrZXQKPj5hcmUgbm90IHJlb3Jk
ZXJlZCBuZWl0aGVyIG9uIHZzb2NrIG5vciBvbiB2aG9zdCB0cmFuc3BvcnQgbGF5ZXJzLCBzdWNo
Cj4+bWFya2VyIGFsbG93cyB0byByZXN0b3JlIG9yaWdpbmFsIHJlY29yZCBvbiByZWNlaXZlcidz
IHNpZGUuIElmIHVzZXIncwo+PmJ1ZmZlciBpcyBzbWFsbGVyIHRoYXQKPgo+dGhhbgo+Cj4KPj4g
IHJlY29yZCBsZW5ndGgsIHdoZW4KPgo+dGhlbgo+Cj4KPj4gIHYxIC0+IHYyOgo+PiAgLSBwYXRj
aGVzIHJlb3JkZXJlZDogYWZfdnNvY2suYyBjaGFuZ2VzIG5vdyBiZWZvcmUgdmlydGlvIHZzb2Nr
Cj4+ICAtIHBhdGNoZXMgcmVvcmdhbml6ZWQ6IG1vcmUgc21hbGwgcGF0Y2hlcywgd2hlcmUgKy8t
IGFyZSBub3QgbWl4ZWQKPgo+SWYgeW91IGRpZCB0aGlzIGJlY2F1c2UgSSBhc2tlZCwgdGhlbiB0
aGlzCj5pcyBub3Qgd2hhdCBJIGFza2VkLiA6KQo+WW91IGNhbid0IGp1c3QgYWRkIHNvbWUgc3Rh
dGljIGZ1bmMgaW4gYQo+c2VwYXJhdGUgcGF0Y2gsIGFzIGl0IHdpbGwganVzdCBwcm9kdWNlIHRo
ZQo+Y29tcGlsYXRpb24gd2FybmluZyBvZiBhbiB1bnVzZWQgZnVuY3Rpb24uCj5JIG9ubHkgYXNr
ZWQgdG8gc2VwYXJhdGUgdGhlIHJlZmFjdG9yaW5nIGZyb20KPnRoZSBuZXcgY29kZS4gSS5lLiBp
ZiB5b3UgbW92ZSBzb21lIGNvZGUKPmJsb2NrIHRvIGEgc2VwYXJhdGUgZnVuY3Rpb24sIHlvdSBz
aG91bGRuJ3QKPnNwbGl0IHRoYXQgaW50byAyIHBhdGNoZXMsIG9uZSB0aGF0IGFkZHMgYQo+Y29k
ZSBibG9jayBhbmQgYW5vdGhlciBvbmUgdGhhdCByZW1vdmVzIGl0Lgo+SXQgc2hvdWxkIGJlIGlu
IG9uZSBwYXRjaCwgc28gdGhhdCBpdCBpcyBjbGVhcgo+d2hhdCB3YXMgbW92ZWQsIGFuZCBubyBu
ZXcgd2FybmluZ3MgYXJlCj5pbnRyb2R1Y2VkLgo+V2hhdCBJIGFza2VkIHRvIHNlcGFyYXRlLCBp
cyB0aGUgb2xkIGNvZGUKPm1vdmVzIHdpdGggdGhlIG5ldyBjb2RlIGFkZGl0aW9ucy4gU3VjaAo+
dGhpbmdzIGNhbiBkZWZpbml0ZWx5IGdvIGluIGEgc2VwYXJhdGUgcGF0Y2hlcy4KCkFyc2VueSwg
dGhhbmtzIGZvciB0aGUgdjIuCkkgYXBwcmVjaWF0ZWQgdGhhdCB5b3UgbW92ZWQgdGhlIGFmX3Zz
b2NrIGNoYW5nZXMgYmVmb3JlIHRoZSB0cmFuc3BvcnQKYW5kIGFsc28gdGhlIHRlc3QsIGJ1dCBJ
IGFncmVlIHdpdGggc3RzcCBhYm91dCBzcGxpdCBwYXRjaGVzLgoKQXMgc3RzcCBzdWdnZXN0ZWQs
IHlvdSBjYW4gaGF2ZSBzb21lICJwcmVwYXJhdGlvbiIgcGF0Y2hlcyB0aGF0IHRvdWNoCnRoZSBh
bHJlYWR5IGV4aXN0aW5nIGNvZGUgKGUuZy4gcmVuYW1lIHZzb2NrX3N0cmVhbV9zZW5kbXNnIGlu
CnZzb2NrX2Nvbm5lY3RpYmxlX3NlbmRtc2coKSBhbmQgY2FsbCBpdCBpbnNpZGUgdGhlIG5ldwp2
c29ja19zdHJlYW1fc2VuZG1zZywgZXRjLiksIHRoZW4gYSBwYXRjaCB0aGF0IGFkZHMgc2VxcGFj
a2V0IHN0dWZmIGluCmFmX3Zzb2NrLgoKQWxzbyBmb3IgdmlydGlvL3Zob3N0IHRyYW5zcG9ydHMs
IHlvdSBjYW4gaGF2ZSBzb21lIHBhdGNoZXMgdGhhdCBhZGQKc3VwcG9ydCBpbiB2aXJ0aW9fdHJh
bnNwb3J0X2NvbW1vbiwgdGhlbiBhIHBhdGNoIHRoYXQgZW5hYmxlIGl0IGluCnZpcnRpb190cmFu
c3BvcnQgYW5kIGEgcGF0Y2ggZm9yIHZob3N0X3Zzb2NrLCBhcyB5b3UgcmlnaHRseSBkaWQgaW4K
cGF0Y2ggMTIuCgpTbywgSSdkIHN1Z2dlc3QgbW92aW5nIG91dCB0aGUgY29kZSB0aGF0IHRvdWNo
ZXMgdmlydGlvX3RyYW5zcG9ydC5jCmZyb20gcGF0Y2ggMTEuCgpUaGVzZSBjaGFuZ2VzIHNob3Vs
ZCBzaW1wbGlmeSB0aGUgcmV2aWV3LgoKSW4gYWRkaXRpb24sIHlvdSBjYW4gYWxzbyByZW1vdmUg
dGhlIC4gZnJvbSB0aGUgY29tbWl0IHRpdGxlcy4KCgpJIGxlZnQgb3RoZXIgY29tbWVudHMgaW4g
dGhlIHNpbmdsZSBwYXRjaGVzLgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
