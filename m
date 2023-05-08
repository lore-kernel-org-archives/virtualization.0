Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F5C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8C3F40105;
	Mon,  8 May 2023 06:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8C3F40105
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WU3MR5nP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwon8jGdkw3v; Mon,  8 May 2023 06:08:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0BBEC40002;
	Mon,  8 May 2023 06:08:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BBEC40002
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBA41C0036;
	Mon,  8 May 2023 06:08:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47DC6C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BAD940461
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:08:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BAD940461
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WU3MR5nP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5dQm9j07WCQZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:08:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDCB240111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDCB240111
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683526084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=496riEt70CLjVEPXxKBFIzM6DccwKHKgAN0XgS7K+xk=;
 b=WU3MR5nPwyORCS4PDfIDUkkSu3M9zLSEngYD76mv+AO7vSBezbqusIT1qIq9bMi+o9Kni5
 eJ3KJa3nYJ5lajV9cBqiMcdG3l1G1jJ1ruJgT8Z+O5JdUVuqBJwkdEMM3rLmJSk4goWcHm
 Es7bUys3H2Xczgetv6iWj1C9fC2+xAs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-8le7XaPFMqWGAgnZ91tGQA-1; Mon, 08 May 2023 02:08:03 -0400
X-MC-Unique: 8le7XaPFMqWGAgnZ91tGQA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-306489b7585so1358865f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 23:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683526082; x=1686118082;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=496riEt70CLjVEPXxKBFIzM6DccwKHKgAN0XgS7K+xk=;
 b=CV7tO1RNcHP9gEQWk6gHpwhqKsB0cTzMj9Z4yqXJ90ADFDCPquflMfn9xS+HHm1zyl
 QirIOFKVcla5yGeZNF6i74g3cdckkv/rvLQOjf+yKYwwr1aEHzErFOY3H6ytJSfDa1D1
 5HDxKpTK69fN1EYHnhv9PJQHK2z9n5HpAdJ5KtjOnGxNrTbzUzHPKKxYT1TIW3VcBf90
 XAMOUR3u++IgmTFQPxf2fG7RINasfiix8/uwtKC0XknQADnB6La6nclctvdKmRl82CXU
 d35snsT+T3DmqN0qKLSvjokarK0jjJPI6940YofWei9TMwE3Em9mEdnZ+QxqJxA+7sbY
 S+ug==
X-Gm-Message-State: AC+VfDzgE+bQ/2o24NcToEo0sQ1iksC+q3MFNyJiHhFg8M0d/Cg+hjAf
 JBkAOKnwJyhoc2EjY5U+GbIXizokle5FtusmaWzWFT2YD0Mt5R6jW5+z5PNNCwhZp4y5vm/mE2j
 jbiWgmiBxIy7qJFVNgGSIKtBmTJ6CWqIO6j+3ztkfsg==
X-Received: by 2002:a5d:6801:0:b0:306:2b64:fd1b with SMTP id
 w1-20020a5d6801000000b003062b64fd1bmr6387828wru.52.1683526082131; 
 Sun, 07 May 2023 23:08:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7f8poeeWKuFbkFRFraXJPQPQU8mq+PdFxmJfqKohdU/FLK+Ng7mCXc+1OoWwdFP0rxufKFDA==
X-Received: by 2002:a5d:6801:0:b0:306:2b64:fd1b with SMTP id
 w1-20020a5d6801000000b003062b64fd1bmr6387812wru.52.1683526081830; 
 Sun, 07 May 2023 23:08:01 -0700 (PDT)
Received: from redhat.com ([2.52.158.28]) by smtp.gmail.com with ESMTPSA id
 k15-20020a5d428f000000b003062d815fa6sm10182362wrq.85.2023.05.07.23.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 May 2023 23:08:01 -0700 (PDT)
Date: Mon, 8 May 2023 02:07:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230508020717-mutt-send-email-mst@kernel.org>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
 <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
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

T24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMTE6MTI6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMy81LzcgMjE6MzQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4g
PiBPbiBGcmksIE1heSAwNSwgMjAyMyBhdCAxMToyODoyNUFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiBPbiBUaHUsIE1heSA0LCAyMDIzIGF0IDEwOjI34oCvQU0gV2VubGlhbmcgV2Fu
Zwo+ID4gPiA8d2FuZ3dlbmxpYW5nLjE5OTVAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+ID4g
Rm9yIG11bHRpLXF1ZXVlIGFuZCBsYXJnZSByaW5nLXNpemUgdXNlIGNhc2UsIHRoZSBmb2xsb3dp
bmcgZXJyb3IKPiA+ID4gPiBvY2N1cnJlZCB3aGVuIGZyZWVfdW51c2VkX2J1ZnM6Cj4gPiA+ID4g
cmN1OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUuCj4gPiA+ID4g
Cj4gPiA+ID4gRml4ZXM6IDk4NmE0ZjRkNDUyZCAoInZpcnRpb19uZXQ6IG11bHRpcXVldWUgc3Vw
cG9ydCIpCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogV2VubGlhbmcgV2FuZyA8d2FuZ3dlbmxpYW5n
LjE5OTVAYnl0ZWRhbmNlLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiB2MjoKPiA+ID4gPiAtYWRk
IG5lZWRfcmVzY2hlZCBjaGVjay4KPiA+ID4gPiAtYXBwbHkgc2FtZSBsb2dpYyB0byBzcS4KPiA+
ID4gPiB2MzoKPiA+ID4gPiAtdXNlIGNvbmRfcmVzY2hlZCBpbnN0ZWFkLgo+ID4gPiA+IHY0Ogo+
ID4gPiA+IC1hZGQgZml4ZXMgdGFnCj4gPiA+ID4gLS0tCj4gPiA+ID4gICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAyICsrCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+IGluZGV4IDhkODAzODUzOGZjNC4u
YTEyYWUyNmRiMGUyIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+IEBAIC0zNTYw
LDEyICszNTYwLDE0IEBAIHN0YXRpYyB2b2lkIGZyZWVfdW51c2VkX2J1ZnMoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmkpCj4gPiA+ID4gICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2
cSA9IHZpLT5zcVtpXS52cTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgIHdoaWxlICgoYnVmID0g
dmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKHZxKSkgIT0gTlVMTCkKPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYodnEsIGJ1Zik7Cj4g
PiA+ID4gKyAgICAgICAgICAgICAgIGNvbmRfcmVzY2hlZCgpOwo+ID4gPiBEb2VzIHRoaXMgcmVh
bGx5IGFkZHJlc3MgdGhlIGNhc2Ugd2hlbiB0aGUgdmlydHF1ZXVlIGlzIHZlcnkgbGFyZ2U/Cj4g
PiA+IAo+ID4gPiBUaGFua3MKPiA+IAo+ID4gaXQgZG9lcyBpbiB0aGF0IGEgdmVyeSBsYXJnZSBx
dWV1ZSBpcyBzdGlsbCBqdXN0IDY0ayBpbiBzaXplLgo+ID4gd2UgbWlnaHQgaG93ZXZlciBoYXZl
IDY0ayBvZiB0aGVzZSBxdWV1ZXMuCj4gCj4gCj4gT2ssIGJ1dCB3ZSBoYXZlIG90aGVyIHNpbWls
YXIgbG9vcHMgZXNwZWNpYWxseSB0aGUgcmVmaWxsLCBJIHRoaW5rIHdlIG1heQo+IG5lZWQgY29u
ZF9yZXNjaGVkKCkgdGhlcmUgYXMgd2VsbC4KPiAKPiBUaGFua3MKPiAKClJlZmlsbCBpcyBhbHJl
YWR5IHBlciB2cSBpc24ndCBpdD8KCgo+ID4gCj4gPiA+ID4gICAgICAgICAgfQo+ID4gPiA+IAo+
ID4gPiA+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKysp
IHsKPiA+ID4gPiAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0cXVldWUgKnZxID0gdmktPnJx
W2ldLnZxOwo+ID4gPiA+ICAgICAgICAgICAgICAgICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVf
ZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxMKQo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1Zih2cSwgYnVmKTsKPiA+ID4gPiArICAg
ICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7Cj4gPiA+ID4gICAgICAgICAgfQo+ID4gPiA+ICAg
fQo+ID4gPiA+IAo+ID4gPiA+IC0tCj4gPiA+ID4gMi4yMC4xCj4gPiA+ID4gCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
