From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH 1/5] lguest: mmap backing file
Date: Thu, 20 Mar 2008 18:46:39 -0500
Message-ID: <47E2F75F.2040808__29716.4781055928$1206056958$gmane$org@codemonkey.ws>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
	<47E26EE1.5030706@codemonkey.ws>
	<200803210912.25648.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803210912.25648.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> How odd!  Do you have any idea why?
>   

Nope, but part of the reason I did this was I recalled a similar 
discussion relating to kqemu and why it used /dev/shm.  I thought it was 
only an issue with older kernels but apparently not.

>> /dev/shm is not really for general use.  I think we'll want to have our
>> own tmpfs mount that we use to create VM images.
>>     
>
> If we're going to mod the kernel, how about a "mmap this part of their address 
> space" and having the kernel keep the mappings in sync.  But I think that if 
> we want to get speed, we should probably be doing the copy between address 
> spaces in-kernel so we can do lightweight exits.
>   

I don't think lightweight exits help the situation very much.  The 
difference between a light weight and heavy weight exit is only 3-4k 
cycles or so.

in-kernel doesn't make the situation much easier.  You have to map pages 
in from a different task.  It's a lot easier if you have both guest 
mapped in userspace.

>> I also prefer to use a 
>> unix socket for communication, unlink the file immediately after open,
>> and then pass the fd via SCM_RIGHTS to the other process.
>>     
>
> Yeah, I shied away from that because cred passing kills whole litters of 
> puppies.  It makes for better encapsulation tho, so I'd do it that way in a 
> serious implementation.
>   

I'm working on an implementation for KVM at the moment.  Instead of just 
supporting two guests, I'm looking to support N-guests and provide a 
simple switch.  I'll have patches soon.

Regards,

Anthony Liguori

> Cheers,
> Rusty.
>   
