From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 00/11] xen: Initial kexec/kdump implementation
Date: Wed, 26 Dec 2012 20:02:30 -0800
Message-ID: <50DBC856.6030208@zytor.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 12/26/2012 06:18 PM, Daniel Kiper wrote:
> Hi,
>
> This set of patches contains initial kexec/kdump implementation for Xen v3.
> Currently only dom0 is supported, however, almost all infrustructure
> required for domU support is ready.
>
> Jan Beulich suggested to merge Xen x86 assembler code with baremetal x86 code.
> This could simplify and reduce a bit size of kernel code. However, this solution
> requires some changes in baremetal x86 code. First of all code which establishes
> transition page table should be moved back from machine_kexec_$(BITS).c to
> relocate_kernel_$(BITS).S. Another important thing which should be changed in that
> case is format of page_list array. Xen kexec hypercall requires to alternate physical
> addresses with virtual ones. These and other required stuff have not been done in that
> version because I am not sure that solution will be accepted by kexec/kdump maintainers.
> I hope that this email spark discussion about that topic.
>

I want a detailed list of the constraints that this assumes and 
therefore imposes on the native implementation as a result of this.  We 
have had way too many patches where Xen PV hacks effectively nailgun 
arbitrary, and sometimes poor, design decisions in place and now we 
can't fix them.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
