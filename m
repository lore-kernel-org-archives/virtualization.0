From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops implementation
Date: Wed, 20 Jun 2007 08:32:41 -0700
Message-ID: <46794899.6070708@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F9DE.6080806@goop.org>
	<4675FDCA.4040006@codemonkey.ws> <4676084F.3090901@goop.org>
	<46787325.30804@vmware.com> <4679381E.9090404@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4679381E.9090404-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Cc: Zachary Amsden <zach-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> I don't agree that having paravirt_ops within a normal module is all
> that useful.  By the time modules can be loaded, the kernel has
> completely booted.  There should only be a handful of paravirt_ops
> implementations and they aren't large so I don't think there's a big
> size savings either.

It doesn't seem terribly valuable to me either.  But Zach is talking
about something very similar to the kvm case, where you have a fully
virtualized environment (with hardware support), but then you load a
module containing paravirtualized helpers at some late stage which makes
things more efficient but isn't required for functional correctness.

>> More importantly, now device drivers for virtual devices would have a
>> way to inquire into which set of paravirt-ops was loaded by having an
>> official registered interface rather than an ad-hoc (if xxx_running
>> == 1) mess, and now the paravirt driver modules are nicely decoupled
>> from the boot-strap code and can be loaded dynamically.
>
> I'm not familiar with the particular problem here, but I don't think
> that driver modules should be checking to see what paravirt_ops is
> active.  Each VMM has it's own discovery mechanism (KVM and Xen are
> both based on CPUID) so that seems like a much better method to use.

I think he's referring to the xen/kvm/vmi paravirt implementation as a
"driver" here.  I think.

I don't know of any "if (xxx_running)" tests at present.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
