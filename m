Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CF2ECAAD3
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 02:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66EA341086;
	Thu,  8 Sep 2022 02:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66EA341086
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LD1XTlH6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNJRqr25qRvq; Thu,  8 Sep 2022 02:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BFFD14107E;
	Thu,  8 Sep 2022 02:21:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFFD14107E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CE5CC0033;
	Thu,  8 Sep 2022 02:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4DCCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 02:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA811418CD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 02:21:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA811418CD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LD1XTlH6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veNzM575Q4xM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 02:21:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18B64418B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18B64418B0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 02:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662603714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iT5k9dnvMqT2ZKkMTuSIzNcN6Xuwb0rz4A/0JhBTSpk=;
 b=LD1XTlH6xG7R+OFttH9IqoH3J14DrHmR+l9wgJ5AqhFJTv5VBKn8M6KX9DdE6KHEN0/fTn
 MMFm8SIxcT/CH8T/aIW8VsGPtI22gqoSLmAE3xweP6G35mmpn3hCCcjZDXMrsVH+wHpbqi
 P9CRamAMyjuYUQ2l6rgqxn23bUKb5gQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18-WiREAr32MCq_tKI85LRGow-1; Wed, 07 Sep 2022 22:21:53 -0400
X-MC-Unique: WiREAr32MCq_tKI85LRGow-1
Received: by mail-pf1-f200.google.com with SMTP id
 z36-20020a056a001da400b005386b23cf15so8447345pfw.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 19:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=iT5k9dnvMqT2ZKkMTuSIzNcN6Xuwb0rz4A/0JhBTSpk=;
 b=XDTX9LWrRax1psAoGtpfb9qhL9fnFt2gkzPDQPImnIlLpbz9o2mQHtZDz4ivbQ5mC/
 eZKbuaTfsTjc5ncOnT3GYBtozvRPy5yrKkCVX4xhwfYQ0x4Exs4PH0jfP2nxDBJU2/2m
 tKt9i7O8yIDjQldb9OQOdAn1Nf8qdpw+TYY+YQzhMpr6U6JBd3jXiXsJaENCeG786WWJ
 OY8bsTxmyMMYUEwarzXoKv9CznCV58Ek4nSbXSfElKvKHcHE0ITNiyVLNKy8G0by+pfe
 by1WijWiLpEKWNZWKo99Mr4cuInh/aYcUC33YhkPkYY5OEmfdI+EQrCOpw3y1V4i240E
 CCJA==
X-Gm-Message-State: ACgBeo2J08rPUX+XiJWHemLf9NiUm4PeGJxmiUo1RJ9oR6W/GmD5JpA6
 RlYiZxr9erEIO4lSvu3+gtXlvYM8jOmy5jzCe5o4eBYbGj9KaBEzeafxOSfKL/Qmo2hu/2V8sul
 SkRAadNYh/Yqtummh4iZ9ZT4WuG9o8ACsiOTmSB7D2w==
X-Received: by 2002:a05:6a00:1354:b0:53a:80d6:6f61 with SMTP id
 k20-20020a056a00135400b0053a80d66f61mr6754058pfu.69.1662603712090; 
 Wed, 07 Sep 2022 19:21:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7yzCmsVxrO0fzQppdwR2AxZWE75JALnDLDP+OsSK9OgJk/Tzw9u6zw5XxVbH4qF7F3wx2wQg==
X-Received: by 2002:a05:6a00:1354:b0:53a:80d6:6f61 with SMTP id
 k20-20020a056a00135400b0053a80d66f61mr6754042pfu.69.1662603711816; 
 Wed, 07 Sep 2022 19:21:51 -0700 (PDT)
Received: from [10.72.13.192] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a17090a294900b002005114fbf5sm401322pjf.22.2022.09.07.19.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Sep 2022 19:21:50 -0700 (PDT)
Message-ID: <d32101bb-783f-dbd1-545a-be291c27cb63@redhat.com>
Date: Thu, 8 Sep 2022 10:21:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command waiting
 loop
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
 <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
 <20220907034407-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220907034407-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, davem <davem@davemloft.net>
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

CuWcqCAyMDIyLzkvNyAxNTo0NiwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBPbiBXZWQs
IFNlcCAwNywgMjAyMiBhdCAwOTowNzoyMEFNICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToKPj4g
T24gV2VkLCAyMDIyLTA5LTA3IGF0IDEwOjA5ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4g
T24gVHVlLCBTZXAgNiwgMjAyMiBhdCA2OjU2IFBNIFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+Pj4gT24gTW9uLCAyMDIyLTA5LTA1IGF0IDE1OjQ5ICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+Pj4+PiBPbiBNb24sIFNlcCA1LCAyMDIyIGF0IDM6MTUgUE0gTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiBNb24sIFNlcCAw
NSwgMjAyMiBhdCAxMjo1Mzo0MVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+IEFk
ZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxvb3AgZm9yIGEgYmV0
dGVyCj4+Pj4+Pj4gY28tb3BlcmF0aW9uIHdpdGggdGhlIHNjaGVkdWxlci4gVGhpcyBhbGxvd3Mg
dG8gZ2l2ZSBDUFUgYSBicmVhdGggdG8KPj4+Pj4+PiBydW4gb3RoZXIgdGFzayh3b3JrcXVldWUp
IGluc3RlYWQgb2YgYnVzeSBsb29waW5nIHdoZW4gcHJlZW1wdGlvbiBpcwo+Pj4+Pj4+IG5vdCBh
bGxvd2VkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gV2hhdCdzIG1vcmUgaW1wb3J0YW50LiBUaGlzIGlzIGEg
bXVzdCBmb3Igc29tZSB2RFBBIHBhcmVudCB0byB3b3JrCj4+Pj4+Pj4gc2luY2UgY29udHJvbCB2
aXJ0cXVldWUgaXMgZW11bGF0ZWQgdmlhIGEgd29ya3F1ZXVlIGZvciB0aG9zZSBwYXJlbnRzLgo+
Pj4+Pj4+Cj4+Pj4+Pj4gRml4ZXM6IGJkYTMyNGZkMDM3YSAoInZkcGFzaW06IGNvbnRyb2wgdmly
dHF1ZXVlIHN1cHBvcnQiKQo+Pj4+Pj4gVGhhdCdzIGEgd2VpcmQgY29tbWl0IHRvIGZpeC4gc28g
aXQgZml4ZXMgdGhlIHNpbXVsYXRvcj8KPj4+Pj4gWWVzLCBzaW5jZSB0aGUgc2ltdWxhdG9yIGlz
IHVzaW5nIGEgd29ya3F1ZXVlIHRvIGhhbmRsZSBjb250cm9sIHZpcnR1ZXVlLgo+Pj4+IFVobW0u
Li4gdG91Y2hpbmcgYSBkcml2ZXIgZm9yIGEgc2ltdWxhdG9yJ3Mgc2FrZSBsb29rcyBhIGxpdHRs
ZSB3ZWlyZC4KPj4+IFNpbXVsYXRvciBpcyBub3QgdGhlIG9ubHkgb25lIHRoYXQgaXMgdXNpbmcg
YSB3b3JrcXVldWUgKGJ1dCBzaG91bGQgYmUKPj4+IHRoZSBmaXJzdCkuCj4+Pgo+Pj4gSSBjYW4g
c2VlICB0aGF0IHRoZSBtbHg1IHZEUEEgZHJpdmVyIGlzIHVzaW5nIGEgd29ya3F1ZXVlIGFzIHdl
bGwgKHNlZQo+Pj4gbWx4NV92ZHBhX2tpY2tfdnEoKSkuCj4+Pgo+Pj4gQW5kIGluIHRoZSBjYXNl
IG9mIFZEVVNFLCBpdCBuZWVkcyB0byB3YWl0IGZvciB0aGUgcmVzcG9uc2UgZnJvbSB0aGUKPj4+
IHVzZXJzcGFjZSwgdGhpcyBtZWFucyBjb25kX3Jlc2NoZWQoKSBpcyBwcm9iYWJseSBhIG11c3Qg
Zm9yIHRoZSBjYXNlCj4+PiBsaWtlIFVQLgo+Pj4KPj4+PiBBZGRpdGlvbmFsbHksIGlmIHRoZSBi
dWcgaXMgdmRwYXNpbSwgSSB0aGluayBpdCdzIGJldHRlciB0byB0cnkgdG8KPj4+PiBzb2x2ZSBp
dCB0aGVyZSwgaWYgcG9zc2libGUuCj4+Pj4KPj4+PiBMb29raW5nIGF0IHZkcGFzaW1fbmV0X3dv
cmsoKSBhbmQgdmRwYXNpbV9ibGtfd29yaygpIGl0IGxvb2tzIGxpa2UKPj4+PiBuZWl0aGVyIG5l
ZWRzIGEgcHJvY2VzcyBjb250ZXh0LCBzbyBwZXJoYXBzIHlvdSBjb3VsZCByZXdvcmsgaXQgdG8g
cnVuCj4+Pj4gdGhlIHdvcmtfZm4oKSBkaXJlY3RseSBmcm9tIHZkcGFzaW1fa2lja192cSgpLCBh
dCBsZWFzdCBmb3IgdGhlIGNvbnRyb2wKPj4+PiB2aXJ0cXVldWU/Cj4+PiBJdCdzIHBvc3NpYmxl
IChidXQgcmVxdWlyZSBzb21lIHJld29yayBvbiB0aGUgc2ltdWxhdG9yIGNvcmUpLiBCdXQKPj4+
IGNvbnNpZGVyaW5nIHdlIGhhdmUgb3RoZXIgc2ltaWxhciB1c2UgY2FzZXMsIGl0IGxvb2tzIGJl
dHRlciB0byBzb2x2ZQo+Pj4gaXQgaW4gdGhlIHZpcnRpby1uZXQgZHJpdmVyLgo+PiBJIHNlZS4K
Pj4KPj4+IEFkZGl0aW9uYWxseSwgdGhpcyBtYXkgaGF2ZSBiZXR0ZXIgYmVoYXZpb3VyIHdoZW4g
dXNpbmcgZm9yIHRoZSBidWdneQo+Pj4gaGFyZHdhcmUgKGUuZyB0aGUgY29udHJvbCB2aXJ0cXVl
dWUgdGFrZXMgdG9vIGxvbmcgdG8gcmVzcG9uZCkuIFdlIG1heQo+Pj4gY29uc2lkZXIgc3dpdGNo
aW5nIHRvIHVzZSBpbnRlcnJ1cHQvc2xlZXAgaW4gdGhlIGZ1dHVyZSAoYnV0IG5vdAo+Pj4gc3Vp
dGFibGUgZm9yIC1uZXQpLgo+PiBBZ3JlZWQuIFBvc3NpYmx5IGEgdGltZW91dCBjb3VsZCBiZSB1
c2VmdWwsIHRvby4KPj4KPj4gQ2hlZXJzLAo+Pgo+PiBQYW9sbwo+Cj4gSG1tIHRpbWVvdXRzIGFy
ZSBraW5kIG9mIGFyYml0cmFyeS4KPiByZWd1bGFyIGRyaXZlcnMgYmFzaWNhbGx5IGRlcml2ZSB0
aGVtIGZyb20gaGFyZHdhcmUKPiBiZWhhdmlvdXIgYnV0IHdpdGggYSBnZW5lcmljIGRyaXZlciBs
aWtlIHZpcnRpbyBpdCdzIGhhcmRlci4KPiBJIGd1ZXNzIHdlIGNvdWxkIGFkZCB0aW1lb3V0IGFz
IGEgY29uZmlnIGZpZWxkLCBoYXZlCj4gZGV2aWNlIG1ha2UgYSBwcm9taXNlIHRvIHRoZSBkcml2
ZXIuCj4KPiBNYWtpbmcgdGhlIHdhaXQgaW50ZXJydXB0aWJsZSBzZWVtcyBtb3JlIHJlYXNvbmFi
bGUuCgoKWWVzLCBidXQgSSB0aGluayB3ZSBzdGlsbCBuZWVkIHRoaXMgcGF0Y2ggZm9yIC1uZXQg
YW5kIC1zdGFibGUuCgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
