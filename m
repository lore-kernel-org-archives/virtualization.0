From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Fri, 19 Sep 2014 09:40:07 -0700
Message-ID: <541C5C67.6040608@zytor.com>
References: <5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT0W4H0VUX+UARphWRm+c9YNz+pOngLNMxFVSTZ05s6OZA@mail.gmail.com>
	<541B13B8.1020006@redhat.com>
	<b697ef83ae594d8fb34347339dd52dfa@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<CAL54oT1nFrbffotNmLSE0+TVBSR3OChfe5Zu1yPNz0ponznVOQ@mail.gmail.com>
	<CALCETrWCKe2Pfmgu1gi6jMqdyqQ78kCpKawoLbAFgaN2USMksw@mail.gmail.com>
	<1969371640.51211843.1411066715223.JavaMail.zimbra@redhat.com>
	<CALCETrUGS_V2h_beStbVyoTC8vuKiudmJwt55Q2BJg=S2KCNKw@mail.gmail.com>
	<0180a8dfcad746a895755c4374853c16@BY2PR03MB585.namprd03.prod.outlook.com>
	<CALCETrUgcJt7p_aS0njtHmvPQ=XxNdonFHtPzFgVNpAE4U=R3Q@mail.gmail.com>
	<20140919163749.GI26540@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140919163749.GI26540@minantech.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@kernel.org>, Andy Lutomirski <luto@amacapital.net>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, David Hepkin <davidhep@microsoft.com>, kvm list <kvm@vger.kernel.org>, Niels Ferguson <niels@microsoft.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/19/2014 09:37 AM, Gleb Natapov wrote:
>
> Linux detects what hypervior it runs on very early

Not anywhere close to early enough.  We're talking for uses like kASLR.

	-hpa
