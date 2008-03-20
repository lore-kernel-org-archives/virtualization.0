From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 10:05:02 -0500
Message-ID: <47E27D1E.2090203__40821.8959034004$1206025701$gmane$org@codemonkey.ws>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E20A35.2000600@qumranet.com> <47E26CC1.8080900@codemonkey.ws>
	<47E27461.4090404@qumranet.com> <47E2771A.4060405@codemonkey.ws>
	<47E27AE7.7090503@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E27AE7.7090503@qumranet.com>
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
>>> Anthony Liguori wrote:
>>>> Avi Kivity wrote:
>>>>
>>>> Each guest's host userspace mmaps the other guest's address space.  
>>>> The userspace then does a copy on both the tx and rx paths.
>>>>
>>>
>>> Well, that's better security-wise (I'd still prefer to avoid it, so 
>>> we can run each guest under a separate uid), but then we lose 
>>> performance wise.
>>
>> What performance win?  I'm not sure the copies can be eliminated in 
>> the case of interguest IO.
>>
>
> I guess not.  But at least you can dma instead of busy-copying.
>
>> Fast interguest IO means mmap()'ing the other guest's address space 
>> read-only.  

You can have the file descriptor be opened O_RDONLY so trust isn't an issue.

> This implies trusting the other userspace, which is not a good thing.  
> Let the kernel copy, we already trust it, and it has more resources to 
> do the copy.
>

You're going to end up with the same trust issues no matter what unless 
you let the kernel look directly at the virtio ring queue.  That's the 
only way to arbitrate what memory gets copied.  There may be a generic 
API here for fast interprocess IO, I don't know.  splice() is a little 
awkward though for this because you really don't want to sit in a 
splice() loop.  What you want is for both sides to be kick'ing the 
kernel and the kernel to raise an event via eventfd() or something.

Absent whatever this kernel API is (which is really just helpful with a 
DMA engine), I think the current userspace approach is pretty 
reasonable.  Not just for interguest IO but also for driver domains 
which I think is a logical extension.

Regards,

Anthony Liguori
