Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEC9C001DE
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 06:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2B5081DFD;
	Mon, 31 Jul 2023 06:30:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2B5081DFD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iVT8dpg0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vC8cuu5ROrov; Mon, 31 Jul 2023 06:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 581F581DED;
	Mon, 31 Jul 2023 06:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 581F581DED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B0EAC0071;
	Mon, 31 Jul 2023 06:30:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA836C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0CB440918
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0CB440918
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iVT8dpg0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fq1KWcSCZdbQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:30:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7DFC408B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7DFC408B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690785020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9F90Lb2s6G0ugGSS8D5PR3Nu2cqZtzEuNKJh0Awsb80=;
 b=iVT8dpg0TDxtbhOmiE+agqWIezsII3xOVtBNgyTN0e3alPuwLbN+yo8ysuIUKi8nsy9D/Y
 E3ZnRhxAJWTCDjcsivKylK3s06hdnYpKNwV1IIGFYajhD5mUN/Uzs7zwKs4eqef8khxs9j
 s7i3EaCA3CeByX92RU8j5Ii6evqJzk0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-oydup5kLN9KUsemR_3-GKQ-1; Mon, 31 Jul 2023 02:30:18 -0400
X-MC-Unique: oydup5kLN9KUsemR_3-GKQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9cde8a457so22029751fa.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jul 2023 23:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690785016; x=1691389816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F90Lb2s6G0ugGSS8D5PR3Nu2cqZtzEuNKJh0Awsb80=;
 b=P7+Hglr9E9fe8dbyK1BiRHZpSpCkG3pN7O27GE2KHUlNDnewJBJ2xPk+s1KMHB68Bk
 Ll9D2D/ZlnIp/gXqj3KxH9Pj5h79t7+ndzFx4fJw+Ruj2cH1TmOupTmv74R0GihefJSP
 0xm72T10MTbyib9PPTYMXBMAScazH/gfwlTyJoljbrWW1myJ1+aKx/c7iKEudrtqWlUm
 zPRJ7r4m1x9P6kdS1bK2rAxPA+jC7pIwk/KuDinKOvYALkUystyIn7QEzyY9IRVDILOh
 LuozYVw4i29eBjtN+HVdivOxK5KuO3OQkGN2Y6fI2SM3fi5xlh8JmGSqgTpoJfnbKbVR
 HEQQ==
X-Gm-Message-State: ABy/qLbjUe5Hu4zm5Nnr73958EBCzrn+zZpkjh9kXaKR4g0DGm720Vis
 OgB0m72K9+2etVuNLHENX9Sd4ZRNoofy88YpEgYC9dn5WXCRkrdA+KE1HMKf7i3lRrqwivfke9u
 Df6ZBSZuMDQsWGAfPHiA0svWhJAN+CYZLfCS/bUOB0CZen0C9iE31FuPaUQ==
X-Received: by 2002:a2e:99c5:0:b0:2b9:df53:4c2a with SMTP id
 l5-20020a2e99c5000000b002b9df534c2amr2649451ljj.20.1690785016712; 
 Sun, 30 Jul 2023 23:30:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGsf5BI9a89FmPfuA62UfQe/Gu3jAK6ZoAvqPzg14jDYGNtWJh1aM8aKl3uXlnUoU1eNeut1vEJYkKShriZjKE=
X-Received: by 2002:a2e:99c5:0:b0:2b9:df53:4c2a with SMTP id
 l5-20020a2e99c5000000b002b9df534c2amr2649436ljj.20.1690785016410; Sun, 30 Jul
 2023 23:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727054300-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 31 Jul 2023 14:30:04 +0800
Message-ID: <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMDQ6NTk6MzNQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gVGhleSByZWFsbHkgc2hvdWxkbid0IC0g
YW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8KPiA+ID4gcHJvZ3JhbSB3aWxsIGNyZWF0ZSBp
c3N1ZXMgaW4gdGhlIG5ldHdvcmtpbmcgc3RhY2suCj4gPgo+ID4gVW5mb3J0dW5hdGVseSwgaXQn
cyBub3QgcmFyZSBhcyB0aGUgZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRlZAo+ID4gdmlh
IGZpcm13YXJlIG9yIHNvZnR3YXJlLgo+Cj4gQ3VycmVudGx5IHRoYXQgbWVhbiBvbmUgZWl0aGVy
IGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+IGNhbiBtZWV0IGRlYWRs
aW5lcywgb3IgbG9zZXMgYWJpbGl0eSB0byByZXBvcnQgZXJyb3JzIGJhY2suCj4KPiA+ID4gQnV0
IGlmIHRoZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+ID4KPiA+IFRo
aXMgbWF5IGhhdmUgZmFsc2UgbmVnYXRpdmVzIGFuZCBtYXkgY29uZnVzZSB0aGUgbWFuYWdlbWVu
dC4KPiA+Cj4gPiBNYXliZSB3ZSBjYW4gZXh0ZW5kIHRoZSBuZXR3b3JraW5nIGNvcmUgdG8gYWxs
b3cgc29tZSBkZXZpY2Ugc3BlY2lmaWMKPiA+IGNvbmZpZ3VyYXRpb25zIHRvIGJlIGRvbmUgd2l0
aCBkZXZpY2Ugc3BlY2lmaWMgbG9jayB3aXRob3V0IHJ0bmwuIEZvcgo+ID4gZXhhbXBsZSwgc3Bs
aXQgdGhlIHNldF9jaGFubmVscyB0bwo+ID4KPiA+IHByZV9zZXRfY2hhbm5lbHMKPiA+IHNldF9j
aGFubmVscwo+ID4gcG9zdF9zZXRfY2hhbm5lbHMKPiA+Cj4gPiBUaGUgZGV2aWNlIHNwZWNpZmlj
IHBhcnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qgd2l0aG91dCBhIHJ0bmwgbG9jaz8K
PiA+Cj4gPiBUaGFua3MKPgo+Cj4gV291bGQgdGhlIGJlbmVmaXQgYmUgdGhhdCBlcnJvcnMgY2Fu
IGJlIHJlcG9ydGVkIHRvIHVzZXJzcGFjZSB0aGVuPwo+IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlv
dSB3aWxsIGhhdmUgdG8gc2hvdyBob3cgdGhpcyB3b3JrcyBmb3IgYXQgbGVhc3QKPiBvbmUgY2Fy
ZCBiZXNpZGVzIHZpcnRpby4KCkV2ZW4gZm9yIHZpcnRpbywgdGhpcyBzZWVtcyBub3QgZWFzeSwg
YXMgZS5nIHRoZQp2aXJ0bmV0X3NlbmRfY29tbWFuZCgpIGFuZCBuZXRpZl9zZXRfcmVhbF9udW1f
dHhfcXVldWVzKCkgbmVlZCB0bwphcHBlYXIgdG8gYmUgYXRvbWljIHRvIHRoZSBuZXR3b3JraW5n
IGNvcmUuCgpJIHdvbmRlciBpZiB3ZSBjYW4gcmUtY29uc2lkZXIgdGhlIHdheSBvZiBhIHRpbWVv
dXQgaGVyZSBhbmQgY2hvb3NlIGEKc2FuZSB2YWx1ZSBhcyBhIHN0YXJ0LgoKVGhhbmtzCgo+Cj4K
PiAtLQo+IE1TVAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
