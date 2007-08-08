From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Wed, 8 Aug 2007 16:13:26 +0200
Message-ID: <200708081613.26613.ak__26395.8078380258$1186582828$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081144.04119.ak@suse.de>
	<5d6222a80708080708h43b1521cp734bedd27f94723e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708080708h43b1521cp734bedd27f94723e@mail.gmail.com>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 08 August 2007 16:08:25 Glauber de Oliveira Costa wrote:
> On 8/8/07, Andi Kleen <ak@suse.de> wrote:
> >
> > > -static void discover_ebda(void)
> > > +void native_ebda_info(unsigned *addr, unsigned *size)
> >
> > I guess it would be better to use the resources frame work here.
> > Before checking EBDA check if it is already reserved. Then lguest/Xen
> > can reserve these areas and stop using it.
> Let's make sure I understand: So you suggest skipping discover
> altogether in case it is already reserved?

Yes


> I don't know exactly what other kinds of hooks we could put there.
> lguest surely didn't need any. Are you okay with just turning it into
> void by now ?

Yes.

-Andi
