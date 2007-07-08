From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 0/4] Using a generic bus_type for virtio
Date: Sun, 08 Jul 2007 12:42:19 +0300
Message-ID: <4690B17B.9010408@qumranet.com>
References: <20070706124200.988637662@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070706124200.988637662@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: arnd@arndb.de
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

arnd@arndb.de wrote:
> This is a subject that came up in the virtio BOF session
> at OLS. I decided to go forward and implement something
> that I like, based on the latest virtio proposal at the
> time, which was draft III.
>
> It's not a drop-in replacement, because it's missing a
> host implementation. I first started my own, which is
> not done yet, but wanted to do one for lguest and one
> for emulated PCI next. It's also entirely untested.
>
> As things evolved, draft IV is completely different, and
> these patches don't make sense any more on them, because
> there is no longer the concept of a virtio_device, but
> instead there are devices that have an arbitrary number
> of virtqueue structures.
>
> I'd still like to discuss my approach to see if there is
> reason to continue down that road, so I'm posting what
> I have right now.
>
> I think among the options we have to go on are:
>
> 1. screw the virtio_bus, and let every host do its own
> stuff -- no autoloading, standalone drivers, chardev
> host etc.
>
>   

That's a bit against the spirit of virtio.  I think that the control 
path will become quite large over time, so it makes sense to share as 
much as possible.

> 2. get virtio_device back from the dead, and allow it
> to have multiple virtqueues, either two or an unlimited
> number.
>   

This is the best option IMO.

> 3. screw the multiple-virtqueue idea, go back to the
> draft III stuff with my changes.
>   

I'm sure Rusty will just love this one.

4. Delegate the responsibility for extracting the queues to 
hypervisor-specific code, but keep the rest shared.

Just for completeness; option 2 is better.


-- 
error compiling committee.c: too many arguments to function
