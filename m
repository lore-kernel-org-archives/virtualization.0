From: Keir Fraser <keir@xensource.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and
	disableunsupported config options.
Date: Fri, 16 Feb 2007 11:03:06 +0000
Message-ID: <C1FB3FEA.98F7%keir__9819.23458534784$1171623939$gmane$org@xensource.com>
References: <20070216025452.d25e3545.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216025452.d25e3545.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Steven Hand <steven.hand@cl.cam.ac.uk>, Ian Pratt <Ian.Pratt@xensource.com>, Christian Limpach <Christian.Limpach@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 10:54, "Andrew Morton" <akpm@linux-foundation.org> wrote:

> OK, you're screwed.  I agree that the process freezer is the way out of t=
hat
> one.
> =

> Ingo said that he's clocked the freezer at a few milliseconds.  But if it=
's
> any higher than that it'll need to get sped up once we convert cpu hotplug
> to use it.

A few milliseconds is acceptable. Presumably that is under some stress
workload? What we'd really like is to be able to gang-hotplug CPUs to
amortise the freezer overhead.

This initial patchset does not include save/restore support anyway, so in
fact it would be consistent to have CONFIG_PREEMPT configurable. I'm sure
that we are going to have some nasty bugs to fix up as a result, but we
can't fix them until we find them! Then we can convert our save/restore code
to use the freezer before submitting it for inclusion.

 -- Keir
