From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/6] smp: add function to execute a function
	synchronously on a physical cpu
Date: Fri, 1 Apr 2016 09:37:33 +0200
Message-ID: <20160401073733.GB3448@twins.programming.kicks-ass.net>
References: <1459494874-12194-1-git-send-email-jgross@suse.com>
	<1459494874-12194-3-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1459494874-12194-3-git-send-email-jgross@suse.com>
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
Cc: x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, hpa@zytor.com, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 01, 2016 at 09:14:30AM +0200, Juergen Gross wrote:
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;

> +	if (cpu != 0)
> +		return -EINVAL;

The other functions return -ENXIO for this.
