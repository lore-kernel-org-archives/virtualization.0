Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB69C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 09:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 222F741FCE;
	Fri, 31 Mar 2023 09:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 222F741FCE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fWzrUECQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91RVNIsHymZr; Fri, 31 Mar 2023 09:02:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 841CB40207;
	Fri, 31 Mar 2023 09:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 841CB40207
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54125C0037;
	Fri, 31 Mar 2023 09:02:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74926C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48953616DB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48953616DB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fWzrUECQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j0rXHCbVNuHx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:02:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC4F961651
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC4F961651
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680253327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKiZjiu+vyUAzLFC4ReUwOUR5bMI5bhQM5JmbRM0Kuw=;
 b=fWzrUECQoCWRsX44JR6WifZmotz8j0dgxZEtGIQMGM5wLFIb6xDxh05MHWLfeeOUDL5BEC
 kUo7gJOwUb7EZt0RZ51WsaNgdBIa2Twxa9C0JUd5FfhoGegnXG9gnUe/vXrb1jz8563SHK
 XGt3x3oXs9ux2hNr0tI1JZiMYtjleFk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-wjcbt-vGNoWdMv3f4CwXxQ-1; Fri, 31 Mar 2023 05:02:06 -0400
X-MC-Unique: wjcbt-vGNoWdMv3f4CwXxQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 s127-20020acaa985000000b003891d21e8c0so4170792oie.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 02:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680253325; x=1682845325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKiZjiu+vyUAzLFC4ReUwOUR5bMI5bhQM5JmbRM0Kuw=;
 b=vwUOnlTYM7vPnXPWedvBeztCCR++rJBXOEkxdNfwSjC9H8Pi3B7MeNG0MSRAkgAl34
 /YpK8TMfo/VzKyCtBf6GyxWF9DsQg1+l2mte1F+1LKgSfaUMJxQYLWJe621z9JHvkpTM
 ZuuBMYN2lg8n1f6iqGQXXu7nZcNOutY2Nn1s7DVNmEVPsz1Ygtufh744baJlMUT40Guk
 hqrvupE93h69jZqe3VplIg9a4CFqdG6wjY521Ezaup2pPp7KPEp1m1C8TBIJuRgfjMFn
 xtfTpGu4cCJ/nSnwUvmgsP2/cPXlq/P41GgLBIHEgcLpheXgovvp1FWkxSpoz9nKEst2
 I5qw==
X-Gm-Message-State: AAQBX9cU3wRYVEwuogSjDZhWRa+LBjTxFneEO/4lp21z6DiyeEWU2p/I
 Cw9ycDTdCnGzr16eW6PIUPI8nOoYWM7eEpgLcnvTSSig5s8Fgf0iGaGae71SKdmEN3pAfZ0mnFC
 u/s3wab1tgeP7AMPdqoKMj+yTECQDX3VjPFZ5ysatHwPOn3of+HOd+OY5LQ==
X-Received: by 2002:a05:6870:10d4:b0:17e:255e:b1 with SMTP id
 20-20020a05687010d400b0017e255e00b1mr8464656oar.9.1680253325522; 
 Fri, 31 Mar 2023 02:02:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set+Ts2kOcVrDednbiGdLc79/pd1q0SEl6uWTDudORrDUOW2+ftuM4XiSkihLIYlW4BcE3xwOOHJ03vcj8ux1Qxo=
X-Received: by 2002:a05:6870:10d4:b0:17e:255e:b1 with SMTP id
 20-20020a05687010d400b0017e255e00b1mr8464651oar.9.1680253325267; Fri, 31 Mar
 2023 02:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230328120412.110114-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Mar 2023 17:01:54 +0800
Message-ID: <CACGkMEseX1+oi+unZspnGzPduQc-tFkxpVg+9KfEhPSWWqCTrg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page
 immediately
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgODowNOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSW4gdGhlIHhkcCBpbXBsZW1lbnRhdGlvbiBvZiB2
aXJ0aW8tbmV0IG1lcmdlYWJsZSwgaXQgYWx3YXlzIGNoZWNrcwo+IHdoZXRoZXIgdHdvIHBhZ2Ug
aXMgdXNlZCBhbmQgYSBwYWdlIGlzIHNlbGVjdGVkIHRvIHJlbGVhc2UuIFRoaXMgaXMKPiBjb21w
bGljYXRlZCBmb3IgdGhlIHByb2Nlc3Npbmcgb2YgYWN0aW9uLCBhbmQgYmUgY2FyZWZ1bC4KPgo+
IEluIHRoZSBlbnRpcmUgcHJvY2Vzcywgd2UgaGF2ZSBzdWNoIHByaW5jaXBsZXM6Cj4gKiBJZiB4
ZHBfcGFnZSBpcyB1c2VkIChQQVNTLCBUWCwgUmVkaXJlY3QpLCB0aGVuIHdlIHJlbGVhc2UgdGhl
IG9sZAo+ICAgcGFnZS4KPiAqIElmIGl0IGlzIGEgZHJvcCBjYXNlLCB3ZSB3aWxsIHJlbGVhc2Ug
dHdvLiBUaGUgb2xkIHBhZ2Ugb2J0YWluZWQgZnJvbQo+ICAgYnVmIGlzIHJlbGVhc2UgaW5zaWRl
IGVycl94ZHAsIGFuZCB4ZHBfcGFnZSBuZWVkcyBiZSByZWxhc2VkIGJ5IHVzLgo+Cj4gQnV0IGlu
IGZhY3QsIHdoZW4gd2UgYWxsb2NhdGUgYSBuZXcgcGFnZSwgd2UgY2FuIHJlbGVhc2UgdGhlIG9s
ZCBwYWdlCj4gaW1tZWRpYXRlbHkuIFRoZW4ganVzdCBvbmUgaXMgdXNpbmcsIHdlIGp1c3QgbmVl
ZCB0byByZWxlYXNlIHRoZSBuZXcKPiBwYWdlIGZvciBkcm9wIGNhc2UuIE9uIHRoZSBkcm9wIHBh
dGgsIGVycl94ZHAgd2lsbCByZWxlYXNlIHRoZSB2YXJpYWJsZQo+ICJwYWdlIiwgc28gd2Ugb25s
eSBuZWVkIHRvIGxldCAicGFnZSIgcG9pbnQgdG8gdGhlIG5ldyB4ZHBfcGFnZSBpbgo+IGFkdmFu
Y2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxNSArKysrKystLS0tLS0t
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBpbmRleCBlMjU2MGI2Zjc5ODAuLjRkMmJmMWNlMDczMCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiBAQCAtMTI0NSw2ICsxMjQ1LDkgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZl
X21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmICgheGRwX3BhZ2UpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGVycl94ZHA7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0ID0gVklSVElPX1hEUF9I
RUFEUk9PTTsKPiArCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgcGFnZSA9IHhkcF9wYWdlOwo+ICAgICAgICAgICAgICAg
ICB9IGVsc2UgaWYgKHVubGlrZWx5KGhlYWRyb29tIDwgdmlydG5ldF9nZXRfaGVhZHJvb20odmkp
KSkgewo+ICAgICAgICAgICAgICAgICAgICAgICAgIHhkcF9yb29tID0gU0tCX0RBVEFfQUxJR04o
VklSVElPX1hEUF9IRUFEUk9PTSArCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHNrYl9zaGFyZWRfaW5mbykpOwo+IEBAIC0x
MjU5LDYgKzEyNjIsOSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBhZ2VfYWRkcmVzcyhwYWdlKSArIG9mZnNldCwgbGVuKTsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBmcmFtZV9zeiA9IFBBR0VfU0laRTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBvZmZz
ZXQgPSBWSVJUSU9fWERQX0hFQURST09NOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBw
dXRfcGFnZShwYWdlKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBwYWdlID0geGRwX3BhZ2U7
Cj4gICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgeGRw
X3BhZ2UgPSBwYWdlOwo+ICAgICAgICAgICAgICAgICB9CgpXaGlsZSBhdCB0aGlzIEkgd291bGQg
Z28gYSBsaXR0bGUgZnVydGhlciwganVzdCByZW1vdmUgdGhlIGFib3ZlCmFzc2lnbm1lbnQgdGhl
biB3ZSBjYW4gdXNlOgoKICAgICAgICAgICAgICAgIGRhdGEgPSBwYWdlX2FkZHJlc3MocGFnZSkg
KyBvZmZzZXQ7CgpXaGljaCBzZWVtcyBjbGVhbmVyPwoKVGhhbmtzCgo+IEBAIC0xMjc4LDggKzEy
ODQsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFo
ZWFkX3NrYikpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBf
ZnJhZ3M7Cj4KPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2Ug
IT0gcGFnZSkpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdXRfcGFnZShwYWdl
KTsKPiAgICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4gICAgICAgICAgICAgICAgIGNhc2Ug
WERQX1RYOgo+IEBAIC0xMjk3LDggKzEzMDEsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJl
Y2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgfQo+ICAgICAgICAgICAgICAgICAgICAgICAgICp4ZHBfeG1pdCB8PSBWSVJUSU9fWERQ
X1RYOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh4ZHBfcGFnZSAhPSBw
YWdlKSkKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGdvdG8geGRwX3htaXQ7Cj4gICAgICAgICAgICAgICAgIGNhc2UgWERQX1JF
RElSRUNUOgo+IEBAIC0xMzA3LDggKzEzMDksNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJl
Y2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGVycikKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3hkcF9mcmFnczsKPiAgICAgICAgICAgICAgICAgICAgICAgICAqeGRwX3htaXQgfD0gVklS
VElPX1hEUF9SRURJUjsKPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoeGRw
X3BhZ2UgIT0gcGFnZSkpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwdXRfcGFn
ZShwYWdlKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHhkcF94bWl0Owo+ICAgICAgICAgICAgICAgICBk
ZWZhdWx0Ogo+IEBAIC0xMzIxLDkgKzEzMjEsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJl
Y2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBlcnJfeGRwX2ZyYWdzOwo+ICAgICAgICAgICAgICAgICB9Cj4gIGVycl94
ZHBfZnJhZ3M6Cj4gLSAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh4ZHBfcGFnZSAhPSBwYWdl
KSkKPiAtICAgICAgICAgICAgICAgICAgICAgICBfX2ZyZWVfcGFnZXMoeGRwX3BhZ2UsIDApOwo+
IC0KPiAgICAgICAgICAgICAgICAgaWYgKHhkcF9idWZmX2hhc19mcmFncygmeGRwKSkgewo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHNoaW5mbyA9IHhkcF9nZXRfc2hhcmVkX2luZm9fZnJvbV9i
dWZmKCZ4ZHApOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzaGlu
Zm8tPm5yX2ZyYWdzOyBpKyspIHsKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
