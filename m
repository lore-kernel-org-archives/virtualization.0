Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A455DC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 08:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36C57417CB;
	Wed,  9 Mar 2022 08:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JX_UTaQGfWCh; Wed,  9 Mar 2022 08:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AFE86417B7;
	Wed,  9 Mar 2022 08:47:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 819C0C001D;
	Wed,  9 Mar 2022 08:47:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07E77C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9D8D84291
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-V_HEE_eL7H
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:47:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F946828EF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646815652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ffS413S/InwxV5O0x2uo8HI1Zzb6CIePH7gzRiVJ4s=;
 b=Rwu3uEKXiY3vULpMLR0RIcM/P/wSI4F1NJkTUIWktGlJU9Eq3ESjd4L3dsZfrDYzMFMEuN
 WSfhYG63Qw8+iDjrwvNPVNglT7dr36vvxpvvWk+Id7csxdHqd6zzDHe9yuyoEE1QBCzq3G
 CVOFoQNo3X1fRk4PA40/BpLQXE0EbeU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-KBUUxur1O2ys2FyJOL7ktA-1; Wed, 09 Mar 2022 03:47:31 -0500
X-MC-Unique: KBUUxur1O2ys2FyJOL7ktA-1
Received: by mail-pj1-f72.google.com with SMTP id
 mm2-20020a17090b358200b001bf529127dfso1177500pjb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 00:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9ffS413S/InwxV5O0x2uo8HI1Zzb6CIePH7gzRiVJ4s=;
 b=6HwickT06wOuw95jOinEqgBSAcvlCDk2ULfNbGbI8LD/U8kS3LysTXAwAD1FT4z/Fs
 7gzMTRjsJnqP8XPx795BSNf7CAzrTSbea0WQp97FJis3hzUVNCBMbGTfG80hsFpSBTEY
 sRpfYCg6GdRsmDGaz+luzHKd2/wPcsF2HJvcFfirjLC9sp5Uoi9FrcWxmUWcS6SljjNv
 R49QjJ9xtALEr/uoS6jOQaknAD4mbgxfkkjVJ9U1aQYerVlJPqCVu5MKsW2YMCiImws5
 V0tGwZ6mNLOXtNtRoMvrEtIB4Gc4vs6K6eNz8gZKapxYx/JSmWwQ9NTrwIDCFbSgWmwX
 2Hcw==
X-Gm-Message-State: AOAM530l3q4jn3dsZUBCY0ns68TekR+JjJuGyEKL1iISdEtPQhrNrExn
 qX/1UmGjul/MN4xESbk3SMZg03PBWaS4nBKA7jqWf5kxH22q4lJgsmKX3RU+ekuJ+8OCV5iyW0z
 iIwMEYIjVQmg5UHdhHmeIxOSAbTSgflzrsBsbEIi9GQ==
X-Received: by 2002:a63:4756:0:b0:373:e14b:5848 with SMTP id
 w22-20020a634756000000b00373e14b5848mr17589451pgk.337.1646815649980; 
 Wed, 09 Mar 2022 00:47:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8AxlCNXVWTVj7iH9SvFqBnT+ALE8NBgyTqiezfIt6S/mnWP42+w8t2ODBwFju+xJKaGATOA==
X-Received: by 2002:a63:4756:0:b0:373:e14b:5848 with SMTP id
 w22-20020a634756000000b00373e14b5848mr17589411pgk.337.1646815649649; 
 Wed, 09 Mar 2022 00:47:29 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a637011000000b0037d5eac87e3sm1577760pgc.18.2022.03.09.00.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 00:47:29 -0800 (PST)
Message-ID: <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
Date: Wed, 9 Mar 2022 16:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 13/26] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFBlcmZvcm1pbmcg
cmVzZXQgb24gYSBxdWV1ZSBpcyBkaXZpZGVkIGludG8gZm91ciBzdGVwczoKPgo+ICAgMS4gcmVz
ZXRfdnEoKSAgICAgICAgICAgICAgICAgICAgIC0gbm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQg
dGhlIHF1ZXVlCj4gICAyLiB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSByZWN5Y2xl
IHRoZSBidWZmZXIgc3VibWl0dGVkCj4gICAzLiB2aXJ0cXVldWVfcmVzZXRfdnJpbmcoKSAgICAg
ICAgLSByZXNldCB0aGUgdnJpbmcgKG1heSByZS1hbGxvYykKPiAgIDQuIGVuYWJsZV9yZXNldF92
cSgpICAgICAgICAgICAgICAtIG1tYXAgdnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBx
dWV1ZQo+Cj4gU28gYWRkIHR3byBjYWxsYmFja3MgcmVzZXRfdnEsIGVuYWJsZV9yZXNldF92cSB0
byBzdHJ1Y3QKPiB2aXJ0aW9fY29uZmlnX29wcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1
byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBpbmNsdWRlL2xpbnV4L3Zp
cnRpb19jb25maWcuaCB8IDExICsrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5o
IGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCA0ZDEwN2FkMzExNDkuLmQ1
MTkwNmIxMzg5ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTc0LDYgKzc0LDE1IEBA
IHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7Cj4gICAgKiBAc2V0X3ZxX2FmZmluaXR5OiBzZXQg
dGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ICAgICogQGdldF92cV9h
ZmZpbml0eTogZ2V0IHRoZSBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFsKS4KPiAg
ICAqIEBnZXRfc2htX3JlZ2lvbjogZ2V0IGEgc2hhcmVkIG1lbW9yeSByZWdpb24gYmFzZWQgb24g
dGhlIGluZGV4Lgo+ICsgKiBAcmVzZXRfdnE6IHJlc2V0IGEgcXVldWUgaW5kaXZpZHVhbGx5IChv
cHRpb25hbCkuCj4gKyAqCXZxOiB0aGUgdmlydHF1ZXVlCj4gKyAqCVJldHVybnMgMCBvbiBzdWNj
ZXNzIG9yIGVycm9yIHN0YXR1cwo+ICsgKglDYWxsZXIgc2hvdWxkIGd1YXJhbnRlZSB0aGF0IHRo
ZSB2cmluZyBpcyBub3QgYWNjZXNzZWQgYnkgYW55IGZ1bmN0aW9ucwo+ICsgKglvZiB2aXJ0cXVl
dWUuCgoKV2UgcHJvYmFibHkgbmVlZCB0byBiZSBtb3JlIGFjY3VyYXRlIGhlcmU6CgoxKSByZXNl
dF92cSB3aWxsIGd1YXJhbnRlZSB0aGF0IHRoZSBjYWxsYmFja3MgYXJlIGRpc2FibGVkIG9yIHN5
bmNocm9uaXplZAoyKSBleGNlcHQgZm9yIHRoZSBjYWxsYmFjaywgdGhlIGNhbGxlciBzaG91bGQg
Z3VhcmFudGVlIC4uLgoKVGhhbmtzCgoKPiArICogQGVuYWJsZV9yZXNldF92cTogZW5hYmxlIGEg
cmVzZXQgcXVldWUKPiArICoJdnE6IHRoZSB2aXJ0cXVldWUKPiArICoJUmV0dXJucyAwIG9uIHN1
Y2Nlc3Mgb3IgZXJyb3Igc3RhdHVzCj4gKyAqCUlmIHJlc2V0X3ZxIGlzIHNldCwgdGhlbiBlbmFi
bGVfcmVzZXRfdnEgbXVzdCBhbHNvIGJlIHNldC4KPiAgICAqLwo+ICAgdHlwZWRlZiB2b2lkIHZx
X2NhbGxiYWNrX3Qoc3RydWN0IHZpcnRxdWV1ZSAqKTsKPiAgIHN0cnVjdCB2aXJ0aW9fY29uZmln
X29wcyB7Cj4gQEAgLTEwMCw2ICsxMDksOCBAQCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+
ICAgCQkJaW50IGluZGV4KTsKPiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2LAo+ICAgCQkJICAgICAgIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiAq
cmVnaW9uLCB1OCBpZCk7Cj4gKwlpbnQgKCpyZXNldF92cSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Owo+ICsJaW50ICgqZW5hYmxlX3Jlc2V0X3ZxKShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gICB9
Owo+ICAgCj4gICAvKiBJZiBkcml2ZXIgZGlkbid0IGFkdmVydGlzZSB0aGUgZmVhdHVyZSwgaXQg
d2lsbCBuZXZlciBhcHBlYXIuICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
