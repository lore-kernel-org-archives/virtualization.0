Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63741C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 06:12:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52DA64E39
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 06:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52DA64E39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5ADE9871EA;
	Fri, 12 Feb 2021 06:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EK7tya1XvW0B; Fri, 12 Feb 2021 06:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B723870E4;
	Fri, 12 Feb 2021 06:12:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 282BCC0174;
	Fri, 12 Feb 2021 06:12:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DE75C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 06:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0A70F8739A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 06:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5Fi66SynkXO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 06:11:59 +0000 (UTC)
X-Greylist: delayed 00:07:13 by SQLgrey-1.7.6
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DD86786E88
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 06:11:58 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id d20so8901368oiw.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 22:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ZAsXGnD/IPYGUh3fkPvAiqOcg7TxjgzYyV7b3xOnCI8=;
 b=Eny9ah6mu43hCbH5zOESRdhNDzyxEGZpTRgNdJZ8hdfzAQcVm3OeUj65Ae6YE5Cpw+
 zU2/5QYZ8iTK6Qx5TOlxY0H3ChETOR0NMQWgLIiy8qs2CCG8PGPFy/uewantnjO2u6s+
 We9/OMwmISNrbLeUkv0VFXpMQoSkAxPIcJ0mD7dqRDBB6s7kpy3M/WI6g89RHWmftPGL
 LJBFSJ2q2HS4XS2tXt5Btibr1FbgBFqrOBYzs5Dcpcc2Cp5p4qWgeQ0Ni9xZZwT8aWzc
 PVhLonMtw9v4QfWGBwuZ3f71MYgDuFFcN8T4Rv3INjzmbEE9F+BM5zJV0XwWZ9N21ZTh
 cs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ZAsXGnD/IPYGUh3fkPvAiqOcg7TxjgzYyV7b3xOnCI8=;
 b=NYN4bDo01RgElzU9Kv561+oijAQlcia8MbBs2YPD10/W2iV+JMpW61JQ861B1WXpMK
 4KaettGFObJdLgW4udR+BvgyZcF7eAnI1dvoYzpNHGuo/WyMNdMAbOPXw8QEqZs45rkx
 KwrQpXm9Vncy6RCp64a2cbpTH1EkvFIw14JBAGor0JC31NPhEznyzHU+/s1AD2L2ATz8
 jTJ5kAztu6puRDThvlWC/Xl0JVja1dx2bqcYHcbaQO+7eo3JbO2mwqBVLZDbjNwKy1vP
 Bvri2o4cIiH9mAoYP5kf99nG0OGI5ECwOVg8EQIdIWYcu/ROMezLCuZFbx0ffnfa5Ch9
 gwgw==
X-Gm-Message-State: AOAM531znwGWdPJwY+PjfdfCnq68d2B0UmyGBSbBUX+kvKP8C5bVGqmc
 UK1WkY/9cSsfLRMBfYrCBWB0IbPZWeQqas79cJGcvHJAjlenoJOn
X-Google-Smtp-Source: ABdhPJyh5AMuVPTNKskLRUSza1BgdRtvZH7kGC6QIC7VBrsDlG5LlddfcXl5tHSBNSDPyYo6+VX3BSbb/5F3B4Pb45M=
X-Received: by 2002:aca:4a4c:: with SMTP id x73mr865989oia.97.1613109884483;
 Thu, 11 Feb 2021 22:04:44 -0800 (PST)
MIME-Version: 1.0
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 11 Feb 2021 22:04:34 -0800
Message-ID: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
Subject: vsock virtio: questions about supporting DGRAM type
To: virtualization@lists.linux-foundation.org, asias@redhat.com, 
 imbrenda@linux.vnet.ibm.com, stefanha@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com
Cc: xieyongji@bytedance.com, cong.wang@bytedance.com,
 Xiongchun Duan <duanxiongchun@bytedance.com>
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

I am working on supporting DGRAM type for virtio/vhost vsock. I
already did some work and a draft code is here (which passed my tests,
but still need some cleanup and only works from host to guest as of
now, will add host to guest soon):
https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
qemu changes are here:
https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb

Today, I just noticed that the Asias had an old version of virtio
which had both dgram and stream support, see this link:
https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1

But somehow, the dgram part seems never merged to upstream linux (the
stream part is merged). If so, does anyone know what is the reason for
this? Did we drop dgram support for some specific reason or the code
needs some improvement?

My current code differs from Asias' code in some ways. It does not use
credit and does not support fragmentation.  It basically adds two virt
queues and re-uses the existing functions for tx and rx ( there is
somewhat duplicate code for now, but I will try to make common
functions to reduce it). If we still want to support dgram in upstream
linux, which way do you guys recommend? If necessary, I can try to
base on Asias' old code and continue working on it. If there is
anything unclear, just let me know. Thanks.

Regards,

Jiang
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
