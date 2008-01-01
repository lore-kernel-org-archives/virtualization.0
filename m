From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] remove __init modifier from header declaration
Date: Tue, 1 Jan 2008 17:57:32 +0100
Message-ID: <20080101165732.GB3488__36536.2597200603$1199207157$gmane$org@elte.hu>
References: <11979967763153-git-send-email-gcosta@redhat.com>
	<20071219101236.GB3521@elte.hu>
	<20071231164624.GA1738@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071231164624.GA1738@martell.zuzino.mipt.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > thanks, applied.
> > 
> > btw., people have been talking about reducing the include file mess 
> > for nearly a decade now,
> 
> Some of us are actually doing it. ;-)

sorry, this was really not meant to slight your contributions in this 
area in any way :-) I'm just judging by the spaghetti still hanging 
around in asm-x86/*.h, and the 'fun' we have with paravirt and its type 
dependencies - and the periodic messups we have with macros. (and many 
macros are not inlines due to ugly dependencies.)

> > So include file dependency flattening patches would be more than 
> > welcome as well.
> 
> Yup! Provided they're compile-tested sufficiently well.

as long as it builds/boots on your box with a single convenient .config 
of yours, we can stick such patches into x86.git and work out all the 
build failures it might cause.

> > (and unlike unification patches they have no expectation of being 
> > 100% perfect, so a natural ping-pong of fixes, until the changes are 
> > fully correct, would be natural.)
> 
> That way you'll never clean anything especially during merge window. 
> ;-)

hm, what do you mean?

	Ingo
