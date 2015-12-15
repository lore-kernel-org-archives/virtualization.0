From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Tue, 15 Dec 2015 10:21:37 -0500
Message-ID: <56703001.9010205@oracle.com>
References: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
	<1447970147-1733-2-git-send-email-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447970147-1733-2-git-send-email-boris.ostrovsky@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, david.vrabel@citrix.com, luto@kernel.org, xen-devel@lists.xenproject.org, bp@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On 11/19/2015 04:55 PM, Boris Ostrovsky wrote:
> After 32-bit syscall rewrite, and specifically after commit 5f310f739b4c
> ("x86/entry/32: Re-implement SYSENTER using the new C path"), the stack
> frame that is passed to xen_sysexit is no longer a "standard" one (i.e.
> it's not pt_regs).
>
> Since we end up calling xen_iret from xen_sysexit we don't need to fix
> up the stack and instead follow entry_SYSENTER_32's IRET path directly
> to xen_iret.
>
> We can do the same thing for compat mode even though stack does not need
> to be fixed. This will allow us to drop usergs_sysret32 paravirt op (in
> the subsequent patch)
>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>


I know this has been in the tip tree --- when do you think this will go 
Linus tree? In the 4.4 timeframe?

Xen 32-bit PV guests are broken without this.


Thanks.
-boris
