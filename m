From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] Lguest64 - fatter puppies!
Date: Tue, 04 Sep 2007 22:06:40 -0400
Message-ID: <1188958000.7913.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756269AbXIECHi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lguest <lguest@ozlabs.org>
Cc: virtualization <virtualization@lists.osdl.org>, LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Glauber de Oliveira Costa <glommer@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a formal announcement of Lguest64.

Most are aware of the little puppies (lguest32, or simply lguest, or in
some circles "rustyvisor").  But this time the puppies ate a bit too
much.  No more lean and mean puppies, now we got big fat lazy ones.
Running on the hardware that's too lazy to do full virutalization. Yes,
lguest now runs on x86_64!

As you know, puppies are young, and so is lguest64. And like most new
born puppies, lguest64 might crap on your floor. But if it's in a good
mood, it will make it to the door and give you a login prompt (or maybe
even ssh into it and run firefox!
http://rostedt.homelinux.com/pics/firefox-on-lguest64.png ).

lguest64 is still going through a bit of growth pains, but its getting
better. It's to a point that we are not that afraid to bring it to the
dog show.

So for those that love puppies, and want even bigger ones, you can
download the code at:

  git://git.et.redhat.com/kernel-lguest-64.git

TODO:
 Many things! but here's what's on the near future list.

 - SMP first for host then for guest. We had it working a while
   ago, but we decided to update to catchup to lguest32, and we
   broke it.

 - get closer to lguest32. Rusty just likes to annoy us ;-)

 - optimization, optimization, optimization (did I say it's still slow?)

 - oh, and hopefully to get it merged!

well, there's lots more to do, but we can think about it later.

Want to help? test it out, and let us know how big a mess it made on
your floor.

-- Steve
