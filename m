From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: EXPORT_SYMBOL_GPL(paravirt_ops);
Date: Thu, 10 Aug 2006 13:44:15 -0700
Message-ID: <1155242655.18876.69.camel@jeremy.eng.hq.xensource.com>
References: <44DB73F5.5040009@goop.org>
	<20060810183250.GJ2654@sequoia.sous-sol.org>
	<44DB84CA.6040900@vmware.com>
	<20060810194058.GK2654@sequoia.sous-sol.org>
	<44DB95DF.8010805@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44DB95DF.8010805@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2006-08-10 at 13:23 -0700, Zachary Amsden wrote:
> But my point is that if you patch everything in the paravirt_ops struct, =

> no module other than the paravirt_ops backend code needs paravirt_ops =

> access, so paravirt_ops can still be GPL only.  The problem is you would =

> need to patch everything.

Sure, but the default code leaves the module with a static dependency on
paravirt_ops, even if it doesn't have a dynamic one.  If you patch every
single pv_op, then you could just make the static code ".fill ud2" and
have no dependency - but I don't think that's where we want to go.

	J
