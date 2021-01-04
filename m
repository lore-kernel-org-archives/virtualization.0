Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2BBC433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 20:18:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7D3221F8
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 20:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7D3221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44AF7863A6;
	Mon,  4 Jan 2021 20:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZGAEhKNW8dG; Mon,  4 Jan 2021 20:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D50286004;
	Mon,  4 Jan 2021 20:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10B5BC0893;
	Mon,  4 Jan 2021 20:18:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E031DC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB6C420485
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aZocyCr9q7Ou
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:18:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3CD9F2047A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 20:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609791498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmpJGv4TG2+177t1uzCmYIaOzWqm0wQxr8JJ8qGFelU=;
 b=FK/vZ1U87aE/GT2wKRZTIFY66MRODkHTgq8i381aKj0NdiXdAlr+/dYDVVoKRIewNAf70w
 /6WtLnvzeWQfuZHQCDQnIOQiGL6w3QkeANvPkXV3xaNtPXe3z9fkR24XxV8kq2IQjUhIwZ
 fIYy0SzYg2JhC2URsBeKHRXdO3bjcrU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-msiZ9BbrOgWuYQtT_c5XJg-1; Mon, 04 Jan 2021 15:18:16 -0500
X-MC-Unique: msiZ9BbrOgWuYQtT_c5XJg-1
Received: by mail-wr1-f71.google.com with SMTP id o12so13733239wrq.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jan 2021 12:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=sL80W/bpndKTkJr6XATsXD1MBTH0F9B9dG84CxK2Xe0=;
 b=hDiESTsMJc8cqjiq8MGGrt5FL993l5LLRgOeq0hy/X3D5tUo84yUUysTi5DbTfnQ5y
 qc7sdfp7Dwjya4Vvbf5AgH13c7HdMbusV96OJprNo5C4A8xfWwmPd70yfaWhLEo7rka/
 cTwMx2PgYORyjBbAhM6TfC57IIuWX+/zyqGEOIDH26T8eBXxoViJFLCNlcw8YO0MncbC
 pxC3l5CIQ+6UbVLT/rUelus1VSAUkNxNow2LRf8TLEPxuo47J+rXeRCEyyac0pML4zrw
 Q0TtPlOwZW2ECD9H9S7Us3bA20ledkiWdJzt5L1agp5RgCaM3jRLiQk9UJczJ45Fe8lv
 cxzw==
X-Gm-Message-State: AOAM533IObd4est5B8aO95QU3ImKSYNVhY7ocBuR4DyfzChS3ygo3GDX
 9t6aYQPNk8hHuJ9u1kBbr3hdOUgMyUX1kHzWrV5Owjn3gM+X5S5jx8eqIcqOIzZPy/ODsQKb4fE
 AJtGdJ0cwQK/cZKdLjSrRpwutkwOWsNMyqGWMCww5Uw==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr54719776wrr.319.1609791495697; 
 Mon, 04 Jan 2021 12:18:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwx4gy5JFxjZnXjZPAl6stC7zCwsld9QLtkKU+syXPFvA2bF6Ji0oL2rXc4WQQ0vvJ9VuptQQ==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr54719760wrr.319.1609791495539; 
 Mon, 04 Jan 2021 12:18:15 -0800 (PST)
Received: from [192.168.3.108] (p5b0c69d7.dip0.t-ipconnect.de. [91.12.105.215])
 by smtp.gmail.com with ESMTPSA id h9sm845757wme.11.2021.01.04.12.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jan 2021 12:18:15 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
Date: Mon, 4 Jan 2021 21:18:14 +0100
Message-Id: <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com>
References: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
In-Reply-To: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
To: Liang Li <liliang324@gmail.com>
X-Mailer: iPhone Mail (18C66)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Liang Li <liliangleo@didiglobal.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Cj4gQW0gMjMuMTIuMjAyMCB1bSAxMzoxMiBzY2hyaWViIExpYW5nIExpIDxsaWxpYW5nMzI0QGdt
YWlsLmNvbT46Cj4gCj4g77u/T24gV2VkLCBEZWMgMjMsIDIwMjAgYXQgNDo0MSBQTSBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+IAo+PiBbLi4uXQo+PiAKPj4+
PiBJIHdhcyByYXRoZXIgc2F5aW5nIHRoYXQgZm9yIHNlY3VyaXR5IGl0J3Mgb2YgbGl0dGxlIHVz
ZSBJTUhPLgo+Pj4+IEFwcGxpY2F0aW9uL1ZNIHN0YXJ0IHVwIHRpbWUgbWlnaHQgYmUgaW1wcm92
ZWQgYnkgdXNpbmcgaHVnZSBwYWdlcyAoYW5kCj4+Pj4gcHJlLXplcm9pbmcgdGhlc2UpLiBGcmVl
IHBhZ2UgcmVwb3J0aW5nIG1pZ2h0IGJlIGltcHJvdmVkIGJ5IHVzaW5nCj4+Pj4gTUFEVl9GUkVF
IGluc3RlYWQgb2YgTUFEVl9ET05UTkVFRCBpbiB0aGUgaHlwZXJ2aXNvci4KPj4+PiAKPj4+Pj4g
dGhpcyBmZWF0dXJlLCBhYm92ZSBhbGwgb2YgdGhlbSwgd2hpY2ggb25lIGlzIGxpa2VseSB0byBi
ZWNvbWUgdGhlCj4+Pj4+IG1vc3Qgc3Ryb25nIG9uZT8gIEZyb20gdGhlIGltcGxlbWVudGF0aW9u
LCB5b3Ugd2lsbCBmaW5kIGl0IGlzCj4+Pj4+IGNvbmZpZ3VyYWJsZSwgdXNlcnMgZG9uJ3Qgd2Fu
dCB0byB1c2UgaXQgY2FuIHR1cm4gaXQgb2ZmLiAgVGhpcyBpcyBub3QKPj4+Pj4gYW4gb3B0aW9u
Pwo+Pj4+IAo+Pj4+IFdlbGwsIHdlIGhhdmUgdG8gbWFpbnRhaW4gdGhlIGZlYXR1cmUgYW5kIHNh
Y3JpZmljZSBhIHBhZ2UgZmxhZy4gRm9yCj4+Pj4gZXhhbXBsZSwgZG8gd2UgZXhwZWN0IHNvbWVv
bmUgZXhwbGljaXRseSBlbmFibGluZyB0aGUgZmVhdHVyZSBqdXN0IHRvCj4+Pj4gc3BlZWQgdXAg
c3RhcnR1cCB0aW1lIG9mIGFuIGFwcCB0aGF0IGNvbnN1bWVzIGEgbG90IG9mIG1lbW9yeT8gSSBo
aWdobHkKPj4+PiBkb3VidCBpdC4KPj4+IAo+Pj4gSW4gb3VyIHByb2R1Y3Rpb24gZW52aXJvbm1l
bnQsIHRoZXJlIGFyZSB0aHJlZSBtYWluIGFwcGxpY2F0aW9ucyBoYXZlIHN1Y2gKPj4+IHJlcXVp
cmVtZW50LCBvbmUgaXMgUUVNVSBbY3JlYXRpbmcgYSBWTSB3aXRoIFNSLUlPViBwYXNzdGhyb3Vn
aCBkZXZpY2VdLAo+Pj4gYW50aGVyIG90aGVyIHR3byBhcmUgRFBESyByZWxhdGVkIGFwcGxpY2F0
aW9ucywgRFBESyBPVlMgYW5kIFNQREsgdmhvc3QsCj4+PiBmb3IgYmVzdCBwZXJmb3JtYW5jZSwg
dGhleSBwb3B1bGF0ZSBtZW1vcnkgd2hlbiBzdGFydGluZyB1cC4gRm9yIFNQREsgdmhvc3QsCj4+
PiB3ZSBtYWtlIHVzZSBvZiB0aGUgVkhPU1RfVVNFUl9HRVQvU0VUX0lORkxJR0hUX0ZEIGZlYXR1
cmUgZm9yCj4+PiB2aG9zdCAnbGl2ZScgdXBncmFkZSwgd2hpY2ggaXMgZG9uZSBieSBraWxsaW5n
IHRoZSBvbGQgcHJvY2VzcyBhbmQKPj4+IHN0YXJ0aW5nIGEgbmV3Cj4+PiBvbmUgd2l0aCB0aGUg
bmV3IGJpbmFyeS4gSW4gdGhpcyBjYXNlLCB3ZSB3YW50IHRoZSBuZXcgcHJvY2VzcyBzdGFydGVk
IGFzIHF1aWNrCj4+PiBhcyBwb3NzaWJsZSB0byBzaG9ydGVuIHRoZSBzZXJ2aWNlIGRvd250aW1l
LiBXZSByZWFsbHkgZW5hYmxlIHRoaXMgZmVhdHVyZQo+Pj4gdG8gc3BlZWQgdXAgc3RhcnR1cCB0
aW1lIGZvciB0aGVtICA6KQoKQW0gSSB3cm9uZyBvciBkb2VzIHVzaW5nIGh1Z2VsdGJmcy90bXBm
cyAuLi4gaS5lLiwgYSBmaWxlIG5vdC1kZWxldGVkIGJldHdlZW4gc2h1dHRpbmcgZG93biB0aGUg
b2xkIGluc3RhbmNlcyBhbmQgZmlyaW5nIHVwIHRoZSBuZXcgaW5zdGFuY2UganVzdCBzb2x2ZSB0
aGlzIGlzc3VlPwoKPj4gCj4+IFRoYW5rcyBmb3IgaW5mbyBvbiB0aGUgdXNlIGNhc2UhCj4+IAo+
PiBBbGwgb2YgdGhlc2UgdXNlIGNhc2VzIGVpdGhlciBhbHJlYWR5IHVzZSwgb3IgY291bGQgdXNl
LCBodWdlIHBhZ2VzCj4+IElNSE8uIEl0J3Mgbm90IHlvdXIgb3JkaW5hcnkgcHJvcHJpZXRhcnkg
Z2FtaW5nIGFwcCA6KSBUaGlzIGlzIHdoZXJlCj4+IHByZS16ZXJvaW5nIG9mIGh1Z2UgcGFnZXMg
Y291bGQgYWxyZWFkeSBoZWxwLgo+IAo+IFlvdSBhcmUgd2VsY29tZS4gIEZvciBzb21lIGhpc3Rv
cmljYWwgcmVhc29uLCBzb21lIG9mIG91ciBzZXJ2aWNlcyBhcmUKPiBub3QgdXNpbmcgaHVnZXRs
YmZzLCB0aGF0IGlzIHdoeSBJIGRpZG4ndCBzdGFydCB3aXRoIGh1Z2V0bGJmcy4KPiAKPj4gSnVz
dCB3b25kZXJpbmcsIHdvdWxkbid0IGl0IGJlIHBvc3NpYmxlIHRvIHVzZSB0bXBmcy9odWdldGxi
ZnMgLi4uCj4+IGNyZWF0aW5nIGEgZmlsZSBhbmQgcHJlLXplcm9pbmcgaXQgZnJvbSBhbm90aGVy
IHByb2Nlc3MsIG9yIGFtIEkgbWlzc2luZwo+PiBzb21ldGhpbmcgaW1wb3J0YW50PyBBdCBsZWFz
dCBmb3IgUUVNVSB0aGlzIHNob3VsZCB3b3JrIEFGQUlLLCB3aGVyZSB5b3UKPj4gY2FuIGp1c3Qg
cGFzcyB0aGUgZmlsZSB0byBiZSB1c2UgdXNpbmcgbWVtb3J5LWJhY2tlbmQtZmlsZS4KPj4gCj4g
SWYgdXNpbmcgYW5vdGhlciBwcm9jZXNzIHRvIGNyZWF0ZSBhIGZpbGUsIHdlIGNhbiBvZmZsb2Fk
IHRoZSBvdmVyaGVhZCB0bwo+IGFub3RoZXIgcHJvY2VzcywgYW5kIHRoZXJlIGlzIG5vIG5lZWQg
dG8gcHJlLXplcm9pbmcgaXQncyBjb250ZW50LCBqdXN0Cj4gcG9wdWxhdGluZyB0aGUgbWVtb3J5
IGlzIGVub3VnaC4KClJpZ2h0LCBpZiBub24temVybyBtZW1vcnkgY2FuIGJlIHRvbGVyYXRlZCAo
ZS5nLiwgZm9yIHZtcyB1c3VhbGx5IGhhcyB0bykuCgo+IElmIHdlIGRvIGl0IHRoYXQgd2F5LCB0
aGVuIGhvdyB0byBkZXRlcm1pbmUgdGhlIHNpemUgb2YgdGhlIGZpbGU/IGl0IGRlcGVuZHMKPiBv
biB0aGUgUkFNIHNpemUgb2YgdGhlIFZNIHRoZSBjdXN0b21lciBidXlzLgo+IE1heWJlIHdlIGNh
biBjcmVhdGUgYSBmaWxlCj4gbGFyZ2UgZW5vdWdoIGluIGFkdmFuY2UgYW5kIHRydW5jYXRlIGl0
IHRvIHRoZSByaWdodCBzaXplIGp1c3QgYmVmb3JlIHRoZQo+IFZNIGlzIGNyZWF0ZWQuIFRoZW4s
IGhvdyBtYW55IGxhcmdlIGZpbGVzIHNob3VsZCBiZSBjcmVhdGVkIG9uIGEgaG9zdD8KClRoYXTi
gJhzIG1vc3RseSBhbHJlYWR5IGV4aXN0aW5nIHNjaGVkdWxpbmcgbG9naWMsIG5vPyAoSG93IG1h
bnkgdm1zIGNhbiBJIHB1dCBvbnRvIGEgc3BlY2lmaWMgbWFjaGluZSBldmVudHVhbGx5KQoKPiBZ
b3Ugd2lsbCBmaW5kIHRoZXJlIGFyZSBhIGxvdCBvZiB0aGluZ3MgdGhhdCBoYXZlIHRvIGJlIGhh
bmRsZWQgcHJvcGVybHkuCj4gSSB0aGluayBpdCdzIHBvc3NpYmxlIHRvIG1ha2UgaXQgd29yayB3
ZWxsLCBidXQgd2Ugd2lsbCB0cmFuc2ZlciB0aGUKPiBtYW5hZ2VtZW50IGNvbXBsZXhpdHkgdG8g
dXAgbGF5ZXIgY29tcG9uZW50cy4gSXQncyBhIGJhZCBwcmFjdGljZSB0byBsZXQKPiB1cHBlciBs
YXllciBjb21wb25lbnRzIHByb2Nlc3Mgc3VjaCBsb3cgbGV2ZWwgZGV0YWlscyB3aGljaCBzaG91
bGQgYmUKPiBoYW5kbGVkIGluIHRoZSBPUyBsYXllci4KCkl04oCYcyBiYWQgcHJhY3RpY2UgdG8g
c3F1ZWV6ZSB0aGluZ3MgaW50byB0aGUga2VybmVsIHRoYXQgY2FuIGp1c3QgYmUgaGFuZGxlZCBv
biB1cHBlciBsYXllcnMgOykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
