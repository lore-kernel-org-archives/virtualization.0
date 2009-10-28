From: Hannes Reinecke <hare@suse.de>
Subject: Re: [Qemu-devel] [PATCH 3/4] scsi-disk: Factor out SCSI command
	emulation
Date: Wed, 28 Oct 2009 20:01:20 +0100
Message-ID: <20091028200120.lijyyq2ao0ss0ksk__33873.2730284848$1256756562$gmane$org@imap.suse.de>
References: <20091027152859.C6CF739742@ochil.suse.de>
	<20091028084247.GC17601@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091028084247.GC17601@lst.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Wed 28 Oct 2009 09:42:47 AM CET schrieb Christoph Hellwig <hch@lst.de>:

> On Tue, Oct 27, 2009 at 04:28:59PM +0100, Hannes Reinecke wrote:
>>
>> Other drives might want to use SCSI command emulation without
>> going through the SCSI disk abstraction, as this imposes too
>> many limits on the emulation.
>
> Might be a good idea to move something like this first into the series
> and share the CDB decoder between scsi and ide (atapi) as a start.  A
> little bit of refactoring of the CDB decoder, e.g. into one function
> per opcode (-family) won't hurt either.
>

Yes, that was on my to-do list, as well.
Eg even the megasas already emulates REPORT LUNs, as we certainly  
don't want to pass the original LUN information back to the guest.
And it would make sense to trap some other commands (like INQUIRY), too, to
strip it off any unwanted information.

Cheers,

Hannes
---
No .sig today as this is from my laptop.
