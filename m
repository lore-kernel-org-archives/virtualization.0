From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
	paravirtualizing critical operations
Date: Wed, 01 Nov 2006 11:45:25 +0100
Message-ID: <1162377928.23744.4.camel@laptopd505.fenrus.org>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1162376827.23462.5.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, akpm@osdl.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-11-01 at 21:27 +1100, Rusty Russell wrote:
> Create a paravirt.h header for all the critical operations which need
> to be replaced with hypervisor calls, and include that instead of
> defining native operations, when CONFIG_PARAVIRT.
> =

> This patch does the dumbest possible replacement of paravirtualized
> instructions: calls through a "paravirt_ops" structure.  Currently
> these are function implementations of native hardware: hypervisors
> will override the ops structure with their own variants.
> =

> All the pv-ops functions are declared "fastcall" so that a specific
> register-based ABI is used, to make inlining assember easier.


this is a lot of infrastructure... do we have more than 1 user of this
yet that wants to get merged in mainline?


-- =

if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwa=
rekit.org
