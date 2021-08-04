Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC24C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 08:31:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7382601FD
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 08:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7382601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 91D8F40227;
	Wed,  4 Aug 2021 08:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZiA4rj-nutGL; Wed,  4 Aug 2021 08:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12FDD40338;
	Wed,  4 Aug 2021 08:31:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E017CC001F;
	Wed,  4 Aug 2021 08:31:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47FF1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08BA04064D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3UWp1EJ-ZRgz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:31:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F47D4057E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628065862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+iBXiMp+0i0kwjToWGA8/FOLua2xKY/IasSPwlB2ug=;
 b=RcEZjPCkTPd0jl/iAPolanj+YheSqUnUshphyxtjcZbb5rLMVRJfTrBai/nYr6iZzCeDCB
 ID6R5PBEwWca8QfmHzVPD8gxZAgfBPvfloHAGkrfONVWkqaDX3v41beexLuYSlkG/ZnFSj
 Ctqi1+RB89wz86yoQnyWxncYrYFMgqg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-jtP37XUVPzG7JsujqXiC0w-1; Wed, 04 Aug 2021 04:30:58 -0400
X-MC-Unique: jtP37XUVPzG7JsujqXiC0w-1
Received: by mail-pj1-f69.google.com with SMTP id
 p8-20020a17090a8688b02901773e164aa8so111733pjn.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 01:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=R+iBXiMp+0i0kwjToWGA8/FOLua2xKY/IasSPwlB2ug=;
 b=NgIyQwvqSTnBukRSvFQYPoeT8+MvjceCIxQvItYoHn5AJ8+SqAUVaqM6Xt7Z3ZmLG3
 CjQ+BENzakIqtKNuBHfoXBb8yyvJ8X7N6XJgfnlYIjygfhXE8P3LQla9Oazhkgzw/wTB
 trQWWYxVuOOQi8sCzm2L/4lwy3oCgWhE+amBt4fd/LIiqiqGrWl+e29Gx7KMleZwHywp
 T1/HVW3g3L4fmLJ407o1+tG8JqXSCIC7IH0ys/FiRlkHGXC/bsT+Oxt8YG6vLRwvbsTC
 El1XQxDnuzSS1+TINLFkKBJpoLa01kvz9OwZJ9EqFLU4P/kVpW0nY9H1QjUaXUydR0FE
 xMrw==
X-Gm-Message-State: AOAM5315s4ZUOUFI8cU9kB4Mrj+OsrjrGEZKxmFRRKbvhfbz6vseiPix
 Be3R1g0Apa1UVasPnd7vmAFkrbZyOdrP0wvr2aErrXM7Z/LY1wvhQExuRwlGf4g/iCjsAcDa+qC
 /wvL8kkZjhABuDVyknh9QEGX7kf+POT2a8Tyx/n0ZVQ==
X-Received: by 2002:a17:90a:5886:: with SMTP id
 j6mr27687760pji.34.1628065857834; 
 Wed, 04 Aug 2021 01:30:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnH9lVsulyqPnREH97Ou07tfmz86+gb2/y1eNG5JuTtEooMRamySZ0IC743fc1pY8YcAbbnQ==
X-Received: by 2002:a17:90a:5886:: with SMTP id
 j6mr27687725pji.34.1628065857537; 
 Wed, 04 Aug 2021 01:30:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i14sm2040290pgh.79.2021.08.04.01.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 01:30:57 -0700 (PDT)
Subject: Re: [PATCH v10 04/17] vdpa: Fail the vdpa_reset() if fail to set
 device status to zero
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-5-xieyongji@bytedance.com>
 <39a191f6-555b-d2e6-e712-735b540526d0@redhat.com>
 <CACycT3sdH3zVzznsaMb0+3mzrLF7FjmB89U11fZv_23Y4_WbEw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <31d11097-dab8-578b-402e-a0e55949ce66@redhat.com>
Date: Wed, 4 Aug 2021 16:30:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sdH3zVzznsaMb0+3mzrLF7FjmB89U11fZv_23Y4_WbEw@mail.gmail.com>
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

CuWcqCAyMDIxLzgvMyDkuIvljYg1OjMxLCBZb25namkgWGllIOWGmemBkzoKPiBPbiBUdWUsIEF1
ZyAzLCAyMDIxIGF0IDM6NTggUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IOWcqCAyMDIxLzcvMjkg5LiL5Y2IMzozNCwgWGllIFlvbmdqaSDlhpnpgZM6Cj4+
PiBSZS1yZWFkIHRoZSBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSBpdCdzIHNldCB0byB6ZXJvIGR1
cmluZwo+Pj4gcmVzZXR0aW5nLiBPdGhlcndpc2UsIGZhaWwgdGhlIHZkcGFfcmVzZXQoKSBhZnRl
ciB0aW1lb3V0Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPgo+Pj4gLS0tCj4+PiAgICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDE1ICsr
KysrKysrKysrKysrLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4gaW5kZXggNDA2ZDUzYTYwNmFjLi5kMWE4MGVmMDUwODkg
MTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4gKysrIGIvaW5jbHVkZS9s
aW51eC92ZHBhLmgKPj4+IEBAIC02LDYgKzYsNyBAQAo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2Rl
dmljZS5oPgo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+Pj4gICAgI2luY2x1
ZGUgPGxpbnV4L3Zob3N0X2lvdGxiLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+Cj4+
Pgo+Pj4gICAgLyoqCj4+PiAgICAgKiBzdHJ1Y3QgdmRwYV9jYWxsbGJhY2sgLSB2RFBBIGNhbGxi
YWNrIGRlZmluaXRpb24uCj4+PiBAQCAtMzQwLDEyICszNDEsMjQgQEAgc3RhdGljIGlubGluZSBz
dHJ1Y3QgZGV2aWNlICp2ZHBhX2dldF9kbWFfZGV2KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikK
Pj4+ICAgICAgICByZXR1cm4gdmRldi0+ZG1hX2RldjsKPj4+ICAgIH0KPj4+Cj4+PiAtc3RhdGlj
IGlubGluZSB2b2lkIHZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+Pj4gKyNk
ZWZpbmUgVkRQQV9SRVNFVF9USU1FT1VUX01TIDEwMDAKPj4+ICsKPj4+ICtzdGF0aWMgaW5saW5l
IGludCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4+ICAgIHsKPj4+ICAg
ICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4+
PiArICAgICBpbnQgdGltZW91dCA9IDA7Cj4+Pgo+Pj4gICAgICAgIHZkZXYtPmZlYXR1cmVzX3Zh
bGlkID0gZmFsc2U7Cj4+PiAgICAgICAgb3BzLT5zZXRfc3RhdHVzKHZkZXYsIDApOwo+Pj4gKyAg
ICAgd2hpbGUgKG9wcy0+Z2V0X3N0YXR1cyh2ZGV2KSkgewo+Pj4gKyAgICAgICAgICAgICB0aW1l
b3V0ICs9IDIwOwo+Pj4gKyAgICAgICAgICAgICBpZiAodGltZW91dCA+IFZEUEFfUkVTRVRfVElN
RU9VVF9NUykKPj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPj4+ICsKPj4+
ICsgICAgICAgICAgICAgbXNsZWVwKDIwKTsKPj4+ICsgICAgIH0KPj4KPj4gSSB3b25kZXIgaWYg
aXQncyBiZXR0ZXIgdG8gZG8gdGhpcyBpbiB0aGUgdkRQQSBwYXJlbnQ/Cj4+Cj4+IFRoYW5rcwo+
Pgo+IFNvcnJ5LCBJIGRpZG4ndCBnZXQgeW91IGhlcmUuIERvIHlvdSBtZWFuIHZEUEEgcGFyZW50
IGRyaXZlciAoZS5nLgo+IFZEVVNFKT8KCgpZZXMsIHNpbmNlIHRoZSBob3cgaXQncyBleHBlY3Rl
ZCB0byBiZWhhdmUgZGVwZW5kcyBvbiB0aGUgc3BlY2lmaWMgaGFyZHdhcmUuCgpFdmVuIGZvciB0
aGUgc3BlYywgdGhlIGJlaGF2aW9yIGlzIHRyYW5zcG9ydCBzcGVjaWZpYzoKClBDSTogcmVxdWly
ZXMgcmVyZWFkIHVudGlsIDAKTU1JTzogZG9lc24ndCByZXF1aXJlIGJ1dCBpdCBtaWdodCBub3Qg
d29yayBmb3IgdGhlIGhhcmR3YXJlIHNvIHdlIApkZWNpZGUgdG8gY2hhbmdlCkNDVzogdGhlIHN1
Y2NlZWQgb2YgdGhlIGNjdyBjb21tYW5kIG1lYW5zIHRoZSBzdWNjZXNzIG9mIHRoZSByZXNldAoK
VGhhbmtzCgoKPiBBY3R1YWxseSBJIGRpZG4ndCBmaW5kIGFueSBvdGhlciBwbGFjZSB3aGVyZSBJ
IGNhbiBkbwo+IHNldF9zdGF0dXMoKSBhbmQgZ2V0X3N0YXR1cygpLgo+Cj4gVGhhbmtzLAo+IFlv
bmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
