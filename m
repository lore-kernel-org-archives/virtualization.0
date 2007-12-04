From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Tue, 4 Dec 2007 14:14:13 -0800
Message-ID: <200712041414.14159.vda.linux__38788.9450452805$1196807565$gmane$org@googlemail.com>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<4755A809.4050305@qumranet.com>
	<5d6222a80712041141p5fbc0c0ei68696f054cc8a303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80712041141p5fbc0c0ei68696f054cc8a303@mail.gmail.com>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 04 December 2007 11:41, Glauber de Oliveira Costa wrote:
> On Dec 4, 2007 5:18 PM, Avi Kivity <avi@qumranet.com> wrote:
> > There is no cr8 register on i386.  This had better be protected by an
> > #ifdef.
>
> Sure. I mentioned it in the changelog. I, however, am not sure If I
> agree it should be enclosed
> in ifdefs. Me and Jeremy discussed it a while ago, and we seem to
> agree that for those functions
> that are exclusive of one architecture, there were no need for ifdefs.
> Any usage by the other arch
> is a bug.
>
> But I admit that I'm not particularly biased here, and I can change
> it, if there's agreement that
> an ifdef here is the way to go.
>
> > (you're likely not getting an error since it's a static inline, so the
> > asm is never emitted)
>
> Which also means it does not affect the binary in anyway. No bigger
> code, no nothing.

If future changes will mistakenly make 32-bit x86 call native_read_cr8(),
you will get no warning. (Hmmm. Maybe as will complain, I'm not sure).
If it explicitly ifdefed out for 32 bits, it's easier to detect misuse.
--
vda
