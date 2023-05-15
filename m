Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA2CC7EE23
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 15:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DAA3615D6;
	Mon, 15 May 2023 15:54:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DAA3615D6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=P8nnJt16
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id khlimFWOcS5T; Mon, 15 May 2023 15:54:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DBC9160C2E;
	Mon, 15 May 2023 15:54:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DBC9160C2E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE116C0036;
	Mon, 15 May 2023 15:54:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46A33C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D5DD403D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:54:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D5DD403D6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=P8nnJt16
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dyNyA9I0xjMr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:54:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4936540129
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4936540129
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:54:22 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-965ddb2093bso1932891466b.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1684166060; x=1686758060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NzJTVdNPJahN4ZaYSD0w8tFsg1kEZiXFWub3q5MNDtA=;
 b=P8nnJt16+mjo39PxYO5U4M45PkUk/fsi27+EpDfDrrEOMN9q+uTLWoB+66tapULTf7
 ueBcqGL5epoo+bRixCvO3RPT3pbSojb3+XFJ5txqVKFOEHMrgECYpLQ+FHk/dFTvCfGg
 HmoNyUrSbV9wNhQaYVEGsAvba9QiPnqsAS0EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684166060; x=1686758060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzJTVdNPJahN4ZaYSD0w8tFsg1kEZiXFWub3q5MNDtA=;
 b=k8CuLWHAU9SIfEBJx0gYlvZz6sR5iuu6C5F2exT9EJBlqlL+D3SA27JKv93NRlZwZQ
 a1sGfEihzX9WvmofluXxStAVEkMk150xHITglEt5EWkC2aboEsgz8AVLPgupYmmcJhfa
 mFO7xR6xIXHsGzFdHdvo9XTvehbjOp/vb1GkZkPDVhlBzxK9Jsp3IAooMRPufHNCteF+
 SEOnUzLBbTSH15CDPamEB16BY846k01p3kk1qWOebAbg39TkQnDL9u+B/X7VVeabbViN
 bCdYLeIZcJQx/QBlH25qhwTsnPbEoUgUBZ2DT0srk934Xgch1tdW2vLDJxLtkS+asAfs
 ld/Q==
X-Gm-Message-State: AC+VfDxcx3u0zPnctxzsKOWffOyMllIU7YF3qu0761IirAO0a2uEwW7a
 3ykNoVLSrOhKH4CiakG5Yq7C/j+nDJVpHhLarZk0UbnF
X-Google-Smtp-Source: ACHHUZ5HyyS8biVFKcwODfTWpNu92wtlh2JQ95xaF8Eb6fz+dSvKo6iGvHIRHfRQwFvc9aIqlGbImQ==
X-Received: by 2002:a17:907:849:b0:968:c38f:5481 with SMTP id
 ww9-20020a170907084900b00968c38f5481mr25424606ejb.51.1684166060066; 
 Mon, 15 May 2023 08:54:20 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 ca21-20020a170906a3d500b00965a52d2bf6sm9570942ejb.88.2023.05.15.08.54.18
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 08:54:18 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-50bd875398dso19536836a12.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 08:54:18 -0700 (PDT)
X-Received: by 2002:a17:907:720d:b0:966:a691:55ed with SMTP id
 dr13-20020a170907720d00b00966a69155edmr26683920ejc.70.1684166057908; Mon, 15
 May 2023 08:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
In-Reply-To: <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 May 2023 08:54:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
Message-ID: <CAHk-=wiDqe+H7UnhD0qLbL8K8hnWUEdsRqcM4QnY=gZ3GytBRQ@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Jens Axboe <axboe@kernel.dk>
Content-Type: multipart/mixed; boundary="000000000000a0257505fbbd77bc"
Cc: Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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

--000000000000a0257505fbbd77bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 8:52=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/23 9:44?AM, Linus Torvalds wrote:
> >
> > So I think the patch should just look something like the attached.
> > Mike, can you test this on whatever vhost test-suite?
>
> Seems like that didn't get attached...

Blush. I decided to built-test it, and then forgot to attach it. Here.

                  Linus

--000000000000a0257505fbbd77bc
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhp0yu7e0>
X-Attachment-Id: f_lhp0yu7e0

IGtlcm5lbC9mb3JrLmMgICAgICAgfCAxMiArKystLS0tLS0tLS0KIGtlcm5lbC92aG9zdF90YXNr
LmMgfCAgMyArKy0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2VybmVsL2ZvcmsuYwppbmRleCBl
ZDRlMDFkYWNjYWEuLmNkMDZiMTM3NDE4ZiAxMDA2NDQKLS0tIGEva2VybmVsL2ZvcmsuYworKysg
Yi9rZXJuZWwvZm9yay5jCkBAIC0yMzM4LDE0ICsyMzM4LDEwIEBAIF9fbGF0ZW50X2VudHJvcHkg
c3RydWN0IHRhc2tfc3RydWN0ICpjb3B5X3Byb2Nlc3MoCiAJCXAtPmZsYWdzIHw9IFBGX0tUSFJF
QUQ7CiAJaWYgKGFyZ3MtPnVzZXJfd29ya2VyKQogCQlwLT5mbGFncyB8PSBQRl9VU0VSX1dPUktF
UjsKLQlpZiAoYXJncy0+aW9fdGhyZWFkKSB7Ci0JCS8qCi0JCSAqIE1hcmsgdXMgYW4gSU8gd29y
a2VyLCBhbmQgYmxvY2sgYW55IHNpZ25hbCB0aGF0IGlzbid0Ci0JCSAqIGZhdGFsIG9yIFNUT1AK
LQkJICovCisJaWYgKGFyZ3MtPmlvX3RocmVhZCkKIAkJcC0+ZmxhZ3MgfD0gUEZfSU9fV09SS0VS
OworCWlmIChhcmdzLT5pZ25vcmVfc2lnbmFscykKIAkJc2lnaW5pdHNldGludigmcC0+YmxvY2tl
ZCwgc2lnbWFzayhTSUdLSUxMKXxzaWdtYXNrKFNJR1NUT1ApKTsKLQl9CiAKIAlpZiAoYXJncy0+
bmFtZSkKIAkJc3Ryc2NweV9wYWQocC0+Y29tbSwgYXJncy0+bmFtZSwgc2l6ZW9mKHAtPmNvbW0p
KTsKQEAgLTI1MTcsOSArMjUxMyw2IEBAIF9fbGF0ZW50X2VudHJvcHkgc3RydWN0IHRhc2tfc3Ry
dWN0ICpjb3B5X3Byb2Nlc3MoCiAJaWYgKHJldHZhbCkKIAkJZ290byBiYWRfZm9ya19jbGVhbnVw
X2lvOwogCi0JaWYgKGFyZ3MtPmlnbm9yZV9zaWduYWxzKQotCQlpZ25vcmVfc2lnbmFscyhwKTsK
LQogCXN0YWNrbGVha190YXNrX2luaXQocCk7CiAKIAlpZiAocGlkICE9ICZpbml0X3N0cnVjdF9w
aWQpIHsKQEAgLTI4NjEsNiArMjg1NCw3IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCAqY3JlYXRlX2lv
X3RocmVhZChpbnQgKCpmbikodm9pZCAqKSwgdm9pZCAqYXJnLCBpbnQgbm9kZSkKIAkJLmZuX2Fy
ZwkJPSBhcmcsCiAJCS5pb190aHJlYWQJPSAxLAogCQkudXNlcl93b3JrZXIJPSAxLAorCQkuaWdu
b3JlX3NpZ25hbHMJPSAxLAogCX07CiAKIAlyZXR1cm4gY29weV9wcm9jZXNzKE5VTEwsIDAsIG5v
ZGUsICZhcmdzKTsKZGlmZiAtLWdpdCBhL2tlcm5lbC92aG9zdF90YXNrLmMgYi9rZXJuZWwvdmhv
c3RfdGFzay5jCmluZGV4IGI3Y2JkNjZmODg5ZS4uMmUzMzRiMmQ3Y2M0IDEwMDY0NAotLS0gYS9r
ZXJuZWwvdmhvc3RfdGFzay5jCisrKyBiL2tlcm5lbC92aG9zdF90YXNrLmMKQEAgLTc1LDcgKzc1
LDggQEAgc3RydWN0IHZob3N0X3Rhc2sgKnZob3N0X3Rhc2tfY3JlYXRlKGludCAoKmZuKSh2b2lk
ICopLCB2b2lkICphcmcsCiAJCQkJICAgICBjb25zdCBjaGFyICpuYW1lKQogewogCXN0cnVjdCBr
ZXJuZWxfY2xvbmVfYXJncyBhcmdzID0gewotCQkuZmxhZ3MJCT0gQ0xPTkVfRlMgfCBDTE9ORV9V
TlRSQUNFRCB8IENMT05FX1ZNLAorCQkuZmxhZ3MJCT0gQ0xPTkVfRlMgfCBDTE9ORV9VTlRSQUNF
RCB8IENMT05FX1ZNIHwKKwkJCQkgIENMT05FX1RIUkVBRCB8IENMT05FX1NJR0hBTkQsCiAJCS5l
eGl0X3NpZ25hbAk9IDAsCiAJCS5mbgkJPSB2aG9zdF90YXNrX2ZuLAogCQkubmFtZQkJPSBuYW1l
LAo=
--000000000000a0257505fbbd77bc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--000000000000a0257505fbbd77bc--
