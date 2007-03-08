From: Andi Kleen <ak@suse.de>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 22:45:39 +0100
Message-ID: <200703082245.39587.ak@suse.de>
References: <1173308717.24738.898.camel@localhost.localdomain>
	<20070308202350.GL10574@sequoia.sous-sol.org>
	<45F07334.7010207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F07334.7010207@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> =

> Maybe hooking into genapic is the right way to mop up all the uses of
> send_IPI and its variants. =


It is.  More hooks in this are wouldn't be appreciated.

-Andi
