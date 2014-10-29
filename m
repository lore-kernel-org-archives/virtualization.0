From: Jake Oshins <jakeo@microsoft.com>
Subject: RE: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Wed, 29 Oct 2014 16:29:56 +0000
Message-ID: <80e17627b82a4bb7bbdc8b8c56a89626@DM2PR03MB592.namprd03.prod.outlook.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
	<21585.1101.912184.610549@mariner.uk.xensource.com>
	<CALCETrWup0JS6a8CJcHLtrqHtKfMeA9ZwRABUY2F88z0qwkOVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWup0JS6a8CJcHLtrqHtKfMeA9ZwRABUY2F88z0qwkOVw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, Ian Jackson <Ian.Jackson@eu.citrix.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Jim Mattson <jmattson@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Doug Covelli <dcovelli@vmware.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alok Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org


>I have no objection to specifying that these reads may be quite slow.
>Guests should only use them at boot and if they have some reason to
>distrust their RNG pool.

>The latter can legitimately happen after various types of suspend or
>after migration (detected by VM Generation ID, for example).

Just as a point of clarification, the VM Generation ID changes (at least in the Hyper-V implementation) only when the VM may have observed a different future, as when a VM backup is restored, a checkpoint is applied, etc.  It does not change during migration, when the VM is suspended or when it is rebooted.  I've heard anecdotes from application vendors saying that there is some other hypervisor that actually does change the ID at these moments and they wanted us to us to fix that, until I explained that I only control Hyper-V.

-- Jake Oshins
