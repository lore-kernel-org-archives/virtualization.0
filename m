From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Mon, 14 May 2012 10:27:27 +0530
Message-ID: <87y5ovtl54.fsf__29206.5740250566$1336972341$gmane$org@abhimanyu.in.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
	<20120507082928.GI16608@gmail.com> <4FA7888F.80505@redhat.com>
	<4FA7AAD8.6050003@linux.vnet.ibm.com> <4FA7BABA.4040700@redhat.com>
	<4FA7CC05.50808@linux.vnet.ibm.com> <4FA7CCA2.4030408@redhat.com>
	<4FA7D06B.60005@linux.vnet.ibm.com>
	<20120507134611.GB5533@linux.vnet.ibm.com>
	<4FA7D2E5.1020607@redhat.com> <4FA7D3F7.9080005@linux.vnet.ibm.com>
	<4FA7D50D.1020209@redhat.com> <4FA7E06E.20304@linux.vnet.ibm.com>
	<4FA7E1C8.7010509@redhat.com> <4FB0014A.90604@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FB0014A.90604@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 14 May 2012 00:15:30 +0530, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
> On 05/07/2012 08:22 PM, Avi Kivity wrote:
> 
> I could not come with pv-flush results (also Nikunj had clarified that
> the result was on NOn PLE
> 
Did you see any issues on PLE?

Regards,
Nikunj
