Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BF1C433EF
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 09:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E276C419CC;
	Thu, 12 May 2022 09:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncQ7MkLpB0t1; Thu, 12 May 2022 09:55:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 413B8419A9;
	Thu, 12 May 2022 09:55:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02B22C0039;
	Thu, 12 May 2022 09:55:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46BBDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3550260A90
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Mo4ElX8xE2v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:55:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B4CD60768
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652349334;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Suly+AhOLSwL62JZZv4D1I4Li10rb2Uta4ldrrSF51M=;
 b=jHL8z6CAp3VeoxS0em23J/sA9gpPnlHT77sKGUytHhGIL6Tjh/B2ZyOpaYqiLzANGL5KWZ
 hCU2MFwhij1nkU/1n4jqeNYTxt4uKZXx01lh0s3TeOpO0cTbO4RMSWlWveiXbuSiGlkO/N
 enjKMKvWzSbtMAVgsR1f/iMXE/SGI5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-GK2AF1lRPLa7_7y1_15qng-1; Thu, 12 May 2022 05:55:33 -0400
X-MC-Unique: GK2AF1lRPLa7_7y1_15qng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2475710726B5;
 Thu, 12 May 2022 09:55:24 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A694E1542A82;
 Thu, 12 May 2022 09:55:21 +0000 (UTC)
Date: Thu, 12 May 2022 10:55:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v5 1/9] virtio-crypto: header update
Message-ID: <YnzZhjwbD6PaKx+2@redhat.com>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
 <20220428135943.178254-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428135943.178254-2-pizhenwei@bytedance.com>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: helei.sig11@bytedance.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMDk6NTk6MzVQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToKPiBVcGRhdGUgaGVhZGVyIGZyb20gbGludXgsIHN1cHBvcnQgYWtjaXBoZXIgc2VydmljZS4K
PiAKPiBSZXZpZXdlZC1ieTogR29uZ2xlaSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogbGVpIGhlIDxoZWxlaS5zaWcxMUBieXRlZGFuY2UuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAuLi4v
c3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fY3J5cHRvLmggICAgfCA4MiArKysrKysrKysr
KysrKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpJIHNlZSB0aGVzZSBjaGFuZ2VzIHdlcmUgbm93IG1lcmdlZCBpbiBsaW51eC5naXQgd2l0
aAoKICBjb21taXQgMjRlMTk1OTA2MjhiNTg1Nzg3NDhlZWFlYzgxNDBiZjljOWRjMDBkOQogIEF1
dGhvcjogICAgIHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPgogIEF1dGhvckRh
dGU6IFdlZCBNYXIgMiAxMTozOToxNSAyMDIyICswODAwCiAgQ29tbWl0OiAgICAgTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KICBDb21taXREYXRlOiBNb24gTWFyIDI4IDE2OjUy
OjU4IDIwMjIgLTA0MDAKCiAgICB2aXJ0aW8tY3J5cHRvOiBpbnRyb2R1Y2UgYWtjaXBoZXIgc2Vy
dmljZQogICAgCiAgICBJbnRyb2R1Y2UgYXN5bW1ldHJpYyBzZXJ2aWNlIGRlZmluaXRpb24sIGFz
eW1tZXRyaWMgb3BlcmF0aW9ucyBhbmQKICAgIHNldmVyYWwgd2VsbCBrbm93biBhbGdvcml0aG1z
LgogICAgCiAgICBDby1kZXZlbG9wZWQtYnk6IGxlaSBoZSA8aGVsZWkuc2lnMTFAYnl0ZWRhbmNl
LmNvbT4KICAgIFNpZ25lZC1vZmYtYnk6IGxlaSBoZSA8aGVsZWkuc2lnMTFAYnl0ZWRhbmNlLmNv
bT4KICAgIFNpZ25lZC1vZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29t
PgogICAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMDMwMjAzMzkxNy4xMjk1
MzM0LTMtcGl6aGVud2VpQGJ5dGVkYW5jZS5jb20KICAgIFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CiAgICBSZXZpZXdlZC1ieTogR29uZ2xlaSA8YXJl
aS5nb25nbGVpQGh1YXdlaS5jb20+CgoKQW5kIHRoZSBjaGFuZ2VzIHByb3Bvc2VkIGhlcmUgbWF0
Y2ggdGhhdCwgc28KCiAgUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdl
QHJlZGhhdC5jb20+CgoKV2l0aCByZWdhcmRzLApEYW5pZWwKLS0gCnw6IGh0dHBzOi8vYmVycmFu
Z2UuY29tICAgICAgLW8tICAgIGh0dHBzOi8vd3d3LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5n
ZSA6fAp8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAgICAgLW8tICAgICAgICAgICAgaHR0cHM6
Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwKfDogaHR0cHM6Ly9lbnRhbmdsZS1waG90by5vcmcg
ICAgLW8tICAgIGh0dHBzOi8vd3d3Lmluc3RhZ3JhbS5jb20vZGJlcnJhbmdlIDp8CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
