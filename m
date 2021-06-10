Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DACFC47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 04:03:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075A5613FF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 04:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075A5613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD83140595;
	Thu, 10 Jun 2021 04:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ICMrjQEAVSMW; Thu, 10 Jun 2021 04:03:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D48EF4051F;
	Thu, 10 Jun 2021 04:03:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E798C000E;
	Thu, 10 Jun 2021 04:03:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67BEFC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B05682EB6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d9qsAaPVKxRI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:02:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17F5982E94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623297776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXvZ6tuoPkEIoxHMDeEeqKamN/QqFwtdpQS3VL200LM=;
 b=gt9Pl69fEyeV9+vAx+p2vJJs9nkeoR1hn8ENLGeWBfrv4/Igh5bnMmrYd6uwB7//pbLIur
 Ncl1FX+Fn+V8CQk3perKe2fHAoIZWpoDpgBbO96r7Kn9M4bxK8BomSHIw3056Im9ymtrnz
 +Gu5q/LEcqPp/0Fl427qRZnnsCztNEI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-hV1y4X-5O22ghAv9ggURxg-1; Thu, 10 Jun 2021 00:02:49 -0400
X-MC-Unique: hV1y4X-5O22ghAv9ggURxg-1
Received: by mail-pl1-f198.google.com with SMTP id
 x7-20020a1709027c07b02900e6489d6231so358114pll.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 21:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SXvZ6tuoPkEIoxHMDeEeqKamN/QqFwtdpQS3VL200LM=;
 b=FeV0ldNWGmvMNHA3wEGBEmgyptfPTQze0+WOcmis4sf0gIdaJbkdTMTRfiVuRarvhp
 m8M34pSoOiwZVlIM51Z08h+CRFHIouxNphCJTsspFQ6fozKw1pL6DtP6oZekXsTDxn8R
 OgnwbRqlAA9uY1KfJDfyBNRwS2HzaPrIijpcj6srj49QiWVV/XCAU53ncNC3YLhmDMH6
 oW3o439SUIHQRjA2E+FkfJzaE7KlIxgj3SjYshMVpUFAQNyP9kHUI2DLF9XkNJq9s9Y1
 fpnul/2sSwCZazR9qMUvNJzlIzSy8AIi0ljbw3HztuOzyNkMJUpxWV+VjB98CfqZsu4y
 sACQ==
X-Gm-Message-State: AOAM533DMQ1sC4W0WRKrxf+mZl+OvM5Wmvw1K3ZvPzAKmvYjtcUlmS5w
 sjcMChU3rTnSczaFVWz7V/WE7dng2k3ogjjci1WDquiZZmURxlJ0kFHAXe8CNBE70v54zlYT0U1
 sLMNkzns0rAQlM1+AO2/ofXwzIeQrHdCKLRaJhTuPXw==
X-Received: by 2002:a62:30c2:0:b029:289:116c:ec81 with SMTP id
 w185-20020a6230c20000b0290289116cec81mr1068659pfw.42.1623297768719; 
 Wed, 09 Jun 2021 21:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVU961zRB+Y9SorZKkIgfJPcbM10PZ2K2e5HZSOxfr9z+jedPA7qXZVldVdXfDjt/JlhuXbA==
X-Received: by 2002:a62:30c2:0:b029:289:116c:ec81 with SMTP id
 w185-20020a6230c20000b0290289116cec81mr1068621pfw.42.1623297768474; 
 Wed, 09 Jun 2021 21:02:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j7sm6490106pjf.0.2021.06.09.21.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 21:02:48 -0700 (PDT)
Subject: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
To: "Jiang Wang ." <jiang.wang@bytedance.com>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
 <CAP_N_Z_VDd+JUJ_Y-peOEc7FgwNGB8O3uZpVumQT_DbW62Jpjw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ac0c241c-1013-1304-036f-504d0edc5fd7@redhat.com>
Date: Thu, 10 Jun 2021 12:02:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z_VDd+JUJ_Y-peOEc7FgwNGB8O3uZpVumQT_DbW62Jpjw@mail.gmail.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>, Networking <netdev@vger.kernel.org>,
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

CuWcqCAyMDIxLzYvMTAg5LiK5Y2IMTE6NDMsIEppYW5nIFdhbmcgLiDlhpnpgZM6Cj4gT24gV2Vk
LCBKdW4gOSwgMjAyMSBhdCA2OjUxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS82LzEwIOS4iuWNiDc6MjQsIEppYW5nIFdhbmcg5YaZ6YGT
Ogo+Pj4gVGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHN1cHBvcnQgb2YgU09DS19ER1JBTSBmb3Ig
dmlydGlvCj4+PiB0cmFuc3BvcnQuCj4+Pgo+Pj4gRGF0YWdyYW0gc29ja2V0cyBhcmUgY29ubmVj
dGlvbmxlc3MgYW5kIHVucmVsaWFibGUuIFRvIGF2b2lkIHVuZmFpciBjb250ZW50aW9uCj4+PiB3
aXRoIHN0cmVhbSBhbmQgb3RoZXIgc29ja2V0cywgYWRkIHR3byBtb3JlIHZpcnRxdWV1ZXMgYW5k
Cj4+PiBhIG5ldyBmZWF0dXJlIGJpdCB0byBpbmRpY2F0ZSBpZiB0aG9zZSB0d28gbmV3IHF1ZXVl
cyBleGlzdCBvciBub3QuCj4+Pgo+Pj4gRGdyYW0gZG9lcyBub3QgdXNlIHRoZSBleGlzdGluZyBj
cmVkaXQgdXBkYXRlIG1lY2hhbmlzbSBmb3IKPj4+IHN0cmVhbSBzb2NrZXRzLiBXaGVuIHNlbmRp
bmcgZnJvbSB0aGUgZ3Vlc3QvZHJpdmVyLCBzZW5kaW5nIHBhY2tldHMKPj4+IHN5bmNocm9ub3Vz
bHksIHNvIHRoZSBzZW5kZXIgd2lsbCBnZXQgYW4gZXJyb3Igd2hlbiB0aGUgdmlydHF1ZXVlIGlz
IGZ1bGwuCj4+PiBXaGVuIHNlbmRpbmcgZnJvbSB0aGUgaG9zdC9kZXZpY2UsIHNlbmQgcGFja2V0
cyBhc3luY2hyb25vdXNseQo+Pj4gYmVjYXVzZSB0aGUgZGVzY3JpcHRvciBtZW1vcnkgYmVsb25n
cyB0byB0aGUgY29ycmVzcG9uZGluZyBRRU1VCj4+PiBwcm9jZXNzLgo+Pgo+PiBXaGF0J3MgdGhl
IHVzZSBjYXNlIGZvciB0aGUgZGF0YWdyYW0gdnNvY2s/Cj4+Cj4gT25lIHVzZSBjYXNlIGlzIGZv
ciBub24gY3JpdGljYWwgaW5mbyBsb2dnaW5nIGZyb20gdGhlIGd1ZXN0Cj4gdG8gdGhlIGhvc3Qs
IHN1Y2ggYXMgdGhlIHBlcmZvcm1hbmNlIGRhdGEgb2Ygc29tZSBhcHBsaWNhdGlvbnMuCgoKQW55
dGhpbmcgdGhhdCBwcmV2ZW50cyB5b3UgZnJvbSB1c2luZyB0aGUgc3RyZWFtIHNvY2tldD8KCgo+
Cj4gSXQgY2FuIGFsc28gYmUgdXNlZCB0byByZXBsYWNlIFVEUCBjb21tdW5pY2F0aW9ucyBiZXR3
ZWVuCj4gdGhlIGd1ZXN0IGFuZCB0aGUgaG9zdC4KCgpBbnkgYWR2YW50YWdlIGZvciBWU09DSyBp
biB0aGlzIGNhc2U/IElzIGl0IGZvciBwZXJmb3JtYW5jZSAoSSBndWVzcyBub3QgCnNpbmNlIEkg
ZG9uJ3QgZXhlcGN0IHZzb2NrIHdpbGwgYmUgZmFzdGVyKS4KCkFuIG9idmlvdXMgZHJhd2JhY2sg
aXMgdGhhdCBpdCBicmVha3MgdGhlIG1pZ3JhdGlvbi4gVXNpbmcgVURQIHlvdSBjYW4gCmhhdmUg
YSB2ZXJ5IHJpY2ggZmVhdHVyZXMgc3VwcG9ydCBmcm9tIHRoZSBrZXJuZWwgd2hlcmUgdnNvY2sg
Y2FuJ3QuCgoKPgo+Pj4gVGhlIHZpcnRpbyBzcGVjIHBhdGNoIGlzIGhlcmU6Cj4+PiBodHRwczov
L3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC12aXJ0dWFsaXphdGlvbi9tc2c1MDAyNy5odG1s
Cj4+Cj4+IEhhdmUgYSBxdWljayBnbGFuY2UsIEkgc3VnZ2VzdCB0byBzcGxpdCBtZXJnZWFibGUg
cnggYnVmZmVyIGludG8gYW4KPj4gc2VwYXJhdGUgcGF0Y2guCj4gU3VyZS4KPgo+PiBCdXQgSSB0
aGluayBpdCdzIHRpbWUgdG8gcmV2aXNpdCB0aGUgaWRlYSBvZiB1bmlmeWluZyB0aGUgdmlydGlv
LW5ldCBhbmQKPj4gdmlydGlvLXZzb2NrLiBPdGhlcndpc2Ugd2UncmUgZHVwbGljYXRpbmcgZmVh
dHVyZXMgYW5kIGJ1Z3MuCj4gRm9yIG1lcmdlYWJsZSByeGJ1ZiByZWxhdGVkIGNvZGUsIEkgdGhp
bmsgYSBzZXQgb2YgY29tbW9uIGhlbHBlcgo+IGZ1bmN0aW9ucyBjYW4gYmUgdXNlZCBieSBib3Ro
IHZpcnRpby1uZXQgYW5kIHZpcnRpby12c29jay4gRm9yIG90aGVyCj4gcGFydHMsIHRoYXQgbWF5
IG5vdCBiZSB2ZXJ5IGJlbmVmaWNpYWwuIEkgd2lsbCB0aGluayBhYm91dCBtb3JlLgo+Cj4gSWYg
dGhlcmUgaXMgYSBwcmV2aW91cyBlbWFpbCBkaXNjdXNzaW9uIGFib3V0IHRoaXMgdG9waWMsIGNv
dWxkIHlvdSBzZW5kIG1lCj4gc29tZSBsaW5rcz8gSSBkaWQgYSBxdWljayB3ZWIgc2VhcmNoIGJ1
dCBkaWQgbm90IGZpbmQgYW55IHJlbGF0ZWQKPiBpbmZvLiBUaGFua3MuCgoKV2UgaGFkIGEgbG90
OgoKWzFdIApodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qva3ZtL3BhdGNoLzVC
REZGNTM3LjMwNTA4MDZAaHVhd2VpLmNvbS8KWzJdIApodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvcGlwZXJtYWlsL3ZpcnR1YWxpemF0aW9uLzIwMTgtTm92ZW1iZXIvMDM5Nzk4Lmh0
bWwKWzNdIGh0dHBzOi8vd3d3LmxrbWwub3JnL2xrbWwvMjAyMC8xLzE2LzIwNDMKClRoYW5rcwoK
Pgo+PiBUaGFua3MKPj4KPj4KPj4+IEZvciB0aG9zZSB3aG8gcHJlZmVyIGdpdCByZXBvLCBoZXJl
IGlzIHRoZSBsaW5rIGZvciB0aGUgbGludXgga2VybmVs77yaCj4+PiBodHRwczovL2dpdGh1Yi5j
b20vSmlhbmcxMTU1L2xpbnV4L3RyZWUvdnNvY2stZGdyYW0tdjEKPj4+Cj4+PiBxZW11IHBhdGNo
IGxpbms6Cj4+PiBodHRwczovL2dpdGh1Yi5jb20vSmlhbmcxMTU1L3FlbXUvdHJlZS92c29jay1k
Z3JhbS12MQo+Pj4KPj4+Cj4+PiBUbyBkbzoKPj4+IDEuIHVzZSBza2Igd2hlbiByZWNlaXZpbmcg
cGFja2V0cwo+Pj4gMi4gc3VwcG9ydCBtdWx0aXBsZSB0cmFuc3BvcnQKPj4+IDMuIHN1cHBvcnQg
bWVyZ2VhYmxlIHJ4IGJ1ZmZlcgo+Pj4KPj4+Cj4+PiBKaWFuZyBXYW5nICg2KToKPj4+ICAgICB2
aXJ0aW8vdnNvY2s6IGFkZCBWSVJUSU9fVlNPQ0tfRl9ER1JBTSBmZWF0dXJlIGJpdAo+Pj4gICAg
IHZpcnRpby92c29jazogYWRkIHN1cHBvcnQgZm9yIHZpcnRpbyBkYXRhZ3JhbQo+Pj4gICAgIHZo
b3N0L3Zzb2NrOiBhZGQgc3VwcG9ydCBmb3Igdmhvc3QgZGdyYW0uCj4+PiAgICAgdnNvY2tfdGVz
dDogYWRkIHRlc3RzIGZvciB2c29jayBkZ3JhbQo+Pj4gICAgIHZob3N0L3Zzb2NrOiBhZGQga2Nv
bmZpZyBmb3Igdmhvc3QgZGdyYW0gc3VwcG9ydAo+Pj4gICAgIHZpcnRpby92c29jazogYWRkIHN5
c2ZzIGZvciByeCBidWYgbGVuIGZvciBkZ3JhbQo+Pj4KPj4+ICAgIGRyaXZlcnMvdmhvc3QvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICsKPj4+ICAgIGRyaXZlcnMv
dmhvc3QvdnNvY2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjA3ICsrKysrKysr
LS0KPj4+ICAgIGluY2x1ZGUvbGludXgvdmlydGlvX3Zzb2NrLmggICAgICAgICAgICAgICAgICAg
ICAgIHwgICA5ICsKPj4+ICAgIGluY2x1ZGUvbmV0L2FmX3Zzb2NrLmggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAxICsKPj4+ICAgIC4uLi90cmFjZS9ldmVudHMvdnNvY2tfdmlydGlv
X3RyYW5zcG9ydF9jb21tb24uaCAgIHwgICA1ICstCj4+PiAgICBpbmNsdWRlL3VhcGkvbGludXgv
dmlydGlvX3Zzb2NrLmggICAgICAgICAgICAgICAgICB8ICAgNCArCj4+PiAgICBuZXQvdm13X3Zz
b2NrL2FmX3Zzb2NrLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArCj4+PiAgICBu
ZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFuc3BvcnQuYyAgICAgICAgICAgICAgICAgICB8IDQzMyAr
KysrKysrKysrKysrKysrKystLS0KPj4+ICAgIG5ldC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9y
dF9jb21tb24uYyAgICAgICAgICAgIHwgMTg0ICsrKysrKysrLQo+Pj4gICAgdG9vbHMvdGVzdGlu
Zy92c29jay91dGlsLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMDUgKysrKysKPj4+ICAg
IHRvb2xzL3Rlc3RpbmcvdnNvY2svdXRpbC5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0
ICsKPj4+ICAgIHRvb2xzL3Rlc3RpbmcvdnNvY2svdnNvY2tfdGVzdC5jICAgICAgICAgICAgICAg
ICAgIHwgMTk1ICsrKysrKysrKysKPj4+ICAgIDEyIGZpbGVzIGNoYW5nZWQsIDEwNzAgaW5zZXJ0
aW9ucygrKSwgOTcgZGVsZXRpb25zKC0pCj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
