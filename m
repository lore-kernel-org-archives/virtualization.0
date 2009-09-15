From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 15 Sep 2009 18:33:57 +0530
Message-ID: <20090915130357.GC5247__35619.7607740343$1253020069$gmane$org@amit-x200.redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
	<20090915123752.GB5247@amit-x200.redhat.com>
	<4AAF8F26.8030503@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AAF8F26.8030503@codemonkey.ws>
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
Cc: greg@kroah.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Sep 15 2009 [07:57:10], Anthony Liguori wrote:
> Amit Shah wrote:
>> Hey Greg,
>>
>> Can you tell me how this could work out -- each console port could have
>> a "role" string associated with it (obtainable from the invoking qemu
>> process in case of qemu/kvm). Something that I have in mind currently
>> is:
>>
>> $ qemu-kvm ... -virtioconsole role=org/qemu/clipboard
>>
>> and then the guest kernel sees the string, and puts the
>> "org/qemu/clipboard" in some file in sysfs. Guest userspace should then
>> be able to open and read/write to
>>
>> /dev/virtio_console/org/qemu/clipboard
>>   
>
> That's probably not what we want.  I imagine what we want is:
>
> /dev/ttyV0
> /dev/ttyV1
> /dev/ttyVN
>
> And then we want:
>
> /sys/class/virtio-console/ttyV0/name -> "org.qemu.clipboard"
>
> Userspace can detect when new virtio-consoles appear via udev events.   
> When it sees a new ttyVN, it can then look in sysfs to discover it's 
> name.

OK; but that's kind of roundabout isn't it? An application, instead of
watching for the console port it's interested in, has to instead monitor
all the ports.

So in effect there has to be one app monitoring for new ports and then
that app exec'ing the corresponding app meant for that port.

		Amit
