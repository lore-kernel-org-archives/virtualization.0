From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 5 Apr 2007 14:54:56 -0700
Message-ID: <20070405215456.GE10574@sequoia.sous-sol.org>
References: <461447F2.9010807@zytor.com>
	<20070405011640.GL19575@sequoia.sous-sol.org>
	<46144FA6.1000802@zytor.com> <4614867C.4060506@vmware.com>
	<461539DF.6010502@zytor.com> <46156591.8080802@vmware.com>
	<46156783.9030501@zytor.com> <461569B7.7060008@vmware.com>
	<46156CC2.7080600@zytor.com> <46156D95.4070001@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46156D95.4070001@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> H. Peter Anvin wrote:
> >
> >I actually expect rdmsr/wrmsr to have a higher likelihood of weird =

> >things.  I don't know how many hypervisors can trap and handle those.
> =

> Or implement anything useful at all ... perhaps it might be useful to =

> simply wrap them with an -ENOSYS in some cases.
> =

> Rusty, Jeremy. Chris - any feedback on MSR support?

Drop 'em as far as I'm concerned.  T&E works fine, need to double check
lguest.
