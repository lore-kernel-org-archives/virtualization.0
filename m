Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EE2C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 03:43:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC10961403
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 03:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC10961403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A48BF83B1A;
	Thu, 10 Jun 2021 03:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgYyJGVNhTbB; Thu, 10 Jun 2021 03:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 400FF83B22;
	Thu, 10 Jun 2021 03:43:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F501C000E;
	Thu, 10 Jun 2021 03:43:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E3C3C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1664060747
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EAvuVCCf9QDK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:43:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBF0A60708
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 03:43:13 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so12443298otl.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d/HsOChtoCYv2fZLAnHj+L8OfimOjEe4YM7F//2V4UM=;
 b=Xh67DyPE6Dr/kBZT1T6WHVHNDgnklob0hvRge79XgS3dUfpC+iqe3geJA0EJxO4kzK
 Ot37b8Pulgxw5XN5Fa6KGf7GYNhkyGy+9RcqdrLjnpbSuIDFQPEbKb0Xf44MrNP1zLm2
 WrWY3RAEWZtR0mQ87N4jnbpzkvSxN3+BHFZgazaGKzsNdaOKZFiEScjc0GExA2l5UsJ4
 F0wFDYmOkxIRvWpAt2j18370FgzP+3AndnwDqjm1R/xH7PG3XDpFClhwRA5bo5+vnqTl
 HWjnxbrNmbjoFG/D0xBPsqZ+n+UakseIticWoF9S9UcgMHc0R+YVxkD8cqlRd/7fe3CB
 Zt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d/HsOChtoCYv2fZLAnHj+L8OfimOjEe4YM7F//2V4UM=;
 b=FID0tllnisFHIJy+thPNnoBW3B5mjppPsOBDeDrPGgLegNcys8WW7BIrcVIiRcJ+Fs
 wsoCVvhts7dReAQAdFjQx7cSijMRVPwC02C5sYG/rJYTWUlMEoWSzmPoRmB3UK4gSF/A
 gaUPA6K8PxlBdGBdu6CcVI2ZSQ7wZcEmn6NW+j6frNtjkxvEpe0fmXDnrk1iBssCJDn5
 4fpbG8ZymaI+K8k4vTP7ZWbfOBGuSFfnHg0GvDetGXE2dY9tWNbprdchCslUVUCAsHk6
 BiYZIOzmwZ9avvl5dOFtbMj/dZsF86bhsGEcRquFfAPe6Z0nOh+iJpZSIaIIQippnxR3
 WTBQ==
X-Gm-Message-State: AOAM532LqQuRwTtTAN7SRh4GUt47nm+EuhU+Qy6vU1RyrdflzTEDr3KW
 4limzWdeyUMp9+9eiyuJjYfuSNh5H2VFGiTuEpCPrg==
X-Google-Smtp-Source: ABdhPJwaI7pY5h+Lp2iauvfmhJT8Zg+jqsNfguAo720I85KWBapKSLe5j38W7lEBj40rsZP877aszFSAKUNQM7jHv0A=
X-Received: by 2002:a9d:711c:: with SMTP id n28mr704194otj.180.1623296592541; 
 Wed, 09 Jun 2021 20:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
In-Reply-To: <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Wed, 9 Jun 2021 20:43:01 -0700
Message-ID: <CAP_N_Z_VDd+JUJ_Y-peOEc7FgwNGB8O3uZpVumQT_DbW62Jpjw@mail.gmail.com>
Subject: Re: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
To: Jason Wang <jasowang@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBKdW4gOSwgMjAyMSBhdCA2OjUxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMS82LzEwIOS4iuWNiDc6MjQsIEppYW5nIFdhbmcg
5YaZ6YGTOgo+ID4gVGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHN1cHBvcnQgb2YgU09DS19ER1JB
TSBmb3IgdmlydGlvCj4gPiB0cmFuc3BvcnQuCj4gPgo+ID4gRGF0YWdyYW0gc29ja2V0cyBhcmUg
Y29ubmVjdGlvbmxlc3MgYW5kIHVucmVsaWFibGUuIFRvIGF2b2lkIHVuZmFpciBjb250ZW50aW9u
Cj4gPiB3aXRoIHN0cmVhbSBhbmQgb3RoZXIgc29ja2V0cywgYWRkIHR3byBtb3JlIHZpcnRxdWV1
ZXMgYW5kCj4gPiBhIG5ldyBmZWF0dXJlIGJpdCB0byBpbmRpY2F0ZSBpZiB0aG9zZSB0d28gbmV3
IHF1ZXVlcyBleGlzdCBvciBub3QuCj4gPgo+ID4gRGdyYW0gZG9lcyBub3QgdXNlIHRoZSBleGlz
dGluZyBjcmVkaXQgdXBkYXRlIG1lY2hhbmlzbSBmb3IKPiA+IHN0cmVhbSBzb2NrZXRzLiBXaGVu
IHNlbmRpbmcgZnJvbSB0aGUgZ3Vlc3QvZHJpdmVyLCBzZW5kaW5nIHBhY2tldHMKPiA+IHN5bmNo
cm9ub3VzbHksIHNvIHRoZSBzZW5kZXIgd2lsbCBnZXQgYW4gZXJyb3Igd2hlbiB0aGUgdmlydHF1
ZXVlIGlzIGZ1bGwuCj4gPiBXaGVuIHNlbmRpbmcgZnJvbSB0aGUgaG9zdC9kZXZpY2UsIHNlbmQg
cGFja2V0cyBhc3luY2hyb25vdXNseQo+ID4gYmVjYXVzZSB0aGUgZGVzY3JpcHRvciBtZW1vcnkg
YmVsb25ncyB0byB0aGUgY29ycmVzcG9uZGluZyBRRU1VCj4gPiBwcm9jZXNzLgo+Cj4KPiBXaGF0
J3MgdGhlIHVzZSBjYXNlIGZvciB0aGUgZGF0YWdyYW0gdnNvY2s/Cj4KT25lIHVzZSBjYXNlIGlz
IGZvciBub24gY3JpdGljYWwgaW5mbyBsb2dnaW5nIGZyb20gdGhlIGd1ZXN0CnRvIHRoZSBob3N0
LCBzdWNoIGFzIHRoZSBwZXJmb3JtYW5jZSBkYXRhIG9mIHNvbWUgYXBwbGljYXRpb25zLgoKSXQg
Y2FuIGFsc28gYmUgdXNlZCB0byByZXBsYWNlIFVEUCBjb21tdW5pY2F0aW9ucyBiZXR3ZWVuCnRo
ZSBndWVzdCBhbmQgdGhlIGhvc3QuCgo+ID4KPiA+IFRoZSB2aXJ0aW8gc3BlYyBwYXRjaCBpcyBo
ZXJlOgo+ID4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtdmlydHVhbGl6YXRp
b24vbXNnNTAwMjcuaHRtbAo+Cj4KPiBIYXZlIGEgcXVpY2sgZ2xhbmNlLCBJIHN1Z2dlc3QgdG8g
c3BsaXQgbWVyZ2VhYmxlIHJ4IGJ1ZmZlciBpbnRvIGFuCj4gc2VwYXJhdGUgcGF0Y2guCgpTdXJl
LgoKPiBCdXQgSSB0aGluayBpdCdzIHRpbWUgdG8gcmV2aXNpdCB0aGUgaWRlYSBvZiB1bmlmeWlu
ZyB0aGUgdmlydGlvLW5ldCBhbmQKPiB2aXJ0aW8tdnNvY2suIE90aGVyd2lzZSB3ZSdyZSBkdXBs
aWNhdGluZyBmZWF0dXJlcyBhbmQgYnVncy4KCkZvciBtZXJnZWFibGUgcnhidWYgcmVsYXRlZCBj
b2RlLCBJIHRoaW5rIGEgc2V0IG9mIGNvbW1vbiBoZWxwZXIKZnVuY3Rpb25zIGNhbiBiZSB1c2Vk
IGJ5IGJvdGggdmlydGlvLW5ldCBhbmQgdmlydGlvLXZzb2NrLiBGb3Igb3RoZXIKcGFydHMsIHRo
YXQgbWF5IG5vdCBiZSB2ZXJ5IGJlbmVmaWNpYWwuIEkgd2lsbCB0aGluayBhYm91dCBtb3JlLgoK
SWYgdGhlcmUgaXMgYSBwcmV2aW91cyBlbWFpbCBkaXNjdXNzaW9uIGFib3V0IHRoaXMgdG9waWMs
IGNvdWxkIHlvdSBzZW5kIG1lCnNvbWUgbGlua3M/IEkgZGlkIGEgcXVpY2sgd2ViIHNlYXJjaCBi
dXQgZGlkIG5vdCBmaW5kIGFueSByZWxhdGVkCmluZm8uIFRoYW5rcy4KCj4gVGhhbmtzCj4KPgo+
ID4KPiA+IEZvciB0aG9zZSB3aG8gcHJlZmVyIGdpdCByZXBvLCBoZXJlIGlzIHRoZSBsaW5rIGZv
ciB0aGUgbGludXgga2VybmVs77yaCj4gPiBodHRwczovL2dpdGh1Yi5jb20vSmlhbmcxMTU1L2xp
bnV4L3RyZWUvdnNvY2stZGdyYW0tdjEKPiA+Cj4gPiBxZW11IHBhdGNoIGxpbms6Cj4gPiBodHRw
czovL2dpdGh1Yi5jb20vSmlhbmcxMTU1L3FlbXUvdHJlZS92c29jay1kZ3JhbS12MQo+ID4KPiA+
Cj4gPiBUbyBkbzoKPiA+IDEuIHVzZSBza2Igd2hlbiByZWNlaXZpbmcgcGFja2V0cwo+ID4gMi4g
c3VwcG9ydCBtdWx0aXBsZSB0cmFuc3BvcnQKPiA+IDMuIHN1cHBvcnQgbWVyZ2VhYmxlIHJ4IGJ1
ZmZlcgo+ID4KPiA+Cj4gPiBKaWFuZyBXYW5nICg2KToKPiA+ICAgIHZpcnRpby92c29jazogYWRk
IFZJUlRJT19WU09DS19GX0RHUkFNIGZlYXR1cmUgYml0Cj4gPiAgICB2aXJ0aW8vdnNvY2s6IGFk
ZCBzdXBwb3J0IGZvciB2aXJ0aW8gZGF0YWdyYW0KPiA+ICAgIHZob3N0L3Zzb2NrOiBhZGQgc3Vw
cG9ydCBmb3Igdmhvc3QgZGdyYW0uCj4gPiAgICB2c29ja190ZXN0OiBhZGQgdGVzdHMgZm9yIHZz
b2NrIGRncmFtCj4gPiAgICB2aG9zdC92c29jazogYWRkIGtjb25maWcgZm9yIHZob3N0IGRncmFt
IHN1cHBvcnQKPiA+ICAgIHZpcnRpby92c29jazogYWRkIHN5c2ZzIGZvciByeCBidWYgbGVuIGZv
ciBkZ3JhbQo+ID4KPiA+ICAgZHJpdmVycy92aG9zdC9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDggKwo+ID4gICBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDIwNyArKysrKysrKy0tCj4gPiAgIGluY2x1ZGUvbGludXgv
dmlydGlvX3Zzb2NrLmggICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsKPiA+ICAgaW5jbHVk
ZS9uZXQvYWZfdnNvY2suaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4g
ICAuLi4vdHJhY2UvZXZlbnRzL3Zzb2NrX3ZpcnRpb190cmFuc3BvcnRfY29tbW9uLmggICB8ICAg
NSArLQo+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3Zzb2NrLmggICAgICAgICAgICAg
ICAgICB8ICAgNCArCj4gPiAgIG5ldC92bXdfdnNvY2svYWZfdnNvY2suYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEyICsKPiA+ICAgbmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0
LmMgICAgICAgICAgICAgICAgICAgfCA0MzMgKysrKysrKysrKysrKysrKysrLS0tCj4gPiAgIG5l
dC92bXdfdnNvY2svdmlydGlvX3RyYW5zcG9ydF9jb21tb24uYyAgICAgICAgICAgIHwgMTg0ICsr
KysrKysrLQo+ID4gICB0b29scy90ZXN0aW5nL3Zzb2NrL3V0aWwuYyAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDEwNSArKysrKwo+ID4gICB0b29scy90ZXN0aW5nL3Zzb2NrL3V0aWwuaCAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgNCArCj4gPiAgIHRvb2xzL3Rlc3RpbmcvdnNvY2svdnNv
Y2tfdGVzdC5jICAgICAgICAgICAgICAgICAgIHwgMTk1ICsrKysrKysrKysKPiA+ICAgMTIgZmls
ZXMgY2hhbmdlZCwgMTA3MCBpbnNlcnRpb25zKCspLCA5NyBkZWxldGlvbnMoLSkKPiA+Cj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
