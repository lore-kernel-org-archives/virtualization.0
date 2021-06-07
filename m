Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC99C4743D
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:10:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F0461164
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F0461164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12D3440004;
	Mon,  7 Jun 2021 02:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id naTkTATmGr6J; Mon,  7 Jun 2021 02:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id F323C40270;
	Mon,  7 Jun 2021 02:10:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6CCCC000E;
	Mon,  7 Jun 2021 02:10:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDAEC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAF11605DC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DC-Ve3mjy31g
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:10:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A4C2605BC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623031810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcGRDlO9kx6xYy9Jkl8yjVemt6SecxLG9YhvbcWz2gI=;
 b=W4dpVWTO0tKb/LPdW2St3fyj5P1RGN11jdn1rXkSNTuviBmKuW6uAp54GSS/THnYzPGOt3
 zsDmjMrOTn7/MQnKuu68aOqP8huJbpNu3rY4Xo4b5CcyOHWlPdgmVlM4Qsi3Mr/JAYqQqc
 SYXdWQ4GZTvOOF6Ll1R97x39cJHsIbM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-_CzvOgiiOeCPomegzYNC8g-1; Sun, 06 Jun 2021 22:10:09 -0400
X-MC-Unique: _CzvOgiiOeCPomegzYNC8g-1
Received: by mail-pf1-f198.google.com with SMTP id
 197-20020a6218ce0000b02902e9c6393facso6907983pfy.18
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QcGRDlO9kx6xYy9Jkl8yjVemt6SecxLG9YhvbcWz2gI=;
 b=dC5ZhoJWX8LuKv+Ar/setoYBzc9VfeN3/eramuJyaTc08zGKmY79/pazh85VkedlEp
 tReFXAAeLAkv9T9OcRI4SFPp2t3NYLto/x1lSBHqyfuxhulnqxm8UWjB1saIyn8bcIqK
 3gCkVaAsgJpl/YTJL7z11sg8DSjfp69fBwyPibnX8BoXfxIj1YurljrugH+Kpq0Yeee9
 xVDBsPHwkkr2OhVkfSCZJl4Vb7ilGNaRWOofaRBRlfyWc/LUSkAdjQ94siFFLUl0Izqr
 mO9VjrESbmQ+RvoUaJD3VzHW1Z4hkL1MVxTPG/NJ88w6WMYlhhuQR3WUOVZVAQXipDUv
 AWDA==
X-Gm-Message-State: AOAM5336q8w95eaoJt47+B7rwp6g8jmO79uYOppmlYXLsApTDUN1lOfO
 IsioP1ma71nHvhm2cPv5wnJCIgrid0HOX4564Zn2tOeXQfjxCg4awkFHLCK5UD8eS5CZIemOa8i
 Ejy1pOicsqB0sc7XjhfXNay/tLG3FRy3tEOt1hqTQjPAzRlil2sFpzwoHkCe/LQs0QHW3SZbdVD
 19PLOAdVQ7s8598/9VAg==
X-Received: by 2002:a17:90b:4b04:: with SMTP id
 lx4mr30113206pjb.54.1623031808019; 
 Sun, 06 Jun 2021 19:10:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEXT6F90kntZU6QpnIPIlWcJyom63naW/Y/kt3Xj9PR4NzxtP0jEX5l2dqihX9yp6m+JbFew==
X-Received: by 2002:a17:90b:4b04:: with SMTP id
 lx4mr30113179pjb.54.1623031807627; 
 Sun, 06 Jun 2021 19:10:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u9sm1039037pgp.90.2021.06.06.19.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:10:07 -0700 (PDT)
Subject: Re: Security hole in vhost-vdpa?
To: "Michael S. Tsirkin" <mst@redhat.com>, Gautam Dawar <gdawar@xilinx.com>
References: <BY5PR02MB6980228A5EA2D021A3F9F47BB1399@BY5PR02MB6980.namprd02.prod.outlook.com>
 <20210606173637-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <82e91727-79f4-b6f1-37f1-9fb5bdf67b8d@redhat.com>
Date: Mon, 7 Jun 2021 10:10:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606173637-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi83IMnPzuc1OjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g0LS1wDoKPiBPbiBTdW4s
IEp1biAwNiwgMjAyMSBhdCAwMjozOTo0OFBNICswMDAwLCBHYXV0YW0gRGF3YXIgd3JvdGU6Cj4+
IEhpIEFsbCwKPj4KPj4gICAKPj4KPj4gVGhpcyBpcyBpbiBjb250aW51YXRpb24gdG8gbXkgZmlu
ZGluZ3Mgbm90ZWQgaW4gQnVnIDIxMzE3OSBhbmQgZGlzY3Vzc2lvbnMgd2UKPj4gaGF2ZSBoYWQg
aW4gdGhlIGxhc3QgY291cGxlIG9mIHdlZWtzIG92ZXIgZW1haWxzLgo+Pgo+PiAgIAo+Pgo+PiBU
b2RheSwgSSBwdWJsaXNoZWQgdGhlIGZpcnN0IHBhdGNoIGZvciB0aGlzIGlzc3VlIHdoaWNoIGFk
ZHMgdGltZW91dCBiYXNlZCB3YWl0Cj4+IGZvciBjb21wbGV0aW9uIGV2ZW50IGFuZCBhbHNvIGxv
Z3MgYSB3YXJuaW5nIG1lc3NhZ2UgdG8gYWxlcnQgdGhlIHVzZXIvCj4+IGFkbWluaXN0cmF0b3Ig
b2YgdGhlIHByb2JsZW0uCj4gQ2FuJ3QgY2xvc2UganVzdCBmaW5pc2ggd2l0aG91dCB3YWl0aW5n
IGZvciB1c2Vyc3BhY2U/CgoKSXQgd29ya3MgYXMgbG9uZyBhcyB3ZSBkb24ndCB1c2UgbW1hcCgp
LiBXaGVuIHdlIG1hcCBraWNrcywgaXQgbG9va3MgdG8gCm1lIHRoZXJlJ3Mgbm8gd2F5IHRvICJy
ZXZva2UiIHRoZSBtYXBwaW5nIGZyb20gdXNlcnNwYWNlPwoKVGhhbmtzCgoKPiBUaGVuIG5vdGlm
eSB1c2Vyc3BhY2UgYWJvdXQgYW55IGJ1ZmZlcnMgdGhhdCBkaWQgbm90IGNvbXBsZXRlIC4uLgo+
Cj4KPj4gQXMgYSBuZXh0IHN0ZXAsIHRoZSBpZGVhIGlzIHRvIGltcGxlbWVudCBhIG1lY2hhbmlz
bSB0byBhbGxvdyB2aG9zdC12ZHBhIG1vZHVsZQo+PiBub3RpZnkgdXNlcnNwYWNlIGFwcCAoUUVN
VSkgdG8gY2xvc2UgdGhlIGZkIGNvcnJlc3BvbmRpbmcgdG8gdGhlIHZob3N0LXZkcGEKPj4gY2hh
cmFjdGVyIGRldmljZSB3aGVuIGl0IGlzIHdhaXRpbmcgZm9yIHRoZSBjb21wbGV0aW9uIGV2ZW50
IGluCj4+IHZob3N0X3ZkcGFfcmVtb3ZlKCkuIEphc29uIGNvbmZpcm1lZCB0aGlzIGJ5IHNheWlu
ZyB0aGF0IHdlIG5lZWQgYSBuZXcgZXZlbnRmZC8KPj4gaW9jdGwgdG8gcmVjZWl2ZSBob3QgcmVt
b3ZlIHJlcXVlc3QgZnJvbSBrZXJuZWwuCj4+Cj4+ICAgCj4+Cj4+IEFsdGhvdWdoLCB3ZSBjYW4g
cHJvY2VlZCB0byBpbXBsZW1lbnQgY2hhbmdlcyBmb3IgdGhlIHBhcnQgZGVzY3JpYmVkIGFib3Zl
IGJ1dAo+PiBJIGZlZWwgdGhhdCB0aGF0IHRoZSBwcm9ibGVtIGlzIG11Y2ggZGVlcGVyIHRoYW4g
dGhhdC4gVGhpcyBtZWNoYW5pc20gd2lsbCBqdXN0Cj4+IHJlcXVlc3QgdGhlIHVzZXJzcGFjZSB0
byBjbG9zZSB0aGUgZmQgYW5kIGxldCB2aG9zdC12ZHBhIHByb2NlZWQgd2l0aCB0aGUKPj4gY2xl
YW4tdXAuIEhvd2V2ZXIsIElNSE8gdGhpbmdzIHNob3VsZCBiZSB1bmRlciBtb3JlIGNvbnRyb2wg
b2Yga2VybmVsIHNwYWNlCj4+IHRoYW4gdGhlIHVzZXIgc3BhY2UuCj4+Cj4+ICAgCj4+Cj4+IFRo
ZSBwcm9ibGVtIEkgYW0gdHJ5aW5nIHRvIGhpZ2hsaWdodCBpcyB0aGF0IGEgbWFsaWNpb3VzIHVz
ZXItc3BhY2UgYXBwbGljYXRpb24KPj4gY2FuIHJlbmRlciBhbnkgbW9kdWxlIHJlZ2lzdGVyaW5n
IGEgdkRQQSBkZXZpY2UgdG8gaGFuZyBpbiB0aGVpcgo+PiBkZS1pbml0aWFsaXphdGlvbiBzZXF1
ZW5jZS4gVGhpcyB3aWxsIHR5cGljYWxseSBzdXJmYWNlIHdoZW4KPj4gdmRwYV9kZXZpY2VfdW5y
ZWdpc3RlcigpIGlzIGNhbGxlZCBmcm9tIHRoZSBmdW5jdGlvbiByZXNwb25zaWJsZSBmb3IgbW9k
dWxlCj4+IHVubG9hZCBsZWFkaW5nIHJtbW9kIGNvbW1hbmRzIHRvIG5vdCByZXR1cm4sIGZvcmV2
ZXIuCj4+Cj4+ICAgCj4+Cj4+IFRvIHByb3ZlIG15IHBvaW50LCBJIGNyZWF0ZWQgYSBzaW1wbGUg
QyBwcm9ncmFtICh0ZXN0X3ZkcGEuYykgdGhhdCBvcGVucyB0aGUKPj4gdmhvc3QtdmRwYSBjaGFy
YWN0ZXIgZGV2aWNlIGFuZCBuZXZlciBleGl0cy4gVGhlIGxvZ3MgKHRlc3RfbG9ncy50eHQpIHNo
b3cgdGhhdAo+PiBhZnRlciByZWdpc3RlcmluZyB0aGUgdkRQQSBkZXZpY2UgZnJvbSBzZmMgZHJp
dmVyLCB2aG9zdC12ZHBhIG1vZHVsZSBjcmVhdGVzCj4+IHRoZSBjaGFyIGRldmljZSAvZGV2L3Zo
b3N0LXZkcGEtMCAgZm9yIGl0LiBBcyB0aGlzIGlzIGF2YWlsYWJsZSB0byBhbGwgYXBwcyBpbgo+
PiB0aGUgdXNlcnNwYWNlLCB0aGUgbWFsaWNpb3VzIGFwcCAoLi9ibG9ja192ZHBhX3VubG9hZCkg
b3BlbnMgdGhpcyBkZXZpY2UgYW5kCj4+IGdvZXMgdG8gaW5maW5pdGUgc2xlZXAuIEF0IHRoaXMg
dGltZSwgd2hlbiBtb2R1bGUgdW5sb2FkIChybW1vZCBzZmMpIGlzIGNhbGxlZCwKPj4gaXQgaGFu
Z3MgYW5kIHRoZSBmb2xsb3dpbmcgcHJpbnQgaW5mb3JtcyB0aGUgdXNlci9hZG1pbiBvZiB0aGlz
IHN0YXRlIHdpdGgKPj4gZm9sbG93aW5nIG1lc3NhZ2U6Cj4+Cj4+IFsgODE4MC4wNTM2NDddICB2
aG9zdC12ZHBhLTA6IHZob3N0X3ZkcGFfcmVtb3ZlIHdhaXRpbmcgZm9yIC9kZXYvdmhvc3QtdmRw
YS0wCj4+IHRvIGJlIGNsb3NlZAo+Pgo+PiAgIAo+Pgo+PiBGaW5hbGx5LCB3aGVuIGJsb2NrX3Zk
cGFfdW5sb2FkIGlzIGtpbGxlZCwgdmhvc3RfdmRwYV9yZW1vdmUoKSB1bmJsb2NrcyBhbmQgc2Zj
Cj4+IG1vZHVsZSBpcyB1bmxvYWRlZC4KPj4KPj4gICAKPj4KPj4gV2l0aCBzdWNoIGFwcGxpY2F0
aW9uIHJ1bm5pbmcgaW4gdXNlcnNwYWNlLCBhIGtlcm5lbCBtb2R1bGUgKHRoYXQgcmVnaXN0ZXJl
ZAo+PiBjb3JyZXNwb25kaW5nIHZEUEEgZGV2aWNlKSB3aWxsIGhhbmcgZHVyaW5nIHVubG9hZCBz
ZXF1ZW5jZS4gU3VjaCBjb250cm9sIG9mCj4+IHRoZSB1c2Vyc3BhY2UgYXBwbGljYXRpb24gb24g
dGhlIHN5c3RlbSByZXNvdXJjZXMgc2hvdWxkIGNlcnRhaW5seSBiZQo+PiBwcmV2ZW50ZWQuCj4+
Cj4+IFRvIG1lLCB0aGlzIHNlZW1zIHRvIGJlIGEgc2VyaW91cyBpc3N1ZSBhbmQgcmVxdWlyZXMg
bW9kaWZpY2F0aW9ucyBpbiB0aGUgd2F5Cj4+IGl0IGlzIGN1cnJlbnRseSBoYW5kbGVkIGluIHZo
b3N0LXZkcGEgKGFuZCBvdGhlciBtb2R1bGVzIChWRklPPykgd2l0aCBzaW1pbGFyCj4+IGltcGxl
bWVudGF0aW9uKS4KPj4KPj4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuCj4+Cj4+ICAgCj4+
Cj4+IFJlZ2FyZHMsCj4+Cj4+IEdhdXRhbSBEYXdhcgo+Pgo+PiAjaW5jbHVkZSA8c3lzL3N0YXQu
aD4KPj4gI2luY2x1ZGUgPHVuaXN0ZC5oPgo+PiAjaW5jbHVkZSA8c3RkbGliLmg+Cj4+ICNpbmNs
dWRlIDxzdGRpby5oPgo+PiAjaW5jbHVkZSA8ZmNudGwuaD4KPj4gI2luY2x1ZGUgPGVycm5vLmg+
Cj4+Cj4+IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKPj4gewo+PiAgICAgdW5zaWdu
ZWQgaW50IGluZGV4Owo+PiAgICAgY2hhciBkZXZfcGF0aFszMF07Cj4+ICAgICBpbnQgZmQ7Cj4+
Cj4+ICAgICBpZiAoYXJnYyAhPSAyKSB7Cj4+IAkgICBwcmludGYoIlVzYWdlOiAlcyA8dmhvc3Qt
dmRwYSBkZXZpY2UgaW5kZXg+XG4iLCBhcmd2WzBdKTsKPj4gCSAgIHJldHVybiAtMTsKPj4gICAg
IH0KPj4KPj4gICAgIGluZGV4ID0gc3RydG91bChhcmd2WzFdLCBOVUxMLCAxMCk7Cj4+Cj4+ICAg
ICBzbnByaW50ZihkZXZfcGF0aCwgc2l6ZW9mKGRldl9wYXRoKSwgIi9kZXYvdmhvc3QtdmRwYS0l
dSIsIGluZGV4KTsKPj4gICAgIGZkID0gb3BlbihkZXZfcGF0aCwgT19SRFdSKTsKPj4gICAgIGlm
KGZkIDwgMCkKPj4gICAgIHsKPj4gICAgICAgICBwcmludGYoIkZhaWxlZCB0byBvcGVuICVzLCBl
cnJubzogJWQhXG4iLCBkZXZfcGF0aCwgZXJybm8pOwo+PiAgICAgICAgIHJldHVybiAxOwo+PiAg
ICAgfQo+Pgo+PiAgICAgcHJpbnRmKCJCbG9ja2luZyB1bmxvYWQgb2YgZHJpdmVyIHRoYXQgcmVn
aXN0ZXJlZCB2RFBBIGRldmljZSIKPj4gCSAgIiBjb3JyZXNwb25kaW5nIHRvIGNkZXYgJXMgY3Jl
YXRlZCBieSB2aG9zdC12ZHBhXG4iLCBkZXZfcGF0aCk7Cj4+ICAgICB3aGlsZSAoMSkKPj4gCSAg
IHNsZWVwKDEpOwo+Pgo+PiAgICAgY2xvc2UoZmQpOwo+PiAgICAgcmV0dXJuIDA7Cj4+IH0KPj4g
W3Jvb3RAbmRyNzMwcCB+XSMgfi9jcmVhdGVfdmRwYV9kZXZpY2Uuc2gKPj4KPj4gW3Jvb3RAbmRy
NzMwcCB+XSMgbGwgL2Rldi92aG9zdC12ZHBhLTAKPj4gY3J3LS0tLS0tLSAxIHJvb3Qgcm9vdCAy
NDAsIDAgSnVuICA2IDE5OjU5IC9kZXYvdmhvc3QtdmRwYS0wCj4+Cj4+IFtyb290QG5kcjczMHAg
fl0jIC4vYmxvY2tfdmRwYV91bmxvYWQgMCAmCj4+IFsxXSAxMDkzMAo+PiBCbG9ja2luZyB1bmxv
YWQgb2YgZHJpdmVyIHRoYXQgcmVnaXN0ZXJlZCB2RFBBIGRldmljZSBjb3JyZXNwb25kaW5nIHRv
IGNkZXYgL2Rldi92aG9zdC12ZHBhLTAgY3JlYXRlZCBieSB2aG9zdC12ZHBhCj4+Cj4+IFtyb290
QG5kcjczMHAgfl0jIHJtbW9kIHNmYwo+PiBbIDgxNzkuMDEwNTIwXSBzZmNfZWYxMDAgMDAwMDow
NjowMC40OiBlZjEwMF92ZHBhX2RlbGV0ZTogQ2FsbGluZyB2ZHBhIHVucmVnaXN0ZXIgZGV2aWNl
Cj4+IFsgODE4MC4wNTM2NDddICB2aG9zdC12ZHBhLTA6IHZob3N0X3ZkcGFfcmVtb3ZlIHdhaXRp
bmcgZm9yIC9kZXYvdmhvc3QtdmRwYS0wIHRvIGJlIGNsb3NlZAo+Pgo+PiBbcm9vdEBuZHI3MzBw
IH5dIyBraWxsIC05IDEwOTMwCj4+IFsgODIxOC4zOTI4OTddIHNmY19lZjEwMCAwMDAwOjA2OjAw
LjA6IHNodXRkb3duIHN1Y2Nlc3NmdWwKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
