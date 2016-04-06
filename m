From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/6] smp: add function to execute a function
	synchronously on a cpu
Date: Wed, 6 Apr 2016 20:04:31 +0200
Message-ID: <20160406180431.GS3448@twins.programming.kicks-ass.net>
References: <1459952266-3687-1-git-send-email-jgross@suse.com>
	<1459952266-3687-4-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1459952266-3687-4-git-send-email-jgross@suse.com>
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
Cc: x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, hpa@zytor.com, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 06, 2016 at 04:17:43PM +0200, Juergen Gross wrote:
> On some hardware models (e.g. Dell Studio 1555 laptop) some hardware
> related functions (e.g. SMIs) are to be executed on physical cpu 0
> only. Instead of open coding such a functionality multiple times in
> the kernel add a service function for this purpose. This will enable
> the possibility to take special measures in virtualized environments
> like Xen, too.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
