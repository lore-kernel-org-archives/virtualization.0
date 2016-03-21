From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2 5/6] virt, sched: add cpu pinning to
	smp_call_sync_on_phys_cpu()
Date: Mon, 21 Mar 2016 14:14:03 +0000
Message-ID: <56F001AB.2000600@citrix.com>
References: <1458563075-30298-1-git-send-email-jgross@suse.com>
	<1458563075-30298-6-git-send-email-jgross@suse.com>
	<56F0087202000078000DED9F@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56F0087202000078000DED9F@prv-mh.provo.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>, Juergen Gross <JGross@suse.com>
Cc: jeremy@goop.org, hpa@zytor.com, peterz@infradead.org, x86@kernel.org, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, Jean Delvare <jdelvare@suse.com>, mingo@redhat.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, boris.ostrovsky@oracle.com, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On 21/03/16 13:42, Jan Beulich wrote:
>
> Also don't you need to call smp_processor_id() after preempt_disable()?

I suggest using get_cpu()/put_cpu() here.

David
