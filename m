From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Wed, 29 Oct 2014 14:45:41 +0100
Message-ID: <5450EF85.8090500@redhat.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
	<5450C35D.1030907@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5450C35D.1030907@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Doug Covelli <dcovelli@vmware.com>, Jim Mattson <jmattson@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



On 10/29/2014 11:37 AM, Andrew Cooper wrote:
> While testing various nested combinations, XenServer has found that
> modern Windows Server versions must have the hypervisor bit hidden from
> them for them to be happy running HyperV, despite the fact that they
> will make use of the Viridian virtual extensions also provided.

Right.

> As a result, while it is certainly advisable for the hypervisor bit to
> be set, CommonHV should be available to be found by paravirtualised
> drivers inside an OS which can't cope with the hypervisor bit set.

Microsoft should just stop putting arbitrary limitations on their
software; or pay the price which, in this case, is not being able to use
the features from the common specification.  I guess what they'd do is
reinvent the RNG as a Viridian extension (if they need it).

You can certainly do CPUID(0x4F000000) even if HYPERVISOR=0.  What you
get back is undefined, but in all likelihood it won't be the
"CommonHVIntf" string.

Paolo
