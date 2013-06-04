From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Tue, 04 Jun 2013 16:28:33 +0530
Message-ID: <51ADC859.6060507__12836.8088197478$1370343291$gmane$org@linux.vnet.ibm.com>
References: <20130601082145.22955.33596.sendpatchset@codeblue>
	<20130601201442.GP6123@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130601201442.GP6123@two.firstfloor.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, srivatsa.vaddagiri@gmail.com, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/02/2013 01:44 AM, Andi Kleen wrote:
>
> FWIW I use the paravirt spinlock ops for adding lock elision
> to the spinlocks.
>
> This needs to be done at the top level (so the level you're removing)
>
> However I don't like the pv mechanism very much and would
> be fine with using an static key hook in the main path
> like I do for all the other lock types.
>
> It also uses interrupt ops patching, for that it would
> be still needed though.
>

Hi Andi, IIUC, you are okay with the current approach overall right?
