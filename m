Return-Path: <SRS0=J7vq=KX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B44C47089
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 02:31:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DBC611BD
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 02:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DBC611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41E7140EB0;
	Fri, 28 May 2021 02:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOkqdTC5NOeG; Fri, 28 May 2021 02:31:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9953840EB7;
	Fri, 28 May 2021 02:31:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CE71C0022;
	Fri, 28 May 2021 02:31:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3744C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFEFC82868
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TtrzBdV0zNTa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:31:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 009FC82862
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622169074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EGKgkb8o4xv2IZRZTEVrb1Y1+m/UXhkrrjmtsfSqmQ=;
 b=Dz/+ZFEeytbF90rFAvvFvEM11SvkR+Bzir6ipkQL+h0Qgv1mKT47IvKHXrzKa0L1ZWNaM5
 7G1eFVgEEEZGq/s8kvz7aWmPJCYWWvVv5LYbaXgFrgKJPqb7Zreec26vAJYR3j34WjoTg5
 A/acKWOqXePaQWuxMH/ybMCTL6O4wpA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-fdgNmF7rPNeZJGxL_fwIxw-1; Thu, 27 May 2021 22:31:12 -0400
X-MC-Unique: fdgNmF7rPNeZJGxL_fwIxw-1
Received: by mail-pj1-f71.google.com with SMTP id
 kk5-20020a17090b4a05b029016102a8423cso297470pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 19:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9EGKgkb8o4xv2IZRZTEVrb1Y1+m/UXhkrrjmtsfSqmQ=;
 b=qCDvbdPqdk2yGxfuyfsJcYuWp6fYvd8OmAs6SekSa01sNHKrGjQPGuCNCvrpu983Oj
 D0Ny/wtUjgYElT4leWnmIEthXIY73gQWHF2tb1pfD329mYaYbO1QHjfiugkalI3lwzlV
 4uMPYGS4kd0VQi+qDzMUQo2Sz3V9MPuLsBKgx+GmgvF/zPh6QYrZAjC5v7iLy2zFt2ay
 UedpMcMJ29JDAW78ouguEPjjfK6n9NwGhQQi5xhvo0Bz4KcwWpXkNgN4bkpNfsQ/RU7M
 t1Ixkk0sIhDkJCoHz6kT/XKVEdhDjtwtoskIuAb79B7hQB4Xkvvapl9u+Ln4Lzdc3eWm
 69+A==
X-Gm-Message-State: AOAM53384N0ZbMRqN0GBl3c2GC/jZcnjeSE3zVLgD4LRfWxCgf8XsaHY
 C1EVBrGAy9iSxG+Bl7YfKnrOOiuZD/TmSmPezsgfR7usx7ecW3xNQptk1z0yuUFBZDrwCEmN7EJ
 DpcfN7uN2CEwSk3pkuJ13yrqNk4rIeJBEDJMY372PtA==
X-Received: by 2002:a17:903:1d0:b029:fd:b754:5b8d with SMTP id
 e16-20020a17090301d0b02900fdb7545b8dmr6051973plh.76.1622169071545; 
 Thu, 27 May 2021 19:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3iJPxs/zsjpLpOcecD0zg+TsVkVvFwUGn6NU1wfATInhZz+P2BUuHZdQCGRFkKA1lSiT38Q==
X-Received: by 2002:a17:903:1d0:b029:fd:b754:5b8d with SMTP id
 e16-20020a17090301d0b02900fdb7545b8dmr6051955plh.76.1622169071233; 
 Thu, 27 May 2021 19:31:11 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t14sm2733839pfg.168.2021.05.27.19.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 19:31:10 -0700 (PDT)
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
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
 <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f20edd55-20cb-c016-b347-dd71c5406ed8@redhat.com>
Date: Fri, 28 May 2021 10:31:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3uK_Fuade-b8FVYkGCKZnne_UGGbYRFwv7WOH2oKCsXSg@mail.gmail.com>
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

CuWcqCAyMDIxLzUvMjcg5LiL5Y2IOToxNywgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4gT24gVGh1LCBN
YXkgMjcsIDIwMjEgYXQgNDo0MSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgzOjM0LCBZb25namkgWGllIOWGmemBkzoK
Pj4+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0IDE6NDAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjEvNS8yNyDkuIvljYgxOjA4LCBZb25namkg
WGllIOWGmemBkzoKPj4+Pj4gT24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgMTowMCBQTSBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IOWcqCAyMDIxLzUvMjcg5LiL
5Y2IMTI6NTcsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+Pj4+Pj4+IE9uIFRodSwgTWF5IDI3LCAyMDIx
IGF0IDEyOjEzIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+
Pj4+PiDlnKggMjAyMS81LzE3IOS4i+WNiDU6NTUsIFhpZSBZb25namkg5YaZ6YGTOgo+Pj4+Pj4+
Pj4gKwo+Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgdmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVz
ZV9kZXYgKmRldiwKPj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
dmR1c2VfZGV2X21zZyAqbXNnKQo+Pj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4+ICsgICAgIGluaXRfd2Fp
dHF1ZXVlX2hlYWQoJm1zZy0+d2FpdHEpOwo+Pj4+Pj4+Pj4gKyAgICAgc3Bpbl9sb2NrKCZkZXYt
Pm1zZ19sb2NrKTsKPj4+Pj4+Pj4+ICsgICAgIHZkdXNlX2VucXVldWVfbXNnKCZkZXYtPnNlbmRf
bGlzdCwgbXNnKTsKPj4+Pj4+Pj4+ICsgICAgIHdha2VfdXAoJmRldi0+d2FpdHEpOwo+Pj4+Pj4+
Pj4gKyAgICAgc3Bpbl91bmxvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4+Pj4+Pj4gKyAgICAgd2Fp
dF9ldmVudF9raWxsYWJsZShtc2ctPndhaXRxLCBtc2ctPmNvbXBsZXRlZCk7Cj4+Pj4+Pj4+IFdo
YXQgaGFwcGVucyBpZiB0aGUgdXNlcnNwYWNlKG1hbGljb3VzKSBkb2Vzbid0IGdpdmUgYSByZXNw
b25zZSBmb3JldmVyPwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJdCBsb29rcyBsaWtlIGEgRE9TLiBJZiB5
ZXMsIHdlIG5lZWQgdG8gY29uc2lkZXIgYSB3YXkgdG8gZml4IHRoYXQuCj4+Pj4+Pj4+Cj4+Pj4+
Pj4gSG93IGFib3V0IHVzaW5nIHdhaXRfZXZlbnRfa2lsbGFibGVfdGltZW91dCgpIGluc3RlYWQ/
Cj4+Pj4+PiBQcm9iYWJseSwgYW5kIHRoZW4gd2UgbmVlZCBjaG9vc2UgYSBzdWl0YWJsZSB0aW1l
b3V0IGFuZCBtb3JlIGltcG9ydGFudCwKPj4+Pj4+IG5lZWQgdG8gcmVwb3J0IHRoZSBmYWlsdXJl
IHRvIHZpcnRpby4KPj4+Pj4+Cj4+Pj4+IE1ha2VzIHNlbnNlIHRvIG1lLiBCdXQgaXQgbG9va3Mg
bGlrZSBzb21lCj4+Pj4+IHZkcGFfY29uZmlnX29wcy92aXJ0aW9fY29uZmlnX29wcyBzdWNoIGFz
IHNldF9zdGF0dXMoKSBkaWRuJ3QgaGF2ZSBhCj4+Pj4+IHJldHVybiB2YWx1ZS4gIE5vdyBJIGFk
ZCBhIFdBUk5fT04oKSBmb3IgdGhlIGZhaWx1cmUuIERvIHlvdSBtZWFuIHdlCj4+Pj4+IG5lZWQg
dG8gYWRkIHNvbWUgY2hhbmdlIGZvciB2aXJ0aW8gY29yZSB0byBoYW5kbGUgdGhlIGZhaWx1cmU/
Cj4+Pj4gTWF5YmUsIGJ1dCBJJ20gbm90IHN1cmUgaG93IGhhcmQgd2UgY2FuIGRvIHRoYXQuCj4+
Pj4KPj4+IFdlIG5lZWQgdG8gY2hhbmdlIGFsbCB2aXJ0aW8gZGV2aWNlIGRyaXZlcnMgaW4gdGhp
cyB3YXkuCj4+Cj4+IFByb2JhYmx5Lgo+Pgo+Pgo+Pj4+IFdlIGhhZCBORUVEU19SRVNFVCBidXQg
aXQgbG9va3Mgd2UgZG9uJ3QgaW1wbGVtZW50IGl0Lgo+Pj4+Cj4+PiBDb3VsZCBpdCBoYW5kbGUg
dGhlIGZhaWx1cmUgb2YgZ2V0X2ZlYXR1cmUoKSBhbmQgZ2V0L3NldF9jb25maWcoKT8KPj4KPj4g
TG9va3Mgbm90Ogo+Pgo+PiAiCj4+Cj4+IFRoZSBkZXZpY2UgU0hPVUxEIHNldCBERVZJQ0VfTkVF
RFNfUkVTRVQgd2hlbiBpdCBlbnRlcnMgYW4gZXJyb3Igc3RhdGUKPj4gdGhhdCBhIHJlc2V0IGlz
IG5lZWRlZC4gSWYgRFJJVkVSX09LIGlzIHNldCwgYWZ0ZXIgaXQgc2V0cwo+PiBERVZJQ0VfTkVF
RFNfUkVTRVQsIHRoZSBkZXZpY2UgTVVTVCBzZW5kIGEgZGV2aWNlIGNvbmZpZ3VyYXRpb24gY2hh
bmdlCj4+IG5vdGlmaWNhdGlvbiB0byB0aGUgZHJpdmVyLgo+Pgo+PiAiCj4+Cj4+IFRoaXMgbG9v
a3MgaW1wbGllcyB0aGF0IE5FRURTX1JFU0VUIG1heSBvbmx5IHdvcmsgYWZ0ZXIgZGV2aWNlIGlz
Cj4+IHByb2JlZC4gQnV0IGluIHRoZSBjdXJyZW50IGRlc2lnbiwgZXZlbiB0aGUgcmVzZXQoKSBp
cyBub3QgcmVsaWFibGUuCj4+Cj4+Cj4+Pj4gT3IgYSByb3VnaCBpZGVhIGlzIHRoYXQgbWF5YmUg
bmVlZCBzb21lIHJlbGF4aW5nIHRvIGJlIGNvdXBsZWQgbG9vc2VseQo+Pj4+IHdpdGggdXNlcnNw
YWNlLiBFLmcgdGhlIGRldmljZSAoY29udHJvbCBwYXRoKSBpcyBpbXBsZW1lbnRlZCBpbiB0aGUK
Pj4+PiBrZXJuZWwgYnV0IHRoZSBkYXRhcGF0aCBpcyBpbXBsZW1lbnRlZCBpbiB0aGUgdXNlcnNw
YWNlIGxpa2UgVFVOL1RBUC4KPj4+Pgo+Pj4gSSB0aGluayBpdCBjYW4gd29yayBmb3IgbW9zdCBj
YXNlcy4gT25lIHByb2JsZW0gaXMgdGhhdCB0aGUgc2V0X2NvbmZpZwo+Pj4gbWlnaHQgY2hhbmdl
IHRoZSBiZWhhdmlvciBvZiB0aGUgZGF0YSBwYXRoIGF0IHJ1bnRpbWUsIGUuZy4KPj4+IHZpcnRu
ZXRfc2V0X21hY19hZGRyZXNzKCkgaW4gdGhlIHZpcnRpby1uZXQgZHJpdmVyIGFuZAo+Pj4gY2Fj
aGVfdHlwZV9zdG9yZSgpIGluIHRoZSB2aXJ0aW8tYmxrIGRyaXZlci4gTm90IHN1cmUgaWYgdGhp
cyBwYXRoIGlzCj4+PiBhYmxlIHRvIHJldHVybiBiZWZvcmUgdGhlIGRhdGFwYXRoIGlzIGF3YXJl
IG9mIHRoaXMgY2hhbmdlLgo+Pgo+PiBHb29kIHBvaW50Lgo+Pgo+PiBCdXQgc2V0X2NvbmZpZygp
IHNob3VsZCBiZSByYXJlOgo+Pgo+PiBFLmcgaW4gdGhlIGNhc2Ugb2YgdmlydGlvLW5ldCB3aXRo
IFZFUlNJT05fMSwgY29uZmlnIHNwYWNlIGlzIHJlYWQgb25seSwKPj4gYW5kIGl0IHdhcyBzZXQg
dmlhIGNvbnRyb2wgdnEuCj4+Cj4+IEZvciBibG9jaywgd2UgY2FuCj4+Cj4+IDEpIHN0YXJ0IGZy
b20gd2l0aG91dCBXQ0Ugb3IKPj4gMikgd2UgYWRkIGEgY29uZmlnIGNoYW5nZSBub3RpZmljYXRp
b24gdG8gdXNlcnNwYWNlIG9yCj4gSSBwcmVmZXIgdGhpcyB3YXkuIEFuZCBJIHRoaW5rIHdlIGFs
c28gbmVlZCB0byBkbyBzaW1pbGFyIHRoaW5ncyBmb3IKPiBzZXQvZ2V0X3ZxX3N0YXRlKCkuCgoK
WWVzLCBJIGFncmVlLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
