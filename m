Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECF2C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 08:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2DA661035;
	Wed,  9 Mar 2022 08:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTRFXZ-JWLwr; Wed,  9 Mar 2022 08:07:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 715C760F53;
	Wed,  9 Mar 2022 08:07:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB2FC001D;
	Wed,  9 Mar 2022 08:07:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E31C3C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D08EF4011A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YhifVy21KAjX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:07:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDAEC4002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646813268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IXuEicy64jzYCxNamwmtmwVtyYt/lRqVjQKpT7Nv/M=;
 b=Z48eH9Ogfmhh5aaQBcQLip3JC3ZnxNPmAJWiEEsjJJd7NJdzmOFYA31tUBq0vF7VRK1h3M
 m1qEHRcg2FxtKHBSTHGxgisPYpSsbwQ0RIGI6YgHJ6y/uga7VtiGae8H8uxKAxnxgg9PQF
 BrLoYUfbr/d0BHXK5ZI95dzaHKNzyK8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-0WT_-C71OpCH0dBF8UrT2Q-1; Wed, 09 Mar 2022 03:07:47 -0500
X-MC-Unique: 0WT_-C71OpCH0dBF8UrT2Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 b9-20020a17090aa58900b001b8b14b4aabso1122970pjq.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 00:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2IXuEicy64jzYCxNamwmtmwVtyYt/lRqVjQKpT7Nv/M=;
 b=6CcTyn5H0J5ufY7HG5odkmRI7lMyoH7SbbJq27t1gpTWhu55wb9wcBysG0+jHomVLI
 YWAlF4hDAceoodQvWq+cY435OfRaaXcEFBFGzGB2NVwt8sg5kwa8FZOVRIOatvnsN2oj
 et9ETCSkGe47pP6gsqUhRWdZOjWUZlXGxiGJLbXSEDlTAosjYb+/Dug6PFS8bc9qilCk
 aHqpeQM0CXGPk0XLDio8LxZysHcMANCfBFjbH00mUzXOo6zJGbW7QNlo7FwYJF5WIWqv
 vlc0I1BwdpF+857WWV6dw1ohw/EWJj3W987FLuwlT/L6oP9kGAsNe0bO0J+mkXWEDO0q
 PeTw==
X-Gm-Message-State: AOAM530+fIqEWfS/CeaEOr/PQgZhYp/pEhumI77tlOzHHEGXz6fF5bhA
 oHjNNQVKWuZWcPv01vOHPAya1iBYpvsQhMjZKCP28+zUg6KnfZEKeNJDm6d5HVJPIvGQLRkoFur
 1XAF7UcCNuvck3rIPuugBi+wfKUUqkCR1R9pRfPUIWQ==
X-Received: by 2002:a17:902:7895:b0:14b:6b63:b3fa with SMTP id
 q21-20020a170902789500b0014b6b63b3famr21356523pll.156.1646813266616; 
 Wed, 09 Mar 2022 00:07:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6DQIqLtQqTfMFPUpM5F+dRCjUh++/2gbXxGyBJdGCkQYoqOQWjpvpTenZNYBY0ODISfgXEQ==
X-Received: by 2002:a17:902:7895:b0:14b:6b63:b3fa with SMTP id
 q21-20020a170902789500b0014b6b63b3famr21356497pll.156.1646813266263; 
 Wed, 09 Mar 2022 00:07:46 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a056a0014d500b004f7261ad03esm1702804pfu.35.2022.03.09.00.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 00:07:45 -0800 (PST)
Message-ID: <1755f8e1-358b-b515-c51c-c2aa7bd0dd28@redhat.com>
Date: Wed, 9 Mar 2022 16:07:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v4 0/4] vdpa tool enhancements
To: Eli Cohen <elic@nvidia.com>, stephen@networkplumber.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 dsahern@kernel.org
References: <20220302065444.138615-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220302065444.138615-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: si-wei.liu@oracle.com, lulu@redhat.com, mst@redhat.com
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

CuWcqCAyMDIyLzMvMiDkuIvljYgyOjU0LCBFbGkgQ29oZW4g5YaZ6YGTOgo+IEhpIFN0ZXBoZW4s
Cj4KPiB0aGlzIGlzIGEgcmVzZW5kIG9mIHYzIHdoaWNoIG9taXR0ZWQgeW91IGFuZCBuZXRkZXYg
ZnJvbSB0aGUgcmVjZXBpZW50Cj4gbGlzdC4gSSBhZGRlZCBhIGZldyAiYWNrZWQtYnkiIGFuZCBj
YWxsZWQgaXQgdjQuCj4KPiBUaGUgZm9sbG93aW5nIGZvdXIgcGF0Y2ggc2VyaWVzIGVuaGFuY2Vz
IHZkcGEgdG8gc2hvdyBuZWdvdGlhdGVkCj4gZmVhdHVyZXMgZm9yIGEgdmRwYSBkZXZpY2UsIG1h
eCBmZWF0dXJlcyBmb3IgYSBtYW5hZ2VtZW50IGRldmljZSBhbmQKPiBhbGxvd3MgdG8gY29uZmln
dXJlIG1heCBudW1iZXIgb2YgdmlydHF1ZXVlIHBhaXJzLgo+Cj4gdjMtPnY0Ogo+IFJlc2VuZCB0
aGUgcGF0Y2hlcyB3aXRoIGFkZGVkICJBY2tlZC1ieSIgdG8gdGhlIHJpZ2h0IG1haWxpbmcgbGlz
dC4KCgpIZWxsbyBtYWludGFpbmVyczoKCkFueSBjb21tZW50IG9uIHRoZSBzZXJpZXM/IFdlIHdh
bnQgdG8gaGF2ZSB0aGlzIGZvciB0aGUgbmV4dCBSSEVMIHJlbGVhc2UuCgpUaGFua3MKCgo+Cj4g
RWxpIENvaGVuICg0KToKPiAgICB2ZHBhOiBSZW1vdmUgdW5zdXBwb3J0ZWQgY29tbWFuZCBsaW5l
IG9wdGlvbgo+ICAgIHZkcGE6IEFsbG93IGZvciBwcmludGluZyBuZWdvdGlhdGVkIGZlYXR1cmVz
IG9mIGEgZGV2aWNlCj4gICAgdmRwYTogU3VwcG9ydCBmb3IgY29uZmlndXJpbmcgbWF4IFZRIHBh
aXJzIGZvciBhIGRldmljZQo+ICAgIHZkcGE6IFN1cHBvcnQgcmVhZGluZyBkZXZpY2UgZmVhdHVy
ZXMKPgo+ICAgdmRwYS9pbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oIHwgICA0ICsKPiAgIHZkcGEv
dmRwYS5jICAgICAgICAgICAgICAgICAgICB8IDE1MSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQ4IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
