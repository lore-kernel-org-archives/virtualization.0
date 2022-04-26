Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B2DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 03:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19908404F5;
	Tue, 26 Apr 2022 03:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPXfof20XI-M; Tue, 26 Apr 2022 03:45:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B2414013B;
	Tue, 26 Apr 2022 03:45:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE78C0032;
	Tue, 26 Apr 2022 03:45:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F19AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D23C60E2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SFAHI6EJBT2o
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E315260D72
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650944723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQxkTt0XC9Rg9r5oloxnV9oPwCXKhivpkktVubMKxA4=;
 b=AMq4kmZYh4kd7ain5JybziFy7IyWjOTFSc/mZUxU+IEdU5R9NQn6UEwermj7eL7Wb2cQdB
 nsUk8ucgRgMSGJom+GQCvNfihuRk6eX6P5QNM1XqR6wUlA6bDqLUxC4+i3vaslDcAQ5aQr
 wRWYMNLRcoFFVoIT5p2NAB4ouLegmTs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-FHqfZzrxOoi5GFplzDJBfw-1; Mon, 25 Apr 2022 23:45:22 -0400
X-MC-Unique: FHqfZzrxOoi5GFplzDJBfw-1
Received: by mail-pl1-f199.google.com with SMTP id
 l6-20020a170903120600b0014f43ba55f3so10598614plh.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 20:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bQxkTt0XC9Rg9r5oloxnV9oPwCXKhivpkktVubMKxA4=;
 b=ej+8Hr9XXphOpliUO6v9mMq1Q0VoIVJMWABa49CwupTCY0vY7MTPEVq5HoHBqtXNLJ
 gWeYegWlfssjYOKT173dcKdM3wZBM8vLkrfnxBHgjFU/x3KQjROU1PLlTvL0YDFZMvOn
 HQ7zK7uX6UKkrsWGz5/X3cmUi4fUirhWyHtaa/pGl/R0DI8ONoQW1GH7Gr7QCRnaFHdL
 +nzMDvOt1oMMZgtVCrQ73Gl5ycc1X/dAxZeOK8UbweTlyFOB+cYQbMBwFvhrFZ7bnXKS
 Irft7qy/IZ01wLm9WB+blEbRfgAHnCIyupEPpNrAARE1vrKH+tPHOe+bO4dOpPFgddcL
 ibPQ==
X-Gm-Message-State: AOAM533ySpHq3C18KlNZBf2CYFVMZ9jDwlt5GhHxIYZhv+OFYlSB3iOE
 68Jbf9qNfyE+70X/AfGsjy5GwcUb8CGx1uAtImnAorXs4zTyB5L6ScqDfp4ylq0xUP/n8hCdi0f
 8bPJDmzqHIg0UPZWGhkWtSdh8CPXpxQ/bmK8eqZaq/Q==
X-Received: by 2002:a05:6a00:2481:b0:50d:4839:5896 with SMTP id
 c1-20020a056a00248100b0050d48395896mr5375179pfv.37.1650944721347; 
 Mon, 25 Apr 2022 20:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+SJgwm09mTi+hWwYYLh/5RwsE1fpUGq4/MRnbAN9YFANBqojxJvgBPIHGh+BdrsxOJapPgA==
X-Received: by 2002:a05:6a00:2481:b0:50d:4839:5896 with SMTP id
 c1-20020a056a00248100b0050d48395896mr5375158pfv.37.1650944721072; 
 Mon, 25 Apr 2022 20:45:21 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 i62-20020a62c141000000b0050d48b96bb8sm3162809pfg.22.2022.04.25.20.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 20:45:20 -0700 (PDT)
Message-ID: <560bcbe5-f0db-ed61-8ec0-043031145fe4@redhat.com>
Date: Tue, 26 Apr 2022 11:45:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 7/9] virtio: allow to unbreak virtqueue
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-8-jasowang@redhat.com> <87v8ux72p5.fsf@redhat.com>
 <20220425100349-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220425100349-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eperezma@redhat.com, tglx@linutronix.de
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzQvMjUgMjI6MDQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gTW9u
LCBBcHIgMjUsIDIwMjIgYXQgMDI6NDQ6MDZQTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90ZToK
Pj4gT24gTW9uLCBBcHIgMjUgMjAyMiwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+Cj4+PiBUaGlzIHBhdGNoIGFsbG93cyB0aGUgdmlydGlvX2JyZWFrX2RldmljZSgp
IHRvIGFjY2VwdCBhIGJvb2xlYW4gdmFsdWUKPj4+IHRoZW4gd2UgY2FuIHVuYnJlYWsgdGhlIHZp
cnRxdWV1ZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jICAgICAg
ICAgICAgICB8IDIgKy0KPj4+ICAgZHJpdmVycy9jcnlwdG8vdmlydGlvL3ZpcnRpb19jcnlwdG9f
Y29yZS5jIHwgMiArLQo+Pj4gICBkcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYyAgICAg
ICAgICAgfCA0ICsrLS0KPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyAg
ICAgICAgIHwgMiArLQo+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICAgICAgICAg
ICAgICAgfCA0ICsrLS0KPj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICAgICAgICAg
ICAgICAgIHwgMiArLQo+Pj4gICA2IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25z
b2xlLmMgYi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYwo+Pj4gaW5kZXggZTNjNDMwNTM5
YTE3Li5hZmVkZTk3N2Y3YjMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2NoYXIvdmlydGlvX2Nv
bnNvbGUuYwo+Pj4gKysrIGIvZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmMKPj4+IEBAIC0x
OTU4LDcgKzE5NTgsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0Y29uc19yZW1vdmUoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpCj4+PiAgIAlzcGluX3VubG9ja19pcnEoJnBkcnZkYXRhX2xvY2spOwo+
Pj4gICAKPj4+ICAgCS8qIERldmljZSBpcyBnb2luZyBhd2F5LCBleGl0IGFueSBwb2xsaW5nIGZv
ciBidWZmZXJzICovCj4+PiAtCXZpcnRpb19icmVha19kZXZpY2UodmRldik7Cj4+PiArCXZpcnRp
b19icmVha19kZXZpY2UodmRldiwgdHJ1ZSk7Cj4+PiAgIAlpZiAodXNlX211bHRpcG9ydChwb3J0
ZGV2KSkKPj4+ICAgCQlmbHVzaF93b3JrKCZwb3J0ZGV2LT5jb250cm9sX3dvcmspOwo+Pj4gICAJ
ZWxzZQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRv
X2NvcmUuYyBiL2RyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2NvcmUuYwo+Pj4g
aW5kZXggYzZmNDgyZGIwYmMwLi5mZDE3ZjNmMmU5NTggMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2NyeXB0by92aXJ0aW8vdmlydGlvX2NyeXB0b19jb3JlLmMKPj4+ICsrKyBiL2RyaXZlcnMvY3J5
cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2NvcmUuYwo+Pj4gQEAgLTIxNSw3ICsyMTUsNyBAQCBz
dGF0aWMgaW50IHZpcnRjcnlwdG9fdXBkYXRlX3N0YXR1cyhzdHJ1Y3QgdmlydGlvX2NyeXB0byAq
dmNyeXB0bykKPj4+ICAgCQlkZXZfd2FybigmdmNyeXB0by0+dmRldi0+ZGV2LAo+Pj4gICAJCQkJ
IlVua25vd24gc3RhdHVzIGJpdHM6IDB4JXhcbiIsIHN0YXR1cyk7Cj4+PiAgIAo+Pj4gLQkJdmly
dGlvX2JyZWFrX2RldmljZSh2Y3J5cHRvLT52ZGV2KTsKPj4+ICsJCXZpcnRpb19icmVha19kZXZp
Y2UodmNyeXB0by0+dmRldiwgdHJ1ZSk7Cj4+PiAgIAkJcmV0dXJuIC1FUEVSTTsKPj4+ICAgCX0K
Pj4+ICAgCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMg
Yi9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYwo+Pj4gaW5kZXggYzE5ZjA3YTgyZDYy
Li45YTk2M2Y1YWY1YjUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRp
b19jY3cuYwo+Pj4gKysrIGIvZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMKPj4+IEBA
IC0xMjExLDcgKzEyMTEsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fY2N3X3JlbW92ZShzdHJ1Y3Qg
Y2N3X2RldmljZSAqY2RldikKPj4+ICAgCj4+PiAgIAlpZiAodmNkZXYgJiYgY2Rldi0+b25saW5l
KSB7Cj4+PiAgIAkJaWYgKHZjZGV2LT5kZXZpY2VfbG9zdCkKPj4+IC0JCQl2aXJ0aW9fYnJlYWtf
ZGV2aWNlKCZ2Y2Rldi0+dmRldik7Cj4+PiArCQkJdmlydGlvX2JyZWFrX2RldmljZSgmdmNkZXYt
PnZkZXYsIHRydWUpOwo+Pj4gICAJCXVucmVnaXN0ZXJfdmlydGlvX2RldmljZSgmdmNkZXYtPnZk
ZXYpOwo+Pj4gICAJCXNwaW5fbG9ja19pcnFzYXZlKGdldF9jY3dkZXZfbG9jayhjZGV2KSwgZmxh
Z3MpOwo+Pj4gICAJCWRldl9zZXRfZHJ2ZGF0YSgmY2Rldi0+ZGV2LCBOVUxMKTsKPj4+IEBAIC0x
MjI4LDcgKzEyMjgsNyBAQCBzdGF0aWMgaW50IHZpcnRpb19jY3dfb2ZmbGluZShzdHJ1Y3QgY2N3
X2RldmljZSAqY2RldikKPj4+ICAgCWlmICghdmNkZXYpCj4+PiAgIAkJcmV0dXJuIDA7Cj4+PiAg
IAlpZiAodmNkZXYtPmRldmljZV9sb3N0KQo+Pj4gLQkJdmlydGlvX2JyZWFrX2RldmljZSgmdmNk
ZXYtPnZkZXYpOwo+Pj4gKwkJdmlydGlvX2JyZWFrX2RldmljZSgmdmNkZXYtPnZkZXYsIHRydWUp
Owo+Pj4gICAJdW5yZWdpc3Rlcl92aXJ0aW9fZGV2aWNlKCZ2Y2Rldi0+dmRldik7Cj4+PiAgIAlz
cGluX2xvY2tfaXJxc2F2ZShnZXRfY2N3ZGV2X2xvY2soY2RldiksIGZsYWdzKTsKPj4+ICAgCWRl
dl9zZXRfZHJ2ZGF0YSgmY2Rldi0+ZGV2LCBOVUxMKTsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9j
b21tb24uYwo+Pj4gaW5kZXggZDcyNGY2NzY2MDhiLi4zOWE3MTFkZGZmMzAgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+PiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+PiBAQCAtNTgzLDcgKzU4Myw3IEBAIHN0YXRp
YyB2b2lkIHZpcnRpb19wY2lfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2KQo+Pj4gICAJ
ICogbGF5ZXJzIGNhbiBhYm9ydCBhbnkgb25nb2luZyBvcGVyYXRpb24uCj4+PiAgIAkgKi8KPj4+
ICAgCWlmICghcGNpX2RldmljZV9pc19wcmVzZW50KHBjaV9kZXYpKQo+Pj4gLQkJdmlydGlvX2Jy
ZWFrX2RldmljZSgmdnBfZGV2LT52ZGV2KTsKPj4+ICsJCXZpcnRpb19icmVha19kZXZpY2UoJnZw
X2Rldi0+dmRldiwgdHJ1ZSk7Cj4+PiAgIAo+Pj4gICAJcGNpX2Rpc2FibGVfc3Jpb3YocGNpX2Rl
dik7Cj4+PiAgIAo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+PiBpbmRleCBjZmIwMjhjYTIzOGUuLjZk
YTEzNDk1YTcwYyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+IEBAIC0yMzgyLDcgKzIz
ODIsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfaXNfYnJva2VuKTsKPj4+ICAgICog
VGhpcyBzaG91bGQgcHJldmVudCB0aGUgZGV2aWNlIGZyb20gYmVpbmcgdXNlZCwgYWxsb3dpbmcg
ZHJpdmVycyB0bwo+Pj4gICAgKiByZWNvdmVyLiAgWW91IG1heSBuZWVkIHRvIGdyYWIgYXBwcm9w
cmlhdGUgbG9ja3MgdG8gZmx1c2guCj4+PiAgICAqLwo+Pj4gLXZvaWQgdmlydGlvX2JyZWFrX2Rl
dmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+Pj4gK3ZvaWQgdmlydGlvX2JyZWFrX2Rl
dmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2LCBib29sIGJyb2tlbikKPj4gSSB0aGluayB3
ZSBuZWVkIHRvIGJlIGNhcmVmdWwgdG8gc2F5IHdoZW4gaXQgaXMgc2FmZSB0byB1bnNldCAnYnJv
a2VuJy4KPj4KPj4gVGhlIGN1cnJlbnQgY2FsbGVycyBzZXQgYWxsIHF1ZXVlcyB0byBicm9rZW4g
aW4gY2FzZSBvZiBzdXJwcmlzZSByZW1vdmFsCj4+IChjY3csIHBjaSksIHJlbW92YWwgKGNvbnNv
bGUpLCBvciB0aGUgZGV2aWNlIGJlaGF2aW5nIGJhZGx5Cj4+IChjcnlwdG8pLiBUaGVyZSdzIGFs
c28gY29kZSBzZXR0aW5nIGluZGl2aWR1YWwgcXVldWVzIHRvIGJyb2tlbi4gV2UgZG8KPj4gbm90
IHdhbnQgdG8gdW5kbyBhbnkgb2YgdGhlc2UsIHVubGVzcyB0aGUgZGV2aWNlIGhhcyBnb25lIHRo
cm91Z2ggYQo+PiByZXNldCBpbiB0aGUgbWVhbndoaWxlLiBNYXliZSBhZGQ6Cj4+Cj4+ICJJdCBp
cyBvbmx5IHNhZmUgdG8gY2FsbCB0aGlzIGZ1bmN0aW9uIHRvICpyZW1vdmUqIHRoZSBicm9rZW4g
ZmxhZyBmb3IgYQo+PiBkZXZpY2UgdGhhdCBpcyAocmUpdHJhbnNpdGlvbmluZyB0byBiZWNvbWlu
ZyB1c2FibGU7IGNhbGxpbmcgaXQgdGhhdCB3YXkKPj4gZHVyaW5nIG5vcm1hbCB1c2FnZSBtYXkg
aGF2ZSB1bnByZWRpY3RhYmxlIGNvbnNlcXVlbmNlcy4iCj4+Cj4+IChOb3Qgc3VyZSBob3cgdG8g
d29yZCB0aGlzOyBlc3BlY2lhbGx5IGlmIHdlIGNvbnNpZGVyIGZ1dHVyZSB1c2FnZSBvZgo+PiBx
dWV1ZSByZXNldC4pCj4KPiBSaWdodC4gSSB3b3VsZCBwcmVmZXIgX192aXJ0aW9fdW5icmVha19k
ZXZpY2Ugb3Igc29tZXRoaW5nIHNpbWlsYXIKCgpPaywgc28gSSB0aGluayB0aGVuIHdlIGRvbid0
IHdhbnQgaXQgdG8gYmUgZXhwb3J0ZWQuCgoKPiB3aXRoIGEgYml0IGNvbW1lbnQgZXhwbGFpbmlu
ZyBpdCdzIG9ubHkgc2FmZSB0byBjYWxsIGR1cmluZyBwcm9iZS4KCgpXaWxsIGRvLgoKVGhhbmtz
CgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
