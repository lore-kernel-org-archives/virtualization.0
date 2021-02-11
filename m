Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA1FC433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 16:40:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02DC64DE7
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 16:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02DC64DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8188886E4C;
	Thu, 11 Feb 2021 16:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TcIR9fyMlqqa; Thu, 11 Feb 2021 16:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FD2186DCD;
	Thu, 11 Feb 2021 16:40:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1CD4C0891;
	Thu, 11 Feb 2021 16:40:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 094DDC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 043E086E4C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:40:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KqGa4Izc-EDm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:40:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 620E186DCD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613061615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lj9y6zovpDL1H8VNnAnIwnGuHO/lQ5y0uBDzrMSzgjs=;
 b=jKSheiiPtaEzCA5W4pdxVMoBtkvVzCD7ulB+LrvQuoo6DcKM3M08OIc1UvTFGsEmQau61C
 4U9tPafks+enGWMerhGjDy5odWSvSyWMkrorcyyUoRkcl4DmfeVJSUB2IFvGBGGfI0pNS4
 nw9xtKESDdG8ZlImcX9rMm3rg5F873A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-hU6eXmKVPWqnoYmkRbE23g-1; Thu, 11 Feb 2021 11:40:12 -0500
X-MC-Unique: hU6eXmKVPWqnoYmkRbE23g-1
Received: by mail-ed1-f69.google.com with SMTP id g2so4864178edq.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 08:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Lj9y6zovpDL1H8VNnAnIwnGuHO/lQ5y0uBDzrMSzgjs=;
 b=ccJ1RjEPuDoI64Klf6timk9VxQ3bbss6iGf+F46KB/TqdfC+I75ynjNLI/XdyIrtgm
 uEaAKOsQdFilEP/pMs3crJoRE/oxYszrQJ9vCcadNZu6M5IYpN5iLemQ1fOYhCVsk5Uf
 vndzoui9RDWCODDSbaF9vNrBO2wu2H1pwPpdW9kdLPs3btQP1xu7CwdgKbKsPsZZFzgR
 1deOuYz+UUvlnL+5QBxuF41PTgWJiJDpWZTOLP5TFfovhcBapR1qeW7+cgcaRzdd3BuL
 LplZrg3UgzTJV1ND5LnL3tck0HuQIxsEYeOPpwM4QQcjHpMguvEqZFD6ze4kVr8uuzHW
 e7dA==
X-Gm-Message-State: AOAM530R2GVBU1LehOel/hobeuwRQmrzKHkFub2KvRtc72ISs7k3s6Bx
 Eik6JnYGs8Qzu+y9wk4ea5gRlE3rOdB5zTHLjwnHeBPVxp+QZeiFH1x5HdQiGSmMG5iAGO2l6z3
 OEPUIIJ0W+7yj/fJG3FrqKBKBquJoGntg7zsfajQyeQ==
X-Received: by 2002:a05:6402:22f6:: with SMTP id
 dn22mr8965269edb.277.1613061611042; 
 Thu, 11 Feb 2021 08:40:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAvYu/wVmfgYAjypXKzDwvmJHlNwAAXIJAYLYHGgD2uuy7YNz2HDw2FUtZ6+pr3Mn3BQ537g==
X-Received: by 2002:a05:6402:22f6:: with SMTP id
 dn22mr8965246edb.277.1613061610877; 
 Thu, 11 Feb 2021 08:40:10 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id b6sm4415609edy.31.2021.02.11.08.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 08:40:10 -0800 (PST)
Date: Thu, 11 Feb 2021 17:40:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v2 1/7] vhost: Delete trailing dot in errpr_setg argument
Message-ID: <20210211164007.r6mtlu4dz64gpn2q@steredhat>
References: <20210209153757.1653598-1-eperezma@redhat.com>
 <20210209153757.1653598-2-eperezma@redhat.com>
 <14b2637e-9610-356e-ad18-27a9a8b82508@redhat.com>
 <CAJaqyWd+NuY3B94HX8J_EzFf4sxeZnFCcw=aXfT-KZ7nfmL6DQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd+NuY3B94HX8J_EzFf4sxeZnFCcw=aXfT-KZ7nfmL6DQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Harpreet Singh Anand <hanand@xilinx.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>, Rob Miller <rob.miller@broadcom.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 09, 2021 at 07:11:41PM +0100, Eugenio Perez Martin wrote:
>On Tue, Feb 9, 2021 at 5:25 PM Eric Blake <eblake@redhat.com> wrote:
>>
>> On 2/9/21 9:37 AM, Eugenio P=E9rez wrote:
>> > As error_setg points
>>
>> Incomplete sentence?
>>
>> Missing Signed-off-by.
>>
>
>Sorry, I should have paid more attention.
>
>Maybe it is better to send this though qemu-trivial, so it does not
>mess with this series?

Yes, I agree that it can go regardless of this series.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
