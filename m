From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH RFC V6 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Thu, 26 Apr 2012 10:57:12 -0500
Message-ID: <4F997058.6070509__32803.4947663129$1335536342$gmane$org@landley.net>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
	<20120423100034.30893.81866.sendpatchset@codeblue.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120423100034.30893.81866.sendpatchset@codeblue.in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, X86 <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/23/2012 05:00 AM, Raghavendra K T wrote:
> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> 
...
> --- /dev/null
> +++ b/Documentation/virtual/kvm/hypercalls.txt
> @@ -0,0 +1,59 @@
> +KVM Hypercalls Documentation
> +===========================
> +Template for documentation is
> +The documenenation for hypercalls should inlcude

What does the line about templates mean/

documenenation? inlcude?

> +1. Hypercall name, value.
> +2. Architecture(s)
> +3. status (deprecated, obsolete, active)
> +4. Purpose
> +
> +
> +1. KVM_HC_VAPIC_POLL_IRQ
> +------------------------
> +value: 1
> +Architecture: x86
> +Purpose:

Purpose: none.

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
