Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE7C47094
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:50:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDBC60FDC
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDBC60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6EE4401C9;
	Mon, 31 May 2021 03:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CR4nX6fgbFhN; Mon, 31 May 2021 03:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1046440134;
	Mon, 31 May 2021 03:50:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2EE5C000E;
	Mon, 31 May 2021 03:50:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69EA5C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B94883576
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bd5zAHBx3pPv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69E2583466
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622433015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpeNMw8isZFAJbMGp8O11XcC9ucupJAP+AkvHbxEI2A=;
 b=C7t6p/NNN4S/JfCcrdas6K/bHAD6/OfaSRAlevj2miGQ19P7FMFSi53kKtGUCt2hSjbOlw
 hg8gQ5AVuGlNDvWE8MflG+8tneeR4mVhWURYT3m6+5VRmvOTNzhXIC6AU40gYNKkgzilgK
 0nfnxkUlDAsZtKXNBSzDbyrlORftjaM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-9QPp9QDyPm6vZ7Q_x1_YRw-1; Sun, 30 May 2021 23:50:13 -0400
X-MC-Unique: 9QPp9QDyPm6vZ7Q_x1_YRw-1
Received: by mail-pj1-f72.google.com with SMTP id
 pf14-20020a17090b1d8eb029015c31e36747so6454735pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 20:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qpeNMw8isZFAJbMGp8O11XcC9ucupJAP+AkvHbxEI2A=;
 b=XArxGrjBnQTIulwqjLkBqdLW2EiSupKONNx4uIhmr68nsq3s7jN0bDoApYoEsprspX
 Ce4GfLdwfg6pRvbQ4ytlFS2Js0RVlPzBQcWYtf8GPrye+RgzEN6xjy+QS/AxZ212vBgJ
 47CR+LZkUwcgJhBygiUUDoyfrkaNvUhAc6VFyvtI64+n/SMo18M0BCt5DFqtdq/8ytSf
 Yhc0bH7o7nkj7ws1F+wwDBDqyuKBvD70n+MD0UVQJSSo3P90pE7TOXBG7LAy1AiUSxul
 lOUMhzwYJGO6mhxGnNqQRseXGHijJcvn9MX+LjLp724+rY5i7uPbis5LKEgxaZVv1fwk
 1Iug==
X-Gm-Message-State: AOAM533ZM6SQlPGuZUOWZEaEYKer9Z/FAjoqzuL0BQd9sccdoN6qQrUv
 TG20xNHNS94mc2+UA4RJ4alvRdIL9mMce+tTHXs8XZp9Ifv2fAFXndRZrOPTge5g35GLE+n1SwR
 vtu9MzSAYI0yjbnnVzA8gCz56GmTF7vfb9zji12dMMA==
X-Received: by 2002:a63:ed58:: with SMTP id m24mr20832443pgk.436.1622433010445; 
 Sun, 30 May 2021 20:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh5ajzzz1pqhUPW44ACOp0tx1kVkv7GfZNROtur2edIoiKlqmcqwdL3lr/ufAac0tGI9TKEg==
X-Received: by 2002:a63:ed58:: with SMTP id m24mr20832419pgk.436.1622433010114; 
 Sun, 30 May 2021 20:50:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l20sm9352444pjq.38.2021.05.30.20.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 20:50:09 -0700 (PDT)
Subject: Re: [PATCH net 1/2] virtio-net: fix for unable to handle page fault
 for address
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210514151637.117596-1-xuanzhuo@linux.alibaba.com>
 <20210514151637.117596-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <687f4151-7375-c200-a7e6-6871be54201d@redhat.com>
Date: Mon, 31 May 2021 11:50:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210514151637.117596-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CtTaIDIwMjEvNS8xNCDPws7nMTE6MTYsIFh1YW4gWmh1byDQtLXAOgo+IEluIG1lcmdlIG1vZGUs
IHdoZW4geGRwIGlzIGVuYWJsZWQsIGlmIHRoZSBoZWFkcm9vbSBvZiBidWYgaXMgc21hbGxlcgo+
IHRoYW4gdmlydG5ldF9nZXRfaGVhZHJvb20oKSwgeGRwX2xpbmVhcml6ZV9wYWdlKCkgd2lsbCBi
ZSBjYWxsZWQgYnV0IHRoZQo+IHZhcmlhYmxlIG9mICJoZWFkcm9vbSIgaXMgc3RpbGwgMCwgd2hp
Y2ggbGVhZHMgdG8gd3JvbmcgbG9naWMgYWZ0ZXIKPiBlbnRlcmluZyBwYWdlX3RvX3NrYigpLgo+
Cj4gWyAgIDE2LjYwMDk0NF0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFk
ZHJlc3M6IGZmZmZlY2JmZmY3YjQzYzhbICAgMTYuNjAyMTc1XSAjUEY6IHN1cGVydmlzb3IgcmVh
ZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKPiBbICAgMTYuNjAzMzUwXSAjUEY6IGVycm9yX2NvZGUo
MHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKPiBbICAgMTYuNjA0MjAwXSBQR0QgMCBQNEQgMAo+
IFsgICAxNi42MDQ2ODZdIE9vcHM6IDAwMDAgWyMxXSBTTVAgUFRJCj4gWyAgIDE2LjYwNTMwNl0g
Q1BVOiA0IFBJRDogNzE1IENvbW06IHNoIFRhaW50ZWQ6IEcgICAgQiAgICAgICAgICAgICA1LjEy
LjArICMzMTIKPiBbICAgMTYuNjA2NDI5XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBD
IChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4xMi4wLTU5LWdjOWJhNTI3NmUzMjEt
cHJlYnVpbHQucWVtdS5vcmcgMDQvMDQKPiBbICAgMTYuNjA4MjE3XSBSSVA6IDAwMTA6dW5tYXBf
cGFnZV9yYW5nZSsweDk0Ny8weGRlMAo+IFsgICAxNi42MDkwMTRdIENvZGU6IDAwIDAwIDA4IDAw
IDQ4IDgzIGY4IDAxIDQ1IDE5IGU0IDQxIGY3IGQ0IDQxIDgzIGU0IDAzIGU5IGE0IGZkIGZmIGZm
IGU4IGI3IDYzIGVkIGZmIDRjIDg5IGUwIDQ4IGMxIGUwIDA2NQo+IFsgICAxNi42MTE4NjNdIFJT
UDogMDAxODpmZmZmYzkwMDAyNTAzYzU4IEVGTEFHUzogMDAwMTAyODYKPiBbICAgMTYuNjEyNzIw
XSBSQVg6IGZmZmZlY2JmZmY3YjQzYzAgUkJYOiAwMDAwN2YxOWY3MjAzMDAwIFJDWDogZmZmZmZm
ZmY4MTJmZjM1OQo+IFsgICAxNi42MTM4NTNdIFJEWDogZmZmZjg4ODEwNzc3ODAwMCBSU0k6IDAw
MDAwMDAwMDAwMDAwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDA1Cj4gWyAgIDE2LjYxNDk3Nl0gUkJQ
OiBmZmZmZWEwMDA0MjVlMDAwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDMwMzAzMDMwMzAz
MDMwMzAKPiBbICAgMTYuNjE2MTI0XSBSMTA6IGZmZmZmZmZmODJlZDdkOTQgUjExOiA2NjM3MzAz
MDMwMzAyMDUyIFIxMjogN2MwMDAwMGFmZmZkZWQwZgo+IFsgICAxNi42MTcyNzZdIFIxMzogMDAw
MDAwMDAwMDAwMDAwMSBSMTQ6IGZmZmY4ODgxMTllZTcwMTAgUjE1OiAwMDAwN2YxOWY3MjAyMDAw
Cj4gWyAgIDE2LjYxODQyM10gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODg0
MmZkMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMAo+IFsgICAxNi42MTk3MzhdIENT
OiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKPiBbICAgMTYu
NjIwNjcwXSBDUjI6IGZmZmZlY2JmZmY3YjQzYzggQ1IzOiAwMDAwMDAwMTAzMjIwMDA1IENSNDog
MDAwMDAwMDAwMDM3MGVlMAo+IFsgICAxNi42MjE3OTJdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBE
UjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwCj4gWyAgIDE2LjYyMjky
MF0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAw
MDAwMDAwMDA0MDAKPiBbICAgMTYuNjI0MDQ3XSBDYWxsIFRyYWNlOgo+IFsgICAxNi42MjQ1MjVd
ICA/IHJlbGVhc2VfcGFnZXMrMHgyNGQvMHg3MzAKPiBbICAgMTYuNjI1MjA5XSAgdW5tYXBfc2lu
Z2xlX3ZtYSsweGE5LzB4MTMwCj4gWyAgIDE2LjYyNTg4NV0gIHVubWFwX3ZtYXMrMHg3Ni8weGYw
Cj4gWyAgIDE2LjYyNjQ4MF0gIGV4aXRfbW1hcCsweGEwLzB4MjEwCj4gWyAgIDE2LjYyNzEyOV0g
IG1tcHV0KzB4NjcvMHgxODAKPiBbICAgMTYuNjI3NjczXSAgZG9fZXhpdCsweDNkMS8weGYxMAo+
IFsgICAxNi42MjgyNTldICA/IGRvX3VzZXJfYWRkcl9mYXVsdCsweDIzMS8weDg0MAo+IFsgICAx
Ni42MjkwMDBdICBkb19ncm91cF9leGl0KzB4NTMvMHhkMAo+IFsgICAxNi42Mjk2MzFdICBfX3g2
NF9zeXNfZXhpdF9ncm91cCsweDFkLzB4MjAKPiBbICAgMTYuNjMwMzU0XSAgZG9fc3lzY2FsbF82
NCsweDNjLzB4ODAKPiBbICAgMTYuNjMwOTg4XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NDQvMHhhZQo+IFsgICAxNi42MzE4MjhdIFJJUDogMDAzMzoweDdmMWEwNDNkMDE5MQo+
IFsgICAxNi42MzI0NjRdIENvZGU6IFVuYWJsZSB0byBhY2Nlc3Mgb3Bjb2RlIGJ5dGVzIGF0IFJJ
UCAweDdmMWEwNDNkMDE2Ny4KPiBbICAgMTYuNjMzNTAyXSBSU1A6IDAwMmI6MDAwMDdmZmUzZDk5
MzMwOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMGU3Cj4gWyAgIDE2
LjYzNDczN10gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdmMWEwNDRjOTQ5MCBSQ1g6
IDAwMDA3ZjFhMDQzZDAxOTEKPiBbICAgMTYuNjM1ODU3XSBSRFg6IDAwMDAwMDAwMDAwMDAwM2Mg
UlNJOiAwMDAwMDAwMDAwMDAwMGU3IFJESTogMDAwMDAwMDAwMDAwMDAwMAo+IFsgICAxNi42MzY5
ODZdIFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IGZmZmZmZmZmZmZmZmZmODggUjA5OiAwMDAw
MDAwMDAwMDAwMDAxCj4gWyAgIDE2LjYzODEyMF0gUjEwOiAwMDAwMDAwMDAwMDAwMDA4IFIxMTog
MDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA3ZjFhMDQ0Yzk0OTAKPiBbICAgMTYuNjM5MjQ1XSBS
MTM6IDAwMDAwMDAwMDAwMDAwMDEgUjE0OiAwMDAwN2YxYTA0NGM5OTY4IFIxNTogMDAwMDAwMDAw
MDAwMDAwMAo+IFsgICAxNi42NDA0MDhdIE1vZHVsZXMgbGlua2VkIGluOgo+IFsgICAxNi42NDA5
NThdIENSMjogZmZmZmVjYmZmZjdiNDNjOAo+IFsgICAxNi42NDE1NTddIC0tLVsgZW5kIHRyYWNl
IGJjNDg5MWM2Y2U0NjM1NGMgXS0tLQo+IFsgICAxNi42NDIzMzVdIFJJUDogMDAxMDp1bm1hcF9w
YWdlX3JhbmdlKzB4OTQ3LzB4ZGUwCj4gWyAgIDE2LjY0MzEzNV0gQ29kZTogMDAgMDAgMDggMDAg
NDggODMgZjggMDEgNDUgMTkgZTQgNDEgZjcgZDQgNDEgODMgZTQgMDMgZTkgYTQgZmQgZmYgZmYg
ZTggYjcgNjMgZWQgZmYgNGMgODkgZTAgNDggYzEgZTAgMDY1Cj4gWyAgIDE2LjY0NTk4M10gUlNQ
OiAwMDE4OmZmZmZjOTAwMDI1MDNjNTggRUZMQUdTOiAwMDAxMDI4Ngo+IFsgICAxNi42NDY4NDVd
IFJBWDogZmZmZmVjYmZmZjdiNDNjMCBSQlg6IDAwMDA3ZjE5ZjcyMDMwMDAgUkNYOiBmZmZmZmZm
ZjgxMmZmMzU5Cj4gWyAgIDE2LjY0Nzk3MF0gUkRYOiBmZmZmODg4MTA3Nzc4MDAwIFJTSTogMDAw
MDAwMDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwMDAwMDAwMDUKPiBbICAgMTYuNjQ5MDkxXSBSQlA6
IGZmZmZlYTAwMDQyNWUwMDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMzAzMDMwMzAzMDMw
MzAzMAo+IFsgICAxNi42NTAyNTBdIFIxMDogZmZmZmZmZmY4MmVkN2Q5NCBSMTE6IDY2MzczMDMw
MzAzMDIwNTIgUjEyOiA3YzAwMDAwYWZmZmRlZDBmCj4gWyAgIDE2LjY1MTM5NF0gUjEzOiAwMDAw
MDAwMDAwMDAwMDAxIFIxNDogZmZmZjg4ODExOWVlNzAxMCBSMTU6IDAwMDA3ZjE5ZjcyMDIwMDAK
PiBbICAgMTYuNjUyNTI5XSBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODQy
ZmQwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCj4gWyAgIDE2LjY1Mzg4N10gQ1M6
ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwo+IFsgICAxNi42
NTQ4NDFdIENSMjogZmZmZmVjYmZmZjdiNDNjOCBDUjM6IDAwMDAwMDAxMDMyMjAwMDUgQ1I0OiAw
MDAwMDAwMDAwMzcwZWUwCj4gWyAgIDE2LjY1NTk5Ml0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERS
MTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKPiBbICAgMTYuNjU3MTUw
XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAw
MDAwMDAwMDQwMAo+IFsgICAxNi42NTgyOTBdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBG
YXRhbCBleGNlcHRpb24KPiBbICAgMTYuNjU5NjEzXSBLZXJuZWwgT2Zmc2V0OiBkaXNhYmxlZAo+
IFsgICAxNi42NjAyMzRdIC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRh
bCBleGNlcHRpb24gXS0tLQo+Cj4gRml4ZXM6IGZiMzI4NTZiMTZhZCAoInZpcnRpby1uZXQ6IHBh
Z2VfdG9fc2tiKCkgdXNlIGJ1aWxkX3NrYiB3aGVuIHRoZXJlJ3Mgc3VmZmljaWVudCB0YWlscm9v
bSIpCj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNv
bT4KPiBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDEyICsrKysrKy0tLS0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBp
bmRleCA5YjZhNGE4NzVjNTUuLjNlNDZjMTJkZGUwOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMzgw
LDcgKzM4MCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmksCj4gICAJCQkJICAgc3RydWN0IHBhZ2UgKnBhZ2UsIHVuc2lnbmVkIGlu
dCBvZmZzZXQsCj4gICAJCQkJICAgdW5zaWduZWQgaW50IGxlbiwgdW5zaWduZWQgaW50IHRydWVz
aXplLAo+ICAgCQkJCSAgIGJvb2wgaGRyX3ZhbGlkLCB1bnNpZ25lZCBpbnQgbWV0YXNpemUsCj4g
LQkJCQkgICB1bnNpZ25lZCBpbnQgaGVhZHJvb20pCj4gKwkJCQkgICBib29sIHdob2xlX3BhZ2Up
Cj4gICB7Cj4gICAJc3RydWN0IHNrX2J1ZmYgKnNrYjsKPiAgIAlzdHJ1Y3QgdmlydGlvX25ldF9o
ZHJfbXJnX3J4YnVmICpoZHI7Cj4gQEAgLTM5OCwxMiArMzk4LDEyIEBAIHN0YXRpYyBzdHJ1Y3Qg
c2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJZWxzZQo+
ICAgCQloZHJfcGFkZGVkX2xlbiA9IHNpemVvZihzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyKTsKPiAg
IAo+IC0JLyogSWYgaGVhZHJvb20gaXMgbm90IDAsIHRoZXJlIGlzIGFuIG9mZnNldCBiZXR3ZWVu
IHRoZSBiZWdpbm5pbmcgb2YgdGhlCj4gKwkvKiBJZiB3aG9sZV9wYWdlLCB0aGVyZSBpcyBhbiBv
ZmZzZXQgYmV0d2VlbiB0aGUgYmVnaW5uaW5nIG9mIHRoZQo+ICAgCSAqIGRhdGEgYW5kIHRoZSBh
bGxvY2F0ZWQgc3BhY2UsIG90aGVyd2lzZSB0aGUgZGF0YSBhbmQgdGhlIGFsbG9jYXRlZAo+ICAg
CSAqIHNwYWNlIGFyZSBhbGlnbmVkLgo+ICAgCSAqLwo+IC0JaWYgKGhlYWRyb29tKSB7Cj4gLQkJ
LyogQnVmZmVycyB3aXRoIGhlYWRyb29tIHVzZSBQQUdFX1NJWkUgYXMgYWxsb2Mgc2l6ZSwKPiAr
CWlmICh3aG9sZV9wYWdlKSB7Cj4gKwkJLyogQnVmZmVycyB3aXRoIHdob2xlX3BhZ2UgdXNlIFBB
R0VfU0laRSBhcyBhbGxvYyBzaXplLAo+ICAgCQkgKiBzZWUgYWRkX3JlY3ZidWZfbWVyZ2VhYmxl
KCkgKyBnZXRfbWVyZ2VhYmxlX2J1Zl9sZW4oKQo+ICAgCQkgKi8KPiAgIAkJdHJ1ZXNpemUgPSBQ
QUdFX1NJWkU7Cj4gQEAgLTk1OCw3ICs5NTgsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJl
Y2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJCQkJcHV0X3BhZ2Uo
cGFnZSk7Cj4gICAJCQkJaGVhZF9za2IgPSBwYWdlX3RvX3NrYih2aSwgcnEsIHhkcF9wYWdlLCBv
ZmZzZXQsCj4gICAJCQkJCQkgICAgICAgbGVuLCBQQUdFX1NJWkUsIGZhbHNlLAo+IC0JCQkJCQkg
ICAgICAgbWV0YXNpemUsIGhlYWRyb29tKTsKPiArCQkJCQkJICAgICAgIG1ldGFzaXplLCB0cnVl
KTsKPiAgIAkJCQlyZXR1cm4gaGVhZF9za2I7CgoKUGF0Y2ggbG9va3MgY29ycmVjdCBidXQgSSdk
IHJhdGhlciBnbyB3aXRoIGEgbXVjaCBzaW1wbGUgb25lOgoKSG93IGFib3V0IGp1c3QgdXNlIFZJ
UlRORVRfWERQX0hFQURST09NIGluc3RlYWQgb2YgaGVhZHJvb20gaGVyZT8KClRoYW5rcwoKCj4g
ICAJCQl9Cj4gICAJCQlicmVhazsKPiBAQCAtMTAxNiw3ICsxMDE2LDcgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAg
CX0KPiAgIAo+ICAgCWhlYWRfc2tiID0gcGFnZV90b19za2IodmksIHJxLCBwYWdlLCBvZmZzZXQs
IGxlbiwgdHJ1ZXNpemUsICF4ZHBfcHJvZywKPiAtCQkJICAgICAgIG1ldGFzaXplLCBoZWFkcm9v
bSk7Cj4gKwkJCSAgICAgICBtZXRhc2l6ZSwgISFoZWFkcm9vbSk7Cj4gICAJY3Vycl9za2IgPSBo
ZWFkX3NrYjsKPiAgIAo+ICAgCWlmICh1bmxpa2VseSghY3Vycl9za2IpKQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
