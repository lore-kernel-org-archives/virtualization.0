From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V11 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Fri, 02 Aug 2013 08:52:07 +0530
Message-ID: <51FB25DF.5000203@linux.vnet.ibm.com>
References: <20130724103907.GF16400@redhat.com>
	<51EFC1D4.9060800@linux.vnet.ibm.com>
	<20130724120647.GG16400@redhat.com>
	<51EFCA42.5020009@linux.vnet.ibm.com>
	<51F0ED31.3040200@linux.vnet.ibm.com>
	<20130725091509.GA22735@redhat.com>
	<51F0F202.5090001@linux.vnet.ibm.com>
	<51F7ED20.80202@linux.vnet.ibm.com>
	<20130731062440.GK28372@redhat.com>
	<51FA1087.9080908@linux.vnet.ibm.com>
	<20130801074529.GO7484@redhat.com>
	<51FA2486.20507@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51FA2486.20507@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>, mingo@redhat.com
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/01/2013 02:34 PM, Raghavendra K T wrote:
> On 08/01/2013 01:15 PM, Gleb Natapov wrote:
>>> Shall I consider this as an ack for kvm part?
>>>
>> For everything except 18/18. For that I still want to see numbers. But
>> 18/18 is pretty independent from the reset of the series so it should
>> not stop the reset from going in.
>
> Yes. agreed.
> I am going to evaluate patch 18 separately and come with results for
> that. Now we can consider only 1-17 patches.
>

Gleb,

32 core machine with HT off 32 vcpu guests.
base = 3.11-rc + patch 1 -17 pvspinlock_v11
patched = base + patch 18

+-----------+-----------+-----------+------------+-----------+
                   dbench  (Throughput in MB/sec higher is better)
+-----------+-----------+-----------+------------+-----------+
       base      stdev       patched    stdev       %improvement
+-----------+-----------+-----------+------------+-----------+
1x 14584.3800   146.9074   14705.1000   163.1060     0.82773
2x  1713.7300    32.8750    1717.3200    45.5979     0.20948
3x   967.8212    42.0257     971.8855    18.8532     0.41994
4x   685.2764    25.7150     694.5881     8.3907     1.35882
+-----------+-----------+-----------+------------+-----------+

I saw -0.78% - .84% changes in ebizzy and 1-2% improvement in
hackbench.
