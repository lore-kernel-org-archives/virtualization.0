From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 2/2] KVM: Handle interrupts for PCI passthrough
	devices
Date: Fri, 02 May 2008 16:16:09 +0300
Message-ID: <481B1419.8060009__12787.050594534$1209734323$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<200804222258.40644.amit.shah@qumranet.com>
	<481AEE65.2010303@qumranet.com>
	<200805021835.47565.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805021835.47565.amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, virtualization@lists.linux-foundation.org, gcosta@redhat.com, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
>
>> Seems to me the only choice here is to mask the interrupt at the ioapic
>> level, wait until the guest acks the interrupt, then unmask the interrupt.
>>     
>
> OK; will that create problems if the line is shared?
>
>   

It will not work with shared interrupts (unless all users of the 
interrupt are in the same guest).

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
