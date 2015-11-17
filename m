From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] paravirt: remove paravirt ops pmd_update_defer and
	pte_update_defer
Date: Tue, 17 Nov 2015 15:47:50 +0100
Message-ID: <564B3E16.8010003__21645.6478382044$1447771779$gmane$org@suse.com>
References: <1447771603-9918-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447771603-9918-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, xen-devel@lists.xen.org, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 17/11/15 15:46, Juergen Gross wrote:
> pte_update_defer can be removed as it is always set to the same
> function as pte_update. So any usage of pte_update_defer() can be
> replaced by pte_update().
> 
> pmd_update_defer is always set to paravirt_nop, so it can just be
> nuked.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sorry, hit send to early. Please forget this one.


Juergen
