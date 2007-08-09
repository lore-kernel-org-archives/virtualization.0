From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 4/25] [PATCH] Add debugreg/load_rsp native hooks
Date: Thu, 9 Aug 2007 02:49:46 -0300
Message-ID: <5d6222a80708082249yb51fc6p16718a6b55e8ef4b__29105.3748959259$1186638736$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
	<11865467702103-git-send-email-gcosta@redhat.com>
	<200708081116.43237.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081116.43237.ak@suse.de>
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
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On 8/8/07, Andi Kleen <ak@suse.de> wrote:
>
> >
> > @@ -264,13 +270,64 @@ struct thread_struct {
> >       set_fs(USER_DS);                                                         \
> >  } while(0)
> >
> > -#define get_debugreg(var, register)                          \
> > -             __asm__("movq %%db" #register ", %0"            \
> > -                     :"=r" (var))
> > -#define set_debugreg(value, register)                        \
> > -             __asm__("movq %0,%%db" #register                \
> > -                     : /* no output */                       \
> > -                     :"r" (value))
> > +static inline unsigned long native_get_debugreg(int regno)
> > +{
> > +     unsigned long val;
>
> It would be better to have own functions for each debug register I think
>
Andi, you mean:
a) split the debugreg paravirt_ops in various
paravirt_ops.set/get_debugreg{X,Y,Z...}, and then join them together
in a set/get_debugreg(a,b) to keep the current interface. OR
b) keep one paravirt_ops for each set/get_debugreg, then split then in
various set/get_debugregX(a, b), changing the current interface, OR
c) plit the debugreg paravirt_ops in various
paravirt_ops.set/get_debugreg{X,Y,Z...}, and give each its own
function set/get_debugregX(a, b), again, changing the current
interface, OR
d) None of the above?

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
