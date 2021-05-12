Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA0C433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 01:21:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898116192A
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 01:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898116192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3889E84503;
	Wed, 12 May 2021 01:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2SOJLx_xJLv; Wed, 12 May 2021 01:21:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD99884572;
	Wed, 12 May 2021 01:21:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 935D2C000D;
	Wed, 12 May 2021 01:21:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B778C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35638400F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:21:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plRWKqRn8W26
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:21:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA02340282
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620782506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQBTeUOnJxVvQe5cf+H0ezJO8F9KLJswaFRFl5Rl3ks=;
 b=c9cBiTzCfMoBl8GW3VvAeobBuekFQq+GSJxkkjUcioYCaF7b0e4MukAwOKStKmjPEGUdnY
 WOz1jNEkTH4m5KThITAh4Yb1jaBdr4yLaYqgYDvMlAvBctMDZAvr8LYDBxKNKR/WjYGS/2
 PaDM5NcVxMAOjJ6xv2swL3erXMWoxjM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-uLUSkkReP8uxz7NJajGkNw-1; Tue, 11 May 2021 21:21:42 -0400
X-MC-Unique: uLUSkkReP8uxz7NJajGkNw-1
Received: by mail-pg1-f200.google.com with SMTP id
 l35-20020a635b630000b029020f1edbc5dfso13314701pgm.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 18:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WQBTeUOnJxVvQe5cf+H0ezJO8F9KLJswaFRFl5Rl3ks=;
 b=JTa4kxSB4ge9pmvXy6W/FOtlKV/fC8cmisLJ9VI85y+YTm6gUpXdpo/Z99SemsHx0Y
 A90vY2rfL9Hi9p0Q1ZlQFnWyDEmm/VibB31LtCr1508laTbfQae8r4Lj5pQEmN2lkTOr
 iKjKZeM7vKLiKtrVon+oBSeYcJP/pgzySdpc9jqZQVcLMkx89bhUYhBQGzUDJ4jzvh7B
 8Vq0dRFAaVmxlHVc8QNl2sMY0rkp7VzrVB6/dPmakQhRx3lPsK7k2ZHiG3dFrUn5FW10
 q1X8snE3fpClNoglj+VQOH40MVFsfJkzQm9RpoMn5fZRFxg1Cw6ToZwM/I8Y+FjH/d/5
 FqiA==
X-Gm-Message-State: AOAM530U6aBnnTzM+KtA5erqVMxvUHZS5vGsQ773iQ3yk0dC28ZwBmVf
 c5af6UFdPxtxhibHX01f5y1PHVhspryihQk8hv6kEDTjtQxDyJK+fDZIICUcFKxFhj7ddHTb9T3
 njRW91m1/2scJQisjFPxembhdMidnn9M/ScW7RZedAg==
X-Received: by 2002:a65:62d7:: with SMTP id m23mr33812945pgv.244.1620782501822; 
 Tue, 11 May 2021 18:21:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjIxWtZRQoYRS6HSFMlqpYwjeopoTbiSUnpPPoiu9LAwL9NQs+qfYYo/83LXGoLG2nOAsGDQ==
X-Received: by 2002:a65:62d7:: with SMTP id m23mr33812932pgv.244.1620782501503; 
 Tue, 11 May 2021 18:21:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id gm17sm14533127pjb.11.2021.05.11.18.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 18:21:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To: Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com>
 <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
 <CAOEp5OdgYtP+W1thGsTGnvEPWrJ02s1HemskQpnMTUyYbsX4jQ@mail.gmail.com>
 <CACGkMEuk3-iP+AxsvhT16t+5dXXtVMGoWPovM=Msm0kvo3LR2Q@mail.gmail.com>
 <CAOEp5OfAEb4=C7GK_EJvJnoTTk-ebdg0RygShPwbn3O67ucQ2Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b6ccd865-deec-47e1-df19-c10fd8ee107f@redhat.com>
Date: Wed, 12 May 2021 09:21:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOEp5OfAEb4=C7GK_EJvJnoTTk-ebdg0RygShPwbn3O67ucQ2Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzUvMTEg5LiL5Y2INToyMSwgWXVyaSBCZW5kaXRvdmljaCDlhpnpgZM6Cj4gT24g
VHVlLCBNYXkgMTEsIDIwMjEgYXQgMTE6MjQgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0IDQ6MTIgUE0gWXVyaSBCZW5k
aXRvdmljaAo+PiA8eXVyaS5iZW5kaXRvdmljaEBkYXluaXguY29tPiB3cm90ZToKPj4+IE9uIFR1
ZSwgTWF5IDExLCAyMDIxIGF0IDk6NDcgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+Pj4KPj4+PiDlnKggMjAyMS81LzExIOS4i+WNiDEyOjQyLCBZdXJpIEJlbmRp
dG92aWNoIOWGmemBkzoKPj4+Pj4gRGVmaW5lIGZlYXR1cmUgYml0IGFuZCBHU08gdHlwZSBhY2Nv
cmRpbmcgdG8gdGhlIFZJUlRJTwo+Pj4+PiBzcGVjaWZpY2F0aW9uLgo+Pj4+Pgo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBZdXJpIEJlbmRpdG92aWNoIDx5dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20+
Cj4+Pj4+IC0tLQo+Pj4+PiAgICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIHwgMiAr
Kwo+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Pj4+Cj4+Pj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19uZXQuaAo+Pj4+PiBpbmRleCAzZjU1YTQyMTVmMTEuLmE1NTZhYzczNWQ3
ZiAxMDA2NDQKPj4+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaAo+Pj4+
PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4+Pj4+IEBAIC01Nyw2ICs1
Nyw3IEBACj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIFN0
ZWVyaW5nICovCj4+Pj4+ICAgICNkZWZpbmUgVklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIgMjMg
ICAgICAgLyogU2V0IE1BQyBhZGRyZXNzICovCj4+Pj4+Cj4+Pj4+ICsjZGVmaW5lIFZJUlRJT19O
RVRfRl9IT1NUX1VTTyAgICAgNTYgLyogSG9zdCBjYW4gaGFuZGxlIFVTTyBwYWNrZXRzICovCj4+
PiBUaGlzIGlzIHRoZSB2aXJ0aW8tbmV0IGZlYXR1cmUKPj4gUmlnaHQsIEkgbWlzcyB0aGlzIHBh
cnQuCj4+Cj4+Pj4+ICAgICNkZWZpbmUgVklSVElPX05FVF9GX0hBU0hfUkVQT1JUICA1NyAgICAg
ICAgLyogU3VwcG9ydHMgaGFzaCByZXBvcnQgKi8KPj4+Pj4gICAgI2RlZmluZSBWSVJUSU9fTkVU
X0ZfUlNTICAgICAgNjAgICAgLyogU3VwcG9ydHMgUlNTIFJYIHN0ZWVyaW5nICovCj4+Pj4+ICAg
ICNkZWZpbmUgVklSVElPX05FVF9GX1JTQ19FWFQgICAgICAgICAgNjEgICAgLyogZXh0ZW5kZWQg
Y29hbGVzY2luZyBpbmZvICovCj4+Pj4+IEBAIC0xMzAsNiArMTMxLDcgQEAgc3RydWN0IHZpcnRp
b19uZXRfaGRyX3YxIHsKPj4+Pj4gICAgI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fVENQVjQg
ICAgMSAgICAgICAvKiBHU08gZnJhbWUsIElQdjQgVENQIChUU08pICovCj4+Pj4+ICAgICNkZWZp
bmUgVklSVElPX05FVF9IRFJfR1NPX1VEUCAgICAgICAgICAgICAgMyAgICAgICAvKiBHU08gZnJh
bWUsIElQdjQgVURQIChVRk8pICovCj4+Pj4+ICAgICNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NP
X1RDUFY2ICAgIDQgICAgICAgLyogR1NPIGZyYW1lLCBJUHY2IFRDUCAqLwo+Pj4+PiArI2RlZmlu
ZSBWSVJUSU9fTkVUX0hEUl9HU09fVURQX0w0ICAgIDUgICAgICAgLyogR1NPIGZyYW1lLCBJUHY0
IFVEUCAoVVNPKSAqLwo+Pj4gVGhpcyBpcyByZXNwZWN0aXZlIEdTTyB0eXBlCj4+Pgo+Pj4+Cj4+
Pj4gVGhpcyBpcyB0aGUgZ3NvX3R5cGUgbm90IHRoZSBmZWF0dXJlIGFjdHVhbGx5Lgo+Pj4+Cj4+
Pj4gSSB3b25kZXIgd2hhdCdzIHRoZSByZWFzb24gZm9yIG5vdAo+Pj4+Cj4+Pj4gMSkgaW50cm9k
dWNpbmcgYSBkZWRpY2F0ZWQgdmlydGlvLW5ldCBmZWF0dXJlIGJpdCBmb3IgdGhpcwo+Pj4+IChW
SVJUSU9fTkVUX0ZfR1VFU1RfR1NPX1VEUF9MNC4KPj4+IFRoaXMgc2VyaWVzIGlzIG5vdCBmb3Ig
R1VFU1QncyBmZWF0dXJlLCBpdCBpcyBvbmx5IGZvciBob3N0IGZlYXR1cmUuCj4+Pgo+Pj4+IDIp
IHRvZ2dsZSB0aGUgTkVUSUZfRl9HU09fVURQX0w0ICBmZWF0dXJlIGZvciB0dW50YXAgYmFzZWQg
b24gdGhlCj4+Pj4gbmVnb3RpYXRlZCBmZWF0dXJlLgo+Pj4gVGhlIE5FVElGX0ZfR1NPX1VEUF9M
NCB3b3VsZCBiZSByZXF1aXJlZCBmb3IgdGhlIGd1ZXN0IFJYIHBhdGguCj4+PiBUaGUgZ3Vlc3Qg
VFggcGF0aCBkb2VzIG5vdCByZXF1aXJlIGFueSBmbGFncyB0byBiZSBwcm9wYWdhdGVkLCBpdCBv
bmx5Cj4+PiBhbGxvd3MgdGhlIGd1ZXN0IHRvIHRyYW5zbWl0IGxhcmdlIFVEUCBwYWNrZXRzIGFu
ZCBoYXZlIHRoZW0KPj4+IGF1dG9tYXRpY2FsbHkgc3BsaXR0ZWQuCj4+PiAoVGhpcyBpcyBzaW1p
bGFyIHRvIEhPU1RfVUZPIGJ1dCBkb2VzIHBhY2tldCBzZWdtZW50YXRpb24gaW5zdGVhZCBvZgo+
Pj4gZnJhZ21lbnRhdGlvbi4gR1VFU1RfVUZPIGluZGVlZCByZXF1aXJlcyBhIHJlc3BlY3RpdmUg
TkVUSUYgZmxhZywgYXMKPj4+IGl0IGlzIHVuY2xlYXIgd2hldGhlciB0aGUgZ3Vlc3QgaXMgY2Fw
YWJsZSBvZiByZWNlaXZpbmcgc3VjaCBwYWNrZXRzKS4KPj4gU28gSSB0aGluayBpdCdzIGJldHRl
ciB0byBpbXBsZW1lbnQgVFgvUlggaW4gdGhlIHNhbWUgc2VyaWVzIHVubGVzcwo+PiB0aGVyZSdz
IHNvbWV0aGluZyBtaXNzZWQ6Cj4+Cj4+IEZvciBHdWVzdCBUWCwgTkVUSUZfRl9HU09fVURQX0w0
IG5lZWRzIHRvIGJlIGVuYWJsZWQgaW4gdGhlIGd1ZXN0Cj4+IHZpcnRpby1uZXQgb25seSB3aGVu
IFZJUlRJT19ORVRfRl9IT1NUX1VTTyBpcyBuZWdvdGlhdGVkLgo+IEkgdW5kZXJzdGFuZCB0aGF0
IHRoaXMgaXMgd2hhdCBzaG91bGQgYmUgZG9uZSB3aGVuIHRoaXMgZmVhdHVyZSB3aWxsCj4gYmUg
YWRkZWQgdG8gTGludXggdmlydGlvLW5ldCBkcml2ZXIuCj4gQnV0IGF0IHRoZSBtb21lbnQgd2Ug
ZG8gbm90IGhhdmUgZW5vdWdoIHJlc291cmNlcyB0byB3b3JrIG9uIGl0Lgo+IEN1cnJlbnRseSB3
ZSBoYXZlIGEgY2xlYXIgdXNlIGNhc2UgYW5kIGFiaWxpdHkgdG8gdGVzdCBpbiBvbiBXaW5kb3dz
IGd1ZXN0Lgo+IFJlc3BlY3RpdmUgUUVNVSBjaGFuZ2VzIGFyZSBwZW5kaW5nIGZvciBrZXJuZWwg
cGF0Y2hlcywgY3VycmVudAo+IHJlZmVyZW5jZSBpcyBodHRwczovL2dpdGh1Yi5jb20vZGF5bml4
L3FlbXUvdHJlZS91c28KCgpUaGlzIGxvb2tzIGZpbmUgYnV0IGFzIHJlcGxpZWQgaW4gYW5vdGhl
ciB0aHJlYWQuCgpXZSBjYW4gdGVzdCBib3RoIFRYIGFuZCBSWCB3aXRoIExpbnV4IGd1ZXN0cyBz
aW1wbHk6CgpXZSBjYW4ganVzdCB1c2UgMiBWTXMsIGFuZCBsZXQgb25lIFZNIHNlbmQgR1NPX1VE
UF9MNCBwYWNrZXQgdG8gYW5vdGhlciwgCnRoZW4gYm90aCB0eCBhbmQgcnggaW4gYm90aCBndWVz
dCAodmlydGlvLW5ldCkgYW5kIGhvc3QgKHZpcnRpby1uZXQpIGFyZSAKdGVzdGVkPwoKVGhhbmtz
CgoKPgo+PiBGb3IgZ3Vlc3QgUlgsIE5FVElGX0ZfR1NPX1VEUF9MNCBuZWVkcyB0byBiZSBlbmFi
bGVkIG9uIHRoZSBob3N0Cj4+IHR1bnRhcCBvbmx5IHdoZW4gVklSVElPX05FVF9GX0dVRVNUX1VT
TyBpcyBuZW9naWF0ZWQuCj4gQ3VycmVudGx5IHdlIGFyZSBub3QgYWJsZSB0byB1c2UgZ3Vlc3Qg
UlggVURQIEdTTy4KPiBJbiBvcmRlciB0byBkbyB0aGF0IHdlIGF0IGxlYXN0IHNob3VsZCBiZSBh
YmxlIHRvIGJ1aWxkIG91ciBXaW5kb3dzCj4gZHJpdmVycyB3aXRoIHRoZSBtb3N0IHVwZGF0ZWQg
ZHJpdmVyIGRldmVsb3BtZW50IGtpdCAoMjAwNCspLgo+IEF0IHRoZSBtb21lbnQgd2UgY2FuJ3Qs
IHRoaXMgdGFzayBpcyBpbiBhIHBsYW4gYnV0IGNhbiB0YWtlIHNldmVyYWwKPiBtb250aHMuIFNv
IHdlIGRvIG5vdCBoYXZlIGEgdGVzdC91c2UgY2FzZSB3aXRoIFdpbmRvd3MgVk0uCj4KPgo+PiBU
aGFua3MKPj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cj4+Pj4+ICAgICNkZWZpbmUgVklSVElPX05F
VF9IRFJfR1NPX0VDTiAgICAgICAgICAgICAgMHg4MCAgICAvKiBUQ1AgaGFzIEVDTiBzZXQgKi8K
Pj4+Pj4gICAgICAgIF9fdTggZ3NvX3R5cGU7Cj4+Pj4+ICAgICAgICBfX3ZpcnRpbzE2IGhkcl9s
ZW47ICAgICAvKiBFdGhlcm5ldCArIElQICsgdGNwL3VkcCBoZHJzICovCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
