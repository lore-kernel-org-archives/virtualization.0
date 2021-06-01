Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E94C47092
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:53:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6C461375
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6C461375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D7F540253;
	Tue,  1 Jun 2021 08:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FE8gonnSxyeU; Tue,  1 Jun 2021 08:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09E77400C7;
	Tue,  1 Jun 2021 08:53:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA907C000D;
	Tue,  1 Jun 2021 08:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F3BC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FADB40253
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQz8WpWQwps8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6053E400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622537633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8WAcJsQSiURJqUup6/vHXemO9q3LwnkDENXrRbvbWL8=;
 b=URi0LcW1QvaHK+jeiInV8S0hKxw7JQvpT8UAgokoZF3wLHd9t3PKveCs9t7pKX9cEKpG34
 uoo9yLwKYVifs1GG4j3kemGD3nmKn12BWNky3VUdoDtPUhhiwHX3p/BfOGqWHTkQM2AKsI
 nSKWUZ/eI5Vy8K9RET2XaEka6ow382w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-5Y5tunQvNy-_7cqI0HGchA-1; Tue, 01 Jun 2021 04:53:51 -0400
X-MC-Unique: 5Y5tunQvNy-_7cqI0HGchA-1
Received: by mail-pl1-f199.google.com with SMTP id
 h3-20020a1709026803b029010163ec78c5so3316746plk.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 01:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=8WAcJsQSiURJqUup6/vHXemO9q3LwnkDENXrRbvbWL8=;
 b=a1SD/UT33BlYIf3KU1xJqCEWNUW+eyAk6uC2kip24/HHCc3IEelLn2C5RszphYWBdH
 PsLyjsJ/jvhKD4kwFyapqpLNI2L7cUqcF6naP0jp8WJrK3AOVhmo6URZtPatyVlJEtdE
 9x6gS1IkEM7ATngZ+9/aZRDmQf4TSAad6vyxU38FG7VQaWmA6igbHR8+ehxnI2/38+hm
 Gn1TR9ypVndcTZcG17ECe9VXQ4xwX84IfZy+8sGePCLvlRw8AcYfLjKbXQlBc2e2xpIe
 nBGpDMrmKOz8pX0jjZRjhzmSFd1LnwqBKRqb+/t3S7JOxTvMeTKX4zC+bNEcDgXB/kgy
 6tlA==
X-Gm-Message-State: AOAM531kUmNMMBadm/NSXk6czBtEHn7+XkBJd4R4F1feVdG4sHF2/qCY
 3TKecsErK7a4Wso91ifpDSyjsraOC0eXNXp/82SIczt6KWIKlKzcBnZycYBTqy7RgaLHkWqRjwi
 /hCagWeDCW8iOoO0J65zjqSw7GPojiePsPZqIwM6vPg==
X-Received: by 2002:a17:90a:b28d:: with SMTP id
 c13mr3860037pjr.80.1622537629590; 
 Tue, 01 Jun 2021 01:53:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVptUOSWsBZH9dICAaOjVBWfDa1kss0dK9yR27Sqmu8qKHzL6FHx0nXJZWYhsiYmSFNmpt0g==
X-Received: by 2002:a17:90a:b28d:: with SMTP id
 c13mr3860024pjr.80.1622537629393; 
 Tue, 01 Jun 2021 01:53:49 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 11sm12590666pfh.182.2021.06.01.01.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 01:53:48 -0700 (PDT)
Subject: Re: [PATCH net v2 1/2] virtio-net: fix for unable to handle page
 fault for address
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
 <20210601064000.66909-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e7b3a4b8-9f5c-1f17-9e7d-ab38bb193919@redhat.com>
Date: Tue, 1 Jun 2021 16:53:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601064000.66909-2-xuanzhuo@linux.alibaba.com>
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

CtTaIDIwMjEvNi8xIM/CzucyOjM5LCBYdWFuIFpodW8g0LS1wDoKPiBJbiBtZXJnZSBtb2RlLCB3
aGVuIHhkcCBpcyBlbmFibGVkLCBpZiB0aGUgaGVhZHJvb20gb2YgYnVmIGlzIHNtYWxsZXIKPiB0
aGFuIHZpcnRuZXRfZ2V0X2hlYWRyb29tKCksIHhkcF9saW5lYXJpemVfcGFnZSgpIHdpbGwgYmUg
Y2FsbGVkIGJ1dCB0aGUKPiB2YXJpYWJsZSBvZiAiaGVhZHJvb20iIGlzIHN0aWxsIDAsIHdoaWNo
IGxlYWRzIHRvIHdyb25nIGxvZ2ljIGFmdGVyCj4gZW50ZXJpbmcgcGFnZV90b19za2IoKS4KPgo+
IFsgICAxNi42MDA5NDRdIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRy
ZXNzOiBmZmZmZWNiZmZmN2I0M2M4WyAgIDE2LjYwMjE3NV0gI1BGOiBzdXBlcnZpc29yIHJlYWQg
YWNjZXNzIGluIGtlcm5lbCBtb2RlCj4gWyAgIDE2LjYwMzM1MF0gI1BGOiBlcnJvcl9jb2RlKDB4
MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlCj4gWyAgIDE2LjYwNDIwMF0gUEdEIDAgUDREIDAKPiBb
ICAgMTYuNjA0Njg2XSBPb3BzOiAwMDAwIFsjMV0gU01QIFBUSQo+IFsgICAxNi42MDUzMDZdIENQ
VTogNCBQSUQ6IDcxNSBDb21tOiBzaCBUYWludGVkOiBHICAgIEIgICAgICAgICAgICAgNS4xMi4w
KyAjMzEyCj4gWyAgIDE2LjYwNjQyOV0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAo
aTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEuMTIuMC01OS1nYzliYTUyNzZlMzIxLXBy
ZWJ1aWx0LnFlbXUub3JnIDA0LzA0Cj4gWyAgIDE2LjYwODIxN10gUklQOiAwMDEwOnVubWFwX3Bh
Z2VfcmFuZ2UrMHg5NDcvMHhkZTAKPiBbICAgMTYuNjA5MDE0XSBDb2RlOiAwMCAwMCAwOCAwMCA0
OCA4MyBmOCAwMSA0NSAxOSBlNCA0MSBmNyBkNCA0MSA4MyBlNCAwMyBlOSBhNCBmZCBmZiBmZiBl
OCBiNyA2MyBlZCBmZiA0YyA4OSBlMCA0OCBjMSBlMCAwNjUKPiBbICAgMTYuNjExODYzXSBSU1A6
IDAwMTg6ZmZmZmM5MDAwMjUwM2M1OCBFRkxBR1M6IDAwMDEwMjg2Cj4gWyAgIDE2LjYxMjcyMF0g
UkFYOiBmZmZmZWNiZmZmN2I0M2MwIFJCWDogMDAwMDdmMTlmNzIwMzAwMCBSQ1g6IGZmZmZmZmZm
ODEyZmYzNTkKPiBbICAgMTYuNjEzODUzXSBSRFg6IGZmZmY4ODgxMDc3NzgwMDAgUlNJOiAwMDAw
MDAwMDAwMDAwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwNQo+IFsgICAxNi42MTQ5NzZdIFJCUDog
ZmZmZmVhMDAwNDI1ZTAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAzMDMwMzAzMDMwMzAz
MDMwCj4gWyAgIDE2LjYxNjEyNF0gUjEwOiBmZmZmZmZmZjgyZWQ3ZDk0IFIxMTogNjYzNzMwMzAz
MDMwMjA1MiBSMTI6IDdjMDAwMDBhZmZmZGVkMGYKPiBbICAgMTYuNjE3Mjc2XSBSMTM6IDAwMDAw
MDAwMDAwMDAwMDEgUjE0OiBmZmZmODg4MTE5ZWU3MDEwIFIxNTogMDAwMDdmMTlmNzIwMjAwMAo+
IFsgICAxNi42MTg0MjNdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4NDJm
ZDAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKPiBbICAgMTYuNjE5NzM4XSBDUzog
IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gWyAgIDE2LjYy
MDY3MF0gQ1IyOiBmZmZmZWNiZmZmN2I0M2M4IENSMzogMDAwMDAwMDEwMzIyMDAwNSBDUjQ6IDAw
MDAwMDAwMDAzNzBlZTAKPiBbICAgMTYuNjIxNzkyXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIx
OiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMAo+IFsgICAxNi42MjI5MjBd
IERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAw
MDAwMDAwNDAwCj4gWyAgIDE2LjYyNDA0N10gQ2FsbCBUcmFjZToKPiBbICAgMTYuNjI0NTI1XSAg
PyByZWxlYXNlX3BhZ2VzKzB4MjRkLzB4NzMwCj4gWyAgIDE2LjYyNTIwOV0gIHVubWFwX3Npbmds
ZV92bWErMHhhOS8weDEzMAo+IFsgICAxNi42MjU4ODVdICB1bm1hcF92bWFzKzB4NzYvMHhmMAo+
IFsgICAxNi42MjY0ODBdICBleGl0X21tYXArMHhhMC8weDIxMAo+IFsgICAxNi42MjcxMjldICBt
bXB1dCsweDY3LzB4MTgwCj4gWyAgIDE2LjYyNzY3M10gIGRvX2V4aXQrMHgzZDEvMHhmMTAKPiBb
ICAgMTYuNjI4MjU5XSAgPyBkb191c2VyX2FkZHJfZmF1bHQrMHgyMzEvMHg4NDAKPiBbICAgMTYu
NjI5MDAwXSAgZG9fZ3JvdXBfZXhpdCsweDUzLzB4ZDAKPiBbICAgMTYuNjI5NjMxXSAgX194NjRf
c3lzX2V4aXRfZ3JvdXArMHgxZC8weDIwCj4gWyAgIDE2LjYzMDM1NF0gIGRvX3N5c2NhbGxfNjQr
MHgzYy8weDgwCj4gWyAgIDE2LjYzMDk4OF0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFt
ZSsweDQ0LzB4YWUKPiBbICAgMTYuNjMxODI4XSBSSVA6IDAwMzM6MHg3ZjFhMDQzZDAxOTEKPiBb
ICAgMTYuNjMyNDY0XSBDb2RlOiBVbmFibGUgdG8gYWNjZXNzIG9wY29kZSBieXRlcyBhdCBSSVAg
MHg3ZjFhMDQzZDAxNjcuCj4gWyAgIDE2LjYzMzUwMl0gUlNQOiAwMDJiOjAwMDA3ZmZlM2Q5OTMz
MDggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBlNwo+IFsgICAxNi42
MzQ3MzddIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZjFhMDQ0Yzk0OTAgUkNYOiAw
MDAwN2YxYTA0M2QwMTkxCj4gWyAgIDE2LjYzNTg1N10gUkRYOiAwMDAwMDAwMDAwMDAwMDNjIFJT
STogMDAwMDAwMDAwMDAwMDBlNyBSREk6IDAwMDAwMDAwMDAwMDAwMDAKPiBbICAgMTYuNjM2OTg2
XSBSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiBmZmZmZmZmZmZmZmZmZjg4IFIwOTogMDAwMDAw
MDAwMDAwMDAwMQo+IFsgICAxNi42MzgxMjBdIFIxMDogMDAwMDAwMDAwMDAwMDAwOCBSMTE6IDAw
MDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwN2YxYTA0NGM5NDkwCj4gWyAgIDE2LjYzOTI0NV0gUjEz
OiAwMDAwMDAwMDAwMDAwMDAxIFIxNDogMDAwMDdmMWEwNDRjOTk2OCBSMTU6IDAwMDAwMDAwMDAw
MDAwMDAKPiBbICAgMTYuNjQwNDA4XSBNb2R1bGVzIGxpbmtlZCBpbjoKPiBbICAgMTYuNjQwOTU4
XSBDUjI6IGZmZmZlY2JmZmY3YjQzYzgKPiBbICAgMTYuNjQxNTU3XSAtLS1bIGVuZCB0cmFjZSBi
YzQ4OTFjNmNlNDYzNTRjIF0tLS0KPiBbICAgMTYuNjQyMzM1XSBSSVA6IDAwMTA6dW5tYXBfcGFn
ZV9yYW5nZSsweDk0Ny8weGRlMAo+IFsgICAxNi42NDMxMzVdIENvZGU6IDAwIDAwIDA4IDAwIDQ4
IDgzIGY4IDAxIDQ1IDE5IGU0IDQxIGY3IGQ0IDQxIDgzIGU0IDAzIGU5IGE0IGZkIGZmIGZmIGU4
IGI3IDYzIGVkIGZmIDRjIDg5IGUwIDQ4IGMxIGUwIDA2NQo+IFsgICAxNi42NDU5ODNdIFJTUDog
MDAxODpmZmZmYzkwMDAyNTAzYzU4IEVGTEFHUzogMDAwMTAyODYKPiBbICAgMTYuNjQ2ODQ1XSBS
QVg6IGZmZmZlY2JmZmY3YjQzYzAgUkJYOiAwMDAwN2YxOWY3MjAzMDAwIFJDWDogZmZmZmZmZmY4
MTJmZjM1OQo+IFsgICAxNi42NDc5NzBdIFJEWDogZmZmZjg4ODEwNzc3ODAwMCBSU0k6IDAwMDAw
MDAwMDAwMDAwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDA1Cj4gWyAgIDE2LjY0OTA5MV0gUkJQOiBm
ZmZmZWEwMDA0MjVlMDAwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDMwMzAzMDMwMzAzMDMw
MzAKPiBbICAgMTYuNjUwMjUwXSBSMTA6IGZmZmZmZmZmODJlZDdkOTQgUjExOiA2NjM3MzAzMDMw
MzAyMDUyIFIxMjogN2MwMDAwMGFmZmZkZWQwZgo+IFsgICAxNi42NTEzOTRdIFIxMzogMDAwMDAw
MDAwMDAwMDAwMSBSMTQ6IGZmZmY4ODgxMTllZTcwMTAgUjE1OiAwMDAwN2YxOWY3MjAyMDAwCj4g
WyAgIDE2LjY1MjUyOV0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODg0MmZk
MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMAo+IFsgICAxNi42NTM4ODddIENTOiAg
MDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKPiBbICAgMTYuNjU0
ODQxXSBDUjI6IGZmZmZlY2JmZmY3YjQzYzggQ1IzOiAwMDAwMDAwMTAzMjIwMDA1IENSNDogMDAw
MDAwMDAwMDM3MGVlMAo+IFsgICAxNi42NTU5OTJdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6
IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwCj4gWyAgIDE2LjY1NzE1MF0g
RFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAw
MDAwMDA0MDAKPiBbICAgMTYuNjU4MjkwXSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRmF0
YWwgZXhjZXB0aW9uCj4gWyAgIDE2LjY1OTYxM10gS2VybmVsIE9mZnNldDogZGlzYWJsZWQKPiBb
ICAgMTYuNjYwMjM0XSAtLS1bIGVuZCBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwg
ZXhjZXB0aW9uIF0tLS0KPgo+IEZpeGVzOiBmYjMyODU2YjE2YWQgKCJ2aXJ0aW8tbmV0OiBwYWdl
X3RvX3NrYigpIHVzZSBidWlsZF9za2Igd2hlbiB0aGVyZSdzIHN1ZmZpY2llbnQgdGFpbHJvb20i
KQo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+
CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggOWI2YTRhODc1
YzU1Li42YjkyOWFjYTE1NWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTk1OCw3ICs5NTgsOCBAQCBz
dGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsCj4gICAJCQkJcHV0X3BhZ2UocGFnZSk7Cj4gICAJCQkJaGVhZF9za2IgPSBwYWdlX3Rv
X3NrYih2aSwgcnEsIHhkcF9wYWdlLCBvZmZzZXQsCj4gICAJCQkJCQkgICAgICAgbGVuLCBQQUdF
X1NJWkUsIGZhbHNlLAo+IC0JCQkJCQkgICAgICAgbWV0YXNpemUsIGhlYWRyb29tKTsKPiArCQkJ
CQkJICAgICAgIG1ldGFzaXplLAo+ICsJCQkJCQkgICAgICAgVklSVElPX1hEUF9IRUFEUk9PTSk7
Cj4gICAJCQkJcmV0dXJuIGhlYWRfc2tiOwo+ICAgCQkJfQo+ICAgCQkJYnJlYWs7CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
