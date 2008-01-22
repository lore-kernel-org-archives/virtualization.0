From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/10] Tree fixes for PARAVIRT
Date: Tue, 22 Jan 2008 13:20:58 +0100
Message-ID: <20080122122058.GC31253__32102.2580181763$1201004587$gmane$org@elte.hu>
References: <12006768251548-git-send-email-gcosta@redhat.com>
	<20080118203259.GA3079@elte.hu> <20080118213711.GA24979@elte.hu>
	<1200693248.21817.157.camel@bodhitayantram.eng.vmware.com>
	<20080118220200.GA1071@elte.hu>
	<5d6222a80801181724p40bdedebgded1d43b052d168e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d6222a80801181724p40bdedebgded1d43b052d168e@mail.gmail.com>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <glommer@gmail.com> wrote:

> On Jan 18, 2008 8:02 PM, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Zachary Amsden <zach@vmware.com> wrote:
> >
> > > > but in exchange you broke all of 32-bit with CONFIG_PARAVIRT=y.
> > > > Which means you did not even build-test it on 32-bit, let alone boot
> > > > test it...
> > >
> > > Why are we rushing so much to do 64-bit paravirt that we are breaking
> > > working configurations?  If the developement is going to be this
> > > chaotic, it should be done and tested out of tree until it can
> > > stabilize.
> >
> > what you see is a open feedback cycle conducted on lkml. People send
> > patches for arch/x86, and we tell them if it breaks something. The bug
> > was found before i pushed out the x86.git devel tree (and the fix is
> > below - but this shouldnt matter to you because the bug never hit a
> > public x86.git tree).
> >
> >         Ingo
> >
> Other than this, it seems to build and boot fine.
> 
> Do you want me to resend ?

no, this was the only small problem i found, your series looks good to 
me and is included in latest x86.git.

	Ingo
