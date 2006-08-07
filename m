From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
	space.
Date: Mon, 7 Aug 2006 04:10:22 +0200
Message-ID: <200608070410.22803.ak@suse.de>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
	<19700101001522.GA3999@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <19700101001522.GA3999@ucw.cz>
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
Cc: akpm@osdl.org, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 01 January 1970 01:15, Pavel Machek wrote:
> Hi!
> =

> > Add a bootparameter to reserve high linear address space for hypervisor=
s.
> > This is necessary to allow dynamically loaded hypervisor modules, which
> =

> Dynamically loaded hypervisor? Do we really want to support that?

I hope so. IMHO letting Linux boot first and then the Hypervisor is =

a better design than the other way round which requires a lot of duplicated=
 code.

-Andi
