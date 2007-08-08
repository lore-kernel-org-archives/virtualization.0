From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
	entry.S
Date: Wed, 8 Aug 2007 16:11:24 +0200
Message-ID: <200708081611.25152.ak__24812.9128980965$1186582794$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<5d6222a80708080658j780667c4o52e924f8690f2a85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708080658j780667c4o52e924f8690f2a85@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 08 August 2007 15:58:06 Glauber de Oliveira Costa wrote:

> On 8/8/07, Andi Kleen <ak@suse.de> wrote:
> >
> > > +#define SYSRETQ                                              \
> > > +                     movq    %gs:pda_oldrsp,%rsp;    \
> > > +                     swapgs;                         \
> > > +                     sysretq;
> >
> > When the macro does more than sysret it should have a different
> > name
> That's fair. Again, suggestions are welcome. Maybe SYSCALL_RETURN ?

Sounds reasonable.

> > >  retint_restore_args:
> > > -     cli
> > > +     DISABLE_INTERRUPTS(CLBR_ANY)
> >
> > Similar.
> I don't think so. They are live here, but restore_args follows, so we
> can safely clobber anything here. Right?

The non argument registers cannot be clobbered.



-Andi
