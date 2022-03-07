Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617ACC433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 17:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D926F4032B;
	Mon,  7 Mar 2022 17:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3iOTUoRybaV; Mon,  7 Mar 2022 17:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4143F4000B;
	Mon,  7 Mar 2022 17:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC93C001D;
	Mon,  7 Mar 2022 17:41:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17E2BC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 17:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED3E881772
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 17:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZHIVQVjEFt-F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 17:41:19 +0000 (UTC)
X-Greylist: delayed 00:34:38 by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CBAC813F2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 17:41:19 +0000 (UTC)
Received: from [117.192.122.233] (helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1nRGog-000Ti1-FU; Mon, 07 Mar 2022 12:06:38 -0500
To: jgross@suse.com, x86@kernel.org, pv-drivers@vmware.com,
 tglx@linutronix.de, bp@alien8.de
References: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v5 0/3] Update VMware maintainer entries
Message-ID: <b0a49148-de03-a591-0849-6bb7d8e8b659@csail.mit.edu>
Date: Mon, 7 Mar 2022 22:36:23 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
Content-Language: en-US
Cc: keerthanak@vmware.com, Ronak Doshi <doshir@vmware.com>, anishs@vmware.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 linux-scsi@vger.kernel.org, Vishal Bhakta <vbhakta@vmware.com>,
 Nadav Amit <namit@vmware.com>, kuba@kernel.org,
 Alexey Makhalov <amakhalov@vmware.com>, Joe Perches <joe@perches.com>,
 linux-graphics-maintainer@vmware.com, rostedt@goodmis.org,
 Zack Rusin <zackr@vmware.com>
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

[+virtualization list, which I forgot to CC when posting v5]

Hi Thomas, other x86 maintainers,

On 2/25/22 2:23 PM, Srivatsa S. Bhat wrote:
> This series updates a few maintainer entries for VMware-maintained
> subsystems and cleans up references to VMware's private mailing lists
> to make it clear that they are effectively email-aliases to reach out
> to reviewers.
> 

Since this patchset got ACKs from the relevant subsystem maintainers,
would you mind taking them through your tree, if this looks good to
you too?

Thank you!

Regards,
Srivatsa

> Changes from v4->v5:
> - Add Alexey as reviewer for paravirt ops.
> 
> Changes from v3->v4:
> - Remove Cc: stable@vger.kernel.org from patches 1 and 2.
> 
> Changes from v1->v3:
> - Add Zack as the named maintainer for vmmouse driver
> - Use R: to denote email-aliases for VMware reviewers
> 
> Regards,
> Srivatsa
> VMware Photon OS
> 
> ---
> 
> Srivatsa S. Bhat (VMware) (3):
>       MAINTAINERS: Update maintainers for paravirt ops and VMware hypervisor interface
>       MAINTAINERS: Add Zack as maintainer of vmmouse driver
>       MAINTAINERS: Mark VMware mailing list entries as email aliases
> 
> 
>  MAINTAINERS | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
