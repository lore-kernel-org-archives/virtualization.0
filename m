From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Sun, 23 May 2010 20:28:21 +0300
Message-ID: <20100523172821.GA14948__33960.1322230466$1274635995$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com> <4BF39C12.7090407@redhat.com>
	<201005201431.51142.rusty@rustcorp.com.au>
	<201005201438.17010.rusty@rustcorp.com.au>
	<20100523153134.GA14646@redhat.com> <4BF94CAD.5010504@redhat.com>
	<20100523155132.GA14733@redhat.com> <4BF951BE.1010402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BF951BE.1010402@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 23, 2010 at 07:03:10PM +0300, Avi Kivity wrote:
> On 05/23/2010 06:51 PM, Michael S. Tsirkin wrote:
>>>
>>>> So locked version seems to be faster than unlocked,
>>>> and share/unshare not to matter?
>>>>
>>>>        
>>> May be due to the processor using the LOCK operation as a hint to
>>> reserve the cacheline for a bit.
>>>      
>> Maybe we should use atomics on index then?
>>    
>
> This should only be helpful if you access the cacheline several times in  
> a row.  That's not the case in virtio (or here).
>
> I think the problem is that LOCKSHARE and SHARE are not symmetric, so  
> they can't be directly compared.
>
>> OK, after adding mb in code patch will be sent separately,
>> the test works for my workstation. locked is still fastest,
>> unshared sometimes shows wins and sometimes loses over shared.
>>
>> [root@qus19 ~]# ./cachebounce share 0 1
>> CPU 0: share cacheline: 6638521 usec
>> CPU 1: share cacheline: 6638478 usec
>>    
>
> 66 ns? nice.
>
>> [root@qus19 ~]# ./cachebounce share 0 2
>> CPU 0: share cacheline: 14529198 usec
>> CPU 2: share cacheline: 14529156 usec
>>    
>
> 140 ns, not too bad.  I hope I'm not misinterpreting the results.
>
> -- 
> error compiling committee.c: too many arguments to function


Here's another box: here the fastest option
is shared, slowest unshared, lock is in the middle.



[root@virtlab16 testring]# sh run 0 2
CPU 2: share cacheline: 3304728 usec
CPU 0: share cacheline: 3304784 usec
CPU 0: unshare cacheline: 6283248 usec
CPU 2: unshare cacheline: 6283224 usec
CPU 2: lockshare cacheline: 4018567 usec
CPU 0: lockshare cacheline: 4018609 usec


CPU 2: lockunshare cacheline: 4041791 usec
CPU 0: lockunshare cacheline: 4041832 usec
[root@virtlab16 testring]# 
[root@virtlab16 testring]# 
[root@virtlab16 testring]# 
[root@virtlab16 testring]# sh run 0 1
CPU 1: share cacheline: 8306326 usec
CPU 0: share cacheline: 8306324 usec
CPU 0: unshare cacheline: 19571697 usec
CPU 1: unshare cacheline: 19571578 usec
CPU 0: lockshare cacheline: 11281566 usec
CPU 1: lockshare cacheline: 11281424 usec
CPU 0: lockunshare cacheline: 11276093 usec
CPU 1: lockunshare cacheline: 11275957 usec


[root@virtlab16 testring]# sh run 0 3
CPU 0: share cacheline: 8288335 usec
CPU 3: share cacheline: 8288334 usec
CPU 0: unshare cacheline: 19107202 usec
CPU 3: unshare cacheline: 19107139 usec
CPU 0: lockshare cacheline: 11238915 usec
CPU 3: lockshare cacheline: 11238848 usec
CPU 3: lockunshare cacheline: 11132134 usec
CPU 0: lockunshare cacheline: 11132249 usec
