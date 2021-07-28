Return-Path: <SRS0=JFNa=MU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D9C432BE
	for <virtualization@archiver.kernel.org>; Wed, 28 Jul 2021 09:01:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A4560FC0
	for <virtualization@archiver.kernel.org>; Wed, 28 Jul 2021 09:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76A4560FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4225660872;
	Wed, 28 Jul 2021 09:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEOE3KRP5jmp; Wed, 28 Jul 2021 09:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D8F12605A6;
	Wed, 28 Jul 2021 09:01:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5FA3C001A;
	Wed, 28 Jul 2021 09:01:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3D2C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 09:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 379054017A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 09:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ScWivTqlbdW9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 09:01:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC27E40004
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 09:01:36 +0000 (UTC)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MV5rK-1maofL2gaM-00S5kR for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 11:01:33 +0200
Received: by mail-wr1-f46.google.com with SMTP id n12so1593791wrr.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 02:01:33 -0700 (PDT)
X-Gm-Message-State: AOAM532TVkBYwAWTfoR7y8i7if+6k0c5nYkB24eBCS9d3CXaMJX19mYc
 XCHR18egw5SBo8KMiZN/CKmL37xtswu/b7aHKa4=
X-Google-Smtp-Source: ABdhPJzsTaVx3R8Xjt7RmEMRCOEETac71shB32aGf6LsvyM2QcF0PWl6f37f55OVAfeM0QRVKWrKMZbildTjD36IfgI=
X-Received: by 2002:adf:e107:: with SMTP id t7mr28823475wrz.165.1627462893205; 
 Wed, 28 Jul 2021 02:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
 <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
 <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
 <0d03a42b-b46c-408f-17a4-b6c094c0c29e@linux.alibaba.com>
In-Reply-To: <0d03a42b-b46c-408f-17a4-b6c094c0c29e@linux.alibaba.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Jul 2021 11:01:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
Message-ID: <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To: Xianting Tian <xianting.tian@linux.alibaba.com>
X-Provags-ID: V03:K1:o5xxxgZLSIvsu7issqFgEpEsJxNeM9Apk0sje5o93/19e13FPVd
 4eTacnkUwFe8wj/uOtawkogxn5/ZFvoJ9nXk8rfNrRWlqfSo2C/6KNCltcYF79adiLtJSh8
 4iI+wOqeDcsHydWnArg9gJqZ6YN1zr1A8fJoi6Ioo60Kl9hp81+2QXC66jDdqAKbcVtLSKs
 NmLbFBz+GoKTxSkc2dEaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:58hSoB8z1ls=:SjJjY4cKUeFJRmjghrKnqN
 mYr9eDH+Nd4QpW9M1pkjYiULnpLo4wsATNhWsHy1gEORwVvR3PY8rrDtZP4gGod/gUQHk1Z7j
 jJsOZcybEnLzsGMvRrRxCbXBvf0pmM6WyohxKx5fIxShowMDKQKbCLEZ/fqKiJnW29YkV2sPk
 msEsRDiZyCaULc+ZUIGLPdX8zem5ucW+l4ydLs/fM7XoSDz4Z4nMOJ/CnRjThMhnHmY2W64yq
 8GVSRUhS0WxK/qF0PKYTwX7dkJgnXB07iUX8TYOklVRh9qQpLrvHMHNWuWphsptF990QMh7K4
 fNBL/1GXvUaMsAN+LUkTMugitKiVOtvMMC9YwtrfLV5CWC3y79N1XlxxvkEG4TZCCWXo4Hrk6
 bJl2Qp/7ARtUn2HEs1SZdq3byqeJzZcT6gA7ly+p07zCd3UWvPwQFIrLiRfdScMXA8Tg9gyWu
 UxGOyYEnpiklwG3mC+EGIN+Pw5C+WCO9NRrGfSaku0MFzPl/VLwHtdMDYY8X+esuVLvHQHujM
 7DgSxyfOr13HK00M0uy9LAfT1BB7joCfkOO6C/M8G0jwMVsrK7lyNMhDgv+OqhSavm2Q6/tCw
 9bcuttnvp6Ob0EUAAk4FkiPM5s2F0Deis85W9AFX0hogdizVqW24fVOXUR1QJhPnZG8/g5omU
 POFPDOTGk7o3xt5QxkbJMayce6R7AX7XZIhLPwbu+vryEBw11GJwU5M4+MjRMbOGAqdI8wCxw
 /cg52Ai7DGoZMYEHyCj8vAMyTe85uPS8KBfulY3096yfbqyZ1MQt20HlOCzO1kdNdjqYIEyVm
 s66S0+m+5/7cFcL/9Kug45NgYYo8m+kpv1P0O04rOi5KyJD4VeUwuvXeYQ/SBpB5qkRYXlV
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Omar Sandoval <osandov@fb.com>
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

T24gV2VkLCBKdWwgMjgsIDIwMjEgYXQgMTA6MjggQU0gWGlhbnRpbmcgVGlhbgo8eGlhbnRpbmcu
dGlhbkBsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4g5ZyoIDIwMjEvNy8yOCDkuIvljYgzOjI1
LCBBcm5kIEJlcmdtYW5uIOWGmemBkzoKPgo+IEkgY2hlY2tlZCBzZXZlcmFsIGh2YyBiYWNrZW5k
cywgbGlrZSBkcml2ZXJzL3R0eS9odmMvaHZjX3Jpc2N2X3NiaS5jLAo+IGRyaXZlcnMvdHR5L2h2
Yy9odmNfaXVjdi5jLCBkcml2ZXJzL3R0eS9odmMvaHZjX3J0YXMuYywgdGhleSBkb24ndCB1c2Ug
ZG1hLgo+Cj4gSSBub3QgZmluaXNoZWQgYWxsIGh2YyBiYWNrZW5kcyBjaGVjayB5ZXQuIEJ1dCBJ
IHRoaW5rIGV2ZW4gaWYgYWxsIGh2Ywo+IGJhY2tlbmRzIGRvbid0IHVzZSBkbWEgY3VycmVudGx5
LCBpdCBpcyBzdGlsbCBwb3NzaWJsZSB0aGF0IHRoZSBodmMKPiBiYWNrZW5kIHVzaW5nIGRtYSB3
aWxsIGJlIGFkZGVkIGluIHRoZSBmdXJ0dXJlLgo+Cj4gU28gSSBhZ3JlZSB3aXRoIHlvdSBpdCBz
aG91bGQgYmV0dGVyIGJlIGZpeGVkIGluIHRoZSBodmMgZnJhbWV3b3JrLAo+IHNvbHZlIHRoZSBp
c3N1ZSBpbiB0aGUgZmlyc3QgcGxhY2UuCgpPaywgc291bmRzIGdvb2QgdG8gbWUsIG5vIG5lZWQg
dG8gY2hlY2sgbW9yZSBiYWNrZW5kcyB0aGVuLgpJIHNlZSB0aGUgaHZjLWNvbnNvbGUgZHJpdmVy
IGlzIGxpc3RlZCBhcyAnT2RkIEZpeGVzJyBpbiB0aGUgbWFpbnRhaW5lcgpsaXN0LCB3aXRoIG5v
Ym9keSBhc3NpZ25lZCBvdGhlciB0aGFuIHRoZSBwcGMga2VybmVsIGxpc3QgKGFkZGVkIHRvIENj
KS4KCk9uY2UgeW91IGNvbWUgdXAgd2l0aCBhIGZpeCBpbiBodmNfY29uc29sZS5jLCBwbGVhc2Ug
c2VuZCB0aGF0IHRvIHRoZQp0dHkgbWFpbnRhaW5lcnMsIHRoZSBwcGMgbGlzdCBhbmQgbWUsIGFu
ZCBJJ2xsIHJldmlldyBpdC4KCiAgICAgICAgQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
