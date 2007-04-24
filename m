From: Chris Snook <csnook@redhat.com>
Subject: Re: SMP lockup in virtualized environment
Date: Tue, 24 Apr 2007 18:37:51 -0400
Message-ID: <462E86BF.7010402__36720.6154777252$1177454342$gmane$org@redhat.com>
References: <462E4223.1050109@trango-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462E4223.1050109@trango-systems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: LAPLACE Cyprien <cyprien.laplace@trango-systems.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

LAPLACE Cyprien wrote:
> An example: in kernel/pid.c:alloc_pid(), if one of the guest CPUs is
> descheduled when holding the pidmap_lock, what happens to the other
> guest CPUs who want to alloc/free pids ? Are they blocked too ?

Yup.  This is where it's really nice to have directed yields, where you tell the 
hypervisor to give your physical CPU time to the vcpu that's holding the lock 
you're blocking on.  I know s390 can do this.  Perhaps it's something worth 
generalizing in paravirt_ops?

	-- Chris
