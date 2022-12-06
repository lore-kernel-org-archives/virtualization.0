Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316B8C63704
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 19:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A776161036;
	Tue,  6 Dec 2022 19:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A776161036
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=5gZ4Gpu/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QupM6ORRoWHx; Tue,  6 Dec 2022 19:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3461E60E00;
	Tue,  6 Dec 2022 19:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3461E60E00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06739C0032;
	Tue,  6 Dec 2022 19:56:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1407C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 19:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B03481EF8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 19:56:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B03481EF8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=5gZ4Gpu/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id krSNGP94mZ6n
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 19:56:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B23281EF6
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B23281EF6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 19:56:41 +0000 (UTC)
Received: by mail-il1-x134.google.com with SMTP id s16so6966598iln.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Dec 2022 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pr5A82QMDS3439cV/l0TiwyD6oe8HTmjdxBAYHIenkw=;
 b=5gZ4Gpu/Xoh5ChxX8vn4yDQ839Y02gORAbRJKicZwrHFBH0NIchUZDW6Y615MW8Cuo
 ZdO4L3CqvKD9JNcgHJjpe9/mjrs85Al83QInqMzjcK62pr1wgEqU8ZhTAJi4Ib3ahj7k
 BZlEtq3KfssqlsY9tZQIx0vaLlC9u3vbxT8LvjuAL1GnsClNkR2tm4WIKQeodHoXdkZE
 KiPCEIcEoxIg4QSjQNTqtlAXIew+2ghnCH4ev8+TU75YzUKjhKWJSMnNxTy27fwj8JCb
 XWwul5V7p/Z+1rXby5ETA9G2t4IWGRXtyRcQ3Cmi0XJKOmS3YkN3oRqED74z2Db+6nws
 ZSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pr5A82QMDS3439cV/l0TiwyD6oe8HTmjdxBAYHIenkw=;
 b=LY3682wZWEQ6pJkK+ebtff+TJC//0Ru6F6ov4SZtx9gFVNBWjch6/qo0ajaijnQjtv
 +Ca0iSgCJ4SWy8ABDiPOiRD/Iztb3/2VN9NE8qroxp2opdWq7iHIGdNnA/Lk8z1zKNhV
 71pv8WPTDsZ5maI3ouq/PI3+IDxY2ekC4FHKq46/ezI1WjWW6rpCMzh7D3iRP0bANxFc
 i4VMHpIr5AT4k4NTikuS1tzlGazYc0gRGaFcl7KeRgRrF0WAwxwAJvw0cdsNsTjqor+j
 gYd7e3ZMJku47nbXb+R5SS1iaeKdJ4EcDPFDW6wdqesrSp/6xy2DwxGdbQ5FzE8bqmdj
 RV3w==
X-Gm-Message-State: ANoB5pkiVLJBEMRfoaeoC38NcwC6L2UGWAIh1hyPqPHc9KKkE0ZsgCKG
 2y06wML0uhlDQKP11CubdwWxrIlXg+7b7rs/dMrztw==
X-Google-Smtp-Source: AA0mqf5weYpfxnfmeNEaWEQd5GuamfhCWZUc6GKCqEjTgjj47RKtDegoyGS/7Ff3WUue6RAch00gS/qlXcQ0t/Pzp84=
X-Received: by 2002:a05:6e02:1c8d:b0:303:71ee:7b6b with SMTP id
 w13-20020a056e021c8d00b0030371ee7b6bmr2852396ill.147.1670356600505; Tue, 06
 Dec 2022 11:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
In-Reply-To: <1d1c946d-2739-6347-f453-8ccf92c6a0cc@acm.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 6 Dec 2022 21:56:05 +0200
Message-ID: <CAJs=3_CWrO34KBxN_eNVyibRNYUP9tzmywnmq2W+9uMYwbQdBA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

Hi Bart,

> Why does the above data structure only refer to SLC and MLC but not to
> TLC or QLC?

This has been discussed before.
The data structure follows the virtio spec
(https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html)

> How will this data structure be extended without having to introduce a
> new ioctl?

There are no more lifetime parameters defined in the virtio spec.
Please note that this is a virtio block specific ioctl, not a block generic one.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
