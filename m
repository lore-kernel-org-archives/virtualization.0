From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Extending virtio_console to support multiple ports
Date: Fri, 28 Aug 2009 12:00:08 -0500
Message-ID: <4A980D18.30106@codemonkey.ws>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090826112718.GA11117@amit-x200.redhat.com>
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
> On (Tue) Aug 25 2009 [11:47:20], Amit Shah wrote:
>   
>> Hello all,
>>
>> Here is a new iteration of the patch series that implements a
>> transport for guest and host communications.
>>
>> The code has been updated to reuse the virtio-console device instead
>> of creating a new virtio-serial device.
>>     
>
> And the problem now is that hvc calls the put_chars function with
> spinlocks held and we now allocate pages in send_buf(), called from
> put_chars.
>   

Don't allocate pages in send_buf.  There's a fixed number of possible 
entries on the ring.  Preallocate them up front and then you don't need 
to sleep.

> A few solutions:
> - Keep things as they are, virtio_console.c remains as it is and
>   virtio_serial.c gets added
>   
Not an option from a QEMU perspective.

Regards,

Anthony Liguori
