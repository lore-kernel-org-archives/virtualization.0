Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE968E7D0C2
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 03:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 671B540B30;
	Fri, 22 Sep 2023 03:02:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 671B540B30
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=It9w5Qj8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VDew8OvfauHD; Fri, 22 Sep 2023 03:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0220A40154;
	Fri, 22 Sep 2023 03:02:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0220A40154
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE317C0071;
	Fri, 22 Sep 2023 03:02:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 584D5C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32DE861012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:02:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32DE861012
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=It9w5Qj8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fHtMYyn-hOH1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:02:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EA516100B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:02:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EA516100B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695351756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqcKAldc0rTAWjL+HzqUoeMVPCAyI6Kth5oYS2zXAKw=;
 b=It9w5Qj8tYQf10Qhx/6566+Z7uKnuBy4O9TnxRRog5Nj1jqMxwvzI3hXzeMQbHzAw57gha
 7I0wBNu4Oe1rZI0TX041BdYM6IDPCRnCA8eRBB9aEFqmSoV1rjQniEohd3ObGEI6rSCmCh
 VvEo9T9U/N+8BYEmZ8GinOHt3R1OhGQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-HorUifaDP-y3p8AoKTjSXA-1; Thu, 21 Sep 2023 23:02:35 -0400
X-MC-Unique: HorUifaDP-y3p8AoKTjSXA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2bfe9ed93easo14220901fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695351753; x=1695956553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqcKAldc0rTAWjL+HzqUoeMVPCAyI6Kth5oYS2zXAKw=;
 b=LvnrJNY26xMFosTQFf5plS1zMjlRgnK1V0gjaGbW4QOWx/jJrrOBKHWKZh6SbhVdrO
 2Lp3LTJr7suNH6BPtDACH3wCiAaUbF+kz/brYkqgeISlDoNdkwZ4tqlCwsW2/1swvaDA
 V0siS9dt7GkGNT6pWJ05egkGcXgdRyROj9EwuOKGkpCt9RSir9zVC/fs/d7TqwrmsPdG
 y2x850w7RzDdT6bIiFwWow0Jm28FH5OQY6RudMa0xvIFd6dAfoJRwe7zeUjWETBTnH/6
 dlDA7/hM9tC6zLsQHenb8OrneUYS3bL/J8sYuQcRheYRArNCdAHZgwjOFpbH5NQ1afnz
 1KeQ==
X-Gm-Message-State: AOJu0YwHa3aLWyEGOvML0vsdwMBFBEv6IwGromgPlOrUmat9XACCCfHh
 kV4h+gh5uVWLjeNj4QKrRZ1A6l0rgYFQF/4XyecMnrbq7oWrXSo0v89nwfiKe9cicHcGbb/C60x
 s5scpT3HPsGFK5RdsU1G4LuWQGwPNaY+JG++mxO3bKcbvUZda98YslTePXjQt0wrhEi+q
X-Received: by 2002:a2e:a270:0:b0:2bf:fa16:3aa3 with SMTP id
 k16-20020a2ea270000000b002bffa163aa3mr414843ljm.25.1695351753197; 
 Thu, 21 Sep 2023 20:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWPaR20LlK/x64yTtW4K1k8WLbyTe7kqQkHaO0WwMNdbdXwq8V+owBL4qNTHfquiQaV1xGp/OsP0CGi7v26wc=
X-Received: by 2002:a2e:a270:0:b0:2bf:fa16:3aa3 with SMTP id
 k16-20020a2ea270000000b002bffa163aa3mr414834ljm.25.1695351752920; Thu, 21 Sep
 2023 20:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921155834-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:02:21 +0800
Message-ID: <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgNDoxNuKAr0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMDQ6NTM6NDVQ
TSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+ID4gT24gVGh1LCBTZXAgMjEsIDIwMjMg
YXQgMDM6MzQ6MDNQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4KPiA+ID4g
dGhhdCdzIGVhc3kvcHJhY3RpY2FsLiAgSWYgaW5zdGVhZCBWRFBBIGdpdmVzIHRoZSBzYW1lIHNw
ZWVkIHdpdGgganVzdAo+ID4gPiBzaGFkb3cgdnEgdGhlbiBrZWVwaW5nIHRoaXMgaGFjayBpbiB2
ZmlvIHNlZW1zIGxpa2UgbGVzcyBvZiBhIHByb2JsZW0uCj4gPiA+IEZpbmFsbHkgaWYgVkRQQSBp
cyBmYXN0ZXIgdGhlbiBtYXliZSB5b3Ugd2lsbCByZWNvbnNpZGVyIHVzaW5nIGl0IDspCj4gPgo+
ID4gSXQgaXMgbm90IGFsbCBhYm91dCB0aGUgc3BlZWQuCj4gPgo+ID4gVkRQQSBwcmVzZW50cyBh
bm90aGVyIGxhcmdlIGFuZCBjb21wbGV4IHNvZnR3YXJlIHN0YWNrIGluIHRoZQo+ID4gaHlwZXJ2
aXNvciB0aGF0IGNhbiBiZSBlbGltaW5hdGVkIGJ5IHNpbXBseSB1c2luZyBWRklPLgo+Cj4gSWYg
YWxsIHlvdSB3YW50IGlzIHBhc3NpbmcgdGhyb3VnaCB5b3VyIGNhcmQgdG8gZ3Vlc3QKPiB0aGVu
IHllcyB0aGlzIGNhbiBiZSBhZGRyZXNzZWQgImJ5IHNpbXBseSB1c2luZyBWRklPIi4KCisxLgoK
QW5kIHdoYXQncyBtb3JlLCB1c2luZyBNTUlPIEJBUjAgdGhlbiBpdCBjYW4gd29yayBmb3IgbGVn
YWN5LgoKSSBoYXZlIGEgaGFuZHkgdmlydGlvIGhhcmR3YXJlIGZyb20gb25lIHZlbmRvciB0aGF0
IHdvcmtzIGxpa2UgdGhpcywKYW5kIEkgc2VlIGl0IGlzIGRvbmUgYnkgYSBsb3Qgb2Ygb3RoZXIg
dmVuZG9ycy4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
