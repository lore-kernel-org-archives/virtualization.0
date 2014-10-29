From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Wed, 29 Oct 2014 15:01:13 +0100
Message-ID: <5450F329.2090105@redhat.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>	<5450C35D.1030907@citrix.com>
	<5450EF85.8090500@redhat.com> <5450F234.6040302@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5450F234.6040302@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, Jim Mattson <jmattson@vmware.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Doug Covelli <dcovelli@vmware.com>, David Hepkin <davidhep@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/29/2014 02:57 PM, David Vrabel wrote:
> Microsoft already has a specification to obtain a random number via an
> ACPI device.  The VM Generation ID.
> 
> http://www.microsoft.com/en-us/download/details.aspx?id=30707

That's a very different thing.  The VM Generation ID always returns the
same number if you run the VM from the same configuration file.

It tells the VM when it might need a reseed, but provides neither a best
effort random number like this spec does, nor an entropy source like
virtio-rng does.

Paolo
