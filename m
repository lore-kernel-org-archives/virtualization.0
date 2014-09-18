From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 07:43:09 -0700
Message-ID: <541AEF7D.2010007@zytor.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<2aa00301e9af4826b5781e01709f81e7@BY2PR0301MB0711.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2aa00301e9af4826b5781e01709f81e7@BY2PR0301MB0711.namprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: KY Srinivasan <kys@microsoft.com>, Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>, kvm list <kvm@vger.kernel.org>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Theodore Ts'o <tytso@mit.edu>
List-Id: virtualization@lists.linuxfoundation.org

On 09/18/2014 07:40 AM, KY Srinivasan wrote:
>>
>> The main questions are what MSR index to use and how to detect the
>> presence of the MSR.  I've played with two approaches:
>>
>> 1. Use CPUID to detect the presence of this feature.  This is very easy for
>> KVM to implement by using a KVM-specific CPUID feature.  The problem is
>> that this will necessarily be KVM-specific, as the guest must first probe for
>> KVM and then probe for the KVM feature.  I doubt that Hyper-V, for
>> example, wants to claim to be KVM.  If we could standardize a non-
>> hypervisor-specific CPUID feature, then this problem would go away.
> 
> We would prefer a CPUID feature bit to detect this feature.
>  

I guess if we're introducing the concept of pan-OS MSRs we could also
have pan-OS CPUID.  The real issue is to get a single non-conflicting
standard.

	-hpa
