From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 17:58:25 +0200
Message-ID: <541B0121.8040503@redhat.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<2aa00301e9af4826b5781e01709f81e7@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<541AEF7D.2010007@zytor.com>
	<CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
	<CALCETrWj+uazLFuy84abnDYCu5D7OYQh9=yNj4gFcoEMO8b+gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWj+uazLFuy84abnDYCu5D7OYQh9=yNj4gFcoEMO8b+gA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Gleb Natapov <gleb@kernel.org>, Theodore Ts'o <tytso@mit.edu>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Il 18/09/2014 17:44, Andy Lutomirski ha scritto:
> Slight correction: QEMU/KVM has optional support for Hyper-V feature
> enumeration.  Ideally the RNG seed mechanism would be enabled by
> default, but I don't know whether the QEMU maintainers would be okay
> with enabling the Hyper-V cpuid mechanism in a default configuration.

Some guests cannot find the KVM leaves at 0x40000100, so it wouldn't be
great.  And I also don't know what VMware folks would think, but I think
they would be even less thrilled than me.

Note that even if there is no well-defined CPUID leaf, and the main
detection mechanism is #GP, each hypervisor is free to define a CPUID
bit of its own.

However, if it's going to be an architectural (Intel-defined) MSR, I
think the right place for a feature bit is in the low leaves (like
EAX=7, ECX=0).

Paolo
