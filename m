From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 9 Aug 2007 02:24:16 +0200
Message-ID: <200708090224.16328.ak__11449.7465584011$1186619257$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<5d6222a80708080749t35c5c0ceo8b3b8f0cce50c666@mail.gmail.com>
	<1186615137.17470.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186615137.17470.100.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 09 August 2007 01:18:57 Rusty Russell wrote:
> On Wed, 2007-08-08 at 11:49 -0300, Glauber de Oliveira Costa wrote:
> > On 8/8/07, Andi Kleen <ak@suse.de> wrote:
> > > > +EXPORT_SYMBOL(paravirt_ops);
> > >
> > > Definitely _GPL at least.
> > Sure.
> 
> We ended up making it EXPORT_SYMBOL in i386 because every driver wants
> to save and restore interrupt state.

Ah true.
 
> But questionably-licensed drivers might be less of a concern on x86-64.

Nvidia/ATI and other binary modules exist too and users will probably unhappy 
if they cannot run them anymore.

But at usually irq state changes should be patched in anyways and won't
need paravirt I guess? 

Hmm, actually thinking about it the module loader probably has no clue
that the relocation it linked will be overwritten so it'll check
for the export anyways.

So the alternatives would be to add ugly hacks to the module loader
or split paravirt_ops in "common" and "low level system" areas or 
export it as a normal export.

Not sure what's best. Ok using a normal export is easiest and not
that big an issue.

-Andi
