From: Andi Kleen <ak@suse.de>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Tue, 6 Mar 2007 23:21:58 +0100
Message-ID: <20070306222157.GJ22829@bingen.suse.de>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>
	<20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>
	<1173178774.24738.311.camel@localhost.localdomain>
	<45EDD82F.90204@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EDD82F.90204@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Dan Hecht <dhecht@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

> I believe this was just a quick fix in response to Ingo breaking the VMI =

> build yesterday by disabling NO_IDLE_HZ on us.  There is no technical =

> reason why NO_IDLE_HZ=3Dy can't coexist with NO_HZ.

Well it's nasty that you force NO_IDLE_HZ on all of paravirt ops users.
I think the right solution is to make VMI depend on (not select) NO_IDLE_HZ
until you can fix your code to work with dynticks properly.

-Andi
