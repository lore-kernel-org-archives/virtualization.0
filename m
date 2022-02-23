Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F902C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E9DE40260;
	Wed, 23 Feb 2022 02:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1lMRf7R8yOCt; Wed, 23 Feb 2022 02:42:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F6C7405B9;
	Wed, 23 Feb 2022 02:42:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E2E1C001A;
	Wed, 23 Feb 2022 02:42:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 419A9C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F5E9408B0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PcmXxdhzxLav
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AF694088D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645584145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8I/wsdXh0dJohZtKOx0CUHN4MFYif6rM5V0sllnvXc=;
 b=IWJjxc4eiuPn6ceyp6Mqx4SVFlLGElIsmELP15XEBLPZKZxr3SHybfmH1LbFFjUwQ5H5WW
 pQ8Wf84IMzfce+G+d5t9X6nQWQVXDHC6kdd+zQxDyjTAtD0bHXzRxhngF4dttUMChBKW/E
 b6b/HqZA33hPLuQBD/+nyg9YYwUV1rc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-zZ8-Fhv6MVaj8oj6Z6WPmA-1; Tue, 22 Feb 2022 21:42:24 -0500
X-MC-Unique: zZ8-Fhv6MVaj8oj6Z6WPmA-1
Received: by mail-pj1-f70.google.com with SMTP id
 j10-20020a17090a7e8a00b001bbef243093so600529pjl.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Y8I/wsdXh0dJohZtKOx0CUHN4MFYif6rM5V0sllnvXc=;
 b=sAH1h0GaeU1E9BeSWOBnE6Oq5VVcwHBy83SC9pGvtW29Wg6oVE74XWH8DATCoJTxI/
 r6ndMA34fd7vKHbKZaVZn/11r2OUpyrwyRSNjMhR3YFiOSOvbuTCvwCYismQuFhG2nHd
 Ju249HfaoyqGaq8Nex22Q4DyGhBnizNHZuR4cvB/4LBNJG9c8NNWAikX3rYaGpA9nFTK
 tVlotVjvD0RbATP4SjDSBoN8o8Y6/occm7vwgIrg/z1yX0WsflT12L1pWmTabgl2Limr
 AQi6fizSjSsrAVNx1FWvC1RKnNU5lFmLdrHVg5BKHRYJH4Y0CvayMlUj04sLwAEsqdrP
 FMoA==
X-Gm-Message-State: AOAM530Rw+QtrGX7wGvTFocvik7L4iLK22hTjRafVkmOjjwVycgr6wbe
 T2vF8dCwizIwgrKWSD7GaikoXtsLOY9wFyTBL81Vb8c+myfgYrly0cwttKVQMsiFtAQV6coFJmM
 2bsYFzt3bPbu+8EDP4gPfJLju8IAlAyXM0G3uXgkwvw==
X-Received: by 2002:a17:902:8b87:b0:14d:7920:e54a with SMTP id
 ay7-20020a1709028b8700b0014d7920e54amr25596062plb.140.1645584143180; 
 Tue, 22 Feb 2022 18:42:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRGKfygcpNP2vI3vF7qqOcF7ZJJbi7Ug+mYl9r2wn7sMqOcmPR8CKcXph90s2P/OTD8ueL/g==
X-Received: by 2002:a17:902:8b87:b0:14d:7920:e54a with SMTP id
 ay7-20020a1709028b8700b0014d7920e54amr25596050plb.140.1645584142962; 
 Tue, 22 Feb 2022 18:42:22 -0800 (PST)
Received: from [10.72.13.161] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a22sm14716386pfv.73.2022.02.22.18.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 18:42:22 -0800 (PST)
Message-ID: <d28edd06-6b65-22c7-039e-5957f04c1e52@redhat.com>
Date: Wed, 23 Feb 2022 10:42:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v1 2/6] virtio: remove flags check for unmap split
 indirect desc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <20220210085124.15466-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220210085124.15466-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzIvMTAg5LiL5Y2INDo1MSwgWHVhbiBaaHVvIOWGmemBkzoKPiBXaGVuIGNhbGxp
bmcgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KCksIGl0IHdpbGwgbm90IGVuY291bnRl
ciB0aGUKPiBzaXR1YXRpb24gdGhhdCB0aGUgZmxhZ3MgY29udGFpbnMgVlJJTkdfREVTQ19GX0lO
RElSRUNULiBTbyByZW1vdmUgdGhpcwo+IGxvZ2ljLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyB8IDE4ICsrKysrLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA3Y2Yz
YWUwNTc4MzMuLmZhZGQwYTc1MDNlOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0zNzks
MTkgKzM3OSwxMSBAQCBzdGF0aWMgdm9pZCB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3Qo
Y29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAKPiAgIAlmbGFncyA9IHZpcnRp
bzE2X3RvX2NwdSh2cS0+dnEudmRldiwgZGVzYy0+ZmxhZ3MpOwo+ICAgCj4gLQlpZiAoZmxhZ3Mg
JiBWUklOR19ERVNDX0ZfSU5ESVJFQ1QpIHsKPiAtCQlkbWFfdW5tYXBfc2luZ2xlKHZyaW5nX2Rt
YV9kZXYodnEpLAo+IC0JCQkJIHZpcnRpbzY0X3RvX2NwdSh2cS0+dnEudmRldiwgZGVzYy0+YWRk
ciksCj4gLQkJCQkgdmlydGlvMzJfdG9fY3B1KHZxLT52cS52ZGV2LCBkZXNjLT5sZW4pLAo+IC0J
CQkJIChmbGFncyAmIFZSSU5HX0RFU0NfRl9XUklURSkgPwo+IC0JCQkJIERNQV9GUk9NX0RFVklD
RSA6IERNQV9UT19ERVZJQ0UpOwo+IC0JfSBlbHNlIHsKPiAtCQlkbWFfdW5tYXBfcGFnZSh2cmlu
Z19kbWFfZGV2KHZxKSwKPiAtCQkJICAgICAgIHZpcnRpbzY0X3RvX2NwdSh2cS0+dnEudmRldiwg
ZGVzYy0+YWRkciksCj4gLQkJCSAgICAgICB2aXJ0aW8zMl90b19jcHUodnEtPnZxLnZkZXYsIGRl
c2MtPmxlbiksCj4gLQkJCSAgICAgICAoZmxhZ3MgJiBWUklOR19ERVNDX0ZfV1JJVEUpID8KPiAt
CQkJICAgICAgIERNQV9GUk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+IC0JfQo+ICsJZG1h
X3VubWFwX3BhZ2UodnJpbmdfZG1hX2Rldih2cSksCj4gKwkJICAgICAgIHZpcnRpbzY0X3RvX2Nw
dSh2cS0+dnEudmRldiwgZGVzYy0+YWRkciksCj4gKwkJICAgICAgIHZpcnRpbzMyX3RvX2NwdSh2
cS0+dnEudmRldiwgZGVzYy0+bGVuKSwKPiArCQkgICAgICAgKGZsYWdzICYgVlJJTkdfREVTQ19G
X1dSSVRFKSA/Cj4gKwkJICAgICAgIERNQV9GUk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+
ICAgfQo+ICAgCj4gICBzdGF0aWMgdW5zaWduZWQgaW50IHZyaW5nX3VubWFwX29uZV9zcGxpdChj
b25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
