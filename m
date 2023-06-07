Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854F9C87FDC
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 08:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9073341BCD;
	Wed,  7 Jun 2023 08:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9073341BCD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WP1pwqJY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBWxCiY2Q8pO; Wed,  7 Jun 2023 08:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 135314089D;
	Wed,  7 Jun 2023 08:39:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 135314089D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E06A1C007A;
	Wed,  7 Jun 2023 08:39:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 083FBC0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C96468176C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C96468176C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WP1pwqJY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDiLk2aYgIUh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:39:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A352381766
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A352381766
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686127161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljArIlCjiAk4raJisPzBpvdPPgGsnUJvYTJw2BtF6ok=;
 b=WP1pwqJYwPirW7RDZ3w3/2E0amoqEJkoN7Z7oWlan+A3hN0EkUj1RD7J1ovk7iCpZRnN/3
 bWgdu6xPgKw8sskYL/m8X7hEr9Ez9jP9rldggyGcsJyKj+Tkko5zb0T1JwcLwde1yxeNYk
 3D2thL0DqpUvlDaW7nPqz70wOgGSOnM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-R5gvTA4hMbGRRyQ2IHBQlg-1; Wed, 07 Jun 2023 04:39:20 -0400
X-MC-Unique: R5gvTA4hMbGRRyQ2IHBQlg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9744659b7b5so630003266b.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 01:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686127159; x=1688719159;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ljArIlCjiAk4raJisPzBpvdPPgGsnUJvYTJw2BtF6ok=;
 b=kYvuV+aX2BDXq8+hRoyDcIhfTgU5ZK/6m2U41vbHnUf/sQRByow78FBGooYSE5f31B
 kfynSt4MOVJC71z1NkXLP7IaX7qenxB24RLvko8Yz1nXgDponXXl/kA/73sywR6bdUDa
 oVbrCno2GA7SXDv0ClzHsZqnQTLee2apDs8tSji2ZsZ4IGPWfzJJj3NCzY1qwkXLmgFG
 kA7/VapXYr5A2gbsBafBORb5RgHMlUvjeHocVA5Mo8LRVAXXJkREfE4dTCAw18xWzBMe
 IT2if0nBjJ0irW6/dWrMMqBr5g3uXr7kbt36c34sk7jj9FGGUhln0qTcWvS6SeEvUBXV
 E5nQ==
X-Gm-Message-State: AC+VfDzyYFFDa8Mlowm1h5B8IyKGWRiDHjgzyIfdkiWUMAnub89dFzEn
 UjGbhP//O5Wicjs/5C+ecBI9sSnBJPOfBSLtdUOhO0OJcbxXDgIW8yTFSyiYGRC0KxIsUzB2wuQ
 IMebq4fse4w/EKs5xVwDCewcLdUQQoRNEhlcvwpEaMA==
X-Received: by 2002:a17:907:2d91:b0:8b1:7de3:cfaa with SMTP id
 gt17-20020a1709072d9100b008b17de3cfaamr5662275ejc.3.1686127159116; 
 Wed, 07 Jun 2023 01:39:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7btGdgIzKw5k5WmwW3L/Sj3hNi5PvtUs3V2LlGUM++yAslee+IT231SvTSKQcWeSSHb5giPg==
X-Received: by 2002:a17:907:2d91:b0:8b1:7de3:cfaa with SMTP id
 gt17-20020a1709072d9100b008b17de3cfaamr5662257ejc.3.1686127158820; 
 Wed, 07 Jun 2023 01:39:18 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 t15-20020a1709066bcf00b0096f7500502csm6655804ejs.199.2023.06.07.01.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 01:39:17 -0700 (PDT)
Date: Wed, 7 Jun 2023 10:39:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606085643-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCAyOjU44oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEp1biAwNiwgMjAyMyBhdCAwOToyOToyMkFN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gTW9uLCBKdW4gNSwgMjAyMyBhdCAxMDo1
OOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+Cj4gPiA+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDA5OjU0OjU3QU0gLTA0MDAsIE1pY2hh
ZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPk9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDAzOjMw
OjM1UE0gKzAyMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4gPj4gT24gTW9uLCBK
dW4gMDUsIDIwMjMgYXQgMDk6MDA6MjVBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gPiA+PiA+IE9uIE1vbiwgSnVuIDA1LCAyMDIzIGF0IDAyOjU0OjIwUE0gKzAyMDAsIFN0
ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+ID4gPj4gPiA+IE9uIE1vbiwgSnVuIDA1LCAyMDIz
IGF0IDA4OjQxOjU0QU0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPj4g
PiA+ID4gT24gTW9uLCBKdW4gMDUsIDIwMjMgYXQgMDE6MDY6NDRQTSArMDIwMCwgU3RlZmFubyBH
YXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+PiA+ID4gPiA+IHZob3N0LXZkcGEgSU9DVExzIChlZy4g
VkhPU1RfR0VUX1ZSSU5HX0JBU0UsIFZIT1NUX1NFVF9WUklOR19CQVNFKQo+ID4gPiA+PiA+ID4g
PiA+IGRvbid0IHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSB3ZWxsIHlldCwgc28gbGV0J3MgZmls
dGVyIHRoZQo+ID4gPiA+PiA+ID4gPiA+IFZJUlRJT19GX1JJTkdfUEFDS0VEIGZlYXR1cmUgZm9y
IG5vdyBpbiB2aG9zdF92ZHBhX2dldF9mZWF0dXJlcygpLgo+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+
ID4+ID4gPiA+ID4gVGhpcyB3YXksIGV2ZW4gaWYgdGhlIGRldmljZSBzdXBwb3J0cyBpdCwgd2Ug
ZG9uJ3QgcmlzayBpdCBiZWluZwo+ID4gPiA+PiA+ID4gPiA+IG5lZ290aWF0ZWQsIHRoZW4gdGhl
IFZNTSBpcyB1bmFibGUgdG8gc2V0IHRoZSB2cmluZyBzdGF0ZSBwcm9wZXJseS4KPiA+ID4gPj4g
PiA+ID4gPgo+ID4gPiA+PiA+ID4gPiA+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50
cm9kdWNlIHZEUEEtYmFzZWQgYmFja2VuZCIpCj4gPiA+ID4+ID4gPiA+ID4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdh
cnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPiA+ID4+ID4gPiA+ID4gLS0tCj4gPiA+
ID4+ID4gPiA+ID4KPiA+ID4gPj4gPiA+ID4gPiBOb3RlczoKPiA+ID4gPj4gPiA+ID4gPiAgICAg
VGhpcyBwYXRjaCBzaG91bGQgYmUgYXBwbGllZCBiZWZvcmUgdGhlICJbUEFUQ0ggdjIgMC8zXSB2
aG9zdF92ZHBhOgo+ID4gPiA+PiA+ID4gPiA+ICAgICBiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHNl
cmllcyBbMV0gYW5kIGJhY2twb3J0ZWQgaW4gc3RhYmxlIGJyYW5jaGVzLgo+ID4gPiA+PiA+ID4g
PiA+Cj4gPiA+ID4+ID4gPiA+ID4gICAgIFdlIGNhbiByZXZlcnQgaXQgd2hlbiB3ZSBhcmUgc3Vy
ZSB0aGF0IGV2ZXJ5dGhpbmcgaXMgd29ya2luZyB3aXRoCj4gPiA+ID4+ID4gPiA+ID4gICAgIHBh
Y2tlZCB2aXJ0cXVldWVzLgo+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+ID4+ID4gPiA+ID4gICAgIFRo
YW5rcywKPiA+ID4gPj4gPiA+ID4gPiAgICAgU3RlZmFubwo+ID4gPiA+PiA+ID4gPiA+Cj4gPiA+
ID4+ID4gPiA+ID4gICAgIFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlv
bi8yMDIzMDQyNDIyNTAzMS4xODk0Ny0xLXNoYW5ub24ubmVsc29uQGFtZC5jb20vCj4gPiA+ID4+
ID4gPiA+Cj4gPiA+ID4+ID4gPiA+IEknbSBhIGJpdCBsb3N0IGhlcmUuIFNvIHdoeSBhbSBJIG1l
cmdpbmcgImJldHRlciBQQUNLRUQgc3VwcG9ydCIgdGhlbj8KPiA+ID4gPj4gPiA+Cj4gPiA+ID4+
ID4gPiBUbyByZWFsbHkgc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlIHdpdGggdmhvc3QtdmRwYSwg
YXQgdGhhdCBwb2ludCB3ZSB3b3VsZAo+ID4gPiA+PiA+ID4gYWxzbyBoYXZlIHRvIHJldmVydCB0
aGlzIHBhdGNoLgo+ID4gPiA+PiA+ID4KPiA+ID4gPj4gPiA+IEkgd2Fzbid0IHN1cmUgaWYgeW91
IHdhbnRlZCB0byBxdWV1ZSB0aGUgc2VyaWVzIGZvciB0aGlzIG1lcmdlIHdpbmRvdy4KPiA+ID4g
Pj4gPiA+IEluIHRoYXQgY2FzZSBkbyB5b3UgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIHNlbmQgdGhp
cyBwYXRjaCBvbmx5IGZvciBzdGFibGUKPiA+ID4gPj4gPiA+IGJyYW5jaGVzPwo+ID4gPiA+PiA+
ID4gPiBEb2VzIHRoaXMgcGF0Y2ggbWFrZSB0aGVtIGEgTk9QPwo+ID4gPiA+PiA+ID4KPiA+ID4g
Pj4gPiA+IFllcCwgYWZ0ZXIgYXBwbHlpbmcgdGhlICJiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHNl
cmllcyBhbmQgYmVpbmcKPiA+ID4gPj4gPiA+IHN1cmUgdGhhdAo+ID4gPiA+PiA+ID4gdGhlIElP
Q1RMcyBvZiB2aG9zdC12ZHBhIHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSwgd2Ugc2hvdWxkIHJl
dmVydCB0aGlzCj4gPiA+ID4+ID4gPiBwYXRjaC4KPiA+ID4gPj4gPiA+Cj4gPiA+ID4+ID4gPiBM
ZXQgbWUga25vdyBpZiB5b3UgcHJlZmVyIGEgZGlmZmVyZW50IGFwcHJvYWNoLgo+ID4gPiA+PiA+
ID4KPiA+ID4gPj4gPiA+IEknbSBjb25jZXJuZWQgdGhhdCBRRU1VIHVzZXMgdmhvc3QtdmRwYSBJ
T0NUTHMgdGhpbmtpbmcgdGhhdCB0aGUga2VybmVsCj4gPiA+ID4+ID4gPiBpbnRlcnByZXRzIHRo
ZW0gdGhlIHJpZ2h0IHdheSwgd2hlbiBpdCBkb2VzIG5vdC4KPiA+ID4gPj4gPiA+Cj4gPiA+ID4+
ID4gPiBUaGFua3MsCj4gPiA+ID4+ID4gPiBTdGVmYW5vCj4gPiA+ID4+ID4gPgo+ID4gPiA+PiA+
Cj4gPiA+ID4+ID4gSWYgdGhpcyBmaXhlcyBhIGJ1ZyBjYW4geW91IGFkZCBGaXhlcyB0YWdzIHRv
IGVhY2ggb2YgdGhlbT8gVGhlbiBpdCdzIG9rCj4gPiA+ID4+ID4gdG8gbWVyZ2UgaW4gdGhpcyB3
aW5kb3cuIFByb2JhYmx5IGVhc2llciB0aGFuIHRoZSBlbGFib3JhdGUKPiA+ID4gPj4gPiBtYXNr
L3VubWFzayBkYW5jZS4KPiA+ID4gPj4KPiA+ID4gPj4gQ0NpbmcgU2hhbm5vbiAodGhlIG9yaWdp
bmFsIGF1dGhvciBvZiB0aGUgImJldHRlciBQQUNLRUQgc3VwcG9ydCIKPiA+ID4gPj4gc2VyaWVz
KS4KPiA+ID4gPj4KPiA+ID4gPj4gSUlVQyBTaGFubm9uIGlzIGdvaW5nIHRvIHNlbmQgYSB2MyBv
ZiB0aGF0IHNlcmllcyB0byBmaXggdGhlCj4gPiA+ID4+IGRvY3VtZW50YXRpb24sIHNvIFNoYW5u
b24gY2FuIHlvdSBhbHNvIGFkZCB0aGUgRml4ZXMgdGFncz8KPiA+ID4gPj4KPiA+ID4gPj4gVGhh
bmtzLAo+ID4gPiA+PiBTdGVmYW5vCj4gPiA+ID4KPiA+ID4gPldlbGwgdGhpcyBpcyBpbiBteSB0
cmVlIGFscmVhZHkuIEp1c3QgcmVwbHkgd2l0aAo+ID4gPiA+Rml4ZXM6IDw+Cj4gPiA+ID50byBl
YWNoIGFuZCBJIHdpbGwgYWRkIHRoZXNlIHRhZ3MuCj4gPiA+Cj4gPiA+IEkgdHJpZWQsIGJ1dCBp
dCBpcyBub3QgZWFzeSBzaW5jZSB3ZSBhZGRlZCB0aGUgc3VwcG9ydCBmb3IgcGFja2VkCj4gPiA+
IHZpcnRxdWV1ZSBpbiB2ZHBhIGFuZCB2aG9zdCBpbmNyZW1lbnRhbGx5Lgo+ID4gPgo+ID4gPiBJ
bml0aWFsbHkgSSB3YXMgdGhpbmtpbmcgb2YgYWRkaW5nIHRoZSBzYW1lIHRhZyB1c2VkIGhlcmU6
Cj4gPiA+Cj4gPiA+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZEUEEt
YmFzZWQgYmFja2VuZCIpCj4gPiA+Cj4gPiA+IFRoZW4gSSBkaXNjb3ZlcmVkIHRoYXQgdnFfc3Rh
dGUgd2Fzbid0IHRoZXJlLCBzbyBJIHdhcyB0aGlua2luZyBvZgo+ID4gPgo+ID4gPiBGaXhlczog
NTMwYTU2NzhiYzAwICgidmRwYTogc3VwcG9ydCBwYWNrZWQgdmlydHF1ZXVlIGZvciBzZXQvZ2V0
X3ZxX3N0YXRlKCkiKQo+ID4gPgo+ID4gPiBTbyB3ZSB3b3VsZCBoYXZlIHRvIGJhY2twb3J0IHF1
aXRlIGEgZmV3IHBhdGNoZXMgaW50byB0aGUgc3RhYmxlIGJyYW5jaGVzLgo+ID4gPiBJIGRvbid0
IGtub3cgaWYgaXQncyB3b3J0aCBpdC4uLgo+ID4gPgo+ID4gPiBJIHN0aWxsIHRoaW5rIGl0IGlz
IGJldHRlciB0byBkaXNhYmxlIHBhY2tlZCBpbiB0aGUgc3RhYmxlIGJyYW5jaGVzLAo+ID4gPiBv
dGhlcndpc2UgSSBoYXZlIHRvIG1ha2UgYSBsaXN0IG9mIGFsbCB0aGUgcGF0Y2hlcyB3ZSBuZWVk
Lgo+ID4gPgo+ID4gPiBBbnkgb3RoZXIgaWRlYXM/Cj4gPgo+ID4gQUZBSUssIGV4Y2VwdCBmb3Ig
dnBfdmRwYSwgcGRzIHNlZW1zIHRvIGJlIHRoZSBmaXJzdCBwYXJlbnQgdGhhdAo+ID4gc3VwcG9y
dHMgcGFja2VkIHZpcnRxdWV1ZS4gVXNlcnMgc2hvdWxkIG5vdCBub3RpY2UgYW55dGhpbmcgd3Jv
bmcgaWYKPiA+IHRoZXkgZG9uJ3QgdXNlIHBhY2tlZCB2aXJ0cXVldWUuIEFuZCB0aGUgcHJvYmxl
bSBvZiB2cF92ZHBhICsgcGFja2VkCj4gPiB2aXJ0cXVldWUgY2FtZSBzaW5jZSB0aGUgZGF5MCBv
ZiB2cF92ZHBhLiBJdCBzZWVtcyBmaW5lIHRvIGRvIG5vdGhpbmcKPiA+IEkgZ3Vlc3MuCj4gPgo+
ID4gVGhhbmtzCj4KPgo+IEkgaGF2ZSBhIHF1ZXN0aW9uIHRob3VnaCwgd2hhdCBpZiBkb3duIHRo
ZSByb2FkIHRoZXJlCj4gaXMgYSBuZXcgZmVhdHVyZSB0aGF0IG5lZWRzIG1vcmUgY2hhbmdlcz8g
SXQgd2lsbCBiZQo+IGJyb2tlbiB0b28ganVzdCBsaWtlIFBBQ0tFRCBubz8KPiBTaG91bGRuJ3Qg
dmRwYSBoYXZlIGFuIGFsbG93bGlzdCBvZiBmZWF0dXJlcyBpdCBrbm93cyBob3cKPiB0byBzdXBw
b3J0PwoKSXQgbG9va3MgbGlrZSB3ZSBoYWQgaXQsIGJ1dCB3ZSB0b29rIGl0IG91dCAoYnkgdGhl
IHdheSwgd2Ugd2VyZQplbmFibGluZyBwYWNrZWQgZXZlbiB0aG91Z2ggd2UgZGlkbid0IHN1cHBv
cnQgaXQpOgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD02MjM0ZjgwNTc0ZDc1Njk0NDRkODcxODM1NWZh
MjgzOGU5MmIxNThiCgpUaGUgb25seSBwcm9ibGVtIEkgc2VlIGlzIHRoYXQgZm9yIGVhY2ggbmV3
IGZlYXR1cmUgd2UgaGF2ZSB0byBtb2RpZnkgCnRoZSBrZXJuZWwuCkNvdWxkIHdlIGhhdmUgbmV3
IGZlYXR1cmVzIHRoYXQgZG9uJ3QgcmVxdWlyZSBoYW5kbGluZyBieSB2aG9zdC12ZHBhPwoKVGhh
bmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
