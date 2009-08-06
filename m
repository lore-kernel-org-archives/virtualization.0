From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Thu, 6 Aug 2009 19:34:04 +0530
Message-ID: <20090806140404.GA12083__14793.641647748$1249567502$gmane$org@amit-x200.redhat.com>
References: <20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728140029.GA16067@amd.home.annexia.org>
	<4A77410D.4090804@codemonkey.ws>
	<20090805175713.GB28738@shareable.org>
	<4A79C8D9.5030606@codemonkey.ws>
	<20090806103843.GC9222@amit-x200.redhat.com>
	<4A7ADAC4.70902@codemonkey.ws>
	<20090806134103.GC11733@amit-x200.redhat.com>
	<4A7AE169.4000606@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A7AE169.4000606@codemonkey.ws>
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
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Aug 06 2009 [08:58:01], Anthony Liguori wrote:
> Amit Shah wrote:
>> On (Thu) Aug 06 2009 [08:29:40], Anthony Liguori wrote:
>>   
>>> Amit Shah wrote:
>>>     
>>>> Sure; but there's been no resistance from anyone from including the
>>>> virtio-serial device driver so maybe we don't need to discuss that.
>>>>         
>>> There certainly is from me.  The userspace interface is not 
>>> reasonable  for guest applications to use.
>>>     
>>
>> One example that would readily come to mind is dbus. A daemon running on
>> the guest that reads data off the port and interacts with the desktop by
>> appropriate dbus commands. All that's needed is a stream of bytes and
>> virtio-serial provides just that.
>>   
>
> dbus runs as an unprivileged user, how does dbus know which  
> virtio-serial port to open and who sets the permissions on that port?

The permission part can be handled by package maintainers and sysadmins
via udev policies.

So all data destined for dbus consumption gets to a daemon and that
daemon then sends it over to dbus.

		Amit
