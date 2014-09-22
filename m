From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Mon, 22 Sep 2014 07:18:20 -0700
Message-ID: <54202FAC.5040200@zytor.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<541C765B.5050705@codeaurora.org>
	<CALCETrU_r90=ve4v6xKfZHR_2O5+f05URqD5fzkbSpcuV4tb8A@mail.gmail.com>
	<15C8041A-3488-4693-B329-3A9FE77A0CB9@gmail.com>
	<CALCETrXq2FJ4c6MeEHCVeY7muV6C1NpuKpmtr+PcnHV2DpF3Zg@mail.gmail.com>
	<541CA440.8080909@zytor.com> <542024CB.2070704@codeaurora.org>
	<54202F67.2010606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54202F67.2010606@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Nadav Amit <nadav.amit@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/22/2014 07:17 AM, H. Peter Anvin wrote:
> 
> It could, but how would you enumerate that?  A new "RDRAND-CPL-0" CPUID
> bit pretty much would be required.
> 

Note that there are two things that differ: the CPL 0-ness and the
performance/exhaustibility attributes.

	-hpa
