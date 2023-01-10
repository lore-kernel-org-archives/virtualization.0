Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B82C54EBC
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 15:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C755A40B68;
	Tue, 10 Jan 2023 15:34:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C755A40B68
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jscmkisD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2AvZsDmKe7My; Tue, 10 Jan 2023 15:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B5D540B58;
	Tue, 10 Jan 2023 15:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B5D540B58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29C80C0033;
	Tue, 10 Jan 2023 15:34:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E6C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24E3340B58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:34:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24E3340B58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ltDaQjIU69-r
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:34:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45A9A40B68
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45A9A40B68
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 15:34:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0EAF86178A;
 Tue, 10 Jan 2023 15:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD1C433D2;
 Tue, 10 Jan 2023 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673364876;
 bh=6eMAM8CalZFNY38f3ldCsno9tHpWRfBLPgZ1YfpCMmo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=jscmkisDJxTebLylCVCm1Pb4G3WCpEwNFs8001RP3PCeo1eOo8bYHl2kVPjDjD7+l
 E5UXDQzwEdvYgZW6lXCJ5NSEDySgm2/FNsfYFwue2rMyslfKibqYdQ+gGr1EQhSRLd
 7RHjUf/O0ig8Fu9oF9evoswPGvrt+W9o99Kwa+x6qjBEGgmSqFf5YcUoTU4qwpUJSw
 3XYaJX5Vp6sVMnD2u61ZGVBqywHNQ02MfZvayXLNwolWaAeLrpZtU5n7NcfyaZVCHA
 az16CVt3ezyajpt8LDI8WAvzEo129fVERifXJYTZiENrHQ/BsJUTEhNI2WaxAWdvoo
 wGCYV5JcgOf9A==
Date: Tue, 10 Jan 2023 09:34:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
Message-ID: <20230110153434.GA1505598@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230109080453.1155113-1-alvaro.karsz@solid-run.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Jan 09, 2023 at 10:04:53AM +0200, Alvaro Karsz wrote:
> Add SolidRun vendor ID to pci_ids.h
> 
> The vendor ID is used in 2 different source files,
> the SNET vDPA driver and PCI quirks.

Nits: wrap to fill 75 columns.

> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b..9a3102e61db 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3092,6 +3092,8 @@
> 
>  #define PCI_VENDOR_ID_3COM_2		0xa727
> 
> +#define PCI_VENDOR_ID_SOLIDRUN          0xd063

This should be indented with tabs instead of spaces so it matches the
rest of the file.

It's helpful if you can send the patches in a series so the individual
patches are replies to the cover letter.  That makes tools and
archives work better:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.1#n342
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
