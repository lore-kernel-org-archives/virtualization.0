From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 00/11] x86: xen cpuid() cleanup
Date: Thu, 13 Apr 2017 09:39:47 -0400
Message-ID: <984b9d1c-d822-643f-4004-d27e45a464c4@oracle.com>
References: <20170413101116.723-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170413101116.723-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: x86@kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 04/13/2017 06:11 AM, Juergen Gross wrote:
> Reduce special casing of xen_cpuid() by using cpu capabilities instead
> of faked cpuid nodes.
>
> This cleanup enables us remove the hypervisor specific set_cpu_features
> callback as the same effect can be reached via
> setup_[clear|force]_cpu_cap().
>
> Removing the rest faked nodes from xen_cpuid() requires some more work
> as the remaining cases (mwait leafs and extended topology info) have
> to be handled at the consumer sides of this information.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


-boris
