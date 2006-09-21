From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: paravirt_ops.safe_halt vs .halt?
Date: Thu, 21 Sep 2006 12:44:15 -0700
Message-ID: <20060921194415.GA2811@sequoia.sous-sol.org>
References: <4512E83E.80402@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <4512E83E.80402@goop.org>
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

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> What's paravirt_ops.halt for?  Is it the non-safe equivalent to =

> safe_halt, or is it intended for shutting down the machine?  It doesn't =

> seem to be used anywhere.

It's called from halt().  Xen should be using it to down the cpu.

thanks,
-chris
