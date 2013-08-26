From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH V13 0/4] Paravirtualized ticket spinlocks for KVM host
Date: Mon, 26 Aug 2013 15:58:49 +0530
Message-ID: <521B2DE1.4060306@linux.vnet.ibm.com>
References: <y>
	<1377506916-26946-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20130826100401.GZ8218@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130826100401.GZ8218@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, drjones@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/26/2013 03:34 PM, Gleb Natapov wrote:
> On Mon, Aug 26, 2013 at 02:18:32PM +0530, Raghavendra K T wrote:
>>
>>   This series forms the kvm host part of paravirtual spinlock
>>   based against kvm tree.
>>
>>   Please refer to https://lkml.org/lkml/2013/8/9/265 for
>>   kvm guest and Xen, x86 part merged to -tip spinlocks.
>>
>>   Please note that:
>>   kvm uapi: Add KICK_CPU and PV_UNHALT definition to uapi is a common patch
>>   for both guest and host.
>>
> Thanks, applied. The patchset is not against kvm.git queue though, so I
> had to fix one minor conflict manually.

Thank you Gleb.
