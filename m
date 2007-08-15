From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 21/25][V3] export cpu_gdt_descr
Date: Wed, 15 Aug 2007 17:43:51 +0200
Message-ID: <20070815154351.GI3406__36303.1966648579$1187189511$gmane$org@bingen.suse.de>
References: <11871823373106-git-send-email-gcosta@redhat.com>
	<11871823673236-git-send-email-gcosta@redhat.com>
	<11871823782610-git-send-email-gcosta@redhat.com>
	<11871823892519-git-send-email-gcosta@redhat.com>
	<11871823991803-git-send-email-gcosta@redhat.com>
	<11871824081337-git-send-email-!gcosta@redhat.com>
	<11871824192375-git-send-email-gcosta@redhat.com>
	<11871824292046-git-send-email-gcosta@redhat.com>
	<20070815140339.GG3406@bingen.suse.de>
	<5d6222a80708150725i45a064bfqfd43139338287988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d6222a80708150725i45a064bfqfd43139338287988@mail.gmail.com>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 15, 2007 at 11:25:43AM -0300, Glauber de Oliveira Costa wrote:
> On 8/15/07, Andi Kleen <ak@suse.de> wrote:
> > > +#ifdef CONFIG_PARAVIRT
> > > +extern unsigned long *cpu_gdt_descr;
> >
> > No externs in .c files
> >
> > Normally they should be where the variable is defined
> > anyways.
> Given that this  variable is defined in head.S, what do you propose?

Move it to C code first.

-Andi
