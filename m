Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78392C07E95
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 02:41:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBCC6113C
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 02:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBCC6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A00E96079E;
	Tue, 20 Jul 2021 02:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3cUmlWxj66Cz; Tue, 20 Jul 2021 02:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3EB5460686;
	Tue, 20 Jul 2021 02:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C9A7C0010;
	Tue, 20 Jul 2021 02:41:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35CCAC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 02:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17CE4833CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 02:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mp_yejCJFOzS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 02:41:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72AA4833CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 02:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626748874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cx9vRaJKoB0elI+pAj8wQCUn2TBTDPaE649XEXqz5I=;
 b=hmdyk5gEtyRRb86k3BP4cpPzpqwlI+TlV3345xp29UAWOVyICyIYwzBFea7T4/5lIdwB80
 c5837Kr0R0/Q1AF1Gd5lg64grqAis/XIpMQORfdtP1gaoLoGjMJQ4rgCxNFL6OV4h3q0Qg
 iD0LqfElFt1iEU4u9o2Kq/LGG2mVWKc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-8jBynn9QPeqt7CrkC2h8Kw-1; Mon, 19 Jul 2021 22:41:12 -0400
X-MC-Unique: 8jBynn9QPeqt7CrkC2h8Kw-1
Received: by mail-pf1-f198.google.com with SMTP id
 124-20020a6217820000b02902feebfd791eso15054270pfx.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 19:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9cx9vRaJKoB0elI+pAj8wQCUn2TBTDPaE649XEXqz5I=;
 b=e5RmM95aUNAeAty6cTEmGLUVs8m9B2stirjrsC3EagzZkIjIhidX5FqXQl6U/hs+2G
 6lgS+Qrf1gSL3jJXfQK9q5yK8ez9o6HmHf2acbODr3yU0uiRhL1F4Y8bCXgSlE7ciTmV
 /h11Nm+bXqzWUmO5T4gprSvvX2cSYvp8ckdgc85pTbo6zeqNbhdL8nfX/myItqwUe8Zw
 Z7Hp69VrzSWa88lgTp2prLntz19RFLGt/pm6mMXNpHuimzEmN297RG8X7AE8oE2Jnay3
 hDaZpHu3rJedexxVRcwVuJYSCxBZ8v8OZW/3qw6a4dhCbNyTzemIZp/BnqDUMiIjNNVw
 +/jg==
X-Gm-Message-State: AOAM533YutwBUaFv2OuXsOyk61I04LswLZg442QhaQ2baTB4uWZHMiU2
 IQLXZsbz/b+Kc3D3qpSLVqGmA9Nj+grWVxFPr1oihv/RNGEV4IkABfDeIn5AnZHJhQhj/6Zj3eY
 SWaMmrep5wOnRqLqgrohX0wF6/KVF29HJDFR/XmgRLQ==
X-Received: by 2002:a63:ed47:: with SMTP id m7mr28577588pgk.194.1626748871679; 
 Mon, 19 Jul 2021 19:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgxZiwuj0ggtt60dnHTwjkzia6vpHkhohJNoz9AYWKnuY4DXH4sLv44Eyv8ZJljg3HsqDpLg==
X-Received: by 2002:a63:ed47:: with SMTP id m7mr28577572pgk.194.1626748871404; 
 Mon, 19 Jul 2021 19:41:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q2sm10838498pfu.205.2021.07.19.19.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 19:41:10 -0700 (PDT)
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To: tianxianting <xianting.tian@linux.alibaba.com>,
 Xianting Tian <xianting_tian@126.com>, mst@redhat.com, david@redhat.com
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
 <b427ac2a-e439-3675-8a42-9fdcd23a5114@redhat.com>
 <d1b6f3d5-22a0-f0a5-ed49-1523dd740ffb@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <76a227a9-1b2c-c433-c8d9-5963fb56028d@redhat.com>
Date: Tue, 20 Jul 2021 10:41:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d1b6f3d5-22a0-f0a5-ed49-1523dd740ffb@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzcvMTkg5LiL5Y2IMTI6MjIsIHRpYW54aWFudGluZyDlhpnpgZM6Cj4gdGhhbmtz
LAo+Cj4gSSBjaGVja2VkLCBhY3R1YWxseSBhbGwgdmlydGlvIGRyaXZlcnMgaGF2ZSBzd2l0Y2hl
ZCB0byB1c2UgdGhlIGhlbHBlciAKPiBhZnRlciB0aGlzIG9uZSBtZXJnZWQuCgoKT2suIENvb2wu
CgpUaGFua3MKCgo+Cj4g5ZyoIDIwMjEvNy8xOSDkuIrljYgxMTo0NiwgSmFzb24gV2FuZyDlhpnp
gZM6Cj4+Cj4+IOWcqCAyMDIxLzcvMTYg5LiL5Y2IODo0NiwgdGlhbnhpYW50aW5nIOWGmemBkzoK
Pj4+IERvIHlvdSBpbnRlcmVzdCBpbiB0aGlzIHBhdGNoPyBqdXN0IGxpdHRsZSBpbXByb3ZtZW50
OikKPj4+Cj4+PiDlnKggMjAyMS83LzEzIOS4i+WNiDExOjM4LCBYaWFudGluZyBUaWFuIOWGmemB
kzoKPj4+PiBGcm9tOiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEu
Y29tPgo+Pj4+Cj4+Pj4gVXNlIHRoZSBoZWxwZXIgdmlydGlvX2ZpbmRfdnFzKCkuCj4+Pj4KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJh
YmEuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxsb29uLmMg
fCA0ICsrLS0KPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxs
b29uLmMgCj4+Pj4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fYmFsbG9vbi5jCj4+Pj4gaW5kZXgg
NTEwZTkzMS4uMThlMGJmMyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
YmFsbG9vbi5jCj4+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX2JhbGxvb24uYwo+Pj4+
IEBAIC01MzEsOCArNTMxLDggQEAgc3RhdGljIGludCBpbml0X3ZxcyhzdHJ1Y3QgdmlydGlvX2Jh
bGxvb24gKnZiKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYWxsYmFja3NbVklSVElPX0JBTExP
T05fVlFfUkVQT1JUSU5HXSA9IGJhbGxvb25fYWNrOwo+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+IMKg
IC3CoMKgwqAgZXJyID0gdmItPnZkZXYtPmNvbmZpZy0+ZmluZF92cXModmItPnZkZXYsIAo+Pj4+
IFZJUlRJT19CQUxMT09OX1ZRX01BWCwKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB2cXMsIGNhbGxiYWNrcywgbmFtZXMsIE5VTEwsIE5VTEwpOwo+Pj4+ICvC
oMKgwqAgZXJyID0gdmlydGlvX2ZpbmRfdnFzKHZiLT52ZGV2LCBWSVJUSU9fQkFMTE9PTl9WUV9N
QVgsIHZxcywKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhbGxiYWNrcywg
bmFtZXMsIE5VTEwpOwo+Pj4+IMKgwqDCoMKgwqAgaWYgKGVycikKPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGVycjsKPj4+Cj4+Cj4+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+Pgo+PiBNYXliZSBpdCdzIGJldHRlciB0byBjb252ZXJ0IGFsbCB0aGUg
ZHJpdmVycyB0aGF0IGRvZXNuJ3QgdXNlIAo+PiB2aXJ0aW9fZmluZF92cXN7X2N0eH0uCj4+Cj4+
IFRoYW5rcwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
