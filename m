From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Extending virtio_console to support multiple ports
Date: Sun, 30 Aug 2009 15:40:57 +0530
Message-ID: <20090830101057.GB32563__17700.1397627921$1251627222$gmane$org@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<4A980D18.30106@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A980D18.30106@codemonkey.ws>
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

On (Fri) Aug 28 2009 [12:00:08], Anthony Liguori wrote:
> Amit Shah wrote:
>> On (Tue) Aug 25 2009 [11:47:20], Amit Shah wrote:
>>   
>>> Hello all,
>>>
>>> Here is a new iteration of the patch series that implements a
>>> transport for guest and host communications.
>>>
>>> The code has been updated to reuse the virtio-console device instead
>>> of creating a new virtio-serial device.
>>>     
>>
>> And the problem now is that hvc calls the put_chars function with
>> spinlocks held and we now allocate pages in send_buf(), called from
>> put_chars.
>>   
>
> Don't allocate pages in send_buf.  There's a fixed number of possible  
> entries on the ring.  Preallocate them up front and then you don't need  
> to sleep.

I did think about that as well, but there are problems:

- vnc clients (at least tigervnc) wants to receive the entire clipboard
  in a single flush command. So in the pre-allocated buffers scenario we
  could run short of the available buffers in some cases. So there will
  have to be a flag with each buffer that says 'there's more data
  pending for this particular write' which will have to be passed on to
  qemu and qemu will then flush it once it receives all the data

- A lock has to be introduced to fetch one unused buffer from the list
  and pass it on to the host. And this lock has to be a spinlock, just
  because writes can be called from irq context.

We're basically just turning a simple transport into more and more
complex code just to handle this special case.

		Amit
