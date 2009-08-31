From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Extending virtio_console to support multiple ports
Date: Mon, 31 Aug 2009 08:17:21 -0500
Message-ID: <4A9BCD61.2040903__14525.7450094961$1251724767$gmane$org@codemonkey.ws>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<4A980D18.30106@codemonkey.ws>
	<20090830101057.GB32563@amit-x200.redhat.com>
	<4A9A7525.6010707@codemonkey.ws>
	<20090830131738.GC3401@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090830131738.GC3401@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
>> No flags, assume it's a streaming protocol and don't assume anything  
>> about message sizes.  IOW, when you send clipboard data, send size and  
>> then the data.  QEMU consumes bytes until it reaches size.
>>     
>
> Same intent but a different method: I'll have to specify that particular
> data is "size" and that data after this special data is the actual data
> stream.
>   

Sounds like every stream protocol in existence :-)

>>> - A lock has to be introduced to fetch one unused buffer from the list
>>>   and pass it on to the host. And this lock has to be a spinlock, just
>>>   because writes can be called from irq context.
>>>       
>> I don't see a problem here.
>>     
>
> You mean you don't see a problem in using a spinlock vs not using one?
>   

Right.  This isn't a fast path.

> Userspace will typically send the entire buffer to be transmitted in one
> system call. If it's large, the system call will have to be broken into
> several. This results in multiple guest system calls, each one to be
> handled with a spinlock held.
>
> Compare this with the entire write handled in one system call in the
> current method.
>   

Does it matter?  This isn't a fast path.

Regards,

Anthony Liguori
