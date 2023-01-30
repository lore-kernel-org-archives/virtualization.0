Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EEDC54EED
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 08:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F54381778;
	Mon, 30 Jan 2023 08:20:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F54381778
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZzzvuPo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-raONrFSLHt; Mon, 30 Jan 2023 08:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A609F81497;
	Mon, 30 Jan 2023 08:20:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A609F81497
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88B54C0033;
	Mon, 30 Jan 2023 08:20:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A186C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 08:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2111960DC2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 08:20:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2111960DC2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZzzvuPo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gouPenI0Xr7n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 08:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C0DE6059B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C0DE6059B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675066805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KA9Lw68dRWzicu3l/X+LGVGA8EUuuBIveL8Pc6YjBXM=;
 b=TZzzvuPooJdL4CdMnj/O5qeZN7/A3BVJxUpMS/yHvg1lr7956QSi+DAHFDPeJs3ZUZCKV5
 OFYGbwCOtEOXACgM1/lQk1b/PL9WkZY2LLy8+ZkvxLvZUxEIzxO9vmmIhVykqpjnLj+B0S
 nseHOjnbcEIV895PCdvQlrQ6RA02M0Y=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-364-L94Ed6J3PraiU1N1yhymOw-1; Mon, 30 Jan 2023 03:20:03 -0500
X-MC-Unique: L94Ed6J3PraiU1N1yhymOw-1
Received: by mail-oi1-f199.google.com with SMTP id
 o206-20020acad7d7000000b00375c9d6b919so4381456oig.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 00:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KA9Lw68dRWzicu3l/X+LGVGA8EUuuBIveL8Pc6YjBXM=;
 b=gBlc3v3LPH+1qnqEhbOb6/EP5bjK5li6WyuIsMPiKguQ/Mg5XAfuPJYWZaVMoRG9ou
 NRGWyhI/K26DxpbF3r4KvtbQRqfxQLEufIic1rhHYh0CabKBTMKD0sjd7Au/PX5bkPgP
 76dHKqSjFs2gT69L+l75Lqz3fjSg1fWvnSkqyCyQ/Tv18zPmDoyGAT29QQ1ZrKHlyPou
 t4OYKOw9xlseJU2QtaItePEIErbevb2FfsU0+Tf7mwJ85DEsdvJUekJ81LCOVAuKa55n
 Z4arM61UfJl6NiYBatcN6g++TswFOv8oBO40/qp30PF9W4LxDEwpfmXxVAnHQk+EysT0
 AxIA==
X-Gm-Message-State: AO0yUKV9B1D6JxNHNihQRUvKfJyQmNPVgKoSCWPBzmbkj8X1DhWWi9cA
 6+MDATwKyzVnC4yN0iwyscdJw6SGP/cTXqYTRdc3HzPHD71ShADL4IKfp+yuFM0pMBzcQpyWJwy
 garWaYsN5O0v5vV7Y1ganU0FxDv8ejEXVhMtlcVyel7hG981lHTprxALPBA==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr301707oao.35.1675066802582; 
 Mon, 30 Jan 2023 00:20:02 -0800 (PST)
X-Google-Smtp-Source: AK7set/9ErdoIRMr9bqJMQEjl+qMRL6ffKizdUoBUw3PboDeaxE8AwVvdcoDOIGYB8BspgzDlNRptoFFg8XzqSghoPA=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr301703oao.35.1675066802324; Mon, 30 Jan
 2023 00:20:02 -0800 (PST)
MIME-Version: 1.0
References: <bc4136ed-abe0-dcc2-4dd9-31dcf3d8c179@nvidia.com>
In-Reply-To: <bc4136ed-abe0-dcc2-4dd9-31dcf3d8c179@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Jan 2023 16:19:51 +0800
Message-ID: <CACGkMEuTz4RVf0CA9y7sf7K3N1FbKrD6A=xC6JL7N+hzX5RLjw@mail.gmail.com>
Subject: Re: RFC: VDPA Interrupt vector distribution
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Hi Eli:

On Mon, Jan 23, 2023 at 1:59 PM Eli Cohen <elic@nvidia.com> wrote:
>
> VDPA allows hardware drivers the propagate interrupts from the hardware
> directly to the vCPU used by the guest. In a typical implementation, the
> hardware driver will assign the interrupt vectors to the virtqueues and report
> this information back through the get_vq_irq() callback defined in
> struct vdpa_config_ops.
>
> Interrupt vectors could be a scarce resource and may be limited. For such
> cases, we can opt the administrator, through the vdpa tool, to set the policy
> defining how to distribute the available vectors amongst the data virtqueues.
>
> The following policies are proposed:
>
> 1. First comes first served. Assign a vector to each data virtqueue by the
>     virtqueue index. Virtqueues which could not be assigned a dedicated vector
>     would use the hardware driver to propagate interrupts using the available
>     callback mechanism.
>
>     vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all
>
>     This is the default mode and works even if "int=all" was not specified.
>
> 2. Use round robin distribution so virtqueues could share vectors.
>     vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all intmode=share
>
> 3. Assign vectors to RX virtqueues only.
> 3.1 Do not share vectors
>      vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx
> 3.2 Share vectors
>      vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx intmode=share
>
> 4. Assign vectors to TX virtqueues only. Can share or not, like rx.
> 5. Fail device creation if number of vectors cannot be fulfilled.
>     vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 max_vq_pairs 8 int=rx intnum=8

I wonder:

1) how the administrator can know if there's sufficient resources for
one of the above policies.
2) how does the administrator know which policy is the best assuming
the resources are sufficient? (E.g vectors to RX only or vectors to TX
only)

If it requires a vendor specific way or knowledge, I believe it's
better to code them in:

1) the vDPA parent or
2) underlayer management tool or drivers

Thanks

>
>
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
