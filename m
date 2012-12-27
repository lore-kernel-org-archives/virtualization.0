From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 00/11] xen: Initial kexec/kdump implementation
Date: Thu, 27 Dec 2012 15:40:50 -0800 (PST)
Message-ID: <bd591d7e-5e78-4df1-af68-5c0e596a80f6__28001.9831065603$1356651693$gmane$org@default>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: hpa@zytor.com
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> On 12/26/2012 06:18 PM, Daniel Kiper wrote:
> > Hi,
> >
> > This set of patches contains initial kexec/kdump implementation for Xen v3.
> > Currently only dom0 is supported, however, almost all infrustructure
> > required for domU support is ready.
> >
> > Jan Beulich suggested to merge Xen x86 assembler code with baremetal x86 code.
> > This could simplify and reduce a bit size of kernel code. However, this solution
> > requires some changes in baremetal x86 code. First of all code which establishes
> > transition page table should be moved back from machine_kexec_$(BITS).c to
> > relocate_kernel_$(BITS).S. Another important thing which should be changed in that
> > case is format of page_list array. Xen kexec hypercall requires to alternate physical
> > addresses with virtual ones. These and other required stuff have not been done in that
> > version because I am not sure that solution will be accepted by kexec/kdump maintainers.
> > I hope that this email spark discussion about that topic.
>
> I want a detailed list of the constraints that this assumes and 
> therefore imposes on the native implementation as a result of this.  We 
> have had way too many patches where Xen PV hacks effectively nailgun 
> arbitrary, and sometimes poor, design decisions in place and now we 
> can't fix them.

OK but now I think that we should leave this discussion
until all details regarding kexec/kdump generic code
will be agreed. Sorry for that.

Daniel
