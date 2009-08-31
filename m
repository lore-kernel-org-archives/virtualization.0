From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Extending virtio_console to support multiple ports
Date: Mon, 31 Aug 2009 11:37:05 -0500
Message-ID: <4A9BFC31.9070005__1987.9002742984$1251736790$gmane$org@codemonkey.ws>
References: <20090826112718.GA11117@amit-x200.redhat.com>
	<4A980D18.30106@codemonkey.ws>
	<20090830101057.GB32563@amit-x200.redhat.com>
	<4A9A7525.6010707@codemonkey.ws>
	<20090830131738.GC3401@amit-x200.redhat.com>
	<4A9BCD61.2040903@codemonkey.ws>
	<20090831135147.GA16371@amit-x200.redhat.com>
	<4A9BDC59.1090801@codemonkey.ws>
	<20090831143101.GA16943@amit-x200.redhat.com>
	<4A9BF2AB.8080104@codemonkey.ws>
	<20090831161925.GA22928@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090831161925.GA22928@amit-x200.redhat.com>
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
>>> We're ending up having to compromise on the performance or functionality
>>> or simplicity the devices just because of this restriction.
>>>   
>>>       
>> This is _not_ a high performance device and there so far has been no  
>> functionality impact.  I don't understand why you keep dragging your  
>> feet about this.  It's very simple, if you post a functional set of  
>> patches for a converged virtio-console driver, we'll merge it.  If you  
>>     
>
> I have already posted them and have received no feedback about the
> patches since. Let me add another request here for you to review them.
>   

But the guest drivers do not have proper locking.  Have you posted a new 
series with that fixed?

>> keep arguing about having a separate virtio-serial driver, it's not  
>> going to get merged.  I don't know how to be more clear than this.
>>     
>
> I'm not at all arguing for a separate virtio-serial driver. Please note
> the difference in what I'm asking for: I'm just asking for a good
> justification for the merging of the two since it just makes both the
> drivers not simple and also introduces dependencies on code outside our
> control.
>   

Functionally speaking, both virtio-console and virtio-serial do the same 
thing.  In fact, virtio-console is just a subset of virtio-serial.

If there are problems converging the two drivers in Linux, then I 
suggest you have two separate driver modules in Linux.  That would 
obviously be rejected for Linux though because you cannot have two 
drivers for the same device.  Why should qemu have a different policy?

  

>> That is not a justification to add a new device in QEMU.  If we add a  
>> new device everytime we encounter a less than ideal interface within a  
>> guest, we're going to end up having hundreds of devices.
>>     
>
> I just find this argument funny.
>   

I'm finding this discussion not so productive.

Regards,

Anthony Liguori
