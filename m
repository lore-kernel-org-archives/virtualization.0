From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtual: Documentation: simplify and generalize
	paravirt_ops.txt
Date: Thu, 12 Feb 2015 10:35:53 +1030
Message-ID: <87lhk4at9a.fsf@rustcorp.com.au>
References: <1423614583-31024-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1423614583-31024-1-git-send-email-mcgrof@do-not-panic.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, chrisw@sous-sol.org, akataria@vmware.com, jeremy@goop.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, kvm@vger.kernel.org, mcgrof@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Isaku Yamahata <yamahata@valinux.co.jp>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> The general documentation we have for pv_ops is currenty present
> on the IA64 docs, but since this documentation covers IA64 xen
> enablement and IA64 Xen support got ripped out a while ago
> through commit d52eefb47 present since v3.14-rc1 lets just
> simplify, generalize and move the pv_ops documentation to a
> shared place.

OK, I've applied this.

Thanks,
Rusty.
