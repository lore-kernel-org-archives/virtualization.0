From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH 1/3] KVM paravirt_ops infrastructure
Date: Thu, 31 May 2007 21:12:31 +1000
Message-ID: <1180609951.11133.43.camel@localhost.localdomain>
References: <465D8F03.7000201@us.ibm.com> <200705311158.28632.ak@suse.de>
	<20070531101116.GA10872@elte.hu>  <200705311240.19794.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200705311240.19794.ak-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-05-31 at 12:40 +0200, Andi Kleen wrote:
> On Thursday 31 May 2007 12:11:16 Ingo Molnar wrote:
> > 
> > * Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org> wrote:
> > 
> > > 
> > > > > +       if (wrmsr_safe(MSR_KVM_API_MAGIC, __pa(para_state), 0)) {
> > > > > +               printk(KERN_INFO "KVM guest: WRMSR probe failed.\n");
> > > > > +               return -ENOENT;
> > > > > +       }
> > > > 
> > > > How about printk(KERN_INFO "I am not a KVM guest\n");?
> > > 
> > > Actually paravirt probes that fail should be silent; similar like 
> > > drivers that don't find their hardware should do the same. Otherwise 
> > > if there are later distro kernels with various of those compiled in 
> > > the boot log would become quite noisy
> > 
> > yeah. I suspect printing that it's executing in native mode is OK.
> 
> But only a single printk for that please

Which already exists in paravirt.c:

static void __init default_banner(void)
{
	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
	       paravirt_ops.name);
}
...
static int __init print_banner(void)
{
	paravirt_ops.banner();
	return 0;
}
core_initcall(print_banner);

Hmm, this will predate your kvm initcall tho, and making that a
pure_initcall is pretty gross...

Cheers,
Rusty.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
