Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9547DC3DA78
	for <virtualization@archiver.kernel.org>; Sun, 15 Jan 2023 07:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C93161192;
	Sun, 15 Jan 2023 07:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C93161192
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3NkR14+q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8TpZl6Z7PUBe; Sun, 15 Jan 2023 07:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A779D60D62;
	Sun, 15 Jan 2023 07:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A779D60D62
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64E62C0032;
	Sun, 15 Jan 2023 07:56:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5341C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Jan 2023 07:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98B0F6118F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Jan 2023 07:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98B0F6118F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RdEA30C6t6Ek
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Jan 2023 07:56:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18C6560D62
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18C6560D62
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Jan 2023 07:56:03 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id i65so15468829pfc.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7mPR+tYk06dWyheXQlcDvaKFF6VE45BY4pbiBRMyTf0=;
 b=3NkR14+qMITtW5c/bhsV3TZxEqserp/0VOuYZNP4g42CclG/xB4agcQEBFDlmIceTy
 Dnb+Gl8ZEbazw6K9BfxSDP353kv8wFoCOzjafOmUpIbb4bA7nygi/+rMVSO+5njloKYR
 CozVxIQlSZAJd9UjP1d+cle8o4s32xooYBqoBz9VDUN4Kv2V66W4gZ/lzxrzL1gZJnQp
 K0Y17q39OljeeFaoVglpyHwGXhK4Mt6LJ+78vfLmrPrS6m4q6R7Fp2b5nvw978ioGuYa
 DvfLxm5eVIN11nZKAUWWpvXXHr/Z67Zvf6tZ92vL3945LZ7OFwpYeJ/q/rEZb0zOV70O
 U5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7mPR+tYk06dWyheXQlcDvaKFF6VE45BY4pbiBRMyTf0=;
 b=FPT2Qg84O6zB09LrY7XFtGS804MbVFVqbUyJkgiqACGJEJTHRqT82ffAEAnDkH80SY
 MoFCina1tJQQRJ8fUxcufB4R1BSk4SzDPpE0MG1ImS+hH9nO9cDiHzPsN6XtFHnArElx
 dxr24YbillnQr0IdBexN8ejkx/yJfBNmVcU5lh9emAdI5SCXRGKhS7FXSsCFOLbe34wI
 M0K4UKrE+0iS6BK3biD2Us5ZO4ojr61t3jDtQCPjf9iD9WiV7YYcrNN4eWQ0KUxeUBAl
 5OB2KtKRBr2uqM1gLK9Y5/BNWxHf+XJtuX/1ZqRKfHT6n2Rw2HOwzU4HwkawDBcHU8ow
 SwDw==
X-Gm-Message-State: AFqh2krDm5J/Q7pa3sDSwSO+X924LOS0t33/KYcbuUpsUiqDgzwtlhXM
 KlXNvueshnbEWucrXbifXH1e//8+d95IN9SYygtg7w1tJvXnhTgS
X-Google-Smtp-Source: AMrXdXvAiyCmTWvJ9EHpfBDvUbeHLHSy+j5Yk8c2u2aPfRmZEEnLTIdJUxpu9gEHkkwwhxqg/OcINr2IlsC0dkOvol4=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr4778556pgr.504.1673769363038; Sat, 14
 Jan 2023 23:56:03 -0800 (PST)
MIME-Version: 1.0
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 15 Jan 2023 09:55:26 +0200
Message-ID: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
Subject: Virtio-blk extended lifetime feature
To: virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, 
 dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 egranata@google.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi guys,

While trying to upstream the implementation of VIRTIO_BLK_F_LIFETIME
feature, many developers suggested that this feature should be
extended to include more cell types, since its current implementation
in virtio spec is relevant for MMC and UFS devices only.

The VIRTIO_BLK_F_LIFETIME defines the following fields:

- pre_eol_info:  the percentage of reserved blocks that are consumed.
- device_lifetime_est_typ_a: wear of SLC cells.
- device_lifetime_est_typ_b: wear of MLC cells.

(https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html)

Following Michael's suggestion, I'd like to add to the virtio spec
with a new, extended lifetime command.
Since I'm more familiar with embedded type storage devices, I'd like
to ask you guys what fields you think should be included in the
extended command.

Thanks,

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
