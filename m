Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEE8C77B75
	for <virtualization@archiver.kernel.org>; Sun,  7 May 2023 13:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 394FE82114;
	Sun,  7 May 2023 13:34:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 394FE82114
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZ+64GcI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8513UwD7eik; Sun,  7 May 2023 13:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 173A7820D4;
	Sun,  7 May 2023 13:34:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 173A7820D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E853CC0036;
	Sun,  7 May 2023 13:34:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29272C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 032D940CBD
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 032D940CBD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZ+64GcI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOKp7v97qwXJ
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:34:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 165B940C96
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 165B940C96
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683466452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65lQRJ+gv4EXk4uO01YGhnAV/eJrvV/vUJvZ5bnqIuQ=;
 b=FZ+64GcI7G7eUg9Z2P1IfwyDgLuDohQQ8NPx1AWQDckmiKlmWpK5IZ/qTIksq6ZXhWw6Y/
 MqkIhShrWMLu6OJQmOjbURd6FUv6pQuWnHLlvbn4Zt1G6P8gjYYs0VaV4oadvZkBC8iUWB
 Mx58xVWpZ2Wg2Vq9/Mch53rRwaJbLWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-5UIF6defNRiM1aCA6v7WCA-1; Sun, 07 May 2023 09:34:11 -0400
X-MC-Unique: 5UIF6defNRiM1aCA6v7WCA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f16ef3be6eso22157325e9.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 06:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683466450; x=1686058450;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=65lQRJ+gv4EXk4uO01YGhnAV/eJrvV/vUJvZ5bnqIuQ=;
 b=Pe2eVYgk2bALi4s0xJt8Ggfk4AWkZkUzlpO5hdVQimUzh+46qaswU382xG7WTVHDne
 A0VMZbY/Eu0HDl9M09dVnpi3IvhyhwP7BQYRICNlZsOGvjT0JZYxgs2SSdGgnC96tAq1
 gom4KoNZZYCO2mt+EmyLiUmnAKW07zr3JG7nOXGLzwHAVTJedK1gr0ZZHAFBxrb9expm
 mvNMyls7u7BEl7KGpn/vq6FWfGD+iVbvyRnSkNoKVmUKsuK4AQ2Yvp5e2zSm5e7Gw6au
 U3aBVSKfQl3ehd7/OvTXf4bqMayWItYNPJkC0UepBF6hjEDH5TjnmLtwP7iollic4l3m
 /hDQ==
X-Gm-Message-State: AC+VfDy7Dpw93N+oDMGjfd1a6keHO9GUhYCdIbN9xaYmD3Zn6rHBM7lJ
 ffLbdGlvWOoyO5u3VQVDWE8n46TOgY4dCuZNbcGG8FcXNTKYxZscAFDlVeNoKtE4unnxh+8ssUz
 bTMOn9oEtMH2Q3Z6Kl710uhuXZazWws3xOfT/rxdJVg==
X-Received: by 2002:a05:600c:28b:b0:3f4:2438:31c7 with SMTP id
 11-20020a05600c028b00b003f4243831c7mr595360wmk.19.1683466450676; 
 Sun, 07 May 2023 06:34:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dlYJQ5LxrwZA0O74DMJJmxxnf1OSnMdKKrqzXaZWy/VspuXbmfoua2VeVLQcpx7zhqb/0Fw==
X-Received: by 2002:a05:600c:28b:b0:3f4:2438:31c7 with SMTP id
 11-20020a05600c028b00b003f4243831c7mr595347wmk.19.1683466450367; 
 Sun, 07 May 2023 06:34:10 -0700 (PDT)
Received: from redhat.com ([2.52.158.28]) by smtp.gmail.com with ESMTPSA id
 z17-20020a1c4c11000000b003ee20b4b2dasm13605868wmf.46.2023.05.07.06.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 May 2023 06:34:09 -0700 (PDT)
Date: Sun, 7 May 2023 09:34:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230507093328-mutt-send-email-mst@kernel.org>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
 Wenliang Wang <wangwenliang.1995@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBNYXkgMDUsIDIwMjMgYXQgMTE6Mjg6MjVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIE1heSA0LCAyMDIzIGF0IDEwOjI34oCvQU0gV2VubGlhbmcgV2FuZwo+IDx3
YW5nd2VubGlhbmcuMTk5NUBieXRlZGFuY2UuY29tPiB3cm90ZToKPiA+Cj4gPiBGb3IgbXVsdGkt
cXVldWUgYW5kIGxhcmdlIHJpbmctc2l6ZSB1c2UgY2FzZSwgdGhlIGZvbGxvd2luZyBlcnJvcgo+
ID4gb2NjdXJyZWQgd2hlbiBmcmVlX3VudXNlZF9idWZzOgo+ID4gcmN1OiBJTkZPOiByY3Vfc2No
ZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUuCj4gPgo+ID4gRml4ZXM6IDk4NmE0ZjRkNDUy
ZCAoInZpcnRpb19uZXQ6IG11bHRpcXVldWUgc3VwcG9ydCIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZW5saWFuZyBXYW5nIDx3YW5nd2VubGlhbmcuMTk5NUBieXRlZGFuY2UuY29tPgo+ID4gLS0tCj4g
PiB2MjoKPiA+IC1hZGQgbmVlZF9yZXNjaGVkIGNoZWNrLgo+ID4gLWFwcGx5IHNhbWUgbG9naWMg
dG8gc3EuCj4gPiB2MzoKPiA+IC11c2UgY29uZF9yZXNjaGVkIGluc3RlYWQuCj4gPiB2NDoKPiA+
IC1hZGQgZml4ZXMgdGFnCj4gPiAtLS0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAy
ICsrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiA+IGluZGV4IDhkODAzODUzOGZjNC4uYTEyYWUyNmRiMGUyIDEwMDY0NAo+ID4gLS0tIGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiA+IEBAIC0zNTYwLDEyICszNTYwLDE0IEBAIHN0YXRpYyB2b2lkIGZyZWVfdW51c2VkX2J1ZnMo
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRx
dWV1ZSAqdnEgPSB2aS0+c3FbaV0udnE7Cj4gPiAgICAgICAgICAgICAgICAgd2hpbGUgKChidWYg
PSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxMKQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYodnEsIGJ1Zik7Cj4gPiAr
ICAgICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7Cj4gCj4gRG9lcyB0aGlzIHJlYWxseSBhZGRy
ZXNzIHRoZSBjYXNlIHdoZW4gdGhlIHZpcnRxdWV1ZSBpcyB2ZXJ5IGxhcmdlPwo+IAo+IFRoYW5r
cwoKCml0IGRvZXMgaW4gdGhhdCBhIHZlcnkgbGFyZ2UgcXVldWUgaXMgc3RpbGwganVzdCA2NGsg
aW4gc2l6ZS4Kd2UgbWlnaHQgaG93ZXZlciBoYXZlIDY0ayBvZiB0aGVzZSBxdWV1ZXMuCgo+ID4g
ICAgICAgICB9Cj4gPgo+ID4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9w
YWlyczsgaSsrKSB7Cj4gPiAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEgPSB2
aS0+cnFbaV0udnE7Cj4gPiAgICAgICAgICAgICAgICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVf
ZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxMKQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYodnEsIGJ1Zik7Cj4gPiArICAgICAgICAgICAg
ICAgY29uZF9yZXNjaGVkKCk7Cj4gPiAgICAgICAgIH0KPiA+ICB9Cj4gPgo+ID4gLS0KPiA+IDIu
MjAuMQo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
