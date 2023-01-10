Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA6FC46467
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 17:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E60F400AC;
	Tue, 10 Jan 2023 17:55:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E60F400AC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BSVp/MnD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VYXrxM0LLSLZ; Tue, 10 Jan 2023 17:55:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED5B1402A8;
	Tue, 10 Jan 2023 17:55:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED5B1402A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB05DC0033;
	Tue, 10 Jan 2023 17:55:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B60C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 17:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CE7660DF4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 17:55:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CE7660DF4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=BSVp/MnD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAZ5SmPKDYjg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 17:55:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFBF560A82
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFBF560A82
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 17:55:32 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 819EC61866;
 Tue, 10 Jan 2023 17:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487DC433D2;
 Tue, 10 Jan 2023 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673373330;
 bh=T+mZoOtNJWgx0Awh9KhMOV3tHjuU8TCQCS00NAQ7V5I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=BSVp/MnDHnTlaIdi5NaFd3DAt4mB1YztUBEgTNSfp5fLXtuR97Dz4Qk5JgAETwvIO
 sBOrxzZ7FpYzzD3Uu/maNeEb/qHn6OT3/4vHD5/aSmWaA3VuDpOhpGWLwlqKjfGf2x
 i/qXs2PACKyTa/nK+6RNiR0sz0QKqnludFTv0JElmUiqZWYetIAVvsuBNxeubUj38w
 iXHXqxPrjAN5w4e+qEhg8uUNoFBxz2RzJqCt8PS2oOslgYHm/LFIW8aGhISi9jdhzR
 XnN1TDpTevxEJ3HYjYxD2nfSZ6SEqd929xxqcChCWx6lq2rc2I+x/SpEx7QBd2z0c+
 w9N+Qvh+8Eb5w==
Date: Tue, 10 Jan 2023 11:55:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v9 0/3] virtio: vdpa: new SolidNET DPU driver
Message-ID: <20230110175528.GA1589047@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
Cc: linux-pci@vger.kernel.org, mst@redhat.com,
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

On Tue, Jan 10, 2023 at 06:56:35PM +0200, Alvaro Karsz wrote:
> This series adds a vDPA driver for SolidNET DPU.
> ...

> v9:
> 	- Indent PCI id in pci_ids.h with tabs - Patch 1.
> 	- Wrap patch comment log to fill 75 columns - Patch 1 + 2.

Beautiful, nice threading, thanks! :)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
