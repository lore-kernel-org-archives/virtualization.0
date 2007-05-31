From: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Subject: Re: [PATCH 1/3] KVM paravirt_ops infrastructure
Date: Thu, 31 May 2007 12:11:16 +0200
Message-ID: <20070531101116.GA10872@elte.hu>
References: <465D8F03.7000201@us.ibm.com> <465D8FA7.9050600@us.ibm.com>
	<1180573347.30202.135.camel@localhost.localdomain>
	<200705311158.28632.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200705311158.28632.ak-l3A5Bk7waGM@public.gmane.org>
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
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org


* Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org> wrote:

> 
> > > +       if (wrmsr_safe(MSR_KVM_API_MAGIC, __pa(para_state), 0)) {
> > > +               printk(KERN_INFO "KVM guest: WRMSR probe failed.\n");
> > > +               return -ENOENT;
> > > +       }
> > 
> > How about printk(KERN_INFO "I am not a KVM guest\n");?
> 
> Actually paravirt probes that fail should be silent; similar like 
> drivers that don't find their hardware should do the same. Otherwise 
> if there are later distro kernels with various of those compiled in 
> the boot log would become quite noisy

yeah. I suspect printing that it's executing in native mode is OK.

	Ingo

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
