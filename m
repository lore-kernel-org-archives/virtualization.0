From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: paravirt_ops.safe_halt vs .halt?
Date: Thu, 21 Sep 2006 13:32:17 -0700
Message-ID: <4512F6D1.60902@goop.org>
References: <4512E83E.80402@goop.org>
	<20060921194415.GA2811@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060921194415.GA2811@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>   =

>> What's paravirt_ops.halt for?  Is it the non-safe equivalent to =

>> safe_halt, or is it intended for shutting down the machine?  It doesn't =

>> seem to be used anywhere.
>>     =

>
> It's called from halt().  Xen should be using it to down the cpu.
>   =


Wonder if we shouldn't give it a less ambigious name...  Or rename =

safe_halt to block() or something.

    J
