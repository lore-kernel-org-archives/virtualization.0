From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Signed bit field; int have_hotplug_status_watch:1
Date: Sun, 3 Apr 2011 22:32:41 +0100
Message-ID: <20110403213241.GA25913@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Ian.Campbell@citrix.com, virtualization@lists.linux-foundation.org
Cc: jeremy.fitzhardinge@citrix.com, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Ian,
   I've been going through some sparse scans of the kernel and
it threw up:

  CHECK   drivers/net/xen-netback/xenbus.c
drivers/net/xen-netback/xenbus.c:29:40: error: dubious one-bit signed bitfield

        int have_hotplug_status_watch:1;

from your patch f942dc2552b8bfdee607be867b12a8971bb9cd85 

It does look like that should be an unsigned (given it's assigned
0 and 1)

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
