From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 0/5] KVM paravirt_ops implementation
Date: Sun, 17 Jun 2007 21:56:34 -0500
Message-ID: <4675F462.1010708@codemonkey.ws>
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
To: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This patch series is an update of my previous paravirt_ops patches.  
They are loosely based on Ingo's original paravirt_ops implementation 
for KVM.  Some of the changes since the last series include:

1) Switch to using CPUID 0x40000000 instead of using MSR writes to 
discover shared memory area
2) Attempt to deal with SMP guests
3) Support for generic CR read caching
4) Support for batching of MMU operations

Some known issues:

1) Not really sure what is needed for CONFIG_PREEMPT support.  I'm not 
sure which paravirt_ops calls are actually re-entrant.
2) The paravirt_ops implementation is registered with core_initcall().  
However, the paravirt_ops banner is also printed with core_initcall() so 
that fact that this works now is just the luck of build order.  Need a 
better way to initialize the KVM paravirt_ops backend.
3) These patches probably break guest save/restore.  Need a generic way 
to get additional save/restore callbacks in the kernel (perhaps the 
in-kernel APIC series addresses this already?).

The latest versions of these patches are available at:

http://hg.codemonkey.ws/kvm-paravirt

Regards,

Anthony Liguori

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
