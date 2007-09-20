From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [Lguest] [PATCH 0/6] virtio with config abstraction and
	ringimplementation
Date: Thu, 20 Sep 2007 15:50:26 +0200
Message-ID: <46F27AA2.1030605__29878.6115403802$1190296330$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<46F2791A.8070601@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F2791A.8070601@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dor Laor <dor.laor@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
> Rusty Russell wrote:
>>
>> Hi all,
>>
>>         This patch series attempts to come closer to unifying kvm and 
>> lguest's
>> usage of virtio.  As these two are the first implementations we've seen,
>> I hope making them closer will make future ones closer too.
>>
>>         Drivers now unpack their own configuration: their probe() 
>> methods are
>> uniform.  The configuration mechanism is extensible and can be backed by
>> PCI, a string of bytes, or something else.
>>
>>         I've abstracted out the lguest ring buffer code into a common 
>> library.
>> The format has changed slightly (mainly because I had an epiphany about
>> inter-guest I/O).
>>
>>         I also implemented a console (lguest needs one).
>>
>>         Finally, there is a working lguest implementation.  
>> Unfortunately,
>> lguest is being refactored for non-i386 ports, so the virtio patches sit
>> at the end of the (quite long) for-2.6.24 patchqueue.  Nonetheless, they
>> can be found at http://lguest.ozlabs.org/patches (click on bz2 to get
>> the series).
>>
>> Cheers!
>> Rusty.
>>
> Superb job, it saved me the burden of try to merge the in-house 
> virtio_backend.
>
> I like the separation of the ring code, the improved descriptors and 
> the notify too.
> Regarding the pci config space, I rather see config_ops type of 
> operations to let
> the 390/xen/other implementations jump on our wagon.
>
> Maybe change the offset/len type into a handle pointer and function 
> pointers.
> The best would be to let them comment on that. I glimpsed over xen 
> netfront.c and I think that
> the config space can be used without too many hassles
> Dor.
>
Of course I'll rebase what's left of my code over the new patches.
