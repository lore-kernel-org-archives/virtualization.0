Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445ABC433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD00D60F02
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD00D60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A39D540205;
	Tue,  2 Nov 2021 07:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGaHHdA9cbEf; Tue,  2 Nov 2021 07:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C656400C7;
	Tue,  2 Nov 2021 07:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFD24C0012;
	Tue,  2 Nov 2021 07:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB0D2C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDD8C402B5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2oaTvkLC-XSa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:36:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30ED9402AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635838565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQzo864IFt7dEBP6wGwA3RJDk6TUSht/jAIHHjiI+Ec=;
 b=Y3lG8vEMtuQ4b7Hp/oguoB5vs8lVu8aQRWlJ8c1d5iERgwpnKkdmdVnsWKa2vlrEHbJ7K+
 8tt/BCAxWS7yO5jwaFsKESwyWvyB9yb4mau4AWgtOyQ1F6K1RT/Z/tJoxxvHSAXWmlqh02
 qS7y8Pw7wsa8tS9WHNdtY+y5eoo1dC4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-_um4TQxOPNu1Dhy90LQVyA-1; Tue, 02 Nov 2021 03:36:04 -0400
X-MC-Unique: _um4TQxOPNu1Dhy90LQVyA-1
Received: by mail-wr1-f69.google.com with SMTP id
 z5-20020a5d6405000000b00182083d7d2aso2765708wru.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 00:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IQzo864IFt7dEBP6wGwA3RJDk6TUSht/jAIHHjiI+Ec=;
 b=KXjLqMUrDRQ7jx8QGreo0cNs9NJWJhhtmc9no64MSTI9PUo4pKSGBLW4vu6oz5e2tv
 1iSqI3syrLQ4AE9URAqmp7EYDL8Pb/fXvWrtO/+NvkgH812kDlkwopbeK5xDjjNcxLQX
 b1VzYZVn4QEwam7gFAYCQcGJLh95O6uA/OY/GzUXKhq+/uj8RG+gdei63FLQq1HrzfuL
 1iH8rl6bUx6adRvtZ7kKjR0jw3tHXsupnZtkjy/N5/jsJvZzOjhvpJ8gFd+Y7G4FreeT
 PwtTlcoX0vE5kfRqBP7RcqqJpEjsmXa37/7IzfjFyeoQS0MzuCMiZmpQrcaI0jIU+1O4
 Nbnw==
X-Gm-Message-State: AOAM531d3FwsFgAXhs7VYjgNXa5bYCelWLAgTv4EwKrqoFZrj99Jh+pY
 oKEZ0B99UnFOXWT5UTJ6iza1nyV2mHhtq9oymGgn8q9LIOxvilP0fUDQGZLvW3gYyX+7VJGWCOM
 AMzGo+t7+GPmqbnfBw6I8aCZkDxoSX2dbLPW3U46jgg==
X-Received: by 2002:a05:600c:3b82:: with SMTP id
 n2mr4995525wms.50.1635838563751; 
 Tue, 02 Nov 2021 00:36:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlC5PEpMXZBCOB3RsoO+aySl0IYlS7ZRwG0VEohOsNKNAVbr4GiARf3aVMBI7AHgzYCtROMg==
X-Received: by 2002:a05:600c:3b82:: with SMTP id
 n2mr4995487wms.50.1635838563555; 
 Tue, 02 Nov 2021 00:36:03 -0700 (PDT)
Received: from localhost ([188.26.219.88])
 by smtp.gmail.com with ESMTPSA id o40sm1570108wms.10.2021.11.02.00.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 00:36:03 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH v5 05/26] vhost: Add x-vhost-set-shadow-vq qmp
In-Reply-To: <20211029183525.1776416-6-eperezma@redhat.com> ("Eugenio
 =?utf-8?Q?P=C3=A9rez=22's?=
 message of "Fri, 29 Oct 2021 20:35:04 +0200")
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-6-eperezma@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date: Tue, 02 Nov 2021 08:36:02 +0100
Message-ID: <87zgqnnh5p.fsf@secure.mitica>
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

RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+IENvbW1hbmQgdG8g
c2V0IHNoYWRvdyB2aXJ0cXVldWUgbW9kZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOp
cmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6IEp1YW4gUXVpbnRlbGEgPHF1
aW50ZWxhQHJlZGhhdC5jb20+CgpZb3UgbmVlZCB0byBrZWVwIGNhcmUgb2Y6CgogTWFya3VzIEFy
bWJydXN0ZXIgICAgICBdIFtQQVRDSCB2MiAwLzldIENvbmZpZ3VyYWJsZSBwb2xpY3kgZm9yIGhh
bmRsaW5nIHVuc3RhYmxlIGludGVyZmFjZXMKCldoZW4gdGhpcyBoaXQgdGhlIHRyZWUsIHlvdSBu
ZWVkIHRvIGRyb3AgdGhlIHgtIGFuZCBtYXJrIGl0IGFzIHVuc3RhYmxlLgoKTGF0ZXIsIEp1YW4u
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
