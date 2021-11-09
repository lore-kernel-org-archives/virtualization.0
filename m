Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427BDC433EF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 00:22:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39C36109D
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 00:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A39C36109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6391140274;
	Tue,  9 Nov 2021 00:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRYZ-0VF3Qo5; Tue,  9 Nov 2021 00:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C33A4023B;
	Tue,  9 Nov 2021 00:22:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D473CC0019;
	Tue,  9 Nov 2021 00:22:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D918C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED1BC80DC1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q57wphn-DExS
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:22:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC68B80DB0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 00:22:23 +0000 (UTC)
Received: from c-24-16-8-193.hsd1.wa.comcast.net ([24.16.8.193]
 helo=srivatsab-a02.vmware.com)
 by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.82) (envelope-from <srivatsa@csail.mit.edu>)
 id 1mkEu2-000R2P-5t; Mon, 08 Nov 2021 19:22:18 -0500
To: Joe Perches <joe@perches.com>, jgross@suse.com, x86@kernel.org,
 pv-drivers@vmware.com
References: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
 <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
 <5179a7c097e0bb88f95642a394f53c53e64b66b1.camel@perches.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark VMware mailing list entries as
 private
Message-ID: <cb03ca42-b777-3d1a-5aba-b01cd19efa9a@csail.mit.edu>
Date: Mon, 8 Nov 2021 16:22:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5179a7c097e0bb88f95642a394f53c53e64b66b1.camel@perches.com>
Content-Language: en-US
Cc: amakhalov@vmware.com, Ronak Doshi <doshir@vmware.com>,
 linux-scsi@vger.kernel.org, anishs@vmware.com,
 Vishal Bhakta <vbhakta@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 linux-rdma@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-graphics-maintainer@vmware.com, linux-input@vger.kernel.org,
 Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
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

+Greg, Thomas

Hi Joe,

On 11/8/21 3:37 PM, Joe Perches wrote:
> On Mon, 2021-11-08 at 12:30 -0800, Srivatsa S. Bhat wrote:
>> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
>>
>> VMware mailing lists in the MAINTAINERS file are private lists meant
>> for VMware-internal review/notification for patches to the respective
>> subsystems. So, in an earlier discussion [1][2], it was recommended to
>> mark them as such. Update all the remaining VMware mailing list
>> references to use that format -- "L: list@address (private)".
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -6134,8 +6134,8 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>>  F:	drivers/gpu/drm/vboxvideo/
>>  
>>  DRM DRIVER FOR VMWARE VIRTUAL GPU
>> -M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
>>  M:	Zack Rusin <zackr@vmware.com>
>> +L:	linux-graphics-maintainer@vmware.com (private)
> 
> This MAINTAINERS file is for _public_ use, marking something
> non-public isn't useful.
> 
> private makes no sense and likely these L: entries shouldn't exist.
> 
> 

Well, the public can send messages to this list, but membership is
restricted.

In many ways, I believe this is similar to x86@kernel.org, which is an
email alias that anyone can post to in order to reach the x86
maintainer community for patch review. I see x86@kernel.org listed as
both L: and M: in the MAINTAINERS file, among different entries.

Although the @vmware list ids refer to VMware-internal mailing lists
as opposed to email aliases, they serve a very similar purpose -- to
inform VMware folks about patches to the relevant subsystems.

Is there a consensus on how such lists should be specified? One
suggestion (from Greg in the email thread referenced above) was to
mark it as private, which is what this patch does. Maybe we can find a
better alternative?

How about specifying such lists using M: (indicating that this address
can be used to reach maintainers), as long as that is not the only M:
entry for a given subsystem (i.e., it includes real people's email id
as well)? I think that would address Greg's primary objection too from
that other thread (related to personal responsibility as maintainers).

Regards,
Srivatsa
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
