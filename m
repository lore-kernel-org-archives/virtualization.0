From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PARAVIRT_SAVE_FLAGS_IRQ_DISABLE composite callsite
Date: Mon, 26 Feb 2007 09:07:07 +1100
Message-ID: <1172441227.13541.24.camel@localhost.localdomain>
References: <45E159A7.7060709@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45E159A7.7060709@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-02-25 at 01:40 -0800, Jeremy Fitzhardinge wrote:
> What was the point of this again?  Was it that these two operations are
> used so commonly together that its worth having a special type for them,
> or is there some correctness issue here?
> =

> It seems to me that having it adds a fair amount of fiddley complexity,
> and it doesn't gain very much because patching will make each operation
> individually fairly efficient.

Yes, the combo was *so* common we went for one patch site rather than
two.

Rusty.
