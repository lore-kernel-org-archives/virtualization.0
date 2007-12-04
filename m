From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 4/8] unify paravirt parts of system.h
Date: Tue, 4 Dec 2007 17:41:41 -0200
Message-ID: <5d6222a80712041141p5fbc0c0ei68696f054cc8a303__38894.6294239306$1196797611$gmane$org@mail.gmail.com>
References: <11967843881946-git-send-email-gcosta@redhat.com>
	<11967843943958-git-send-email-gcosta@redhat.com>
	<11967843983411-git-send-email-gcosta@redhat.com>
	<11967844032081-git-send-email-gcosta@redhat.com>
	<11967844071346-git-send-email-gcosta@redhat.com>
	<4755A809.4050305@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4755A809.4050305@qumranet.com>
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
To: Avi Kivity <avi@qumranet.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Dec 4, 2007 5:18 PM, Avi Kivity <avi@qumranet.com> wrote:
> Glauber de Oliveira Costa wrote:
> > This patch moves the i386 control registers manipulation functions,
> > wbinvd, and clts functions to system.h. They are essentially the same
> > as in x86_64, except for the cr8 register, which we add.
> >
> > +
> > +static inline unsigned long native_read_cr8(void)
> > +{
> > +     unsigned long cr8;
> > +     asm volatile("mov %%cr8,%0" : "=r" (cr8), "=m" (__force_order));
> > +     return cr8;
> > +}
> > +
> >
>
> There is no cr8 register on i386.  This had better be protected by an
> #ifdef.

Sure. I mentioned it in the changelog. I, however, am not sure If I
agree it should be enclosed
in ifdefs. Me and Jeremy discussed it a while ago, and we seem to
agree that for those functions
that are exclusive of one architecture, there were no need for ifdefs.
Any usage by the other arch
is a bug.

But I admit that I'm not particularly biased here, and I can change
it, if there's agreement that
an ifdef here is the way to go.

> (you're likely not getting an error since it's a static inline, so the
> asm is never emitted)
>
Which also means it does not affect the binary in anyway. No bigger
code, no nothing.
My current approach is to save the ifdefs for pieces that in fact can
save us some resources
in the final image. But again... I can change it.



-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
