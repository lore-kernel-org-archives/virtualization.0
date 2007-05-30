From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [kvm-devel] [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 13:40:07 -0700
Message-ID: <97D612E30E1F88419025B06CB4CF1BE10259AE6D__39352.7395827279$1180557705$gmane$org@scsmsx412.amr.corp.intel.com>
References: <465DCED8.4080506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
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

Anthony Liguori wrote:
> Nakajima, Jun wrote:

<snip>

> > For KVM, it should be okay as well. But we can replace two CR4
accesses
> > with just one hypercall. 
> > 
> 
> I was thinking the same thing :-)
> 
> I was actually thinking about adding a hypercall to set/clear a bit in
a
> control register.  The thought here is that it would be useful not
just
> for the global bit but also for CR0.TS although we would need another
> paravirt_op hook for stts.

Given the optimizations for CPU virtualization in the current H/W, I'm
not sure if such hooks are useful. Do you have any performance data that
justify such hooks? 

> 
> Regards,
> 
> Anthony Liguori
> 


Jun
---
Intel Open Source Technology Center
