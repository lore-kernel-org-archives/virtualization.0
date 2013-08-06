From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V11 0/18] Paravirtualized ticket spinlocks
Date: Tue, 06 Aug 2013 08:20:28 +0530
Message-ID: <52006474.6010109@linux.vnet.ibm.com>
References: <20130722061631.24737.75508.sendpatchset@codeblue>
	<52002C49.1060201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <52002C49.1060201@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/06/2013 04:20 AM, H. Peter Anvin wrote:
> So, having read through the entire thread I *think* this is what the
> status of this patchset is:
>
> 1. Patches 1-17 are noncontroversial, Raghavendra is going to send an
>     update split into two patchsets;

Yes.  Only one patch would be common to both host and guest which will
be sent as a separate patch.
I 'll rebase first patchset to -next and second patchset to kvm tree as
needed.

> 2. There are at least two versions of patch 15; I think the "PATCH
>     RESEND RFC" is the right one.

True.

> 3. Patch 18 is controversial but there are performance numbers; these
>     should be integrated in the patch description.

Current plan is to drop for patch 18 for now.
