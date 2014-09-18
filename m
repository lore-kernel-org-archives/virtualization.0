From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 10:13:05 -0700
Message-ID: <CAL54oT0W4H0VUX+UARphWRm+c9YNz+pOngLNMxFVSTZ05s6OZA@mail.gmail.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
	<2aa00301e9af4826b5781e01709f81e7@BY2PR0301MB0711.namprd03.prod.outlook.com>
	<541AEF7D.2010007@zytor.com>
	<CALCETrVPAEdQjFaBzk6F5wKScHDAwwyzVCC--iMSHJjrbz4EqQ@mail.gmail.com>
	<5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5b9c7dcde3824e49a25f3ee00844b868@BY2PR0301MB0711.namprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, John Starks <John.Starks@microsoft.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, Andy Lutomirski <luto@amacapital.net>, David Hepkin <davidhep@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 18, 2014 at 9:36 AM, KY Srinivasan <kys@microsoft.com> wrote:
>
> I am copying other Hyper-V engineers to this discussion.
>

Thanks, K.Y.

In terms of the address for the MSR, I suggest that you choose one
from the range between 40000000H - 400000FFH. The SDM (35.1
ARCHITECTURAL MSRS) says "All existing and
future processors will not implement any features using any MSR in
this range." Hyper-V already defines many synthetic MSRs in this
range, and I think it would be reasonable for you to pick one for this
to avoid a conflict?

-- 
Jun
Intel Open Source Technology Center
