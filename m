Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F211C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 06:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BFC14019E;
	Thu, 20 Apr 2023 06:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BFC14019E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=La+nyW1Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t1NmkvLTAuZw; Thu, 20 Apr 2023 06:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 898E6400D1;
	Thu, 20 Apr 2023 06:29:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 898E6400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61776C0036;
	Thu, 20 Apr 2023 06:29:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E0FEC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F33041D9C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:29:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F33041D9C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=La+nyW1Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pv4IbO_97vJK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:29:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16BEE41BA8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16BEE41BA8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681972153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LgdnNmMXeh29yiOutomiP5kEsD1QGmIJDroopmJnClM=;
 b=La+nyW1Zu9XGgdnTmBmEh/K3Dm+kinibzwJ6uJWpkFai4xSfUX8EWFtEDO1pS5VmC3RnWY
 Ew5fIvQldoN84f6tKBlq7hM75j7oOwcl2Bueuo0ga+g92LIMHUzGr1zf/7PdfwsqqnfRND
 vpDGjW+JkujVHNa4lvcnWSHwrIq8f38=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-bPRQORDuOvyjjiPZRAH7fg-1; Thu, 20 Apr 2023 02:29:12 -0400
X-MC-Unique: bPRQORDuOvyjjiPZRAH7fg-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-38bf67eabedso191517b6e.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 23:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681972151; x=1684564151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgdnNmMXeh29yiOutomiP5kEsD1QGmIJDroopmJnClM=;
 b=Iichk63DcI6KkAO1ziCWzqcQqeo2tfjZPdAQpcablTt0KXPOhLplqPvBZGrwNwNU4n
 jy96v8rOSaGoy5hBga94vzV45uKZTlOi519mjAlS6SCy0iLhhIz9JGJQbR0LD/Mi7JcH
 EQVSrCfbgxh1QN2QgE5dITQr/5297bvLX57UerVfdjFJCFE8dRVBgqeTn1YbDj3aJtAx
 lkul1/3ZAiDG36eGaMTIJoRgV2SjeKuBc9Z3KKyRi0arVYn/mFH5qDv7boJ57lXPIXro
 Orc0oXltsa9sPZee2jkuZkouZlzMpnY1D7h5AZz+YPy0JIpWOisPA2acmwqKZUG/lOJb
 /cKA==
X-Gm-Message-State: AAQBX9f+cJHU+V8XV2t0izYmzziTTI3CRjw+aF9mZ5e/U9zmzkv0VxCi
 1Ih9g2xXp7Bbf9DFLW4Cv6tgFeOUIRMBuHbJGjEmM19bjo5XiNqGrbfe4HrkjhgFdlzrSv43DpJ
 qsViLSWzqdEOhW9zKAwJx/IWCfXIqrJOZvhWFNSAcC17SmENPz748H9YfMg==
X-Received: by 2002:a05:6808:1991:b0:38b:f2d1:db15 with SMTP id
 bj17-20020a056808199100b0038bf2d1db15mr344449oib.47.1681972151230; 
 Wed, 19 Apr 2023 23:29:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350YT4AHXQXgwTQRHka9aoNLwtjjr5EAkfqPeNamGyXLmUb3WmrSzik+6jAVvfDtUCTnI5MDVMEL5IUPiyqxatyk=
X-Received: by 2002:a05:6808:1991:b0:38b:f2d1:db15 with SMTP id
 bj17-20020a056808199100b0038bf2d1db15mr344442oib.47.1681972151022; Wed, 19
 Apr 2023 23:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 14:28:59 +0800
Message-ID: <CACGkMEsSR9uu1n7kFZLDxeje=_JWzadVtqcYizwYRypmnR4Wdw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/14] virtio_net: small: optimize code
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSW4gdGhlIGNhc2Ugb2YgWERQLVBBU1MsIHNrYl9y
ZXNlcnZlIHVzZXMgdGhlIGRlbHRhIHRvIGNvbXBhdGlibGUKPiBub24tWERQLCBub3cgcmVtb3Zl
IHRoaXMgbG9naWMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDYgKy0tLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiBpbmRleCAzNDIyMGY1ZjI3ZDEuLmY2ZjU5MDNmYWNlMiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBA
QCAtOTU5LDkgKzk1OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9zbWFsbF94
ZHAoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAgIHVuc2lnbmVkIGludCBidWZsZW47
Cj4gICAgICAgICBzdHJ1Y3QgeGRwX2J1ZmYgeGRwOwo+ICAgICAgICAgc3RydWN0IHNrX2J1ZmYg
KnNrYjsKPiAtICAgICAgIHVuc2lnbmVkIGludCBkZWx0YSA9IDA7Cj4gICAgICAgICB1bnNpZ25l
ZCBpbnQgbWV0YXNpemUgPSAwOwo+IC0gICAgICAgdm9pZCAqb3JpZ19kYXRhOwo+ICAgICAgICAg
dTMyIGFjdDsKPgo+ICAgICAgICAgaWYgKHVubGlrZWx5KGhkci0+aGRyLmdzb190eXBlKSkKPiBA
QCAtOTk0LDE0ICs5OTIsMTIgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX3NtYWxs
X3hkcChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgeGRwX2luaXRfYnVmZigmeGRw
LCBidWZsZW4sICZycS0+eGRwX3J4cSk7Cj4gICAgICAgICB4ZHBfcHJlcGFyZV9idWZmKCZ4ZHAs
IGJ1ZiArIFZJUlRORVRfUlhfUEFEICsgdmktPmhkcl9sZW4sCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHhkcF9oZWFkcm9vbSwgbGVuLCB0cnVlKTsKPiAtICAgICAgIG9yaWdfZGF0YSA9IHhk
cC5kYXRhOwo+Cj4gICAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVyKHhkcF9wcm9nLCAm
eGRwLCBkZXYsIHhkcF94bWl0LCBzdGF0cyk7Cj4KPiAgICAgICAgIHN3aXRjaCAoYWN0KSB7Cj4g
ICAgICAgICBjYXNlIFZJUlRORVRfWERQX1JFU19QQVNTOgo+ICAgICAgICAgICAgICAgICAvKiBS
ZWNhbGN1bGF0ZSBsZW5ndGggaW4gY2FzZSBicGYgcHJvZ3JhbSBjaGFuZ2VkIGl0ICovCj4gLSAg
ICAgICAgICAgICAgIGRlbHRhID0gb3JpZ19kYXRhIC0geGRwLmRhdGE7Cj4gICAgICAgICAgICAg
ICAgIGxlbiA9IHhkcC5kYXRhX2VuZCAtIHhkcC5kYXRhOwo+ICAgICAgICAgICAgICAgICBtZXRh
c2l6ZSA9IHhkcC5kYXRhIC0geGRwLmRhdGFfbWV0YTsKPiAgICAgICAgICAgICAgICAgYnJlYWs7
Cj4gQEAgLTEwMTcsNyArMTAxMyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9z
bWFsbF94ZHAoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAgIGlmICghc2tiKQo+ICAg
ICAgICAgICAgICAgICBnb3RvIGVycjsKPgo+IC0gICAgICAgc2tiX3Jlc2VydmUoc2tiLCBoZWFk
cm9vbSAtIGRlbHRhKTsKPiArICAgICAgIHNrYl9yZXNlcnZlKHNrYiwgeGRwLmRhdGEgLSBidWYp
Owo+ICAgICAgICAgc2tiX3B1dChza2IsIGxlbik7Cj4gICAgICAgICBpZiAobWV0YXNpemUpCj4g
ICAgICAgICAgICAgICAgIHNrYl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7Cj4gLS0KPiAy
LjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
