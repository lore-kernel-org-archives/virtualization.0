From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 17:36:34 +0200
Message-ID: <47E28482.9010501__48679.2838354178$1206027627$gmane$org@qumranet.com>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E20A35.2000600@qumranet.com> <47E26CC1.8080900@codemonkey.ws>
	<47E27461.4090404@qumranet.com> <47E2771A.4060405@codemonkey.ws>
	<47E27AE7.7090503@qumranet.com> <47E27D1E.2090203@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E27D1E.2090203@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>
> You can have the file descriptor be opened O_RDONLY so trust isn't an 
> issue.
>

Reading is just as bad as writing.

>> This implies trusting the other userspace, which is not a good 
>> thing.  Let the kernel copy, we already trust it, and it has more 
>> resources to do the copy.
>>
>
> You're going to end up with the same trust issues no matter what 
> unless you let the kernel look directly at the virtio ring queue.  
> That's the only way to arbitrate what memory gets copied.  

That's what we need, then.

> There may be a generic API here for fast interprocess IO, I don't 
> know.  splice() is a little awkward though for this because you really 
> don't want to sit in a splice() loop.  What you want is for both sides 
> to be kick'ing the kernel and the kernel to raise an event via 
> eventfd() or something.
>
> Absent whatever this kernel API is (which is really just helpful with 
> a DMA engine), I think the current userspace approach is pretty 
> reasonable.  Not just for interguest IO but also for driver domains 
> which I think is a logical extension.

I disagree.  A driver domain is shared between multiple guests, and if 
one of the guests manages to break into qemu then it can see other 
guest's data.

[Driver domains are a horrible idea IMO, but that's another story]

-- 
error compiling committee.c: too many arguments to function
