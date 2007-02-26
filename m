From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: PARAVIRT_SAVE_FLAGS_IRQ_DISABLE composite callsite
Date: Sun, 25 Feb 2007 16:51:02 -0800
Message-ID: <45E22EF6.901@goop.org>
References: <45E159A7.7060709@goop.org>
	<1172441227.13541.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1172441227.13541.24.camel@localhost.localdomain>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Yes, the combo was *so* common we went for one patch site rather than
> two.
>   =


Is there any disadvantage to having two adjacent patch sites?  For
native the same instruction sequence will be generated, but with a few
more nops.

    J
