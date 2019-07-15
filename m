From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/2] Remove 32-bit Xen PV guest support
Date: Mon, 15 Jul 2019 09:34:00 -0700
Message-ID: <87y30zfe9z.fsf__43147.7572464914$1563208451$gmane$org@linux.intel.com>
References: <20190715113739.17694-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190715113739.17694-1-jgross@suse.com> (Juergen Gross's message
	of "Mon, 15 Jul 2019 13:37:37 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org, Alok Kataria <akataria@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Juergen Gross <jgross@suse.com> writes:

> The long term plan has been to replace Xen PV guests by PVH. The first
> victim of that plan are now 32-bit PV guests, as those are used only
> rather seldom these days. Xen on x86 requires 64-bit support and with
> Grub2 now supporting PVH officially since version 2.04 there is no
> need to keep 32-bit PV guest support alive in the Linux kernel.
> Additionally Meltdown mitigation is not available in the kernel running
> as 32-bit PV guest, so dropping this mode makes sense from security
> point of view, too.

Normally we have a deprecation period for feature removals like this.
You would make the kernel print a warning for some releases, and when
no user complains you can then remove. If a user complains you can't.

-Andi
