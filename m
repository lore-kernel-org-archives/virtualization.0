From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Extending virtio_console to support multiple ports
Date: Mon, 31 Aug 2009 19:21:47 +0530
Message-ID: <20090831135147.GA16371__32321.7405858033$1251726949$gmane$org@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<4A980D18.30106@codemonkey.ws>
	<20090830101057.GB32563@amit-x200.redhat.com>
	<4A9A7525.6010707@codemonkey.ws>
	<20090830131738.GC3401@amit-x200.redhat.com>
	<4A9BCD61.2040903@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A9BCD61.2040903@codemonkey.ws>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Aug 31 2009 [08:17:21], Anthony Liguori wrote:
>>>> - A lock has to be introduced to fetch one unused buffer from the list
>>>>   and pass it on to the host. And this lock has to be a spinlock, just
>>>>   because writes can be called from irq context.
>>>>       
>>> I don't see a problem here.
>>>     
>>
>> You mean you don't see a problem in using a spinlock vs not using one?
>>   
>
> Right.  This isn't a fast path.
>
>> Userspace will typically send the entire buffer to be transmitted in one
>> system call. If it's large, the system call will have to be broken into
>> several. This results in multiple guest system calls, each one to be
>> handled with a spinlock held.
>>
>> Compare this with the entire write handled in one system call in the
>> current method.
>>   
>
> Does it matter?  This isn't a fast path.

The question isn't just about how much work happens inside the spinlock.
It's also a question about introducing spinlocks where they shouldn't
be.

I don't see why such changes have to creep into the kernel.

Can you please explain your rationale for being so rigid about merging
the two drivers?

		Amit
