From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 4/4] KVM/vmx: enable lbr for the guest
Date: Wed, 27 Sep 2017 09:27:46 +0800
Message-ID: <59CAFE92.8090608__16440.8673336313$1506475516$gmane$org@intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
	<20170925145720.GM4311@tassilo.jf.intel.com>
	<59CA164B.1080707@intel.com>
	<20170926164114.GQ4311@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170926164114.GQ4311@tassilo.jf.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@linux.intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/27/2017 12:41 AM, Andi Kleen wrote:
>> 1) vCPU context switching and guest side task switching are not identical.
>> That is, when the vCPU is scheduled out, the guest task on the vCPU may not
> guest task lifetime has nothing to do with this. It's completely independent
> of what you do here on the VCPU level.
>
>> run out its time slice yet, so the task will continue to run when the vCPU
>> is
>> scheduled in by the host (lbr wasn't save by the guest task when the vCPU is
>> scheduled out in this case).
>>
>> It is possible to have the vCPU which runs the guest task (in use of lbr)
>> scheduled
>> out, followed by a new host task being scheduled in on the pCPU to run.
>> It is not guaranteed that the new host task does not use the LBR feature on
>> the
>> pCPU.
> Sure it may use the LBR, and the normal perf context switch
> will switch it and everything works fine.
>
> It's like any other per-task LBR user.

OK, I see the point, thanks.

Why couldn't we save the LBR_SELECT via task switching too?


Best,
Wei
