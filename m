Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2768C433F5
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 04:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 659934185E;
	Mon, 23 May 2022 04:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zlq63hJB_p-U; Mon, 23 May 2022 04:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B9ECA41845;
	Mon, 23 May 2022 04:15:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87D5DC0039;
	Mon, 23 May 2022 04:15:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB367C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 962D641853
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fC8DPpvX1wLi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:15:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29DE441845
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653279334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/4uq0rZJkoN6vEvVqkAPhz7EjjSM0bnK2nRK5G7D8m8=;
 b=KS9QVS9g3hA280cow634h5qkxSvr3xpNfq6t6Lx5akvtQ0GLzjpcO7jO7wNt7GbfCtUE8B
 uEC9R5U0n/2eA+b+eiAtqYRTXEtigJaxqSuA6azbLBSFYTS8WLJNCa/HLDyOP5zMDuBve3
 NSew5BLZNjJerpm0wjjGVJIuezI9yjk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-csy9ABV_MYuPRb0uS9m-Lw-1; Mon, 23 May 2022 00:15:29 -0400
X-MC-Unique: csy9ABV_MYuPRb0uS9m-Lw-1
Received: by mail-lj1-f197.google.com with SMTP id
 f10-20020a2e9e8a000000b00250925fec6aso2540763ljk.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 May 2022 21:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/4uq0rZJkoN6vEvVqkAPhz7EjjSM0bnK2nRK5G7D8m8=;
 b=LMNs5vKWuVmOshfpcDWWrGSJpNRXaSpG5jgaQQNCLyqw4iUaadhRSv5/bt1DGg0Ewb
 gWBUQS3Ov8qOYj0r7LjSGWzSIKSdjPb0AEHjVTl5eKJ49yhR4wVP327jtJzkHp6syju4
 xoUQzFBTpFWPLhq/XDwrKePlEpuJGEJwtlbIQKQ/OoXcbrj7Zx9hu31RnttOWDFro0f6
 mbs7K4hjbkckWDMHhJ0H1hyuQKqSokxGbQwN/cco5sOvkOPg6oTcBiWZaWqtAgM3fc9D
 emQeC5FR8FzhUp+gwukCwcXmdypi92LtrTj+BQuQFwvucq6irbnCCmFTywZvFtdZbWlw
 wz7A==
X-Gm-Message-State: AOAM533WViooXUAaXSzSd0qwzlPX88HpzABwIN7E5cxDQ83xkT7KBBBd
 gDtiVsAW7W34pYi7TMSJtfUPL6Th2zoZ/SJnw87y8Gls3WBWvri+QKBnh4XpwsPo6SD0rUvWb+J
 33W8aLzddtK4gY7+DSKbvBbrAXqQgkBIWPVEvPre+n7MxCc6KlRDXta3tfg==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr14947653lfa.210.1653279328291; 
 Sun, 22 May 2022 21:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWmvbbOnlzByyq0K7ST1/0Rig6zYncXxT7uN0bhy7BAXium/pYbfOxxsbqwsJyyqfJa8HBFvtAlbjEDB8k180=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr14947643lfa.210.1653279328132; Sun, 22
 May 2022 21:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBj=5jD5AjyaF8UmMXAZGFnMEgTruFM2KYL3GGZt-ABcHBQ@mail.gmail.com>
In-Reply-To: <CAMhUBj=5jD5AjyaF8UmMXAZGFnMEgTruFM2KYL3GGZt-ABcHBQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 May 2022 12:15:16 +0800
Message-ID: <CACGkMEvgtzUXw9v=cMN3=Mqm9YTp_2bKmc4--q2+BREvgVdeLg@mail.gmail.com>
Subject: Re: [BUG] vDPA/ifcvf: got a warning when removing the module
To: Zheyu Ma <zheyuma97@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="0000000000001188a805dfa6171f"
Cc: mst <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eli Cohen <elic@nvidia.com>
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

--0000000000001188a805dfa6171f
Content-Type: text/plain; charset="UTF-8"

On Sat, May 21, 2022 at 10:27 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> Hello,
>
> I found a bug in the ifcvf driver.
> When removing the module, I got the following warning:
>
> [   14.478123] general protection fault, probably for non-canonical
> address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> [   14.478701] KASAN: null-ptr-deref in range
> [0x0000000000000028-0x000000000000002f]
> [   14.479922] RIP: 0010:vdpa_mgmtdev_unregister+0x39/0x150
> [   14.484063] Call Trace:
> [   14.484186]  <TASK>
> [   14.484292]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
> [   14.484536]  ifcvf_remove+0x3a/0x50 [ifcvf]
> [   14.484743]  pci_device_remove+0x92/0x240
>
> The reason is that the 'ifcvf_mgmt_dev' is zero which means that
> ifcvf_vdpa_dev_add() was not executed.
> Since I am not familiar with the driver, I cannot find a proper solution for it.
>

Looks like the drv data needs to be set in probe(). Could you pleas
try to the attached patch? (compile test only).

Thanks

> Zheyu Ma
>

--0000000000001188a805dfa6171f
Content-Type: application/octet-stream; 
	name="0001-vdpa-ifcvf-set-pci-driver-data-in-probe.patch"
Content-Disposition: attachment; 
	filename="0001-vdpa-ifcvf-set-pci-driver-data-in-probe.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l3i7tfc30>
X-Attachment-Id: f_l3i7tfc30

RnJvbSBjN2MwMzFkMWE1YzY0ZTBmNThlMDE1NzlmZjc4MjI0YTU4ZDZhNGZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBNb24sIDIzIE1heSAyMDIyIDEyOjEyOjAwICswODAwClN1YmplY3Q6IFtQQVRDSF0gdmRwYTog
aWZjdmY6IHNldCBwY2kgZHJpdmVyIGRhdGEgaW4gcHJvYmUKQ29udGVudC10eXBlOiB0ZXh0L3Bs
YWluCgpXZSBzaG91bGQgc2V0IHRoZSBwY2kgZHJpdmVyIGRhdGEgaW4gcHJvYmUgaW5zdGVhZCBv
ZiB0aGUgdmRwYSBkZXZpY2UKYWRkaW5nIGNhbGxiYWNrLiBPdGhlcndpc2UgaWYgbm8gdkRQQSBk
ZXZpY2UgaXMgY3JlYXRlZCB3ZSB3aWxsIGxvc2UKdGhlIHBvaW50ZXIgdG8gdGhlIG1hbmFnZW1l
bnQgZGV2aWNlLgoKRml4ZXM6IDZiNWRmMzQ3YzY0ODIgKCJ2RFBBL2lmY3ZmOiBpbXBsZW1lbnQg
bWFuYWdlbWVudCBuZXRsaW5rIGZyYW1ld29yayBmb3IgaWZjdmYiKQpTaWduZWQtb2ZmLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
Yi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCmluZGV4IDQzNjYzMjBmYjY4ZC4uMTk3
ZDUyZTdiODAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCisr
KyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKQEAgLTc2NSw3ICs3NjUsNiBAQCBz
dGF0aWMgaW50IGlmY3ZmX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwg
Y29uc3QgY2hhciAqbmFtZSwKIAl9CiAKIAlpZmN2Zl9tZ210X2Rldi0+YWRhcHRlciA9IGFkYXB0
ZXI7Ci0JcGNpX3NldF9kcnZkYXRhKHBkZXYsIGlmY3ZmX21nbXRfZGV2KTsKIAogCXZmID0gJmFk
YXB0ZXItPnZmOwogCXZmLT5kZXZfdHlwZSA9IGdldF9kZXZfdHlwZShwZGV2KTsKQEAgLTg4MCw2
ICs4NzksOCBAQCBzdGF0aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCiAJCWdvdG8gZXJyOwogCX0KIAorCXBjaV9z
ZXRfZHJ2ZGF0YShwZGV2LCBpZmN2Zl9tZ210X2Rldik7CisKIAlyZXR1cm4gMDsKIAogZXJyOgot
LSAKMi4yNS4xCgo=
--0000000000001188a805dfa6171f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--0000000000001188a805dfa6171f--

