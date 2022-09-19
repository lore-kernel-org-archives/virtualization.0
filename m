Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A112ECAAD3
	for <virtualization@archiver.kernel.org>; Mon, 19 Sep 2022 17:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62D52416BE;
	Mon, 19 Sep 2022 17:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62D52416BE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ewlo5IFi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vMZz3CCjLnV; Mon, 19 Sep 2022 17:36:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C670409A9;
	Mon, 19 Sep 2022 17:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C670409A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F12A4C0033;
	Mon, 19 Sep 2022 17:36:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23C41C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F206F81451
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:36:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F206F81451
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Ewlo5IFi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NoC_rq0Km_zz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:36:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18F6280894
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18F6280894
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:36:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D966861C16;
 Mon, 19 Sep 2022 17:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C2AC433D6;
 Mon, 19 Sep 2022 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663609003;
 bh=jkG4891B6GGZ69slhjyKEIVhWBcQm0wrOpbVVV9al2I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Ewlo5IFi+88Flt1dhLw8XuNbkGXLKNgaWtJC2D9VSc6zsRz4ZYKdziHPscpKaN4ab
 QjyVNbY/FmT61DQlTP03v4eaqZSD1Y+yCghSA26b8qMgwReuQST8H2rC+DRJRG+Jgb
 mH78puWJ/B7CxX3k4fVZoM9TdF6hu7NNlVpNlkg85uKvmMh8w/JAKM7CL2YcXjLhHK
 nQxM/J1veU7fxTHRU2YLggaomJ+v907QRAJ4SyNATa7BT2pCKlPr4qShEyhdvlE6o6
 6rRrAkVq2r574bbKYGoOuhpS7dAE7CSUojWuVIoNhea0ZKdUsLXfQDOz6xPbRnweRj
 2UjVOAvnqy/xw==
Date: Mon, 19 Sep 2022 12:36:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v2] jailhouse: Hold reference returned from of_find_xxx API
Message-ID: <20220919173641.GA1014673@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0069849b-e6c7-5c9b-4b52-5aa6e4a328e4@csail.mit.edu>
Cc: jgross@suse.com, jailhouse-dev@googlegroups.com, jan.kiszka@siemens.com,
 virtualization@lists.linux-foundation.org, andy.shevchenko@gmail.com,
 robh+dt@kernel.org, wangkelin2023@163.com,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, mark.rutland@arm.com,
 Liang He <windhl@126.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Sep 16, 2022 at 10:25:31PM -0700, Srivatsa S. Bhat wrote:
> [ Adding author and reviewers of commit 63338a38db95 again ]
> 
> On 9/16/22 2:00 AM, Liang He wrote:
> > In jailhouse_paravirt(), we should hold the reference returned from
> > of_find_compatible_node() which has increased the refcount and then
> > call of_node_put() with it when done.
> > 
> > Fixes: 63338a38db95 ("jailhouse: Provide detection for non-x86 systems")
> > Signed-off-by: Liang He <windhl@126.com>
> > Co-developed-by: Kelin Wang <wangkelin2023@163.com>
> > Signed-off-by: Kelin Wang <wangkelin2023@163.com>
> 
> Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

The message to which you are responding didn't make it to the mailing
list, so it's unlikely that anybody will pick it up.  See the archive:
https://lore.kernel.org/all/0069849b-e6c7-5c9b-4b52-5aa6e4a328e4@csail.mit.edu/

Maybe it was a multipart message or was HTML, which the mailing lists
reject: http://vger.kernel.org/majordomo-info.html

Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
