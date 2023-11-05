Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C6BC4332F
	for <virtualization@archiver.kernel.org>; Sun,  5 Nov 2023 15:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E258682179;
	Sun,  5 Nov 2023 15:58:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E258682179
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iRoVaLL4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DM2HOGkAQ3KZ; Sun,  5 Nov 2023 15:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A68682173;
	Sun,  5 Nov 2023 15:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A68682173
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C960C0039;
	Sun,  5 Nov 2023 15:58:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A11AC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 15:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12E5A82175
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 15:58:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12E5A82175
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BfOLUqansakl
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 15:58:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE4D382173
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Nov 2023 15:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE4D382173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699199900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gm8P+4qqkq3fie/1BXBTuSMj+CMA8LATFFDY5rV8ORw=;
 b=iRoVaLL4ZpxQqZpqg35eHA56K0DlXNQ1WcOq5EiX38bxtfsd18tT7muxeKrxHKoEBj/9bs
 37bjm4CbvzFaDpbD8pelcb81k3dMts7Lqmi6Kk421QYSRnp6a63fx+SPVaEqrr5D00FtwG
 8t6GH8aAPmAWv+OeYOZkvaRDglovqw8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ol65Xah4MdW2f7aTxb8LrQ-1; Sun, 05 Nov 2023 10:58:18 -0500
X-MC-Unique: ol65Xah4MdW2f7aTxb8LrQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-54061ad6600so3034993a12.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Nov 2023 07:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699199897; x=1699804697;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gm8P+4qqkq3fie/1BXBTuSMj+CMA8LATFFDY5rV8ORw=;
 b=aXcuAyjSHjaniiUWfn/Ba4hBBxO0QeHakKZblnCkqLBfy7zaKYPwXvwpmqGj6u3quL
 CISLhwYWyATa4axQj7aKsM2A+K8f1dH4M5whP7jL6doMO60SXPMDVW+tK7p96WKEAkos
 OqQMfJyd3efJnxNz0uj43b7LUFR8UmM3xjwVxAlL0H/JWlRDnZNW+JxeJxJhhzayPR68
 RuB+WYHoVqk/cOGX1zQwcgwL36S8hUMwIIi/4ekUjbgTvotbl4sNlgfQILT3ow03zola
 tiWqp2Yf8NRawp2g/vLgtktJrYqJRkHTozLe97MVrl7lCI7Qj/bQFfD/hdO0q4EeLPNo
 irNg==
X-Gm-Message-State: AOJu0YxulBuZNgZV/xN80KHKQOWx87V2ivnT42Tzc/sIeFtQ/4/eOLmv
 UOsxo+csfYOrEtDt/eU6HmUbzQ4VGRWWnMyft/lEcY4UNtk4HRIEg3O+QUXeVCG9Fvr/OHxdfah
 xWG0JujXHqqEpFW7JJL4A43OfN4VALXlhl0zFGvoh3g==
X-Received: by 2002:a17:906:db08:b0:9dd:f5ba:856d with SMTP id
 xj8-20020a170906db0800b009ddf5ba856dmr3819999ejb.62.1699199897434; 
 Sun, 05 Nov 2023 07:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEybgJfekAZesQ+akyhDcdHp9NNqn1nBxIeCP8wqicCb5vXKmYeJbRaNub+H3s331kYxYmE9A==
X-Received: by 2002:a17:906:db08:b0:9dd:f5ba:856d with SMTP id
 xj8-20020a170906db0800b009ddf5ba856dmr3819966ejb.62.1699199896993; 
 Sun, 05 Nov 2023 07:58:16 -0800 (PST)
Received: from redhat.com ([2.55.35.234]) by smtp.gmail.com with ESMTPSA id
 qw23-20020a1709066a1700b009dd949b75c7sm2460591ejc.151.2023.11.05.07.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 07:58:16 -0800 (PST)
Date: Sun, 5 Nov 2023 10:58:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost,virtio,vdpa: features, fixes, cleanups
Message-ID: <20231105105806-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, geert+renesas@glider.be, kvm@vger.kernel.org,
 mst@redhat.com, simon.horman@corigine.com, netdev@vger.kernel.org,
 xieyongji@bytedance.com, xueshi.hu@smartx.com, pizhenwei@bytedance.com,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, leiyang@redhat.com,
 gregkh@linuxfoundation.org, shawn.shao@jaguarmicro.com,
 virtualization@lists.linux-foundation.org, leon@kernel.org
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBmZmMyNTMyNjNhMTM3NWE2NWZhNmM5
ZjYyYTg5M2U5NzY3ZmJlYmZhOgoKICBMaW51eCA2LjYgKDIwMjMtMTAtMjkgMTY6MzE6MDggLTEw
MDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAgaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbXN0L3Zob3N0LmdpdCB0YWdz
L2Zvcl9saW51cwoKZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDg2ZjZjMjI0Yzk3OTEx
YjQzOTJjYjdiNDAyZTZhNGVkMzIzYTQ0OWU6CgogIHZkcGFfc2ltOiBpbXBsZW1lbnQgLnJlc2V0
X21hcCBzdXBwb3J0ICgyMDIzLTExLTAxIDA5OjIwOjAwIC0wNDAwKQoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQp2aG9zdCx2
aXJ0aW8sdmRwYTogZmVhdHVyZXMsIGZpeGVzLCBjbGVhbnVwcwoKdmRwYS9tbHg1OgoJVkhPU1Rf
QkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0sKCW5ldyBtYWludGFpbmVyCnZkcGE6Cglz
dXBwb3J0IGZvciB2cSBkZXNjcmlwdG9yIG1hcHBpbmdzCglkZWNvdXBsZSByZXNldCBvZiBpb3Rs
YiBtYXBwaW5nIGZyb20gZGV2aWNlIHJlc2V0CgpmaXhlcywgY2xlYW51cHMgYWxsIG92ZXIgdGhl
IHBsYWNlCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
PgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpEcmFnb3MgVGF0dWxlYSAoMTQpOgogICAgICB2ZHBhL21seDU6IEV4cG9zZSBk
ZXNjcmlwdG9yIGdyb3VwIG1rZXkgaHcgY2FwYWJpbGl0eQogICAgICB2ZHBhL21seDU6IENyZWF0
ZSBoZWxwZXIgZnVuY3Rpb24gZm9yIGRtYSBtYXBwaW5ncwogICAgICB2ZHBhL21seDU6IERlY291
cGxlIGN2cSBpb3RsYiBoYW5kbGluZyBmcm9tIGh3IG1hcHBpbmcgY29kZQogICAgICB2ZHBhL21s
eDU6IFRha2UgY3ZxIGlvdGxiIGxvY2sgZHVyaW5nIHJlZnJlc2gKICAgICAgdmRwYS9tbHg1OiBD
b2xsYXBzZSAiZHZxIiBtciBhZGQvZGVsZXRlIGZ1bmN0aW9ucwogICAgICB2ZHBhL21seDU6IFJl
bmFtZSBtciBkZXN0cm95IGZ1bmN0aW9ucwogICAgICB2ZHBhL21seDU6IEFsbG93IGNyZWF0aW9u
L2RlbGV0aW9uIG9mIGFueSBnaXZlbiBtciBzdHJ1Y3QKICAgICAgdmRwYS9tbHg1OiBNb3ZlIG1y
IG11dGV4IG91dCBvZiBtciBzdHJ1Y3QKICAgICAgdmRwYS9tbHg1OiBJbXByb3ZlIG1yIHVwZGF0
ZSBmbG93CiAgICAgIHZkcGEvbWx4NTogSW50cm9kdWNlIG1yIGZvciB2cSBkZXNjcmlwdG9yCiAg
ICAgIHZkcGEvbWx4NTogRW5hYmxlIGh3IHN1cHBvcnQgZm9yIHZxIGRlc2NyaXB0b3IgbWFwcGlu
ZwogICAgICB2ZHBhL21seDU6IE1ha2UgaW90bGIgaGVscGVyIGZ1bmN0aW9ucyBtb3JlIGdlbmVy
aWMKICAgICAgdmRwYS9tbHg1OiBVcGRhdGUgY3ZxIGlvdGxiIG1hcHBpbmcgb24gQVNJRCBjaGFu
Z2UKICAgICAgTUFJTlRBSU5FUlM6IEFkZCBteXNlbGYgYXMgbWx4NV92ZHBhIGRyaXZlcgoKRXVn
ZW5pbyBQw6lyZXogKDEpOgogICAgICBtbHg1X3ZkcGE6IG9mZmVyIFZIT1NUX0JBQ0tFTkRfRl9F
TkFCTEVfQUZURVJfRFJJVkVSX09LCgpHZWVydCBVeXR0ZXJob2V2ZW4gKDEpOgogICAgICB2aG9z
dC1zY3NpOiBTcGVsbGluZyBzL3ByZWNlZWRpbmcvcHJlY2VkaW5nL2cKCkdyZWcgS3JvYWgtSGFy
dG1hbiAoMSk6CiAgICAgIHZkdXNlOiBtYWtlIHZkdXNlX2NsYXNzIGNvbnN0YW50CgpNaWNoYWVs
IFMuIFRzaXJraW4gKDEpOgogICAgICBNZXJnZSBicmFuY2ggJ21seDUtdmhvc3QnIG9mIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21lbGxhbm94L2xpbnV4
LmdpdAoKU2hhbm5vbiBOZWxzb24gKDEpOgogICAgICB2aXJ0aW86IGtkb2MgZm9yIHN0cnVjdCB2
aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UKClNoYXduLlNoYW8gKDEpOgogICAgICB2ZHBhOiBVcGRh
dGUgc3lzZnMgQUJJIGRvY3VtZW50YXRpb24KClNpLVdlaSBMaXUgKDEwKToKICAgICAgdmRwYTog
aW50cm9kdWNlIGRlZGljYXRlZCBkZXNjcmlwdG9yIGdyb3VwIGZvciB2aXJ0cXVldWUKICAgICAg
dmhvc3QtdmRwYTogaW50cm9kdWNlIGRlc2NyaXB0b3IgZ3JvdXAgYmFja2VuZCBmZWF0dXJlCiAg
ICAgIHZob3N0LXZkcGE6IHVBUEkgdG8gZ2V0IGRlZGljYXRlZCBkZXNjcmlwdG9yIGdyb3VwIGlk
CiAgICAgIHZkcGE6IGludHJvZHVjZSAucmVzZXRfbWFwIG9wZXJhdGlvbiBjYWxsYmFjawogICAg
ICB2aG9zdC12ZHBhOiByZXNldCB2ZW5kb3Igc3BlY2lmaWMgbWFwcGluZyB0byBpbml0aWFsIHN0
YXRlIGluIC5yZWxlYXNlCiAgICAgIHZob3N0LXZkcGE6IGludHJvZHVjZSBJT1RMQl9QRVJTSVNU
IGJhY2tlbmQgZmVhdHVyZSBiaXQKICAgICAgdmRwYTogaW50cm9kdWNlIC5jb21wYXRfcmVzZXQg
b3BlcmF0aW9uIGNhbGxiYWNrCiAgICAgIHZob3N0LXZkcGE6IGNsZWFuIGlvdGxiIG1hcCBkdXJp
bmcgcmVzZXQgZm9yIG9sZGVyIHVzZXJzcGFjZQogICAgICB2ZHBhL21seDU6IGltcGxlbWVudCAu
cmVzZXRfbWFwIGRyaXZlciBvcAogICAgICB2ZHBhX3NpbTogaW1wbGVtZW50IC5yZXNldF9tYXAg
c3VwcG9ydAoKWHVhbiBaaHVvICgzKToKICAgICAgdmlydGlvOiBhZGQgZGVmaW5pdGlvbiBvZiBW
SVJUSU9fRl9OT1RJRl9DT05GSUdfREFUQSBmZWF0dXJlIGJpdAogICAgICB2aXJ0aW9fcGNpOiBh
ZGQgYnVpbGQgb2Zmc2V0IGNoZWNrIGZvciB0aGUgbmV3IGNvbW1vbiBjZmcgaXRlbXMKICAgICAg
dmlydGlvX3BjaTogYWRkIGNoZWNrIGZvciBjb21tb24gY2ZnIHNpemUKClh1ZXNoaSBIdSAoMSk6
CiAgICAgIHZpcnRpby1iYWxsb29uOiBjb3JyZWN0IHRoZSBjb21tZW50IG9mIHZpcnRiYWxsb29u
X21pZ3JhdGVwYWdlKCkKCnpoZW53ZWkgcGkgKDEpOgogICAgICB2aXJ0aW8tYmxrOiBmaXggaW1w
bGljaXQgb3ZlcmZsb3cgb24gdmlydGlvX21heF9kbWFfc2l6ZQoKIERvY3VtZW50YXRpb24vQUJJ
L3Rlc3Rpbmcvc3lzZnMtYnVzLXZkcGEgfCAgIDQgKy0KIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDYgKwogZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgICAg
ICAgICAgICAgICB8ICAgNCArLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCAg
ICAgICB8ICAzMiArKystLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICAgICAg
ICB8IDIxMyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiBkcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL3Jlc291cmNlcy5jICAgICAgIHwgICA2ICstCiBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgICAgICAgIHwgMTM3ICsrKysrKysrKysrKysrKy0tLS0tCiBkcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgICAgIHwgIDUyICsrKysrKy0tCiBkcml2ZXJzL3Zk
cGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jICAgICAgIHwgIDQwICsrKy0tLQogZHJpdmVycy92aG9z
dC9zY3NpLmMgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQogZHJpdmVycy92aG9zdC92ZHBh
LmMgICAgICAgICAgICAgICAgICAgICB8ICA3OSArKysrKysrKysrKy0KIGRyaXZlcnMvdmlydGlv
L3ZpcnRpb19iYWxsb29uLmMgICAgICAgICAgfCAgIDIgKy0KIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbW9kZXJuLmMgICAgICAgfCAgMzYgKysrKysrCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX21vZGVybl9kZXYuYyAgIHwgICA2ICstCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5j
ICAgICAgICAgICAgIHwgICAyICstCiBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmMuaCAgICAg
ICAgICAgIHwgICA4ICstCiBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmNfdmRwYS5oICAgICAg
IHwgICA3ICstCiBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgICAgICAgICAgICAgIHwgIDQx
ICsrKysrLQogaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oICAgICAgICB8ICAzNSAr
KystLQogaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggICAgICAgICAgICAgICB8ICAgOCArKwog
aW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggICAgICAgICB8ICAgNyArCiBpbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oICAgICAgIHwgICA1ICsKIDIyIGZpbGVzIGNoYW5n
ZWQsIDU0NiBpbnNlcnRpb25zKCspLCAxODYgZGVsZXRpb25zKC0pCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
