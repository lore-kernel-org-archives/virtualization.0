Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE1CCDB474
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 15:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8C7581076;
	Tue, 17 Oct 2023 15:19:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8C7581076
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZvH2tZt9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGxRPOmWveKE; Tue, 17 Oct 2023 15:19:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E20CB8101B;
	Tue, 17 Oct 2023 15:19:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E20CB8101B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB7A9C0072;
	Tue, 17 Oct 2023 15:19:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB45EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 874A74015E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:19:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 874A74015E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZvH2tZt9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OsqztEFpKaR8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:19:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AF974014D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:19:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AF974014D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697555993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=hEljbdfa7bD86OhYFUOYvSGcltkQSYot0oEUAqeyQEA=;
 b=ZvH2tZt9JP3v4Acs3htUkhFvbGDpoLm0TB9LwzVeSEwmlhAqAjQe/lsOCBJnU7LPQHQlXu
 XMIaHNO95VIoQeWFvtJM5C3ieWifDsRXfyeZJK9pJ+HuY8GfxA+263pz261pA6WtQaqzQD
 I7oBqND/XRAezLvKV7VP5doNLhxt6Kw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-tp8jGGaMNuGi1C2yfzjZBA-1; Tue, 17 Oct 2023 11:19:36 -0400
X-MC-Unique: tp8jGGaMNuGi1C2yfzjZBA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6c22d8a0cecso8320961a34.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 08:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697555976; x=1698160776;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hEljbdfa7bD86OhYFUOYvSGcltkQSYot0oEUAqeyQEA=;
 b=uJAcP9bqzfoAvL6nkdwqC2EQ404am/fISYPxFVZwsREJ/CT7TbDKpQATxV/zoaKm+R
 DSv45GSH6/Zw/qylBcSnzg9X54cVHjYE+0MKTImu2X2slRE7ITC6ml9jMrQUOKs6k1ti
 Xb6Tckj1Dp9OfJbFHIEemq57qF+DXC/HGS/nfhfQDO+fTFHuxMJjiWZcR0PKNERIeSFR
 PznG/J6f120uFld9jsBz+wUGgfSZHpqpZ00oIEN+HJ/I7A1bxnHQmZ8KZY9K2SeTOQXw
 y0qPLdEkG+/mph5OQK/mnddleJ+UKB1D1oCFQieDVwGqOJd/fRzURR6Xzwc2KRLBAxi+
 wcUA==
X-Gm-Message-State: AOJu0YyMPbPNBoxH9Y8e3Qm360pm2uzjCYdVWgLBvD/ry1C7v4pqZb+/
 CvH7UXNcT1sD489RuG7gnq8U3Mq1zeZkDzOSC5uqicV6NsAzlEugh9/3dRYVhdWuXizZl++q+3b
 9Kn1m3dh8C0cJ9kUut/T7pqHM+YRZibqbcZlx4x+iePTaTkomkt4+7QLDAiD9feY06w2MFIXcg7
 12MOhrY9yDRHO2v2EjiJGq7h9Tuwk5
X-Received: by 2002:a05:6830:3d18:b0:6b9:9cc0:537f with SMTP id
 eu24-20020a0568303d1800b006b99cc0537fmr2449355otb.33.1697555975738; 
 Tue, 17 Oct 2023 08:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHygDzbf4FkOeZ5yzPHHp7dRoGWcri/Y9cHl/OSOwJOx3WBZoAenk49HB/I4yIkDgS7/InpTA==
X-Received: by 2002:a05:6830:3d18:b0:6b9:9cc0:537f with SMTP id
 eu24-20020a0568303d1800b006b99cc0537fmr2449321otb.33.1697555975333; 
 Tue, 17 Oct 2023 08:19:35 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 e4-20020ac80644000000b00419b9b1b0b0sm693137qth.56.2023.10.17.08.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:19:34 -0700 (PDT)
Date: Tue, 17 Oct 2023 17:19:31 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: virtio-sound: release control request clarification
Message-ID: <ZS6mA6/EsmvDVlTC@fedora>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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

Hello,

This email is to clarify the VirtIO specification regarding the RELEASE
control request. Section 5.14.6.6.5.1 [1] states the following device
requirements for the RELEASE control request: 
1. The device MUST complete all pending I/O messages for the specified
stream ID.
2. The device MUST NOT complete the control request while there are
pending I/O messages for the specified stream ID.

The 1) requirement does not indicate what "complete" means. Does it mean
that the pending I/O messages in the tx queue shall be outputted in the
host, i.e., consumed by the audio backend? Or, completion means simply
to put the requests in the used-ring without consuming them?

Regarding 2), I interpret it as "the device shall wait until all I/O
messages are proceeded to complete the RELEASE control request".

Currently, the kernel driver seems not expecting such a delay when the
RELEASE command is sent. If I understand correctly, the kernel driver
first sends the RELEASE command and waits a fixed amount of time until
the device can process it. Then, the driver waits a fixed amount of time
until all pending IO messages are completed. If the device follows the
specification and waits until all messages IO are completed to issue the
completion of the RELEASE command, the kernel driver may timeout. The
time to complete N IO messages in the TX queue could be proportional
with the number of pending messages.

In our device implementation [2], RELEASE is handled as follows:
- Drop all messages in the TX queue without outputting in the host.
- Complete the RELEASE control request.

This seems to be working, however, I can observe that sometimes there
are still requests in the TX queue when we get RELEASE. Those requests
are never reproduced in the host.

My questions are:
- In the specification, should we modify it to clarify that all pending
  IO messages in the device are discarded during RELEASE, that is, not
  output to the host, but signaled to the guest as completed?
- According to the specification, should the driver wait in RELEASE an
  amount of time proportional to the number of periods yet to be
  reproduced?

Thanks, Matias.

[1]
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
[2]
https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-sound

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
