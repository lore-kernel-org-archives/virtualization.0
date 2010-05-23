From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Sun, 23 May 2010 18:41:33 +0300
Message-ID: <4BF94CAD.5010504__33449.7517942966$1274629333$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com> <4BF39C12.7090407@redhat.com>
	<201005201431.51142.rusty@rustcorp.com.au>
	<201005201438.17010.rusty@rustcorp.com.au>
	<20100523153134.GA14646@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100523153134.GA14646@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/23/2010 06:31 PM, Michael S. Tsirkin wrote:
> On Thu, May 20, 2010 at 02:38:16PM +0930, Rusty Russell wrote:
>    
>> On Thu, 20 May 2010 02:31:50 pm Rusty Russell wrote:
>>      
>>> On Wed, 19 May 2010 05:36:42 pm Avi Kivity wrote:
>>>        
>>>>> Note that this is a exclusive->shared->exclusive bounce only, too.
>>>>>
>>>>>            
>>>> A bounce is a bounce.
>>>>          
>>> I tried to measure this to show that you were wrong, but I was only able
>>> to show that you're right.  How annoying.  Test code below.
>>>        
>> This time for sure!
>>      
>
> What do you see?
> On my laptop:
> 	[mst@tuck testring]$ ./rusty1 share 0 1
> 	CPU 1: share cacheline: 2820410 usec
> 	CPU 0: share cacheline: 2823441 usec
> 	[mst@tuck testring]$ ./rusty1 unshare 0 1
> 	CPU 0: unshare cacheline: 2783014 usec
> 	CPU 1: unshare cacheline: 2782951 usec
> 	[mst@tuck testring]$ ./rusty1 lockshare 0 1
> 	CPU 1: lockshare cacheline: 1888495 usec
> 	CPU 0: lockshare cacheline: 1888544 usec
> 	[mst@tuck testring]$ ./rusty1 lockunshare 0 1
> 	CPU 0: lockunshare cacheline: 1889854 usec
> 	CPU 1: lockunshare cacheline: 1889804 usec
>    

Ugh, can the timing be normalized per operation?  This is unreadable.

> So locked version seems to be faster than unlocked,
> and share/unshare not to matter?
>    

May be due to the processor using the LOCK operation as a hint to 
reserve the cacheline for a bit.

> same on a workstation:
> [root@qus19 ~]# ./rusty1 unshare 0 1
> CPU 0: unshare cacheline: 6037002 usec
> CPU 1: unshare cacheline: 6036977 usec
> [root@qus19 ~]# ./rusty1 lockunshare 0 1
> CPU 1: lockunshare cacheline: 5734362 usec
> CPU 0: lockunshare cacheline: 5734389 usec
> [root@qus19 ~]# ./rusty1 lockshare 0 1
> CPU 1: lockshare cacheline: 5733537 usec
> CPU 0: lockshare cacheline: 5733564 usec
>
> using another pair of CPUs gives a more drastic
> results:
>
> [root@qus19 ~]# ./rusty1 lockshare 0 2
> CPU 2: lockshare cacheline: 4226990 usec
> CPU 0: lockshare cacheline: 4227038 usec
> [root@qus19 ~]# ./rusty1 lockunshare 0 2
> CPU 0: lockunshare cacheline: 4226707 usec
> CPU 2: lockunshare cacheline: 4226662 usec
> [root@qus19 ~]# ./rusty1 unshare 0 2
> CPU 0: unshare cacheline: 14815048 usec
> CPU 2: unshare cacheline: 14815006 usec
>
>    

That's expected.  Hyperthread will be fastest (shared L1), shared L2/L3 
will be slower, cross-socket will suck.


-- 
error compiling committee.c: too many arguments to function
