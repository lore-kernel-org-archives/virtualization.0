Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F210BC433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:18:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E48D61163
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E48D61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FF28401F4;
	Fri, 15 Oct 2021 08:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id utGhOWGyYdiv; Fri, 15 Oct 2021 08:18:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 96F4F401CC;
	Fri, 15 Oct 2021 08:18:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 602C0C000F;
	Fri, 15 Oct 2021 08:18:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DD0BC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E60B4017B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6T9PczvNO-E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:18:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF66B40132
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634285912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AR7NmtJeDKbUolQgFEf1uh0PVLHMymws/0LyfI2hS+8=;
 b=ZHgvo0FcTuNOyNIHxo/VLxL19xaBSosKw19IcclSS4TsY+qRcY0oyK2bLNVg1m/5Z45+91
 2R0FH8+JUggpv3aTPW7MIr6ZvPJ8TpHOytJQNOxJiA2miXfuLYeUivjYdvryq58MDEtWPv
 o4IAzUut5MG62QmNhxSKmRaE7tdv+Wo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ez-D07GtNiGNsTRQPhSZ3A-1; Fri, 15 Oct 2021 04:18:31 -0400
X-MC-Unique: ez-D07GtNiGNsTRQPhSZ3A-1
Received: by mail-pg1-f197.google.com with SMTP id
 g26-20020a63521a000000b0029524f04f5aso4685917pgb.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AR7NmtJeDKbUolQgFEf1uh0PVLHMymws/0LyfI2hS+8=;
 b=vyraOEApAeMiJ9mziROMoyTWmwGhzH/9uOdfs8yL92EO0kNqF7I+A/JejHhiTxxqHE
 2Wn88yFBYMPKAscAWCIet/d5QIhBln+7Gtg4zbb1RM9ApjtavfPXHwZGDa8WPM0Vc6TM
 RQHIOOeMkl4RbuzJuOFzmLluPfLvVPiYaTgfTFLDveidmNZCo5tWP2/PQcyfx8hM4l3d
 7c8RP9lRDkrjX0oR80RCX+OHmDSvieSlKzPJBwlFPIMmUuKS2ZxzYSmlWGpEDGURN2kM
 Yxufet4wU2l/Gc4xJu0teb7P6Y+5xQp2XmK5YKt0zCtXgky7JFQDFs+8UQuxse2PlTiI
 2O5w==
X-Gm-Message-State: AOAM532hHe/tPYkFNJrsGWRoIqCDTcKu5MV/6kI+Lw4BfgKq2JrrTiMD
 eTA1BWSct/XWSdsqwwvdpQoVvAWjShmQolJuDFjNlGpLfcPZixR9o+SP1IuOKW+2Y4YiKLEsLMW
 iQziNO6rxovEURoTrvPtbT6IUNZxeOkJ4tVJThMsA7g==
X-Received: by 2002:a62:6243:0:b0:44b:e10e:61b0 with SMTP id
 w64-20020a626243000000b0044be10e61b0mr10013326pfb.53.1634285910338; 
 Fri, 15 Oct 2021 01:18:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKi1J9Dv5m7Hzhrxa7SAAKzEt+oDX9bo4a9zUH0AYB9m+fPbcsqJOxHucHRQn/BvVA4daJVg==
X-Received: by 2002:a62:6243:0:b0:44b:e10e:61b0 with SMTP id
 w64-20020a626243000000b0044be10e61b0mr10013296pfb.53.1634285909984; 
 Fri, 15 Oct 2021 01:18:29 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h1sm4607177pfh.183.2021.10.15.01.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 01:18:29 -0700 (PDT)
Subject: Re: [PATCH v5 8/8] eni_vdpa: add vDPA driver for Alibaba ENI
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <71914be7-827a-b496-90cb-1c0b5f573c37@redhat.com>
Date: Fri, 15 Oct 2021 16:18:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <57a04a9e516ec4055cb887e9c7b24658ca5b0228.1634281805.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMTAvMTUgz8LO5zM6MTUsIFd1IFpvbmd5b25nINC0tcA6Cj4gKwo+ICtzdGF0aWMg
dTY0IGVuaV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gK3sK
PiArCXN0cnVjdCB2aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgKmxkZXYgPSB2ZHBhX3RvX2xkZXYo
dmRwYSk7Cj4gKwl1NjQgZmVhdHVyZXMgPSB2cF9sZWdhY3lfZ2V0X2ZlYXR1cmVzKGxkZXYpOwo+
ICsKPiArCWZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKTsKPiAr
CWZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX0ZfT1JERVJfUExBVEZPUk0pOwo+ICsKPiArCXJl
dHVybiBmZWF0dXJlczsKPiArfQo+ICsKPiArc3RhdGljIGludCBlbmlfdmRwYV9zZXRfZmVhdHVy
ZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4gK3sKPiArCXN0cnVj
dCB2aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgKmxkZXYgPSB2ZHBhX3RvX2xkZXYodmRwYSk7Cj4g
Kwo+ICsJaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUkdfUlhCVUYpKSAm
JiBmZWF0dXJlcykgewo+ICsJCUVOSV9FUlIobGRldi0+cGNpX2RldiwKPiArCQkJIlZJUlRJT19O
RVRfRl9NUkdfUlhCVUYgaXMgbm90IG5lZ290aWF0ZWRcbiIpOwo+ICsJCXJldHVybiAtRUlOVkFM
Owo+ICsJfQo+ICsKPiArCXZwX2xlZ2FjeV9zZXRfZmVhdHVyZXMobGRldiwgKHUzMilmZWF0dXJl
cyk7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KCgpIaToKCkl0IGxvb2tzIGxpa2Ugc29tZSBvZiBt
eSBwcmV2aW91cyBjb21tZW50cyB3ZXJlIGlnbm9yZWQ/Cgo+ICtzdGF0aWMgdTY0IGVuaV92ZHBh
X2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gK3sKPiArCXN0cnVjdCB2
aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgKmxkZXYgPSB2ZHBhX3RvX2xkZXYodmRwYSk7Cj4gKwl1
NjQgZmVhdHVyZXMgPSB2cF9sZWdhY3lfZ2V0X2ZlYXR1cmVzKGxkZXYpOwo+ICsKPiArCWZlYXR1
cmVzIHw9IEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKTsKPiArCWZlYXR1cmVzIHw9
IEJJVF9VTEwoVklSVElPX0ZfT1JERVJfUExBVEZPUk0pOwoKVkVSU0lPTl8xIGlzIGFsc28gbmVl
ZGVkPwoKCj4gKwo+ICsJcmV0dXJuIGZlYXR1cmVzOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IGVu
aV92ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJl
cykKPiArewo+ICsJc3RydWN0IHZpcnRpb19wY2lfbGVnYWN5X2RldmljZSAqbGRldiA9IHZkcGFf
dG9fbGRldih2ZHBhKTsKPiArCj4gKwlpZiAoIShmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05F
VF9GX01SR19SWEJVRikpICYmIGZlYXR1cmVzKSB7Cj4gKwkJRU5JX0VSUihsZGV2LT5wY2lfZGV2
LAo+ICsJCQkiVklSVElPX05FVF9GX01SR19SWEJVRiBpcyBub3QgbmVnb3RpYXRlZFxuIik7Cj4g
KwkJcmV0dXJuIC1FSU5WQUw7CgpEbyB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSBGRUFUVVJFX09LIGlz
IG5vdCBzZXQgaW4gdGhpcyBjYXNlIG9yIHRoZSBFTkkgY2FuIGRvCnRoaXMgZm9yIHVzPwoKT3Ro
ZXIgbG9va3MgZ29vZC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
