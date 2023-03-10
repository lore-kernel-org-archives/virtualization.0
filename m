Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF41C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6533081FDA;
	Fri, 10 Mar 2023 09:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6533081FDA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CV/uJ3Gr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ju2mG4NHzZQe; Fri, 10 Mar 2023 09:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E151281EC8;
	Fri, 10 Mar 2023 09:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E151281EC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B24D2C0035;
	Fri, 10 Mar 2023 09:33:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA0ACC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7791C81FDA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7791C81FDA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iq35X14W2uX3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:33:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1125981EC8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1125981EC8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678440804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vsva43SlvNVzUTvI3O0bV6X5ubbZe8SqHlJm6HBd1/c=;
 b=CV/uJ3GroHFgkTBZUhl+w9iFEHTQZ7MJRziKv1tXSr9IoGGvOADr84dBkoNbTf8Ey4AEnL
 ewDQLeINdAQF9ZhoZLce/OWeb3e5D9ujzw6ZjVoF82heXo/3wHtmh8nImyOC8wgG8aviiZ
 EOUe1wZ17b7wuxrbK9elR//V7g973ds=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-Jm4b03V8MjeDQdGhAgsHmQ-1; Fri, 10 Mar 2023 04:33:22 -0500
X-MC-Unique: Jm4b03V8MjeDQdGhAgsHmQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 r23-20020a05683001d700b0068bc6c8621eso2132396ota.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678440802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vsva43SlvNVzUTvI3O0bV6X5ubbZe8SqHlJm6HBd1/c=;
 b=oE7H61XQASSX4/Zo7dg6vtezs/Dj8iTdNA4JqL7e9XSTZp1lfSxtXA7LiE5OEg5eQF
 zoysgWeMjPqwXUXEM85hQQ2ZIaklS5Wq3IVXi118pe77FU6KiODRDEmjyi6BZL6Z+9IM
 KCwDvr+hJxtSP9Sr9QvUhcPonna1jNBJdhOPjWexjy6Wnuac2qCd3rk+qjumbyRyLA9O
 T8D1eawX/GC6PjeHHmd/N2CGCFj6ZFChyrRnmm3ROcGX5FG71RBTkQfqI7uec5UcA4TK
 aG0BQouBOUm1cnAbbM05CGB/pLXy9w3RboeqHhtB/9bDk/S5uOoKJ0wLcuDjQ7QhSoEo
 5giw==
X-Gm-Message-State: AO0yUKUvKgXcWNwPMiF7qirnADgwzxjAN1YUaaOTE64TeV7hehYM0of2
 S3YOqne1f546bpfYh+kzjKtGY3VI7W4URzy6HTqGDw0zLtBJyTvBhFKJG+PaQa0u74tAP/49Lrn
 uFd20zG5aMEfmcOUIFqKqIlKIvZGzS5fXJJCZNNMPvwq6usm77pDyjZG98Q==
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id
 ds49-20020a0568705b3100b001762b47b31dmr8653096oab.9.1678440802023; 
 Fri, 10 Mar 2023 01:33:22 -0800 (PST)
X-Google-Smtp-Source: AK7set83P3oWqYK4Zzz97ui17Vgfn+oYqz9zCdJBkWtYsJ9mz0XzWk8MkAaghgLZjlapXZGm5fgN9Uv+jFMEyJi8eXw=
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id
 ds49-20020a0568705b3100b001762b47b31dmr8653090oab.9.1678440801753; Fri, 10
 Mar 2023 01:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230310040546-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230310040546-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Mar 2023 17:33:10 +0800
Message-ID: <CACGkMEsz7=0itRiaTwW5TGAxH=gSoyzaO4u5JgdgZ3oWYdHdaQ@mail.gmail.com>
Subject: Re: [PATCH vhost v2 00/12] virtio core prepares for AF_XDP
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org
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

T24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgNTowNuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXIgMDgsIDIwMjMgYXQgMDI6NDQ6MzFQ
TSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gWERQIHNvY2tldChBRl9YRFApIGlzIGFuIGV4
Y2VsbGVudCBieXBhc3Mga2VybmVsIG5ldHdvcmsgZnJhbWV3b3JrLiBUaGUgemVybwo+ID4gY29w
eSBmZWF0dXJlIG9mIHhzayAoWERQIHNvY2tldCkgbmVlZHMgdG8gYmUgc3VwcG9ydGVkIGJ5IHRo
ZSBkcml2ZXIuIFRoZQo+ID4gcGVyZm9ybWFuY2Ugb2YgemVybyBjb3B5IGlzIHZlcnkgZ29vZC4K
PiA+Cj4gPiBFTlY6IFFlbXUgd2l0aCB2aG9zdC4KPiA+Cj4gPiAgICAgICAgICAgICAgICAgICAg
dmhvc3QgY3B1IHwgR3Vlc3QgQVBQIENQVSB8R3Vlc3QgU29mdGlycSBDUFUgfCBQUFMKPiA+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0t
LS0tLS18LS0tLS0tLS0tLS0tCj4gPiB4bWl0IGJ5IHNvY2twZXJmOiAgICAgOTAlICAgIHwgICAx
MDAlICAgICAgICB8ICAgICAgICAgICAgICAgICAgfCAgMzE4OTY3Cj4gPiB4bWl0IGJ5IHhzazog
ICAgICAgICAgMTAwJSAgIHwgICAzMCUgICAgICAgICB8ICAgMzMlICAgICAgICAgICAgfCAxMTky
MDY0Cj4gPiByZWN2IGJ5IHNvY2twZXJmOiAgICAgMTAwJSAgIHwgICA2OCUgICAgICAgICB8ICAg
MTAwJSAgICAgICAgICAgfCAgNjkyMjg4Cj4gPiByZWN2IGJ5IHhzazogICAgICAgICAgMTAwJSAg
IHwgICAzMyUgICAgICAgICB8ICAgNDMlICAgICAgICAgICAgfCAgNzcxNjcwCj4gPgo+ID4gQmVm
b3JlIGFjaGlldmluZyB0aGUgZnVuY3Rpb24gb2YgVmlydGlvLU5ldCwgd2UgYWxzbyBoYXZlIHRv
IGxldCB2aXJ0aW8gY29yZQo+ID4gc3VwcG9ydCB0aGVzZSBmZWF0dXJlczoKPiA+Cj4gPiAxLiB2
aXJ0aW8gY29yZSBzdXBwb3J0IHByZW1hcHBlZAo+ID4gMi4gdmlydGlvIGNvcmUgc3VwcG9ydCBy
ZXNldCBwZXItcXVldWUKPiA+IDMuIGludHJvZHVjZSBETUEgQVBJcyB0byB2aXJ0aW8gY29yZQo+
ID4KPiA+IFBsZWFzZSByZXZpZXcuCj4KPgo+IEphc29uIGNhbiBJIGdldCBzb21lIGFja3Mgb24g
dGhpcz8KCkluIG15IFRPRE8gbGlzdCwgSSB3aWxsIGRvIGl0IG5leHQgd2Vlay4KClRoYW5rcwoK
Pgo+ID4gVGhhbmtzLgo+ID4KPiA+IHYyOgo+ID4gIDEuIGJhc2VkIG9uIHNnc1swXS0+ZG1hX2Fk
ZHJlc3MgdG8ganVkZ21lbnQgaXMgcHJlbWFwcGVkCj4gPiAgMi4gYmFzZWQgb24gZXh0cmEuYWRk
ciB0byBqdWRnbWVudCB0byBkbyB1bm1hcCBmb3Igbm8taW5kaXJlY3QgZGVzYwo+ID4gIDMuIGJh
c2VkIG9uIGluZGlyX2Rlc2MgdG8ganVkZ21lbnQgdG8gZG8gdW5tYXAgZm9yIGluZGlyZWN0IGRl
c2MKPiA+ICA0LiByZW5hbWUgdmlydHF1ZXVlX2dldF9kbWFfZGV2IHRvIHZpcnRxdWV1ZV9kbWFf
ZGV2Cj4gPgo+ID4gdjE6Cj4gPiAgMS4gZXhwb3NlIGRtYSBkZXZpY2UuIE5PIGludHJvZHVjZSB0
aGUgYXBpIGZvciBkbWEgYW5kIHN5bmMKPiA+ICAyLiBzcGxpdCBzb21lIGNvbW1pdCBmb3IgcmV2
aWV3Lgo+ID4KPiA+IFh1YW4gWmh1byAoMTIpOgo+ID4gICB2aXJ0aW9fcmluZzogc3BsaXQ6IHNl
cGFyYXRlIGRtYSBjb2Rlcwo+ID4gICB2aXJ0aW9fcmluZzogcGFja2VkOiBzZXBhcmF0ZSBkbWEg
Y29kZXMKPiA+ICAgdmlydGlvX3Jpbmc6IHBhY2tlZC1pbmRpcmVjdDogc2VwYXJhdGUgZG1hIGNv
ZGVzCj4gPiAgIHZpcnRpb19yaW5nOiBzcGxpdDogc3VwcG9ydCBwcmVtYXBwZWQKPiA+ICAgdmly
dGlvX3Jpbmc6IHBhY2tlZDogc3VwcG9ydCBwcmVtYXBwZWQKPiA+ICAgdmlydGlvX3Jpbmc6IHNw
bGl0LWluZGlyZWN0OiBzdXBwb3J0IHByZW1hcHBlZAo+ID4gICB2aXJ0aW9fcmluZzogcGFja2Vk
LWluZGlyZWN0OiBzdXBwb3J0IHByZW1hcHBlZAo+ID4gICB2aXJ0aW9fcmluZzogdXBkYXRlIGRv
Y3VtZW50IGZvciB2aXJ0cXVldWVfYWRkXyoKPiA+ICAgdmlydGlvX3Jpbmc6IGludHJvZHVjZSB2
aXJ0cXVldWVfZG1hX2RldigpCj4gPiAgIHZpcnRpb19yaW5nOiBjb3JyZWN0IHRoZSBleHByZXNz
aW9uIG9mIHRoZSBkZXNjcmlwdGlvbiBvZgo+ID4gICAgIHZpcnRxdWV1ZV9yZXNpemUoKQo+ID4g
ICB2aXJ0aW9fcmluZzogc2VwYXJhdGUgdGhlIGxvZ2ljIG9mIHJlc2V0L2VuYWJsZSBmcm9tIHZp
cnRxdWV1ZV9yZXNpemUKPiA+ICAgdmlydGlvX3Jpbmc6IGludHJvZHVjZSB2aXJ0cXVldWVfcmVz
ZXQoKQo+ID4KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyAgICAgIHwgICA2ICsKPiA+ICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzU0ICsrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tCj4gPiAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAgNCArCj4g
PiAgMyBmaWxlcyBjaGFuZ2VkLCAyNjAgaW5zZXJ0aW9ucygrKSwgMTA0IGRlbGV0aW9ucygtKQo+
ID4KPiA+IC0tCj4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
