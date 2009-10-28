From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Wed, 28 Oct 2009 11:54:31 +0100
Message-ID: <4AE822E7.2010108__5042.67858709699$1256727356$gmane$org@redhat.com>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091028091129.n46xqd1lww8oosc8@imap.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

   Hi,

>>> In order to support SCSI command emulation I had to update /
>>> patch up the existing SCSI disk support. This might be
>>> not to everyones taste, so I'm open to alternative
>>> suggestions.
>>>
>>> But I certainly do _not_ want to update the SCSI disk
>>> emulation, as this is really quite tied to the SCSI parallel
>>> interface used by the old lsi53c895a.c.
>>
>> --verbose please. I'd prefer to fix scsi-disk bugs and/or limitations
>> instead of working around them.
>>
> The problem is I don't have any documentation for the LSI parallel
> SCSI controller. So I don't know if and in what shape I/O is passed
> down, nor anything else.

[ after briefly checking the code ]

Hmm.  Data is passed back+forth between scsi-device and scsi-adapter 
using a bounce buffer per request and a amazing maze of callbacks ...

That interface needs some serious rework, so we have a chance to kill 
the memcpy() and use iovecs.

> And as the SCSI disk emulation is really
> tied into the LSI parallel SCSI controller, any change in the former
> is likely to break the latter.

Not really.

> And what with me no way of fixing it. Hence I decided on this approach.

 From a really quick view fixing up the data xfer code paths doesn't 
look too bad.  Think I'll give it a try.

>>> Plus it doesn't do scatter-gather list handling,
>>
>> Which should be fixed anyway.
>>
> Quite. But as I said, the LSI parallel SCSI controller is going to
> suffer.

Don't think so.  Even if scsi-disk *supports* scatter lists, lsi isn't 
forced to actually use that.  I think we'll need a bounce-buffer mode 
anyway for usb-msd because it streams the scsi data in tons of small 
packets over usb ...

cheers,
   Gerd
