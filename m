From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: xen: Make hvc0 the preferred console in domU
Date: Wed, 02 Apr 2008 09:21:34 -0700
Message-ID: <47F3B28E.3090803__23903.9356624291$1207153745$gmane$org@goop.org>
References: <87zltm1p0s.fsf@pike.pond.sub.org> <47F08688.6050206@goop.org>
	<87iqz0e24y.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87iqz0e24y.fsf@pike.pond.sub.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Markus Armbruster <armbru@redhat.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Markus Armbruster wrote:
> This turns out to a thornier problem than one might think.
>
> Consoles tty, hvc and ttyS register in this order.
>
> Unless the kernel command line dictates otherwise, the first one to
> register becomes the preferred console (the one behind /dev/console).
> This is tty.  Except we patched things so that hvc wins over tty in
> domU.  That's what we want there; tty is the dummy console there.
>
> Enter PV framebuffer.  It turns tty into a useful console, which we
> want to use.  But the PVFB is created only if it's enabled for this
> domain, and we learn that from xenstore.
>
> Problem: when tty registers, we can't yet know whether the PVFB is
> enabled.  By the time we can know, the console setup game is over.
>   

Why's that?  Is it because xenbus setup is too late?  Could we do an 
earlier query?

> The non-pvops PVFB has the same problem.  Jeremy Katz solved it there
> with a fairly gross hack: right after the Xen console is up, at the
> end of xencons_init(), we forcefully make the Xen console the
> preferred console if the PVFB is disabled:
>
>         /* Check about framebuffer messing up the console */
>         if (!is_initial_xendomain() &&
> 	    !xenbus_exists(XBT_NIL, "device", "vfb")) {
> 		/* FIXME: this is ugly */
> 		unregister_console(&kcons_info);
> 		kcons_info.flags |= CON_CONSDEV;
> 		register_console(&kcons_info);
> 	}
>
> Aside: we tried to get that into linux-2.6.18-xen.hg a couple of times
> before we gave up.  If you use that tree unmodified, you simply get no
> working console when you diable the PVFB.
>
> I append the straight pvops port of this hack.
>
> Instead of putting hvc_force_consdev() into hvc_console.c, we could
> also have a force_console() in kernel/printk.c, like this:
>
> void
> force_console(char *name, int index)
> {
> 	struct console *c, *cc;
>
> 	acquire_console_sem();
> 	for (c = console_drivers; c->next; c = c->next) {
> 		cc = c->next;
> 		if (!strcmp(cc->name, name) && cc->index == index) {
> 			c->next = c->next->next;
> 			cc->next = console_drivers;
> 			console_drivers->flags &= ~CON_CONSDEV;
> 			console_drivers = cc;
> 			cc->flags |= CON_CONSDEV;
> 			break;
> 		}
> 	}
> 	release_console_sem();
> }
>
> If one of these two hacks is acceptable, I'll prepare a proper patch.
> If not, I'd appreciate advice on how to solve this better.
>   

The console system supports multiple concurrent consoles, doesn't it?  
With the limitation that only one of them can be the source of keyboard 
input.  Can we support that, so that even if the user gets the config 
wrong they can still see some output (and we can printk a helpful 
message so they can work out how to get it working).  Ideally we could 
take input from all the consoles too, so there's no reason to 
exclusively choose one over any other...

But aside from that, it doesn't seem like our problem is particularly 
strange.  One can imagine many circumstances in which we come up using 
whatever's currently available as a console, but then a better console 
device appears during device probing.   In other words, this kind of 
console device switching seems like something that the console subsystem 
should support.

But in the meantime, pragmatics should win, and I don't have any strong 
objections to this patch.

    J
