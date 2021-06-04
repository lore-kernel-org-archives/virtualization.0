Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A5C47082
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:28:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42EC861407
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 02:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EC861407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 099CC6F941;
	Fri,  4 Jun 2021 02:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iJEhNnPQUW6d; Fri,  4 Jun 2021 02:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F6F860635;
	Fri,  4 Jun 2021 02:28:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E7FDC000D;
	Fri,  4 Jun 2021 02:28:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2843C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AA5260604
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_6au2wxC5Se
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:28:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F72D605BD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622773733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4FEeFH/pQALtmPWyCOn3tMvLw70W3gs+V22pPRCgrw=;
 b=WUeOSinv+Hheacs/ulPKQDu6DB3JqTvYcn+bEvy7dY6gjFUZzFSeydfA/dkYPODUl8Hd3H
 pQlHzxG2fJC8BB1/P4cq8qxJUVXvRi3kyQRMv47tHJ/QfFObhOz+6fS8gX/x1esw0xsVF/
 mwzyF/AWUr4JOGfEYbXJ4TpkVYJPVIU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-mRKJsk6MPIaPq3GqkaBt3Q-1; Thu, 03 Jun 2021 22:28:52 -0400
X-MC-Unique: mRKJsk6MPIaPq3GqkaBt3Q-1
Received: by mail-pl1-f198.google.com with SMTP id
 e14-20020a170902784eb0290102b64712f9so3482849pln.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 19:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=W4FEeFH/pQALtmPWyCOn3tMvLw70W3gs+V22pPRCgrw=;
 b=Sv4KgkjPRdg6JO/6BPwsxoufzC9WCiKz+UTz+nkEW2Vpcz0wgdn1AXEjjWRQCsPch+
 uc0iDBqkZErt35vCCDPNkCi4pru9GFQJdNxa95wTkfT6koo/EN/9vFoW7+0PMlLFMrPk
 w20OKxUWrEpFVRJCjpfGOOPHSreunSDHhx2Ezu9UQLu8ojDmldumXVDw77OxxLb045XW
 VQTfJptNABMnoTVyYkocQ7i3YQ/utJgeggbq0dwvytQYLYv2KQr0G7SDPsaMC1skaJrC
 DuW/A1v5F3noNm0w/3PesMXZltuBKTHq9JTcC1FvlBPLzWTdx2enLKpi3HUP0wccEzBn
 HLQg==
X-Gm-Message-State: AOAM530EtHkM63OMXExAd+lMyNkGGpSnJ+h5nDzEQq85buxpadR8ErVZ
 ALy2sRFBkhd+3XoH5c2gycu6HaBUhZoTKbd9PU5Xxy/+ZDhxq3NRK5ew9iy6AABCCQ5NHF4nFT8
 xCGYIewj4slmbrgDIya5et0aFYJ0P0F31KABvDA1qXQ==
X-Received: by 2002:a17:90a:8d82:: with SMTP id
 d2mr2387042pjo.200.1622773730978; 
 Thu, 03 Jun 2021 19:28:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7nIC7vCX27/pebah12gefchckRdwl+x2P/Rcym5m+MUU5qWKzxUck3QlQJYl+LYPsU17LGw==
X-Received: by 2002:a17:90a:8d82:: with SMTP id
 d2mr2387019pjo.200.1622773730666; 
 Thu, 03 Jun 2021 19:28:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i8sm3247600pjs.54.2021.06.03.19.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 19:28:50 -0700 (PDT)
Subject: Re: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210603170901.66504-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <231466df-adc1-79a9-6950-77c88e2783c2@redhat.com>
Date: Fri, 4 Jun 2021 10:28:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603170901.66504-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Corentin_No=c3=abl?= <corentin.noel@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIxLzYvNCDkuIrljYgxOjA5LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEluIHZpcnRpby1u
ZXQncyBsYXJnZSBwYWNrZXQgbW9kZSwgdGhlcmUgaXMgYSBob2xlIGluIHRoZSBzcGFjZSBiZWhp
bmQKPiBidWYuCgoKYmVmb3JlIHRoZSBidWYgYWN0dWFsbHkgb3IgYmVoaW5kIHRoZSB2bmV0IGhl
YWRlcj8KCgo+Cj4gICAgICBoZHJfcGFkZGVkX2xlbiAtIGhkcl9sZW4KPgo+IFdlIG11c3QgdGFr
ZSB0aGlzIGludG8gYWNjb3VudCB3aGVuIGNhbGN1bGF0aW5nIHRhaWxyb29tLgo+Cj4gWyAgIDQ0
LjU0NDM4NV0gc2tiX3B1dC5jb2xkIChuZXQvY29yZS9za2J1ZmYuYzo1MjU0IChkaXNjcmltaW5h
dG9yIDEpIG5ldC9jb3JlL3NrYnVmZi5jOjUyNTIgKGRpc2NyaW1pbmF0b3IgMSkpCj4gWyAgIDQ0
LjU0NDg2NF0gcGFnZV90b19za2IgKGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzo0ODUpIFsgICA0
NC41NDUzNjFdIHJlY2VpdmVfYnVmIChkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6ODQ5IGRyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYzoxMTMxKQo+IFsgICA0NC41NDU4NzBdID8gbmV0aWZfcmVjZWl2
ZV9za2JfbGlzdF9pbnRlcm5hbCAobmV0L2NvcmUvZGV2LmM6NTcxNCkKPiBbICAgNDQuNTQ2NjI4
XSA/IGRldl9ncm9fcmVjZWl2ZSAobmV0L2NvcmUvZGV2LmM6NjEwMykKPiBbICAgNDQuNTQ3MTM1
XSA/IG5hcGlfY29tcGxldGVfZG9uZSAoLi9pbmNsdWRlL2xpbnV4L2xpc3QuaDozNSBuZXQvY29y
ZS9kZXYuYzo1ODY3IG5ldC9jb3JlL2Rldi5jOjU4NjIgbmV0L2NvcmUvZGV2LmM6NjU2NSkKPiBb
ICAgNDQuNTQ3NjcyXSB2aXJ0bmV0X3BvbGwgKGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxNDI3
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxNTI1KQo+IFsgICA0NC41NDgyNTFdIF9fbmFwaV9w
b2xsIChuZXQvY29yZS9kZXYuYzo2OTg1KQo+IFsgICA0NC41NDg3NDRdIG5ldF9yeF9hY3Rpb24g
KG5ldC9jb3JlL2Rldi5jOjcwNTQgbmV0L2NvcmUvZGV2LmM6NzEzOSkKPiBbICAgNDQuNTQ5MjY0
XSBfX2RvX3NvZnRpcnEgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5oOjE5IC4v
aW5jbHVkZS9saW51eC9qdW1wX2xhYmVsLmg6MjAwIC4vaW5jbHVkZS90cmFjZS9ldmVudHMvaXJx
Lmg6MTQyIGtlcm5lbC9zb2Z0aXJxLmM6NTYwKQo+IFsgICA0NC41NDk3NjJdIGlycV9leGl0X3Jj
dSAoa2VybmVsL3NvZnRpcnEuYzo0MzMga2VybmVsL3NvZnRpcnEuYzo2Mzcga2VybmVsL3NvZnRp
cnEuYzo2NDkpCj4gWyAgIDQ0LjU1MTM4NF0gY29tbW9uX2ludGVycnVwdCAoYXJjaC94ODYva2Vy
bmVsL2lycS5jOjI0MCAoZGlzY3JpbWluYXRvciAxMykpCj4gWyAgIDQ0LjU1MTk5MV0gPyBhc21f
Y29tbW9uX2ludGVycnVwdCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pZHRlbnRyeS5oOjYzOCkK
PiBbICAgNDQuNTUyNjU0XSBhc21fY29tbW9uX2ludGVycnVwdCAoLi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9pZHRlbnRyeS5oOjYzOCkKPgo+IEZpeGVzOiBmYjMyODU2YjE2YWQgKCJ2aXJ0aW8tbmV0
OiBwYWdlX3RvX3NrYigpIHVzZSBidWlsZF9za2Igd2hlbiB0aGVyZSdzIHN1ZmZpY2llbnQgdGFp
bHJvb20iKQo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFi
YS5jb20+Cj4gUmVwb3J0ZWQtYnk6IENvcmVudGluIE5vw6tsIDxjb3JlbnRpbi5ub2VsQGNvbGxh
Ym9yYS5jb20+Cj4gVGVzdGVkLWJ5OiBDb3JlbnRpbiBOb8OrbCA8Y29yZW50aW4ubm9lbEBjb2xs
YWJvcmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gaW5kZXggZmE0MDdlYjhiNDU3Li43OGEwMWM3MWExN2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAg
LTQwNiw3ICs0MDYsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgCSAqIGFkZF9yZWN2YnVmX21lcmdlYWJsZSgpICsgZ2V0
X21lcmdlYWJsZV9idWZfbGVuKCkKPiAgIAkgKi8KPiAgIAl0cnVlc2l6ZSA9IGhlYWRyb29tID8g
UEFHRV9TSVpFIDogdHJ1ZXNpemU7Cj4gLQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gaGVh
ZHJvb207Cj4gKwl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gaGVhZHJvb20gLSAoaGRyX3Bh
ZGRlZF9sZW4gLSBoZHJfbGVuKTsKCgpUaGUgcGF0Y2ggbG9va3MgY29ycmVjdCBhbmQgSSBzYXcg
aXQgaGFzIGJlZW4gbWVyZ2VkLgoKQnV0IEkgcHJlZmVyIHRvIGRvIHRoYXQgaW4gcmVjZWl2ZV9i
aWcoKSBpbnN0ZWFkIG9mIGhlcmUuCgpUaGFua3MKCgoKPiAgIAlidWYgPSBwIC0gaGVhZHJvb207
Cj4gICAKPiAgIAlsZW4gLT0gaGRyX2xlbjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
