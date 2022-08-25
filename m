Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4340BC6498F
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 07:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D388340C0F;
	Thu, 25 Aug 2022 07:09:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D388340C0F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMb/DdK+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 92nZeV3UKftm; Thu, 25 Aug 2022 07:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A5964017E;
	Thu, 25 Aug 2022 07:09:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A5964017E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04A70C0033;
	Thu, 25 Aug 2022 07:09:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D3F0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE91782F20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE91782F20
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMb/DdK+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lnok1pFfNvgP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CF1782F13
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CF1782F13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661411348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSUsmhrntyYlE4q4EIuSMo8SwjVSMcRRvXJOMV3jSHQ=;
 b=SMb/DdK+Z1WBajyrzwHokey2/KotfaP+Ompkb+HYfPwFWo1hEO71za98995RP5Bx8PKgDQ
 4uKf868m4hqlh6WYqcDW9K2Qh+W5N0fnCcHVVM65usi1UWZuF4kl9doapCPevX+dKYIVhS
 HWt8gcJDkQdBDobookrf4sfask2ZD2w=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-UjT4fiVhNZayEWcWEDMumg-1; Thu, 25 Aug 2022 03:09:06 -0400
X-MC-Unique: UjT4fiVhNZayEWcWEDMumg-1
Received: by mail-pg1-f199.google.com with SMTP id
 a33-20020a630b61000000b00429d91cc649so8660818pgl.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 00:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=QSUsmhrntyYlE4q4EIuSMo8SwjVSMcRRvXJOMV3jSHQ=;
 b=CeQjhxnDo7bJUqE4kkA7Qpo6nGg3oZaR6LcA1R+0xbsQgx/OhTAK4e3f68GUMzKR7V
 3Glnje1hJaVr7pqgGKDI/eFPJnbfgkfHGDV4+PScd1i8GFpO919XrmUVAaSAL4Psnyyl
 5qnCB2GGRGS1whOxyFdbzESJSbzeDROhCk9qZNy0pSfJK8zJdDMCGnNVeo7/FUWZylG7
 YLZwT+jR8IbW9eC0u/TVP4IT3tiFC2+DkdAdTO5HrcSEFQch1SRpEMbp2omwNSjE53vA
 /0YwrEcA7SbIBbloy9eU+9lXFXCKKZKZVkD9d+cfEq6hKmSQTg/hqVwJ8JMFq5z0CYub
 2COg==
X-Gm-Message-State: ACgBeo2iwCDdxP1MXHdGE5oRcrrh/BUr6NLaZA/qikELHvdb5LDpkHyv
 5sx3PiY6megncBUiqWuaZVnoag3HZxx40tObJ0XGvcD6zALW3LyjY3Qe8rrE9PNp3zZpe+Wct1E
 OK3+yy/+5Q6dxh+kKQ5NULBQH+JFtgZ/yi8Dtl9CWBw==
X-Received: by 2002:a17:902:eac3:b0:172:ff31:bb3c with SMTP id
 p3-20020a170902eac300b00172ff31bb3cmr2446552pld.48.1661411345723; 
 Thu, 25 Aug 2022 00:09:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7OChChMg/kNoqJvKmBhroiYu863PvIINaRSgGceUgxIbVI8dEwE1UrA/8XZGCf2a1ChdudKQ==
X-Received: by 2002:a17:902:eac3:b0:172:ff31:bb3c with SMTP id
 p3-20020a170902eac300b00172ff31bb3cmr2446532pld.48.1661411345488; 
 Thu, 25 Aug 2022 00:09:05 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a62d409000000b0053645475a6dsm10698425pfh.66.2022.08.25.00.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:09:04 -0700 (PDT)
Message-ID: <13f97c76-bc8b-1509-d854-89d0d62138fa@redhat.com>
Date: Thu, 25 Aug 2022 15:08:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v2 3/7] vsock: batch buffers in tx
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-4-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817135718.2553-4-qtxuning1999@sjtu.edu.cn>
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

CuWcqCAyMDIyLzgvMTcgMjE6NTcsIEd1byBaaGkg5YaZ6YGTOgo+IFZzb2NrIHVzZXMgYnVmZmVy
cyBpbiBvcmRlciwgYW5kIGZvciB0eCBkcml2ZXIgZG9lc24ndCBoYXZlIHRvCj4ga25vdyB0aGUg
bGVuZ3RoIG9mIHRoZSBidWZmZXIuIFNvIHdlIGNhbiBkbyBhIGJhdGNoIGZvciB2c29jayBpZgo+
IGluIG9yZGVyIG5lZ290aWF0ZWQsIG9ubHkgd3JpdGUgb25lIHVzZWQgcmluZyBmb3IgYSBiYXRj
aCBvZiBidWZmZXJzCj4KPiBTaWduZWQtb2ZmLWJ5OiBHdW8gWmhpIDxxdHh1bmluZzE5OTlAc2p0
dS5lZHUuY24+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMgfCA5ICsrKysrKysrLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnNvY2suYyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwo+
IGluZGV4IDM2ODMzMDQxN2JkZS4uYjAxMDgwMDljMzlhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmhvc3QvdnNvY2suYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnNvY2suYwo+IEBAIC01MDAsNiAr
NTAwLDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfdnNvY2tfaGFuZGxlX3R4X2tpY2soc3RydWN0IHZo
b3N0X3dvcmsgKndvcmspCj4gICAJaW50IGhlYWQsIHBrdHMgPSAwLCB0b3RhbF9sZW4gPSAwOwo+
ICAgCXVuc2lnbmVkIGludCBvdXQsIGluOwo+ICAgCWJvb2wgYWRkZWQgPSBmYWxzZTsKPiArCWlu
dCBsYXN0X2hlYWQgPSAtMTsKPiAgIAo+ICAgCW11dGV4X2xvY2soJnZxLT5tdXRleCk7Cj4gICAK
PiBAQCAtNTUxLDEwICs1NTIsMTYgQEAgc3RhdGljIHZvaWQgdmhvc3RfdnNvY2tfaGFuZGxlX3R4
X2tpY2soc3RydWN0IHZob3N0X3dvcmsgKndvcmspCj4gICAJCWVsc2UKPiAgIAkJCXZpcnRpb190
cmFuc3BvcnRfZnJlZV9wa3QocGt0KTsKPiAgIAo+IC0JCXZob3N0X2FkZF91c2VkKHZxLCBoZWFk
LCAwKTsKPiArCQlpZiAoIXZob3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9JTl9PUkRFUikp
Cj4gKwkJCXZob3N0X2FkZF91c2VkKHZxLCBoZWFkLCAwKTsKPiArCQllbHNlCj4gKwkJCWxhc3Rf
aGVhZCA9IGhlYWQ7Cj4gICAJCWFkZGVkID0gdHJ1ZTsKPiAgIAl9IHdoaWxlKGxpa2VseSghdmhv
c3RfZXhjZWVkc193ZWlnaHQodnEsICsrcGt0cywgdG90YWxfbGVuKSkpOwo+ICAgCj4gKwkvKiBJ
ZiBpbiBvcmRlciBmZWF0dXJlIG5lZ290aWFnZWQsIHdlIGNhbiBkbyBhIGJhdGNoIHRvIGluY3Jl
YXNlIHBlcmZvcm1hbmNlICovCj4gKwlpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19G
X0lOX09SREVSKSAmJiBsYXN0X2hlYWQgIT0gLTEpCj4gKwkJdmhvc3RfYWRkX3VzZWQodnEsIGxh
c3RfaGVhZCwgMCk7CgoKSSBtYXkgbWlzcyBzb21ldGhpbmcgYnV0IHNwZWMgc2FpZCAiVGhlIGRl
dmljZSB0aGVuIHNraXBzIGZvcndhcmQgaW4gdGhlIApyaW5nIGFjY29yZGluZyB0byB0aGUgc2l6
ZSBvZiB0aGUgYmF0Y2guICIuCgpJIGRvbid0IHNlZSBob3cgaXQgaXMgZG9uZSBoZXJlLgoKVGhh
bmtzCgoKPiAgIG5vX21vcmVfcmVwbGllczoKPiAgIAlpZiAoYWRkZWQpCj4gICAJCXZob3N0X3Np
Z25hbCgmdnNvY2stPmRldiwgdnEpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
