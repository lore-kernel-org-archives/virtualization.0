From: "Christopher S. Aker" <caker@theshore.net>
Subject: Xen paravirt frontend block hang
Date: Wed, 26 Dec 2007 14:33:34 -0500
Message-ID: <4772AC8E.7010007@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Sorry for the noise if this isn't the appropriate venue for this.  I 
posted this last month to xen-devel:

http://lists.xensource.com/archives/html/xen-devel/2007-11/msg00777.html

I can reliably cause a paravirt_ops Xen guest to hang during intensive 
IO.  My current recipe is an untar/tar loop, without compression, of a 
kernel tree.  For example:

wget http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.23.tar.bz2
bzip2 -d linux-2.6.23.tar.bz2

while true;
   echo `date`
   tar xf linux-2.6.23.tar
   tar cf linux-2.6.23.tar linux-2.6.23
done

After a few loops, anything that touches the xvd device that hung will 
get stuck in D state.

This happens on both a 2.6.16 and 2.6.18 dom0 (3.1.2 tools).  Paravirt 
guests I've tried that exhibit the problem: 2.6.23.8, 2.6.23.12, and 
2.6.24-rc6.  It does *not* occur using the Xensource 2.6.18 domU tree 
from 3.1.2.  In all cases, the host continues to run fine, nothing out 
of the ordinary is logged on the dom0 side, xenstore reports the status 
of the devices is fine.

Can anyone reproduce this problem, or let me know what else I can 
provide to help track this down?

Thanks,
-Chris
