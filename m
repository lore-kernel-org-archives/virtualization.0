Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA7C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 16:44:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA2C613DD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 16:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA2C613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C93183D9E;
	Thu, 10 Jun 2021 16:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgaWQob1eipN; Thu, 10 Jun 2021 16:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B52FE83D97;
	Thu, 10 Jun 2021 16:44:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86DF1C000E;
	Thu, 10 Jun 2021 16:44:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4F70C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A554F4010B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eH9gbrpfPrhj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:44:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20629400F3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:44:34 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 j11-20020a9d738b0000b02903ea3c02ded8so320424otk.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g8tVa/tKF1Z1CFOTKrCMtVkTz0WRgBPyaTEt7gz3464=;
 b=W1+d+fDE8NSQkxbRbfU7zYcFBjCkx/2su5gXnqeg4CLRMyq2bz8jAz/745Fm/ABMiE
 g2JgptK7cOjALXDUq9nxVJg3FpvkS20L3IRxTQONFGFNt27nfkwUUVlXgV1DsvvzTn0X
 OqEZ7Huloj8M/ZorHEkpoDbk4NE0IjYfU3040AtiyYJh9QRAr9YuwfjloRqge4dXayq2
 VMY1bi5fnuQCxbJcbZoT/USdC4LvjjX+8LmLui/XyBjn4pBkdJ4wxVE69YC/7l8f9XdE
 2RWjczc/NJLLLksutLckOMeJS23epSZ1ywSt33bO4g6igszI7OAXVuHXq/JU/RR2cGbr
 5VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g8tVa/tKF1Z1CFOTKrCMtVkTz0WRgBPyaTEt7gz3464=;
 b=K3TIGjhODPqqmTi/e7T7uIQU2ytDW5M5HJOA++AW0m0RWJtU9HzQasfLFR51gWLbwE
 sxGdeunuc6GhJZrjm0ia/32mJmNZaautSlwnylpM+pzfGyJBYyrOpxBsRxPHP4LvAYR4
 ytD+JTGwf7z4esdjOwAQl+EeOKvXFCqqF/e8KZeI49vR5bsAbk5wzYBuCohD2QxgDclE
 bF1+zDmhX6oVToYELtLZmk34/r8Kbp1kPlMfZFY2FwlTSEjJXevM196T4SLYGDBrnrEA
 VdP+uvF46IboOxKgSzVVVB0z46YlXwS5vSunQshIjwGcxi+XcFq98gxbhyCRLmNX6ab9
 1CUA==
X-Gm-Message-State: AOAM5321RhR+j0jX005V2iC1tNF8Wh/FiPQlc8Rl4vx7C/nq3WMOTB+E
 yYE4ZxKXVByizAroPp1fUJ6QYLC4Udk1RyULSS7DJg==
X-Google-Smtp-Source: ABdhPJynSuOt7MYRmCjZvAc5B4VmBGBKyZsPveniHvv9WSF0sbxlVWyakjj9xBT1MIK+WtKSHQrs2p3/PxCc3y/Cw4o=
X-Received: by 2002:a05:6830:2117:: with SMTP id
 i23mr3087102otc.279.1623343473082; 
 Thu, 10 Jun 2021 09:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
 <CAP_N_Z_VDd+JUJ_Y-peOEc7FgwNGB8O3uZpVumQT_DbW62Jpjw@mail.gmail.com>
 <ac0c241c-1013-1304-036f-504d0edc5fd7@redhat.com>
 <20210610072358.3fuvsahxec2sht4y@steredhat>
 <47ce307b-f95e-25c7-ed58-9cd1cbff5b57@redhat.com>
 <20210610095151.2cpyny56kbotzppp@steredhat>
In-Reply-To: <20210610095151.2cpyny56kbotzppp@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 10 Jun 2021 09:44:22 -0700
Message-ID: <CAP_N_Z8u5U2yxMWG2bNgp1cbRcVqv4gEHA_i-4=r9h1HFFGYOA@mail.gmail.com>
Subject: Re: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMjo1MiBBTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMDM6NDY6
NTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+Cj4gPuWcqCAyMDIxLzYvMTAg5LiL5Y2I
MzoyMywgU3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPiA+Pk9uIFRodSwgSnVuIDEwLCAyMDIx
IGF0IDEyOjAyOjM1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPj4+Cj4gPj4+5ZyoIDIw
MjEvNi8xMCDkuIrljYgxMTo0MywgSmlhbmcgV2FuZyAuIOWGmemBkzoKPiA+Pj4+T24gV2VkLCBK
dW4gOSwgMjAyMSBhdCA2OjUxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4+Pj4+Cj4gPj4+Pj7lnKggMjAyMS82LzEwIOS4iuWNiDc6MjQsIEppYW5nIFdhbmcg
5YaZ6YGTOgo+ID4+Pj4+PlRoaXMgcGF0Y2hzZXQgaW1wbGVtZW50cyBzdXBwb3J0IG9mIFNPQ0tf
REdSQU0gZm9yIHZpcnRpbwo+ID4+Pj4+PnRyYW5zcG9ydC4KPiA+Pj4+Pj4KPiA+Pj4+Pj5EYXRh
Z3JhbSBzb2NrZXRzIGFyZSBjb25uZWN0aW9ubGVzcyBhbmQgdW5yZWxpYWJsZS4gVG8gYXZvaWQK
PiA+Pj4+Pj51bmZhaXIgY29udGVudGlvbgo+ID4+Pj4+PndpdGggc3RyZWFtIGFuZCBvdGhlciBz
b2NrZXRzLCBhZGQgdHdvIG1vcmUgdmlydHF1ZXVlcyBhbmQKPiA+Pj4+Pj5hIG5ldyBmZWF0dXJl
IGJpdCB0byBpbmRpY2F0ZSBpZiB0aG9zZSB0d28gbmV3IHF1ZXVlcyBleGlzdCBvciBub3QuCj4g
Pj4+Pj4+Cj4gPj4+Pj4+RGdyYW0gZG9lcyBub3QgdXNlIHRoZSBleGlzdGluZyBjcmVkaXQgdXBk
YXRlIG1lY2hhbmlzbSBmb3IKPiA+Pj4+Pj5zdHJlYW0gc29ja2V0cy4gV2hlbiBzZW5kaW5nIGZy
b20gdGhlIGd1ZXN0L2RyaXZlciwgc2VuZGluZyBwYWNrZXRzCj4gPj4+Pj4+c3luY2hyb25vdXNs
eSwgc28gdGhlIHNlbmRlciB3aWxsIGdldCBhbiBlcnJvciB3aGVuIHRoZQo+ID4+Pj4+PnZpcnRx
dWV1ZSBpcyBmdWxsLgo+ID4+Pj4+PldoZW4gc2VuZGluZyBmcm9tIHRoZSBob3N0L2RldmljZSwg
c2VuZCBwYWNrZXRzIGFzeW5jaHJvbm91c2x5Cj4gPj4+Pj4+YmVjYXVzZSB0aGUgZGVzY3JpcHRv
ciBtZW1vcnkgYmVsb25ncyB0byB0aGUgY29ycmVzcG9uZGluZyBRRU1VCj4gPj4+Pj4+cHJvY2Vz
cy4KPiA+Pj4+Pgo+ID4+Pj4+V2hhdCdzIHRoZSB1c2UgY2FzZSBmb3IgdGhlIGRhdGFncmFtIHZz
b2NrPwo+ID4+Pj4+Cj4gPj4+Pk9uZSB1c2UgY2FzZSBpcyBmb3Igbm9uIGNyaXRpY2FsIGluZm8g
bG9nZ2luZyBmcm9tIHRoZSBndWVzdAo+ID4+Pj50byB0aGUgaG9zdCwgc3VjaCBhcyB0aGUgcGVy
Zm9ybWFuY2UgZGF0YSBvZiBzb21lIGFwcGxpY2F0aW9ucy4KPiA+Pj4KPiA+Pj4KPiA+Pj5Bbnl0
aGluZyB0aGF0IHByZXZlbnRzIHlvdSBmcm9tIHVzaW5nIHRoZSBzdHJlYW0gc29ja2V0Pwo+ID4+
Pgo+ID4+Pgo+ID4+Pj4KPiA+Pj4+SXQgY2FuIGFsc28gYmUgdXNlZCB0byByZXBsYWNlIFVEUCBj
b21tdW5pY2F0aW9ucyBiZXR3ZWVuCj4gPj4+PnRoZSBndWVzdCBhbmQgdGhlIGhvc3QuCj4gPj4+
Cj4gPj4+Cj4gPj4+QW55IGFkdmFudGFnZSBmb3IgVlNPQ0sgaW4gdGhpcyBjYXNlPyBJcyBpdCBm
b3IgcGVyZm9ybWFuY2UgKEkKPiA+Pj5ndWVzcyBub3Qgc2luY2UgSSBkb24ndCBleGVwY3QgdnNv
Y2sgd2lsbCBiZSBmYXN0ZXIpLgo+ID4+Cj4gPj5JIHRoaW5rIHRoZSBnZW5lcmFsIGFkdmFudGFn
ZSB0byB1c2luZyB2c29jayBhcmUgZm9yIHRoZSBndWVzdAo+ID4+YWdlbnRzIHRoYXQgcG90ZW50
aWFsbHkgZG9uJ3QgbmVlZCBhbnkgY29uZmlndXJhdGlvbi4KPiA+Cj4gPgo+ID5SaWdodCwgSSB3
b25kZXIgaWYgd2UgcmVhbGx5IG5lZWQgZGF0YWdyYW0gY29uc2lkZXIgdGhlIGhvc3QgdG8gZ3Vl
c3QKPiA+Y29tbXVuaWNhdGlvbiBpcyByZWxpYWJsZS4KPiA+Cj4gPihOb3RlIHRoYXQgSSBkb24n
dCBvYmplY3QgaXQgc2luY2UgdnNvY2sgaGFzIGFscmVhZHkgc3VwcG9ydGVkIHRoYXQsCj4gPmp1
c3Qgd29uZGVyIGl0cyB1c2UgY2FzZXMpCj4KPiBZZXAsIGl0IHdhcyB0aGUgc2FtZSBjb25jZXJu
IEkgaGFkIDotKQo+IEFsc28gYmVjYXVzZSB3ZSdyZSBub3cgYWRkaW5nIFNFUVBBQ0tFVCwgd2hp
Y2ggcHJvdmlkZXMgcmVsaWFibGUKPiBkYXRhZ3JhbSBzdXBwb3J0Lgo+Cj4gQnV0IElJVUMgdGhl
IHVzZSBjYXNlIGlzIHRoZSBsb2dnaW5nIHdoZXJlIHlvdSBkb24ndCBuZWVkIGEgcmVsaWFibGUK
PiBjb21tdW5pY2F0aW9uIGFuZCB5b3Ugd2FudCB0byBhdm9pZCB0byBrZWVwIG1vcmUgb3BlbiBj
b25uZWN0aW9ucyB3aXRoCj4gZGlmZmVyZW50IGd1ZXN0cy4KPgo+IFNvIHRoZSBzZXJ2ZXIgaW4g
dGhlIGhvc3QgY2FuIGJlIHByZXR0eSBzaW1wbGUgYW5kIGRvZXNuJ3QgaGF2ZSB0bwo+IGhhbmRs
ZSBjb25uZWN0aW9ucy4gSXQganVzdCB3YWl0cyBmb3IgZGF0YWdyYW1zIG9uIGEgcG9ydC4KClll
cy4gV2l0aCBkYXRhZ3JhbSBzb2NrZXRzLCB0aGUgYXBwbGljYXRpb24gY29kZSBpcyBzaW1wbGVy
IHRoYW4gdGhlIHN0cmVhbQpzb2NrZXRzLiBBbHNvLCBpdCB3aWxsIGJlIGVhc2llciB0byBwb3J0
IGV4aXN0aW5nIGFwcGxpY2F0aW9ucyB3cml0dGVuCmZvciBkZ3JhbSwKc3VjaCBhcyBVRFAgb3Ig
dW5peCBkb21haW4gc29ja2V0IHdpdGggZGF0YWdyYW0gdHlwZXMgdG8gdGhlIHZzb2NrCmRncmFt
IHNvY2tldHMuCgpDb21wYXJlZCB0byBVRFAsIHRoZSB2c29jayBkZ3JhbSBoYXMgYSBtaW5pbXVt
IGNvbmZpZ3VyYXRpb24uIFdoZW4Kc2VuZGluZyBkYXRhIGZyb20gdGhlIGd1ZXN0IHRvIHRoZSBo
b3N0LCB0aGUgY2xpZW50IGluIHRoZSBndWVzdCBrbm93cwp0aGUgaG9zdCBDSUQgd2lsbCBhbHdh
eXMgYmUgMi4gRm9yIFVEUCwgdGhlIGhvc3QgSVAgbWF5IGNoYW5nZSBkZXBlbmRpbmcKb24gdGhl
IGNvbmZpZ3VyYXRpb24uCgpUaGUgYWR2YW50YWdlIG92ZXIgVU5JWCBkb21haW4gc29ja2V0cyBp
cyBtb3JlIG9idmlvdXMuIFdlCmhhdmUgc29tZSBhcHBsaWNhdGlvbnMgdGFsa2luZyB0byBlYWNo
IG90aGVyIHdpdGggVU5JWCBkb21haW4gc29ja2V0cywKYnV0IG5vdyB0aGUgYXBwbGljYXRpb25z
IGFyZSBydW5uaW5nIGluc2lkZSBWTXMsIHNvIHdlIHdpbGwgbmVlZCB0bwp1c2UgdnNvY2sgYW5k
IHRob3NlIGFwcGxpY2F0aW9ucyB1c2UgZGF0YWdyYW0gdHlwZXMsIHNvIGl0IGlzIG5hdHVyYWwK
YW5kIHNpbXBsZXIgaWYgdnNvY2sgaGFzIGRhdGFncmFtIHR5cGVzIHRvby4KCkFuZCB3ZSBjYW4g
YWxzbyBydW4gYXBwbGljYXRpb25zIGZvciB2bXdhcmUgdnNvY2sgZGdyYW0gb24KdGhlIFFFTVUg
ZGlyZWN0bHkuCgpidHcsIFNFUVBBQ0tFVCBhbHNvIHN1cHBvcnRzIGRhdGFncmFtLCBidXQgdGhl
IGFwcGxpY2F0aW9uIGNvZGUKbG9naWMgaXMgc2ltaWxhciB0byBzdHJlYW0gc29ja2V0cyBhbmQg
dGhlIHNlcnZlciBuZWVkcyB0byBtYWludGFpbgpjb25uZWN0aW9ucy4KCj4gPgo+ID4KPiA+Pgo+
ID4+Pgo+ID4+PkFuIG9idmlvdXMgZHJhd2JhY2sgaXMgdGhhdCBpdCBicmVha3MgdGhlIG1pZ3Jh
dGlvbi4gVXNpbmcgVURQIHlvdQo+ID4+PmNhbiBoYXZlIGEgdmVyeSByaWNoIGZlYXR1cmVzIHN1
cHBvcnQgZnJvbSB0aGUga2VybmVsIHdoZXJlIHZzb2NrCj4gPj4+Y2FuJ3QuCj4gPj4+Cj4gPj4K
PiA+PlRoYW5rcyBmb3IgYnJpbmdpbmcgdGhpcyB1cCEKPiA+PldoYXQgZmVhdHVyZXMgZG9lcyBV
RFAgc3VwcG9ydCBhbmQgZGF0YWdyYW0gb24gdnNvY2sgY291bGQgbm90IHN1cHBvcnQ/Cj4gPgo+
ID4KPiA+RS5nIHRoZSBzZW5kcGFnZSgpIGFuZCBidXN5IHBvbGxpbmcuIEFuZCB1c2luZyBVRFAg
bWVhbnMgcWRpc2NzIGFuZAo+ID5lQlBGIGNhbiB3b3JrLgo+Cj4gVGhhbmtzLCBJIHNlZSEKPgo+
ID4KPiA+Cj4gPj4KPiA+Pj4KPiA+Pj4+Cj4gPj4+Pj4+VGhlIHZpcnRpbyBzcGVjIHBhdGNoIGlz
IGhlcmU6Cj4gPj4+Pj4+aHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtdmlydHVh
bGl6YXRpb24vbXNnNTAwMjcuaHRtbAo+ID4+Pj4+Cj4gPj4+Pj5IYXZlIGEgcXVpY2sgZ2xhbmNl
LCBJIHN1Z2dlc3QgdG8gc3BsaXQgbWVyZ2VhYmxlIHJ4IGJ1ZmZlciBpbnRvIGFuCj4gPj4+Pj5z
ZXBhcmF0ZSBwYXRjaC4KPiA+Pj4+U3VyZS4KPiA+Pj4+Cj4gPj4+Pj5CdXQgSSB0aGluayBpdCdz
IHRpbWUgdG8gcmV2aXNpdCB0aGUgaWRlYSBvZiB1bmlmeWluZyB0aGUKPiA+Pj4+PnZpcnRpby1u
ZXQgYW5kCj4gPj4+Pj52aXJ0aW8tdnNvY2suIE90aGVyd2lzZSB3ZSdyZSBkdXBsaWNhdGluZyBm
ZWF0dXJlcyBhbmQgYnVncy4KPiA+Pj4+Rm9yIG1lcmdlYWJsZSByeGJ1ZiByZWxhdGVkIGNvZGUs
IEkgdGhpbmsgYSBzZXQgb2YgY29tbW9uIGhlbHBlcgo+ID4+Pj5mdW5jdGlvbnMgY2FuIGJlIHVz
ZWQgYnkgYm90aCB2aXJ0aW8tbmV0IGFuZCB2aXJ0aW8tdnNvY2suIEZvciBvdGhlcgo+ID4+Pj5w
YXJ0cywgdGhhdCBtYXkgbm90IGJlIHZlcnkgYmVuZWZpY2lhbC4gSSB3aWxsIHRoaW5rIGFib3V0
IG1vcmUuCj4gPj4+Pgo+ID4+Pj5JZiB0aGVyZSBpcyBhIHByZXZpb3VzIGVtYWlsIGRpc2N1c3Np
b24gYWJvdXQgdGhpcyB0b3BpYywgY291bGQKPiA+Pj4+eW91IHNlbmQgbWUKPiA+Pj4+c29tZSBs
aW5rcz8gSSBkaWQgYSBxdWljayB3ZWIgc2VhcmNoIGJ1dCBkaWQgbm90IGZpbmQgYW55IHJlbGF0
ZWQKPiA+Pj4+aW5mby4gVGhhbmtzLgo+ID4+Pgo+ID4+Pgo+ID4+PldlIGhhZCBhIGxvdDoKPiA+
Pj4KPiA+Pj5bMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2t2bS9wYXRj
aC81QkRGRjUzNy4zMDUwODA2QGh1YXdlaS5jb20vCj4gPj4+WzJdIGh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9waXBlcm1haWwvdmlydHVhbGl6YXRpb24vMjAxOC1Ob3ZlbWJlci8w
Mzk3OTguaHRtbAo+ID4+PlszXSBodHRwczovL3d3dy5sa21sLm9yZy9sa21sLzIwMjAvMS8xNi8y
MDQzCj4gPj4+CkdvdCBpdC4gSSB3aWxsIGNoZWNrLCB0aGFua3MuCgo+ID4+V2hlbiBJIHRyaWVk
IGl0LCB0aGUgYmlnZ2VzdCBwcm9ibGVtIHRoYXQgYmxvY2tlZCBtZSB3ZXJlIGFsbCB0aGUKPiA+
PmZlYXR1cmVzIHN0cmljdGx5IHJlbGF0ZWQgdG8gVENQL0lQIHN0YWNrIGFuZCBldGhlcm5ldCBk
ZXZpY2VzIHRoYXQKPiA+PnZzb2NrIGRldmljZSBkb2Vzbid0IGtub3cgaG93IHRvIGhhbmRsZTog
VFNPLCBHU08sIGNoZWNrc3VtcywgTUFDLAo+ID4+bmFwaSwgeGRwLCBtaW4gZXRoZXJuZXQgZnJh
bWUgc2l6ZSwgTVRVLCBldGMuCj4gPgo+ID4KPiA+SXQgZGVwZW5kcyBvbiB3aGljaCBsZXZlbCB3
ZSB3YW50IHRvIHNoYXJlOgo+ID4KPiA+MSkgc2hhcmluZyBjb2Rlcwo+ID4yKSBzaGFyaW5nIGRl
dmljZXMKPiA+MykgbWFrZSB2c29jayBhIHByb3RvY29sIHRoYXQgaXMgdW5kZXJzdG9vZCBieSB0
aGUgbmV0d29yayBjb3JlCj4gPgo+ID5XZSBjYW4gc3RhcnQgZnJvbSAxKSwgdGhlIGxvdyBsZXZl
bCB0eC9yeCBsb2dpYyBjYW4gYmUgc2hhcmVkIGF0IGJvdGgKPiA+dmlydGlvLW5ldCBhbmQgdmhv
c3QtbmV0LiBGb3IgMikgd2UgcHJvYmFibHkgbmVlZCBzb21lIHdvcmsgb24gdGhlCj4gPnNwZWMs
IHByb2JhYmx5IHdpdGggYSBuZXcgZmVhdHVyZSBiaXQgdG8gZGVtb25zdHJhdGUgdGhhdCBpdCdz
IGEgdnNvY2sKPiA+ZGV2aWNlIG5vdCBhIGV0aGVybmV0IGRldmljZS4gVGhlbiBpZiBpdCBpcyBw
cm9iZWQgYXMgYSB2c29jayBkZXZpY2Ugd2UKPiA+d29uJ3QgbGV0IHBhY2tldCB0byBiZSBkZWxp
dmVyZWQgaW4gdGhlIFRDUC9JUCBzdGFjay4gRm9yIDMpLCBpdCB3b3VsZAo+ID5iZSBldmVuIGhh
cmRlciBhbmQgSSdtIG5vdCBzdXJlIGl0J3Mgd29ydGggdG8gZG8gdGhhdC4KPiA+Cj4gPgo+ID4+
Cj4gPj5TbyBpbiBteSBvcGluaW9uIHRvIHVuaWZ5IHRoZW0gaXMgbm90IHNvIHNpbXBsZSwgYmVj
YXVzZSB2c29jayBpcyBub3QKPiA+PnJlYWxseSBhbiBldGhlcm5ldCBkZXZpY2UsIGJ1dCBzaW1w
bHkgYSBzb2NrZXQuCj4gPgo+ID4KPiA+V2UgY2FuIHN0YXJ0IGZyb20gc2hhcmluZyBjb2Rlcy4K
Pgo+IFllcCwgSSBhZ3JlZSwgYW5kIG1heWJlIHRoZSBtZXJnZWFibGUgYnVmZmVyIGlzIGEgZ29v
ZCBzdGFydGluZyBwb2ludCB0bwo+IHNoYXJlIGNvZGUhCj4KPiBASmlhbmcsIGRvIHlvdSB3YW50
IHRvIHRha2UgYSBsb29rIG9mIHRoaXMgcG9zc2liaWxpdHk/CgpZZXMuIEkgYWxyZWFkeSByZWFk
IGNvZGUgYWJvdXQgbWVyZ2VhYmxlIGJ1ZmZlciBpbiB2aXJ0aW8tbmV0LCB3aGljaCBJIHRoaW5r
CmlzIHRoZSBvbmx5IHBsYWNlIHNvIGZhciB0byB1c2UgaXQuIEkgd2lsbCBjaGVjayBob3cgdG8g
c2hhcmUgdGhlIGNvZGUuCgpUaGFua3MgZm9yIGFsbCB0aGUgY29tbWVudHMuCgo+IFRoYW5rcywK
PiBTdGVmYW5vCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
