From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Paravirt-ops VMI / Xen / lrustyvisor merge status
Date: Thu, 08 Feb 2007 23:06:20 -0800
Message-ID: <45CC1D6C.6070801@goop.org>
References: <45CC0672.7090201@vmware.com>	
	<1171000474.2718.8.camel@localhost.localdomain>	
	<45CC10B7.2060100@vmware.com>
	<1171003468.2718.10.camel@localhost.localdomain>
	<45CC1BCA.8060003@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45CC1BCA.8060003@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> I believe there was a patch that got applied that turned it off by
> default if CONFIG_PARAVIRT was enabled.  Doing it the cpuid way is the
> right solution, IMHO.

That was true for other things, but I don't think we ever did that for
sysenter (there's no config option to turn off sysenter).  Its not true
now, anyway.

    J
