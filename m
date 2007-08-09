From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 9 Aug 2007 04:02:14 -0300
Message-ID: <5d6222a80708090002y7fdc6f2dw1dbacd3d27a86433__17047.095418866$1186643078$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546820708-git-send-email-gcosta@redhat.com>
	<11865468243612-git-send-email-gcosta@redhat.com>
	<11865468321629-git-send-email-gcosta@redhat.com>
	<11865468362401-git-send-email-gcosta@redhat.com>
	<11865468394005-git-send-email-gcosta@redhat.com>
	<11865468431616-git-send-email-gcosta@redhat.com>
	<1186546847263-git-send-email-gcosta@redhat.com>
	<11865468513077-git-send-email-gcosta@redhat.com>
	<46BAB5C8.5090906@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BAB5C8.5090906@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

> > +     case PARAVIRT_PATCH(make_pgd):
> > +     case PARAVIRT_PATCH(pgd_val):
> > +     case PARAVIRT_PATCH(make_pte):
> > +     case PARAVIRT_PATCH(pte_val):
> > +     case PARAVIRT_PATCH(make_pmd):
> > +     case PARAVIRT_PATCH(pmd_val):
> > +     case PARAVIRT_PATCH(make_pud):
> > +     case PARAVIRT_PATCH(pud_val):
> > +             /* These functions end up returning what
> > +                they're passed in the first argument */
> >
>
> Is this still true with 64-bit?  Either way, I don't think its worth
> having this here.  The damage to codegen around all those sites has
> already happened, and the additional cost of a noop direct call is
> pretty trivial.  I think this is a nanooptimisation which risks more
> problems than it could possibly be worth.

No it is not. But it is just the comment that is broken. (I forgot to
update it). The case here, is that they put in rax what they receive
in rdi.

> > +     case PARAVIRT_PATCH(set_pte):
> > +     case PARAVIRT_PATCH(set_pmd):
> > +     case PARAVIRT_PATCH(set_pud):
> > +     case PARAVIRT_PATCH(set_pgd):
> > +             /* These functions end up storing the second
> > +              * argument in the location pointed by the first */
> > +             ret = paravirt_patch_store_reg(insns, len);
> > +             break;
> >
>
> Ditto, really.  Do this in a later patch if it actually seems to help.

Okay, I can remove them both.

> > +/*
> > + * integers must be use with care here. They can break the PARAVIRT_PATCH(x)
> > + * macro, that divides the offset in the structure by 8, to get a number
> > + * associated with the hook. Dividing by four would be a solution, but it
> > + * would limit the future growth of the structure if needed.
> >
>
> Why not just stick them at the end of the structure?

Does it really matter?

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
