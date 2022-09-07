Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A219EC38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 04:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F8E940278;
	Wed,  7 Sep 2022 04:28:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F8E940278
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V+KAm/as
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWXnyGXQJn5x; Wed,  7 Sep 2022 04:28:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95834400CC;
	Wed,  7 Sep 2022 04:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95834400CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 694C1C0032;
	Wed,  7 Sep 2022 04:28:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E1F7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3182081489
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:27:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3182081489
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V+KAm/as
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Y9BCDRaQAv6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:27:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E607C81441
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E607C81441
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662524876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4j6Q+BCgruPfdfNoIE3/wZJYX17HQyjtjOota9ARPcM=;
 b=V+KAm/asuIDImGIgApI9YQgU4hIKkKJV98/wMi18UBxbIDtIt7vdjJKOPExAQRmzk0hSO/
 W83sxJ//sjymxv+V25jnA+sEBG9uf9cU5Ig0V4BnNe0Tpd772avFHM5ufvCNGMLeurI6q9
 WWicbQrQNla8dV2jZC7B/tvNbfMRirk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-315-8uUJ4W2yO9SCfi2spC4Ulw-1; Wed, 07 Sep 2022 00:27:55 -0400
X-MC-Unique: 8uUJ4W2yO9SCfi2spC4Ulw-1
Received: by mail-pl1-f200.google.com with SMTP id
 p18-20020a170902a41200b00172b0dc71e0so9075172plq.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 21:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=4j6Q+BCgruPfdfNoIE3/wZJYX17HQyjtjOota9ARPcM=;
 b=ZsTrEuWlFxcZXpPrfexYJPzGhf54nJwe4pahj6wL7s/al5XZ1mdawvHEWjBd/q3ixg
 qVOx5x/f9UZpbgDaFZNF3asKmJ3USEAhZ+quOLelrJm9Zb63gn+GX+4K9vVoXoc7OC6g
 GA4CA/T8Uouyl4NOsGc9w0uOQ2vMQ0HueqtVinwWwq5/udcdOaWs7f8OFBcKg/AVQe7E
 Tm+SjC3WL9/u1mGRauRaceiOgRtLcZke1ofsNd4kaAmSAZfFydOl73/A1ReCCAqLnTxf
 98jL6zyKT+h/f0qprPsp9w00D0iBwy6eCjn4yfPIAUZtsHEEUEqGF1cjSDBOIy4qkPrH
 l9ug==
X-Gm-Message-State: ACgBeo1+S0ofwoJ5xJQF+tqC2Vp6TRaAaIpU5WpsDFS4Kv65rOoh9PPy
 J1aBiva1si7a3BHRbbrmjEjRzYfrV0loYsc6KsgNNl2maP+uK85/qd1YVIGPbgoCSBV2hF0StnH
 ubP3GlcWpN9ra09yNqZXxslP0o6kyHpMllpezonCXvQ==
X-Received: by 2002:a05:6a00:ad1:b0:530:2cb7:84de with SMTP id
 c17-20020a056a000ad100b005302cb784demr1905277pfl.3.1662524874247; 
 Tue, 06 Sep 2022 21:27:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7P5ZyRAOSvxlEfTBlfyhp+ATcHkzoRBcyq3eWnpZwM/6/JJA/8FKFnJZ8VB0LxM3ySljdcsQ==
X-Received: by 2002:a05:6a00:ad1:b0:530:2cb7:84de with SMTP id
 c17-20020a056a000ad100b005302cb784demr1905253pfl.3.1662524873918; 
 Tue, 06 Sep 2022 21:27:53 -0700 (PDT)
Received: from [10.72.13.171] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a632341000000b0042a6dde1d66sm7922152pgm.43.2022.09.06.21.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Sep 2022 21:27:53 -0700 (PDT)
Message-ID: <ff96c12e-95cb-be57-9b5b-2da08b0630c6@redhat.com>
Date: Wed, 7 Sep 2022 12:27:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v3 3/7] vsock: batch buffers in tx
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220901055434.824-1-qtxuning1999@sjtu.edu.cn>
 <20220901055434.824-4-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220901055434.824-4-qtxuning1999@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzkvMSAxMzo1NCwgR3VvIFpoaSDlhpnpgZM6Cj4gVnNvY2sgdXNlcyBidWZmZXJz
IGluIG9yZGVyLCBhbmQgZm9yIHR4IGRyaXZlciBkb2Vzbid0IGhhdmUgdG8KPiBrbm93IHRoZSBs
ZW5ndGggb2YgdGhlIGJ1ZmZlci4gU28gd2UgY2FuIGRvIGEgYmF0Y2ggZm9yIHZzb2NrIGlmCj4g
aW4gb3JkZXIgbmVnb3RpYXRlZCwgb25seSB3cml0ZSBvbmUgdXNlZCByaW5nIGZvciBhIGJhdGNo
IG9mIGJ1ZmZlcnMKPgo+IFNpZ25lZC1vZmYtYnk6IEd1byBaaGkgPHF0eHVuaW5nMTk5OUBzanR1
LmVkdS5jbj4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdnNvY2suYyB8IDEyICsrKysrKysrKyst
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92c29jay5jIGIvZHJpdmVycy92aG9zdC92c29j
ay5jCj4gaW5kZXggMzY4MzMwNDE3YmRlLi5lMDhmYmJiNTQzOWUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aG9zdC92c29jay5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92c29jay5jCj4gQEAgLTQ5
Nyw3ICs0OTcsNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF92c29ja19oYW5kbGVfdHhfa2ljayhzdHJ1
Y3Qgdmhvc3Rfd29yayAqd29yaykKPiAgIAlzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZzb2NrID0gY29u
dGFpbmVyX29mKHZxLT5kZXYsIHN0cnVjdCB2aG9zdF92c29jaywKPiAgIAkJCQkJCSBkZXYpOwo+
ICAgCXN0cnVjdCB2aXJ0aW9fdnNvY2tfcGt0ICpwa3Q7Cj4gLQlpbnQgaGVhZCwgcGt0cyA9IDAs
IHRvdGFsX2xlbiA9IDA7Cj4gKwlpbnQgaGVhZCwgcGt0cyA9IDAsIHRvdGFsX2xlbiA9IDAsIGFk
ZCA9IDA7Cj4gICAJdW5zaWduZWQgaW50IG91dCwgaW47Cj4gICAJYm9vbCBhZGRlZCA9IGZhbHNl
Owo+ICAgCj4gQEAgLTU1MSwxMCArNTUxLDE4IEBAIHN0YXRpYyB2b2lkIHZob3N0X3Zzb2NrX2hh
bmRsZV90eF9raWNrKHN0cnVjdCB2aG9zdF93b3JrICp3b3JrKQo+ICAgCQllbHNlCj4gICAJCQl2
aXJ0aW9fdHJhbnNwb3J0X2ZyZWVfcGt0KHBrdCk7Cj4gICAKPiAtCQl2aG9zdF9hZGRfdXNlZCh2
cSwgaGVhZCwgMCk7Cj4gKwkJaWYgKCF2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfSU5f
T1JERVIpKSB7Cj4gKwkJCXZob3N0X2FkZF91c2VkKHZxLCBoZWFkLCAwKTsKCgpJJ2QgZG8gdGhp
cyBzdGVwIGJ5IHN0ZXAuCgoxKSBzd2l0Y2ggdG8gdXNlIHZob3N0X2FkZF91c2VkX24oKSBmb3Ig
dnNvY2ssIGxlc3MgY29weV90b191c2VyKCkgCmJldHRlciBwZXJmb3JtYW5jZQoyKSBkbyBpbi1v
cmRlciBvbiB0b3AKCgo+ICsJCX0gZWxzZSB7Cj4gKwkJCXZxLT5oZWFkc1thZGRdLmlkID0gaGVh
ZDsKPiArCQkJdnEtPmhlYWRzW2FkZCsrXS5sZW4gPSAwOwoKCkhvdyBjYW4gd2UgZ3VhcmFudGVl
IHRoYXQgd2UgYXJlIGluIHRoZSBib3VuZGFyeSBvZiB0aGUgaGVhZHMgYXJyYXk/CgpCdHcgaW4g
dGhlIGNhc2Ugb2YgaW4tb3JkZXIgd2UgZG9uJ3QgbmVlZCB0byByZWNvcmQgdGhlIGhlYWRzLCBp
bnN0ZWFkIAp3ZSBqdXN0IG5lZWQgdG8ga25vdyB0aGUgaGVhZCBvZiB0aGUgbGFzdCBidWZmZXIs
IGl0IHJlZHVjZXMgdGhlIHN0cmVzcyAKb24gdGhlIGNhY2hlLgoKVGhhbmtzCgoKPiArCQl9Cj4g
ICAJCWFkZGVkID0gdHJ1ZTsKPiAgIAl9IHdoaWxlKGxpa2VseSghdmhvc3RfZXhjZWVkc193ZWln
aHQodnEsICsrcGt0cywgdG90YWxfbGVuKSkpOwo+ICAgCj4gKwkvKiBJZiBpbiBvcmRlciBmZWF0
dXJlIG5lZ290aWFnZWQsIHdlIGNhbiBkbyBhIGJhdGNoIHRvIGluY3JlYXNlIHBlcmZvcm1hbmNl
ICovCj4gKwlpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX0lOX09SREVSKSAmJiBh
ZGRlZCkKPiArCQl2aG9zdF9hZGRfdXNlZF9uKHZxLCB2cS0+aGVhZHMsIGFkZCk7Cj4gICBub19t
b3JlX3JlcGxpZXM6Cj4gICAJaWYgKGFkZGVkKQo+ICAgCQl2aG9zdF9zaWduYWwoJnZzb2NrLT5k
ZXYsIHZxKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
