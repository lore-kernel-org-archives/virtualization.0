Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A823C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 09:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DD8061519;
	Thu, 23 Mar 2023 09:50:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DD8061519
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwQR9eok
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id naRrLfr_YCUh; Thu, 23 Mar 2023 09:50:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0AD9461511;
	Thu, 23 Mar 2023 09:50:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AD9461511
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1B97C0071;
	Thu, 23 Mar 2023 09:50:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE84C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B11E61515
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B11E61515
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WgZZg5anv5Ee
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:50:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B569E61511
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B569E61511
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679565021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XERu7jFbdY1Uu35G9bxCU6ajLW1FJ5w92clS/0dwz/w=;
 b=LwQR9eokPsIfcNgU1dsZWzYfapfOWLARCFnboLvxpqkF8efHcS3wnSrvYATTDchqFWubpJ
 JGTs6KUeFRckC/FigM+a1Zyb/nI/EbKzv6fPpjBg/Iijc5N3F4r/wIo4GoF/Jf5T96P+Yp
 rSH5ostTHkjadRM3Hdvtiyp/3j5xWp4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-_OxJ1RbvO9myc8I1q5hjhg-1; Thu, 23 Mar 2023 05:50:12 -0400
X-MC-Unique: _OxJ1RbvO9myc8I1q5hjhg-1
Received: by mail-qv1-f72.google.com with SMTP id
 g6-20020ad45426000000b005a33510e95aso10603438qvt.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679565012;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XERu7jFbdY1Uu35G9bxCU6ajLW1FJ5w92clS/0dwz/w=;
 b=VUn04nlb06io38u6Vex7tpmX/t00ZjQWot1NLsK8sFPlv4E8RozwCe+emYlyZBikAN
 UfV2k3VF8E4vVtXCNSGSh9t2eeQ/1bFQVvyUoot/nW2YhJ+JxbnvEpx9YBVGbo8+qNjR
 VPNO93psF30k0GUX3g9LF+SNPXVrJtAoFNLi64YA5u2OouTSNlUoXjQDBjrUqepPgoPZ
 CNFn3TGjaqFeDhRmmnyC/73JIrH5TXK3pL3jVp71fFdKcrM4SDaGIcX66/HyPikAhOHV
 UO7jn12+ZYpUVa3+Yn11wDBjQrGmCZdRw4l9ZCBLDvUPO/96vaLiDx+4ffxvUGmi/ZtQ
 UCGQ==
X-Gm-Message-State: AO0yUKX5rsZBGLGRWySrwWhvbimODpCeGye+MBy2AydVrhTICnofpORo
 8eYOSb2ht6Y6rzF/GAvrFroXxU2YDWPoylmo1byxz7AzeMcMARFDMc3ksyWL+CIAomgHRlcgTqW
 EMjlTw8ClXhyD2ixVbVT2zUTAXanYqLTnqUGUUJnUmA==
X-Received: by 2002:a05:6214:23c7:b0:56e:abb8:b656 with SMTP id
 hr7-20020a05621423c700b0056eabb8b656mr7134170qvb.7.1679565012266; 
 Thu, 23 Mar 2023 02:50:12 -0700 (PDT)
X-Google-Smtp-Source: AK7set+QwTH7mkA2d88CDuEA5u4qe58JMiq4f/fwPX1oT/BguD3EV9srXmDNSfnJZru9uKMxtXB43w==
X-Received: by 2002:a05:6214:23c7:b0:56e:abb8:b656 with SMTP id
 hr7-20020a05621423c700b0056eabb8b656mr7134160qvb.7.1679565011978; 
 Thu, 23 Mar 2023 02:50:11 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 4-20020a05620a048400b007468bf8362esm7179339qkr.66.2023.03.23.02.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 02:50:11 -0700 (PDT)
Date: Thu, 23 Mar 2023 10:50:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 8/8] vdpa_sim: add support for user VA
Message-ID: <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
References: <20230321154804.184577-1-sgarzare@redhat.com>
 <20230321154804.184577-4-sgarzare@redhat.com>
 <CACGkMEtbrt3zuqy9YdhNyE90HHUT1R=HF-YRAQ6b4KnW_SdZ-w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtbrt3zuqy9YdhNyE90HHUT1R=HF-YRAQ6b4KnW_SdZ-w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMTE6NDI6MDdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFR1ZSwgTWFyIDIxLCAyMDIzIGF0IDExOjQ44oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxh
IDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPj4KPj4gVGhlIG5ldyAidXNlX3ZhIiBtb2R1
bGUgcGFyYW1ldGVyIChkZWZhdWx0OiB0cnVlKSBpcyB1c2VkIGluCj4+IHZkcGFfYWxsb2NfZGV2
aWNlKCkgdG8gaW5mb3JtIHRoZSB2RFBBIGZyYW1ld29yayB0aGF0IHRoZSBkZXZpY2UKPj4gc3Vw
cG9ydHMgVkEuCj4+Cj4+IHZyaW5naCBpcyBpbml0aWFsaXplZCB0byB1c2UgVkEgb25seSB3aGVu
ICJ1c2VfdmEiIGlzIHRydWUgYW5kIHRoZQo+PiB1c2VyJ3MgbW0gaGFzIGJlZW4gYm91bmQuIFNv
LCBvbmx5IHdoZW4gdGhlIGJ1cyBzdXBwb3J0cyB1c2VyIFZBCj4+IChlLmcuIHZob3N0LXZkcGEp
Lgo+Pgo+PiB2ZHBhc2ltX21tX3dvcmtfZm4gd29yayBpcyB1c2VkIHRvIHNlcmlhbGl6ZSB0aGUg
YmluZGluZyB0byBhIG5ldwo+PiBhZGRyZXNzIHNwYWNlIHdoZW4gdGhlIC5iaW5kX21tIGNhbGxi
YWNrIGlzIGludm9rZWQsIGFuZCB1bmJpbmRpbmcKPj4gd2hlbiB0aGUgLnVuYmluZF9tbSBjYWxs
YmFjayBpcyBpbnZva2VkLgo+Pgo+PiBDYWxsIG1tZ2V0X25vdF96ZXJvKCkva3RocmVhZF91c2Vf
bW0oKSBpbnNpZGUgdGhlIHdvcmtlciBmdW5jdGlvbgo+PiB0byBwaW4gdGhlIGFkZHJlc3Mgc3Bh
Y2Ugb25seSBhcyBsb25nIGFzIG5lZWRlZCwgZm9sbG93aW5nIHRoZQo+PiBkb2N1bWVudGF0aW9u
IG9mIG1tZ2V0KCkgaW4gaW5jbHVkZS9saW51eC9zY2hlZC9tbS5oOgo+Pgo+PiAgICogTmV2ZXIg
dXNlIHRoaXMgZnVuY3Rpb24gdG8gcGluIHRoaXMgYWRkcmVzcyBzcGFjZSBmb3IgYW4KPj4gICAq
IHVuYm91bmRlZC9pbmRlZmluaXRlIGFtb3VudCBvZiB0aW1lLgo+Cj5JIHdvbmRlciBpZiBldmVy
eXRoaW5nIHdvdWxkIGJlIHNpbXBsaWZpZWQgaWYgd2UganVzdCBhbGxvdyB0aGUgcGFyZW50Cj50
byBhZHZlcnRpc2Ugd2hldGhlciBvciBub3QgaXQgcmVxdWlyZXMgdGhlIGFkZHJlc3Mgc3BhY2Uu
Cj4KPlRoZW4gd2hlbiB2aG9zdC12RFBBIHByb2JlcyB0aGUgZGV2aWNlIGl0IGNhbiBzaW1wbHkg
YWR2ZXJ0aXNlCj51c2Vfd29yayBhcyB0cnVlIHNvIHZob3N0IGNvcmUgY2FuIHVzZSBnZXRfdGFz
a19tbSgpIGluIHRoaXMgY2FzZT8KCklJVUMgc2V0IHVzZXJfd29ya2VyIHRvIHRydWUsIGl0IGFs
c28gY3JlYXRlcyB0aGUga3RocmVhZCBpbiB0aGUgdmhvc3QKY29yZSAoYnV0IHdlIGNhbiBhZGQg
YW5vdGhlciB2YXJpYWJsZSB0byBhdm9pZCB0aGlzKS4KCk15IGJpZ2dlc3QgY29uY2VybiBpcyB0
aGUgY29tbWVudCBpbiBpbmNsdWRlL2xpbnV4L3NjaGVkL21tLmguCmdldF90YXNrX21tKCkgdXNl
cyBtbWdldCgpLCBidXQgaW4gdGhlIGRvY3VtZW50YXRpb24gdGhleSBhZHZpc2UgYWdhaW5zdApw
aW5uaW5nIHRoZSBhZGRyZXNzIHNwYWNlIGluZGVmaW5pdGVseSwgc28gSSBwcmVmZXJyZWQgaW4g
a2VlcGluZwptbWdyYWIoKSBpbiB0aGUgdmhvc3QgY29yZSwgdGhlbiBjYWxsIG1tZ2V0X25vdF96
ZXJvKCkgaW4gdGhlIHdvcmtlcgpvbmx5IHdoZW4gaXQgaXMgcnVubmluZy4KCkluIHRoZSBmdXR1
cmUgbWF5YmUgbW0gd2lsbCBiZSB1c2VkIGRpZmZlcmVudGx5IGZyb20gcGFyZW50IGlmIHNvbWVo
b3cKaXQgaXMgc3VwcG9ydGVkIGJ5IGlvbW11LCBzbyBJIHdvdWxkIGxlYXZlIGl0IHRvIHRoZSBw
YXJlbnQgdG8gaGFuZGxlCnRoaXMuCgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
