Return-Path: <SRS0=k2cl=LJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D3C48BE5
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 14:33:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165D561490
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 14:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165D561490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D70CB4037A;
	Tue, 15 Jun 2021 14:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id buLQ1C3_kAvR; Tue, 15 Jun 2021 14:33:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80BAC40012;
	Tue, 15 Jun 2021 14:33:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6DBC000D;
	Tue, 15 Jun 2021 14:33:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89C4BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 14:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 748B1834D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 14:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T6SD0JIdOllT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 14:33:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B36C834C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623767615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+PEwO1vuzVKwcAXZ/qn4zNQsNTC2ftksP1m6DzEJUg=;
 b=Lolxd9oNY3eqSJ8W+T9zYR0XiWrYAaCoHDa+e5QXYGD4eaHzc/Dva5ivyP/fZHCgE2uyZy
 J2LO3vS+U3tycUI9nOPErJVY6TMqySRCENcDcFvAbWmcz3NrpuCtY7/lpBBcZv7jukQxEG
 hIKqHVbbzupbdaEywnI0ooWg8HojaGE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-OHYDDwtGPLib7PY-bZ0bgA-1; Tue, 15 Jun 2021 10:33:31 -0400
X-MC-Unique: OHYDDwtGPLib7PY-bZ0bgA-1
Received: by mail-pg1-f197.google.com with SMTP id
 h1-20020a63df410000b0290222939c0dd7so2369327pgj.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=C+PEwO1vuzVKwcAXZ/qn4zNQsNTC2ftksP1m6DzEJUg=;
 b=IF5kpsv2ipZD7FSet1Uccx7wCxA96Qa2vcHJ6vNcREZMYLJVSIre9PyInv8+uSAiCP
 Zh66bg9nhGloEHhhQwPhEz/G9K/TXRTy/Cub4eYLy16+IVqInkp4GRR4mKsmsGHS04bc
 OUOiChhFMDEr66on69rLWYhOOh5uf1U7SvD4Pr/Y844YtLwcixRaPcvrwaEPaK6xGVBQ
 eW7zFT8Vh9T8OJeFWspCrPuuY4fZhJ04Nnb5yBGRx6W7KAJUUbsXNCE9IzA2pXeZJ2s5
 E0qf8VSt34KeOOYEgMrJaX/ZJaOqEhr+Q4NxmgfSo47vye8Go2s0A7Qd+WwXrZxThH3z
 80Rg==
X-Gm-Message-State: AOAM530o4M/p6fyX5r2nW+xQSY83IM8t03tYv98UjqUFgWGJeM6Gmdqe
 mS/DnzuV6h3WWvinDRskPnDvGYTr0Uf6ShZvvN8UESs6yGgBPHZlrVrVwMaXhDu6hvhKgkXq55K
 8tqbdqf1SphH1ndnz+2yYcpRFwScDa/x0EbDAlhAojA==
X-Received: by 2002:a17:90a:6b42:: with SMTP id
 x2mr10714889pjl.16.1623767610586; 
 Tue, 15 Jun 2021 07:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoLgAmk1b7+hVi09blQTTsivWllOjkeEFAcRwAwvRRMpCJnIURaBSkCjKYxfrUksdkBYUPgA==
X-Received: by 2002:a17:90a:6b42:: with SMTP id
 x2mr10714866pjl.16.1623767610322; 
 Tue, 15 Jun 2021 07:33:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o16sm13419988pfk.129.2021.06.15.07.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 07:33:29 -0700 (PDT)
Subject: Re: [PATCH] vhost-vdpa: log warning message if vhost_vdpa_remove gets
 blocked
To: Gautam Dawar <gdawar.xilinx@gmail.com>
References: <20210606132909.177640-1-gdawar.xilinx@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa866c72-c3d9-9022-aa5b-b5a9fc9e946a@redhat.com>
Date: Tue, 15 Jun 2021 22:33:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210606132909.177640-1-gdawar.xilinx@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, martinh@xilinx.com,
 hanand@xilinx.com
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

CtTaIDIwMjEvNi82IM/Czuc5OjI5LCBHYXV0YW0gRGF3YXIg0LS1wDoKPiBGcm9tOiBHYXV0YW0g
RGF3YXIgPGdkYXdhckB4aWxpbnguY29tPgo+Cj4gSWYgc29tZSBtb2R1bGUgaW52b2tlcyB2ZHBh
X2RldmljZV91bnJlZ2lzdGVyICh1c3VhbGx5IGluIHRoZSBtb2R1bGUKPiB1bmxvYWQgZnVuY3Rp
b24pIHdoZW4gdGhlIHVzZXJzcGFjZSBhcHAgKGVnLiBRRU1VKSB3aGljaCBoYWQgb3BlbmVkCj4g
dGhlIHZob3N0LXZkcGEgY2hhcmFjdGVyIGRldmljZSBpcyBzdGlsbCBydW5uaW5nLCB2aG9zdF92
ZHBhX3JlbW92ZSgpCj4gZnVuY3Rpb24gd2lsbCBibG9jayBpbmRlZmluaXRlbHkgaW4gY2FsbCB0
byB3YWl0X2Zvcl9jb21wbGV0aW9uKCkuCj4KPiBUaGlzIGNhdXNlcyB0aGUgdmRwYV9kZXZpY2Vf
dW5yZWdpc3RlciBjYWxsZXIgdG8gaGFuZyBhbmQgd2l0aCBhCj4gdXN1YWwgc2lkZS1lZmZlY3Qg
b2Ygcm1tb2QgY29tbWFuZCBub3QgcmV0dXJuaW5nIHdoZW4gdGhpcyBjYWxsCj4gaXMgaW4gdGhl
IG1vZHVsZV9leGl0IGZ1bmN0aW9uLgo+Cj4gVGhpcyBwYXRjaCBjb252ZXJ0cyB0aGUgd2FpdF9m
b3JfY29tcGxldGlvbiBjYWxsIHRvIGl0cyB0aW1lb3V0IGJhc2VkCj4gY291bnRlcnBhcnQgKHdh
aXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCkgYW5kIGFsc28gYWRkcyBhIHdhcm5pbmcKPiBtZXNz
YWdlIHRvIGFsZXJ0IHRoZSB1c2VyL2FkbWluaXN0cmF0b3IgYWJvdXQgdGhpcyBoYW5nIHNpdHVh
dGlvbi4KPgo+IFRvIGV2ZW50dWFsbHkgZml4IHRoaXMgcHJvYmxlbSwgYSBtZWNoYW5pc20gd2ls
bCBiZSByZXF1aXJlZCB0byBsZXQKPiB2aG9zdC12ZHBhIG1vZHVsZSBpbmZvcm0gdGhlIHVzZXJz
cGFjZSBvZiB0aGlzIHNpdHVhdGlvbiBhbmQKPiB1c2Vyc3BhY2Ugd2lsbCBjbG9zZSB0aGUgZGVz
Y3JpcHRvciBvZiB2aG9zdC12ZHBhIGNoYXIgZGV2aWNlLgo+IFRoaXMgd2lsbCBlbmFibGUgdmhv
c3QtdmRwYSB0byBjb250aW51ZSB3aXRoIGdyYWNlZnVsIGNsZWFuLXVwLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogR2F1dGFtIERhd2FyIDxnZGF3YXJAeGlsaW54LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
dmhvc3QvdmRwYS5jIHwgNiArKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBi
L2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggYmZhNGM2ZWY1NTRlLi41NzJiNjRkMDliMDYg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0
L3ZkcGEuYwo+IEBAIC0xMDkxLDcgKzEwOTEsMTEgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9y
ZW1vdmUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgCQlvcGVuZWQgPSBhdG9taWNfY21w
eGNoZygmdi0+b3BlbmVkLCAwLCAxKTsKPiAgIAkJaWYgKCFvcGVuZWQpCj4gICAJCQlicmVhazsK
PiAtCQl3YWl0X2Zvcl9jb21wbGV0aW9uKCZ2LT5jb21wbGV0aW9uKTsKPiArCQl3YWl0X2Zvcl9j
b21wbGV0aW9uX3RpbWVvdXQoJnYtPmNvbXBsZXRpb24sCj4gKwkJCQkJICAgIG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCkpOwo+ICsJCWRldl93YXJuX3JhdGVsaW1pdGVkKCZ2LT5kZXYsCj4gKwkJCQkg
ICAgICIlcyB3YWl0aW5nIGZvciAvZGV2LyVzIHRvIGJlIGNsb3NlZFxuIiwKPiArCQkJCSAgICAg
X19mdW5jX18sIGRldl9uYW1lKCZ2LT5kZXYpKTsKPiAgIAl9IHdoaWxlICgxKTsKPiAgIAo+ICAg
CXB1dF9kZXZpY2UoJnYtPmRldik7CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
