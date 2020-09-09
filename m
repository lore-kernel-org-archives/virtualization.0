Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3021C43461
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 05:54:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386342166E
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 05:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up3DXdI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386342166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E353C87389;
	Wed,  9 Sep 2020 05:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bg8OfwypfRqx; Wed,  9 Sep 2020 05:54:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 36C6F81E4A;
	Wed,  9 Sep 2020 05:54:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1856BC0859;
	Wed,  9 Sep 2020 05:54:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3642CC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 19AB086E44
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zoKVkhyBzk5y
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:54:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E8E1E86E41
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:54:06 +0000 (UTC)
Received: from localhost (unknown [172.98.75.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC8532166E;
 Wed,  9 Sep 2020 05:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599630846;
 bh=pbyS4ZMWYMUKwmpi3BhxrHHLzLjXuJLnUN/DArAAcCk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Up3DXdI8JG6lYgGcC0tVjYoVSP1nLZyG6no0UVGh0mcYcuP7bLalh/ZHMcaxkd8ZT
 4hKkD4LUFJoxQFZYfY0KmG9+m5OcFoTb6CHL9YtBOQqvWQ53gbXqE+GdKD+ZcMeAHE
 2uF6//oVS8x+8pzmKdA8VqSS/nBIguX1Si2IuUBY=
Date: Wed, 9 Sep 2020 07:54:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH] Rescan the entire target on transport reset when LUN is 0
Message-ID: <20200909055403.GA310264@kroah.com>
References: <CY4PR02MB33354370E0A81E75DD9DFE74FB520@CY4PR02MB3335.namprd02.prod.outlook.com>
 <200ad446-1242-9555-96b6-4fa94ee27ec7@redhat.com>
 <CCFAFEBB-8250-4627-B25D-3B9054954C45@nutanix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CCFAFEBB-8250-4627-B25D-3B9054954C45@nutanix.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Matej Genci <matej.genci@nutanix.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>
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

On Tue, Sep 08, 2020 at 05:53:16PM +0000, Felipe Franciosi wrote:
> 
> 
> > On Sep 8, 2020, at 3:22 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > On 28/08/20 14:21, Matej Genci wrote:
> >> VirtIO 1.0 spec says
> >>    The removed and rescan events ... when sent for LUN 0, they MAY
> >>    apply to the entire target so the driver can ask the initiator
> >>    to rescan the target to detect this.
> >> 
> >> This change introduces the behaviour described above by scanning the
> >> entire scsi target when LUN is set to 0. This is both a functional and a
> >> performance fix. It aligns the driver with the spec and allows control
> >> planes to hotplug targets with large numbers of LUNs without having to
> >> request a RESCAN for each one of them.
> >> 
> >> Signed-off-by: Matej Genci <matej@nutanix.com>
> >> Suggested-by: Felipe Franciosi <felipe@nutanix.com>
> >> ---
> >> drivers/scsi/virtio_scsi.c | 7 ++++++-
> >> 1 file changed, 6 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> >> index bfec84aacd90..a4b9bc7b4b4a 100644
> >> --- a/drivers/scsi/virtio_scsi.c
> >> +++ b/drivers/scsi/virtio_scsi.c
> >> @@ -284,7 +284,12 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
> >> 
> >> 	switch (virtio32_to_cpu(vscsi->vdev, event->reason)) {
> >> 	case VIRTIO_SCSI_EVT_RESET_RESCAN:
> >> -		scsi_add_device(shost, 0, target, lun);
> >> +		if (lun == 0) {
> >> +			scsi_scan_target(&shost->shost_gendev, 0, target,
> >> +					 SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
> >> +		} else {
> >> +			scsi_add_device(shost, 0, target, lun);
> >> +		}
> >> 		break;
> >> 	case VIRTIO_SCSI_EVT_RESET_REMOVED:
> >> 		sdev = scsi_device_lookup(shost, 0, target, lun);
> >> 
> > 
> > 
> > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Cc: stable@vger.kernel.org
> 
> Thanks, Paolo.
> 
> I'm Cc'ing stable as I believe this fixes a driver bug where it
> doesn't follow the spec. Per commit message, today devices are
> required to issue RESCAN events for each LUN behind a target when
> hotplugging, or risking the driver not seeing the new LUNs.
> 
> Is this enough? Or should we resend after merge per below?
> https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

You need to let stable know the git commit id of the patch in Linus's
tree if the cc: stable is not on the final commit that gets merged.

thanks,

greg k-h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
