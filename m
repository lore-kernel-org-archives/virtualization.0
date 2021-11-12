Return-Path: <SRS0=b7zo=P7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF8C433FE
	for <virtualization@archiver.kernel.org>; Fri, 12 Nov 2021 17:50:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF14361029
	for <virtualization@archiver.kernel.org>; Fri, 12 Nov 2021 17:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF14361029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 758CE405F3;
	Fri, 12 Nov 2021 17:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIfO6rAcmDsz; Fri, 12 Nov 2021 17:50:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 314A1405EB;
	Fri, 12 Nov 2021 17:50:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 035E7C001E;
	Fri, 12 Nov 2021 17:50:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52142C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 17:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DCC1826B4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 17:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LhyFirk4R55t
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 17:50:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68D8F82553
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 17:50:51 +0000 (UTC)
Received: from c-24-16-8-193.hsd1.wa.comcast.net ([24.16.8.193]
 helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1mlahI-0006py-1E; Fri, 12 Nov 2021 12:50:44 -0500
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Mark VMware mailing list entries as
 email aliases
To: Jakub Kicinski <kuba@kernel.org>, Joe Perches <joe@perches.com>
References: <163657479269.84207.13658789048079672839.stgit@srivatsa-dev>
 <163657493334.84207.11063282485812745766.stgit@srivatsa-dev>
 <20211110173935.45a9f495@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d7f3fec79287a149d6edc828583a771c84646b42.camel@perches.com>
 <20211111055554.4f257fd2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <fd9df647-4c1a-b4fb-159b-4876bc5cd0b6@csail.mit.edu>
Date: Fri, 12 Nov 2021 09:50:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211111055554.4f257fd2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Language: en-US
Cc: Ronak Doshi <doshir@vmware.com>, pv-drivers@vmware.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Nadav Amit <namit@vmware.com>, amakhalov@vmware.com,
 linux-scsi@vger.kernel.org, Vishal Bhakta <vbhakta@vmware.com>, x86@kernel.org,
 linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org,
 rostedt@goodmis.org, keerthanak@vmware.com, jgross@suse.com, anishs@vmware.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Zack Rusin <zackr@vmware.com>
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


[ Resending since my previous reply didn't reach the mailing lists. ]

On 11/11/21 5:55 AM, Jakub Kicinski wrote:
> On Wed, 10 Nov 2021 21:19:53 -0800 Joe Perches wrote:
>> On Wed, 2021-11-10 at 17:39 -0800, Jakub Kicinski wrote:
>>> On Wed, 10 Nov 2021 12:09:06 -0800 Srivatsa S. Bhat wrote:  
>>>>  DRM DRIVER FOR VMWARE VIRTUAL GPU
>>>> -M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
>>>>  M:	Zack Rusin <zackr@vmware.com>
>>>> +R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
>>>>  L:	dri-devel@lists.freedesktop.org
>>>>  S:	Supported
>>>>  T:	git git://anongit.freedesktop.org/drm/drm-misc  
>>>
>>> It'd be preferable for these corporate entries to be marked or
>>> otherwise distinguishable so that we can ignore them when we try 
>>> to purge MAINTAINERS from developers who stopped participating.
>>>
>>> These addresses will never show up in a commit tag which is normally
>>> sign of inactivity.  
>>
>> Funny.
>>
>> The link below is from over 5 years ago.
>>
>> https://lore.kernel.org/lkml/1472081625.3746.217.camel@perches.com/
>>
>> Almost all of those entries are still in MAINTAINERS.
>>
>> I think the concept of purging is a non-issue.
> 
> I cleaned networking in January and intend to do it again in 2 months.
> See:
> 
> 054c4610bd05 MAINTAINERS: dccp: move Gerrit Renker to CREDITS
> 4f3786e01194 MAINTAINERS: ipvs: move Wensong Zhang to CREDITS
> 0e4ed0b62b5a MAINTAINERS: tls: move Aviad to CREDITS
> c41efbf2ad56 MAINTAINERS: ena: remove Zorik Machulsky from reviewers
> 5e62d124f75a MAINTAINERS: vrf: move Shrijeet to CREDITS
> 09cd3f4683a9 MAINTAINERS: net: move Alexey Kuznetsov to CREDITS
> 93089de91e85 MAINTAINERS: altx: move Jay Cliburn to CREDITS
> 8b0f64b113d6 MAINTAINERS: remove names from mailing list maintainers
> 
I'm assuming the purging is not totally automated, is it? As long as
the entries are informative to a human reader, it should be possible
to skip the relevant ones when purging inactive entries.

I believe this patch makes the situation better than it is currently
(at least for the human reader), by marking lists without public
read-access in a format that is more appropriate. In the future, we
could perhaps improve on it to ease automation too, but for now I
think it is worthwhile to merge this change (unless there are strong
objections or better alternatives that everyone agrees on).

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
