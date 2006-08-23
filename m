From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 13:24:16 +0200
Message-ID: <200608231324.16047.ak@suse.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608231150.17650.ak@suse.de> <44EC27DF.2010204@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932381AbWHWLYi@vger.kernel.org>
In-Reply-To: <44EC27DF.2010204@vmware.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 23 August 2006 12:03, Zachary Amsden wrote:
> Andi Kleen wrote:
> >> And the functions they call?
> >>     
> >
> > Yes. But you only really need it for the actual callback, not the bulk
> > of stop_machine_run() (which calls scheduler and lots of other stuff)
> > The actual callback should be pretty limited already so it shouldn't
> > be a big limitation.
> >
> > -Andi
> >   
> 
> Hmm.  Seems dangerous to rely on this, because functions could change 
> from inline to out of line without people noticing that it affects this 
> very corner case for kprobes + paravirt + stop_machine.  Is there a way 
> to cascade the __kprobes declaration to all called functions, perhaps 
> with a static checker, like sparse?

Not that I know of. But that wasn't what I suggested: my point was that
kprobes while stop machine is still doing setup or tear down is fine.
You only don't want them in your new per CPU callback. So it should be enough
to mark that callback __kprobes.

-Andi
