Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC1C433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:24:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695C3208C7
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAF7taDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695C3208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0097485EC1;
	Mon,  3 Aug 2020 21:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qam1v0NKxUfD; Mon,  3 Aug 2020 21:24:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CE7484887;
	Mon,  3 Aug 2020 21:24:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 350A7C0889;
	Mon,  3 Aug 2020 21:24:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBBF5C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AA75687B47
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CGGLfaOS95Si
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:24:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0D14187B1D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596489839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jo615WZTpEY0jWsSBDhMKfTO9X12e9eG3FwUUEQGPi4=;
 b=ZAF7taDWfS4xTpQJqACz1rOo9Bxa07smt76PegYz+VrlqjalIZghhWV4or/znwTrztebvk
 KKbhXApLS8yU5LivWUfQBZbRTKCwbTyXVL0bHzJaHLwX/6AwO6ouip4A2TjWz5WycGrzm7
 DJnIVPYpOKjBkNpnvlXjJwXWF6qS29E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-XZyNMxsdNBKT7K3bAX5mYQ-1; Mon, 03 Aug 2020 17:23:58 -0400
X-MC-Unique: XZyNMxsdNBKT7K3bAX5mYQ-1
Received: by mail-ed1-f71.google.com with SMTP id b23so11206880edj.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=dXYb/lLcqMNHaL94ouMomDU8DMTLeQCp1rZbDZouExs=;
 b=BDwTDV7G0ZK0qZUPx3hGjqt0+b4Kav1AQjeQ0weh/J4cqg4v7910irlF7hq6lxlMEc
 7Yp+6nGvNJBWuI4FM0kt4H3AIKASDIki958h7EN1K62sy+PyFprgVqBoFuO2RCpy+S8E
 aADQAYWgm2DM7Cia04nCC+U1oBlWn2Dffpb7vW69nRGXuhX2ciW7FnBM4xOkY/g8/JMC
 fAj8AjJ8qtyhFoAZVlmMnsD54WrxB0C+Glf9tCLKHNCJhtP2QRmIpK+gXlca/8fiexMX
 BS3WN0Bt6LhKvD413BsjUYAR1Rd6pEpEfdo5jSa5l7ahkBffi6oQXKZGJ8bQS0031xVb
 p9bA==
X-Gm-Message-State: AOAM531tGA1TxdwAktGjiHuQNxaQc2qllo4xTGz/fZmHlENGZP4pCyiZ
 alDeqQDfzDHMOV0IMoU2zFujDbHJuqV+emg2gjt8oI4hYxEzIi0GLoUPN7uW8cO+7n3rDZm+C2N
 d/FfRK6ZZ5zaOX8etg+mDNjhdtHUBUQ23xvBYoSu5XA==
X-Received: by 2002:a50:d655:: with SMTP id c21mr17128422edj.49.1596489836977; 
 Mon, 03 Aug 2020 14:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9I1gjkEaXGh8qVzCjl0anLUZO0DuGenZt4s5ea0cJEoQXiT5U/ffATDFfC1PlsKqrxI5U+Q==
X-Received: by 2002:a50:d655:: with SMTP id c21mr17128405edj.49.1596489836766; 
 Mon, 03 Aug 2020 14:23:56 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6449.dip0.t-ipconnect.de. [91.12.100.73])
 by smtp.gmail.com with ESMTPSA id
 s15sm16948785ejb.16.2020.08.03.14.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 14:23:56 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 13/24] virtio_mem: correct tags for config space fields
Date: Mon, 3 Aug 2020 23:23:55 +0200
Message-Id: <CB3AAE22-6BCA-448E-B499-AA4554755518@redhat.com>
References: <20200803205814.540410-14-mst@redhat.com>
In-Reply-To: <20200803205814.540410-14-mst@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17F80)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Cgo+IEFtIDAzLjA4LjIwMjAgdW0gMjI6NTkgc2NocmllYiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPjoKPiAKPiDvu79TaW5jZSB0aGlzIGlzIGEgbW9kZXJuLW9ubHkgZGV2aWNl
LAo+IHRhZyBjb25maWcgc3BhY2UgZmllbGRzIGFzIGhhdmluZyBsaXR0bGUgZW5kaWFuLW5lc3Mu
Cj4gCj4gVE9ETzogY2hlY2sgb3RoZXIgdXNlcyBvZiBfX3ZpcnRpb1hYIHR5cGVzIGluIHRoaXMg
aGVhZGVyLAo+IHNob3VsZCBwcm9iYWJseSBiZSBfX2xlWFguCgpEb2VzbuKAmHQgbWF0dGVyIGlu
IHByYWN0aWNlIElJUkMsIGxpa2UgdGhpcyBjaGFuZ2UuIEJ1dCB3ZSBjb3VsZCBkbyBpdCAodGhl
IHNwZWMgZG9jdW1lbnRzIGV2ZXJ5dGhpbmcgYXMgX19sZSkgaW4gY2FzZSBpdCBtYWtlcyB0aGlu
Z3MgY2xlYXJlci4KCkFja2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNv
bT4KCj4gCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNv
bT4KPiAtLS0KPiBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX21lbS5oIHwgMTQgKysrKysrKy0t
LS0tLS0KPiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+
IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX21lbS5oIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19tZW0uaAo+IGluZGV4IGE5ZmZlMDQxODQzYy4uNzBlMDFjNjg3
ZDVlIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbWVtLmgKPiArKysg
Yi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX21lbS5oCj4gQEAgLTE4NSwyNyArMTg1LDI3IEBA
IHN0cnVjdCB2aXJ0aW9fbWVtX3Jlc3Agewo+IAo+IHN0cnVjdCB2aXJ0aW9fbWVtX2NvbmZpZyB7
Cj4gICAgLyogQmxvY2sgc2l6ZSBhbmQgYWxpZ25tZW50LiBDYW5ub3QgY2hhbmdlLiAqLwo+IC0g
ICAgX191NjQgYmxvY2tfc2l6ZTsKPiArICAgIF9fbGU2NCBibG9ja19zaXplOwo+ICAgIC8qIFZh
bGlkIHdpdGggVklSVElPX01FTV9GX0FDUElfUFhNLiBDYW5ub3QgY2hhbmdlLiAqLwo+IC0gICAg
X191MTYgbm9kZV9pZDsKPiArICAgIF9fbGUxNiBub2RlX2lkOwo+ICAgIF9fdTggcGFkZGluZ1s2
XTsKPiAgICAvKiBTdGFydCBhZGRyZXNzIG9mIHRoZSBtZW1vcnkgcmVnaW9uLiBDYW5ub3QgY2hh
bmdlLiAqLwo+IC0gICAgX191NjQgYWRkcjsKPiArICAgIF9fbGU2NCBhZGRyOwo+ICAgIC8qIFJl
Z2lvbiBzaXplIChtYXhpbXVtKS4gQ2Fubm90IGNoYW5nZS4gKi8KPiAtICAgIF9fdTY0IHJlZ2lv
bl9zaXplOwo+ICsgICAgX19sZTY0IHJlZ2lvbl9zaXplOwo+ICAgIC8qCj4gICAgICogQ3VycmVu
dGx5IHVzYWJsZSByZWdpb24gc2l6ZS4gQ2FuIGdyb3cgdXAgdG8gcmVnaW9uX3NpemUuIENhbgo+
ICAgICAqIHNocmluayBkdWUgdG8gVklSVElPX01FTV9SRVFfVU5QTFVHX0FMTCAoaW4gd2hpY2gg
Y2FzZSBubyBjb25maWcKPiAgICAgKiB1cGRhdGUgd2lsbCBiZSBzZW50KS4KPiAgICAgKi8KPiAt
ICAgIF9fdTY0IHVzYWJsZV9yZWdpb25fc2l6ZTsKPiArICAgIF9fbGU2NCB1c2FibGVfcmVnaW9u
X3NpemU7Cj4gICAgLyoKPiAgICAgKiBDdXJyZW50bHkgdXNlZCBzaXplLiBDaGFuZ2VzIGR1ZSB0
byBwbHVnL3VucGx1ZyByZXF1ZXN0cywgYnV0IG5vCj4gICAgICogY29uZmlnIHVwZGF0ZXMgd2ls
bCBiZSBzZW50Lgo+ICAgICAqLwo+IC0gICAgX191NjQgcGx1Z2dlZF9zaXplOwo+ICsgICAgX19s
ZTY0IHBsdWdnZWRfc2l6ZTsKPiAgICAvKiBSZXF1ZXN0ZWQgc2l6ZS4gTmV3IHBsdWcgcmVxdWVz
dHMgY2Fubm90IGV4Y2VlZCBpdC4gQ2FuIGNoYW5nZS4gKi8KPiAtICAgIF9fdTY0IHJlcXVlc3Rl
ZF9zaXplOwo+ICsgICAgX19sZTY0IHJlcXVlc3RlZF9zaXplOwo+IH07Cj4gCj4gI2VuZGlmIC8q
IF9MSU5VWF9WSVJUSU9fTUVNX0ggKi8KPiAtLSAKPiBNU1QKPiAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
