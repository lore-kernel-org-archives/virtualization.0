Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4FCC433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 15:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8C0560E7E;
	Sun, 12 Dec 2021 15:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sf_w3-NzBpeg; Sun, 12 Dec 2021 15:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7BB9560A8E;
	Sun, 12 Dec 2021 15:03:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B34AC001E;
	Sun, 12 Dec 2021 15:03:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60A64C0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 15:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 388CA410B7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 15:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtWvM3sjSHe9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 15:03:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B99B410AB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 15:03:13 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 np6-20020a17090b4c4600b001a90b011e06so11329362pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ndCqA56yDPdk4/U5zH+4CHcCyXDgYIZ2oi0MLXCjqSE=;
 b=lhO3UYFyJKrqzq5HPDfc+PFbsq6QQfW7AmBNbExvbtFXlq0wrjQecG2WRqAzp6e4AG
 dLqR+L0MONeWmNZKrCWbmSw7KsFBqjQk0a6JStD9bDnpx6T5Rf298y84DqrtyoiNln+j
 /nxi0T904eMzGulj/yucVxrxufrXlv7SPyx3OB+4L7NQnQPGsSQQIeP+cWrzCOBXdsdB
 9uR0OqjTM+0xenAf71ShyHD6/tIbAIQM7rMQSqR1TDFxRmDysjPBgtFNyHL48igzxdl/
 aA0JNL1H+gyAVZzrzpbutn6XyR9YQkl5t8TYUpejKIAviNSqCIACT31/viHV0LOGrf3g
 xFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ndCqA56yDPdk4/U5zH+4CHcCyXDgYIZ2oi0MLXCjqSE=;
 b=inka1AsLlo7lKwnvGqRxjsWBD7QJH4/tDs7vFlEMJbAZXf/+QZwXJqrHb5Or/rHS4y
 YkgaO6IhWb/mr1CzPR0VQGLyIzHE8j+14WDF2iXfkdVEQi4L5syJe58KMkADyhjU5ni0
 flvCSPW1WugcSw6fJMZGunHaaokCljElUp4fJQEjvJuWQBkOUqUTqr2YmjMplgIziCxk
 rdej5ZwzzDtDcbS2jXIO1vOqMeo0pG/QafkU8bScgbJnyGN1easm9kRgYKiokF7Ovemz
 sbIO7bsDUgTIJOzSWcPilt9FHWRfHQH7jWAbp6WTI/Y01DiS3WLNACYmvxk82eyPfKRd
 5mTQ==
X-Gm-Message-State: AOAM533151LzCEHhY+rv4Skekq717byZb+YPaL0EN9gKd0ZV4Fb5NbZ2
 8dIW40fbZtrhNG1YwLM3pdD5Tis2luaFipcPY7HDbQ==
X-Google-Smtp-Source: ABdhPJzM6ThjE9fb1jBuOnaTRvStJ0J72a1wwy0FvBkYR9v9S0zmF+mqndMBqw+OLDevQiB5qKGoueX9OBCB41euCZc=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr89560721plt.89.1639321392929; Sun, 12
 Dec 2021 07:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-6-hch@lst.de>
In-Reply-To: <20211209063828.18944-6-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 12 Dec 2021 07:03:02 -0800
Message-ID: <CAPcyv4gYXqbNRLkM4zJUq=sZuw4h_T+BSTXmESXc8juiWijKbQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 device-mapper development <dm-devel@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Wed, Dec 8, 2021 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> While using the MC-safe copy routines is rather pointless on a virtual device
> like virtiofs, it also isn't harmful at all.  So just use _copy_mc_to_iter
> unconditionally to simplify the code.

From a correctness perspective, yes, but from a performance perspective, see:

enable_copy_mc_fragile()

...on those platforms fast-string copy implementation is replaced with
a manual unrolled copy. So this will cause a performance regression on
those platforms.

How about let's keep this as is / still only use it for PMEM where end
users are already dealing with the performance difference across
platforms? I considered exporting an indicator of which backend
routine has been selected from arch/x86/lib/copy_mc.c, but it got
messy quickly so I fell back to just keeping the status quo.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
