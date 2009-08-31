From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Extending virtio_console to support multiple ports
Date: Mon, 31 Aug 2009 21:49:25 +0530
Message-ID: <20090831161925.GA22928__22616.0433995121$1251735644$gmane$org@amit-x200.redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A9BF2AB.8080104@codemonkey.ws>
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

On (Mon) Aug 31 2009 [10:56:27], Anthony Liguori wrote:
> Amit Shah wrote:
>> On (Mon) Aug 31 2009 [09:21:13], Anthony Liguori wrote:
>>   
>>> Amit Shah wrote:
>>>     
>>>> Can you please explain your rationale for being so rigid about merging
>>>> the two drivers?
>>>>         
>>> Because they do the same thing.  I'm not going to constantly rehash   
>>> this.  It's been explained multiple times.
>>>     
>>
>> It hardly looks like the same thing each passing day.
>>   
>
> That's BS.  The very first time you posted, you received the same  
> feedback from both Paul and I.  See  
> http://article.gmane.org/gmane.comp.emulators.qemu/44778.  That was back  
> in June.  You've consistently received the same feedback both on the ML  
> and in private.

I'm just saying they all start looking the same.

>> We're ending up having to compromise on the performance or functionality
>> or simplicity the devices just because of this restriction.
>>   
>
> This is _not_ a high performance device and there so far has been no  
> functionality impact.  I don't understand why you keep dragging your  
> feet about this.  It's very simple, if you post a functional set of  
> patches for a converged virtio-console driver, we'll merge it.  If you  

I have already posted them and have received no feedback about the
patches since. Let me add another request here for you to review them.

> keep arguing about having a separate virtio-serial driver, it's not  
> going to get merged.  I don't know how to be more clear than this.

I'm not at all arguing for a separate virtio-serial driver. Please note
the difference in what I'm asking for: I'm just asking for a good
justification for the merging of the two since it just makes both the
drivers not simple and also introduces dependencies on code outside our
control.

>>> If there are implementation issues within the Linux drivers because 
>>> of  peculiarities of hvc then hvc needs to be fixed.  It has nothing 
>>> to do  with the driver ABI which is what qemu cares about.
>>>     
>>
>> I'd welcome that effort as well. But we all know that's not going to
>> happen anytime soon.
>>   
>
> That is not a justification to add a new device in QEMU.  If we add a  
> new device everytime we encounter a less than ideal interface within a  
> guest, we're going to end up having hundreds of devices.

I just find this argument funny.

		Amit
