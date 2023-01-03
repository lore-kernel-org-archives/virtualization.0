Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE356C3DA7D
	for <virtualization@archiver.kernel.org>; Tue,  3 Jan 2023 15:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BBEB409C1;
	Tue,  3 Jan 2023 15:50:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BBEB409C1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dsw+a1sk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xi2Vq8qGKrGf; Tue,  3 Jan 2023 15:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD76840147;
	Tue,  3 Jan 2023 15:49:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD76840147
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85178C0032;
	Tue,  3 Jan 2023 15:49:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAC0EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 15:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D318415E6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 15:49:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D318415E6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dsw+a1sk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6YNkolO3AIuf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 15:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D6F3408A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D6F3408A1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jan 2023 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672760994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WC94+qRtcsQoAZV6EJBwTDdUsyIqcyvTkPy2eHYVDF8=;
 b=Dsw+a1skJrczJSjugB4GFPkVku1KQU+pKKtHoH8KoPlUobI7sRzGiWLORGW//f1JBwGbGh
 2j0ZsbqAF1iwbQCnVmDi7Z3YdwBIex4InD+PZsovaqcenjusr+JQKmr4rRA8n03XTSEnXO
 D5mJlX7dtfLNXRc7IhLo+gPf1Lib6Jo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-yAGNAnrEONavA71XfcqjBw-1; Tue, 03 Jan 2023 10:49:53 -0500
X-MC-Unique: yAGNAnrEONavA71XfcqjBw-1
Received: by mail-wm1-f70.google.com with SMTP id
 c66-20020a1c3545000000b003d355c13229so20243544wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Jan 2023 07:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WC94+qRtcsQoAZV6EJBwTDdUsyIqcyvTkPy2eHYVDF8=;
 b=froFSs/6o0YIV2ofTS30PUgs98I4rTJAYXMWVAlX8DQzu8abBSf0qnaVUfm+pJ815x
 NhIwFcv0IRve8bZ7hqrmLpPQ9wvCX+ljfPZKvP6IDlARq/8N6GazBLnmwQ8Dp3125efN
 2YMWJTM13oRlOiZUrNY0wQpLLOxp2n1/9eX1i/qfKKAxFIYAcBDJvXEmBFb0BbwdU2EV
 W5zUGCbHm96noe9Oowy4iF7sSeuZsJ+pa3qYno6Jg7NeIr6ChLm1jEe2/1NQed6Xp9yh
 WwKgLuXnaFTnHn26JvwmCb7OcpdfCis451b40EQsWPZg2TikBxFP+gGZD+9/Vp/UadkY
 1ngQ==
X-Gm-Message-State: AFqh2kodse/KmjCS4AxxxfzZmgnyKBJJG2OKYLZf85hEKdpRAZCc/uth
 1jLzrYM8dtsKqh5v2EHd90K/WzCj5lf/utzaKJlqnt2Pf6hdhn5BLxS5o/dtL/zP7HZMXQOgwh9
 mb8Sk87bF6JEErsu3r8hik2c0TsiPsBxmgCu6AW024w==
X-Received: by 2002:a05:600c:4fcf:b0:3d1:d396:1ade with SMTP id
 o15-20020a05600c4fcf00b003d1d3961ademr31416071wmq.9.1672760992129; 
 Tue, 03 Jan 2023 07:49:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvBokw4ntbihohzRlAT/7Kd2Eqgl7eiuIEN+Pul08FB9XjA5yr3GOYK70ZuUvwnVXP0KlLXRw==
X-Received: by 2002:a05:600c:4fcf:b0:3d1:d396:1ade with SMTP id
 o15-20020a05600c4fcf00b003d1d3961ademr31416049wmq.9.1672760991925; 
 Tue, 03 Jan 2023 07:49:51 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c458a00b003d9a86a13bfsm15382532wmo.28.2023.01.03.07.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jan 2023 07:49:51 -0800 (PST)
Date: Tue, 3 Jan 2023 10:49:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL v2] virtio,vhost,vdpa: fixes, cleanups
Message-ID: <20230103104946-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, dmitry.fomichev@wdc.com,
 yuancan@huawei.com, virtualization@lists.linux-foundation.org,
 shaoqin.huang@intel.com, weiyongjun1@huawei.com, set_pte_at@outlook.com,
 elic@nvidia.com, dave@stgolabs.net, lulu@redhat.com, ruanjinjie@huawei.com,
 sunnanyong@huawei.com, rafaelmendsr@gmail.com, pizhenwei@bytedance.com,
 eperezma@redhat.com, angus.chen@jaguarmicro.com, colin.i.king@gmail.com,
 harshit.m.mogalapalli@oracle.com, wangjianli@cdjrlc.com,
 gautam.dawar@xilinx.com, dengshaomin@cdjrlc.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, wangrong68@huawei.com
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

VGhlc2UgZml4ZXMgaGF2ZSBiZWVuIGluIG5leHQsIHRob3VnaCBub3QgYXMgdGhlc2UgY29tbWl0
cy4KCkknZCBsaWtlIHRvIGFwb2xvZ2l6ZSBhZ2FpbiB0byBjb250cmlidXRvcnMgZm9yIG1pc3Np
bmcgdGhlIG1lcmdlCndpbmRvdyB3aXRoIG5ldyBmZWF0dXJlcy4gVGhlc2UgYnkgbmVjZXNzaXR5
IGhhdmUgYmVlbiBwdXNoZWQgb3V0CnRvIHRoZSBuZXh0IG1lcmdlIHdpbmRvdy4gVGhpcyBwdWxs
IG9ubHkgaGFzIGJ1Z2ZpeGVzLgoKSSBwdXQgYXV0b21hdGlvbiBpbiBwbGFjZSB0byBoZWxwIHBy
ZXZlbnQgbWlzc2luZyBtZXJnZSB3aW5kb3cKaW4gdGhlIGZ1dHVyZS4KClRoZSBmb2xsb3dpbmcg
Y2hhbmdlcyBzaW5jZSBjb21taXQgMWI5MjljMDJhZmQzNzg3MWQ1YWZiOWQ0OTg0MjZmODM0MzJl
NzFjMjoKCiAgTGludXggNi4yLXJjMSAoMjAyMi0xMi0yNSAxMzo0MTozOSAtMDgwMCkKCmFyZSBh
dmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3Qvdmhvc3QuZ2l0IHRhZ3MvZm9yX2xpbnVz
Cgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYTI2MTE2YzFlNzQwMjg5MTRmMjgxODUx
NDg4NTQ2YzkxY2JhZTU3ZDoKCiAgdmlydGlvX2JsazogRml4IHNpZ25lZG5lc3MgYnVnIGluIHZp
cnRibGtfcHJlcF9ycSgpICgyMDIyLTEyLTI4IDA1OjI4OjExIC0wNTAwKQoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQp2aXJ0
aW8sdmhvc3QsdmRwYTogZml4ZXMsIGNsZWFudXBzCgptb3N0bHkgZml4ZXMgYWxsIG92ZXIgdGhl
IHBsYWNlLCBhIGNvdXBsZSBvZiBjbGVhbnVwcy4KClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkFuZ3VzIENoZW4gKDIpOgogICAgICB2
aXJ0aW9fcGNpOiBtb2RpZnkgRU5PRU5UIHRvIEVJTlZBTAogICAgICB2aXJ0aW9fYmxrOiB1c2Ug
VUlOVF9NQVggaW5zdGVhZCBvZiAtMVUKCkNpbmR5IEx1ICgyKToKICAgICAgdmhvc3RfdmRwYTog
Zml4IHRoZSBjcmFzaCBpbiB1bm1hcCBhIGxhcmdlIG1lbW9yeQogICAgICB2ZHBhX3NpbV9uZXQ6
IHNob3VsZCBub3QgZHJvcCB0aGUgbXVsdGljYXN0L2Jyb2FkY2FzdCBwYWNrZXQKCkNvbGluIElh
biBLaW5nICgxKToKICAgICAgUkRNQS9tbHg1OiByZW1vdmUgdmFyaWFibGUgaQoKRGF2aWRsb2hy
IEJ1ZXNvICgyKToKICAgICAgdG9vbHMvdmlydGlvOiByZW1vdmUgc3RyYXkgY2hhcmFjdGVycwog
ICAgICB0b29scy92aXJ0aW86IHJlbW92ZSBzbXBfcmVhZF9iYXJyaWVyX2RlcGVuZHMoKQoKRGF3
ZWkgTGkgKDEpOgogICAgICB2aXJ0aW86IEltcGxlbWVudGluZyBhdHRyaWJ1dGUgc2hvdyB3aXRo
IHN5c2ZzX2VtaXQKCkRtaXRyeSBGb21pY2hldiAoMSk6CiAgICAgIHZpcnRpby1ibGs6IHVzZSBh
IGhlbHBlciB0byBoYW5kbGUgcmVxdWVzdCBxdWV1aW5nIGVycm9ycwoKRWxpIENvaGVuICg1KToK
ICAgICAgdmRwYS9tbHg1OiBGaXggcnVsZSBmb3J3YXJkaW5nIFZMQU4gdG8gVElSCiAgICAgIHZk
cGEvbWx4NTogUmV0dXJuIGVycm9yIG9uIHZsYW4gY3RybCBjb21tYW5kcyBpZiBub3Qgc3VwcG9y
dGVkCiAgICAgIHZkcGEvbWx4NTogRml4IHdyb25nIG1hYyBhZGRyZXNzIGRlbGV0aW9uCiAgICAg
IHZkcGEvbWx4NTogQXZvaWQgdXNpbmcgcmVzbG9jayBpbiBldmVudF9oYW5kbGVyCiAgICAgIHZk
cGEvbWx4NTogQXZvaWQgb3ZlcndyaXRpbmcgQ1ZRIGlvdGxiCgpIYXJzaGl0IE1vZ2FsYXBhbGxp
ICgxKToKICAgICAgdmR1c2U6IFZhbGlkYXRlIHZxX251bSBpbiB2ZHVzZV92YWxpZGF0ZV9jb25m
aWcoKQoKSmFzb24gV2FuZyAoMik6CiAgICAgIHZkcGE6IGNvbmRpdGlvbmFsbHkgZmlsbCBtYXgg
bWF4IHF1ZXVlIHBhaXIgZm9yIHN0YXRzCiAgICAgIHZkcGFzaW06IGZpeCBtZW1vcnkgbGVhayB3
aGVuIGZyZWVpbmcgSU9UTEJzCgpSYWZhZWwgTWVuZG9uY2EgKDEpOgogICAgICB2aXJ0aW9fYmxr
OiBGaXggc2lnbmVkbmVzcyBidWcgaW4gdmlydGJsa19wcmVwX3JxKCkKClJpY2FyZG8gQ2HDsXVl
bG8gKDEpOgogICAgICB0b29scy92aXJ0aW86IGluaXRpYWxpemUgc3BpbmxvY2tzIGluIHZyaW5n
X3Rlc3QuYwoKUm9uZyBXYW5nICgxKToKICAgICAgdmRwYS92cF92ZHBhOiBmaXgga2ZyZWUgYSB3
cm9uZyBwb2ludGVyIGluIHZwX3ZkcGFfcmVtb3ZlCgpTaGFvbWluIERlbmcgKDEpOgogICAgICB0
b29sczogRGVsZXRlIHRoZSB1bm5lZWRlZCBzZW1pY29sb24gYWZ0ZXIgY3VybHkgYnJhY2VzCgpT
aGFvcWluIEh1YW5nICgyKToKICAgICAgdmlydGlvX3BjaTogdXNlIGhlbHBlciBmdW5jdGlvbiBp
c19wb3dlcl9vZl8yKCkKICAgICAgdmlydGlvX3Jpbmc6IHVzZSBoZWxwZXIgZnVuY3Rpb24gaXNf
cG93ZXJfb2ZfMigpCgpTaS1XZWkgTGl1ICgxKToKICAgICAgdmRwYTogbWVyZ2UgZnVuY3Rpb25h
bGx5IGR1cGxpY2F0ZWQgZGV2X2ZlYXR1cmVzIGF0dHJpYnV0ZXMKClN0ZWZhbm8gR2FyemFyZWxs
YSAoNCk6CiAgICAgIHZyaW5naDogZml4IHJhbmdlIHVzZWQgaW4gaW90bGJfdHJhbnNsYXRlKCkK
ICAgICAgdmhvc3Q6IGZpeCByYW5nZSB1c2VkIGluIHRyYW5zbGF0ZV9kZXNjKCkKICAgICAgdmhv
c3QtdmRwYTogZml4IGFuIGlvdGxiIG1lbW9yeSBsZWFrCiAgICAgIHZkcGFfc2ltOiBmaXggdnJp
bmdoIGluaXRpYWxpemF0aW9uIGluIHZkcGFzaW1fcXVldWVfcmVhZHkoKQoKV2VpIFlvbmdqdW4g
KDEpOgogICAgICB2aXJ0aW8tY3J5cHRvOiBmaXggbWVtb3J5IGxlYWsgaW4gdmlydGlvX2NyeXB0
b19hbGdfc2tjaXBoZXJfY2xvc2Vfc2Vzc2lvbigpCgpZdWFuIENhbiAoMSk6CiAgICAgIHZob3N0
L3Zzb2NrOiBGaXggZXJyb3IgaGFuZGxpbmcgaW4gdmhvc3RfdnNvY2tfaW5pdCgpCgpydWFuamlu
amllICgxKToKICAgICAgdmRwYV9zaW06IGZpeCBwb3NzaWJsZSBtZW1vcnkgbGVhayBpbiB2ZHBh
c2ltX25ldF9pbml0KCkgYW5kIHZkcGFzaW1fYmxrX2luaXQoKQoKd2FuZ2ppYW5saSAoMSk6CiAg
ICAgIHRvb2xzL3ZpcnRpbzogVmFyaWFibGUgdHlwZSBjb21wbGV0aW9uCgogZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAzNSArKysrKy0tLS0tCiAu
Li4vY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX3NrY2lwaGVyX2FsZ3MuYyAgICB8ICAzICst
CiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oICAgICAgICAgICAgICAgICB8ICA1
ICstCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAgICAgICAgICAgICAgICAgICB8
IDQ2ICsrKysrKystLS0tLS0KIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgICAg
ICAgICAgICAgICAgIHwgNzggKysrKysrKy0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy92ZHBhL3Zk
cGEuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMSArKy0KIGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbS5jICAgICAgICAgICAgICAgICAgIHwgIDcgKy0KIGRyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyAgICAgICAgICAgICAgIHwgIDQgKy0KIGRyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyAgICAgICAgICAgICAgIHwgIDcgKy0KIGRy
aXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgICAgICAgICAgICAgICAgIHwgIDMgKwog
ZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jICAgICAgICAgICAgICAgICAgfCAgMiAr
LQogZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA1
MiArKysrKysrKystLS0tLS0KIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDQgKy0KIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDUgKy0KIGRyaXZlcnMvdmhvc3QvdnNvY2suYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDkgKystCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsrLS0KIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbW9kZXJuLmMgICAgICAgICAgICAgICAgIHwgIDQgKy0KIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KIGluY2x1ZGUvdWFwaS9saW51
eC92ZHBhLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0KIHRvb2xzL3ZpcnRpby9y
aW5ndGVzdC9tYWluLmggICAgICAgICAgICAgICAgICAgICAgIHwgMzcgKysrKystLS0tLQogdG9v
bHMvdmlydGlvL3ZpcnRpby10cmFjZS90cmFjZS1hZ2VudC1jdGwuYyAgICAgICAgfCAgMiArLQog
dG9vbHMvdmlydGlvL3ZpcnRpb190ZXN0LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAr
LQogdG9vbHMvdmlydGlvL3ZyaW5naF90ZXN0LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MiArCiAyMyBmaWxlcyBjaGFuZ2VkLCAxNzMgaW5zZXJ0aW9ucygrKSwgMTYzIGRlbGV0aW9ucygt
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
