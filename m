Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0360EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 19:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992CF82890;
	Tue, 25 Jan 2022 19:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qr8bFQg0z0dd; Tue, 25 Jan 2022 19:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 526A5827DE;
	Tue, 25 Jan 2022 19:36:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3145CC0039;
	Tue, 25 Jan 2022 19:36:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6101C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEE05827F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:36:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ch-UGt02ddzx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:36:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04729827DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643139377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTQ4mdS7TZuENfBoyB8K2lauO/+f3s/CNFZ8+QrcxlM=;
 b=GRksaFgreFxQ4ldXPx0AXPI4LPwIobDNaYiHAUvszoTVs8KC2PXLn3k/aOSrGlDHc34z/C
 I2Q/jRzqEGWZHVfBMO64m8M/0wgL7llI/pEc+4H/oCcoJiTQ/S8NKcszJdGGfX85gM8VJm
 YbGqVJiPDlqNXDS/4nB/GHE1Y1QuQMg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-PGy3pm6POCG-Xjro6gyYsw-1; Tue, 25 Jan 2022 14:36:16 -0500
X-MC-Unique: PGy3pm6POCG-Xjro6gyYsw-1
Received: by mail-ej1-f71.google.com with SMTP id
 rl11-20020a170907216b00b006b73a611c1aso3177643ejb.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OTQ4mdS7TZuENfBoyB8K2lauO/+f3s/CNFZ8+QrcxlM=;
 b=dPhwHdxakBaBZmk1iGR+plcnLUaDkQSHKW3g0UEqlqDwwQziUWDnqVymr0TDswRyNx
 gkkNL+mHVnjz6ML9aFLSqgstMQ5cuvtNCzc3C5lwLz9sQzzdKffveXQBDxpSHPxHNnt3
 nEWlEOB3TrNkl6Q4Tx+K8csPc4DB3ZCtywmXESi2xJ3ZIoeO9hSoqMhAKm3XEVdHFGwF
 PKx6suayHMMYeghUMPGwGs9GrTMmeS4/tpUHlngBq6WR8B1osGGhWN6I++zBBsz8s/+u
 IDHLjHB70XKbQNPbByJHQKHaOSlvyk0bWvmfB4ETpANS65ZNivj2vXtF/gOvbve+2e4V
 p5fg==
X-Gm-Message-State: AOAM531Ffxs2jlLm9YcW6TkLx4MMmQoMxrAeKBng+WY4BwM8iLR/RESW
 LMO42bSwf8FLydDCntUQuWdlqX5g+dHKdQP9l3v+s+wual+IZKCxJWUdwMPlusz1NGo70Q1/V/s
 fLt0YojS6f+QeGLREc87C/GhdxDwE4ZWaMWXbN9lF5g==
X-Received: by 2002:a05:6402:2994:: with SMTP id
 eq20mr21736136edb.281.1643139374856; 
 Tue, 25 Jan 2022 11:36:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlVE9Pz77RC+rOZa7S9uRx5aXKFXFEbpDJMUq2Xe969xw3jJJ0tHzapo3icoqzMKN2HqeMfA==
X-Received: by 2002:a05:6402:2994:: with SMTP id
 eq20mr21736119edb.281.1643139374622; 
 Tue, 25 Jan 2022 11:36:14 -0800 (PST)
Received: from redhat.com ([176.12.185.204])
 by smtp.gmail.com with ESMTPSA id qw3sm6602956ejc.128.2022.01.25.11.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 11:36:14 -0800 (PST)
Date: Tue, 25 Jan 2022 14:36:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 2/4] vDPA/ifcvf: implement device MSIX vector allocator
Message-ID: <20220125143254-mutt-send-email-mst@kernel.org>
References: <20220125091744.115996-1-lingshan.zhu@intel.com>
 <20220125091744.115996-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220125091744.115996-3-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Jan 25, 2022 at 05:17:42PM +0800, Zhu Lingshan wrote:
> This commit implements a MSIX vector allocation helper
> for vqs and config interrupts.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index d1a6b5ab543c..7e2af2d2aaf5 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -58,14 +58,40 @@ static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
>  	ifcvf_free_irq_vectors(pdev);
>  }
>  
> +static int ifcvf_alloc_vectors(struct ifcvf_adapter *adapter)


So the helper returns an int...

> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct ifcvf_hw *vf = &adapter->vf;
> +	u16 max_intr, ret;
> +
> +	/* all queues and config interrupt  */
> +	max_intr = vf->nr_vring + 1;
> +	ret = pci_alloc_irq_vectors(pdev, 1, max_intr, PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
> +
> +	if (ret < 0) {
> +		IFCVF_ERR(pdev, "Failed to alloc IRQ vectors\n");
> +		return ret;


which is negative on error...

> +	}
> +
> +	if (ret < max_intr)
> +		IFCVF_INFO(pdev,
> +			   "Requested %u vectors, however only %u allocated, lower performance\n",
> +			   max_intr, ret);
> +
> +	return ret;
> +}
> +
>  static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
>  {
>  	struct pci_dev *pdev = adapter->pdev;
>  	struct ifcvf_hw *vf = &adapter->vf;
>  	int vector, i, ret, irq;
> -	u16 max_intr;
> +	u16 nvectors, max_intr;
> +
> +	nvectors = ifcvf_alloc_vectors(adapter);

which you proceed to stash into an unsigned int ...

> +	if (!(nvectors > 0))

and then compare to zero ...

> +		return nvectors;
>

correct error handling is unlikely as a result.

  
> -	/* all queues and config interrupt  */
>  	max_intr = vf->nr_vring + 1;
>  
>  	ret = pci_alloc_irq_vectors(pdev, max_intr,


As long as you are introducing a helper, document it's return
type and behaviour and then use correctly.

> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
