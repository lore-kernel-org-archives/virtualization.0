Return-Path: <SRS0=qiqk=DQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C24BC433E7
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 03:59:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86812224A
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 03:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwmdv+Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86812224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 703E487436;
	Fri,  9 Oct 2020 03:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZxfGmXPdWaE8; Fri,  9 Oct 2020 03:59:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B3F17873A8;
	Fri,  9 Oct 2020 03:59:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E7E9C016F;
	Fri,  9 Oct 2020 03:59:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13D3AC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0FC20876A5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GmP66UvkaVru
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:59:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 89A6F8763B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602215995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeARdKdxXITMJyQg5RZv73lx5offC2uV5GIuBo7fxJ0=;
 b=Jwmdv+QehAXxxrzGJXA/Eyhkml5RTKmn/6dFv0aDZKYiW/Aezr9tdLPmltZkcRCWoyWFjv
 kN/k89OXbsOZg1VesieAVgjt6Ucf+Ixl8jcKsWlNWtCr4l3nFlOJsOAKQ/P5mtPzk47odG
 fWhnM+BswF0hLrevFnjvv7EG+FLxZp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-ovPi3MAeMFqZ6s7Ym02ajw-1; Thu, 08 Oct 2020 23:59:52 -0400
X-MC-Unique: ovPi3MAeMFqZ6s7Ym02ajw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579CB425D7;
 Fri,  9 Oct 2020 03:59:50 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 013996EF58;
 Fri,  9 Oct 2020 03:59:17 +0000 (UTC)
Subject: Re: [RFC PATCH 18/24] vhost-vdpa: support ASID based IOTLB API
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-19-jasowang@redhat.com>
 <CAJaqyWcsEfJ5n+U-8iNXEM-L4Y9buZntgmMdjPxKCtLxo2cEiw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e0f5e0e4-8aaf-60f0-258c-e11f8c5013fb@redhat.com>
Date: Fri, 9 Oct 2020 11:59:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcsEfJ5n+U-8iNXEM-L4Y9buZntgmMdjPxKCtLxo2cEiw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Cindy Lu <lulu@redhat.com>, kvm list <kvm@vger.kernel.org>,
 Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, eli@mellanox.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>, lingshan.zhu@intel.com,
 Rob Miller <rob.miller@broadcom.com>
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

Ck9uIDIwMjAvOS8yOCDkuIvljYgxMTo0NCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0IGlvdmEsIHU2NCBzaXplKQo+PiArc3Rh
dGljIGludCB2aG9zdF92ZHBhX3VubWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSkKPj4gICB7Cj4+ICAgICAg
ICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+ICAgICAgICAgIGNvbnN0
IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPj4gKyAgICAgICB1
MzIgYXNpZCA9IChpb3RsYik7Cj4+ICsKPj4gKyAgICAgICBpZiAoIWlvdGxiKQo+PiArICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gVGhpcyBzaG91bGQgYmUgcmVvcmRlciB0byBjaGVj
ayBmb3IgKCFpb3RsYikgYmVmb3JlIHVzZSBhdCBgYXNpZCA9Cj4gaW90bGJfdG9fYXNpZCgpYCwg
aXNuJ3QgaXQ/Cj4KPiBUaGFua3MhCj4KClllcywgd2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lv
bi4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
