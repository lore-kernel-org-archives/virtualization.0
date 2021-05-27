Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E583EC4707F
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 08:41:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A97B613CC
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 08:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A97B613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1516740261;
	Thu, 27 May 2021 08:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MAFAKY_DAk2K; Thu, 27 May 2021 08:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF83940284;
	Thu, 27 May 2021 08:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B422C000D;
	Thu, 27 May 2021 08:41:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E918EC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 08:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEC2940609
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 08:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2uX7jAVTlCYu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 08:41:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83E3440561
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622104877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yN1LmC6tLlwHE2JSmI5/WtXdvMUbtIRH+V/hkQT9TzA=;
 b=JHr2dwA3m2wYjgaiPOSQfPpwDC+2/4Kn0W3j/E/U/xkC//oJoDjRUEufaik8zryPnbVqud
 VKJoyzyamPL8qu1XV9EQZIF1HIKZoNhwYYZl7/Vaja4vLyA24C0aeAtGJm+FMkXi0zljyA
 Y5e031OIUryvuOalYF1tg/hwv8fELw4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-GzktC7JYPSqiX18NsTX7NA-1; Thu, 27 May 2021 04:41:15 -0400
X-MC-Unique: GzktC7JYPSqiX18NsTX7NA-1
Received: by mail-pg1-f199.google.com with SMTP id
 28-20020a63135c0000b029021b78388f01so2492715pgt.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 01:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yN1LmC6tLlwHE2JSmI5/WtXdvMUbtIRH+V/hkQT9TzA=;
 b=peT6CZhpmJIBxB45qFUK4r4y+ZEOlAOqyGWC3/28kClfC6Xzo5p+uTWkrOWlAmfNkC
 DCjijLFoSYl5Mw9Fh4jhK+NHwC6dzF1/WPWO3Ru9AsdlcHBMchFGZE/IwSDYGLAEVvrE
 iBYSlXaHzBL+Cs7Z+aItNPpaG1awm6MMCqgLaZjUFDzZlZUcTlhibUcHK4chfSwSoBCs
 H92e5lVUb5xjudyImqrmjiEOHiKPwPafouPqUBIjD2illWELykq+u5EpF/bCOD3tPDnb
 ocJC9tYYHh7dtQKabz8LOrcL86D1CCHcOe6tIC8sp0OeZGcjBMCzei+4yXzG5H0NbOZ+
 I4MQ==
X-Gm-Message-State: AOAM530+InIkEzagTfCQbkFGCK/8zNbNM56Q1ztjnD+w8MVrKsIxOO12
 O6kO2DEIFa7UW9Qsmm5lkZleRA0l/VSAyYmKJAI8h412pv45XIDeF+s9Gxga9cHwOnirthQ/6oX
 lu0bdiZunYJIM8ZIGlLA1G++2mKowX6XhDoxsezRvvQ==
X-Received: by 2002:a17:902:d508:b029:ef:b008:f4ad with SMTP id
 b8-20020a170902d508b02900efb008f4admr2333604plg.8.1622104874616; 
 Thu, 27 May 2021 01:41:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvPNDcYkAS3faf7fevSyiFC8ZU6oTJ+el34W9W0mGRDdwfnLELCNOSU91eRydTJVumJh4SSA==
X-Received: by 2002:a17:902:d508:b029:ef:b008:f4ad with SMTP id
 b8-20020a170902d508b02900efb008f4admr2333565plg.8.1622104874245; 
 Thu, 27 May 2021 01:41:14 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a12sm1513042pfg.102.2021.05.27.01.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 01:41:13 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
 <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
Date: Thu, 27 May 2021 16:41:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, joro@8bytes.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
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

CuWcqCAyMDIxLzUvMjcg5LiL5Y2IMzozNCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVGh1LCBN
YXkgMjcsIDIwMjEgYXQgMTo0MCBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxOjA4LCBZb25namkgWGllIOWGmemBkzoK
Pj4+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDE6MDAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxMjo1NywgWW9uZ2pp
IFhpZSDlhpnpgZM6Cj4+Pj4+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDEyOjEzIFBNIEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4g5ZyoIDIwMjEvNS8xNyDk
uIvljYg1OjU1LCBYaWUgWW9uZ2ppIOWGmemBkzoKPj4+Pj4+PiArCj4+Pj4+Pj4gK3N0YXRpYyBp
bnQgdmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwKPj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZkdXNlX2Rldl9tc2cgKm1zZykKPj4+Pj4+
PiArewo+Pj4+Pj4+ICsgICAgIGluaXRfd2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2FpdHEpOwo+Pj4+
Pj4+ICsgICAgIHNwaW5fbG9jaygmZGV2LT5tc2dfbG9jayk7Cj4+Pj4+Pj4gKyAgICAgdmR1c2Vf
ZW5xdWV1ZV9tc2coJmRldi0+c2VuZF9saXN0LCBtc2cpOwo+Pj4+Pj4+ICsgICAgIHdha2VfdXAo
JmRldi0+d2FpdHEpOwo+Pj4+Pj4+ICsgICAgIHNwaW5fdW5sb2NrKCZkZXYtPm1zZ19sb2NrKTsK
Pj4+Pj4+PiArICAgICB3YWl0X2V2ZW50X2tpbGxhYmxlKG1zZy0+d2FpdHEsIG1zZy0+Y29tcGxl
dGVkKTsKPj4+Pj4+IFdoYXQgaGFwcGVucyBpZiB0aGUgdXNlcnNwYWNlKG1hbGljb3VzKSBkb2Vz
bid0IGdpdmUgYSByZXNwb25zZSBmb3JldmVyPwo+Pj4+Pj4KPj4+Pj4+IEl0IGxvb2tzIGxpa2Ug
YSBET1MuIElmIHllcywgd2UgbmVlZCB0byBjb25zaWRlciBhIHdheSB0byBmaXggdGhhdC4KPj4+
Pj4+Cj4+Pj4+IEhvdyBhYm91dCB1c2luZyB3YWl0X2V2ZW50X2tpbGxhYmxlX3RpbWVvdXQoKSBp
bnN0ZWFkPwo+Pj4+IFByb2JhYmx5LCBhbmQgdGhlbiB3ZSBuZWVkIGNob29zZSBhIHN1aXRhYmxl
IHRpbWVvdXQgYW5kIG1vcmUgaW1wb3J0YW50LAo+Pj4+IG5lZWQgdG8gcmVwb3J0IHRoZSBmYWls
dXJlIHRvIHZpcnRpby4KPj4+Pgo+Pj4gTWFrZXMgc2Vuc2UgdG8gbWUuIEJ1dCBpdCBsb29rcyBs
aWtlIHNvbWUKPj4+IHZkcGFfY29uZmlnX29wcy92aXJ0aW9fY29uZmlnX29wcyBzdWNoIGFzIHNl
dF9zdGF0dXMoKSBkaWRuJ3QgaGF2ZSBhCj4+PiByZXR1cm4gdmFsdWUuICBOb3cgSSBhZGQgYSBX
QVJOX09OKCkgZm9yIHRoZSBmYWlsdXJlLiBEbyB5b3UgbWVhbiB3ZQo+Pj4gbmVlZCB0byBhZGQg
c29tZSBjaGFuZ2UgZm9yIHZpcnRpbyBjb3JlIHRvIGhhbmRsZSB0aGUgZmFpbHVyZT8KPj4KPj4g
TWF5YmUsIGJ1dCBJJ20gbm90IHN1cmUgaG93IGhhcmQgd2UgY2FuIGRvIHRoYXQuCj4+Cj4gV2Ug
bmVlZCB0byBjaGFuZ2UgYWxsIHZpcnRpbyBkZXZpY2UgZHJpdmVycyBpbiB0aGlzIHdheS4KCgpQ
cm9iYWJseS4KCgo+Cj4+IFdlIGhhZCBORUVEU19SRVNFVCBidXQgaXQgbG9va3Mgd2UgZG9uJ3Qg
aW1wbGVtZW50IGl0Lgo+Pgo+IENvdWxkIGl0IGhhbmRsZSB0aGUgZmFpbHVyZSBvZiBnZXRfZmVh
dHVyZSgpIGFuZCBnZXQvc2V0X2NvbmZpZygpPwoKCkxvb2tzIG5vdDoKCiIKClRoZSBkZXZpY2Ug
U0hPVUxEIHNldCBERVZJQ0VfTkVFRFNfUkVTRVQgd2hlbiBpdCBlbnRlcnMgYW4gZXJyb3Igc3Rh
dGUgCnRoYXQgYSByZXNldCBpcyBuZWVkZWQuIElmIERSSVZFUl9PSyBpcyBzZXQsIGFmdGVyIGl0
IHNldHMgCkRFVklDRV9ORUVEU19SRVNFVCwgdGhlIGRldmljZSBNVVNUIHNlbmQgYSBkZXZpY2Ug
Y29uZmlndXJhdGlvbiBjaGFuZ2UgCm5vdGlmaWNhdGlvbiB0byB0aGUgZHJpdmVyLgoKIgoKVGhp
cyBsb29rcyBpbXBsaWVzIHRoYXQgTkVFRFNfUkVTRVQgbWF5IG9ubHkgd29yayBhZnRlciBkZXZp
Y2UgaXMgCnByb2JlZC4gQnV0IGluIHRoZSBjdXJyZW50IGRlc2lnbiwgZXZlbiB0aGUgcmVzZXQo
KSBpcyBub3QgcmVsaWFibGUuCgoKPgo+PiBPciBhIHJvdWdoIGlkZWEgaXMgdGhhdCBtYXliZSBu
ZWVkIHNvbWUgcmVsYXhpbmcgdG8gYmUgY291cGxlZCBsb29zZWx5Cj4+IHdpdGggdXNlcnNwYWNl
LiBFLmcgdGhlIGRldmljZSAoY29udHJvbCBwYXRoKSBpcyBpbXBsZW1lbnRlZCBpbiB0aGUKPj4g
a2VybmVsIGJ1dCB0aGUgZGF0YXBhdGggaXMgaW1wbGVtZW50ZWQgaW4gdGhlIHVzZXJzcGFjZSBs
aWtlIFRVTi9UQVAuCj4+Cj4gSSB0aGluayBpdCBjYW4gd29yayBmb3IgbW9zdCBjYXNlcy4gT25l
IHByb2JsZW0gaXMgdGhhdCB0aGUgc2V0X2NvbmZpZwo+IG1pZ2h0IGNoYW5nZSB0aGUgYmVoYXZp
b3Igb2YgdGhlIGRhdGEgcGF0aCBhdCBydW50aW1lLCBlLmcuCj4gdmlydG5ldF9zZXRfbWFjX2Fk
ZHJlc3MoKSBpbiB0aGUgdmlydGlvLW5ldCBkcml2ZXIgYW5kCj4gY2FjaGVfdHlwZV9zdG9yZSgp
IGluIHRoZSB2aXJ0aW8tYmxrIGRyaXZlci4gTm90IHN1cmUgaWYgdGhpcyBwYXRoIGlzCj4gYWJs
ZSB0byByZXR1cm4gYmVmb3JlIHRoZSBkYXRhcGF0aCBpcyBhd2FyZSBvZiB0aGlzIGNoYW5nZS4K
CgpHb29kIHBvaW50LgoKQnV0IHNldF9jb25maWcoKSBzaG91bGQgYmUgcmFyZToKCkUuZyBpbiB0
aGUgY2FzZSBvZiB2aXJ0aW8tbmV0IHdpdGggVkVSU0lPTl8xLCBjb25maWcgc3BhY2UgaXMgcmVh
ZCBvbmx5LCAKYW5kIGl0IHdhcyBzZXQgdmlhIGNvbnRyb2wgdnEuCgpGb3IgYmxvY2ssIHdlIGNh
bgoKMSkgc3RhcnQgZnJvbSB3aXRob3V0IFdDRSBvcgoyKSB3ZSBhZGQgYSBjb25maWcgY2hhbmdl
IG5vdGlmaWNhdGlvbiB0byB1c2Vyc3BhY2Ugb3IKMykgZXh0ZW5kIHRoZSBzcGVjIHRvIHVzZSB2
cSBpbnN0ZWFkIG9mIGNvbmZpZyBzcGFjZQoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
