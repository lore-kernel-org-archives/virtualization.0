Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1FC4338F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 07:12:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8D3610A0
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 07:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA8D3610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 939FA83267;
	Thu,  5 Aug 2021 07:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8DbLLIMQkn5K; Thu,  5 Aug 2021 07:12:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 452CA8332A;
	Thu,  5 Aug 2021 07:12:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F359C0010;
	Thu,  5 Aug 2021 07:12:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3A5C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0FDDC403AF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1zqCREAns7ys
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:12:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BBDF401EC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 07:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628147573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0VxlG+I9DtspBlzYcgwvjsV5zD4hYtPEcF5uDUSb8k=;
 b=bFXCHAqtxHv+9hYnFqAy/ZCG3DnyogXmnF9K075McnmQb6Ld+PvZkCLdRFA3sOPIFFYPMk
 mE1Z9iKt3XTMyNL8OZSMGvuWbbRtzk3ACem1WufjCS4gdl+N4IoT7QY4uqEyYJXQA4g2Po
 jpdCCYigL3WUOyUzFiAr9iUOBkQS3Oc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-j7-9zmsdNW6ZcXQ3hZfBmA-1; Thu, 05 Aug 2021 03:12:49 -0400
X-MC-Unique: j7-9zmsdNW6ZcXQ3hZfBmA-1
Received: by mail-pl1-f198.google.com with SMTP id
 u6-20020a170902bf46b029012c971d6226so4026191pls.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 00:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=n0VxlG+I9DtspBlzYcgwvjsV5zD4hYtPEcF5uDUSb8k=;
 b=aceVecswLEI3xNvedZ4YEfFNzTSS4e1aX3CNDI64XQUILsxyiAoxwGzXeeok9udWm2
 9+AY8jci5YHN3mSluyQejvKnT3Ll3I2/FzpP9UTAqcnJ4tQGZL+H5ytuZcvnb9IjfDp3
 Ste8s03esHl4YDc4YWvt1hoX8AJ/3OzJxTdLAF04WW/kEm6ErNeRLu5HtGx+AMC3JRg1
 9oVIh0E6qd5hAh0w+L5ltWF489j7x+WUUJBd85cMVStMhuUCwqOSxhvHxX+Cp1hIiwra
 zZbpP2CKUHqLYf+b3FD3QlSVVi21pFcHvJCryGDQZ3dUBQvb0tKIUkMpvlU9hwAOAayq
 KPHA==
X-Gm-Message-State: AOAM533hokUZ8xCa5qqHAsTyuzkRWw8/5e0QR5GIYwjKbM0TPeUXWeXu
 4jT1aEomLE6JG+/Hb4U30poLdyWvGHf+Z4UZtg+m6/8GagpWFrDbeg+Znzst+UrSblIPjOZGk9G
 rsLS5kISHaEkSyi74fNy2Oxl7taDzv0V3aBIkYNXrfQ==
X-Received: by 2002:a63:190b:: with SMTP id z11mr654570pgl.320.1628147568793; 
 Thu, 05 Aug 2021 00:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUfHRxG/dXx9YH24cRrMopBNWNIkigiB28PNmXNoiyFNr8yDY8zBJY64Y2tGLqmxO/3wI2WA==
X-Received: by 2002:a63:190b:: with SMTP id z11mr654537pgl.320.1628147568588; 
 Thu, 05 Aug 2021 00:12:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k8sm5028086pfu.116.2021.08.05.00.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 00:12:48 -0700 (PDT)
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
 <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
 <CACycT3v7BHxYY0OFYJRFU41Bz1=_v8iMRwzYKgX6cJM-SiNH+A@mail.gmail.com>
 <fdcb0224-11f9-caf2-a44e-e6406087fd50@redhat.com>
 <CACycT3v0EQVrv_A1K1bKmiYu0q5aFE=t+0yRaWKC7T3_H3oB-Q@mail.gmail.com>
 <bd48ec76-0d5c-2efb-8406-894286b28f6b@redhat.com>
 <CACycT3tUwJXUV24PK7OvzPrHYYeQ5Q3qUW_vbuFMjwig0dBw2g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ae529e8a-67a2-b235-1404-4623d57031d6@redhat.com>
Date: Thu, 5 Aug 2021 15:12:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tUwJXUV24PK7OvzPrHYYeQ5Q3qUW_vbuFMjwig0dBw2g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzgvNCDkuIvljYg1OjA3LCBZb25namkgWGllIOWGmemBkzoKPiBPbiBXZWQsIEF1
ZyA0LCAyMDIxIGF0IDQ6NTQgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IOWcqCAyMDIxLzgvNCDkuIvljYg0OjUwLCBZb25namkgWGllIOWGmemBkzoKPj4+
IE9uIFdlZCwgQXVnIDQsIDIwMjEgYXQgNDozMiBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS84LzMg5LiL5Y2INTozOCwgWW9uZ2ppIFhpZSDl
hpnpgZM6Cj4+Pj4+IE9uIFR1ZSwgQXVnIDMsIDIwMjEgYXQgNDowOSBQTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IOWcqCAyMDIxLzcvMjkg5LiL5Y2IMzoz
NCwgWGllIFlvbmdqaSDlhpnpgZM6Cj4+Pj4+Pj4gVGhlIGRldmljZSByZXNldCBtYXkgZmFpbCBp
biB2aXJ0aW8tdmRwYSBjYXNlIG5vdywgc28gYWRkIGNoZWNrcyB0bwo+Pj4+Pj4+IGl0cyByZXR1
cm4gdmFsdWUgYW5kIGZhaWwgdGhlIHJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoKS4KPj4+Pj4+IFNv
IHRoZSByZXNldCgpIHdvdWxkIGJlIGNhbGxlZCBieSB0aGUgZHJpdmVyIGR1cmluZyByZW1vdmUg
YXMgd2VsbCwgb3IKPj4+Pj4+IGlzIGl0IHN1ZmZpY2llbnQgdG8gZGVhbCBvbmx5IHdpdGggdGhl
IHJlc2V0IGR1cmluZyBwcm9iZT8KPj4+Pj4+Cj4+Pj4+IEFjdHVhbGx5IHRoZXJlIGlzIG5vIHdh
eSB0byBoYW5kbGUgZmFpbHVyZSBkdXJpbmcgcmVtb3ZhbC4gQW5kIGl0Cj4+Pj4+IHNob3VsZCBi
ZSBzYWZlIHdpdGggdGhlIHByb3RlY3Rpb24gb2Ygc29mdHdhcmUgSU9UTEIgZXZlbiBpZiB0aGUK
Pj4+Pj4gcmVzZXQoKSBmYWlscy4KPj4+Pj4KPj4+Pj4gVGhhbmtzLAo+Pj4+PiBZb25namkKPj4+
PiBJZiB0aGlzIGlzIHRydWUsIGRvZXMgaXQgbWVhbiB3ZSBkb24ndCBldmVuIG5lZWQgdG8gY2Fy
ZSBhYm91dCByZXNldAo+Pj4+IGZhaWx1cmU/Cj4+Pj4KPj4+IEJ1dCB3ZSBuZWVkIHRvIGhhbmRs
ZSB0aGUgZmFpbHVyZSBpbiB0aGUgdmhvc3QtdmRwYSBjYXNlLCBpc24ndCBpdD8KPj4KPj4gWWVz
LCBidXQ6Cj4+Cj4+IC0gVGhpcyBwYXRjaCBpcyBmb3IgdmlydGlvIG5vdCBmb3Igdmhvc3QsIGlm
IHdlIGRvbid0IGNhcmUgdmlydGlvLCB3ZQo+PiBjYW4gYXZvaWQgdGhlIGNoYW5nZXMKPj4gLSBG
b3Igdmhvc3QsIHRoZXJlIGNvdWxkIGJlIHR3byB3YXlzIHByb2JhYmx5Ogo+Pgo+PiAxKSBsZXQg
dGhlIHNldF9zdGF0dXMgdG8gcmVwb3J0IGVycm9yCj4+IDIpIHJlcXVpcmUgdXNlcnNwYWNlIHRv
IHJlLXJlYWQgZm9yIHN0YXR1cwo+Pgo+PiBJdCBsb29rcyB0byBtZSB5b3Ugd2FudCB0byBnbyB3
aXRoIDEpIGFuZCBJJ20gbm90IHN1cmUgd2hldGhlciBvciBub3QKPj4gaXQncyB0b28gbGF0ZSB0
byBnbyB3aXRoIDIpLgo+Pgo+IExvb2tzIGxpa2UgMikgY2FuJ3Qgd29yayBpZiByZXNldCBmYWls
dXJlIGhhcHBlbnMgaW4KPiB2aG9zdF92ZHBhX3JlbGVhc2UoKSBhbmQgdmhvc3RfdmRwYV9vcGVu
KCkuCgoKWWVzLCB5b3UncmUgcmlnaHQuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
