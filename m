From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH] paravirt: remove unused pv_apic_ops structure
Date: Tue, 17 Nov 2015 13:51:31 +0000
Message-ID: <564B30E3.80401__31923.1246402071$1447768902$gmane$org@citrix.com>
References: <1447767872-16730-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447767872-16730-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, xen-devel@lists.xen.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 17/11/15 13:44, Juergen Gross wrote:
> The only member of that structure is startup_ipi_hook which is always
> set to paravirt_nop.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
