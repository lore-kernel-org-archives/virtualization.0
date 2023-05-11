Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9418EC7EE24
	for <virtualization@archiver.kernel.org>; Thu, 11 May 2023 08:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19B1A60D65;
	Thu, 11 May 2023 08:05:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19B1A60D65
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XRSVCdTe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Cxm85Nl2QlR; Thu, 11 May 2023 08:05:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DEC460BCE;
	Thu, 11 May 2023 08:05:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DEC460BCE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 102EAC0036;
	Thu, 11 May 2023 08:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63A03C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 08:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39DAE8229C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 08:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39DAE8229C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XRSVCdTe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMyXbW7hNrww
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 08:05:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2D2A82137
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2D2A82137
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683792322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDguPfFBQ1A5HBLbGPkFIstEpZuKohqgknZXXQa2m5U=;
 b=XRSVCdTeLtNJV5gDvq+BSVg/tBc5cG9zczitwq4Q5Qg3UwtuNKdFZloq0ZlgQEP+lmyjrP
 nC5D6+o+qxTWvDxj8JIt2lkzreJAXyCO/BWPmqguPUDvvWJWT55jLTeTzKGSwLhwEx4sVQ
 mnRHE96PRAxOVZ7ib3++h508Fd4Ob+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-9a9obINCMi6dRFy9pvj4JQ-1; Thu, 11 May 2023 04:05:21 -0400
X-MC-Unique: 9a9obINCMi6dRFy9pvj4JQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f4245ffb03so29712175e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683792320; x=1686384320;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDguPfFBQ1A5HBLbGPkFIstEpZuKohqgknZXXQa2m5U=;
 b=kafmXBAg60QcxWUQPfhi6lm8r4eTSJcLFCTMPAQyRtg4MZDqoLm6VPeyteVSotBpSQ
 pzHjWDOmoKaJmBGnvKIkZL1vnmQqhXDQh55esCKKwVaIl64+w5n8OPPZtoXLvjzRlvtn
 S0wB7hXsSEJYoNTSX6a+2ZKdn7dG7r5xQ05sHgdl9NMjI4BZMeR8r0E3b/TOOI6LPXjG
 TgJxyZ70SCObl2ThJAXMpcGD0AXhAMHCPWpURSrCOmST2j12A9B0PJSD6H9I35H7MiDI
 74dvojcbKXtMjRYiyekviVFInWEdQA5abjNziS3bhXXIla4ToKLGmnBADVbsSy/xEZIW
 01zA==
X-Gm-Message-State: AC+VfDwLBeu8RPj1qchqcDJJDqcscnGBnVbbl3ZJ0y2HG/HHIbFIdbAX
 UdyPCl9OeVLzR8f0lMoqmoxzhidfSL+jbYbxbBMLv6NjmoX3jR4HxIlX2jw5YTwQdAba/nBU1KH
 0NhI6Boy8MXRg6gxDKtMsMc1CcUeXeJ1K2CCiAO/2bA==
X-Received: by 2002:adf:dbd0:0:b0:306:39e3:8409 with SMTP id
 e16-20020adfdbd0000000b0030639e38409mr14427168wrj.49.1683792320331; 
 Thu, 11 May 2023 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7l+BpAdb0iCMyJ1RUUM102Pj/7Li/+Avs0LqpRU6YbPaKu+/sEc+cIjTbpYXL8YuEmB9Vy/Q==
X-Received: by 2002:adf:dbd0:0:b0:306:39e3:8409 with SMTP id
 e16-20020adfdbd0000000b0030639e38409mr14427142wrj.49.1683792320001; 
 Thu, 11 May 2023 01:05:20 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.69.175])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5d65cd000000b0030789698eebsm15980169wrw.89.2023.05.11.01.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 May 2023 01:05:19 -0700 (PDT)
Date: Thu, 11 May 2023 10:05:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhuang Shengen <zhuangshengen@huawei.com>
Subject: Re: [PATCH] vsock: bugfix port residue in server
Message-ID: <oavxfpkinrpj7n24myvgmyq34aymvjm5lx3lqwhwxw6nbumam3@vwg76jsvjdaj>
References: <20230510142502.2293109-1-zhuangshengen@huawei.com>
 <ftuh7vhoxdxbymg6u3wlkfhlfoufupeqampqxc2ktqrpxndow3@dkpufdnuwlln>
 <f7ab6d78-1815-bd3e-c365-1bf054138366@huawei.com>
MIME-Version: 1.0
In-Reply-To: <f7ab6d78-1815-bd3e-c365-1bf054138366@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, jianjay.zhou@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, longpeng2@huawei.com
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

T24gVGh1LCBNYXkgMTEsIDIwMjMgYXQgMDM6MDM6MjRQTSArMDgwMCwgWmh1YW5nIFNoZW5nZW4g
d3JvdGU6Cj5IaSBTdGVmYW5vOgo+Cj7lnKggMjAyMy81LzEwIDIzOjIzLCBTdGVmYW5vIEdhcnph
cmVsbGEg5YaZ6YGTOgo+PkhpLAo+PnRoYW5rcyBmb3IgdGhlIHBhdGNoLCB0aGUgY2hhbmdlIExH
VE0sIGJ1dCBJIGhhdmUgdGhlIGZvbGxvd2luZwo+PnN1Z2dlc3Rpb25zOgo+Pgo+PlBsZWFzZSBh
dm9pZCAiYnVnZml4IiBpbiB0aGUgc3ViamVjdCwgImZpeCIgc2hvdWxkIGJlIGVub3VnaDoKPj5o
dHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0LjE3L3Byb2Nlc3Mvc3VibWl0dGluZy1w
YXRjaGVzLmh0bWwjZGVzY3JpYmUteW91ci1jaGFuZ2VzCj4+Cj4+Cj4+QW55d2F5LCBJIHN1Z2dl
c3QgdG8gY2hhbmdlIHRoZSBzdWJqZWN0IGluCj4+InZzb2NrOiBhdm9pZCB0byBjbG9zZSBjb25u
ZWN0ZWQgc29ja2V0IGFmdGVyIHRoZSB0aW1lb3V0Igo+Pgo+dGhhbmtzIGZvciB5b3VyIHN1Z2dl
c3Rpb24sIEkgd2lsbCBjaGFuZ2UgdGhlIHN1YmplY3QKPj5PbiBXZWQsIE1heSAxMCwgMjAyMyBh
dCAxMDoyNTowMlBNICswODAwLCBaaHVhbmcgU2hlbmdlbiB3cm90ZToKPj4+V2hlbiBjbGllbnQg
YW5kIHNlcnZlciBlc3RhYmxpc2ggYSBjb25uZWN0aW9uIHRocm91Z2ggdnNvY2ssCj4+PnRoZSBj
bGllbnQgc2VuZCBhIHJlcXVlc3QgdG8gdGhlIHNlcnZlciB0byBpbml0aWF0ZSB0aGUgY29ubmVj
dGlvbiwKPj4+dGhlbiBzdGFydCBhIHRpbWVyIHRvIHdhaXQgZm9yIHRoZSBzZXJ2ZXIncyByZXNw
b25zZS4gV2hlbiB0aGUgc2VydmVyJ3MKPj4+UkVTUE9OU0UgbWVzc2FnZSBhcnJpdmVzLCB0aGUg
dGltZXIgYWxzbyB0aW1lcyBvdXQgYW5kIGV4aXRzLiBUaGUKPj4+c2VydmVyJ3MgUkVTUE9OU0Ug
bWVzc2FnZSBpcyBwcm9jZXNzZWQgZmlyc3QsIGFuZCB0aGUgY29ubmVjdGlvbiBpcwo+Pj5lc3Rh
Ymxpc2hlZC4gSG93ZXZlciwgdGhlIGNsaWVudCdzIHRpbWVyIGFsc28gdGltZXMgb3V0LCB0aGUg
b3JpZ2luYWwKPj4+cHJvY2Vzc2luZyBsb2dpYyBvZiB0aGUgY2xpZW50IGlzIHRvIGRpcmVjdGx5
IHNldCB0aGUgc3RhdGUgb2YgCj4+PnRoaXMgdnNvY2sKPj4+dG8gQ0xPU0UgYW5kIHJldHVybiBF
VElNRURPVVQsIFVzZXIgd2lsbCByZWxlYXNlIHRoZSBwb3J0LiBJdCB3aWxsIG5vdAo+Pgo+Pldo
YXQgdG8geW91IG1lYW4gd2l0aCAiVXNlciIgaGVyZT8KPj4KPlRoZSBVc2VyIG1lYW5zIENsaWVu
dCwgSSB3aWxsIGRlbGV0ZSB0aGUgc3RhdGVtZW50ICJVc2VyIHdpbGwgcmVsZWFzZSAKPnRoZSBw
b3IiLCBpdCBpbmRlZWQgZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQKPj4+bm90aWZ5IHRoZSBzZXJ2
ZXIgd2hlbiB0aGUgcG9ydCBpcyByZWxlYXNlZCwgY2F1c2luZyB0aGUgc2VydmVyIAo+Pj5wb3J0
IHJlbWFpbgo+Pj4KPj4KPj5DYW4gd2UgcmVtb3ZlIHRoaXMgYmxhbmsgbGluZT8KPj4KPk9LCj4+
PndoZW4gY2xpZW50J3MgdnNvY2tfY29ucW5lY3QgdGltZW91dO+8jGl0IHNob3VsZCBjaGVjayBz
ayBzdGF0ZSBpcwo+Pgo+PlRoZSByZW1vdGUgcGVlciBjYW4ndCB0cnVzdCB0aGUgb3RoZXIgcGVl
ciwgaW5kZWVkIGl0IHdpbGwgcmVjZWl2ZSBhbgo+PmVycm9yIGFmdGVyIHNlbmRpbmcgdGhlIGZp
cnN0IG1lc3NhZ2UgYW5kIGl0IHdpbGwgcmVtb3ZlIHRoZSBjb25uZWN0aW9uLAo+PnJpZ2h0Pwo+
Pgo+SWYgdGhpcyBzaXR1YXRpb24gaGFwcGVuZCwgdGhlIHNlcnZlciB3aWxsIHJlc3BvbnNlIGEg
UlNUPyBBbnl3YXkgdGhlIAo+Y29ubmVjdGlvbiB3aWxsIG5vdCBlc3RhYmxpc2hlZCBiZWZvcmUg
dGltZW91dCwgVGhlIHNrIHN0YXRlIHdvbnQgYmUgCj5FU1RBQkxJU0hFRC4KPj4+RVNUQUJMSVNI
RUQgb3Igbm90LiBpZiBzayBzdGF0ZSBpcyBFU1RBQkxJU0hFRCwgaXQgbWVhbnMgdGhlIGNvbm5l
Y3Rpb24KPj4+aXMgZXN0YWJsaXNoZWQsIHRoZSBjbGllbnQgc2hvdWxkIG5vdCBzZXQgdGhlIHNr
IHN0YXRlIHRvIENMT1NFCj4+Pgo+Pj5Ob3RlOiBJIGVuY291bnRlcmVkIHRoaXMgaXNzdWUgb24g
a2VybmVsLTQuMTgsIHdoaWNoIGNhbiBiZSBmaXhlZCBieQo+Pj50aGlzIHBhdGNoLiBUaGVuIEkg
Y2hlY2tlZCB0aGUgbGF0ZXN0IGNvZGUgaW4gdGhlIGNvbW11bml0eQo+Pj5hbmQgZm91bmQgc2lt
aWxhciBpc3N1ZS4KPj4+Cj4+Cj4+SW4gb3JkZXIgdG8gYmFja3BvcnQgaXQgdG8gdGhlIHN0YWJs
ZSBrZXJuZWxzLCB3ZSBzaG91bGQgYWRkIGEgRml4ZXMgdGFnOgo+Pmh0dHBzOi8vd3d3Lmtlcm5l
bC5vcmcvZG9jL2h0bWwvdjQuMTcvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNkZXNj
cmliZS15b3VyLWNoYW5nZXMKPj4KPj4KPk9LLCBJIGFkZCBhIEZpeGVzOiBkMDIxYzM0NDA1MWEg
KCJWU09DSzogSW50cm9kdWNlIFZNIFNvY2tldHMiKSBpbiB0aGUgCj5uZXcgcGF0Y2guCj4KPkkg
cHV0IHRoZSBuZXcgcGF0Y2ggd2l0aCB2MiB0aXRsZSBpbiB0aGUgYXR0YWNobWVudCwgcGxlYXNl
IGNoZWNrLgoKTEdUTSAoZ3JlYXQgdG8gaGF2ZSBhZGRlZCB0aGUgbmV0IHRhZyEpLCBidXQgcGxl
YXNlIHBvc3QgYXMgcGxhaW4gdGV4dCAKbGlrZSB2MS4KClRoYW5rcywKU3RlZmFubwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
