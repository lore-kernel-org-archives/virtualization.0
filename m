From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A set of "standard" virtual devices?
Date: Wed, 04 Apr 2007 08:50:25 -0700
Message-ID: <4613C941.6040706@zytor.com>
References: <4611652F.700@zytor.com> <200704040049.13118.arnd@arndb.de> <4612F6E9.7040003@zytor.com> <200704041511.42543.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933618AbXDDPvE@vger.kernel.org>
In-Reply-To: <200704041511.42543.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> 
>> That being said, on platforms which are PCI-centric, such as x86, this 
>> of course makes it a lot easier to produce virtual devices which work 
>> across hypervisors, since the device model, of *any* operating system is 
>> set up to handle them.
> 
> Yes, as I said there are two separate problems. I really think that
> a standardized virtual driver interface should be modeled after
> kernel <-> user interfaces, not hardware <-> kernel interfaces.
> 
> Once we know what operations we want (e.g. read, write and SIGIO,
> or some other set of primitives), it will be good to provide a
> virtual PCI device that can be used as one transport mechanism
> below it. Using PCI device IDs to tell what functionality is
> provided by the device would provide a reasonable method for
> autoprobing.
> 

That seems like a reasonable approach.  I *do* care about 
hardware-equivalent interfaces, because they, too, keep getting 
reinvented, but it seems reasonable to approach it in a layered fashion 
like you describe.

	-hpa
