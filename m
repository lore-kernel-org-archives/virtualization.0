From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/6] x86: reduce paravirtualized spinlock overhead
Date: Tue, 05 May 2015 10:21:30 -0700
Message-ID: <5548FC1A.7000806@goop.org>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
	<55425ADA.4060105@goop.org> <554709BB.7090400@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <554709BB.7090400@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/03/2015 10:55 PM, Juergen Gross wrote:
> I did a small measurement of the pure locking functions on bare metal
> without and with my patches.
>
> spin_lock() for the first time (lock and code not in cache) dropped from
> about 600 to 500 cycles.
>
> spin_unlock() for first time dropped from 145 to 87 cycles.
>
> spin_lock() in a loop dropped from 48 to 45 cycles.
>
> spin_unlock() in the same loop dropped from 24 to 22 cycles.

Did you isolate icache hot/cold from dcache hot/cold? It seems to me the
main difference will be whether the branch predictor is warmed up rather
than if the lock itself is in dcache, but its much more likely that the
lock code is icache if the code is lock intensive, making the cold case
moot. But that's pure speculation.

Could you see any differences in workloads beyond microbenchmarks?

Not that its my call at all, but I think we'd need to see some concrete
improvements in real workloads before adding the complexity of more pvops.

    J
