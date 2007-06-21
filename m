From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 0/5] KVM paravirt_ops backend (v3)
Date: Wed, 20 Jun 2007 22:04:15 -0500
Message-ID: <4679EAAF.2060103@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This is an update to the paravirt_ops KVM backend series.  I've made a 
number of changes and attempted to incorporate all the feedback from the 
last review.  Some highlights:

1) Clean up the paravirt time source patch to use a more Xen-like model
2) Change the hypercall queueing to pass a PA on the flush hypercall
3) Add MMU support for release_{pt,pd} and TLB flush
4) Use KVM specific errno values
5) Switch from per_cpu to more appropriate functions

As for performance, I've got a few interesting results.  kbuild with a 
guest using 2G of memory goes from 19 minutes to 12 minutes with the 
full series applied.  Using 512mb, the build time goes from 10.75 
minutes to 9 minutes.  For 512mb, native is around 7 minutes so that's 
pretty close to what Avi had seen.  The more dramatic improvement with 
large memory guests is probably because of the increased shadow page 
table activity due to high mem.

virtbench shows major improvements but I'm not 100% confident yet in the 
results as they are not very stable.  I don't yet have a benchmark that 
shows the benefit of the CR caching so if I don't find one, I'll drop 
that from the queue.

As usual, the latest bits are available at 
http://hg.codemonkey.ws/kvm-paravirt

Regards,

Anthony Liguori

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
