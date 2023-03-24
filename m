Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC527C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FACB401AD;
	Fri, 24 Mar 2023 06:48:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FACB401AD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Twrpl5WH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IA3ZRkpYS6ER; Fri, 24 Mar 2023 06:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D516540236;
	Fri, 24 Mar 2023 06:48:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D516540236
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDCA4C0035;
	Fri, 24 Mar 2023 06:48:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 311D7C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B7C7402C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B7C7402C8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Twrpl5WH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XpOy6unGMULz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E462402B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E462402B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679640489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMMtXyRXMzHiopY6UfP6d0MdZO74TE/uQP9qHqYj7Uk=;
 b=Twrpl5WHKSm9hnI1+aOMXethR9jCfo1UsI3rdVoBD1s5RjxXrbS0Y4c+iFLIR0tntXVjwJ
 k8he76OE4sJAl0x7yO8EjS4Tih4FWXgWPw3sYjXHywkQTxdm7kvhvzMAwszHQOiamFVirW
 y+YsvNv+lLix2oBk2vlNhegajpjiQjc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-pWNzoGzlN4anyETSBxRfmw-1; Fri, 24 Mar 2023 02:48:08 -0400
X-MC-Unique: pWNzoGzlN4anyETSBxRfmw-1
Received: by mail-ot1-f72.google.com with SMTP id
 k29-20020a9d701d000000b006a037b882d8so372329otj.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 23:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679640488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMMtXyRXMzHiopY6UfP6d0MdZO74TE/uQP9qHqYj7Uk=;
 b=6mWMW3e2jbOvqkgE5FY3UHGPG4aRXjrntvBGdDB1Jfm+IjQZVPGcZc1y0TcON5XDz/
 rkqCH8xWDTym0aC6/4B1veWzNdQKGmcGI9qbmoOhUvQdRIA+3R3kbXU3lGD9mIWfqyfn
 52advElDh7dTEUstErws8LbF0PMfw7lFkW3wfvJ2cXuMhb8i9hIWg707BQM8zTE62Al3
 HVQQxom9eKDG+JmJtgpTSTbmlU9J1MszEm0RZ993BBPEuox/vnj5eKCI01nUZk0wo+77
 /hFFre/6I0fhSiJGsNDK/p59qRkBTaeNvPnXMY1aE0LGMTYGor5oRSoENQO4ortTm3Lv
 62XA==
X-Gm-Message-State: AAQBX9fa9+iSl5sUBAuqtCX+9h9VJphmhVO4bvVheQue5U3hLswLVF0L
 YIU1gY/OuPqyfxzTCqK6NvPyneFB3hj+54v5coG4dqKANR/416wLU6Vle7xlYhiWe3JALQR0eCl
 +CGnaAar6Ad/BcUaQfHFhRl1Ft5mnwaDTgrLcegp+Qlk+0EQEDh8Ab0fWYQ==
X-Received: by 2002:a05:6871:8891:b0:17e:7674:8df0 with SMTP id
 tg17-20020a056871889100b0017e76748df0mr644024oab.9.1679640487829; 
 Thu, 23 Mar 2023 23:48:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y7xQXEulGO6vdBPBkXvtuWP7guRzZY5YIoWsMus2va/IzyYLY1IYKz9bg/v98Zk9y/aKH8yYULeHtnVUENMUI=
X-Received: by 2002:a05:6871:8891:b0:17e:7674:8df0 with SMTP id
 tg17-20020a056871889100b0017e76748df0mr644021oab.9.1679640487651; Thu, 23 Mar
 2023 23:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
 <20230324063010.48670-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230324063010.48670-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Mar 2023 14:47:56 +0800
Message-ID: <CACGkMEtoii-vXeFfdcYQ8VMk-PomqNMdpcZ9ymVvZ39zZ=6s0g@mail.gmail.com>
Subject: Re: [PATCH vhost v5 05/11] virtio_ring: packed: support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMjozMOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gdmlydGlvIGNvcmUgb25seSBzdXBwb3J0cyB2aXJ0
dWFsIGFkZHJlc3NlcywgZG1hIGlzIGNvbXBsZXRlZCBpbiB2aXJ0aW8KPiBjb3JlLgo+Cj4gSW4g
c29tZSBzY2VuYXJpb3MgKHN1Y2ggYXMgdGhlIEFGX1hEUCksIHRoZSBtZW1vcnkgaXMgYWxsb2Nh
dGVkCj4gYW5kIERNQSBtYXBwaW5nIGlzIGNvbXBsZXRlZCBpbiBhZHZhbmNlLCBzbyBpdCBpcyBu
ZWNlc3NhcnkgZm9yIHVzIHRvCj4gc3VwcG9ydCBwYXNzaW5nIHRoZSBETUEgYWRkcmVzcyB0byB2
aXJ0aW8gY29yZS4KPgo+IERyaXZlcyBjYW4gdXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIHRo
ZSBtYXBwZWQgZG1hIGFkZHJlc3MgdG8gdmlydGlvCj4gY29yZS4gSWYgb25lIHNnLT5kbWFfYWRk
cmVzcyBpcyB1c2VkIHRoZW4gYWxsIHNncyBtdXN0IHVzZQo+IHNnLT5kbWFfYWRkcmVzcywgb3Ro
ZXJ3aXNlIGFsbCBtdXN0IGJlIG51bGwgd2hlbiBwYXNzaW5nIGl0IHRvIHRoZSBBUElzCj4gb2Yg
dmlydGlvLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDE3ICsrKysr
KysrKysrKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMWMzMDg0YThmNGUzLi5kZjZkNTE0
YTY4MWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtNzgsNiArNzgsNyBAQCBzdHJ1Y3Qg
dnJpbmdfZGVzY19zdGF0ZV9zcGxpdCB7Cj4gIHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3BhY2tl
ZCB7Cj4gICAgICAgICB2b2lkICpkYXRhOyAgICAgICAgICAgICAgICAgICAgIC8qIERhdGEgZm9y
IGNhbGxiYWNrLiAqLwo+ICAgICAgICAgc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICppbmRpcl9k
ZXNjOyAvKiBJbmRpcmVjdCBkZXNjcmlwdG9yLCBpZiBhbnkuICovCj4gKyAgICAgICB1NjQgZmxh
Z3M7ICAgICAgICAgICAgICAgICAgICAgIC8qIFN0YXRlIGZsYWdzLiAqLwoKSSdkIHVzZSB1MzIg
dGhlbiB0aGVyZSB3b3VsZCBiZSBubyBuZWVkIGZvciB0aGUgY29tcGlsZXIgdG8gcGFkIHRoZQpz
dHJ1Y3R1cmUgaW4gYm90aCAzMiBhbmQgNjQgYml0IGFyY2hzLgoKVGhhbmtzCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
