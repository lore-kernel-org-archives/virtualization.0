Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01515C77B73
	for <virtualization@archiver.kernel.org>; Sat, 27 May 2023 16:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45EE042014;
	Sat, 27 May 2023 16:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45EE042014
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=T9rdZ8CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nb29SpRKtj7d; Sat, 27 May 2023 16:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3469A42041;
	Sat, 27 May 2023 16:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3469A42041
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07FE1C0035;
	Sat, 27 May 2023 16:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87432C002A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 16:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57DC660F2A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 16:12:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57DC660F2A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=T9rdZ8CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8ul4e7pgU_p
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 16:12:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8E9960F03
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8E9960F03
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 16:12:48 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51478f6106cso2714883a12.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1685203966; x=1687795966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I/bw27vS3UVZGByGOfLoz+Tva7cynCfUs6ZBWXI06bo=;
 b=T9rdZ8CAEEk2bwYl04RlNrdIw1fR0aZAtgEkRhT1ywPBV5ljidGU1zkHPG7XuRkavG
 0ldhVFgA/+nuYwudhD8SkCHF0F+9mZeET9tUkJ7H19OO7a436jmmsH02rfu9iXl6Mls6
 +bQEh76AYnTrCMsvy42HbavxbjHEAJetWtPXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685203966; x=1687795966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/bw27vS3UVZGByGOfLoz+Tva7cynCfUs6ZBWXI06bo=;
 b=KcOZERhkNE8XK+WDdV2gjZEUia80xFTSQA6Du3GuigPVK3p8rCB+wGIDswOZjAxu9t
 cQR5DMZDkfdHPZ/6fN6AL+KxRPMe0ENEfc0jqgMOqlp2zTg0Mr5OXDex5FsumjyKdTQk
 OR3A2eExoommx6I67bhMHeNXLFsw3NPfxYoLDLh5tJF2fCpTJdbMkxXCeqYT7Nd9f1Wp
 s12MEoWfpvbPQQvbiVCNz3GAMEkZ4ExUyUZryT5CRGUPUYC+mLEl+Ly5hy8rfgKtxwwd
 eCPqGMtLohdk/BsvvlgLe6S4w4+JZXQmuKAzQvw6ki685CG8naOxOuD6o/spVHJfxC7X
 QTyA==
X-Gm-Message-State: AC+VfDynwrbIxXVI9Vk727gIG4R9+iWKvRuK6/r18/Zzs/loJsOa5szz
 e7NopIW7BaYZG/xQaTFgIWsvJ77+FlzNeF0G+i3OL9NNTKA=
X-Google-Smtp-Source: ACHHUZ6ZU6jItHH8QvBBfC1siFvAxvejaibxtJPfQRjC9MOwpu0SLRejAmIRkH3BEU1gVeoIDb0P0Q==
X-Received: by 2002:a17:907:5cb:b0:968:c3b5:8b92 with SMTP id
 wg11-20020a17090705cb00b00968c3b58b92mr4045652ejb.57.1685203966530; 
 Sat, 27 May 2023 09:12:46 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 f19-20020a170906139300b0095fd0462695sm3532269ejc.5.2023.05.27.09.12.44
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 May 2023 09:12:45 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5147e8972a1so2503894a12.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 09:12:44 -0700 (PDT)
X-Received: by 2002:a17:907:3607:b0:96f:7b4a:2909 with SMTP id
 bk7-20020a170907360700b0096f7b4a2909mr5884052ejc.26.1685203964300; Sat, 27
 May 2023 09:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 May 2023 09:12:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
Message-ID: <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
Subject: Re: [PATCH 3/3] fork,
 vhost: Use CLONE_THREAD to fix freezer/ps regression
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: multipart/mixed; boundary="000000000000aae9aa05fcaf1f14"
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--000000000000aae9aa05fcaf1f14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 2:49=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> The real sticky widget for me is how to handle one of these processes
> coredumping.  It really looks like it will result in a reliable hang.

Well, if *that* is the main worry, I think that's trivial enough to deal wi=
th.

In particular, we could make the rule just be that user worker threads
simply do not participate in core-dumps.

THAT isn't hard.

All we need to do is

 (a) not count those threads in zap_threads()

 (b) make sure that they don't add themselves to the "dumper" list by
not calling "coredujmp_task_exit()"

 (c) not initiate core-dumping themselves.

and I think that's pretty much it.

In fact, that really seems like a good model *regardless*, because
honestly, a PF_IO_WORKER doesn't have valid register state for the
core dump anyway, and anything that would have caused a IO thread to
get a SIGSEGV *should* have caused a kernel oops already.

So the only worry is that the core dump will now happen while an IO
worker is still busy and so it's not "atomic" wrt possible VM changes,
but while that used to be a big problem back in the dark ages when we
didn't get the VM locks for core dumping, that got fixed a few years
ago because it already caused lots of potential issues.

End result: I think the attached patch is probably missing something,
but the approach "FeelsRight(tm)" to me.

Comments?

                   Linus

--000000000000aae9aa05fcaf1f14
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_li66x0ln0>
X-Attachment-Id: f_li66x0ln0

IGZzL2NvcmVkdW1wLmMgICB8ICAyICstCiBrZXJuZWwvZXhpdC5jICAgfCAgNiArKysrKysKIGtl
cm5lbC9zaWduYWwuYyB8IDE4ICsrKysrKysrKystLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAx
NyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NvcmVkdW1w
LmMgYi9mcy9jb3JlZHVtcC5jCmluZGV4IGVjZTdiYWRmNzAxYi4uNDZmODE0NWIzOWU2IDEwMDY0
NAotLS0gYS9mcy9jb3JlZHVtcC5jCisrKyBiL2ZzL2NvcmVkdW1wLmMKQEAgLTM2OCw3ICszNjgs
NyBAQCBzdGF0aWMgaW50IHphcF9wcm9jZXNzKHN0cnVjdCB0YXNrX3N0cnVjdCAqc3RhcnQsIGlu
dCBleGl0X2NvZGUpCiAKIAlmb3JfZWFjaF90aHJlYWQoc3RhcnQsIHQpIHsKIAkJdGFza19jbGVh
cl9qb2JjdGxfcGVuZGluZyh0LCBKT0JDVExfUEVORElOR19NQVNLKTsKLQkJaWYgKHQgIT0gY3Vy
cmVudCAmJiAhKHQtPmZsYWdzICYgUEZfUE9TVENPUkVEVU1QKSkgeworCQlpZiAodCAhPSBjdXJy
ZW50ICYmICEodC0+ZmxhZ3MgJiAoUEZfUE9TVENPUkVEVU1QIHwgUEZfSU9fV09SS0VSKSkpIHsK
IAkJCXNpZ2FkZHNldCgmdC0+cGVuZGluZy5zaWduYWwsIFNJR0tJTEwpOwogCQkJc2lnbmFsX3dh
a2VfdXAodCwgMSk7CiAJCQlucisrOwpkaWZmIC0tZ2l0IGEva2VybmVsL2V4aXQuYyBiL2tlcm5l
bC9leGl0LmMKaW5kZXggMzRiOTBlMmU3Y2Y3Li5mZGU1N2I5ZjQ0OTQgMTAwNjQ0Ci0tLSBhL2tl
cm5lbC9leGl0LmMKKysrIGIva2VybmVsL2V4aXQuYwpAQCAtNDAwLDYgKzQwMCwxMiBAQCBzdGF0
aWMgdm9pZCBjb3JlZHVtcF90YXNrX2V4aXQoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiB7CiAJ
c3RydWN0IGNvcmVfc3RhdGUgKmNvcmVfc3RhdGU7CiAKKwkvKgorCSAqIElPIHdvcmtlcnMgZG8g
bm90IHBhcnRpY2lwYXRlIGluIGR1bXBpbmcgY29yZQorCSAqLworCWlmICh0c2stPmZsYWdzICYg
UEZfSU9fV09SS0VSKQorCQlyZXR1cm47CisKIAkvKgogCSAqIFNlcmlhbGl6ZSB3aXRoIGFueSBw
b3NzaWJsZSBwZW5kaW5nIGNvcmVkdW1wLgogCSAqIFdlIG11c3QgaG9sZCBzaWdsb2NrIGFyb3Vu
ZCBjaGVja2luZyBjb3JlX3N0YXRlCmRpZmYgLS1naXQgYS9rZXJuZWwvc2lnbmFsLmMgYi9rZXJu
ZWwvc2lnbmFsLmMKaW5kZXggOGY2MzMwZjBlOWNhLi5lMGFjYjExZDNhMWQgMTAwNjQ0Ci0tLSBh
L2tlcm5lbC9zaWduYWwuYworKysgYi9rZXJuZWwvc2lnbmFsLmMKQEAgLTI4NDUsNiArMjg0NSwx
NiBAQCBib29sIGdldF9zaWduYWwoc3RydWN0IGtzaWduYWwgKmtzaWcpCiAJCSAqLwogCQljdXJy
ZW50LT5mbGFncyB8PSBQRl9TSUdOQUxFRDsKIAorCQkvKgorCQkgKiBQRl9JT19XT1JLRVIgdGhy
ZWFkcyB3aWxsIGNhdGNoIGFuZCBleGl0IG9uIGZhdGFsIHNpZ25hbHMKKwkJICogdGhlbXNlbHZl
cyBhbmQgZG8gbm90IHBhcnRpY2lwYXRlIGluIGNvcmUgZHVtcGluZy4KKwkJICoKKwkJICogVGhl
eSBoYXZlIGNsZWFudXAgdGhhdCBtdXN0IGJlIHBlcmZvcm1lZCwgc28gd2UgY2Fubm90CisJCSAq
IGNhbGwgZG9fZXhpdCgpIG9uIHRoZWlyIGJlaGFsZi4KKwkJICovCisJCWlmIChjdXJyZW50LT5m
bGFncyAmIFBGX0lPX1dPUktFUikKKwkJCWdvdG8gb3V0OworCiAJCWlmIChzaWdfa2VybmVsX2Nv
cmVkdW1wKHNpZ25yKSkgewogCQkJaWYgKHByaW50X2ZhdGFsX3NpZ25hbHMpCiAJCQkJcHJpbnRf
ZmF0YWxfc2lnbmFsKGtzaWctPmluZm8uc2lfc2lnbm8pOwpAQCAtMjg2MCwxNCArMjg3MCw2IEBA
IGJvb2wgZ2V0X3NpZ25hbChzdHJ1Y3Qga3NpZ25hbCAqa3NpZykKIAkJCWRvX2NvcmVkdW1wKCZr
c2lnLT5pbmZvKTsKIAkJfQogCi0JCS8qCi0JCSAqIFBGX0lPX1dPUktFUiB0aHJlYWRzIHdpbGwg
Y2F0Y2ggYW5kIGV4aXQgb24gZmF0YWwgc2lnbmFscwotCQkgKiB0aGVtc2VsdmVzLiBUaGV5IGhh
dmUgY2xlYW51cCB0aGF0IG11c3QgYmUgcGVyZm9ybWVkLCBzbwotCQkgKiB3ZSBjYW5ub3QgY2Fs
bCBkb19leGl0KCkgb24gdGhlaXIgYmVoYWxmLgotCQkgKi8KLQkJaWYgKGN1cnJlbnQtPmZsYWdz
ICYgUEZfSU9fV09SS0VSKQotCQkJZ290byBvdXQ7Ci0KIAkJLyoKIAkJICogRGVhdGggc2lnbmFs
cywgbm8gY29yZSBkdW1wLgogCQkgKi8K
--000000000000aae9aa05fcaf1f14
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--000000000000aae9aa05fcaf1f14--
