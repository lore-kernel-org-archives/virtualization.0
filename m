From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
	space.
Date: Sun, 6 Aug 2006 22:00:44 +0000 (UTC)
Message-ID: <19700101001522.GA3999__18368.2579933249$1154901644$gmane$org@ucw.cz>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Thu, 1 Jan 1970 00:15:22 +0000
Content-Disposition: inline
In-Reply-To: <20060803002518.595166293@xensource.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> Add a bootparameter to reserve high linear address space for hypervisors.
> This is necessary to allow dynamically loaded hypervisor modules, which

Dynamically loaded hypervisor? Do we really want to support that?

							Pavel
-- =

Thanks for all the (sleeping) penguins.
