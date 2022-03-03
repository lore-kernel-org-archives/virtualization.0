Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B8EC433EF
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 07:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07C4660B66;
	Thu,  3 Mar 2022 07:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9RdoILbT-K9; Thu,  3 Mar 2022 07:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FC5460B65;
	Thu,  3 Mar 2022 07:17:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A6E9C0012;
	Thu,  3 Mar 2022 07:17:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 445A4C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23228415C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FmxS_0sPCm0F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3DBF3415C6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646291824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H0L3SjGmJfaTMXO+ul6CF6OQfLAf5NRrsiHYU3r9CA=;
 b=bfVHGYThPpQtYfT50zy6bpZiu9kaoOTwPGzXIYU8WIq9g2uTjXScudAUpCqsB9S6Gap3Y9
 DWSiDYPOh36mjjGsIHAp1YciwlGvb8cZfLpVuhVWxEAO25eivR5oQy+ywFcnLrF+rWz2fq
 mtEksLxJun2L6E8xe4zxOGSHHRin9TM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-elEVZVWNMlKG_eRVmCMfhw-1; Thu, 03 Mar 2022 02:17:01 -0500
X-MC-Unique: elEVZVWNMlKG_eRVmCMfhw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d132-20020a621d8a000000b004f41f34db96so2727408pfd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 23:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0H0L3SjGmJfaTMXO+ul6CF6OQfLAf5NRrsiHYU3r9CA=;
 b=pwJ3mVf5jRwRWOr8VSJFIdFzBOyL7WtCV8NKUxhG6aUr/RK0ngsYqFWZzS18HkvPxQ
 2MSzmWseVfpWhxevlwBaXSx2vQciqTngicbrYkZtk2fexXsBA8grYS/VbgwcjsMQUfHJ
 5D7eN2P4JX+vvhl6mNNClLIhKky2FXR8F7pHBqE7pLqti5nrvk+sVLBK7DJ7D3crBoC3
 h2X+SRRbcEs9G4dm8jWTFiLzZfIuGzRjawYqqn8tm8lDgrQsgSd21R5z9clR4g85JhZZ
 21RHqrqBXJ+6RmSgAFH2jKq5wjJrK29NaeAVM7bi2SPpUFjHF6E9VrU2MPkmkl2PjWkQ
 j+HA==
X-Gm-Message-State: AOAM532gSwa7LlPZEpaJXieK9yZOaqQJPTNg8Awm2zIx77gSHXRlLbFU
 GZ3qh2+zPfW3Q3kxo3POTO0w0Tilm6XapNbmUPvqG3n1qxq60c9eQoDCcuKS1y1miL2XugjegpE
 QsrnWK1h3/3dgODD+tI4NGBmA5EWWCUjm14TKHV0x+g==
X-Received: by 2002:a17:90a:348f:b0:1be:d738:9736 with SMTP id
 p15-20020a17090a348f00b001bed7389736mr3879519pjb.65.1646291820145; 
 Wed, 02 Mar 2022 23:17:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwExVb68VLibKFtVtm0ABMSPom1oZ1FYvaBLMbZvGIGdrSLVsm5Ud9yT3aUIhANHq1AQ9KEGw==
X-Received: by 2002:a17:90a:348f:b0:1be:d738:9736 with SMTP id
 p15-20020a17090a348f00b001bed7389736mr3879501pjb.65.1646291819894; 
 Wed, 02 Mar 2022 23:16:59 -0800 (PST)
Received: from [10.72.13.250] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a056a00235400b004e192221ec2sm1431601pfj.14.2022.03.02.23.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 23:16:59 -0800 (PST)
Message-ID: <57cede59-97ba-10b0-01e0-c94b9907a903@redhat.com>
Date: Thu, 3 Mar 2022 15:16:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 08/14] util: Add iova_tree_alloc
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-9-eperezma@redhat.com>
 <7829cc8d-66d0-cedd-eca5-f899cd5ecd07@redhat.com>
 <CAJaqyWdNWqpdBQ-iTWLu7fH0prHPo8Uc1LXkEKvQ4X6cp7_TOA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWdNWqpdBQ-iTWLu7fH0prHPo8Uc1LXkEKvQ4X6cp7_TOA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Lingshan <lingshan.zhu@intel.com>
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

CuWcqCAyMDIyLzMvMSDkuIvljYg2OjA2LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4+
PiArCj4+PiArICAgIC8qCj4+PiArICAgICAqIEZpbmQgYSB2YWxpZCBob2xlIGZvciB0aGUgbWFw
cGluZwo+Pj4gKyAgICAgKgo+Pj4gKyAgICAgKiBBc3N1bWluZyBsb3cgaW92YV9iZWdpbiwgc28g
bm8gbmVlZCB0byBkbyBhIGJpbmFyeSBzZWFyY2ggdG8KPj4+ICsgICAgICogbG9jYXRlIHRoZSBm
aXJzdCBub2RlLgo+Pj4gKyAgICAgKgo+Pj4gKyAgICAgKiBUT0RPOiBSZXBsYWNlIGFsbCB0aGlz
IHdpdGggZ190cmVlX25vZGVfZmlyc3QvbmV4dC9sYXN0IHdoZW4gYXZhaWxhYmxlCj4+PiArICAg
ICAqIChmcm9tIGdsaWIgc2luY2UgMi42OCkuIFRvIGRvIGl0IHdpdGggZ190cmVlX2ZvcmVhY2gg
Y29tcGxpY2F0ZXMgdGhlCj4+PiArICAgICAqIGNvZGUgYSBsb3QuCj4+PiArICAgICAqCj4+IE9u
ZSBtb3JlIHF1ZXN0aW9uCj4+Cj4+IFRoZSBjdXJyZW50IGNvZGUgbG9va3Mgd29yayBidXQgc3Rp
bGwgYSBsaXR0bGUgYml0IGNvbXBsaWNhdGVkIHRvIGJlCj4+IHJldmlld2VkLiBMb29raW5nIGF0
IHRoZSBtaXNzaW5nIGhlbHBlcnMgYWJvdmUsIGlmIHRoZSBhZGQgYW5kIHJlbW92ZQo+PiBhcmUg
c2VsZG9tLiBJIHdvbmRlciBpZiB3ZSBjYW4gc2ltcGx5IGRvCj4+Cj4+IGdfdHJlZV9mb3JlYWNo
KCkgZHVyaW5nIGVhY2ggYWRkL2RlbCB0byBidWlsZCBhIHNvcnRlZCBsaXN0IHRoZW4gd2UgY2Fu
Cj4+IGVtdWxhdGUgZ190cmVlX25vZGVfZmlyc3QvbmV4dC9sYXN0IGVhc2lseT8KPj4KPiBUaGlz
IHNvdW5kcyBhIGxvdCBsaWtlIHRoZSBtZXRob2QgaW4gdjEgWzFdOikuCgoKT2gsIHJpZ2h0LiBJ
IG1pc3NlZCB0aGF0IGFuZCBpdCB0YWtlcyB0aW1lIHRvIHJlY292ZXIgdGhlIG1lbW9yeS4KCgo+
Cj4gQnV0IGl0IGRpZG4ndCB1c2UgdGhlIE8oTikgZm9yZWFjaCwgc2luY2Ugd2UgY2FuIGxvY2F0
ZSB0aGUgbmV3IG5vZGUncwo+IHByZXZpb3VzIGVsZW1lbnQgbG9va2luZyBmb3IgdGhlIHVwcGVy
IGJvdW5kIG9mIGlvdmEtMSwgbWFpbnRhaW5pbmcKPiB0aGUgaW5zZXJ0aW9uJ3MgY29tcGxleGl0
eSBPKGxvZyhOKSkuIFRoZSBmdW5jdGlvbiBnX3RyZWVfdXBwZXJfYm91bmQKPiBpcyBhZGRlZCBp
biBHbGliIHZlcnNpb24gMi42OCwgc28gdGhlIHByb3Bvc2VkIHZlcnNpb24gd2lsbCBiZSBkZWxl
dGVkCj4gc29vbmVyIG9yIGxhdGVyLgo+Cj4gQWxzbyB0aGUgZGVsZXRpb24ga2VlcHMgYmVpbmcg
Tyhsb2coTikpIHNpbmNlIGRlbGV0aW5nIGEgbm9kZSBpbiBRTElTVCBpcyBPKDEpLgoKClllcywg
c28gSSB0aGluayB3ZSBjYW4gbGVhdmUgdGhlIGxvZyBhcyBpcyBhbmQgZG8gb3B0aW1pemF0aW9u
IG9uIHRvcC4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
