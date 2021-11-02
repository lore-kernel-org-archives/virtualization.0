Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E164C433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:25:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28EC60724
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E28EC60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8726140205;
	Tue,  2 Nov 2021 07:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NEjf-v-e4YxI; Tue,  2 Nov 2021 07:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F41CB400C7;
	Tue,  2 Nov 2021 07:25:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1327C0012;
	Tue,  2 Nov 2021 07:25:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 865E0C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60521402B5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q61VfNuHu1x7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:25:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BB55402AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635837933;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7yffhPX+vho+28Gpi8r3quLL7PgmQ1wTBBSs+ie47U=;
 b=JWI4AmGLOdtj/4hfrB20eu8PJTeEPh/XdB6wzrVVKhr3mYDDpd9VPuYLcR3NbLLSGX7rQu
 Yr13mQuFrToNiX3UGBFaxtFoIkkDONZGDwOvu/865+3+F9O/oGPxMdtkIvfnMp0DjiPAAN
 P5I0t8+CfZXUXWpYxMI7gXlBjnDOhcc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-RqMworSKMJSQ-vJbI5uQog-1; Tue, 02 Nov 2021 03:25:30 -0400
X-MC-Unique: RqMworSKMJSQ-vJbI5uQog-1
Received: by mail-wm1-f72.google.com with SMTP id
 z138-20020a1c7e90000000b003319c5f9164so688727wmc.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 00:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oAW8XtcxK2uizmVJvFb6uSAJqsymalNgSqRqG6DzS6Q=;
 b=Oou5HzMzUU//HypusSJB8vjq3IFR9kcCGa83I8sSCL8RnqE+vj7hUBmSwIItc2tq4Q
 8zT60vd1NW9q0yn/tIYIOYsZWI1WdxUuCmWgQHlkwEfUsEIJ2/cCtmyeKW1gjNi+TwS2
 3xx1Z0Rx8Lh9uzEhGPEhb3DO1VSfeZtKoDWtHht8FCTYG0c43m2rujEJrFdMkkiHxdhJ
 RRWHE0Tp8ES3ceiQInjaj7PRTJKfNLaLrbPMWfAGQaRvfKyu7QpwoSTX2sJXKmvrz9VG
 hvKboGhZWKOpZhquJVcFVvG4efj8GjV7FJL1Xkbp3S9VMBl/if4NEWxrGg9FELdqxwWg
 5BDw==
X-Gm-Message-State: AOAM533LklruKKaj0VNn9mOJGac/1HjVlug34pZwbbvZjLRBCmat47k6
 Me4BV3/Zg1pXYXyvP32V3KSWxnzhFRtpb7MZKGUjzC58U0EQQJdfqq3eVcSw3qzK5WoEAtejdD5
 DJiOSBpNbB8Geqb9j68IecPjRgKJqLYcPR88QFpy9Cw==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr5007681wmk.78.1635837929451;
 Tue, 02 Nov 2021 00:25:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY7mrnU1rMP3eWf4zK4fN2TqPgfcUIFlGftElm82BaXeWxJuZBQdoWj7ESLQ+ehdznORIIUg==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr5007664wmk.78.1635837929279;
 Tue, 02 Nov 2021 00:25:29 -0700 (PDT)
Received: from localhost ([188.26.219.88])
 by smtp.gmail.com with ESMTPSA id r15sm18248041wru.9.2021.11.02.00.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 00:25:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH v5 02/26] vhost: Fix last queue index of devices
 with no cvq
In-Reply-To: <20211029183525.1776416-3-eperezma@redhat.com> ("Eugenio
 =?utf-8?Q?P=C3=A9rez=22's?=
 message of "Fri, 29 Oct 2021 20:35:01 +0200")
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-3-eperezma@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date: Tue, 02 Nov 2021 08:25:27 +0100
Message-ID: <87a6inow7s.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Eli Cohen <eli@mellanox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, virtualization@lists.linux-foundation.org,
 Parav Pandit <parav@mellanox.com>
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
Reply-To: quintela@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+IFRoZSAtMSBhc3N1
bWVzIHRoYXQgYWxsIGRldmljZXMgd2l0aCBubyBjdnEgaGF2ZSBhbiBzcGFyZSB2cSBhbGxvY2F0
ZWQKPiBmb3IgdGhlbSwgYnV0IHdpdGggbm8gb2ZmZXIgb2YgVklSVElPX05FVF9GX0NUUkxfVlEu
IFRoaXMgbWF5IG5vdCBiZSB0aGUKPiBjYXNlLCBhbmQgdGhlIGRldmljZSBtYXkgaGF2ZSBhIHBh
aXIgbnVtYmVyIG9mIHF1ZXVlcy4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5e
Xl4KZXZlbgoKSSBrbm93LCBJIGtub3csIEkgYW0gU3BhbmlzaCBteXNlbGYgTzotKQoKPiBUbyBm
aXggdGhpcywganVzdCByZXNvcnQgdG8gdGhlIGxvd2VyIGV2ZW4gbnVtYmVyIG9mIHF1ZXVlcy4K
CkkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSB0cnkgdG8gYWNoaWV2ZSBoZXJlLgoKPiBGaXhl
czogMDQ5ZWIxNWI1ZmM5ICgidmhvc3Q6IHJlY29yZCB0aGUgbGFzdCB2aXJ0cXVldWUgaW5kZXgg
Zm9yIHRoZQo+IHZpcnRpbyBkZXZpY2UiKQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6
IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICBody9uZXQvdmhvc3RfbmV0LmMgfCAyICst
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2h3L25ldC92aG9zdF9uZXQuYyBiL2h3L25ldC92aG9zdF9uZXQuYwo+IGluZGV4
IDBkODg4ZjI5YTYuLmVkZjU2YTU5N2YgMTAwNjQ0Cj4gLS0tIGEvaHcvbmV0L3Zob3N0X25ldC5j
Cj4gKysrIGIvaHcvbmV0L3Zob3N0X25ldC5jCj4gQEAgLTMzMCw3ICszMzAsNyBAQCBpbnQgdmhv
c3RfbmV0X3N0YXJ0KFZpcnRJT0RldmljZSAqZGV2LCBOZXRDbGllbnRTdGF0ZSAqbmNzLAo+ICAg
ICAgTmV0Q2xpZW50U3RhdGUgKnBlZXI7Cj4gIAo+ICAgICAgaWYgKCFjdnEpIHsKPiAtICAgICAg
ICBsYXN0X2luZGV4IC09IDE7Cj4gKyAgICAgICAgbGFzdF9pbmRleCAmPSB+MVVMTDsKPiAgICAg
IH0KCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoYXQgaXMgYSBub3AuIGxhc3RfaW5kZXggaXMgZGVm
aW5lZCBhcyBhbiBpbnQuCgokIGNhdCBray5jCiNpbmNsdWRlIDxzdGRpby5oPgoKaW50IG1haW4o
dm9pZCkKewoJaW50IGkgPSA3OwoJaSAmPSAtMVVMTDsKCXByaW50ZigiJWRcbiIsIGkpOwoJaSA9
IDg7CglpICY9IC0xVUxMOwoJcHJpbnRmKCIlZFxuIiwgaSk7CglpID0gMDsKCWkgJj0gLTFVTEw7
CglwcmludGYoIiVkXG4iLCBpKTsKCWkgPSAtMjsKCWkgJj0gLTFVTEw7CglwcmludGYoIiVkXG4i
LCBpKTsKCXJldHVybiAwOwp9CiQgLi9rawo3CjgKMAotMgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
