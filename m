Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDD3C77B73
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 07:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8F7D60C1D;
	Wed, 31 May 2023 07:28:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8F7D60C1D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RYO+BX4X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g9JvMUL3cHIC; Wed, 31 May 2023 07:28:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF81B607EC;
	Wed, 31 May 2023 07:28:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF81B607EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 942BCC007C;
	Wed, 31 May 2023 07:28:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07E0DC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D755641CA2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:28:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D755641CA2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RYO+BX4X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TEfrlgSiJ3Jw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:28:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B47F140A01
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B47F140A01
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685518088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/jcj1p+dPSX4LPtsNzKmq9GtWWjgKaTvB7WD/Tt27U=;
 b=RYO+BX4XX3EvuqiVeJsxz6VaPTU+Wdl7Sc8TVz2xEvetWlsntNu0aKAIWlJaCblRguMdaU
 xe9AKwzSL4BQWiEyqZ8PHp8RTfOhUfupOVP9og8YAhf2RWzmU0A7fk/lPGAnb2XboCxcy0
 M1DrUtet1zeg6Qx3nbQLZG+nXIDp5fM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-7LbHDD4VMdWt2E-91foVMw-1; Wed, 31 May 2023 03:28:07 -0400
X-MC-Unique: 7LbHDD4VMdWt2E-91foVMw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-ba8338f20bdso6326196276.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 00:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685518086; x=1688110086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/jcj1p+dPSX4LPtsNzKmq9GtWWjgKaTvB7WD/Tt27U=;
 b=TWUJXDMnR/krMsmGzGgNtGSEZz608YSdFIt/REWxlGKzN5EDHlVWECyzzkFErh+teO
 yHJuNyPXECbSAY8fpZczgLvVrueOIaokTPyNYkzBYBI9gb9EWfjfPtyyREXKTOfdz3GP
 emJSHn00lycHlmfCykNWWiI8216gF5VTpQ/7oevV4pTMJw12LHDBrJkNCIPyJOyHaNVt
 3NvYBQ+3IN5tb7tiNWC8FIXtirdz/+Nq9K5cbELt+cz0bCuhmQ9lxSa32PzMhVDyoDK8
 ADe132HRKELZ0jFQubYeBaJVHh+0dJGYFhst8HlSfacRm5hdRssUUq7LXwmyH44GSVUj
 aM4Q==
X-Gm-Message-State: AC+VfDyihQuuLCpavoYZE2mJYJ/jNw4leE4pci77bjCqeD9rnE62Thnj
 9e8BbHMj5wDVlyxdBzAAA27lIfddG7q8Y8//PhWpHrOUcL9cZwguhmvgP6tAQMWs/J96VZsHcvc
 V5QiUTa9uYox/hwjKYXLObBS7hdViFW2peSz0jcDr9h//UTnrrA8fXNFZtQ==
X-Received: by 2002:a25:e74a:0:b0:ba8:c000:3da8 with SMTP id
 e71-20020a25e74a000000b00ba8c0003da8mr5501235ybh.32.1685518086708; 
 Wed, 31 May 2023 00:28:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Plgt9hmPFiSDXc0oeLAkYKsykTTqd4B5pwE2g+dpW8bCb+6KVSnOeDacyokQkuQP23w/NyGAste2scW2tm4Y=
X-Received: by 2002:a25:e74a:0:b0:ba8:c000:3da8 with SMTP id
 e71-20020a25e74a000000b00ba8c0003da8mr5501224ybh.32.1685518086460; Wed, 31
 May 2023 00:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001777f605fce42c5f@google.com>
 <20230530072310-mutt-send-email-mst@kernel.org>
 <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <CAGxU2F7HK5KRggiY7xnKHeXFRXJmqcKbjf3JnXC3mbmn9xqRtw@mail.gmail.com>
 <e4589879-1139-22cc-854f-fed22cc18693@oracle.com>
 <6p7pi6mf3db3gp3xqarap4uzrgwlzqiz7wgg5kn2ep7hvrw5pg@wxowhbw4e7w7>
 <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
In-Reply-To: <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 31 May 2023 09:27:54 +0200
Message-ID: <CAGxU2F5oTLY_weLixRKMQVqmjpDG_09yL6tS2rF8mwJ7K+xP0Q@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
To: michael.christie@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org,
 syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

T24gVHVlLCBNYXkgMzAsIDIwMjMgYXQgNjozMOKAr1BNIDxtaWNoYWVsLmNocmlzdGllQG9yYWNs
ZS5jb20+IHdyb3RlOgo+Cj4gT24gNS8zMC8yMyAxMToxNyBBTSwgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+ID4gT24gVHVlLCBNYXkgMzAsIDIwMjMgYXQgMTE6MDk6MDlBTSAtMDUwMCwgTWlr
ZSBDaHJpc3RpZSB3cm90ZToKPiA+PiBPbiA1LzMwLzIzIDExOjAwIEFNLCBTdGVmYW5vIEdhcnph
cmVsbGEgd3JvdGU6Cj4gPj4+IEkgdGhpbmsgaXQgaXMgcGFydGlhbGx5IHJlbGF0ZWQgdG8gY29t
bWl0IDZlODkwYzVkNTAyMSAoInZob3N0OiB1c2UKPiA+Pj4gdmhvc3RfdGFza3MgZm9yIHdvcmtl
ciB0aHJlYWRzIikgYW5kIGNvbW1pdCAxYTVmODA5MGM2ZGUgKCJ2aG9zdDogbW92ZQo+ID4+PiB3
b3JrZXIgdGhyZWFkIGZpZWxkcyB0byBuZXcgc3RydWN0IikuIE1heWJlIHRoYXQgY29tbWl0cyBq
dXN0Cj4gPj4+IGhpZ2hsaWdodGVkIHRoZSBpc3N1ZSBhbmQgaXQgd2FzIGFscmVhZHkgZXhpc3Rp
bmcuCj4gPj4KPiA+PiBTZWUgbXkgbWFpbCBhYm91dCB0aGUgY3Jhc2guIEFncmVlIHdpdGggeW91
ciBhbmFseXNpcyBhYm91dCB3b3JrZXItPnZ0c2sKPiA+PiBub3QgYmVpbmcgc2V0IHlldC4gSXQn
cyBhIGJ1ZyBmcm9tIG15IGNvbW1pdCB3aGVyZSBJIHNob3VsZCBoYXZlIG5vdCBzZXQKPiA+PiBp
dCBzbyBlYXJseSBvciBJIHNob3VsZCBiZSBjaGVja2luZyBmb3IKPiA+Pgo+ID4+IGlmIChkZXYt
PndvcmtlciAmJiB3b3JrZXItPnZ0c2spCj4gPj4KPiA+PiBpbnN0ZWFkIG9mCj4gPj4KPiA+PiBp
ZiAoZGV2LT53b3JrZXIpCj4gPgo+ID4gWWVzLCB0aG91Z2gsIGluIG15IG9waW5pb24gdGhlIHBy
b2JsZW0gbWF5IHBlcnNpc3QgZGVwZW5kaW5nIG9uIGhvdyB0aGUKPiA+IGluc3RydWN0aW9ucyBh
cmUgcmVvcmRlcmVkLgo+Cj4gQWggb2suCj4KPiA+Cj4gPiBTaG91bGQgd2UgcHJvdGVjdCBkZXYt
PndvcmtlcigpIHdpdGggYW4gUkNVIHRvIGJlIHNhZmU/Cj4KPiBGb3IgdGhvc2UgbXVsdGlwbGUg
d29ya2VyIHBhdGNoc2V0cyBKYXNvbiBoYWQgYXNrZWQgbWUgYWJvdXQgc3VwcG9ydGluZwo+IHdo
ZXJlIHdlIGRvbid0IGhhdmUgYSB3b3JrZXIgd2hpbGUgd2UgYXJlIHN3YXBwaW5nIHdvcmtlcnMg
YXJvdW5kLiBUbyBkbwo+IHRoYXQgSSBoYWQgYWRkZWQgcmN1IGFyb3VuZCB0aGUgZGV2LT53b3Jr
ZXIuIEkgcmVtb3ZlZCBpdCBpbiBsYXRlciBwYXRjaHNldHMKPiBiZWNhdXNlIEkgZGlkbid0IHRo
aW5rIGFueW9uZSB3b3VsZCB1c2UgaXQuCj4KPiByY3Ugd291bGQgd29yayBmb3IgeW91ciBjYXNl
IGFuZCBmb3Igd2hhdCBKYXNvbiBoYWQgcmVxdWVzdGVkLgoKWWVhaCwgc28geW91IGFscmVhZHkg
aGF2ZSBzb21lIHBhdGNoZXM/CgpEbyB5b3Ugd2FudCB0byBzZW5kIGl0IHRvIHNvbHZlIHRoaXMg
cHJvYmxlbT8KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
