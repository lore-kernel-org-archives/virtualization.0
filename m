From: Hannes Reinecke <hare@suse.de>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Wed, 28 Oct 2009 20:25:22 +0100
Message-ID: <20091028202522.r53660olwsk8cokk__31764.1854439445$1256757975$gmane$org@imap.suse.de>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
	<4AE822E7.2010108@redhat.com> <4AE84E09.7090002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AE84E09.7090002@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Wed 28 Oct 2009 02:58:33 PM CET schrieb Gerd Hoffmann <kraxel@redhat.com>:

>   Hi,
>
>> From a really quick view fixing up the data xfer code paths doesn't
>> look too bad. Think I'll give it a try.
>
> Oh well.  The interface pretty obviously designed for the esp, which is
> the oldest scsi adapter in qemu ...
>
> ESP: There is no scatter-gather support in the hardware.  So for large
> reads/writes there are quite switches between OS and ESP:  The OS
> saying "dma next sectors to this location" via ioports, the ESP doing
> it and raising a IRQ when done, next round.  The existing callback
> mechanism models that pretty closely.
>
> USB: streams the data in small packets (smaller than sector size, 64
> bytes IIRC).  Current interface works good enougth.
>
> LSI: Hops through quite a few loops to work with the existing
> interface.  Current emulation reads one lsi script command at a time
> and does reads/writes in small pieces like the ESP.  I think it could
> do alot better: parse lsi scripts into scatter lists and submit larger
> requests.  Maybe even have multiple requests in flight at the same
> time.  That probably means putting the lsi script parsing code upside
> down though.
>
> MEGASAS: I guess you have scatter lists at hand and want to submit them
> directly to the block layer for zerocopy block I/O.
>
Precisely.

> So, where to go from here?
>
> I'm tempted to zap the complete read-in-pieces logic.  For read/write
> transfers storage must be passed where everything fits in.  The
> completion callback is called on command completion and nothing else.
>
Agree. That would be my idea here, as well.

> I think we'll need to modes here: xfer from/to host-allocated bounce
> buffer (linear buffer) and xfer from/to guest memory (scatter list).
>
I don't think we really need two modes.
My preferred interface here is to pass down scatter-gather lists down
with every xfer; this way it'll be the responsibility of the driver to
create the lists in the first place. If it has hardware scatter-gather
support it can just pass them down, if not it can as easily create a
scatter-gather list with just one element as a bounce buffer.
Much like the current code does now, only with explicit passing of iovecs.

> That means (emulated) hardware without scatter-gather support must use
> the bounce buffer mode can can't do zerocopy I/O.  I don't think this
> is a big problem though.  Lots of small I/O requests don't perform very
> well, so one big request filling the bounce buffer then memcpy()
> from/to guest memory will most likely be faster anyway.
>
I would update the existing interface to split off the request generation from
the command completion code; then it would be easy to attach the iovec to the
request.

So something like
- Get next request
- Attach iovec/bounc-buffer
- handle request (command/write/read)
- complete request (callback)

would be an idea.

Cheers,

Hannes
---
No .sig today as I'm writing from my laptop.
