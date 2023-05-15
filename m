Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE3DC77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 01:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DC0941893;
	Mon, 15 May 2023 01:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DC0941893
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZJ3yGTv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AMOerrIu97Hk; Mon, 15 May 2023 01:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3AEC4188C;
	Mon, 15 May 2023 01:39:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3AEC4188C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92A12C0037;
	Mon, 15 May 2023 01:39:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B02E3C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76F4E40399
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:39:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76F4E40399
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZJ3yGTv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Orqp3px2a9ng
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:39:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69F84400FB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69F84400FB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684114752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzZpznKAP4TuR+habW0ZszgNdKh7TSEEPS9oqjQ8taw=;
 b=fZJ3yGTvL3x1nHu3KI1sTDpb1nbNKes12HAqEQds8ds2Vf0j6Jx0qu9ow7A8atFWzE9eq/
 2EytbKuRd6o0fk1UUvoh0hJsdB8B4W/TOkjAyoz2y4Dw5Lpwl9hMKs2uPHLITh3gjao3ni
 IiTSI2paADTIN5Hz8xNQMRMR0cTBdoE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-nECt3gj2MnS-kBlBnVaKQQ-1; Sun, 14 May 2023 21:39:10 -0400
X-MC-Unique: nECt3gj2MnS-kBlBnVaKQQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f139de8c55so8834343e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 18:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684114749; x=1686706749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzZpznKAP4TuR+habW0ZszgNdKh7TSEEPS9oqjQ8taw=;
 b=AN8KSQOCLOvVSDSHSs4itp7XhLt5TObNAJwKOHBuojNR7THEbiAe6JZw0LzUHqGJxL
 hxR7BlbE8eMRgZu1lE5cvvFeo/qkhgvw5S51W7qyM5QCitCLEkjgAciJ2Xe53lxZMJWl
 WW8tQABf13QZtcFFAHJqHKfQWtuL8rGaWTwefmCBiO7B31R0CI2uviNckYbiUxbJNUiw
 +nNxeJ3bPnCIBWRKQTuam8fCkP3/r1YYdY5UNZO0mES58dE7nMEKxkIFK/4wNJpkC4zT
 Nua6OaatAUpgAVtZgEo4JKF4gYNBcoVFh2VGhpZz+GQHyrgHw/Eh1ogEtdekb723FhEp
 DW4g==
X-Gm-Message-State: AC+VfDwC4Lr5hCkNhRNp+fra14J6u4QE92yTOLXohnQ8RITjZbs9E9FD
 PAut0aBkKDsqzZ+KzNaUJYM09s+CGWTn6PDtSKx9H9bGClwzBEVbG3N4adoAs6LlnqpmZfYP65o
 Rk4c72DxLSvaw3HiWhKkkDKWeLNCWZ6/S6SINhPWMLg2uo32RBRrZLFdllg==
X-Received: by 2002:ac2:5ed0:0:b0:4f0:1a45:2b10 with SMTP id
 d16-20020ac25ed0000000b004f01a452b10mr6450156lfq.10.1684114749292; 
 Sun, 14 May 2023 18:39:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fLf9De0PQocYy8p4SxCTr3aj5KDFtJ1MohJM5tkG8J/IkR6Go0zyYyrQO5WoQ3DIBnbrkqroKxlwKPyksfDs=
X-Received: by 2002:ac2:5ed0:0:b0:4f0:1a45:2b10 with SMTP id
 d16-20020ac25ed0000000b004f01a452b10mr6450151lfq.10.1684114748930; Sun, 14
 May 2023 18:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230509080902.104619-1-xuanzhuo@linux.alibaba.com>
 <20230509080902.104619-2-xuanzhuo@linux.alibaba.com>
 <ZF5Vv40TWNyFl0IN@infradead.org>
In-Reply-To: <ZF5Vv40TWNyFl0IN@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 May 2023 09:38:57 +0800
Message-ID: <CACGkMEu9BzOP-jTqO-7iiGZYYX_1hmcGdC2bL1HB_CLWWuvvNA@mail.gmail.com>
Subject: Re: [PATCH vhost v8 01/12] virtio_ring: split: separate dma codes
To: Christoph Hellwig <hch@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gRnJpLCBNYXkgMTIsIDIwMjMgYXQgMTE6MjfigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gQXMgc2FpZCBiZWZvcmUsIHBsZWFzZSBkb24ndCB0
cnkgdG8gZG8gd2VpcmQgcnVudGltZSBjaGVja3MgYmFzZWQKPiBvbiB0aGUgc2NhdHRlcmxpc3Qu
ICBXaGF0IHlvdSBoYXZlIHdvcmtzIGZvciBub3csIGJ1dCB0aGVyZSBhcmUKPiBwbGFucyB0byBy
ZXBhbGNlIHRoZSBwYWdlICsgb2Zmc2V0IHR1cGxlIGluIHRoZSBzY2F0dGVybGlzdCB3aXRoCj4g
anVzdCBhIHBoeXNfYWRkcl90LiAgQW5kIHdpdGggdGhhdCB5b3VyICJjbGV2ZXIiIHNjaGVtZSB3
aWxsIGJyZWFrCj4gaW5zdGFudGx5Lgo+CgpYdWFuLCBJIHRoaW5rIHdlIHByb2JhYmx5IG5lZWQg
dG8gZ28gYmFjayB0byB5b3VyIG9yaWdpbmFsIG1ldGhvZCB0aGF0CmlzIGhhdmluZyBhIGRlZGlj
YXRlZCBmbGFnIGFuZCBoZWxwZXIgZm9yIHByZSBtYXBwZWQgYnVmZmVycy4KClRoYW5rcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
