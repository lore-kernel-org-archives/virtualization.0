Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC0CC4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 08:54:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED35E61059
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 08:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED35E61059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD68F60B6C;
	Thu, 12 Aug 2021 08:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4ZMOgJjB818; Thu, 12 Aug 2021 08:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 503E660699;
	Thu, 12 Aug 2021 08:54:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11DC9C0010;
	Thu, 12 Aug 2021 08:54:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26B40C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1098F605E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9StF_cyXdKO0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:54:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67D3060699
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 08:54:41 +0000 (UTC)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MnJdC-1muphK1OQ0-00jJAY for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 10:54:38 +0200
Received: by mail-wr1-f41.google.com with SMTP id h13so7202837wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 01:54:38 -0700 (PDT)
X-Gm-Message-State: AOAM531q5l7wAbVGDjXaWbzyp6RxhGp/0CuPiQlJLIqJmqmyJcTYvlOG
 7KeGKiZspIHwc/5ri209aKO09aGoykS92dhokn0=
X-Google-Smtp-Source: ABdhPJzZv/5OPQVMV4X72DNrEeILwE4MD89RT2+33mM5oD+u5NtsqZPGmxrUuRpkUtjSdyCe45aXAKV0gko4m0wLh/Y=
X-Received: by 2002:adf:fd89:: with SMTP id d9mr701787wrr.361.1628758477814;
 Thu, 12 Aug 2021 01:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
 <20210806030138.123479-2-xianting.tian@linux.alibaba.com>
 <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
 <f18d017b-d6f7-cf87-8859-8d6b50c7c289@linux.alibaba.com>
In-Reply-To: <f18d017b-d6f7-cf87-8859-8d6b50c7c289@linux.alibaba.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 12 Aug 2021 10:54:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ykLvJkhX+wDAOHdyLHjPFAfhOxi5BNM9kTKv_8F7VQg@mail.gmail.com>
Message-ID: <CAK8P3a2ykLvJkhX+wDAOHdyLHjPFAfhOxi5BNM9kTKv_8F7VQg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Xianting TIan <xianting.tian@linux.alibaba.com>
X-Provags-ID: V03:K1:9San7FZUVTBB1OcFfMZ3LnJZDhOB2eLJA12eJxgBO5Es9qhOhNu
 omjnyXONAxDGBANkLGJF3OZGlqX1dywESiWkQEshBcq8XDwqKx8m2bsHufKpONXizqzyRRn
 qplccuUSWoJCz3pILphpaFkJVCh5kMPn4ezmDEbeKrAtgMYjO5IR5CoCu8JXy07BKgAe/lO
 nPhOIrlrN2Opi7AKFd2Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IwjBcLCHqpg=:0rS9lxscJCj3zy7ND9kM7i
 xK88lPS55xVbi9PnsTN7D6zpald0uwfu4xS9eWG4C4OAxOGIdQyCt7RcQkdCsVezeU1bxH687
 37xXXp1uUJJ6HjYLvBKFjRQssHFOu4097LwzJnIA0wQ2xqd51b+E6JpjsfqEWhqRoPw/R22qV
 ZV4XjgzH95QXjeZyqi0a6aD2UP5cg1CYgoNdlS+SNzs8rx63Ep/6UTtbnEHywCKCHF9Klg+hJ
 ECPKPzBZfTe0hNYVFPpZPe+d2gUJnVMvbmZCRz2cXUq6AAcWCPMsqszeDy0ZpgafY7oMxYI7a
 vgf+uh85omIGJP5Q3m6MtpD5n4OAsjx8f990VHBKYG1HxSmg05kAyMXnA5/GDZi/cncPODi+L
 uNLlerWmnsgZ3/OJv6PvUJLp00Z+bAmHtnK0ek1bSD2nfyPisHZhGZaPd7krEdtgv0e2Is8Id
 VVSKYh11XJAMSoPFqEXX+R5os/gw5y2kHojNO0OSd8a4vA9XPenaO6jmHipucOgf3fmkZ+oH5
 gevrj0GaEg4eZMrOkvq3x+tdfVq6lB+vHr+cTKS1c10FYFmjGAeiHArj37ctU7URZu1Zfy6qV
 31xdf9DzmJzbf0qkewfOMtiq3gyUnaO4ymY7JRCE9lV4wPeuztGBfYEYakc7RVdZ2S5pzgaEH
 3ThBN52AW78QwpV8DLKRw4TwT/n8Z0efTf7ipKp6uuZ8de3e9b2JZ4CHzQZRlrwktJUI8QzZW
 RjsiyW1IFfa0k/jrYVG9JhVA5vQ1HeoUMjbC70Qu94Vg6nvmQZqLTH4dbwOtjFSauBdAq656D
 mwaYkg4Zxf0NIpE1B37AbwQkw0m+PsVOT7wwunMRh/jIhqDieS8wiitfLNxYpONNDxvMCbi
Cc: Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
 Amit Shah <amit@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Guo Ren <guoren@kernel.org>,
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

T24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTA6MDggQU0gWGlhbnRpbmcgVElhbgo8eGlhbnRpbmcu
dGlhbkBsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4g5ZyoIDIwMjEvOC82IOS4i+WNiDEwOjUx
LCBBcm5kIEJlcmdtYW5uIOWGmemBkzoKPiA+IE9uIEZyaSwgQXVnIDYsIDIwMjEgYXQgNTowMSBB
TSBYaWFudGluZyBUaWFuCj4gPj4gKyNkZWZpbmUgX19BTElHTkVEX18gX19hdHRyaWJ1dGVfXygo
X19hbGlnbmVkX18oc2l6ZW9mKGxvbmcpKSkpCj4gPiBJIHRoaW5rIHlvdSBuZWVkIGEgaGlnaGVy
IGFsaWdubWVudCBmb3IgRE1BIGJ1ZmZlcnMsIGluc3RlYWQgb2Ygc2l6ZW9mKGxvbmcpLAo+ID4g
SSB3b3VsZCBzdWdnZXN0IEFSQ0hfRE1BX01JTkFMSUdOLgo+Cj4gQXMgc29tZSBBUkNIKGVnLCB4
ODYsIHJpc2N2KSBkb2Vzbid0IGRlZmluZSBBUkNIX0RNQV9NSU5BTElHLCBzbyBpIHRoaW5rCj4g
aXQgJ3MgYmV0dGVyIHJlbWFpbiB0aGUgY29kZSB1bmNoYW5nZWQsCj4KPiBJIHdpbGwgc2VuZCB2
NSBwYXRjaCBzb29uLgoKSSB0aGluayB5b3UgY291bGQganVzdCB1c2UgIkwxX0NBQ0hFX0JZVEVT
IiBhcyB0aGUgYWxpZ25tZW50IGluIHRoaXMgY2FzZS4KVGhpcyB3aWxsIG1ha2UgdGhlIHN0cnVj
dHVyZSBzbGlnaHRseSBsYXJnZXIgZm9yIGFyY2hpdGVjdHVyZXMgdGhhdCBkbyBub3QgaGF2ZQph
bGlnbm1lbnQgY29uc3RyYWludHMgb24gRE1BIGJ1ZmZlcnMsIGJ1dCB1c2luZyBhIHNtYWxsZXIg
YWxpZ25tZW50IGlzCmNsZWFybHkgd3JvbmcuIEFub3RoZXIgb3B0aW9uIHdvdWxkIGJlIHRvIHVz
ZSBBUkNIX0tNQUxMT0NfTUlOQUxJR04uCgpOb3RlIHRoYXQgdGhlcmUgaXMgYSBwYXRjaCB0byBh
ZGQgQVJDSF9ETUFfTUlOQUxJR04gdG8gcmlzY3YgYWxyZWFkeSwKYXMgc29tZSBpbXBsZW1lbnRh
dGlvbnMgZG8gbm90IGhhdmUgY29oZXJlbnQgRE1BLiBJIGhhZCBmYWlsZWQgdG8KcmVhbGl6ZWQg
dGhvdWdoIHRoYXQgb24geDg2IHlvdSBkbyBub3QgZ2V0IGFuIEFSQ0hfRE1BX01JTkFMSUdOCmRl
ZmluaXRpb24uCgogICAgICAgQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
