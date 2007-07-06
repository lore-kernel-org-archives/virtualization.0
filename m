From: arnd@arndb.de
Subject: [RFC 0/4] Using a generic bus_type for virtio
Date: Fri, 06 Jul 2007 14:42:00 +0200
Message-ID: <20070706124200.988637662@arndb.de>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is a subject that came up in the virtio BOF session
at OLS. I decided to go forward and implement something
that I like, based on the latest virtio proposal at the
time, which was draft III.

It's not a drop-in replacement, because it's missing a
host implementation. I first started my own, which is
not done yet, but wanted to do one for lguest and one
for emulated PCI next. It's also entirely untested.

As things evolved, draft IV is completely different, and
these patches don't make sense any more on them, because
there is no longer the concept of a virtio_device, but
instead there are devices that have an arbitrary number
of virtqueue structures.

I'd still like to discuss my approach to see if there is
reason to continue down that road, so I'm posting what
I have right now.

I think among the options we have to go on are:

1. screw the virtio_bus, and let every host do its own
stuff -- no autoloading, standalone drivers, chardev
host etc.

2. get virtio_device back from the dead, and allow it
to have multiple virtqueues, either two or an unlimited
number.

3. screw the multiple-virtqueue idea, go back to the
draft III stuff with my changes.

	Arnd <><
