From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Add an entry in MAINTAINERS for VMware's hypervisor
	interface
Date: Wed, 04 Sep 2013 04:45:34 -0700
Message-ID: <52271D5E.4060402@zytor.com>
References: <1378284821.9739.7404.camel@akataria-dtop.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1378284821.9739.7404.camel@akataria-dtop.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alok Kataria <akataria@vmware.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Doug Covelli <dcovelli@vmware.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 09/04/2013 01:53 AM, Alok Kataria wrote:
> Hey,
> 
> This change adds an entry to the maintainers file to explicitly state
> that any changes to vmware.c should be sent to the authors of the file
> as well.
> 
> If you are thinking why do this now, off late we have seen quite a few
> changes that touched the "arch/x86/kernel/cpu/vmware.c" file but were
> not directed to me, someone else made me aware of those changes. It
> could be that my use of different SOB lines "Alok N Kataria" vs "Alok
> Kataria" confuses get_maintainer.pl, but adding this entry in
> MAINTAINERS should solve the problem at hand. For one of the changes
> [1], I did verify that get_maintainer.pl, now expectedly includes me in
> the cc list.
> 
> Thanks,
> Alok 
> 

That is indeed what the maintainers file is for.

> Add an entry in MAINTAINERS file to reflect the authors of a file.

No, it reflects the *maintainer(s)* of a file.

	-hpa
