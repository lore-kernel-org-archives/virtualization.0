Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F22AC77B73
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 05:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF52482894;
	Wed, 31 May 2023 05:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF52482894
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5qdfblk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAJoF0om4fv7; Wed, 31 May 2023 05:22:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E03E822A9;
	Wed, 31 May 2023 05:22:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E03E822A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B482C007C;
	Wed, 31 May 2023 05:22:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBB59C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9518941EE0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9518941EE0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5qdfblk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kvev3tYi89NU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23D6141F2B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23D6141F2B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 05:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685510551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEQ7TS+vyvsvSkbc945GTeCJNzt8/T2iPFI6Ja2m7Tc=;
 b=B5qdfblkVVKKuA/r00eamUpEVrRISfsUxEhRpqkqeKdyC2ygEVvMNkQT7KaPeysnHw0SGX
 RNL1wG1KKnymrKvnOxZ2LaoVuIM5q5nCMwIABwuxnwBcm4m0fO+7uuRbFi3SMebqVIXAJj
 Wlyc5pkhT/Nv1YbyN1WZ0xJF4GG6Pb0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-e_MJzXM3OF-9wCIn1MAv5w-1; Wed, 31 May 2023 01:22:29 -0400
X-MC-Unique: e_MJzXM3OF-9wCIn1MAv5w-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-64d413b25caso6060790b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 22:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510549; x=1688102549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WEQ7TS+vyvsvSkbc945GTeCJNzt8/T2iPFI6Ja2m7Tc=;
 b=URKVPzZaobQ3OOhkHbq/Fd/n3XFCyKfn4DeMQs7EGGHoTP0EmZ9MmUiIjtR5/1pE06
 fB77+rT2cXJF2J0Gw6yvH3bFpCOM3faJuBIc9jEtSc5qhQ4xdXmyeek5snXpMjJzoxga
 NfP0azIT2LvcXLIF8g6HbR/LhDty0VPXil2+E5L0MWCwhMQJnPOeKlQIDDGoKn12l+je
 OMgx36xoIO6JBjvjJV4OH+OjSAmTUPtL72NEbya98sZAMreDq4GrlVUjgVC4qumOGQgP
 2ZezJOt2EMp9mW9KOBo88AuiJne16gpHtOqyjxpbxjsruoKqKfdiOcsWL+fLuCA6wPH0
 eyHw==
X-Gm-Message-State: AC+VfDzdTrgiWqyrnjRrzFKEzFNrFx7rHs6cy8qQ+GX2OdfLmMqfP6lr
 Dy0NqLaB2XD65WRHh5EiOljopQkfJYEYDeho2X6gq9S5M5iRqNr6a4wZvrI5DdX9/1zRcq4cnkD
 Drwaki6rO70XAHjRCpD4nGT6bL0S3r1WfquqZwJ+eCA==
X-Received: by 2002:a05:6a20:7fa7:b0:105:8173:93a0 with SMTP id
 d39-20020a056a207fa700b00105817393a0mr6006065pzj.5.1685510548708; 
 Tue, 30 May 2023 22:22:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7u0/KbgtxubOa7ggKO6fzLX5KAxiKr4jwHXNkdUFKNRBJw5oMEaCK0s5MaabHczQzM6Lyt9Q==
X-Received: by 2002:a05:6a20:7fa7:b0:105:8173:93a0 with SMTP id
 d39-20020a056a207fa700b00105817393a0mr6006055pzj.5.1685510548453; 
 Tue, 30 May 2023 22:22:28 -0700 (PDT)
Received: from [10.72.13.48] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s11-20020aa7828b000000b0063d670ad850sm2582842pfm.92.2023.05.30.22.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:22:28 -0700 (PDT)
Message-ID: <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
Date: Wed, 31 May 2023 13:22:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To: Oleg Nesterov <oleg@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230523121506.GA6562@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, linux@leemhuis.info, ebiederm@xmission.com,
 stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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

CuWcqCAyMDIzLzUvMjMgMjA6MTUsIE9sZWcgTmVzdGVyb3Yg5YaZ6YGTOgo+IE9uIDA1LzIyLCBP
bGVnIE5lc3Rlcm92IHdyb3RlOgo+PiBSaWdodCBub3cgSSB0aGluayB0aGF0ICJpbnQgZGVhZCIg
c2hvdWxkIGRpZSwKPiBObywgcHJvYmFibHkgd2Ugc2hvdWxkbid0IGNhbGwgZ2V0X3NpZ25hbCgp
IGlmIHdlIGhhdmUgYWxyZWFkeSBkZXF1ZXVlZCBTSUdLSUxMLgo+Cj4+IGJ1dCBsZXQgbWUgdGhp
bmsgdG9tb3Jyb3cuCj4gTWF5IGJlIHNvbWV0aGluZyBsaWtlIHRoaXMuLi4gSSBkb24ndCBsaWtl
IGl0IGJ1dCBJIGNhbid0IHN1Z2dlc3QgYW55dGhpbmcgYmV0dGVyCj4gcmlnaHQgbm93Lgo+Cj4g
CWJvb2wga2lsbGVkID0gZmFsc2U7Cj4KPiAJZm9yICg7Oykgewo+IAkJLi4uCj4gCQo+IAkJbm9k
ZSA9IGxsaXN0X2RlbF9hbGwoJndvcmtlci0+d29ya19saXN0KTsKPiAJCWlmICghbm9kZSkgewo+
IAkJCXNjaGVkdWxlKCk7Cj4gCQkJLyoKPiAJCQkgKiBXaGVuIHdlIGdldCBhIFNJR0tJTEwgb3Vy
IHJlbGVhc2UgZnVuY3Rpb24gd2lsbAo+IAkJCSAqIGJlIGNhbGxlZC4gVGhhdCB3aWxsIHN0b3Ag
bmV3IElPcyBmcm9tIGJlaW5nIHF1ZXVlZAo+IAkJCSAqIGFuZCBjaGVjayBmb3Igb3V0c3RhbmRp
bmcgY21kIHJlc3BvbnNlcy4gSXQgd2lsbCB0aGVuCj4gCQkJICogY2FsbCB2aG9zdF90YXNrX3N0
b3AgdG8gdGVsbCB1cyB0byByZXR1cm4gYW5kIGV4aXQuCj4gCQkJICovCj4gCQkJaWYgKHNpZ25h
bF9wZW5kaW5nKGN1cnJlbnQpKSB7Cj4gCQkJCXN0cnVjdCBrc2lnbmFsIGtzaWc7Cj4KPiAJCQkJ
aWYgKCFraWxsZWQpCj4gCQkJCQlraWxsZWQgPSBnZXRfc2lnbmFsKCZrc2lnKTsKPgo+IAkJCQlj
bGVhcl90aHJlYWRfZmxhZyhUSUZfU0lHUEVORElORyk7Cj4gCQkJfQo+Cj4gCQkJY29udGludWU7
Cj4gCQl9Cj4KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gQnV0IGxldCBtZSBhc2sgYSBjb3Vw
bGUgb2YgcXVlc3Rpb25zLiBMZXQncyBmb3JnZXQgdGhpcyBwYXRjaCwgbGV0J3MgbG9vayBhdCB0
aGUKPiBjdXJyZW50IGNvZGU6Cj4KPiAJCW5vZGUgPSBsbGlzdF9kZWxfYWxsKCZ3b3JrZXItPndv
cmtfbGlzdCk7Cj4gCQlpZiAoIW5vZGUpCj4gCQkJc2NoZWR1bGUoKTsKPgo+IAkJbm9kZSA9IGxs
aXN0X3JldmVyc2Vfb3JkZXIobm9kZSk7Cj4gCQkuLi4gcHJvY2VzcyB3b3JrcyAuLi4KPgo+IFRv
IG1lIHRoaXMgbG9va3MgYSBiaXQgY29uZnVzaW5nLiBTaG91bGRuJ3Qgd2UgZG8KPgo+IAkJaWYg
KCFub2RlKSB7Cj4gCQkJc2NoZWR1bGUoKTsKPiAJCQljb250aW51ZTsKPiAJCX0KPgo+IGp1c3Qg
dG8gbWFrZSB0aGUgY29kZSBhIGJpdCBtb3JlIGNsZWFyPyBJZiBub2RlID09IE5VTEwgdGhlbgo+
IGxsaXN0X3JldmVyc2Vfb3JkZXIoKSBhbmQgbGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpIHdp
bGwgZG8gbm90aGluZy4KPiBCdXQgdGhpcyBpcyBtaW5vci4KCgpZZXMuCgoKPgo+Cj4KPiAJCS8q
IG1ha2Ugc3VyZSBmbGFnIGlzIHNlZW4gYWZ0ZXIgZGVsZXRpb24gKi8KPiAJCXNtcF93bWIoKTsK
PiAJCWxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUod29yaywgd29ya19uZXh0LCBub2RlLCBub2Rl
KSB7Cj4gCQkJY2xlYXJfYml0KFZIT1NUX1dPUktfUVVFVUVELCAmd29yay0+ZmxhZ3MpOwo+Cj4g
SSBhbSBub3Qgc3VyZSBhYm91dCBzbXBfd21iICsgY2xlYXJfYml0LiBPbmNlIHdlIGNsZWFyIFZI
T1NUX1dPUktfUVVFVUVELAo+IHZob3N0X3dvcmtfcXVldWUoKSBjYW4gYWRkIHRoaXMgd29yayBh
Z2FpbiBhbmQgY2hhbmdlIHdvcmstPm5vZGUtPm5leHQuCj4KPiBUaGF0IGlzIHdoeSB3ZSB1c2Ug
X3NhZmUsIGJ1dCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0IGxsaXN0X2Zvcl9lYWNoX3NhZmUoKQo+
IGNvbXBsZXRlcyBMT0FEKHdvcmstPm5vZGUtPm5leHQpIGJlZm9yZSBWSE9TVF9XT1JLX1FVRVVF
RCBpcyBjbGVhcmVkLgoKClRoaXMgc2hvdWxkIGJlIGZpbmUgc2luY2Ugc3RvcmUgaXMgbm90IHNw
ZWN1bGF0ZWQsIHNvIHdvcmstPm5vZGUtPm5leHQgCm5lZWRzIHRvIGJlIGxvYWRlZCBiZWZvcmUg
VkhPU1RfV09SS19RVUVVRUQgaXMgY2xlYXJlZCB0byBtZWV0IHRoZSBsb29wIApjb25kaXRpb24u
CgoKPiBTbyBpdCBzZWVtcyB0aGF0IHNtcF93bWIoKSBjYW4ndCBoZWxwIGFuZCBzaG91bGQgYmUg
cmVtb3ZlZCwgaW5zdGVhZCB3ZSBuZWVkCj4KPiAJCWxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
Li4uKSB7Cj4gCQkJc21wX21iX19iZWZvcmVfYXRvbWljKCk7Cj4gCQkJY2xlYXJfYml0KFZIT1NU
X1dPUktfUVVFVUVELCAmd29yay0+ZmxhZ3MpOwo+Cj4gQWxzbywgaWYgdGhlIHdvcmstPmZuIHBv
aW50ZXIgaXMgbm90IHN0YWJsZSwgd2Ugc2hvdWxkIHJlYWQgaXQgYmVmb3JlCj4gc21wX21iX19i
ZWZvcmVfYXRvbWljKCkgYXMgd2VsbC4KCgpUaGUgZm4gd29uJ3QgYmUgY2hhbmdlZCBhZnRlciBp
dCBpcyBpbml0aWFsaXplZC4KCgo+Cj4gTm8/Cj4KPgo+IAkJCV9fc2V0X2N1cnJlbnRfc3RhdGUo
VEFTS19SVU5OSU5HKTsKPgo+IFdoeSBkbyB3ZSBzZXQgVEFTS19SVU5OSU5HIGluc2lkZSB0aGUg
bG9vcD8gRG9lcyB0aGlzIG1lYW4gdGhhdCB3b3JrLT5mbigpCj4gY2FuIHJldHVybiB3aXRoIGN1
cnJlbnQtPnN0YXRlICE9IFJVTk5JTkcgPwoKCkl0IGlzIGJlY2F1c2UgdGhlIHN0YXRlIHdlcmUg
c2V0IHRvIFRBU0tfSU5URVJSVVBUSUJMRSBpbiB0aGUgYmVnaW5uaW5nIApvZiB0aGUgbG9vcCBv
dGhlcndpc2UgaXQgbWlnaHQgYmUgc2lkZSBlZmZlY3Qgd2hpbGUgZXhlY3V0aW5nIHdvcmstPmZu
KCkuCgoKPgo+Cj4gCQkJd29yay0+Zm4od29yayk7Cj4KPiBOb3cgdGhlIG1haW4gcXVlc3Rpb24u
IFdoYXRldmVyIHdlIGRvLCBTSUdLSUxML1NJR1NUT1AvZXRjIGNhbiBjb21lIHJpZ2h0Cj4gYmVm
b3JlIHdlIGNhbGwgd29yay0+Zm4oKS4gSXMgaXQgInNhZmUiIHRvIHJ1biB0aGlzIGNhbGxiYWNr
IHdpdGgKPiBzaWduYWxfcGVuZGluZygpIG9yIGZhdGFsX3NpZ25hbF9wZW5kaW5nKCkgPwoKCkl0
IGxvb2tzIHNhZmUgc2luY2U6CgoxKSB2aG9zdCBob2xkIHJlZmNudCBvZiB0aGUgbW0KMikgcmVs
ZWFzZSB3aWxsIHN5bmMgd2l0aCB0aGUgd29ya2VyCgoKPgo+Cj4gRmluYWxseS4gSSBuZXZlciBs
b29rZWQgaW50byBkcml2ZXJzL3Zob3N0LyBiZWZvcmUgc28gSSBkb24ndCB1bmRlcnN0YW5kCj4g
dGhpcyBjb2RlIGF0IGFsbCwgYnV0IGxldCBtZSBhc2sgYW55d2F5Li4uIENhbiB3ZSBjaGFuZ2Ug
dmhvc3RfZGV2X2ZsdXNoKCkKPiB0byBydW4gdGhlIHBlbmRpbmcgY2FsbGJhY2tzIHJhdGhlciB0
aGFuIHdhaXQgZm9yIHZob3N0X3dvcmtlcigpID8KPiBJIGd1ZXNzIHdlIGNhbid0LCAtPm1tIHdv
bid0IGJlIGNvcnJlY3QsIGJ1dCBjYW4geW91IGNvbmZpcm0/CgoKWWVzLgoKVGhhbmtzCgoKPgo+
IE9sZWcuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
