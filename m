Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CEC46467
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 18:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CEA3D40535;
	Thu, 19 Jan 2023 18:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEA3D40535
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=o102Tgd2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NaamH5bF1LZ; Thu, 19 Jan 2023 18:58:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1362D401AE;
	Thu, 19 Jan 2023 18:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1362D401AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC711C0033;
	Thu, 19 Jan 2023 18:58:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E9D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 18:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5E7C41D1B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 18:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5E7C41D1B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=o102Tgd2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxtEnH-ROPbB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 18:58:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A078341A37
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A078341A37
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 18:58:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EE70FB826FD;
 Thu, 19 Jan 2023 18:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9C1C433EF;
 Thu, 19 Jan 2023 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674154678;
 bh=irPDc4PqAY06umonc3ANFVo3lz70U1KnloYgvlv8TEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o102Tgd2S3iUcbnVFMtgpmXS3FOTMR7HLC3tQJfGtyz797HD6QTTXDdGKqUQ7G10T
 gqFzk/nJx76PYVy99ZA+DWrcbG8fPwGhQtIXubPIDycfZpfVoPlmlraOOoZjKyAjkN
 iNoQrdo+n5lPdVGCUnRg/lLNq5TEHy1pv1iALv00=
Date: Thu, 19 Jan 2023 19:57:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y8mSs68JfW6t4mjl@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilh2quto.fsf@ubik.fi.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 mst@redhat.com, Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, elena.reshetova@intel.com,
 kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 07:48:35PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Jan 19, 2023 at 03:57:17PM +0200, Alexander Shishkin wrote:
> >> From: Andi Kleen <ak@linux.intel.com>
> >> 
> >> The ADD_PORT operation reads and sanity checks the port id multiple
> >> times from the untrusted host. This is not safe because a malicious
> >> host could change it between reads.
> >> 
> >> Read the port id only once and cache it for subsequent uses.
> >> 
> >> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Amit Shah <amit@kernel.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >>  drivers/char/virtio_console.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> >> index f4fd5fe7cd3a..6599c2956ba4 100644
> >> --- a/drivers/char/virtio_console.c
> >> +++ b/drivers/char/virtio_console.c
> >> @@ -1563,10 +1563,13 @@ static void handle_control_message(struct virtio_device *vdev,
> >>  	struct port *port;
> >>  	size_t name_size;
> >>  	int err;
> >> +	unsigned id;
> >>  
> >>  	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
> >>  
> >> -	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> >> +	/* Make sure the host cannot change id under us */
> >> +	id = virtio32_to_cpu(vdev, READ_ONCE(cpkt->id));
> >
> > Why READ_ONCE()?
> >
> > And how can it change under us?  Is the message still under control of
> > the "host"?  If so, that feels wrong as this is all in kernel memory,
> > not userspace memory right?
> >
> > If you are dealing with memory from a different process that you do not
> > trust, then you need to copy EVERYTHING at once.  Don't piece-meal copy
> > bits and bobs in all different places please.  Do it once and then parse
> > the local structure properly.
> 
> This is the device memory or the VM host memory, not userspace or
> another process. And it can change under us willy-nilly.

Then you need to copy it out once, and then only deal with the local
copy.  Otherwise you have an incomplete snapshot.

> The thing is, we only need to cache two things to correctly process the
> request. Copying everything, on the other hand, would involve the entire
> buffer, not just the *cpkt, but also stuff that follows, which also
> differs between different event types. And we also don't care if the
> rest of it changes under us.

That feels broken if you do not "trust" that other side.  And what
prevents the buffer from changing after you validated the other part?

For virtio, I thought you always implied that you did trust the other
side, when has that changed?  Where was that new security model for the
kernel discussed?

Are you sure this is even viable?  What is the threat model you are
attempting to add to the driver here?

> > Otherwise this is going to be impossible to actually maintain over
> > time...
> 
> An 'id' can't possibly be worse to maintain than multiple instances of
> 'virtio32_to_cpu(vdev, cpkt->id)' sprinkled around the code.

Again, copy what you want out and then act on that.  If it can change
under you, and you do not trust it, then you have to work only on a
snapshot that you have verified.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
