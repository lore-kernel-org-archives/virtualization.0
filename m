From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 26 Nov 2007 10:52:44 -0800
Message-ID: <474B15FC.4050901@goop.org>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4744BB54.4040803@goop.org>
	<de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Juan Quintela <juan.quintela@gmail.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Juan Quintela wrote:
> Hi,
>
> your console works great, but rest of patches are assuming:
>
> arch/x86/boot/compressed/notes-xen.c
> arch/x86/xen/early.c
>   

Yes, those are leftovers from a somewhat unsuccessful attempt at getting
ELF-in-bzImage booting working.  I need to go back and make bzImage
booting work properly.

I posted those patches as a source of possibly useful code
snippets/summary of things I've looked at so far, rather than something
that can be directly used.

> at least.  It looks as if there is missing another patche, could you
> take a look, please?
> Otherwise, I will take a look at what is missing.
>
> It breaks with:
>
> Intel machine check architecture supported.
> (XEN) traps.c:1734:d0 Domain attempted WRMSR 00000404 from 00000000:00000001 to
> ffffffff:ffffffff.
> Intel machine check reporting enabled on CPU#0.
> general protection fault: 0000 [#1] SMP
> Modules linked in:
>   

Hm.  Looks like Xen is getting upset about dom0 trying to disable
caching.  No, wait: 0xffffffff:ffffffff?  That's strange; I wonder if
its just misreporting the value, because the code doesn't look like its
trying to write that.

Either way, the fix is to implement xen_write_cr0, and mask off any bits
that Xen won't want us to set/clear (or if it doesn't allow dom0 to
change cr0, just ignore all updates).

    J
