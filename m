Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD57C7EE29
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 06:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0933340568;
	Sun, 28 May 2023 06:29:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0933340568
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJdVF9Wk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wVZj_1shRgBl; Sun, 28 May 2023 06:29:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6ACAF404F9;
	Sun, 28 May 2023 06:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6ACAF404F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33C08C0036;
	Sun, 28 May 2023 06:29:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31E96C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2DD760C2C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2DD760C2C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJdVF9Wk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N0Es9fT4in2S
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:29:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3094B60B9C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3094B60B9C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685255350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1z1TCz2XlwxREEQEluVbhG7+rqICZNvx0IHizhIGLQ=;
 b=IJdVF9WkrsGGGk9je/z7heM6Jk1tLcDMmTE/qTlGN0PSKSMhI5kgQ1Se4PfggruC/8W/gi
 OL+se4RwbEnjIvJFgzq9/WJ6k+lrDBDL4PiTzJnlSHcO8BvfRYtgFVOF97jOkekH+zPIpc
 RsJ9MNCRIRuC7+gkRc5UWwi34GnglXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-0w2N8AXyP5CUpCrvnMiEdw-1; Sun, 28 May 2023 02:29:08 -0400
X-MC-Unique: 0w2N8AXyP5CUpCrvnMiEdw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7005d4a85so540125e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 23:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685255347; x=1687847347;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d1z1TCz2XlwxREEQEluVbhG7+rqICZNvx0IHizhIGLQ=;
 b=laANH2F+POlFAbfilzHP8Lpls2cR9kLCZXwYbFeV+YlbgtHLu26GNeE8VbFYJbZIIn
 db9jh/lu/sYA1kHx/DzvMN2pwU9ngNAZh5hHoE3lOwu5PICyRTrhPBwo3mM2zVreWqvE
 arCf48uIYPmdStbvSdkTKGUViwOWBvM1Z4kMcvUBE8zxXl5ZwT3+pAn4YtCI3bZ+Cck3
 LEEK5bLFQGj2Sdl/eS1ME2e6lXAfjycpv1hpRK84+8sSQf0F9xPtLWUKu9gAxEveyQ6L
 rEF5W0knVcpb7LfMkrkJWWVvOxxuJCbDg/XaUaTN60StA4w/TxbxVkAdUzN/+mvV0r/k
 vQ7g==
X-Gm-Message-State: AC+VfDzvXPE48F6EmRuVzdagq4bQeUVlecGAf/Gg4txvGEz04/178HRt
 PU/GyXxSuWwEoW6/yqUJViC0PKIVM4yoDiPYjnqF1+BYRFi/pq+RmJWDIyZwEa0Zi060I+/0T7l
 eyQp4hvI4lVHESiG+d2BNHHj9ip54nC5h0cMpX/+lEw==
X-Received: by 2002:a7b:cc95:0:b0:3f5:1a4:a08d with SMTP id
 p21-20020a7bcc95000000b003f501a4a08dmr7162225wma.7.1685255347700; 
 Sat, 27 May 2023 23:29:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oMIRa2O5snnR2DBaZbn6UNByaPav76lWPUnAJoPlC/LhnJ393xJpdpLpMJQpzMKIgXPhbhw==
X-Received: by 2002:a7b:cc95:0:b0:3f5:1a4:a08d with SMTP id
 p21-20020a7bcc95000000b003f501a4a08dmr7162208wma.7.1685255347442; 
 Sat, 27 May 2023 23:29:07 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 z10-20020a7bc7ca000000b003f602e2b653sm13856777wmk.28.2023.05.27.23.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 23:29:06 -0700 (PDT)
Date: Sun, 28 May 2023 02:29:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
Message-ID: <20230528022737-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org,
 edumazet@google.com, netdev@vger.kernel.org, kuba@kernel.org,
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMDI6Mzg6NTRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIE1heSAyNiwgMjAyMyBhdCAxOjQ24oCvUE0gTGlhbmcgQ2hlbiA8bGlhbmdj
aGVuLmxpbnV4QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gInByaXZhdGUiIG9mIGJ1ZmZlciBw
YWdlIGlzIGN1cnJlbnRseSB1c2VkIGZvciBiaWcgbW9kZSB0byBjaGFpbiBwYWdlcy4KPiA+IEJ1
dCBpbiBtZXJnZWFibGUgbW9kZSwgdGhhdCBvZmZzZXQgb2YgcGFnZSBjb3VsZCBtZWFuIHNvbWV0
aGluZyBlbHNlLAo+ID4gZS5nLiB3aGVuIHBhZ2VfcG9vbCBwYWdlIGlzIHVzZWQgaW5zdGVhZC4g
U28gZXhjbHVkaW5nIG1lcmdlYWJsZSBtb2RlIHRvCj4gPiBhdm9pZCBzdWNoIGEgcHJvYmxlbS4K
PiAKPiBJZiB0aGlzIGlzc3VlIGhhcHBlbnMgb25seSBpbiB0aGUgY2FzZSBvZiBwYWdlX3Bvb2ws
IGl0IHdvdWxkIGJlCj4gYmV0dGVyIHRvIHNxdWFzaCBpdCB0aGVyZS4KPiAKPiBUaGFua3MKCgpU
aGlzIGlzIGEgdGlueSBwYXRjaCBzbyBJIGRvbid0IGNhcmUuIEdlbmVyYWxseSBpdCdzIG9rCnRv
IGZpcnN0IHJld29yayBjb2RlIHRoZW4gY2hhbmdlIGZ1bmN0aW9uYWxpdHkuCmluIHRoaXMgY2Fz
ZSB3aGF0IEphc29uIHNheXMgb3MgcmlnaHQgZXNwZWNpYWxseSBiZWNhdXNlCnlvdSB0aGVuIGRv
IG5vdCBuZWVkIHRvIGV4cGxhaW4gdGhhdCBjdXJyZW50IGNvZGUgaXMgb2suCgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IExpYW5nIENoZW4gPGxpYW5nY2hlbi5saW51eEBnbWFpbC5jb20+Cj4gPiAt
LS0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gaW5k
ZXggNWE3ZjdhNzZiOTIwLi5jNWRjYTBkOTJlNjQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gQEAg
LTQ5Nyw3ICs0OTcsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7Cj4gPgo+ID4gICAgICAgICAgICAgICAgIHBhZ2UgPSAoc3RydWN0IHBhZ2UgKilwYWdlLT5w
cml2YXRlOwo+ID4gLSAgICAgICAgICAgICAgIGlmIChwYWdlKQo+ID4gKyAgICAgICAgICAgICAg
IGlmICghdmktPm1lcmdlYWJsZV9yeF9idWZzICYmIHBhZ2UpCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBnaXZlX3BhZ2VzKHJxLCBwYWdlKTsKPiA+ICAgICAgICAgICAgICAgICBnb3RvIG9r
Owo+ID4gICAgICAgICB9Cj4gPiAtLQo+ID4gMi4zMS4xCj4gPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
