From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH V13 4/4] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Wed, 28 Aug 2013 13:01:42 -0500
Message-ID: <1377712902.2737.137@driftwood>
References: <y>
	<1377506916-26946-5-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1377506916-26946-5-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	(from raghavendra.kt@linux.vnet.ibm.com on Mon Aug 26 03:48:36 2013)
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: jeremy@goop.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, drjones@redhat.com, konrad.wilk@oracle.com, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/26/2013 03:48:36 AM, Raghavendra K T wrote:
> KVM_HC_KICK_CPU  hypercall added to wakeup halted vcpu in paravirtual  
> spinlock
> enabled guest.
> 
> KVM_FEATURE_PV_UNHALT enables guest to check whether pv spinlock can  
> be enabled
> in guest.
> 
> Thanks Vatsa for rewriting KVM_HC_KICK_CPU
> Cc: Rob Landley <rob@landley.net>

Looks like documentation to me:

Acked-by: Rob Landley <rob@landley.net>

Rob
