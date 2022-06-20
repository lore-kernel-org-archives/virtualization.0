Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58997C433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 03:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B68A660E72;
	Mon, 20 Jun 2022 03:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B68A660E72
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=engERVEp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORDZiPgZPepG; Mon, 20 Jun 2022 03:34:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86C1660ABE;
	Mon, 20 Jun 2022 03:34:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86C1660ABE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F298C0032;
	Mon, 20 Jun 2022 03:34:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7273BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 03:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38CA660E72
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 03:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38CA660E72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wcVurrznbiwV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 03:34:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7033F60ABE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7033F60ABE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 03:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655696064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfwEK1sq7rdGyo7PvaKmvL8otVhWygQzLxR6ANVD3rU=;
 b=engERVEp4IuWjDkmM87RS7B/er3Kw1f69Vf9wbtfYVKMESWU/0PCiMh+O6L8w6VW6GuKto
 K11sw1xn9phVNrJQzDbvhbYU/BJatfo8Otpg0NSPRyAz96R+UviXRD1DN5q/LLbZfmRjxh
 p5TebB6kt/bgad7ZF/g4jbZ+G+nuCcQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-bq5slzzTNcGDmmty99CRzw-1; Sun, 19 Jun 2022 23:34:15 -0400
X-MC-Unique: bq5slzzTNcGDmmty99CRzw-1
Received: by mail-pg1-f200.google.com with SMTP id
 194-20020a6307cb000000b0040c7d803242so2685227pgh.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Jun 2022 20:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dfwEK1sq7rdGyo7PvaKmvL8otVhWygQzLxR6ANVD3rU=;
 b=M83eEP1QnL5GyWQhK3on+VkLs5LjxduPLkAIpzW787skhv5hT0GQY5abn+Tu73N3RU
 QAkT6rIxpqWpu1oKYpJ0QnWmZyp3cJYyNqCaWi2QuaPZtYhmnezWBcas9dy9Ovm+HtiV
 Wzfm/21Q9jGrvUaWloYe0xxPQbQ/0rWe5Y3CXvCX58AdZ6c1543VvYTyiaFGeQTwU249
 JiWzkoJ6fEjMR1DFSS4WfiLvdfOV5FmvszABnthVpkftv6VSjGw7n3sYVhekYnc6x85A
 KjKfc2hVENv31pRnFOY9gZDd2DWublOdWj3cq0lJvuWtfFPgZddY+1ldi40JVIE/0k+B
 J73A==
X-Gm-Message-State: AJIora95aU2uLU4oOTCIu4tTzIKwzhS5nIB8vFd0Fkb/tigswkVOxqtM
 fuMvhV6xaadSdSgUZDikHQxVDyjiuQS9wGHbCWi+Zp6TbidYXeYZEEm/41RXYFlDa62MdWiow1C
 H9VR7/S6nkXxTprFfWOni72js/LM/RroOlmmMuO7bqg==
X-Received: by 2002:a05:6a00:170b:b0:51b:d1fd:5335 with SMTP id
 h11-20020a056a00170b00b0051bd1fd5335mr22346551pfc.28.1655696054175; 
 Sun, 19 Jun 2022 20:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uYN9VMFAa2HlkmqX/qFWqSRenF42IdfOZYHLpfaUTJHe10i9fpjJMcSHXQutXOkNBszTIlmw==
X-Received: by 2002:a05:6a00:170b:b0:51b:d1fd:5335 with SMTP id
 h11-20020a056a00170b00b0051bd1fd5335mr22346531pfc.28.1655696053829; 
 Sun, 19 Jun 2022 20:34:13 -0700 (PDT)
Received: from [10.72.12.16] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a170902710100b001634d581adfsm7383215pll.157.2022.06.19.20.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jun 2022 20:34:13 -0700 (PDT)
Message-ID: <78d6d295-4694-c2db-5689-f0e366da9a07@redhat.com>
Date: Mon, 20 Jun 2022 11:34:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220617072949.30734-1-jasowang@redhat.com>
 <20220617060632-mutt-send-email-mst@kernel.org>
 <CACGkMEtTVs5W+qqt9Z6BcorJ6wcqcnSVuCBrHrLZbbKzG-7ULQ@mail.gmail.com>
 <20220617083141-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220617083141-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
 davem <davem@davemloft.net>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIyLzYvMTcgMjA6MzIsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gRnJp
LCBKdW4gMTcsIDIwMjIgYXQgMDc6NDY6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
T24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgNjoxMyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPj4+IE9uIEZyaSwgSnVuIDE3LCAyMDIyIGF0IDAzOjI5OjQ5UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4gV2UgdXNlZCB0byBjYWxsIHZpcnRpb19kZXZp
Y2VfcmVhZHkoKSBhZnRlciBuZXRkZXYgcmVnaXN0cmF0aW9uLiBUaGlzCj4+Pj4gY2F1c2UgYSBy
YWNlIGJldHdlZW4gbmRvX29wZW4oKSBhbmQgdmlydGlvX2RldmljZV9yZWFkeSgpOiBpZgo+Pj4+
IG5kb19vcGVuKCkgaXMgY2FsbGVkIGJlZm9yZSB2aXJ0aW9fZGV2aWNlX3JlYWR5KCksIHRoZSBk
cml2ZXIgbWF5Cj4+Pj4gc3RhcnQgdG8gdXNlIHRoZSBkZXZpY2UgYmVmb3JlIERSSVZFUl9PSyB3
aGljaCB2aW9sYXRlcyB0aGUgc3BlYy4KPj4+Pgo+Pj4+IEZpeGluZyB0aGlzIGJ5IHN3aXRjaGlu
ZyB0byB1c2UgcmVnaXN0ZXJfbmV0ZGV2aWNlKCkgYW5kIHByb3RlY3QgdGhlCj4+Pj4gdmlydGlv
X2RldmljZV9yZWFkeSgpIHdpdGggcnRubF9sb2NrKCkgdG8gbWFrZSBzdXJlIG5kb19vcGVuKCkg
Y2FuCj4+Pj4gb25seSBiZSBjYWxsZWQgYWZ0ZXIgdmlydGlvX2RldmljZV9yZWFkeSgpLgo+Pj4+
Cj4+Pj4gRml4ZXM6IDRiYWYxZTMzZDA4NDIgKCJ2aXJ0aW9fbmV0OiBlbmFibGUgVlFzIGVhcmx5
IikKPj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
Pj4+IC0tLQo+Pj4+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgOCArKysrKysrLQo+Pj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+Pj4+IGluZGV4IGRiMDViNWU5MzBiZS4uOGE1ODEwYmNiODM5IDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+Pj4+IEBAIC0zNjU1LDE0ICszNjU1LDIwIEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+PiAgICAgICAgaWYgKHZp
LT5oYXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hhc2hfcmVwb3J0KQo+Pj4+ICAgICAgICAgICAgICAg
IHZpcnRuZXRfaW5pdF9kZWZhdWx0X3Jzcyh2aSk7Cj4+Pj4KPj4+PiAtICAgICBlcnIgPSByZWdp
c3Rlcl9uZXRkZXYoZGV2KTsKPj4+PiArICAgICAvKiBzZXJpYWxpemUgbmV0ZGV2IHJlZ2lzdGVy
ICsgdmlydGlvX2RldmljZV9yZWFkeSgpIHdpdGggbmRvX29wZW4oKSAqLwo+Pj4+ICsgICAgIHJ0
bmxfbG9jaygpOwo+Pj4+ICsKPj4+PiArICAgICBlcnIgPSByZWdpc3Rlcl9uZXRkZXZpY2UoZGV2
KTsKPj4+PiAgICAgICAgaWYgKGVycikgewo+Pj4+ICAgICAgICAgICAgICAgIHByX2RlYnVnKCJ2
aXJ0aW9fbmV0OiByZWdpc3RlcmluZyBkZXZpY2UgZmFpbGVkXG4iKTsKPj4+PiArICAgICAgICAg
ICAgIHJ0bmxfdW5sb2NrKCk7Cj4+Pj4gICAgICAgICAgICAgICAgZ290byBmcmVlX2ZhaWxvdmVy
Owo+Pj4+ICAgICAgICB9Cj4+Pj4KPj4+PiAgICAgICAgdmlydGlvX2RldmljZV9yZWFkeSh2ZGV2
KTsKPj4+Pgo+Pj4+ICsgICAgIHJ0bmxfdW5sb2NrKCk7Cj4+Pj4gKwo+Pj4+ICAgICAgICBlcnIg
PSB2aXJ0bmV0X2NwdV9ub3RpZl9hZGQodmkpOwo+Pj4+ICAgICAgICBpZiAoZXJyKSB7Cj4+Pj4g
ICAgICAgICAgICAgICAgcHJfZGVidWcoInZpcnRpb19uZXQ6IHJlZ2lzdGVyaW5nIGNwdSBub3Rp
ZmllciBmYWlsZWRcbiIpOwo+Pj4KPj4+IExvb2tzIGdvb2QgYnV0IHRoZW4gZG9uJ3Qgd2UgaGF2
ZSB0aGUgc2FtZSBpc3N1ZSB3aGVuIHJlbW92aW5nIHRoZQo+Pj4gZGV2aWNlPwo+Pj4KPj4+IEFj
dHVhbGx5IEkgbG9va2VkIGF0ICB2aXJ0bmV0X3JlbW92ZSBhbmQgSSBzZWUKPj4+ICAgICAgICAg
IHVucmVnaXN0ZXJfbmV0ZGV2KHZpLT5kZXYpOwo+Pj4KPj4+ICAgICAgICAgIG5ldF9mYWlsb3Zl
cl9kZXN0cm95KHZpLT5mYWlsb3Zlcik7Cj4+Pgo+Pj4gICAgICAgICAgcmVtb3ZlX3ZxX2NvbW1v
bih2aSk7IDwtIHRoaXMgd2lsbCByZXNldCB0aGUgZGV2aWNlCj4+Pgo+Pj4gYSB3aW5kb3cgaGVy
ZT8KPj4gUHJvYmFibHkuIEZvciBzYWZldHksIHdlIHByb2JhYmx5IG5lZWQgdG8gcmVzZXQgYmVm
b3JlIHVucmVnaXN0ZXJpbmcuCj4KPiBjYXJlZnVsIG5vdCB0byBjcmVhdGUgbmV3IHJhY2VzLCBs
ZXQncyBhbmFseXNlIHRoaXMgb25lIHRvIGJlCj4gc3VyZSBmaXJzdC4KCgpZZXMsIGlmIHdlIGRv
IHRoYXQsIHRoZXJlIGNvdWxkIGJlIGFuIGluZmluaXRlIHdhaXQgaW4gY3RybCBjb21tYW5kcy4K
ClNvIHdlIGFyZSBwcm9iYWJseSBmaW5lIGhlcmUgc2luY2UgdW5yZWdpc3Rlcl9uZXRkZXYoKSB3
aWxsIG1ha2Ugc3VyZSAKKG90aGVyd2lzZSBpdCBzaG91bGQgYmUgYSBidWcgb2YgdW5yZWdpc3Rl
cl9uZXRkZXYoKSk6CgoxKSBOQVBJIGlzIGRpc2FibGVkIChhbmQgc3luY2VkKSBzbyBubyBuZXcg
TkFQSSBjb3VsZCBiZSBlbmFibGVkIGJ5IHRoZSAKY2FsbGJhY2tzCjIpIFRYIGlzIGRpc2FibGVk
IChhbmQgc3luY2VkKSBzbyB0aGUgcWRpc2MgY291bGQgbm90IGJlIHNjaGVkdWxlZCBldmVuIApp
ZiBza2JfeG1pdF9kb25lKCkgaXMgY2FsbGVkIGJldHdlZW4gdGhlIHdpbmRvdwoKCj4KPj4+Cj4+
PiBSZWFsbHksIEkgdGhpbmsgd2hhdCB3ZSBoYWQgb3JpZ2luYWxseSB3YXMgYSBiZXR0ZXIgaWRl
YSAtCj4+PiBpbnN0ZWFkIG9mIGRyb3BwaW5nIGludGVycnVwdHMgdGhleSB3ZXJlIGRlbGF5ZWQg
YW5kCj4+PiB3aGVuIGRyaXZlciBpcyByZWFkeSB0byBhY2NlcHQgdGhlbSBpdCBqdXN0IGVuYWJs
ZXMgdGhlbS4KPj4gVGhlIHByb2JsZW0gaXMgdGhhdCBpdCB3b3JrcyBvbmx5IG9uIHNvbWUgc3Bl
Y2lmaWMgc2V0dXA6Cj4+Cj4+IC0gZG9lc24ndCB3b3JrIG9uIHNoYXJlZCBJUlEKPj4gLSBkb2Vz
bid0IHdvcmsgb24gc29tZSBzcGVjaWZpYyBkcml2ZXIgZS5nIHZpcnRpby1ibGsKPiBjYW4gc29t
ZSBjb3JlIGlycSB3b3JrIGZpeCB0aGF0PwoKCk5vdCBzdXJlLiBBdCBsZWFzdCBmb3IgdGhlIHNo
YXJlZCBJUlEgcGFydCwgdGhlcmUncyBubyB3YXkgdG8gZGlzYWJsZSBhIApzcGVjaWZpYyBoYW5k
bGVyIGN1cnJlbnRseS4gTW9yZSBiZWxvdy4KCgo+Cj4+PiBXZSBqdXN0IG5lZWQgdG8gbWFrZSBz
dXJlIGRyaXZlciBkb2VzIG5vdCB3YWl0IGZvcgo+Pj4gaW50ZXJydXB0cyBiZWZvcmUgZW5hYmxp
bmcgdGhlbS4KCgpUaGlzIG9ubHkgaGVscCBmb3IgdGhlIGNhc2U6CgoxKSB0aGUgdmlydGlvX2Rl
dmljZV9yZWFkeSgpIGlzIGNhbGxlZCBhZnRlciBzdWJzeXN0ZW0gCmluaXRpYWxpemF0aW9uL3Jl
Z2lzdHJhdGlvbgoyKSB0aGUgZHJpdmVyIHVzZSByeCBpbnRlcnJ1cHQKCkl0IGRvZXNuJ3Qgc29s
dmUgdGhlIHJhY2UgYmV0d2VlbiBzdWJzeXN0ZW0gcmVnaXN0cmF0aW9uL2luaXRpYWxpemF0aW9u
IAphbmQgdmlydGlvX2RldmljZV9yZWFkeSgpIG9yIHRoZSBjYXNlIHdoZW4gdGhlIHZpcnRpb19k
ZXZpY2VfcmVhZHkoKSAKbmVlZHMgdG8gYmUgY2FsbGVkIGJlZm9yZSBzdWJzeXN0ZW0gcmVnaXN0
cmF0aW9uLgoKVGhhbmtzCgoKPj4+Cj4+PiBBbmQgSSBzdXNwZWN0IHdlIG5lZWQgdG8gbWFrZSB0
aGlzIG9wdC1pbiBvbiBhIHBlciBkcml2ZXIKPj4+IGJhc2lzLgo+PiBFeGFjdGx5Lgo+Pgo+PiBU
aGFua3MKPj4KPj4+Cj4+Pgo+Pj4+IC0tCj4+Pj4gMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
