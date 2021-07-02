Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB686C11F68
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 03:25:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AB6613F2
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 03:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AB6613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26B4F40121;
	Fri,  2 Jul 2021 03:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KPEBsyliaYQ3; Fri,  2 Jul 2021 03:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8FA4405A0;
	Fri,  2 Jul 2021 03:25:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC815C001A;
	Fri,  2 Jul 2021 03:25:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D4C2C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E52860AC3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:25:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19Zi7bgUkz-k
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:25:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6087460ABD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625196329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnDTUBO/qel2LJGKzNIBMBJoNluIIwfxXdRX1zb5ugw=;
 b=J70ABlfAwp1L+cw7X3P3zfZuH0NLheuvuME5xzNrrcBDcBguoeWPAvnNxmg367MsZfrzeF
 9o3oXqrGQ7HyVCr2Om0PRMCNp4A7eTpf8ckDZTIyeBnvabVFPhOwDB8ocPJmkRkWmcAsTZ
 qKOg0koJSlHIMLMElrPYOirPL3g1LDU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-0XI5fYLnNseGYx4plVFGJA-1; Thu, 01 Jul 2021 23:25:26 -0400
X-MC-Unique: 0XI5fYLnNseGYx4plVFGJA-1
Received: by mail-pg1-f200.google.com with SMTP id
 j15-20020a633c0f0000b02902283104f77cso3460423pga.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jul 2021 20:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KnDTUBO/qel2LJGKzNIBMBJoNluIIwfxXdRX1zb5ugw=;
 b=caM4DbeCCO+qN7UDff24BsXRFVzcEgEHooNA3qcuqoRSRAeBHg0iXl7FRBGGE7hHhz
 pTCdmnRmHRc/BDBoHYibj8eFESh0uGBE14Cboist+yj4NOnZLXAJI2vrZ4gjqMbhGklw
 myss/zRO6ZVJq1ZhltkNtOhUmJ4YATmsyQp8bQf6s/VLscoAL7HLti/h6/kgEqhHRoL2
 np96kGUTyQz6P1fYRYFcssnlbUaQI27mA73X5bTHQbb+vL1uagVDsWt7Cum9l094Ei+V
 wrATxVQfR/N7AcsN3JJFnGnKRn2xBpZzyfw7Vz0NE0ZDmwaqiReQT5DzNEpVbIAnC//Y
 xx6Q==
X-Gm-Message-State: AOAM533wBDkCmvoMojUYKVWI6X8O702J7fPd20qn+E/l85CA2LxFdp+s
 mRZmCRAMYl0TePrCI68S3hWqGjPtrgJRc9la6CfCCrgtAEl6xqMYEgimsyLAwQUkZNsINpEcF7y
 ajPOzCKnsNYbOoeIoYBsPCiRmCSomogABTn7rZNP26g==
X-Received: by 2002:a05:6a00:174e:b029:308:35eb:4593 with SMTP id
 j14-20020a056a00174eb029030835eb4593mr3353637pfc.8.1625196324989; 
 Thu, 01 Jul 2021 20:25:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKMQl/tw5Kx6FHOmk54WvFeYF610dbfRRBBaUlCrS6TkxAlUSkb5jlHy46VzHh0+l9ZFtiag==
X-Received: by 2002:a05:6a00:174e:b029:308:35eb:4593 with SMTP id
 j14-20020a056a00174eb029030835eb4593mr3353600pfc.8.1625196324718; 
 Thu, 01 Jul 2021 20:25:24 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p17sm11147627pjg.54.2021.07.01.20.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jul 2021 20:25:23 -0700 (PDT)
Subject: Re: [PATCH v8 09/10] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-10-xieyongji@bytedance.com>
 <YNSatrDFsg+4VvH4@stefanha-x1.localdomain>
 <CACycT3vaXQ4dxC9QUzXXJs7og6TVqqVGa8uHZnTStacsYAiFwQ@mail.gmail.com>
 <YNw+q/ADMPviZi6S@stefanha-x1.localdomain>
 <CACycT3t6M5i0gznABm52v=rdmeeLZu8smXAOLg+WsM3WY1fgTw@mail.gmail.com>
 <7264cb0b-7072-098e-3d22-2b7e89216545@redhat.com>
 <CACycT3v7pYXAFtijPgWCMZ2WXxjT2Y-DUwS3hN_T7dhfE5o_6g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c7d3473c-f855-166b-f4da-47be5a329859@redhat.com>
Date: Fri, 2 Jul 2021 11:25:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACycT3v7pYXAFtijPgWCMZ2WXxjT2Y-DUwS3hN_T7dhfE5o_6g@mail.gmail.com>
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
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com,
 Jens Axboe <axboe@kernel.dk>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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

CuWcqCAyMDIxLzcvMSDkuIvljYg2OjI2LCBZb25namkgWGllIOWGmemBkzoKPiBPbiBUaHUsIEp1
bCAxLCAyMDIxIGF0IDM6NTUgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IOWcqCAyMDIxLzcvMSDkuIvljYgyOjUwLCBZb25namkgWGllIOWGmemBkzoKPj4+
IE9uIFdlZCwgSnVuIDMwLCAyMDIxIGF0IDU6NTEgUE0gU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPiB3cm90ZToKPj4+PiBPbiBUdWUsIEp1biAyOSwgMjAyMSBhdCAxMDo1OTo1
MUFNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+Pj4+PiBPbiBNb24sIEp1biAyOCwgMjAyMSBh
dCA5OjAyIFBNIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+
Pj4+PiBPbiBUdWUsIEp1biAxNSwgMjAyMSBhdCAxMDoxMzozMFBNICswODAwLCBYaWUgWW9uZ2pp
IHdyb3RlOgo+Pj4+Pj4+ICsvKiBpb2N0bHMgKi8KPj4+Pj4+PiArCj4+Pj4+Pj4gK3N0cnVjdCB2
ZHVzZV9kZXZfY29uZmlnIHsKPj4+Pj4+PiArICAgICBjaGFyIG5hbWVbVkRVU0VfTkFNRV9NQVhd
OyAvKiB2ZHVzZSBkZXZpY2UgbmFtZSAqLwo+Pj4+Pj4+ICsgICAgIF9fdTMyIHZlbmRvcl9pZDsg
LyogdmlydGlvIHZlbmRvciBpZCAqLwo+Pj4+Pj4+ICsgICAgIF9fdTMyIGRldmljZV9pZDsgLyog
dmlydGlvIGRldmljZSBpZCAqLwo+Pj4+Pj4+ICsgICAgIF9fdTY0IGZlYXR1cmVzOyAvKiBkZXZp
Y2UgZmVhdHVyZXMgKi8KPj4+Pj4+PiArICAgICBfX3U2NCBib3VuY2Vfc2l6ZTsgLyogYm91bmNl
IGJ1ZmZlciBzaXplIGZvciBpb21tdSAqLwo+Pj4+Pj4+ICsgICAgIF9fdTE2IHZxX3NpemVfbWF4
OyAvKiB0aGUgbWF4IHNpemUgb2YgdmlydHF1ZXVlICovCj4+Pj4+PiBUaGUgVklSVElPIHNwZWNp
ZmljYXRpb24gYWxsb3dzIHBlci12aXJ0cXVldWUgc2l6ZXMuIEEgZGV2aWNlIGNhbiBoYXZlCj4+
Pj4+PiB0d28gdmlydHF1ZXVlcywgd2hlcmUgdGhlIGZpcnN0IG9uZSBhbGxvd3MgdXAgdG8gMTAy
NCBkZXNjcmlwdG9ycyBhbmQKPj4+Pj4+IHRoZSBzZWNvbmQgb25lIGFsbG93cyBvbmx5IDEyOCBk
ZXNjcmlwdG9ycywgZm9yIGV4YW1wbGUuCj4+Pj4+Pgo+Pj4+PiBHb29kIHBvaW50ISBCdXQgaXQg
bG9va3MgbGlrZSB2aXJ0aW8tdmRwYS92aXJ0aW8tcGNpIGRvZXNuJ3Qgc3VwcG9ydAo+Pj4+PiB0
aGF0IG5vdy4gQWxsIHZpcnRxdWV1ZXMgaGF2ZSB0aGUgc2FtZSBtYXhpbXVtIHNpemUuCj4+Pj4g
SSBzZWUgc3RydWN0IHZwZGFfY29uZmlnX29wcyBvbmx5IHN1cHBvcnRzIGEgcGVyLWRldmljZSBt
YXggdnEgc2l6ZToKPj4+PiB1MTYgKCpnZXRfdnFfbnVtX21heCkoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2KTsKPj4+Pgo+Pj4+IHZpcnRpby1wY2kgc3VwcG9ydHMgcGVyLXZpcnRxdWV1ZSBzaXpl
cyBiZWNhdXNlIHRoZSBzdHJ1Y3QKPj4+PiB2aXJ0aW9fcGNpX2NvbW1vbl9jZmctPnF1ZXVlX3Np
emUgcmVnaXN0ZXIgaXMgcGVyLXF1ZXVlIChjb250cm9sbGVkIGJ5Cj4+Pj4gcXVldWVfc2VsZWN0
KS4KPj4+Pgo+Pj4gT2gsIHllcy4gSSBtaXNzIHF1ZXVlX3NlbGVjdC4KPj4+Cj4+Pj4gSSBndWVz
cyB0aGlzIGlzIGEgcXVlc3Rpb24gZm9yIEphc29uOiB3aWxsIHZkcGEgd2lsbCBrZWVwIHRoaXMg
bGltaXRhdGlvbj8KPj4+PiBJZiB5ZXMsIHRoZW4gVkRVU0UgY2FuIHN0aWNrIHRvIGl0IHRvbyB3
aXRob3V0IHJ1bm5pbmcgaW50byBwcm9ibGVtcyBpbgo+Pj4+IHRoZSBmdXR1cmUuCj4+Cj4+IEkg
dGhpbmsgaXQncyBiZXR0ZXIgdG8gZXh0ZW5kIHRoZSBnZXRfdnFfbnVtX21heCgpIHBlciB2aXJ0
cXVldWUuCj4+Cj4+IEN1cnJlbnRseSwgdkRQQSBhc3N1bWVzIHRoZSBwYXJlbnQgdG8gaGF2ZSBh
IGdsb2JhbCBtYXggc2l6ZS4gVGhpcyBzZWVtcwo+PiB0byB3b3JrIG9uIG1vc3Qgb2YgdGhlIHBh
cmVudHMgYnV0IG5vdCB2cC12RFBBICh3aGljaCBjb3VsZCBiZSBiYWNrZWQgYnkKPj4gUUVNVSwg
aW4gdGhhdCBjYXNlIGN2cSdzIHNpemUgaXMgc21hbGxlcikuCj4+Cj4+IEZvcnR1bmF0ZWx5LCB3
ZSBoYXZlbid0IGVuYWJsZWQgaGFkIGN2cSBzdXBwb3J0IGluIHRoZSB1c2Vyc3BhY2Ugbm93Lgo+
Pgo+PiBJIGNhbiBwb3N0IHRoZSBmaXhlcy4KPj4KPiBPSy4gSWYgc28sIGl0IGxvb2tzIGxpa2Ug
d2UgbmVlZCB0byBzdXBwb3J0IHRoZSBwZXItdnEgY29uZmlndXJhdGlvbi4KPiBJIHdvbmRlciBp
ZiBpdCdzIGJldHRlciB0byB1c2Ugc29tZXRoaW5nIGxpa2U6IFZEVVNFX0NSRUFURV9ERVZJQ0Ug
LT4KPiBWRFVTRV9TRVRVUF9WUSAtPiBWRFVTRV9TRVRVUF9WUSAtPiAuLi4gLT4gVkRVU0VfRU5B
QkxFX0RFVklDRSB0byBkbwo+IGluaXRpYWxpemF0aW9uIHJhdGhlciB0aGFuIG9ubHkgdXNlIFZE
VVNFX0NSRUFURV9ERVZJQ0UuCgoKVGhpcyBzaG91bGQgYmUgZmluZS4KClRoYW5rcwoKCj4KPiBU
aGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
