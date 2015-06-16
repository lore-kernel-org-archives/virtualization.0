From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] x86: reduce paravirtualized spinlock overhead
Date: Tue, 16 Jun 2015 17:18:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506161716050.4120__17864.8629844703$1434467953$gmane$org@nanos>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
	<558034B1.1030906@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <558034B1.1030906@suse.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, gleb@kernel.org, x86@kernel.org, akataria@vmware.com, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Peter Zijlstra <peterz@infradead.org>, david.vrabel@citrix.com, "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com, boris.ostrovsky@oracle.com, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 16 Jun 2015, Juergen Gross wrote:

> AFAIK there are no outstanding questions for more than one month now.
> I'd appreciate some feedback or accepting these patches.

They are against dead code, which will be gone soon. We switched over
to queued locks.

Thanks,

	tglx
