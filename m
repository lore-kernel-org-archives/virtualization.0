From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: APIC clock setup dependent on PAE ?
Date: Wed, 10 Jan 2007 18:01:20 -0800
Message-ID: <20070111020119.GF19575@sequoia.sous-sol.org>
References: <Pine.LNX.4.64.0701100933220.8582@d.namei>
	<45A5609A.4070201@vmware.com>
	<Pine.LNX.4.64.0701101913540.14475@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701101913540.14475@d.namei>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: James Morris <jmorris@namei.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* James Morris (jmorris@namei.org) wrote:
> On Wed, 10 Jan 2007, Zachary Amsden wrote:
> =

> > Um, that is nuts.  What tree are you in?
> =

> The current hg repo, with all patches applied & the current kernel =

> version.

It's patch fuzz, I fixed it.  The context wasn't enough to fail,
and it put it under the #ifdef

thanks,
-chris
