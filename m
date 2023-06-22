Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B699EB64DA
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 22:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1340A6061B;
	Thu, 22 Jun 2023 22:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1340A6061B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5els/K1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYKcVEEgy3LU; Thu, 22 Jun 2023 22:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8293460A84;
	Thu, 22 Jun 2023 22:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8293460A84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3879FC007A;
	Thu, 22 Jun 2023 22:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 060FBC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 22:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E22A460A84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 22:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E22A460A84
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6jxBoVa_KWU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 22:19:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE2296061B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE2296061B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687472397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8RTbUEcsXVxJGVp1cgZcgX/JYsR6GHDNvHugZoGaQ8=;
 b=f5els/K1GPNSTObvrQgKXZXV8Kslr+dA+dP+x/dJdcwSRnY2m6wUVxop7+AnYmBR9ojbIF
 +wO2JixVd8uL2aEhj+YFiqEL8CMakJ1uBnUMTZapICf/jy1ntllnWSBSM0orX3XTCQh0el
 eYWfo/gXllrf99I6Ce6Jx418FzW82TM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-dvyC58D_MSSlLD9e9V7XgQ-1; Thu, 22 Jun 2023 18:19:56 -0400
X-MC-Unique: dvyC58D_MSSlLD9e9V7XgQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3129750e403so696788f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687472395; x=1690064395;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8RTbUEcsXVxJGVp1cgZcgX/JYsR6GHDNvHugZoGaQ8=;
 b=LAnPvcUy+x5DEsp0LzccyuAOBY5g1mAbEpVEATNmsqM+RNhmerN73Yr3RewcwwQeLa
 cPKqWolzlQAAjZwbzSdf7DL4KB5prdgRQPEM2ER/f9mbGUaUUIOEQjbkD0qgf4Tk8ELt
 9Fk3tKg6FTfg6IRsg/6N9jn5+NUbeU9wcBKEtgFLc2bDkZem/UUVuBvVe0ksxHVB5LYp
 IY6CTCcKojOWQLZ3b0YYQZ5KVPktdOvroa5yACpqjmKl1RjZfgANMjc+d8TD6sAxEwY6
 kGqK0JIZxim054f1cdF5qiJ7gZVejU3+ExkZBAJkZO8jh4NR77xmOjHuOL4+SneutJgU
 qYZw==
X-Gm-Message-State: AC+VfDwo8V5t6W2lJGyfvCYtejv2qY95ZOvzrxbaSy6lCa4HcTU31LvD
 6KKMo8jxzEe8z332eNwRbnqkdZb+T/oHuAHa2gAk4JLwMIfQwE47Vg6TPfbDbT/vCMFK5k4LETn
 ep0/7jSdOBpIXw9ZqcPi6qbkCbakseGw0YOuoWem+xA==
X-Received: by 2002:a5d:6884:0:b0:30f:bb0c:d19d with SMTP id
 h4-20020a5d6884000000b0030fbb0cd19dmr15604594wru.64.1687472395004; 
 Thu, 22 Jun 2023 15:19:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tGVFhj88K9vXN9dEIt7gC+lJIK47dxUwDE9o4afC0zIAZHaBYJ2sfg+xB/WDyPkaGjaGs7w==
X-Received: by 2002:a5d:6884:0:b0:30f:bb0c:d19d with SMTP id
 h4-20020a5d6884000000b0030fbb0cd19dmr15604584wru.64.1687472394712; 
 Thu, 22 Jun 2023 15:19:54 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 i15-20020a5d55cf000000b0030633152664sm7923108wrw.87.2023.06.22.15.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 15:19:53 -0700 (PDT)
Date: Thu, 22 Jun 2023 18:19:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] block: virtio-blk: Fix handling of zone append command
 completion
Message-ID: <20230622181558-mutt-send-email-mst@kernel.org>
References: <20230620083857.611153-1-dlemoal@kernel.org>
 <CAFNWusY41eprBrH-95vp2uZFkxMpLh0iF7NZ8H6FznjQYSv31g@mail.gmail.com>
 <def64cdb-d36a-04c8-77cf-1ed0daa1ef0b@kernel.org>
MIME-Version: 1.0
In-Reply-To: <def64cdb-d36a-04c8-77cf-1ed0daa1ef0b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Suwan Kim <suwan.kim027@gmail.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Sam Li <faithilikerun@gmail.com>
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

T24gRnJpLCBKdW4gMjMsIDIwMjMgYXQgMDY6NTU6MjRBTSArMDkwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6Cj4gT24gNi8yMi8yMyAyMzozMiwgU3V3YW4gS2ltIHdyb3RlOgo+ID4gT24gVHVlLCBK
dW4gMjAsIDIwMjMgYXQgNTozOeKAr1BNIERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5v
cmc+IHdyb3RlOgo+ID4+Cj4gPj4gVGhlIGludHJvZHVjdGlvbiBvZiBjb21wbGV0aW9uIGJhdGNo
aW5nIHdpdGggY29tbWl0IDA3YjY3OWY3MGQ3Mwo+ID4+ICgidmlydGlvLWJsazogc3VwcG9ydCBj
b21wbGV0aW9uIGJhdGNoaW5nIGZvciB0aGUgSVJRIHBhdGgiKSBvdmVybGxva2VkCj4gPj4gaGFu
ZGxpbmcgY29ycmVjdGx5IHRoZSBjb21wbGV0aW9uIG9mIHpvbmUgYXBwZW5kIG9wZXJhdGlvbnMs
IHdoaWNoCj4gPj4gcmVxdWlyZSBhbiB1cGRhdGUgb2YgdGhlIHJlcXVlc3QgX19zZWN0b3IgZmll
bGQsIGFzIGlzIGRvbmUgaW4KPiA+PiB2aXJ0YmxrX3JlcXVlc3RfZG9uZSgpOiB0aGUgZnVuY3Rp
b24gdmlydGJsa19jb21wbGV0ZV9iYXRjaCgpIG9ubHkKPiA+PiBleGVjdXRlcyB2aXJ0YmxrX3Vu
bWFwX2RhdGEoKSBhbmQgdmlydGJsa19jbGVhbnVwX2NtZCgpIHdpdGhvdXQgZG9pbmcKPiA+PiB0
aGlzIHVwZGF0ZS4gVGhpcyBjYXVzZXMgcHJvYmxlbXMgd2l0aCB6b25lIGFwcGVuZCBvcGVyYXRp
b25zLCBlLmcuCj4gPj4gem9uZWZzIGNvbXBsYWlucyBhYm91dCBpbnZhbGlkIHpvbmUgYXBwZW5k
IGxvY2F0aW9ucy4KPiA+Pgo+ID4gCj4gPiBIaSBEYW1pZW4gTGUgTW9hbCwKPiA+IAo+ID4gVW5m
b3J0dW5hdGVseSwgdGhpcyBjb21taXQgd2FzIHJldmVydGVkIGR1ZSB0byBpbyBoYW5nLgo+ID4g
KGFmZDM4NGYwZGJlYTIyMjlmZDExMTU5ZWZiODZhNWI0MTA1MWM0YTkpCj4gPiBZb3UgY2FuIHNl
ZSB0aGUgbWFpbCB0aHJlYWQgYXQgdGhlIGJsb2NrIGxheWVyIG1haWxpbmcgbGlzdC4KPiAKPiBU
aGVyZSBpcyBubyBjb21taXQgYWZkMzg0ZjBkYmVhMjIyOWZkMTExNTllZmI4NmE1YjQxMDUxYzRh
OSBpbiBMaW51cyB0cmVlLiBXaGF0Cj4gcGF0Y2ggYXJlIHlvdSB0YWxraW5nIGFib3V0ID8gV2hl
cmUgaXMgaXQgPwoKRWl0aGVyIHlvdSBkaWRuJ3QgY2hlY2sgcmVjZW50bHkgZW5vdWdoLCBvciAg
dGhlcmUncyBzb21lCmJyZWFrYWdlIGFuZCB5b3VyIENETidzIG5vdCB1cGRhdGluZy4gSWYgdGhl
IGxhdGVyIHRyeQpwb2tpbmcga2VybmVsLm9yZyBhZG1pbnMuCgpUaGlzIGlzIHRoZSBjb21taXQ6
Cgpjb21taXQgYWZkMzg0ZjBkYmVhMjIyOWZkMTExNTllZmI4NmE1YjQxMDUxYzRhOQpBdXRob3I6
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CkRhdGU6ICAgVGh1IEp1biA4IDE3
OjQyOjUzIDIwMjMgLTA0MDAKCiAgICBSZXZlcnQgInZpcnRpby1ibGs6IHN1cHBvcnQgY29tcGxl
dGlvbiBiYXRjaGluZyBmb3IgdGhlIElSUSBwYXRoIgoKeW91IGNhbiBnZXQgdGhlIHBhdGNoIGZy
b20gbG9yZSB0b286CiAgICBNZXNzYWdlLUlkOiA8MzM2NDU1YjRmNjMwZjMyOTM4MGE4ZjUzZWU4
Y2FkMzg2ODc2NGQ1Yy4xNjg2Mjk1NTQ5LmdpdC5tc3RAcmVkaGF0LmNvbT4KCgo+IAo+ID4gV2Ug
ZG9uJ3QgaGF2ZSBhIHNvbHV0aW9uIGFib3V0IGlvIGhhbmcgeWV0Li4KPiA+IFNvIEkgaGF2ZSBv
bmUgcXVlc3Rpb24uCj4gPiBJcyB0aGVyZSBhbnkgcG9zc2liaWxpdHkgb2YgdmlydGJsay1kcml2
ZXIgaW8gaGFuZyBvbiB6b25lZCBkZXZpY2VzCj4gPiB3aXRob3V0IHRoaXMgcGF0Y2g/Cj4gCj4g
SWYgeW91IGFyZSB0YWxraW5nIGFib3V0IHRoZSBiYXRjaCBjb21wbGV0aW9uIHN1cHBvcnQgYmVp
bmcgcmV2ZXJ0ZWQsIHRoZW4gbXkKPiBmaXggcGF0Y2ggaXMgbm90IG5lY2Vzc2FyeS4gVGhlIGlz
c3VlIEkgZml4ZWQgaXMgbm90IGFib3V0IElPIGhhbmcgYnV0IHRoZSBmYWN0Cj4gdGhhdCBjb21w
bGV0aW9uIHByb2Nlc3Npbmcgd2FzIG5vdCBpZGVudGljYWwgZm9yIGJhdGNoIGNhc2UgdnMgbm9u
IGJhdGNoLiBUaGF0Cj4gbGVkIHRvIGJyZWFrYWdlIG9mIHRoZSB6b25lIGFwcGVuZCBjb21tYW5k
IGNvbXBsZXRpb24uIFRoZSBvcmlnaW5hbCBzdXBwb3J0IGZvcgo+IHpvbmUgYXBwZW5kIHdpdGhv
dXQgYmF0Y2ggY29tcGxldGlvbiBpcyBmaW5lLgoKWWVzIHRoYXQncyBncmVhdCEgSSBleHBlY3Qg
d2UnbGwgcmVhcHBseSB0aGUgYmF0Y2ggY29tcGxldGlvbgpkb3duIHRoZSByb2FkIGFuZCB0aGVu
IHlvdXIgcGF0Y2ggd291bGQgaGVscCEKCj4gPiAKPiA+IFJlZ2FyZHMsCj4gPiBTdXdhbiBLaW0K
PiAKPiAtLSAKPiBEYW1pZW4gTGUgTW9hbAo+IFdlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
