From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Thu, 31 May 2007 11:12:13 +1000
Message-ID: <1180573933.30202.145.camel@localhost.localdomain>
References: <97D612E30E1F88419025B06CB4CF1BE10259AD95@scsmsx412.amr.corp.intel.com>
	<465DCED8.4080506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465DCED8.4080506@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-30 at 14:22 -0500, Anthony Liguori wrote:
> I was actually thinking about adding a hypercall to set/clear a bit in a 
> control register.  The thought here is that it would be useful not just 
> for the global bit but also for CR0.TS although we would need another 
> paravirt_op hook for stts.

We don't really need one, because Linux (i386) only cares about the TS
bit of cr0.  From lguest (you'd want this per-cpu of course):

        static unsigned long current_cr0, current_cr3;
        static void lguest_write_cr0(unsigned long val)
        {
        	lazy_hcall(LHCALL_TS, val & 8, 0, 0);
        	current_cr0 = val;
        }
        
        static unsigned long lguest_read_cr0(void)
        {
        	return current_cr0;
        }

Cheers,
Rusty.
