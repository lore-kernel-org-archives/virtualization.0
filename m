Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B3C001DB
	for <virtualization@archiver.kernel.org>; Sat, 12 Aug 2023 00:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D240583B06;
	Sat, 12 Aug 2023 00:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D240583B06
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgmxEQGa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xh3SzYWB9e8O; Sat, 12 Aug 2023 00:48:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51B9983B40;
	Sat, 12 Aug 2023 00:48:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51B9983B40
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17483C0071;
	Sat, 12 Aug 2023 00:48:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DEC6C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Aug 2023 00:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 249B283B40
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Aug 2023 00:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 249B283B40
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R0OyhO8psZPz
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Aug 2023 00:48:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CF3983B06
 for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Aug 2023 00:48:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CF3983B06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691801283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLC/yOAR2d4wIWdWwjFchmmeIa+RdcqwrFVJ1+GuKDw=;
 b=hgmxEQGarnOQZuMKSheRJhCTU6jYcgoLQs5/O3JXDeV6RNmiFaqU+guQsV70vYHiNlmWtJ
 TyqM+nRG4ccf49i6CACNS/sYdE4fMEXMcLgEt6a7LsaGxwSqWmVT5dmUCIvbLvn0Cg4JcM
 nNg2RLdmu0Of173TzDYV2IKqTL4Ux68=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-lUtXwiZgPMmXVj5sVgtwdQ-1; Fri, 11 Aug 2023 20:47:54 -0400
X-MC-Unique: lUtXwiZgPMmXVj5sVgtwdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 918563C0ED49;
 Sat, 12 Aug 2023 00:47:53 +0000 (UTC)
Received: from [10.22.17.82] (unknown [10.22.17.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E04A2166B25;
 Sat, 12 Aug 2023 00:47:51 +0000 (UTC)
Message-ID: <2f84b806-193a-6d7c-71fe-cc718e9455f9@redhat.com>
Date: Fri, 11 Aug 2023 20:47:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V10 18/19] locking/qspinlock: Move pv_ops into x86
 directory
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>
References: <20230802164701.192791-1-guoren@kernel.org>
 <20230802164701.192791-19-guoren@kernel.org>
 <5cf1117c-d537-703c-cdcf-f43c5bd9ed1b@redhat.com>
 <CAJF2gTQ6zJrcyOVCqF+xDXTEzFYUVQuTP0rKy=K6R99TQ05CrA@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJF2gTQ6zJrcyOVCqF+xDXTEzFYUVQuTP0rKy=K6R99TQ05CrA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: Guo Ren <guoren@linux.alibaba.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 bjorn@rivosinc.com, palmer@rivosinc.com,
 virtualization@lists.linux-foundation.org, conor.dooley@microchip.com,
 jszhang@kernel.org, linux-riscv@lists.infradead.org, will@kernel.org,
 keescook@chromium.org, linux-arch@vger.kernel.org, anup@brainfault.org,
 linux-csky@vger.kernel.org, xiaoguang.xing@sophgo.com, mingo@redhat.com,
 greentime.hu@sifive.com, ajones@ventanamicro.com, alexghiti@rivosinc.com,
 paulmck@kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 paul.walmsley@sifive.com, tglx@linutronix.de, rdunlap@infradead.org,
 wuwei2016@iscas.ac.cn, wefu@redhat.com
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

Ck9uIDgvMTEvMjMgMjA6MjQsIEd1byBSZW4gd3JvdGU6Cj4gT24gU2F0LCBBdWcgMTIsIDIwMjMg
YXQgNDo0MuKAr0FNIFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+IHdyb3RlOgo+PiBP
biA4LzIvMjMgMTI6NDcsIGd1b3JlbkBrZXJuZWwub3JnIHdyb3RlOgo+Pj4gRnJvbTogR3VvIFJl
biA8Z3VvcmVuQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4KPj4+IFRoZSBwdl9vcHMgYmVsb25ncyB0
byB4ODYgY3VzdG9tIGluZnJhc3RydWN0dXJlIGFuZCBjbGVhbnMgdXAgdGhlCj4+PiBjbmFfY29u
ZmlndXJlX3NwaW5fbG9ja19zbG93cGF0aCgpIHdpdGggc3RhbmRhcmQgY29kZS4gVGhpcyBpcwo+
Pj4gcHJlcGFyYXRpb24gZm9yIHJpc2N2IHN1cHBvcnQgQ05BIHFzcG9pbmxvY2suCj4+IENOQSBx
c3BpbmxvY2sgaGFzIG5vdCBiZWVuIG1lcmdlZCBpbnRvIG1haW5saW5lIHlldC4gSSB3aWxsIHN1
Z2dlc3QgeW91Cj4+IGRyb3AgdGhlIGxhc3QgMiBwYXRjaGVzIGZvciBub3cuIE9mIGNvdXJzZSwg
eW91IGNhbiBwcm92aWRlIGJlbmNobWFyawo+PiBkYXRhIHRvIGJvb3N0IHRoZSBjYXNlIGZvciB0
aGUgaW5jbHVzaW9uIG9mIHRoZSBDTkEgcXNwaW5sb2NrIHBhdGNoIGludG8KPj4gdGhlIG1haW5s
aW5lLgo+IFllcywgbXkgbGF6eSwgSSB3b3VsZCBzZXBhcmF0ZSBwYXJhdmlydCBhbmQgQ05BIGZy
b20gdGhpcyBzZXJpZXMuCgpwYXJhdmlydCBpcyBPSywgaXQgaXMganVzdCB0aGF0IENOQSBoYXNu
J3QgYmVlbiBtZXJnZWQgeWV0LgoKQ2hlZXJzLApMb25nbWFuCgo+Cj4+IENoZWVycywKPj4gTG9u
Z21hbgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
