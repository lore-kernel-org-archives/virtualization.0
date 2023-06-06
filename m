Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC79C7EE23
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 01:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25C1340931;
	Tue,  6 Jun 2023 01:29:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25C1340931
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ggVnQReO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YPcyllnyswD; Tue,  6 Jun 2023 01:29:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 350AB40922;
	Tue,  6 Jun 2023 01:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 350AB40922
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14DA0C007A;
	Tue,  6 Jun 2023 01:29:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 274CAC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EECA360F83
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EECA360F83
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ggVnQReO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uK-nTM9_oe99
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:29:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA2D060F30
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA2D060F30
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686014977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LO0PcoIQipRUJHYAP4IZqQY6Y4aLmW6KIu9FvB1onCA=;
 b=ggVnQReOn2wuDhgo2dFb62pht5aKUqJ28qX4EgOOxx2sJUiVk3cVFTRI8Qul2YMeXsZlIO
 UHhDuj8LSV6rfr6vedM7rxwLDX2930+6Xh2zTCJv+Ipw9A5Dgfv7JJxnWtROmn+yyTqyd6
 ibLf+VpMDzq6g/EQX3S+YFhmtZ4YgA8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-hBNUokv7P32Hq2omXrHw3w-1; Mon, 05 Jun 2023 21:29:35 -0400
X-MC-Unique: hBNUokv7P32Hq2omXrHw3w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b1ae743e9cso27473241fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 18:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686014974; x=1688606974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LO0PcoIQipRUJHYAP4IZqQY6Y4aLmW6KIu9FvB1onCA=;
 b=F50GieLYG31PBPfvH7KTTVMCLRZ4NAOTDCfBOL7nH/3bbn7j5qPWEuZ306VFHG0ia2
 IWV93kAHSQhlcyJ7VkgZK/ED3jl5f+FLrsnXpeMhCh3cdU64PxehfI6MgDYtCFK7N4wb
 c+OPYbhUHrx7hOj3kd+zPES4M23tK0Bop6RkU5JSlUdIF4WFKO5cRW9Qn2f5XnsgBSd5
 XHei7azaFuvYG/cewlgVcfvRDxt8QsS/Rl9LE7sUWPwkl6Yxm3ijm0FCLIxVeTHBcxJf
 Y6I1CPhQ7qQcQijO+Qw0zj31V7Kuils/PyxB1gwxgZOxkFYxYgXY/wd4qhhXL+UnH7qm
 6Xag==
X-Gm-Message-State: AC+VfDxVILtwaHChxu2I0xDiMDOU7nHWSBARxO9gJegxs6ojr2L4+oql
 ciPRq1BuhgzfWaCWLLWfHSTBMU0o6MYNMCClM686Pukot9s58L4yvzgEMb6kP2qJSCUB1IaPYTP
 +EiERXdFrNjnYTD2+l4nvHheN/ESSxqMMigQMgL7ZN4844hbO//Z6hSkQHA==
X-Received: by 2002:a05:651c:90:b0:2ac:770f:8831 with SMTP id
 16-20020a05651c009000b002ac770f8831mr471626ljq.40.1686014974166; 
 Mon, 05 Jun 2023 18:29:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q8xwsG2H2HJLbjrNSEB15Tcb4Vhw2h23yOvguszqhRoiFXNx/aA4LQRn2qI/jZv0NF0GvO+g7EwDrFoZVmEY=
X-Received: by 2002:a05:651c:90:b0:2ac:770f:8831 with SMTP id
 16-20020a05651c009000b002ac770f8831mr471619ljq.40.1686014973831; Mon, 05 Jun
 2023 18:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
In-Reply-To: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jun 2023 09:29:22 +0800
Message-ID: <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
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

T24gTW9uLCBKdW4gNSwgMjAyMyBhdCAxMDo1OOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwOTo1
NDo1N0FNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPk9uIE1vbiwgSnVuIDA1
LCAyMDIzIGF0IDAzOjMwOjM1UE0gKzAyMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiA+
PiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwOTowMDoyNUFNIC0wNDAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4gPj4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwMjo1NDoyMFBNICsw
MjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPj4gPiA+IE9uIE1vbiwgSnVuIDA1LCAy
MDIzIGF0IDA4OjQxOjU0QU0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+PiA+
ID4gPiBPbiBNb24sIEp1biAwNSwgMjAyMyBhdCAwMTowNjo0NFBNICswMjAwLCBTdGVmYW5vIEdh
cnphcmVsbGEgd3JvdGU6Cj4gPj4gPiA+ID4gPiB2aG9zdC12ZHBhIElPQ1RMcyAoZWcuIFZIT1NU
X0dFVF9WUklOR19CQVNFLCBWSE9TVF9TRVRfVlJJTkdfQkFTRSkKPiA+PiA+ID4gPiA+IGRvbid0
IHN1cHBvcnQgcGFja2VkIHZpcnRxdWV1ZSB3ZWxsIHlldCwgc28gbGV0J3MgZmlsdGVyIHRoZQo+
ID4+ID4gPiA+ID4gVklSVElPX0ZfUklOR19QQUNLRUQgZmVhdHVyZSBmb3Igbm93IGluIHZob3N0
X3ZkcGFfZ2V0X2ZlYXR1cmVzKCkuCj4gPj4gPiA+ID4gPgo+ID4+ID4gPiA+ID4gVGhpcyB3YXks
IGV2ZW4gaWYgdGhlIGRldmljZSBzdXBwb3J0cyBpdCwgd2UgZG9uJ3QgcmlzayBpdCBiZWluZwo+
ID4+ID4gPiA+ID4gbmVnb3RpYXRlZCwgdGhlbiB0aGUgVk1NIGlzIHVuYWJsZSB0byBzZXQgdGhl
IHZyaW5nIHN0YXRlIHByb3Blcmx5Lgo+ID4+ID4gPiA+ID4KPiA+PiA+ID4gPiA+IEZpeGVzOiA0
YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZEUEEtYmFzZWQgYmFja2VuZCIpCj4gPj4g
PiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+ID4+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+ID4+ID4gPiA+
ID4gLS0tCj4gPj4gPiA+ID4gPgo+ID4+ID4gPiA+ID4gTm90ZXM6Cj4gPj4gPiA+ID4gPiAgICAg
VGhpcyBwYXRjaCBzaG91bGQgYmUgYXBwbGllZCBiZWZvcmUgdGhlICJbUEFUQ0ggdjIgMC8zXSB2
aG9zdF92ZHBhOgo+ID4+ID4gPiA+ID4gICAgIGJldHRlciBQQUNLRUQgc3VwcG9ydCIgc2VyaWVz
IFsxXSBhbmQgYmFja3BvcnRlZCBpbiBzdGFibGUgYnJhbmNoZXMuCj4gPj4gPiA+ID4gPgo+ID4+
ID4gPiA+ID4gICAgIFdlIGNhbiByZXZlcnQgaXQgd2hlbiB3ZSBhcmUgc3VyZSB0aGF0IGV2ZXJ5
dGhpbmcgaXMgd29ya2luZyB3aXRoCj4gPj4gPiA+ID4gPiAgICAgcGFja2VkIHZpcnRxdWV1ZXMu
Cj4gPj4gPiA+ID4gPgo+ID4+ID4gPiA+ID4gICAgIFRoYW5rcywKPiA+PiA+ID4gPiA+ICAgICBT
dGVmYW5vCj4gPj4gPiA+ID4gPgo+ID4+ID4gPiA+ID4gICAgIFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy92aXJ0dWFsaXphdGlvbi8yMDIzMDQyNDIyNTAzMS4xODk0Ny0xLXNoYW5ub24ubmVs
c29uQGFtZC5jb20vCj4gPj4gPiA+ID4KPiA+PiA+ID4gPiBJJ20gYSBiaXQgbG9zdCBoZXJlLiBT
byB3aHkgYW0gSSBtZXJnaW5nICJiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHRoZW4/Cj4gPj4gPiA+
Cj4gPj4gPiA+IFRvIHJlYWxseSBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUgd2l0aCB2aG9zdC12
ZHBhLCBhdCB0aGF0IHBvaW50IHdlIHdvdWxkCj4gPj4gPiA+IGFsc28gaGF2ZSB0byByZXZlcnQg
dGhpcyBwYXRjaC4KPiA+PiA+ID4KPiA+PiA+ID4gSSB3YXNuJ3Qgc3VyZSBpZiB5b3Ugd2FudGVk
IHRvIHF1ZXVlIHRoZSBzZXJpZXMgZm9yIHRoaXMgbWVyZ2Ugd2luZG93Lgo+ID4+ID4gPiBJbiB0
aGF0IGNhc2UgZG8geW91IHRoaW5rIGl0IGlzIGJldHRlciB0byBzZW5kIHRoaXMgcGF0Y2ggb25s
eSBmb3Igc3RhYmxlCj4gPj4gPiA+IGJyYW5jaGVzPwo+ID4+ID4gPiA+IERvZXMgdGhpcyBwYXRj
aCBtYWtlIHRoZW0gYSBOT1A/Cj4gPj4gPiA+Cj4gPj4gPiA+IFllcCwgYWZ0ZXIgYXBwbHlpbmcg
dGhlICJiZXR0ZXIgUEFDS0VEIHN1cHBvcnQiIHNlcmllcyBhbmQgYmVpbmcKPiA+PiA+ID4gc3Vy
ZSB0aGF0Cj4gPj4gPiA+IHRoZSBJT0NUTHMgb2Ygdmhvc3QtdmRwYSBzdXBwb3J0IHBhY2tlZCB2
aXJ0cXVldWUsIHdlIHNob3VsZCByZXZlcnQgdGhpcwo+ID4+ID4gPiBwYXRjaC4KPiA+PiA+ID4K
PiA+PiA+ID4gTGV0IG1lIGtub3cgaWYgeW91IHByZWZlciBhIGRpZmZlcmVudCBhcHByb2FjaC4K
PiA+PiA+ID4KPiA+PiA+ID4gSSdtIGNvbmNlcm5lZCB0aGF0IFFFTVUgdXNlcyB2aG9zdC12ZHBh
IElPQ1RMcyB0aGlua2luZyB0aGF0IHRoZSBrZXJuZWwKPiA+PiA+ID4gaW50ZXJwcmV0cyB0aGVt
IHRoZSByaWdodCB3YXksIHdoZW4gaXQgZG9lcyBub3QuCj4gPj4gPiA+Cj4gPj4gPiA+IFRoYW5r
cywKPiA+PiA+ID4gU3RlZmFubwo+ID4+ID4gPgo+ID4+ID4KPiA+PiA+IElmIHRoaXMgZml4ZXMg
YSBidWcgY2FuIHlvdSBhZGQgRml4ZXMgdGFncyB0byBlYWNoIG9mIHRoZW0/IFRoZW4gaXQncyBv
awo+ID4+ID4gdG8gbWVyZ2UgaW4gdGhpcyB3aW5kb3cuIFByb2JhYmx5IGVhc2llciB0aGFuIHRo
ZSBlbGFib3JhdGUKPiA+PiA+IG1hc2svdW5tYXNrIGRhbmNlLgo+ID4+Cj4gPj4gQ0NpbmcgU2hh
bm5vbiAodGhlIG9yaWdpbmFsIGF1dGhvciBvZiB0aGUgImJldHRlciBQQUNLRUQgc3VwcG9ydCIK
PiA+PiBzZXJpZXMpLgo+ID4+Cj4gPj4gSUlVQyBTaGFubm9uIGlzIGdvaW5nIHRvIHNlbmQgYSB2
MyBvZiB0aGF0IHNlcmllcyB0byBmaXggdGhlCj4gPj4gZG9jdW1lbnRhdGlvbiwgc28gU2hhbm5v
biBjYW4geW91IGFsc28gYWRkIHRoZSBGaXhlcyB0YWdzPwo+ID4+Cj4gPj4gVGhhbmtzLAo+ID4+
IFN0ZWZhbm8KPiA+Cj4gPldlbGwgdGhpcyBpcyBpbiBteSB0cmVlIGFscmVhZHkuIEp1c3QgcmVw
bHkgd2l0aAo+ID5GaXhlczogPD4KPiA+dG8gZWFjaCBhbmQgSSB3aWxsIGFkZCB0aGVzZSB0YWdz
Lgo+Cj4gSSB0cmllZCwgYnV0IGl0IGlzIG5vdCBlYXN5IHNpbmNlIHdlIGFkZGVkIHRoZSBzdXBw
b3J0IGZvciBwYWNrZWQKPiB2aXJ0cXVldWUgaW4gdmRwYSBhbmQgdmhvc3QgaW5jcmVtZW50YWxs
eS4KPgo+IEluaXRpYWxseSBJIHdhcyB0aGlua2luZyBvZiBhZGRpbmcgdGhlIHNhbWUgdGFnIHVz
ZWQgaGVyZToKPgo+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZEUEEt
YmFzZWQgYmFja2VuZCIpCj4KPiBUaGVuIEkgZGlzY292ZXJlZCB0aGF0IHZxX3N0YXRlIHdhc24n
dCB0aGVyZSwgc28gSSB3YXMgdGhpbmtpbmcgb2YKPgo+IEZpeGVzOiA1MzBhNTY3OGJjMDAgKCJ2
ZHBhOiBzdXBwb3J0IHBhY2tlZCB2aXJ0cXVldWUgZm9yIHNldC9nZXRfdnFfc3RhdGUoKSIpCj4K
PiBTbyB3ZSB3b3VsZCBoYXZlIHRvIGJhY2twb3J0IHF1aXRlIGEgZmV3IHBhdGNoZXMgaW50byB0
aGUgc3RhYmxlIGJyYW5jaGVzLgo+IEkgZG9uJ3Qga25vdyBpZiBpdCdzIHdvcnRoIGl0Li4uCj4K
PiBJIHN0aWxsIHRoaW5rIGl0IGlzIGJldHRlciB0byBkaXNhYmxlIHBhY2tlZCBpbiB0aGUgc3Rh
YmxlIGJyYW5jaGVzLAo+IG90aGVyd2lzZSBJIGhhdmUgdG8gbWFrZSBhIGxpc3Qgb2YgYWxsIHRo
ZSBwYXRjaGVzIHdlIG5lZWQuCj4KPiBBbnkgb3RoZXIgaWRlYXM/CgpBRkFJSywgZXhjZXB0IGZv
ciB2cF92ZHBhLCBwZHMgc2VlbXMgdG8gYmUgdGhlIGZpcnN0IHBhcmVudCB0aGF0CnN1cHBvcnRz
IHBhY2tlZCB2aXJ0cXVldWUuIFVzZXJzIHNob3VsZCBub3Qgbm90aWNlIGFueXRoaW5nIHdyb25n
IGlmCnRoZXkgZG9uJ3QgdXNlIHBhY2tlZCB2aXJ0cXVldWUuIEFuZCB0aGUgcHJvYmxlbSBvZiB2
cF92ZHBhICsgcGFja2VkCnZpcnRxdWV1ZSBjYW1lIHNpbmNlIHRoZSBkYXkwIG9mIHZwX3ZkcGEu
IEl0IHNlZW1zIGZpbmUgdG8gZG8gbm90aGluZwpJIGd1ZXNzLgoKVGhhbmtzCgo+Cj4gVGhhbmtz
LAo+IFN0ZWZhbm8KPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
