Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DDFC6FD1D
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 03:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84EA082115;
	Fri, 17 Mar 2023 03:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84EA082115
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WCN+6xau
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBTx7wBZJZVq; Fri, 17 Mar 2023 03:23:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12A9082106;
	Fri, 17 Mar 2023 03:23:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12A9082106
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFD48C0035;
	Fri, 17 Mar 2023 03:23:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FEDDC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E6004046A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:23:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E6004046A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WCN+6xau
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FwM7XrDh36lS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:23:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3949C40168
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3949C40168
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679023381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z70p775aYB2SeXmWs/Qd3l/VYzN8+Y+gqhrGAr5rW/o=;
 b=WCN+6xau7Zh7q+4N3tHMig+gQn0v+dVQm85z0HHrTIGMXBYWTiz1Y97FBgsEo/WwJMVjUP
 UpGJKsyVZBFioZtXX9PvOGPkJwsfaK3aGMEuFZ5zntTy8zsAI9FPDvwi0L9/mHmKIej9qw
 1QMn4vKKNKgD/t3t8BepfIOeYtt18oE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-_uJAnt9xPEeMB6XRDMMWBQ-1; Thu, 16 Mar 2023 23:22:59 -0400
X-MC-Unique: _uJAnt9xPEeMB6XRDMMWBQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 n10-20020a4abd0a000000b005253ac653a0so1096071oop.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679023379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z70p775aYB2SeXmWs/Qd3l/VYzN8+Y+gqhrGAr5rW/o=;
 b=xVD9M21FQpl/m+0MYasNnZRg+WTY6CzUg//DJ6fF4JvDXMcLHBdJGrKDqA/YuKN0kN
 aKQj65hX/jJ8eJW9IrZEz8d0Ywc/L39AeTKPMYfEif0jmP/gN8ItRJVAeMhgte5pI/ws
 skdn65O4UFqKxjJ+UuWmdz9WovhwBJXoALb/bUWTx+rYT/TV0fEqEaJAznmAn17722ja
 vKhnpm0vSh9T2FAhYVksUKmt/kWkQq2XmMLvXz81/8ZgghDfnxe8xMQhGA8rBcskPCAL
 PQJfErImZHWA01yd18/fLqS1mTyjXXUhvBCM6zZkiJezWCyGDisfh9PsQ6GYdZTKEyTX
 iiXw==
X-Gm-Message-State: AO0yUKUK4u6AKWKxEdD+e7B3YnsQrn1JGZ9T0AHM85AJf6YzKD8y5CjQ
 W9IohokxBU1kOXhutE/jILhaYQiPDn+vcudcO5nF6bdReE5MSm/6UiTSTAfUX7gid3po+t1B2H+
 a14HKczXe6L7v9teH2Nyek5X0aY7VTF9QNaTAGqL9em5OIYNInSxxXwt6og==
X-Received: by 2002:a05:6830:1f51:b0:69b:1bd:7f9e with SMTP id
 u17-20020a0568301f5100b0069b01bd7f9emr2404146oth.2.1679023379182; 
 Thu, 16 Mar 2023 20:22:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set9DqL9cseNTB3oGIZHf/qdOTQ4uiwYvk0nbzuHhXv7ny9cTisYzWWLxG+Qsx+SAFnhwyzPsmFWz2VJKKcUs944=
X-Received: by 2002:a05:6830:1f51:b0:69b:1bd:7f9e with SMTP id
 u17-20020a0568301f5100b0069b01bd7f9emr2404142oth.2.1679023378940; Thu, 16 Mar
 2023 20:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230315072802.2400337-1-elic@nvidia.com>
 <20230315072802.2400337-3-elic@nvidia.com>
In-Reply-To: <20230315072802.2400337-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Mar 2023 11:22:47 +0800
Message-ID: <CACGkMEusDS0HvNztBinu_YPiKH0tRR1MM6XTHUggs+2yQuOrOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by
 default
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 parav@mellanox.com, mst@redhat.com
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

T24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgMzoyOOKAr1BNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPiB3cm90ZToKPgo+IE9uZSBjYW4gc3RpbGwgZW5hYmxlIGl0IHdoZW4gY3JlYXRpbmcgdGhl
IHZkcGEgZGV2aWNlIHVzaW5nIHZkcGEgdG9vbCBieQo+IHByb3ZpZGluZyBmZWF0dXJlcyB0aGF0
IGluY2x1ZGUgaXQuCj4KPiBGb3IgZXhhbXBsZToKPiAkIHZkcGEgZGV2IGFkZCBuYW1lIHZkcGEw
IG1nbXRkZXYgcGNpLzAwMDA6ODY6MDAuMiBkZXZpY2VfZmVhdHVyZXMgMHgzMDBjYjk4MmIKPgo+
IFBsZWFzZSBiZSBhd2FyZSB0aGF0IHRoaXMgZmVhdHVyZSB3YXMgbm90IHN1cHBvcnRlZCBiZWZv
cmUgdGhlIHByZXZpb3VzCj4gcGF0Y2ggaW4gdGhpcyBsaXN0IHdhcyBpbnRyb2R1Y2VkIHNvIHdl
IGRvbid0IGNoYW5nZSB1c2VyIGV4cGVyaWVuY2UuCgpQYXRjaCBsb29rcyBnb29kIGJ1dCB3ZSBu
ZWVkIHRvIGRvY3VtZW50IHdoeSB3ZSBkaXNhYmxlIG1yZyByeGJ1ZiBieQpkZWZhdWx0IGluIHRo
ZSBjaGFuZ2xvZy4KCldpdGggdGhhdCwKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPgoKVGhhbmtzCgo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDIg
KysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+IGluZGV4IDRhYmMzYTRlZTUxNS4uMzg1OGJhMWU4OTc1IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0zMTU0LDYgKzMxNTQsOCBAQCBzdGF0aWMgaW50
IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNo
YXIgKm5hbWUsCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gICAg
ICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgZGV2aWNlX2ZlYXR1cmVzICY9IGFkZF9j
b25maWctPmRldmljZV9mZWF0dXJlczsKPiArICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAg
ICAgIGRldmljZV9mZWF0dXJlcyAmPSB+QklUX1VMTChWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKTsK
PiAgICAgICAgIH0KPiAgICAgICAgIGlmICghKGRldmljZV9mZWF0dXJlcyAmIEJJVF9VTEwoVklS
VElPX0ZfVkVSU0lPTl8xKSAmJgo+ICAgICAgICAgICAgICAgZGV2aWNlX2ZlYXR1cmVzICYgQklU
X1VMTChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkgewo+IC0tCj4gMi4zOC4xCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
