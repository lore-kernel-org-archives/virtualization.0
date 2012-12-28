From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH v3 06/11] x86/xen: Add i386 kexec/kdump implementation
Date: Thu, 27 Dec 2012 19:16:46 -0800
Message-ID: <87han6n9wh.fsf@xmission.com>
References: <5698071f-c96c-4891-81d6-a77c4e3b77c2@default>
	<50DCDBD3.1020703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50DCDBD3.1020703@zytor.com> (H. Peter Anvin's message of "Thu,
	27 Dec 2012 15:37:55 -0800")
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
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 12/27/2012 03:23 PM, Daniel Kiper wrote:
>>> On 12/26/2012 06:18 PM, Daniel Kiper wrote:
>>>> Add i386 kexec/kdump implementation.
>>>>
>>>> v2 - suggestions/fixes:
>>>>      - allocate transition page table pages below 4 GiB
>>>>        (suggested by Jan Beulich).
>>>
>>> Why?
>>
>> Sadly all addresses are passed via unsigned long
>> variable to kexec hypercall.
>>
>
> So can you unf*ck your broken interface before imposing it on anyone
> else?

Hasn't 32bit dom0 been retired?

Untill the kexec firmware pass through and the normal kexec code paths
are separated I can't make sense out of this code.

The normal kexec code path should be doable without any special
constraints on the kernel.  Just leaning on some xen paravirt calls.

The kexec pass through probably should not even touch x86 arch code.

Certainly the same patch should not have code for both the xen kexec
pass through and the paravirt arch code for the normal kexec path.

Eric
