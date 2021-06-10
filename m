Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765BAC47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 07:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28828613C1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 07:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28828613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2CAB83C89;
	Thu, 10 Jun 2021 07:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yc0ELMzJoDm4; Thu, 10 Jun 2021 07:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 66FD783C86;
	Thu, 10 Jun 2021 07:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39C21C000E;
	Thu, 10 Jun 2021 07:47:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0EB0C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6FD183C87
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vi5ZDZ550mNL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:47:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F82E83C86
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623311233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loF5cb29gw2Qr4WX1KQpGHzr7ki9z/ToQpTxS3i6VWU=;
 b=M5ctXOVP1oSvIgYF1KSfIBTTIh0uBkrT+p/jqdsYlgXdrwh1ezgU2Awc2zzhsO0xh4tBWV
 6dJQZftu44rpYVA/gQqKEZ0jGzaAXpA0ovndTX8+jeuyJGgqJyXauJveV3TYsRecqckz3/
 TTgc0OPT7JX4v2htHtZ0t9Cb31ORo1s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-nDtjXNv6O9ewSc9XQ9mWpw-1; Thu, 10 Jun 2021 03:47:11 -0400
X-MC-Unique: nDtjXNv6O9ewSc9XQ9mWpw-1
Received: by mail-pf1-f197.google.com with SMTP id
 c20-20020a621c140000b02902e9c6ad8cd9so792199pfc.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 00:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=loF5cb29gw2Qr4WX1KQpGHzr7ki9z/ToQpTxS3i6VWU=;
 b=PcmpoVm1nWfD68vaLcBmLEQZdPO/sZ3pixBv6TOi2j4ywT3mzHR2JryVLPa+MP4aXT
 fIDYlZN03buC2W8/IMAZiFALrKy1fC6kbFT5ybLYuwP2ufTbwawHKq1GIofmVjS/h+F/
 XOL0WuNqXtbRH5f3PAET3lZFUGJ+ViGsM36ln04eCrskqkd1CHq/E+jlKx2hX9BXMK3x
 gwEhwzIL0FA9rXBFhQwPSkEEMYJp5+YGd8USzYUuV/Ak+Jco+ryN1BrsF91OqwAZuQKr
 r05isyXiryenk5fH+bPDOEkpBij5sSc5U9PvHCh3Rps7jEkl/NCXfTOQnS9z8aS+Q3Id
 c0IQ==
X-Gm-Message-State: AOAM5316PC4h8xVjY+cxidN0jtd7DeP4ABSKQsxU0Dvdb5J/O5onolUq
 Z/8rHHTQfctLWfV/OCBIz7/s+yztji9KE58bHUL5yLq3mVXrIHCZoHd9XNxMn32rIAGH4J8gPfH
 ab7FDtsMiCIkZW9w+l67pW3nc8a12enGcHTsCxJ/GbA==
X-Received: by 2002:a62:6805:0:b029:2e9:a7c9:2503 with SMTP id
 d5-20020a6268050000b02902e9a7c92503mr1763813pfc.26.1623311230731; 
 Thu, 10 Jun 2021 00:47:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqrvDw/tkXuYDtQELqf02BdCoSYQh21xwSXFSnN/JVfuMs/MqAAlU+YEIkeQA3no0RJlH3gQ==
X-Received: by 2002:a62:6805:0:b029:2e9:a7c9:2503 with SMTP id
 d5-20020a6268050000b02902e9a7c92503mr1763775pfc.26.1623311230441; 
 Thu, 10 Jun 2021 00:47:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n37sm1570183pfv.47.2021.06.10.00.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 00:47:09 -0700 (PDT)
Subject: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
 <CAP_N_Z_VDd+JUJ_Y-peOEc7FgwNGB8O3uZpVumQT_DbW62Jpjw@mail.gmail.com>
 <ac0c241c-1013-1304-036f-504d0edc5fd7@redhat.com>
 <20210610072358.3fuvsahxec2sht4y@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <47ce307b-f95e-25c7-ed58-9cd1cbff5b57@redhat.com>
Date: Thu, 10 Jun 2021 15:46:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610072358.3fuvsahxec2sht4y@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, jhansen@vmware.comments,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 Yongji Xie <xieyongji@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexander Popov <alex.popov@linux.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Jiang Wang ." <jiang.wang@bytedance.com>, Networking <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

CuWcqCAyMDIxLzYvMTAg5LiL5Y2IMzoyMywgU3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPiBP
biBUaHUsIEp1biAxMCwgMjAyMSBhdCAxMjowMjozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pgo+PiDlnKggMjAyMS82LzEwIOS4iuWNiDExOjQzLCBKaWFuZyBXYW5nIC4g5YaZ6YGTOgo+
Pj4gT24gV2VkLCBKdW4gOSwgMjAyMSBhdCA2OjUxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4g5ZyoIDIwMjEvNi8xMCDkuIrljYg3OjI0LCBKaWFu
ZyBXYW5nIOWGmemBkzoKPj4+Pj4gVGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHN1cHBvcnQgb2Yg
U09DS19ER1JBTSBmb3IgdmlydGlvCj4+Pj4+IHRyYW5zcG9ydC4KPj4+Pj4KPj4+Pj4gRGF0YWdy
YW0gc29ja2V0cyBhcmUgY29ubmVjdGlvbmxlc3MgYW5kIHVucmVsaWFibGUuIFRvIGF2b2lkIAo+
Pj4+PiB1bmZhaXIgY29udGVudGlvbgo+Pj4+PiB3aXRoIHN0cmVhbSBhbmQgb3RoZXIgc29ja2V0
cywgYWRkIHR3byBtb3JlIHZpcnRxdWV1ZXMgYW5kCj4+Pj4+IGEgbmV3IGZlYXR1cmUgYml0IHRv
IGluZGljYXRlIGlmIHRob3NlIHR3byBuZXcgcXVldWVzIGV4aXN0IG9yIG5vdC4KPj4+Pj4KPj4+
Pj4gRGdyYW0gZG9lcyBub3QgdXNlIHRoZSBleGlzdGluZyBjcmVkaXQgdXBkYXRlIG1lY2hhbmlz
bSBmb3IKPj4+Pj4gc3RyZWFtIHNvY2tldHMuIFdoZW4gc2VuZGluZyBmcm9tIHRoZSBndWVzdC9k
cml2ZXIsIHNlbmRpbmcgcGFja2V0cwo+Pj4+PiBzeW5jaHJvbm91c2x5LCBzbyB0aGUgc2VuZGVy
IHdpbGwgZ2V0IGFuIGVycm9yIHdoZW4gdGhlIHZpcnRxdWV1ZSAKPj4+Pj4gaXMgZnVsbC4KPj4+
Pj4gV2hlbiBzZW5kaW5nIGZyb20gdGhlIGhvc3QvZGV2aWNlLCBzZW5kIHBhY2tldHMgYXN5bmNo
cm9ub3VzbHkKPj4+Pj4gYmVjYXVzZSB0aGUgZGVzY3JpcHRvciBtZW1vcnkgYmVsb25ncyB0byB0
aGUgY29ycmVzcG9uZGluZyBRRU1VCj4+Pj4+IHByb2Nlc3MuCj4+Pj4KPj4+PiBXaGF0J3MgdGhl
IHVzZSBjYXNlIGZvciB0aGUgZGF0YWdyYW0gdnNvY2s/Cj4+Pj4KPj4+IE9uZSB1c2UgY2FzZSBp
cyBmb3Igbm9uIGNyaXRpY2FsIGluZm8gbG9nZ2luZyBmcm9tIHRoZSBndWVzdAo+Pj4gdG8gdGhl
IGhvc3QsIHN1Y2ggYXMgdGhlIHBlcmZvcm1hbmNlIGRhdGEgb2Ygc29tZSBhcHBsaWNhdGlvbnMu
Cj4+Cj4+Cj4+IEFueXRoaW5nIHRoYXQgcHJldmVudHMgeW91IGZyb20gdXNpbmcgdGhlIHN0cmVh
bSBzb2NrZXQ/Cj4+Cj4+Cj4+Pgo+Pj4gSXQgY2FuIGFsc28gYmUgdXNlZCB0byByZXBsYWNlIFVE
UCBjb21tdW5pY2F0aW9ucyBiZXR3ZWVuCj4+PiB0aGUgZ3Vlc3QgYW5kIHRoZSBob3N0Lgo+Pgo+
Pgo+PiBBbnkgYWR2YW50YWdlIGZvciBWU09DSyBpbiB0aGlzIGNhc2U/IElzIGl0IGZvciBwZXJm
b3JtYW5jZSAoSSBndWVzcyAKPj4gbm90IHNpbmNlIEkgZG9uJ3QgZXhlcGN0IHZzb2NrIHdpbGwg
YmUgZmFzdGVyKS4KPgo+IEkgdGhpbmsgdGhlIGdlbmVyYWwgYWR2YW50YWdlIHRvIHVzaW5nIHZz
b2NrIGFyZSBmb3IgdGhlIGd1ZXN0IGFnZW50cyAKPiB0aGF0IHBvdGVudGlhbGx5IGRvbid0IG5l
ZWQgYW55IGNvbmZpZ3VyYXRpb24uCgoKUmlnaHQsIEkgd29uZGVyIGlmIHdlIHJlYWxseSBuZWVk
IGRhdGFncmFtIGNvbnNpZGVyIHRoZSBob3N0IHRvIGd1ZXN0IApjb21tdW5pY2F0aW9uIGlzIHJl
bGlhYmxlLgoKKE5vdGUgdGhhdCBJIGRvbid0IG9iamVjdCBpdCBzaW5jZSB2c29jayBoYXMgYWxy
ZWFkeSBzdXBwb3J0ZWQgdGhhdCwgCmp1c3Qgd29uZGVyIGl0cyB1c2UgY2FzZXMpCgoKPgo+Pgo+
PiBBbiBvYnZpb3VzIGRyYXdiYWNrIGlzIHRoYXQgaXQgYnJlYWtzIHRoZSBtaWdyYXRpb24uIFVz
aW5nIFVEUCB5b3UgCj4+IGNhbiBoYXZlIGEgdmVyeSByaWNoIGZlYXR1cmVzIHN1cHBvcnQgZnJv
bSB0aGUga2VybmVsIHdoZXJlIHZzb2NrIGNhbid0Lgo+Pgo+Cj4gVGhhbmtzIGZvciBicmluZ2lu
ZyB0aGlzIHVwIQo+IFdoYXQgZmVhdHVyZXMgZG9lcyBVRFAgc3VwcG9ydCBhbmQgZGF0YWdyYW0g
b24gdnNvY2sgY291bGQgbm90IHN1cHBvcnQ/CgoKRS5nIHRoZSBzZW5kcGFnZSgpIGFuZCBidXN5
IHBvbGxpbmcuIEFuZCB1c2luZyBVRFAgbWVhbnMgcWRpc2NzIGFuZCBlQlBGIApjYW4gd29yay4K
Cgo+Cj4+Cj4+Pgo+Pj4+PiBUaGUgdmlydGlvIHNwZWMgcGF0Y2ggaXMgaGVyZToKPj4+Pj4gaHR0
cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtdmlydHVhbGl6YXRpb24vbXNnNTAwMjcu
aHRtbAo+Pj4+Cj4+Pj4gSGF2ZSBhIHF1aWNrIGdsYW5jZSwgSSBzdWdnZXN0IHRvIHNwbGl0IG1l
cmdlYWJsZSByeCBidWZmZXIgaW50byBhbgo+Pj4+IHNlcGFyYXRlIHBhdGNoLgo+Pj4gU3VyZS4K
Pj4+Cj4+Pj4gQnV0IEkgdGhpbmsgaXQncyB0aW1lIHRvIHJldmlzaXQgdGhlIGlkZWEgb2YgdW5p
ZnlpbmcgdGhlIAo+Pj4+IHZpcnRpby1uZXQgYW5kCj4+Pj4gdmlydGlvLXZzb2NrLiBPdGhlcndp
c2Ugd2UncmUgZHVwbGljYXRpbmcgZmVhdHVyZXMgYW5kIGJ1Z3MuCj4+PiBGb3IgbWVyZ2VhYmxl
IHJ4YnVmIHJlbGF0ZWQgY29kZSwgSSB0aGluayBhIHNldCBvZiBjb21tb24gaGVscGVyCj4+PiBm
dW5jdGlvbnMgY2FuIGJlIHVzZWQgYnkgYm90aCB2aXJ0aW8tbmV0IGFuZCB2aXJ0aW8tdnNvY2su
IEZvciBvdGhlcgo+Pj4gcGFydHMsIHRoYXQgbWF5IG5vdCBiZSB2ZXJ5IGJlbmVmaWNpYWwuIEkg
d2lsbCB0aGluayBhYm91dCBtb3JlLgo+Pj4KPj4+IElmIHRoZXJlIGlzIGEgcHJldmlvdXMgZW1h
aWwgZGlzY3Vzc2lvbiBhYm91dCB0aGlzIHRvcGljLCBjb3VsZCB5b3UgCj4+PiBzZW5kIG1lCj4+
PiBzb21lIGxpbmtzPyBJIGRpZCBhIHF1aWNrIHdlYiBzZWFyY2ggYnV0IGRpZCBub3QgZmluZCBh
bnkgcmVsYXRlZAo+Pj4gaW5mby4gVGhhbmtzLgo+Pgo+Pgo+PiBXZSBoYWQgYSBsb3Q6Cj4+Cj4+
IFsxXSAKPj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2t2bS9wYXRjaC81
QkRGRjUzNy4zMDUwODA2QGh1YXdlaS5jb20vCj4+IFsyXSAKPj4gaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL3BpcGVybWFpbC92aXJ0dWFsaXphdGlvbi8yMDE4LU5vdmVtYmVyLzAz
OTc5OC5odG1sCj4+IFszXSBodHRwczovL3d3dy5sa21sLm9yZy9sa21sLzIwMjAvMS8xNi8yMDQz
Cj4+Cj4KPiBXaGVuIEkgdHJpZWQgaXQsIHRoZSBiaWdnZXN0IHByb2JsZW0gdGhhdCBibG9ja2Vk
IG1lIHdlcmUgYWxsIHRoZSAKPiBmZWF0dXJlcyBzdHJpY3RseSByZWxhdGVkIHRvIFRDUC9JUCBz
dGFjayBhbmQgZXRoZXJuZXQgZGV2aWNlcyB0aGF0IAo+IHZzb2NrIGRldmljZSBkb2Vzbid0IGtu
b3cgaG93IHRvIGhhbmRsZTogVFNPLCBHU08sIGNoZWNrc3VtcywgTUFDLCAKPiBuYXBpLCB4ZHAs
IG1pbiBldGhlcm5ldCBmcmFtZSBzaXplLCBNVFUsIGV0Yy4KCgpJdCBkZXBlbmRzIG9uIHdoaWNo
IGxldmVsIHdlIHdhbnQgdG8gc2hhcmU6CgoxKSBzaGFyaW5nIGNvZGVzCjIpIHNoYXJpbmcgZGV2
aWNlcwozKSBtYWtlIHZzb2NrIGEgcHJvdG9jb2wgdGhhdCBpcyB1bmRlcnN0b29kIGJ5IHRoZSBu
ZXR3b3JrIGNvcmUKCldlIGNhbiBzdGFydCBmcm9tIDEpLCB0aGUgbG93IGxldmVsIHR4L3J4IGxv
Z2ljIGNhbiBiZSBzaGFyZWQgYXQgYm90aCAKdmlydGlvLW5ldCBhbmQgdmhvc3QtbmV0LiBGb3Ig
Mikgd2UgcHJvYmFibHkgbmVlZCBzb21lIHdvcmsgb24gdGhlIHNwZWMsIApwcm9iYWJseSB3aXRo
IGEgbmV3IGZlYXR1cmUgYml0IHRvIGRlbW9uc3RyYXRlIHRoYXQgaXQncyBhIHZzb2NrIGRldmlj
ZSAKbm90IGEgZXRoZXJuZXQgZGV2aWNlLiBUaGVuIGlmIGl0IGlzIHByb2JlZCBhcyBhIHZzb2Nr
IGRldmljZSB3ZSB3b24ndCAKbGV0IHBhY2tldCB0byBiZSBkZWxpdmVyZWQgaW4gdGhlIFRDUC9J
UCBzdGFjay4gRm9yIDMpLCBpdCB3b3VsZCBiZSBldmVuIApoYXJkZXIgYW5kIEknbSBub3Qgc3Vy
ZSBpdCdzIHdvcnRoIHRvIGRvIHRoYXQuCgoKPgo+IFNvIGluIG15IG9waW5pb24gdG8gdW5pZnkg
dGhlbSBpcyBub3Qgc28gc2ltcGxlLCBiZWNhdXNlIHZzb2NrIGlzIG5vdCAKPiByZWFsbHkgYW4g
ZXRoZXJuZXQgZGV2aWNlLCBidXQgc2ltcGx5IGEgc29ja2V0LgoKCldlIGNhbiBzdGFydCBmcm9t
IHNoYXJpbmcgY29kZXMuCgoKPgo+IEJ1dCBJIGZ1bGx5IGFncmVlIHRoYXQgd2Ugc2hvdWxkbid0
IGR1cGxpY2F0ZSBmdW5jdGlvbmFsaXR5IGFuZCBjb2RlLCAKPiBzbyBtYXliZSB3ZSBjb3VsZCBm
aW5kIHRob3NlIGNvbW1vbiBwYXJ0cyBhbmQgY3JlYXRlIGhlbHBlcnMgdG8gYmUgCj4gdXNlZCBi
eSBib3RoLgoKClllcy4KClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gU3RlZmFubwo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
