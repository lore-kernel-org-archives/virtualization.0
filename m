From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 08 Mar 2007 08:15:15 +0000
Message-ID: <C2157693.381A%Keir.Fraser@cl.cam.ac.uk>
References: <20070308080131.GB9295@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070308080131.GB9295@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 8/3/07 08:01, "Ingo Molnar" <mingo@elte.hu> wrote:

> you are obsessed with avoiding a hypercall, but why? Granted it's slow
> especially on things like SVN/VMX, but it's not fundamentally slow. We
> definitely do not want to design our whole APIs and abstractions around
> the temporary notion that 'hypercalls are slow'. I'd expect hypercalls
> to be put into silicon just as much as SYSENTER was put into silicon.

If syscalls are already so fast, why does Linux have vgettimeofday()?

 -- Keir
