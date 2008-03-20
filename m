From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 09:39:22 -0500
Message-ID: <47E2771A.4060405__36249.3987348445$1206024229$gmane$org@codemonkey.ws>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E20A35.2000600@qumranet.com> <47E26CC1.8080900@codemonkey.ws>
	<47E27461.4090404@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E27461.4090404@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>> Avi Kivity wrote:
>>
>> Each guest's host userspace mmaps the other guest's address space.  
>> The userspace then does a copy on both the tx and rx paths.
>>
>
> Well, that's better security-wise (I'd still prefer to avoid it, so we 
> can run each guest under a separate uid), but then we lose performance 
> wise.

What performance win?  I'm not sure the copies can be eliminated in the 
case of interguest IO.

Fast interguest IO means mmap()'ing the other guest's address space 
read-only.  If you had a pv dma registration api you could conceivably 
only allow the active dma entries to be mapped but my fear would be that 
the zap'ing on unregister would hurt performance.

>> Conceivably, this could be done as a read-only mapping so that each 
>> guest userspace copies only the rx packets.  That's about as secure 
>> as you're going to get with this approach I think.
>>
>
> Maybe we can terminate the virtio queue in the host kernel as a pipe, 
> and splice pipes together.
>
> That gives us guest-guest and guest-process communications, and if you 
> use aio the kernel can use a dma engine for the copy.

Ah, so you're looking to use a DMA engine for accelerated copy.  Perhaps 
the answer is to expose the DMA engine via a userspace API?

Regards,

Anthony Liguori
