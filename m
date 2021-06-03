Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C37C47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:15:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C34613E6
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C34613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2AC48344C;
	Thu,  3 Jun 2021 07:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n1luxh0Uyhfz; Thu,  3 Jun 2021 07:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24DB183542;
	Thu,  3 Jun 2021 07:15:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F157EC000D;
	Thu,  3 Jun 2021 07:15:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5544C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B658383CB1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6dtwsEAjiBBM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:14:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEDA88344C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622704497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnbuU0fDADScyN4D+Z91sdr8ftGo7PShkTKmw8niS1s=;
 b=aA9dQ+bV4tLvjeSPO2NdHw8HdVrkiBGhY2CK+qTGcvq62fh/u3lHc/80EpI4r9owUSzc7K
 mOwD2dSz4Lp1l4/nFxCZQLykaW4YNGYt7QIVkWCjhJQeNvdb2QHbs0ra8idz8DlQcBUoXu
 BmNjQkWcCtXo1FLG6FJObMGC0Jel9wA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-nw_5cf-JNQynJ6VEBtv77g-1; Thu, 03 Jun 2021 03:14:55 -0400
X-MC-Unique: nw_5cf-JNQynJ6VEBtv77g-1
Received: by mail-pf1-f197.google.com with SMTP id
 d17-20020aa781510000b02902e921bdea05so2985195pfn.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 00:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=nnbuU0fDADScyN4D+Z91sdr8ftGo7PShkTKmw8niS1s=;
 b=NnJtZF1XBaLbaFjhhnF+dlctLBD/2i/HDYhdfeKmqDIOzVPjoXtmQ7qQsZKNZnyoE9
 7vd1WWJX++04yaQkzMzE1NvnjnLOuTpI+bKiaBC4263TvEp6QK6Xl3kBGDdweyMzzh4Z
 VQeCO+lWcgjsv/uiWup0Twq5OFapC6XShw0sWoKnSDPKat05pGov6cb89DkVBZ5pzuy9
 27WHYthEkhBE3FBWiTzgjek87PF41UAk8ZFUCJQZp9LjJurwcNzeLLkt9QFV3ea0qxav
 ZHp6ZJxIqwm/0RHoHPy66Hz4h84xqHsZdpOWNnTzVxxozCADkk+1WAn3wvCbxsSbpDBC
 IJag==
X-Gm-Message-State: AOAM531BAD+M2xh08XvQ81Tegi2iVz3MaNzgCNWHD2Ni4F7/FIQzRt4T
 oXoZ/iaLn08WN/Vg75yCtuJCUvbYYN7HubWODcByIKFy0Gf2NJR/xHoaFgcZH5miKyJFmwCijDP
 XQMRyMNudn0g7J3YTVRauWDJgMfX0oa61PxeZwkOsLQ==
X-Received: by 2002:a17:902:7205:b029:ed:6fc0:bbd4 with SMTP id
 ba5-20020a1709027205b02900ed6fc0bbd4mr34978948plb.4.1622704494547; 
 Thu, 03 Jun 2021 00:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcMf1yi5YrM3ZQ0E6Vd9YMsWvJYGeeRw+gZHSHDc3E71UInsJbTim5M4WExk813zBaqHxkoQ==
X-Received: by 2002:a17:902:7205:b029:ed:6fc0:bbd4 with SMTP id
 ba5-20020a1709027205b02900ed6fc0bbd4mr34978932plb.4.1622704494247; 
 Thu, 03 Jun 2021 00:14:54 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c130sm1454035pfc.51.2021.06.03.00.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 00:14:53 -0700 (PDT)
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To: Eli Cohen <elic@nvidia.com>
References: <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
 <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
 <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
 <20210511061740-mutt-send-email-mst@kernel.org>
 <CACGkMEuvqUL04_wHqSKPUufu5O6ydhytHAx0NryLODNHkEO+Fw@mail.gmail.com>
 <20210602103025.GA17279@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c885b2e2-0f90-d215-27c7-02f0d1527991@redhat.com>
Date: Thu, 3 Jun 2021 15:14:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602103025.GA17279@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: mapfelba@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Lingshan Zhu <lingshan.zhu@intel.com>
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

CuWcqCAyMDIxLzYvMiDkuIvljYg2OjMwLCBFbGkgQ29oZW4g5YaZ6YGTOgo+IE9uIFdlZCwgTWF5
IDEyLCAyMDIxIGF0IDA1OjI0OjIxUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBNaWNo
YWVsLAo+IERpZCB5b3UgYW5kIEphc29uIGNhbWUgaW50byBhZ3JlZW1lbnQgcmVnYXJkaW5nIHRo
aXM/CgoKUHJvYmFibHksIGxldCBtZSBzZW5kIGEgZm9ybWFsIHBhdGNoIGFuZCBzZWUgd2hhdCBo
YXBwZW5zLgoKVGhhbmtzCgoKPiBEbyB5b3UgdGhpbmsgd2UKPiBjYW4gaGF2ZSB0aGUgYml0cyBp
biA1LjEzIGFuZCBzdGlsbCBoYXZlIHRpbWUgZm9yIG1lIHRvIHB1c2ggdGhlIHZkcGEKPiB0b28g
c3R1ZmY/Cj4KPgo+PiBPbiBXZWQsIE1heSAxMiwgMjAyMSBhdCAzOjU0IFBNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4gT24gVHVlLCBNYXkgMTEsIDIwMjEg
YXQgMDQ6NDM6MTNBTSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pgo+Pj4+IC0tLS0tIOWO
n+Wni+mCruS7tiAtLS0tLQo+Pj4+PiDlnKggMjAyMS80LzIxIOS4i+WNiDQ6MDMsIE1pY2hhZWwg
Uy4gVHNpcmtpbiDlhpnpgZM6Cj4+Pj4+PiBPbiBXZWQsIEFwciAyMSwgMjAyMSBhdCAwMzo0MToz
NlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+IOWcqCAyMDIxLzQvMTIg5LiL5Y2I
NToyMywgSmFzb24gV2FuZyDlhpnpgZM6Cj4+Pj4+Pj4+IOWcqCAyMDIxLzQvMTIg5LiL5Y2INTow
OSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPj4+Pj4+Pj4+IE9uIE1vbiwgQXByIDEyLCAy
MDIxIGF0IDAyOjM1OjA3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pj4+Pj4g5Zyo
IDIwMjEvNC8xMCDkuIrljYgxMjowNCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPj4+Pj4+
Pj4+Pj4gT24gRnJpLCBBcHIgMDksIDIwMjEgYXQgMTI6NDc6NTVQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPj4+Pj4+Pj4+Pj4+IOWcqCAyMDIxLzQvOCDkuIvljYgxMTo1OSwgTWljaGFlbCBT
LiBUc2lya2luIOWGmemBkzoKPj4+Pj4+Pj4+Pj4+PiBPbiBUaHUsIEFwciAwOCwgMjAyMSBhdCAw
NDoyNjo0OFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+Pj4+Pj4+PiBUaGlzIHBh
dGNoIG1hbmRhdGVzIDEuMCBmb3IgdkRQQSBkZXZpY2VzLiBUaGUgZ29hbCBpcyB0byBoYXZlIHRo
ZQo+Pj4+Pj4+Pj4+Pj4+PiBzZW1hbnRpYyBvZiBub3JtYXRpdmUgc3RhdGVtZW50IGluIHRoZSB2
aXJ0aW8KPj4+Pj4+Pj4+Pj4+Pj4gc3BlYyBhbmQgZWxpbWluYXRlIHRoZQo+Pj4+Pj4+Pj4+Pj4+
PiBidXJkZW4gb2YgdHJhbnNpdGlvbmFsIGRldmljZSBmb3IgYm90aCB2RFBBIGJ1cyBhbmQgdkRQ
QSBwYXJlbnQuCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IHVBUEkgc2VlbXMgZmluZSBz
aW5jZSBhbGwgdGhlIHZEUEEgcGFyZW50IG1hbmRhdGVzCj4+Pj4+Pj4+Pj4+Pj4+IFZJUlRJT19G
X0FDQ0VTU19QTEFURk9STSB3aGljaCBpbXBsaWVzIDEuMCBkZXZpY2VzLgo+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+PiBGb3IgbGVnYWN5IGd1ZXN0cywgaXQgY2FuIHN0aWxsIHdvcmsgc2lu
Y2UgUWVtdSB3aWxsIG1lZGlhdGUgd2hlbgo+Pj4+Pj4+Pj4+Pj4+PiBuZWNlc3NhcnkgKGUuZyBk
b2luZyB0aGUgZW5kaWFuIGNvbnZlcnNpb24pLgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4+
Pj4+Pj4+IEhtbS4gSWYgd2UgZG8gdGhpcywgZG9uJ3Qgd2Ugc3RpbGwgaGF2ZSBhIHByb2JsZW0g
d2l0aAo+Pj4+Pj4+Pj4+Pj4+IGxlZ2FjeSBkcml2ZXJzIHdoaWNoIGRvbid0IGFjayAxLjA/Cj4+
Pj4+Pj4+Pj4+PiBZZXMsIGJ1dCBpdCdzIG5vdCBzb21ldGhpbmcgdGhhdCBpcyBpbnRyb2R1Y2Vk
IGluIHRoaXMKPj4+Pj4+Pj4+Pj4+IGNvbW1pdC4gVGhlIGxlZ2FjeQo+Pj4+Pj4+Pj4+Pj4gZHJp
dmVyIG5ldmVyIHdvcmsgLi4uCj4+Pj4+Pj4+Pj4+IE15IHBvaW50IGlzIHRoaXMgbmVpdGhlciBm
aXhlcyBvciBwcmV2ZW50cyB0aGlzLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBTbyBteSBzdWdn
ZXN0aW9uIGlzIHRvIGZpbmFsbHkgYWRkIGlvY3RscyBhbG9uZyB0aGUgbGluZXMKPj4+Pj4+Pj4+
Pj4gb2YgUFJPVE9DT0xfRkVBVFVSRVMgb2Ygdmhvc3QtdXNlci4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4gVGhlbiB0aGF0IG9uZSBjYW4gaGF2ZSBiaXRzIGZvciBsZWdhY3kgbGUsIGxlZ2FjeSBi
ZSBhbmQgbW9kZXJuLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBCVFcgSSBsb29rZWQgYXQgdmhv
c3QtdXNlciBhbmQgaXQgZG9lcyBub3QgbG9vayBsaWtlIHRoYXQKPj4+Pj4+Pj4+Pj4gaGFzIGEg
c29sdXRpb24gZm9yIHRoaXMgcHJvYmxlbSBlaXRoZXIsIHJpZ2h0Pwo+Pj4+Pj4+Pj4+IFJpZ2h0
Lgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBOb3RlIDEuMCBhZmZlY3RzIHJp
bmcgZW5kaWFubmVzcyB3aGljaCBpcyBub3QgbWVkaWF0ZWQgaW4gUUVNVQo+Pj4+Pj4+Pj4+Pj4+
IHNvIFFFTVUgY2FuJ3QgcHJldGVuZCB0byBkZXZpY2UgZ3Vlc3QgaXMgMS4wLgo+Pj4+Pj4+Pj4+
Pj4gUmlnaHQsIEkgcGxhbiB0byBzZW5kIHBhdGNoZXMgdG8gZG8gbWVkaWF0aW9uIGluIHRoZQo+
Pj4+Pj4+Pj4+Pj4gUWVtdSB0byB1bmJyZWFrIGxlZ2FjeQo+Pj4+Pj4+Pj4+Pj4gZHJpdmVycy4K
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBUaGFua3MKPj4+Pj4+Pj4+Pj4gSSBmcmFua2x5IHRo
aW5rIHdlJ2xsIG5lZWQgUFJPVE9DT0xfRkVBVFVSRVMgYW55d2F5LCBpdCdzCj4+Pj4+Pj4+Pj4+
IHRvbyB1c2VmdWwgLi4uCj4+Pj4+Pj4+Pj4+IHNvIHdoeSBub3QgdGVhY2ggZHJpdmVycyBhYm91
dCBpdCBhbmQgYmUgZG9uZSB3aXRoIGl0PyBZb3UKPj4+Pj4+Pj4+Pj4gY2FuJ3QgZW11bGF0ZQo+
Pj4+Pj4+Pj4+PiBsZWdhY3kgb24gbW9kZXJuIGluIGEgY3Jvc3MgZW5kaWFuIHNpdHVhdGlvbiBi
ZWNhdXNlIG9mIHZyaW5nCj4+Pj4+Pj4+Pj4+IGVuZGlhbi1uZXNzIC4uLgo+Pj4+Pj4+Pj4+IFNv
IHRoZSBwcm9ibGVtIHN0aWxsLiBUaGlzIGNhbiBvbmx5IHdvcmsgd2hlbiB0aGUgaGFyZHdhcmUg
Y2FuIHN1cHBvcnQKPj4+Pj4+Pj4+PiBsZWdhY3kgdnJpbmcgZW5kaWFuLW5lc3MuCj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+PiBDb25zaWRlcjoKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IDEpIHRoZSBsZWFn
Y3kgZHJpdmVyIHN1cHBvcnQgaXMgbm9uLW5vcm1hdGl2ZSBpbiB0aGUgc3BlYwo+Pj4+Pj4+Pj4+
IDIpIHN1cHBvcnQgYSB0cmFuc2l0aW9uYWwgZGV2aWNlIGluIHRoZSBrZW5yZWwgbWF5IHJlcXVp
cmVzIHRoZQo+Pj4+Pj4+Pj4+IGhhcmR3YXJlCj4+Pj4+Pj4+Pj4gc3VwcG9ydCBhbmQgYSBidXJk
ZW4gb2Yga2VybmVsIGNvZGVzCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBJJ2QgcmF0aGVyIHNpbXBs
eSBkcm9wIHRoZSBsZWdhY3kgZHJpdmVyIHN1cHBvcnQKPj4+Pj4+Pj4+IE15IHBvaW50IGlzIHRo
aXMgcGF0Y2ggZG9lcyBub3QgZHJvcCBsZWdhY3kgc3VwcG9ydC4gSXQgbWVyZWx5IG1hbmRhdGVz
Cj4+Pj4+Pj4+PiBtb2Rlcm4gc3VwcG9ydC4KPj4+Pj4+Pj4gSSBhbSBub3Qgc3VyZSBJIGdldCBo
ZXJlLiBUaGlzIHBhdGNoIGZhaWxzIHRoZSBzZXRfZmVhdHVyZSBpZiBWRVJTSU9OXzEKPj4+Pj4+
Pj4gaXMgbm90IG5lZ290aWF0ZWQuIFRoaXMgbWVhbnM6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IDEpIHZE
UEEgcHJlc2VudHMgYSBtb2Rlcm4gZGV2aWNlIGluc3RlYWQgb2YgdHJhbnNpdG9uYWwgZGV2aWNl
Cj4+Pj4+Pj4+IDIpIGxlZ2FjeSBkcml2ZXIgY2FuJ3QgYmUgcHJvYmVkCj4+Pj4+Pj4+Cj4+Pj4+
Pj4+IFdoYXQgSSdtIG1pc3Npbmc/Cj4+Pj4+Pj4gSGkgTWljaGFlbDoKPj4+Pj4+Pgo+Pj4+Pj4+
IERvIHlvdSBhZ3JlZSB0byBmaW5kIHRoZSB3YXkgdG8gcHJlc2VudCBtb2Rlcm4gZGV2aWNlPyBX
ZSBuZWVkIGEKPj4+Pj4+PiBjb25jbHVzaW9uCj4+Pj4+Pj4gdG8gbWFrZSB0aGUgbmV0bGluayBB
UEkgd29yayB0byBtb3ZlIGZvcndhcmQuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGFua3MKPj4+Pj4+IEkg
dGhpbmsgd2UgbmVlZCBhIHdheSB0byBzdXBwb3J0IGxlZ2FjeSB3aXRoIG5vIGRhdGEgcGF0aCBv
dmVyaGVhZC4gcWVtdQo+Pj4+Pj4gc2V0dGluZyBWRVJTSU9OXzEgZm9yIGEgbGVnYWN5IGd1ZXN0
IGFmZmVjdHMgdGhlIHJpbmcgZm9ybWF0IHNvIGl0IGRvZXMKPj4+Pj4+IG5vdCByZWFsbHkgd29y
ay4gVGhpcyBzZWVtcyB0byBydWxlIG91dCBlbXVsYXRpbmcgY29uZmlnIHNwYWNlIGVudGlyZWx5
Cj4+Pj4+PiBpbiB1c2Vyc3BhY2UuCj4+Pj4+Cj4+Pj4+IFNvIEknZCByYXRoZXIgZHJvcCB0aGUg
bGVnYWN5IHN1cHBvcnQgaW4gdGhpcyBjYXNlLiBJdCBuZXZlciB3b3JrIGZvcgo+Pj4+PiB2RFBB
IGluIHRoZSBwYXN0IGFuZCB2aXJ0aW8tdkRQQSBkb2Vzbid0IGV2ZW4gbmVlZCB0aGF0LiBOb3Rl
IHRoYXQKPj4+Pj4gQUNDRVNTX1BMQVRGT1JNIGlzIG1hbmRhdGVkIGZvciBhbGwgdGhlIHZEUEEg
cGFyZW50cyByaWdodCBub3cgd2hpY2gKPj4+Pj4gaW1wbGllcyBtb2Rlcm4gZGV2aWNlIGFuZCBM
RS4gSSB3b25kZXIgd2hhdCdzIHRoZSB2YWx1ZSBmb3Igc3VwcG9ydGluZwo+Pj4+PiBsZWdhY3kg
aW4gdGhpcyBjYXNlIG9yIGRvIHdlIHJlYWxseSBlbmNvdXJhZ2UgdmVuZG9ycyB0byBzaGlwIGNh
cmQgd2l0aAo+Pj4+PiBsZWdhY3kgc3VwcG9ydCAoZS5nIGVuZGlhbiBzdXBwb3J0IGluIHRoZSBo
YXJkd2FyZSk/Cj4+Pj4gSGkgTWljaGFlbDoKPj4+Pgo+Pj4+IEFueSB0aG91Z2h0cyBvbiB0aGlz
IGFwcHJvYWNoPwo+Pj4+Cj4+Pj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGRyb3BwaW5nIGxl
Z2FjeSBzdXBwb3J0IHdpbGwgc2ltcGxpZnkgYSBsb3Qgb2Ygc3R1ZmZzLgo+Pj4+Cj4+Pj4gVGhh
bmtzCj4+PiBTbyBiYXNpY2FsbHkgdGhlIG1haW4gY29uZGl0aW9uIGlzIHRoYXQgc3Ryb25nIG1l
bW9yeSBiYXJyaWVycyBhcmVuJ3QKPj4+IG5lZWRlZCBmb3IgdmlydGlvLCBzbXAgYmFycmllcnMg
YXJlIGVub3VnaC4KPj4+IEFyZSB0aGVyZSBhcmNoaXRlY3R1cmVzIGJlc2lkZXMgeDg2ICh3aGVy
ZSBpdCdzIGtpbmQgb2YgdHJ1ZSAtIGFzIGxvbmcgYXMKPj4+IG9uZSBkb2VzIG5vdCB1c2Ugbm9u
LXRlbXBvcmFscykgd2hlcmUgdGhhdCBpcyB0cnVlPwo+Pj4gSWYgYWxsIHRoZXNlIGFyY2hpdGVj
dHVyZXMgYXJlIExFIHRoZW4gd2UgZG9uJ3QgbmVlZCB0byB3b3JyeQo+Pj4gYWJvdXQgZW5kaWFu
IHN1cHBvcnQgaW4gdGhlIGhhcmR3YXJlLgo+PiBTbyBJIGFncmVlIGl0J3MgYmV0dGVyIG5vdCB0
byBhZGQgdGhvc2Ugc3R1ZmZzIGluIGVpdGhlciBxZW11IG9yCj4+IGtlcm5lbC4gU2VlIGJlbG93
Lgo+Pgo+Pj4gSW4gb3RoZXIgd29yZHMgSSBndWVzcyB5ZXMgd2UgY291bGQgaGF2ZSBxZW11IGxp
bWl0IHRoaW5ncyB0byB4ODYgYW5kCj4+PiB0aGVuIGp1c3QgcHJldGVuZCB0byB0aGUgY2FyZCB0
aGF0IGl0J3MgdmlydGlvIDEuCj4+PiBTbyBlbmRpYW4tbmVzcyB3ZSBjYW4gYWRkcmVzcy4KPj4+
Cj4+PiBQcm9ibGVtIGlzIHZpcnRpbyAxIGhhcyBlZmZlY3RzIGJleW9uZCB0aGlzLiB0aGluZ3Mg
bGlrZSBoZWFkZXIgc2l6ZQo+Pj4gd2l0aCBtZXJnZWFibGUgYnVmZmVycyBvZmYgZm9yIHZpcnRp
byBuZXQuCj4+Pgo+Pj4gU28gSSBhbSBpbmNsaW5lZCB0byBzYXkgbGV0IHVzIG5vdCBkbyB0aGUg
InByZXRlbmQgaXQncyB2aXJ0aW8gMSIgZ2FtZQo+Pj4gaW4gcWVtdS4KPj4gSSBmdWxseSBhZ3Jl
ZS4KPj4KPj4gICAgTGV0IHVzIGJlIGhvbmVzdCB0byB0aGUgY2FyZCBhYm91dCB3aGF0IGhhcHBl
bnMuCj4+PiBCdXQgaWYgeW91IHdhbnQgdG8gbGltaXQgdGhpbmdzIHRvIHg4NiBlaXRoZXIgaW4g
a2VybmVsIG9yIGluIHFlbXUsCj4+PiB0aGF0J3Mgb2sgYnkgbWUuCj4+IFNvIHdoYXQgSSB3YW50
IHRvIGRvIGlzOgo+Pgo+PiAxKSBtYW5kYXRlIDEuMCBkZXZpY2Ugb24gdGhlIGtlcm5lbAo+PiAy
KSBkb24ndCB0cnkgdG8gcHJldGVuZCB0cmFuc2l0aW9uYWwgb3IgbGVnYWN5IGRldmljZSBvbiB0
b3Agb2YgbW9kZXJuCj4+IGRldmljZSBpbiBRZW11LCBzbyBxZW11IHdpbGwgZmFpbCB0byBzdGFy
dCBpZiB2aG9zdC12RFBBIGlzIHN0YXJ0ZWQKPj4gd2l0aCBhIGxlZ2FjeSBvciB0cmFuc2l0aW9u
YWwgZGV2aWNlCj4+Cj4+IEFuZCB0aGlzIHNpbXBseSB0aGUgbWFuYWdlbWVudCBBUEkgd2hpY2gg
Y2FuIGFzc3VtZSBMRSBmb3IKPj4gcHJlLWNvbmZpZ3VyYXRpb24gdmlhIGNvbmZpZyBzcGFjZS4K
Pj4KPj4gU28gaWYgSSdtIG5vdCBtaXN1bmRlcnN0YW5kaW5nLCB3ZSBjYW4gbWVyZ2UgdGhpcyBw
YXRjaCBhbmQgSSBjYW4gZG8KPj4gdGhlIFFlbXUgd29yayBvbiB0b3A/Cj4+Cj4+IFRoYW5rcwo+
Pgo+Pj4+Pgo+Pj4+Pj4gU28gSSB0aGluayB3ZSBzaG91bGQgYWRkIGFuIGlvY3RsIGFsb25nIHRo
ZSBsaW5lcyBvZgo+Pj4+Pj4gcHJvdG9jb2wgZmVhdHVyZXMuIFRoZW4gSSB0aGluayB3ZSBjYW4g
cmVzZXJ2ZSBmZWF0dXJlIGJpdHMKPj4+Pj4+IGZvciBjb25maWcgc3BhY2UgZm9ybWF0OiBsZWdh
Y3kgTEUsIGxlZ2FjeSBCRSwgbW9kZXJuLgo+Pj4+Pgo+Pj4+PiBXZSBoYWQgVkhPU1RfU0VUX1ZS
SU5HX0VORElBTiBidXQgdGhpcyB3aWxsIGNvbXBsaWNhdGVzIGJvdGggdGhlIHZEUEEKPj4+Pj4g
cGFyZW50IGFuZCBtYW5hZ2VtZW50LiBXaGF0J3MgbW9yZSBpbXBvcnRhbnQsIGxlZ2FjeSBiZWhh
dmlvdXIgaXMgbm90Cj4+Pj4+IHJlc3RyaWN0aWVkIGJ5IHRoZSBzcGVjLgo+Pj4+Pgo+Pj4+Pgo+
Pj4+Pj4gUXVlcnlpbmcgdGhlIGZlYXR1cmUgYml0cyB3aWxsIHByb3ZpZGUgdXMgd2l0aCBpbmZv
IGFib3V0Cj4+Pj4+PiB3aGF0IGRvZXMgdGhlIGRldmljZSBzdXBwb3J0LiBBY2tpbmcgdGhlbSB3
aWxsIHRlbGwgZGV2aWNlCj4+Pj4+PiB3aGF0IGRvZXMgZ3Vlc3QgbmVlZC4KPj4+Pj4KPj4+Pj4g
SSB0aGluayB0aGlzIGNhbiB3b3JrLCBidXQgSSB3b25kZXIgaG93IG11Y2ggd2UgY2FuIGdhaW4g
ZnJvbSBzdWNoCj4+Pj4+IGNvbXBsZXhpdGl5Lgo+Pj4+Pgo+Pj4+PiBUaGFua3MKPj4+Pj4KPj4+
Pj4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4+Pj4gdG8gaGF2ZSBhIHNpbXBs
ZSBhbmQgZWFzeQo+Pj4+Pj4+Pj4+IGFic3RhcmN0aW9uIGluIHRoZSBrZW5yZWwuIEZvciBsZWdh
Y3kgZHJpdmVyIGluIHRoZSBndWVzdCwKPj4+Pj4+Pj4+PiBoeXBlcnZpc29yIGlzIGluCj4+Pj4+
Pj4+Pj4gY2hhcmdlIG9mIHRoZSBtZWRpYXRpb246Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiAxKSBj
b25maWcgc3BhY2UgYWNjZXNzIGVuZGlhbiBjb252ZXJzaW9uCj4+Pj4+Pj4+Pj4gMikgdXNpbmcg
c2hhZG93IHZpcnRxdWV1ZSB0byBjaGFuZ2UgdGhlIGVuZGlhbiBpbiB0aGUgdnJpbmcKPj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+IFRoYW5rcwo+Pj4+Pj4+Pj4gSSdkIGxpa2UgdG8gYXZvaWQgc2hhZG93
IHZpcnRxdWV1ZSBoYWNrcyBpZiBhdCBhbGwgcG9zc2libGUuCj4+Pj4+Pj4+PiBMYXN0IEkgY2hl
Y2tlZCBwZXJmb3JtYW5jZSB3YXNuJ3QgbXVjaCBiZXR0ZXIgdGhhbiBqdXN0IGVtdWxhdGluZwo+
Pj4+Pj4+Pj4gdmlydGlvIGluIHNvZnR3YXJlLgo+Pj4+Pj4+PiBJIHRoaW5rIHRoZSBsZWdhY3kg
ZHJpdmVyIHN1cHBvcnQgaXMganVzdCBhIG5pY2UgdG8gaGF2ZS4gT3IgZG8geW91IHNlZQo+Pj4+
Pj4+PiBhbnkgdmFsdWUgdG8gdGhhdD8gSSBndWVzcyBmb3IgbWVsbGFub3ggYW5kIGludGVsLCBv
bmx5IG1vZGVybiBkZXZpY2UgaXMKPj4+Pj4+Pj4gc3VwcG9ydGVkIGluIHRoZSBoYXJkd2FyZS4K
Pj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgIGluY2x1ZGUvbGludXgvdmRw
YS5oIHwgNiArKysrKysKPj4+Pj4+Pj4+Pj4+Pj4gICAgICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+Pj4+Pj4+Pj4+PiBp
bmRleCAwZmVmZWI5NzY4NzcuLmNmZGU0ZWM5OTliNCAxMDA2NDQKPj4+Pj4+Pj4+Pj4+Pj4gLS0t
IGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+Pj4+Pj4+Pj4+Pj4gKysrIGIvaW5jbHVkZS9saW51
eC92ZHBhLmgKPj4+Pj4+Pj4+Pj4+Pj4gQEAgLTYsNiArNiw3IEBACj4+Pj4+Pj4+Pj4+Pj4+ICAg
ICAgICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KPj4+Pj4+Pj4+Pj4+Pj4gICAgICAgI2luY2x1
ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAjaW5jbHVkZSA8bGlu
dXgvdmhvc3RfaW90bGIuaD4KPj4+Pj4+Pj4+Pj4+Pj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3Zp
cnRpb19jb25maWcuaD4KPj4+Pj4+Pj4+Pj4+Pj4gICAgICAgLyoqCj4+Pj4+Pj4+Pj4+Pj4+ICAg
ICAgICAqIHZEUEEgY2FsbGJhY2sgZGVmaW5pdGlvbi4KPj4+Pj4+Pj4+Pj4+Pj4gQEAgLTMxNyw2
ICszMTgsMTEgQEAgc3RhdGljIGlubGluZSBpbnQKPj4+Pj4+Pj4+Pj4+Pj4gdmRwYV9zZXRfZmVh
dHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQKPj4+Pj4+Pj4+Pj4+Pj4gZmVhdHVy
ZXMpCj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgIHsKPj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICBj
b25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgIC8qIE1hbmRhdGluZyAxLjAgdG8gaGF2ZSBzZW1hbnRpY3Mgb2YKPj4+
Pj4+Pj4+Pj4+Pj4gbm9ybWF0aXZlIHN0YXRlbWVudHMgaW4KPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAg
ICAgICogdGhlIHNwZWMuICovCj4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgIGlmICghKGZlYXR1cmVz
ICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpKSkKPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAg
cmV0dXJuIC1FSU5WQUw7Cj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAg
IHZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gdHJ1ZTsKPj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAg
ICByZXR1cm4gb3BzLT5zZXRfZmVhdHVyZXModmRldiwgZmVhdHVyZXMpOwo+Pj4+Pj4+Pj4+Pj4+
PiAgICAgICB9Cj4+Pj4+Pj4+Pj4+Pj4+IC0tCj4+Pj4+Pj4+Pj4+Pj4+IDIuMjUuMQo+Pj4+PgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
