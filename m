From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 0/4] Using a generic bus_type for virtio
Date: Sun, 08 Jul 2007 12:45:34 +0300
Message-ID: <4690B23E.8030009@qumranet.com>
References: <20070706124200.988637662@arndb.de>
	<1183860930.6005.212.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183860930.6005.212.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: arnd@arndb.de, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Fri, 2007-07-06 at 14:42 +0200, arnd@arndb.de wrote:
>   
>> This is a subject that came up in the virtio BOF session
>> at OLS. I decided to go forward and implement something
>> that I like, based on the latest virtio proposal at the
>> time, which was draft III.
>>
>> It's not a drop-in replacement, because it's missing a
>> host implementation. I first started my own, which is
>> not done yet, but wanted to do one for lguest and one
>> for emulated PCI next. It's also entirely untested.
>>     
>
> Hi Arnd,
>
> 	I think it will come down to how neat PCI<->virtio is.  Can we push
> further towards PCI without screwing non-PCI?  eg. can we use
> pci_device_id?  struct pci_driver?  (Might be pushing it, but should
> probably be considered: it'd be neat if some platforms could #define
> virtio_driver_register pci_driver_register).
>   

This is liable to cause breakage when something changes.  And if I 
weren't such a sweet person I'd say it's also horribly ugly.

> 	Standardizing how to pack the info for each device into the config
> space would be especially useful.  Our drivers are going to get more
> featureful, and we're going to need a versioning/compatibility scheme
> too.
>
> Basically, I'd like to see someone start with work from the PCI side,
> then make sure non-PCI isn't overly burdened.
>   

We can certainly make non-bus specific code, like the feature bitmaps, 
shared.  I do agree that it makes sense to start from the PCI side as 
virtbus doesn't have any constraints.


-- 
error compiling committee.c: too many arguments to function
