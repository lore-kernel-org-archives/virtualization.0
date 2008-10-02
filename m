From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Wed, 01 Oct 2008 17:57:56 -0700
Message-ID: <48E41C94.7040904__19156.1188702055$1222958989$gmane$org@kernel.org>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>	
	<1222894878.9381.63.camel@alok-dev1>
	<48E3E8DE.1080602@goop.org>	 <48E3ECD1.30809@codemonkey.ws>
	<1222904824.7330.83.camel@bodhitayantram.eng.vmware.com>
	<48E4183A.7090208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E4183A.7090208@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Anthony Liguori <anthony@codemonkey.ws>, Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> 
> Ah, if it was only that simple.  Transmeta actually did this, but it's 
> not as useful as you think.
> 

For what it's worth, Transmeta's implementation used CPUID leaf 
0x80860001.ECX to give the TSC frequency rounded to the nearest MHz. 
The caveat of spread-spectrum modulation applies.

	-hpa
