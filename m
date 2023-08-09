Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB357C001B0
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 01:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43C9340CC3;
	Wed,  9 Aug 2023 01:43:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 43C9340CC3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6dXfKyJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbFEMlTJ2GUW; Wed,  9 Aug 2023 01:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D1E1C4018A;
	Wed,  9 Aug 2023 01:43:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1E1C4018A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF37EC0071;
	Wed,  9 Aug 2023 01:43:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B352C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72A878216C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:43:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72A878216C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6dXfKyJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2_WVyolWAjcm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:43:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B494B8216A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 01:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B494B8216A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691545400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0milLMTfaMNwV+pkxME5lLLZH3Tw9BxNkPloaCPzUwI=;
 b=a6dXfKyJxwdnazKBUCGMl8j7iB+gH7hedhGcRwedOUqBMJPsbxceB91VIGk2w4IS6Abpr/
 ag9zQYt7fN9LtKPsdXJlEG2rPIzm84HeffoBkOidI8fFvYdblPEkziSAiEqiR5GVV0S7Jo
 VsrLBPnYKYJKvuurTyk07/GAOm/1XB8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-v6O7E90_Op2aqZ-Z1lKe-w-1; Tue, 08 Aug 2023 21:43:17 -0400
X-MC-Unique: v6O7E90_Op2aqZ-Z1lKe-w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9dc1bfdd2so66685661fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Aug 2023 18:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691545396; x=1692150196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0milLMTfaMNwV+pkxME5lLLZH3Tw9BxNkPloaCPzUwI=;
 b=ZKqFYGiHmSg5u8DeLojBAl5/IPDtdyCllHyodjl1MtCqF9Vcr0afJLHt4hlgGPlF9P
 nuesetl/IJ1ptTTIvnlZIr2+JOMFkIE/dfuttkhDSKzxqUSAeUrA/1Le45paVxLp7CQg
 O7UxO47uzcGO4aZWSBYD7h3deu8CrsOFYM9mnwEIhn9+lusk8OyZmFnhjwhln1xICaHs
 w0lp3e/ABGjiR8VD+uXCtfNJxrG3uE3GCOyX6xZlkehBCgepPM5Es4bc1dBf0RFEhx9/
 ta6ibY0//qx4CaSz6Ib0AJVMmTPp8lzwL82DlZWQs619JtvggJbW/wjObHFgEC4ntp/U
 MUcA==
X-Gm-Message-State: AOJu0YyaSyrUJ71hLzuajDhucuCELv8OD+7p0055vTM9gavPBsiLtG4l
 DwxTFJM8i6Ug98YJLE/8LYPtmHx/DMCf69OMp67nwKkg17uu/cpoX4EY2g6mWwHx7ZFBHY/dF1p
 UnEixMNRIX41Dr7BKE+o3+tJcNWMSrp3iGgRS/oDGwujwwLs9KhfQ/RBtOg==
X-Received: by 2002:a2e:a0d0:0:b0:2b9:afd1:b77a with SMTP id
 f16-20020a2ea0d0000000b002b9afd1b77amr781217ljm.0.1691545395933; 
 Tue, 08 Aug 2023 18:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF11DqwutQb2zmy1I9zWiJXkEyFGxV+VUJ1RL/ZEvmwVFq1I/11YA4CKyXEynCjNHKyqVxR0nnXTRmIF85/CBg=
X-Received: by 2002:a2e:a0d0:0:b0:2b9:afd1:b77a with SMTP id
 f16-20020a2ea0d0000000b002b9afd1b77amr781206ljm.0.1691545395631; Tue, 08 Aug
 2023 18:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230725072049.617289-1-jasowang@redhat.com>
 <e1fcd1a2ca22bc09387e162e22c61e54fe8c57ca.camel@nvidia.com>
In-Reply-To: <e1fcd1a2ca22bc09387e162e22c61e54fe8c57ca.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Aug 2023 09:43:04 +0800
Message-ID: <CACGkMEunLBK2VPpp_TVn-=SZjt4p3NTx0_iL=nLQz1EmceMWTA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCA3OjM14oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAyMDIzLTA3LTI1IGF0IDAzOjIwIC0wNDAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gQSByYWNlIHdlcmUgZm91bmQgd2hlcmUgc2V0X2NoYW5u
ZWxzIGNvdWxkIGJlIGNhbGxlZCBhZnRlciByZWdpc3RlcmluZwo+ID4gYnV0IGJlZm9yZSB2aXJ0
bmV0X3NldF9xdWV1ZXMoKSBpbiB2aXJ0bmV0X3Byb2JlKCkuIEZpeGluZyB0aGlzIGJ5Cj4gPiBt
b3ZpbmcgdGhlIHZpcnRuZXRfc2V0X3F1ZXVlcygpIGJlZm9yZSBuZXRkZXZpY2UgcmVnaXN0ZXJp
bmcuIFdoaWxlIGF0Cj4gPiBpdCwgdXNlIF92aXJ0bmV0X3NldF9xdWV1ZXMoKSB0byBhdm9pZCBo
b2xkaW5nIHJ0bmwgYXMgdGhlIGRldmljZSBpcwo+ID4gbm90IGV2ZW4gcmVnaXN0ZXJlZCBhdCB0
aGF0IHRpbWUuCj4gPgo+ID4gRml4ZXM6IGEyMjA4NzFiZTY2ZiAoInZpcnRpby1uZXQ6IGNvcnJl
Y3RseSBlbmFibGUgbXVsdGlxdWV1ZSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IHwgNCArKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCAwZGIxNGY2Yjg3ZDMuLjEyNzBjOGQyMzQ2
MyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtNDIxOSw2ICs0MjE5LDggQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gICAgICAgICBp
ZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpCj4gPiAgICAgICAgICAg
ICAgICAgdmlydG5ldF9pbml0X2RlZmF1bHRfcnNzKHZpKTsKPiA+Cj4gPiArICAgICAgIF92aXJ0
bmV0X3NldF9xdWV1ZXModmksIHZpLT5jdXJyX3F1ZXVlX3BhaXJzKTsKPiA+ICsKPiA+ICAgICAg
ICAgLyogc2VyaWFsaXplIG5ldGRldiByZWdpc3RlciArIHZpcnRpb19kZXZpY2VfcmVhZHkoKSB3
aXRoIG5kb19vcGVuKCkKPiA+ICovCj4gPiAgICAgICAgIHJ0bmxfbG9jaygpOwo+ID4KPiA+IEBA
IC00MjU3LDggKzQyNTksNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpCj4gPiAgICAgICAgICAgICAgICAgZ290byBmcmVlX3VucmVnaXN0ZXJf
bmV0ZGV2Owo+ID4gICAgICAgICB9Cj4gPgo+ID4gLSAgICAgICB2aXJ0bmV0X3NldF9xdWV1ZXMo
dmksIHZpLT5jdXJyX3F1ZXVlX3BhaXJzKTsKPiA+IC0KPiA+ICAgICAgICAgLyogQXNzdW1lIGxp
bmsgdXAgaWYgZGV2aWNlIGNhbid0IHJlcG9ydCBsaW5rIHN0YXR1cywKPiA+ICAgICAgICAgICAg
b3RoZXJ3aXNlIGdldCBsaW5rIHN0YXR1cyBmcm9tIGNvbmZpZy4gKi8KPiA+ICAgICAgICAgbmV0
aWZfY2Fycmllcl9vZmYoZGV2KTsKPgo+IFRoaXMgY2hhbmdlIHNlZW1zIHRvIGJyZWFrIG1seDVf
dmRwYSB3aGVuIHVzaW5nIHZpcnRpb192ZHBhLgo+IF92aXJ0bmV0X3NldF9xdWV1ZXMoKSBoYW5n
cy4gQmVjYXVzZSBEUklWRVJfT0sgaGFzIG5vdCB5ZXQgYmVlbiBzZXQsIG1seDVfdmRwYQo+IGN2
cSBraWNrIGhhbmRsZXIgd2lsbCBpZ25vcmUgYW55IGNvbW1hbmRzLgo+CgpZZXMsIEkgd2lsbCBw
b3N0IGEgZml4IHNvb24uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
