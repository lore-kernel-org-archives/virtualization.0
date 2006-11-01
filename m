From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/7] paravirtualization: Add APIC accessors to
	paravirt-ops.
Date: Wed, 1 Nov 2006 15:31:02 -0800
Message-ID: <20061101153102.a192f6c9.akpm@osdl.org>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org>
	<200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
	<1162376894.23462.7.camel@localhost.localdomain>
	<1162376981.23462.10.camel@localhost.localdomain>
	<1162377043.23462.12.camel@localhost.localdomain>
	<1162377093.23462.14.camel@localhost.localdomain>
	<1162377150.23462.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1162377150.23462.16.camel@localhost.localdomain>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 01 Nov 2006 21:32:30 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> +static __inline void apic_write(unsigned long reg, unsigned long v)
> +static __inline void apic_write_atomic(unsigned long reg, unsigned long =
v)
> +static __inline unsigned long apic_read(unsigned long reg)

Just `inline', please.
