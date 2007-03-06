From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Tue, 6 Mar 2007 08:35:11 +0100
Message-ID: <20070306073511.GA3938@elte.hu>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ECC076.9050209@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > I had just sent this out for internal review...
> =

> I think Jan's approach is better if it works (since there's no =

> compromise), but this is better if you want to get something working =

> in the near term.

yeah. (plus my patches of course that remove the current papering-over =

hackery and restores COMPAT_VDSO.)

	Ingo
