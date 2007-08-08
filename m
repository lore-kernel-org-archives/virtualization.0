From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Wed, 8 Aug 2007 11:08:25 -0300
Message-ID: <5d6222a80708080708h43b1521cp734bedd27f94723e__30678.7194255323$1186582451$gmane$org@mail.gmail.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468394005-git-send-email-gcosta@redhat.com>
	<11865468431616-git-send-email-gcosta@redhat.com>
	<200708081144.04119.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081144.04119.ak@suse.de>
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
> > -static void discover_ebda(void)
> > +void native_ebda_info(unsigned *addr, unsigned *size)
>
> I guess it would be better to use the resources frame work here.
> Before checking EBDA check if it is already reserved. Then lguest/Xen
> can reserve these areas and stop using it.
Let's make sure I understand: So you suggest skipping discover
altogether in case it is already reserved?

>
> > +/* Overridden in paravirt.c if CONFIG_PARAVIRT */
> > +void __attribute__((weak)) memory_setup(void)
> > +{
> > +       return setup_memory_region();
> > +}
> > +
> > +
> >  void __init setup_arch(char **cmdline_p)
> >  {
> >       printk(KERN_INFO "Command line: %s\n", boot_command_line);
> > @@ -231,12 +255,19 @@ void __init setup_arch(char **cmdline_p)
> >       saved_video_mode = SAVED_VIDEO_MODE;
> >       bootloader_type = LOADER_TYPE;
> >
> > +     /*
> > +      * By returning non-zero here, a paravirt impl can choose to
> > +      * skip the rest of the setup process
> > +      */
> > +     if (paravirt_arch_setup())
> > +             return;
>
> Sorry, but that's an extremly ugly and clumpsy interface and will lead
> to extensive code duplication in hypervisors because so much code
> is disabled.

We can just wipe out the return value right now. Note that it was a
choice, it would only lead to code duplication if the hypervisor
wanted it. But yeah, I understand your concern. They may chose to
return 1 here just to change some tiny thing in the bottom.

I don't know exactly what other kinds of hooks we could put there.
lguest surely didn't need any. Are you okay with just turning it into
void by now ?

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
