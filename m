From: Andi Kleen <andi@firstfloor.org>
Subject: netlink versus pid namespaces
Date: Fri, 15 Oct 2010 16:23:57 +0200
Message-ID: <20101015142357.GA29321__38611.8802628063$1287152685$gmane$org@basil.fritz.box>
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
To: netdev@vger.kernel.org, xemul@openvz.org, kuznet@ms2.inr.ac.ru, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I have been trying to figure out how pid namespaces interact
with netlink.

netlink uses pids (or really tids I hope?) to address sockets
associated with processes.

The netlink code passes around pids without caring much about 
the pid namespace.  It does pass around some information about the 
network namespace, but that doesn't help here because the pid
namespace is not necessarily related to the net namespace.

When the netlink consumer runs in kernel (like rtnetlink) and
happens to run in the same process context while receiving
and processing the data it should do the right thing because
it has the same pid namespace.

If it runs in some other process that is not guaranteed and
it may actually send the reply back to the wrong pid.

When a process receives netlink in user space and it isn't
in the same pid space as the sender it is unlikely that
the reply gets back.

Anything I'm missing here? 

Does netlink need to be extended? 
Or perhaps forbid passing netlink between name spaces?

Thanks,
-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
