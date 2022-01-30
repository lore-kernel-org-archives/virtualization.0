Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1275C433F5
	for <virtualization@archiver.kernel.org>; Sun, 30 Jan 2022 05:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5791C40554;
	Sun, 30 Jan 2022 05:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksZpHe3bxozA; Sun, 30 Jan 2022 05:07:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12EC24055D;
	Sun, 30 Jan 2022 05:07:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE100C0011;
	Sun, 30 Jan 2022 05:07:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 346C0C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 05:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E89D400E0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 05:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kW48J4O6LaxZ
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 05:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5B8F40342
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jan 2022 05:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643519218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yu5ck5PDQxU8W0XKcd5kpr4kTqE1JkiqoCZ6NoOdIFE=;
 b=HEv/YiC5N9ZJ0py5wnUFkCF4ReOhQUio+ix6E/DNivxUt3IriRBPlEkaK35IWdIOmK6eo6
 3CuagFv4rM0x/p6GhM0kAurI1dcCZqrTyK56GeAEbOcVKBylRdHuD56dNClrK4wmBJBd8w
 DQFb4VUQ0Dg10YvXASSiNhlPbURClfA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-mPfJxNbQMG6icg9_lBWZ4A-1; Sun, 30 Jan 2022 00:06:56 -0500
X-MC-Unique: mPfJxNbQMG6icg9_lBWZ4A-1
Received: by mail-pj1-f70.google.com with SMTP id
 o72-20020a17090a0a4e00b001b4e5b5b6c0so6600833pjo.5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jan 2022 21:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yu5ck5PDQxU8W0XKcd5kpr4kTqE1JkiqoCZ6NoOdIFE=;
 b=kxZEJWC6RYtBwJOrwLtEvlThp/gC/i64tewt20uYn//LelSjgKf4l7QoMBqYj2BrVA
 vofZrnobPpbmXu3tEbZ/Rat86cTh0nGKNfx6gx+6iRfY36lzXhy+bFRUbj85PRASK0dQ
 1LuTd8HObR1SUygcuh2fwQuc+Of6x+Pm7DT9b8m7WcrZn7QLJedFmnH/NmQtDfMZlwXZ
 s7+MiCDYvT8FmquOvPqc9KOOOl+/8qYVPwCUIP6CNjpnKf73HW/Ywy23btls39XasL1s
 BvGEehnZPKWXBlKpHP/kjSG3f93oCxTTaaGHVqRtDFFq6T3/4Efq648WWP/1QbH7sWrk
 oxqw==
X-Gm-Message-State: AOAM531q2fVtSuaoWFB7CfHNqUMGLbkyIuJe3riDMMVjDQKlcEx2QFal
 WjCxO0EV1t5iuygY/ZctS+6+MHae22E5mhOVyH649bPgqFLNxXQCCiZOrnAxtpw+R1wOKmMDGKe
 1rINQCU6m2CpNm/4j9g+KXuwx2YM6ORBCMZ6+0msKVA==
X-Received: by 2002:a63:dc42:: with SMTP id f2mr12151721pgj.477.1643519215356; 
 Sat, 29 Jan 2022 21:06:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxToInrjlwfxIHjC6YNfIXQZMyFaCJGBolp1KUblezk5XHg2/nK31KFXChPTQB40dXlg8poQ==
X-Received: by 2002:a63:dc42:: with SMTP id f2mr12151703pgj.477.1643519215089; 
 Sat, 29 Jan 2022 21:06:55 -0800 (PST)
Received: from [10.72.13.18] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c6sm14281603pfl.200.2022.01.29.21.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jan 2022 21:06:54 -0800 (PST)
Message-ID: <1140466a-ef7d-7b02-cc9a-fcbe6be49f3c@redhat.com>
Date: Sun, 30 Jan 2022 13:06:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 21/31] util: Add iova_tree_alloc
To: Eugenio Perez Martin <eperezma@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-22-eperezma@redhat.com> <Ye4r7tKFhP9VaT5/@xz-m1.local>
 <CAJaqyWf--wbNZz5ZzbpixD9op_fO5fV01kbYXzG097c_NkqYrw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWf--wbNZz5ZzbpixD9op_fO5fV01kbYXzG097c_NkqYrw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjQg5LiL5Y2INToyMCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIE1vbiwgSmFuIDI0LCAyMDIyIGF0IDU6MzMgQU0gUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQu
Y29tPiB3cm90ZToKPj4gT24gRnJpLCBKYW4gMjEsIDIwMjIgYXQgMDk6Mjc6MjNQTSArMDEwMCwg
RXVnZW5pbyBQw6lyZXogd3JvdGU6Cj4+PiAraW50IGlvdmFfdHJlZV9hbGxvYyhJT1ZBVHJlZSAq
dHJlZSwgRE1BTWFwICptYXAsIGh3YWRkciBpb3ZhX2JlZ2luLAo+IEkgZm9yZ290IHRvIHMvaW92
YV90cmVlX2FsbG9jL2lvdmFfdHJlZV9hbGxvY19tYXAvIGhlcmUuCj4KPj4+ICsgICAgICAgICAg
ICAgICAgICAgIGh3YWRkciBpb3ZhX2xhc3QpCj4+PiArewo+Pj4gKyAgICBjb25zdCBETUFNYXBJ
bnRlcm5hbCAqbGFzdCwgKmk7Cj4+PiArCj4+PiArICAgIGFzc2VydChpb3ZhX2JlZ2luIDwgaW92
YV9sYXN0KTsKPj4+ICsKPj4+ICsgICAgLyoKPj4+ICsgICAgICogRmluZCBhIHZhbGlkIGhvbGUg
Zm9yIHRoZSBtYXBwaW5nCj4+PiArICAgICAqCj4+PiArICAgICAqIFRPRE86IFJlcGxhY2UgYWxs
IHRoaXMgd2l0aCBnX3RyZWVfbm9kZV9maXJzdC9uZXh0L2xhc3Qgd2hlbiBhdmFpbGFibGUKPj4+
ICsgICAgICogKGZyb20gZ2xpYiBzaW5jZSAyLjY4KS4gVXNpbmcgYSBzZXBwYXJhdGVkIFFUQUlM
USBjb21wbGljYXRlcyBjb2RlLgo+Pj4gKyAgICAgKgo+Pj4gKyAgICAgKiBUcnkgdG8gYWxsb2Nh
dGUgZmlyc3QgYXQgdGhlIGVuZCBvZiB0aGUgbGlzdC4KPj4+ICsgICAgICovCj4+PiArICAgIGxh
c3QgPSBRVEFJTFFfTEFTVCgmdHJlZS0+bGlzdCk7Cj4+PiArICAgIGlmIChpb3ZhX3RyZWVfYWxs
b2NfbWFwX2luX2hvbGUobGFzdCwgTlVMTCwgaW92YV9iZWdpbiwgaW92YV9sYXN0LAo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcC0+c2l6ZSkpIHsKPj4+ICsgICAg
ICAgIGdvdG8gYWxsb2M7Cj4+PiArICAgIH0KPj4+ICsKPj4+ICsgICAgLyogTG9vayBmb3IgaW5u
ZXIgaG9sZSAqLwo+Pj4gKyAgICBsYXN0ID0gTlVMTDsKPj4+ICsgICAgZm9yIChpID0gUVRBSUxR
X0ZJUlNUKCZ0cmVlLT5saXN0KTsgaTsKPj4+ICsgICAgICAgICBsYXN0ID0gaSwgaSA9IFFUQUlM
UV9ORVhUKGksIGVudHJ5KSkgewo+Pj4gKyAgICAgICAgaWYgKGlvdmFfdHJlZV9hbGxvY19tYXBf
aW5faG9sZShsYXN0LCBpLCBpb3ZhX2JlZ2luLCBpb3ZhX2xhc3QsCj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcC0+c2l6ZSkpIHsKPj4+ICsgICAgICAgICAg
ICBnb3RvIGFsbG9jOwo+Pj4gKyAgICAgICAgfQo+Pj4gKyAgICB9Cj4+PiArCj4+PiArICAgIHJl
dHVybiBJT1ZBX0VSUl9OT01FTTsKPj4+ICsKPj4+ICthbGxvYzoKPj4+ICsgICAgbWFwLT5pb3Zh
ID0gbGFzdCA/IGxhc3QtPm1hcC5pb3ZhICsgbGFzdC0+bWFwLnNpemUgKyAxIDogaW92YV9iZWdp
bjsKPj4+ICsgICAgcmV0dXJuIGlvdmFfdHJlZV9pbnNlcnQodHJlZSwgbWFwKTsKPj4+ICt9Cj4+
IEhpLCBFdWdlbmlvLAo+Pgo+PiBIYXZlIHlvdSB0cmllZCB3aXRoIHdoYXQgSmFzb24gc3VnZ2Vz
dGVkIHByZXZpb3VzbHk/Cj4+Cj4+ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvQ0FDR2tNRXRaQVBkOXhRVFBfUjR3Mjk2Tl9RejdWdVYxRkxuYjU0NGZFVm9ZTzBvZitnQG1h
aWwuZ21haWwuY29tLwo+Pgo+PiBUaGF0IHNvbHV0aW9uIHN0aWxsIHNvdW5kcyB2ZXJ5IHNlbnNp
YmxlIHRvIG1lIGV2ZW4gd2l0aG91dCB0aGUgbmV3bHkKPj4gaW50cm9kdWNlZCBsaXN0IGluIHBy
ZXZpb3VzIHR3byBwYXRjaGVzLgo+Pgo+PiBJTUhPIHdlIGNvdWxkIG1vdmUgIkRNQU1hcCAqcHJl
dmlvdXMsICp0aGlzIiBpbnRvIHRoZSBJT1ZBVHJlZUFsbG9jQXJncyoKPj4gc3R1Y3R1cmUgdGhh
dCB3YXMgcGFzc2VkIGludG8gdGhlIHRyYXZlcnNlIGZ1bmMgdGhvdWdoLCBzbyBpdCdsbCBuYXR1
cmFsbHkgd29yawo+PiB3aXRoIHRocmVhZGluZy4KPj4KPj4gT3IgaXMgdGhlcmUgYW55IGJsb2Nr
ZXIgZm9yIGl0Pwo+Pgo+IEhpIFBldGVyLAo+Cj4gSSBjYW4gdHJ5IHRoYXQgc29sdXRpb24gYWdh
aW4sIGJ1dCB0aGUgbWFpbiBwcm9ibGVtIHdhcyB0aGUgc3BlY2lhbAo+IGNhc2VzIG9mIHRoZSBi
ZWdpbm5pbmcgYW5kIGVuZGluZy4KPgo+IEZvciB0aGUgZnVuY3Rpb24gdG8gbG9jYXRlIGEgaG9s
ZSwgRE1BTWFwIGZpcnN0ID0gey5pb3ZhID0gMCwgLnNpemUgPQo+IDB9IG1lYW5zIHRoYXQgaXQg
Y2Fubm90IGFjY291bnQgMCBmb3IgdGhlIGhvbGUuCj4KPiBJbiBvdGhlciB3b3Jkcywgd2l0aCB0
aGF0IGFsZ29yaXRobSwgaWYgdGhlIG9ubHkgdmFsaWQgaG9sZSBpcyBbMCwgTikKPiBhbmQgd2Ug
dHJ5IHRvIGFsbG9jYXRlIGEgYmxvY2sgb2Ygc2l6ZSBOLCBpdCB3b3VsZCBmYWlsLgo+Cj4gU2Ft
ZSBoYXBwZW5zIHdpdGggaW92YV9lbmQsIGFsdGhvdWdoIGluIHByYWN0aWNlIGl0IHNlZW1zIHRo
YXQgSU9NTVUKPiBoYXJkd2FyZSBpb3ZhIHVwcGVyIGxpbWl0IGlzIG5ldmVyIFVJTlQ2NF9NQVgu
Cj4KPiBNYXliZSB3ZSBjb3VsZCB0cmVhdCAuc2l6ZSA9IDAgYXMgYSBzcGVjaWFsIGNhc2U/CgoK
WWVzLCB0aGUgcHNldWRvLWNvZGUgSSBwYXN0IGlzIGp1c3QgdG8gc2hvdyB0aGUgaWRlYSBvZiB1
c2luZyAKZ190cmVlX2ZvcmVhY2goKSBpbnN0ZWFkIG9mIGludHJvZHVjaW5nIG5ldyBhdXhpbGlh
cnkgZGF0YSBzdHJ1Y3R1cmVzLiAKVGhhdCB3aWxsIHNpbXBsaWZ5IGJvdGggdGhlIGNvZGVzIGFu
ZCB0aGUgcmV2aWV3ZXJzLgoKRG93biB0aGUgcm9hZCwgd2UgbWF5IHN0YXJ0IGZyb20gYW4gaW92
YSByYW5nZSBzcGVjaWZpZWQgZHVyaW5nIHRoZSAKY3JlYXRpb24gb2YgdGhlIGlvdmEgdHJlZS4g
RS5nIGZvciB2dGQsIGl0J3MgdGhlIEdBVywgZm9yIHZob3N0LXZkcGEsIAppdCdzIHRoZSBvbmUg
dGhhdCB3ZSBnZXQgZnJvbSBWSE9TVF9WRFBBX0dFVF9JT1ZBX1JBTkdFLgoKVGhhbmtzCgoKPiBJ
IHNlZSBjbGVhbmVyIGVpdGhlcgo+IHRvIGJ1aWxkIHRoZSBsaXN0IChidXQgaW5zZXJ0IG5lZWRz
IHRvIHRha2UgdGhlIGxpc3QgaW50byBhY2NvdW50KSBvcgo+IHRvIGV4cGxpY2l0bHkgdGVsbCB0
aGF0IHByZXYgPT0gTlVMTCBtZWFucyB0byB1c2UgaW92YV9maXJzdC4KPgo+IEFub3RoZXIgc29s
dXRpb24gdGhhdCBjb21lcyB0byBteSBtaW5kOiB0byBhZGQgYm90aCBleGNlcHRpb25zIG91dHNp
ZGUKPiBvZiB0cmFuc3ZlcnNlIGZ1bmN0aW9uLCBhbmQgc2tpcCB0aGUgZmlyc3QgaXRlcmF0aW9u
IHdpdGggc29tZXRoaW5nCj4gbGlrZToKPgo+IGlmIChwcmV2ID09IE5VTEwpIHsKPiAgICBwcmV2
ID0gdGhpczsKPiAgICByZXR1cm4gZmFsc2UgLyogY29udGludWUgKi8KPiB9Cj4KPiBTbyB0aGUg
dHJhbnN2ZXJzZSBjYWxsYmFjayBoYXMgd2F5IGxlc3MgY29kZSBwYXRocy4gV291bGQgaXQgd29y
ayBmb3IKPiB5b3UgaWYgSSBzZW5kIGEgc2VwYXJhdGUgUkZDIGZyb20gU1ZRIG9ubHkgdG8gdmFs
aWRhdGUgdGhpcz8KPgo+IFRoYW5rcyEKPgo+PiBUaGFua3MsCj4+IC0tCj4+IFBldGVyIFh1Cj4+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
